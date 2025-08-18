Return-Path: <linux-fsdevel+bounces-58127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BDEB29B9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 10:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1B0188B82F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 08:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E232EAB6E;
	Mon, 18 Aug 2025 08:04:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28562C3757
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504273; cv=none; b=SIdKLJOl/MKYb15on1wTK8zwtJ7u3LLEhVDi3W0+em0PAsyKMI4r1y0CUiCJh8UTIt/fsx2hPm5oa29qYOUrC9bOVxL6gvZoiDNJJxdHAm6iWVorayWc0ULu+OOvN/ljzWBpN+UgLaKLcMH/QQR6KnRREftqDxHY7bvhCtqcqE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504273; c=relaxed/simple;
	bh=RHk19o0hxuJWW/AUjMGx3j6AyVeEotI75BaRvs/6usI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sWTjRvWr1WMDHvdJdDZd3cJRwaRYBDQCjNVfG03endK+G9I0vhfQPZhDAdPjwHvr4ps8xBUb+DvqFNri1RxC+qRNExJ7WRHHqTBJ+PCSV8fX/BQsSI3vaybklriXhTAn3SCxLeRGaVih9aGl1eSVw8JUSfTpikM2wstri5Gqd94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-88432d8ddb1so461804639f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 01:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755504271; x=1756109071;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXCnyKQ3Vm9M1IoDEuwjwfWaE/02hODwJqv40lVhlK0=;
        b=laXZ6RAmrms1MWLSwH7HXOsPbBJrl8+jIM5x+1EjP4MrGWS1PkDApGlRLVDEpOQUa+
         IZD5nTR3S7nbEqcxQyvajnF+GH9C29n/RDfCruVwQMN0cjFpSOZm1jrtCWun1K7qB3Eb
         eG9zMxhfHonae2eisfefBx3vlkUl0l0VIq9fPFVqn+pDShOhal6XsPyRCMR3DtgzQ62F
         783YYoT6+wVD/rJR1Fc1pjIzTP76XTmlHOga2f32MPsYslLE9DWYPQCqTZiDhRFxKacQ
         LJ873idyUk/7kEX0VrBfbPzFUNBfCF0xvOPiYets/LNQZ44H6kNW/hqaJi+42CXrSfWD
         Yb9w==
X-Forwarded-Encrypted: i=1; AJvYcCUe6JWg8arDLT3a4FGj5nR+70CEeGESMn/XRCQQQWQkw1OftS8ZvpYCICV8f7HKkCksbI2sX3C/km9BehoH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8mDL6TLjIjYRIRQ14Rh6slP9yn27OnplbEq869It6Kf48a1Y
	eZOiQJ0FibqgcVECnPCREveg9PShm/BGiQS2pig1avxq4JUnxLVllNbsIG/SrFhS7e0Dc7KvFWv
	U0cC64mOWGKB/djWnSfu9tTVw4uppmK+He9uLi14e49VPIWl85B0T1uKgHAY=
X-Google-Smtp-Source: AGHT+IG3kt2iy1xjjQ4YX7zLb09k9beA7lbFy2HID79JSAPU010RsT/rmQ5oO/ogDnt62ofaqeiOBwbktkqzqJ3/+ro7iQksbLgp
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15c7:b0:876:a8dc:96cc with SMTP id
 ca18e2360f4ac-8843e39e913mr1960591339f.6.1755504271041; Mon, 18 Aug 2025
 01:04:31 -0700 (PDT)
Date: Mon, 18 Aug 2025 01:04:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a2de8f.050a0220.e29e5.0097.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] INFO: task hung in v9fs_file_fsync
From: syzbot <syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, dvyukov@google.com, 
	elver@google.com, glider@google.com, jack@suse.cz, kasan-dev@googlegroups.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, oleg@redhat.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    038d61fd6422 Linux 6.16
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15f5a234580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=515ec0b49771bcd1
dashboard link: https://syzkaller.appspot.com/bug?extid=d1b5dace43896bc386c3
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158063a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1335d3a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34e894532715/disk-038d61fd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b6a27a46b9dc/vmlinux-038d61fd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f97a9c8d8216/bzImage-038d61fd.xz

The issue was bisected to:

commit aaec5a95d59615523db03dd53c2052f0a87beea7
Author: Oleg Nesterov <oleg@redhat.com>
Date:   Thu Jan 2 14:07:15 2025 +0000

    pipe_read: don't wake up the writer if the pipe is still full

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1498e3a2580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1698e3a2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1298e3a2580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com
Fixes: aaec5a95d596 ("pipe_read: don't wake up the writer if the pipe is still full")

INFO: task syz-executor224:5849 blocked for more than 143 seconds.
      Not tainted 6.16.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor224 state:D stack:22952 pid:5849  tgid:5849  ppid:5848   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x16aa/0x4c90 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6879
 io_schedule+0x81/0xe0 kernel/sched/core.c:7724
 folio_wait_bit_common+0x6b0/0xb90 mm/filemap.c:1317
 folio_wait_writeback+0xb0/0x100 mm/page-writeback.c:3126
 __filemap_fdatawait_range+0x147/0x230 mm/filemap.c:539
 file_write_and_wait_range+0x275/0x330 mm/filemap.c:798
 v9fs_file_fsync+0xcf/0x1a0 fs/9p/vfs_file.c:418
 generic_write_sync include/linux/fs.h:3031 [inline]
 netfs_file_write_iter+0x3d8/0x4a0 fs/netfs/buffered_write.c:494
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x54b/0xa90 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb29049bef9
RSP: 002b:00007ffeb3361588 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000200000000140 RCX: 00007fb29049bef9
RDX: 0000000000007fec RSI: 0000200000000300 RDI: 0000000000000007
RBP: 0030656c69662f2e R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 0000200000000180
R13: 00007fb2904e504e R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u8:0/12:
1 lock held by khungtaskd/31:
 #0: ffffffff8e13f0e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13f0e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e13f0e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6770
2 locks held by kworker/u8:6/1337:
 #0: ffff88801a489148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88801a489148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000451fbc0 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000451fbc0 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
2 locks held by getty/5596:
 #0: ffff88803095f0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900036cb2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
1 lock held by syz-executor224/5849:
 #0: ffff88807f8cc428 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3096 [inline]
 #0: ffff88807f8cc428 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x211/0xa90 fs/read_write.c:682

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.16.0-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
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
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.0-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: 53 de 02 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d d3 ad 21 00 f3 0f 1e fa fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffffff8de07d80 EFLAGS: 000002c2
RAX: eefad1cde067ed00 RBX: ffffffff81976918 RCX: eefad1cde067ed00
RDX: 0000000000000001 RSI: ffffffff8d982fba RDI: ffffffff8be1ba40
RBP: ffffffff8de07ea8 R08: ffff8880b8632f5b R09: 1ffff110170c65eb
R10: dffffc0000000000 R11: ffffed10170c65ec R12: ffffffff8fa0b3f0
R13: 0000000000000000 R14: 0000000000000000 R15: 1ffffffff1bd2a50
FS:  0000000000000000(0000) GS:ffff888125c57000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055943a295660 CR3: 000000000df38000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:749
 default_idle_call+0x74/0xb0 kernel/sched/idle.c:117
 cpuidle_idle_call kernel/sched/idle.c:185 [inline]
 do_idle+0x1e8/0x510 kernel/sched/idle.c:325
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:423
 rest_init+0x2de/0x300 init/main.c:745
 start_kernel+0x47d/0x500 init/main.c:1102
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

