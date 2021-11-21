Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CB54585F4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Nov 2021 19:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbhKUSm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 13:42:28 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:37506 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbhKUSm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 13:42:28 -0500
Received: by mail-io1-f70.google.com with SMTP id w8-20020a0566022c0800b005dc06acea8dso9462341iov.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Nov 2021 10:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=P3bR0h9MtRQHasU/yoIFOzaCTelHNVQza7LkR4fSHMY=;
        b=MUwvKkNUnE0Mts+ngX403TxtN51q3hGcfFPmgYqwvRFiSljxA4lVvUwDCpsf56x3CG
         TTES9X2SjkEB6jvGTsJVcwptimtJxp8AiyMA7wYAj2Ylnhf0jIGa2B32y6N5skHykIFV
         Q140ZLc4aewXW0pQFCAF/TQkR3BvP6TvqqHiRiAXvnjIAaWIlwAw/AZTI9e60CgwCDZ5
         YxuUYtMDqJ3j1V8Tuw8fwtD1CvNoMc1S0DvqyR7FRvDGlcX9dQVWZQAdIT6Q9fhMzKsp
         WqgFna3EC4HcGytTgFcE1N2mIAL+B7GOiZN5Ch2zvHbMyKQPq+NuswELg4XMWf4BNbXn
         SrQw==
X-Gm-Message-State: AOAM533vTdL+8Q1qHMS1ty2P9priF08c0+S2q1dE8koMhMQ/3PiBwotS
        TSjxDKe8BLJP+a2q7cLyHnoWYHbDbLwRAzjvRgEY0LS/NxOo
X-Google-Smtp-Source: ABdhPJymsP7gQmhSuv2krXupE8Ya8wcM/ifuSskgmK9I1eqgtndHu4Yzf36xBYO8NlI0bFFIIr4NmaP9fuwS6cSu9TlTZlsFAkoj
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be9:: with SMTP id y9mr7127715ilv.219.1637519962652;
 Sun, 21 Nov 2021 10:39:22 -0800 (PST)
Date:   Sun, 21 Nov 2021 10:39:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000afc4bc05d150d3af@google.com>
Subject: [syzbot] possible deadlock in snd_timer_interrupt (2)
From:   syzbot <syzbot+1ee0910eca9c94f71f25@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ee1703cda8dc Merge tag 'hyperv-fixes-signed-20211117' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167cc6fab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7264d1cb8ba2795
dashboard link: https://syzkaller.appspot.com/bug?extid=1ee0910eca9c94f71f25
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ee0910eca9c94f71f25@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
5.16.0-rc1-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.0/25993 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffffffff8b80a098 (tasklist_lock){.+.+}-{2:2}, at: send_sigio+0xab/0x380 fs/fcntl.c:810

and this task is already holding:
ffff888042f5cbb8 (&f->f_owner.lock){...-}-{2:2}, at: send_sigio+0x24/0x380 fs/fcntl.c:796
which would create a new lock dependency:
 (&f->f_owner.lock){...-}-{2:2} -> (tasklist_lock){.+.+}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&timer->lock){..-.}-{2:2}

... which became SOFTIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5637 [inline]
  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
  snd_timer_interrupt.part.0+0x34/0xcf0 sound/core/timer.c:856
  snd_timer_interrupt sound/core/timer.c:1154 [inline]
  snd_timer_s_function+0x14b/0x200 sound/core/timer.c:1154
  call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
  expire_timers kernel/time/timer.c:1466 [inline]
  __run_timers.part.0+0x675/0xa20 kernel/time/timer.c:1734
  __run_timers kernel/time/timer.c:1715 [inline]
  run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
  __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
  invoke_softirq kernel/softirq.c:432 [inline]
  __irq_exit_rcu+0x123/0x180 kernel/softirq.c:636
  irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
  lock_is_held_type+0xff/0x140 kernel/locking/lockdep.c:5685
  lock_is_held include/linux/lockdep.h:283 [inline]
  rcu_read_lock_sched_held+0x3a/0x70 kernel/rcu/update.c:125
  trace_lock_release include/trace/events/lock.h:58 [inline]
  lock_release+0x522/0x720 kernel/locking/lockdep.c:5648
  rcu_lock_release include/linux/rcupdate.h:273 [inline]
  rcu_read_unlock include/linux/rcupdate.h:721 [inline]
  inet_twsk_purge+0x503/0x7d0 net/ipv4/inet_timewait_sock.c:299
  ops_exit_list+0x10d/0x160 net/core/net_namespace.c:171
  cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:593
  process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
  worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
  kthread+0x405/0x4f0 kernel/kthread.c:327
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

