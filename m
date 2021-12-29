Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A4E480E84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Dec 2021 02:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbhL2BXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Dec 2021 20:23:18 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:37862 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238152AbhL2BXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Dec 2021 20:23:18 -0500
Received: by mail-io1-f70.google.com with SMTP id m127-20020a6b3f85000000b005f045ba51f9so8995049ioa.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Dec 2021 17:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BOLFyTa5gB+IROpl/3LH2URZ5X8e8OBp/KksWVij03w=;
        b=Nu8jXGbAjlw5E/XcVakpWFY72fyk9W/YDAKvy0t/bQjmy3GXJ4oS/0NsMSLGSioMko
         dCOHXpaqZ0SG4M7oj8ZZeY1Oyy3KkildvR2GFk/s83rci7ojAO4skLS+4vZ+abzNRaNR
         NkrwD72dPaF5JzcNEOK2JbBFhlCGtagt2TQlm0dUeKXr3C+FJ+CbvPwqMSbLNNTIm26n
         ShXesHI9IpsEBn6IFnfQArsLzOagEIyCrXYTthF7K1RjPEhNskbonhOTjpSJrlEoq0bv
         HfNnxKWR3fEb9Hk+ZzqR8d6THPbA/vrHPji2iJS924VRIhtvA9ja20RBWBkulxbJw7Bc
         KGwA==
X-Gm-Message-State: AOAM533xWlnhTFnjno14Hwonx2nprHqdcupo3w/Ijh0S3E6AcePRWb5e
        EyM33YvH39jE3SdPGyHCsmOEt+eHSoy62EfmtwPa8JQSS8sK
X-Google-Smtp-Source: ABdhPJynSlcIsRyra3HucMu/jgYYfaDH+IMqvWUABbzuzxhGchv4+P4rt22xAXbka2EFgETOBmpaIElRuRV61D8fZOOy3V+2G8U5
MIME-Version: 1.0
X-Received: by 2002:a6b:915:: with SMTP id t21mr8625246ioi.169.1640740997571;
 Tue, 28 Dec 2021 17:23:17 -0800 (PST)
Date:   Tue, 28 Dec 2021 17:23:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000542dc005d43ec857@google.com>
Subject: [syzbot] possible deadlock in snd_pcm_period_elapsed (3)
From:   syzbot <syzbot+669c9abf11a6a011dd09@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b927dfc67d05 Merge tag 'for-linus' of git://git.armlinux.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d7f80db00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec8ccde32929e7ce
dashboard link: https://syzkaller.appspot.com/bug?extid=669c9abf11a6a011dd09
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+669c9abf11a6a011dd09@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
5.16.0-rc6-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.2/12930 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffffffff8c80a058 (tasklist_lock){.+.+}-{2:2}, at: send_sigio+0xbe/0x300 fs/fcntl.c:810

and this task is already holding:
ffff88806efb3cb8 (&f->f_owner.lock){...-}-{2:2}, at: send_sigio+0x2f/0x300 fs/fcntl.c:796
which would create a new lock dependency:
 (&f->f_owner.lock){...-}-{2:2} -> (tasklist_lock){.+.+}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&group->lock){..-.}-{2:2}

... which became SOFTIRQ-irq-safe at:
  lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
  snd_pcm_period_elapsed+0x2c/0x210 sound/core/pcm_lib.c:1848
  dummy_hrtimer_callback+0x87/0x190 sound/drivers/dummy.c:377
  __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
  __hrtimer_run_queues+0x50b/0xa60 kernel/time/hrtimer.c:1749
  hrtimer_run_softirq+0x1b7/0x5d0 kernel/time/hrtimer.c:1766
  __do_softirq+0x392/0x7a3 kernel/softirq.c:558
  __irq_exit_rcu+0xec/0x170 kernel/softirq.c:637
  irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
  sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1097
  asm_sysvec_apic_timer_interrupt+0x12/0x20
  variable_test_bit arch/x86/include/asm/bitops.h:214 [inline]
  test_bit include/asm-generic/bitops/instrumented-non-atomic.h:135 [inline]
  cpumask_test_cpu include/linux/cpumask.h:344 [inline]
  cpu_online include/linux/cpumask.h:895 [inline]
  trace_lock_release+0x39/0x150 include/trace/events/lock.h:58
  lock_release+0x82/0x810 kernel/locking/lockdep.c:5648
  rcu_read_unlock include/linux/rcupdate.h:721 [inline]
  __do_sys_getpriority kernel/sys.c:321 [inline]
  __se_sys_getpriority+0x6b1/0x9c0 kernel/sys.c:273
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

