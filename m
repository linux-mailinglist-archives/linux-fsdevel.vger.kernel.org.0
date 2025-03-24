Return-Path: <linux-fsdevel+bounces-44863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228B5A6D8F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 12:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6D33A836C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 11:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2E825DD1B;
	Mon, 24 Mar 2025 11:15:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7D25DCF5
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742814906; cv=none; b=SK9oU3Jhz7QXK3IdqRESOe1rLLYqqvg4Ob9HHa060yYBDOSENK5biaVfbah5UkhOWbWyhDo+FTb7gWcQAm0dAisWSIAhd9CIP2GY6avvb1EQ7s4nB3QXCE5ZPp+x+E5nO/zmxTpe+X24szstQ55JYIZOmSaXxt3XBg3ehqmmC1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742814906; c=relaxed/simple;
	bh=ag19h64y1x9Esf8f8fl9K0vmeml+C3hyWoG85fkFgcU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DzyW8P+THmsnthiVYcV5x8eYgWg9BWFZ9j7AEsnlc9VNv/EalTlElp+q47o74yE/2YCZDEE7hnOTccaEecKkES3zZTNW9w0+bkNms5Ek2e0e5J5nDjYd0teYiW2JvXUnBQMigsFXdlbxnlHdbLw+ig5JJas5HpbUahG56JydgDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d434c328dbso76944595ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 04:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742814903; x=1743419703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVRXh8drqMt7jNzBvZOb/gqer1J2lINTc2OP+Ko2me4=;
        b=OY5BNowRuYdNBGMHkNU32RnxTb85dvUvKKZwn5BItOlE3B5mSTwxRZ7lH+5utMVPbv
         GO/xZxz+UW2gOsu7nfjtxjwD5bPAtXznelIoyncxk9cLIM2RQoUiYbTnq4KEul1lLCWY
         oSdWyOQWTgovoaklzarhGQI4QJ69ld/XTIMjDFxJJ5YDkHu15N5OaHf9J/xC1tcruWsx
         IKWiBdyaQeIKW4lHXBr4l9boBvwk5qynrqivkDs+uFEInvL46tNBrjxVKegyj7AthOEt
         jMPZyOnTy73ZrXxSYtiTZZ7guKzHMGZTiEOfOZGfCNos9Uh+ZKvk0+cksgMzM40dq9qg
         HIbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcnFmVxx0LRRHBjwUnHMhKr4IYZO/2fja62RPZW0wkvSrD7VPU9k1upSRtQSMtNmscB+pUIcRuD4lmjbdN@vger.kernel.org
X-Gm-Message-State: AOJu0YwsqjUQoo86J7qBGns3799G7cHBQ9Kf70XNJnT97zZSHFL/xt68
	rSMPFd40fmELS9FGRTeC+/c5WZ9mDPd3BxtDW51TIsiHX9a72nUGqS/GBtN/+qDWF7bZk53baTc
	LmSrQpr8A3TPTAIA41J9gp7n5enXvwSVqlVh8WbYxxUrqm8o5x4tyjfs=
X-Google-Smtp-Source: AGHT+IEyNysNWVch14YKZQcav42ifuMoGinGdohw8j1y+TDb4B1ZGPYPdv8gGAXqaPV1B0vRG+JRkTTocFJ8rSOoVuDb/Vh6YEz0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:10:b0:3d2:b4ea:5f42 with SMTP id
 e9e14a558f8ab-3d59613bbf9mr127150455ab.6.1742814903559; Mon, 24 Mar 2025
 04:15:03 -0700 (PDT)
Date: Mon, 24 Mar 2025 04:15:03 -0700
In-Reply-To: <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e13eb7.050a0220.a7ebc.001d.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
To: brauner@kernel.org, dhowells@redhat.com, jack@suse.cz, jlayton@kernel.org, 
	kprateek.nayak@amd.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjguzik@gmail.com, netfs@lists.linux.dev, 
	oleg@redhat.com, swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in netfs_unbuffered_write_iter

INFO: task syz.0.18:6758 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc1-syzkaller-00017-gaaec5a95d596-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.18        state:D stack:26608 pid:6758  tgid:6757  ppid:6540   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0xe58/0x5ad0 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6848
 bit_wait+0x15/0xe0 kernel/sched/wait_bit.c:237
 __wait_on_bit+0x62/0x180 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0xda/0x110 kernel/sched/wait_bit.c:64
 wait_on_bit include/linux/wait_bit.h:77 [inline]
 netfs_unbuffered_write_iter_locked+0xba8/0xe70 fs/netfs/direct_write.c:105
 netfs_unbuffered_write_iter+0x413/0x6d0 fs/netfs/direct_write.c:193
 v9fs_file_write_iter+0xbf/0x100 fs/9p/vfs_file.c:404
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae42f8d169
RSP: 002b:00007fae43eb2038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fae431a5fa0 RCX: 00007fae42f8d169
RDX: 0000000000007fec RSI: 0000400000000540 RDI: 0000000000000007
RBP: 00007fae4300e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fae431a5fa0 R15: 00007ffef04451c8
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u8:1/12:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000117d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
1 lock held by khungtaskd/30:
 #0: ffffffff8e1bac80 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e1bac80 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e1bac80 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6744
