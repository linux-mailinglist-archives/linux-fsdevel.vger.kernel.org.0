Return-Path: <linux-fsdevel+bounces-7696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819DF82971B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 11:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAF8282C04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 10:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959183FB0E;
	Wed, 10 Jan 2024 10:16:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA70F3F8E6
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7beeb9acd59so92200239f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 02:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704881787; x=1705486587;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5/j67+kQ+bcaF7cSN8tiUBI+F9SoIb7yqu3oMXsr0w=;
        b=OyrRIWAdT/5LIh5ErnnIQiovdK96XlkkCzAqgi2CIM8AyzeoMFr8pOVJVRpsZSZMvG
         eiCK4WaluUzw8LYREdW0Uc3X7hOzranFckMi0x0P7VVwrQeo3/ZLqhlNwzt9XdausniA
         bMO8Q2pOiAFWrxuwn3Ndlt681UvDXmsXHKW9tyOMJFTysKxJrq8e+MrCsin5h7FWbmDe
         nCEGdqHnSC18idNPsTfUck5rZCu5lGRm4D/U89WmaGEkHycW5e2tjQqmrZIu7odPDLGB
         uCBiyeIHuaOVULxCUbiMbbEM3+/4JKXy9VKd9PvVCax0DHgFSFfkJ8ugz6OHlHhgPYha
         rZIg==
X-Gm-Message-State: AOJu0Yzgn71lRS5u6unnLnsVU4TvD4l13ASEaLkXP484DA3leCYWLy1y
	ov4TpkT9jGbsyPe4xHhJE3NrzMehk+zEx3/k2tPljmlg/jg7tkU=
X-Google-Smtp-Source: AGHT+IGCvQ7iqheeM7f7Faw4ZM+k5vT6V5iFA3XWpPnmJWUubvlHq0zLFb96i+Ys9hoX/fgPq1i48ix+g77Nv7QDUhNZWRDwmm8c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216b:b0:360:795e:a6b3 with SMTP id
 s11-20020a056e02216b00b00360795ea6b3mr69756ilv.4.1704881787065; Wed, 10 Jan
 2024 02:16:27 -0800 (PST)
Date: Wed, 10 Jan 2024 02:16:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d5e29060e94b998@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in hfs_cat_keycmp (2)
From: syzbot <syzbot+04486d87f6240a004c85@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    610a9b8f49fb Linux 6.7-rc8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=163c9fb5e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e51fe20c3e51ba7f
dashboard link: https://syzkaller.appspot.com/bug?extid=04486d87f6240a004c85
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/daced691c987/disk-610a9b8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5e37367a7d1e/vmlinux-610a9b8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/013b65c960ab/bzImage-610a9b8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+04486d87f6240a004c85@syzkaller.appspotmail.com

hfs: filesystem is marked locked, mounting read-only.
=====================================================
BUG: KMSAN: uninit-value in hfs_cat_keycmp+0x154/0x210 fs/hfs/catalog.c:178
 hfs_cat_keycmp+0x154/0x210 fs/hfs/catalog.c:178
 __hfs_brec_find+0x250/0x820 fs/hfs/bfind.c:75
 hfs_brec_find+0x436/0x970 fs/hfs/bfind.c:138
 hfs_brec_read+0x3f/0x1a0 fs/hfs/bfind.c:165
 hfs_cat_find_brec+0xe6/0x400 fs/hfs/catalog.c:194
 hfs_fill_super+0x1f27/0x23c0 fs/hfs/super.c:419
 mount_bdev+0x3d7/0x560 fs/super.c:1650
 hfs_mount+0x4d/0x60 fs/hfs/super.c:456
 legacy_get_tree+0x110/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa5/0x520 fs/super.c:1771
 do_new_mount+0x68d/0x1550 fs/namespace.c:3337
 path_mount+0x73d/0x1f20 fs/namespace.c:3664
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3863
 __ia32_sys_mount+0xe3/0x150 fs/namespace.c:3863
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x5c9/0x970 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc+0x121/0x3c0 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 hfs_find_init+0x91/0x250 fs/hfs/bfind.c:21
 hfs_fill_super+0x1eb9/0x23c0 fs/hfs/super.c:416
 mount_bdev+0x3d7/0x560 fs/super.c:1650
 hfs_mount+0x4d/0x60 fs/hfs/super.c:456
 legacy_get_tree+0x110/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa5/0x520 fs/super.c:1771
 do_new_mount+0x68d/0x1550 fs/namespace.c:3337
 path_mount+0x73d/0x1f20 fs/namespace.c:3664
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3863
 __ia32_sys_mount+0xe3/0x150 fs/namespace.c:3863
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

CPU: 1 PID: 7246 Comm: syz-executor.0 Not tainted 6.7.0-rc8-syzkaller #0
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