to a SOFTIRQ-irq-unsafe lock:
 (tasklist_lock){.+.+}-{2:2}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
  __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
  _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
  do_wait+0x224/0x9d0 kernel/exit.c:1511
  kernel_wait+0xe4/0x230 kernel/exit.c:1701
  call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
  call_usermodehelper_exec_work+0xb4/0x220 kernel/umh.c:166
  process_one_work+0x853/0x1140 kernel/workqueue.c:2298
  worker_thread+0xac1/0x1320 kernel/workqueue.c:2445
  kthread+0x468/0x490 kernel/kthread.c:327
  ret_from_fork+0x1f/0x30

other info that might help us debug this:

Chain exists of:
  &group->lock --> &f->f_owner.lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&group->lock);
                               lock(&f->f_owner.lock);
  <Interrupt>
    lock(&group->lock);

 *** DEADLOCK ***

5 locks held by syz-executor.2/12930:
 #0: ffff88807efb4460 (sb_writers#5){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:376
 #1: ffff8880326621d8 (&type->i_mutex_dir_key#4){++++}-{3:3}, at: inode_lock include/linux/fs.h:783 [inline]
 #1: ffff8880326621d8 (&type->i_mutex_dir_key#4){++++}-{3:3}, at: open_last_lookups fs/namei.c:3347 [inline]
 #1: ffff8880326621d8 (&type->i_mutex_dir_key#4){++++}-{3:3}, at: path_openat+0x853/0x3660 fs/namei.c:3556
 #2: ffffffff90c894f8 (&fsnotify_mark_srcu){....}-{0:0}, at: rcu_lock_acquire+0x5/0x30 include/linux/rcupdate.h:267
 #3: ffff888075975038 (&mark->lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
 #3: ffff888075975038 (&mark->lock){+.+.}-{2:2}, at: dnotify_handle_event+0x5d/0x450 fs/notify/dnotify/dnotify.c:89
 #4: ffff88806efb3cb8 (&f->f_owner.lock){...-}-{2:2}, at: send_sigio+0x2f/0x300 fs/fcntl.c:796

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
   -> (&group->lock){..-.}-{2:2} {
      IN-SOFTIRQ-W at:
                          lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
                          __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                          _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
                          snd_pcm_period_elapsed+0x2c/0x210 sound/core/pcm_lib.c:1848
                          dummy_hrtimer_callback+0x87/0x190 sound/drivers/dummy.c:377
                          __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
                          __hrtimer_run_queues+0x50b/0xa60 kernel/time/hrtimer.c:1749
                          hrtimer_run_softirq+0x1b7/0x5d0 kernel/time/hrtimer.c:1766
                          __do_softirq+0x392/0x7a3 kernel/softirq.c:558
                          __irq_exit_rcu+0xec/0x170 kernel/softirq.c:637
                          irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
                          sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1097
                          asm_sysvec_apic_timer_interrupt+0x12/0x20
                          variable_test_bit arch/x86/include/asm/bitops.h:214 [inline]
                          test_bit include/asm-generic/bitops/instrumented-non-atomic.h:135 [inline]
                          cpumask_test_cpu include/linux/cpumask.h:344 [inline]
                          cpu_online include/linux/cpumask.h:895 [inline]
                          trace_lock_release+0x39/0x150 include/trace/events/lock.h:58
                          lock_release+0x82/0x810 kernel/locking/lockdep.c:5648
                          rcu_read_unlock include/linux/rcupdate.h:721 [inline]
                          __do_sys_getpriority kernel/sys.c:321 [inline]
                          __se_sys_getpriority+0x6b1/0x9c0 kernel/sys.c:273
                          do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                          do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
                          entry_SYSCALL_64_after_hwframe+0x44/0xae
      INITIAL USE at:
                         lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
                         __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                         _raw_spin_lock_irq+0xcf/0x110 kernel/locking/spinlock.c:170
                         spin_lock_irq include/linux/spinlock.h:374 [inline]
                         snd_pcm_group_lock_irq sound/core/pcm_native.c:97 [inline]
                         snd_pcm_stream_lock_irq sound/core/pcm_native.c:136 [inline]
                         snd_pcm_hw_params+0xca/0x1740 sound/core/pcm_native.c:686
                         snd_pcm_oss_change_params_locked+0x244e/0x4460 sound/core/oss/pcm_oss.c:960
                         snd_pcm_oss_change_params sound/core/oss/pcm_oss.c:1104 [inline]
                         snd_pcm_oss_make_ready sound/core/oss/pcm_oss.c:1163 [inline]
                         snd_pcm_oss_sync+0x37c/0xee0 sound/core/oss/pcm_oss.c:1730
                         snd_pcm_oss_release+0x119/0x270 sound/core/oss/pcm_oss.c:2584
                         __fput+0x3fc/0x870 fs/file_table.c:280
                         task_work_run+0x146/0x1c0 kernel/task_work.c:164
                         tracehook_notify_resume include/linux/tracehook.h:189 [inline]
                         exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
                         exit_to_user_mode_prepare+0x209/0x220 kernel/entry/common.c:207
                         __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
                         syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:300
                         do_syscall_64+0x53/0xd0 arch/x86/entry/common.c:86
                         entry_SYSCALL_64_after_hwframe+0x44/0xae
    }
    ... key      at: [<ffffffff91013ac0>] snd_pcm_group_init.__key+0x0/0x40
  -> (&timer->lock){....}-{2:2} {
     INITIAL USE at:
                       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
                       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                       _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
                       snd_timer_resolution sound/core/timer.c:489 [inline]
                       snd_timer_user_params sound/core/timer.c:1851 [inline]
                       __snd_timer_user_ioctl+0x1b9d/0x5920 sound/core/timer.c:2100
                       snd_timer_user_ioctl+0x5d/0x80 sound/core/timer.c:2128
                       vfs_ioctl fs/ioctl.c:51 [inline]
                       __do_sys_ioctl fs/ioctl.c:874 [inline]
                       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
                       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
                       entry_SYSCALL_64_after_hwframe+0x44/0xae
   }
   ... key      at: [<ffffffff91013080>] snd_timer_new.__key+0x0/0x40
   ... acquired at:
   lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
   snd_timer_notify+0x105/0x3e0 sound/core/timer.c:1086
   snd_pcm_timer_notify sound/core/pcm_native.c:595 [inline]
   snd_pcm_post_stop sound/core/pcm_native.c:1453 [inline]
   snd_pcm_action_single sound/core/pcm_native.c:1229 [inline]
   snd_pcm_action sound/core/pcm_native.c:1310 [inline]
   snd_pcm_stop+0x3b8/0x4c0 sound/core/pcm_native.c:1476
   snd_pcm_drop+0x16d/0x290 sound/core/pcm_native.c:2155
   snd_pcm_oss_sync+0x4f4/0xee0 sound/core/oss/pcm_oss.c:1734
   snd_pcm_oss_release+0x119/0x270 sound/core/oss/pcm_oss.c:2584
   __fput+0x3fc/0x870 fs/file_table.c:280
   task_work_run+0x146/0x1c0 kernel/task_work.c:164
   tracehook_notify_resume include/linux/tracehook.h:189 [inline]
   exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
   exit_to_user_mode_prepare+0x209/0x220 kernel/entry/common.c:207
   __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
   syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:300
   do_syscall_64+0x53/0xd0 arch/x86/entry/common.c:86
   entry_SYSCALL_64_after_hwframe+0x44/0xae

 -> (&new->fa_lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:194 [inline]
                     _raw_write_lock_irq+0xcf/0x110 kernel/locking/spinlock.c:316
                     fasync_remove_entry+0xff/0x1d0 fs/fcntl.c:891
                     __fput+0x71e/0x870 fs/file_table.c:277
                     task_work_run+0x146/0x1c0 kernel/task_work.c:164
                     tracehook_notify_resume include/linux/tracehook.h:189 [inline]
                     exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
                     exit_to_user_mode_prepare+0x209/0x220 kernel/entry/common.c:207
                     __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
                     syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:300
                     do_syscall_64+0x53/0xd0 arch/x86/entry/common.c:86
                     entry_SYSCALL_64_after_hwframe+0x44/0xae
    INITIAL READ USE at:
                          lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
                          __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
                          _raw_read_lock_irqsave+0xd9/0x120 kernel/locking/spinlock.c:236
                          kill_fasync_rcu fs/fcntl.c:1014 [inline]
                          kill_fasync+0x13b/0x430 fs/fcntl.c:1035
                          snd_timer_user_ccallback+0x370/0x540 sound/core/timer.c:1386
                          snd_timer_notify1+0x1ad/0x350 sound/core/timer.c:516
                          snd_timer_start1+0x53d/0x640 sound/core/timer.c:578
                          snd_timer_start sound/core/timer.c:696 [inline]
                          snd_timer_user_start sound/core/timer.c:1984 [inline]
                          __snd_timer_user_ioctl+0xb56/0x5920 sound/core/timer.c:2107
                          snd_timer_user_ioctl+0x5d/0x80 sound/core/timer.c:2128
                          vfs_ioctl fs/ioctl.c:51 [inline]
                          __do_sys_ioctl fs/ioctl.c:874 [inline]
                          __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
                          do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                          do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
                          entry_SYSCALL_64_after_hwframe+0x44/0xae
  }
  ... key      at: [<ffffffff90c85d40>] fasync_insert_entry.__key+0x0/0x40
  ... acquired at:
   lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
   _raw_read_lock_irqsave+0xd9/0x120 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1014 [inline]
   kill_fasync+0x13b/0x430 fs/fcntl.c:1035
   snd_timer_user_ccallback+0x370/0x540 sound/core/timer.c:1386
   snd_timer_notify1+0x1ad/0x350 sound/core/timer.c:516
   snd_timer_start1+0x53d/0x640 sound/core/timer.c:578
   snd_timer_start sound/core/timer.c:696 [inline]
   snd_timer_user_start sound/core/timer.c:1984 [inline]
   __snd_timer_user_ioctl+0xb56/0x5920 sound/core/timer.c:2107
   snd_timer_user_ioctl+0x5d/0x80 sound/core/timer.c:2128
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:874 [inline]
   __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

