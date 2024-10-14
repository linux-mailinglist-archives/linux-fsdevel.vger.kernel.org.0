Return-Path: <linux-fsdevel+bounces-31833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5956099BFC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 08:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189B8281531
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 06:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022E013D897;
	Mon, 14 Oct 2024 06:08:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCA513D25E
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 06:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886116; cv=none; b=SO+VQ8B7RMVjzMEQ1uUz5v8YOQ4TL+vbd+aaWULMT1Wx/ElgUxtMNY6HdsMHasSnG+czrEZjUruQFz7G9qBBy/slOLAILg6gz498vqdFkYdMP4QGjysIdOVS1+RHLJdrqtBFmlevlYNMiMhpediPhAp9IfsjrqPK5Vy0KJy6nRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886116; c=relaxed/simple;
	bh=mBfPnj0pOHonS0WzYkYJo2XpqiFEKIS8tlLzX7aNqEk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RaDdfbWjj5n0RD+n2eu6BjcQVP42O/0zbVXbWu2wAsw3D0Z5nFtVvtP8H+CvI9qE5mCqPgj5+XoFcWrZ+lsZvuiXUu2o/jTbx74g2Ayhufx5uUIncvwFFErgSennpvy3+Ahcap3cfLQLyudgalSwPJgfqBq+njXyjqCmXRZZXuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c24f3111so8823835ab.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Oct 2024 23:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728886114; x=1729490914;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t0/yeDeNkaEjV4g5mMXlb4fZuDqiuvnJ1UQSJpN+zKo=;
        b=iC07LLj8+T454ZiMmBFdF0yT76rd9Zlzk55Vs0CQl4hI2oV2oytY0qlS1QJwWLNd9c
         V6axMU7bfEH6fzqfN95RFY2qTLvp1qP9VIE5/t1jzRRRCTBOzqtDM0EXHQpwwCG3d0Gk
         STzbMnOlUJKQ6slCUZvyOA/1QzI6Zf/G2cz5zIEwSQ6mK4qpm3ciVBnO7mDpQPVVP69r
         7uuYAc00omu+pf+g7Q7rdaEagNE9vB4k+bswMRm1zCEf8mrHaWPLmTpVkVSLN6OzgSzX
         iyJmzq9p9q2PoJG2bef4KDInYAhlZDfs6xg2AQGZdDC9AquP3KV2F5nhpsIOY32SsuYj
         JZhw==
X-Forwarded-Encrypted: i=1; AJvYcCUhAnq1Tehl/96GQfike4guGB1MbmmKo/ISmxKV6J1A2V8+QkppwfvII83twzMm1qgHxd+UpXyNUxU8FXZ+@vger.kernel.org
X-Gm-Message-State: AOJu0YxpxB2b+Cj3cH7olTqKFFhndUOKiMtCTFCW1wyfe82zK69kV7iV
	NTzBy1lbAROsvrR+h88x45+jyRroXhNN0dzlEFU3iMmMcex+mPaNOHV3jqaFsyOK8od+tlmdRwy
	ih6kkVVa882bHFmhz0xLBUib+0jdln0JHDrStwat2FONkzzAiH2gYDOk=
X-Google-Smtp-Source: AGHT+IFqT3iIV9aFXmeqV4lDgQYcBZ+OA2OPQxqgQKVMpIjjnmUkcezojlMl/MUbNxHgXiqYaQAhTNnsRoysS3/qSE/xtFWQKHvj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138a:b0:3a1:a163:ba58 with SMTP id
 e9e14a558f8ab-3a3b5fcaac6mr75865685ab.26.1728886114193; Sun, 13 Oct 2024
 23:08:34 -0700 (PDT)
