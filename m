Return-Path: <linux-fsdevel+bounces-17040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87078A6BF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 15:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0BA28133F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 13:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FD112C47F;
	Tue, 16 Apr 2024 13:14:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF2A12882C
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273262; cv=none; b=aJKVC88aa7gCFmkkFeHrdsdPX+oVj8Pf3N2fzfpFk4ZawDLXVJy6PHw3KSjDj76XUDHb5wXs087sz5dvO+ewvjI/e2k6eKlax1yQoevab1N26VNgQzp/ef3lmoluPH4wzX154OyFpHiurM2lVcGCT+5eUy2UacxVMVlrV57ANGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273262; c=relaxed/simple;
	bh=H2aDO5hRUHxVtBzoQM9q506rMIo3n75KR3eMoKFiDYc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XTqo6URdvlVmcWZ8bVwEkUBZYbb9HPoGtznx7oFmVrM2TuXdlvJTEDp/zQJXb5NzyUpdGsbeTFp9j+hUZSyvqA2BkkGRokwOx/ldKwh+U/5NgGff1tdul+RtpS+19MGQFxwl6klSvkN67sxUgBENWbT4ouk1na686W1nHGhpxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc7a930922so558873739f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 06:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713273260; x=1713878060;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H6OYGGa+wa2bluQBe1fsFpWf24/pbrMDuPRSn5WUZ0s=;
        b=uvvJfESxbUUH4+eVGIMmYyYJooXk616N89ffY7Ta4pJ4AUVdzvuVVsfjKaUHaCTTmW
         xsp8CCnPzSskH3a7LyZ8n8xud++BBPP+RCtBTKd+4DasBFTAoybntlcZiXLmK3fDRKLq
         84RWvguhQE0dfl4gV4u9smIXOdL4dmUaLLEFlrT7ATf7GPOkODWE+AhF5e8JqX2M7cZL
         BD6yjJtX/NXdWXZt69UjerY7e8Pn3SfB+w4T+7pdqEWRp5dW1qUtksUmLIOZswPnIUKJ
         9wKBFd332kQ795ULCuRm6dqa2DImlNzyMS4fwiHZqllWwUnRRbllEy5evc3kVrVrWzck
         7nUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXapeTGxvI1wA5pzAe3wn9LM6WVjJDyeQqiyo5gBgd9NsjCUnJPSzVUBTd8FWnbZ8tizQdixsqfiDyVh5UJFv7KdgJYhoDqLOE2c4tHrw==
X-Gm-Message-State: AOJu0Ywp+n7iYMMFEVdT3c1gHsMnE1jqcuU0H8pOOAy4Yn80swcgr0qg
	bN2PoUwJ3tXU3xY6HiNajVSXMCg2Wvp/+3fzHY+Rf5MudjgEVkNjzSZgNcghW6gf9QC9hvBfdME
	SJBZoZwKaUceNBxaf94QEz/p063N+3twZncjFRQ6C0s/zAx0d2kNfPeA=
X-Google-Smtp-Source: AGHT+IHFcLT+SeKYEa1nZIMuGAxPYbpk88VWrLpxCjt8Qya/sIvTrCRjnTAnuQM08lS23mL0hGpTJ231t2DRdz+1Kckmt7Fs5b21
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8917:b0:482:fa6f:78f1 with SMTP id
 jc23-20020a056638891700b00482fa6f78f1mr571514jab.6.1713273260230; Tue, 16 Apr
 2024 06:14:20 -0700 (PDT)
