Return-Path: <linux-fsdevel+bounces-56526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8B5B186C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 19:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F35566846
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7990428CF58;
	Fri,  1 Aug 2025 17:38:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A5119C556
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069922; cv=none; b=DgUU3Fo4DUVe2pX7WbShfjRWpF7vwmELAEFTQ2uHyAkcQ8xCTv11uopvlYqsItyFOVWXHmvfOJTB8tfLsrTRoxTcOuP16Blu23OAmq2KEUH5GdnNgqwwTsf9TaL+eR25W9H493ic/ELNzD5izykRREtyaL1Xx4DhTsW4OARK0RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069922; c=relaxed/simple;
	bh=2W1rcozhKyT/eJtvyet4sQjLkvad9Gnv1dzDOUDYB3I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bYWTcPPACVEMk5IiJPBIANk7Em5YM6vACwRfau0t2MSujaf2cv5GUQHT80YxPOKcBDnzBKec8f7JNfxQM6BqrBYJivepYGHAB3aLcxbvb8xRCxixlhVq/R/DTFSijkoZuDrN97jyYVa0qBniZt5dEu52ArQ/StqirtEgKQE3Btg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3e3c78b5192so34032135ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Aug 2025 10:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754069917; x=1754674717;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZkksdtlo6oEnxgG9PkLGlnNp4AsmDgbjYiK41mFU1w=;
        b=p6iMk6lQZ0TH/sbSPp+gzeHZICq+0rxGDbjirLBRm/gnqYXFYjMS8pRQZ0QC/nisja
         7V3HsuQVXtbKhE/6702wCieZntTfORevhR+1ygGedcR5tCOhvtd1Xp9n89Q2bfDP2lZH
         DDpHJoHAsnx8F5+MpmxBrSG0zKKUtEaP4D5QnYEBbh/kvi+73N3gxfIYYGshy7d8WQgk
         8rI0XVn6Q1KyvQ5HXt2K1ySQTiB9H6MA5ofi2jPkN374rd4qbnkyxXZul16qzsrNtTzi
         eSwWXBksgmYrNugQJn0pBpmeZSdIR2QVTtaaVOiW1XYAJAmrIyES7lWTsSoA8GF1LtKf
         IiBA==
X-Forwarded-Encrypted: i=1; AJvYcCX8TCcSNuycZiTMG60SI/b8b/DLS6dqoHrq21f/qIeuz+zxERfJ4CwK8HALv+UfbbXc/VZt2AN/KkfhdB9x@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr1ZwzaLHTWE6f6U0/+ra6rWK0Ou2YoPEROZcauy42S5amnr75
	mdtvX4PsLpqKt2l6C0m3AJLPcijsg9Xepk1e0o9CAjeAB+ETHKnGAzKS2v05vbgJiyczPtUpTIo
	h/KclCWWkwHy0MWhvduUrMtfgCzBYSzaPXKEiAXMVmn3uIZP0QP7vY3M9pgA=
X-Google-Smtp-Source: AGHT+IGpqjvcRrrrv3bLRpoLAqttMGP2kYB4MOE6sykpWaQJ3fKQ1BGnbInS6T/T3Vmhh+O+Wyvtt+DLx0ZYugmkulmf3qgwkn6f
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2601:b0:3e3:d968:bb49 with SMTP id
 e9e14a558f8ab-3e41610a4d7mr7565625ab.1.1754069917442; Fri, 01 Aug 2025
 10:38:37 -0700 (PDT)
Date: Fri, 01 Aug 2025 10:38:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688cfb9d.050a0220.f0410.012e.GAE@google.com>
Subject: [syzbot] [hfs?] INFO: task hung in hfsplus_find_init (3)
From: syzbot <syzbot+6f9eae7d87e0afb22029@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f2d282e1dfb3 Merge tag 'bitmap-for-6.17' of https://github..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=144faf82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b51b56c81c0761d
dashboard link: https://syzkaller.appspot.com/bug?extid=6f9eae7d87e0afb22029
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124faf82580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100642a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/70f09e088d5c/disk-f2d282e1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9baa408863b9/vmlinux-f2d282e1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/36063ac42323/bzImage-f2d282e1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7fea0d017f73/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f9eae7d87e0afb22029@syzkaller.appspotmail.com

INFO: task kworker/u8:3:49 blocked for more than 143 seconds.
      Not tainted 6.16.0-syzkaller-10355-gf2d282e1dfb3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:3    state:D
 stack:21000 pid:49    tgid:49    ppid:2      task_flags:0x4208160 flags:0x00004000
