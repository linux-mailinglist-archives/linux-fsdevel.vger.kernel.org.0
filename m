Return-Path: <linux-fsdevel+bounces-28099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F87966F42
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 06:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77E75B21E27
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 04:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA0B136E37;
	Sat, 31 Aug 2024 04:17:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0F31D12E0
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Aug 2024 04:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725077845; cv=none; b=RPKBPVgY9fm+0Nnby8BAVCB/FwwDD+HHsO5BSDcxclZmM8fcwFL1kOq+bengboS2bdMvROcuLRukrm7OYk5ALGuY4sm5sAztb6h253mSqtiD23jdieiHq6Kd8r42f9l1MPTqf7Bw0BW659AmxDWNi6y0VrAqNmDFcDGS+ZKDjqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725077845; c=relaxed/simple;
	bh=5KPC9uhoB23yMSAtxDSCROiOONSUA7ZuEyL9uRMemg8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=klrUHPkSjJwP7ZSKTUB519RRfOYA1/cyXuyHhccX2RUodaOoVJObQgSB+B8Xy40I/Q5nZAem+Hr5eNSJcdLivviYNbZcNlPgvo2Ujo7FeasTf33yk+K1s3A83l0cmABYNva3J0dNpvL7eIJiILEIFfEkrVTUJRbl4P864KuUHow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d244820edso26622365ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 21:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725077843; x=1725682643;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNcyuBYKcHE0GceQ7W9FBZewdPCgXpzuu5zLUQEQcZM=;
        b=ZuyBq5LGkVAc7EH2sJG1irM3RUCVvipHhSIO43omkx8QxnDHBME1IQvKH8z3Kidxpz
         4keCKi4OHdgeguec7dM3+cznwIKQiOZJhG1VsF53vYv/b+2VDMfgnP9l+AtMZgju1+28
         5s3rzTE/bu/IkLu8lnnqm1p6gKdZk+ftu2IiEswxb7hMwtTGR/lLx9ZH2pS4cwG4SNnd
         LxA8v9rnGBkYO/U2niTOuJsNZCRpZaLK/weU7dTPAZREbasR6y+MCUW4CnUJM6lR+sKq
         ZVAfX9BaU0+sGPdfLhFlW670VOM6o4t4DjBUfWJmBOwQ8QfB/SURcX+JoWlQhVsZNufg
         Z1+A==
X-Forwarded-Encrypted: i=1; AJvYcCWmmaLrW6yjIqwFK7x3U97sRHArO1gymWHh+8LV1gssgRAdH8jKim340VBScX/27bgv3jYKLfnK8vl9/CkD@vger.kernel.org
X-Gm-Message-State: AOJu0YwCzdvku73h2S0kg4UaaZX2J60YIKwu3iwZznqw6phgITV4+95o
	LsFTQwSFoL69CxXyJYg6gta4vi3NbfbNnJbA2i+Sx+KpyyGVJ7ZoqMnzsxcBTDNYz2ZFweggydh
	3C1wAIBvQuW94eHVDkkW0IfjNpg/kTy9i+Gal35KA25HwCTuj7jIbLlM=
X-Google-Smtp-Source: AGHT+IEzBUBP8I5MIPtT4Rs1yfce7TKMIf/Vyrngb3mZRtCK5SsLhzCtOofo2Qsb0puanlBQM6j3oP2pKTtSLQNTghr9OelNMgk2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c87:b0:39d:1144:e784 with SMTP id
 e9e14a558f8ab-39f410741c7mr3084605ab.4.1725077842977; Fri, 30 Aug 2024
 21:17:22 -0700 (PDT)
