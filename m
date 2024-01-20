Return-Path: <linux-fsdevel+bounces-8356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C60383350C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 15:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719681C20F6D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087D0FC10;
	Sat, 20 Jan 2024 14:40:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F67FBEF
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jan 2024 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705761621; cv=none; b=doWRYOF2fQ8M4v8z6XzXBcVHtTbJsyiE7GqkPclaL1e1j24sgj2nEa7T34Bb2FDTXPySSZID4GQQIneoG9/7DQSIfjCrGDGNlp926h3lc2X8VFn57mccaVsqERVg6ycLBLQdDyKO2oLuPH/96z3NREtbmuvHws9RbnmfUE83f9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705761621; c=relaxed/simple;
	bh=Uyq7eNazO+/HXUlmG1l8rdo8GXksmV0R15KNsiFDKw0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VDzgDRbQBbsjLG90DtzPvTlXtjCFmA/Q9iQ8xHFVeWrlqlmsX7UjvazMYmanqqO8P3QrOMKOmHkkyR0BwoHe8y8KwcJJnNXggfQLy1Dlcpc4N0ZnceB+Q4O6P9EwzPDsjFfTr3ofFNMhdJ8TCFVNRP/gtE8NvW55L63u6c5/dhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-361a9198bffso7776865ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jan 2024 06:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705761619; x=1706366419;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NgBjWecrYA4bUSZJoLAg/vkOwGF5pwa5aEOhJfOJ/Ns=;
        b=cQI5UG6CITEikAaDsM7itkQ2rFxxJcWfKCogpKwbmoKNG2PN0gBvb8aSS8jT9U0w8h
         8E6F6CFUD4WDMqjnTUDQDFCyIcKJvw+vPTpbC3Sm6aXb7oZkainZZyIvou4PI4NvD37M
         aYu7HKGu3HkZ74vnwLHBsYtCYl3OtQn6/P9Vh0uWYgOSgtqASKuRuFWYluH5bSao61do
         YxGU8Tlsl8M/nwk6jgQVF7PdgXNRjpS2EIaftgsUCF3Kg30ZKaP4XwUOqLYL7PtqplGN
         wkLMJmhjEE7aFx2JjW6hwZxIcVlmZslxiS2pf5/AtNLNz6ltLLGxBoBjny/9RewXCxN0
         lC3w==
X-Gm-Message-State: AOJu0YxlhxPJRBF1BoFRwxU7Gqsdfhq1JkkLTHiPTddGRftFp+f2YJeB
	PnyNcW6QkaYht3rv98zpHvK/4ztuUuW9/MVr+QOXnp8pZ028cKNxR/5Y9cGIwaH0f0gznWHy2yf
	JodQeyOTTbjXngSXlqVfxFYfe6TY6SbOZIejx7Y8YY2T+/+bcEdym6bXxHA==
X-Google-Smtp-Source: AGHT+IEntCObEgCxL7B/uuh8e89mfoBB6f+uVdFjjv/epL+T0ctV5Aw3FxwyywXSK25SfgQtAf/6oecKgIIPHQACrUVJbghSwa8b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c5c3:0:b0:361:a99f:bb1c with SMTP id
 s3-20020a92c5c3000000b00361a99fbb1cmr100338ilt.0.1705761619263; Sat, 20 Jan
 2024 06:40:19 -0800 (PST)
Date: Sat, 20 Jan 2024 06:40:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006347db060f619341@google.com>
Subject: [syzbot] [hfs?] INFO: task hung in hfs_find_init (2)
From: syzbot <syzbot+37463f2a5b94a8fdabec@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13cf2debe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c8840a4a09eab8
dashboard link: https://syzkaller.appspot.com/bug?extid=37463f2a5b94a8fdabec
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151791f5e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1569e90be80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b1b0ffd73481/disk-052d5343.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c25614b900ba/vmlinux-052d5343.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7dd1842e2ad4/bzImage-052d5343.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6d0508568ec7/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+37463f2a5b94a8fdabec@syzkaller.appspotmail.com

