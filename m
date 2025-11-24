Return-Path: <linux-fsdevel+bounces-69630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B55C8C7F299
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 08:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1CA3A4AF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 07:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FC02E1F0E;
	Mon, 24 Nov 2025 07:13:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B3C2E0B6E
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763968387; cv=none; b=Dncpe29hcLROx39Gkb1iA1Y/dsWl4pdTrZFN2YDdg0YcyIzZvKvDDGs5kWpPmzXfINij5O7D6o/GrIe4wyKpj4MRzWMqBQoNfu5KtdGFrC+6D4kgUIifDTFSj/pQpryHbemYfTVMjJtc8qJyTCw3BC3UsVJ/1PwlSqo5E+RHUlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763968387; c=relaxed/simple;
	bh=HInhl1KO+J0EXrgShI3LVH+RBcQtz85AHxWsOLncCvM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LSyWJ9DCkZsoy2WmCThGOaG/ThgMomQE4o1YwQ1mtPvWumRovsEOtv5MZzQzVPQzzuzINXUkON6HJ3Zryobc9IeyavaBLFeOhIpkD/uToEH8dkGNYNW3BG8tCX0zOYg5UDyOFmks6+s+EqsaMSHWtI6louVnnX9d75dlKC474TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9495ffe8241so100367239f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 23:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763968384; x=1764573184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KF2Ak0sQUgMNK1rKnWGzsfhSUBSdzgZI3IHey+cKkB4=;
        b=YTe4eZecmGbclRFL5eG23j2wcS45pqz9RndYaRSWOBEyRSSRFDI6PMe8N3XZ5pk4OJ
         DATmIFzyo81DELO7pYtB3RDzCVDhJD+5FKFmCkAhjWjZ/bjdOrWgpHmBi6n01YHJDc2n
         B2wSjtzFkdxfy7CV3SCARQYA+3eb89JuXjAG3BnhaAkVs9PTjXx5EttFW5O/N/RzjzIM
         K+q3DV+tADtMPytaWML5Wd/4Vjfg8KwmVwc2P0a0Tz+tsx6lDzfHe8eVF4hArX0TRzGk
         CGhn3vVye1mxkveX0rKcbHdrQvQs8lqgGpVHa0y1QuWZasz4gSQ70EktGC4A9dc1JeNe
         oeSg==
X-Forwarded-Encrypted: i=1; AJvYcCUJG/5bPGRkKccy1o/SnwQcHT6YH+y4JufoFuWmg/s79LrQHaAjMNU7G+vJNQMxJLn4zIjvq7Kgk9pWefOD@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ/a8bXhPi8NDewx6Yz8KP5PXUCyRnahntmRonclcFouhVsvKu
	rsH9gCPHKLFosSJlxv8OJfh+FCusfWbTxmAjhQ7RIAC92R0QgI9JdfvTs+RHjOSX40IsNNNnKjh
	ofYVnulyHq23QHoXXXpfv1Je/7kIW+z5GBip6eEXawLGbq9OcGj55UubJSPQ=
X-Google-Smtp-Source: AGHT+IEWlScereATm2wIbqGUY+hJ/KpTZaNQGX0sn++dl2V4QBfGitYt//QVfB7u/Qi0SKJtuUOPVwlsX3ESLkWm4hlvWFU2j7xK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152e:b0:430:c0e4:9e43 with SMTP id
 e9e14a558f8ab-435b8bf8b4fmr80722175ab.6.1763968383781; Sun, 23 Nov 2025
 23:13:03 -0800 (PST)
Date: Sun, 23 Nov 2025 23:13:03 -0800
In-Reply-To: <gyt53gbtarw75afmeswazv4dmmj6mc2lzlm2bycunphazisbyq@qrjumrerwox5>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6924057f.a70a0220.d98e3.007b.GAE@google.com>
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
INFO: task hung in __start_renaming

