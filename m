Return-Path: <linux-fsdevel+bounces-6345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC9C8161D9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 20:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936AF282BDF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 19:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2862481B1;
	Sun, 17 Dec 2023 19:50:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB2E481A0
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Dec 2023 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7ccd6778fso58238239f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Dec 2023 11:50:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702842623; x=1703447423;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnxmCXdu8X8my6WRLXsEZ8nqurme9ZtqlNqBhv3jdoM=;
        b=HvR/Ukwf8b0cCxfFLLkZu+yqxLAo/b/D0snLm0rJGjHBAKJDTiAndwpK9lvA+fcF1W
         zWdF4tL8c9B/hggtaYpFMtOvWaeS9RfSgRqoJwt9LxdGHcUpSzvtSPnKCweBySaOPA9T
         rmePFlKgu3o2+5sIl9xcNfKyWP8UPX7UxiJaFuJSChZCsHp+fyla/FcGv532huT4dGhZ
         p/QiR7RxvevCcrBf+N4/Go3J+T0rwDN9EOQvZiWo6smwuJEOKGgLwdtUh9LIMYQiLEJ9
         3HKZIOzGrriKSGmf+JzaBXuA/mHOsUUgTzvD3yLGoGEjWnYnE6N4YhRxq8f0E+e0dZEV
         wVaA==
X-Gm-Message-State: AOJu0YztSaQSWqdMnGiKZF5Mcb+FGgmvWGQRKO7ZrMHt1g0QVtBI84/l
	iIuOWMLhZG5OMipqCReN6uQz9872SojCtj8GeR1xUQdpsPry
X-Google-Smtp-Source: AGHT+IE4DXKTsu02yWpMJAhWG0+ahgC5cQurqYWLK3RNddMAzr7ACcgqjNLNG0af2JpObw/Szh2/alVlk3IJH3M/i0oiudm/hNqi
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:33a9:b0:469:22db:6827 with SMTP id
 h41-20020a05663833a900b0046922db6827mr498993jav.6.1702842623746; Sun, 17 Dec
 2023 11:50:23 -0800 (PST)
Date: Sun, 17 Dec 2023 11:50:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b26907060cb9f1f5@google.com>
Subject: [syzbot] [reiserfs?] possible deadlock in __run_timers
From: syzbot <syzbot+a3981d3c93cde53224be@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    88035e5694a8 Merge tag 'hid-for-linus-2023121201' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13467cc6e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be2bd0a72b52d4da
dashboard link: https://syzkaller.appspot.com/bug?extid=a3981d3c93cde53224be
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15befbfee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b20006e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce88672b9863/disk-88035e56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7509f7d0b113/vmlinux-88035e56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7465dc030e58/bzImage-88035e56.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a5134eb638e9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3981d3c93cde53224be@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.7.0-rc5-syzkaller-00042-g88035e5694a8 #0 Not tainted
------------------------------------------------------
syz-executor221/5060 is trying to acquire lock:
ffffffff8ceb8ea0 (console_owner){..-.}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:1962 [inline]
ffffffff8ceb8ea0 (console_owner){..-.}-{0:0}, at: vprintk_emit+0x313/0x5f0 kernel/printk/printk.c:2302

but task is already holding lock:
ffff8880b98297d8 (&base->lock){-.-.}-{2:2}, at: expire_timers kernel/time/timer.c:1752 [inline]
ffff8880b98297d8 (&base->lock){-.-.}-{2:2}, at: __run_timers+0x76c/0xb20 kernel/time/timer.c:2022

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&base->lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       lock_timer_base+0x5d/0x200 kernel/time/timer.c:999
       __mod_timer+0x420/0xea0 kernel/time/timer.c:1080
       worker_enter_idle+0x404/0x550 kernel/workqueue.c:945
       create_worker+0x467/0x730 kernel/workqueue.c:2213
       maybe_create_worker kernel/workqueue.c:2459 [inline]
       manage_workers kernel/workqueue.c:2511 [inline]
       worker_thread+0xca1/0x1290 kernel/workqueue.c:2756
       kthread+0x2c6/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

