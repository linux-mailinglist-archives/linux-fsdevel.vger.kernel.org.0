Return-Path: <linux-fsdevel+bounces-32545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D266C9A9657
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 04:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7A11C22E73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 02:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F404E13C9B8;
	Tue, 22 Oct 2024 02:42:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F36136E01
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 02:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729564949; cv=none; b=GJWC3QRwjmjcNH0Dy9WE+TBo12daWOqTSEbM9/mCoRqDB5gvc2DTwxCVlvqgnUO6zaZ3tRmjUj/wEXn4SF4OkCtBS/AqaJN5RMcSpeRjt6r4vH1KHRTaLwaq2ZshbIOXvBVZt2r8xUtK/AMLO3AEw4YNUKTlYxhpHNp3Z3Z4Re0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729564949; c=relaxed/simple;
	bh=GSnURtL9XpSGABnp+TGwu1/YZwS6fHMiIw38oKyv8UI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GVdrM8MwyMTJVrnSj+JjjmcHnlPWd9l14E6k9StOK7piJZJ6fNdpOPyxnRYUJEFm/jpH/jibcZ3iV9pLK3olGTDOG2dDi7iKHd5fPKjiqTwBXPizirxyz6yxCTcFdYgKTVG7Upcmm1sIwow5RldUrwND5TOVNOZ/i4BG+eDJ+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3cb771556so56538095ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 19:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729564947; x=1730169747;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=waJbPxJBywkfTruSFQ4D4lhYRkssTn1n7ZY+z77pU4c=;
        b=sLBfKKBEJCZw1sUTqohyRbNgWJxAb4140vxYFAwstyppg858KUPxSibeq+9tYPLwn8
         84i3qpmdJsUtJgTrtrKbt1k4+49oD4mWAlVwuqukVyCSbqFjkQ9Pp54zESWG0+AdC/pU
         Gyw78faAnDMmDBiXU5FKzq/LJV9Vkddbdb4BUJPFB9oYVKM430F3W4T68SJ3WACJXZED
         4LDCRuDSzxlOaPr+CTnedf9OedFSY4taVjLnSG1H50utOOXwDN0Fm3Bqvo2ntvVFukuN
         y79CMbCHHOei4FRYJuK/ZDV9JnSmqG/3vNHmawayn1PMzED5s+cDlb11RxGEnGaqR5Ao
         T2ig==
X-Gm-Message-State: AOJu0YyRZ44ZF405lNLAF3H0AIIgnkdqQ4WntNqUHKD8tH/qGUf99siE
	/P8QSuE4f8ASBYzRqHyolw6Ph71/j3k6oZOTj8kbf6gBQYfgFzPDDFXwSqkf0b7mJzscEJfBkjW
	6712CLiOMK7wccjLev+uPgOhqNS2PBr1cXFarGy1syyMZSEvYTSHwAaw=
X-Google-Smtp-Source: AGHT+IHUsmKgKsRKD/HreZf7gBvUki8d0ysnrXI4hE1UaKWcuwWxn2DxXUhFoDfRzymm4oK8O1lHOEWJYDBvT66uyhtrZcyJfGbw
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c6:b0:3a0:8c5f:90c0 with SMTP id
 e9e14a558f8ab-3a3f4054723mr130029565ab.10.1729564947193; Mon, 21 Oct 2024
 19:42:27 -0700 (PDT)
Date: Mon, 21 Oct 2024 19:42:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67171113.050a0220.1e4b4d.006c.GAE@google.com>
Subject: [syzbot] [fuse?] INFO: task hung in __fuse_simple_request
From: syzbot <syzbot+0dbb0d6fda088e78a4d8@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    715ca9dd687f Merge tag 'io_uring-6.12-20241019' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f6ca40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16e543edc81a3008
dashboard link: https://syzkaller.appspot.com/bug?extid=0dbb0d6fda088e78a4d8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1478a0a7980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-715ca9dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba436e2363b6/vmlinux-715ca9dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3ac78a7a1a30/bzImage-715ca9dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0dbb0d6fda088e78a4d8@syzkaller.appspotmail.com

INFO: task syz.1.16:5435 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc3-syzkaller-00420-g715ca9dd687f #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.16        state:D stack:26736 pid:5435  tgid:5429  ppid:5222   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 request_wait_answer fs/fuse/dev.c:464 [inline]
 __fuse_request_send fs/fuse/dev.c:478 [inline]
 __fuse_simple_request+0xe17/0x1840 fs/fuse/dev.c:572
 fuse_simple_request fs/fuse/fuse_i.h:1156 [inline]
 fuse_send_open fs/fuse/file.c:51 [inline]
 fuse_file_open+0x599/0xb40 fs/fuse/file.c:146
 fuse_do_open fs/fuse/file.c:175 [inline]
 fuse_open+0x341/0x720 fs/fuse/file.c:264
 do_dentry_open+0x978/0x1460 fs/open.c:958
 vfs_open+0x3e/0x330 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x2c84/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff76397dff9
RSP: 002b:00007ff764752038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007ff763b36058 RCX: 00007ff76397dff9
RDX: 0000000000101001 RSI: 0000000020000180 RDI: ffffffffffffff9c
RBP: 00007ff7639f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007ff763b36058 R15: 00007ffe4de011e8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/25:
 #0: ffffffff8e937e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937e20 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
1 lock held by klogd/4585:
 #0: ffff88801fc3ea98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:593
2 locks held by getty/4894:
 #0: ffff88801e1690a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000039b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
1 lock held by syz-execprog/5119:
1 lock held by syz-executor/5120:
1 lock held by dhcpcd-run-hook/5428:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 25 Comm: khungtaskd Not tainted 6.12.0-rc3-syzkaller-00420-g715ca9dd687f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