INFO: task kworker/u4:1:12 blocked for more than 143 seconds.
      Not tainted 6.7.0-syzkaller-09928-g052d534373b7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:1    state:D stack:23968 pid:12    tgid:12    ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 hfs_find_init+0x17f/0x220 fs/hfs/bfind.c:33
 hfs_ext_write_extent+0x18e/0x1f0 fs/hfs/extent.c:141
 hfs_write_inode+0xc4/0x9f0 fs/hfs/inode.c:427
 write_inode fs/fs-writeback.c:1473 [inline]
 __writeback_single_inode+0xa91/0xe90 fs/fs-writeback.c:1690
 writeback_sb_inodes+0x599/0x1080 fs/fs-writeback.c:1916
 __writeback_inodes_wb+0xff/0x2d0 fs/fs-writeback.c:1987
 wb_writeback+0x7f8/0xaa0 fs/fs-writeback.c:2094
 wb_check_background_flush fs/fs-writeback.c:2164 [inline]
 wb_do_writeback fs/fs-writeback.c:2252 [inline]
 wb_workfn+0x87c/0xfe0 fs/fs-writeback.c:2279
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: task syz-executor755:5051 blocked for more than 143 seconds.
      Not tainted 6.7.0-syzkaller-09928-g052d534373b7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor755 state:D stack:26976 pid:5051  tgid:5051  ppid:5049   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 hfs_find_init+0x17f/0x220 fs/hfs/bfind.c:33
 hfs_ext_read_extent+0x19c/0x9d0 fs/hfs/extent.c:200
 hfs_extend_file+0x4e0/0xb10 fs/hfs/extent.c:401
 hfs_bmap_reserve+0x29c/0x370 fs/hfs/btree.c:234
 __hfs_ext_write_extent+0x3cb/0x520 fs/hfs/extent.c:121
 __hfs_ext_cache_extent fs/hfs/extent.c:174 [inline]
 hfs_ext_read_extent+0x805/0x9d0 fs/hfs/extent.c:202
 hfs_extend_file+0x4e0/0xb10 fs/hfs/extent.c:401
 hfs_get_block+0x17f/0x820 fs/hfs/extent.c:353
 __block_write_begin_int+0x4fb/0x16e0 fs/buffer.c:2103
 __block_write_begin fs/buffer.c:2152 [inline]
 block_write_begin+0xb1/0x490 fs/buffer.c:2211
 cont_write_begin+0x530/0x730 fs/buffer.c:2565
 hfs_write_begin+0x87/0x140 fs/hfs/inode.c:53
 generic_perform_write+0x278/0x600 mm/filemap.c:3928
 __generic_file_write_iter+0x1f9/0x240 mm/filemap.c:4023
 generic_file_write_iter+0xe3/0x350 mm/filemap.c:4049
 call_write_iter include/linux/fs.h:2085 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x64f/0xdf0 fs/read_write.c:590
 ksys_write+0x12f/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f9a72ed2a59
RSP: 002b:00007ffcc7d3ea78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9a72ed2a59
RDX: 000000000208e24b RSI: 0000000020000180 RDI: 0000000000000004
RBP: 00007f9a72f465f0 R08: 0000555555d2b4c0 R09: 0000555555d2b4c0
R10: 00000000000002ba R11: 0000000000000246 R12: 00007ffcc7d3eaa0
R13: 00007ffcc7d3ecc8 R14: 431bde82d7b634db R15: 00007f9a72f1b03b
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.7.0-syzkaller-09928-g052d534373b7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf87/0x1210 kernel/hung_task.c:379
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.7.0-syzkaller-09928-g052d534373b7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:200
Code: c6 71 e0 02 66 0f 1f 44 00 00 f3 0f 1e fa 48 8b be b0 01 00 00 e8 b0 ff ff ff 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 <f3> 0f 1e fa 65 48 8b 14 25 40 c2 03 00 65 8b 05 e4 c8 7c 7e a9 00
RSP: 0018:ffffc900001079a0 EFLAGS: 00000006
RAX: 0000000000000000 RBX: 0000000000000200 RCX: ffffffff812fe3af
RDX: ffff888015693b80 RSI: 0000000000000000 RDI: 0000000000000007
RBP: ffffffff81d45d23 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000200 R11: 0000000000000000 R12: 0000000000000d27
R13: 0000000000000003 R14: ffffffff8d320100 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007feace266b90 CR3: 000000000cf79000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __text_poke+0x8d2/0xca0 arch/x86/kernel/alternative.c:1961
 text_poke_bp_batch+0x3e0/0x750 arch/x86/kernel/alternative.c:2319
 text_poke_flush arch/x86/kernel/alternative.c:2488 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2485 [inline]
 text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2495
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x1d7/0x400 kernel/jump_label.c:829
 static_key_disable_cpuslocked+0x154/0x1c0 kernel/jump_label.c:235
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate mm/kfence/core.c:831 [inline]
 toggle_allocation_gate+0x13f/0x250 mm/kfence/core.c:818
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.570 msecs


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

