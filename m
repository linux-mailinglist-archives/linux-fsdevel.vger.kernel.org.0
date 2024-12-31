Return-Path: <linux-fsdevel+bounces-38303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FE59FF0D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 18:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D531623B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 17:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8BE1ADFE4;
	Tue, 31 Dec 2024 17:07:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2801ACEB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735664849; cv=none; b=U+whdtd6n4ShV84ooTM/inTeiq0QhaaLIWF9re0g6YgW4YQkwEPzax0fIZNQcffuLKrnHGMjkZ3bKCRM+QCPx4RidjsZVXIw8XVQCPyhSoIrK8YPBxrJbH4pAv4yeuJ94ThA+8iEIqrXxc8bf029Ei1v/nG1KubuK3Gd4MAfB1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735664849; c=relaxed/simple;
	bh=X/EDcUmOe6Zran6wP/HMyj2qMZsoHQcf19GlxPC97/w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N359CO3Fq+x9S9hlRdSxOUI59XAOkel6w69yWqMcIAjlKa7AsohxeKBrhY+D2IqiUJYFF54cCYuqRJKfdlJwQtAkfCpsrKzben8y45LojFGyMWVQE+6KL0ZL5ETuJpGtWvgdtdfAL1zVk8Z9OZ1XTdIriX6dcAMgr8ROb9/RGU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a9d303a5ccso203932705ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 09:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735664846; x=1736269646;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6B0r5eUqiXilb2ZNkg8w1t0mTXd91vDy3QUpcH2VTk=;
        b=iQpAeyhvkKcBy2SWVQOpjgCqUaLy2sQA+rVmywe4cbRdBJvWHRCCElaivK67eIvL/8
         Bp3VDtTNZnS64vNQT3QXhLQ9Cqx89sr9lbLRGUBcJr0jkTU6pCgE+GZiPlczCbPsVzb7
         B4P5UEm0CjlRC5LFwUnQNShQzEamBp2LusjUi/b1LCp7KOGsjSclFZNwP75VsAnBtLhp
         8l/Yb2RrOpyDYALsmdC/bAoIOFzfj/MaoOqLcyFD+tzMnRgX58un9r2nLMcGnHTLL57D
         YBsh+9t5m3jzHTSJXAkJANuTXFgNG0GvROCtjNeFQCrijLy/jmgoFOBDWhBwTiL6gUP2
         GKmg==
X-Forwarded-Encrypted: i=1; AJvYcCV/5fkqalF/JQvGymXLWrG59aCDEkci/G1cLg9L/LgUSQMLBywkDDeuO3v/WIQsvigtomK3AUitDXJIwTRy@vger.kernel.org
X-Gm-Message-State: AOJu0YyjVFxRaAn0Qltv0FJ7+OodRFoqo1qCN4MuOOdmo48yIMRX7nBK
	I+AR5l71chhYcVrroVDReXlPN0GZxe6vq9ckITVvqSmrcN5CvZ7hwaQ1mSM4cyw9Imw81vixNFS
	Ss11KGwgpCt9U9KpCy+N5oBSrSlCTNibeR/fYC3MiKzoKedDd5G9fpwI=
X-Google-Smtp-Source: AGHT+IF8NiHBxVis5QvcWWZZubfq17qvxn4lJW2IDYiaB0BYr2FWNErZR8IGgIAOS02m4aaepigYpPrUTPTjzLEuK0CoAc2tXDyD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aad:b0:3a7:e452:db4 with SMTP id
 e9e14a558f8ab-3c2d524751cmr302406875ab.16.1735664846732; Tue, 31 Dec 2024
 09:07:26 -0800 (PST)
