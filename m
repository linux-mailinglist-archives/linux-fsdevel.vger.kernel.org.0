Return-Path: <linux-fsdevel+bounces-38354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0BFA0041B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 07:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1026B3A1028
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 06:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A72187555;
	Fri,  3 Jan 2025 06:09:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5295D13B2A4
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jan 2025 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735884566; cv=none; b=MF+QLWEr9y0yZLecevzFRFIQVxKpghTEYbgnEJex751R72C0bEjOwIJeNxJSAKugv+ZM7IW5IgWfUHOhphRjVxpFz8DEn2+slU6HT1ANDiXXp8R5bgdxsSPzyN9qCYWd/L9JhMXjmpH2aayLfxO+Dwuo4hK1bKqIPNyTGSqle7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735884566; c=relaxed/simple;
	bh=l1RBgAGB7hMU2hii++atK289dn8dXbQgpI3zwlVaDDo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h2W0qHt//nliKD0M9mBd0rYDIhUx02NZlC0GNz0XUpt7Qxmh4SXDeDY7XiWfhm1dsuyDYvBxoQcnMQhBkfS+/acYGCnDpdrXYeFPPG/XxrwTgcVIf7RxC7XWLFVOwqjXN/xSPRVjRTtjyZvlET7ayo/QqDfOQlOgA1c8SFmTD/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7d85ab308so115677895ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2025 22:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735884563; x=1736489363;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+6UPPbzeg24U59IjirzkQa4jGZHnvFYM1DYFh/iyEg=;
        b=lgQ16oMGxFExdCWiDoG09t9491Bofsj2SPE4vbxUEV3ifkI2JtLDVSWGhFj91MtfTw
         9XsgOo9Oi49MCxMj3pZfEik+XGqbHeYu8wdIgTMGvqT7lVY+r2QsJ6H2BQbzBmfR1M/k
         G3WjRB0c2W1yiahsDwd2IeAH0X7N/jJyEfNK+PxLS+TaxMfIAOQmqrrSsYdsDgJh+kUw
         4ui1dNqlU+/niDxFlduz7jfhjvm2H65nZAZnmiahVboW2f+mT5n4uyNKzRUCM3K1zEeT
         0ChGt+ZAHwSkwsb7jmLvER6+BIc00dwpIM28mwxqqxia5NXqdKc06/D7ewonUne6GxEz
         h3Xw==
X-Gm-Message-State: AOJu0YyRiCRM5eg8roXh9Gq3zFioumB7IdjWnF5E1B8qcgIFnYuoGo3M
	WxgqP59nkwvGXbm0UxHmwYdZnm65foONBeGoBFmWG5uYRWW3QdxyxYL5Ty7oKFXq4jWckdNV13Z
	mv0ql8CdR6GKHqC+UoWsZK9dZnQ5ME7OlTaQkGALV50TOUPrVXXFw7AR7hg==
X-Google-Smtp-Source: AGHT+IF20GyN0Xl9ylD+LeOuYdXjSUY1H6D2PauJVt5hg/fUBFDiVWMjBZ5MY5GVViq5Vqi2GmWHVz62H38pI+Kxz7x2KyUuLtfa
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca09:0:b0:3a7:8d8e:e730 with SMTP id
 e9e14a558f8ab-3c2d54348admr288877025ab.22.1735884563455; Thu, 02 Jan 2025
 22:09:23 -0800 (PST)
Date: Thu, 02 Jan 2025 22:09:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67777f13.050a0220.11076.0003.GAE@google.com>
Subject: [syzbot] [fs?] INFO: task hung in __generic_file_fsync (5)
From: syzbot <syzbot+d11add3a08fc150ce457@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8155b4ef3466 Add linux-next specific files for 20241220
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=162b26df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c90bb7161a56c88
dashboard link: https://syzkaller.appspot.com/bug?extid=d11add3a08fc150ce457
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169faaf8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12696818580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/98a974fc662d/disk-8155b4ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2dea9b72f624/vmlinux-8155b4ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/593a42b9eb34/bzImage-8155b4ef.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4da9f7f100dd/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14bdaac4580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16bdaac4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12bdaac4580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d11add3a08fc150ce457@syzkaller.appspotmail.com

