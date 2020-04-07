Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E6F1A048F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 03:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgDGBgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 21:36:18 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:46584 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGBgR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:36:17 -0400
Received: by mail-il1-f199.google.com with SMTP id n18so1597358ilp.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2020 18:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qIYLZ8N6YOeSd0ZbidTI6devPpMkC11+E/tH+GGz8qc=;
        b=VhF8QN/vQz3sY3+DCHSHVr88b38mM8zMhhUz25crSK+q+R5QOX3vAzcUymtU7YEK3P
         4Zthvqol9Cl4umT6loazh831Pmh8BTMn3O7GpacB3iYULQh0BHvxE/CHUB3671fFxbnb
         0lVK0quuL8Flw6Bvij0SRMn2wnJs1GDsXgX4a/RB2N9dFBlcGUvAxB8wcurKirlakPmf
         vyIwJepu5IKUidXBDMpll7EWOhAuQcjMkHUJg+d5f2cgu4EkN8eeuzIEEUBrZ9surLUL
         T3rWzQueDyi1YuGYntc0F1nnABXSCuYejVfnou/AQdSqoPMVpKfbPMsQIcp+rAHrxGkA
         +bKg==
X-Gm-Message-State: AGi0Pua4sEfPfUD4f79gNAoCoUQFYp40GwIPj6un04kZyr8cEx+1yWSv
        0ytEIeiWOpCxOQgE1i0gtEXm+BZFX/zaHIdSRmsSvEEYaBXg
X-Google-Smtp-Source: APiQypKbcuUDOUag1E8mjfZA74oiQO9xt/aSFkWhsLQXQ4E36OOeZYfY65MDPvVaWaelCLf6LsV0c7DLeETUZY6ia0P4v7Y5oHKH
MIME-Version: 1.0
X-Received: by 2002:a92:4c4:: with SMTP id 187mr24999ile.128.1586223373558;
 Mon, 06 Apr 2020 18:36:13 -0700 (PDT)
