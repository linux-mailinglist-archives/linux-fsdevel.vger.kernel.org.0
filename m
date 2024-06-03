Return-Path: <linux-fsdevel+bounces-20773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B0F8D7A92
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 05:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45EF1C20E83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 03:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014DF182DA;
	Mon,  3 Jun 2024 03:50:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCF3FBED
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 03:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717386620; cv=none; b=MPlVinQv1InKx/cqIJQBtGLEflayvMyuQPEF+ZWj6GXXpxg0XeiYMx/EcdslI6mevFSUIqAsDC0cLpCbI+Y7QzJuGQ6/xeJ6jv5duN0xeZov4h103GloScjDg4ZUOpSw2mhn2ewYrX5Auqu80Yxclq5fAFS6IUdY570FZRtLSd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717386620; c=relaxed/simple;
	bh=1ANqzlXN6QgBixaS4MFELMZPKLeuCh49qwYRXIlJhpI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F/6TREpYhPdPqk8OUdhfQOJ5j0pN4VAOeIPZrdbEHYd5/gYlXNwMKXnb25PcoxElKolKhTVpmg1SqzmQ6j/F/xc/F/jrx6IlZrzIz/lKZK7jsI/PA84/SblXZUwUss1RUaskCAnJXDIjHmrcJ0BZiT2t5VBzBREbH82QoI6Muvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7eb01189491so352013239f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jun 2024 20:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717386618; x=1717991418;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSPZMKkBI7zfCYDgVMujOuceO46eKVRs+W67esEnsuc=;
        b=WHZ/GBLN1Piz92NghERbjQY9XUKWO741rNyr/ayFPB4vbF5DMObZ0MGoQMLTKLT+S7
         9Hcp+pXa7W1hYgbxocUfyQaxp6RHUcmG0mvxztVo+r5+AyKc3qzCpmgA5tKfdTR47kBB
         89xnxDAYnnVS/6vopLxDEiVMi3j1+icC95Ns5E4q2lfBjcNEpA2sysn4jzmo1572Z67p
         hL4XBG2IdVlEafztBTKCgbbOhdLMXn5hnRu4mGd1gAucaj4aNaPvOeNFv4t0m6ptZwk+
         t7uy2aZwvGd72B4kzL19pdltVjIsotw7gpiIT6GXPlaFY1/EwopXcENYBCaVCaaoHEL9
         iLPw==
X-Forwarded-Encrypted: i=1; AJvYcCUCj/I0l58QGc3rkdGKSM9BCpNS/fp1VKN0mQ/lf/a9kRodxnWgQ4WOSebhKP8T+7qAQXgytc93SR8f7Y7wOt5qdqYQjkFzTSnT0US+fw==
X-Gm-Message-State: AOJu0Yy1jjTr0OnDUnEv41pZazTj97OkwMuJGwCPvwdEIWRdc8Y41oGQ
	TYH9h7ilGNy5p/9652FoLWGtUGOralMbaPRj3eONf6qDirmQP38JHq/JmKCEcJQOpQyNZ9tY24d
	a73rP4TXgwX7X8iqJibEP5sQRtC7BlhVo8liR8bgRAwLdkdTVLaYf1Rg=
X-Google-Smtp-Source: AGHT+IGa4Lb4g7P/F4jS2dEzIBFVKP7gDDPixQ3bGVBxtyr6zPWaUvpH71Hv4MOPdEo+HeiMh2iQMJguBmY/mfjgX8ctZO/yGGvG
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6412:b0:7da:bccd:c3e3 with SMTP id
 ca18e2360f4ac-7eaffe9573emr44749139f.1.1717386618389; Sun, 02 Jun 2024
 20:50:18 -0700 (PDT)