INFO: task syz-executor324:5878 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor324 state:D stack:28912 pid:5878  tgid:5861  ppid:5857   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5371 [inline]
 __schedule+0x189f/0x4c80 kernel/sched/core.c:6758
 __schedule_loop kernel/sched/core.c:6835 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6850
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6907
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
 inode_lock include/linux/fs.h:863 [inline]
 __generic_file_fsync+0x97/0x1a0 fs/libfs.c:1537
 generic_file_fsync+0x70/0xf0 fs/libfs.c:1574
 vfs_fsync_range fs/sync.c:187 [inline]
 vfs_fsync fs/sync.c:201 [inline]
 do_fsync fs/sync.c:212 [inline]
 __do_sys_fdatasync fs/sync.c:222 [inline]
 __se_sys_fdatasync fs/sync.c:220 [inline]
 __x64_sys_fdatasync+0xb6/0x110 fs/sync.c:220
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f66848ece09
RSP: 002b:00007f6684882218 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
RAX: ffffffffffffffda RBX: 00007f668497e6d8 RCX: 00007f66848ece09
RDX: 00007f66848ece09 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f668497e6d0 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffebef38b97 R11: 0000000000000246 R12: 00007f6684941160
R13: 0030656c69662f30 R14: 2f30656c69662f2e R15: 0031656c69662f2e
 </TASK>
INFO: task syz-executor324:5879 blocked for more than 144 seconds.
      Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor324 state:D stack:29200 pid:5879  tgid:5862  ppid:5856   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5371 [inline]
 __schedule+0x189f/0x4c80 kernel/sched/core.c:6758
 __schedule_loop kernel/sched/core.c:6835 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6850
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6907
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
 inode_lock include/linux/fs.h:863 [inline]
 __generic_file_fsync+0x97/0x1a0 fs/libfs.c:1537
 generic_file_fsync+0x70/0xf0 fs/libfs.c:1574
 vfs_fsync_range fs/sync.c:187 [inline]
 vfs_fsync fs/sync.c:201 [inline]
 do_fsync fs/sync.c:212 [inline]
 __do_sys_fdatasync fs/sync.c:222 [inline]
 __se_sys_fdatasync fs/sync.c:220 [inline]
 __x64_sys_fdatasync+0xb6/0x110 fs/sync.c:220
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f66848ece09
RSP: 002b:00007f6684882218 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
RAX: ffffffffffffffda RBX: 00007f668497e6d8 RCX: 00007f66848ece09
RDX: 00007f66848c63c6 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f668497e6d0 R08: 00007ffebef38b97 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6684941160
R13: 0030656c69662f30 R14: 2f30656c69662f2e R15: 0031656c69662f2e
 </TASK>
INFO: task syz-executor324:5874 blocked for more than 145 seconds.
      Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor324 state:D stack:28632 pid:5874  tgid:5863  ppid:5858   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5371 [inline]
 __schedule+0x189f/0x4c80 kernel/sched/core.c:6758
 __schedule_loop kernel/sched/core.c:6835 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6850
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6907
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
 inode_lock include/linux/fs.h:863 [inline]
 __generic_file_fsync+0x97/0x1a0 fs/libfs.c:1537
 generic_file_fsync+0x70/0xf0 fs/libfs.c:1574
 vfs_fsync_range fs/sync.c:187 [inline]
 vfs_fsync fs/sync.c:201 [inline]
 do_fsync fs/sync.c:212 [inline]
 __do_sys_fdatasync fs/sync.c:222 [inline]
 __se_sys_fdatasync fs/sync.c:220 [inline]
 __x64_sys_fdatasync+0xb6/0x110 fs/sync.c:220
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f66848ece09
RSP: 002b:00007f6684882218 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
RAX: ffffffffffffffda RBX: 00007f668497e6d8 RCX: 00007f66848ece09
RDX: 00007f66848c63c6 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f668497e6d0 R08: 00007ffebef38b97 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6684941160
R13: 0030656c69662f30 R14: 2f30656c69662f2e R15: 0031656c69662f2e
 </TASK>