2 locks held by kworker/u8:3/52:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000bd7d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:4/63:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000214fd80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:5/1034:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000403fd80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:6/2116:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90005937d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:7/4367:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000f717d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:8/4487:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000fd07d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:9/4559:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000ffe7d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by getty/5582:
 #0: ffff8880313180a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
3 locks held by syz.0.18/6758:
 #0: ffff888026eba478 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff888024f5a420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff8880755987b8 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.1.23/6787:
 #0: ffff88803111c9b8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff88807d6da420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff888075720148 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.2.25/6807:
 #0: ffff88803562d438 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff888027a9e420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff88807559a178 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.3.28/6829:
 #0: ffff888026d3e9b8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff888025ffa420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff8880757207b8 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.4.30/6854:
 #0: ffff888033e600f8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff888036adc420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff888075720e28 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
2 locks held by kworker/u8:10/6856:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90002ee7d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
3 locks held by syz.5.32/6881:
 #0: ffff88803162deb8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff88802aa02420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff88807559a7e8 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by kworker/u8:11/6882:
3 locks held by syz.6.34/6908:
 #0: ffff88804f312d38 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff888062c8c420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff888075721498 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
2 locks held by kworker/u8:12/6909:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900021dfd80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
3 locks held by syz.7.36/6935:
 #0: ffff8880369530b8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff888063c48420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff888075721b08 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.8.38/6968:
 #0: ffff88801e2adeb8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff88807b25e420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff88807559ae58 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.9.40/6997:
 #0: ffff88802a74a7f8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff888053afa420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff888075722178 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-rc1-syzkaller-00017-gaaec5a95d596-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:234 [inline]
 watchdog+0xf14/0x1240 kernel/hung_task.c:397
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5182 Comm: klogd Not tainted 6.13.0-rc1-syzkaller-00017-gaaec5a95d596-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:__raw_callee_save___pv_queued_spin_unlock+0x12/0x18
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 52 b8 01 00 00 00 31 d2 f0 0f b0 17 75 06 <5a> c3 cc cc cc cc 56 0f b6 f0 e8 9f ff ff ff 5e 5a c3 cc cc cc cc
RSP: 0018:ffffc90005667618 EFLAGS: 00000046
RAX: 0000000000000001 RBX: ffffffff9a9f6bc8 RCX: ffffffff81770803
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff9a9f6bc8
RBP: ffffffff9a9f6bd0 R08: 0000000000000000 R09: fffffbfff353ed79
R10: ffffffff9a9f6bcb R11: 0000000000000001 R12: ffffffff9a9f6bd8
R13: 0000000000000012 R14: 0000000000000000 R15: ffff888067f30000
FS:  00007fb083fb7500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005612bebd5240 CR3: 00000000347be000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 pv_queued_spin_unlock arch/x86/include/asm/paravirt.h:589 [inline]
 queued_spin_unlock arch/x86/include/asm/qspinlock.h:57 [inline]
 do_raw_spin_unlock+0x172/0x230 kernel/locking/spinlock_debug.c:142
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:150 [inline]
 _raw_spin_unlock_irqrestore+0x22/0x80 kernel/locking/spinlock.c:194
 __debug_check_no_obj_freed lib/debugobjects.c:1108 [inline]
 debug_check_no_obj_freed+0x327/0x600 lib/debugobjects.c:1129
 free_pages_prepare mm/page_alloc.c:1134 [inline]
 free_unref_page+0x276/0x1080 mm/page_alloc.c:2657
 __put_partials+0x14c/0x170 mm/slub.c:3142
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_node_noprof+0x223/0x3c0 mm/slub.c:4205
 __alloc_skb+0x2b1/0x380 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1323 [inline]
 alloc_skb_with_frags+0xe4/0x850 net/core/skbuff.c:6612
 sock_alloc_send_pskb+0x7f1/0x980 net/core/sock.c:2881
 unix_dgram_sendmsg+0x4b8/0x19e0 net/unix/af_unix.c:2027
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg net/socket.c:726 [inline]
 __sys_sendto+0x488/0x4f0 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb0841199b5
Code: 8b 44 24 08 48 83 c4 28 48 98 c3 48 98 c3 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 26 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 7a 48 8b 15 44 c4 0c 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffd368d15b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb0841199b5
RDX: 0000000000000049 RSI: 0000558a1e31e270 RDI: 0000000000000003
RBP: 0000558a1e3172c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000013
R13: 00007fb0842a7212 R14: 00007ffd368d16b8 R15: 0000000000000000
 </TASK>


Tested on:

commit:         aaec5a95 pipe_read: don't wake up the writer if the pi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12debc4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d5a2956e94d7972
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10750198580000