-> #3 (&pool->lock){-.-.}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       __queue_work+0x399/0x11d0 kernel/workqueue.c:1760
       queue_work_on+0xed/0x110 kernel/workqueue.c:1831
       queue_work include/linux/workqueue.h:562 [inline]
       rpm_suspend+0x121b/0x16f0 drivers/base/power/runtime.c:660
       rpm_idle+0x578/0x6e0 drivers/base/power/runtime.c:534
       __pm_runtime_idle+0xbe/0x160 drivers/base/power/runtime.c:1102
       pm_runtime_put include/linux/pm_runtime.h:460 [inline]
       __device_attach+0x382/0x4b0 drivers/base/dd.c:1048
       bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
       device_add+0x117e/0x1aa0 drivers/base/core.c:3625
       serial_base_port_add+0x353/0x4b0 drivers/tty/serial/serial_base_bus.c:178
       serial_core_port_device_add drivers/tty/serial/serial_core.c:3316 [inline]
       serial_core_register_port+0x137/0x1af0 drivers/tty/serial/serial_core.c:3357
       serial8250_register_8250_port+0x140d/0x2080 drivers/tty/serial/8250/8250_core.c:1139
       serial_pnp_probe+0x47d/0x880 drivers/tty/serial/8250/8250_pnp.c:478
       pnp_device_probe+0x2a3/0x4c0 drivers/pnp/driver.c:111
       call_driver_probe drivers/base/dd.c:579 [inline]
       really_probe+0x234/0xc90 drivers/base/dd.c:658
       __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
       driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
       __driver_attach+0x274/0x570 drivers/base/dd.c:1216
       bus_for_each_dev+0x13c/0x1d0 drivers/base/bus.c:368
       bus_add_driver+0x2e9/0x630 drivers/base/bus.c:673
       driver_register+0x15c/0x4a0 drivers/base/driver.c:246
       serial8250_init+0xba/0x4b0 drivers/tty/serial/8250/8250_core.c:1240
       do_one_initcall+0x11c/0x650 init/main.c:1236
       do_initcall_level init/main.c:1298 [inline]
       do_initcalls init/main.c:1314 [inline]
       do_basic_setup init/main.c:1333 [inline]
       kernel_init_freeable+0x687/0xc10 init/main.c:1551
       kernel_init+0x1c/0x2a0 init/main.c:1441
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

-> #2 (&dev->power.lock){-...}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       __pm_runtime_resume+0xab/0x170 drivers/base/power/runtime.c:1169
       pm_runtime_get include/linux/pm_runtime.h:408 [inline]
       __uart_start+0x1b2/0x470 drivers/tty/serial/serial_core.c:148
       uart_write+0x2ff/0x5b0 drivers/tty/serial/serial_core.c:616
       process_output_block drivers/tty/n_tty.c:574 [inline]
       n_tty_write+0x422/0x1130 drivers/tty/n_tty.c:2379
       iterate_tty_write drivers/tty/tty_io.c:1021 [inline]
       file_tty_write.constprop.0+0x519/0x9b0 drivers/tty/tty_io.c:1092
       tty_write drivers/tty/tty_io.c:1113 [inline]
       redirected_tty_write drivers/tty/tty_io.c:1136 [inline]
       redirected_tty_write+0xa6/0xc0 drivers/tty/tty_io.c:1116
       call_write_iter include/linux/fs.h:2020 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x64f/0xdf0 fs/read_write.c:584
       ksys_write+0x12f/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #1 (&port_lock_key){-...}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
       serial8250_console_write+0xa7c/0x1060 drivers/tty/serial/8250/8250_port.c:3403
       console_emit_next_record kernel/printk/printk.c:2901 [inline]
       console_flush_all+0x4d5/0xd60 kernel/printk/printk.c:2967
       console_unlock+0x10c/0x260 kernel/printk/printk.c:3036
       vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2303
       vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2328
       register_console+0xa74/0x1060 kernel/printk/printk.c:3542
       univ8250_console_init+0x35/0x50 drivers/tty/serial/8250/8250_core.c:717
       console_init+0xba/0x5d0 kernel/printk/printk.c:3688
       start_kernel+0x25a/0x480 init/main.c:1008
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:555
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:536
       secondary_startup_64_no_verify+0x166/0x16b

