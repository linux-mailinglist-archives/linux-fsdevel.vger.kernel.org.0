Return-Path: <linux-fsdevel+bounces-63652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D74BC882B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 12:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3153AD13E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 10:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54FB2C11DB;
	Thu,  9 Oct 2025 10:32:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9046779CD
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760005947; cv=none; b=YFav3ZJHaMaCuruGCWi3qeOSPlZrnEI7tN8RwX80PhVOPTmdnrA8vhe0RXhKENa3YVK0QlwbQvamsZ7ilwZa41aS/KjfV8+6CHadza6sC9IdVIBwt+/JHbEpYKC9Cc152l5m0hboXRuQYOVHnuWKxrKqAngzc5nnWAObHdJgaJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760005947; c=relaxed/simple;
	bh=k5R/vceqDjN5sCzQFkq785u7pH5+CTtIEZKL5Szr+aA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QcoLhgKDWhd7j8KCQHhU/HTmTuOcXAcxljYvBbZPeg7pa7FRkoRWCedZDKbN5ozZb63I3jGcvGLlvr1XOUAU4IWdiUEiUO95YGCD2gIyLo4Cw+sjriQk9vAamomEiToMvXYgJIgX2vKFB0ZiT9CAY3Co8qtkWeNvj2baADd2GxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-927b19c5023so135898539f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 03:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760005944; x=1760610744;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=csjVdmAnGOd8IRaEQ846icIIutQIU1tu6v0kvHSOjB8=;
        b=OsDvyOZ2GD9M75IbyPN2M1HqvO9ivjruYROmTahRalrIjvOi25ce4S8YgyYaLQzuoq
         YgqgjkWAhpzhtsoPao2qUVArQQSdTd5jtqZeeL9Bv/rEVFjFstnmWblBMctucrgc15BP
         X9zXMu3m6lNd2QrQJUDL2vAoycybIfyZa1sTexqS83afG8JDR5MtoNk9OeE1J4mrqUNO
         TIXwZvnzKP0392O1ZNP1BbCEfkWJxO8TZ/IqMoBwh4beMlyP9TkIuB/igEbSXwH+YaN4
         USSHzav10FcVXpLVjb3HqYstgV9kmFKUMOfSBPjZDHf7Xb81dfaHPnCLRwmFwF5fZBB3
         aSkg==
X-Forwarded-Encrypted: i=1; AJvYcCUW1xSB9T6vfVVoln9b9jinJzkrrNrehgou6mjitp303nt4zomoBoHl31vgNp42A5tpooTfjYHVwOoe4mhu@vger.kernel.org
X-Gm-Message-State: AOJu0YwERkzkl3A25ImbxH2kvZVult4tBsrivjBxoObgtn7jhcBs/2qh
	6zDkUzqTw9GN7H88P1GsMjvM3s16pdW6pT1jeRE6XiqaweIuY9jeARmjcF/8jIUYK74apmQsGa4
	sGpZtpKSkodU351TviN2bvWhEHMMRP9MO8hk7QiyiUJXdix/4btz2iQxyk4Q=
X-Google-Smtp-Source: AGHT+IG0bihqbzkFHPoRY12uWvM3UJGNySYuvEEnQx+kSblX2ADCKLbmQOEmRD1LKeYrgNWdaQX/wdS+Vw5iQRA0enedzFYXnt0S
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3c3:b0:88d:7956:2e04 with SMTP id
 ca18e2360f4ac-93bd1996632mr790580439f.19.1760005944707; Thu, 09 Oct 2025
 03:32:24 -0700 (PDT)
