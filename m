Return-Path: <linux-fsdevel+bounces-10337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1DA849FA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 17:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E19E1F253B6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 16:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00A13C097;
	Mon,  5 Feb 2024 16:43:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A244C69
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151407; cv=none; b=No8/VyPm/j9dre752nLYYQTXTNdgejxrbxCgB5xRCQPaVvkdCJmT2wh1qkzr6t6K1Xs8AWkn+rPZK0yCHUMvlT0ECtFJYoiFiHunWSrIF1X3eu/ur2nCRGs38yknc3NPmSejgU1nMN1s8YIWL+s7B2n/kkYEMsWi3oBmFRJ+5zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151407; c=relaxed/simple;
	bh=8OxqGc9vix9NkKoNC0s3Cyui0zO2bynkyDH/jlgbA5k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S29xc8CGQhLseyVA+Nony96uzj2iQEeWxxMhBr6KrAH5RgpNs7+q35HYTC/Lm1atlkPRa+Ef251J4/vnHhSG1amkFYju50bz/vNRjw+aFtyW59C0HuAUQjPe2iO+jTZJMYTfZHVhBmw0M93TfiApRYwJJsjx060ivefNpfwpKUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bbb3de4dcbso549081739f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 08:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151405; x=1707756205;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HVVduCt4pD0y3Mn0F7G0Ei30vvm4n/FswoItULAhfmQ=;
        b=vmg6Xwud3u/myWDofHx3o8bEocRf0ysPdn82vo827zBH1qWmosM49ZTH0lv16QYawW
         Fm8Vf+ZLYfDzWUYClLTlLgULHZIbonzKmVlsOkpbhl5sHlqim76vJ3QeFXjKUmVwVcvL
         glDREIbiaK9bH9IvOR/5IwAs5G2uowISkJ+mtGHMB8jIAai7/I1NhoMzpWCy9vNuYd4r
         ccIaNUDMq4SHu/HD0fArDLuzxPXkVBt15fm+maTY1tGqeiMQ+tKrG/NtPhcVVK9P2oTa
         wZF5ltBfkFi5mpsf+EeRgrBE+WpaII3oxaS9vGQBUfRwqcFUJJccJ/YF9TFuoTMnwcY6
         OFuA==
X-Gm-Message-State: AOJu0Yy6u3dFa5rnxyNbjD/6M3AP0Q8vb7rZcz1IGkacnsTk66ZvbrPw
	dVY/3b7mIQPuMnTEHecC/MxpgMeWrCMkfpcGykUvEr52SRcp+6VRhVrto2TMarxLOelvbfOMjMb
	/lShKgfLijNrKJVWi+wJeu2ZIaPoaAA8LpGh3lVHHlBkfl6H83w20JXw=
X-Google-Smtp-Source: AGHT+IHjRx/kYKvsFPIuIsFBj5pCd0NUoBUXs/p9s8oyT10r+Aa/4mjQm8YOi77gi4+ldck09mhYrUnR+jTxnr1ykjnoBwdW3HBF
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c8d:b0:7c0:2a76:a607 with SMTP id
 i13-20020a0566022c8d00b007c02a76a607mr3745iow.0.1707151405160; Mon, 05 Feb
 2024 08:43:25 -0800 (PST)
Date: Mon, 05 Feb 2024 08:43:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001524350610a52994@google.com>
Subject: [syzbot] [ceph?] [fs?] INFO: task hung in ceph_mdsc_pre_umount
From: syzbot <syzbot+4bbc13a207327f82b3b0@syzkaller.appspotmail.com>
To: ceph-devel@vger.kernel.org, idryomov@gmail.com, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    076d56d74f17 Add linux-next specific files for 20240202
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=104ea9b7e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=428086ff1c010d9f
dashboard link: https://syzkaller.appspot.com/bug?extid=4bbc13a207327f82b3b0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a4ef2fe80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1255e7c4180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dece45d1a4b5/disk-076d56d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4921e269b178/vmlinux-076d56d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a9156da9091/bzImage-076d56d7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4bbc13a207327f82b3b0@syzkaller.appspotmail.com

INFO: task syz-executor268:5081 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor268 state:D stack:26296 pid:5081  tgid:5081  ppid:5070   flags:0x00004006
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
 ceph_mdsc_pre_umount+0x5b5/0x8b0 fs/ceph/mds_client.c:5475
 ceph_kill_sb+0x9f/0x4b0 fs/ceph/super.c:1535
 deactivate_locked_super+0xc4/0x130 fs/super.c:477
 ceph_get_tree+0x9a9/0x17b0 fs/ceph/super.c:1361
 vfs_get_tree+0x90/0x2a0 fs/super.c:1784
 vfs_cmd_create+0xe4/0x230 fs/fsopen.c:230
 __do_sys_fsconfig fs/fsopen.c:476 [inline]
 __se_sys_fsconfig+0x967/0xec0 fs/fsopen.c:349
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f1723f3ba39
RSP: 002b:00007ffde9dc2ba8 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1723f3ba39
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
RBP: 00000000000143e0 R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffde9dc2bbc
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by getty/4823:
 #0: ffff88802b08d0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
2 locks held by syz-executor268/5081:
 #0: ffff888022c74c70 (&fc->uapi_mutex){+.+.}-{3:3}, at: __do_sys_fsconfig fs/fsopen.c:474 [inline]
 #0: ffff888022c74c70 (&fc->uapi_mutex){+.+.}-{3:3}, at: __se_sys_fsconfig+0x8e6/0xec0 fs/fsopen.c:349
 #1: ffff888022e380e0 (&type->s_umount_key#41/1){+.+.}-{3:3}, at: alloc_super+0x20e/0x8f0 fs/super.c:345

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 11 Comm: kworker/u4:1 Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:__text_poke+0x34b/0xd30
Code: e8 3a 08 c2 00 4c 8b b4 24 40 01 00 00 fa bb 00 02 00 00 be 00 02 00 00 4c 21 f6 31 ff e8 6d 18 5f 00 4c 21 f3 48 89 5c 24 50 <4c> 89 7c 24 38 75 07 e8 79 13 5f 00 eb 0a e8 72 13 5f 00 e8 fd 42
RSP: 0018:ffffc90000107780 EFLAGS: 00000006
RAX: 0000000000000000 RBX: 0000000000000200 RCX: ffff888016eabc00
RDX: 0000000000000000 RSI: 0000000000000200 RDI: 0000000000000000
RBP: ffffc90000107950 R08: ffffffff8134bcf3 R09: fffff52000020ec0
R10: dffffc0000000000 R11: fffff52000020ec0 R12: ffffea000007ad00
R13: fffffffffffffeff R14: 0000000000000246 R15: ffffffff81eb4896
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a9d88ed600 CR3: 000000000df32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 text_poke arch/x86/kernel/alternative.c:1985 [inline]
 text_poke_bp_batch+0x59c/0xb30 arch/x86/kernel/alternative.c:2318
 text_poke_flush arch/x86/kernel/alternative.c:2487 [inline]
 text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2494
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_disable_cpuslocked+0xce/0x1c0 kernel/jump_label.c:235
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate+0x1b8/0x250 mm/kfence/core.c:831
 process_one_work kernel/workqueue.c:3049 [inline]
 process_scheduled_works+0x913/0x14f0 kernel/workqueue.c:3125
 worker_thread+0xa60/0x1000 kernel/workqueue.c:3206
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.413 msecs


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

