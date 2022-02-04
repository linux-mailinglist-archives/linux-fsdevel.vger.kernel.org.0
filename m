Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD994A923C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 03:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbiBDCMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 21:12:20 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:57077 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiBDCMT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:12:19 -0500
Received: by mail-il1-f199.google.com with SMTP id t15-20020a92c90f000000b002ba55086cc6so2913357ilp.23
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Feb 2022 18:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=loIlQQhD8rASiuX2pvX5Xk8j8M8qufubC/OTk/rx/20=;
        b=JLzibA5GvNhPTkRWstH5qFQELCtwKsSOCxyIx8LCsfPYm5AEl4tgnwBMnNHImzOeIi
         8gdFDl/qbiOFZRqaCYNgkz7YwYcMP0+rYMIPe+xtL0q9147G3CsOWl5XpnOehTGME5ii
         DMlGPKHyl0UfJ0lFTzeSyQ6PAG5hd+8g8zXa/d0zXLBYgp+02zLn9J6st0+8NArliKOd
         B8hPewurEnXv+DM+3HW5Qm6WWMddbk1DOGfKeffl3o6TKdBes6OHGmzFmYx1Bh4crDJJ
         VjvQTpMuLkCULxXgtO19RjEC3biBOdqUHXhUHn/dzhXKHxt5L6/Xv+6IwZ3VZhhqemoK
         97SQ==
X-Gm-Message-State: AOAM53120C8S2720XLoRh4YZ6TydpjVPIZAGdL1JD0kIsV0jome2Hb2b
        LPacZsAQV/ppPShDi/RE3hkcx567lo89LPwPzEyFRb4HkauL
X-Google-Smtp-Source: ABdhPJzJ3WI4uBBax7afQtYmDH9dEDjQYsCF7WblXFkdBoz4A2BYRwc2+dDmjQp2RH0cHybba0nx2KDBNFr6KdmszizWN1o11051
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c6:: with SMTP id s6mr407633ilu.301.1643940739387;
 Thu, 03 Feb 2022 18:12:19 -0800 (PST)
Date:   Thu, 03 Feb 2022 18:12:19 -0800
In-Reply-To: <000000000000afc4bc05d150d3af@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd945f05d727c7f6@google.com>
Subject: Re: [syzbot] possible deadlock in snd_timer_interrupt (2)
From:   syzbot <syzbot+1ee0910eca9c94f71f25@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, bfields@fieldses.org,
        hdanton@sina.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        viro@zeniv.linux.org.uk, wangwensheng4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    1f2cfdd349b7 printk: Fix incorrect __user type in proc_doi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146fce24700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4a89edfcc8f7c74
dashboard link: https://syzkaller.appspot.com/bug?extid=1ee0910eca9c94f71f25
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1007e462700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ee0910eca9c94f71f25@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
5.17.0-rc2-syzkaller-00071-g1f2cfdd349b7 #0 Not tainted
--------------------------------------------------------
syz-executor.3/4250 just changed the state of lock:
ffff88814a62e148 (&timer->lock){..-.}-{2:2}, at: snd_timer_interrupt.part.0+0x34/0xcf0 sound/core/timer.c:856
but this lock took another, SOFTIRQ-READ-unsafe lock in the past:
 (tasklist_lock){.+.+}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
Chain exists of:
  &timer->lock --> &new->fa_lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&timer->lock);
                               lock(&new->fa_lock);
  <Interrupt>
    lock(&timer->lock);

 *** DEADLOCK ***

2 locks held by syz-executor.3/4250:
 #0: ffff88807efef828 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0xa1/0x170 mm/memory.c:5271
 #1: ffffc90000dc0d70 ((&priv->tlist)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:35 [inline]
 #1: ffffc90000dc0d70 ((&priv->tlist)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x6b0 kernel/time/timer.c:1411