Date: Thu, 09 Oct 2025 03:32:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e78f38.a70a0220.126b66.0000.GAE@google.com>
Subject: [syzbot] [fs?] INFO: rcu detected stall in eventpoll_release_file (2)
From: syzbot <syzbot+acf1d29334968f95c8aa@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d104e3d17f7b Merge tag 'cxl-for-6.18' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1386692f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7fbc67b290d20c8
dashboard link: https://syzkaller.appspot.com/bug?extid=acf1d29334968f95c8aa
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144f4304580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a3b942580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1b9be99eac71/disk-d104e3d1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c53f49fb5e7d/vmlinux-d104e3d1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/472bbd39f27e/bzImage-d104e3d1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+acf1d29334968f95c8aa@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 ticks this GP) idle=1a74/1/0x4000000000000000 softirq=13502/13502 fqs=0
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5871/1:b..l
rcu: 	(detected by 1, t=10504 jiffies, g=10797, q=541 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5864 Comm: udevd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:advance_sched+0x178/0xc90 net/sched/sch_taprio.c:932
Code: db 74 29 49 8d 7c 24 c0 be ff ff ff ff e8 70 81 d7 01 89 c3 31 ff 89 c6 e8 55 24 61 f8 85 db 0f 84 ab 06 00 00 e8 08 20 61 f8 <eb> 05 e8 01 20 61 f8 4d 8d 74 24 f0 4c 89 f1 48 c1 e9 03 48 b8 00
RSP: 0018:ffffc90000007c70 EFLAGS: 00000006
RAX: ffffffff895d3f38 RBX: 0000000000000001 RCX: ffff8880785cdac0
RDX: 0000000000010000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000000f7c R12: ffff888023610340
R13: ffff888023610000 R14: dffffc0000000000 R15: ffff888032438800
FS:  00007f2a2f406880(0000) GS:ffff888126388000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f21335dba90 CR3: 0000000077c54000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
 __hrtimer_run_queues+0x52c/0xc60 kernel/time/hrtimer.c:1841
 hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1903
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
 __sysvec_apic_timer_interrupt+0x108/0x410 arch/x86/kernel/apic/apic.c:1058
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1052
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__ep_remove+0x126/0x710 fs/eventpoll.c:855
Code: 35 00 00 74 08 4c 89 e7 e8 57 49 d9 ff 89 6c 24 0c 4d 8b 34 24 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 <74> 08 4c 89 f7 e8 30 49 d9 ff 49 8d 6f 50 49 39 2e 0f 84 95 00 00
RSP: 0018:ffffc90004347ce0 EFLAGS: 00000246
RAX: 1ffff1100fc09fd0 RBX: ffff8880304fcc3c RCX: dffffc0000000000
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffc90004347c60
RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000868f8c R12: ffff88807be122f8
R13: 1ffff1100f7c245f R14: ffff88807e04fe80 R15: ffff8880304fcc00
 eventpoll_release_file+0xdb/0x310 fs/eventpoll.c:1136
 eventpoll_release include/linux/eventpoll.h:57 [inline]
 __fput+0x839/0xa70 fs/file_table.c:459
 fput_close_sync+0x119/0x200 fs/file_table.c:573
 __do_sys_close fs/open.c:1589 [inline]
 __se_sys_close fs/open.c:1574 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1574
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2a2eca7407
Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffefbabcad0 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 00007f2a2f406880 RCX: 00007f2a2eca7407
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f2a2f4066e8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 00007ffefbabcb90 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:syz-executor758 state:R  running task     stack:21000 pid:5871  tgid:5871  ppid:5851   task_flags:0x400140 flags:0x00080001
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7256
 irqentry_exit+0x6f/0x90 kernel/entry/common.c:211
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:707
RIP: 0010:lock_release+0x2b5/0x3e0 kernel/locking/lockdep.c:5893
Code: 51 48 c7 44 24 20 00 00 00 00 9c 8f 44 24 20 f7 44 24 20 00 02 00 00 75 56 f7 c3 00 02 00 00 74 01 fb 65 48 8b 05 6b 6d ad 10 <48> 3b 44 24 28 0f 85 8b 00 00 00 48 83 c4 30 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc900042862f0 EFLAGS: 00000206
RAX: e2c579f95b601100 RBX: 0000000000000206 RCX: e2c579f95b601100
RDX: 0000000000000001 RSI: ffffffff8d6f55e3 RDI: ffffffff8b9eea60
RBP: ffff8880316de618 R08: ffffc90004286cf0 R09: 0000000000000000
R10: ffffc90004286478 R11: fffff52000850c91 R12: 0000000000000001
R13: 0000000000000001 R14: ffffffff8dd3b220 R15: ffff8880316ddac0
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:871 [inline]
 class_rcu_destructor include/linux/rcupdate.h:1169 [inline]
 unwind_next_frame+0x19a9/0x2390 arch/x86/kernel/unwind_orc.c:680
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 unpoison_slab_object mm/kasan/common.c:342 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:368
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4946 [inline]
 slab_alloc_node mm/slub.c:5245 [inline]
 kmem_cache_alloc_node_noprof+0x433/0x710 mm/slub.c:5297
 kmalloc_reserve+0xbd/0x290 net/core/skbuff.c:579
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1383 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 rtmsg_fib+0xea/0x4c0 net/ipv4/fib_semantics.c:552
 fib_table_insert+0xd64/0x1b50 net/ipv4/fib_trie.c:1380
 fib_magic+0x2c4/0x390 net/ipv4/fib_frontend.c:1134
 fib_add_ifaddr+0x38d/0x5f0 net/ipv4/fib_frontend.c:1171
 fib_netdev_event+0x382/0x490 net/ipv4/fib_frontend.c:1516
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 __dev_notify_flags+0x18d/0x2e0 net/core/dev.c:-1
 netif_change_flags+0xe8/0x1a0 net/core/dev.c:9705
 do_setlink+0xc55/0x41c0 net/core/rtnetlink.c:3151
 rtnl_changelink net/core/rtnetlink.c:3769 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3928 [inline]
 rtnl_newlink+0x1619/0x1c80 net/core/rtnetlink.c:4065
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6954
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 __sys_sendto+0x3bd/0x520 net/socket.c:2244
 __do_sys_sendto net/socket.c:2251 [inline]
 __se_sys_sendto net/socket.c:2247 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2247
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f213324e8fc
RSP: 002b:00007f21333ff670 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f2133401080 RCX: 00007f213324e8fc
RDX: 000000000000002c RSI: 00007f21334010d0 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007f21333ff6c4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f21334010d0 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10503 jiffies! g10797 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=0 timer-softirq=5145
rcu: rcu_preempt kthread starved for 10504 jiffies! g10797 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:26728 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