INFO: task syz-executor324:5876 blocked for more than 145 seconds.
      Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor324 state:D stack:29200 pid:5876  tgid:5866  ppid:5859   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5371 [inline]
 __schedule+0x189f/0x4c80 kernel/sched/core.c:6758
 __schedule_loop kernel/sched/core.c:6835 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6850
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6907
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
 inode_lock include/linux/fs.h:863 [inline]
 __generic_file_fsync+0x97/0x1a0 fs/libfs.c:1537
 generic_file_fsync+0x70/0xf0 fs/libfs.c:1574
 vfs_fsync_range fs/sync.c:187 [inline]
 vfs_fsync fs/sync.c:201 [inline]
 do_fsync fs/sync.c:212 [inline]
 __do_sys_fdatasync fs/sync.c:222 [inline]
 __se_sys_fdatasync fs/sync.c:220 [inline]
 __x64_sys_fdatasync+0xb6/0x110 fs/sync.c:220
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f66848ece09
RSP: 002b:00007f6684882218 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
RAX: ffffffffffffffda RBX: 00007f668497e6d8 RCX: 00007f66848ece09
RDX: 00007f66848c63c6 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f668497e6d0 R08: 00007ffebef38b97 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6684941160
R13: 0030656c69662f30 R14: 2f30656c69662f2e R15: 0031656c69662f2e
 </TASK>
INFO: task syz-executor324:5877 blocked for more than 146 seconds.
      Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor324 state:D stack:28912 pid:5877  tgid:5865  ppid:5860   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5371 [inline]
 __schedule+0x189f/0x4c80 kernel/sched/core.c:6758
 __schedule_loop kernel/sched/core.c:6835 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6850
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6907
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
 inode_lock include/linux/fs.h:863 [inline]
 __generic_file_fsync+0x97/0x1a0 fs/libfs.c:1537
 generic_file_fsync+0x70/0xf0 fs/libfs.c:1574
 vfs_fsync_range fs/sync.c:187 [inline]
 vfs_fsync fs/sync.c:201 [inline]
 do_fsync fs/sync.c:212 [inline]
 __do_sys_fdatasync fs/sync.c:222 [inline]
 __se_sys_fdatasync fs/sync.c:220 [inline]
 __x64_sys_fdatasync+0xb6/0x110 fs/sync.c:220
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f66848ece09
RSP: 002b:00007f6684882218 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
RAX: ffffffffffffffda RBX: 00007f668497e6d8 RCX: 00007f66848ece09
RDX: 00007f66848ece09 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f668497e6d0 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffebef38b97 R11: 0000000000000246 R12: 00007f6684941160
R13: 0030656c69662f30 R14: 2f30656c69662f2e R15: 0031656c69662f2e
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6744
1 lock held by kswapd0/89:
1 lock held by kswapd1/90:
2 locks held by getty/5589:
 #0: ffff88814d95d0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
1 lock held by syz-executor324/5869:
1 lock held by syz-executor324/5878:
 #0: ffff88807ba6c180 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: inode_lock include/linux/fs.h:863 [inline]
 #0: ffff88807ba6c180 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: __generic_file_fsync+0x97/0x1a0 fs/libfs.c:1537
1 lock held by syz-executor324/5872:
1 lock held by syz-executor324/5879:
 #0: ffff88807ba6cc00 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: inode_lock include/linux/fs.h:863 [inline]
 #0: ffff88807ba6cc00 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: __generic_file_fsync+0x97/0x1a0 fs/libfs.c:1537
1 lock held by syz-executor324/5870:
1 lock held by syz-executor324/5874:
 #0: ffff88807ba64180 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: inode_lock include/linux/fs.h:863 [inline]
 #0: ffff88807ba64180 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: __generic_file_fsync+0x97/0x1a0 fs/libfs.c:1537