to a SOFTIRQ-irq-unsafe lock:
 (tasklist_lock){.+.+}-{2:2}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5637 [inline]
  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
  __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
  _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
  do_wait+0x284/0xce0 kernel/exit.c:1511
  kernel_wait+0x9c/0x150 kernel/exit.c:1701
  call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
  call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
  process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
  worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
  kthread+0x405/0x4f0 kernel/kthread.c:327
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

6 locks held by syz-executor.0/25993:
 #0: ffff88814af6e460 (sb_writers#5){.+.+}-{0:0}, at: vfs_truncate+0xea/0x4b0 fs/open.c:83
 #1: ffffffff8bd30930 (file_rwsem){.+.+}-{0:0}, at: break_lease include/linux/fs.h:2634 [inline]
 #1: ffffffff8bd30930 (file_rwsem){.+.+}-{0:0}, at: break_lease include/linux/fs.h:2624 [inline]
 #1: ffffffff8bd30930 (file_rwsem){.+.+}-{0:0}, at: vfs_truncate+0x31a/0x4b0 fs/open.c:104
 #2: ffff88806c596a68 (&ctx->flc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
 #2: ffff88806c596a68 (&ctx->flc_lock){+.+.}-{2:2}, at: __break_lease+0x208/0x1420 fs/locks.c:1422
 #3: ffffffff8bb80f60 (rcu_read_lock){....}-{1:2}, at: kill_fasync+0x41/0x470 fs/fcntl.c:1033
 #4: ffff88802aad5948 (&new->fa_lock){...-}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1014 [inline]
 #4: ffff88802aad5948 (&new->fa_lock){...-}-{2:2}, at: kill_fasync fs/fcntl.c:1035 [inline]
 #4: ffff88802aad5948 (&new->fa_lock){...-}-{2:2}, at: kill_fasync+0x136/0x470 fs/fcntl.c:1028
 #5: ffff888042f5cbb8 (&f->f_owner.lock){...-}-{2:2}, at: send_sigio+0x24/0x380 fs/fcntl.c:796

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
  -> (&timer->lock){..-.}-{2:2} {
     IN-SOFTIRQ-W at:
                        lock_acquire kernel/locking/lockdep.c:5637 [inline]
                        lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                        _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
                        snd_timer_interrupt.part.0+0x34/0xcf0 sound/core/timer.c:856
                        snd_timer_interrupt sound/core/timer.c:1154 [inline]
                        snd_timer_s_function+0x14b/0x200 sound/core/timer.c:1154
                        call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
                        expire_timers kernel/time/timer.c:1466 [inline]
                        __run_timers.part.0+0x675/0xa20 kernel/time/timer.c:1734
                        __run_timers kernel/time/timer.c:1715 [inline]
                        run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
                        __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
                        invoke_softirq kernel/softirq.c:432 [inline]
                        __irq_exit_rcu+0x123/0x180 kernel/softirq.c:636
                        irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
                        sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
                        asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
                        lock_is_held_type+0xff/0x140 kernel/locking/lockdep.c:5685
                        lock_is_held include/linux/lockdep.h:283 [inline]
                        rcu_read_lock_sched_held+0x3a/0x70 kernel/rcu/update.c:125
                        trace_lock_release include/trace/events/lock.h:58 [inline]
                        lock_release+0x522/0x720 kernel/locking/lockdep.c:5648
                        rcu_lock_release include/linux/rcupdate.h:273 [inline]
                        rcu_read_unlock include/linux/rcupdate.h:721 [inline]
                        inet_twsk_purge+0x503/0x7d0 net/ipv4/inet_timewait_sock.c:299
                        ops_exit_list+0x10d/0x160 net/core/net_namespace.c:171
                        cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:593
                        process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
                        worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
                        kthread+0x405/0x4f0 kernel/kthread.c:327
                        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
     INITIAL USE at:
                       lock_acquire kernel/locking/lockdep.c:5637 [inline]
                       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
                       snd_timer_notify sound/core/timer.c:1086 [inline]
                       snd_timer_notify+0x10c/0x3d0 sound/core/timer.c:1073
                       snd_pcm_timer_notify sound/core/pcm_native.c:595 [inline]
                       snd_pcm_post_stop+0x195/0x1f0 sound/core/pcm_native.c:1453
                       snd_pcm_action_single sound/core/pcm_native.c:1229 [inline]
                       snd_pcm_action+0x143/0x170 sound/core/pcm_native.c:1310
                       snd_pcm_stop sound/core/pcm_native.c:1476 [inline]
                       snd_pcm_drop+0x1ab/0x320 sound/core/pcm_native.c:2155
                       snd_pcm_kernel_ioctl+0x2af/0x310 sound/core/pcm_native.c:3382
                       snd_pcm_oss_sync+0x230/0x800 sound/core/oss/pcm_oss.c:1721
                       snd_pcm_oss_release+0x276/0x300 sound/core/oss/pcm_oss.c:2571
                       __fput+0x286/0x9f0 fs/file_table.c:280
                       task_work_run+0xdd/0x1a0 kernel/task_work.c:164
                       tracehook_notify_resume include/linux/tracehook.h:189 [inline]
                       exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
                       exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
                       __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
                       syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
                       do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
                       entry_SYSCALL_64_after_hwframe+0x44/0xae
   }
   ... key      at: [<ffffffff90842da0>] __key.12+0x0/0x40
 -> (&new->fa_lock){...-}-{2:2} {
    IN-SOFTIRQ-R at:
                      lock_acquire kernel/locking/lockdep.c:5637 [inline]
                      lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                      __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
                      _raw_read_lock_irqsave+0x45/0x90 kernel/locking/spinlock.c:236
                      kill_fasync_rcu fs/fcntl.c:1014 [inline]
                      kill_fasync fs/fcntl.c:1035 [inline]
                      kill_fasync+0x136/0x470 fs/fcntl.c:1028
                      sock_wake_async+0xd2/0x160 net/socket.c:1368
                      sk_wake_async include/net/sock.h:2400 [inline]
                      sk_wake_async include/net/sock.h:2396 [inline]
                      sock_def_error_report+0x34b/0x4e0 net/core/sock.c:3125
                      sk_error_report+0x35/0x310 net/core/sock.c:339
                      tcp_write_err net/ipv4/tcp_timer.c:71 [inline]
                      tcp_write_timeout net/ipv4/tcp_timer.c:276 [inline]
                      tcp_retransmit_timer+0x20c2/0x3320 net/ipv4/tcp_timer.c:512
                      tcp_write_timer_handler+0x5e6/0xbc0 net/ipv4/tcp_timer.c:622
                      tcp_write_timer+0xa2/0x2b0 net/ipv4/tcp_timer.c:642
                      call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
                      expire_timers kernel/time/timer.c:1466 [inline]
                      __run_timers.part.0+0x675/0xa20 kernel/time/timer.c:1734
                      __run_timers kernel/time/timer.c:1715 [inline]
                      run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
                      __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
                      run_ksoftirqd kernel/softirq.c:920 [inline]
                      run_ksoftirqd+0x2d/0x60 kernel/softirq.c:912
                      smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
                      kthread+0x405/0x4f0 kernel/kthread.c:327
                      ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5637 [inline]
                     lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:194 [inline]
                     _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:316
                     fasync_remove_entry+0xb6/0x1f0 fs/fcntl.c:891
                     fasync_helper+0x9e/0xb0 fs/fcntl.c:994
                     lease_modify fs/locks.c:1315 [inline]
                     lease_modify+0x28a/0x370 fs/locks.c:1302
                     locks_remove_lease fs/locks.c:2558 [inline]
                     locks_remove_file+0x29c/0x570 fs/locks.c:2583
                     __fput+0x1b9/0x9f0 fs/file_table.c:272
                     task_work_run+0xdd/0x1a0 kernel/task_work.c:164
                     tracehook_notify_resume include/linux/tracehook.h:189 [inline]
                     exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
                     exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
                     __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
                     syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
                     do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
                     entry_SYSCALL_64_after_hwframe+0x44/0xae
    INITIAL READ USE at:
                          lock_acquire kernel/locking/lockdep.c:5637 [inline]
                          lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                          __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
                          _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
                          kill_fasync_rcu fs/fcntl.c:1014 [inline]
                          kill_fasync fs/fcntl.c:1035 [inline]
                          kill_fasync+0x136/0x470 fs/fcntl.c:1028
                          pipe_release+0x1ba/0x320 fs/pipe.c:728
                          __fput+0x286/0x9f0 fs/file_table.c:280
                          task_work_run+0xdd/0x1a0 kernel/task_work.c:164
                          tracehook_notify_resume include/linux/tracehook.h:189 [inline]
                          exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
                          exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
                          __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
                          syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
                          do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
                          entry_SYSCALL_64_after_hwframe+0x44/0xae
  }
  ... key      at: [<ffffffff90537880>] __key.0+0x0/0x40
  ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
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