Date: Sun, 02 Jun 2024 20:50:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054d8540619f43b86@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in vfs_rmdir (2)
From: syzbot <syzbot+42986aeeddfd7ed93c8b@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1466269a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=42986aeeddfd7ed93c8b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a5b3ec980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103820f2980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/91325320f37c/disk-4a4be1ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49af253b674e/vmlinux-4a4be1ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/04d26ea378d5/bzImage-4a4be1ad.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2643c2ec211c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+42986aeeddfd7ed93c8b@syzkaller.appspotmail.com

INFO: task syz-executor150:5089 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor150 state:D stack:24224 pid:5089  tgid:5087  ppid:5086   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 inode_lock include/linux/fs.h:791 [inline]
 vfs_rmdir+0x101/0x510 fs/namei.c:4203
 do_rmdir+0x3b5/0x580 fs/namei.c:4273
 __do_sys_rmdir fs/namei.c:4292 [inline]
 __se_sys_rmdir fs/namei.c:4290 [inline]
 __x64_sys_rmdir+0x49/0x60 fs/namei.c:4290
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9b91eaed89
RSP: 002b:00007f9b91e65168 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 00007f9b91f375e8 RCX: 00007f9b91eaed89
RDX: ffffffffffffffb0 RSI: e0f7bef392ce73bd RDI: 0000000020000180
RBP: 00007f9b91f375e0 R08: 00007f9b91e656c0 R09: 0000000000000000
R10: 00007f9b91e656c0 R11: 0000000000000246 R12: 00007f9b91f375ec
R13: 0000000000000006 R14: 00007fff5a763930 R15: 00007fff5a763a18
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by getty/4840:
 #0: ffff88802afc40a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f0e2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
3 locks held by syz-executor150/5089:
 #0: ffff88807cf1a420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff88807a2d9650 (&sb->s_type->i_mutex_key#14/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:826 [inline]
 #1: ffff88807a2d9650 (&sb->s_type->i_mutex_key#14/1){+.+.}-{3:3}, at: do_rmdir+0x263/0x580 fs/namei.c:4261
 #2: ffff88807a2d9650 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
 #2: ffff88807a2d9650 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: vfs_rmdir+0x101/0x510 fs/namei.c:4203

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 30 Comm: khungtaskd Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 1093 Comm: kworker/u8:7 Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:hlock_class kernel/locking/lockdep.c:228 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4798 [inline]
RIP: 0010:__lock_acquire+0x876/0x1fd0 kernel/locking/lockdep.c:5087
Code: 8b 5d 00 81 e3 ff 1f 00 00 48 89 d8 48 c1 e8 06 48 8d 3c c5 80 15 f7 92 be 08 00 00 00 e8 c2 2b 86 00 48 0f a3 1d ca b2 84 11 <73> 1a 48 69 c3 c8 00 00 00 48 8d 98 80 74 c5 92 48 ba 00 00 00 00
RSP: 0018:ffffc900047af3d0 EFLAGS: 00000057
RAX: 0000000000000001 RBX: 0000000000000021 RCX: ffffffff817262ae
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff92f71580
RBP: 0000000000000003 R08: ffffffff92f71587 R09: 1ffffffff25ee2b0
R10: dffffc0000000000 R11: fffffbfff25ee2b1 R12: 0000000000000005
R13: ffff8880223f8bc8 R14: 0000000000000005 R15: ffff8880223f8bc8
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e370ade680 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __pte_offset_map_lock+0x1ba/0x300 mm/pgtable-generic.c:375
 get_locked_pte include/linux/mm.h:2744 [inline]
 __text_poke+0x2c5/0xd30 arch/x86/kernel/alternative.c:1883
 text_poke arch/x86/kernel/alternative.c:1968 [inline]
 text_poke_bp_batch+0x8cd/0xb30 arch/x86/kernel/alternative.c:2357
 text_poke_flush arch/x86/kernel/alternative.c:2470 [inline]
 text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2477
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x136/0x260 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 toggle_allocation_gate+0xb5/0x250 mm/kfence/core.c:826
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.739 msecs


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

