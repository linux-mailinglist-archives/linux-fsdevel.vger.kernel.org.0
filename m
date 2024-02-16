Return-Path: <linux-fsdevel+bounces-11822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ABE8575D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 07:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5311E1F230F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 06:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A022C13AE2;
	Fri, 16 Feb 2024 06:07:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9FA134B6
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708063650; cv=none; b=fkvZloYpz6VoO0lMOqDoQD7hgNJyrMdslxye87hjcvnoG+Sfr27Qj2Rd3KyNBh7W5xNzmJPgs0aoaNj/9Y1R/1WaGT0c8Ag7bZ87HZKwz2k1Ury6hq0fMzVTueWJvVXm/hWnNLWpKfb6a8MA/c2pKoM5e9NlBP2qpMXYqj0PYPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708063650; c=relaxed/simple;
	bh=QMpt0SCftdJcIjYbXJ1LMcwEQQ/VGD+/cEUDupOQkiU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u27E691yXWXgKehHNnier3vptR9MJ5T6T2B2fwAnNfj8V0AZKH/rLtTkBw93nVeZAIymFtMIx5ynnEi42I7qZh8p4D37g1t6nqhQxh8IsOGnQ4IzAmZztJFaaqq9YL1PVblT3vvapfCAjyucyxAMVmHhG0c0FMpPokIexX1v07Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3641afea5efso10372035ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 22:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708063648; x=1708668448;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4F2YASos/WaI9dxX5WGWFwdCo+2tbvtN26YAtxHcV9s=;
        b=eOJOK/kl/+jEGZB/teqDtpId0lHbmBtfvF6CJosxz+qlufNBXlWoT7zwMrDbn9HHkp
         xFyXowlSF9JR8JiksdejFh1PE/A4Y6wBXM2MhJMMvhiu/GnSd+CQJNOeiQhkMA+RkJQ8
         1BHlNvNf2J1N12KOLAO25f4PmWuJXlCPO4qt5jMp8UsFBuHJY3BIP226DWyxMy9/wriw
         lEz/Y9zFCWvlc0T6MiQmtZ8gNjgcUXh/ylsGqh0uSJi+ZRv2ZCa/SseIewqfHByUrmWB
         FTHK2fFfEWqGJBz+kQot7toeEdirGpujUlPcuXLJCF8XkLyJ3GauVUigMEcM1jsyGDeo
         btTg==
X-Forwarded-Encrypted: i=1; AJvYcCVk9M0d0rW//Ydm2PO/Vdf+7kP3sLCM3G4UEn10beqCq6CFLD9/dMm2u9rx5D4Baze4sfI4f+9znGxHQtAkDr8GkUkVHfsx5jaRAQb3Iw==
X-Gm-Message-State: AOJu0YyhsfMd4xoBEh0DmfOtUZtDuRCTmN37WX8Shz3EBdgDz6wvRaci
	iT2KkUGobdOdizc92Y8iQNbDkRPoxbVk+LfKs8E1YL9qEgHlbWJL4VcNfFgShApsAfP2mrtj40c
	dUSIQ4JcXNm6O8gwTJbi8XibmxjQvng4dQl7JT92dQFsg9EKljn3dxwg=
X-Google-Smtp-Source: AGHT+IG0M6rkbOe11lpZQGSZExlEryIZb9CjCRq56IOJvg3Fha44Kc2qgLHGDvA0MYeWpzzardLkaha1l9WT8hXlZy4DNY66p9EK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda8:0:b0:363:cc38:db1c with SMTP id
 g8-20020a92cda8000000b00363cc38db1cmr322034ild.6.1708063647882; Thu, 15 Feb
 2024 22:07:27 -0800 (PST)
