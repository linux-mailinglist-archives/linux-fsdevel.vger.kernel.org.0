Return-Path: <linux-fsdevel+bounces-2770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E263E7E8F50
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 10:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5E21C20828
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417AA63D3;
	Sun, 12 Nov 2023 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C0B5238
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 09:21:06 +0000 (UTC)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C9730C5
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 01:21:05 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc3ad55c75so35481985ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 01:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699780865; x=1700385665;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVjrCTYRe2nvig3PfqBsiJOGikcayNigDKHyRd84JT0=;
        b=YCBF5VlJdSbzPYb7sYLckfApPESnGlWSpaGfGEcgAYuL8ulDGYtO1Hs2rFogN9XjM2
         SIQ4qA79ZmanlY/jDbs6K84UNzeDEmOoQyJVcMCvQCRyGwO4dTRkuH/6Dol6yTkEfNz9
         P2VY+jA4GmqpJQ4v/5P3hz6KZ7FgD6AUV/4MT8VroF3dqHxgQJxqeOJJJLUdRVtCJJE8
         3Wat8A8n4cQGRNhaaw0fo5ajVwZa79AQ5b9/sYQf2MPga1jsYm9yFCHIIU9gq8cte5F3
         wi0VUR82rsjXIYtf2CKTJIz5o86m+5QrIcQK9pxtxbvBgybuqjWjcieYpHSSIh7OWKlz
         Z4Sw==
X-Gm-Message-State: AOJu0Yz0/SGewqcyJGcQaFsES/4/up5JQ8YvfOZmSca3MaRtcBqh/BP1
	AOVFpS9E95bv6AYOP/ZmPccYIrBtQVuPffVAMnmYwq1/KiEA
X-Google-Smtp-Source: AGHT+IEu+yITQdTApV4csEmOVbD15js3mHkSdQ+58WMD7ouB8zTRrneXIPdqDIfkThrK6y/KShstLZZ7saAT7O6pJqAevaRhxkvc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:1301:b0:1cc:c462:d4ce with SMTP id
 iy1-20020a170903130100b001ccc462d4cemr1231200plb.11.1699780865041; Sun, 12
 Nov 2023 01:21:05 -0800 (PST)
Date: Sun, 12 Nov 2023 01:21:04 -0800
In-Reply-To: <CAOQ4uxh3i=eLJZeNu7VWS9L7OaVVRgyX9Yqr5hx15h9dYmWaXQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a82c860609f1124d@google.com>
Subject: Re: [syzbot] [overlayfs?] memory leak in ovl_parse_param
From: syzbot <syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in ovl_parse_param

BUG: memory leak
unreferenced object 0xffff88814002d0c8 (size 8):
  comm "syz-executor.0", pid 5498, jiffies 4294944229 (age 12.660s)
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
    [<ffffffff81d0424e>] ovl_parse_param_lowerdir fs/overlayfs/params.c:496 [inline]
    [<ffffffff81d0424e>] ovl_parse_param+0x70e/0xc60 fs/overlayfs/params.c:576
    [<ffffffff817053ab>] vfs_parse_fs_param+0xfb/0x190 fs/fs_context.c:146
    [<ffffffff817054d6>] vfs_parse_fs_string+0x96/0xd0 fs/fs_context.c:188
    [<ffffffff817055ef>] vfs_parse_monolithic_sep+0xdf/0x130 fs/fs_context.c:230
    [<ffffffff816dfe88>] do_new_mount fs/namespace.c:3333 [inline]
    [<ffffffff816dfe88>] path_mount+0xc48/0x10d0 fs/namespace.c:3664
    [<ffffffff816e0ac1>] do_mount fs/namespace.c:3677 [inline]
    [<ffffffff816e0ac1>] __do_sys_mount fs/namespace.c:3886 [inline]
    [<ffffffff816e0ac1>] __se_sys_mount fs/namespace.c:3863 [inline]
    [<ffffffff816e0ac1>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3863
    [<ffffffff84b67d8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b67d8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff8881009ec0c8 (size 8):
  comm "syz-executor.0", pid 5752, jiffies 4294944765 (age 7.300s)
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
    [<ffffffff81d0424e>] ovl_parse_param_lowerdir fs/overlayfs/params.c:496 [inline]
    [<ffffffff81d0424e>] ovl_parse_param+0x70e/0xc60 fs/overlayfs/params.c:576
    [<ffffffff817053ab>] vfs_parse_fs_param+0xfb/0x190 fs/fs_context.c:146
    [<ffffffff817054d6>] vfs_parse_fs_string+0x96/0xd0 fs/fs_context.c:188
    [<ffffffff817055ef>] vfs_parse_monolithic_sep+0xdf/0x130 fs/fs_context.c:230
    [<ffffffff816dfe88>] do_new_mount fs/namespace.c:3333 [inline]
    [<ffffffff816dfe88>] path_mount+0xc48/0x10d0 fs/namespace.c:3664
    [<ffffffff816e0ac1>] do_mount fs/namespace.c:3677 [inline]
    [<ffffffff816e0ac1>] __do_sys_mount fs/namespace.c:3886 [inline]
    [<ffffffff816e0ac1>] __se_sys_mount fs/namespace.c:3863 [inline]
    [<ffffffff816e0ac1>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3863
    [<ffffffff84b67d8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b67d8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff8881009ec0e0 (size 8):
  comm "syz-executor.0", pid 5754, jiffies 4294944766 (age 7.290s)
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
    [<ffffffff81d0424e>] ovl_parse_param_lowerdir fs/overlayfs/params.c:496 [inline]
    [<ffffffff81d0424e>] ovl_parse_param+0x70e/0xc60 fs/overlayfs/params.c:576
    [<ffffffff817053ab>] vfs_parse_fs_param+0xfb/0x190 fs/fs_context.c:146
    [<ffffffff817054d6>] vfs_parse_fs_string+0x96/0xd0 fs/fs_context.c:188
    [<ffffffff817055ef>] vfs_parse_monolithic_sep+0xdf/0x130 fs/fs_context.c:230
    [<ffffffff816dfe88>] do_new_mount fs/namespace.c:3333 [inline]
    [<ffffffff816dfe88>] path_mount+0xc48/0x10d0 fs/namespace.c:3664
    [<ffffffff816e0ac1>] do_mount fs/namespace.c:3677 [inline]
    [<ffffffff816e0ac1>] __do_sys_mount fs/namespace.c:3886 [inline]
    [<ffffffff816e0ac1>] __se_sys_mount fs/namespace.c:3863 [inline]
    [<ffffffff816e0ac1>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3863
    [<ffffffff84b67d8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b67d8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b



Tested on:

commit:         3f653af2 ovl: fix memory leak in ovl_parse_param()
git tree:       https://github.com/amir73il/linux ovl-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=13a07ea7680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecfdf78a410c834
dashboard link: https://syzkaller.appspot.com/bug?extid=26eedf3631650972f17c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

