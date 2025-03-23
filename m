Return-Path: <linux-fsdevel+bounces-44838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A34AA6D0BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 20:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533251892544
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 19:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDAF19E83E;
	Sun, 23 Mar 2025 19:17:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418ED1F92A
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Mar 2025 19:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742757427; cv=none; b=Ap/33kViOSomBvXDIR7fMu+VRQssqwZNZqNDqNbQgE21lW4ZHHHfOXiSle+ILa60+h0qoAN5gzNbecJBy8OeXff5/UiymRqnkVPi4HzVPf+NCTJ5edQJjb7/OKVhT9KfDm1GeoklQtICSM0QFiNAz9Bc7Qh9TRpymxkCvN65fCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742757427; c=relaxed/simple;
	bh=SoyfxZ6YMuE0fiZPQxElXv/YEiBAJvtXFzuNwAllsXc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jSA35sAJ0xrDNm1NGwich9xKXVd7bZQJZ/ersEqzCAtXZMwj012v7fzkY+0DiqELWjctFq5qOVo/nKZ7SecIoMcelrkDf0yRpQEmpFQfw/g1hp8moeSrI2zX06dkVg9zDgp3Jz8nxhvU1h8sJ4OLpKgzi8+PY415Gl91WfJCCk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-849d26dd331so468833939f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Mar 2025 12:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742757424; x=1743362224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swRiJdiTivHZNl/AP0jbG3xuufYcssqEEk3+v9qHjps=;
        b=UIBy1ATaljWiUVgZildPZ0e2zCMjF3/FtXoGZe97GqMEVQFrZ/lbNNpgBuGoWD1tHM
         wjjWg53ouEbNWP3HiVn3Vin91yjFW9221G1p5PWRhKZzE3z+z931kQEan2A3t9YVNKzX
         y/zjV8c7aKQqI3Ktl6b9gzkf8r6vh9bXW0QDmIGAAn1mUWTCu2RzvUX/aKl8JWJfhzqI
         WuIzd52+Z5bZKh/bau7TCc3syIm7vEhu9BNreByOleL/ig7JmKEqxZlov8sJA/DzwpK2
         ncHzy3zbWvTC9XU5zr+wx8MYcASXPazE5W8KheyBmXBEqLR/LiyA3eBwWTscKrGn8XmX
         9ovQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2TQtsKAYpjObOzJmGIDMHFXDwYeKaf6/T2vp+FbkBUMtVuOivTjnowIRCxR3v7UIG1RFiO2G+Z51/evyP@vger.kernel.org
X-Gm-Message-State: AOJu0YwZDLT+16f6vu8TAsIhVQV/Tyef2BOZQzskLzBV55mBfsR0syy5
	VPgKyrhdzvNCGITo7fuUOYUXcvP09wWQOt+SFz+spZsyejGtFHXhIR2FjEA8WAk2HLMH6cSX0vH
	AZrB7V/E8bxc8t6in75o/64YoOdgYjcnetgL9C/kMSY7fbHep0w1u4Eg=
X-Google-Smtp-Source: AGHT+IExTPzvzyelgUbZq82vkwIvq9bD//vMw2YlRAWPE+gBFz+j5D33X7mNRoxrkxn447N+XSubDZOKM5a6DdFDjS9IAcVfCK3J
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:9d:b0:3d4:44:958a with SMTP id
 e9e14a558f8ab-3d595edd857mr105041325ab.3.1742757424391; Sun, 23 Mar 2025
 12:17:04 -0700 (PDT)
Date: Sun, 23 Mar 2025 12:17:04 -0700
In-Reply-To: <20250323184848.GB14883@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e05e30.050a0220.21942d.0003.GAE@google.com>
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

INFO: task syz.0.17:6724 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc1-syzkaller-00017-gaaec5a95d596-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:24768 pid:6724  tgid:6722  ppid:6593   flags:0x00004004
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
RIP: 0033:0x7fce81f8d169
RSP: 002b:00007fce82d75038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fce821a5fa0 RCX: 00007fce81f8d169
RDX: 0000000000007fec RSI: 0000400000000540 RDI: 0000000000000007
RBP: 00007fce8200e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fce821a5fa0 R15: 00007ffc98f4b948
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u8:0/11:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000107d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:1/12:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000117d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
1 lock held by khungtaskd/30:
 #0: ffffffff8e1bac80 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e1bac80 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e1bac80 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6744
