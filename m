Return-Path: <linux-fsdevel+bounces-41969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AB8A3974E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 10:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855CF3A6558
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 09:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8D62309B5;
	Tue, 18 Feb 2025 09:37:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32422FAC3
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871446; cv=none; b=ZcZyvARShdsp02888hfw0sM9C/+LDdFKJW83N9ZgZJkY5umvOlu21hN6G8yHoi5yEBj1fW/WZNVXNzEBtWYOTFrP2421jfRuauu0U8Ko+Q+EnsrPML3jdGnEuznAE045QHkTdxNggqF49ER18rA7VYbn4iaj8bL982BuFWl/ajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871446; c=relaxed/simple;
	bh=1vzXxAhEudrAhyb1CsSMVfihnBRlSdyHD0J4se+ZkKs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GNz8VAfksU8ksuPrZ0wR+qtkJ9yyUg2q/a6yrXIsLJp1xNBilQnCC6mkurzXusx6QRZqwnyloFUup3fwV/FJ+MMBwdlf13Npw+/SbF7r1s+lCJaAR0rlI8tcno35iC2UCeVOP6dvmgM2r7eFgz/4Cy9LclN8oTCRGCuP7jsKphY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d18e28a0c1so97200475ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 01:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739871444; x=1740476244;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLZ4fY1/NxqwbUdjoAoI1yEPFjdoeZ2kiHEcyPZJC1Y=;
        b=W9zOuuecs4CZxibDuAJDdjQ7HO+CvmuWmmWXSsvoFHIvHrP9lb0A7QAdCnL4BBA1lw
         BjfZwGgO/CYjGQ7jzKdVM6ceXri7bdEBHjf9uXjm+9QstFGPxrIk+K8uu6kORo9rql+U
         ItQ2tyyh4dlRFQ5JM4gj14URF+dB75PEZ/eLBq7BcWjIVNCNMj8YkemkIkbg6ZCWcT9P
         4EKXIh0C7tOLYH3GTv2CGp9K627ZxjEYEo18dDbx3xxT1GYZoziZjLVSY3CVtGGYV+w2
         1z831rp0duhwiP9PE4xBgLRWVPI/anWrKMRGk5Nf8Hq/Op6Uf+sqAw/BHtr601Tk9PVv
         GFBA==
X-Forwarded-Encrypted: i=1; AJvYcCVGwyIL/kqpky8eJgu4myLNVys6ZPrZgfNO7IGt/t4ec/RFcfSJAGNUpF5qkCo1UtAW7EN+Yf4Rn+hv4Q4n@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0W0L1pM1ty70ZUwBE/7mSjPduk+gMySFokMeT9V9y10N+FtE9
	NG2SfTJIw3rsw3oxpITArtD1WHPqxG9BWk52bpJ/6VBkImkpccUHAyx4EvVtqF+mRyO3uaDYaLm
	SOICiLJOg6EMQPnequpUiet2dZEGTFeXWZ2KfDAaHBGhgs6MN5zYehGU=
X-Google-Smtp-Source: AGHT+IEm82RK3nnYqiu/mYzAVrx+dILIstbP39Ck3XYMaxYLNL9eyMHJ8hlfxzpUGC53uwrwTtS1l7Y1imi/shDsJlP6RzNpi6m1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8c:b0:3d0:21aa:a756 with SMTP id
 e9e14a558f8ab-3d2807aba07mr117250795ab.5.1739871444163; Tue, 18 Feb 2025
 01:37:24 -0800 (PST)
Date: Tue, 18 Feb 2025 01:37:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b454d4.050a0220.173698.0051.GAE@google.com>
Subject: [syzbot] [netfs?] INFO: task hung in pipe_write (6)
From: syzbot <syzbot+5984e31a805252b3b40a@syzkaller.appspotmail.com>
To: brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	idryomov@gmail.com, jack@suse.cz, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, netfs@lists.linux.dev, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ad1b832bf1cf Merge tag 'devicetree-fixes-for-6.14-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1251a898580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e55cabe422b4fcaf
dashboard link: https://syzkaller.appspot.com/bug?extid=5984e31a805252b3b40a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170d57df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12df35a4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9de6d97a8d34/disk-ad1b832b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/258463d6a9b5/vmlinux-ad1b832b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0449b94f00a/bzImage-ad1b832b.xz

The issue was bisected to:

commit 7ba167c4c73ed96eb002c98a9d7d49317dfb0191
Author: David Howells <dhowells@redhat.com>
Date:   Mon Mar 18 16:57:31 2024 +0000

    netfs: Switch to using unsigned long long rather than loff_t

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166625b0580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=156625b0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=116625b0580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5984e31a805252b3b40a@syzkaller.appspotmail.com
Fixes: 7ba167c4c73e ("netfs: Switch to using unsigned long long rather than loff_t")

INFO: task kworker/1:2:837 blocked for more than 143 seconds.
      Not tainted 6.14.0-rc2-syzkaller-00303-gad1b832bf1cf #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:2     state:D stack:25360 pid:837   tgid:837   ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: events p9_write_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5377 [inline]
 __schedule+0x18bc/0x4c40 kernel/sched/core.c:6764
 __schedule_loop kernel/sched/core.c:6841 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6856
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6913
 __mutex_lock_common kernel/locking/mutex.c:662 [inline]
 __mutex_lock+0x817/0x1010 kernel/locking/mutex.c:730
 pipe_write+0x1c6/0x1a30 fs/pipe.c:456
 __kernel_write_iter+0x433/0x950 fs/read_write.c:612
 __kernel_write fs/read_write.c:632 [inline]
 kernel_write+0x214/0x330 fs/read_write.c:653
 p9_fd_write net/9p/trans_fd.c:432 [inline]
 p9_write_work+0x57d/0xd70 net/9p/trans_fd.c:483
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8eb38f60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8eb38f60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8eb38f60 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6746
3 locks held by kworker/1:2/837:
 #0: ffff88801b080d48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88801b080d48 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x98b/0x18e0 kernel/workqueue.c:3317
 #1: ffffc90003547c60 ((work_completion)(&m->wq)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90003547c60 ((work_completion)(&m->wq)){+.+.}-{0:0}, at: process_scheduled_works+0x9c6/0x18e0 kernel/workqueue.c:3317
 #2: ffff8880233c5468 (&pipe->mutex){+.+.}-{4:4}, at: pipe_write+0x1c6/0x1a30 fs/pipe.c:456
2 locks held by getty/5577:
 #0: ffff8880354a20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x616/0x1770 drivers/tty/n_tty.c:2211
2 locks held by syz-executor138/5815:
 #0: ffff8880233c5468 (&pipe->mutex){+.+.}-{4:4}, at: pipe_write+0x1c6/0x1a30 fs/pipe.c:456
 #1: ffff888077e802e8 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:932 [inline]
 #1: ffff888077e802e8 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: page_cache_ra_unbounded+0x156/0x820 mm/readahead.c:229

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.14.0-rc2-syzkaller-00303-gad1b832bf1cf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:236 [inline]
 watchdog+0x1058/0x10a0 kernel/hung_task.c:399
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 0 skipped: idling at acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:111


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

