Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11399917BC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 18:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfHRQSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 12:18:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:49252 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHRQSH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:18:07 -0400
Received: by mail-io1-f69.google.com with SMTP id k13so1391765ioh.16
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Aug 2019 09:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Hmr6LbNPAogYz9M9AWErVSdLPJP6C8NA+lUBffMdXcY=;
        b=RDmJbR1ZAzBzU5K4TfxNFoWBZauWUF44rMH+RC0HCOgXtG2ZF0b+q62E8p4VQJXadp
         ftxDHC7Lp/tetoOJhruUcBcbAuxY5Hbp6PpDg5PN+uPGP7u3yMs0t5lS2Uq+duwO5H6r
         Y+9sIjuXpb4eYAaYh0Qo/kacu1/xnfu5e49iPXUv4wQbHLNJaNjbpMvBQ1CHYLzWERV8
         iadqd+uo0HL8Y8NeVHV3CSH1xmkmX/TDtLIS/cpJ3hqu5XTw8JG6JnFFyQ5tw/BFMrfl
         9E0wjaoXd/gCDsU7hNO0N0o/V/YTOFv+EObr6SIk+d1bMDuIHOKmv10oI0Fc4uf+dE15
         yLEQ==
X-Gm-Message-State: APjAAAWG1UtgUdOwYEGZfm+ciBXVM8B5W9+uuGiw9xaZySMtPw06N9Qt
        0dfAOmkgr5l/is89li1g8dwMEJRBTLWg2tDrF+jnGlr9wTci
X-Google-Smtp-Source: APXvYqzVT6FgCvnwRaYKUVgC+5aUifUjqZ25O99mI97owt1IBKwoVnOwIw1emBhWm7YIg81BCuGOiNNOhD++dgM6N8t6V+yLEIP9
MIME-Version: 1.0
X-Received: by 2002:a6b:7009:: with SMTP id l9mr1217269ioc.160.1566145086587;
 Sun, 18 Aug 2019 09:18:06 -0700 (PDT)
Date:   Sun, 18 Aug 2019 09:18:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d8eac05906691ac@google.com>
Subject: possible deadlock in io_submit_one (2)
From:   syzbot <syzbot+af05535bb79520f95431@syzkaller.appspotmail.com>
To:     bcrl@kvack.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    17da61ae Add linux-next specific files for 20190814
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=127712e2600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4733704ca85aaa66
dashboard link: https://syzkaller.appspot.com/bug?extid=af05535bb79520f95431
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+af05535bb79520f95431@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
5.3.0-rc4-next-20190814 #66 Not tainted
-----------------------------------------------------
syz-executor.1/25024 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff8880a374bbe8 (&fiq->waitq){+.+.}, at: spin_lock  
include/linux/spinlock.h:338 [inline]
ffff8880a374bbe8 (&fiq->waitq){+.+.}, at: aio_poll fs/aio.c:1748 [inline]
ffff8880a374bbe8 (&fiq->waitq){+.+.}, at: __io_submit_one fs/aio.c:1822  
[inline]
ffff8880a374bbe8 (&fiq->waitq){+.+.}, at: io_submit_one+0xefa/0x2ef0  
fs/aio.c:1859

and this task is already holding:
ffff88806001fc58 (&(&ctx->ctx_lock)->rlock){..-.}, at: spin_lock_irq  
include/linux/spinlock.h:363 [inline]
ffff88806001fc58 (&(&ctx->ctx_lock)->rlock){..-.}, at: aio_poll  
fs/aio.c:1746 [inline]
ffff88806001fc58 (&(&ctx->ctx_lock)->rlock){..-.}, at: __io_submit_one  
fs/aio.c:1822 [inline]
ffff88806001fc58 (&(&ctx->ctx_lock)->rlock){..-.}, at:  
io_submit_one+0xeb5/0x2ef0 fs/aio.c:1859
which would create a new lock dependency:
  (&(&ctx->ctx_lock)->rlock){..-.} -> (&fiq->waitq){+.+.}

but this new dependency connects a SOFTIRQ-irq-safe lock:
  (&(&ctx->ctx_lock)->rlock){..-.}