Date: Thu, 15 Feb 2024 22:07:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc6b2c0611798e90@google.com>
Subject: [syzbot] [mm?] possible deadlock in lock_vma
From: syzbot <syzbot+27f783f9d240834c9d44@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axelrasmussen@google.com, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lokeshgidra@google.com, mirq-linux@rere.qmqm.pl, 
	peterx@redhat.com, rppt@kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ae00c445390b Add linux-next specific files for 20240212
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17478592180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4eb3a27eddb32a14
dashboard link: https://syzkaller.appspot.com/bug?extid=27f783f9d240834c9d44
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17406e42180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111cb500180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b2a2d0b511f/disk-ae00c445.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a668a09c9d03/vmlinux-ae00c445.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4ad623928692/bzImage-ae00c445.xz

The issue was bisected to:

commit 31d97016c80a83daa4c938014c81282810a14773
Author: Lokesh Gidra <lokeshgidra@google.com>
Date:   Thu Feb 8 21:22:04 2024 +0000

    userfaultfd: use per-vma locks in userfaultfd operations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129ff100180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=119ff100180000
console output: https://syzkaller.appspot.com/x/log.txt?x=169ff100180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27f783f9d240834c9d44@syzkaller.appspotmail.com
Fixes: 31d97016c80a ("userfaultfd: use per-vma locks in userfaultfd operations")

======================================================
WARNING: possible circular locking dependency detected
6.8.0-rc4-next-20240212-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor800/5064 is trying to acquire lock:
ffff888021d401a0 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:146 [inline]
ffff888021d401a0 (&mm->mmap_lock){++++}-{3:3}, at: lock_vma+0xc5/0x260 mm/userfaultfd.c:73

but task is already holding lock:
ffff88802b989730 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma+0x1a1/0x260 mm/userfaultfd.c:87

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&vma->vm_lock->lock){++++}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       vma_start_write include/linux/mm.h:716 [inline]
       vma_link+0x2c6/0x550 mm/mmap.c:416
       insert_vm_struct+0x1a3/0x260 mm/mmap.c:3331
       __bprm_mm_init fs/exec.c:282 [inline]
       bprm_mm_init fs/exec.c:384 [inline]
       alloc_bprm+0x543/0xa00 fs/exec.c:1579
       kernel_execve+0x99/0xa10 fs/exec.c:2008
       try_to_run_init_process init/main.c:1361 [inline]
       kernel_init+0xe8/0x2b0 init/main.c:1488
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       mmap_read_lock include/linux/mmap_lock.h:146 [inline]
       lock_vma+0xc5/0x260 mm/userfaultfd.c:73
       find_and_lock_vmas mm/userfaultfd.c:1405 [inline]
       move_pages+0x18c/0xff0 mm/userfaultfd.c:1546
       userfaultfd_move fs/userfaultfd.c:2008 [inline]
       userfaultfd_ioctl+0x5c10/0x72c0 fs/userfaultfd.c:2126
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:871 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:857
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&vma->vm_lock->lock);
                               lock(&mm->mmap_lock);
                               lock(&vma->vm_lock->lock);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

1 lock held by syz-executor800/5064:
 #0: ffff88802b989730 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma+0x1a1/0x260 mm/userfaultfd.c:87

stack backtrace:
CPU: 1 PID: 5064 Comm: syz-executor800 Not tainted 6.8.0-rc4-next-20240212-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
 mmap_read_lock include/linux/mmap_lock.h:146 [inline]
 lock_vma+0xc5/0x260 mm/userfaultfd.c:73
 find_and_lock_vmas mm/userfaultfd.c:1405 [inline]
 move_pages+0x18c/0xff0 mm/userfaultfd.c:1546
 userfaultfd_move fs/userfaultfd.c:2008 [inline]
 userfaultfd_ioctl+0x5c10/0x72c0 fs/userfaultfd.c:2126
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:857
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f86fc35f329
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd53428e38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffd53429008 RCX: 00007f86fc35f329
RDX: 0000000020000040 RSI: 00000000c028aa05 RDI: 


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

