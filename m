Return-Path: <linux-fsdevel+bounces-55889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77838B0F8CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 19:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5E5566CE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 17:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C48B2135B9;
	Wed, 23 Jul 2025 17:18:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F4F1DDC1B
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291111; cv=none; b=lK7R3nsgI9TgFxIiUKWTyKvAt4vsgWqSFeh1ERWrkJqyB3WZHa5F586pI6QYEN3/CNxARi2ONj/2an51eiydD9759muW8mzCwgjnKrEUSDksKs1cbeUIltBNTBcD8IynVuGiLMb7bwuTkQw7zimFWdXygbpxb75oDS7XrIvDplE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291111; c=relaxed/simple;
	bh=UVNk2gwcTV0Upq4beElxTA3IWUjTQaDD1GT+471r5gc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P39dGJhp2JCwiJjEZcdGKrDr0JoL26DMGEpr1+HqzmjlPAQQdJaAaclWr7x6kCwK9blnNKNAB9OVWgnei02QnzyUkT/G6fldhjkLuJo17LgWD25MkarrQeoZeCHTpk8KP7gwKErXvbjx4ccafMRmB6jTJIHcix9/FaR42oaAqDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-87c707bfeb6so8574839f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 10:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753291108; x=1753895908;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5MHYL/8Ep44gCCGXpP5bGPlDa5GTqtkkltmrt/synk=;
        b=CCZ0uE0f2g90glngxiKTZRoEzJLhdkj4o2TJ8tBkJq2jf81ycxKxUMUTqzT5aXOZsV
         SHbr9brqY72Kss1t3R1JWdZH4HVnPz/ZxBRFlDHg/gPTVn0u8Je0HikpvXvFBg9kb0JO
         7MeweyW9QE2s3Aaof1KIEWo++xzexUlR2Kk6NZ9VdsF2GfK/pJmanlDovKl3qZ6b4yBQ
         BDaeROfSDQsAFNYI7qA5dc5MnXM9e7zWWSCI1ZtuOqmlH6aimTKrcg9iw/8m7NJNND8O
         Tw12xEzoC6C8NdtChu+yc1S86YUtltI0QV+njmAO/1N53I88s3+yXQdO72rS1SvwOfgg
         vQKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVToERGBMBpXKxND4d2Aala6oqdWcnuWOIhaFr6SPMW/LGJBiK4ErbLJ0w9KrZtpLvKT6J0Q6dQIyTPWrTH@vger.kernel.org
X-Gm-Message-State: AOJu0YyYXhNC1Oiq2I0y84RPtEusU/c7iQPw9YdVdNLCwLppAM3XENzi
	y9xdvgqQivZcCU4MuwTHbwdjPIm6jDd3h+KNqmJCxcpfkeOsLn2j9ExSnAa5m+jduQE6g5k/CoO
	8R3m4qFPEK2i+PgaCm4hRPTXG7PzaZmKkS6mt3gItRqkcNzO8lp+fAivK3xk=
X-Google-Smtp-Source: AGHT+IFggdIvplBp/gIAuHSzczUpsmu6Z4YocPxPh+nR7tMsB7KjM/ocnrHeTR2kAvJkG1vVqqBk4UMPx3B/Wu6+Brt0IWxPhPZd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:a00f:b0:864:9cc7:b847 with SMTP id
 ca18e2360f4ac-87c6506b6e0mr711665539f.14.1753291108221; Wed, 23 Jul 2025
 10:18:28 -0700 (PDT)
Date: Wed, 23 Jul 2025 10:18:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68811964.050a0220.248954.0006.GAE@google.com>
Subject: [syzbot] [exfat?] INFO: task hung in generic_file_write_iter (3)
From: syzbot <syzbot+fa7ef54f66c189c04b73@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89be9a83ccf1 Linux 6.16-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1487cfd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=859f36d9ccbeaa3e
dashboard link: https://syzkaller.appspot.com/bug?extid=fa7ef54f66c189c04b73
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a1af22580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aedf22580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/643ea7d0c3c5/disk-89be9a83.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eff636e251a2/vmlinux-89be9a83.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2fb1b317d3fa/bzImage-89be9a83.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3be85efe76dc/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=13c30f22580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa7ef54f66c189c04b73@syzkaller.appspotmail.com