Date: Tue, 31 Dec 2024 09:07:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677424ce.050a0220.25abdd.091e.GAE@google.com>
Subject: [syzbot] [kernfs?] [exfat?] INFO: task hung in chmod_common (5)
From: syzbot <syzbot+4426dfa686191fab8b50@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8155b4ef3466 Add linux-next specific files for 20241220
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=178492c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c90bb7161a56c88
dashboard link: https://syzkaller.appspot.com/bug?extid=4426dfa686191fab8b50
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156010b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1292d018580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/98a974fc662d/disk-8155b4ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2dea9b72f624/vmlinux-8155b4ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/593a42b9eb34/bzImage-8155b4ef.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c3f39387ee98/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4426dfa686191fab8b50@syzkaller.appspotmail.com

INFO: task syz-executor927:5851 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor927 state:D stack:28848 pid:5851  tgid:5836  ppid:5831   flags:0x00004006
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
 chmod_common+0x1bb/0x4c0 fs/open.c:638
 do_fchmodat fs/open.c:690 [inline]
 __do_sys_fchmodat fs/open.c:709 [inline]
 __se_sys_fchmodat fs/open.c:706 [inline]
 __x64_sys_fchmodat+0x11d/0x1c0 fs/open.c:706
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdd8bcafec9
RSP: 002b:00007fdd8bc45218 EFLAGS: 00000246 ORIG_RAX: 000000000000010c
RAX: ffffffffffffffda RBX: 00007fdd8bd416b8 RCX: 00007fdd8bcafec9
RDX: 00000000ffffff19 RSI: 0000000020000000 RDI: 00000000ffffff9c
RBP: 00007fdd8bd416b0 R08: 00007ffe7565dd17 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdd8bd416bc
R13: 0030656c69662f2e R14: 00007fdd8bd04160 R15: 00000000ffffff19
 </TASK>
INFO: task syz-executor927:5850 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor927 state:D stack:27928 pid:5850  tgid:5837  ppid:5832   flags:0x00004006
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
 chmod_common+0x1bb/0x4c0 fs/open.c:638
 do_fchmodat fs/open.c:690 [inline]
 __do_sys_fchmodat fs/open.c:709 [inline]
 __se_sys_fchmodat fs/open.c:706 [inline]
 __x64_sys_fchmodat+0x11d/0x1c0 fs/open.c:706
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdd8bcafec9
RSP: 002b:00007fdd8bc45218 EFLAGS: 00000246 ORIG_RAX: 000000000000010c
RAX: ffffffffffffffda RBX: 00007fdd8bd416b8 RCX: 00007fdd8bcafec9
RDX: 00000000ffffff19 RSI: 0000000020000000 RDI: 00000000ffffff9c
RBP: 00007fdd8bd416b0 R08: 00007ffe7565dd17 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdd8bd416bc
R13: 0030656c69662f2e R14: 00007fdd8bd04160 R15: 00000000ffffff19
 </TASK>
INFO: task syz-executor927:5849 blocked for more than 144 seconds.
      Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor927 state:D stack:28216 pid:5849  tgid:5839  ppid:5834   flags:0x00004006
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
 chmod_common+0x1bb/0x4c0 fs/open.c:638
 do_fchmodat fs/open.c:690 [inline]
 __do_sys_fchmodat fs/open.c:709 [inline]
 __se_sys_fchmodat fs/open.c:706 [inline]
 __x64_sys_fchmodat+0x11d/0x1c0 fs/open.c:706
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdd8bcafec9
RSP: 002b:00007fdd8bc45218 EFLAGS: 00000246 ORIG_RAX: 000000000000010c
RAX: ffffffffffffffda RBX: 00007fdd8bd416b8 RCX: 00007fdd8bcafec9
RDX: 00000000ffffff19 RSI: 0000000020000000 RDI: 00000000ffffff9c
RBP: 00007fdd8bd416b0 R08: 00007ffe7565dd17 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdd8bd416bc
R13: 0030656c69662f2e R14: 00007fdd8bd04160 R15: 00000000ffffff19
 </TASK>
