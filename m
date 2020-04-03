Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3818819D01C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 08:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387544AbgDCGPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 02:15:15 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:47288 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731040AbgDCGPO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 02:15:14 -0400
Received: by mail-il1-f198.google.com with SMTP id a15so5895025ild.14
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2020 23:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=83Ymbi6Qn03gSTEUyRMK7Xz2p0/EVlLM6rWqDklgtDY=;
        b=Ek5e4LS/flBdgobu0XkdbVZ3ZLfygK732j5PrR6FVDZWo9zbQqrjbwJgGyZ76/iOJi
         PSoE/1JiFSEh3avvi1XkgRzHW5+Pup/mDW3OG43qQNydOqG6Mkd7GCfBiKl1v+whAFiU
         6ucLMe+E0GCRIc8oiz3R4EK00Y3vu1UqWHhuKYdtC/tZbRWFOSN6oLY9qaBMKzTGqbSC
         mLHFNc+ccchXASx5HqoJPDJ48Ak+RKY9TJVWu3P0We19y9vfKJWgVLBt0hm3Q8bXp9h6
         RJynO+JmN/hc8wmhvRm2tdXViuAHvrhIC3zggRy2eHDJTf4rFs01vQwPjgfARd2OgB11
         L89w==
X-Gm-Message-State: AGi0PuYI1ipvOZM0S4iNgRmea79O9dfJw4v4oSZ3+CxYw4Gz3YJ/NB3i
        sC5lW7UHaCUSMhQxAoceyAcCdbkWkTyGF+jUSDTHXo+u02Ct
X-Google-Smtp-Source: APiQypJJZ1F4uLXoTpSsMxhOpA+lgtNL/TzqbnZD5h7jC6hzGab0s0qa8EaV7EQWXfM0c1eEw1onDkeTF4fBvU+YGqBaMcBej2fW
MIME-Version: 1.0
X-Received: by 2002:a92:d582:: with SMTP id a2mr6306931iln.37.1585894512512;
 Thu, 02 Apr 2020 23:15:12 -0700 (PDT)
Date:   Thu, 02 Apr 2020 23:15:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011d66805a25cd73f@google.com>
Subject: possible deadlock in send_sigurg
From:   syzbot <syzbot+f675f964019f884dbd0f@syzkaller.appspotmail.com>
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

HEAD commit:    7be97138 Merge tag 'xfs-5.7-merge-8' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14952b6de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6a1e2f9a9986236
dashboard link: https://syzkaller.appspot.com/bug?extid=f675f964019f884dbd0f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1643bf2fe00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ef5733e00000

The bug was bisected to:

commit 7bc3e6e55acf065500a24621f3b313e7e5998acf
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Thu Feb 20 00:22:26 2020 +0000

    proc: Use a list of inodes to flush from proc

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11aa9747e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13aa9747e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15aa9747e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f675f964019f884dbd0f@syzkaller.appspotmail.com
Fixes: 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")

========================================================
WARNING: possible irq lock inversion dependency detected
5.6.0-syzkaller #0 Not tainted
--------------------------------------------------------
swapper/1/0 just changed the state of lock:
ffffffff898090d8 (tasklist_lock){.+.?}-{2:2}, at: send_sigurg+0x9f/0x320 fs/fcntl.c:840
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

4 locks held by swapper/1/0:
 #0: ffffffff899bacc0 (rcu_read_lock){....}-{1:2}, at: __write_once_size include/linux/compiler.h:226 [inline]
 #0: ffffffff899bacc0 (rcu_read_lock){....}-{1:2}, at: __skb_unlink include/linux/skbuff.h:2078 [inline]
 #0: ffffffff899bacc0 (rcu_read_lock){....}-{1:2}, at: __skb_dequeue include/linux/skbuff.h:2093 [inline]
 #0: ffffffff899bacc0 (rcu_read_lock){....}-{1:2}, at: process_backlog+0x1ad/0x7a0 net/core/dev.c:6131
 #1: ffffffff899bacc0 (rcu_read_lock){....}-{1:2}, at: __skb_pull include/linux/skbuff.h:2309 [inline]
 #1: ffffffff899bacc0 (rcu_read_lock){....}-{1:2}, at: ip_local_deliver_finish+0x124/0x360 net/ipv4/ip_input.c:228
 #2: ffff888093e42de0 (slock-AF_INET/1){+.-.}-{2:2}, at: tcp_v4_rcv+0x2d09/0x39c0 net/ipv4/tcp_ipv4.c:1997
 #3: ffff8880950c23b8 (&f->f_owner.lock){.+.?}-{2:2}, at: send_sigurg+0x1a/0x320 fs/fcntl.c:824

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
  ... key      at: [<ffffffff8bba4680>] __key.53714+0x0/0x40
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
                    send_sigurg+0x9f/0x320 fs/fcntl.c:840
                    sk_send_sigurg+0x76/0x300 net/core/sock.c:2855
                    tcp_check_urg net/ipv4/tcp_input.c:5353 [inline]
                    tcp_urg+0x38c/0xb80 net/ipv4/tcp_input.c:5394
                    tcp_rcv_established+0x8f3/0x1d90 net/ipv4/tcp_input.c:5724
                    tcp_v4_do_rcv+0x605/0x8b0 net/ipv4/tcp_ipv4.c:1621
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
                    invoke_softirq kernel/softirq.c:373 [inline]
                    irq_exit+0x192/0x1d0 kernel/softirq.c:413
                    exiting_irq arch/x86/include/asm/apic.h:546 [inline]
                    smp_apic_timer_interrupt+0x19e/0x600 arch/x86/kernel/apic/apic.c:1140
                    apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
                    native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:60
                    arch_safe_halt arch/x86/include/asm/paravirt.h:144 [inline]
                    default_idle+0x49/0x350 arch/x86/kernel/process.c:697
                    cpuidle_idle_call kernel/sched/idle.c:154 [inline]
                    do_idle+0x393/0x690 kernel/sched/idle.c:269
                    cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:361
                    start_secondary+0x2f3/0x400 arch/x86/kernel/smpboot.c:268
                    secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242
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
                   copy_process+0x3430/0x72c0 kernel/fork.c:2204
                   _do_fork+0x12d/0x1010 kernel/fork.c:2431
                   kernel_thread+0xb1/0xf0 kernel/fork.c:2518
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
   send_sigurg+0x9f/0x320 fs/fcntl.c:840
   sk_send_sigurg+0x76/0x300 net/core/sock.c:2855
   tcp_check_urg net/ipv4/tcp_input.c:5353 [inline]
   tcp_urg+0x38c/0xb80 net/ipv4/tcp_input.c:5394
   tcp_rcv_established+0x8f3/0x1d90 net/ipv4/tcp_input.c:5724
   tcp_v4_do_rcv+0x605/0x8b0 net/ipv4/tcp_ipv4.c:1621
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
   invoke_softirq kernel/softirq.c:373 [inline]
   irq_exit+0x192/0x1d0 kernel/softirq.c:413
   exiting_irq arch/x86/include/asm/apic.h:546 [inline]
   smp_apic_timer_interrupt+0x19e/0x600 arch/x86/kernel/apic/apic.c:1140
   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
   native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:60
   arch_safe_halt arch/x86/include/asm/paravirt.h:144 [inline]
   default_idle+0x49/0x350 arch/x86/kernel/process.c:697
   cpuidle_idle_call kernel/sched/idle.c:154 [inline]
   do_idle+0x393/0x690 kernel/sched/idle.c:269
   cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:361
   start_secondary+0x2f3/0x400 arch/x86/kernel/smpboot.c:268
   secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242


stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
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
 send_sigurg+0x9f/0x320 fs/fcntl.c:840
 sk_send_sigurg+0x76/0x300 net/core/sock.c:2855
 tcp_check_urg net/ipv4/tcp_input.c:5353 [inline]
 tcp_urg+0x38c/0xb80 net/ipv4/tcp_input.c:5394
 tcp_rcv_established+0x8f3/0x1d90 net/ipv4/tcp_input.c:5724
 tcp_v4_do_rcv+0x605/0x8b0 net/ipv4/tcp_ipv4.c:1621
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
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0x192/0x1d0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:546 [inline]
 smp_apic_timer_interrupt+0x19e/0x600 arch/x86/kernel/apic/apic.c:1140
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
 </IRQ>
RIP: 0010:native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:61
Code: cc cc cc cc cc cc cc cc cc cc cc cc e9 07 00 00 00 0f 00 2d 44 ae 5e 00 f4 c3 66 90 e9 07 00 00 00 0f 00 2d 34 ae 5e 00 fb f4 <c3> cc 41 56 41 55 41 54 55 53 e8 c3 07 97 f9 e8 9e 72 cb fb 0f 1f
RSP: 0018:ffffc90000d3fdb8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff13291af RBX: ffff8880a95f2340 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000006 RDI: ffff8880a95f2c04
RBP: dffffc0000000000 R08: ffff8880a95f2340 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffed10152be468
R13: 0000000000000001 R14: ffffffff8a883540 R15: 0000000000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:144 [inline]
 default_idle+0x49/0x350 arch/x86/kernel/process.c:697
 cpuidle_idle_call kernel/sched/idle.c:154 [inline]
 do_idle+0x393/0x690 kernel/sched/idle.c:269
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:361
 start_secondary+0x2f3/0x400 arch/x86/kernel/smpboot.c:268
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