INFO: task syz-executor344:5859 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor344 state:D stack:28584 pid:5859  tgid:5841  ppid:5838   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x16aa/0x4c90 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6879
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6936
 rwsem_down_write_slowpath+0xbec/0x1030 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1ab/0x1f0 kernel/locking/rwsem.c:1578
 inode_lock include/linux/fs.h:869 [inline]
 generic_file_write_iter+0xe3/0x540 mm/filemap.c:4252
 do_iter_readv_writev+0x56b/0x7f0 fs/read_write.c:-1
 vfs_writev+0x31a/0x960 fs/read_write.c:1057
 do_writev+0x14d/0x2d0 fs/read_write.c:1103
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5f1bd82739
RSP: 002b:00007f5f1bd16218 EFLAGS: 00000246
 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f5f1be0a618 RCX: 00007f5f1bd82739
RDX: 0000000000000001 RSI: 00002000000001c0 RDI: 0000000000000004
RBP: 00007f5f1be0a610 R08: 00007ffe5b610c67 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00002000000000c0
R13: 00002000000001c0 R14: b7f7b4e26d48fd3f R15: 00002000000000e0
 </TASK>
INFO: task syz-executor344:5850 blocked for more than 144 seconds.
      Not tainted 6.16.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor344 state:D stack:25064 pid:5850  tgid:5842  ppid:5837   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x16aa/0x4c90 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6879
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6936
 rwsem_down_write_slowpath+0xbec/0x1030 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1ab/0x1f0 kernel/locking/rwsem.c:1578
 inode_lock include/linux/fs.h:869 [inline]
 process_measurement+0x3d8/0x1a40 security/integrity/ima/ima_main.c:260
 ima_file_check+0xd7/0x120 security/integrity/ima/ima_main.c:613
 security_file_post_open+0xbb/0x290 security/security.c:3130
 do_open fs/namei.c:3898 [inline]
 path_openat+0x2f26/0x3830 fs/namei.c:4055
 do_filp_open+0x1fa/0x410 fs/namei.c:4082
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5f1bd82739
RSP: 002b:00007f5f1bd37218 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f5f1be0a608 RCX: 00007f5f1bd82739
RDX: 0000000000183341 RSI: 0000200000000080 RDI: 00000000ffffff9c
RBP: 00007f5f1be0a600 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00002000000000c0
R13: 00002000000001c0 R14: b7f7b4e26d48fd3f R15: 00002000000000e0
 </TASK>
INFO: task syz-executor344:5857 blocked for more than 145 seconds.
      Not tainted 6.16.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor344 state:D stack:28440 pid:5857  tgid:5844  ppid:5840   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x16aa/0x4c90 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6879
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6936
 rwsem_down_write_slowpath+0xbec/0x1030 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1ab/0x1f0 kernel/locking/rwsem.c:1578
 inode_lock include/linux/fs.h:869 [inline]
 generic_file_write_iter+0xe3/0x540 mm/filemap.c:4252
 do_iter_readv_writev+0x56b/0x7f0 fs/read_write.c:-1
 vfs_writev+0x31a/0x960 fs/read_write.c:1057
 do_writev+0x14d/0x2d0 fs/read_write.c:1103
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5f1bd82739
RSP: 002b:00007f5f1bd16218 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f5f1be0a618 RCX: 00007f5f1bd82739
RDX: 0000000000000001 RSI: 00002000000001c0 RDI: 0000000000000004
RBP: 00007f5f1be0a610 R08: 00007ffe5b610c67 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00002000000000c0
R13: 00002000000001c0 R14: b7f7b4e26d48fd3f R15: 00002000000000e0
 </TASK>
