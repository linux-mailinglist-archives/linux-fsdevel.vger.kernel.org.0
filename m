Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F29E7A2E48
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 08:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbjIPG4R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Sep 2023 02:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjIPGz6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Sep 2023 02:55:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11863B8;
        Fri, 15 Sep 2023 23:55:52 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rnhbv5Ry6zrS6x;
        Sat, 16 Sep 2023 14:53:47 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 16 Sep 2023 14:55:48 +0800
Message-ID: <89d049ed-6bbf-bba7-80d4-06c060e65e5b@huawei.com>
Date:   Sat, 16 Sep 2023 14:55:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [czhong@redhat.com: [bug report] WARNING: CPU: 121 PID: 93233 at
 fs/dcache.c:365 __dentry_kill+0x214/0x278]
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        <mark.rutland@arm.com>
CC:     Christian Brauner <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        Changhui Zhong <czhong@redhat.com>,
        yangerkun <yangerkun@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        Baokun Li <libaokun1@huawei.com>, <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        chengzhihao <chengzhihao1@huawei.com>
References: <ZOWFtqA2om0w5Vmz@fedora>
 <20230823-kuppe-lassen-bc81a20dd831@brauner>
 <CAFj5m9KiBDzNHCsTjwUevZh3E3RRda2ypj9+QcRrqEsJnf9rXQ@mail.gmail.com>
 <CAHj4cs_MqqWYy+pKrNrLqTb=eoSOXcZdjPXy44x-aA1WvdVv0w@mail.gmail.com>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <CAHj4cs_MqqWYy+pKrNrLqTb=eoSOXcZdjPXy44x-aA1WvdVv0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/9/13 16:59, Yi Zhang wrote:
> The issue still can be reproduced on the latest linux tree[2].
> To reproduce I need to run about 1000 times blktests block/001, and
> bisect shows it was introduced with commit[1], as it was not 100%
> reproduced, not sure if it's the culprit?
>
>
> [1] 9257959a6e5b locking/atomic: scripts: restructure fallback ifdeffery
Hello, everyone！

We have confirmed that the merge-in of this patch caused hlist_bl_lock
(aka, bit_spin_lock) to fail, which in turn triggered the issue above.


The process in which VFS issue arise is as follows:
1.  bl_head >>> first==dentry2 >>> dentry1
dentry2->next = dentry1
dentry2->pprev = head
dentry1->next = NULL
dentry1->pprev = dentry2

2. Concurrent deletion of dentry, hlist_bl_lock lock protection failure
```
__hlist_bl_del(dentry2)
                                __hlist_bl_del(dentry1)
                                dentry2->next = NULL;
                                dentry1->next = NULL;
                                dentry1->pprev = NULL;
head->first = dentry1
dentry1->pprev = head
dentry2->next = NULL;
dentry2->pprev = NULL;
```
3. WARN_ON/BUG_ON is triggered because dentry1 is still on the
  hlist after being deleted.

dentry1->next = NULL
dentry1->pprev = head


Verify that hlist_bl_lock is not working with the following mod：
mymod.c
```
#include <linux/kallsyms.h>
#include <linux/module.h>
#include <linux/moduleloader.h>
#include <linux/kernel.h>
#include <linux/jiffies.h>
#include <linux/sched.h>
#include <linux/smp.h>
#include <linux/cpu.h>
#include <linux/delay.h>
#include <linux/percpu.h>
#include <linux/threads.h>
#include <linux/kthread.h>
#include <linux/kernel_stat.h>
#include <linux/version.h>
#include <linux/slab.h>
#include <linux/smpboot.h>
#include <linux/pagemap.h>
#include <linux/notifier.h>
#include <linux/syscalls.h>
#include <linux/namei.h>

#include <asm/atomic.h>
#include <asm/bitops.h>

static unsigned long long a = 0, b = 0;
static struct hlist_bl_head bl_head;

struct task_struct *Thread1;
struct task_struct *Thread2;
struct task_struct *Thread3;
struct task_struct *Thread4;
struct task_struct *Thread5;
struct task_struct *Thread6;
int increase_ab(void *arg);

int increase_ab(void *arg)
{
     while (1) {
         hlist_bl_lock(&bl_head);
         if (a != b) {
             pr_err(">>> a = %llu, b = %llu \n", a, b);
             BUG();
             return -1;
         }
         if (a > (ULLONG_MAX - 4096)) {
             a = 0;
             b = 0;
         }
         a++;
         b++;
         hlist_bl_unlock(&bl_head);
         schedule();
     }
     return 0;
}

static int mymod_init(void)
{
     INIT_HLIST_BL_HEAD(&bl_head);

     Thread1 = kthread_create(increase_ab, NULL, "bl_lock_thread1");
     wake_up_process(Thread1);

     Thread2 = kthread_create(increase_ab, NULL, "bl_lock_thread2");
     wake_up_process(Thread2);

     Thread3 = kthread_create(increase_ab, NULL, "bl_lock_thread3");
     wake_up_process(Thread3);

     Thread4 = kthread_create(increase_ab, NULL, "bl_lock_thread4");
     wake_up_process(Thread4);

     Thread5 = kthread_create(increase_ab, NULL, "bl_lock_thread5");
     wake_up_process(Thread5);

     Thread6 = kthread_create(increase_ab, NULL, "bl_lock_thread6");
     wake_up_process(Thread6);

         return 0;
}

static void mymod_exit(void)
{
     if (Thread1)
         kthread_stop(Thread1);
         if (Thread2)
                 kthread_stop(Thread2);
         if (Thread3)
                 kthread_stop(Thread3);
         if (Thread4)
                 kthread_stop(Thread4);
         if (Thread5)
                 kthread_stop(Thread5);
         if (Thread6)
                 kthread_stop(Thread6);
}

module_init(mymod_init);
module_exit(mymod_exit);

MODULE_LICENSE("Dual BSD/GPL");

```