Date:   Mon, 06 Apr 2020 18:36:13 -0700
In-Reply-To: <000000000000f59ac305a25cfa14@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b72b0105a2a96809@google.com>
Subject: Re: possible deadlock in io_submit_one (3)
From:   syzbot <syzbot+343f75cdeea091340956@syzkaller.appspotmail.com>
To:     bcrl@kvack.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    7e634208 Merge tag 'acpi-5.7-rc1-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139b71c7e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12205d036cec317f
dashboard link: https://syzkaller.appspot.com/bug?extid=343f75cdeea091340956
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105d592be00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+343f75cdeea091340956@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
5.6.0-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.0/9005 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff88808b9c1b48 (&pid->wait_pidfd){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:353 [inline]
ffff88808b9c1b48 (&pid->wait_pidfd){+.+.}-{2:2}, at: aio_poll fs/aio.c:1767 [inline]
ffff88808b9c1b48 (&pid->wait_pidfd){+.+.}-{2:2}, at: __io_submit_one fs/aio.c:1841 [inline]
ffff88808b9c1b48 (&pid->wait_pidfd){+.+.}-{2:2}, at: io_submit_one+0xc1b/0x2ec0 fs/aio.c:1878

and this task is already holding:
ffff8880a81b1cd8 (&ctx->ctx_lock){..-.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:378 [inline]
ffff8880a81b1cd8 (&ctx->ctx_lock){..-.}-{2:2}, at: aio_poll fs/aio.c:1765 [inline]
ffff8880a81b1cd8 (&ctx->ctx_lock){..-.}-{2:2}, at: __io_submit_one fs/aio.c:1841 [inline]
ffff8880a81b1cd8 (&ctx->ctx_lock){..-.}-{2:2}, at: io_submit_one+0xbd6/0x2ec0 fs/aio.c:1878
which would create a new lock dependency:
 (&ctx->ctx_lock){..-.}-{2:2} -> (&pid->wait_pidfd){+.+.}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&ctx->ctx_lock){..-.}-{2:2}

... which became SOFTIRQ-irq-safe at:
  lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
  __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
  _raw_spin_lock_irq+0x5b/0x80 kernel/locking/spinlock.c:167
  spin_lock_irq include/linux/spinlock.h:378 [inline]
  free_ioctx_users+0x2b/0x450 fs/aio.c:618
  percpu_ref_put_many include/linux/percpu-refcount.h:309 [inline]
  percpu_ref_put include/linux/percpu-refcount.h:325 [inline]
  percpu_ref_call_confirm_rcu lib/percpu-refcount.c:131 [inline]
  percpu_ref_switch_to_atomic_rcu+0x494/0x540 lib/percpu-refcount.c:166
  rcu_do_batch kernel/rcu/tree.c:2206 [inline]
  rcu_core+0x59f/0x1370 kernel/rcu/tree.c:2433
  __do_softirq+0x26c/0x9f7 kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x192/0x1d0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:546 [inline]
  smp_apic_timer_interrupt+0x19e/0x600 arch/x86/kernel/apic/apic.c:1140
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
  preempt_count_add+0x0/0x140 kernel/sched/core.c:6758
  __raw_spin_lock include/linux/spinlock_api_smp.h:141 [inline]
  _raw_spin_lock+0xe/0x40 kernel/locking/spinlock.c:151
  spin_lock include/linux/spinlock.h:353 [inline]
  lockref_put_or_lock+0x14/0x80 lib/lockref.c:174
  fast_dput fs/dcache.c:728 [inline]
  dput+0x4a3/0xdf0 fs/dcache.c:846
  path_put+0x2d/0x60 fs/namei.c:482
  vfs_statx+0x14d/0x1e0 fs/stat.c:202
  vfs_stat include/linux/fs.h:3279 [inline]
  __do_sys_newstat+0x96/0x120 fs/stat.c:351
  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
  entry_SYSCALL_64_after_hwframe+0x49/0xb3

to a SOFTIRQ-irq-unsafe lock:
 (&pid->wait_pidfd){+.+.}-{2:2}

... which became SOFTIRQ-irq-unsafe at:
...
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
  path_openat+0x25a/0x27d0 fs/namei.c:3342
  do_filp_open+0x192/0x260 fs/namei.c:3373
  do_sys_openat2+0x585/0x7d0 fs/open.c:1148
  do_sys_open+0xc3/0x140 fs/open.c:1164
  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
  entry_SYSCALL_64_after_hwframe+0x49/0xb3

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

1 lock held by syz-executor.0/9005:
 #0: ffff8880a81b1cd8 (&ctx->ctx_lock){..-.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:378 [inline]
 #0: ffff8880a81b1cd8 (&ctx->ctx_lock){..-.}-{2:2}, at: aio_poll fs/aio.c:1765 [inline]
 #0: ffff8880a81b1cd8 (&ctx->ctx_lock){..-.}-{2:2}, at: __io_submit_one fs/aio.c:1841 [inline]
 #0: ffff8880a81b1cd8 (&ctx->ctx_lock){..-.}-{2:2}, at: io_submit_one+0xbd6/0x2ec0 fs/aio.c:1878

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (&ctx->ctx_lock){..-.}-{2:2} {
   IN-SOFTIRQ-W at:
                    lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
                    __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
                    _raw_spin_lock_irq+0x5b/0x80 kernel/locking/spinlock.c:167
                    spin_lock_irq include/linux/spinlock.h:378 [inline]
                    free_ioctx_users+0x2b/0x450 fs/aio.c:618
                    percpu_ref_put_many include/linux/percpu-refcount.h:309 [inline]
                    percpu_ref_put include/linux/percpu-refcount.h:325 [inline]
                    percpu_ref_call_confirm_rcu lib/percpu-refcount.c:131 [inline]
                    percpu_ref_switch_to_atomic_rcu+0x494/0x540 lib/percpu-refcount.c:166
                    rcu_do_batch kernel/rcu/tree.c:2206 [inline]
                    rcu_core+0x59f/0x1370 kernel/rcu/tree.c:2433
                    __do_softirq+0x26c/0x9f7 kernel/softirq.c:292
                    invoke_softirq kernel/softirq.c:373 [inline]
                    irq_exit+0x192/0x1d0 kernel/softirq.c:413
                    exiting_irq arch/x86/include/asm/apic.h:546 [inline]
                    smp_apic_timer_interrupt+0x19e/0x600 arch/x86/kernel/apic/apic.c:1140
                    apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
                    preempt_count_add+0x0/0x140 kernel/sched/core.c:6758
                    __raw_spin_lock include/linux/spinlock_api_smp.h:141 [inline]
                    _raw_spin_lock+0xe/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:353 [inline]
                    lockref_put_or_lock+0x14/0x80 lib/lockref.c:174
                    fast_dput fs/dcache.c:728 [inline]
                    dput+0x4a3/0xdf0 fs/dcache.c:846
                    path_put+0x2d/0x60 fs/namei.c:482
                    vfs_statx+0x14d/0x1e0 fs/stat.c:202
                    vfs_stat include/linux/fs.h:3279 [inline]
                    __do_sys_newstat+0x96/0x120 fs/stat.c:351
                    do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
                    entry_SYSCALL_64_after_hwframe+0x49/0xb3
   INITIAL USE at:
                   lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
                   _raw_spin_lock_irq+0x5b/0x80 kernel/locking/spinlock.c:167
                   spin_lock_irq include/linux/spinlock.h:378 [inline]
                   free_ioctx_users+0x2b/0x450 fs/aio.c:618
                   percpu_ref_put_many include/linux/percpu-refcount.h:309 [inline]
                   percpu_ref_put include/linux/percpu-refcount.h:325 [inline]
                   percpu_ref_call_confirm_rcu lib/percpu-refcount.c:131 [inline]
                   percpu_ref_switch_to_atomic_rcu+0x494/0x540 lib/percpu-refcount.c:166
                   rcu_do_batch kernel/rcu/tree.c:2206 [inline]
                   rcu_core+0x59f/0x1370 kernel/rcu/tree.c:2433
                   __do_softirq+0x26c/0x9f7 kernel/softirq.c:292
                   invoke_softirq kernel/softirq.c:373 [inline]
                   irq_exit+0x192/0x1d0 kernel/softirq.c:413
                   exiting_irq arch/x86/include/asm/apic.h:546 [inline]
                   smp_apic_timer_interrupt+0x19e/0x600 arch/x86/kernel/apic/apic.c:1140
                   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
                   preempt_count_add+0x0/0x140 kernel/sched/core.c:6758
                   __raw_spin_lock include/linux/spinlock_api_smp.h:141 [inline]
                   _raw_spin_lock+0xe/0x40 kernel/locking/spinlock.c:151
                   spin_lock include/linux/spinlock.h:353 [inline]
                   lockref_put_or_lock+0x14/0x80 lib/lockref.c:174
                   fast_dput fs/dcache.c:728 [inline]
                   dput+0x4a3/0xdf0 fs/dcache.c:846
                   path_put+0x2d/0x60 fs/namei.c:482
                   vfs_statx+0x14d/0x1e0 fs/stat.c:202
                   vfs_stat include/linux/fs.h:3279 [inline]
                   __do_sys_newstat+0x96/0x120 fs/stat.c:351
                   do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
                   entry_SYSCALL_64_after_hwframe+0x49/0xb3
 }
 ... key      at: [<ffffffff8c67af20>] __key.55262+0x0/0x40
 ... acquired at:
   lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:353 [inline]
   aio_poll fs/aio.c:1767 [inline]
   __io_submit_one fs/aio.c:1841 [inline]
   io_submit_one+0xc1b/0x2ec0 fs/aio.c:1878
   __do_compat_sys_io_submit fs/aio.c:1979 [inline]
   __se_compat_sys_io_submit fs/aio.c:1949 [inline]
   __ia32_compat_sys_io_submit+0x1bf/0x530 fs/aio.c:1949
   do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
   do_fast_syscall_32+0x270/0xe90 arch/x86/entry/common.c:396
   entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139


the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
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
                    path_openat+0x25a/0x27d0 fs/namei.c:3342
                    do_filp_open+0x192/0x260 fs/namei.c:3373
                    do_sys_openat2+0x585/0x7d0 fs/open.c:1148
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
                    path_openat+0x25a/0x27d0 fs/namei.c:3342
                    do_filp_open+0x192/0x260 fs/namei.c:3373
                    do_sys_openat2+0x585/0x7d0 fs/open.c:1148
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
 ... key      at: [<ffffffff8bbbe680>] __key.53786+0x0/0x40
 ... acquired at:
   lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:353 [inline]
   aio_poll fs/aio.c:1767 [inline]
   __io_submit_one fs/aio.c:1841 [inline]
   io_submit_one+0xc1b/0x2ec0 fs/aio.c:1878
   __do_compat_sys_io_submit fs/aio.c:1979 [inline]
   __se_compat_sys_io_submit fs/aio.c:1949 [inline]
   __ia32_compat_sys_io_submit+0x1bf/0x530 fs/aio.c:1949
   do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
   do_fast_syscall_32+0x270/0xe90 arch/x86/entry/common.c:396
   entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139


stack backtrace:
CPU: 0 PID: 9005 Comm: syz-executor.0 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_bad_irq_dependency kernel/locking/lockdep.c:2132 [inline]
 check_irq_usage.cold+0x566/0x6de kernel/locking/lockdep.c:2330
 check_prev_add kernel/locking/lockdep.c:2519 [inline]
 check_prevs_add kernel/locking/lockdep.c:2620 [inline]
 validate_chain kernel/locking/lockdep.c:3237 [inline]
 __lock_acquire+0x2c39/0x4e00 kernel/locking/lockdep.c:4344
 lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:353 [inline]
 aio_poll fs/aio.c:1767 [inline]
 __io_submit_one fs/aio.c:1841 [inline]
 io_submit_one+0xc1b/0x2ec0 fs/aio.c:1878
 __do_compat_sys_io_submit fs/aio.c:1979 [inline]
 __se_compat_sys_io_submit fs/aio.c:1949 [inline]
 __ia32_compat_sys_io_submit+0x1bf/0x530 fs/aio.c:1949
 do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
 do_fast_syscall_32+0x270/0xe90 arch/x86/entry/common.c:396
 entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

