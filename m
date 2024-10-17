Return-Path: <linux-fsdevel+bounces-32176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A889A1DC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 11:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E67281A44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 09:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575101D88AC;
	Thu, 17 Oct 2024 09:02:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165B818C348
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155751; cv=none; b=HLRx3El8GuVsctyaKbrhQiXOFceUjqGG3hhZoMXi/oN20LOJXkWzj9uOYYl6MFcnAqeAN2/K+t2IxL7uIOHQgEXq/nYB76aDTuWzPMX9kg860OtJ4hLbxcoxLifHlFc6m9LziUt1p3mMr5DDOjEqWjH/OpdNjYqbGEo3f1nS+nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155751; c=relaxed/simple;
	bh=ynej3tE6z+IjENCF94V6jx4lK+8FjzJTIC7+eSa9f0c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NxnkstRl71u8/KJKtKeiamcZj21d1cpciNKYkQS7HiwIlRjlxUnrZ+rNJSS194v3f0qhEwHRVLZ8Lj29VvGf7RNeOUoIMyyqn4xKbWY3poEVxLxVPKnHRPJzPZnCYiLx+h/b61cxmPbvICu1QkoiS35hjEr2WsbUQMH73J2qFXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c38d2b91so7180635ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 02:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729155746; x=1729760546;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3IbfTcZfMfwFOXm3kudPuLyWNrjMVrqsU0eXvcHD06w=;
        b=kKLIKmjR1q33xe9y/4BBqLU/YmXSWNZFuIgg9LMFHgx+4mhrBrM6H6NLnKP3TAPQ74
         qYc4aMrAEv7ftX/JKGeKBFChrH/v1Q0lg28y+jsKl5iVK+uOLQyDIqkv3y8yqejDWxT7
         Xeilva9A5Ooj3MPup+CHnVPN2F87WJNf8JogOpSCSTCQFtNnlennPPrb8NzhusO0uCZY
         FI3L5R/p0sDeKkvL3pqSkeZUdD3gGLHUblC44/udjFuKLEEFJ4JAsi+EVqlk86cfJGjp
         FWCzrctDnImX3M+U1BgjwKq7PbJCboLXYYYBlOcVXmmqwiCEJIslhN0RuyR6S5Wpn00A
         fGUA==
X-Forwarded-Encrypted: i=1; AJvYcCW1CWWHp2GJrhjhGUXt3D/wq9YPsN5shtvj435DBfGLgaMQpWTNTBbYJLQ9xH5ykZm/frET7uz1yJsYA2dC@vger.kernel.org
X-Gm-Message-State: AOJu0YyjoK4/UDaHW5Bmun/3d03kqPhsDwV1jMuprEEqwXmwqHJHlsdi
	symIkgTBFOwVfX/uzmDcTiMJ00cbKVooLQhtJcXGZu7m3dUlaeZ1uAukYWjJ7QtG9uxjx1MR/z8
	36MxcHFe2cqiiChoSgSbl+eARlO/J06XgXCU+AxJAOw1ugKf59nwVBVk=
X-Google-Smtp-Source: AGHT+IGaSDKBWOBFP1lzOzdm2/8hj9mkiv5JAp0TIXLMkhriV6ilmz7uNRoJPfaTkLTOiyyylzISBSGoc0jupb3clBLpnyE1Y6n0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2167:b0:3a3:983a:874f with SMTP id
 e9e14a558f8ab-3a3bcdc6bfamr164993065ab.12.1729155746484; Thu, 17 Oct 2024
 02:02:26 -0700 (PDT)
Date: Thu, 17 Oct 2024 02:02:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6710d2a2.050a0220.d9b66.0189.GAE@google.com>
Subject: [syzbot] [kernfs?] INFO: task hung in do_coredump (3)
From: syzbot <syzbot+a8cdfe2d8ad35db3a7fd@syzkaller.appspotmail.com>
To: brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c964ced77262 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13dbcf27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64667415a04ab9c4
dashboard link: https://syzkaller.appspot.com/bug?extid=a8cdfe2d8ad35db3a7fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8e033b304e7a/disk-c964ced7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4f886da219e0/vmlinux-c964ced7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/814a8b44477f/bzImage-c964ced7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a8cdfe2d8ad35db3a7fd@syzkaller.appspotmail.com

INFO: task syz.0.801:10223 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc3-syzkaller-00087-gc964ced77262 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.801       state:D stack:28592 pid:10223 tgid:10220 ppid:9895   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3e1/0x600 kernel/sched/completion.c:116
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion_state+0x1c/0x40 kernel/sched/completion.c:264
 coredump_wait fs/coredump.c:418 [inline]
 do_coredump+0x82f/0x4160 fs/coredump.c:575
 get_signal+0x237c/0x26d0 kernel/signal.c:2902
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f282b37dff9
RSP: 002b:00007f282c1850e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007f282b536060 RCX: 00007f282b37dff9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f282b536064
RBP: 00007f282b536058 R08: 00007f282c1a7080 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f282b536064
R13: 0000000000000000 R14: 00007ffcdfcd02c0 R15: 00007ffcdfcd03a8
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:1/12:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1212/0x1b30 kernel/workqueue.c:3204
 #1: ffffc90000117d80 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x8bb/0x1b30 kernel/workqueue.c:3205
 #2: ffffffff8fac4128 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0x51/0xc0 net/core/link_watch.c:276
1 lock held by khungtaskd/30:
 #0: ffffffff8ddb7800 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8ddb7800 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ddb7800 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
5 locks held by kworker/u8:5/1104:
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x1212/0x1b30 kernel/workqueue.c:3204
 #1: ffffc90003e27d80 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x8bb/0x1b30 kernel/workqueue.c:3205
 #2: ffffffff8faae510 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0xbb/0xb40 net/core/net_namespace.c:580
 #3: ffffffff8fac4128 (rtnl_mutex){+.+.}-{3:3}, at: default_device_exit_batch+0x8f/0x9b0 net/core/dev.c:11934
 #4: ffffffff8ddc30f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x282/0x3b0 kernel/rcu/tree_exp.h:297
3 locks held by kworker/u8:7/2921:
 #0: ffff88814c578948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x1212/0x1b30 kernel/workqueue.c:3204
 #1: ffffc90009917d80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x8bb/0x1b30 kernel/workqueue.c:3205
 #2: ffffffff8fac4128 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x14d0 net/ipv6/addrconf.c:4196
2 locks held by dhcpcd/4901:
 #0: ffff88803129c6c8 (nlk_cb_mutex-ROUTE){+.+.}-{3:3}, at: __netlink_dump_start+0x154/0x980 net/netlink/af_netlink.c:2405
 #1: ffffffff8fac4128 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #1: ffffffff8fac4128 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_dumpit+0x18f/0x1f0 net/core/rtnetlink.c:6534
2 locks held by getty/4989:
 #0: ffff888031d4a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
1 lock held by syz.1.644/8939:
1 lock held by syz.0.801/10221:
1 lock held by syz-executor/11581:
 #0: ffffffff8fac4128 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fac4128 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6672
1 lock held by syz-executor/11673:
 #0: ffffffff8fac4128 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fac4128 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6672
1 lock held by syz-executor/11679:
 #0: ffffffff8fac4128 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fac4128 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6672
1 lock held by syz-executor/11682:
 #0: ffffffff8fac4128 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fac4128 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6672

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc3-syzkaller-00087-gc964ced77262 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf0c/0x1240 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 8939 Comm: syz.1.644 Not tainted 6.12.0-rc3-syzkaller-00087-gc964ced77262 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:sha256_transform_rorx+0x491/0x1120 arch/x86/crypto/sha256-avx2-asm.S:600
Code: 00 c2 45 31 e6 c4 63 7b f0 e1 02 c4 c1 7d fe c0 45 31 e6 41 89 cc 41 21 d4 45 01 ef c5 fd 70 d0 50 44 09 e6 44 01 f3 45 01 f9 <44> 01 fb 01 f3 89 de c4 43 7b f0 e9 19 c4 43 7b f0 f1 0b 03 44 3c
RSP: 0018:ffffc900115f7200 EFLAGS: 00000207
RAX: 000000003357dd5f RBX: 0000000090041468 RCX: 00000000a7e785dd
RDX: 000000009f51b31d RSI: 000000008f51b59d RDI: 0000000000000080
RBP: ffffc900115f7420 R08: 00000000cd5035ab R09: 0000000068c009dd
R10: 00000000ca0dc7c0 R11: 00000000ff34e361 R12: 000000008741811d
R13: 00000000fdd296c2 R14: 00000000d903a8d4 R15: 00000000f9297221
FS:  00007f704af0b6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556573553680 CR3: 0000000050cbe000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_base_do_update include/crypto/sha256_base.h:81 [inline]
 _sha256_update arch/x86/crypto/sha256_ssse3_glue.c:74 [inline]
 _sha256_update+0x17e/0x220 arch/x86/crypto/sha256_ssse3_glue.c:58
 ima_calc_file_hash_tfm+0x302/0x3e0 security/integrity/ima/ima_crypto.c:491
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1ba/0x490 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x8a7/0xa10 security/integrity/ima/ima_api.c:293
 process_measurement+0x1271/0x2370 security/integrity/ima/ima_main.c:372
 ima_file_mmap+0x1b1/0x1d0 security/integrity/ima/ima_main.c:462
 security_mmap_file+0x8bd/0x990 security/security.c:2979
 vm_mmap_pgoff+0xdb/0x360 mm/util.c:584
 ksys_mmap_pgoff+0x1c8/0x5c0 mm/mmap.c:542
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:79 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:79
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f704a17dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f704af0b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f704a335f80 RCX: 00007f704a17dff9
RDX: 00004000000000df RSI: 0000002000000004 RDI: 0000000000000002
RBP: 00007f704a1f0296 R08: 0000000000000404 R09: 0000300000000000
R10: 0000000000040eb2 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f704a335f80 R15: 00007ffeb08cd318
 </TASK>


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

