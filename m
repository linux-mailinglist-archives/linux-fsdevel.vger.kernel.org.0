Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C482EFFB9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 14:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbhAINGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 08:06:07 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:46587 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbhAINGG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 08:06:06 -0500
Received: by mail-il1-f197.google.com with SMTP id x14so12960151ilg.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Jan 2021 05:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Oxg1f3ZQbDFZuLoZlFpJsrZ+RFWdGJNDuixf0/nZikY=;
        b=OlO/g8iA526DvqEhTDwh8lVgKFGkkyiRetq/Xa/eckRBkUgDJRXun+uBi5R/Pae5sB
         vv4QirwtZMo+WiUqAZkNl1v0MD4Q6+MznqcHiu2n23qIG2aLRJGsmx2Ph0NEAo15VnXz
         RgAI17giCZcfi1cHK0GUDEqp/Q4GJGCmDFIr9H4YqJsF0wSORLIOmGF1cye+AqDiPhOB
         r+WnojWgmt88hb8Cv9H/cwFa90+hsIu5sxI2YHnHCh8ejC7aGp/KLMvejbGLgMzsFqMq
         Zf8zybOB1DvHIpamX1JaOPNXUaBD1kXWfj8QaqlQS6D5ZOXw3tVRptpg0i4dEuQJfcLE
         xpBA==
X-Gm-Message-State: AOAM532rTTCF7/z5ZOzgPJKXkJDOHWq4akDLYcfToO+NP0sNJANaSzWt
        hVmfB8Bsrb4oUN1y7kUy23Zjv1OaQFNrbe8sktveW9fDM3zw
X-Google-Smtp-Source: ABdhPJx88ecDfQBcuRZ9wiLPjM6UcatDnOSH3BT5Rgf8MQuI/P+DkPmaRLz7ZSzYhWF9zAZwnL2fl7V4aGH5EN0jyjw6MdnjAl7l
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1647:: with SMTP id v7mr7846863ilu.259.1610197524340;
 Sat, 09 Jan 2021 05:05:24 -0800 (PST)
Date:   Sat, 09 Jan 2021 05:05:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074e66c05b87753da@google.com>
Subject: possible deadlock in fasync_remove_entry
From:   syzbot <syzbot+5252d2712377e3867125@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f5e6c330 Merge tag 'spi-fix-v5.11-rc2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1639f3a8d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aa30b9da402d224
dashboard link: https://syzkaller.appspot.com/bug?extid=5252d2712377e3867125
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5252d2712377e3867125@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
5.11.0-rc2-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.3/15310 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff888013d6b7b8 (&f->f_owner.lock){.+.?}-{2:2}, at: send_sigio+0x24/0x360 fs/fcntl.c:787

and this task is already holding:
ffff8880289580c0 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1004 [inline]
ffff8880289580c0 (&new->fa_lock){....}-{2:2}, at: kill_fasync fs/fcntl.c:1025 [inline]
ffff8880289580c0 (&new->fa_lock){....}-{2:2}, at: kill_fasync+0x14b/0x460 fs/fcntl.c:1018
which would create a new lock dependency:
 (&new->fa_lock){....}-{2:2} -> (&f->f_owner.lock){.+.?}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (fasync_lock){+.+.}-{2:2}

... which became SOFTIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5437 [inline]
  lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
  spin_lock include/linux/spinlock.h:354 [inline]
  fasync_remove_entry+0x2e/0x1f0 fs/fcntl.c:877
  fasync_helper+0x9e/0xb0 fs/fcntl.c:985
  __tty_fasync drivers/tty/tty_io.c:2130 [inline]
  tty_release+0x16d/0x1210 drivers/tty/tty_io.c:1668
  __fput+0x283/0x920 fs/file_table.c:280
  task_work_run+0xdd/0x190 kernel/task_work.c:140
  tracehook_notify_resume include/linux/tracehook.h:189 [inline]
  exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
  exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:201
  __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
  syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

