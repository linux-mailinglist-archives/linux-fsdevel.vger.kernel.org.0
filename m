Return-Path: <linux-fsdevel+bounces-37091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C579ED723
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 21:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563B516753A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 20:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A811FF1DC;
	Wed, 11 Dec 2024 20:20:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931DD1C4A02
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948426; cv=none; b=jrCf0/5OSmhHZup3t0g0XapStxWQUTfF1oZHkecHHSYD6x1kr5qgPk/CMAYq7uawtkLasD/xwbQQBx6J2QvZDkdlAsBehaIy2wMqWmiSRJzwBu8iY0+zZPaUUufC/9d+t0tZA5grwH4WkYqz1IF0r0DZBsQh1I3MoVP8q/5HoVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948426; c=relaxed/simple;
	bh=618zjw2ouKaWswwmR6WpFUxRSJtunl2om/z6huOxLjg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TW4Rz+JQ+1seo6ybJjn1sHcsGLRuEJkZwjJWebOlvdHqQfUbFB7y3xEkCeTe+ys2tJvmSJ5zNQPgxJj16QlxvT1OGJexulwLiK6CtsqiQ9GhHst5LGcJp0rKFJeD5+k0oVLtx9+aoVBc2pZ+2Y6DbjBGiVFpQVARtIKHT4hdMEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a815ab079cso119354875ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 12:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733948423; x=1734553223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqCNbZY6U72+aSL9l8AE7zjsD7QGr2gDR64WahnMA+4=;
        b=THgIAVgHZT7X9d9tLshax/OGJhs22s5BPmAupn3V8iWrmbNuUWOfb7jKl8dC8782xj
         A1o+U8x9WlcAtH6LpQvvnC1XvATh62Bt97WmpOnjTpIizrwRw2udFvnmEQX9eA/A7ZXC
         xWF+wHBtWsu6H7xa1PJviv7tpeCjSpcpykLc1+N2DVjT0Nu6fdpGqejD3aYSg9QqYvpJ
         baBycs26fUtpxhCkphtjgWkP818RaID+GDmnWasL5El3ZWpngpcDIEgoV95cjFzPieZS
         SqIqYMMnnz6qQK6cfUT2bOCs56UCUXxdMI+zo/JWS0OwNdvOKLtLTCz/icbtkOiX1ZWs
         /qGw==
X-Forwarded-Encrypted: i=1; AJvYcCWfOaYGSnoH7NgFVBQLOkJhbuz7YPC36VSBrRNTeYLiKUmwXaU2zA+lAg5o5QyvZrvlHbZw9XYz4MlLXghl@vger.kernel.org
X-Gm-Message-State: AOJu0YxoNI36OTO/aShfj2mFpvpZZegrZA7a0fouFpuCX1OrDFv2rfmn
	CBS+2oZCOMyJuisxi9xFC8RNY8qWv+sjeIC/OBXmqGKA1IgDtNwj361ft/hV2sk85Z/7zI4NnOH
	mWkofBGe8NDAJrOnVz62jS5S2hS/C1SbW5TWenY9qB9glVAWlPnTks2o=
X-Google-Smtp-Source: AGHT+IESYvZmO5MOjmUDuXdsPDP7Ff75vG0N8pmEovXTdk0Qmx02SxIJjz+5VHsUuG5b30brRAO9rrebfNTCUqiHq7cK8AZqlUF4
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c265:0:b0:3a7:e528:6f1e with SMTP id
 e9e14a558f8ab-3ac48caa3d7mr9076445ab.11.1733948423762; Wed, 11 Dec 2024
 12:20:23 -0800 (PST)
Date: Wed, 11 Dec 2024 12:20:23 -0800
In-Reply-To: <000000000000e7813b0601a3af69@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6759f407.050a0220.1ac542.000f.GAE@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in exfat_sync_fs
From: syzbot <syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f92f4749861b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=165e73e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7c9f223bfe8924e
dashboard link: https://syzkaller.appspot.com/bug?extid=205c2644abdff9d3f9fc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1619bb30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115e73e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5b8875fea73b/disk-f92f4749.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bf1ea2d28b68/vmlinux-f92f4749.xz
kernel image: https://storage.googleapis.com/syzbot-assets/21f786c9f90d/bzImage-f92f4749.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d6e372cd93dd/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com