-> (&f->f_owner.lock){...-}-{2:2} {
   IN-SOFTIRQ-R at:
                    lock_acquire kernel/locking/lockdep.c:5637 [inline]
                    lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                    __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
                    _raw_read_lock_irqsave+0x45/0x90 kernel/locking/spinlock.c:236
                    send_sigio+0x24/0x380 fs/fcntl.c:796
                    kill_fasync_rcu fs/fcntl.c:1021 [inline]
                    kill_fasync fs/fcntl.c:1035 [inline]
                    kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
                    sock_wake_async+0xd2/0x160 net/socket.c:1368
                    sk_wake_async include/net/sock.h:2400 [inline]
                    sk_wake_async include/net/sock.h:2396 [inline]
                    sock_def_error_report+0x34b/0x4e0 net/core/sock.c:3125
                    sk_error_report+0x35/0x310 net/core/sock.c:339
                    tcp_write_err net/ipv4/tcp_timer.c:71 [inline]
                    tcp_write_timeout net/ipv4/tcp_timer.c:276 [inline]
                    tcp_retransmit_timer+0x20c2/0x3320 net/ipv4/tcp_timer.c:512
                    tcp_write_timer_handler+0x5e6/0xbc0 net/ipv4/tcp_timer.c:622
                    tcp_write_timer+0xa2/0x2b0 net/ipv4/tcp_timer.c:642
                    call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
                    expire_timers kernel/time/timer.c:1466 [inline]
                    __run_timers.part.0+0x675/0xa20 kernel/time/timer.c:1734
                    __run_timers kernel/time/timer.c:1715 [inline]
                    run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
                    __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
                    run_ksoftirqd kernel/softirq.c:920 [inline]
                    run_ksoftirqd+0x2d/0x60 kernel/softirq.c:912
                    smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
                    kthread+0x405/0x4f0 kernel/kthread.c:327
                    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5637 [inline]
                   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:194 [inline]
                   _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:316
                   f_modown+0x2a/0x390 fs/fcntl.c:91
                   generic_add_lease fs/locks.c:1735 [inline]
                   generic_setlease+0x11bc/0x1a60 fs/locks.c:1814
                   vfs_setlease+0xfd/0x120 fs/locks.c:1904
                   do_fcntl_add_lease fs/locks.c:1925 [inline]
                   fcntl_setlease+0x134/0x2c0 fs/locks.c:1947
                   do_fcntl+0x2b6/0x1210 fs/fcntl.c:419
                   __do_sys_fcntl fs/fcntl.c:472 [inline]
                   __se_sys_fcntl fs/fcntl.c:457 [inline]
                   __x64_sys_fcntl+0x165/0x1e0 fs/fcntl.c:457
                   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                   entry_SYSCALL_64_after_hwframe+0x44/0xae
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5637 [inline]
                        lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                        __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
                        _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
                        send_sigio+0x24/0x380 fs/fcntl.c:796
                        kill_fasync_rcu fs/fcntl.c:1021 [inline]
                        kill_fasync fs/fcntl.c:1035 [inline]
                        kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
                        pipe_release+0x1ba/0x320 fs/pipe.c:728
                        __fput+0x286/0x9f0 fs/file_table.c:280
                        task_work_run+0xdd/0x1a0 kernel/task_work.c:164
                        tracehook_notify_resume include/linux/tracehook.h:189 [inline]
                        exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
                        exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
                        __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
                        syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
                        do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
                        entry_SYSCALL_64_after_hwframe+0x44/0xae
 }
 ... key      at: [<ffffffff90536aa0>] __key.5+0x0/0x40
 ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
   send_sigio+0x24/0x380 fs/fcntl.c:796
   kill_fasync_rcu fs/fcntl.c:1021 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
   pipe_release+0x1ba/0x320 fs/pipe.c:728
   __fput+0x286/0x9f0 fs/file_table.c:280
   task_work_run+0xdd/0x1a0 kernel/task_work.c:164
   tracehook_notify_resume include/linux/tracehook.h:189 [inline]
   exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
   exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
   __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
   syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
   do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
   entry_SYSCALL_64_after_hwframe+0x44/0xae


