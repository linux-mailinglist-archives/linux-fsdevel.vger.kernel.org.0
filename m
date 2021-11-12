Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BDD44ECFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 19:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhKLTBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 14:01:21 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:39724 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhKLTBS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 14:01:18 -0500
Received: by mail-io1-f72.google.com with SMTP id r15-20020a6b600f000000b005dde03edc0cso6964220iog.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Nov 2021 10:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JsWX/VgXc74R1LHCljoCinrhSuBWjRZqepgnNTzcFuQ=;
        b=obSNFPAELArZi1H4Q1KrtsIfU9Wc1gaDrQ+TrUQ7cdHy9AGGRIr27ZwtMaiYfQ1cT7
         QEEuCECUDep1la91ZpCcfrVMGa3YtwkyMNqGKE1J/M66ias7JP0hN3+UG16jD55gCZKW
         KeQPRJeJpxlqhDfHoY8UOuOu4fYctoTkMGgCLa1YTPNElpiYy9mPp23DexXKaDvuNDj3
         ecSBz4mQJ5iC0CyNrvL7wIJjcb+l9R87o1s0wga8T2Km5h/b0I7k9fXJmbeyJFrUKjAM
         A71gX4nQ2ywpTmPZQggC9wh0/wKvKZVJo6MnVYrfOvsIe7yPBXN85xN4s3FUKXZxDF+w
         ixiA==
X-Gm-Message-State: AOAM5329HVv8C/S09SlqCEl94rqwPP5bvWOSusGEIfQd3mugFT3urSH6
        GOqipNlzp1Qos6VikEa2VotZBpN7SHHXOnXs6n9JhOUyR1DX
X-Google-Smtp-Source: ABdhPJz/NqFXOUdeF4XOG0CRdeWhD7za3OHfnCYaPbqjw3zECyufEaccw4Z9niJoFhqFokGTJTRBRfwjTGL6oMQR37uDDmLLJXqX
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24c6:: with SMTP id y6mr13780143jat.98.1636743507080;
 Fri, 12 Nov 2021 10:58:27 -0800 (PST)
Date:   Fri, 12 Nov 2021 10:58:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053fc0905d09c0b00@google.com>
Subject: [syzbot] possible deadlock in snd_timer_notify (2)
From:   syzbot <syzbot+49b10793b867871ee26f@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    debe436e77c7 Merge tag 'ext4_for_linus' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1060c32ab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7259f0deb293aa
dashboard link: https://syzkaller.appspot.com/bug?extid=49b10793b867871ee26f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+49b10793b867871ee26f@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
5.15.0-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.0/15830 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff888076cbade0 (&new->fa_lock){...-}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1014 [inline]
ffff888076cbade0 (&new->fa_lock){...-}-{2:2}, at: kill_fasync fs/fcntl.c:1035 [inline]
ffff888076cbade0 (&new->fa_lock){...-}-{2:2}, at: kill_fasync+0x136/0x470 fs/fcntl.c:1028

and this task is already holding:
ffff88802171d948 (&timer->lock){..-.}-{2:2}, at: snd_timer_start1+0x5a/0x800 sound/core/timer.c:541
which would create a new lock dependency:
 (&timer->lock){..-.}-{2:2} -> (&new->fa_lock){...-}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&timer->lock){..-.}-{2:2}