-> #0 (console_owner){..-.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2433/0x3b20 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
       console_trylock_spinning kernel/printk/printk.c:1962 [inline]
       vprintk_emit+0x328/0x5f0 kernel/printk/printk.c:2302
       vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2328
       __report_bug lib/bug.c:195 [inline]
       report_bug+0x4a8/0x580 lib/bug.c:219
       handle_bug+0x3d/0x70 arch/x86/kernel/traps.c:237
       exc_invalid_op+0x17/0x40 arch/x86/kernel/traps.c:258
       asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:568
       expire_timers kernel/time/timer.c:1738 [inline]
       __run_timers+0x8d2/0xb20 kernel/time/timer.c:2022
       run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
       __do_softirq+0x21a/0x8de kernel/softirq.c:553
       invoke_softirq kernel/softirq.c:427 [inline]
       __irq_exit_rcu kernel/softirq.c:632 [inline]
       irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
       sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
       asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
       memmove+0x44/0x1b0 arch/x86/lib/memmove_64.S:67
       leaf_insert_into_buf+0x303/0xa30 fs/reiserfs/lbalance.c:933
       balance_leaf_new_nodes_insert fs/reiserfs/do_balan.c:1001 [inline]
       balance_leaf_new_nodes fs/reiserfs/do_balan.c:1243 [inline]
       balance_leaf+0x2ff4/0xcda0 fs/reiserfs/do_balan.c:1450
       do_balance+0x337/0x840 fs/reiserfs/do_balan.c:1888
       reiserfs_insert_item+0xadd/0xe20 fs/reiserfs/stree.c:2260
       indirect2direct+0x6d8/0xa20 fs/reiserfs/tail_conversion.c:283
       maybe_indirect_to_direct fs/reiserfs/stree.c:1585 [inline]
       reiserfs_cut_from_item+0xa82/0x1a10 fs/reiserfs/stree.c:1692
       reiserfs_do_truncate+0x672/0x10b0 fs/reiserfs/stree.c:1971
       reiserfs_truncate_file+0x1bf/0x940 fs/reiserfs/inode.c:2302
       reiserfs_file_release+0xae3/0xc40 fs/reiserfs/file.c:109
       __fput+0x270/0xbb0 fs/file_table.c:394
       task_work_run+0x14d/0x240 kernel/task_work.c:180
       exit_task_work include/linux/task_work.h:38 [inline]
       do_exit+0xa92/0x2ae0 kernel/exit.c:871
       do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
       __do_sys_exit_group kernel/exit.c:1032 [inline]
       __se_sys_exit_group kernel/exit.c:1030 [inline]
       __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1030
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

other info that might help us debug this:

Chain exists of:
  console_owner --> &pool->lock --> &base->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&base->lock);
                               lock(&pool->lock);
                               lock(&base->lock);
  lock(console_owner);

 *** DEADLOCK ***

3 locks held by syz-executor221/5060:
 #0: ffff8880766e0df8 (&ei->tailpack){+.+.}-{3:3}, at: reiserfs_file_release+0xdd/0xc40 fs/reiserfs/file.c:41
 #1: ffff888078f6b090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock_nested+0x69/0xe0 fs/reiserfs/lock.c:78
 #2: ffff8880b98297d8 (&base->lock){-.-.}-{2:2}, at: expire_timers kernel/time/timer.c:1752 [inline]
 #2: ffff8880b98297d8 (&base->lock){-.-.}-{2:2}, at: __run_timers+0x76c/0xb20 kernel/time/timer.c:2022

