Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18834A8CA5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 20:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353844AbiBCToU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 14:44:20 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:33747 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353842AbiBCToS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:44:18 -0500
Received: by mail-io1-f71.google.com with SMTP id d6-20020a6b6e06000000b006101dc42ec8so2737061ioh.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Feb 2022 11:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UNxxsPWZjFQjXzG7ieRcL3cS0HnyuRmnHfDX/xcOPyI=;
        b=cL+ER6/JsBZ93Fu6VWW6lbYp8zm8f9Fopcg7AczQ65RDsCfekC++lZAO2nF7YAYo4v
         qtvqZ1fzjZh/3dS8+UNm4/HwCXcBFjMx5UxJSDReKed80T+mWCzcQppXtIZJGWquvM1l
         9aaa+29sAGPiTj6ChA4UWD4goe5WExWRDjElNCisEwcCrU3t0CljWQJKR+wxsztftx+O
         Ssw9CXLm/C7FRivlk211FP/U5/XxRyHj3U8dI40SvzHG/qYsJU/4IEZu6jIQMg2LDXQg
         hjAAAAzBxaIr3kcrb/eSqp/gDTEiBZ1xsX1aVyOTiHYX81k1WWIfK4H4mHdG/WTx6hh/
         DpOQ==
X-Gm-Message-State: AOAM530+omlolhq7bdLegQZql4yzyBUC+dxlETa85ZJTwbJpBjC2x9CV
        RPgstqieBUS1apwjBpmEaucDljPyuF4Nl5Lg9/BIK1Gx+3P3
X-Google-Smtp-Source: ABdhPJwsgGOhmoRgxFUO8JZfXkc5uJvft4XICMzFdc0G3mzv/0rlVgfw1ojZkZ2Jump622V+0UhtgZ02//1jJOhNvyNZQTj8z87v
MIME-Version: 1.0
X-Received: by 2002:a05:6638:304d:: with SMTP id u13mr16603198jak.103.1643917457978;
 Thu, 03 Feb 2022 11:44:17 -0800 (PST)
Date:   Thu, 03 Feb 2022 11:44:17 -0800
In-Reply-To: <000000000000efaa3905d0722c58@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f79b405d7225c42@google.com>
Subject: Re: [syzbot] possible deadlock in snd_hrtimer_callback (2)
From:   syzbot <syzbot+8285e973a41b5aa68902@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    88808fbbead4 Merge tag 'nfsd-5.17-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13949710700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4a89edfcc8f7c74
dashboard link: https://syzkaller.appspot.com/bug?extid=8285e973a41b5aa68902
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1743617c700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b4f97c700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8285e973a41b5aa68902@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
5.17.0-rc2-syzkaller-00060-g88808fbbead4 #0 Not tainted
-----------------------------------------------------
syz-executor612/3594 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffffffff8b80a098 (tasklist_lock){.+.+}-{2:2}, at: send_sigio+0xab/0x380 fs/fcntl.c:810

and this task is already holding:
ffff888076825038 (&f->f_owner.lock){....}-{2:2}, at: send_sigio+0x24/0x380 fs/fcntl.c:796
which would create a new lock dependency:
 (&f->f_owner.lock){....}-{2:2} -> (tasklist_lock){.+.+}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&timer->lock){-...}-{2:2}

... which became HARDIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5639 [inline]
  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:349 [inline]
  snd_hrtimer_callback+0x4f/0x3c0 sound/core/hrtimer.c:38
  __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
  __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1749
  hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
  __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1103
  sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1097
  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
  _raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
  spin_unlock_irqrestore include/linux/spinlock.h:404 [inline]
  snd_seq_cell_free+0x20a/0x410 sound/core/seq/seq_memory.c:202
  snd_seq_dispatch_event+0x11e/0x580 sound/core/seq/seq_clientmgr.c:916
  snd_seq_check_queue+0x173/0x440 sound/core/seq/seq_queue.c:268
  snd_seq_enqueue_event+0x1ed/0x3e0 sound/core/seq/seq_queue.c:344
  snd_seq_client_enqueue_event.constprop.0+0x230/0x440 sound/core/seq/seq_clientmgr.c:976
  snd_seq_kernel_client_enqueue+0x191/0x1e0 sound/core/seq/seq_clientmgr.c:2298
  insert_queue sound/core/seq/oss/seq_oss_rw.c:174 [inline]
  snd_seq_oss_write+0x5d7/0x780 sound/core/seq/oss/seq_oss_rw.c:135
  odev_write+0x55/0x90 sound/core/seq/oss/seq_oss.c:168
  vfs_write+0x28e/0xae0 fs/read_write.c:588
  ksys_write+0x12d/0x250 fs/read_write.c:643
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

