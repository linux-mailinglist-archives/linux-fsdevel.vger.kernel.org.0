Return-Path: <linux-fsdevel+bounces-27057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E14295E1AC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 06:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14386285FAA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 04:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC062C69B;
	Sun, 25 Aug 2024 04:18:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC632A1D6
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Aug 2024 04:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724559502; cv=none; b=hCS+qDuMI783pmQgkRi6wZcPvxqekyYhpeSWFUft6tPpkeXPvDghHOt39OKF8zGoAR7122Kq0auabvzg1rJqztwDIUTgk5SIeY8WN8kCNxtREbo8RZIWXFsX/+jm/ahgINfKZkHVyEo+ar7OhZap5mfo36bruSnLmc+9AL3cbVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724559502; c=relaxed/simple;
	bh=h2qZGmiim1iogf1TTKlAxHV+1sa2M7QWGViexIdIwLU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iAN8TClrP7yXTxzG/4clobdFkmv6RVlH2epWbkzK830jTyMMtZyNZ6jIfq3Rko66Y3Qj+PEBmgqk4qaJ5LVZZ5w4gAroS6sgdS2Jh1K5rCrIEbi0E4kaAn2+xdk1MZBqA8/eqhAgm8WRvOdO32caI8LJnRHC636s5pFTKnfqJ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f81da0972so362122239f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 21:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724559499; x=1725164299;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Ta5x7Nx8nK+wZ+1OBghrErhjXWge0kxAwhhczbT850=;
        b=US8M3MzxuQ52o2R71j4dRzMCrt4DpGinrf+KF/geshujcwRK+dM7gmIhY5WFCNTx7T
         iSeONmN3fuwZ4S7vDhhlmWsKqMgz7+vot/i0go51h690YBb+Aj/ubbVQRXoginBbOBVj
         XQgujRtnq7pBHqswgwlxkWdv+VbxT+nE4VvIWksA+11nQA2p8iRLvnRVINQqpu+REP3M
         8y/ab6fmpmbm+VlGYOx/mb2o5H0G5fKv4kXiOWEBHY6siqF8QBogCh/J71Ku5DzebaB3
         q2ewAP22+HxHf88Lzi6djBnC3yazPZzhD4rPYMU90A6jPjk250ZYzyB4zdumQRhDrRo6
         MG5A==
X-Forwarded-Encrypted: i=1; AJvYcCXBoq5sZKrXVN2rAQ6Wv3raTAM3R0yQaJLSNxH91kmAZ2u4WeINFOLkOE18jWa0x9in5QWn/FPvplp4gg80@vger.kernel.org
X-Gm-Message-State: AOJu0YzB+jKymdE+a8y0X7eO5jwgzgdlVU3KugKumPOZ0dJy7SDpefon
	DMbpUQU1ivP2Rr224E6Vew/GiryxXR5PQvcJZZ1DZma91GcsGoSCuo9FDdwI4Ds1lLYN+Q2UOpP
	ZWiluAThwes5QOJ1/8/l/+OwuceNcIWFMO9R4RQJXhj7QtPv5Dy6Z1lE=
X-Google-Smtp-Source: AGHT+IHmuf1UVrmGwlnfkszMT/YNbV7pPd3h3si6szDpmkoxxIKhrbUdp3ajJIkCt7pLjfmxTU+2cwqbiAiS+hmsAPUbIiEHT7MA
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:cca1:0:b0:4ce:8f9e:5002 with SMTP id
 8926c6da1cb9f-4ce8f9e52a8mr37078173.2.1724559499270; Sat, 24 Aug 2024
 21:18:19 -0700 (PDT)
Date: Sat, 24 Aug 2024 21:18:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059326f06207a4c52@google.com>
Subject: [syzbot] [netfs?] possible deadlock in netfs_writepages
From: syzbot <syzbot+4cd21de745fa06782146@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    521b1e7f4cf0 Merge tag 'cxl-fixes-6.11-rc5' of git://git.k.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D1319656b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc87b73e79a23403=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3D4cd21de745fa06782=
146
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc=
7510fe41f/non_bootable_disk-521b1e7f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/16372c2b18b5/vmlinux-=
521b1e7f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/94a90e809b75/bzI=
mage-521b1e7f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+4cd21de745fa06782146@syzkaller.appspotmail.com

