Return-Path: <linux-fsdevel+bounces-69581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F8CC7E82A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 23:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754133A4F69
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 22:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FB0274B2E;
	Sun, 23 Nov 2025 22:44:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042E01B4F2C
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763937872; cv=none; b=Iu9E4xivkZYOkQdrG9Fm7BgESspus0upXtTA0jKUzwCJKjf7A1XjITGbqnC3GXf4p/rZSG1KRFQp2r8qIknymwDmCefcspUvnR/qFHVi5mOxzro5zg1/NqACKAobykME11CLbBpYRNBWeWhmdCdWkYDG1tEQ7ErHEV2tl8qHAg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763937872; c=relaxed/simple;
	bh=yii9UVWnSjNHjvEvvkBVI9dl32AgIQcL0OEduweVrwY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pzbo3z8jhRY58PglS2ble0IhntMd1g95yU7CMk0/8PlB6cKTYqB/kbtx6++zE90NSXMyQCuMpZnteG46NLx+c43+oISSQ0Rwgh1a6soxy2KWP0J7Lla0YcqKnqBpJJa7S3aMGb7mu+m3uiqG8t5ExXqJVKQsbs1F6bDJNCWZv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-43376637642so37115135ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 14:44:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763937869; x=1764542669;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kR0P7tPJwaauNhD0wbKYyT+7PMxQKf4qFnJzBc2a1lg=;
        b=vDz5f93tB9bjYepLX7rnWncZtv4zzd8sQl5Gzo1y+v20/oFpyRZvEbJRpgvpelVaOS
         xZPeV1WliZ9IV/v3r4h95mmFjTdU3SHhYls5N/FJ0bbrmndpzWCg/8LCLaRb3WY/8Kub
         y/V0GMOsqWxbJUx4a5feLn0444iweiU7OVKcXqgkKrAhr3GXaqGuhqInUJo7QQX8pS1P
         JDv0vVttM576P3AT6HkzmjLQnA+lQCgJMePhXdM2trULGGyFJt+z0Ck/ZbzdTdKTpy47
         nRJijeM6hjgFn8rL2LNk2Hhk9bvgQkQzJ0IIqZdj2FXkLkaMa+UEyrcoBBEzLJrt2mB9
         S2mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfiiRJg6LTJG37qAzfA+NauF3e2gauAgHhuLN5dviCukMVM0TUHkjPznxQGocw/ud9gjl1IbnZVBxJER/T@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ03ygYa7loEvLd2hwquPuztqp4SDzjei+2yCF2imE0EWIa/xt
	PkcTrBSreTxMQpGx+aEfq8HpRstxWWywiMWdG1y71+kZLaoMxpoJY6K/HULavDMTdEm5knJ7KOS
	n95TYp0U5EmVnzEdNlMVSIBHJ+2qLgv+eorzu9wl6Fqw5JVL5Fr6KSFn+PAg=
X-Google-Smtp-Source: AGHT+IGHUxzDI9NBvvMfeAyBU2mSLNvcSemsXzLkgFIgqXQ8jK8L9Eb5GJTJgICdgBCQt9yOjy1KedgXz1v31dHRj6QYTc9Nvuau
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe8:b0:432:10f9:5e0a with SMTP id
 e9e14a558f8ab-435b98c55e7mr62638615ab.19.1763937869205; Sun, 23 Nov 2025
 14:44:29 -0800 (PST)
Date: Sun, 23 Nov 2025 14:44:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69238e4d.a70a0220.d98e3.006e.GAE@google.com>
Subject: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
From: syzbot <syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com>
To: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	brauner@kernel.org, dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, mjguzik@gmail.com, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe4d0dea039f Add linux-next specific files for 20251119
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=142c0514580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f20a6db7594dcad7
dashboard link: https://syzkaller.appspot.com/bug?extid=2fefb910d2c20c0698d8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cd7692580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17615658580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce4f26d91a01/disk-fe4d0dea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c9b53acf521/vmlinux-fe4d0dea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/64d37d01cd64/bzImage-fe4d0dea.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a91529a880b1/mount_0.gz

The issue was bisected to:

commit 1e3c3784221ac86401aea72e2bae36057062fc9c
Author: Mateusz Guzik <mjguzik@gmail.com>
Date:   Fri Oct 10 22:17:36 2025 +0000

    fs: rework I_NEW handling to operate without fences

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17739742580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f39742580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10f39742580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com
Fixes: 1e3c3784221a ("fs: rework I_NEW handling to operate without fences")

INFO: task syz.0.17:6022 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:28744 pid:6022  tgid:6020  ppid:5945   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5263 [inline]
 __schedule+0x1836/0x4ed0 kernel/sched/core.c:6871
 __schedule_loop kernel/sched/core.c:6953 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6968
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7025
 rwsem_down_write_slowpath+0x872/0xfe0 kernel/locking/rwsem.c:1185
 __down_write_common kernel/locking/rwsem.c:1317 [inline]
 __down_write kernel/locking/rwsem.c:1326 [inline]
 down_write_nested+0x1b5/0x200 kernel/locking/rwsem.c:1707
 inode_lock_nested include/linux/fs.h:1072 [inline]
 lock_rename fs/namei.c:3681 [inline]
 __start_renaming+0x148/0x410 fs/namei.c:3777
 do_renameat2+0x399/0x8e0 fs/namei.c:5991
 __do_sys_rename fs/namei.c:6059 [inline]
 __se_sys_rename fs/namei.c:6057 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:6057
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7ba9b8f749
RSP: 002b:00007f7ba91dd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f7ba9de6090 RCX: 00007f7ba9b8f749
RDX: 0000000000000000 RSI: 0000200000000080 RDI: 0000200000000340
RBP: 00007f7ba9c13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7ba9de6128 R14: 00007f7ba9de6090 R15: 00007fff2ce8d188
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8df3d740 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8df3d740 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8df3d740 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by getty/5589:
 #0: ffff88814d56c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