... which became SOFTIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5637 [inline]
  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
  snd_timer_notify sound/core/timer.c:1087 [inline]
  snd_timer_notify+0x10c/0x3d0 sound/core/timer.c:1074
  snd_pcm_timer_notify sound/core/pcm_native.c:595 [inline]
  snd_pcm_post_stop+0x195/0x1f0 sound/core/pcm_native.c:1453
  snd_pcm_action_single sound/core/pcm_native.c:1229 [inline]
  snd_pcm_drain_done+0xdc/0x120 sound/core/pcm_native.c:1491
  snd_pcm_update_state+0x43b/0x540 sound/core/pcm_lib.c:191
  snd_pcm_update_hw_ptr0+0xa75/0x1a50 sound/core/pcm_lib.c:465
  snd_pcm_period_elapsed_under_stream_lock+0x15a/0x230 sound/core/pcm_lib.c:1817
  snd_pcm_period_elapsed+0x28/0x50 sound/core/pcm_lib.c:1849
  dummy_hrtimer_callback+0x94/0x1b0 sound/drivers/dummy.c:377
  __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
  __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1749
  hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1766
  __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
  invoke_softirq kernel/softirq.c:432 [inline]
  __irq_exit_rcu+0x123/0x180 kernel/softirq.c:636
  irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
  __memset+0x24/0x30 arch/x86/lib/memset_64.S:38
  slab_post_alloc_hook mm/slab.h:521 [inline]
  slab_alloc_node mm/slub.c:3234 [inline]
  slab_alloc mm/slub.c:3242 [inline]
  kmem_cache_alloc_trace+0x20b/0x2c0 mm/slub.c:3259
  kmalloc include/linux/slab.h:590 [inline]
  pty_common_install+0xd4/0xa70 drivers/tty/pty.c:381
  tty_driver_install_tty drivers/tty/tty_io.c:1315 [inline]
  tty_init_dev.part.0+0x9e/0x610 drivers/tty/tty_io.c:1429
  tty_init_dev+0x5b/0x80 drivers/tty/tty_io.c:1419
  ptmx_open drivers/tty/pty.c:834 [inline]
  ptmx_open+0x112/0x360 drivers/tty/pty.c:800
  chrdev_open+0x266/0x770 fs/char_dev.c:414
  do_dentry_open+0x4c8/0x1250 fs/open.c:822
  do_open fs/namei.c:3426 [inline]
  path_openat+0x1cad/0x2750 fs/namei.c:3559
  do_filp_open+0x1aa/0x400 fs/namei.c:3586
  do_sys_openat2+0x16d/0x4d0 fs/open.c:1212
  do_sys_open fs/open.c:1228 [inline]
  __do_sys_openat fs/open.c:1244 [inline]
  __se_sys_openat fs/open.c:1239 [inline]
  __x64_sys_openat+0x13f/0x1f0 fs/open.c:1239
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

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