Date: Fri, 30 Aug 2024 21:17:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a78120620f2fc2b@google.com>
Subject: [syzbot] [netfs?] possible deadlock in lock_mm_and_find_vma (2)
From: syzbot <syzbot+b02bbe0ff80a09a08c1b@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5be63fc19fca Linux 6.11-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d8b247980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f29704545d454ed3
dashboard link: https://syzkaller.appspot.com/bug?extid=b02bbe0ff80a09a08c1b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-5be63fc1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/64065b3c02ed/vmlinux-5be63fc1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aef4258dcb3f/bzImage-5be63fc1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b02bbe0ff80a09a08c1b@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc5-syzkaller #0 Not tainted
------------------------------------------------------
syz.2.1318/10014 is trying to acquire lock:
ffff88802b6b2798 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable include/linux/mmap_lock.h:153 [inline]
ffff88802b6b2798 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:5878 [inline]
ffff88802b6b2798 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x3a9/0x6a0 mm/memory.c:5929

but task is already holding lock:
ffff8880302e8b70 (&ctx->wb_lock){+.+.}-{3:3}, at: netfs_begin_writethrough+0x6c/0x3c0 fs/netfs/write_issue.c:572

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ctx->wb_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       netfs_writepages+0x5e1/0xdd0 fs/netfs/write_issue.c:509
       do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2683
       filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
       filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
       v9fs_mmap_vm_close+0x213/0x260 fs/9p/vfs_file.c:502
       remove_vma+0x8b/0x180 mm/mmap.c:182
       remove_mt mm/mmap.c:2415 [inline]
       do_vmi_align_munmap+0x1272/0x19c0 mm/mmap.c:2758
       do_vmi_munmap+0x231/0x410 mm/mmap.c:2830
       mmap_region+0x17f/0x2760 mm/mmap.c:2881
       do_mmap+0xbfb/0xfb0 mm/mmap.c:1468
       vm_mmap_pgoff+0x1ba/0x360 mm/util.c:588
       ksys_mmap_pgoff+0x332/0x5d0 mm/mmap.c:1514
       __do_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
       __se_sys_mmap arch/x86/kernel/sys_x86_64.c:79 [inline]
       __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:79
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
       lock_acquire kernel/locking/lockdep.c:5759 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
       down_read_killable+0x9d/0x380 kernel/locking/rwsem.c:1549
       mmap_read_lock_killable include/linux/mmap_lock.h:153 [inline]
       get_mmap_lock_carefully mm/memory.c:5878 [inline]
       lock_mm_and_find_vma+0x3a9/0x6a0 mm/memory.c:5929
       do_user_addr_fault+0x2b5/0x13f0 arch/x86/mm/fault.c:1361
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       fault_in_readable+0x126/0x230 mm/gup.c:2244
       fault_in_iov_iter_readable+0x101/0x2c0 lib/iov_iter.c:94
       netfs_perform_write+0x3ef/0x2250 fs/netfs/buffered_write.c:240
       netfs_buffered_write_iter_locked+0x213/0x2c0 fs/netfs/buffered_write.c:470
       netfs_file_write_iter+0x1e0/0x470 fs/netfs/buffered_write.c:509
       v9fs_file_write_iter+0xa1/0x100 fs/9p/vfs_file.c:407
       aio_write+0x3c1/0x8e0 fs/aio.c:1633
       __io_submit_one fs/aio.c:2005 [inline]
       io_submit_one+0x124e/0x1db0 fs/aio.c:2052
       __do_sys_io_submit fs/aio.c:2111 [inline]
       __se_sys_io_submit fs/aio.c:2081 [inline]
       __x64_sys_io_submit+0x19d/0x330 fs/aio.c:2081
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ctx->wb_lock);
                               lock(&mm->mmap_lock);
                               lock(&ctx->wb_lock);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

2 locks held by syz.2.1318/10014:
 #0: ffff8880302e87b8 (&sb->s_type->i_mutex_key#25){++++}-{3:3}, at: netfs_start_io_write+0x1f/0x70 fs/netfs/locking.c:118
 #1: ffff8880302e8b70 (&ctx->wb_lock){+.+.}-{3:3}, at: netfs_begin_writethrough+0x6c/0x3c0 fs/netfs/write_issue.c:572