... which became SOFTIRQ-irq-safe at:
   lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
   _raw_spin_lock_irq+0x60/0x80 kernel/locking/spinlock.c:167
   spin_lock_irq include/linux/spinlock.h:363 [inline]
   free_ioctx_users+0x2d/0x490 fs/aio.c:618
   percpu_ref_put_many include/linux/percpu-refcount.h:293 [inline]
   percpu_ref_put include/linux/percpu-refcount.h:309 [inline]
   percpu_ref_call_confirm_rcu lib/percpu-refcount.c:130 [inline]
   percpu_ref_switch_to_atomic_rcu+0x4c0/0x570 lib/percpu-refcount.c:165
   __rcu_reclaim kernel/rcu/rcu.h:222 [inline]
   rcu_do_batch kernel/rcu/tree.c:2157 [inline]
   rcu_core+0x581/0x1560 kernel/rcu/tree.c:2377
   rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2386
   __do_softirq+0x262/0x98c kernel/softirq.c:292
   invoke_softirq kernel/softirq.c:373 [inline]
   irq_exit+0x19b/0x1e0 kernel/softirq.c:413
   exiting_irq arch/x86/include/asm/apic.h:536 [inline]
   smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1095
   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
   constant_test_bit arch/x86/include/asm/bitops.h:207 [inline]
   test_bit include/asm-generic/bitops-instrumented.h:238 [inline]
   test_ti_thread_flag include/linux/thread_info.h:84 [inline]
   need_resched include/linux/sched.h:1827 [inline]
   mutex_spin_on_owner+0x7b/0x330 kernel/locking/mutex.c:568
   mutex_optimistic_spin kernel/locking/mutex.c:673 [inline]
   __mutex_lock_common kernel/locking/mutex.c:959 [inline]
   __mutex_lock+0x330/0x13c0 kernel/locking/mutex.c:1103
   mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
   rtnl_lock+0x17/0x20 net/core/rtnetlink.c:72
   addrconf_dad_work+0xad/0x1150 net/ipv6/addrconf.c:4032
   process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
   worker_thread+0x98/0xe40 kernel/workqueue.c:2415
   kthread+0x361/0x430 kernel/kthread.c:255
   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

to a SOFTIRQ-irq-unsafe lock:
  (&fiq->waitq){+.+.}

... which became SOFTIRQ-irq-unsafe at:
...
   lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:338 [inline]
   flush_bg_queue+0x1f3/0x3c0 fs/fuse/dev.c:415
   fuse_request_queue_background+0x2f8/0x5a0 fs/fuse/dev.c:676
   fuse_request_send_background+0x58/0x110 fs/fuse/dev.c:687
   cuse_send_init fs/fuse/cuse.c:459 [inline]
   cuse_channel_open+0x5ba/0x830 fs/fuse/cuse.c:519
   misc_open+0x395/0x4c0 drivers/char/misc.c:141
   chrdev_open+0x245/0x6b0 fs/char_dev.c:414
   do_dentry_open+0x4df/0x1250 fs/open.c:797
   vfs_open+0xa0/0xd0 fs/open.c:914
   do_last fs/namei.c:3416 [inline]
   path_openat+0x10e9/0x4630 fs/namei.c:3533
   do_filp_open+0x1a1/0x280 fs/namei.c:3563
   do_sys_open+0x3fe/0x5d0 fs/open.c:1097
   __do_sys_openat fs/open.c:1124 [inline]
   __se_sys_openat fs/open.c:1118 [inline]
   __x64_sys_openat+0x9d/0x100 fs/open.c:1118
   do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

  Possible interrupt unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&fiq->waitq);
                                local_irq_disable();
                                lock(&(&ctx->ctx_lock)->rlock);
                                lock(&fiq->waitq);
   <Interrupt>
     lock(&(&ctx->ctx_lock)->rlock);

  *** DEADLOCK ***

1 lock held by syz-executor.1/25024:
  #0: ffff88806001fc58 (&(&ctx->ctx_lock)->rlock){..-.}, at: spin_lock_irq  
include/linux/spinlock.h:363 [inline]
  #0: ffff88806001fc58 (&(&ctx->ctx_lock)->rlock){..-.}, at: aio_poll  
