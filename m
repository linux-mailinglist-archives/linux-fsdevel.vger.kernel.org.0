Return-Path: <linux-fsdevel+bounces-7644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D14828C53
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 19:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179471F27514
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 18:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5D13C473;
	Tue,  9 Jan 2024 18:17:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48CD3C068
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35ff5a2f9c0so29980135ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jan 2024 10:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824255; x=1705429055;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RiahJxs7SPtt+UudYmhc+t36HoMS9MKqIrVEkKF6S2U=;
        b=HePApOWNwav2xrrqzU4NBg3XYkgPGEnJHT6ONTtj3KVH0pYsPiEKBtN/3cahG2BnsM
         u7OaTAo1Mtudtqygwg6QvSL73NtFLjih/l5DR00Cwfu8Siy+4Vo1Hg4F5LZ8jahnXAkl
         AoHmqJMnEnB5m7P8BQozNKSc3sd2tBahGx3K47D4jtN1t2kOM29ceYuPBBiRUkU2VWRO
         8Dj3YCH+wrLoicbgeL5XmwSboP1Gt18aI5oT8WvagUHYPuQCKSRx/uZ8yq9Aa87ywjZH
         lFMKjvbk3HOh0D0w36xopNr3NrzKATR0kpHMOsY82HJ08XQfRMkkrVIvL1AwfUfFPKFt
         +Umg==
X-Gm-Message-State: AOJu0YzU65lHV7jAb1s06EARW7Kjx1waFdYYv7sURrsyeCH/WCtyE8yo
	82IhvEKxrklb2XqXPaaDemiCuVirk9mTpeLxELu+Y+eqC1DRFC0=
X-Google-Smtp-Source: AGHT+IEht9I3VrjRx9VKsqPry6iSom3FtiB9hpIwihdDWriWj3Fo4UygZb8QcsO3QrSrJ7HD4rBxNAf+ymvvMJ1/XPdDkfHW3UeK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cb:b0:360:f2c:cde6 with SMTP id
 z11-20020a056e0217cb00b003600f2ccde6mr755040ilu.6.1704824255096; Tue, 09 Jan
 2024 10:17:35 -0800 (PST)
Date: Tue, 09 Jan 2024 10:17:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000212ec9060e8754e2@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_lookup
From: syzbot <syzbot+91db973302e7b18c7653@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    861deac3b092 Linux 6.7-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=103d9131e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=91db973302e7b18c7653
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15dd9e81e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134b9595e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ea60ee8ed32/disk-861deac3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d69fdc33021/vmlinux-861deac3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0158750d452/bzImage-861deac3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/77e776893084/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91db973302e7b18c7653@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
=====================================================
BUG: KMSAN: uninit-value in hfsplus_lookup+0x66b/0xef0 fs/hfsplus/dir.c:83
 hfsplus_lookup+0x66b/0xef0 fs/hfsplus/dir.c:83
 lookup_open fs/namei.c:3455 [inline]
 open_last_lookups fs/namei.c:3546 [inline]
 path_openat+0x27d3/0x5c70 fs/namei.c:3776
 do_filp_open+0x20d/0x590 fs/namei.c:3809
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_creat fs/open.c:1528 [inline]
 __se_sys_creat fs/open.c:1522 [inline]
 __x64_sys_creat+0xe6/0x140 fs/open.c:1522
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages+0x1be/0x1e0 mm/mempolicy.c:2204
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x421/0x1570 mm/slub.c:2070
 ___slab_alloc+0x13db/0x33d0 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc_lru+0x552/0x970 mm/slub.c:3509
 alloc_inode_sb include/linux/fs.h:2937 [inline]
 hfsplus_alloc_inode+0x5a/0xc0 fs/hfsplus/super.c:627
 alloc_inode+0x83/0x440 fs/inode.c:261
 iget_locked+0x2dd/0xe80 fs/inode.c:1316
 hfsplus_iget+0x59/0xaf0 fs/hfsplus/super.c:64
 hfsplus_btree_open+0x13e/0x1d00 fs/hfsplus/btree.c:150
 hfsplus_fill_super+0x1113/0x26f0 fs/hfsplus/super.c:473
 mount_bdev+0x3d7/0x560 fs/super.c:1650
 hfsplus_mount+0x4d/0x60 fs/hfsplus/super.c:641
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

CPU: 0 PID: 5008 Comm: syz-executor168 Not tainted 6.7.0-rc7-syzkaller #0
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

