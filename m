Return-Path: <linux-fsdevel+bounces-7353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C543824095
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 12:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57A61F26D10
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 11:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D983210FF;
	Thu,  4 Jan 2024 11:28:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8202110D
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fe3fbbea8so2139185ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jan 2024 03:28:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704367708; x=1704972508;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AeD8S49PpVPc/MfX2hJlH7o8ZjT7dzTos6trOKHcGU=;
        b=VNaeqQkg+VE28J/LJbn1AU4LEBjybE7F28EY3qRayniuPzAQVTn2SU+G0y4FrCa0UW
         CgsRqJn2+q28OxsX8wgjrX+CCcXg5aG2SM9Q07KF+18JGHPKHoRElfKzZRf+1iEh1dM1
         IONQsGyPsw4anY/wgDiLxQMSFNjk9LyUKQVj0KKvcbf45n03tIahK/yfdANX7nqzBn6G
         R8Jkf/ReRRPXGZD8BaHRTip5ON76Bnt5HpQfK3V3CfDdiOH+J4j139WD2rZAXaGKnYsy
         icB+6/pDGJja35NSmMN5+7mrtHtkro4IKjFJvw++bMYkLREvrC7dlxJvn6SabNYE5q/n
         93Ig==
X-Gm-Message-State: AOJu0Yxu7hCEVavouvINtiTKbkReddohkaIyKuqY87NJyzbTH7ZrHHoA
	vRhRVM+HAiiAixqhVS15IqVSR0d7B/G4cVOrTsLg2ERzlrWB
X-Google-Smtp-Source: AGHT+IG/rrP2kV05eXyUwnh3Km8mdoV9q+WU45NJ5XikpxUSkzdE6q1qOCWOBsBQW5PpJTEoXqV38fHuKLHcXte58s8j8rf5Z39A
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cc:b0:35f:ff56:c0fe with SMTP id
 s12-20020a056e0218cc00b0035fff56c0femr70631ilu.1.1704367708200; Thu, 04 Jan
 2024 03:28:28 -0800 (PST)
Date: Thu, 04 Jan 2024 03:28:28 -0800
In-Reply-To: <00000000000082de1c05f81467ed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d06740060e1d074d@google.com>
Subject: Re: [syzbot] [reiserfs?] INFO: task hung in deactivate_super (2)
From: syzbot <syzbot+aa7397130ec6a8c2e2d9@syzkaller.appspotmail.com>
To: jack@suse.com, jfs-discussion@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ac865f00af29 Merge tag 'pci-v6.7-fixes-2' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11f14c55e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
dashboard link: https://syzkaller.appspot.com/bug?extid=aa7397130ec6a8c2e2d9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1669644de80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137d7db5e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9a1f24b8b8e9/disk-ac865f00.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b09904d69477/vmlinux-ac865f00.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8130ed70d938/bzImage-ac865f00.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ea2e844115b1/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa7397130ec6a8c2e2d9@syzkaller.appspotmail.com

INFO: task syz-executor393:5056 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc8-syzkaller-00024-gac865f00af29 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor393 state:D stack:25016 pid:5056  tgid:5056  ppid:5055   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1961/0x4ab0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6778
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
 rwsem_down_write_slowpath+0xeea/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1aa/0x200 kernel/locking/rwsem.c:1306
 __super_lock fs/super.c:56 [inline]
 __super_lock_excl fs/super.c:71 [inline]
 deactivate_super+0xad/0xf0 fs/super.c:516
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1256
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 ptrace_notify+0x2cd/0x380 kernel/signal.c:2399
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:278 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x168/0x2a0 kernel/entry/common.c:296
 do_syscall_64+0x52/0x110 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f4ae237a577
RSP: 002b:00007fffedd426b8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 000000000000daf5 RCX: 00007f4ae237a577
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007fffedd42770
RBP: 00007fffedd42770 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007fffedd437e0
R13: 000055555600b6c0 R14: 431bde82d7b634db R15: 00007fffedd43800
 </TASK>
INFO: task syz-executor393:5082 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc8-syzkaller-00024-gac865f00af29 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor393 state:D stack:27056 pid:5082  tgid:5082  ppid:5059   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1961/0x4ab0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6778
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
 rwsem_down_read_slowpath kernel/locking/rwsem.c:1086 [inline]
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x703/0xa40 kernel/locking/rwsem.c:1528
 __super_lock fs/super.c:58 [inline]
 super_lock+0x176/0x3a0 fs/super.c:117
 super_lock_shared fs/super.c:146 [inline]
 iterate_supers+0x8c/0x180 fs/super.c:969
 quota_sync_all fs/quota/quota.c:69 [inline]
 __do_sys_quotactl fs/quota/quota.c:938 [inline]
 __se_sys_quotactl+0x391/0xa30 fs/quota/quota.c:917
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f4ae2379319
RSP: 002b:00007fffedd437a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f4ae2379319
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff80000100
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fffedd437e0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffedd437cc
R13: 0000000000000001 R14: 431bde82d7b634db R15: 00007fffedd43800
 </TASK>
