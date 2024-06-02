Return-Path: <linux-fsdevel+bounces-20734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFF48D75DE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 16:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49862824B7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAB240848;
	Sun,  2 Jun 2024 14:09:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A696D3D387
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jun 2024 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717337365; cv=none; b=WgLsh430nh0s26E17HgSFK1BnXxSBo+bAuL59FlL4vbs9SjGg6yTkxiH2BwsVj/QUS3kumZxJCwXB+NnZYIL4TEJewBslLCqaQHNDWpQaQz3fxcjGv1OLQ/st+Fkn/NjUlumI1pjMlQ1cmX51ULj7NgFBsQYRHGM1G59juucyLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717337365; c=relaxed/simple;
	bh=kJxeVbEqQW7ysv/Z1X5ieihf48ygtv9hKGZbBclL57c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tBfPx9ahNtAQxpHVwymvHeU1Awa9pBYGXh/yG7ILt/X/nUfKAYsFqbuuBFAxWKW6BHUX5YYdx2ctfPJLlqrMX1Is6oKne636JBzSeJh7XogMDJqAhh8/J7iDcdrVxlARjrEEAD/0borncYQ0dZ0AqZyu6utq2730fKETZUGHfPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e1ea8608afso468813339f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jun 2024 07:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717337363; x=1717942163;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmIyVt3WKHxn0afBt5IKOYUapABvxb3wOIfnd2NiOKU=;
        b=VXfqwDNwL9dCAZ+hUwZYmsOfhw5LLpcRLKyUGc6112Fh73MBsVQNinL3pfu9AtG9lh
         qfaPeDfo+i3mmPDb5tXYIDhWvqtGC/Sk4Lg+DrfeaXe8P+5DkBtXleXPRL7lpjQmuEAE
         R/+NM+cNCcN0/LnOKQiY9sGX7g4YoopMlaaHNeHTtU3fOcZpWsstY01Jf70QGQZibXFZ
         w5p7eZGzFFqX8P/6X2U+VOZfA8tLnDQNXh+1OAvKpCV3pwga73sXabCV4b/6wTfTq8G2
         PwRlOXpNXdZktT7dpkIoQIMzx8LcEn5i7E79SlFwAI+aUUGhuYQIqlZS+qDIY2hO2t/d
         RaYw==
X-Forwarded-Encrypted: i=1; AJvYcCXxx00H/qC3ia6xA5Z3KZ/4NVTlk9YRYEqNz2PeNzXHgLrZ2akI78IIzj2HszUH7JVyl8s6kebNuqC856DMWPFOzoONhto3Q0wSR5cmgA==
X-Gm-Message-State: AOJu0YyZIIJm/fI6JgvMOr3zn8BUGajJ6PQkS/angflJ1cgUHYyDvBIH
	ZVFdYEzZrPnKD8YDx0v3TjcKvGOsjmw/UVJYy/3qhhMTRLDfoep8YKdqQ/HdBxB39SOJOmPkL3n
	bL+Z8GPbECZ4vZvShblz7nlXCQv+eqXsKnBL+jZcpR75STd9PmILwRkY=
X-Google-Smtp-Source: AGHT+IEc4x0OYbFZzOWOTZqTcZjZDZpUevfECQm4f4kBd6Hggep4jD8b8Tn/aRkAU4ZZksw1/skgZ+6BjGgNEkFKk/J+EcatIKTv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2185:b0:374:491c:654a with SMTP id
 e9e14a558f8ab-3748b97c4d4mr2600685ab.1.1717337362961; Sun, 02 Jun 2024
 07:09:22 -0700 (PDT)
Date: Sun, 02 Jun 2024 07:09:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007aa62a0619e8c330@google.com>
Subject: [syzbot] [kernfs?] [bcachefs?] [exfat?] INFO: task hung in
 do_unlinkat (5)
From: syzbot <syzbot+08b113332e19a9378dd5@syzkaller.appspotmail.com>
To: brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz, 
	kent.overstreet@linux.dev, linkinjeon@kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b6394d6f7159 Merge tag 'pull-misc' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146989a4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=713476114e57eef3