-> (&f->f_owner.lock){...-}-{2:2} {
   IN-SOFTIRQ-R at:
                    lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
                    __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
                    _raw_read_lock_irqsave+0xd9/0x120 kernel/locking/spinlock.c:236
                    send_sigurg+0x25/0x360 fs/fcntl.c:835
                    sk_send_sigurg+0x6a/0xb0 net/core/sock.c:3172
                    tcp_check_urg net/ipv4/tcp_input.c:5567 [inline]
                    tcp_urg+0x2b6/0xb40 net/ipv4/tcp_input.c:5608
                    tcp_rcv_state_process+0x16b9/0x2410 net/ipv4/tcp_input.c:6575
                    tcp_v4_do_rcv+0x68c/0xa10 net/ipv4/tcp_ipv4.c:1741
                    tcp_v4_rcv+0x39db/0x4890 net/ipv4/tcp_ipv4.c:2113
                    ip_protocol_deliver_rcu+0x1ed/0x3b0 net/ipv4/ip_input.c:204
                    ip_local_deliver_finish net/ipv4/ip_input.c:231 [inline]
                    NF_HOOK include/linux/netfilter.h:307 [inline]
                    ip_local_deliver+0x316/0x490 net/ipv4/ip_input.c:252
                    __netif_receive_skb_one_core net/core/dev.c:5465 [inline]
                    __netif_receive_skb+0x1d1/0x500 net/core/dev.c:5579
                    process_backlog+0x518/0x9a0 net/core/dev.c:6455
                    __napi_poll+0xbd/0x520 net/core/dev.c:7023
                    napi_poll net/core/dev.c:7090 [inline]
                    net_rx_action+0x61c/0xf30 net/core/dev.c:7177
                    __do_softirq+0x392/0x7a3 kernel/softirq.c:558
                    run_ksoftirqd+0xc1/0x120 kernel/softirq.c:921
                    smpboot_thread_fn+0x533/0x9d0 kernel/smpboot.c:164
                    kthread+0x468/0x490 kernel/kthread.c:327
                    ret_from_fork+0x1f/0x30
   INITIAL USE at:
                   lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:194 [inline]
                   _raw_write_lock_irq+0xcf/0x110 kernel/locking/spinlock.c:316
                   f_modown+0x38/0x340 fs/fcntl.c:91
                   __f_setown fs/fcntl.c:110 [inline]
                   f_setown+0x113/0x1a0 fs/fcntl.c:138
                   do_fcntl+0x1a8/0x1560 fs/fcntl.c:393
                   __do_sys_fcntl fs/fcntl.c:472 [inline]
                   __se_sys_fcntl+0xd8/0x1b0 fs/fcntl.c:457
                   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                   do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
                   entry_SYSCALL_64_after_hwframe+0x44/0xae
   INITIAL READ USE at:
                        lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
                        __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
                        _raw_read_lock_irqsave+0xd9/0x120 kernel/locking/spinlock.c:236
                        send_sigio+0x2f/0x300 fs/fcntl.c:796
                        kill_fasync_rcu fs/fcntl.c:1021 [inline]
                        kill_fasync+0x1e4/0x430 fs/fcntl.c:1035
                        snd_timer_user_ccallback+0x370/0x540 sound/core/timer.c:1386
                        snd_timer_notify1+0x1ad/0x350 sound/core/timer.c:516
                        snd_timer_start1+0x53d/0x640 sound/core/timer.c:578
                        snd_timer_start sound/core/timer.c:696 [inline]
                        snd_timer_user_start sound/core/timer.c:1984 [inline]
                        __snd_timer_user_ioctl+0xb56/0x5920 sound/core/timer.c:2107
                        snd_timer_user_ioctl+0x5d/0x80 sound/core/timer.c:2128
                        vfs_ioctl fs/ioctl.c:51 [inline]
                        __do_sys_ioctl fs/ioctl.c:874 [inline]
                        __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
                        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                        do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
                        entry_SYSCALL_64_after_hwframe+0x44/0xae
 }
 ... key      at: [<ffffffff90c84e80>] __alloc_file.__key+0x0/0x10
 ... acquired at:
   lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
   _raw_read_lock_irqsave+0xd9/0x120 kernel/locking/spinlock.c:236
   send_sigio+0x2f/0x300 fs/fcntl.c:796
   kill_fasync_rcu fs/fcntl.c:1021 [inline]
   kill_fasync+0x1e4/0x430 fs/fcntl.c:1035
   snd_timer_user_ccallback+0x370/0x540 sound/core/timer.c:1386
   snd_timer_notify1+0x1ad/0x350 sound/core/timer.c:516
   snd_timer_start1+0x53d/0x640 sound/core/timer.c:578
   snd_timer_start sound/core/timer.c:696 [inline]
   snd_timer_user_start sound/core/timer.c:1984 [inline]
   __snd_timer_user_ioctl+0xb56/0x5920 sound/core/timer.c:2107
   snd_timer_user_ioctl+0x5d/0x80 sound/core/timer.c:2128
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:874 [inline]
   __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae


the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (tasklist_lock){.+.+}-{2:2} {
   HARDIRQ-ON-R at:
                    lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
                    __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                    _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
                    do_wait+0x224/0x9d0 kernel/exit.c:1511
                    kernel_wait+0xe4/0x230 kernel/exit.c:1701
                    call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                    call_usermodehelper_exec_work+0xb4/0x220 kernel/umh.c:166
                    process_one_work+0x853/0x1140 kernel/workqueue.c:2298
                    worker_thread+0xac1/0x1320 kernel/workqueue.c:2445
                    kthread+0x468/0x490 kernel/kthread.c:327
                    ret_from_fork+0x1f/0x30
   SOFTIRQ-ON-R at:
                    lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
                    __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                    _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
                    do_wait+0x224/0x9d0 kernel/exit.c:1511
                    kernel_wait+0xe4/0x230 kernel/exit.c:1701
                    call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                    call_usermodehelper_exec_work+0xb4/0x220 kernel/umh.c:166
                    process_one_work+0x853/0x1140 kernel/workqueue.c:2298
                    worker_thread+0xac1/0x1320 kernel/workqueue.c:2445
                    kthread+0x468/0x490 kernel/kthread.c:327
                    ret_from_fork+0x1f/0x30
   INITIAL USE at:
                   lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:194 [inline]
                   _raw_write_lock_irq+0xcf/0x110 kernel/locking/spinlock.c:316
                   copy_process+0x34bf/0x5ca0 kernel/fork.c:2311
                   kernel_clone+0x22a/0x7e0 kernel/fork.c:2582
                   kernel_thread+0x155/0x1d0 kernel/fork.c:2634
                   rest_init+0x21/0x2e0 init/main.c:690
                   start_kernel+0x4bf/0x56e init/main.c:1135
                   secondary_startup_64_no_verify+0xb1/0xbb
   INITIAL READ USE at:
                        lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
                        __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                        _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
                        do_wait+0x224/0x9d0 kernel/exit.c:1511
                        kernel_wait+0xe4/0x230 kernel/exit.c:1701
                        call_usermodehelper_exec_sync kernel/umh.c:139 [inline]
                        call_usermodehelper_exec_work+0xb4/0x220 kernel/umh.c:166
                        process_one_work+0x853/0x1140 kernel/workqueue.c:2298
                        worker_thread+0xac1/0x1320 kernel/workqueue.c:2445
                        kthread+0x468/0x490 kernel/kthread.c:327
                        ret_from_fork+0x1f/0x30
 }
 ... key      at: [<ffffffff8c80a058>] tasklist_lock+0x18/0x40
 ... acquired at:
   lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
   send_sigio+0xbe/0x300 fs/fcntl.c:810
   dnotify_handle_event+0x136/0x450 fs/notify/dnotify/dnotify.c:97
   fsnotify_handle_event fs/notify/fsnotify.c:313 [inline]
   send_to_group+0x9a1/0xdd0 fs/notify/fsnotify.c:367
   fsnotify+0xa65/0x1370 fs/notify/fsnotify.c:543
   fsnotify_name include/linux/fsnotify.h:36 [inline]
   fsnotify_dirent include/linux/fsnotify.h:42 [inline]
   fsnotify_create include/linux/fsnotify.h:204 [inline]
   open_last_lookups fs/namei.c:3352 [inline]
   path_openat+0x1598/0x3660 fs/namei.c:3556
   do_filp_open+0x277/0x4f0 fs/namei.c:3586
   do_sys_openat2+0x13b/0x500 fs/open.c:1212
   do_sys_open fs/open.c:1228 [inline]
   __do_sys_creat fs/open.c:1304 [inline]
   __se_sys_creat fs/open.c:1298 [inline]
   __x64_sys_creat+0x11f/0x160 fs/open.c:1298
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae


