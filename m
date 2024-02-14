Return-Path: <linux-fsdevel+bounces-11557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F1D854AFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 15:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B83D28E6FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5858955E5E;
	Wed, 14 Feb 2024 14:00:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA35054BD3
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919241; cv=none; b=Ys8Qtc2W11aJjeliVsztCQxwYOgtMncqRGNPjvvgWb5xpU4uBzvbz9cWID/8D+c6b5cVkob0Ibrn20qn7crHOjG6ztBNAWP2hhiNEAFH4dQgWktLOcSurA7hgbZ4RknaiZzYOjD6IEp8Nje3RsBGoBFxWqur8RB2+Hag5d5AFAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919241; c=relaxed/simple;
	bh=uvElZyMP2rcFdjIIyKiJsBHwJfuAl/XGHulLQCgJLwo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rq8KY7FdGjiDymHmxHPkwqooyTp/l5YrdgD8iV2wdPMI7vSvqgHIEtc7m2Jr0yYdNMsPSL4gG3L+mL8BYtOkT6rcqE8zNvV4msdhQm/rg2CeiKBlnV5/I9p+mbeM8dMfhGgDCwVexg8vUfpEeY7ZBCgXnFsv4se8yGV4WjNpGVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7baa6cc3af2so658637339f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 06:00:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707919238; x=1708524038;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0DwJ3ovGKUUkG4BQaQbOPgpMToCEkMd6gleXFbwlt4=;
        b=IpesqRZ+ap+D7xCRFW3DH4igqLE1lasCKQYQSlHH6kQ3ftOTXTrJ/9ehJJrKRwuMlT
         g3aB/yBOzig/mDskTj/cSYgNl4Px28kvBqqYYd/7KR+qgaiaDd5gj+N1YQUcUfojPzsz
         D9+uzGP15oj7bDJklHq3N9ShUcDW0P8fD8Pqun4mSYKeR53gjETiZG5X4nyARbQqvgoN
         grKv0Alxmptj4oxlc1pGabT69AHJuOCE65mRg0/N9OLqcQGysejfgTAtC2oAIam3cG1A
         MT7sltpssR8maGsss/lO8jVXn7b1nOUwK6auK3e1BRTiopmILMltp8dCYJ8fsQQwkld9
         7DLA==
X-Forwarded-Encrypted: i=1; AJvYcCV0x1p6OJphVq93ClFh0k1y7l1TtajvbpVExx9h3vqpMzvh0gm7+L3HJpcRz0k1qeyzE99C6ej3+JQXdK2YfLDtSwhLizogNo1Ex9Aj7Q==
X-Gm-Message-State: AOJu0Yychn2lCtZljl/Re/uZu/N7IKpFD0MUcr5qEMPKMcDUMyx5hzW7
	fCUe551FkxCc7WhGsqDeIVltULziAoggKZa/Jrbk9FvfH9R1ULXS3SM8RWQV6qY/AS6lqmFlk8S
	FqYa/xcbROI6cRk9PfhijsqOwCWAriId8AzdS/rPo2bS1hBlmV4WKSSM=
X-Google-Smtp-Source: AGHT+IFfM3IyfYL7DR/oOjtskYQ5YXHpq+Hqnvw5TVVTShYOIGteBsq6mzL1IjRzl2y6NXgznRrBVakr1ynXYMcudpd0f0OLpNPW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0a:b0:363:7bac:528e with SMTP id
 s10-20020a056e021a0a00b003637bac528emr175273ild.1.1707919237932; Wed, 14 Feb
 2024 06:00:37 -0800 (PST)
Date: Wed, 14 Feb 2024 06:00:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b7330061157ef4c@google.com>
Subject: [syzbot] [squashfs?] INFO: task hung in evict (2)
From: syzbot <syzbot+65b1e2d8f2d618a93e96@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, hch@lst.de, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	phillip@squashfs.org.uk, squashfs-devel@lists.sourceforge.net, 
	syzkaller-bugs@googlegroups.com, vincent.whitchurch@axis.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c664e16bb1ba Merge tag 'docs-6.8-fixes2' of git://git.lwn...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13d7d01c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d7c92dd8d5c7a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=65b1e2d8f2d618a93e96
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1778ca10180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12762720180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3bccfc692e21/disk-c664e16b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/197da43ba3e0/vmlinux-c664e16b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b24c7a9a54fd/bzImage-c664e16b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0988c022ebbd/mount_0.gz

