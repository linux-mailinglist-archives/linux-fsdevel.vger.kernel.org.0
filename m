Return-Path: <linux-fsdevel+bounces-20776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C929D8D7AAE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 06:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DA81C2118B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 04:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA6918E02;
	Mon,  3 Jun 2024 04:14:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2820DF7
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 04:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717388045; cv=none; b=EK1CTGLdYMTcQLp8SJAQgKZAtXO+gW4EDtUNOQRuAschPFT5DjLlp49cvjvM9/mGbMUX5PcdODWS+as5txP55xCB/lWXMHUV+HCn0fxWrmAk2AM2B0ByasDgJPXDnrsgQmISiYflnpMGJX8qSejtY0zlDpbfhQSmpFq+W8mfp4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717388045; c=relaxed/simple;
	bh=62Fqw3teqZsqZ3tz9YHfQsSuskkRT9Ew8ULLLpLnVkM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UHQJ/deNio3aq6s0Rbw4igldehalUOwXljLZrancxMjI2MaHND5iYHuizsSJs65AZrVWh46tXMJVNUbTivsWx9P1nORMtQM8ir7HLwnJ14yfFhag2NP/2PhGH7FVTgvJl9zT6DIXVjh8MRWbI09gvnJDmbxzrf3eD7igh4jIdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1ea8608afso516794039f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jun 2024 21:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717388043; x=1717992843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7VbCSxJbjIm1KcKRV1usbXf1dPKsCFGg/OuEn3tbtM=;
        b=LGtBf2+67FOxKDcFWt+b1Rm4VJsa+qgUSUmnWNtYgAlkQghK2bu4rY7et2XCgw6fky
         TJaykaGm78Rdw1QnUxbT84xuASDnUEmE6S02Apek8SNt7WrgYIUWrbnJ3z5xe+tKB8eD
         +oAl3kXFp2yWRBd83+hjqEjX37Ts+ifQ3LRmOqQiEkpDYJ9EMedTAkl195ARJgEjV4N5
         GGYVvzBTwj8NMrdyPaBLLUbCaxI1+x4MgWPu5u7f01+PbijAgJuOlF0qCpHSzpcusVsA
         Kec8LV5KRTikhtAmsERmoYRDJ4UiM2WsmPi+mUQHna0/FcK4wzuF16bO3wPxF24skLND
         QXnA==
X-Forwarded-Encrypted: i=1; AJvYcCW2Pc00AvDOd686vrgZFeBX60PDxb5SVvN2XnkUPC96IRgOYvnQEFSE6Rgv2w3NWxjFQj+Xk/ujf51q1DLNnVPxskhk1mmB8VuREbozgQ==
X-Gm-Message-State: AOJu0YwmFs5+2K/ZCz6C32Qh5hkkXqO1lzZXi23XGdHNQVSYcJd35o/z
	GXDpvXwIP7hxVwUQotaDpYZSTQp0fIGjem9RnROflwfzx7/f3nGxBepCKKY1BnBjSdGS4mgixNX
	VQNSyDNu9W7UfJUoINtMEZCo7m7d6BSFPK4OYGNfGtIZ5MVYxbW6nyNs=
X-Google-Smtp-Source: AGHT+IH0BlU4TM9qzpRgm44ZdBC3d3+9xIkNeXbovvlf+xnGtYGhgvGpWPtlEHDBmBxSs5joPcDjmJ8tCfT8ydwCB+CX0GXcFuwo
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3406:b0:7e2:b00:2277 with SMTP id
 ca18e2360f4ac-7eafff33df6mr49071739f.2.1717388043233; Sun, 02 Jun 2024
 21:14:03 -0700 (PDT)
Date: Sun, 02 Jun 2024 21:14:03 -0700
In-Reply-To: <20240603035649.GK1629371@ZenIV>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000423bba0619f49015@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in vfs_rmdir (2)
From: syzbot <syzbot+42986aeeddfd7ed93c8b@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in vfs_rmdir

