Return-Path: <linux-fsdevel+bounces-51586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A62CAD89F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 13:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864951896FDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 11:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C6E2D4B5D;
	Fri, 13 Jun 2025 11:04:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f207.google.com (mail-qt1-f207.google.com [209.85.160.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED0F2C15A5
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749812679; cv=none; b=KnZhnUmOUW6PyDe6VvCFCBrCVqtqwiumEp033PEJ9HGlvrLzxUgNLvSIn1kWnB+vDOJ0trHvYloDwHGnA90gCKu4e0hw+mh4pp6PuleqURC49fGZblY8jcrGrndNWcocVVZ5cF8I+6/B0O6O/S1TSpuNNPfekatyDkkvMLzyDQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749812679; c=relaxed/simple;
	bh=gkF11Vi2FrQD3WOhk2A71W/Qr3tehY8WiasNwBSxfKs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HW+EKOrW1xjwewc5W9iETsmdANYFcrND3yf8Cf6jhkBxxl+/7SRKDIiTspJ5tjJo1RpJZvBbTiWAAy/MLu4DRHfxvDTRhWuN1FPSiLF90xF7vXmoyrprqfzx7Q7Uq7IOd9MPHggmuVNkvtNVZRiQ+i5+NgbYilXoGZu5PpVO1QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-qt1-f207.google.com with SMTP id d75a77b69052e-4a43988c314so39674991cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 04:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749812677; x=1750417477;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cpTGQab/U0D39e0o1gC8NFB6KS8WTusESL+/4+GxDfk=;
        b=vFfqSILeh+df/RSvYibQM74wzkowKG6Y9o/BRzUw70i1F3ueOLy1TeBgyGd/hBRIAo
         payalYBCjCc+XdBQqormW+1KLOzj/AyFOl0Hy6ny7rjjKlIs8Bz/MHWOR9qEIXwDdpDa
         VB773/tMGsyG1fWk6USNrN6goP7kaVhv6dYR0UULmtU7+RdysxQc6No55ZvVUaBITEbq
         ch01luX69vDD9+X4PbuhwroHAvMbCmRrWvMU09V1b9TIN/IEYiccQcWHQof33duUAkcQ
         Y1qmCAIP+Ru/0IJzR2PspP7QwlGk0ARgv9XPSiZITzDe84VcxjWwaxGdGXO+WynDiJ1K
         gi4g==
X-Forwarded-Encrypted: i=1; AJvYcCVPwIo2p8pg3LnMeoKlUqkVyRRa22Wu2qx+I4moH+teLCERPydiGd/+UMWoddG9yXfk6xAm1NpV9EnUTSxm@vger.kernel.org
X-Gm-Message-State: AOJu0YzyzIaQSveTmXf2EztrzdfPpO9l/VUVh9l6zm9aPMmZ8zWzJ5JH
	eDvqXI9XhrY3yGY4R4YejElxpQFc6J3Rzi6ZitHA1vNMyM3Rdj6GXgtJCOOMjALVS4dzxDi1wOU
	AmsCrgyS+MgCS60x2WrVS4BYQzmWbyaMV9lsss4FJnEcE+8SjDQ0/fV1Udww=
X-Google-Smtp-Source: AGHT+IE7vKBDsqsTe9tHa2v3D5xyEFZfFh8AgoWKXonoKkwkytcSrBCab9bQcAfYQtkx2BzSyr8Nj5Z3SMd9RArnwFJC2/edQ0I6
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164d:b0:3dd:d746:25eb with SMTP id
 e9e14a558f8ab-3de00bf6f74mr26720675ab.16.1749812666276; Fri, 13 Jun 2025
 04:04:26 -0700 (PDT)
Date: Fri, 13 Jun 2025 04:04:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684c05ba.050a0220.be214.029e.GAE@google.com>
Subject: [syzbot] [hfs?] INFO: task hung in hfs_mdb_commit (3)
From: syzbot <syzbot+6bdbdd12cf8cdbc66466@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    19272b37aa4f Linux 6.16-rc1
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13d5ca0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=162faeb2d1eaefb4
dashboard link: https://syzkaller.appspot.com/bug?extid=6bdbdd12cf8cdbc66466
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1113ca82580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125a29d4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63fc98170cdb/disk-19272b37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f53e0c9076b/vmlinux-19272b37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/249526f4900a/bzImage-19272b37.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/cafdeb8d4eab/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6bdbdd12cf8cdbc66466@syzkaller.appspotmail.com

INFO: task kworker/0:0:9 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:27336 pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: events_long flush_mdb
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5396 [inline]
 __schedule+0x16a2/0x4cb0 kernel/sched/core.c:6785
 __schedule_loop kernel/sched/core.c:6863 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6878
 io_schedule+0x81/0xe0 kernel/sched/core.c:7723
 bit_wait_io+0x11/0xd0 kernel/sched/wait_bit.c:247
 __wait_on_bit_lock+0xe9/0x4f0 kernel/sched/wait_bit.c:90
 out_of_line_wait_on_bit_lock+0x123/0x170 kernel/sched/wait_bit.c:117
 lock_buffer include/linux/buffer_head.h:434 [inline]
 hfs_mdb_commit+0xb0d/0x1160 fs/hfs/mdb.c:325
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/0:0/9:
 #0: ffff88801a481548 ((wq_completion)events_long){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88801a481548 ((wq_completion)events_long){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc900000e7bc0 ((work_completion)(&(&sbi->mdb_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc900000e7bc0 ((work_completion)(&(&sbi->mdb_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
1 lock held by khungtaskd/31:
 #0: ffffffff8e13eda0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13eda0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e13eda0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6770
6 locks held by kworker/u8:7/4455:
2 locks held by getty/5585:
 #0: ffff888030f560a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.16.0-rc1-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:307 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:470
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.0-rc1-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d a3 55 29 00 f3 0f 1e fa fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffffff8de07d80 EFLAGS: 000002c2
RAX: 19cf73c379472d00 RBX: ffffffff81974f68 RCX: 19cf73c379472d00
RDX: 0000000000000001 RSI: ffffffff8d96d7bc RDI: ffffffff8be1af40
RBP: ffffffff8de07ea8 R08: ffff8880b8632f5b R09: 1ffff110170c65eb
R10: dffffc0000000000 R11: ffffed10170c65ec R12: ffffffff8f9fdef0
R13: 0000000000000000 R14: 0000000000000000 R15: 1ffffffff1bd2a50
FS:  0000000000000000(0000) GS:ffff888125c86000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0bd9123130 CR3: 000000002f7b4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:749
 default_idle_call+0x74/0xb0 kernel/sched/idle.c:117
 cpuidle_idle_call kernel/sched/idle.c:185 [inline]
 do_idle+0x1e8/0x510 kernel/sched/idle.c:325
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:423
 rest_init+0x2de/0x300 init/main.c:744
 start_kernel+0x47d/0x500 init/main.c:1101
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:307
 x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:288
 common_startup_64+0x13e/0x147
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

