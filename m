Return-Path: <linux-fsdevel+bounces-46999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F93A97542
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 21:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2FD3B59F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 19:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362872980D5;
	Tue, 22 Apr 2025 19:17:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C0D1DDA1E
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745349453; cv=none; b=uQIQ3XjzVs9wcloU/N5N14WqKtWVzyKvdMT1SGw1C8XeyogdZU+EPU7qDYJ1JYJftQZ2VHoLZvSjF5L8WaNmjx7Cdlb7T7CcOr7Ne+34HofnoXA4bQ/oCbkntYFW4hvPRoA1lAJsWLSJSIC0UNU+H7LeV6X8ybQiqdreXXNyrjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745349453; c=relaxed/simple;
	bh=pnHd2Ycif+rX3H6FenVUfl3wWZDJjQd9f8Z2kbG9kdw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oXX24f3b+bCGkXThac9lbkAOGJN0m5JVX4FmSeo2wkCZsywpp6WAaK32ARlpCsA2bCiuTN4J1fZRf9KbzpVtc7VkGiBgEV5dc695QKfW/eWI9lXOHRzhl9tr1EdiMCJT10rn05FDo9OiLXrHfOQ1fNsvzX3N1kGkgggFOWYttPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d8fc035433so72309375ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 12:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745349451; x=1745954251;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cyBDm2ZYj7cLn5Omsf047ecfidS0I0AxTIw8zpsgTPg=;
        b=DvMbdY6zYxtlzkygNXbwI7us3+DB9WOAAYUX9COoltNeIjygtV261152zlaQxKniQI
         XVjmp1DvTlEbPkIj3AxZ8VkHP2vSfmBhB4sC0bhAk1iAIH5dHVpDNZDmGTu9n0ILkcmI
         CnMomxXkSR7QG477lipXvmJidHo/YW2ssQsyIEphJO5kXxSSTIZnrBKhy5lQGKyRy1w7
         0p1CI+D4iiDo1kw8lEsJAa8kzA9sePCYBGwc44VU2LnCXFLomNF4PYj5IRq/mmxQ+1sB
         4parIa9G2tLLueITx6RLje8DtbLY2rURaaYgd4fIkSXbZp2thOL/ngKbS5c4EysTtpQ7
         Tagg==
X-Forwarded-Encrypted: i=1; AJvYcCWZU+X1td9y42os33JgxrzG/pLKkHkVu3lPzGzx7LYDGJivJ7ycfxGHdO/YK/GHY6wH+iPOpmr96Gyx502h@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2aIG7Zy2D5nhX4N7PfF+cArjjjFRr3lkZdY7rTBSO45GuAzD
	mHO9SYlGs0WqGU4EeNBVQ5qe4/bAIq4cqubEuC2q+u3kQWBxZBzuMF2paaopWqN3/Uzs8iQZ52Z
	bgyCWjL5ZhWTsaw+a18Yo3FpU4sJmw42lBCMQNnJLkHPxmZAFxseQUdA=
X-Google-Smtp-Source: AGHT+IHC1m62G5guSqyDDO0R9CXlhrXtqBEjq7z/HZTO5pgxQKAgDn5jhDJDMLKUWRQQ8rdAk2H7HuEK0FyOsX2khGMYyNeUpJvA
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:240a:b0:3d3:d00c:3602 with SMTP id
 e9e14a558f8ab-3d88edfb6e6mr180204625ab.10.1745349450982; Tue, 22 Apr 2025
 12:17:30 -0700 (PDT)
Date: Tue, 22 Apr 2025 12:17:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6807eb4a.050a0220.36a438.0000.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] INFO: task hung in page_cache_ra_order
From: syzbot <syzbot+f719dec20853d1563edc@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, arnd@arndb.de, hch@lst.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, thuth@redhat.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc96b232f8e7 Merge tag 'pci-v6.15-fixes-2' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=146337cf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a31f7155996562
dashboard link: https://syzkaller.appspot.com/bug?extid=f719dec20853d1563edc
compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f9d470580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17125fe4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c90d59ce6487/disk-fc96b232.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/78fd0e48c804/vmlinux-fc96b232.xz
kernel image: https://storage.googleapis.com/syzbot-assets/58353c4d5ca1/bzImage-fc96b232.xz

The issue was bisected to:

commit 3e25d5a49f99b75be2c6cfb165e4f77dc6d739a2
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Oct 23 05:36:37 2024 +0000

    asm-generic: add an optional pfn_valid check to page_to_phys

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166cb4cc580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=156cb4cc580000
console output: https://syzkaller.appspot.com/x/log.txt?x=116cb4cc580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f719dec20853d1563edc@syzkaller.appspotmail.com
Fixes: 3e25d5a49f99 ("asm-generic: add an optional pfn_valid check to page_to_phys")

