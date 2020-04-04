Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B59419E30D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Apr 2020 07:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDDFzP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Apr 2020 01:55:15 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:40299 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgDDFzP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Apr 2020 01:55:15 -0400
Received: by mail-il1-f200.google.com with SMTP id g79so9337997ild.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2020 22:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9AMQArMuO93J/CpN0Qc3E0byB9kG+Ic8o1NP1LGYUQw=;
        b=hg8Hbl03cMCBVeC1T2/u6q5oZRQ5+31/+msWVt/x9Wg8OvB/K4f1tUVXUXIVDC/G1K
         Un96WHklOZ2+bgx30vCGwYZ69+5VJ1FBKEcXO9SfTXZScC3yBbIMkzW/Gy9IZXjUkODU
         leYO4r7CuKyrRO96z0vXKBpJzvU01ySiZR0toHgaTZWelm7x98ESfKERUt7TGqDhjUGG
         HkX7Wqc/NPxzJy5a0KzBnC8eLP6o3TbpxmjC13CX4SDZPDtGAuwILO46UesxE6Q9bget
         5QvuPHAzZrvKOSlmqV08TS2CS/hJ1WK5cVd5kGCi+sCZV2il/VhbP5Ng66qUvUba/WBq
         msng==
X-Gm-Message-State: AGi0PuZJvs49XQTMh4pRxZjb5o1Rk4lYeJKZps6tFj61/fW7Q7E1mMn7
        xHdQhPst0puElVOfr7eIwf2QQKNqZqzpKtT4COsrj27x24Jf
X-Google-Smtp-Source: APiQypJ3zVy2n6UjAJUoBMWPPx4h13PWSTKaTDLsZYs9bjfa0f4ELC/F5D/hidjVTeMq0QTtYxvSKKTaxvdNv55+JU6idVqNJdMQ
MIME-Version: 1.0
X-Received: by 2002:a02:7688:: with SMTP id z130mr11279368jab.108.1585979713773;
 Fri, 03 Apr 2020 22:55:13 -0700 (PDT)
Date:   Fri, 03 Apr 2020 22:55:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000760d0705a270ad0c@google.com>
Subject: possible deadlock in send_sigio
From:   syzbot <syzbot+a9fb1457d720a55d6dc5@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        allison@lohutok.net, areber@redhat.com, aubrey.li@linux.intel.com,
        avagin@gmail.com, bfields@fieldses.org, christian@brauner.io,
        cyphar@cyphar.com, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, guro@fb.com, jlayton@kernel.org,
        joel@joelfernandes.org, keescook@chromium.org,
        linmiaohe@huawei.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, mingo@kernel.org,
        oleg@redhat.com, peterz@infradead.org, sargun@sargun.me,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bef7b2a7 Merge tag 'devicetree-for-5.7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f39c5de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91b674b8f0368e69
dashboard link: https://syzkaller.appspot.com/bug?extid=a9fb1457d720a55d6dc5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1454c3b7e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a22ac7e00000

The bug was bisected to:

commit 7bc3e6e55acf065500a24621f3b313e7e5998acf
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Thu Feb 20 00:22:26 2020 +0000

    proc: Use a list of inodes to flush from proc

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165c4acde00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=155c4acde00000
console output: https://syzkaller.appspot.com/x/log.txt?x=115c4acde00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a9fb1457d720a55d6dc5@syzkaller.appspotmail.com
Fixes: 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")

========================================================
WARNING: possible irq lock inversion dependency detected
5.6.0-syzkaller #0 Not tainted
--------------------------------------------------------
ksoftirqd/0/9 just changed the state of lock:
ffffffff898090d8 (tasklist_lock){.+.?}-{2:2}, at: send_sigio+0xa9/0x340 fs/fcntl.c:800
but this lock took another, SOFTIRQ-unsafe lock in the past:
 (&pid->wait_pidfd){+.+.}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&pid->wait_pidfd);
                               local_irq_disable();
                               lock(tasklist_lock);
                               lock(&pid->wait_pidfd);
  <Interrupt>
    lock(tasklist_lock);

 *** DEADLOCK ***