INFO: task syz-executor344:5861 blocked for more than 146 seconds.
      Not tainted 6.16.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor344 state:D stack:28584 pid:5861  tgid:5845  ppid:5839   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x16aa/0x4c90 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6879
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6936
 rwsem_down_write_slowpath+0xbec/0x1030 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1ab/0x1f0 kernel/locking/rwsem.c:1578
 inode_lock include/linux/fs.h:869 [inline]
 generic_file_write_iter+0xe3/0x540 mm/filemap.c:4252
 do_iter_readv_writev+0x56b/0x7f0 fs/read_write.c:-1
 vfs_writev+0x31a/0x960 fs/read_write.c:1057
 do_writev+0x14d/0x2d0 fs/read_write.c:1103
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5f1bd82739
RSP: 002b:00007f5f1bd16218 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f5f1be0a618 RCX: 00007f5f1bd82739
RDX: 0000000000000001 RSI: 00002000000001c0 RDI: 0000000000000004
RBP: 00007f5f1be0a610 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffe5b610c67 R11: 0000000000000246 R12: 00002000000000c0
R13: 00002000000001c0 R14: b7f7b4e26d48fd3f R15: 00002000000000e0
 </TASK>
INFO: task syz-executor344:5862 blocked for more than 147 seconds.
      Not tainted 6.16.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor344 state:D stack:28584 pid:5862  tgid:5849  ppid:5843   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x16aa/0x4c90 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6879
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6936
 rwsem_down_write_slowpath+0xbec/0x1030 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1ab/0x1f0 kernel/locking/rwsem.c:1578
 inode_lock include/linux/fs.h:869 [inline]
 generic_file_write_iter+0xe3/0x540 mm/filemap.c:4252
 do_iter_readv_writev+0x56b/0x7f0 fs/read_write.c:-1
 vfs_writev+0x31a/0x960 fs/read_write.c:1057
 do_writev+0x14d/0x2d0 fs/read_write.c:1103
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5f1bd82739
RSP: 002b:00007f5f1bd16218 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f5f1be0a618 RCX: 00007f5f1bd82739
RDX: 0000000000000001 RSI: 00002000000001c0 RDI: 0000000000000004
RBP: 00007f5f1be0a610 R08: 00007ffe5b610c67 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00002000000000c0
R13: 00002000000001c0 R14: b7f7b4e26d48fd3f R15: 00002000000000e0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e13f0e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13f0e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e13f0e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6770
2 locks held by getty/5598:
 #0: ffff88814d7280a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900036cb2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
2 locks held by syz-executor344/5847:
3 locks held by syz-executor344/5859:
 #0: ffff888030c76478 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x247/0x320 fs/file.c:1217
 #1: ffff888030a62428 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 #1: ffff888030a62428 (sb_writers#8){.+.+}-{0:0}, at: vfs_writev+0x288/0x960 fs/read_write.c:1055
 #2: ffff8880749ec158 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
 #2: ffff8880749ec158 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: generic_file_write_iter+0xe3/0x540 mm/filemap.c:4252
2 locks held by syz-executor344/5850:
 #0: ffff888030a62428 (sb_writers#8){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:557
 #1: ffff8880749ec158 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}
, at: inode_lock include/linux/fs.h:869 [inline]
, at: process_measurement+0x3d8/0x1a40 security/integrity/ima/ima_main.c:260
7 locks held by syz-executor344/5848:
3 locks held by syz-executor344/5857:
 #0: ffff888077ddd0b8 (
