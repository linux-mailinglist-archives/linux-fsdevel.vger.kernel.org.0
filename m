Return-Path: <linux-fsdevel+bounces-28903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ED497036E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 19:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A543B230CB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 17:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789A7165F16;
	Sat,  7 Sep 2024 17:53:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C541649BF
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Sep 2024 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725731605; cv=none; b=Ed/aM8Bm11IW0RsM3iR4odkH87PKKdmRGEhPGl6UkCnj2wWHDu1pJhLqoo/fj9g9gIkQr76CpYjTdqZQUUUnDpViDxwPR+irinnz9W6LAddGrthN4vPGxCuFlv9FWtcoyvY579TU7A2vjISDtGiK/N44QwfqeFW6Xm6tOMWMM/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725731605; c=relaxed/simple;
	bh=OxzHOd5ga6+EW1Cu+39R5r5SnFLpaW3qBO9c1lb/Mt0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dddyO6mSf+9cW1bxrmMQmtFsgwPuahmuxhuuyOUhoqXZ7lbffDalt8G0FJAIAgkaiGeWZSFyl5qmGEhs0cLP6wFCpMkk5EQoOIAGO/xCtWE7zfn4vVLOfY+mm/WRgTZq9M5mWGY6yqTFYCLLyVi4aNPCJzfBcqLiua8SSifGaYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82aa3527331so100291439f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Sep 2024 10:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725731602; x=1726336402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ogs60RJ79QB8EzRED1rwHgMM/Zl20ZBDV9MlHAh0gTI=;
        b=d9kYgAasmvq6NNFKvzoDHE0pWGv2ibUmCawqhRNFFFGeJVgHCirPBic+mbVAl1Gr2o
         8Dtxm/1XSk6S+LevHp+HDYFu2hZPfOkg9qlvhpFIZWeBhz2i+AO/wwfP01NDnIPTfl2k
         wfFyXEGeCy0o9gwR3FaAqu2bHCxt1shMFqBBsPRByaLChaHvNqH+V41WUgTchU2TrAG6
         nZ6/ar6JF+Q35Y37mwbi3W//cEElgqCxgkeFNLCTg+/HXhiBa8wuusHWvPLbFL+p4vb7
         ImyNcyVPXRJrwIcZfZrlw5V7NlMNpzq1UoImKT8JZ3en1VCAG1XKfEcyvL0mPFsZ9EoH
         ftpw==
X-Forwarded-Encrypted: i=1; AJvYcCXcJ2Pr24tDPvCSLyas0fn+0n1iAb9PUmKuuWlGu8mBFCv1qc6SXLQ6pvHRkwW+f29ni6WIvgCL/X5rm0Lw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5QSR01qgkyBPUO39faDeEMnJhBCYznmsoKjODv1DaeozeEiC2
	pD02L1UgSf5FOTi+sBcp5OAWNv5RtJDxz1LjEWL/VZGPlCNVIh67eXRj9oXN5VpoZT4eUSfAqUS
	PP/RgZI7H431L1gfZHAuYkBYnui/KV3dKwB0tS3i20LD3yVnXuW+0uJk=
X-Google-Smtp-Source: AGHT+IHeudbzRzLTaqbQCB8u7XJEFwpBrVCAnhdcXduguBpZO9dKxTF/1NEAae0K0FpkfjEKNwH+USOAEBcjH+zdcS9RnLuwQliy
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2710:b0:4b9:ad20:51ff with SMTP id
 8926c6da1cb9f-4d084ec9e1emr364470173.1.1725731602633; Sat, 07 Sep 2024
 10:53:22 -0700 (PDT)
Date: Sat, 07 Sep 2024 10:53:22 -0700
In-Reply-To: <00000000000087e83e061dd271bd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000272a2706218b333e@google.com>
Subject: Re: [syzbot] [kernfs?] INFO: task hung in eventpoll_release_file (2)
From: syzbot <syzbot+63ab1a905aebbf410bb7@syzkaller.appspotmail.com>
To: brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    b31c44928842 Merge tag 'linux_kselftest-kunit-fixes-6.11-r..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=157bba00580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58a85aa6925a8b78
dashboard link: https://syzkaller.appspot.com/bug?extid=63ab1a905aebbf410bb7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10662bc7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137bba00580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f716370b7d9/disk-b31c4492.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/45074cd156bc/vmlinux-b31c4492.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7c45c63d7fed/bzImage-b31c4492.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4ad4ee0b00a8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+63ab1a905aebbf410bb7@syzkaller.appspotmail.com

