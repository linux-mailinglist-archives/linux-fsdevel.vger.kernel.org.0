Return-Path: <linux-fsdevel+bounces-35864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D269D8FDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 02:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0678E289128
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 01:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103D5D531;
	Tue, 26 Nov 2024 01:26:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF73C2ED
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 01:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732584386; cv=none; b=BfUIVUiCVXhqlV4AhCR1NvHE/MwtJNiGQfp39ybja8VsRl4Au5bVDYa579X87T3t+ov8GwLAelCx0uV5ymdfu4+mWqIC3RXCo/KcXSacADi1ajmemFr/qbrzeM5aOAAPXUyMk/tyQBw8ZxwpqvTMSm6kV13+9kk8+dp6pTpdgII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732584386; c=relaxed/simple;
	bh=kEFSAChAQCbIutdMW5aUh1ttj8PI29L9DCyiBMrO0EQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qw7IoAEWh04IDZhjFl9KUl7YQqNDEpJEd/59reqn4vS+IpUrD5t/DgHUuwDD1o/uLoa0XOnF8J1tA92ApDXPXQcggqyZ2hE6wo7BjCKablMlZJVjxMUbqFzOI6xnH2kCqpl3UsBhGbuqiLV3d+DvpfYktj++pl4n5+jYVXs6XJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8419946e077so187504839f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 17:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732584384; x=1733189184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhV3qmcY6LKgpbt6QuqXrnAC3jZ0vw2YkX9rEy3Fb7U=;
        b=WPHivU2afOfnrrcOV/M3q2vMuKPD762XUnaC9B7kx7fdbyfZGrFPeUFnRFUHO6RXD2
         4g0qgKH6qwIRBt9w3Z3iZtUsAsMlUYKKHj/EymMpvt3q8L5wQ65QTlk1//fmuLBzXpf4
         yZaqe9twwGjpZxP5J33cxYRBrvYzLdDDWVBPcZdjjlcLKn6Jp29hWXw2SzXC4HZmo2Bp
         JZdE50NFDtXnRt6iwJf/u+wkgIydDNHwdyQr7+cIZC8w6jGiG9jHaeALQdd5d8lcHw/V
         mc0ZC0wnu93TMKXUYVtn/orIquW6gnCNllUKM8IohLA/yaAGUG+n8BV8mKQ8nUK+fWfM
         CybA==
X-Forwarded-Encrypted: i=1; AJvYcCX8C4rXlWWtS7rK4MesJG6io31bTgBQW3Q3H0exEn78x5qpMo6JmgpugdW8WgIREPdKkXVePEh0H0U3MB0i@vger.kernel.org
X-Gm-Message-State: AOJu0YzdPN7yah2DIxcxDkSKCmNKd1Fy9KcXv2ZW4979LPuPt+UypdWR
	n8p/Jr7amDxwwfXAiMeApohUqo6kCDy/Pf9F5vHq5vH4tm/lIyx5Z+svUIdJUzFy/H8qdDJ06TR
	GTFxxWWjZWIe5OU4E16I9tGtRO1ggc4/JegXhM3oNUj+LwIud6ulFzOU=
X-Google-Smtp-Source: AGHT+IHnJ+33L+DOC1BWdlwpVtRpr3NfmR+TdrsKDI2KQ0zdahDEObJ010H7LXh6E7Fu4RQkoBmYMWZLwscAMw61qLEG7rZ3SeHK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:3a7:975d:4364 with SMTP id
 e9e14a558f8ab-3a79ab7f795mr160676665ab.0.1732584384000; Mon, 25 Nov 2024
 17:26:24 -0800 (PST)
Date: Mon, 25 Nov 2024 17:26:23 -0800
In-Reply-To: <0000000000007aa62a0619e8c330@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674523bf.050a0220.21d33d.0006.GAE@google.com>
Subject: Re: [syzbot] [jfs?] [bcachefs?] INFO: task hung in do_unlinkat (5)
From: syzbot <syzbot+08b113332e19a9378dd5@syzkaller.appspotmail.com>
To: brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, kent.overstreet@linux.dev, 
	linkinjeon@kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10a2e778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54f7b2f59e7640e5
dashboard link: https://syzkaller.appspot.com/bug?extid=08b113332e19a9378dd5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147d3ee8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14dc15c0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7562d921dc97/disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8fb84b5dec53/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cac8b3f180c1/bzImage-9f16d5e6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c1fa91bf8bb1/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+08b113332e19a9378dd5@syzkaller.appspotmail.com

