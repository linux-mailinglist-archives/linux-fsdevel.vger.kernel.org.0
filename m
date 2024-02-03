Return-Path: <linux-fsdevel+bounces-10186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9116584872A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 16:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A132A1C2217C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 15:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC7D5F569;
	Sat,  3 Feb 2024 15:38:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9615F559
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Feb 2024 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706974717; cv=none; b=MHdiOZogw7VQtkRt6CamLriDW6kr2WzOkKFpSWbIwGtBXdZtMuSI0Thn4MxR4Tdrdp+0A4ZH7LhawxhgEgxHteImQLf82NES8Kte0DcnF9uGmsjIwQMksi/QjE03+cwkN2QRr6+5hB6Or/qVvfA5DJ2gusRK0SVFw3R1s5SLYxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706974717; c=relaxed/simple;
	bh=gxUmWy3RfhCGVuRi+uI/CKS3DwxEK2s4OvC5EeXDCj8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Fej+eKXnCSYqsbP8KkQLB7/sk6gCNeICRx4Abny8rp+rPOnjVqko9cRZ5ikEyJcX7RnrAgy31akkpA2x/32EI72MD0Na/XDy1iQnRIquHJKQDj8wGMLm62K9ZOGGmtjprITYNgmCm1mCnxOS/K2eZKxhKcB44nl47VktaWFKMK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c02ed38aa5so202265739f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Feb 2024 07:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706974714; x=1707579514;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hcLIrlEq0V1aL1+D+Tbm4+g+5l0YewgsapoPn67CZn8=;
        b=PlPaUIm4CUVvH0s94WwqF9YIjpbIaHSRzIbhpc6ODt7qh3d2gs7FKgkdpwVDfgUIJR
         A4jEVp5sQvoXm+0tkagZuWVp0NBkhyyKhkkHEA6el0G6yMwN/p/WhsowuQeFVmPKxFJX
         OuXU6FqGUUwnmo89z+24XW5DqSQEM/ieMMD6VXrefCygRNtwwLnQohhbzUGpAjn3azIJ
         2xJgX3bTRQkT2vW/ql75Ab5jR8aqtVkkl983bbiGn4/5RmbgorJCZImVnEOdZcUT9AWR
         UaL8/Hccwf7gGvQTe+3od3mzRZzLVl2eXDxJj3xHcgN2Pa76PZqDa/vzf1d45bdegPCC
         g9YQ==
X-Gm-Message-State: AOJu0YyRWQNVEClp2DIexbwgsK3EP8iJWknua7t0yJaS3o2bN7GIWtcz
	q2O8TlFvkB7uS5Efn90gsc9xAsfvyPgwKtVRduVD5AlnqBPIYlM9ynF/oVS8xZngpfUS7lSzHdN
	Oa3xxwlRjiAUJpcz6vn52Z6QRGEJ52RSzy9dgrXTatMcQY4eOOE/L378=
X-Google-Smtp-Source: AGHT+IHrswuHa1bA8dFmO+/phXIZsZaUfnzrLqz1XsVI3Rgaxke/Mkpo8re0k6oNwaaBBTCRpgDaOqZhiOAot7Gj3sH3DORFdF0b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e7:b0:363:b9d6:1261 with SMTP id
 q7-20020a056e0220e700b00363b9d61261mr260487ilv.0.1706974714424; Sat, 03 Feb
 2024 07:38:34 -0800 (PST)
Date: Sat, 03 Feb 2024 07:38:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e79b806107c054a@google.com>
Subject: [syzbot] [afs?] [net?] INFO: task hung in rxrpc_release (3)
From: syzbot <syzbot+6b1634ec78e55df41793@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	kuba@kernel.org, linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    076d56d74f17 Add linux-next specific files for 20240202
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11611004180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=428086ff1c010d9f
dashboard link: https://syzkaller.appspot.com/bug?extid=6b1634ec78e55df41793
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1562f5b0180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dece45d1a4b5/disk-076d56d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4921e269b178/vmlinux-076d56d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a9156da9091/bzImage-076d56d7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/eed1ed253054/mount_8.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b1634ec78e55df41793@syzkaller.appspotmail.com