to a SOFTIRQ-irq-unsafe lock:
 (&f->f_owner.lock){.+.?}-{2:2}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5437 [inline]
  lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
  __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
  _raw_read_lock_irqsave+0x45/0x90 kernel/locking/spinlock.c:231
  send_sigurg+0x1e/0xac0 fs/fcntl.c:826
  sk_send_sigurg+0x76/0x300 net/core/sock.c:2938
  tcp_check_urg.isra.0+0x1f4/0x710 net/ipv4/tcp_input.c:5508
  tcp_urg net/ipv4/tcp_input.c:5549 [inline]
  tcp_rcv_established+0x106c/0x1eb0 net/ipv4/tcp_input.c:5883
  tcp_v4_do_rcv+0x5d1/0x870 net/ipv4/tcp_ipv4.c:1676
  tcp_v4_rcv+0x2d10/0x3750 net/ipv4/tcp_ipv4.c:2058
  ip_protocol_deliver_rcu+0x5c/0x8a0 net/ipv4/ip_input.c:204
  ip_local_deliver_finish+0x20a/0x370 net/ipv4/ip_input.c:231
  NF_HOOK include/linux/netfilter.h:301 [inline]
  NF_HOOK include/linux/netfilter.h:295 [inline]
  ip_local_deliver+0x1b3/0x200 net/ipv4/ip_input.c:252
  dst_input include/net/dst.h:447 [inline]
  ip_rcv_finish+0x1da/0x2f0 net/ipv4/ip_input.c:428
  NF_HOOK include/linux/netfilter.h:301 [inline]
  NF_HOOK include/linux/netfilter.h:295 [inline]
  ip_rcv+0xaa/0xd0 net/ipv4/ip_input.c:539
  __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5323
  __netif_receive_skb+0x27/0x1c0 net/core/dev.c:5437
  process_backlog+0x232/0x6c0 net/core/dev.c:6327
  napi_poll net/core/dev.c:6805 [inline]
  net_rx_action+0x461/0xe10 net/core/dev.c:6888
  __do_softirq+0x2a5/0x9f7 kernel/softirq.c:343
  run_ksoftirqd kernel/softirq.c:650 [inline]
  run_ksoftirqd+0x2d/0x50 kernel/softirq.c:642
  smpboot_thread_fn+0x655/0x9e0 kernel/smpboot.c:165
  kthread+0x3b1/0x4a0 kernel/kthread.c:292
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

other info that might help us debug this:

Chain exists of:
  fasync_lock --> &new->fa_lock --> &f->f_owner.lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&f->f_owner.lock);
                               local_irq_disable();
                               lock(fasync_lock);
                               lock(&new->fa_lock);
  <Interrupt>
    lock(fasync_lock);

 *** DEADLOCK ***