INFO: task syz-executor405:5841 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc2-syzkaller-00031-gf92f4749861b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor405 state:D stack:27504 pid:5841  tgid:5838  ppid:5837   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x17fb/0x4be0 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 __mutex_lock_common kernel/locking/mutex.c:665 [inline]
 __mutex_lock+0x7e7/0xee0 kernel/locking/mutex.c:735
 exfat_sync_fs+0xb0/0x160 fs/exfat/super.c:56
 iterate_supers+0xc6/0x190 fs/super.c:934
 ksys_sync+0xdb/0x1c0 fs/sync.c:104
 __do_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff13f9f4849
RSP: 002b:00007ff13f98a218 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007ff13fa7c6d8 RCX: 00007ff13f9f4849
RDX: 00007ff13f9cdfb6 RSI: 0000000000000000 RDI: 00007ff13f98afb0
RBP: 00007ff13fa7c6d0 R08: 00007ffce2fc7077 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff13fa48086
R13: 00007ff13fa4807e R14: 633d73726f727265 R15: 0030656c69662f2e
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6744
2 locks held by getty/5572:
 #0: ffff88814d4a10a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900032fb2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by syz-executor405/5840:
2 locks held by syz-executor405/5841:
 #0: ffff88807d95a0e0 (&type->s_umount_key#64){.+.+}-{4:4}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff88807d95a0e0 (&type->s_umount_key#64){.+.+}-{4:4}, at: super_lock+0x27c/0x400 fs/super.c:120
 #1: ffff88807d9580e8 (&sbi->s_lock){+.+.}-{4:4}, at: exfat_sync_fs+0xb0/0x160 fs/exfat/super.c:56

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-rc2-syzkaller-00031-gf92f4749861b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:234 [inline]
 watchdog+0xff6/0x1040 kernel/hung_task.c:397
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5840 Comm: syz-executor405 Not tainted 6.13.0-rc2-syzkaller-00031-gf92f4749861b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
RIP: 0010:rcu_is_watching+0x10/0xb0 kernel/rcu/tree.c:737
Code: 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 53 65 ff 05 48 db 7e 7e <e8> db 5d 3b 0a 89 c3 83 f8 08 73 7a 49 bf 00 00 00 00 00 fc ff df
RSP: 0018:ffffc9000401f488 EFLAGS: 00000083
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff81a7289c
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff90183af0
RBP: ffffc9000401f5f8 R08: ffffffff90183af7 R09: 1ffffffff203075e
R10: dffffc0000000000 R11: fffffbfff203075f R12: 0000000000000246
R13: dffffc0000000000 R14: 0000000000000200 R15: 00000000000000a0
FS:  00007ff13f9ab6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555571eef738 CR3: 0000000073fd8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 trace_irq_disable+0x3b/0x120 include/trace/events/preemptirq.h:36
 lookup_bh_lru fs/buffer.c:1359 [inline]
 __find_get_block+0x190/0x1150 fs/buffer.c:1394
 bdev_getblk+0x33/0x670 fs/buffer.c:1425
 __bread_gfp+0x86/0x400 fs/buffer.c:1485
 sb_bread include/linux/buffer_head.h:346 [inline]
 exfat_get_dentry+0x53b/0x730 fs/exfat/dir.c:672
 exfat_readdir fs/exfat/dir.c:118 [inline]
 exfat_iterate+0x9f9/0x2ce0 fs/exfat/dir.c:242
 wrap_directory_iterator+0x91/0xd0 fs/readdir.c:65
 iterate_dir+0x571/0x800 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:403 [inline]
 __se_sys_getdents64+0x1e2/0x4b0 fs/readdir.c:389
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff13f9f4849
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff13f9ab218 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007ff13fa7c6c8 RCX: 00007ff13f9f4849
RDX: 0000000000001000 RSI: 0000000020000f80 RDI: 0000000000000004
RBP: 00007ff13fa7c6c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff13fa48086
R13: 00007ff13fa4807e R14: 633d73726f727265 R15: 0030656c69662f2e
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.207 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