INFO: task syz-executor:5934 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22736 pid:5934  tgid:5932  ppid:5638   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1796/0x4a00 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6838
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6895
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 inode_lock include/linux/fs.h:795 [inline]
 vfs_rmdir+0x101/0x4c0 fs/namei.c:4195
 do_rmdir+0x3b5/0x580 fs/namei.c:4265
 __do_sys_rmdir fs/namei.c:4284 [inline]
 __se_sys_rmdir fs/namei.c:4282 [inline]
 __x64_sys_rmdir+0x49/0x60 fs/namei.c:4282
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efe6f27cee9
RSP: 002b:00007efe7003c0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 00007efe6f3b3fa0 RCX: 00007efe6f27cee9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 00007efe6f2c947f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007efe6f3b3fa0 R15: 00007ffcf06a10f8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8e334da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e334da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e334da0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by getty/4827:
 #0: ffff88802abe60a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
3 locks held by syz-executor/5934:
 #0: ffff888020866420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff88807f131650 (&sb->s_type->i_mutex_key#20/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:830 [inline]
 #1: ffff88807f131650 (&sb->s_type->i_mutex_key#20/1){+.+.}-{3:3}, at: do_rmdir+0x263/0x580 fs/namei.c:4253
 #2: ffff88807f131650 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:795 [inline]
 #2: ffff88807f131650 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_rmdir+0x101/0x4c0 fs/namei.c:4195
4 locks held by syz-executor/5946:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.9.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:380
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 14944 Comm: syz-executor Not tainted 6.9.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:ext4_ext_map_blocks+0x7c7/0x77b0 fs/ext4/extents.c:4236
Code: 89 ee e8 1c 4d 46 ff 4d 89 fc 45 29 ef 0f 86 c8 02 00 00 e8 4b 4b 46 ff 45 89 ec 4c 8b 74 24 20 e9 07 21 00 00 48 8b 44 24 70 <42> 0f b6 04 38 84 c0 0f 85 2f 4c 00 00 48 8b 44 24 18 44 8b 30 48
RSP: 0018:ffffc90003ef74c0 EFLAGS: 00000202
RAX: 1ffff920007def39 RBX: 0000000000000001 RCX: ffff88801166da00
RDX: ffff88801166da00 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90003ef77d0 R08: ffffffff824fbb51 R09: 0000000000000000
R10: ffff888028cbf110 R11: ffffed1005197e24 R12: 1ffff920007deee2
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007ff4d35a56c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000026118000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 ext4_map_blocks+0xa5e/0x1d20 fs/ext4/inode.c:623
 ext4_getblk+0x1fa/0x850 fs/ext4/inode.c:833
 ext4_bread+0x2e/0x180 fs/ext4/inode.c:889
 ext4_append+0x327/0x5c0 fs/ext4/namei.c:83
 ext4_init_new_dir+0x33e/0xa30 fs/ext4/namei.c:2977
 ext4_mkdir+0x4f7/0xcf0 fs/ext4/namei.c:3023
 vfs_mkdir+0x2f9/0x4b0 fs/namei.c:4123
 do_mkdirat+0x264/0x3a0 fs/namei.c:4146
 __do_sys_mkdirat fs/namei.c:4161 [inline]
 __se_sys_mkdirat fs/namei.c:4159 [inline]
 __x64_sys_mkdirat+0x89/0xa0 fs/namei.c:4159
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff4d287b9e7
Code: 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 02 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff4d35a4ef8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007ff4d35a4f80 RCX: 00007ff4d287b9e7
RDX: 00000000000001ff RSI: 0000000020000180 RDI: 00000000ffffff9c
RBP: 0000000020000100 R08: 00000000200001c0 R09: 0000000000000000
R10: 0000000020000100 R11: 0000000000000246 R12: 0000000020000180
R13: 00007ff4d35a4f40 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


Tested on:

commit:         a38297e3 Linux 6.9
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6 v6.9
console output: https://syzkaller.appspot.com/x/log.txt?x=117bca16980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df13071aee1d0001
dashboard link: https://syzkaller.appspot.com/bug?extid=42986aeeddfd7ed93c8b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