stack backtrace:
CPU: 1 PID: 12930 Comm: syz-executor.2 Not tainted 5.16.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 print_bad_irq_dependency kernel/locking/lockdep.c:2577 [inline]
 check_irq_usage kernel/locking/lockdep.c:2816 [inline]
 check_prev_add kernel/locking/lockdep.c:3067 [inline]
 check_prevs_add kernel/locking/lockdep.c:3186 [inline]
 validate_chain+0x6f4c/0x8240 kernel/locking/lockdep.c:3801
 __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5027
 lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
 __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
 _raw_read_lock+0x32/0x40 kernel/locking/spinlock.c:228
 send_sigio+0xbe/0x300 fs/fcntl.c:810
 dnotify_handle_event+0x136/0x450 fs/notify/dnotify/dnotify.c:97
 fsnotify_handle_event fs/notify/fsnotify.c:313 [inline]
 send_to_group+0x9a1/0xdd0 fs/notify/fsnotify.c:367
 fsnotify+0xa65/0x1370 fs/notify/fsnotify.c:543
 fsnotify_name include/linux/fsnotify.h:36 [inline]
 fsnotify_dirent include/linux/fsnotify.h:42 [inline]
 fsnotify_create include/linux/fsnotify.h:204 [inline]
 open_last_lookups fs/namei.c:3352 [inline]
 path_openat+0x1598/0x3660 fs/namei.c:3556
 do_filp_open+0x277/0x4f0 fs/namei.c:3586
 do_sys_openat2+0x13b/0x500 fs/open.c:1212
 do_sys_open fs/open.c:1228 [inline]
 __do_sys_creat fs/open.c:1304 [inline]
 __se_sys_creat fs/open.c:1298 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1298
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fbb4226fe99
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbb40be5168 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fbb42382f60 RCX: 00007fbb4226fe99
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007fbb422c9ff1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd3f2a44cf R14: 00007fbb40be5300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
