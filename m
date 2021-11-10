Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D42244C59D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 18:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhKJREL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 12:04:11 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:54973 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbhKJREK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:04:10 -0500
Received: by mail-io1-f69.google.com with SMTP id s8-20020a056602168800b005e96bba1363so267605iow.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 09:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BK0XFV5lYn4tvbeJMTdxuU2AINW1usRfkmqy6hs7p4k=;
        b=vYOwIrT63ThTnTXZoxOOnKekH0EilEJDp2nQRGPDllnNnKCNO4NyTW20wdbIyU5DTW
         W64O8q4Zs+12lsKxiD+pX9wKYDqKX2V6J86aM7EX7hr4Wvb5o8vnlR6LANBgBux5QZEX
         b3rP5lBauwU9bfU4/avvksOhUR/Aeu4TyCUttYpQia5m6cf1abDI6HgIpcycYE6ej56P
         +ko6ZJGTe4oEKPO/Tb/JUSgcWGSOXfEfOr/vMXgopJiyXho/O+6W9SfTVCtUFr44Sn4z
         O6CWN9kEu8d5Y6oC3bbH4EOE7rE5sEOPsQbSEwe5z1dfl+kwsYhLfrabirUkyrh5ADda
         cZhw==
X-Gm-Message-State: AOAM531VKn0k79BjFsO11Dr7bj4d7qHUWeAcoSk5ibYmvnSdLFPb7q3u
        N2+0Reu7noKvFl4GMDMlKFbUcRRXnQqvzRao4cCrGO8G379m
X-Google-Smtp-Source: ABdhPJwtXgp521JwQHEDHJSomg47LRj4guOr0WtBScqPnP2gQL5ug5tRbYCmAWGmc1I0Ib3AK5q/B+BgvTv5kXw4IAyWqzFszo8t
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:547:: with SMTP id i7mr334549ils.298.1636563682304;
 Wed, 10 Nov 2021 09:01:22 -0800 (PST)
Date:   Wed, 10 Nov 2021 09:01:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000efaa3905d0722c58@google.com>
Subject: [syzbot] possible deadlock in snd_hrtimer_callback (2)
From:   syzbot <syzbot+8285e973a41b5aa68902@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cb690f5238d7 Merge tag 'for-5.16/drivers-2021-11-09' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f805c1b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7259f0deb293aa
dashboard link: https://syzkaller.appspot.com/bug?extid=8285e973a41b5aa68902
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8285e973a41b5aa68902@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
5.15.0-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.0/30191 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff88801d373168 (&new->fa_lock){...-}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1014 [inline]
ffff88801d373168 (&new->fa_lock){...-}-{2:2}, at: kill_fasync fs/fcntl.c:1035 [inline]
ffff88801d373168 (&new->fa_lock){...-}-{2:2}, at: kill_fasync+0x136/0x470 fs/fcntl.c:1028

and this task is already holding:
ffff888021a2d148 (&timer->lock){-.-.}-{2:2}, at: snd_timer_start1+0x5a/0x800 sound/core/timer.c:541
which would create a new lock dependency:
 (&timer->lock){-.-.}-{2:2} -> (&new->fa_lock){...-}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&timer->lock){-.-.}-{2:2}

... which became HARDIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5637 [inline]
  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:349 [inline]
  snd_hrtimer_callback+0x4f/0x3c0 sound/core/hrtimer.c:38
  __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
  __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1749
  hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
  __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1103
  sysvec_apic_timer_interrupt+0x40/0xc0 arch/x86/kernel/apic/apic.c:1097
  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638

to a HARDIRQ-irq-unsafe lock:
 (tasklist_lock){.+.?}-{2:2}

... which became HARDIRQ-irq-unsafe at:
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