the shortest dependencies between 2nd lock and 1st lock:
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

 -> (&new->fa_lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5639 [inline]
                     lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                     _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:326
                     fasync_remove_entry+0xb6/0x1f0 fs/fcntl.c:891
                     fasync_helper+0x9e/0xb0 fs/fcntl.c:994
                     __fput+0x846/0x9f0 fs/file_table.c:308
                     task_work_run+0xdd/0x1a0 kernel/task_work.c:164
                     tracehook_notify_resume include/linux/tracehook.h:188 [inline]
                     exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
                     exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
                     __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
                     syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
                     do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
                     entry_SYSCALL_64_after_hwframe+0x44/0xae
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

-> (&timer->lock){..-.}-{2:2} {
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5639 [inline]
                    lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
                    snd_timer_interrupt.part.0+0x34/0xcf0 sound/core/timer.c:856
                    snd_timer_interrupt sound/core/timer.c:1154 [inline]
                    snd_timer_s_function+0x14b/0x200 sound/core/timer.c:1154
                    call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
                    expire_timers kernel/time/timer.c:1466 [inline]
                    __run_timers.part.0+0x67c/0xa30 kernel/time/timer.c:1734
                    __run_timers kernel/time/timer.c:1715 [inline]
                    run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
                    __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
                    invoke_softirq kernel/softirq.c:432 [inline]
                    __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
                    irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
                    sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
                    asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
                    kasan_check_range+0x0/0x180 mm/kasan/generic.c:349
                    instrument_atomic_read include/linux/instrumented.h:71 [inline]
                    test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
                    cpumask_test_cpu include/linux/cpumask.h:379 [inline]
                    cpu_online include/linux/cpumask.h:921 [inline]
                    trace_lock_release include/trace/events/lock.h:58 [inline]
                    lock_release+0xa1/0x720 kernel/locking/lockdep.c:5650
                    __might_fault mm/memory.c:5272 [inline]
                    __might_fault+0x142/0x170 mm/memory.c:5257
                    _copy_from_user+0x27/0x180 lib/usercopy.c:13
                    copy_from_user include/linux/uaccess.h:192 [inline]
                    snd_seq_oss_write+0x38b/0x780 sound/core/seq/oss/seq_oss_rw.c:93
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
                   snd_timer_user_params.isra.0+0x18e/0x8c0 sound/core/timer.c:1851
                   __snd_timer_user_ioctl.isra.0+0x1020/0x2490 sound/core/timer.c:2100
                   snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2128
                   vfs_ioctl fs/ioctl.c:51 [inline]
                   __do_sys_ioctl fs/ioctl.c:874 [inline]
                   __se_sys_ioctl fs/ioctl.c:860 [inline]
                   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
                   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                   entry_SYSCALL_64_after_hwframe+0x44/0xae
 }
 ... key      at: [<ffffffff9087d3c0>] __key.12+0x0/0x40
 ... acquired at:
   mark_usage kernel/locking/lockdep.c:4500 [inline]
   __lock_acquire+0x11d2/0x5470 kernel/locking/lockdep.c:4981
   lock_acquire kernel/locking/lockdep.c:5639 [inline]
   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
   snd_timer_interrupt.part.0+0x34/0xcf0 sound/core/timer.c:856
   snd_timer_interrupt sound/core/timer.c:1154 [inline]
   snd_timer_s_function+0x14b/0x200 sound/core/timer.c:1154
   call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
   expire_timers kernel/time/timer.c:1466 [inline]
   __run_timers.part.0+0x67c/0xa30 kernel/time/timer.c:1734
   __run_timers kernel/time/timer.c:1715 [inline]
   run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
   __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
   invoke_softirq kernel/softirq.c:432 [inline]
   __irq_exit_rcu+0x123/0x180 kernel/softirq.c:637
   irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
   sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
   asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
   kasan_check_range+0x0/0x180 mm/kasan/generic.c:349
   instrument_atomic_read include/linux/instrumented.h:71 [inline]
   test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
   cpumask_test_cpu include/linux/cpumask.h:379 [inline]
   cpu_online include/linux/cpumask.h:921 [inline]
   trace_lock_release include/trace/events/lock.h:58 [inline]
   lock_release+0xa1/0x720 kernel/locking/lockdep.c:5650
   __might_fault mm/memory.c:5272 [inline]
   __might_fault+0x142/0x170 mm/memory.c:5257
   _copy_from_user+0x27/0x180 lib/usercopy.c:13
   copy_from_user include/linux/uaccess.h:192 [inline]
   snd_seq_oss_write+0x38b/0x780 sound/core/seq/oss/seq_oss_rw.c:93
   odev_write+0x55/0x90 sound/core/seq/oss/seq_oss.c:168
   vfs_write+0x28e/0xae0 fs/read_write.c:588
   ksys_write+0x12d/0x250 fs/read_write.c:643
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae


stack backtrace:
CPU: 1 PID: 4250 Comm: syz-executor.3 Not tainted 5.17.0-rc2-syzkaller-00071-g1f2cfdd349b7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106

