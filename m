Return-Path: <linux-fsdevel+bounces-6953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE41C81EEC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 13:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D661F220FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 12:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1140446D6;
	Wed, 27 Dec 2023 12:12:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABD4446C6
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Dec 2023 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35ffefe1f5cso27793905ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Dec 2023 04:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703679144; x=1704283944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5IDQmVehXMnABlPMFwv2yxsr22rrMztxhav0QRoFr4=;
        b=sB/uymf1YjtDZ9WkZ7aw/o3/RIa/j4fxvyLyouAs/V2C4bAPzTsumAHaCbUDW4vmCG
         ZJ2W5IyNUz1SoP2l74X9vi6qnxETuLc1OChB8C2qzhR+VqSrAzLEPaiO6xKPVr8gNrnr
         6ka1yl715Aj9C4HombclOJ4SDZ33CJVf38A6P26IhWk/K1fz/4Xoj8J+0asEEXsdy7Rs
         3a/9VjftSpqnAnTSDXzwAarGX/9mKyJY3QOv8X7trUsO8c1/8eUw/xabPfX6v87YB7DQ
         1HTMu8xmZo3w+8FNQSXyAMVNPE8zoqROTqvoA+juX3U7GJ4A79ImaWbhfCYmnECL2Ub9
         eO8A==
X-Gm-Message-State: AOJu0Ywp85NUuer2mq6CfS3vehBr8EkMkpE6mioJ2MXsx47Aj6jHmqMY
	eJoqJZ4ZVMJOG65lnh+ZeCqvWb8wS/WID+Wslkufgj7bNPU9
X-Google-Smtp-Source: AGHT+IG+xocUf1/BhKuKWYImJfxU0USYtTDs19LgIGsGjmu5cm+/MA9346oDcbLsZCJpxVd9zj4dJsnaHT0zMzGh/gQpqFCZhQVu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d18:b0:35f:f01e:bb32 with SMTP id
 i24-20020a056e021d1800b0035ff01ebb32mr840244ila.4.1703679144122; Wed, 27 Dec
 2023 04:12:24 -0800 (PST)
Date: Wed, 27 Dec 2023 04:12:24 -0800
In-Reply-To: <000000000000daec33060d6bc380@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003260c1060d7cb673@google.com>
Subject: Re: [syzbot] [ntfs?] KMSAN: uninit-value in post_read_mst_fixup (2)
From: syzbot <syzbot+82248056430fd49210e9@syzkaller.appspotmail.com>
To: anton@tuxera.com, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=170a9f76e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=82248056430fd49210e9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173c705ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1410147ee80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1520f7b6daa4/disk-fbafc3e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b490af009d5/vmlinux-fbafc3e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/202ca200f4a4/bzImage-fbafc3e6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a03c45c57d87/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+82248056430fd49210e9@syzkaller.appspotmail.com

ntfs: (device loop0): ntfs_read_locked_inode(): Failed with error code -2.  Marking corrupt inode 0xa as bad.  Run chkdsk.
ntfs: (device loop0): load_and_init_upcase(): Failed to load $UpCase from the volume. Using default.
ntfs: volume version 3.1.
ntfs: (device loop0): ntfs_mapping_pairs_decompress(): Corrupt attribute.
syz-executor416: attempt to access beyond end of device
loop0: rw=0, sector=552, nr_sectors = 8 limit=190
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
 ntfs_lookup_inode_by_name+0x1d97/0x50d0 fs/ntfs/dir.c:308
 check_windows_hibernation_status+0xc4/0xca0 fs/ntfs/super.c:1282
 load_system_files+0x6d84/0x97b0 fs/ntfs/super.c:1997
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
 ntfs_lookup_inode_by_name+0x1d97/0x50d0 fs/ntfs/dir.c:308
 check_windows_hibernation_status+0xc4/0xca0 fs/ntfs/super.c:1282
 load_system_files+0x6d84/0x97b0 fs/ntfs/super.c:1997
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

CPU: 1 PID: 5006 Comm: syz-executor416 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