Workqueue: writeback wb_workfn
 (flush-7:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x7e3/0x1340 kernel/locking/mutex.c:760
 hfsplus_find_init+0x15a/0x1d0 fs/hfsplus/bfind.c:28
 hfsplus_cat_write_inode+0x1e6/0x7a0 fs/hfsplus/inode.c:592
 write_inode fs/fs-writeback.c:1525 [inline]
 __writeback_single_inode+0x6f1/0xff0 fs/fs-writeback.c:1745
 writeback_sb_inodes+0x6c7/0x1010 fs/fs-writeback.c:1976
 __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2047
 wb_writeback+0x44f/0xaf0 fs/fs-writeback.c:2158
 wb_check_old_data_flush fs/fs-writeback.c:2262 [inline]
 wb_do_writeback fs/fs-writeback.c:2315 [inline]
 wb_workfn+0xaef/0xef0 fs/fs-writeback.c:2343
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e139e60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e139e60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e139e60 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
4 locks held by kworker/u8:3/49:
 #0: ffff8881412ee948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff8881412ee948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc90000b97bc0 (
(work_completion)(&(&wb->dwork)->work)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3212 [inline]
, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffff8880332b00e0
 (
&type->s_umount_key
#42
){.+.+}-{4:4}
, at: super_trylock_shared+0x20/0xf0 fs/super.c:563
 #3: 
ffff8880792320b0
 (
&tree->tree_lock){+.+.}-{4:4}, at: hfsplus_find_init+0x15a/0x1d0 fs/hfsplus/bfind.c:28
5 locks held by kworker/u8:4/61:
 #0: 
ffff8880b8739f58
 (
&rq->__lock
){-.-.}-{2:2}
, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:636
 #1: 
ffff8880b8724008
 (
per_cpu_ptr(&psi_seq, cpu)){-.-.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
per_cpu_ptr(&psi_seq, cpu)){-.-.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffffffff8dfd2f50 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_disable+0x12/0x20 kernel/jump_label.c:247
 #3: ffffffff99c6aca8 (
&obj_hash[i].lock
){-.-.}-{2:2}
, at: debug_object_activate+0xbb/0x420 lib/debugobjects.c:818
 #4: 
ffffffff8dfe6308
 (
text_mutex
){+.+.}-{4:4}
, at: arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_label.c:145
2 locks held by getty/5605:
 #0: 
ffff88803031a0a0
 (
&tty->ldisc_sem
){++++}-{0:0}
, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: 
ffffc900036c32f0
 (
&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
4 locks held by syz-executor384/5873:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.16.0-syzkaller-10355-gf2d282e1dfb3 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:307 [inline]
 watchdog+0xf93/0xfe0 kernel/hung_task.c:470
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5873 Comm: syz-executor384 Not tainted 6.16.0-syzkaller-10355-gf2d282e1dfb3 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:kasan_check_range+0xd/0x2c0 mm/kasan/generic.c:188
Code: 0f 0b cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 55 41 57 41 56 41 55 41 54 <53> b0 01 48 85 f6 0f 84 ba 01 00 00 4c 8d 04 37 49 39 f8 0f 82 82
RSP: 0018:ffffc9000414eb30 EFLAGS: 00000056
RAX: 00000000ffffff01 RBX: ffffffff99dbe400 RCX: ffffffff819df6c1
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffc9000414eba0
RBP: ffffc9000414ec10 R08: ffffffff99dbe403 R09: 1ffffffff33b7c80
R10: dffffc0000000000 R11: fffffbfff33b7c81 R12: ffffffff99dbe410
R13: ffffffff99dbe408 R14: 1ffffffff33b7c82 R15: 1ffffffff33b7c81
FS:  0000555574d53380(0000) GS:ffff888125d5c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcbbc35f19 CR3: 00000000714b1000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1301 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
 do_raw_spin_lock+0x121/0x290 kernel/locking/spinlock_debug.c:116
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0xb3/0xf0 kernel/locking/spinlock.c:162
 uart_port_lock_irqsave include/linux/serial_core.h:717 [inline]
 serial8250_console_write+0x17e/0x1ba0 drivers/tty/serial/8250/8250_port.c:3355
 console_emit_next_record kernel/printk/printk.c:3138 [inline]
 console_flush_all+0x728/0xc40 kernel/printk/printk.c:3226
 __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
 console_unlock+0xc4/0x270 kernel/printk/printk.c:3325
 vprintk_emit+0x5b7/0x7a0 kernel/printk/printk.c:2450
 _printk+0xcf/0x120 kernel/printk/printk.c:2475
 hfsplus_bnode_read_u16 fs/hfsplus/bnode.c:101 [inline]
 hfsplus_bnode_dump+0x322/0x450 fs/hfsplus/bnode.c:403
 hfsplus_brec_remove+0x480/0x550 fs/hfsplus/brec.c:229
 __hfsplus_delete_attr+0x1d4/0x360 fs/hfsplus/attributes.c:299
 hfsplus_delete_attr+0x231/0x2d0 fs/hfsplus/attributes.c:345
 hfsplus_removexattr fs/hfsplus/xattr.c:796 [inline]
 __hfsplus_setxattr+0x768/0x1fe0 fs/hfsplus/xattr.c:279
 hfsplus_setxattr+0x11e/0x180 fs/hfsplus/xattr.c:436
 hfsplus_user_setxattr+0x40/0x60 fs/hfsplus/xattr_user.c:30
 __vfs_removexattr+0x431/0x470 fs/xattr.c:518
 __vfs_removexattr_locked+0x1ed/0x230 fs/xattr.c:553
 vfs_removexattr+0x80/0x1b0 fs/xattr.c:575
 removexattr fs/xattr.c:1023 [inline]
 filename_removexattr fs/xattr.c:1052 [inline]
 path_removexattrat+0x35d/0x690 fs/xattr.c:1088
 __do_sys_removexattr fs/xattr.c:1100 [inline]
 __se_sys_removexattr fs/xattr.c:1097 [inline]
 __x64_sys_removexattr+0x62/0x70 fs/xattr.c:1097
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd613ef9bd9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff6590fb28 EFLAGS: 00000246 ORIG_RAX: 00000000000000c5
RAX: ffffffffffffffda RBX: 0000200000000340 RCX: 00007fd613ef9bd9
RDX: ffffffffffffffb8 RSI: 0000200000000080 RDI: 0000200000000040
RBP: 0000200000000380 R08: 0000555574d544c0 R09: 0000555574d544c0
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 00007fff6590fd78 R14: 431bde82d7b634db R15: 0000200000000390
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 3.116 msecs


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

