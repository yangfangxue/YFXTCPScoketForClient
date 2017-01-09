//
//  ViewController.m
//  YFX_ScoketForClientDemo
//
//  Created by fangxue on 2017/1/9.
//  Copyright © 2017年 fangxue. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"

@interface ViewController ()<GCDAsyncSocketDelegate>

//客户端socket
@property (nonatomic, strong) GCDAsyncSocket *clientSocket;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //1.创建客户端scoket
    self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    //2.链接服务器socket
    BOOL result = [self.clientSocket connectToHost:@"172.20.10.1" onPort:[@"8000" integerValue] error:nil];
    //判断链接
    if (result) {
        //成功
        NSLog(@"链接成功");
    }else{
        //失败
        NSLog(@"链接失败");
    }
    
}
#pragma mark ------------
//客户端链接服务器成功
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    
    NSLog(@"%@",[NSString stringWithFormat:@"链接成功服务器：%@",host]);
    
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    
    NSLog(@"消息发送成功");
}
//成功读取服务端发过来的消息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    NSLog(@"%lu",(unsigned long)[data length]);
    
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