INFO: task syz-executor690:5861 blocked for more than 143 seconds.
      Not tainted 6.15.0-rc2-syzkaller-00278-gfc96b232f8e7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor690 state:D stack:23400 pid:5861  tgid:5860  ppid:5859   task_flags:0x440040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1b88/0x5240 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x163/0x360 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 rwsem_down_read_slowpath kernel/locking/rwsem.c:1084 [inline]
 __down_read_common kernel/locking/rwsem.c:1248 [inline]
 __down_read kernel/locking/rwsem.c:1261 [inline]
 down_read+0x6ff/0xa50 kernel/locking/rwsem.c:1526
 filemap_invalidate_lock_shared include/linux/fs.h:922 [inline]
 page_cache_ra_order+0x45e/0xca0 mm/readahead.c:491
 filemap_readahead mm/filemap.c:2560 [inline]
 filemap_get_pages+0x9ec/0x1fc0 mm/filemap.c:2605
 filemap_splice_read+0x690/0xef0 mm/filemap.c:2981
 do_splice_read fs/splice.c:979 [inline]
 splice_direct_to_actor+0x4af/0xc90 fs/splice.c:1083
 do_splice_direct_actor fs/splice.c:1201 [inline]
 do_splice_direct+0x281/0x3d0 fs/splice.c:1227
 do_sendfile+0x582/0x8c0 fs/read_write.c:1368
 __do_sys_sendfile64 fs/read_write.c:1429 [inline]
 __se_sys_sendfile64+0x17e/0x1e0 fs/read_write.c:1415
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8463035369
RSP: 002b:00007f8462fee228 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f84630bf328 RCX: 00007f8463035369
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 00007f84630bf320 R08: 00007f8462fee6c0 R09: 00007f8462fee6c0
R10: 000400000000003f R11: 0000000000000246 R12: 00007f84630bf32c
R13: 0000200000001000 R14: 6c756e2f7665642f R15: 00007ffd91caffd8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x30/0x180 kernel/locking/lockdep.c:6764
1 lock held by klogd/5202:
2 locks held by getty/5601:
 #0: ffff8880346d00a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x5bb/0x1700 drivers/tty/n_tty.c:2222
1 lock held by syz-executor690/5861:
 #0: ffff88802395b740 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:922 [inline]
 #0: ffff88802395b740 (mapping.invalidate_lock#2){++++}-{4:4}, at: page_cache_ra_order+0x45e/0xca0 mm/readahead.c:491
3 locks held by syz-executor690/5862:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.15.0-rc2-syzkaller-00278-gfc96b232f8e7 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x4ab/0x4e0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:274 [inline]
 watchdog+0x1058/0x10a0 kernel/hung_task.c:437
 kthread+0x7b7/0x940 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5862 Comm: syz-executor690 Not tainted 6.15.0-rc2-syzkaller-00278-gfc96b232f8e7 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:lockdep_enabled kernel/locking/lockdep.c:124 [inline]
RIP: 0010:lock_acquire+0xae/0x2f0 kernel/locking/lockdep.c:5842
Code: e8 97 67 8e 00 83 3d f0 ae c1 0e 00 0f 84 ef 00 00 00 65 8b 05 c3 35 ca 11 85 c0 0f 85 e0 00 00 00 65 48 8b 04 25 08 60 68 93 <83> b8 ec 0a 00 00 00 0f 85 ca 00 00 00 48 c7 44 24 10 00 00 00 00
RSP: 0018:ffffc9000408ee68 EFLAGS: 00000246
RAX: ffff8880782ada00 RBX: ffffffff8ed3df20 RCX: 0000000000000002
RDX: 0000000000000000 RSI: ffffffff816d9be5 RDI: 1ffffffff1da7be4
RBP: ffffffff93686020 R08: 0000000000000000 R09: 0000000000000000
R10: ffffc9000408f020 R11: fffff52000811e10 R12: 0000000000000000
R13: 0000000000000002 R14: ffffffff816dc508 R15: 0000000000000000
FS:  00007f8462fcd6c0(0000) GS:ffff88812509a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005606e6d75600 CR3: 000000002f6f0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:841 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1155 [inline]
 unwind_next_frame+0xd5/0x23b0 arch/x86/kernel/unwind_orc.c:479
 __unwind_start+0x59a/0x740 arch/x86/kernel/unwind_orc.c:758
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xe7/0x150 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x11a/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4161 [inline]
 slab_alloc_node mm/slub.c:4210 [inline]
 kmem_cache_alloc_noprof+0x1e1/0x390 mm/slub.c:4217
 mempool_alloc_noprof+0x199/0x5a0 mm/mempool.c:402
 bio_alloc_bioset+0x26f/0x1130 block/bio.c:554
 bio_alloc_clone block/bio.c:864 [inline]
 bio_split+0x107/0x490 block/bio.c:1587
 bio_submit_split+0x98/0x600 block/blk-merge.c:116
 __bio_split_to_limits block/blk.h:390 [inline]
 blk_mq_submit_bio+0x18a6/0x25e0 block/blk-mq.c:3110
 __submit_bio+0x1d2/0x6d0 block/blk-core.c:635
 __submit_bio_noacct_mq block/blk-core.c:722 [inline]
 submit_bio_noacct_nocheck+0x57b/0xe30 block/blk-core.c:751
 bio_chain_and_submit+0xed/0x130 block/bio.c:361
 __blkdev_issue_zero_pages+0x218/0x290 block/blk-lib.c:222
 blkdev_issue_zero_pages block/blk-lib.c:238 [inline]
 blkdev_issue_zeroout+0x651/0x880 block/blk-lib.c:325
 blkdev_fallocate+0x3dd/0x490 block/fops.c:-1
 vfs_fallocate+0x627/0x7a0 fs/open.c:338
 ksys_fallocate fs/open.c:362 [inline]
 __do_sys_fallocate fs/open.c:367 [inline]
 __se_sys_fallocate fs/open.c:365 [inline]
 __x64_sys_fallocate+0xbc/0x110 fs/open.c:365
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8463035369
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8462fcd228 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f84630bf338 RCX: 00007f8463035369
RDX: 0000000008000000 RSI: 0000000000000011 RDI: 0000000000000004
RBP: 00007f84630bf330 R08: 00007f8462fcd6c0 R09: 00007f8462fcd6c0
R10: 0008004000000200 R11: 0000000000000246 R12: 00007f84630bf33c
R13: 0000200000001000 R14: 6c756e2f7665642f R15: 00007ffd91caffd8
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.578 msecs


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