&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x247/0x320 fs/file.c:1217
 #1: ffff888076fda428
 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 (sb_writers#8){.+.+}-{0:0}, at: vfs_writev+0x288/0x960 fs/read_write.c:1055
 #2: ffff8880749ea838 (&sb->s_type->i_mutex_key
#14){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
#14){+.+.}-{4:4}, at: generic_file_write_iter+0xe3/0x540 mm/filemap.c:4252
2 locks held by syz-executor344/5851:
 #0: ffff8880354c0428 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 #0: ffff8880354c0428 (sb_writers#8){.+.+}-{0:0}, at: vfs_fallocate+0x62a/0x830 fs/open.c:340
 #1: ffff8880749ec7a0 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
 #1: ffff8880749ec7a0 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: fat_fallocate+0xf4/0x2f0 fs/fat/file.c:279
3 locks held by syz-executor344/5861:
 #0: ffff8880286495f8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x247/0x320 fs/file.c:1217
 #1: ffff8880354c0428
 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 (sb_writers#8){.+.+}-{0:0}, at: vfs_writev+0x288/0x960 fs/read_write.c:1055
 #2: ffff8880749ec7a0 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
 #2: ffff8880749ec7a0 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: generic_file_write_iter+0xe3/0x540 mm/filemap.c:4252
2 locks held by syz-executor344/5852:
 #0: ffff888076fc6428 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 #0: ffff888076fc6428 (sb_writers#8){.+.+}-{0:0}, at: vfs_fallocate+0x62a/0x830 fs/open.c:340
 #1: ffff8880749ee0c0 (&sb->s_type->i_mutex_key
#14
){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
){+.+.}-{4:4}, at: fat_fallocate+0xf4/0x2f0 fs/fat/file.c:279
3 locks held by syz-executor344/5862:
 #0: 
ffff888028648638 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x247/0x320 fs/file.c:1217
 #1: ffff888076fc6428 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 #1: ffff888076fc6428 (sb_writers#8){.+.+}-{0:0}, at: vfs_writev+0x288/0x960 fs/read_write.c:1055
 #2: ffff8880749ee0c0 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
 #2: ffff8880749ee0c0 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: generic_file_write_iter+0xe3/0x540 mm/filemap.c:4252

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.16.0-rc7-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:307 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:470
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5848 Comm: syz-executor344 Not tainted 6.16.0-rc7-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:io_serial_in+0x77/0xc0 drivers/tty/serial/8250/8250_port.c:409
Code: e8 8e 0d 81 fc 44 89 f9 d3 e3 49 83 c6 40 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 af f4 e0 fc 41 03 1e 89 da ec <0f> b6 c0 5b 41 5c 41 5e 41 5f e9 ca 3a 2a 06 cc 44 89 f9 80 e1 07
RSP: 0018:ffffc9000413ed10 EFLAGS: 00000002
RAX: 1ffffffff33b8400 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000020
RBP: ffffffff99dc2350 R08: ffff8880244f0237 R09: 1ffff1100489e046
R10: dffffc0000000000 R11: ffffffff853f17d0 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff99dc20c0 R15: 0000000000000000
FS:  00007f5f1bd376c0(0000) GS:ffff888125c57000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561fd380d168 CR3: 000000002449a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 serial_in drivers/tty/serial/8250/8250.h:137 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:159 [inline]
 wait_for_lsr+0x1a1/0x2f0 drivers/tty/serial/8250/8250_port.c:2094
 fifo_wait_for_lsr drivers/tty/serial/8250/8250_port.c:3348 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3371 [inline]
 serial8250_console_write+0x134c/0x1ba0 drivers/tty/serial/8250/8250_port.c:3456
 console_emit_next_record kernel/printk/printk.c:3138 [inline]
 console_flush_all+0x725/0xc40 kernel/printk/printk.c:3226
 __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
 console_unlock+0xc4/0x270 kernel/printk/printk.c:3325
 vprintk_emit+0x5b7/0x7a0 kernel/printk/printk.c:2450
 _printk+0xcf/0x120 kernel/printk/printk.c:2475
 _fat_msg+0x117/0x170 fs/fat/misc.c:62
 __fat_fs_error+0x23d/0x2c0 fs/fat/misc.c:31
 fat_chain_add+0x6a3/0x810 fs/fat/misc.c:161
 fat_add_cluster+0xad/0x120 fs/fat/inode.c:112
 fat_fallocate+0x1bd/0x2f0 fs/fat/file.c:292
 vfs_fallocate+0x6a0/0x830 fs/open.c:341
 ioctl_preallocate fs/ioctl.c:290 [inline]
 file_ioctl+0x611/0x780 fs/ioctl.c:-1
 do_vfs_ioctl+0xe80/0x1990 fs/ioctl.c:886
 __do_sys_ioctl fs/ioctl.c:905 [inline]
 __se_sys_ioctl+0x82/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5f1bd82739
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5f1bd37218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5f1be0a608 RCX: 00007f5f1bd82739
RDX: 00002000000000c0 RSI: 0000000040305828 RDI: 0000000000000004
RBP: 00007f5f1be0a600 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00002000000000c0
R13: 00002000000001c0 R14: b7f7b4e26d48fd3f R15: 00002000000000e0
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.333 msecs


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