INFO: task syz-executor927:5848 blocked for more than 145 seconds.
      Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor927 state:D stack:28848 pid:5848  tgid:5840  ppid:5833   flags:0x00004006
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
 chmod_common+0x1bb/0x4c0 fs/open.c:638
 do_fchmodat fs/open.c:690 [inline]
 __do_sys_fchmodat fs/open.c:709 [inline]
 __se_sys_fchmodat fs/open.c:706 [inline]
 __x64_sys_fchmodat+0x11d/0x1c0 fs/open.c:706
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdd8bcafec9
RSP: 002b:00007fdd8bc45218 EFLAGS: 00000246 ORIG_RAX: 000000000000010c
RAX: ffffffffffffffda RBX: 00007fdd8bd416b8 RCX: 00007fdd8bcafec9
RDX: 00000000ffffff19 RSI: 0000000020000000 RDI: 00000000ffffff9c
RBP: 00007fdd8bd416b0 R08: 00007ffe7565dd17 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdd8bd416bc
R13: 0030656c69662f2e R14: 00007fdd8bd04160 R15: 00000000ffffff19
 </TASK>
INFO: task syz-executor927:5852 blocked for more than 146 seconds.
      Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor927 state:D stack:28848 pid:5852  tgid:5841  ppid:5835   flags:0x00004006
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
 chmod_common+0x1bb/0x4c0 fs/open.c:638
 do_fchmodat fs/open.c:690 [inline]
 __do_sys_fchmodat fs/open.c:709 [inline]
 __se_sys_fchmodat fs/open.c:706 [inline]
 __x64_sys_fchmodat+0x11d/0x1c0 fs/open.c:706
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdd8bcafec9
RSP: 002b:00007fdd8bc45218 EFLAGS: 00000246 ORIG_RAX: 000000000000010c
RAX: ffffffffffffffda RBX: 00007fdd8bd416b8 RCX: 00007fdd8bcafec9
RDX: 00000000ffffff19 RSI: 0000000020000000 RDI: 00000000ffffff9c
RBP: 00007fdd8bd416b0 R08: 00007ffe7565dd17 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdd8bd416bc
R13: 0030656c69662f2e R14: 00007fdd8bd04160 R15: 00000000ffffff19
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6744
1 lock held by kswapd0/88:
2 locks held by getty/5588:
 #0: ffff8880352820a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by syz-executor927/5843:
2 locks held by syz-executor927/5851:
 #0: ffff88802079a420 (sb_writers#10){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:548
 #1: ffff8880735fc6c0 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: inode_lock include/linux/fs.h:863 [inline]
 #1: ffff8880735fc6c0 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: chmod_common+0x1bb/0x4c0 fs/open.c:638
1 lock held by syz-executor927/5842:
2 locks held by syz-executor927/5850:
 #0: ffff8880309c8420 (sb_writers#10){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:548
 #1: ffff8880735fc180 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: inode_lock include/linux/fs.h:863 [inline]
 #1: ffff8880735fc180 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: chmod_common+0x1bb/0x4c0 fs/open.c:638
2 locks held by syz-executor927/5844:
2 locks held by syz-executor927/5849:
 #0: ffff88807d020420 (sb_writers#10){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:548
 #1: ffff888073590180 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: inode_lock include/linux/fs.h:863 [inline]
 #1: ffff888073590180 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: chmod_common+0x1bb/0x4c0 fs/open.c:638
2 locks held by syz-executor927/5845:
2 locks held by syz-executor927/5848:
 #0: ffff8880335de420 (sb_writers#10){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:548
 #1: ffff8880735906c0 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: inode_lock include/linux/fs.h:863 [inline]
 #1: ffff8880735906c0 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: chmod_common+0x1bb/0x4c0 fs/open.c:638
1 lock held by syz-executor927/5847:
2 locks held by syz-executor927/5852:
 #0: ffff888031550420 (sb_writers#10){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:548
 #1: ffff888073590c00 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: inode_lock include/linux/fs.h:863 [inline]
 #1: ffff888073590c00 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: chmod_common+0x1bb/0x4c0 fs/open.c:638