fuse: Unknown parameter 'r=1Datmode'
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
6.11.0-rc4-syzkaller-00011-g521b1e7f4cf0 #0 Not tainted
------------------------------------------------------
syz.0.1984/12860 is trying to acquire lock:
ffff888028a511e0 (&ctx->wb_lock){+.+.}-{3:3}, at: netfs_writepages+0x5e1/0x=
dd0 fs/netfs/write_issue.c:509

but task is already holding lock:
ffff88801d5b9e18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock include/=
linux/mmap_lock.h:106 [inline]
ffff88801d5b9e18 (&mm->mmap_lock){++++}-{3:3}, at: exit_mmap+0x1fa/0xb20 mm=
/mmap.c:3420

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&mm->mmap_lock){++++}-{3:3}:
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
       netfs_buffered_write_iter_locked+0x213/0x2c0 fs/netfs/buffered_write=
.c:470
       netfs_file_write_iter+0x1e0/0x470 fs/netfs/buffered_write.c:509
       v9fs_file_write_iter+0xa1/0x100 fs/9p/vfs_file.c:407
       aio_write+0x3c1/0x8e0 fs/aio.c:1633
       __io_submit_one fs/aio.c:2005 [inline]
       io_submit_one+0x124e/0x1db0 fs/aio.c:2052
       __do_compat_sys_io_submit fs/aio.c:2153 [inline]
       __se_compat_sys_io_submit fs/aio.c:2123 [inline]
       __ia32_compat_sys_io_submit+0x1af/0x390 fs/aio.c:2123
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (&ctx->wb_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
       lock_acquire kernel/locking/lockdep.c:5759 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       netfs_writepages+0x5e1/0xdd0 fs/netfs/write_issue.c:509
       do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2683
       filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
       filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
       v9fs_mmap_vm_close+0x213/0x260 fs/9p/vfs_file.c:502
       remove_vma+0x8b/0x180 mm/mmap.c:182
       exit_mmap+0x4d4/0xb20 mm/mmap.c:3436
       __mmput+0x12a/0x480 kernel/fork.c:1345
       mmput+0x62/0x70 kernel/fork.c:1367
       exit_mm kernel/exit.c:571 [inline]
       do_exit+0x9bf/0x2bb0 kernel/exit.c:869
       do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
       get_signal+0x265a/0x26e0 kernel/signal.c:2917
       arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
       exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
       __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock);
                               lock(&ctx->wb_lock);
                               lock(&mm->mmap_lock);
  lock(&ctx->wb_lock);

 *** DEADLOCK ***

1 lock held by syz.0.1984/12860:
 #0: ffff88801d5b9e18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock inc=
lude/linux/mmap_lock.h:106 [inline]
 #0: ffff88801d5b9e18 (&mm->mmap_lock){++++}-{3:3}, at: exit_mmap+0x1fa/0xb=
20 mm/mmap.c:3420

stack backtrace:
CPU: 2 UID: 0 PID: 12860 Comm: syz.0.1984 Not tainted 6.11.0-rc4-syzkaller-=
00011-g521b1e7f4cf0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16=
.3-2~bpo12+1 04/01/2014
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
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 netfs_writepages+0x5e1/0xdd0 fs/netfs/write_issue.c:509
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 v9fs_mmap_vm_close+0x213/0x260 fs/9p/vfs_file.c:502
 remove_vma+0x8b/0x180 mm/mmap.c:182
 exit_mmap+0x4d4/0xb20 mm/mmap.c:3436
 __mmput+0x12a/0x480 kernel/fork.c:1345
 mmput+0x62/0x70 kernel/fork.c:1367
 exit_mm kernel/exit.c:571 [inline]
 do_exit+0x9bf/0x2bb0 kernel/exit.c:869
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 get_signal+0x265a/0x26e0 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f31579
Code: Unable to access opcode bytes at 0xf7f3154f.
RSP: 002b:00000000f56d660c EFLAGS: 00000296 ORIG_RAX: 00000000000000f0
RAX: fffffffffffffe00 RBX: 00000000f73f4f88 RCX: 0000000000000080
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000f73f4f8c
RBP: 0000000000000081 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


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