The issue was bisected to:

commit e994f5b677ee016a2535d9df826315122da1ae65
Author: Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Wed May 17 14:18:19 2023 +0000

    squashfs: cache partial compressed blocks

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1101e584180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1301e584180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1501e584180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65b1e2d8f2d618a93e96@syzkaller.appspotmail.com
Fixes: e994f5b677ee ("squashfs: cache partial compressed blocks")

INFO: task syz-executor382:5067 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc4-syzkaller-00005-gc664e16bb1ba #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor382 state:D stack:24216 pid:5067  tgid:5067  ppid:5064   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6817
 io_schedule+0x8c/0x110 kernel/sched/core.c:9023
 folio_wait_bit_common+0x881/0x12b0 mm/filemap.c:1274
 truncate_inode_pages_range+0xa8b/0xf70 mm/truncate.c:412
 evict+0x2bd/0x630 fs/inode.c:667
 dispose_list fs/inode.c:698 [inline]
 evict_inodes+0x5f8/0x690 fs/inode.c:748
 generic_shutdown_super+0x9d/0x2d0 fs/super.c:631
 kill_block_super+0x44/0x90 fs/super.c:1680
 deactivate_locked_super+0xc6/0x130 fs/super.c:477
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x250/0x310 kernel/task_work.c:180
 ptrace_notify+0x2d1/0x380 kernel/signal.c:2390
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work+0xbb/0x170 kernel/entry/common.c:167
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:194 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:199 [inline]
 syscall_exit_to_user_mode+0x27f/0x370 kernel/entry/common.c:212
 do_syscall_64+0x108/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f0f31f293c7
RSP: 002b:00007fff0cb79da8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f0f31f293c7
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007fff0cb79e60
RBP: 00007fff0cb79e60 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000202 R12: 00007fff0cb7aed0
R13: 00005555560276c0 R14: 0000000000000007 R15: 431bde82d7b634db
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/28:
 #0: ffffffff8e130ae0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e130ae0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e130ae0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by getty/4820:
 #0: ffff88802fed20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b4/0x1e10 drivers/tty/n_tty.c:2201
1 lock held by syz-executor382/5067:
 #0: ffff88801193e0e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88801193e0e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88801193e0e0 (&type->s_umount_key#42){+.+.}-{3:3}, at: deactivate_super+0xb5/0xf0 fs/super.c:509

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.8.0-rc4-syzkaller-00005-gc664e16bb1ba #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfaf/0xff0 kernel/hung_task.c:379
 kthread+0x2f1/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 60 Comm: kworker/u4:4 Not tainted 6.8.0-rc4-syzkaller-00005-gc664e16bb1ba #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:smp_call_function_many_cond+0x2200/0x2960 kernel/smp.c:778
Code: 0f 85 03 02 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 01 db e9 09 e8 9c c6 0b 00 e9 47 e0 ff ff 65 8b 1d c8 e1 7a 7e <31> ff 89 de e8 c7 ca 0b 00 85 db 0f 84 12 01 00 00 e8 7a c6 0b 00
RSP: 0018:ffffc900015b7720 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff94482303
RDX: ffff8880187d0000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900015b7920 R08: ffffffff818797a2 R09: 1ffffffff1f0ab4d
R10: dffffc0000000000 R11: fffffbfff1f0ab4e R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff8f855a68 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005612dea05600 CR3: 000000002bc1a000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1023
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2087 [inline]
 text_poke_bp_batch+0x726/0xb30 arch/x86/kernel/alternative.c:2359
 text_poke_flush arch/x86/kernel/alternative.c:2488 [inline]
 text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2495
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_disable_cpuslocked+0xce/0x1c0 kernel/jump_label.c:235
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate+0x1b8/0x250 mm/kfence/core.c:831
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x915/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2f1/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.016 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

