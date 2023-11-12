Return-Path: <linux-fsdevel+bounces-2760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 426397E8E43
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 05:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639D21C2084A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 04:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EBC1FD9;
	Sun, 12 Nov 2023 04:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069961FA5
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 04:18:27 +0000 (UTC)
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DDE30EB
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Nov 2023 20:18:25 -0800 (PST)
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-6c337818f4cso3459228b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Nov 2023 20:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699762705; x=1700367505;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWEoTwBlXjGTTrl0xPgTiw5vgCy7bqROUuWjF1tWseI=;
        b=wduSdPM9wxFqD18TVeCrTOeejDy6rgaqttRkneXzuDsJQmPvoqHRNZ4PO5SugNHVbU
         Su+dJYj/LI4xLK1ZGIRRLkIN8MXvl5owAUxc3MQy4y2IgCWorkomy9a5aEhDM0W/29CF
         in8XxhWMvS2nI/FQ7VRSFgRp+iZxxElV+34ItVMfXJi5KkWD++JP9V8aIjj+48xpQIHk
         nU6d9vMh2bSwaPOKxHLJo7w7ZL6Wt8mi8Dn7lnVmxqx7suovkgiQkAxK3jbPxuFtV01j
         giPC042MnuQyKlji19lHycohDVI7vmueUb4fVtzSFdrrJGOKFZ4sklzsdzklWfN4u9aR
         2czw==
X-Gm-Message-State: AOJu0YycXzntv7JPi3CDhWvy2VOTMT44X0FbLwLtrib9exxHFoPN+rwK
	kzvCNh8JAdUmn3bjv+YpLA4+XwUqztbXbQiKVbyrvUIBj6Z/
X-Google-Smtp-Source: AGHT+IHZ5YatetUTXqQsCd+tFcdXeuEetfUkqDqzA7IEbmiUgUyTV1jGMi+vSA4VND+qs4KiCqLnYHoIb85f+QrAzPtMoM9IiM0R
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1884:b0:6c6:b762:ad8a with SMTP id
 x4-20020a056a00188400b006c6b762ad8amr574179pfh.0.1699762705017; Sat, 11 Nov
 2023 20:18:25 -0800 (PST)
Date: Sat, 11 Nov 2023 20:18:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c31650609ecd824@google.com>
Subject: [syzbot] [overlayfs?] memory leak in ovl_parse_param
From: syzbot <syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    13d88ac54ddd Merge tag 'vfs-6.7.fsid' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121cf047680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecfdf78a410c834
dashboard link: https://syzkaller.appspot.com/bug?extid=26eedf3631650972f17c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c7a6eb680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f8b787680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9bb27a01f17c/disk-13d88ac5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fb496feed171/vmlinux-13d88ac5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f4da22719ffa/bzImage-13d88ac5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff8881009b40a8 (size 8):
  comm "syz-executor225", pid 5035, jiffies 4294944336 (age 13.730s)
  hex dump (first 8 bytes):
    2e 00 00 00 00 00 00 00                          ........
  backtrace:
    [<ffffffff8163331d>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff8163331d>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff8163331d>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff8163331d>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157e57c>] __do_kmalloc_node mm/slab_common.c:1006 [inline]
    [<ffffffff8157e57c>] __kmalloc_node_track_caller+0x4c/0x150 mm/slab_common.c:1027
    [<ffffffff8156da4c>] kstrdup+0x3c/0x70 mm/util.c:62
    [<ffffffff81d0438a>] ovl_parse_param_lowerdir fs/overlayfs/params.c:496 [inline]
    [<ffffffff81d0438a>] ovl_parse_param+0x70a/0xc70 fs/overlayfs/params.c:576
    [<ffffffff8170542b>] vfs_parse_fs_param+0xfb/0x190 fs/fs_context.c:146
    [<ffffffff81705556>] vfs_parse_fs_string+0x96/0xd0 fs/fs_context.c:188
    [<ffffffff8170566f>] vfs_parse_monolithic_sep+0xdf/0x130 fs/fs_context.c:230
    [<ffffffff816dff08>] do_new_mount fs/namespace.c:3333 [inline]
    [<ffffffff816dff08>] path_mount+0xc48/0x10d0 fs/namespace.c:3664
    [<ffffffff816e0b41>] do_mount fs/namespace.c:3677 [inline]
    [<ffffffff816e0b41>] __do_sys_mount fs/namespace.c:3886 [inline]
    [<ffffffff816e0b41>] __se_sys_mount fs/namespace.c:3863 [inline]
    [<ffffffff816e0b41>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3863
    [<ffffffff84b67d8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b67d8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88814002d070 (size 8):
  comm "syz-executor225", pid 5036, jiffies 4294944900 (age 8.090s)
  hex dump (first 8 bytes):
    2e 00 00 00 00 00 00 00                          ........
  backtrace:
    [<ffffffff8163331d>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff8163331d>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff8163331d>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff8163331d>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157e57c>] __do_kmalloc_node mm/slab_common.c:1006 [inline]
    [<ffffffff8157e57c>] __kmalloc_node_track_caller+0x4c/0x150 mm/slab_common.c:1027
    [<ffffffff8156da4c>] kstrdup+0x3c/0x70 mm/util.c:62
    [<ffffffff81d0438a>] ovl_parse_param_lowerdir fs/overlayfs/params.c:496 [inline]
    [<ffffffff81d0438a>] ovl_parse_param+0x70a/0xc70 fs/overlayfs/params.c:576
    [<ffffffff8170542b>] vfs_parse_fs_param+0xfb/0x190 fs/fs_context.c:146
    [<ffffffff81705556>] vfs_parse_fs_string+0x96/0xd0 fs/fs_context.c:188
    [<ffffffff8170566f>] vfs_parse_monolithic_sep+0xdf/0x130 fs/fs_context.c:230
    [<ffffffff816dff08>] do_new_mount fs/namespace.c:3333 [inline]
    [<ffffffff816dff08>] path_mount+0xc48/0x10d0 fs/namespace.c:3664
    [<ffffffff816e0b41>] do_mount fs/namespace.c:3677 [inline]
    [<ffffffff816e0b41>] __do_sys_mount fs/namespace.c:3886 [inline]
    [<ffffffff816e0b41>] __se_sys_mount fs/namespace.c:3863 [inline]
    [<ffffffff816e0b41>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3863
    [<ffffffff84b67d8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b67d8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b



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