INFO: task syz-executor302:5246 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc6-syzkaller-00308-gb31c44928842 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor302 state:D stack:25880 pid:5246  tgid:5246  ppid:5235   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 eventpoll_release_file+0xcb/0x1c0 fs/eventpoll.c:1106
 eventpoll_release include/linux/eventpoll.h:53 [inline]
 __fput+0x6e0/0x8a0 fs/file_table.c:413
 __do_sys_close fs/open.c:1566 [inline]
 __se_sys_close fs/open.c:1551 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1551
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f597c12319a
RSP: 002b:00007ffd4a27f4d0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f597c12319a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
RBP: 00007f597c0e7300 R08: 0000000000000000 R09: 00007f597c17720f
R10: 0000000000000000 R11: 0000000000000293 R12: 00000000000155fa
R13: 000000000001562c R14: 00007ffd4a27f5b0 R15: 00007ffd4a27f540
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6626
1 lock held by syslogd/4664:
2 locks held by getty/4988:
 #0: ffff88803078b0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000312b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ac/0x1e00 drivers/tty/n_tty.c:2211
1 lock held by syz-executor302/5246:
 #0: ffff8880328a7868 (&ep->mtx){+.+.}-{3:3}, at: eventpoll_release_file+0xcb/0x1c0 fs/eventpoll.c:1106
3 locks held by syz-executor302/5247:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc6-syzkaller-00308-gb31c44928842 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5247 Comm: syz-executor302 Not tainted 6.11.0-rc6-syzkaller-00308-gb31c44928842 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:get_current arch/x86/include/asm/current.h:49 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x8/0x70 kernel/kcov.c:215
Code: 8b 3d 6c 76 96 0c 48 89 de 5b e9 b3 99 5b 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 04 24 <65> 48 8b 0c 25 00 d7 03 00 65 8b 15 40 4a 70 7e 81 e2 00 01 ff 00
RSP: 0018:ffffc90004d876b8 EFLAGS: 00000202
RAX: ffffffff81e12736 RBX: 0000000000000001 RCX: ffff88802f810000
RDX: ffff88802f810000 RSI: ffffffff8c608e60 RDI: ffffffff8c608e20
RBP: ffffc90004d87790 R08: ffffffff81e12724 R09: 1ffffffff283c90e
R10: dffffc0000000000 R11: fffffbfff283c90f R12: 0000000000000046
R13: ffffffff81e12474 R14: dffffc0000000000 R15: 1ffff920009b0edc
FS:  00007f597c0d36c0(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020008040 CR3: 000000007c01c000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 rcu_read_unlock include/linux/rcupdate.h:867 [inline]
 count_memcg_event_mm+0x356/0x420 include/linux/memcontrol.h:1021
 mm_account_fault mm/memory.c:5698 [inline]
 handle_mm_fault+0x16f7/0x1bc0 mm/memory.c:5858
 do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x2b9/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:__put_user_nocheck_4+0x7/0x20 arch/x86/lib/putuser.S:97
Code: d9 0f 01 cb 89 01 31 c9 0f 01 ca e9 ae a7 39 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 01 cb <89> 01 31 c9 0f 01 ca e9 88 a7 39 00 66 2e 0f 1f 84 00 00 00 00 00
RSP: 0018:ffffc90004d87b38 EFLAGS: 00050246
RAX: 0000000000000008 RBX: ffff8880279cf06c RCX: 0000000020008040
RDX: ffff88802f810000 RSI: 0000000000000008 RDI: 0000000000000000
RBP: ffffc90004d87db8 R08: ffffffff82232656 R09: 1ffff110049ee77b
R10: dffffc0000000000 R11: ffffed10049ee77c R12: 0000000020008040
R13: 0000000000000000 R14: 0000000000000008 R15: 1ffff11004f39e0d
 epoll_put_uevent include/linux/eventpoll.h:81 [inline]
 ep_send_events fs/eventpoll.c:1876 [inline]
 ep_poll fs/eventpoll.c:2005 [inline]
 do_epoll_wait+0xe3a/0x2040 fs/eventpoll.c:2464
 do_epoll_pwait+0x56/0x1e0 fs/eventpoll.c:2498
 __do_sys_epoll_pwait fs/eventpoll.c:2511 [inline]
 __se_sys_epoll_pwait fs/eventpoll.c:2505 [inline]
 __x64_sys_epoll_pwait+0x2b8/0x310 fs/eventpoll.c:2505
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f597c124049
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1b 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f597c0d3208 EFLAGS: 00000246 ORIG_RAX: 0000000000000119
RAX: ffffffffffffffda RBX: 00007f597c1b34e8 RCX: 00007f597c124049
RDX: 0000000000000001 RSI: 0000000020008040 RDI: 0000000000000008
RBP: 00007f597c1b34e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000401 R11: 0000000000000246 R12: 00007f597c179414
R13: 00007f597c177052 R14: 0000000000000000 R15: 7061632f7665642f
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