2 locks held by syz-executor324/5871:
1 lock held by syz-executor324/5876:
 #0: ffff88807ba646c0 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: inode_lock include/linux/fs.h:863 [inline]
 #0: ffff88807ba646c0 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: __generic_file_fsync+0x97/0x1a0 fs/libfs.c:1537
5 locks held by syz-executor324/5873:
1 lock held by syz-executor324/5877:
 #0: ffff88807ba6c6c0 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: inode_lock include/linux/fs.h:863 [inline]
 #0: ffff88807ba6c6c0 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: __generic_file_fsync+0x97/0x1a0 fs/libfs.c:1537

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
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
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5871 Comm: syz-executor324 Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:check_kcov_mode kernel/kcov.c:185 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:246 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x2f/0x90 kernel/kcov.c:314
Code: 8b 04 24 65 48 8b 14 25 c0 d6 03 00 65 8b 05 50 ae 44 7e 25 00 01 ff 00 74 10 3d 00 01 00 00 75 5b 83 ba 24 16 00 00 00 74 52 <8b> 82 00 16 00 00 83 f8 03 75 47 48 8b 8a 08 16 00 00 44 8b 8a 04
RSP: 0018:ffffc900041ced78 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff888078ef9e00
RDX: ffff888078ef9e00 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900041cee80 R08: ffffffff81f7ce68 R09: 1ffffffff285af08
R10: dffffc0000000000 R11: fffffbfff285af09 R12: 0000000000000000
R13: dffffc0000000000 R14: ffffc900041cedd8 R15: ffffc900041cedc0
FS:  00007f66848a36c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efd57688580 CR3: 000000002506c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 rcu_read_lock include/linux/rcupdate.h:850 [inline]
 filemap_get_entry+0x158/0x3b0 mm/filemap.c:1820
 __filemap_get_folio+0x72/0x940 mm/filemap.c:1868
 __find_get_block_slow fs/buffer.c:203 [inline]
 __find_get_block+0x287/0x1140 fs/buffer.c:1398
 bdev_getblk+0x33/0x670 fs/buffer.c:1425
 __bread_gfp+0x86/0x400 fs/buffer.c:1485
 sb_bread include/linux/buffer_head.h:346 [inline]
 get_branch+0x2c3/0x6e0 fs/sysv/itree.c:102
 get_block+0x180/0x16d0 fs/sysv/itree.c:222
 block_read_full_folio+0x3ee/0xae0 fs/buffer.c:2396
 filemap_read_folio+0x148/0x3b0 mm/filemap.c:2348
 do_read_cache_folio+0x373/0x5b0 mm/filemap.c:3893
 read_mapping_folio include/linux/pagemap.h:1032 [inline]
 dir_get_folio fs/sysv/dir.c:64 [inline]
 sysv_find_entry+0x16c/0x590 fs/sysv/dir.c:154
 sysv_inode_by_name+0x98/0x2a0 fs/sysv/dir.c:370
 sysv_lookup+0x6b/0xe0 fs/sysv/namei.c:38
 __lookup_slow+0x28c/0x3f0 fs/namei.c:1791
 lookup_slow+0x53/0x70 fs/namei.c:1808
 walk_component fs/namei.c:2112 [inline]
 link_path_walk+0x99b/0xea0 fs/namei.c:2477
 path_parentat fs/namei.c:2681 [inline]
 __filename_parentat+0x2a7/0x740 fs/namei.c:2705
 filename_parentat fs/namei.c:2723 [inline]
 do_renameat2+0x3b8/0x13f0 fs/namei.c:5136
 __do_sys_rename fs/namei.c:5271 [inline]
 __se_sys_rename fs/namei.c:5269 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5269
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f66848ece09
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f66848a3218 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f668497e6c8 RCX: 00007f66848ece09
RDX: ffffffffffffffb0 RSI: 0000000020000000 RDI: 0000000020000040
RBP: 00007f668497e6c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6684941160
R13: 0030656c69662f30 R14: 2f30656c69662f2e R15: 0031656c69662f2e
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