stack backtrace:
CPU: 1 UID: 0 PID: 10014 Comm: syz.2.1318 Not tainted 6.11.0-rc5-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
 lock_acquire kernel/locking/lockdep.c:5759 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
 down_read_killable+0x9d/0x380 kernel/locking/rwsem.c:1549
 mmap_read_lock_killable include/linux/mmap_lock.h:153 [inline]
 get_mmap_lock_carefully mm/memory.c:5878 [inline]
 lock_mm_and_find_vma+0x3a9/0x6a0 mm/memory.c:5929
 do_user_addr_fault+0x2b5/0x13f0 arch/x86/mm/fault.c:1361
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:fault_in_readable+0x126/0x230 mm/gup.c:2244
Code: f7 bc ff 48 39 dd 0f 84 f0 00 00 00 45 31 f6 eb 11 e8 6e f7 bc ff 48 81 c3 00 10 00 00 48 39 eb 74 1d e8 5d f7 bc ff 45 89 f7 <8a> 03 31 ff 44 89 fe 88 44 24 28 e8 8a f9 bc ff 45 85 ff 74 d2 e8
RSP: 0018:ffffc900032d7650 EFLAGS: 00050287
RAX: 0000000000030b60 RBX: 0000000020005000 RCX: ffffc900040f9000
RDX: 0000000000040000 RSI: ffffffff81cd8213 RDI: 0000000000000005
RBP: 0000000020006000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000001000
R13: 0000000020004180 R14: 0000000000000000 R15: 0000000000000000
 fault_in_iov_iter_readable+0x101/0x2c0 lib/iov_iter.c:94
 netfs_perform_write+0x3ef/0x2250 fs/netfs/buffered_write.c:240
 netfs_buffered_write_iter_locked+0x213/0x2c0 fs/netfs/buffered_write.c:470
 netfs_file_write_iter+0x1e0/0x470 fs/netfs/buffered_write.c:509
 v9fs_file_write_iter+0xa1/0x100 fs/9p/vfs_file.c:407
 aio_write+0x3c1/0x8e0 fs/aio.c:1633
 __io_submit_one fs/aio.c:2005 [inline]
 io_submit_one+0x124e/0x1db0 fs/aio.c:2052
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit fs/aio.c:2081 [inline]
 __x64_sys_io_submit+0x19d/0x330 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f86fd779e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f86fe526038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f86fd915f80 RCX: 00007f86fd779e79
RDX: 0000000020000700 RSI: 000000000000140b RDI: 00007f86fe4fe000
RBP: 00007f86fd7e793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f86fd915f80 R15: 00007ffe70f66888
 </TASK>
input: syz0 as /devices/virtual/input/input13
netlink: 'syz.2.1318': attribute type 2 has an invalid length.
netlink: 'syz.2.1318': attribute type 1 has an invalid length.
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	bc ff 48 39 dd       	mov    $0xdd3948ff,%esp
   5:	0f 84 f0 00 00 00    	je     0xfb
   b:	45 31 f6             	xor    %r14d,%r14d
   e:	eb 11                	jmp    0x21
  10:	e8 6e f7 bc ff       	call   0xffbcf783
  15:	48 81 c3 00 10 00 00 	add    $0x1000,%rbx
  1c:	48 39 eb             	cmp    %rbp,%rbx
  1f:	74 1d                	je     0x3e
  21:	e8 5d f7 bc ff       	call   0xffbcf783
  26:	45 89 f7             	mov    %r14d,%r15d
* 29:	8a 03                	mov    (%rbx),%al <-- trapping instruction
  2b:	31 ff                	xor    %edi,%edi
  2d:	44 89 fe             	mov    %r15d,%esi
  30:	88 44 24 28          	mov    %al,0x28(%rsp)
  34:	e8 8a f9 bc ff       	call   0xffbcf9c3
  39:	45 85 ff             	test   %r15d,%r15d
  3c:	74 d2                	je     0x10
  3e:	e8                   	.byte 0xe8


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

