Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6991819D037
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 08:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388268AbgDCGZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 02:25:17 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:33981 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388214AbgDCGZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 02:25:16 -0400
Received: by mail-il1-f197.google.com with SMTP id b14so5964553ilb.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2020 23:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VwbrFL8wGaAe9hRy1TCDS93XTLoFhjiFt9l/CG1QVzE=;
        b=EOUsYuuvngKWWmKpiXLaHOgXW+J/febAn8SpBjek8cVOqAR+ZqQuFDzBRXz6jU60dz
         xiT5niymuoZ5D6Ntmn9yVuqMGjrHPsOE4ZYagebyRTUkObF+QDeQtmYmDd7Q+sf4VrRa
         FsQP7ukjkg4Zpjvjz0PY8n/2QGqgMNRhc2i8Bsi/ocWJIxg7urCF4MKyq50h+iMIG8R6
         90a/FAFmjGfoZXwiEluE3J2DDZ43EKRtePdFcaqb3Zh3YwJgxmK7ASxAjjzJbr0zHkYJ
         tHuwmliuZtQISzi6af/ebSvvLFA/yns5BtXrnZmC5QB7BSinQL5khrNldbvZX8+FxZ7r
         k4pw==
X-Gm-Message-State: AGi0PuarJnjg4rd37U6XGfUPwIxfT/0pqP40ISnRsN3X3SxskY3P3dpA
        +ca6V/WlGFCEdszaRcal4uI1IeKVo5isWJluBR76GW5/9ziV
X-Google-Smtp-Source: APiQypKcYd9bjP/FR2qLbpaE6v5GmohQy/D5tGp8wbPC1KuKxMhoBy85F2TNnSRY7oIPhJAK3RhXeIc8xq84G7T+lTsSJD2YSmm8
MIME-Version: 1.0
X-Received: by 2002:a5d:9648:: with SMTP id d8mr6256766ios.115.1585895114384;
 Thu, 02 Apr 2020 23:25:14 -0700 (PDT)
Date:   Thu, 02 Apr 2020 23:25:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1aa0d05a25cfab6@google.com>
Subject: possible deadlock in free_ioctx_users (2)
From:   syzbot <syzbot+832aabf700bc3ec920b9@syzkaller.appspotmail.com>
To:     bcrl@kvack.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=16df6cc7e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec722f9d4eb221d2
dashboard link: https://syzkaller.appspot.com/bug?extid=832aabf700bc3ec920b9
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f37663e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16feb91fe00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+832aabf700bc3ec920b9@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
5.6.0-syzkaller #0 Not tainted
--------------------------------------------------------
swapper/1/0 just changed the state of lock:
ffff88808f38bcd8 (&ctx->ctx_lock){..-.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:378 [inline]
ffff88808f38bcd8 (&ctx->ctx_lock){..-.}-{2:2}, at: free_ioctx_users+0x30/0x1c0 fs/aio.c:618
but this lock took another, SOFTIRQ-unsafe lock in the past:
 (&pid->wait_pidfd){+.+.}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&pid->wait_pidfd);
                               local_irq_disable();
                               lock(&ctx->ctx_lock);
                               lock(&pid->wait_pidfd);
  <Interrupt>
    lock(&ctx->ctx_lock);

 *** DEADLOCK ***

2 locks held by swapper/1/0:
 #0: ffffffff892e67a0 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire+0x0/0x30 lib/xarray.c:75
 #1: ffffffff892e6750 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x5/0x30 include/linux/rcupdate.h:207

