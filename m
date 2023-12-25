Return-Path: <linux-fsdevel+bounces-6904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F7381E1B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 18:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EEE28218E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA7652F7D;
	Mon, 25 Dec 2023 17:30:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8FA51C36
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Dec 2023 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7baa66ebd17so222921739f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Dec 2023 09:30:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703525427; x=1704130227;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDEbyFX/uNJ6pNOP9ps3wA3oswpBwZ/XfGpRR61rov4=;
        b=rOHLTas0NIp8aiPm6lKTqQx5plrD7n4lZW7LsKa+EelwuWIfNLSedIip3oQAy/g7m6
         GthupeWcT+PpZ7aDaciT6oX4d7fYslm2RyRwI09swRg5aWFqE09n/m1Y0SfBLL73WUmv
         B+yAZ5IdsmetCA8ODj/lhj1I8CmQO310sdlg2dRzcfwT6SM1C3qWel1bD8Bwxm5wU9uo
         SQcAC4trO1WHZGYyosqL0ndNMutHeTjIL2ZALgXuNCp1gzDH8+1G3nmfQkyFaTF0qFP3
         Qh5LxvO5rvA/vvG49tkaxmkHttHsCBxYA2/wWHY7lcWYR4deFs+si/dslnSEQD+qp1By
         gfNA==
X-Gm-Message-State: AOJu0YwWonXmaans63rL9FBKrwThh2IYPOleJIwRO2AaAMEKuQMt6AfW
	o/OkcSdKCegw8eqLKM2V4nqajfuyMPsc3UfvMNkw94+S8ruO
X-Google-Smtp-Source: AGHT+IFwTo/+8gy+Oz0fJprtvcSjjIo2Py45r/qiX0KlgP+HNDvyBWaS9NoonUnchP7BP014ovlSq3Vg7QzKzISe6Xfxb7OIZHbM
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2dd0:b0:46d:5a:a467 with SMTP id
 gt16-20020a0566382dd000b0046d005aa467mr173464jab.4.1703525425507; Mon, 25 Dec
 2023 09:30:25 -0800 (PST)
Date: Mon, 25 Dec 2023 09:30:25 -0800
In-Reply-To: <00000000000027f81605ee31ab88@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da757a060d58ebbe@google.com>
Subject: Re: [syzbot] [reiserfs?] KMSAN: uninit-value in reiserfs_new_inode (2)
From: syzbot <syzbot+6450929faa7a97cd42d1@syzkaller.appspotmail.com>
To: brauner@kernel.org, damien.lemoal@opensource.wdc.com, 
	edward.shishkin@gmail.com, glider@google.com, jack@suse.cz, 
	jlayton@kernel.org, linuszeng@tencent.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    861deac3b092 Linux 6.7-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12057ecee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=6450929faa7a97cd42d1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14836ca1e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159e1e16e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ea60ee8ed32/disk-861deac3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d69fdc33021/vmlinux-861deac3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0158750d452/bzImage-861deac3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/dcd887118b46/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6450929faa7a97cd42d1@syzkaller.appspotmail.com

REISERFS warning (device loop0): vs-13060 reiserfs_update_sd_size: stat data of object [1 2 0x0 SD] (nlink == 1) not found (pos 2)
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
=====================================================
BUG: KMSAN: uninit-value in reiserfs_new_inode+0x16cd/0x20f0 fs/reiserfs/inode.c:2044
 reiserfs_new_inode+0x16cd/0x20f0 fs/reiserfs/inode.c:2044
 reiserfs_create+0x674/0xcb0 fs/reiserfs/namei.c:666
 xattr_create fs/reiserfs/xattr.c:70 [inline]
 xattr_lookup+0x3ee/0x5e0 fs/reiserfs/xattr.c:413
 reiserfs_xattr_set_handle+0xe7/0x21b0 fs/reiserfs/xattr.c:535
 reiserfs_xattr_set+0x670/0x7f0 fs/reiserfs/xattr.c:635
 trusted_set+0x112/0x190 fs/reiserfs/xattr_trusted.c:31
 __vfs_setxattr+0x7aa/0x8b0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x24f/0xa30 fs/xattr.c:235
 __vfs_setxattr_locked+0x441/0x480 fs/xattr.c:296
 vfs_setxattr+0x294/0x650 fs/xattr.c:322
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x45f/0x540 fs/xattr.c:653
 path_setxattr+0x1f5/0x3c0 fs/xattr.c:672
 __do_sys_setxattr fs/xattr.c:688 [inline]
 __se_sys_setxattr fs/xattr.c:684 [inline]
 __x64_sys_setxattr+0xf7/0x180 fs/xattr.c:684
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
 reiserfs_alloc_inode+0x62/0x150 fs/reiserfs/super.c:642
 alloc_inode+0x83/0x440 fs/inode.c:261
 iget5_locked+0xa9/0x210 fs/inode.c:1271
 reiserfs_fill_super+0x2109/0x39d0 fs/reiserfs/super.c:2053
 mount_bdev+0x3d7/0x560 fs/super.c:1650
 get_super_block+0x4d/0x60 fs/reiserfs/super.c:2601
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

CPU: 1 PID: 5006 Comm: syz-executor185 Not tainted 6.7.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

