Return-Path: <linux-fsdevel+bounces-18781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58608BC49D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 00:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C37F2817DD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 22:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6A113FD9B;
	Sun,  5 May 2024 22:47:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC0213FD89
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714949243; cv=none; b=Lfuwt67sHj4jpgn/lGWfKfURK+RWbHyo3QugmNQgAaKgcHMNGYrp/vgfOsQ1huYIJ4gMbu7ktRHAIsBbIVVEUnf3HlYDiNYyz8Ps9oq7Tbz8NXdEpY5AVH6PW5JDsl48B2EeeypJ5uULDntKU0geqQWmShwcRSLgzIJuwR+glFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714949243; c=relaxed/simple;
	bh=2rQSGfZczxuu5BVViuod3PIqPvYjrsjLpDWk9+74D0Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DpnUq6kPZbfwSGcMQiU4tZZY98h5SrjtDD0WMFv0JV4H2TlREsJrFmg+9RtUcd2COXcVuArZnXexBqP/HTcNDPlRNmAVSW7QcBmuMAUM6ebhiMnak7d1AFl3P+5QJFmepVmSEhwJVUoqqdlXJO8UCpAppgXzv2uYxSH8ClD7AUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7ded5e00bf0so181768539f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 15:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714949241; x=1715554041;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MminAExDnz0wYpoMIUdMImA6PlzOOiOe3Juhk9FBtMc=;
        b=DuGZMSb3O8JxJEVeSG6uztGKKMfh25Kg2g7nd+PkcJh4DK1I8BcEe3rU5jAgOWNnZC
         /0bWmRyOfKq0hZZ5l4HVuxjyN7446x9JSf9K1cRC1b1eegsf9uX5TIWwucu+ZktiMtFX
         6zZ2weKYYlL4u6OuIvgpK1mDthdT+zJ5dycY1q1ipzA7TvnZQn5cR/w8Fjm5s9t4Iy8t
         6cOAowrH6bybsIgkaEcrTxXar/BQ9KlE0m/QFe6uTKaVJZAROBGKwGxLe1pj0U7M31K0
         9SV4T8MuLNIsy0g2pfXOMRbb9HsIj+tlny1PnqtZUyw/Ftxt5kRlAR86JNwNiR0vgelb
         SYzw==
X-Forwarded-Encrypted: i=1; AJvYcCUMfDO5ud7yJVzmTeY5T1ucj0XhIyXxxijDjY95c9Eaq1hYRUDHyYkBETzJiHMOHdi3O1sUZeSxktnk9HCV4KVZ5wzjKV2gE+7t0ewo1A==
X-Gm-Message-State: AOJu0YwypQSN1iAC34WCIjv0PFs7XdtrK8p9gRrHvp0e9QjKkjhDJ8/N
	0tFpU7gJYFRVxMLf+We5wnDCvi1w2nH4DYOJABJFE5xc7PeCPqhZpc0NOKgWVhCrQOIrKD2tLEh
	NPIol9CQTfZwOy+0+5o+ODh09S1t9PVcI7h1V1+gNUM+Thx9RGr2I6To=
X-Google-Smtp-Source: AGHT+IGyWPkiy1kqutemKYb6J1UuvxDvQXx3vMAGY9UF7Abyw7UL3d714Gjb6qsfg0KwATCAnNzpNmc+ZNQZvJGv89JjTG663o42
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d91:b0:36a:276e:4fe with SMTP id
 h17-20020a056e021d9100b0036a276e04femr468881ila.4.1714949241096; Sun, 05 May
 2024 15:47:21 -0700 (PDT)