8 locks held by syz-executor.3/15310:
 #0: ffff888144d4e110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_write+0x1d3/0x760 drivers/input/evdev.c:513
 #1: ffff88801cb5c230 (&dev->event_lock){-...}-{2:2}, at: input_inject_event+0xa6/0x310 drivers/input/input.c:471
 #2: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: is_event_supported drivers/input/input.c:53 [inline]
 #2: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: is_event_supported drivers/input/input.c:50 [inline]
 #2: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: input_inject_event+0x92/0x310 drivers/input/input.c:470
 #3: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: input_pass_values.part.0+0x0/0x700 drivers/input/input.c:837
 #4: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: evdev_events+0x59/0x3f0 drivers/input/evdev.c:296
 #5: ffff888074f12028 (&client->buffer_lock){....}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
 #5: ffff888074f12028 (&client->buffer_lock){....}-{2:2}, at: evdev_pass_values.part.0+0xf6/0x970 drivers/input/evdev.c:261
 #6: ffffffff8b363860 (rcu_read_lock){....}-{1:2}, at: kill_fasync+0x3d/0x460 fs/fcntl.c:1023
 #7: ffff8880289580c0 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1004 [inline]
 #7: ffff8880289580c0 (&new->fa_lock){....}-{2:2}, at: kill_fasync fs/fcntl.c:1025 [inline]
 #7: ffff8880289580c0 (&new->fa_lock){....}-{2:2}, at: kill_fasync+0x14b/0x460 fs/fcntl.c:1018

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
 -> (fasync_lock){+.+.}-{2:2} {
    HARDIRQ-ON-W at:
                      lock_acquire kernel/locking/lockdep.c:5437 [inline]
                      lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                      __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                      _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                      spin_lock include/linux/spinlock.h:354 [inline]
                      fasync_remove_entry+0x2e/0x1f0 fs/fcntl.c:877
                      fasync_helper+0x9e/0xb0 fs/fcntl.c:985
                      __tty_fasync drivers/tty/tty_io.c:2130 [inline]
                      tty_release+0x16d/0x1210 drivers/tty/tty_io.c:1668
                      __fput+0x283/0x920 fs/file_table.c:280
                      task_work_run+0xdd/0x190 kernel/task_work.c:140
                      tracehook_notify_resume include/linux/tracehook.h:189 [inline]
                      exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
                      exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:201
                      __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
                      syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
                      entry_SYSCALL_64_after_hwframe+0x44/0xa9
    SOFTIRQ-ON-W at:
                      lock_acquire kernel/locking/lockdep.c:5437 [inline]
                      lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                      __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                      _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                      spin_lock include/linux/spinlock.h:354 [inline]
                      fasync_remove_entry+0x2e/0x1f0 fs/fcntl.c:877
                      fasync_helper+0x9e/0xb0 fs/fcntl.c:985
                      __tty_fasync drivers/tty/tty_io.c:2130 [inline]
                      tty_release+0x16d/0x1210 drivers/tty/tty_io.c:1668
                      __fput+0x283/0x920 fs/file_table.c:280
                      task_work_run+0xdd/0x190 kernel/task_work.c:140
                      tracehook_notify_resume include/linux/tracehook.h:189 [inline]
                      exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
                      exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:201
                      __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
                      syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
                      entry_SYSCALL_64_after_hwframe+0x44/0xa9
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5437 [inline]
                     lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                     __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                     _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                     spin_lock include/linux/spinlock.h:354 [inline]
                     fasync_remove_entry+0x2e/0x1f0 fs/fcntl.c:877
                     fasync_helper+0x9e/0xb0 fs/fcntl.c:985
                     __tty_fasync drivers/tty/tty_io.c:2130 [inline]
                     tty_release+0x16d/0x1210 drivers/tty/tty_io.c:1668
                     __fput+0x283/0x920 fs/file_table.c:280
                     task_work_run+0xdd/0x190 kernel/task_work.c:140
                     tracehook_notify_resume include/linux/tracehook.h:189 [inline]
                     exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
                     exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:201
                     __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
                     syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
                     entry_SYSCALL_64_after_hwframe+0x44/0xa9
  }
  ... key      at: [<ffffffff8b4b3058>] fasync_lock+0x18/0x8e0
  ... acquired at:
   __raw_write_lock_irq include/linux/rwlock_api_smp.h:196 [inline]
   _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:311
   fasync_remove_entry+0xb6/0x1f0 fs/fcntl.c:882
   fasync_helper+0x9e/0xb0 fs/fcntl.c:985
   sock_fasync+0x94/0x140 net/socket.c:1281
   __fput+0x70d/0x920 fs/file_table.c:277
   task_work_run+0xdd/0x190 kernel/task_work.c:140
   tracehook_notify_resume include/linux/tracehook.h:189 [inline]
   exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
   exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:201
   __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
   syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> (&new->fa_lock){....}-{2:2} {
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5437 [inline]
                   lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:196 [inline]
                   _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:311
                   fasync_remove_entry+0xb6/0x1f0 fs/fcntl.c:882
                   fasync_helper+0x9e/0xb0 fs/fcntl.c:985
                   sock_fasync+0x94/0x140 net/socket.c:1281
                   __fput+0x70d/0x920 fs/file_table.c:277
                   task_work_run+0xdd/0x190 kernel/task_work.c:140
                   tracehook_notify_resume include/linux/tracehook.h:189 [inline]
                   exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
                   exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:201
                   __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
                   syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
                   entry_SYSCALL_64_after_hwframe+0x44/0xa9
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5437 [inline]
                        lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                        __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                        _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                        kill_fasync_rcu fs/fcntl.c:1004 [inline]
                        kill_fasync fs/fcntl.c:1025 [inline]
                        kill_fasync+0x14b/0x460 fs/fcntl.c:1018
                        __pass_event drivers/input/evdev.c:240 [inline]
                        evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
                        evdev_pass_values drivers/input/evdev.c:253 [inline]
                        evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
                        input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
                        input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
                        input_pass_values drivers/input/input.c:134 [inline]
                        input_handle_event+0x373/0x1440 drivers/input/input.c:404
                        input_inject_event+0x2f5/0x310 drivers/input/input.c:476
                        evdev_write+0x430/0x760 drivers/input/evdev.c:530
                        vfs_write+0x28e/0xa30 fs/read_write.c:603
                        ksys_write+0x1ee/0x250 fs/read_write.c:658
                        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                        entry_SYSCALL_64_after_hwframe+0x44/0xa9
 }
 ... key      at: [<ffffffff8ef8e980>] __key.0+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5437 [inline]
   lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:231
   send_sigio+0x24/0x360 fs/fcntl.c:787
   kill_fasync_rcu fs/fcntl.c:1011 [inline]
   kill_fasync fs/fcntl.c:1025 [inline]
   kill_fasync+0x205/0x460 fs/fcntl.c:1018
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
   evdev_pass_values drivers/input/evdev.c:253 [inline]
   evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x373/0x1440 drivers/input/input.c:404
   input_inject_event+0x2f5/0x310 drivers/input/input.c:476
   evdev_write+0x430/0x760 drivers/input/evdev.c:530
   vfs_write+0x28e/0xa30 fs/read_write.c:603
   ksys_write+0x1ee/0x250 fs/read_write.c:658
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9