Date: Tue, 16 Apr 2024 06:14:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000145ce00616368490@google.com>
Subject: [syzbot] [exfat?] possible deadlock in exfat_page_mkwrite
From: syzbot <syzbot+d88216a7af9446d57d59@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    66e4190e92ce Add linux-next specific files for 20240416
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15817767180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c247afaa437e6409
dashboard link: https://syzkaller.appspot.com/bug?extid=d88216a7af9446d57d59
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/86891dae5f9c/disk-66e4190e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1ca383660bf2/vmlinux-66e4190e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bf6ff37d3fcc/bzImage-66e4190e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d88216a7af9446d57d59@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc4-next-20240416-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.0/17125 is trying to acquire lock:
ffff88805e616b38 (&sb->s_type->i_mutex_key#24){++++}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
ffff88805e616b38 (&sb->s_type->i_mutex_key#24){++++}-{3:3}, at: exfat_page_mkwrite+0x43a/0xea0 fs/exfat/file.c:629

but task is already holding lock:
ffff88802dc76518 (sb_pagefaults#4){.+.+}-{0:0}, at: do_page_mkwrite+0x19b/0x480 mm/memory.c:3097

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_pagefaults#4){.+.+}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1659 [inline]
       sb_start_pagefault include/linux/fs.h:1824 [inline]
       exfat_page_mkwrite+0x161/0xea0 fs/exfat/file.c:619
       do_page_mkwrite+0x19b/0x480 mm/memory.c:3097
       do_shared_fault mm/memory.c:4977 [inline]
       do_fault mm/memory.c:5039 [inline]
       do_pte_missing mm/memory.c:3881 [inline]
       handle_pte_fault+0x1298/0x6dc0 mm/memory.c:5359
       __handle_mm_fault mm/memory.c:5500 [inline]
       handle_mm_fault+0x10e7/0x1bb0 mm/memory.c:5665
       do_user_addr_fault arch/x86/mm/fault.c:1420 [inline]
       handle_page_fault arch/x86/mm/fault.c:1512 [inline]
       exc_page_fault+0x2b9/0x900 arch/x86/mm/fault.c:1570
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       __put_user_4+0x11/0x20 arch/x86/lib/putuser.S:86
       __sys_socketpair+0x186/0x720 net/socket.c:1756
       __do_sys_socketpair net/socket.c:1822 [inline]
       __se_sys_socketpair net/socket.c:1819 [inline]
       __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1819
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       gup_fast_fallback+0x24c/0x2b40 mm/gup.c:3442
       pin_user_pages_fast+0xcc/0x160 mm/gup.c:3566
       iov_iter_extract_user_pages lib/iov_iter.c:1583 [inline]
       iov_iter_extract_pages+0x3db/0x720 lib/iov_iter.c:1646
       dio_refill_pages fs/direct-io.c:173 [inline]
       dio_get_page fs/direct-io.c:214 [inline]
       do_direct_IO fs/direct-io.c:916 [inline]
       __blockdev_direct_IO+0x150a/0x49b0 fs/direct-io.c:1249
       blockdev_direct_IO include/linux/fs.h:3182 [inline]
       exfat_direct_IO+0x1b4/0x3d0 fs/exfat/inode.c:526
       generic_file_read_iter+0x231/0x430 mm/filemap.c:2783
       new_sync_read fs/read_write.c:395 [inline]
       vfs_read+0x9c4/0xbd0 fs/read_write.c:476
       ksys_read+0x1a0/0x2c0 fs/read_write.c:619
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sb->s_type->i_mutex_key#24){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:791 [inline]
       exfat_page_mkwrite+0x43a/0xea0 fs/exfat/file.c:629
       do_page_mkwrite+0x19b/0x480 mm/memory.c:3097
       do_shared_fault mm/memory.c:4977 [inline]
       do_fault mm/memory.c:5039 [inline]
       do_pte_missing mm/memory.c:3881 [inline]
       handle_pte_fault+0x1298/0x6dc0 mm/memory.c:5359
       __handle_mm_fault mm/memory.c:5500 [inline]
       handle_mm_fault+0x10e7/0x1bb0 mm/memory.c:5665
       do_user_addr_fault arch/x86/mm/fault.c:1420 [inline]
       handle_page_fault arch/x86/mm/fault.c:1512 [inline]
       exc_page_fault+0x2b9/0x900 arch/x86/mm/fault.c:1570
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

other info that might help us debug this:

Chain exists of:
  &sb->s_type->i_mutex_key#24 --> &mm->mmap_lock --> sb_pagefaults#4

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_pagefaults#4);
                               lock(&mm->mmap_lock);
                               lock(sb_pagefaults#4);
  lock(&sb->s_type->i_mutex_key#24);

 *** DEADLOCK ***

2 locks held by syz-executor.0/17125:
 #0: ffff88804e4ce098 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
 #0: ffff88804e4ce098 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:5692 [inline]
 #0: ffff88804e4ce098 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x32/0x2f0 mm/memory.c:5752
 #1: ffff88802dc76518 (sb_pagefaults#4){.+.+}-{0:0}, at: do_page_mkwrite+0x19b/0x480 mm/memory.c:3097

stack backtrace:
CPU: 1 PID: 17125 Comm: syz-executor.0 Not tainted 6.9.0-rc4-next-20240416-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
 inode_lock include/linux/fs.h:791 [inline]
 exfat_page_mkwrite+0x43a/0xea0 fs/exfat/file.c:629
 do_page_mkwrite+0x19b/0x480 mm/memory.c:3097
 do_shared_fault mm/memory.c:4977 [inline]
 do_fault mm/memory.c:5039 [inline]
 do_pte_missing mm/memory.c:3881 [inline]
 handle_pte_fault+0x1298/0x6dc0 mm/memory.c:5359
 __handle_mm_fault mm/memory.c:5500 [inline]
 handle_mm_fault+0x10e7/0x1bb0 mm/memory.c:5665
 do_user_addr_fault arch/x86/mm/fault.c:1420 [inline]
 handle_page_fault arch/x86/mm/fault.c:1512 [inline]
 exc_page_fault+0x2b9/0x900 arch/x86/mm/fault.c:1570
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f59f325f107
Code: 7e 6f 44 16 e0 48 29 fe 48 83 e1 e0 48 01 ce 0f 1f 40 00 c5 fe 6f 4e 60 c5 fe 6f 56 40 c5 fe 6f 5e 20 c5 fe 6f 26 48 83 c6 80 <c5> fd 7f 49 60 c5 fd 7f 51 40 c5 fd 7f 59 20 c5 fd 7f 21 48 83 c1
RSP: 002b:00007ffd52a03428 EFLAGS: 00010203
RAX: 00000000200027c0 RBX: 0000000000000004 RCX: 0000000020003c20
RDX: 0000000000001500 RSI: 00007f59f2e02adf RDI: 00000000200027c0
RBP: 00007f59f33ac050 R08: 0000000000000000 R09: 0000000000000054
R10: 0000000000000000 R11: 0000000000000001 R12: 00007ffd52a035e0
R13: 0000000000000001 R14: ffffffffffffffff R15: 00007f59f3234cb0
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