Date: Sun, 05 May 2024 15:47:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052d98f0617bcbc84@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in indx_read (2)
From: syzbot <syzbot+9309ec5fd67539ad7ccd@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0106679839f7 Merge tag 'regulator-fix-v6.9-rc6' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a4eaa0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=9309ec5fd67539ad7ccd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2175ae9aeccf/disk-01066798.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/279c31a8cc74/vmlinux-01066798.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bac83f4f7c54/bzImage-01066798.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9309ec5fd67539ad7ccd@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 4096
======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc6-syzkaller-00053-g0106679839f7 #0 Not tainted
------------------------------------------------------
syz-executor.2/16366 is trying to acquire lock:
ffff88806c3f77e0 (&indx->run_lock){++++}-{3:3}, at: indx_read+0x44b/0xc50 fs/ntfs3/index.c:1079

but task is already holding lock:
ffff88806c3f7700 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1123 [inline]
ffff88806c3f7700 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_lookup+0xf9/0x1f0 fs/ntfs3/namei.c:84

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ni->ni_lock/4){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ni_lock fs/ntfs3/ntfs_fs.h:1123 [inline]
       attr_data_get_block+0x444/0x2e10 fs/ntfs3/attrib.c:914
       ntfs_get_block_vbo+0x36a/0xd00 fs/ntfs3/inode.c:593
       do_mpage_readpage+0x827/0x1c80 fs/mpage.c:232
       mpage_readahead+0x44f/0x930 fs/mpage.c:381
       read_pages+0x17e/0x840 mm/readahead.c:160
       page_cache_ra_unbounded+0x67f/0x7a0 mm/readahead.c:269
       do_sync_mmap_readahead+0x444/0x850
       filemap_fault+0x7e5/0x16a0 mm/filemap.c:3289
       __do_fault+0x135/0x460 mm/memory.c:4531
       do_read_fault mm/memory.c:4894 [inline]
       do_fault mm/memory.c:5024 [inline]
       do_pte_missing mm/memory.c:3880 [inline]
       handle_pte_fault mm/memory.c:5300 [inline]
       __handle_mm_fault+0x45fe/0x7250 mm/memory.c:5441
       handle_mm_fault+0x27f/0x770 mm/memory.c:5606
       do_user_addr_fault arch/x86/mm/fault.c:1413 [inline]
       handle_page_fault arch/x86/mm/fault.c:1505 [inline]
       exc_page_fault+0x2a8/0x8e0 arch/x86/mm/fault.c:1563
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       do_strncpy_from_user lib/strncpy_from_user.c:69 [inline]
       strncpy_from_user+0x21a/0x2f0 lib/strncpy_from_user.c:139
       strncpy_from_sockptr include/linux/sockptr.h:155 [inline]
       do_tcp_setsockopt+0x18d/0x2590 net/ipv4/tcp.c:3427
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2311
       __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
       __do_sys_setsockopt net/socket.c:2343 [inline]
       __se_sys_setsockopt net/socket.c:2340 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (mapping.invalidate_lock#7){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       filemap_invalidate_lock_shared include/linux/fs.h:850 [inline]
       page_cache_ra_unbounded+0xfb/0x7a0 mm/readahead.c:225
       do_sync_mmap_readahead+0x444/0x850
       filemap_fault+0x7e5/0x16a0 mm/filemap.c:3289
       __do_fault+0x135/0x460 mm/memory.c:4531
       do_cow_fault mm/memory.c:4924 [inline]
       do_fault mm/memory.c:5026 [inline]
       do_pte_missing mm/memory.c:3880 [inline]
       handle_pte_fault mm/memory.c:5300 [inline]
       __handle_mm_fault+0x219c/0x7250 mm/memory.c:5441
       handle_mm_fault+0x27f/0x770 mm/memory.c:5606
       faultin_page mm/gup.c:958 [inline]
       __get_user_pages+0x727/0x1630 mm/gup.c:1257
       __get_user_pages_locked mm/gup.c:1525 [inline]
       __gup_longterm_locked+0x50a/0x2b30 mm/gup.c:2228
       pin_user_pages+0x137/0x1f0 mm/gup.c:3401
       xdp_umem_pin_pages net/xdp/xdp_umem.c:105 [inline]
       xdp_umem_reg net/xdp/xdp_umem.c:227 [inline]
       xdp_umem_create+0x955/0xf30 net/xdp/xdp_umem.c:260
       xsk_setsockopt+0x732/0x950 net/xdp/xsk.c:1402
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2311
       __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
       __do_sys_setsockopt net/socket.c:2343 [inline]
       __se_sys_setsockopt net/socket.c:2340 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __might_fault+0xc6/0x120 mm/memory.c:6220
       _copy_to_user+0x2a/0xb0 lib/usercopy.c:36
       copy_to_user include/linux/uaccess.h:191 [inline]
       fiemap_fill_next_extent+0x235/0x410 fs/ioctl.c:145
       ni_fiemap+0xa5e/0x1230 fs/ntfs3/frecord.c:2065
       ntfs_fiemap+0x132/0x180 fs/ntfs3/file.c:1206
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x1c07/0x2e50 fs/ioctl.c:838
       __do_sys_ioctl fs/ioctl.c:902 [inline]
       __se_sys_ioctl+0x81/0x170 fs/ioctl.c:890
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&indx->run_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       indx_read+0x44b/0xc50 fs/ntfs3/index.c:1079
       indx_find+0x47a/0xbf0 fs/ntfs3/index.c:1181
       dir_search_u+0x1b7/0x3a0 fs/ntfs3/dir.c:254
       ntfs_lookup+0x106/0x1f0 fs/ntfs3/namei.c:85
       lookup_one_qstr_excl+0x11f/0x260 fs/namei.c:1607
       filename_create+0x297/0x540 fs/namei.c:3893
       do_symlinkat+0xf9/0x3a0 fs/namei.c:4500
       __do_sys_symlinkat fs/namei.c:4523 [inline]
       __se_sys_symlinkat fs/namei.c:4520 [inline]
       __x64_sys_symlinkat+0x99/0xb0 fs/namei.c:4520
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &indx->run_lock --> mapping.invalidate_lock#7 --> &ni->ni_lock/4

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->ni_lock/4);
                               lock(mapping.invalidate_lock#7);
                               lock(&ni->ni_lock/4);
  lock(&indx->run_lock);

 *** DEADLOCK ***

3 locks held by syz-executor.2/16366:
 #0: ffff888065810420 (sb_writers#19){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff88806c3f79a0 (&type->i_mutex_dir_key#12/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:830 [inline]
 #1: ffff88806c3f79a0 (&type->i_mutex_dir_key#12/1){+.+.}-{3:3}, at: filename_create+0x260/0x540 fs/namei.c:3892
 #2: ffff88806c3f7700 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1123 [inline]
 #2: ffff88806c3f7700 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_lookup+0xf9/0x1f0 fs/ntfs3/namei.c:84

stack backtrace:
CPU: 1 PID: 16366 Comm: syz-executor.2 Not tainted 6.9.0-rc6-syzkaller-00053-g0106679839f7 #0
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
 indx_read+0x44b/0xc50 fs/ntfs3/index.c:1079
 indx_find+0x47a/0xbf0 fs/ntfs3/index.c:1181
 dir_search_u+0x1b7/0x3a0 fs/ntfs3/dir.c:254
 ntfs_lookup+0x106/0x1f0 fs/ntfs3/namei.c:85
 lookup_one_qstr_excl+0x11f/0x260 fs/namei.c:1607
 filename_create+0x297/0x540 fs/namei.c:3893
 do_symlinkat+0xf9/0x3a0 fs/namei.c:4500
 __do_sys_symlinkat fs/namei.c:4523 [inline]
 __se_sys_symlinkat fs/namei.c:4520 [inline]
 __x64_sys_symlinkat+0x99/0xb0 fs/namei.c:4520
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f090a47dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f090b2cc0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 00007f090a5abf80 RCX: 00007f090a47dea9
RDX: 00000000200000c0 RSI: 0000000000000009 RDI: 0000000020000300
RBP: 00007f090a4ca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f090a5abf80 R15: 00007ffdebe94ed8
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

