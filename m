Return-Path: <linux-fsdevel+bounces-69636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4DDC7F66D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 09:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 749C74E3586
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 08:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A432E03F5;
	Mon, 24 Nov 2025 08:38:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B11A27472
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763973486; cv=none; b=UXGCEZED2oRCix4hjFF3WwvgNsRrZZQdUCMJwo/tRj16HS4P06f4wzVBxNvdG82yWLbQt3/1tZoHY1cXRmEv+apEi+Ot8/PuruxmzvVQPfuuzxKJMIXT4n2zT83AZtQtscxz5n8JdeF3JlVDIVO0kfQcn3msQJiUgm3mH0LZO08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763973486; c=relaxed/simple;
	bh=6HgnkYfme8r3947a/0awy+eKUByBmh2ucVsHvUoSTRo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KQ1qIJkKZ2jg1BWvv7YPN4Eha0hCCsQEsnnRUcNH2rEgpFaACxuN05qrbnGCsz99WDpIqu+rPSnQoi990WVcf2j4sLgPTS5PQ4yybqaE7OXeusCIhnAshF8DjaEZv6d482GJKzXDX43r1kJ/QV1V+xM4nwerxXjtd1sySzYFVuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-945aa9e086eso295448039f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 00:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763973483; x=1764578283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHBz9Vy/izaPGuZfkDJCPbzsEqQA3+kSMEq8RFje9Hw=;
        b=ai82YnTGI9HUDAvKbYLjcHv7RZIyTiVhi/EZfX6lQSusHS12JlsXK2X4zL7NhDJmGH
         IWmTFvGVxJ4q8pks2ips3T5pL4DJeBTdOUqt/IzKqw6DEu3QhGyCu84dKxNPO3FyjjYe
         GdOyeuG0iwSTw8y+Uw2Ty1HK0ar6suRCZpm+EwyVJJpZV2uMPULF4l9mZp5+uwvkWBk3
         6rFbIlgIunlRApw9zEFOIXJULP0qaKWpkN5TMiXp4ainIGl1FUUrgxMNPYkmSksSgERq
         06dEDW8tEOz8m239PT2GmZ/5C+ZoTar36YtwqUGQqTc6vjOMPnJp3LWzFydlsj8ebHMh
         wTQg==
X-Forwarded-Encrypted: i=1; AJvYcCU/A1mHfVUCC7GDVb0oo4IW9E/hqYSWxUMTHmaAL07QUAn5PzGOzVEwsyFjCiMpuJ6mAi5BtjeFWtqH/7qA@vger.kernel.org
X-Gm-Message-State: AOJu0YzytLFwRqCEuXoQMt4mdNb1IDhaxlmtYadAFEHGetRGZE4hMEgR
	e1eym2WymKkhrz2Cga/o2G7oVPxr3pkj/r5uDlRDn1uTbCOU94NIH+aRAbzEw2WJrWE4shCMv0b
	yb3BU6KqD9mL4Dkg7crR3maq8RsTVNIC/5a3vnyx1hxKx78rXq3h1+cMGOuo=
X-Google-Smtp-Source: AGHT+IE3a2rsUW8VL4oZdLQlW5epEfMRiguF4+XgrSTk0Tt/77TOkWiqA0uHAo4MSu8NQWlR146k/RmCFF+s4NATRb8lOuAYRK9z
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:153:b0:949:1025:96cd with SMTP id
 ca18e2360f4ac-94939ed0824mr997765739f.6.1763973483462; Mon, 24 Nov 2025
 00:38:03 -0800 (PST)
Date: Mon, 24 Nov 2025 00:38:03 -0800
In-Reply-To: <wij7hnuisn4cukkqmcflda3eurejl2dqjgwlphwesbu5jbljvc@xtqmwpwdj4pr>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6924196b.a70a0220.2ea503.007c.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
From: syzbot <syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com>
To: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	brauner@kernel.org, dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, mjguzik@gmail.com, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in do_renameat2

INFO: task syz.0.17:6464 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:28904 pid:6464  tgid:6455  ppid:6331   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7083
 rwsem_down_write_slowpath+0x872/0xfe0 kernel/locking/rwsem.c:1185
 __down_write_common kernel/locking/rwsem.c:1317 [inline]
 __down_write kernel/locking/rwsem.c:1326 [inline]
 down_write_nested+0x1b5/0x200 kernel/locking/rwsem.c:1707
 inode_lock_nested include/linux/fs.h:1108 [inline]
 lock_rename fs/namei.c:3360 [inline]
 do_renameat2+0x3b9/0xa50 fs/namei.c:5311
 __do_sys_rename fs/namei.c:5411 [inline]
 __se_sys_rename fs/namei.c:5409 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5409
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa97338f749
RSP: 002b:00007fa97416a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007fa9735e6090 RCX: 00007fa97338f749
RDX: 0000000000000000 RSI: 0000200000000080 RDI: 0000200000000340
RBP: 00007fa973413f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa9735e6128 R14: 00007fa9735e6090 R15: 00007ffdbce82b48
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8df3d020 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8df3d020 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8df3d020 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
3 locks held by kworker/u8:7/1145:
2 locks held by getty/5589:
 #0: ffff888033d380a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
3 locks held by syz.0.17/6456:
2 locks held by syz.0.17/6464:
 #0: ffff88807b846420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:508
 #1: ffff888058da6988 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1108 [inline]
 #1: ffff888058da6988 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3360 [inline]
 #1: ffff888058da6988 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: do_renameat2+0x3b9/0xa50 fs/namei.c:5311
