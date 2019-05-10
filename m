Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D762919F6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 16:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfEJOi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 10:38:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7742 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727262AbfEJOi1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 10:38:27 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 07403C816D11DC8FB93E
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2019 22:38:25 +0800 (CST)
Received: from [127.0.0.1] (10.177.33.43) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 May 2019
 22:38:16 +0800
To:     <jack@suse.cz>, <amir73il@gmail.com>
CC:     <linux-fsdevel@vger.kernel.org>, <yangerkun@huawei.com>,
        <yi.zhang@huawei.com>, <houtao1@huawei.com>,
        <huawei.libin@huawei.com>, <miaoxie@huawei.com>,
        <suoben@huawei.com>
From:   yangerkun <yangerkun@huawei.com>
Subject: [Question] softlockup in __fsnotify_update_child_dentry_flags
Message-ID: <0ce0173a-78f0-ae69-05b2-8374fbe3ba37@huawei.com>
Date:   Fri, 10 May 2019 22:37:56 +0800
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

Run process parallel which each code show as below(ARM64 + 2T ram):

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

Sometimes later, system will report softlockup with stack:

#10 [ffff00002ffc39f0] el1_irq at ffff000008083474
      PC: ffff00000814570c  [queued_spin_lock_slowpath+420]
      LR: ffff000008146ca4  [do_raw_spin_lock+260]
      SP: ffff00002ffc3a00  PSTATE: 80000005
     X29: ffff00002ffc3a00  X28: ffff802fa1f62f40  X27: 0000000000000002
     X26: ffff00002ffc3bac  X25: ffff801fac95bd60  X24: ffff00002ffc3bb0
     X23: ffff801fa8a9ce80  X22: ffff00002ffc3bb8  X21: 0000000000000002
     X20: 0000000000d80000  X19: ffff801fa8a9ced8  X18: 0000000000000000
     X17: 0000000000d80000  X16: 0000000000d80000  X15: 0000000000000000
     X14: 0000000000000000  X13: 0000000000000000  X12: 0000000000000000
     X11: 0000000000000000  X10: ffff801fa614c200   X9: ffff801ffbe68e00
      X8: 0000000000000000   X7: ffff809ffbfd4e00   X6: 0000000000040000
      X5: ffff00000976b788   X4: ffff801ffbe68e00   X3: ffff0000093c7000
      X2: 0000000000000000   X1: 0000000000000000   X0: ffff801ffbe68e08
#11 [ffff00002ffc3a00] queued_spin_lock_slowpath at ffff000008145708
#12 [ffff00002ffc3a20] do_raw_spin_lock at ffff000008146ca0
#13 [ffff00002ffc3a40] _raw_spin_lock at ffff000008d0da6c
#14 [ffff00002ffc3a60] lockref_get_not_dead at ffff0000085abca8
#15 [ffff00002ffc3a80] legitimize_path at ffff00000832aee0
#16 [ffff00002ffc3ab0] unlazy_walk at ffff00000832b09c
#17 [ffff00002ffc3ad0] lookup_fast at ffff00000832ba2c
#18 [ffff00002ffc3b40] walk_component at ffff00000832bc30
#19 [ffff00002ffc3bd0] path_lookupat at ffff00000832c5d8
#20 [ffff00002ffc3c40] filename_lookup at ffff00000832e464
#21 [ffff00002ffc3d70] user_path_at_empty at ffff00000832e67c
#22 [ffff00002ffc3db0] do_faccessat at ffff000008317750
#23 [ffff00002ffc3e40] __arm64_sys_faccessat at ffff00000831795c
#24 [ffff00002ffc3e60] el0_svc_common at ffff000008097514
#25 [ffff00002ffc3ea0] el0_svc_handler at ffff00000809762c
#26 [ffff00002ffc3ff0] el0_svc at ffff000008084144


We find the lock of lockref has been catched with cpu 40. And since 
there is too much negative dentry in root dentry's d_subdirs, traversing 
will spend so long time with holding d_lock of root dentry. So other 
thread waiting for the lockref.lock will softlockup.

For this problem, thought?

crash> bt -c 40
PID: 1      TASK: ffff801faf851f80  CPU: 40  COMMAND: "systemd"
  #0 [ffff000009c9bda0] crash_save_cpu at ffff0000081a280c
  #1 [ffff000009c9bf60] handle_IPI at ffff000008096850
  #2 [ffff000009c9bfd0] gic_handle_irq at ffff0000080818d0
--- <IRQ stack> ---
  #3 [ffff000009d5bcb0] el1_irq at ffff000008083474
      PC: ffff00000836c7a8  [__fsnotify_update_child_dentry_flags+160]
      LR: ffff00000836c770  [__fsnotify_update_child_dentry_flags+104]
      SP: ffff000009d5bcc0  PSTATE: 20000005
     X29: ffff000009d5bcc0  X28: ffff809fb33f4150  X27: ffff801f9e33e5e0
     X26: ffff000009b28f68  X25: ffff801f9e33e668  X24: ffff801fa8a9ced8
     X23: 0000000000000184  X22: ffff801fa8a9ce80  X21: ffff801fa8a9cf38
     X20: ffff801ec2499360  X19: ffff801ec24a3a48  X18: 0000000000000000
     X17: 0000000000240001  X16: 0000000000240001  X15: 0000000000000000
     X14: 0000000000000000  X13: 0000000000000000  X12: 0000000000000000
     X11: ffff809fb14276c8  X10: 0000000000000001   X9: ffff809ffbf38e00
      X8: 0000000000000000   X7: ffff802ffbeb7e00   X6: 0000000000a40000
      X5: 0000000000440000   X4: ffff809ffbf38e00   X3: ffff0000093c7000
      X2: 0000809ff2b71000   X1: 0000000000000000   X0: ffff801ec24a3af0
  #4 [ffff000009d5bcc0] __fsnotify_update_child_dentry_flags at 
ffff00000836c7a4
  #5 [ffff000009d5bd10] __fsnotify_update_child_dentry_flags at 
ffff00000836cb74
  #6 [ffff000009d5bd30] fsnotify_recalc_mask at ffff00000836d910
  #7 [ffff000009d5bd50] fsnotify_add_mark_locked at ffff00000836e0e4
  #8 [ffff000009d5bdd0] __arm64_sys_inotify_add_watch at ffff0000083704c8
  #9 [ffff000009d5be60] el0_svc_common at ffff000008097514
#10 [ffff000009d5bea0] el0_svc_handler at ffff00000809762c
#11 [ffff000009d5bff0] el0_svc at ffff000008084144