the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (&f->f_owner.lock){.+.?}-{2:2} {
   HARDIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5437 [inline]
                    lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                    __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                    _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                    f_getown_ex fs/fcntl.c:206 [inline]
                    do_fcntl+0x8ab/0x1070 fs/fcntl.c:387
                    __do_sys_fcntl fs/fcntl.c:463 [inline]
                    __se_sys_fcntl fs/fcntl.c:448 [inline]
                    __x64_sys_fcntl+0x165/0x1e0 fs/fcntl.c:448
                    do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                    entry_SYSCALL_64_after_hwframe+0x44/0xa9
   IN-SOFTIRQ-R at:
                    lock_acquire kernel/locking/lockdep.c:5437 [inline]
                    lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                    __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
                    _raw_read_lock_irqsave+0x45/0x90 kernel/locking/spinlock.c:231
                    send_sigurg+0x1e/0xac0 fs/fcntl.c:826
                    sk_send_sigurg+0x76/0x300 net/core/sock.c:2938
                    tcp_check_urg.isra.0+0x1f4/0x710 net/ipv4/tcp_input.c:5508
                    tcp_urg net/ipv4/tcp_input.c:5549 [inline]
                    tcp_rcv_established+0x106c/0x1eb0 net/ipv4/tcp_input.c:5883
                    tcp_v4_do_rcv+0x5d1/0x870 net/ipv4/tcp_ipv4.c:1676
                    tcp_v4_rcv+0x2d10/0x3750 net/ipv4/tcp_ipv4.c:2058
                    ip_protocol_deliver_rcu+0x5c/0x8a0 net/ipv4/ip_input.c:204
                    ip_local_deliver_finish+0x20a/0x370 net/ipv4/ip_input.c:231
                    NF_HOOK include/linux/netfilter.h:301 [inline]
                    NF_HOOK include/linux/netfilter.h:295 [inline]
                    ip_local_deliver+0x1b3/0x200 net/ipv4/ip_input.c:252
                    dst_input include/net/dst.h:447 [inline]
                    ip_rcv_finish+0x1da/0x2f0 net/ipv4/ip_input.c:428
                    NF_HOOK include/linux/netfilter.h:301 [inline]
                    NF_HOOK include/linux/netfilter.h:295 [inline]
                    ip_rcv+0xaa/0xd0 net/ipv4/ip_input.c:539
                    __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5323
                    __netif_receive_skb+0x27/0x1c0 net/core/dev.c:5437
                    process_backlog+0x232/0x6c0 net/core/dev.c:6327
                    napi_poll net/core/dev.c:6805 [inline]
                    net_rx_action+0x461/0xe10 net/core/dev.c:6888
                    __do_softirq+0x2a5/0x9f7 kernel/softirq.c:343
                    run_ksoftirqd kernel/softirq.c:650 [inline]
                    run_ksoftirqd+0x2d/0x50 kernel/softirq.c:642
                    smpboot_thread_fn+0x655/0x9e0 kernel/smpboot.c:165
                    kthread+0x3b1/0x4a0 kernel/kthread.c:292
                    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
   SOFTIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5437 [inline]
                    lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                    __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                    _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                    f_getown_ex fs/fcntl.c:206 [inline]
                    do_fcntl+0x8ab/0x1070 fs/fcntl.c:387
                    __do_sys_fcntl fs/fcntl.c:463 [inline]
                    __se_sys_fcntl fs/fcntl.c:448 [inline]
                    __x64_sys_fcntl+0x165/0x1e0 fs/fcntl.c:448
                    do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                    entry_SYSCALL_64_after_hwframe+0x44/0xa9
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5437 [inline]
                        lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
                        __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                        _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:223
                        f_getown_ex fs/fcntl.c:206 [inline]
                        do_fcntl+0x8ab/0x1070 fs/fcntl.c:387
                        __do_sys_fcntl fs/fcntl.c:463 [inline]
                        __se_sys_fcntl fs/fcntl.c:448 [inline]
                        __x64_sys_fcntl+0x165/0x1e0 fs/fcntl.c:448
                        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                        entry_SYSCALL_64_after_hwframe+0x44/0xa9
 }
 ... key      at: [<ffffffff8ef8dba0>] __key.5+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5437 [inline]
   lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:231
   send_sigio+0x24/0x360 fs/fcntl.c:787
   kill_fasync_rcu fs/fcntl.c:1011 [inline]
   kill_fasync fs/fcntl.c:1025 [inline]
   kill_fasync+0x205/0x460 fs/fcntl.c:1018
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
   evdev_pass_values drivers/input/evdev.c:253 [inline]
   evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
   input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
   input_pass_values drivers/input/input.c:134 [inline]
   input_handle_event+0x373/0x1440 drivers/input/input.c:404
   input_inject_event+0x2f5/0x310 drivers/input/input.c:476
   evdev_write+0x430/0x760 drivers/input/evdev.c:530
   vfs_write+0x28e/0xa30 fs/read_write.c:603
   ksys_write+0x1ee/0x250 fs/read_write.c:658
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xa9


