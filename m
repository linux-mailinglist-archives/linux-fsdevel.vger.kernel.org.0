Return-Path: <linux-fsdevel+bounces-10577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D4084C67B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 09:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDE91C21DBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 08:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11C3208DA;
	Wed,  7 Feb 2024 08:44:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B320A208B0
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295464; cv=none; b=WHbYL+uV27Zpvsbt2fQ42+SEvdpaROc4D7bJMIOEoR2y8jDJcIAftlu38g3yVAZx0FYGLRUZNw3L5ntuvclZRc+lAxv6WF4lpMtomnKonIE+z89spHWPnr4ZJpiuYGGEwAOO38NIZ7NHl1VU+AM1NXjpA4L9BRiTsmeklnWSTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295464; c=relaxed/simple;
	bh=urWyMor9PzUhawbt1aDcluue/V96UkIeCSF6aTfwkEY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X8UqnULMbXjVqhM5Z/KSo36CCwONNlOPjtiCiDh7/TtlPSItdRwdk939mvXg5sjjlAeTdlFG8zZV5I5DIwUfcFFMBeS7jGD/qDQO0BFTEXf8XfMmUI63sHzU0TzJtA1fT/PmsEPE87UFSiWTgPKcAffccJDFiJ+mcUYfXb0nUjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c2c96501e6so24503739f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 00:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707295462; x=1707900262;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9PsWuNaKPQWBOwb1Q8TS48CwB4K4Y/qGlpzzqB8naz0=;
        b=KbUgGtEVwxSf85SYwr3OjXmksoqU3EIb2jI97tbGtoynychfyMhDuOqZztR/bZXC4O
         VBe0ulnu/NSU40u1OQYaWLeEP33rpXd+M7gyorUI56Scvp2tigz7rl0VVIPa8gpngD9H
         Gk8bjOjCz1N4QwQNN9HmnTXjkSIO0HCpqovtsmjulOeyXZjJpouuv1xzwFx9/NsImFHE
         huIUwINUtmF4/ZYAE7jwsHr8sliEO01ux1Yzsu7JMV1gQ8DehgeZVr/vqb8aV4iBLdz8
         Vq/S88JhChkPFkquFv3Cgogeqqi3AFlrVDUiYLT+jwPUjQqjOZihinC9ssYBMva4qPVW
         lvNg==
X-Gm-Message-State: AOJu0YzcMe6483DDw8pSqpEXCbHDTailvov7MQhmmyN0FF01gyJDNQBN
	IoyV42ubIqSmAmXwznCLmDEIMDHKqztP/HjF1DybIWqckLkY5S30eF5gjBMN+YNUdrPfG6S/tWU
	WRprtQX6UuOzj2QsgM+YwMy767rQY1SdXxKjA7E6svAjToov0mlwnCFM=
X-Google-Smtp-Source: AGHT+IHg/p0y5xPt2x4+3qbFtmEedzqTWvFWQUpezzkAqeOzs+9ZrTwRjkNRYNs0Ktt1rawFeoTL+lLXdzYwOU2vzbmXPSdfT6KT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15d0:b0:7bf:ffe2:3537 with SMTP id
 f16-20020a05660215d000b007bfffe23537mr181274iow.3.1707295461875; Wed, 07 Feb
 2024 00:44:21 -0800 (PST)
Date: Wed, 07 Feb 2024 00:44:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088268a0610c6b3ae@google.com>
Subject: [syzbot] [xfs?] INFO: task hung in xfs_inodegc_flush
From: syzbot <syzbot+0260338e3eff65854d1f@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    076d56d74f17 Add linux-next specific files for 20240202
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=173b568fe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=428086ff1c010d9f
dashboard link: https://syzkaller.appspot.com/bug?extid=0260338e3eff65854d1f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148b3c9fe80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13811004180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dece45d1a4b5/disk-076d56d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4921e269b178/vmlinux-076d56d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a9156da9091/bzImage-076d56d7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9938609b8cc3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0260338e3eff65854d1f@syzkaller.appspotmail.com

INFO: task syz-executor218:5106 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor218 state:D stack:18928 pid:5106  tgid:5106  ppid:5102   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17df/0x4a40 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6804 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6819
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2159
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 __flush_workqueue+0x730/0x1630 kernel/workqueue.c:3617
 xfs_inodegc_wait_all fs/xfs/xfs_icache.c:465 [inline]
 xfs_inodegc_flush+0xe1/0x3e0 fs/xfs/xfs_icache.c:1912
 xfs_unmountfs+0x25/0x200 fs/xfs/xfs_mount.c:1064
 xfs_fs_put_super+0x65/0x140 fs/xfs/xfs_super.c:1136
 generic_shutdown_super+0x136/0x2d0 fs/super.c:646
 kill_block_super+0x44/0x90 fs/super.c:1680
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2026
 deactivate_locked_super+0xc4/0x130 fs/super.c:477
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:108 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:212
 do_syscall_64+0x10a/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f1a396ed8f7
RSP: 002b:00007ffec055f888 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f1a396ed8f7
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffec055f940
RBP: 00007ffec055f940 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffec05609b0
R13: 000055555739d6c0 R14: 00000000000c93c9 R15: 0000000000000108
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by getty/4817:
 #0: ffff88802a9230a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
1 lock held by syz-executor218/5106:
 #0: ffff88807f4d40e0 (&type->s_umount_key#48){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88807f4d40e0 (&type->s_umount_key#48){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88807f4d40e0 (&type->s_umount_key#48){+.+.}-{3:3}, at: deactivate_super+0xb5/0xf0 fs/super.c:509

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfb0/0xff0 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
NMI backtrace for cpu 0 skipped: idling at acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:112


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