stack backtrace:
CPU: 0 PID: 5060 Comm: syz-executor221 Not tainted 6.7.0-rc5-syzkaller-00042-g88035e5694a8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x317/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2433/0x3b20 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
 console_trylock_spinning kernel/printk/printk.c:1962 [inline]
 vprintk_emit+0x328/0x5f0 kernel/printk/printk.c:2302
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2328
 __report_bug lib/bug.c:195 [inline]
 report_bug+0x4a8/0x580 lib/bug.c:219
 handle_bug+0x3d/0x70 arch/x86/kernel/traps.c:237
 exc_invalid_op+0x17/0x40 arch/x86/kernel/traps.c:258
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:568
RIP: 0010:expire_timers kernel/time/timer.c:1738 [inline]
RIP: 0010:__run_timers+0x8d2/0xb20 kernel/time/timer.c:2022
Code: 6f 48 e8 91 9d 11 00 89 de 31 ff 83 eb 01 e8 f5 98 11 00 8b 44 24 18 85 c0 0f 85 50 fc ff ff e9 50 fb ff ff e8 6f 9d 11 00 90 <0f> 0b 90 e9 b3 fc ff ff e8 61 9d 11 00 90 0f 0b 90 e9 37 fd ff ff
RSP: 0018:ffffc90000007d88 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88807e909300 RCX: ffffffff8175f032
RDX: ffff888023565940 RSI: ffffffff8175f091 RDI: ffff88807e909318
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: ffffc90000007e60
R13: ffffc90000007e60 R14: dffffc0000000000 R15: ffff8880b98297c0
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:memmove+0x44/0x1b0 arch/x86/lib/memmove_64.S:68
Code: 00 48 83 fa 20 0f 82 01 01 00 00 66 0f 1f 44 00 00 48 81 fa a8 02 00 00 72 05 40 38 fe 74 47 48 83 ea 20 48 83 ea 20 4c 8b 1e <4c> 8b 56 08 4c 8b 4e 10 4c 8b 46 18 48 8d 76 20 4c 89 1f 4c 89 57
RSP: 0018:ffffc900039feb60 EFLAGS: 00000282
RAX: ffff88807c4ac0c0 RBX: 0000000000000006 RCX: 0000000000000000
RDX: ffffffffe7ab3e98 RSI: ffff8880949f9040 RDI: ffff8880949f8100
RBP: 00000000000000c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000f18
R13: ffff8880765cd938 R14: 0000000000000000 R15: ffff88807c4ac0a8
 leaf_insert_into_buf+0x303/0xa30 fs/reiserfs/lbalance.c:933
 balance_leaf_new_nodes_insert fs/reiserfs/do_balan.c:1001 [inline]
 balance_leaf_new_nodes fs/reiserfs/do_balan.c:1243 [inline]
 balance_leaf+0x2ff4/0xcda0 fs/reiserfs/do_balan.c:1450
 do_balance+0x337/0x840 fs/reiserfs/do_balan.c:1888
 reiserfs_insert_item+0xadd/0xe20 fs/reiserfs/stree.c:2260
 indirect2direct+0x6d8/0xa20 fs/reiserfs/tail_conversion.c:283
 maybe_indirect_to_direct fs/reiserfs/stree.c:1585 [inline]
 reiserfs_cut_from_item+0xa82/0x1a10 fs/reiserfs/stree.c:1692
 reiserfs_do_truncate+0x672/0x10b0 fs/reiserfs/stree.c:1971
 reiserfs_truncate_file+0x1bf/0x940 fs/reiserfs/inode.c:2302
 reiserfs_file_release+0xae3/0xc40 fs/reiserfs/file.c:109
 __fput+0x270/0xbb0 fs/file_table.c:394
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa92/0x2ae0 kernel/exit.c:871
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fb4f48ae339
Code: Unable to access opcode bytes at 0x7fb4f48ae30f.
RSP: 002b:00007fff27e4b078 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb4f48ae339
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fb4f49292b0 R08: ffffffffffffffb8 R09: 00007fb4f487bbf0
R10: 00007fff27e4b028 R11: 0000000000000246 R12: 00007fb4f49292b0
R13: 0000000000000000 R14: 00007fb4f492a020 R15: 00007fb4f487cc70
 </TASK>
WARNING: CPU: 0 PID: 5060 at kernel/time/timer.c:1738 expire_timers kernel/time/timer.c:1738 [inline]
WARNING: CPU: 0 PID: 5060 at kernel/time/timer.c:1738 __run_timers+0x8d2/0xb20 kernel/time/timer.c:2022
Modules linked in:
CPU: 0 PID: 5060 Comm: syz-executor221 Not tainted 6.7.0-rc5-syzkaller-00042-g88035e5694a8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:expire_timers kernel/time/timer.c:1738 [inline]
RIP: 0010:__run_timers+0x8d2/0xb20 kernel/time/timer.c:2022
Code: 6f 48 e8 91 9d 11 00 89 de 31 ff 83 eb 01 e8 f5 98 11 00 8b 44 24 18 85 c0 0f 85 50 fc ff ff e9 50 fb ff ff e8 6f 9d 11 00 90 <0f> 0b 90 e9 b3 fc ff ff e8 61 9d 11 00 90 0f 0b 90 e9 37 fd ff ff
RSP: 0018:ffffc90000007d88 EFLAGS: 00010046

RAX: 0000000000000000 RBX: ffff88807e909300 RCX: ffffffff8175f032
RDX: ffff888023565940 RSI: ffffffff8175f091 RDI: ffff88807e909318
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000003 R12: ffffc90000007e60
R13: ffffc90000007e60 R14: dffffc0000000000 R15: ffff8880b98297c0
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb4f48f7d08 CR3: 000000000cd77000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:memmove+0x44/0x1b0 arch/x86/lib/memmove_64.S:68
Code: 00 48 83 fa 20 0f 82 01 01 00 00 66 0f 1f 44 00 00 48 81 fa a8 02 00 00 72 05 40 38 fe 74 47 48 83 ea 20 48 83 ea 20 4c 8b 1e <4c> 8b 56 08 4c 8b 4e 10 4c 8b 46 18 48 8d 76 20 4c 89 1f 4c 89 57
RSP: 0018:ffffc900039feb60 EFLAGS: 00000282