8 locks held by ksoftirqd/0/9:
 #0: ffffffff899bb200 (rcu_read_lock){....}-{1:2}, at: __write_once_size include/linux/compiler.h:226 [inline]
 #0: ffffffff899bb200 (rcu_read_lock){....}-{1:2}, at: __skb_unlink include/linux/skbuff.h:2078 [inline]
 #0: ffffffff899bb200 (rcu_read_lock){....}-{1:2}, at: __skb_dequeue include/linux/skbuff.h:2093 [inline]
 #0: ffffffff899bb200 (rcu_read_lock){....}-{1:2}, at: process_backlog+0x1ad/0x7a0 net/core/dev.c:6131
 #1: ffffffff899bb200 (rcu_read_lock){....}-{1:2}, at: __skb_pull include/linux/skbuff.h:2309 [inline]
 #1: ffffffff899bb200 (rcu_read_lock){....}-{1:2}, at: ip_local_deliver_finish+0x124/0x360 net/ipv4/ip_input.c:228
 #2: ffff88808e1750e0 (slock-AF_INET/1){+.-.}-{2:2}, at: tcp_v4_rcv+0x2d09/0x39c0 net/ipv4/tcp_ipv4.c:1997
 #3: ffffffff899bb200 (rcu_read_lock){....}-{1:2}, at: sock_def_error_report+0x0/0x4d0 include/linux/compiler.h:199
 #4: ffffffff899bb200 (rcu_read_lock){....}-{1:2}, at: rcu_lock_release include/linux/rcupdate.h:213 [inline]
 #4: ffffffff899bb200 (rcu_read_lock){....}-{1:2}, at: rcu_read_unlock include/linux/rcupdate.h:655 [inline]
 #4: ffffffff899bb200 (rcu_read_lock){....}-{1:2}, at: sock_def_error_report+0x1d6/0x4d0 net/core/sock.c:2809
 #5: ffffffff899bb200 (rcu_read_lock){....}-{1:2}, at: kill_fasync+0x3d/0x470 fs/fcntl.c:1021
 #6: ffff8880a41312b8 (&new->fa_lock){.+.?}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:1002 [inline]
 #6: ffff8880a41312b8 (&new->fa_lock){.+.?}-{2:2}, at: kill_fasync fs/fcntl.c:1023 [inline]
 #6: ffff8880a41312b8 (&new->fa_lock){.+.?}-{2:2}, at: kill_fasync+0x162/0x470 fs/fcntl.c:1016
 #7: ffff8880a5d263f8 (&f->f_owner.lock){.+.?}-{2:2}, at: send_sigio+0x24/0x340 fs/fcntl.c:786

the shortest dependencies between 2nd lock and 1st lock:
 -> (&pid->wait_pidfd){+.+.}-{2:2} {
    HARDIRQ-ON-W at:
                      lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
                      __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                      _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                      spin_lock include/linux/spinlock.h:353 [inline]
                      proc_pid_make_inode+0x1f9/0x3c0 fs/proc/base.c:1880
                      proc_pid_instantiate+0x51/0x150 fs/proc/base.c:3285
                      proc_pid_lookup+0x1da/0x340 fs/proc/base.c:3320
                      proc_root_lookup+0x20/0x60 fs/proc/root.c:243
                      __lookup_slow+0x256/0x490 fs/namei.c:1530
                      lookup_slow fs/namei.c:1547 [inline]
                      walk_component+0x418/0x6a0 fs/namei.c:1846
                      link_path_walk.part.0+0x4f1/0xb50 fs/namei.c:2166
                      link_path_walk fs/namei.c:2098 [inline]
                      path_openat+0x25a/0x27b0 fs/namei.c:3342
                      do_filp_open+0x203/0x260 fs/namei.c:3375
                      do_sys_openat2+0x585/0x770 fs/open.c:1148
                      do_sys_open+0xc3/0x140 fs/open.c:1164
                      do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
                      entry_SYSCALL_64_after_hwframe+0x49/0xb3
    SOFTIRQ-ON-W at:
                      lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
                      __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                      _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                      spin_lock include/linux/spinlock.h:353 [inline]
                      proc_pid_make_inode+0x1f9/0x3c0 fs/proc/base.c:1880
                      proc_pid_instantiate+0x51/0x150 fs/proc/base.c:3285
                      proc_pid_lookup+0x1da/0x340 fs/proc/base.c:3320
                      proc_root_lookup+0x20/0x60 fs/proc/root.c:243
                      __lookup_slow+0x256/0x490 fs/namei.c:1530
                      lookup_slow fs/namei.c:1547 [inline]
                      walk_component+0x418/0x6a0 fs/namei.c:1846
                      link_path_walk.part.0+0x4f1/0xb50 fs/namei.c:2166
                      link_path_walk fs/namei.c:2098 [inline]
                      path_openat+0x25a/0x27b0 fs/namei.c:3342
                      do_filp_open+0x203/0x260 fs/namei.c:3375
                      do_sys_openat2+0x585/0x770 fs/open.c:1148
                      do_sys_open+0xc3/0x140 fs/open.c:1164
                      do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
                      entry_SYSCALL_64_after_hwframe+0x49/0xb3
    INITIAL USE at:
                     lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
                     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                     _raw_spin_lock_irqsave+0x8c/0xbf kernel/locking/spinlock.c:159
                     __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:122
                     do_notify_pidfd kernel/signal.c:1900 [inline]
                     do_notify_parent+0x19e/0xe60 kernel/signal.c:1927
                     exit_notify kernel/exit.c:660 [inline]
                     do_exit+0x238f/0x2dd0 kernel/exit.c:816
                     call_usermodehelper_exec_async+0x507/0x710 kernel/umh.c:125
                     ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
  }
  ... key      at: [<ffffffff8bbaf680>] __key.53746+0x0/0x40
  ... acquired at:
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x8c/0xbf kernel/locking/spinlock.c:159
   __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:122
   do_notify_pidfd kernel/signal.c:1900 [inline]
   do_notify_parent+0x19e/0xe60 kernel/signal.c:1927
   exit_notify kernel/exit.c:660 [inline]
   do_exit+0x238f/0x2dd0 kernel/exit.c:816
   call_usermodehelper_exec_async+0x507/0x710 kernel/umh.c:125
   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