INFO: task syz-executor130:5858 blocked for more than 143 seconds.
      Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor130 state:D stack:29072 pid:5858  tgid:5841  ppid:5837   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x17fb/0x4be0 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write_nested+0x1e0/0x220 kernel/locking/rwsem.c:1694
 inode_lock_nested include/linux/fs.h:853 [inline]
 do_unlinkat+0x26a/0x830 fs/namei.c:4574
 __do_sys_unlink fs/namei.c:4635 [inline]
 __se_sys_unlink fs/namei.c:4633 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4633
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8ff0002b49
RSP: 002b:00007f8feff98218 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007f8ff00946b8 RCX: 00007f8ff0002b49
RDX: 00007f8feffdc0f6 RSI: 0000000000000000 RDI: 0000000020000580
RBP: 00007f8ff00946b0 R08: 00007fffff5b63d7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0031656c69662f2e
R13: 00007f8ff00570c0 R14: 0030656c69662f2e R15: 0032656c69662f2e
 </TASK>
INFO: task syz-executor130:5854 blocked for more than 144 seconds.
      Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor130 state:D stack:28440 pid:5854  tgid:5842  ppid:5838   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x17fb/0x4be0 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write_nested+0x1e0/0x220 kernel/locking/rwsem.c:1694
 inode_lock_nested include/linux/fs.h:853 [inline]
 do_unlinkat+0x26a/0x830 fs/namei.c:4574
 __do_sys_unlink fs/namei.c:4635 [inline]
 __se_sys_unlink fs/namei.c:4633 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4633
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8ff0002b49
RSP: 002b:00007f8feff98218 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007f8ff00946b8 RCX: 00007f8ff0002b49
RDX: 00007f8feffdc0f6 RSI: 0000000000000000 RDI: 0000000020000580
RBP: 00007f8ff00946b0 R08: 00007fffff5b63d7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0031656c69662f2e
R13: 00007f8ff00570c0 R14: 0030656c69662f2e R15: 0032656c69662f2e
 </TASK>
INFO: task syz-executor130:5855 blocked for more than 145 seconds.
      Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor130 state:D stack:28912 pid:5855  tgid:5843  ppid:5836   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x17fb/0x4be0 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write_nested+0x1e0/0x220 kernel/locking/rwsem.c:1694
 inode_lock_nested include/linux/fs.h:853 [inline]
 do_unlinkat+0x26a/0x830 fs/namei.c:4574
 __do_sys_unlink fs/namei.c:4635 [inline]
 __se_sys_unlink fs/namei.c:4633 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4633
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8ff0002b49
RSP: 002b:00007f8feff98218 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007f8ff00946b8 RCX: 00007f8ff0002b49
RDX: 00007f8feffdc0f6 RSI: 0000000000000000 RDI: 0000000020000580
RBP: 00007f8ff00946b0 R08: 00007fffff5b63d7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0031656c69662f2e
R13: 00007f8ff00570c0 R14: 0030656c69662f2e R15: 0032656c69662f2e
 </TASK>
INFO: task syz-executor130:5856 blocked for more than 146 seconds.
      Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor130 state:D stack:29072 pid:5856  tgid:5844  ppid:5839   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x17fb/0x4be0 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write_nested+0x1e0/0x220 kernel/locking/rwsem.c:1694
 inode_lock_nested include/linux/fs.h:853 [inline]
 do_unlinkat+0x26a/0x830 fs/namei.c:4574
 __do_sys_unlink fs/namei.c:4635 [inline]
 __se_sys_unlink fs/namei.c:4633 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4633
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8ff0002b49
RSP: 002b:00007f8feff98218 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007f8ff00946b8 RCX: 00007f8ff0002b49
RDX: 00007f8feffdc0f6 RSI: 0000000000000000 RDI: 0000000020000580
RBP: 00007f8ff00946b0 R08: 00007fffff5b63d7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0031656c69662f2e
R13: 00007f8ff00570c0 R14: 0030656c69662f2e R15: 0032656c69662f2e
 </TASK>
INFO: task syz-executor130:5857 blocked for more than 147 seconds.
      Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor130 state:D stack:29072 pid:5857  tgid:5845  ppid:5840   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x17fb/0x4be0 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write_nested+0x1e0/0x220 kernel/locking/rwsem.c:1694
 inode_lock_nested include/linux/fs.h:853 [inline]
 do_unlinkat+0x26a/0x830 fs/namei.c:4574
 __do_sys_unlink fs/namei.c:4635 [inline]
 __se_sys_unlink fs/namei.c:4633 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4633
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8ff0002b49
RSP: 002b:00007f8feff98218 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007f8ff00946b8 RCX: 00007f8ff0002b49
RDX: 00007f8feffdc0f6 RSI: 0000000000000000 RDI: 0000000020000580
RBP: 00007f8ff00946b0 R08: 00007fffff5b63d7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0031656c69662f2e
R13: 00007f8ff00570c0 R14: 0030656c69662f2e R15: 0032656c69662f2e
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6744
1 lock held by kswapd0/88:
2 locks held by getty/5592:
 #0: ffff88814cf5a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