After 9257959a6e5b ("locking/atomic: scripts: restructure fallback 
ifdeffery") is
merged in, we can see the problem when inserting the ko:
```
[root@localhost ~]# insmod mymod.ko
[   37.994787][  T621] >>> a = 725, b = 724
[   37.995313][  T621] ------------[ cut here ]------------
[   37.995951][  T621] kernel BUG at fs/mymod/mymod.c:42!
[r[  oo 3t7@.l996o4c61al]h[o s T6t21] ~ ]#Int ernal error: Oops - BUG: 
00000000f2000800 [#1] SMP
[   37.997420][  T621] Modules linked in: mymod(E)
[   37.997891][  T621] CPU: 9 PID: 621 Comm: bl_lock_thread2 Tainted: 
G            E      6.4.0-rc2-00034-g9257959a6e5b-dirty #117
[   37.999038][  T621] Hardware name: linux,dummy-virt (DT)
[   37.999571][  T621] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT 
-SSBS BTYPE=--)
[   38.000344][  T621] pc : increase_ab+0xcc/0xe70 [mymod]
[   38.000882][  T621] lr : increase_ab+0xcc/0xe70 [mymod]
[   38.001416][  T621] sp : ffff800008b4be40
[   38.001822][  T621] x29: ffff800008b4be40 x28: 0000000000000000 x27: 
0000000000000000
[   38.002605][  T621] x26: 0000000000000000 x25: 0000000000000000 x24: 
0000000000000000
[   38.003385][  T621] x23: ffffd9930c698190 x22: ffff800008a0ba38 x21: 
0000000000000001
[   38.004174][  T621] x20: ffffffffffffefff x19: ffffd9930c69a580 x18: 
0000000000000000
[   38.004955][  T621] x17: 0000000000000000 x16: ffffd9933011bd38 x15: 
ffffffffffffffff
[   38.005754][  T621] x14: 0000000000000000 x13: 205d313236542020 x12: 
ffffd99332175b80
[   38.006538][  T621] x11: 0000000000000003 x10: 0000000000000001 x9 : 
ffffd9933022a9d8
[   38.007325][  T621] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 : 
ffffd993320b5b40
[   38.008124][  T621] x5 : ffff0001f7d1c708 x4 : 0000000000000000 x3 : 
0000000000000000
[   38.008912][  T621] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 
0000000000000015
[   38.009709][  T621] Call trace:
[   38.010035][  T621]  increase_ab+0xcc/0xe70 [mymod]
[   38.010539][  T621]  kthread+0xdc/0xf0
[   38.010927][  T621]  ret_from_fork+0x10/0x20
[   38.011370][  T621] Code: 17ffffe0 90000020 91044000 9400000d (d4210000)
[   38.012067][  T621] ---[ end trace 0000000000000000 ]---
[   38.012603][  T621] Kernel panic - not syncing: Oops - BUG: Fatal 
exception
[   38.013311][  T621] SMP: stopping secondary CPUs
[   38.013818][  T621] Kernel Offset: 0x599328000000 from 0xffff800008000000
[   38.014508][  T621] PHYS_OFFSET: 0x40000000
[   38.014933][  T621] CPU features: 0x000000,0220080c,44016203
[   38.015510][  T621] Memory Limit: none
[   38.015950][  T621] ---[ end Kernel panic - not syncing: Oops - BUG: 
Fatal exception ]---
```
