3 locks held by syz.0.17/6021:
2 locks held by syz.0.17/6022:
 #0: ffff888030718420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
 #1: ffff8880631e3dd8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff8880631e3dd8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
 #1: ffff8880631e3dd8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
3 locks held by syz.1.18/6048:
2 locks held by syz.1.18/6049:
 #0: ffff888077cbe420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
 #1: ffff8880632db690 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff8880632db690 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
 #1: ffff8880632db690 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
3 locks held by syz.2.19/6082:
2 locks held by syz.2.19/6083:
 #0: ffff88807945e420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
 #1: ffff888073281970 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff888073281970 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
 #1: ffff888073281970 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
3 locks held by syz.3.20/6107:
2 locks held by syz.3.20/6108:
 #0: ffff88807b0a4420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
 #1: ffff8880631e1228 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff8880631e1228 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
 #1: ffff8880631e1228 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
3 locks held by syz.4.21/6138:
2 locks held by syz.4.21/6139:
 #0: ffff8880587fe420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
 #1: ffff8880632d8ae0 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff8880632d8ae0 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
 #1: ffff8880632d8ae0 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
3 locks held by syz.5.22/6176:
2 locks held by syz.5.22/6177:
 #0: ffff888026cec420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
 #1: ffff8880631ce240 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff8880631ce240 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
 #1: ffff8880631ce240 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
3 locks held by syz.6.23/6211:
2 locks held by syz.6.23/6212:
 #0: ffff888027d88420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
 #1: ffff8880631c9228 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff8880631c9228 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
 #1: ffff8880631c9228 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
3 locks held by syz.7.24/6244:
2 locks held by syz.7.24/6245:
 #0: ffff88807d516420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
 #1: ffff8880631bdaf8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff8880631bdaf8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
 #1: ffff8880631bdaf8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777

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
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
 watchdog+0xfb5/0x1000 kernel/hung_task.c:515
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6107 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:hlock_class kernel/locking/lockdep.c:234 [inline]
RIP: 0010:mark_lock+0x3c/0x190 kernel/locking/lockdep.c:4731
Code: 00 03 00 83 f9 01 bb 09 00 00 00 83 db 00 83 fa 08 0f 45 da bd 01 00 00 00 89 d9 d3 e5 25 ff 1f 00 00 48 0f a3 05 c4 46 df 11 <73> 10 48 69 c0 c8 00 00 00 48 8d 88 70 f3 1e 93 eb 48 83 3d 4b d6
RSP: 0018:ffffc90003747518 EFLAGS: 00000007
RAX: 0000000000000311 RBX: 0000000000000008 RCX: 0000000000000008
RDX: 0000000000000008 RSI: ffff8880275f48a8 RDI: ffff8880275f3d00
RBP: 0000000000000100 R08: 0000000000000000 R09: ffffffff8241cc56
R10: dffffc0000000000 R11: ffffed100e650518 R12: 0000000000000004
R13: 0000000000000003 R14: ffff8880275f48a8 R15: 0000000000000000
FS:  00007fc3607da6c0(0000) GS:ffff888125fbc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558e8c347168 CR3: 0000000077b26000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 mark_usage kernel/locking/lockdep.c:4674 [inline]
 __lock_acquire+0x6a8/0xd20 kernel/locking/lockdep.c:5191
 lock_acquire+0x117/0x350 kernel/locking/lockdep.c:5868
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 insert_inode_locked+0x336/0x5d0 fs/inode.c:1837
 ntfs_new_inode+0xc8/0x100 fs/ntfs3/fsntfs.c:1675
 ntfs_create_inode+0x606/0x32a0 fs/ntfs3/inode.c:1309
 ntfs_create+0x3d/0x50 fs/ntfs3/namei.c:110
 lookup_open fs/namei.c:4409 [inline]
 open_last_lookups fs/namei.c:4509 [inline]
 path_openat+0x190f/0x3d90 fs/namei.c:4753
 do_filp_open+0x1fa/0x410 fs/namei.c:4783
 do_sys_openat2+0x121/0x1c0 fs/open.c:1432
 do_sys_open fs/open.c:1447 [inline]
 __do_sys_openat fs/open.c:1463 [inline]
 __se_sys_openat fs/open.c:1458 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1458
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc35f98f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc3607da038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fc35fbe5fa0 RCX: 00007fc35f98f749
RDX: 000000000000275a RSI: 00002000000001c0 RDI: ffffffffffffff9c
RBP: 00007fc35fa13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc35fbe6038 R14: 00007fc35fbe5fa0 R15: 00007ffffeb34448
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