INFO: task syz-executor393:5083 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc8-syzkaller-00024-gac865f00af29 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor393 state:D stack:26736 pid:5083  tgid:5083  ppid:5060   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1961/0x4ab0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6778
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
 rwsem_down_read_slowpath kernel/locking/rwsem.c:1086 [inline]
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x703/0xa40 kernel/locking/rwsem.c:1528
 __super_lock fs/super.c:58 [inline]
 super_lock+0x176/0x3a0 fs/super.c:117
 super_lock_shared fs/super.c:146 [inline]
 iterate_supers+0x8c/0x180 fs/super.c:969
 quota_sync_all fs/quota/quota.c:69 [inline]
 __do_sys_quotactl fs/quota/quota.c:938 [inline]
 __se_sys_quotactl+0x391/0xa30 fs/quota/quota.c:917
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f4ae2379319
RSP: 002b:00007fffedd437a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f4ae2379319
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff80000100
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fffedd437e0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffedd437cc
R13: 0000000000000001 R14: 431bde82d7b634db R15: 00007fffedd43800
 </TASK>
INFO: task syz-executor393:5084 blocked for more than 144 seconds.
      Not tainted 6.7.0-rc8-syzkaller-00024-gac865f00af29 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor393 state:D stack:27056 pid:5084  tgid:5084  ppid:5061   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1961/0x4ab0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6778
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
 rwsem_down_read_slowpath kernel/locking/rwsem.c:1086 [inline]
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x703/0xa40 kernel/locking/rwsem.c:1528
 __super_lock fs/super.c:58 [inline]
 super_lock+0x176/0x3a0 fs/super.c:117
 super_lock_shared fs/super.c:146 [inline]
 iterate_supers+0x8c/0x180 fs/super.c:969
 quota_sync_all fs/quota/quota.c:69 [inline]
 __do_sys_quotactl fs/quota/quota.c:938 [inline]
 __se_sys_quotactl+0x391/0xa30 fs/quota/quota.c:917
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f4ae2379319
RSP: 002b:00007fffedd437a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f4ae2379319
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff80000100
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fffedd437e0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffedd437cc
R13: 0000000000000001 R14: 431bde82d7b634db R15: 00007fffedd43800
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8d92dae0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8d92dae0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8d92dae0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by getty/4808:
 #0: ffff88802667c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b4/0x1e10 drivers/tty/n_tty.c:2201
1 lock held by syz-executor393/5056:
 #0: ffff888029d1e0e0 (&type->s_umount_key#24){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff888029d1e0e0 (&type->s_umount_key#24){++++}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff888029d1e0e0 (&type->s_umount_key#24){++++}-{3:3}, at: deactivate_super+0xad/0xf0 fs/super.c:516
4 locks held by syz-executor393/5078:
 #0: ffff888029d1e0e0 (&type->s_umount_key#24){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff888029d1e0e0 (&type->s_umount_key#24){++++}-{3:3}, at: super_lock+0x176/0x3a0 fs/super.c:117
 #1: ffffc90003b890f0 (&journal->j_mutex){+.+.}-{3:3}, at: reiserfs_mutex_lock_safe fs/reiserfs/reiserfs.h:813 [inline]
 #1: ffffc90003b890f0 (&journal->j_mutex){+.+.}-{3:3}, at: lock_journal fs/reiserfs/journal.c:533 [inline]
 #1: ffffc90003b890f0 (&journal->j_mutex){+.+.}-{3:3}, at: do_journal_begin_r+0x352/0x1030 fs/reiserfs/journal.c:3047
 #2: ffff8880b993c358 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:558
 #3: ffff8880b993c358 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:558
2 locks held by syz-executor393/5079:
 #0: ffff888029d1e0e0 (&type->s_umount_key#24){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff888029d1e0e0 (&type->s_umount_key#24){++++}-{3:3}, at: super_lock+0x176/0x3a0 fs/super.c:117
 #1: ffffc90003b890f0 (&journal->j_mutex){+.+.}-{3:3}, at: reiserfs_mutex_lock_safe fs/reiserfs/reiserfs.h:813 [inline]
 #1: ffffc90003b890f0 (&journal->j_mutex){+.+.}-{3:3}, at: lock_journal fs/reiserfs/journal.c:533 [inline]
 #1: ffffc90003b890f0 (&journal->j_mutex){+.+.}-{3:3}, at: do_journal_begin_r+0x352/0x1030 fs/reiserfs/journal.c:3047
1 lock held by syz-executor393/5082:
 #0: ffff888029d1e0e0 (&type->s_umount_key#24){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff888029d1e0e0 (&type->s_umount_key#24){++++}-{3:3}, at: super_lock+0x176/0x3a0 fs/super.c:117
