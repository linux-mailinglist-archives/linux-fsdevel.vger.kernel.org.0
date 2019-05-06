Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1517D143C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 05:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfEFDga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 May 2019 23:36:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbfEFDga (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 May 2019 23:36:30 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9EF054C1408C98A0F850;
        Mon,  6 May 2019 11:36:28 +0800 (CST)
Received: from [127.0.0.1] (10.177.33.43) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 6 May 2019
 11:36:21 +0800
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <houtao1@huawei.com>, <miaoxie@huawei.com>
From:   yangerkun <yangerkun@huawei.com>
Subject: system panic while dentry reference count overflow
Message-ID: <af9a8dec-98a2-896f-448b-04ded0af95f0@huawei.com>
Date:   Mon, 6 May 2019 11:36:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.33.43]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Run process parallel which each code show as below(2T memory), reference 
count of root dentry will overflow since allocation of negative dentry 
should do count++ for root dentry. Then, another dput of root dentry 
will free it, which cause crash of system. I wondered is there anyone 
has found this problem?

#include<stdlib.h> 

#include<stdio.h> 

#include<string.h> 

#include<time.h> 

 

int main() 

{ 

     const char *forname="_dOeSnotExist_.db"; 

     int i; 

     char filename[100]=""; 

     struct timespec time1 = {0, 0}; 

     for(;;) 

     { 

         clock_gettime(CLOCK_REALTIME, &time1); 

         for(i=0; i < 10000; i++) { 

 
sprintf(filename,"/%d%d%d%s",time1.tv_sec,time1.tv_nsec,i,forname); 

             access(filename,0); 

             memset(filename,'\0',100); 

         } 

     } 

     return 0; 

 

} 

~ 

Thanks,
Kun.