3 locks held by syz-executor.0/15830:
 #0: ffff88807bd80168 (&tu->ioctl_lock){+.+.}-{3:3}, at: snd_timer_user_ioctl+0x4c/0xb0 sound/core/timer.c:2128
 #1: ffff88802171d948 (&timer->lock){..-.}-{2:2}, at: snd_timer_start1+0x5a/0x800 sound/core/timer.c:541
 #2: ffffffff8b983a20 (rcu_read_lock){....}-{1:2}, at: kill_fasync+0x41/0x470 fs/fcntl.c:1033

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (&timer->lock){..-.}-{2:2} {
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5637 [inline]
                    lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
                    snd_timer_notify sound/core/timer.c:1087 [inline]
                    snd_timer_notify+0x10c/0x3d0 sound/core/timer.c:1074
                    snd_pcm_timer_notify sound/core/pcm_native.c:595 [inline]
                    snd_pcm_post_stop+0x195/0x1f0 sound/core/pcm_native.c:1453
                    snd_pcm_action_single sound/core/pcm_native.c:1229 [inline]
                    snd_pcm_drain_done+0xdc/0x120 sound/core/pcm_native.c:1491
                    snd_pcm_update_state+0x43b/0x540 sound/core/pcm_lib.c:191
                    snd_pcm_update_hw_ptr0+0xa75/0x1a50 sound/core/pcm_lib.c:465
                    snd_pcm_period_elapsed_under_stream_lock+0x15a/0x230 sound/core/pcm_lib.c:1817
                    snd_pcm_period_elapsed+0x28/0x50 sound/core/pcm_lib.c:1849
                    dummy_hrtimer_callback+0x94/0x1b0 sound/drivers/dummy.c:377
                    __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
                    __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1749
                    hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1766
                    __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
                    invoke_softirq kernel/softirq.c:432 [inline]
                    __irq_exit_rcu+0x123/0x180 kernel/softirq.c:636
                    irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
                    sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
                    asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
                    __memset+0x24/0x30 arch/x86/lib/memset_64.S:38
                    slab_post_alloc_hook mm/slab.h:521 [inline]
                    slab_alloc_node mm/slub.c:3234 [inline]
                    slab_alloc mm/slub.c:3242 [inline]
                    kmem_cache_alloc_trace+0x20b/0x2c0 mm/slub.c:3259
                    kmalloc include/linux/slab.h:590 [inline]
                    pty_common_install+0xd4/0xa70 drivers/tty/pty.c:381
                    tty_driver_install_tty drivers/tty/tty_io.c:1315 [inline]
                    tty_init_dev.part.0+0x9e/0x610 drivers/tty/tty_io.c:1429
                    tty_init_dev+0x5b/0x80 drivers/tty/tty_io.c:1419
                    ptmx_open drivers/tty/pty.c:834 [inline]
                    ptmx_open+0x112/0x360 drivers/tty/pty.c:800
                    chrdev_open+0x266/0x770 fs/char_dev.c:414
                    do_dentry_open+0x4c8/0x1250 fs/open.c:822
                    do_open fs/namei.c:3426 [inline]
                    path_openat+0x1cad/0x2750 fs/namei.c:3559
                    do_filp_open+0x1aa/0x400 fs/namei.c:3586
                    do_sys_openat2+0x16d/0x4d0 fs/open.c:1212
                    do_sys_open fs/open.c:1228 [inline]
                    __do_sys_openat fs/open.c:1244 [inline]
                    __se_sys_openat fs/open.c:1239 [inline]
                    __x64_sys_openat+0x13f/0x1f0 fs/open.c:1239
                    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                    do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                    entry_SYSCALL_64_after_hwframe+0x44/0xae
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5637 [inline]
                   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   _raw_spin_lock_irq+0x32/0x50 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:374 [inline]
                   snd_timer_close_locked+0x63/0xbb0 sound/core/timer.c:396
                   snd_timer_close+0x87/0xf0 sound/core/timer.c:463
                   snd_seq_timer_close+0x8c/0xe0 sound/core/seq/seq_timer.c:326
                   queue_delete+0x4a/0xa0 sound/core/seq/seq_queue.c:134
                   snd_seq_queue_delete+0x45/0x60 sound/core/seq/seq_queue.c:196
                   snd_seq_kernel_client_ctl+0x102/0x1e0 sound/core/seq/seq_clientmgr.c:2369
                   delete_seq_queue.part.0.isra.0+0xa2/0x110 sound/core/seq/oss/seq_oss_init.c:377
                   delete_seq_queue sound/core/seq/oss/seq_oss_init.c:373 [inline]
                   snd_seq_oss_release+0x10b/0x1a0 sound/core/seq/oss/seq_oss_init.c:422
                   odev_release+0x4f/0x70 sound/core/seq/oss/seq_oss.c:144
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
 ... key      at: [<ffffffff9061a800>] __key.12+0x0/0x40

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
                       copy_process+0x36c0/0x75a0 kernel/fork.c:2310
                       kernel_clone+0xe7/0xab0 kernel/fork.c:2581
                       kernel_thread+0xb5/0xf0 kernel/fork.c:2633
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
   ... key      at: [<ffffffff8b60a098>] tasklist_lock+0x18/0x40
   ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x5b/0x70 kernel/locking/spinlock.c:228
   send_sigio+0xab/0x380 fs/fcntl.c:810
   kill_fasync_rcu fs/fcntl.c:1021 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
   __receive_buf drivers/tty/n_tty.c:1591 [inline]
   n_tty_receive_buf_common+0x12d7/0x4780 drivers/tty/n_tty.c:1674
   tty_ldisc_receive_buf+0xa3/0x190 drivers/tty/tty_buffer.c:471
   paste_selection+0x1de/0x4c0 drivers/tty/vt/selection.c:408
   tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3204
   vt_ioctl+0x229a/0x2b10 drivers/tty/vt/vt_ioctl.c:762
   tty_ioctl+0xbbd/0x1670 drivers/tty/tty_io.c:2805
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
                      send_sigurg+0x1e/0xaf0 fs/fcntl.c:835
                      sk_send_sigurg+0x76/0x310 net/core/sock.c:3172
                      tcp_check_urg.isra.0+0x1f3/0x710 net/ipv4/tcp_input.c:5567
                      tcp_urg net/ipv4/tcp_input.c:5608 [inline]
                      tcp_rcv_established+0x12ab/0x2130 net/ipv4/tcp_input.c:5942
                      tcp_v6_do_rcv+0x461/0x1320 net/ipv6/tcp_ipv6.c:1522
                      tcp_v6_rcv+0x236d/0x2cb0 net/ipv6/tcp_ipv6.c:1765
                      ip6_protocol_deliver_rcu+0x2e9/0x1ca0 net/ipv6/ip6_input.c:422
                      ip6_input_finish+0x62/0x170 net/ipv6/ip6_input.c:463
                      NF_HOOK include/linux/netfilter.h:307 [inline]
                      NF_HOOK include/linux/netfilter.h:301 [inline]
                      ip6_input+0x9c/0xd0 net/ipv6/ip6_input.c:472
                      dst_input include/net/dst.h:460 [inline]
                      ip6_rcv_finish net/ipv6/ip6_input.c:76 [inline]
                      NF_HOOK include/linux/netfilter.h:307 [inline]
                      NF_HOOK include/linux/netfilter.h:301 [inline]
                      ipv6_rcv+0x28c/0x3c0 net/ipv6/ip6_input.c:297
                      __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5462
                      __netif_receive_skb+0x24/0x1b0 net/core/dev.c:5576
                      process_backlog+0x2a5/0x6c0 net/core/dev.c:6452
                      __napi_poll+0xaf/0x440 net/core/dev.c:7017
                      napi_poll net/core/dev.c:7084 [inline]
                      net_rx_action+0x801/0xb40 net/core/dev.c:7171
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
                          __raw_read_lock_irq include/linux/rwlock_api_smp.h:168 [inline]
                          _raw_read_lock_irq+0x63/0x80 kernel/locking/spinlock.c:244
                          f_getown+0x23/0x2a0 fs/fcntl.c:154
                          do_fcntl+0xbd8/0x1210 fs/fcntl.c:389
                          __do_sys_fcntl fs/fcntl.c:472 [inline]
                          __se_sys_fcntl fs/fcntl.c:457 [inline]
                          __x64_sys_fcntl+0x165/0x1e0 fs/fcntl.c:457
                          do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                          do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                          entry_SYSCALL_64_after_hwframe+0x44/0xae
  }
  ... key      at: [<ffffffff9031bde0>] __key.5+0x0/0x40
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
                    sock_def_readable+0x349/0x4e0 net/core/sock.c:3138
                    tcp_data_ready+0x106/0x540 net/ipv4/tcp_input.c:4977
                    tcp_data_queue+0x23c7/0x4b90 net/ipv4/tcp_input.c:5047
                    tcp_rcv_established+0x8ad/0x2130 net/ipv4/tcp_input.c:5945
                    tcp_v4_do_rcv+0x600/0x8d0 net/ipv4/tcp_ipv4.c:1716
                    tcp_v4_rcv+0x2768/0x3080 net/ipv4/tcp_ipv4.c:2110
                    ip_protocol_deliver_rcu+0xa7/0xee0 net/ipv4/ip_input.c:204
                    ip_local_deliver_finish+0x20a/0x370 net/ipv4/ip_input.c:231
                    NF_HOOK include/linux/netfilter.h:307 [inline]
                    NF_HOOK include/linux/netfilter.h:301 [inline]
                    ip_local_deliver+0x1b3/0x200 net/ipv4/ip_input.c:252
                    dst_input include/net/dst.h:460 [inline]
                    ip_rcv_finish+0x1da/0x2f0 net/ipv4/ip_input.c:429
                    NF_HOOK include/linux/netfilter.h:307 [inline]
                    NF_HOOK include/linux/netfilter.h:301 [inline]
                    ip_rcv+0xaa/0xd0 net/ipv4/ip_input.c:540
                    __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5462
                    __netif_receive_skb+0x24/0x1b0 net/core/dev.c:5576
                    process_backlog+0x2a5/0x6c0 net/core/dev.c:6452
                    __napi_poll+0xaf/0x440 net/core/dev.c:7017
                    napi_poll net/core/dev.c:7084 [inline]
                    net_rx_action+0x801/0xb40 net/core/dev.c:7171
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
                   fasync_insert_entry+0x1d8/0x2b0 fs/fcntl.c:938
                   lease_setup+0x9d/0x160 fs/locks.c:492
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
 ... key      at: [<ffffffff9031cbc0>] __key.0+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5637 [inline]
   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1014 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x136/0x470 fs/fcntl.c:1028
   snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1387
   snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
   snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
   snd_timer_start sound/core/timer.c:697 [inline]
   snd_timer_start sound/core/timer.c:690 [inline]
   snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1985
   __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2108
   snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2129
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:874 [inline]
   __se_sys_ioctl fs/ioctl.c:860 [inline]
   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae


stack backtrace:
CPU: 0 PID: 15830 Comm: syz-executor.0 Not tainted 5.15.0-syzkaller #0
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
 __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
 _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
 kill_fasync_rcu fs/fcntl.c:1014 [inline]
 kill_fasync fs/fcntl.c:1035 [inline]
 kill_fasync+0x136/0x470 fs/fcntl.c:1028
 snd_timer_user_ccallback+0x298/0x330 sound/core/timer.c:1387
 snd_timer_notify1+0x11c/0x3b0 sound/core/timer.c:516
 snd_timer_start1+0x4d4/0x800 sound/core/timer.c:578
 snd_timer_start sound/core/timer.c:697 [inline]
 snd_timer_start sound/core/timer.c:690 [inline]
 snd_timer_user_start.isra.0+0x1e3/0x260 sound/core/timer.c:1985
 __snd_timer_user_ioctl.isra.0+0xda8/0x2490 sound/core/timer.c:2108
 snd_timer_user_ioctl+0x77/0xb0 sound/core/timer.c:2129
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fbbeece0ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbbec214188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbbeedf40e0 RCX: 00007fbbeece0ae9
RDX: 0000000000000000 RSI: 00000000000054a0 RDI: 0000000000000003
RBP: 00007fbbeed3af6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd7ce4e5ff R14: 00007fbbec214300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
