Return-Path: <linux-fsdevel+bounces-44788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882DAA6CB56
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 16:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95FE1891F4F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 15:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C49233129;
	Sat, 22 Mar 2025 15:54:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459B222A7E5
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Mar 2025 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742658865; cv=none; b=uRzIoU2bZInmgiUurlQqVy5QiG32DR4oespU26E1FR8jYCTKnpTHDZDZIxHC9gYYcEOiuTuFhLs3Pm1Xl839DIP75IzR0NomaFvml0pJrAyBtDlh3uGaaIBcQn4yfivWjhS+g8N7WXZjH1hATrTJD5PW3lEg6eczKCZWdr4tdds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742658865; c=relaxed/simple;
	bh=kc6QUl7CZA17PutYJYOi8oMYxt/ybm/SJxaoCofPK3c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bqzzpHF2QUUAUuu1tQT53NxbOZz/UARhe1WD4m4IgKGTXNcAnMEApqIPiaK9HE5k0bGgtIbqo4taIRrtJFmGw2f5bJWbtHFP1ROqco0A32wvq/Gu/cC3OvrMC41bKqJxTfoyMO62Q1OpGbfnN6N464Z75+oD4XU1RVxBbGsOrAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d43d333855so29353825ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Mar 2025 08:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742658863; x=1743263663;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ieGuoJM9yMvrxpuQvM/BFy2q00aJIIm7lGg8sljWk2I=;
        b=A6Pev6oHlhdAj40ZNkCaudEvphS8hQ8q0c6Z43u3XlQtz9VmZ9mTOB6CggVu+ulR19
         tRK2w7+jmLHIXPvseYK37ZuQJInB+4WLTLqhf1Nh3FjPdK821SYzDz6Oiwen0aBiew08
         wHmcxi1A54OxGzgBLoihJ2C9lkA4SirgN0kn3v4D4WHrNrNTl3Hm2dtDk5/2uKyxBk85
         Q92F/vTfAlBwE+HL72d5UAvN07ZR/sovGunLWEiKKAPl+7uoNVC4xGBQOyzwJzhCWyFU
         be/GcSpdc5vRt/W23EIL3d/GBEMr8eDz9y19xrqJws7n/nTpwKWIceGlvAl25rClUpU9
         f/qA==
X-Forwarded-Encrypted: i=1; AJvYcCUppuDtc3b/AlGKWQ6sQpNLpv9Ev2o/iPQZzHUfavxETrgU79dQnZHXNM8ZPDS2KF52iNxzYHAMrguNEUmi@vger.kernel.org
X-Gm-Message-State: AOJu0YyC5J4moKBVomvgSRhqA2LA0ILKdBvnHcGBdrV3ChTeN6fPo91L
	oTFHPKNsnwUIo6yIU8ufqBS/mN61G8yznRAmvB4BifHY2wRUsa9UFyww/scAtxhfLS+QX0Q1tfB
	4kqAeSCBujbKzJYCUmLpVAJ/LrPlMlnOzlbCjhSw6aJoxOEhYWZu4Gsw=
X-Google-Smtp-Source: AGHT+IFViFrzSWhVTneZ2RhpziEvKfrFxQxjQDeo8nZmzt9IUNmq4BZv2LERXv/1js3Iu4L+t2F7CSCOC7wcRKBiaK/JJ63TVNlQ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190f:b0:3d0:4b3d:75ba with SMTP id
 e9e14a558f8ab-3d5960c1270mr81751745ab.4.1742658863334; Sat, 22 Mar 2025
 08:54:23 -0700 (PDT)
Date: Sat, 22 Mar 2025 08:54:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dedd2f.050a0220.31a16b.003f.GAE@google.com>
Subject: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
To: brauner@kernel.org, dhowells@redhat.com, jack@suse.cz, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, oleg@redhat.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc444ada1310 Merge tag 'soc-fixes-6.14-2' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1397319b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e330e9768b5b8ff
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1057319b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d6a44c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/924e6055daef/disk-fc444ada.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0cd40093a53e/vmlinux-fc444ada.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7370bbe4e1b8/bzImage-fc444ada.xz

The issue was bisected to:

commit aaec5a95d59615523db03dd53c2052f0a87beea7
Author: Oleg Nesterov <oleg@redhat.com>
Date:   Thu Jan 2 14:07:15 2025 +0000

    pipe_read: don't wake up the writer if the pipe is still full

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b6b19b980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16b6b19b980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12b6b19b980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com
Fixes: aaec5a95d596 ("pipe_read: don't wake up the writer if the pipe is still full")

INFO: task syz-executor309:5842 blocked for more than 143 seconds.
      Not tainted 6.14.0-rc7-syzkaller-00050-gfc444ada1310 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor309 state:D stack:24944 pid:5842  tgid:5842  ppid:5838   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0xf43/0x5890 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6857
 bit_wait+0x15/0xe0 kernel/sched/wait_bit.c:237
 __wait_on_bit+0x62/0x180 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0xda/0x110 kernel/sched/wait_bit.c:64
 wait_on_bit include/linux/wait_bit.h:77 [inline]
 netfs_unbuffered_write_iter_locked+0xaa1/0xd30 fs/netfs/direct_write.c:108
 netfs_unbuffered_write_iter+0x413/0x6d0 fs/netfs/direct_write.c:195
 v9fs_file_write_iter+0xbf/0x100 fs/9p/vfs_file.c:404
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff138d69f79
RSP: 002b:00007ffe82a84918 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007ff138d69f79
RDX: 0000000000007fec RSI: 0000400000000540 RDI: 0000000000000007
RBP: 0000400000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 0000400000000280
R13: 00007ff138db304e R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e1bd140 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e1bd140 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e1bd140 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6746
2 locks held by kworker/u8:3/58:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3213
 #1: ffffc9000123fd18 ((work_completion)(&rreq->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3214
2 locks held by getty/5585:
 #0: ffff88803117c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
2 locks held by syz-executor309/5842:
 #0: ffff888030b1a420 (sb_writers#10){.+.+}-{0:0}, at: ksys_write+0x12b/0x250 fs/read_write.c:731
 #1: ffff88807ae98148 (&sb->s_type->i_mutex_key#15){++++}-{4:4}, at: netfs_start_io_direct+0x116/0x260 fs/netfs/locking.c:188

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.14.0-rc7-syzkaller-00050-gfc444ada1310 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:236 [inline]
 watchdog+0xf62/0x12b0 kernel/hung_task.c:399
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:111


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