fs/aio.c:1746 [inline]
  #0: ffff88806001fc58 (&(&ctx->ctx_lock)->rlock){..-.}, at: __io_submit_one  
fs/aio.c:1822 [inline]
  #0: ffff88806001fc58 (&(&ctx->ctx_lock)->rlock){..-.}, at:  
io_submit_one+0xeb5/0x2ef0 fs/aio.c:1859

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (&(&ctx->ctx_lock)->rlock){..-.} {
    IN-SOFTIRQ-W at:
                     lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
                     __raw_spin_lock_irq  
include/linux/spinlock_api_smp.h:128 [inline]
                     _raw_spin_lock_irq+0x60/0x80  
kernel/locking/spinlock.c:167
                     spin_lock_irq include/linux/spinlock.h:363 [inline]
                     free_ioctx_users+0x2d/0x490 fs/aio.c:618
                     percpu_ref_put_many include/linux/percpu-refcount.h:293  
[inline]
                     percpu_ref_put include/linux/percpu-refcount.h:309  
[inline]
                     percpu_ref_call_confirm_rcu lib/percpu-refcount.c:130  
[inline]
                     percpu_ref_switch_to_atomic_rcu+0x4c0/0x570  
lib/percpu-refcount.c:165
                     __rcu_reclaim kernel/rcu/rcu.h:222 [inline]
                     rcu_do_batch kernel/rcu/tree.c:2157 [inline]
                     rcu_core+0x581/0x1560 kernel/rcu/tree.c:2377
                     rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2386
                     __do_softirq+0x262/0x98c kernel/softirq.c:292
                     invoke_softirq kernel/softirq.c:373 [inline]
                     irq_exit+0x19b/0x1e0 kernel/softirq.c:413
                     exiting_irq arch/x86/include/asm/apic.h:536 [inline]
                     smp_apic_timer_interrupt+0x1a3/0x610  
arch/x86/kernel/apic/apic.c:1095
                     apic_timer_interrupt+0xf/0x20  
arch/x86/entry/entry_64.S:830
                     constant_test_bit arch/x86/include/asm/bitops.h:207  
[inline]
                     test_bit include/asm-generic/bitops-instrumented.h:238  
[inline]
                     test_ti_thread_flag include/linux/thread_info.h:84  
[inline]
                     need_resched include/linux/sched.h:1827 [inline]
                     mutex_spin_on_owner+0x7b/0x330  
kernel/locking/mutex.c:568
                     mutex_optimistic_spin kernel/locking/mutex.c:673  
[inline]
                     __mutex_lock_common kernel/locking/mutex.c:959 [inline]
                     __mutex_lock+0x330/0x13c0 kernel/locking/mutex.c:1103
                     mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
                     rtnl_lock+0x17/0x20 net/core/rtnetlink.c:72
                     addrconf_dad_work+0xad/0x1150 net/ipv6/addrconf.c:4032
                     process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
                     worker_thread+0x98/0xe40 kernel/workqueue.c:2415
                     kthread+0x361/0x430 kernel/kthread.c:255
                     ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
    INITIAL USE at:
                    lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
                    __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128  
[inline]
                    _raw_spin_lock_irq+0x60/0x80  
kernel/locking/spinlock.c:167
                    spin_lock_irq include/linux/spinlock.h:363 [inline]
                    free_ioctx_users+0x2d/0x490 fs/aio.c:618
                    percpu_ref_put_many include/linux/percpu-refcount.h:293  
[inline]
                    percpu_ref_put include/linux/percpu-refcount.h:309  
[inline]
                    percpu_ref_call_confirm_rcu lib/percpu-refcount.c:130  
[inline]
                    percpu_ref_switch_to_atomic_rcu+0x4c0/0x570  
lib/percpu-refcount.c:165
                    __rcu_reclaim kernel/rcu/rcu.h:222 [inline]
                    rcu_do_batch kernel/rcu/tree.c:2157 [inline]
                    rcu_core+0x581/0x1560 kernel/rcu/tree.c:2377
                    rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2386
                    __do_softirq+0x262/0x98c kernel/softirq.c:292
                    invoke_softirq kernel/softirq.c:373 [inline]
                    irq_exit+0x19b/0x1e0 kernel/softirq.c:413
                    exiting_irq arch/x86/include/asm/apic.h:536 [inline]
                    smp_apic_timer_interrupt+0x1a3/0x610  
arch/x86/kernel/apic/apic.c:1095
                    apic_timer_interrupt+0xf/0x20  
arch/x86/entry/entry_64.S:830
                    constant_test_bit arch/x86/include/asm/bitops.h:207  
[inline]
                    test_bit include/asm-generic/bitops-instrumented.h:238  
[inline]
                    test_ti_thread_flag include/linux/thread_info.h:84  
[inline]
                    need_resched include/linux/sched.h:1827 [inline]
                    mutex_spin_on_owner+0x7b/0x330 kernel/locking/mutex.c:568
                    mutex_optimistic_spin kernel/locking/mutex.c:673 [inline]
                    __mutex_lock_common kernel/locking/mutex.c:959 [inline]
                    __mutex_lock+0x330/0x13c0 kernel/locking/mutex.c:1103
                    mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
                    rtnl_lock+0x17/0x20 net/core/rtnetlink.c:72
                    addrconf_dad_work+0xad/0x1150 net/ipv6/addrconf.c:4032
                    process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
                    worker_thread+0x98/0xe40 kernel/workqueue.c:2415
                    kthread+0x361/0x430 kernel/kthread.c:255
                    ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
  }
  ... key      at: [<ffffffff8ab00360>] __key.54228+0x0/0x40
  ... acquired at:
    lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
    spin_lock include/linux/spinlock.h:338 [inline]
    aio_poll fs/aio.c:1748 [inline]
    __io_submit_one fs/aio.c:1822 [inline]
    io_submit_one+0xefa/0x2ef0 fs/aio.c:1859
    __do_sys_io_submit fs/aio.c:1918 [inline]
    __se_sys_io_submit fs/aio.c:1888 [inline]
    __x64_sys_io_submit+0x1bd/0x570 fs/aio.c:1888
    do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
    entry_SYSCALL_64_after_hwframe+0x49/0xbe