1 lock held by syz-executor393/5083:
 #0: ffff888029d1e0e0 (&type->s_umount_key#24){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff888029d1e0e0 (&type->s_umount_key#24){++++}-{3:3}, at: super_lock+0x176/0x3a0 fs/super.c:117
1 lock held by syz-executor393/5084:
 #0: ffff888029d1e0e0 (&type->s_umount_key#24){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff888029d1e0e0 (&type->s_umount_key#24){++++}-{3:3}, at: super_lock+0x176/0x3a0 fs/super.c:117

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.7.0-rc8-syzkaller-00024-gac865f00af29 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x498/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x310 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfaf/0xff0 kernel/hung_task.c:379
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5078 Comm: syz-executor393 Not tainted 6.7.0-rc8-syzkaller-00024-gac865f00af29 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:kasan_check_range+0x7/0x290 mm/kasan/generic.c:186
Code: 84 47 ff ff ff 48 ff c8 48 39 d8 0f 84 3b ff ff ff 48 89 df 48 c7 c6 02 91 12 8d e8 83 0a e7 ff 90 0f 0b 66 0f 1f 00 55 41 57 <41> 56 41 54 53 b0 01 48 85 f6 0f 84 a0 01 00 00 4c 8d 04 37 49 39
RSP: 0018:ffffc90003a5e838 EFLAGS: 00000046
RAX: 0000000000000002 RBX: 00000000000000a5 RCX: ffffffff816d37ac
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff90dd9370
RBP: ffff88802451c780 R08: ffffffff90dd9377 R09: 1ffffffff21bb26e
R10: dffffc0000000000 R11: fffffbfff21bb26f R12: 0000000000000001
R13: ffff88802451bb80 R14: 1ffff110048a38f4 R15: ffff88802451c7a0
FS:  000055555600a380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f934ceb7580 CR3: 0000000023d95000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 __lock_acquire+0xc5c/0x1fd0 kernel/locking/lockdep.c:5107
 lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
 do_write_seqcount_begin_nested include/linux/seqlock.h:525 [inline]
 do_write_seqcount_begin include/linux/seqlock.h:551 [inline]
 psi_group_change+0x113/0x12d0 kernel/sched/psi.c:787
 psi_task_change+0xfd/0x280 kernel/sched/psi.c:912
 psi_enqueue kernel/sched/stats.h:139 [inline]
 enqueue_task+0x29c/0x2f0 kernel/sched/core.c:2091
 activate_task kernel/sched/core.c:2125 [inline]
 ttwu_do_activate+0x1d7/0x760 kernel/sched/core.c:3770
 ttwu_queue kernel/sched/core.c:4021 [inline]
 try_to_wake_up+0x86d/0x1440 kernel/sched/core.c:4342
 kick_pool+0x2f4/0x3d0 kernel/workqueue.c:1142
 __queue_work+0xbfc/0x1000 kernel/workqueue.c:1797
 mod_delayed_work_on+0x105/0x250 kernel/workqueue.c:2021
 kblockd_mod_delayed_work_on+0x29/0x40 block/blk-core.c:1046
 blk_insert_flush+0x3cb/0x4e0 block/blk-flush.c:456
 blk_mq_submit_bio+0xff6/0x2140 block/blk-mq.c:3004
 __submit_bio+0x239/0x2e0 block/blk-core.c:607
 __submit_bio_noacct_mq block/blk-core.c:686 [inline]
 submit_bio_noacct_nocheck+0x91d/0xc70 block/blk-core.c:715
 submit_bh fs/buffer.c:2826 [inline]
 __sync_dirty_buffer+0x23b/0x390 fs/buffer.c:2864
 _update_journal_header_block+0x401/0x540 fs/reiserfs/journal.c:1270
 update_journal_header_block fs/reiserfs/journal.c:1289 [inline]
 flush_journal_list+0x106f/0x1c80 fs/reiserfs/journal.c:1589
 flush_used_journal_lists+0x1256/0x15d0 fs/reiserfs/journal.c:1828
 do_journal_end+0x3d51/0x4b40
 do_journal_begin_r+0x970/0x1030
 journal_begin+0x14c/0x360 fs/reiserfs/journal.c:3254
 reiserfs_sync_fs+0xb0/0x150 fs/reiserfs/super.c:77
 dquot_quota_sync+0xdb/0x490 fs/quota/dquot.c:753
 iterate_supers+0xc2/0x180 fs/super.c:971
 quota_sync_all fs/quota/quota.c:69 [inline]
 __do_sys_quotactl fs/quota/quota.c:938 [inline]
 __se_sys_quotactl+0x391/0xa30 fs/quota/quota.c:917
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f4ae2379319
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffedd437a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f4ae2379319
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff80000100
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fffedd437e0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffedd437cc
R13: 0000000000000001 R14: 431bde82d7b634db R15: 00007fffedd43800
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.090 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