RAX: ffff88807c4ac0c0 RBX: 0000000000000006 RCX: 0000000000000000
RDX: ffffffffe7ab3e98 RSI: ffff8880949f9040 RDI: ffff8880949f8100
RBP: 00000000000000c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000f18
R13: ffff8880765cd938 R14: 0000000000000000 R15: ffff88807c4ac0a8
 leaf_insert_into_buf+0x303/0xa30 fs/reiserfs/lbalance.c:933
 balance_leaf_new_nodes_insert fs/reiserfs/do_balan.c:1001 [inline]
 balance_leaf_new_nodes fs/reiserfs/do_balan.c:1243 [inline]
 balance_leaf+0x2ff4/0xcda0 fs/reiserfs/do_balan.c:1450
 do_balance+0x337/0x840 fs/reiserfs/do_balan.c:1888
 reiserfs_insert_item+0xadd/0xe20 fs/reiserfs/stree.c:2260
 indirect2direct+0x6d8/0xa20 fs/reiserfs/tail_conversion.c:283
 maybe_indirect_to_direct fs/reiserfs/stree.c:1585 [inline]
 reiserfs_cut_from_item+0xa82/0x1a10 fs/reiserfs/stree.c:1692
 reiserfs_do_truncate+0x672/0x10b0 fs/reiserfs/stree.c:1971
 reiserfs_truncate_file+0x1bf/0x940 fs/reiserfs/inode.c:2302
 reiserfs_file_release+0xae3/0xc40 fs/reiserfs/file.c:109
 __fput+0x270/0xbb0 fs/file_table.c:394
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa92/0x2ae0 kernel/exit.c:871
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fb4f48ae339
Code: Unable to access opcode bytes at 0x7fb4f48ae30f.
RSP: 002b:00007fff27e4b078 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb4f48ae339
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fb4f49292b0 R08: ffffffffffffffb8 R09: 00007fb4f487bbf0
R10: 00007fff27e4b028 R11: 0000000000000246 R12: 00007fb4f49292b0
R13: 0000000000000000 R14: 00007fb4f492a020 R15: 00007fb4f487cc70
 </TASK>
irq event stamp: 46901
hardirqs last  enabled at (46900): [<ffffffff8a83b6ee>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (46900): [<ffffffff8a83b6ee>] _raw_spin_unlock_irqrestore+0x4e/0x70 kernel/locking/spinlock.c:194
hardirqs last disabled at (46901): [<ffffffff8a83b445>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
hardirqs last disabled at (46901): [<ffffffff8a83b445>] _raw_spin_lock_irq+0x45/0x50 kernel/locking/spinlock.c:170
softirqs last  enabled at (46892): [<ffffffff8a83e307>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (46892): [<ffffffff8a83e307>] __do_softirq+0x597/0x8de kernel/softirq.c:582
softirqs last disabled at (46895): [<ffffffff814f9757>] invoke_softirq kernel/softirq.c:427 [inline]
softirqs last disabled at (46895): [<ffffffff814f9757>] __irq_exit_rcu kernel/softirq.c:632 [inline]
softirqs last disabled at (46895): [<ffffffff814f9757>] irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	48 83 fa 20          	cmp    $0x20,%rdx
   4:	0f 82 01 01 00 00    	jb     0x10b
   a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  10:	48 81 fa a8 02 00 00 	cmp    $0x2a8,%rdx
  17:	72 05                	jb     0x1e
  19:	40 38 fe             	cmp    %dil,%sil
  1c:	74 47                	je     0x65
  1e:	48 83 ea 20          	sub    $0x20,%rdx
  22:	48 83 ea 20          	sub    $0x20,%rdx
  26:	4c 8b 1e             	mov    (%rsi),%r11
* 29:	4c 8b 56 08          	mov    0x8(%rsi),%r10 <-- trapping instruction
  2d:	4c 8b 4e 10          	mov    0x10(%rsi),%r9
  31:	4c 8b 46 18          	mov    0x18(%rsi),%r8
  35:	48 8d 76 20          	lea    0x20(%rsi),%rsi
  39:	4c 89 1f             	mov    %r11,(%rdi)
  3c:	4c                   	rex.WR
  3d:	89                   	.byte 0x89
  3e:	57                   	push   %rdi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