stack backtrace:
CPU: 1 PID: 15310 Comm: syz-executor.3 Not tainted 5.11.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_bad_irq_dependency kernel/locking/lockdep.c:2452 [inline]
 check_irq_usage.cold+0x4f5/0x6c8 kernel/locking/lockdep.c:2681
 check_prev_add kernel/locking/lockdep.c:2872 [inline]
 check_prevs_add kernel/locking/lockdep.c:2993 [inline]
 validate_chain kernel/locking/lockdep.c:3608 [inline]
 __lock_acquire+0x2af6/0x5500 kernel/locking/lockdep.c:4832
 lock_acquire kernel/locking/lockdep.c:5437 [inline]
 lock_acquire+0x29d/0x740 kernel/locking/lockdep.c:5402
 __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
 _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:231
 send_sigio+0x24/0x360 fs/fcntl.c:787
 kill_fasync_rcu fs/fcntl.c:1011 [inline]
 kill_fasync fs/fcntl.c:1025 [inline]
 kill_fasync+0x205/0x460 fs/fcntl.c:1018
 __pass_event drivers/input/evdev.c:240 [inline]
 evdev_pass_values.part.0+0x64e/0x970 drivers/input/evdev.c:278
 evdev_pass_values drivers/input/evdev.c:253 [inline]
 evdev_events+0x28b/0x3f0 drivers/input/evdev.c:306
 input_to_handler+0x2a0/0x4c0 drivers/input/input.c:115
 input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
 input_pass_values drivers/input/input.c:134 [inline]
 input_handle_event+0x373/0x1440 drivers/input/input.c:404
 input_inject_event+0x2f5/0x310 drivers/input/input.c:476
 evdev_write+0x430/0x760 drivers/input/evdev.c:530
 vfs_write+0x28e/0xa30 fs/read_write.c:603
 ksys_write+0x1ee/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e219
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1ed116dc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045e219
RDX: 00000000000002b8 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 000000000119bfc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bf8c
R13: 00007fff2a57451f R14: 00007f1ed116e9c0 R15: 000000000119bf8c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