the shortest dependencies between 2nd lock and 1st lock:
 -> (&pid->wait_pidfd){+.+.}-{2:2} {
    HARDIRQ-ON-W at:
                      lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
                      __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                      _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                      spin_lock include/linux/spinlock.h:353 [inline]
                      proc_pid_make_inode+0x187/0x2d0 fs/proc/base.c:1880
                      proc_pid_instantiate+0x4b/0x1a0 fs/proc/base.c:3285
                      proc_pid_lookup+0x218/0x2f0 fs/proc/base.c:3320
                      proc_root_lookup+0x1b/0x50 fs/proc/root.c:243
                      __lookup_slow+0x240/0x370 fs/namei.c:1530
                      lookup_slow fs/namei.c:1547 [inline]
                      walk_component+0x442/0x680 fs/namei.c:1846
                      link_path_walk+0x66d/0xba0 fs/namei.c:2165
                      path_openat+0x21d/0x38b0 fs/namei.c:3342
                      do_filp_open+0x2b4/0x3a0 fs/namei.c:3375
                      do_sys_openat2+0x463/0x6f0 fs/open.c:1148
                      do_sys_open fs/open.c:1164 [inline]
                      ksys_open include/linux/syscalls.h:1386 [inline]
                      __do_sys_open fs/open.c:1170 [inline]
                      __se_sys_open fs/open.c:1168 [inline]
                      __x64_sys_open+0x1af/0x1e0 fs/open.c:1168
                      do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
                      entry_SYSCALL_64_after_hwframe+0x49/0xb3
    SOFTIRQ-ON-W at:
                      lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
                      __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                      _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                      spin_lock include/linux/spinlock.h:353 [inline]
                      proc_pid_make_inode+0x187/0x2d0 fs/proc/base.c:1880
                      proc_pid_instantiate+0x4b/0x1a0 fs/proc/base.c:3285
                      proc_pid_lookup+0x218/0x2f0 fs/proc/base.c:3320
                      proc_root_lookup+0x1b/0x50 fs/proc/root.c:243
                      __lookup_slow+0x240/0x370 fs/namei.c:1530
                      lookup_slow fs/namei.c:1547 [inline]
                      walk_component+0x442/0x680 fs/namei.c:1846
                      link_path_walk+0x66d/0xba0 fs/namei.c:2165
                      path_openat+0x21d/0x38b0 fs/namei.c:3342
                      do_filp_open+0x2b4/0x3a0 fs/namei.c:3375
                      do_sys_openat2+0x463/0x6f0 fs/open.c:1148
                      do_sys_open fs/open.c:1164 [inline]
                      ksys_open include/linux/syscalls.h:1386 [inline]
                      __do_sys_open fs/open.c:1170 [inline]
                      __se_sys_open fs/open.c:1168 [inline]
                      __x64_sys_open+0x1af/0x1e0 fs/open.c:1168
                      do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
                      entry_SYSCALL_64_after_hwframe+0x49/0xb3
    INITIAL USE at:
                     lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
                     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                     _raw_spin_lock_irqsave+0x9e/0xc0 kernel/locking/spinlock.c:159
                     __wake_up_common_lock kernel/sched/wait.c:122 [inline]
                     __wake_up+0xb8/0x150 kernel/sched/wait.c:142
                     do_notify_pidfd kernel/signal.c:1900 [inline]
                     do_notify_parent+0x167/0xce0 kernel/signal.c:1927
                     exit_notify kernel/exit.c:660 [inline]
                     do_exit+0x12c5/0x1f80 kernel/exit.c:816
                     call_usermodehelper_exec_async+0x47c/0x480 kernel/umh.c:125
                     ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
  }
  ... key      at: [<ffffffff8aae6790>] alloc_pid.__key+0x0/0x10
  ... acquired at:
   lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:353 [inline]
   aio_poll fs/aio.c:1767 [inline]
   __io_submit_one fs/aio.c:1841 [inline]
   io_submit_one+0x10f5/0x1a80 fs/aio.c:1878
   __do_sys_io_submit fs/aio.c:1937 [inline]
   __se_sys_io_submit+0x117/0x220 fs/aio.c:1907
   do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
   entry_SYSCALL_64_after_hwframe+0x49/0xb3