the dependencies between the lock to be acquired
  and SOFTIRQ-irq-unsafe lock:
-> (&fiq->waitq){+.+.} {
    HARDIRQ-ON-W at:
                     lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
                     __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                     _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
                     spin_lock include/linux/spinlock.h:338 [inline]
                     flush_bg_queue+0x1f3/0x3c0 fs/fuse/dev.c:415
                     fuse_request_queue_background+0x2f8/0x5a0  
fs/fuse/dev.c:676
                     fuse_request_send_background+0x58/0x110  
fs/fuse/dev.c:687
                     cuse_send_init fs/fuse/cuse.c:459 [inline]
                     cuse_channel_open+0x5ba/0x830 fs/fuse/cuse.c:519
                     misc_open+0x395/0x4c0 drivers/char/misc.c:141
                     chrdev_open+0x245/0x6b0 fs/char_dev.c:414
                     do_dentry_open+0x4df/0x1250 fs/open.c:797
                     vfs_open+0xa0/0xd0 fs/open.c:914
                     do_last fs/namei.c:3416 [inline]
                     path_openat+0x10e9/0x4630 fs/namei.c:3533
                     do_filp_open+0x1a1/0x280 fs/namei.c:3563
                     do_sys_open+0x3fe/0x5d0 fs/open.c:1097
                     __do_sys_openat fs/open.c:1124 [inline]
                     __se_sys_openat fs/open.c:1118 [inline]
                     __x64_sys_openat+0x9d/0x100 fs/open.c:1118
                     do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
    SOFTIRQ-ON-W at:
                     lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
                     __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                     _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
                     spin_lock include/linux/spinlock.h:338 [inline]
                     flush_bg_queue+0x1f3/0x3c0 fs/fuse/dev.c:415
                     fuse_request_queue_background+0x2f8/0x5a0  
fs/fuse/dev.c:676
                     fuse_request_send_background+0x58/0x110  
fs/fuse/dev.c:687
                     cuse_send_init fs/fuse/cuse.c:459 [inline]
                     cuse_channel_open+0x5ba/0x830 fs/fuse/cuse.c:519
                     misc_open+0x395/0x4c0 drivers/char/misc.c:141
                     chrdev_open+0x245/0x6b0 fs/char_dev.c:414
                     do_dentry_open+0x4df/0x1250 fs/open.c:797
                     vfs_open+0xa0/0xd0 fs/open.c:914
                     do_last fs/namei.c:3416 [inline]
                     path_openat+0x10e9/0x4630 fs/namei.c:3533
                     do_filp_open+0x1a1/0x280 fs/namei.c:3563
                     do_sys_open+0x3fe/0x5d0 fs/open.c:1097
                     __do_sys_openat fs/open.c:1124 [inline]
                     __se_sys_openat fs/open.c:1118 [inline]
                     __x64_sys_openat+0x9d/0x100 fs/open.c:1118
                     do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
    INITIAL USE at:
                    lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142  
[inline]
                    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:338 [inline]
                    flush_bg_queue+0x1f3/0x3c0 fs/fuse/dev.c:415
                    fuse_request_queue_background+0x2f8/0x5a0  
fs/fuse/dev.c:676
                    fuse_request_send_background+0x58/0x110 fs/fuse/dev.c:687
                    cuse_send_init fs/fuse/cuse.c:459 [inline]
                    cuse_channel_open+0x5ba/0x830 fs/fuse/cuse.c:519
                    misc_open+0x395/0x4c0 drivers/char/misc.c:141
                    chrdev_open+0x245/0x6b0 fs/char_dev.c:414
                    do_dentry_open+0x4df/0x1250 fs/open.c:797
                    vfs_open+0xa0/0xd0 fs/open.c:914
                    do_last fs/namei.c:3416 [inline]
                    path_openat+0x10e9/0x4630 fs/namei.c:3533
                    do_filp_open+0x1a1/0x280 fs/namei.c:3563
                    do_sys_open+0x3fe/0x5d0 fs/open.c:1097
                    __do_sys_openat fs/open.c:1124 [inline]
                    __se_sys_openat fs/open.c:1118 [inline]
                    __x64_sys_openat+0x9d/0x100 fs/open.c:1118
                    do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
  }
  ... key      at: [<ffffffff8ab9a180>] __key.45697+0x0/0x40
  ... acquired at:
    lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
    spin_lock include/linux/spinlock.h:338 [inline]
    aio_poll fs/aio.c:1748 [inline]
    __io_submit_one fs/aio.c:1822 [inline]
    io_submit_one+0xefa/0x2ef0 fs/aio.c:1859
    __do_sys_io_submit fs/aio.c:1918 [inline]
    __se_sys_io_submit fs/aio.c:1888 [inline]
    __x64_sys_io_submit+0x1bd/0x570 fs/aio.c:1888
    do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
    entry_SYSCALL_64_after_hwframe+0x49/0xbe