-> (tasklist_lock){.+.?}-{2:2} {
   HARDIRQ-ON-R at:
                    lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
                    __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                    _raw_read_lock+0x2d/0x40 kernel/locking/spinlock.c:223
                    do_wait+0x3b9/0xa00 kernel/exit.c:1436
                    kernel_wait4+0x14c/0x260 kernel/exit.c:1611
                    call_usermodehelper_exec_sync kernel/umh.c:150 [inline]
                    call_usermodehelper_exec_work+0x172/0x260 kernel/umh.c:187
                    process_one_work+0x965/0x16a0 kernel/workqueue.c:2266
                    worker_thread+0x96/0xe20 kernel/workqueue.c:2412
                    kthread+0x388/0x470 kernel/kthread.c:268
                    ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
   IN-SOFTIRQ-R at:
                    lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
                    __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                    _raw_read_lock+0x2d/0x40 kernel/locking/spinlock.c:223
                    send_sigio+0xa9/0x340 fs/fcntl.c:800
                    kill_fasync_rcu fs/fcntl.c:1009 [inline]
                    kill_fasync fs/fcntl.c:1023 [inline]
                    kill_fasync+0x21c/0x470 fs/fcntl.c:1016
                    sock_wake_async+0xd2/0x160 net/socket.c:1337
                    sk_wake_async include/net/sock.h:2259 [inline]
                    sk_wake_async include/net/sock.h:2255 [inline]
                    sock_def_error_report+0x2d7/0x4d0 net/core/sock.c:2808
                    tcp_reset net/ipv4/tcp_input.c:4138 [inline]
                    tcp_reset+0x195/0x4e0 net/ipv4/tcp_input.c:4114
                    tcp_rcv_synsent_state_process net/ipv4/tcp_input.c:5937 [inline]
                    tcp_rcv_state_process+0x2ead/0x4c80 net/ipv4/tcp_input.c:6204
                    tcp_v4_do_rcv+0x34c/0x8b0 net/ipv4/tcp_ipv4.c:1643
                    tcp_v4_rcv+0x2f60/0x39c0 net/ipv4/tcp_ipv4.c:2003
                    ip_protocol_deliver_rcu+0x57/0x880 net/ipv4/ip_input.c:204
                    ip_local_deliver_finish+0x220/0x360 net/ipv4/ip_input.c:231
                    NF_HOOK include/linux/netfilter.h:307 [inline]
                    NF_HOOK include/linux/netfilter.h:301 [inline]
                    ip_local_deliver+0x1c8/0x4e0 net/ipv4/ip_input.c:252
                    dst_input include/net/dst.h:441 [inline]
                    ip_rcv_finish+0x1da/0x2f0 net/ipv4/ip_input.c:428
                    NF_HOOK include/linux/netfilter.h:307 [inline]
                    NF_HOOK include/linux/netfilter.h:301 [inline]
                    ip_rcv+0xd0/0x3c0 net/ipv4/ip_input.c:539
                    __netif_receive_skb_one_core+0xf5/0x160 net/core/dev.c:5187
                    __netif_receive_skb+0x27/0x1c0 net/core/dev.c:5301
                    process_backlog+0x21e/0x7a0 net/core/dev.c:6133
                    napi_poll net/core/dev.c:6571 [inline]
                    net_rx_action+0x4c2/0x1070 net/core/dev.c:6639
                    __do_softirq+0x26c/0x9f7 kernel/softirq.c:292
                    run_ksoftirqd kernel/softirq.c:604 [inline]
                    run_ksoftirqd+0x89/0x100 kernel/softirq.c:596
                    smpboot_thread_fn+0x653/0x9e0 kernel/smpboot.c:165
                    kthread+0x388/0x470 kernel/kthread.c:268
                    ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
   SOFTIRQ-ON-R at:
                    lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
                    __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
                    _raw_read_lock+0x2d/0x40 kernel/locking/spinlock.c:223
                    do_wait+0x3b9/0xa00 kernel/exit.c:1436
                    kernel_wait4+0x14c/0x260 kernel/exit.c:1611
                    call_usermodehelper_exec_sync kernel/umh.c:150 [inline]
                    call_usermodehelper_exec_work+0x172/0x260 kernel/umh.c:187
                    process_one_work+0x965/0x16a0 kernel/workqueue.c:2266
                    worker_thread+0x96/0xe20 kernel/workqueue.c:2412
                    kthread+0x388/0x470 kernel/kthread.c:268
                    ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
   INITIAL USE at:
                   lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:196 [inline]
                   _raw_write_lock_irq+0x5b/0x80 kernel/locking/spinlock.c:311
                   copy_process+0x3430/0x72c0 kernel/fork.c:2205
                   _do_fork+0x12d/0x1010 kernel/fork.c:2432
                   kernel_thread+0xb1/0xf0 kernel/fork.c:2519
                   rest_init+0x23/0x365 init/main.c:626
                   start_kernel+0x867/0x8a1 init/main.c:998
                   secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242
 }
 ... key      at: [<ffffffff898090d8>] tasklist_lock+0x18/0x40
 ... acquired at:
   mark_lock_irq kernel/locking/lockdep.c:3585 [inline]
   mark_lock+0x624/0xf10 kernel/locking/lockdep.c:3935
   mark_usage kernel/locking/lockdep.c:3826 [inline]
   __lock_acquire+0x1ed9/0x4e00 kernel/locking/lockdep.c:4298
   lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
   __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
   _raw_read_lock+0x2d/0x40 kernel/locking/spinlock.c:223
   send_sigio+0xa9/0x340 fs/fcntl.c:800
   kill_fasync_rcu fs/fcntl.c:1009 [inline]
   kill_fasync fs/fcntl.c:1023 [inline]
   kill_fasync+0x21c/0x470 fs/fcntl.c:1016
   sock_wake_async+0xd2/0x160 net/socket.c:1337
   sk_wake_async include/net/sock.h:2259 [inline]
   sk_wake_async include/net/sock.h:2255 [inline]
   sock_def_error_report+0x2d7/0x4d0 net/core/sock.c:2808
   tcp_reset net/ipv4/tcp_input.c:4138 [inline]
   tcp_reset+0x195/0x4e0 net/ipv4/tcp_input.c:4114
   tcp_rcv_synsent_state_process net/ipv4/tcp_input.c:5937 [inline]
   tcp_rcv_state_process+0x2ead/0x4c80 net/ipv4/tcp_input.c:6204
   tcp_v4_do_rcv+0x34c/0x8b0 net/ipv4/tcp_ipv4.c:1643
   tcp_v4_rcv+0x2f60/0x39c0 net/ipv4/tcp_ipv4.c:2003
   ip_protocol_deliver_rcu+0x57/0x880 net/ipv4/ip_input.c:204
   ip_local_deliver_finish+0x220/0x360 net/ipv4/ip_input.c:231
   NF_HOOK include/linux/netfilter.h:307 [inline]
   NF_HOOK include/linux/netfilter.h:301 [inline]
   ip_local_deliver+0x1c8/0x4e0 net/ipv4/ip_input.c:252
   dst_input include/net/dst.h:441 [inline]
   ip_rcv_finish+0x1da/0x2f0 net/ipv4/ip_input.c:428
   NF_HOOK include/linux/netfilter.h:307 [inline]
   NF_HOOK include/linux/netfilter.h:301 [inline]
   ip_rcv+0xd0/0x3c0 net/ipv4/ip_input.c:539
   __netif_receive_skb_one_core+0xf5/0x160 net/core/dev.c:5187
   __netif_receive_skb+0x27/0x1c0 net/core/dev.c:5301
   process_backlog+0x21e/0x7a0 net/core/dev.c:6133
   napi_poll net/core/dev.c:6571 [inline]
   net_rx_action+0x4c2/0x1070 net/core/dev.c:6639
   __do_softirq+0x26c/0x9f7 kernel/softirq.c:292
   run_ksoftirqd kernel/softirq.c:604 [inline]
   run_ksoftirqd+0x89/0x100 kernel/softirq.c:596
   smpboot_thread_fn+0x653/0x9e0 kernel/smpboot.c:165
   kthread+0x388/0x470 kernel/kthread.c:268
   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