the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (tasklist_lock){.+.+}-{2:2} {
   HARDIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5637 [inline]
                    lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                    __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                    _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                    do_wait+0x284/0xce0 kernel/exit.c:1511
                    kernel_wait+0x9c/0x150 kernel/exit.c:1701
                    call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                    call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                    process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
                    worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
                    kthread+0x405/0x4f0 kernel/kthread.c:327
                    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
   SOFTIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5637 [inline]
                    lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                    __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                    _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                    do_wait+0x284/0xce0 kernel/exit.c:1511
                    kernel_wait+0x9c/0x150 kernel/exit.c:1701
                    call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                    call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                    process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
                    worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
                    kthread+0x405/0x4f0 kernel/kthread.c:327
                    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5637 [inline]
                   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:194 [inline]
                   _raw_write_lock_irq+0x32/0x50 kernel/locking/spinlock.c:316
                   copy_process+0x36c8/0x75a0 kernel/fork.c:2311
                   kernel_clone+0xe7/0xab0 kernel/fork.c:2582
                   kernel_thread+0xb5/0xf0 kernel/fork.c:2634
                   rest_init+0x23/0x3e0 init/main.c:690
                   start_kernel+0x47a/0x49b init/main.c:1135
                   secondary_startup_64_no_verify+0xb0/0xbb
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5637 [inline]
                        lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                        __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                        _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
                        do_wait+0x284/0xce0 kernel/exit.c:1511
                        kernel_wait+0x9c/0x150 kernel/exit.c:1701
                        call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                        call_usermodehelper_exec_work+0xf5/0x180 kernel/umh.c:166
                        process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
                        worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
                        kthread+0x405/0x4f0 kernel/kthread.c:327
                        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 }
 ... key      at: [<ffffffff8b80a098>] tasklist_lock+0x18/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5637 [inline]
   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
   send_sigio+0xab/0x380 fs/fcntl.c:810
   kill_fasync_rcu fs/fcntl.c:1021 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
   lease_break_callback+0x1f/0x30 fs/locks.c:477
   __break_lease+0x3d7/0x1420 fs/locks.c:1450
   break_lease include/linux/fs.h:2634 [inline]
   break_lease include/linux/fs.h:2624 [inline]
   vfs_truncate+0x31a/0x4b0 fs/open.c:104
   do_sys_truncate.part.0+0x11e/0x140 fs/open.c:133
   do_sys_truncate fs/open.c:127 [inline]
   __do_sys_truncate fs/open.c:145 [inline]
   __se_sys_truncate fs/open.c:143 [inline]
   __x64_sys_truncate+0x69/0x90 fs/open.c:143
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae


stack backtrace:
CPU: 0 PID: 25993 Comm: syz-executor.0 Not tainted 5.16.0-rc1-syzkaller #0
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
 __lock_acquire+0x2a1f/0x54a0 kernel/locking/lockdep.c:5027
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
 __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
 _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
 send_sigio+0xab/0x380 fs/fcntl.c:810
 kill_fasync_rcu fs/fcntl.c:1021 [inline]
 kill_fasync fs/fcntl.c:1035 [inline]
 kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
 lease_break_callback+0x1f/0x30 fs/locks.c:477
 __break_lease+0x3d7/0x1420 fs/locks.c:1450
 break_lease include/linux/fs.h:2634 [inline]
 break_lease include/linux/fs.h:2624 [inline]
 vfs_truncate+0x31a/0x4b0 fs/open.c:104
 do_sys_truncate.part.0+0x11e/0x140 fs/open.c:133
 do_sys_truncate fs/open.c:127 [inline]
 __do_sys_truncate fs/open.c:145 [inline]
 __se_sys_truncate fs/open.c:143 [inline]
 __x64_sys_truncate+0x69/0x90 fs/open.c:143
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f7b8fe43ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7b8d3b9188 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007f7b8ff56f60 RCX: 00007f7b8fe43ae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007f7b8fe9df6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc1688ebaf R14: 00007f7b8d3b9300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