2 locks held by syz-executor130/5848:
2 locks held by syz-executor130/5858:
 #0: ffff88804b276420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff88807720c6c0 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:853 [inline]
 #1: ffff88807720c6c0 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at: do_unlinkat+0x26a/0x830 fs/namei.c:4574
3 locks held by syz-executor130/5851:
2 locks held by syz-executor130/5854:
 #0: ffff88804bba2420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff88807720cc00 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:853 [inline]
 #1: ffff88807720cc00 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at: do_unlinkat+0x26a/0x830 fs/namei.c:4574
2 locks held by syz-executor130/5847:
2 locks held by syz-executor130/5855:
 #0: ffff88807d41c420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff8880770886c0 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:853 [inline]
 #1: ffff8880770886c0 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at: do_unlinkat+0x26a/0x830 fs/namei.c:4574
3 locks held by syz-executor130/5850:
2 locks held by syz-executor130/5856:
 #0: ffff88804b886420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff888077088180 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:853 [inline]
 #1: ffff888077088180 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at: do_unlinkat+0x26a/0x830 fs/namei.c:4574
2 locks held by syz-executor130/5849:
2 locks held by syz-executor130/5857:
 #0: ffff88804b046420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff88807720c180 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:853 [inline]
 #1: ffff88807720c180 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at: do_unlinkat+0x26a/0x830 fs/namei.c:4574

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5847 Comm: syz-executor130 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__find_get_block+0x831/0x1150 fs/buffer.c:1404
Code: 75 74 73 ff e8 90 3c 7b ff fb 48 c7 44 24 40 0e 36 e0 45 48 b8 00 00 00 00 00 fc ff df 48 8b 4c 24 38 48 c7 04 08 00 00 00 00 <48> c7 44 08 09 00 00 00 00 66 c7 44 08 11 00 00 c6 44 08 13 00 65
RSP: 0018:ffffc90003f6f340 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff920007ede70
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003f6f478 R08: ffffffff8222697d R09: 1ffffd40002f172e
R10: dffffc0000000000 R11: fffff940002f172f R12: 0000000000000000
R13: ffffea000178b940 R14: ffffea000178b900 R15: 00000000003186d1
FS:  00007f8feffb96c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561c4fca3600 CR3: 00000000766a6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __getblk_slow fs/buffer.c:1127 [inline]
 bdev_getblk+0x18d/0x550 fs/buffer.c:1431
 __bread_gfp+0x86/0x400 fs/buffer.c:1485
 sb_bread include/linux/buffer_head.h:346 [inline]
 get_branch+0x2c3/0x6e0 fs/sysv/itree.c:102
 get_block+0x180/0x16d0 fs/sysv/itree.c:222
 block_read_full_folio+0x418/0xcd0 fs/buffer.c:2396
 filemap_read_folio+0x14b/0x630 mm/filemap.c:2366
 do_read_cache_folio+0x3f5/0x850 mm/filemap.c:3826
 read_mapping_folio include/linux/pagemap.h:1011 [inline]
 dir_get_folio fs/sysv/dir.c:64 [inline]
 sysv_find_entry+0x16a/0x4b0 fs/sysv/dir.c:154
 sysv_inode_by_name+0x98/0x2a0 fs/sysv/dir.c:370
 sysv_lookup+0x6b/0xe0 fs/sysv/namei.c:38
 lookup_one_qstr_excl+0x11f/0x260 fs/namei.c:1692
 do_renameat2+0x670/0x13f0 fs/namei.c:5165
 __do_sys_rename fs/namei.c:5271 [inline]
 __se_sys_rename fs/namei.c:5269 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5269
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8ff0002b49
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8feffb9218 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f8ff00946a8 RCX: 00007f8ff0002b49
RDX: 00007f8ff0002b49 RSI: 0000000020000080 RDI: 00000000200000c0
RBP: 00007f8ff00946a0 R08: 0000000000000000 R09: 0000000000000000
R10: 00ffffffffffffff R11: 0000000000000246 R12: 0031656c69662f2e
R13: 00007f8ff00570c0 R14: 0030656c69662f2e R15: 0032656c69662f2e
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.677 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