2 locks held by dhcpcd/5874:
 #0: ffff888030e65608 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:863 [inline]
 #0: ffff888030e65608 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: __sock_release net/socket.c:639 [inline]
 #0: ffff888030e65608 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: sock_close+0x90/0x240 net/socket.c:1419
 #1: ffffffff8e93d278 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:302 [inline]
 #1: ffffffff8e93d278 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:996
2 locks held by dhcpcd/5875:
 #0: ffff8880257ec258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1618 [inline]
 #0: ffff8880257ec258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcb0 net/packet/af_packet.c:3267
 #1: ffffffff8e93d278 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:334 [inline]
 #1: ffffffff8e93d278 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:996

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5844 Comm: syz-executor927 Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:87 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x86/0x290 mm/kasan/generic.c:189
Code: 00 fc ff df 4f 8d 3c 31 4c 89 fd 4c 29 dd 48 83 fd 10 7f 29 48 85 ed 0f 84 3e 01 00 00 4c 89 cd 48 f7 d5 48 01 dd 41 80 3b 00 <0f> 85 c9 01 00 00 49 ff c3 48 ff c5 75 ee e9 1e 01 00 00 45 89 dc
RSP: 0018:ffffc90003fcf570 EFLAGS: 00000246
RAX: 0000000000000001 RBX: 1ffffffff203563e RCX: ffffffff819ab2c0
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff901ab1f0
RBP: ffffffffffffffff R08: ffffffff901ab1f7 R09: 1ffffffff203563e
R10: dffffc0000000000 R11: fffffbfff203563e R12: 1ffff920007f9ec0
R13: ffffffff822d42f8 R14: dffffc0000000001 R15: fffffbfff203563f
FS:  00007fdd8bc666c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b44c034600 CR3: 000000007948e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 cpumask_test_cpu include/linux/cpumask.h:570 [inline]
 cpu_online include/linux/cpumask.h:1117 [inline]
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0xb0/0xa30 kernel/locking/lockdep.c:5860
 rcu_lock_release include/linux/rcupdate.h:347 [inline]
 rcu_read_unlock include/linux/rcupdate.h:880 [inline]
 get_mem_cgroup_from_mm+0x1ad/0x2a0 mm/memcontrol.c:949
 __mem_cgroup_charge+0x16/0x80 mm/memcontrol.c:4498
 mem_cgroup_charge include/linux/memcontrol.h:644 [inline]
 filemap_add_folio+0xb7/0x380 mm/filemap.c:967
 do_read_cache_folio+0x349/0x5b0 mm/filemap.c:3860
 read_mapping_folio include/linux/pagemap.h:1032 [inline]
 dir_get_folio fs/sysv/dir.c:64 [inline]
 sysv_find_entry+0x16c/0x590 fs/sysv/dir.c:154
 sysv_inode_by_name+0x98/0x2a0 fs/sysv/dir.c:370
 sysv_lookup+0x6b/0xe0 fs/sysv/namei.c:38
 __lookup_slow+0x28c/0x3f0 fs/namei.c:1791
 lookup_slow+0x53/0x70 fs/namei.c:1808
 walk_component+0x2e1/0x410 fs/namei.c:2112
 lookup_last fs/namei.c:2610 [inline]
 path_lookupat+0x16f/0x450 fs/namei.c:2634
 filename_lookup+0x2a3/0x670 fs/namei.c:2663
 user_path_at+0x3a/0x60 fs/namei.c:3070
 __do_sys_chdir fs/open.c:557 [inline]
 __se_sys_chdir+0xbc/0x220 fs/open.c:551
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdd8bcafec9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdd8bc66218 EFLAGS: 00000246 ORIG_RAX: 0000000000000050
RAX: ffffffffffffffda RBX: 00007fdd8bd416a8 RCX: 00007fdd8bcafec9
RDX: ffffffffffffffb0 RSI: 0000000000000000 RDI: 0000000020000140
RBP: 00007fdd8bd416a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdd8bd416ac
R13: 0030656c69662f2e R14: 00007fdd8bd04160 R15: 00000000ffffff19
 </TASK>


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

