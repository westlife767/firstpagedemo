//
//  firstPageViewController.m
//  firstPageDemo
//
//  Created by 王佳伟 on 16/4/10.
//  Copyright © 2016年 王佳伟. All rights reserved.
//

#import "firstPageViewController.h"
#import <AFNetworking.h>
//#import "ScollFirstViewController.h"
//#import "secondPageViewController.h"
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
CGFloat KImageCount = 4;
CGFloat ImageCount = 3;
CGFloat changeImageCount = 23;
@interface firstPageViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollview;
@property(nonatomic,strong)UIPageControl *pageControl;
//@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIButton *bt1;
@property(nonatomic,strong)UIButton *bt2;
//view数组
@property(nonatomic,strong)NSMutableArray *arry;
//图片数组
@property(nonatomic,strong)NSMutableArray *imageArry;
//判断当前是哪个图片
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSTimer *timer;
@property (copy) NSDate *fireDate;
@end

@implementation firstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化滚动页面
    [self initWithScollerView];
    //初始化页面控制器
    [self initPageControl];
    //初始化按钮
    [self initButton];
    //初始化pagecontroll约束
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *nameMap = @{@"pageControl":self.pageControl};
    NSArray *hscoll = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-135-[pageControl(==60)]-135-|" options:0 metrics:nil views:nameMap];
    NSArray *vscoll = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-471-[pageControl(==20)]-77-|" options:0 metrics:nil views:nameMap];
    //初始化登入和注册按钮的约束
    self.bt1.translatesAutoresizingMaskIntoConstraints = NO;
    self.bt2.translatesAutoresizingMaskIntoConstraints  = NO;
    NSDictionary *nameWithButton = @{@"bt1":self.bt1,@"bt2":self.bt2};
    NSArray *bt1 = [NSLayoutConstraint constraintsWithVisualFormat:<#(nonnull NSString *)#> options:<#(NSLayoutFormatOptions)#> metrics:<#(nullable NSDictionary<NSString *,id> *)#> views:<#(nonnull NSDictionary<NSString *,id> *)#>]
    [self.view addConstraints:hscoll];
    [self.view addConstraints:vscoll];
  
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configureTimer];
    if (!_imageArry) {
         self.imageArry = [[NSMutableArray alloc] init];
        for (int i=0; i<73; i++) {
             UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"c%d",i]];
        
            [self.imageArry addObject:image];
        }
    }
}

- (void)configureTimer{

    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(changeSecondPage) userInfo:nil repeats:YES];


}
- (void)initWithScollerView{
    
    self.count=0;
    self.page=0;
    //初始化滑动视图的
       self.scrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight)];
    //添加可以滑动的区域
      [self.scrollview setContentSize:CGSizeMake(KImageCount*KScreenWidth, KScreenHeight)];
       self.arry = [NSMutableArray array];
       self.scrollview.delegate=self;
       for (int first=0; first<KImageCount; first++) {
       UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth*first, 0, KScreenWidth, KScreenHeight)];
       imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"img%d",first]];
        [self.arry addObject:imageView];
         [self.scrollview addSubview:imageView];
       }
    
    //设置滑动大小
    self.scrollview.contentSize = CGSizeMake(KScreenWidth*KImageCount, KScreenHeight);
    self.scrollview.pagingEnabled=YES;
    //静止反弹
    self.scrollview.bounces = NO;
    //静止水平方向的滑动条
    self.scrollview.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.scrollview];
    
}

- (void)initPageControl{
    self.pageControl=[[UIPageControl alloc] init];
    self.pageControl.numberOfPages=KImageCount;
    self.pageControl.pageIndicatorTintColor=[UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
    [self.view insertSubview:self.pageControl aboveSubview:self.scrollview];


}
- (void)changePage:(NSInteger) count
{
    //_timer.fireDate  = [NSDate distantPast];
    switch (count){
        case 0:
            [self.arry[1] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"img1.png"]]];
            [self.arry[2] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"img2.png"]]];
            [self.arry[3] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"img3.png"]]];
        case 1:
            
            [self.arry[2] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"img2.png"]]];
            [self.arry[3] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"img3.png"]]];
            break;
        case 2:
            [self.arry[1] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"img1.png"]]];
            [self.arry[3] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"img3.png"]]];
            break;
        case 3:
            [self.arry[1] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"img1.png"]]];
            [self.arry[2] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"img2.png"]]];
            break;
        default:
            
            break;
    }


}
- (void)changeSecondPage{
    
    

    switch (_page){
        case 0:
            [self.arry[0] setImage:_imageArry[_count]];
            break;
        case 1:
          
            if (_count>=24) {
               _timer.fireDate  = [NSDate distantFuture];
                break;
            }else{
               [self.arry[1] setImage:_imageArry[_count]];
                _count++;
            }
            
        case 2:
           
            if (_count>=48) {
                _timer.fireDate  = [NSDate distantFuture];
                break;
            }else{
                [self.arry[2] setImage:_imageArry[_count]];
                 _count++;
           }
            //break;
        case 3:
            if (_count>=72) {
                _timer.fireDate  = [NSDate distantFuture];
                break;
            }else{
                [self.arry[3] setImage:_imageArry[_count]];
                _count++;
            }
            break;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    
    self.page =scrollView.contentOffset.x/KScreenWidth+0.5;
   
    self.pageControl.currentPage=_page;
    
    if (_page==0) {
        [self changePage:_page];
        self.count=0;
    }
    if (_page==1) {
        [self changePage:_page];
        self.count = 1;
        _timer.fireDate  = [NSDate distantPast];
        //NSLog(@"page1");
    }else if (_page==2) {
        [self changePage:_page];
        self.count=25;
        _timer.fireDate  = [NSDate distantPast];
    }else if (_page==3) {
        [self changePage:_page];
        self.count=49;
        _timer.fireDate  = [NSDate distantPast];
    }
}

- (void)initButton{
    self.bt1 = [[UIButton alloc] init];
    self.bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bt1 setTitle:@"登入" forState:UIControlStateNormal];
    [self.bt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bt1 setBackgroundColor:[UIColor clearColor]];
    self.bt2 = [[UIButton alloc] init];
    [self.bt2 setTitle:@"注册" forState:UIControlStateNormal];
    [self.bt1 setBackgroundColor:[UIColor greenColor]];
    [self.bt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}
-(BOOL)prefersStatusBarHidden{
    
    return YES;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