2 locks held by kworker/u8:2/35:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000ab7d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:3/56:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000121fd80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:4/81:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000217fd80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:5/1317:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90004897d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:6/3513:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000cadfd80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:7/3805:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000d66fd80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by getty/5580:
 #0: ffff88803216c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
3 locks held by syz.0.17/6724:
 #0: ffff8880227fd438 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff88807965c420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff8880749e0148 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.1.19/6772:
 #0: ffff888028adf438 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff88802984c420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff888074838148 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.2.21/6792:
 #0: ffff888034b1bcf8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff88805ffda420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff8880748387b8 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
2 locks held by kworker/u8:8/6807:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90003157d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
3 locks held by syz.3.23/6812:
 #0: ffff88807c3c70b8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff888026990420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff888074838e28 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.4.25/6838:
 #0: ffff8880794df438 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff88807c934420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff8880749e07b8 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.5.27/6864:
 #0: ffff8880248b07f8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff88805ccc4420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff888074839498 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
2 locks held by kworker/u8:11/6865:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90003117d80 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
3 locks held by syz.6.29/6891:
 #0: ffff8880355f7eb8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff888078eb2420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff888074839b08 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.7.31/6917:
 #0: ffff88807f33f0b8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff88807613e420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff88807483a178 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.8.34/6953:
 #0: ffff88806f5b4478 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff888078710420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff88807483ae58 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188
3 locks held by syz.9.36/6980:
 #0: ffff888029c18ef8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x267/0x390 fs/file.c:1191
 #1: ffff888033c44420 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #2: ffff88807483b4c8 (&sb->s_type->i_mutex_key#20){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-rc1-syzkaller-00017-gaaec5a95d596-dirty #0
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6813 Comm: kworker/u8:9 Not tainted 6.13.0-rc1-syzkaller-00017-gaaec5a95d596-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events_unbound nsim_dev_trap_report_work
RIP: 0010:orc_ip arch/x86/kernel/unwind_orc.c:80 [inline]
RIP: 0010:__orc_find+0x70/0xf0 arch/x86/kernel/unwind_orc.c:102
Code: ec 72 4e 4c 89 e2 48 29 ea 48 89 d6 48 c1 ea 3f 48 c1 fe 02 48 01 f2 48 d1 fa 48 8d 5c 95 00 48 89 da 48 c1 ea 03 0f b6 34 0a <48> 89 da 83 e2 07 83 c2 03 40 38 f2 7c 05 40 84 f6 75 4b 48 63 13
RSP: 0018:ffffc900031476d8 EFLAGS: 00000a06
RAX: ffffffff90f0214a RBX: ffffffff906e9fd0 RCX: dffffc0000000000
RDX: 1ffffffff20dd3fa RSI: 0000000000000000 RDI: ffffffff906e9fa8
RBP: ffffffff906e9fd0 R08: ffffffff90f0218c R09: ffffffff90f117cc
R10: ffffc900031477d8 R11: 0000000000004070 R12: ffffffff906e9fd0
R13: ffffffff814070f3 R14: ffffffff906e9fa8 R15: ffffffff906e9fcc
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c008cfd000 CR3: 000000000df7e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
 unwind_next_frame+0x2be/0x20c0 arch/x86/kernel/unwind_orc.c:494
 __unwind_start+0x45f/0x7f0 arch/x86/kernel/unwind_orc.c:760
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0x74/0x100 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kmem_cache_free+0x152/0x4c0 mm/slub.c:4700
 kfree_skbmem+0x1a4/0x1f0 net/core/skbuff.c:1148
 __kfree_skb net/core/skbuff.c:1205 [inline]
 consume_skb net/core/skbuff.c:1436 [inline]
 consume_skb+0xcc/0x100 net/core/skbuff.c:1430
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:821 [inline]
 nsim_dev_trap_report_work+0x8cf/0xd00 drivers/net/netdevsim/dev.c:851
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         aaec5a95 pipe_read: don't wake up the writer if the pi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=169ac43f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d5a2956e94d7972
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17803c4c580000


