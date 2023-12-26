Return-Path: <linux-fsdevel+bounces-6917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A42C181E83F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 16:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587CE1F236CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 15:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EF04F886;
	Tue, 26 Dec 2023 15:59:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D88E4F5E6
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Dec 2023 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b71b4b179aso289518239f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Dec 2023 07:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703606359; x=1704211159;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8vsIUG0DSqSbyGFh91iIrmWYYRdoWbKG7UR2q9Kt4xE=;
        b=ogeN+901ivYArQCM36VlCu6ig5HEldL48490mzTZc2zLj+U8eB5+PljhKEF3HcIYOB
         zrZPuBWyXVEn4f9YXWWk/iVUpI1B0167d6uon7gIE0hlzIkEZSyOoOy9Y0cpRK/O6IDC
         tLTpa5ajWtJCwun0VRW/YyBAKNLxrJGywUW7EJbtF4Hy+GALS1hNkrW6q1zz/SUn9ZDe
         0BufsblQsFFHzwfEZtTw1QjYXmWSBr4ktM81XGJ9pKkRUZ5UzaUbrjZCTlrPNz6BCtRE
         2AHbacpUM902G2U4iVayqJDXyCtQjtOi/FL3kYsWDOAHRT1R2tXME++A4jB8mYwdoQum
         EWNw==
X-Gm-Message-State: AOJu0YzYWVOQvT4mwKwUv2XUe86YvzfXW15ZOJ1u2vfFGbAoeJybjApB
	nbc8xfUbfaFM30/ed5RBpvM0tlKUWvSWsB5+QxLrbYiqnG9V
X-Google-Smtp-Source: AGHT+IGR/NI/D/x4HKxH8gstdJaDlHeF2nIUa2DWUqyGcEk4BfF4oIDSMTlL9QuzhyPvIEUR/UOf4NE53k6Gef7A3LXAGdgg1viz
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4919:b0:46d:6d36:d86f with SMTP id
 cx25-20020a056638491900b0046d6d36d86fmr12144jab.3.1703606358828; Tue, 26 Dec
 2023 07:59:18 -0800 (PST)
Date: Tue, 26 Dec 2023 07:59:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000daec33060d6bc380@google.com>
Subject: [syzbot] [ntfs?] KMSAN: uninit-value in post_read_mst_fixup (2)
From: syzbot <syzbot+82248056430fd49210e9@syzkaller.appspotmail.com>
To: anton@tuxera.com, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    55cb5f43689d Merge tag 'trace-v6.7-rc6' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107247e1e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a65fa9f077ead01
dashboard link: https://syzkaller.appspot.com/bug?extid=82248056430fd49210e9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ab88d88fa1d1/disk-55cb5f43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/587fd1186192/vmlinux-55cb5f43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c7bbb5741191/bzImage-55cb5f43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+82248056430fd49210e9@syzkaller.appspotmail.com

syz-executor.1: attempt to access beyond end of device
loop1: rw=0, sector=2040, nr_sectors = 8 limit=190
ntfs: (device loop1): ntfs_end_buffer_async_read(): Buffer I/O error, logical block 0xff.
=====================================================
BUG: KMSAN: uninit-value in post_read_mst_fixup+0xab8/0xb70 fs/ntfs/mst.c:39
 post_read_mst_fixup+0xab8/0xb70 fs/ntfs/mst.c:39
 ntfs_end_buffer_async_read+0xbb8/0x1a70 fs/ntfs/aops.c:133
 end_bio_bh_io_sync+0x130/0x1d0 fs/buffer.c:2775
 bio_endio+0xb17/0xb70 block/bio.c:1603
 submit_bio_noacct+0x230/0x2840 block/blk-core.c:816
 submit_bio+0x171/0x1c0 block/blk-core.c:842
 submit_bh_wbc+0x7de/0x850 fs/buffer.c:2821
 submit_bh+0x26/0x30 fs/buffer.c:2826
 ntfs_read_block fs/ntfs/aops.c:339 [inline]
 ntfs_read_folio+0x364b/0x3930 fs/ntfs/aops.c:430
 filemap_read_folio+0xce/0x370 mm/filemap.c:2323
 do_read_cache_folio+0x3b4/0x11e0 mm/filemap.c:3691
 do_read_cache_page mm/filemap.c:3757 [inline]
 read_cache_page+0x63/0x1c0 mm/filemap.c:3766
 read_mapping_page include/linux/pagemap.h:871 [inline]
 ntfs_map_page fs/ntfs/aops.h:75 [inline]
 check_mft_mirror fs/ntfs/super.c:1117 [inline]
 load_system_files+0x985/0x97b0 fs/ntfs/super.c:1780
 ntfs_fill_super+0x307e/0x45d0 fs/ntfs/super.c:2900
 mount_bdev+0x3d7/0x560 fs/super.c:1650
 ntfs_mount+0x4d/0x60 fs/ntfs/super.c:3057
 legacy_get_tree+0x110/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa5/0x520 fs/super.c:1771
 do_new_mount+0x68d/0x1550 fs/namespace.c:3337
 path_mount+0x73d/0x1f20 fs/namespace.c:3664
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3863
 __x64_sys_mount+0xe4/0x140 fs/namespace.c:3863
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages mm/mempolicy.c:2204 [inline]
 folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
 filemap_alloc_folio+0xa5/0x430 mm/filemap.c:974
 do_read_cache_folio+0x163/0x11e0 mm/filemap.c:3655
 do_read_cache_page mm/filemap.c:3757 [inline]
 read_cache_page+0x63/0x1c0 mm/filemap.c:3766
 read_mapping_page include/linux/pagemap.h:871 [inline]
 ntfs_map_page fs/ntfs/aops.h:75 [inline]
 check_mft_mirror fs/ntfs/super.c:1117 [inline]
 load_system_files+0x985/0x97b0 fs/ntfs/super.c:1780
 ntfs_fill_super+0x307e/0x45d0 fs/ntfs/super.c:2900
 mount_bdev+0x3d7/0x560 fs/super.c:1650
 ntfs_mount+0x4d/0x60 fs/ntfs/super.c:3057
 legacy_get_tree+0x110/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa5/0x520 fs/super.c:1771
 do_new_mount+0x68d/0x1550 fs/namespace.c:3337
 path_mount+0x73d/0x1f20 fs/namespace.c:3664
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3863
 __x64_sys_mount+0xe4/0x140 fs/namespace.c:3863
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 6133 Comm: syz-executor.1 Not tainted 6.7.0-rc6-syzkaller-00022-g55cb5f43689d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
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

