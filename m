Return-Path: <linux-fsdevel+bounces-18663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A208BB1D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 19:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996D5287E2C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 17:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BFC1581EB;
	Fri,  3 May 2024 17:32:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6C5157E86
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757561; cv=none; b=no9ydHsoF3sdnz0hXgRT69sf9cE+oV7bx0U8LiaX5TwtBTnr6joAUmie5L1cN0duLIFi4lBOPXAzhxsMdM+D1R+BmgNsK57rCp2Vbpq2pzbaW1efnn7/vqzKEYWfRE7M76aQST+6Nq2/JUMQxXttnxnRULrFFSOpYY6K1fMpNm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757561; c=relaxed/simple;
	bh=dVYEm0hHRWJuQDzyhrR26MDHhJDdDLnZW8nfjNm8Fzc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rhMgyIiuf5vnEjtGqYckM/aMUx8D0upX9I5nWzfZB8rZyRhHnkMgupxiXhVjNk+1I6bP97Nonkmv53lkCU+HzvPyXD6NjobXieZyyYx1CzODkaHOphnHPICNcy0IaDKEybJKJI2oyeX0FSrDuJUVyy+ri6b31BQBOBVelvT+OCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7decb47ceebso654858439f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 10:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714757559; x=1715362359;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PaBujB/M/JeYRrKl4YGWAOx8sWeverl2PICTy/te8Ew=;
        b=hjzVYlO7wab2ejPMTBeOIUsNMd5kv1cIblqD08zZBegr06hn+Zl5jYfTxBd8s4lBIj
         liqCXjxT8wN/SJH7i5yoju0sD/Ko5qI6GcLy+993ijp4a0mVPcQCqDbU54HKc4FjHxGU
         kzM9IuKhLdwwRiBgECZnsL43i6f6Drc7VvqdddpS6z80ss7eU6z0ifjGWixcN4+N+w+F
         U6eSdnDrTGk15VF7BNo9lrwpl8M8biTyIXv5cSaeCDJ7v3/jzsZaMntsInb/VkRdHmzW
         YGLxACYe2aNcaCN32x8yK+rDRt0SP/i3WDST7zamyyhMzrNVQ7Q5chlU1lF6T7ndq9qp
         UpCg==
X-Forwarded-Encrypted: i=1; AJvYcCXgQvdEdTGsUH/h3mEzfsYISQKFWXr4/lbhZx0firTiwaqiew8WtwSJaU9zw6rexKoVUNHsiSKWVrgjqADsdWL7734kP4z++zeoyPqZAA==
X-Gm-Message-State: AOJu0Yx95zIGxQaGkhNFOWxVnbB+YfQbdSRSs/yeJABrtiuNW4VQ7kdc
	NiGRckW5P3dolc9lDSxrxuxMU55kc4riXhFN7v3K+0l3R3BKM+YvaPR/wEFUdeWfy+WkYFd/ke+
	aZxNzZvZKHUMQd1gP1QK8onBHdv8+zX+qtbxlLhXYAFC+TbU3Tq03JOA=
X-Google-Smtp-Source: AGHT+IGEagBeVl/Vf/uyy1rm/tGpmJdGFKGs+H0Qm2oWn5GNEedHW27t6/dgtynox9mqvH84JW3/5edHV2wbH6sytTEZL3QgjWKx
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4387:b0:487:591e:6df3 with SMTP id
 bo7-20020a056638438700b00487591e6df3mr116262jab.2.1714757559544; Fri, 03 May
 2024 10:32:39 -0700 (PDT)
Date: Fri, 03 May 2024 10:32:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000367c770617901bba@google.com>
Subject: [syzbot] [bcachefs?] INFO: task hung in __closure_sync
From: syzbot <syzbot+7bf808f7fe4a6549f36e@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f03359bca01b Merge tag 'for-6.9-rc6-tag' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1298e660980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=7bf808f7fe4a6549f36e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a7c31f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16109450980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e3ee5200440e/disk-f03359bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c651e70b4ae3/vmlinux-f03359bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/196f43b316ad/bzImage-f03359bc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/883314a64ffe/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7bf808f7fe4a6549f36e@syzkaller.appspotmail.com

INFO: task syz-executor334:5078 blocked for more than 143 seconds.
      Not tainted 6.9.0-rc6-syzkaller-00131-gf03359bca01b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor334 state:D stack:15856 pid:5078  tgid:5078  ppid:5075   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1796/0x4a00 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6838
 __closure_sync+0x259/0x2f0 lib/closure.c:135
 closure_sync include/linux/closure.h:194 [inline]
 __bch2_write+0x5458/0x5bd0 fs/bcachefs/io_write.c:1486
 bch2_write+0x947/0x1590 fs/bcachefs/io_write.c:1610
 closure_queue include/linux/closure.h:257 [inline]
 closure_call include/linux/closure.h:390 [inline]
 bch2_dio_write_loop fs/bcachefs/fs-io-direct.c:531 [inline]
 bch2_direct_write+0x1a52/0x3050 fs/bcachefs/fs-io-direct.c:652
 bch2_write_iter+0x206/0x2840 fs/bcachefs/fs-io-buffered.c:1143
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa84/0xcb0 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f42713dfdf9
RSP: 002b:00007ffdf34d9c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f42713dfdf9
RDX: 00000000175d9003 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000555500000000 R09: 0000555500000000
R10: 0000555500000000 R11: 0000000000000246 R12: 00000000000f4240
R13: 00007ffdf34d9ec8 R14: 0000000000000001 R15: 00007ffdf34d9c90
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8e334da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e334da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e334da0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
1 lock held by kworker/u8:3/50:
 #0: ffff8880b953e658 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
2 locks held by getty/4827:
 #0: ffff88802aba90a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
2 locks held by syz-executor334/5078:
 #0: ffff8880730de420 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2855 [inline]
 #0: ffff8880730de420 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x233/0xcb0 fs/read_write.c:586
 #1: ffff8880779f88b8 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:795 [inline]
 #1: ffff8880779f88b8 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}, at: bch2_direct_write+0x243/0x3050 fs/bcachefs/fs-io-direct.c:598

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.9.0-rc6-syzkaller-00131-gf03359bca01b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:380
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:112


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