to a HARDIRQ-irq-unsafe lock:
 (tasklist_lock){.+.+}-{2:2}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5639 [inline]
  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
  __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
  _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
  do_wait+0x284/0xce0 kernel/exit.c:1518
  kernel_wait+0x9c/0x150 kernel/exit.c:1708
  call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
  call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
  process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
  worker_thread+0x657/0x1110 kernel/workqueue.c:2454
  kthread+0x2e9/0x3a0 kernel/kthread.c:377
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

other info that might help us debug this:

Chain exists of:
  &timer->lock --> &f->f_owner.lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&timer->lock);
                               lock(&f->f_owner.lock);
  <Interrupt>
    lock(&timer->lock);

 *** DEADLOCK ***

5 locks held by syz-executor612/3594:
 #0: ffffffff8bb83c20 (rcu_read_lock){....}-{1:2}, at: sock_def_readable+0x0/0x4e0 include/trace/events/sock.h:204
 #1: ffffffff8bb83c20 (rcu_read_lock){....}-{1:2}, at: rcu_read_unlock include/linux/rcupdate.h:723 [inline]
 #1: ffffffff8bb83c20 (rcu_read_lock){....}-{1:2}, at: sock_def_readable+0x2aa/0x4e0 net/core/sock.c:3150
 #2: ffffffff8bb83c20 (rcu_read_lock){....}-{1:2}, at: kill_fasync+0x41/0x470 fs/fcntl.c:1033
 #3: ffff8880701ce0c0 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1014 [inline]
 #3: ffff8880701ce0c0 (&new->fa_lock){....}-{2:2}, at: kill_fasync fs/fcntl.c:1035 [inline]
 #3: ffff8880701ce0c0 (&new->fa_lock){....}-{2:2}, at: kill_fasync+0x136/0x470 fs/fcntl.c:1028
 #4: ffff888076825038 (&f->f_owner.lock){....}-{2:2}, at: send_sigio+0x24/0x380 fs/fcntl.c:796

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
  -> (&timer->lock){-...}-{2:2} {
     IN-HARDIRQ-W at:
                        lock_acquire kernel/locking/lockdep.c:5639 [inline]
                        lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                        __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                        _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
                        spin_lock include/linux/spinlock.h:349 [inline]
                        snd_hrtimer_callback+0x4f/0x3c0 sound/core/hrtimer.c:38
                        __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
                        __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1749
                        hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
                        local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
                        __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1103
                        sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1097
                        asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
                        __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
                        _raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
                        spin_unlock_irqrestore include/linux/spinlock.h:404 [inline]
                        snd_seq_cell_free+0x20a/0x410 sound/core/seq/seq_memory.c:202
                        snd_seq_dispatch_event+0x11e/0x580 sound/core/seq/seq_clientmgr.c:916
                        snd_seq_check_queue+0x173/0x440 sound/core/seq/seq_queue.c:268
                        snd_seq_enqueue_event+0x1ed/0x3e0 sound/core/seq/seq_queue.c:344
                        snd_seq_client_enqueue_event.constprop.0+0x230/0x440 sound/core/seq/seq_clientmgr.c:976
                        snd_seq_kernel_client_enqueue+0x191/0x1e0 sound/core/seq/seq_clientmgr.c:2298
                        insert_queue sound/core/seq/oss/seq_oss_rw.c:174 [inline]
                        snd_seq_oss_write+0x5d7/0x780 sound/core/seq/oss/seq_oss_rw.c:135
                        odev_write+0x55/0x90 sound/core/seq/oss/seq_oss.c:168
                        vfs_write+0x28e/0xae0 fs/read_write.c:588
                        ksys_write+0x12d/0x250 fs/read_write.c:643
                        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                        do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                        entry_SYSCALL_64_after_hwframe+0x44/0xae
     INITIAL USE at:
                       lock_acquire kernel/locking/lockdep.c:5639 [inline]
                       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
                       snd_timer_resolution+0x55/0x100 sound/core/timer.c:489
                       initialize_timer+0x183/0x290 sound/core/seq/seq_timer.c:373
                       seq_timer_start sound/core/seq/seq_timer.c:391 [inline]
                       snd_seq_timer_start+0x151/0x290 sound/core/seq/seq_timer.c:405
                       snd_seq_queue_process_event sound/core/seq/seq_queue.c:660 [inline]
                       snd_seq_control_queue+0x872/0xaa0 sound/core/seq/seq_queue.c:721
                       snd_seq_deliver_single_event.constprop.0+0x42b/0x820 sound/core/seq/seq_clientmgr.c:640
                       snd_seq_deliver_event+0x4e7/0x970 sound/core/seq/seq_clientmgr.c:841
                       snd_seq_kernel_client_dispatch+0x145/0x180 sound/core/seq/seq_clientmgr.c:2339
                       send_timer_event.isra.0+0x10b/0x160 sound/core/seq/oss/seq_oss_timer.c:140
                       snd_seq_oss_timer_start+0x1c3/0x310 sound/core/seq/oss/seq_oss_timer.c:161
                       old_event sound/core/seq/oss/seq_oss_event.c:113 [inline]
                       snd_seq_oss_process_event+0xda5/0x27d0 sound/core/seq/oss/seq_oss_event.c:88
                       insert_queue sound/core/seq/oss/seq_oss_rw.c:167 [inline]
                       snd_seq_oss_write+0x227/0x780 sound/core/seq/oss/seq_oss_rw.c:135
                       odev_write+0x55/0x90 sound/core/seq/oss/seq_oss.c:168
                       vfs_write+0x28e/0xae0 fs/read_write.c:588
                       ksys_write+0x12d/0x250 fs/read_write.c:643
                       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                       entry_SYSCALL_64_after_hwframe+0x44/0xae
   }
   ... key      at: [<ffffffff9087d3c0>] __key.12+0x0/0x40
 -> (&new->fa_lock){....}-{2:2} {
    INITIAL READ USE at:
                          lock_acquire kernel/locking/lockdep.c:5639 [inline]
                          lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                          __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                          _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
                          kill_fasync_rcu fs/fcntl.c:1014 [inline]
                          kill_fasync fs/fcntl.c:1035 [inline]
                          kill_fasync+0x136/0x470 fs/fcntl.c:1028
                          snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1386
                          snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
                          snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
                          snd_timer_start sound/core/timer.c:696 [inline]
                          snd_timer_start sound/core/timer.c:689 [inline]
                          snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1984
                          __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2107
                          snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128
                          vfs_ioctl fs/ioctl.c:51 [inline]
                          __do_sys_ioctl fs/ioctl.c:874 [inline]
                          __se_sys_ioctl fs/ioctl.c:860 [inline]
                          __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
                          do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                          do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                          entry_SYSCALL_64_after_hwframe+0x44/0xae
  }
  ... key      at: [<ffffffff9057f820>] __key.0+0x0/0x40
  ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1014 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x136/0x470 fs/fcntl.c:1028
   snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1386
   snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
   snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
   snd_timer_start sound/core/timer.c:696 [inline]
   snd_timer_start sound/core/timer.c:689 [inline]
   snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1984
   __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2107
   snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:874 [inline]
   __se_sys_ioctl fs/ioctl.c:860 [inline]
   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

