Return-Path: <linux-fsdevel+bounces-49708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 829BDAC1B93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 06:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7821B63E4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 04:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B44822371C;
	Fri, 23 May 2025 04:46:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D59019DF4A
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 04:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747975597; cv=none; b=AQpmwDlM5LzY+vEAGUqieRbrbDKfcLQ9j5i8nbgoLOKqJhA9pomy/4qJHZAU+IXrE2DmQHg+E13/TOK4AEnO1HR+bKggzZliBpusYF9xI1yWB3EijRplptoSSGdhc3oPXu4s9W9EdjqDq5pios6mAIwX6XCviQDnshLLaqYEROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747975597; c=relaxed/simple;
	bh=XAqPNcQTWX91zcH2mVA5CqsMow38DbgaVvBjBUe0TDo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Cc3Sc28/HIDtyEPyLM6SWzh1NfNVM6Oqw3y12YPIEQNqFt69QO0WzIM3AfQsvXVou2eq6gtOkrkf5vgcOuxAbUsMpo5LdM86i0XHNHJxiDc6hOTbSfG/atK5iRJrHXiA19S4LcgYSxD7tujP6b/oPIHGvyyjTWx6wbpj0+cd2jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3dc78d55321so49883165ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 21:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747975594; x=1748580394;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xbWOPZAgkoPSb2bLTKcY8Iaj/okxhf05Cpg7L2qKMFs=;
        b=suAQAagjpaTzulzTpzfCoWq6LG74paOniHCtoV+HGdqB6i04E6oP6/mauR8bDLG5Al
         NdbYfbJd5LsOHZT4m6JdFTIqsGydHVL7Yff+eOiy/JU47HD40JDA6MDamA7NbnvihCSL
         EPEPtu8WI/s43z6LRSdJQEAEwkJWSDERDXe5H3PUe4iK6IXaq40ypk7oks/5BaUD6X8d
         tbTI8lv2NGyNBB016BEq/d/kXDxXBocET6HFwQACHKzHXwXO5tHIdNhWJWH3GbKn1BhV
         /60hkGI0HdmdORT+neWshfhR+8HFWm6jNHi0J/wZgqySU+Uce6zTDiCkE64Tkvg3aWUm
         5SIA==
X-Forwarded-Encrypted: i=1; AJvYcCW7GpCMUEq9gdqF0b6wbnSXD5hkFt4Mbjnzh9fpIuv574z5szPyLLcA7kk8J2lu8aINSxtXZvR+LqL6XyL0@vger.kernel.org
X-Gm-Message-State: AOJu0YyBk95QpoJ5r2TTFK0wwNMJI+HXBcKDE9n5D4XyLAV+kZ7m0XKR
	NsV2Seb5rQmEI8DA7Joi0HOFlw/3K09snz8VNoDZsjBr4vpSWAWLe1kVheUPcMm1sHln/ALx8iX
	BuZVcwqpV8JIQhYAhaEigTBo3fbpMDYP4qP87xUBlheQbRU6jbSuPmMzeEmw=
X-Google-Smtp-Source: AGHT+IGnYULwd6+EAnWNTWM0zxMUrJYcKL/b/3KprQheG4Ilx0uvk8CYbzsaxTdqbvfzzzJnXsbooSyMhwtja4j4AVeD293W+Nb3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174b:b0:3dc:7f3b:aca9 with SMTP id
 e9e14a558f8ab-3dc7f3bae28mr124342205ab.14.1747975594321; Thu, 22 May 2025
 21:46:34 -0700 (PDT)
Date: Thu, 22 May 2025 21:46:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682ffdaa.a70a0220.253bc2.0061.GAE@google.com>
Subject: [syzbot] [jfs?] [xfs?] [bcachefs?] INFO: task hung in sb_start_write (2)
From: syzbot <syzbot+b3fba2e269970207b61d@syzkaller.appspotmail.com>
To: brauner@kernel.org, cem@kernel.org, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5806cd506af Linux 6.15-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11923f68580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3340af1a8845dd35
dashboard link: https://syzkaller.appspot.com/bug?extid=b3fba2e269970207b61d
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/652000eacd92/disk-a5806cd5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2b445a74e31e/vmlinux-a5806cd5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a4ef01f165f/bzImage-a5806cd5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3fba2e269970207b61d@syzkaller.appspotmail.com