3 locks held by syz.1.18/6490:
2 locks held by syz.1.18/6491:
 #0: ffff88803257c420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:508
 #1: ffff888058dae988 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1108 [inline]
 #1: ffff888058dae988 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3360 [inline]
 #1: ffff888058dae988 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: do_renameat2+0x3b9/0xa50 fs/namei.c:5311
3 locks held by syz.2.19/6514:
2 locks held by syz.2.19/6515:
 #0: ffff88802ef3e420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:508
 #1: ffff88807e9ee240 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1108 [inline]
 #1: ffff88807e9ee240 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3360 [inline]
 #1: ffff88807e9ee240 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: do_renameat2+0x3b9/0xa50 fs/namei.c:5311
3 locks held by syz.3.20/6543:
2 locks held by syz.3.20/6544:
 #0: ffff88802765e420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:508
 #1: ffff8880752ee240 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1108 [inline]
 #1: ffff8880752ee240 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3360 [inline]
 #1: ffff8880752ee240 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: do_renameat2+0x3b9/0xa50 fs/namei.c:5311
3 locks held by syz.4.21/6573:
2 locks held by syz.4.21/6574:
 #0: ffff88805e6f0420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:508
 #1: ffff888058dab690 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1108 [inline]
 #1: ffff888058dab690 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3360 [inline]
 #1: ffff888058dab690 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: do_renameat2+0x3b9/0xa50 fs/namei.c:5311
3 locks held by syz.5.22/6603:
2 locks held by syz.5.22/6604:
 #0: ffff88807572c420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:508
 #1: ffff8880752d9970 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1108 [inline]
 #1: ffff8880752d9970 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3360 [inline]
 #1: ffff8880752d9970 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: do_renameat2+0x3b9/0xa50 fs/namei.c:5311
3 locks held by syz.6.23/6640:
2 locks held by syz.6.23/6641:
 #0: ffff888023ebe420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:508
 #1: ffff888075340ae0 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1108 [inline]
 #1: ffff888075340ae0 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3360 [inline]
 #1: ffff888075340ae0 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: do_renameat2+0x3b9/0xa50 fs/namei.c:5311
3 locks held by syz.7.24/6671:
2 locks held by syz.7.24/6672:
 #0: ffff8880795f0420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:508
 #1: ffff88807e9ea0b8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1108 [inline]
 #1: ffff88807e9ea0b8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3360 [inline]
 #1: ffff88807e9ea0b8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: do_renameat2+0x3b9/0xa50 fs/namei.c:5311

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
 watchdog+0xf60/0xfa0 kernel/hung_task.c:495
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6514 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:lockdep_recursion_finish kernel/locking/lockdep.c:470 [inline]
RIP: 0010:lock_is_held_type+0x10b/0x190 kernel/locking/lockdep.c:5941
Code: 0f 95 c0 31 db 39 c5 0f 94 c3 eb 05 bb 01 00 00 00 48 c7 c7 91 26 8f 8d e8 82 16 00 00 b8 ff ff ff ff 65 0f c1 05 85 1a 29 07 <83> f8 01 75 44 48 c7 04 24 00 00 00 00 9c 8f 04 24 f7 04 24 00 02
RSP: 0018:ffffc90003c1f498 EFLAGS: 00000057
RAX: 0000000000000001 RBX: 0000000000000000 RCX: bf125e8550141200
RDX: 0000000000000000 RSI: ffffffff8d8f2691 RDI: ffffffff8bbf0760
RBP: 00000000ffffffff R08: ffffffff8dc16843 R09: 1ffffffff1b82d08
R10: dffffc0000000000 R11: fffffbfff1b82d09 R12: 0000000000000246
R13: ffff88802d930000 R14: ffffffff8df3d080 R15: 0000000000000003
FS:  00007fdcbd6ba6c0(0000) GS:ffff888126240000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0084c3000 CR3: 0000000077de8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lock_is_held include/linux/lockdep.h:249 [inline]
 __might_resched+0xa6/0x610 kernel/sched/core.c:8887
 iput+0x2b/0x1050 fs/inode.c:1972
 insert_inode_locked+0x32a/0x5d0 fs/inode.c:1874
 ntfs_new_inode+0xc8/0x100 fs/ntfs3/fsntfs.c:1681
 ntfs_create_inode+0x606/0x32a0 fs/ntfs3/inode.c:1306
 ntfs_create+0x3d/0x50 fs/ntfs3/namei.c:110
 lookup_open fs/namei.c:3796 [inline]
 open_last_lookups fs/namei.c:3895 [inline]
 path_openat+0x14f4/0x3830 fs/namei.c:4131
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdcbc78f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdcbd6ba038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fdcbc9e5fa0 RCX: 00007fdcbc78f749
RDX: 000000000000275a RSI: 00002000000001c0 RDI: ffffffffffffff9c
RBP: 00007fdcbc813f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdcbc9e6038 R14: 00007fdcbc9e5fa0 R15: 00007ffddfdb5568
 </TASK>


Tested on:

commit:         f6fe56e7 fs: push list presence check into inode_io_li..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.19.inode
console output: https://syzkaller.appspot.com/x/log.txt?x=1051797c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4d8bca00359e65f
dashboard link: https://syzkaller.appspot.com/bug?extid=2fefb910d2c20c0698d8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