-> (&f->f_owner.lock){....}-{2:2} {
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5639 [inline]
                   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:326
                   f_modown+0x2a/0x390 fs/fcntl.c:91
                   __f_setown fs/fcntl.c:110 [inline]
                   f_setown+0xd7/0x230 fs/fcntl.c:138
                   sock_ioctl+0x37e/0x640 net/socket.c:1182
                   vfs_ioctl fs/ioctl.c:51 [inline]
                   __do_sys_ioctl fs/ioctl.c:874 [inline]
                   __se_sys_ioctl fs/ioctl.c:860 [inline]
                   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
                   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                   entry_SYSCALL_64_after_hwframe+0x44/0xae
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5639 [inline]
                        lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                        __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                        _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
                        send_sigio+0x24/0x380 fs/fcntl.c:796
                        kill_fasync_rcu fs/fcntl.c:1021 [inline]
                        kill_fasync fs/fcntl.c:1035 [inline]
                        kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
                        snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1386
                        snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
                        snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
                        snd_timer_start sound/core/timer.c:696 [inline]
                        snd_timer_start sound/core/timer.c:689 [inline]
                        snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1984
                        __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2107
                        snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128
                        vfs_ioctl fs/ioctl.c:51 [inline]
                        __do_sys_ioctl fs/ioctl.c:874 [inline]
                        __se_sys_ioctl fs/ioctl.c:860 [inline]
                        __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
                        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                        do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                        entry_SYSCALL_64_after_hwframe+0x44/0xae
 }
 ... key      at: [<ffffffff9057ea40>] __key.5+0x0/0x40
 ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
   send_sigio+0x24/0x380 fs/fcntl.c:796
   kill_fasync_rcu fs/fcntl.c:1021 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
   snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1386
   snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
   snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
   snd_timer_start sound/core/timer.c:696 [inline]
   snd_timer_start sound/core/timer.c:689 [inline]
   snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1984
   __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2107
   snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:874 [inline]
   __se_sys_ioctl fs/ioctl.c:860 [inline]
   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae


the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (tasklist_lock){.+.+}-{2:2} {
   HARDIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5639 [inline]
                    lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                    do_wait+0x284/0xce0 kernel/exit.c:1518
                    kernel_wait+0x9c/0x150 kernel/exit.c:1708
                    call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                    call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                    process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
                    worker_thread+0x657/0x1110 kernel/workqueue.c:2454
                    kthread+0x2e9/0x3a0 kernel/kthread.c:377
                    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
   SOFTIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5639 [inline]
                    lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                    do_wait+0x284/0xce0 kernel/exit.c:1518
                    kernel_wait+0x9c/0x150 kernel/exit.c:1708
                    call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                    call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                    process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
                    worker_thread+0x657/0x1110 kernel/workqueue.c:2454
                    kthread+0x2e9/0x3a0 kernel/kthread.c:377
                    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5639 [inline]
                   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:326
                   copy_process+0x47da/0x7300 kernel/fork.c:2284
                   kernel_clone+0xe7/0xab0 kernel/fork.c:2555
                   kernel_thread+0xb5/0xf0 kernel/fork.c:2607
                   rest_init+0x23/0x3e0 init/main.c:690
                   start_kernel+0x47a/0x49b init/main.c:1138
                   secondary_startup_64_no_verify+0xc3/0xcb
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5639 [inline]
                        lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                        __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                        do_wait+0x284/0xce0 kernel/exit.c:1518
                        kernel_wait+0x9c/0x150 kernel/exit.c:1708
                        call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                        call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                        process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
                        worker_thread+0x657/0x1110 kernel/workqueue.c:2454
                        kthread+0x2e9/0x3a0 kernel/kthread.c:377
                        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 }
 ... key      at: [<ffffffff8b80a098>] tasklist_lock+0x18/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5639 [inline]
   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
   send_sigio+0xab/0x380 fs/fcntl.c:810
   kill_fasync_rcu fs/fcntl.c:1021 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
   sock_wake_async+0xd2/0x160 net/socket.c:1372
   sk_wake_async include/net/sock.h:2444 [inline]
   sk_wake_async include/net/sock.h:2440 [inline]
   sock_def_readable+0x349/0x4e0 net/core/sock.c:3149
   unix_dgram_sendmsg+0xf30/0x1a10 net/unix/af_unix.c:2029
   sock_sendmsg_nosec net/socket.c:705 [inline]
   sock_sendmsg+0xcf/0x120 net/socket.c:725
   ____sys_sendmsg+0x331/0x810 net/socket.c:2413
   ___sys_sendmsg+0xf3/0x170 net/socket.c:2467
   __sys_sendmmsg+0x195/0x470 net/socket.c:2553
   __do_sys_sendmmsg net/socket.c:2582 [inline]
   __se_sys_sendmmsg net/socket.c:2579 [inline]
   __x64_sys_sendmmsg+0x99/0x100 net/socket.c:2579
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae


stack backtrace:
CPU: 0 PID: 3594 Comm: syz-executor612 Not tainted 5.17.0-rc2-syzkaller-00060-g88808fbbead4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_bad_irq_dependency kernel/locking/lockdep.c:2577 [inline]
 check_irq_usage.cold+0x4c1/0x6b0 kernel/locking/lockdep.c:2816
 check_prev_add kernel/locking/lockdep.c:3067 [inline]
 check_prevs_add kernel/locking/lockdep.c:3186 [inline]
 validate_chain kernel/locking/lockdep.c:3801 [inline]
 __lock_acquire+0x2a44/0x5470 kernel/locking/lockdep.c:5027
 lock_acquire kernel/locking/lockdep.c:5639 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
 __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
 _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
 send_sigio+0xab/0x380 fs/fcntl.c:810
 kill_fasync_rcu fs/fcntl.c:1021 [inline]
 kill_fasync fs/fcntl.c:1035 [inline]
 kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
 sock_wake_async+0xd2/0x160 net/socket.c:1372
 sk_wake_async include/net/sock.h:2444 [inline]
 sk_wake_async include/net/sock.h:2440 [inline]
 sock_def_readable+0x349/0x4e0 net/core/sock.c:3149
 unix_dgram_sendmsg+0xf30/0x1a10 net/unix/af_unix.c:2029
 sock_sendmsg_nosec net/socket.c:705 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:725
 ____sys_sendmsg+0x331/0x810 net/socket.c:2413
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2467
 __sys_sendmmsg+0x195/0x470 net/socket.c:2553
 __do_sys_sendmmsg net/socket.c:2582 [inline]
 __se_sys_sendmmsg net/socket.c:2579 [inline]
 __x64_sys_sendmmsg+0x99/0x100 net/socket.c:2579
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fe4c19ec509
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe

