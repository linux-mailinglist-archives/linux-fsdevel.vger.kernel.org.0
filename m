Return-Path: <linux-fsdevel+bounces-7914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99AE82D042
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jan 2024 11:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9318AB21E1B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jan 2024 10:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B2B1FD1;
	Sun, 14 Jan 2024 10:15:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C65396
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jan 2024 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35ff23275b8so74171185ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jan 2024 02:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705227320; x=1705832120;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ef8RlfvNizusNJEpFPPJswpir101aPuFjW55VZ/jFAE=;
        b=DCkjnnyMT6HrszqQrlLVoZSokKROW3DuYjBu0GLG3sQAcK3YqBPqOm2NmhxGOZVIzJ
         BWtw0KcNDIDOXzibCuI0yIXehBYCBOT7mEFFVSLpK/UjZA3Ks9OTcqHeBVTs7GA2CMIp
         WpixdHfoXrffJGdp7TbGetNeKPrJ283Q6nr5nYCiXJcoc9K8jL6JYdpMFymXwTjB/xaF
         0jcqPsyLx2ZR+bSKhv/HqHxVXMjR0cT9FQExh9NvbHIXYYTk029bwVvgM1UiTmEQ1wWZ
         7t3hM+0pljnLxoUFEkU4CJaShOBBL/2oj9B0O9lP1vDezlP0UhWEnnbf1srlgxDXJdwY
         aPwA==
X-Gm-Message-State: AOJu0YyBpxnk/xAZYd4W3ZRo4EBUywOCwgoO/IpTbjmV5SWTXOmTOTv+
	ZttSrTJ6nXtkx4X7/du/OJRV8t4pBssltOtpnLYE/eeH67j6
X-Google-Smtp-Source: AGHT+IH4paAtnH1GJFNpGmWxNyqSDgEl+vpHoOr+kybnQ1rSsj6CcqUHkvD2v8RpwUFwLc1rO0kDVuvGqOYmC9+eM+6+83UNe4yt
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b85:b0:35f:f01e:bb1d with SMTP id
 h5-20020a056e021b8500b0035ff01ebb1dmr548548ili.5.1705227320751; Sun, 14 Jan
 2024 02:15:20 -0800 (PST)
Date: Sun, 14 Jan 2024 02:15:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6ffa9060ee52c74@google.com>
Subject: [syzbot] [btrfs?] KMSAN: uninit-value in bcmp (2)
From: syzbot <syzbot+3ce5dea5b1539ff36769@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    610a9b8f49fb Linux 6.7-rc8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110b4555e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e51fe20c3e51ba7f
dashboard link: https://syzkaller.appspot.com/bug?extid=3ce5dea5b1539ff36769
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/daced691c987/disk-610a9b8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5e37367a7d1e/vmlinux-610a9b8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/013b65c960ab/bzImage-610a9b8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ce5dea5b1539ff36769@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in memcmp lib/string.c:681 [inline]
BUG: KMSAN: uninit-value in bcmp+0xc3/0x1c0 lib/string.c:713
 memcmp lib/string.c:681 [inline]
 bcmp+0xc3/0x1c0 lib/string.c:713
 sample_repeated_patterns fs/btrfs/compression.c:1298 [inline]
 btrfs_compress_heuristic+0x926/0x31f0 fs/btrfs/compression.c:1380
 inode_need_compress fs/btrfs/inode.c:804 [inline]
 btrfs_run_delalloc_range+0x156c/0x16c0 fs/btrfs/inode.c:2272
 writepage_delalloc+0x244/0x6b0 fs/btrfs/extent_io.c:1189
 __extent_writepage fs/btrfs/extent_io.c:1440 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2108 [inline]
 extent_writepages+0x1d22/0x3f20 fs/btrfs/extent_io.c:2230
 btrfs_writepages+0x35/0x40 fs/btrfs/inode.c:7836
 do_writepages+0x426/0x870 mm/page-writeback.c:2553
 filemap_fdatawrite_wbc+0x1d8/0x270 mm/filemap.c:387
 start_delalloc_inodes+0x91d/0x1560 fs/btrfs/inode.c:9284
 btrfs_start_delalloc_roots+0x874/0xe80 fs/btrfs/inode.c:9361
 shrink_delalloc fs/btrfs/space-info.c:649 [inline]
 flush_space+0xbd4/0x16c0 fs/btrfs/space-info.c:759
 btrfs_async_reclaim_metadata_space+0x76d/0x9c0 fs/btrfs/space-info.c:1089
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was stored to memory at:
 heuristic_collect_sample fs/btrfs/compression.c:1338 [inline]
 btrfs_compress_heuristic+0x303/0x31f0 fs/btrfs/compression.c:1378
 inode_need_compress fs/btrfs/inode.c:804 [inline]
 btrfs_run_delalloc_range+0x156c/0x16c0 fs/btrfs/inode.c:2272
 writepage_delalloc+0x244/0x6b0 fs/btrfs/extent_io.c:1189
 __extent_writepage fs/btrfs/extent_io.c:1440 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2108 [inline]
 extent_writepages+0x1d22/0x3f20 fs/btrfs/extent_io.c:2230
 btrfs_writepages+0x35/0x40 fs/btrfs/inode.c:7836
 do_writepages+0x426/0x870 mm/page-writeback.c:2553
 filemap_fdatawrite_wbc+0x1d8/0x270 mm/filemap.c:387
 start_delalloc_inodes+0x91d/0x1560 fs/btrfs/inode.c:9284
 btrfs_start_delalloc_roots+0x874/0xe80 fs/btrfs/inode.c:9361
 shrink_delalloc fs/btrfs/space-info.c:649 [inline]
 flush_space+0xbd4/0x16c0 fs/btrfs/space-info.c:759
 btrfs_async_reclaim_metadata_space+0x76d/0x9c0 fs/btrfs/space-info.c:1089
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was created at:
 __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages mm/mempolicy.c:2204 [inline]
 folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
 filemap_alloc_folio+0xa5/0x430 mm/filemap.c:974
 __filemap_get_folio+0xa5a/0x1760 mm/filemap.c:1918
 pagecache_get_page+0x4a/0x1a0 mm/folio-compat.c:99
 prepare_pages+0x1f2/0x1050 fs/btrfs/file.c:922
 btrfs_buffered_write+0xe48/0x2be0 fs/btrfs/file.c:1316
 btrfs_do_write_iter+0x370/0x2300 fs/btrfs/file.c:1687
 btrfs_file_write_iter+0x38/0x40 fs/btrfs/file.c:1704
 __kernel_write_iter+0x329/0x930 fs/read_write.c:517
 dump_emit_page fs/coredump.c:888 [inline]
 dump_user_range+0x593/0xcd0 fs/coredump.c:915
 elf_core_dump+0x59e8/0x5c60 fs/binfmt_elf.c:2077
 do_coredump+0x32c9/0x4920 fs/coredump.c:764
 get_signal+0x2185/0x2d10 kernel/signal.c:2890
 arch_do_signal_or_restart+0x53/0xca0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0x163/0x220 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0xd/0x30 kernel/entry/common.c:309
 irqentry_exit+0x16/0x40 kernel/entry/common.c:412
 exc_page_fault+0x246/0x6f0 arch/x86/mm/fault.c:1564
 asm_exc_page_fault+0x2b/0x30 arch/x86/include/asm/idtentry.h:570

CPU: 1 PID: 56 Comm: kworker/u4:4 Not tainted 6.7.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_unbound btrfs_async_reclaim_metadata_space
=====================================================


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

