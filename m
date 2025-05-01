Return-Path: <linux-fsdevel+bounces-47815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39350AA5BEF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 10:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7743E4C5052
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 08:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FF4265CC4;
	Thu,  1 May 2025 08:08:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F0540BF5
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 May 2025 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746086923; cv=none; b=bmM1mn+S6y457RZ0dne/BR0Ef9lbahiR5wojgIKFbxeIXylseEUI4ICOczT0Eni+AGlk2vU8dZBb2Nm1gukT3ab9KqqUqewcl7sRnIbtwf1eXa20vsXI0GFUvvXQkJ5SyZvAh0sycBHmnrf0AwPoL2R1lSTX2cork7g3h3j62YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746086923; c=relaxed/simple;
	bh=6CS+mD6fzts1P1fSlYpcm7I0+NU8n7R08zNCC7Fs5SY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H2qiBUt6kJnFehep2DPKidig8IGAb1nIYlQesvOFWlUTEunoG51ygeawNXBBGJJ1ZW7Plpc/Rj7uW/vZELbVzCKzjG7Dwo6ujgxoxPMwoh5CLd3NraphwPJaLyTsC5mCGr8Lz2Sjbmk/2EFxOVwHSmWsQ08l8jaUYPAzmL/Z1Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85b4ee2e69bso79471539f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 May 2025 01:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746086920; x=1746691720;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ql6YYBERpJOsbTEQcpqxxcK3lPb1peFfvwvGY2f/FNg=;
        b=Ozbu8Wus8dgZbE5GHzI9iAzxwaOpDedRovfV9zHiM2yVwZNdr0lVkIo4ADcEn8S52W
         OxK7VOmxdyBeMrAJOC9XkMAYtDo+niCJ5aS+4Dx8F3kAJeKndaZ4GVu94VuY153PDyF8
         bXTuTH5qjWijZvLJtlZE1S1h9ojkePCCDD61lr2pHdG8zultXnLjhqXtScqH5NSy6YIU
         tm/+xKCxTWd1qwRMoAPATC3KuGmOId/7go7MdAvLW2QRxS/+eBqOL2X40kPzL9JNPJgJ
         NOqH8vnSbyxze5Su1K7bHylYeWU42hI6kKip1e8Vf6P0Unribotg2BsSi4o8VMugVbao
         zf9w==
X-Forwarded-Encrypted: i=1; AJvYcCUShCKl2khou2zDzWIZw3NV96ilaWc5mNVhcxYzy++SCPzLArBYf4kPVlL6U7xgTvI37wcyCqlhV/nadZMv@vger.kernel.org
X-Gm-Message-State: AOJu0YyqHNrubwQSSWdP/GoH9p5FEmNWmSNK3ZRnfkYWth++O5KbnjSF
	WN6DXiJqjznecTvaNzL8zY9yRaR78EqTrIgW+h0WWwU6wnzQf/QDrOmmHwogjSU5v1Tbi66wXfw
	6ma5rvxnNYUdF+SwKdQYHiMc31kMGpReJNsp8pRMug9BJIfPhKa0L1Iw=
X-Google-Smtp-Source: AGHT+IH8lE3jRxC6jxsU8/g0jLpBmYKNJ8KGjxoa0WYAUZ+FEIPCW0sZxUjTbQ0WnSamP6a8kdSvn0FU1t+ddlOVRJigbAhhmlDa
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:274b:b0:864:68b0:60b3 with SMTP id
 ca18e2360f4ac-8649805684bmr700099839f.12.1746086920444; Thu, 01 May 2025
 01:08:40 -0700 (PDT)
Date: Thu, 01 May 2025 01:08:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68132c08.050a0220.14dd7d.0007.GAE@google.com>
Subject: [syzbot] [netfs?] INFO: task hung in anon_pipe_write
From: syzbot <syzbot+ef2c1c404cbcbcc66453@syzkaller.appspotmail.com>
To: brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	idryomov@gmail.com, jack@suse.cz, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, netfs@lists.linux.dev, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5bc1018675ec Merge tag 'pci-v6.15-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a01270580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f5bd2a76d9d0b4e
dashboard link: https://syzkaller.appspot.com/bug?extid=ef2c1c404cbcbcc66453
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a130d4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12944374580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/33f182866e0b/disk-5bc10186.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/103760a3e862/vmlinux-5bc10186.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9954dc25ed1d/bzImage-5bc10186.xz

The issue was bisected to:

commit 7ba167c4c73ed96eb002c98a9d7d49317dfb0191
Author: David Howells <dhowells@redhat.com>
Date:   Mon Mar 18 16:57:31 2024 +0000

    netfs: Switch to using unsigned long long rather than loff_t

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=112ba374580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=132ba374580000
console output: https://syzkaller.appspot.com/x/log.txt?x=152ba374580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ef2c1c404cbcbcc66453@syzkaller.appspotmail.com
Fixes: 7ba167c4c73e ("netfs: Switch to using unsigned long long rather than loff_t")

INFO: task kworker/0:0:9 blocked for more than 143 seconds.
      Not tainted 6.15.0-rc3-syzkaller-00342-g5bc1018675ec #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:28184 pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: events p9_write_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x116f/0x5de0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 __mutex_lock_common kernel/locking/mutex.c:678 [inline]
 __mutex_lock+0x6c7/0xb90 kernel/locking/mutex.c:746
 anon_pipe_write+0x15d/0x1a70 fs/pipe.c:459
 __kernel_write_iter+0x317/0xa90 fs/read_write.c:617
 __kernel_write fs/read_write.c:637 [inline]
 kernel_write fs/read_write.c:658 [inline]
 kernel_write+0x1f4/0x6c0 fs/read_write.c:648
 p9_fd_write net/9p/trans_fd.c:434 [inline]
 p9_write_work+0x258/0xc10 net/9p/trans_fd.c:485
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:0/9:
 #0: ffff88801b478d48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
 #1: ffffc900000e7d18 ((work_completion)(&m->wq)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
 #2: ffff888021730068 (&pipe->mutex){+.+.}-{4:4}, at: anon_pipe_write+0x15d/0x1a70 fs/pipe.c:459
1 lock held by khungtaskd/31:
 #0: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e3bf5c0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6764
2 locks held by getty/5571:
 #0: ffff8880323de0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000333b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x41b/0x14f0 drivers/tty/n_tty.c:2222
2 locks held by syz-executor149/5821:
 #0: ffff888021730068 (&pipe->mutex){+.+.}-{4:4}, at: anon_pipe_write+0x15d/0x1a70 fs/pipe.c:459
 #1: ffff88807f568958 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:922 [inline]
 #1: ffff88807f568958 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: filemap_fault+0x625/0x2740 mm/filemap.c:3410

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.15.0-rc3-syzkaller-00342-g5bc1018675ec #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:274 [inline]
 watchdog+0xf70/0x12c0 kernel/hung_task.c:437
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.15.0-rc3-syzkaller-00342-g5bc1018675ec #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
RIP: 0010:hlock_class+0x13/0x70 kernel/locking/lockdep.c:233
Code: 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f b7 47 20 66 25 ff 1f 0f b7 c0 48 0f a3 05 3d cd 12 14 <73> 15 48 8d 04 80 48 8d 04 80 48 8d 04 c5 60 6f aa 95 c3 cc cc cc
RSP: 0018:ffffc90000197a30 EFLAGS: 00000003
RAX: 000000000000006d RBX: ffff88801dad2f30 RCX: 0000000000000000
RDX: 0000000000040000 RSI: 0000000000000000 RDI: ffff88801dad2f30
RBP: ffff88801dad2f30 R08: 0000000000080000 R09: 0000000000000001
R10: 0000000000000000 R11: ffff8880b8527858 R12: 0000000000000001
R13: 0000000000000002 R14: ffff88801dad2440 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888124ae4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005650ce575028 CR3: 000000000e180000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 check_wait_context kernel/locking/lockdep.c:4856 [inline]
 __lock_acquire+0x1f9/0x1ba0 kernel/locking/lockdep.c:5185
 lock_acquire kernel/locking/lockdep.c:5866 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 hrtimer_get_next_event+0x5f/0x260 kernel/time/hrtimer.c:1530
 cmp_next_hrtimer_event kernel/time/timer.c:1976 [inline]
 __get_next_timer_interrupt+0x43e/0x810 kernel/time/timer.c:2318
 tick_nohz_next_event+0x309/0x400 kernel/time/tick-sched.c:922
 tick_nohz_idle_stop_tick+0x7d3/0xef0 kernel/time/tick-sched.c:1218
 cpuidle_idle_call kernel/sched/idle.c:183 [inline]
 do_idle+0x38c/0x510 kernel/sched/idle.c:325
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:423
 start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:315
 common_startup_64+0x13e/0x148
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