stack backtrace:
CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_irq_inversion_bug kernel/locking/lockdep.c:3448 [inline]
 check_usage_forwards.cold+0x20/0x29 kernel/locking/lockdep.c:3472
 mark_lock_irq kernel/locking/lockdep.c:3585 [inline]
 mark_lock+0x624/0xf10 kernel/locking/lockdep.c:3935
 mark_usage kernel/locking/lockdep.c:3826 [inline]
 __lock_acquire+0x1ed9/0x4e00 kernel/locking/lockdep.c:4298
 lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
 __raw_read_lock include/linux/rwlock_api_smp.h:149 [inline]
 _raw_read_lock+0x2d/0x40 kernel/locking/spinlock.c:223
 send_sigio+0xa9/0x340 fs/fcntl.c:800
 kill_fasync_rcu fs/fcntl.c:1009 [inline]
 kill_fasync fs/fcntl.c:1023 [inline]
 kill_fasync+0x21c/0x470 fs/fcntl.c:1016
 sock_wake_async+0xd2/0x160 net/socket.c:1337
 sk_wake_async include/net/sock.h:2259 [inline]
 sk_wake_async include/net/sock.h:2255 [inline]
 sock_def_error_report+0x2d7/0x4d0 net/core/sock.c:2808
 tcp_reset net/ipv4/tcp_input.c:4138 [inline]
 tcp_reset+0x195/0x4e0 net/ipv4/tcp_input.c:4114
 tcp_rcv_synsent_state_process net/ipv4/tcp_input.c:5937 [inline]
 tcp_rcv_state_process+0x2ead/0x4c80 net/ipv4/tcp_input.c:6204
 tcp_v4_do_rcv+0x34c/0x8b0 net/ipv4/tcp_ipv4.c:1643
 tcp_v4_rcv+0x2f60/0x39c0 net/ipv4/tcp_ipv4.c:2003
 ip_protocol_deliver_rcu+0x57/0x880 net/ipv4/ip_input.c:204
 ip_local_deliver_finish+0x220/0x360 net/ipv4/ip_input.c:231
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ip_local_deliver+0x1c8/0x4e0 net/ipv4/ip_input.c:252
 dst_input include/net/dst.h:441 [inline]
 ip_rcv_finish+0x1da/0x2f0 net/ipv4/ip_input.c:428
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ip_rcv+0xd0/0x3c0 net/ipv4/ip_input.c:539
 __netif_receive_skb_one_core+0xf5/0x160 net/core/dev.c:5187
 __netif_receive_skb+0x27/0x1c0 net/core/dev.c:5301
 process_backlog+0x21e/0x7a0 net/core/dev.c:6133
 napi_poll net/core/dev.c:6571 [inline]
 net_rx_action+0x4c2/0x1070 net/core/dev.c:6639
 __do_softirq+0x26c/0x9f7 kernel/softirq.c:292
 run_ksoftirqd kernel/softirq.c:604 [inline]
 run_ksoftirqd+0x89/0x100 kernel/softirq.c:596
 smpboot_thread_fn+0x653/0x9e0 kernel/smpboot.c:165
 kthread+0x388/0x470 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