-> (&ctx->ctx_lock){..-.}-{2:2} {
   IN-SOFTIRQ-W at:
                    lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
                    __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
                    _raw_spin_lock_irq+0x67/0x80 kernel/locking/spinlock.c:167
                    spin_lock_irq include/linux/spinlock.h:378 [inline]
                    free_ioctx_users+0x30/0x1c0 fs/aio.c:618
                    percpu_ref_put_many include/linux/percpu-refcount.h:309 [inline]
                    percpu_ref_put+0x18d/0x1a0 include/linux/percpu-refcount.h:325
                    rcu_do_batch kernel/rcu/tree.c:2206 [inline]
                    rcu_core+0x816/0x1120 kernel/rcu/tree.c:2433
                    __do_softirq+0x268/0x80c kernel/softirq.c:292
                    invoke_softirq kernel/softirq.c:373 [inline]
                    irq_exit+0x223/0x230 kernel/softirq.c:413
                    exiting_irq arch/x86/include/asm/apic.h:546 [inline]
                    smp_apic_timer_interrupt+0x113/0x280 arch/x86/kernel/apic/apic.c:1140
                    apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
                    native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:60
                    arch_safe_halt arch/x86/include/asm/paravirt.h:144 [inline]
                    default_idle+0x4c/0x70 arch/x86/kernel/process.c:697
                    cpuidle_idle_call kernel/sched/idle.c:154 [inline]
                    do_idle+0x1ee/0x650 kernel/sched/idle.c:269
                    cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:361
                    start_secondary+0x386/0x410 arch/x86/kernel/smpboot.c:268
                    secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242
   INITIAL USE at:
                   lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
                   _raw_spin_lock_irq+0x67/0x80 kernel/locking/spinlock.c:167
                   spin_lock_irq include/linux/spinlock.h:378 [inline]
                   aio_poll fs/aio.c:1765 [inline]
                   __io_submit_one fs/aio.c:1841 [inline]
                   io_submit_one+0x10cb/0x1a80 fs/aio.c:1878
                   __do_sys_io_submit fs/aio.c:1937 [inline]
                   __se_sys_io_submit+0x117/0x220 fs/aio.c:1907
                   do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
                   entry_SYSCALL_64_after_hwframe+0x49/0xb3
 }
 ... key      at: [<ffffffff8b596090>] ioctx_alloc.__key+0x0/0x10
 ... acquired at:
   mark_lock_irq kernel/locking/lockdep.c:3585 [inline]
   mark_lock+0x529/0x1b00 kernel/locking/lockdep.c:3935
   mark_usage kernel/locking/lockdep.c:3834 [inline]
   __lock_acquire+0xaa7/0x2b90 kernel/locking/lockdep.c:4298
   lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
   _raw_spin_lock_irq+0x67/0x80 kernel/locking/spinlock.c:167
   spin_lock_irq include/linux/spinlock.h:378 [inline]
   free_ioctx_users+0x30/0x1c0 fs/aio.c:618
   percpu_ref_put_many include/linux/percpu-refcount.h:309 [inline]
   percpu_ref_put+0x18d/0x1a0 include/linux/percpu-refcount.h:325
   rcu_do_batch kernel/rcu/tree.c:2206 [inline]
   rcu_core+0x816/0x1120 kernel/rcu/tree.c:2433
   __do_softirq+0x268/0x80c kernel/softirq.c:292
   invoke_softirq kernel/softirq.c:373 [inline]
   irq_exit+0x223/0x230 kernel/softirq.c:413
   exiting_irq arch/x86/include/asm/apic.h:546 [inline]
   smp_apic_timer_interrupt+0x113/0x280 arch/x86/kernel/apic/apic.c:1140
   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
   native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:60
   arch_safe_halt arch/x86/include/asm/paravirt.h:144 [inline]
   default_idle+0x4c/0x70 arch/x86/kernel/process.c:697
   cpuidle_idle_call kernel/sched/idle.c:154 [inline]
   do_idle+0x1ee/0x650 kernel/sched/idle.c:269
   cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:361
   start_secondary+0x386/0x410 arch/x86/kernel/smpboot.c:268
   secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242


stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 print_irq_inversion_bug+0xb67/0xe90 kernel/locking/lockdep.c:3447
 check_usage_forwards+0x13f/0x240 kernel/locking/lockdep.c:3472
 mark_lock_irq kernel/locking/lockdep.c:3585 [inline]
 mark_lock+0x529/0x1b00 kernel/locking/lockdep.c:3935
 mark_usage kernel/locking/lockdep.c:3834 [inline]
 __lock_acquire+0xaa7/0x2b90 kernel/locking/lockdep.c:4298
 lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
 _raw_spin_lock_irq+0x67/0x80 kernel/locking/spinlock.c:167
 spin_lock_irq include/linux/spinlock.h:378 [inline]
 free_ioctx_users+0x30/0x1c0 fs/aio.c:618
 percpu_ref_put_many include/linux/percpu-refcount.h:309 [inline]
 percpu_ref_put+0x18d/0x1a0 include/linux/percpu-refcount.h:325
 rcu_do_batch kernel/rcu/tree.c:2206 [inline]
 rcu_core+0x816/0x1120 kernel/rcu/tree.c:2433
 __do_softirq+0x268/0x80c kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0x223/0x230 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:546 [inline]
 smp_apic_timer_interrupt+0x113/0x280 arch/x86/kernel/apic/apic.c:1140
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
 </IRQ>
RIP: 0010:native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:61
Code: 80 e1 07 80 c1 03 38 c1 7c bc 48 89 df e8 8a fc ab f9 eb b2 cc cc cc cc cc cc cc cc e9 07 00 00 00 0f 00 2d d6 a2 5c 00 fb f4 <c3> 90 e9 07 00 00 00 0f 00 2d c6 a2 5c 00 f4 c3 cc cc 41 56 53 65
RSP: 0018:ffffc90000d3fe60 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff12573b1 RBX: ffff8880a9a3c340 RCX: dffffc0000000000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff8880a9a3cba4
RBP: ffffffff896b61e0 R08: ffffffff817a6f90 R09: ffffed1015347869
R10: ffffed1015347869 R11: 0000000000000000 R12: 1ffff11015347868
R13: dffffc0000000000 R14: 1ffffffff12573af R15: 0000000000000001
 arch_safe_halt arch/x86/include/asm/paravirt.h:144 [inline]
 default_idle+0x4c/0x70 arch/x86/kernel/process.c:697
 cpuidle_idle_call kernel/sched/idle.c:154 [inline]
 do_idle+0x1ee/0x650 kernel/sched/idle.c:269
 cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:361
 start_secondary+0x386/0x410 arch/x86/kernel/smpboot.c:268
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