stack backtrace:
CPU: 0 PID: 25024 Comm: syz-executor.1 Not tainted 5.3.0-rc4-next-20190814  
#66
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_bad_irq_dependency kernel/locking/lockdep.c:2095 [inline]
  check_irq_usage.cold+0x586/0x6fe kernel/locking/lockdep.c:2293
  check_prev_add kernel/locking/lockdep.c:2480 [inline]
  check_prevs_add kernel/locking/lockdep.c:2581 [inline]
  validate_chain kernel/locking/lockdep.c:2971 [inline]
  __lock_acquire+0x25d0/0x4e70 kernel/locking/lockdep.c:3955
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
  spin_lock include/linux/spinlock.h:338 [inline]
  aio_poll fs/aio.c:1748 [inline]
  __io_submit_one fs/aio.c:1822 [inline]
  io_submit_one+0xefa/0x2ef0 fs/aio.c:1859
  __do_sys_io_submit fs/aio.c:1918 [inline]
  __se_sys_io_submit fs/aio.c:1888 [inline]
  __x64_sys_io_submit+0x1bd/0x570 fs/aio.c:1888
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459829
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9e07853c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459829
RDX: 0000000020000440 RSI: 0000000000000001 RDI: 00007f9e07833000
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9e078546d4
R13: 00000000004c0c19 R14: 00000000004d3c40 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