INFO: task syz.9.533:10335 blocked for more than 143 seconds.
      Not tainted 6.15.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.9.533       state:D stack:24344 pid:10335 tgid:10334 ppid:7718   task_flags:0x400140 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x168f/0x4c70 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 percpu_rwsem_wait+0x2ab/0x300 kernel/locking/percpu-rwsem.c:162
 __percpu_down_read+0xe3/0x120 kernel/locking/percpu-rwsem.c:177
 percpu_down_read include/linux/percpu-rwsem.h:66 [inline]
 __sb_start_write include/linux/fs.h:1783 [inline]
 sb_start_write+0x185/0x1c0 include/linux/fs.h:1919
 mnt_want_write+0x41/0x90 fs/namespace.c:556
 open_last_lookups fs/namei.c:3789 [inline]
 path_openat+0x85d/0x3830 fs/namei.c:4036
 do_filp_open+0x1fa/0x410 fs/namei.c:4066
 do_sys_openat2+0x121/0x1c0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1455
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8e2a18e969
RSP: 002b:00007f8e2b0be038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f8e2a3b5fa0 RCX: 00007f8e2a18e969
RDX: 000000000000275a RSI: 0000200000000100 RDI: ffffffffffffff9c
RBP: 00007f8e2a210ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8e2a3b5fa0 R15: 00007fffe529a348
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6764
5 locks held by kworker/u8:2/36:
2 locks held by kworker/u8:6/1089:
2 locks held by getty/5583:
 #0: ffff88803055e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002ffe2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
1 lock held by udevd/9862:
2 locks held by udevd/10189:
 #0: ffff888022a2e3a0 (&sb->s_type->i_mutex_key#7){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:877 [inline]
 #0: ffff888022a2e3a0 (&sb->s_type->i_mutex_key#7){++++}-{4:4}, at: blkdev_read_iter+0x2f8/0x440 block/fops.c:808
 #1: ffff8880b88399d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:605
1 lock held by syz.9.533/10335:
 #0: ffff88802f0e0420 (sb_writers#25){++++}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:556
3 locks held by syz-executor/12892:
 #0: ffff8880b89399d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:605
 #1: ffff8880b8923b08 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x39e/0x6d0 kernel/sched/psi.c:987
 #2: ffff88807a093758 (&sb->s_type->i_lock_key#9){+.+.}-{3:3}, at: spin_trylock include/linux/spinlock.h:361 [inline]
 #2: ffff88807a093758 (&sb->s_type->i_lock_key#9){+.+.}-{3:3}, at: lock_for_kill+0x84/0x210 fs/dcache.c:705
2 locks held by syz.2.1023/13285:
2 locks held by dhcpcd-run-hook/13307:
 #0: ffff8880b89399d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:605
 #1: ffff8880b8923b08 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x39e/0x6d0 kernel/sched/psi.c:987

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.15.0-rc7-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:274 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:437
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 13310 Comm: rm Not tainted 6.15.0-rc7-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:file_ref_inc include/linux/file_ref.h:121 [inline]
RIP: 0010:get_file include/linux/fs.h:1133 [inline]
RIP: 0010:__mmap_new_file_vma mm/vma.c:2352 [inline]
RIP: 0010:__mmap_new_vma mm/vma.c:2417 [inline]
RIP: 0010:__mmap_region mm/vma.c:2519 [inline]
RIP: 0010:mmap_region+0xf23/0x1e50 mm/vma.c:2597
Code: 24 18 01 00 00 48 89 44 24 50 49 8d be 60 01 00 00 be 08 00 00 00 e8 1c 3f 0e 00 41 bf 01 00 00 00 f0 4d 0f c1 be 60 01 00 00 <31> ff 4c 89 fe e8 83 6c ae ff 4d 85 ff 78 74 e8 99 67 ae ff 4c 8b
RSP: 0018:ffffc9000418f2c0 EFLAGS: 00000202
RAX: ffffc9000418f301 RBX: ffff88806733f2a0 RCX: ffffffff82118924
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff88807e407820
RBP: ffffc9000418f730 R08: ffff88807e407827 R09: 1ffff1100fc80f04
R10: dffffc0000000000 R11: ffffed100fc80f05 R12: ffff88806733f280
R13: ffffc9000418f3d0 R14: ffff88807e4076c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881261f6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055aa8d186008 CR3: 000000007f374000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_mmap+0xc68/0x1100 mm/mmap.c:561
 vm_mmap_pgoff+0x31b/0x4c0 mm/util.c:579
 elf_map fs/binfmt_elf.c:387 [inline]
 elf_load+0x140/0x6c0 fs/binfmt_elf.c:414
 load_elf_interp+0x469/0xaf0 fs/binfmt_elf.c:681
 load_elf_binary+0x19d2/0x27a0 fs/binfmt_elf.c:1246
 search_binary_handler fs/exec.c:1778 [inline]
 exec_binprm fs/exec.c:1810 [inline]
 bprm_execve+0x999/0x1440 fs/exec.c:1862
 do_execveat_common+0x510/0x6a0 fs/exec.c:1968
 do_execve fs/exec.c:2042 [inline]
 __do_sys_execve fs/exec.c:2118 [inline]
 __se_sys_execve fs/exec.c:2113 [inline]
 __x64_sys_execve+0x94/0xb0 fs/exec.c:2113
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6e5ef70107
Code: Unable to access opcode bytes at 0x7f6e5ef700dd.
RSP: 002b:00007fff92965db8 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00005577b8e42fe0 RCX: 00007f6e5ef70107
RDX: 00005577b8e43000 RSI: 00005577b8e42fe0 RDI: 00005577b8e43088
RBP: 00005577b8e43088 R08: 00007fff92968e28 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 00005577b8e43000
R13: 00007f6e5f135e8b R14: 00005577b8e43000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