INFO: task kworker/u4:2:5198 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:2    state:D stack:22960 pid:5198  tgid:5198  ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17df/0x4a40 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6804 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6819
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2159
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 __flush_workqueue+0x730/0x1630 kernel/workqueue.c:3617
 rxrpc_release_sock net/rxrpc/af_rxrpc.c:949 [inline]
 rxrpc_release+0x258/0x420 net/rxrpc/af_rxrpc.c:979
 __sock_release net/socket.c:659 [inline]
 sock_release+0x82/0x150 net/socket.c:687
 afs_close_socket+0x288/0x310 fs/afs/rxrpc.c:127
 afs_net_exit+0x60/0xf0 fs/afs/main.c:156
 ops_exit_list net/core/net_namespace.c:170 [inline]
 cleanup_net+0x6da/0xb90 net/core/net_namespace.c:618
 process_one_work kernel/workqueue.c:3049 [inline]
 process_scheduled_works+0x913/0x14f0 kernel/workqueue.c:3125
 worker_thread+0xa60/0x1000 kernel/workqueue.c:3206
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: task syz-executor.1:7723 blocked for more than 144 seconds.
      Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:25784 pid:7723  tgid:7692  ppid:5146   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17df/0x4a40 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6804 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6819
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2159
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 __flush_workqueue+0x730/0x1630 kernel/workqueue.c:3617
 rxrpc_destroy_all_locals+0x47/0x140 net/rxrpc/local_object.c:477
 rxrpc_exit_net+0x87/0xc0 net/rxrpc/net_ns.c:115
 ops_exit_list net/core/net_namespace.c:170 [inline]
 setup_net+0x8d3/0xbc0 net/core/net_namespace.c:362
 copy_net_ns+0x4e4/0x7b0 net/core/net_namespace.c:495
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x619/0xc10 kernel/fork.c:3450
 __do_sys_unshare kernel/fork.c:3521 [inline]
 __se_sys_unshare kernel/fork.c:3519 [inline]
 __x64_sys_unshare+0x38/0x40 kernel/fork.c:3519
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f239b27dda9
RSP: 002b:00007f239adff0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f239b3ac120 RCX: 00007f239b27dda9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000060000200
RBP: 00007f239b2ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f239b3ac120 R15: 00007ffcfdc9a708
 </TASK>
INFO: task syz-executor.2:7726 blocked for more than 145 seconds.
      Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:24664 pid:7726  tgid:7704  ppid:5147   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17df/0x4a40 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6804 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6819
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2159
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 __flush_workqueue+0x730/0x1630 kernel/workqueue.c:3617
 rxrpc_destroy_all_connections+0xf0/0x3f0 net/rxrpc/conn_object.c:471
 rxrpc_exit_net+0x77/0xc0 net/rxrpc/net_ns.c:113
 ops_exit_list net/core/net_namespace.c:170 [inline]
 setup_net+0x8d3/0xbc0 net/core/net_namespace.c:362
 copy_net_ns+0x4e4/0x7b0 net/core/net_namespace.c:495
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x619/0xc10 kernel/fork.c:3450
 __do_sys_unshare kernel/fork.c:3521 [inline]
 __se_sys_unshare kernel/fork.c:3519 [inline]
 __x64_sys_unshare+0x38/0x40 kernel/fork.c:3519
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f96d407dda9
RSP: 002b:00007f96d3bff0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f96d41ac050 RCX: 00007f96d407dda9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000060000200
RBP: 00007f96d40ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f96d41ac050 R15: 00007fff0e3ca7e8
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_exp_gp_kthr/18:
1 lock held by khungtaskd/29:
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by getty/4823:
 #0: ffff8880294900a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000312b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
3 locks held by kworker/u4:2/5198:
 #0: ffff888015acd948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3024 [inline]
 #0: ffff888015acd948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x14f0 kernel/workqueue.c:3125
 #1: ffffc900043b7d20 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3024 [inline]
 #1: ffffc900043b7d20 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x14f0 kernel/workqueue.c:3125
 #2: ffffffff8f36da50 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0xf5/0xb90 net/core/net_namespace.c:580