Date: Sun, 13 Oct 2024 23:08:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670cb562.050a0220.4cbc0.0042.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] KCSAN: data-race in xas_create / xas_find (8)
From: syzbot <syzbot+b79be83906cd9bab16ff@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f91ff27b0ee Merge tag 'sound-6.12-rc2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155c879f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95098faba89c70c9
dashboard link: https://syzkaller.appspot.com/bug?extid=b79be83906cd9bab16ff
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/14933c4ac457/disk-2f91ff27.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6725831fc1a1/vmlinux-2f91ff27.xz
kernel image: https://storage.googleapis.com/syzbot-assets/98d64e038e72/bzImage-2f91ff27.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b79be83906cd9bab16ff@syzkaller.appspotmail.com

loop4: detected capacity change from 0 to 4096
EXT4-fs: Ignoring removed nobh option
EXT4-fs: Ignoring removed i_version option
==================================================================
BUG: KCSAN: data-race in xas_create / xas_find

write to 0xffff888106819919 of 1 bytes by task 3435 on cpu 0:
 xas_expand lib/xarray.c:613 [inline]
 xas_create+0x666/0xbd0 lib/xarray.c:654
 xas_store+0x6f/0xc90 lib/xarray.c:788
 __filemap_add_folio+0x3cc/0x6f0 mm/filemap.c:916
 filemap_add_folio+0x9c/0x1b0 mm/filemap.c:972
 page_cache_ra_unbounded+0x175/0x310 mm/readahead.c:268
 do_page_cache_ra mm/readahead.c:320 [inline]
 force_page_cache_ra mm/readahead.c:349 [inline]
 page_cache_sync_ra+0x252/0x670 mm/readahead.c:562
 page_cache_sync_readahead include/linux/pagemap.h:1394 [inline]
 filemap_get_pages+0x2c1/0x10e0 mm/filemap.c:2547
 filemap_read+0x216/0x680 mm/filemap.c:2645
 blkdev_read_iter+0x20e/0x2c0 block/fops.c:765
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x5f6/0x720 fs/read_write.c:569
 ksys_read+0xeb/0x1b0 fs/read_write.c:712
 __do_sys_read fs/read_write.c:722 [inline]
 __se_sys_read fs/read_write.c:720 [inline]
 __x64_sys_read+0x42/0x50 fs/read_write.c:720
 x64_sys_call+0x27d3/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:1
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888106819919 of 1 bytes by task 9109 on cpu 1:
 xas_find+0x372/0x3f0 lib/xarray.c:1278
 find_get_entry+0x66/0x390 mm/filemap.c:1992
 find_get_entries+0xa4/0x220 mm/filemap.c:2047
 truncate_inode_pages_range+0x4ac/0x6b0 mm/truncate.c:378
 truncate_inode_pages+0x24/0x30 mm/truncate.c:423
 kill_bdev block/bdev.c:91 [inline]
 set_blocksize+0x258/0x270 block/bdev.c:173
 sb_set_blocksize block/bdev.c:182 [inline]
 sb_min_blocksize+0x63/0xe0 block/bdev.c:198
 ext4_load_super fs/ext4/super.c:4992 [inline]
 __ext4_fill_super fs/ext4/super.c:5213 [inline]
 ext4_fill_super+0x38b/0x3a10 fs/ext4/super.c:5686
 get_tree_bdev+0x256/0x2e0 fs/super.c:1635
 ext4_get_tree+0x1c/0x30 fs/ext4/super.c:5718
 vfs_get_tree+0x56/0x1e0 fs/super.c:1800
 do_new_mount+0x227/0x690 fs/namespace.c:3507
 path_mount+0x49b/0xb30 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x27c/0x2d0 fs/namespace.c:4032
 __x64_sys_mount+0x67/0x80 fs/namespace.c:4032
 x64_sys_call+0x203e/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0e -> 0x00

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 9109 Comm: syz.4.1794 Not tainted 6.12.0-rc1-syzkaller-00257-g2f91ff27b0ee #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
==================================================================
EXT4-fs (loop4): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
EXT4-fs (loop4): unmounting filesystem 00000000-0000-0000-0000-000000000000.


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