3 locks held by syz-executor.0/30191:
 #0: ffff88801ca04d68 (&tu->ioctl_lock){+.+.}-{3:3}, at: snd_timer_user_ioctl+0x4c/0xb0 sound/core/timer.c:2128
 #1: ffff888021a2d148 (&timer->lock){-.-.}-{2:2}, at: snd_timer_start1+0x5a/0x800 sound/core/timer.c:541
 #2: ffffffff8b983a20 (rcu_read_lock){....}-{1:2}, at: kill_fasync+0x41/0x470 fs/fcntl.c:1033

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&timer->lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5637 [inline]
                    lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:349 [inline]
                    snd_hrtimer_callback+0x4f/0x3c0 sound/core/hrtimer.c:38
                    __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
                    __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1749
                    hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
                    local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
                    __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1103
                    sysvec_apic_timer_interrupt+0x40/0xc0 arch/x86/kernel/apic/apic.c:1097
                    asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5637 [inline]
                    lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:349 [inline]
                    snd_hrtimer_callback+0x4f/0x3c0 sound/core/hrtimer.c:38
                    __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
                    __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1749
                    hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
                    local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
                    __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1103
                    sysvec_apic_timer_interrupt+0x40/0xc0 arch/x86/kernel/apic/apic.c:1097
                    asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
                    bpf_task_storage_free+0x1ea/0x400 kernel/bpf/bpf_task_storage.c:112
                    security_task_free+0x3e/0xe0 security/security.c:1656
                    __put_task_struct+0x128/0x400 kernel/fork.c:751
                    put_task_struct include/linux/sched/task.h:114 [inline]
                    delayed_put_task_struct+0x1f6/0x340 kernel/exit.c:174
                    rcu_do_batch kernel/rcu/tree.c:2506 [inline]
                    rcu_core+0x7ab/0x1470 kernel/rcu/tree.c:2741
                    __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
                    invoke_softirq kernel/softirq.c:432 [inline]
                    __irq_exit_rcu+0x123/0x180 kernel/softirq.c:636
                    irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
                    sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
                    asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
                    resched_offsets_ok kernel/sched/core.c:9488 [inline]
                    __might_resched+0x65/0x2c0 kernel/sched/core.c:9503
                    might_alloc include/linux/sched/mm.h:230 [inline]
                    slab_pre_alloc_hook mm/slab.h:492 [inline]
                    slab_alloc_node mm/slub.c:3148 [inline]
                    __kmalloc_node_track_caller+0x271/0x360 mm/slub.c:4956
                    kmalloc_reserve net/core/skbuff.c:354 [inline]
                    __alloc_skb+0xde/0x340 net/core/skbuff.c:426
                    alloc_skb include/linux/skbuff.h:1120 [inline]
                    netlink_alloc_large_skb net/netlink/af_netlink.c:1191 [inline]
                    netlink_sendmsg+0x967/0xda0 net/netlink/af_netlink.c:1891
                    sock_sendmsg_nosec net/socket.c:704 [inline]
                    sock_sendmsg+0xcf/0x120 net/socket.c:724
                    ____sys_sendmsg+0x331/0x810 net/socket.c:2409
                    ___sys_sendmsg+0xf3/0x170 net/socket.c:2463
                    __sys_sendmmsg+0x195/0x470 net/socket.c:2549
                    __do_sys_sendmmsg net/socket.c:2578 [inline]
                    __se_sys_sendmmsg net/socket.c:2575 [inline]
                    __x64_sys_sendmmsg+0x99/0x100 net/socket.c:2575
                    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                    do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                    entry_SYSCALL_64_after_hwframe+0x44/0xae
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5637 [inline]
                   lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   _raw_spin_lock_irq+0x32/0x50 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:374 [inline]
                   snd_pcm_detach_substream+0x16b/0x360 sound/core/pcm.c:995
                   snd_pcm_release_substream+0x57/0x70 sound/core/pcm_native.c:2635
                   snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2394 [inline]
                   snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2386 [inline]
                   snd_pcm_oss_release+0x171/0x300 sound/core/oss/pcm_oss.c:2573
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
 ... key      at: [<ffffffff90606780>] __key.12+0x0/0x40

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
  -> (tasklist_lock){.+.?}-{2:2} {
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
     IN-SOFTIRQ-R at:
                        lock_acquire kernel/locking/lockdep.c:5637 [inline]
                        lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
                        __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                        _raw_read_lock+0x36/0x70 kernel/locking/spinlock.c:228
                        send_sigurg+0xad/0xaf0 fs/fcntl.c:851
                        sk_send_sigurg+0x76/0x310 net/core/sock.c:3172
                        tcp_check_urg.isra.0+0x1f3/0x710 net/ipv4/tcp_input.c:5567
                        tcp_urg net/ipv4/tcp_input.c:5608 [inline]
                        tcp_rcv_established+0x12ab/0x2130 net/ipv4/tcp_input.c:5942
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
   sock_wake_async+0xd2/0x160 net/socket.c:1368
   sk_wake_async include/net/sock.h:2400 [inline]
   sk_wake_async+0x108/0x290 include/net/sock.h:2396
   tcp_rcv_state_process+0x32a0/0x4bd0 net/ipv4/tcp_input.c:6486
   tcp_v4_do_rcv+0x323/0x8d0 net/ipv4/tcp_ipv4.c:1738
   sk_backlog_rcv include/net/sock.h:1030 [inline]
   __release_sock+0x134/0x3b0 net/core/sock.c:2768
   release_sock+0x54/0x1b0 net/core/sock.c:3300
   inet_wait_for_connect net/ipv4/af_inet.c:593 [inline]
   __inet_stream_connect+0x5db/0xed0 net/ipv4/af_inet.c:685
   tcp_sendmsg_fastopen net/ipv4/tcp.c:1161 [inline]
   tcp_sendmsg_locked+0x2010/0x2c60 net/ipv4/tcp.c:1203
   tcp_sendmsg+0x2b/0x40 net/ipv4/tcp.c:1422
   inet_sendmsg+0x99/0xe0 net/ipv4/af_inet.c:819
   sock_sendmsg_nosec net/socket.c:704 [inline]
   sock_sendmsg+0xcf/0x120 net/socket.c:724
   __sys_sendto+0x21c/0x320 net/socket.c:2036
   __do_sys_sendto net/socket.c:2048 [inline]
   __se_sys_sendto net/socket.c:2044 [inline]
   __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2044
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
                          send_sigurg+0x1e/0xaf0 fs/fcntl.c:835
                          sk_send_sigurg+0x76/0x310 net/core/sock.c:3172
                          tcp_check_urg.isra.0+0x1f3/0x710 net/ipv4/tcp_input.c:5567
                          tcp_urg net/ipv4/tcp_input.c:5608 [inline]
                          tcp_rcv_established+0x12ab/0x2130 net/ipv4/tcp_input.c:5942
                          tcp_v4_do_rcv+0x600/0x8d0 net/ipv4/tcp_ipv4.c:1716
                          sk_backlog_rcv include/net/sock.h:1030 [inline]
                          __release_sock+0x134/0x3b0 net/core/sock.c:2768
                          release_sock+0x54/0x1b0 net/core/sock.c:3300
                          sk_stream_wait_memory+0x604/0xed0 net/core/stream.c:145
                          tcp_sendmsg_locked+0x7c1/0x2c60 net/ipv4/tcp.c:1384
                          tcp_sendmsg+0x2b/0x40 net/ipv4/tcp.c:1422
                          inet_sendmsg+0x99/0xe0 net/ipv4/af_inet.c:819
                          sock_sendmsg_nosec net/socket.c:704 [inline]
                          sock_sendmsg+0xcf/0x120 net/socket.c:724
                          __sys_sendto+0x21c/0x320 net/socket.c:2036
                          __do_sys_sendto net/socket.c:2048 [inline]
                          __se_sys_sendto net/socket.c:2044 [inline]
                          __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2044
                          do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                          do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                          entry_SYSCALL_64_after_hwframe+0x44/0xae
  }
  ... key      at: [<ffffffff90307de0>] __key.5+0x0/0x40
  ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:159 [inline]
   _raw_read_lock_irqsave+0x70/0x90 kernel/locking/spinlock.c:236
   send_sigio+0x24/0x380 fs/fcntl.c:796
   kill_fasync_rcu fs/fcntl.c:1021 [inline]
   kill_fasync fs/fcntl.c:1035 [inline]
   kill_fasync+0x1f8/0x470 fs/fcntl.c:1028
   sock_wake_async+0xd2/0x160 net/socket.c:1368
   sk_wake_async include/net/sock.h:2400 [inline]
   sk_wake_async+0x108/0x290 include/net/sock.h:2396
   tcp_rcv_state_process+0x32a0/0x4bd0 net/ipv4/tcp_input.c:6486
   tcp_v4_do_rcv+0x323/0x8d0 net/ipv4/tcp_ipv4.c:1738
   sk_backlog_rcv include/net/sock.h:1030 [inline]
   __release_sock+0x134/0x3b0 net/core/sock.c:2768
   release_sock+0x54/0x1b0 net/core/sock.c:3300
   inet_wait_for_connect net/ipv4/af_inet.c:593 [inline]
   __inet_stream_connect+0x5db/0xed0 net/ipv4/af_inet.c:685
   tcp_sendmsg_fastopen net/ipv4/tcp.c:1161 [inline]
   tcp_sendmsg_locked+0x2010/0x2c60 net/ipv4/tcp.c:1203
   tcp_sendmsg+0x2b/0x40 net/ipv4/tcp.c:1422
   inet_sendmsg+0x99/0xe0 net/ipv4/af_inet.c:819
   sock_sendmsg_nosec net/socket.c:704 [inline]
   sock_sendmsg+0xcf/0x120 net/socket.c:724
   __sys_sendto+0x21c/0x320 net/socket.c:2036
   __do_sys_sendto net/socket.c:2048 [inline]
   __se_sys_sendto net/socket.c:2044 [inline]
   __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2044
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
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
                    sock_wake_async+0xf1/0x160 net/socket.c:1371
                    sk_wake_async include/net/sock.h:2400 [inline]
                    sk_wake_async include/net/sock.h:2396 [inline]
                    sk_send_sigurg net/core/sock.c:3173 [inline]
                    sk_send_sigurg+0x17c/0x310 net/core/sock.c:3169
                    tcp_check_urg.isra.0+0x1f3/0x710 net/ipv4/tcp_input.c:5567
                    tcp_urg net/ipv4/tcp_input.c:5608 [inline]
                    tcp_rcv_established+0x12ab/0x2130 net/ipv4/tcp_input.c:5942
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
                        sock_wake_async+0xd2/0x160 net/socket.c:1368
                        sk_wake_async include/net/sock.h:2400 [inline]
                        sk_wake_async+0x108/0x290 include/net/sock.h:2396
                        tcp_rcv_state_process+0x32a0/0x4bd0 net/ipv4/tcp_input.c:6486
                        tcp_v4_do_rcv+0x323/0x8d0 net/ipv4/tcp_ipv4.c:1738
                        sk_backlog_rcv include/net/sock.h:1030 [inline]
                        __release_sock+0x134/0x3b0 net/core/sock.c:2768
                        release_sock+0x54/0x1b0 net/core/sock.c:3300
                        inet_wait_for_connect net/ipv4/af_inet.c:593 [inline]
                        __inet_stream_connect+0x5db/0xed0 net/ipv4/af_inet.c:685
                        tcp_sendmsg_fastopen net/ipv4/tcp.c:1161 [inline]
                        tcp_sendmsg_locked+0x2010/0x2c60 net/ipv4/tcp.c:1203
                        tcp_sendmsg+0x2b/0x40 net/ipv4/tcp.c:1422
                        inet_sendmsg+0x99/0xe0 net/ipv4/af_inet.c:819
                        sock_sendmsg_nosec net/socket.c:704 [inline]
                        sock_sendmsg+0xcf/0x120 net/socket.c:724
                        __sys_sendto+0x21c/0x320 net/socket.c:2036
                        __do_sys_sendto net/socket.c:2048 [inline]
                        __se_sys_sendto net/socket.c:2044 [inline]
                        __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2044
                        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                        do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
                        entry_SYSCALL_64_after_hwframe+0x44/0xae
 }
 ... key      at: [<ffffffff90308bc0>] __key.0+0x0/0x40
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
CPU: 1 PID: 30191 Comm: syz-executor.0 Not tainted 5.15.0-syzkaller #0
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
RIP: 0033:0x7f23cf480ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f23cc9f6188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f23cf593f60 RCX: 00007f23cf480ae9
RDX: 0000000000000000 RSI: 00000000000054a0 RDI: 0000000000000003
RBP: 00007f23cf4daf6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f23cfac7b2f R14: 00007f23cc9f6300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
