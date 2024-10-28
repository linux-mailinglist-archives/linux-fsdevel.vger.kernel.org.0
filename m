Return-Path: <linux-fsdevel+bounces-33092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC149B3DAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 23:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5361C216F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 22:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AD41EE023;
	Mon, 28 Oct 2024 22:23:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F62E414
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154204; cv=none; b=GkuzhQ62ZGJGe6/G4EhTBVwO6bzaVB0xAyGyll2kfC1cq5BubFSwxJU5p8s0L1wpN0IKhYdhQBSAAkd0xVT/Zp7SI90A62VfndRCGbHkYe9JyZe09EMddeb9WIyFTmz4gN1T0xkcHUalPtW/Rp5zqtYZUkJ8nijYWEL34kuBo04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154204; c=relaxed/simple;
	bh=WXOxYEeMCkHYPfA9arqGKyS0+VjxZnAss7CGRQJ9dzw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tgq8uoKz8tDvyJbzJZ9JdGXb9SlnWece77vg1qadbYuGnWOzr2f2tSiVhixTGBIQeWGD3yT4vP6rG0ZubpHm70npPDooIZX8k/LcxA1eS2bgm/LP5Y8pcnbAmcCbaDxtrgGTwLO9j6bF/kWxupUE9hYuF9oL8xY+sViWPFUJexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so42602625ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 15:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730154201; x=1730759001;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CThvT4rZ2XhQHbDeTQuDJPUMFBOGec7BXymSfx7Unc=;
        b=Ylu5yGaM4qzWCdpusPDz0bLnBYdtXhzJ+OidyqmRykn/6gRR2D+gwvHdlm4EGJrJTq
         ERPbxIIQwFkqb4DMg7RI/tfVWFW5X9oJUi9e2BTM/uUYgeIEZBiY01IuQG9i/fE7Ob/R
         OXBPnHqUTGOtj0et52TzaoHvjWPJeeTQhprhszgVA94PLWee9Idx1XlK8RIcv3+/MEVb
         ZOaNMNW8MkiHOs59pEQAOAA23Zp3lqaGB+VNEY7U9015Vy49WGQP06Yay/NIuTc/lrMb
         tN7DtUBtEuBSDhegsxoa/WKwxH8GyITSjBAEz9m+v8mblIim4S3+b43n0PT13VbcK1P3
         /T6g==
X-Forwarded-Encrypted: i=1; AJvYcCWETAu/Cn4xJLojUSdhFZjK5c+2TExhDDNHHZxEs2Ibsm7klNFb09IUAfrxUqBBFi1yRPjZkNRBhza70hMQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwnmMbFte1GMyEM+M9iipvrThq+EloYVeW4PdU3xGPj7hnq0y3N
	YGcnuAJEd/VJ92YdDq/USbAyVVy7DUNE6gBqw8WAO11BN/hmEl1aJEO9SgRVvCBlepCrC2YUxDX
	45IkkgfpeHuh5UhstUBhkN2AZGcHMPWcJUxCVHPoz6TTf0A3rEL4aKAw=
X-Google-Smtp-Source: AGHT+IFPM+RsyuYrZzYKKY5Et21s5ErO8PkxTg5KrcBKd+1CUsjO6237bHOXE2ebWPCJ4xLvTtAu1Y5dvsmCcqsw32iwaQ4oI09b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4e:b0:3a0:90c7:f1b with SMTP id
 e9e14a558f8ab-3a4ed2aff69mr91699135ab.12.1730154200970; Mon, 28 Oct 2024
 15:23:20 -0700 (PDT)
Date: Mon, 28 Oct 2024 15:23:20 -0700
In-Reply-To: <6710d2a2.050a0220.d9b66.0189.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67200ed8.050a0220.11b624.04b5.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] INFO: task hung in do_coredump (3)
From: syzbot <syzbot+a8cdfe2d8ad35db3a7fd@syzkaller.appspotmail.com>
To: brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    819837584309 Linux 6.12-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16356ca7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1940f73a609bb874
dashboard link: https://syzkaller.appspot.com/bug?extid=a8cdfe2d8ad35db3a7fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171b4687980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bd3230580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5d6f005bb493/disk-81983758.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9e1428c416c8/vmlinux-81983758.xz
kernel image: https://storage.googleapis.com/syzbot-assets/970a44403f00/bzImage-81983758.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a8cdfe2d8ad35db3a7fd@syzkaller.appspotmail.com

INFO: task syz-executor377:5856 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor377 state:D stack:28560 pid:5856  tgid:5854  ppid:5853   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5730 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
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
RIP: 0033:0x7fc0089ce2e9
RSP: 002b:00007fc008968218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007fc008a58318 RCX: 00007fc0089ce2e9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007fc008a5831c
RBP: 00007fc008a58310 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000246 R12: 00007fc008a5831c
R13: 0008000000000001 R14: 00004000000000df R15: 0000300000000000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8ddb7800 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8ddb7800 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ddb7800 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
2 locks held by syslogd/5195:
 #0: ffff8880b863ee98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:598
 #1: ffffffff9a5faf30 (&obj_hash[i].lock){-.-.}-{2:2}, at: __skb_try_recv_datagram+0x149/0x4f0 net/core/datagram.c:263
2 locks held by getty/5606:
 #0: ffff8880350da0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
1 lock held by syz-executor377/5855:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc5-syzkaller #0
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
CPU: 0 UID: 0 PID: 5855 Comm: syz-executor377 Not tainted 6.12.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:sha256_transform_rorx+0xfd9/0x1120 arch/x86/crypto/sha256-avx2-asm.S:655
Code: 38 09 d6 45 31 e6 41 89 cc 44 21 c6 41 21 d4 45 01 ef 41 01 d9 44 09 e6 44 01 f3 45 01 f9 44 01 fb 45 89 d7 c4 43 7b f0 e9 19 <c4> 43 7b f0 f1 0b 45 31 df 45 31 f5 c4 43 7b f0 f1 06 45 21 cf 01
RSP: 0018:ffffc9000381f200 EFLAGS: 00000297
RAX: 0000000082170eda RBX: 00000000aaf713b2 RCX: 00000000dd0d3fb4
RDX: 0000000083a209e1 RSI: 00000000dd051db4 RDI: 00000000000001c0
RBP: ffffc9000381f420 R08: 000000007d459d16 R09: 000000002d345c33
R10: 00000000bb0c1e52 R11: 00000000ff949dec R12: 00000000810009a0
R13: 000000009a2e1996 R14: 00000000fe1b74f0 R15: 00000000bb0c1e52
FS:  00007fc0089896c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005614eea51680 CR3: 0000000079270000 CR4: 00000000003526f0
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
RIP: 0033:0x7fc0089ce2e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc008989208 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fc008a58308 RCX: 00007fc0089ce2e9
RDX: 00004000000000df RSI: 0008000000000001 RDI: 0000000000000000
RBP: 00007fc008a58300 R08: 0000000000000401 R09: 0000300000000000
R10: 0000000000040eb1 R11: 0000000000000246 R12: 00007fc008a5830c
R13: 0008000000000001 R14: 00004000000000df R15: 0000300000000000
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.168 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