dashboard link: https://syzkaller.appspot.com/bug?extid=08b113332e19a9378dd5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e1377d4772/disk-b6394d6f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/19fbbb3b6dd5/vmlinux-b6394d6f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4dcce16af95d/bzImage-b6394d6f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+08b113332e19a9378dd5@syzkaller.appspotmail.com

INFO: task syz-executor.2:9894 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-10729-gb6394d6f7159 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:24688 pid:9894  tgid:9893  ppid:9055   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x4a00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 inode_lock_nested include/linux/fs.h:826 [inline]
 do_unlinkat+0x26a/0x830 fs/namei.c:4394
 __do_sys_unlink fs/namei.c:4455 [inline]
 __se_sys_unlink fs/namei.c:4453 [inline]
 __x64_sys_unlink+0x49/0x60 fs/namei.c:4453
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faae4e7cee9
RSP: 002b:00007faae5c910c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007faae4fabf80 RCX: 00007faae4e7cee9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000a80
RBP: 00007faae4ec949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007faae4fabf80 R15: 00007ffee8d5b6f8
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:1/12:
1 lock held by khungtaskd/30:
 #0: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by kworker/u8:7/2801:
2 locks held by getty/4839:
 #0: ffff88802f9390a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
2 locks held by syz-fuzzer/5091:
3 locks held by kworker/1:6/5155:
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90003a8fd00 (free_ipc_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90003a8fd00 (free_ipc_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e3390f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
 #2: ffffffff8e3390f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:939
2 locks held by syz-executor.2/9894:
 #0: ffff888063566420 (sb_writers#35){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff88805ef856a8 (&type->i_mutex_dir_key#29/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:826 [inline]
 #1: ffff88805ef856a8 (&type->i_mutex_dir_key#29/1){+.+.}-{3:3}, at: do_unlinkat+0x26a/0x830 fs/namei.c:4394
2 locks held by syz-executor.2/9897:
3 locks held by syz-executor.4/11013:
2 locks held by syz-executor.4/11026:
 #0: ffff888021986420 (sb_writers#25){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff88805505afe0 (&type->i_mutex_dir_key#20/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:826 [inline]
 #1: ffff88805505afe0 (&type->i_mutex_dir_key#20/1){+.+.}-{3:3}, at: filename_create+0x260/0x540 fs/namei.c:3900
1 lock held by syz-executor.4/11030:
 #0: ffff88805505afe0 (&type->i_mutex_dir_key#20){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:801 [inline]
 #0: ffff88805505afe0 (&type->i_mutex_dir_key#20){++++}-{3:3}, at: lookup_slow+0x45/0x70 fs/namei.c:1708
2 locks held by syz-executor.4/11037:
 #0: ffff888021986420 (sb_writers#25){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff88805505afe0 (&type->i_mutex_dir_key#20/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:826 [inline]
 #1: ffff88805505afe0 (&type->i_mutex_dir_key#20/1){+.+.}-{3:3}, at: filename_create+0x260/0x540 fs/namei.c:3900
2 locks held by syz-executor.4/11038:
 #0: ffff888021986420 (sb_writers#25){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff88805505afe0 (&type->i_mutex_dir_key#20){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:801 [inline]
 #1: ffff88805505afe0 (&type->i_mutex_dir_key#20){++++}-{3:3}, at: open_last_lookups fs/namei.c:3573 [inline]
 #1: ffff88805505afe0 (&type->i_mutex_dir_key#20){++++}-{3:3}, at: path_openat+0x7c4/0x3280 fs/namei.c:3804
4 locks held by kworker/0:2/11663:
 #0: ffff8880b943e798 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 #1: ffff8880b9428948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:988
 #2: ffff8880b942a718 (&base->lock){-.-.}-{2:2}, at: __debug_check_no_obj_freed lib/debugobjects.c:978 [inline]
 #2: ffff8880b942a718 (&base->lock){-.-.}-{2:2}, at: debug_check_no_obj_freed+0x234/0x580 lib/debugobjects.c:1019
 #3: ffffffff94a429d8 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0x16d/0x510 lib/debugobjects.c:708


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