1 lock held by syz-executor.1/7723:
 #0: ffffffff8f36da50 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c8/0x7b0 net/core/net_namespace.c:491
1 lock held by syz-executor.2/7726:
 #0: ffffffff8f36da50 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c8/0x7b0 net/core/net_namespace.c:491
1 lock held by syz-executor.0/7880:
 #0: ffffffff8f36da50 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c8/0x7b0 net/core/net_namespace.c:491
1 lock held by syz-executor.3/7924:
 #0: ffffffff8f36da50 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c8/0x7b0 net/core/net_namespace.c:491
1 lock held by syz-executor.3/8070:
 #0: ffffffff8f36da50 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c8/0x7b0 net/core/net_namespace.c:491
1 lock held by syz-executor.4/8223:
 #0: ffffffff8f36da50 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c8/0x7b0 net/core/net_namespace.c:491
1 lock held by syz-executor.0/8217:
 #0: ffffffff8f36da50 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c8/0x7b0 net/core/net_namespace.c:491
2 locks held by kworker/u4:10/8387:
1 lock held by syz-executor.2/8526:
 #0: ffffffff8e1360f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:323 [inline]
 #0: ffffffff8e1360f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x463/0x820 kernel/rcu/tree_exp.h:939
1 lock held by syz-executor.3/8524:
 #0: ffffffff8e1360f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:323 [inline]
 #0: ffffffff8e1360f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x463/0x820 kernel/rcu/tree_exp.h:939

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfb0/0xff0 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 4509 Comm: klogd Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:validate_chain+0xc/0x58e0 kernel/locking/lockdep.c:3825
Code: 89 d9 e9 54 ff ff ff e8 b2 a6 fa 09 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 e5 41 57 41 56 <41> 55 41 54 53 48 83 e4 e0 48 81 ec c0 02 00 00 49 89 ce 89 54 24
RSP: 0018:ffffc90003be7030 EFLAGS: 00000082
RAX: 1ffffffff25315a5 RBX: ffffffff9298ad28 RCX: 58cce5e7c8d5ebdc
RDX: 0000000000000001 RSI: ffff88807efac6d8 RDI: ffff88807efabc00
RBP: ffffc90003be7040 R08: ffffffff92ca3427 R09: 1ffffffff2594684
R10: dffffc0000000000 R11: fffffbfff2594685 R12: ffff88807efabc00
R13: ffff88807efabc00 R14: 0000000000000001 R15: ffff88807efabc00
FS:  00007f2d3d36b380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6f6acd56c6 CR3: 000000002c35c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 rcu_read_lock include/linux/rcupdate.h:750 [inline]
 is_bpf_text_address+0x42/0x2b0 kernel/bpf/core.c:762
 kernel_text_address+0xa7/0xe0 kernel/extable.c:125
 __kernel_text_address+0xd/0x40 kernel/extable.c:79
 unwind_get_return_address+0x5d/0xc0 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0x125/0x1b0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3814 [inline]
 slab_alloc_node mm/slub.c:3861 [inline]
 kmem_cache_alloc_node+0x192/0x380 mm/slub.c:3904
 __alloc_skb+0x181/0x420 net/core/skbuff.c:641
 alloc_skb include/linux/skbuff.h:1296 [inline]
 alloc_skb_with_frags+0xc3/0x780 net/core/skbuff.c:6394
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2794
 unix_dgram_sendmsg+0x6d3/0x1f80 net/unix/af_unix.c:2032
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2199
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f2d3d4cd9b5
Code: 8b 44 24 08 48 83 c4 28 48 98 c3 48 98 c3 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 26 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 7a 48 8b 15 44 c4 0c 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffc85358648 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f2d3d4cd9b5
RDX: 0000000000000039 RSI: 00005631e25d5ab0 RDI: 0000000000000003
RBP: 00005631e25d0910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000013
R13: 00007f2d3d65b212 R14: 00007ffc85358748 R15: 0000000000000000
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