INFO: task syz.0.17:6473 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:27936 pid:6473  tgid:6471  ppid:6352   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5257 [inline]
 __schedule+0x14bc/0x5030 kernel/sched/core.c:6864
 __schedule_loop kernel/sched/core.c:6946 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6961
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7018
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
RIP: 0033:0x7f2425d8f749
RSP: 002b:00007f2426c44038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f2425fe6090 RCX: 00007f2425d8f749
RDX: 0000000000000000 RSI: 0000200000000080 RDI: 0000200000000340
RBP: 00007f2425e13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2425fe6128 R14: 00007f2425fe6090 R15: 00007ffcd5a91138
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8df3d980 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8df3d980 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8df3d980 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by getty/5592:
 #0: ffff8880342450a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
3 locks held by syz.0.17/6472:
2 locks held by syz.0.17/6473:
 #0: ffff88805c19c420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
 #1: ffff88805e78e988 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff88805e78e988 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
 #1: ffff88805e78e988 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
3 locks held by syz.1.18/6495:
2 locks held by syz.1.18/6496:
 #0: ffff88807bbb8420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
 #1: ffff888073ef5af8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff888073ef5af8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
 #1: ffff888073ef5af8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
5 locks held by syz.2.19/6519:
2 locks held by syz.2.19/6520:
 #0: ffff888031634420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
 #1: ffff888073e770d0 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff888073e770d0 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
 #1: ffff888073e770d0 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
3 locks held by syz.3.20/6552:
2 locks held by syz.3.20/6553:
 #0: ffff8880241de420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
 #1: ffff888073ee5af8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff888073ee5af8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
 #1: ffff888073ee5af8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
3 locks held by syz.4.21/6582:
2 locks held by syz.4.21/6583:
 #0: ffff88805dafe420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
 #1: ffff88805e78b690 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff88805e78b690 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
 #1: ffff88805e78b690 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
3 locks held by syz.5.22/6613:
2 locks held by syz.5.22/6614:
 #0: ffff88806d820420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
 #1: ffff88805e7dcc68 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff88805e7dcc68 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
 #1: ffff88805e7dcc68 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
3 locks held by syz.6.23/6654:
2 locks held by syz.6.23/6655:
 #0: ffff888032cd2420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
 #1: ffff88805e78f818 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff88805e78f818 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
 #1: ffff88805e78f818 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
3 locks held by syz.7.24/6689:
2 locks held by syz.7.24/6690:
 #0: ffff88807eda2420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
 #1: ffff888073e73dd8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff888073e73dd8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
 #1: ffff888073e73dd8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777

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
CPU: 1 UID: 0 PID: 6582 Comm: syz.4.21 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:27 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:183 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:246 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x11/0x90 kernel/kcov.c:314
Code: 09 cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 04 24 65 48 8b 14 25 08 60 76 92 <65> 8b 0d 68 82 b4 10 81 e1 00 01 ff 00 74 11 81 f9 00 01 00 00 75
RSP: 0018:ffffc900040bf660 EFLAGS: 00000246
RAX: ffffffff82417239 RBX: ffff888073e75268 RCX: df51652e15ac6b00
RDX: ffff888024430000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000817ec0 R12: ffff888073e75268
R13: ffff888073e752e8 R14: dffffc0000000000 R15: 0000000000000003
FS:  00007f2cd1b696c0(0000) GS:ffff888125fba000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b091e56a38 CR3: 000000003082e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 inode_state_read+0x59/0xd0 include/linux/fs.h:888
 insert_inode_locked+0x2c8/0x650 fs/inode.c:1873
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
RIP: 0033:0x7f2cd0d8f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2cd1b69038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f2cd0fe5fa0 RCX: 00007f2cd0d8f749
RDX: 000000000000275a RSI: 00002000000001c0 RDI: ffffffffffffff9c
RBP: 00007f2cd0e13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2cd0fe6038 R14: 00007f2cd0fe5fa0 R15: 00007ffce05c0bc8
 </TASK>


Tested on:

commit:         d724c6f8 Add linux-next specific files for 20251121
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17ce797c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68d11c703cf8e4a0
dashboard link: https://syzkaller.appspot.com/bug?extid=2fefb910d2c20c0698d8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10fdf658580000


