Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5843212C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 10:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhBVJHl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 04:07:41 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:52815 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhBVJGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:06:55 -0500
Received: by mail-io1-f72.google.com with SMTP id v5so1183788ioq.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Feb 2021 01:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SnPAfYRAYGtfnVs6B/o8MLHL0hcsdQDCUmNnokrQL7o=;
        b=jliRHi8x1mHC5kC7tbxR4M460lKWzUD5sy9stBYZl0pixgCDkxXh6kkcoKsSBeWPZl
         3gCywXvdFy/nRpPHKmXHh/p18JF150ZXoNmxy6mGr0A9WtaP3QTi5a6deg6b0g60s6S1
         t7LMb3YQXAOKgfz6TTNPIPJ6c1OhmQtWCYU/BzedLvEHKReyCFdEjgsUqH0ncl+TvsFl
         Kr8w64c9vervuSrgHIZTzOQ6k3yOs+CkGs1WumyNlqxxsLpogYSAWmtlU9QMQ1rAxpK4
         4KL2C43x0/IY6cDq2VQ5NgbSerKvJCS9JMhzG85ckacF72MaVoq7h6hZJ70hIgjATru7
         O1JQ==
X-Gm-Message-State: AOAM533kWUr6kdZY86e5CxkjS5P8Mt0AsAs/edbirLwUHEITU46wol3y
        3KXKR5f8giWQSa47RbSVYbrKuopOiodL6GfwO0G9LtZ4sdOM
X-Google-Smtp-Source: ABdhPJwmxkJjRFeNvq2UYxQJReoERu+QZLrYkYc09f0SI6K1RXT5HU/mr/PVvn51bznq8aJQtYH2OmmxLM11pvYMTnZlvAAQNXfy
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d8a:: with SMTP id l10mr21309377jaj.2.1613984774045;
 Mon, 22 Feb 2021 01:06:14 -0800 (PST)
Date:   Mon, 22 Feb 2021 01:06:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002142f605bbe91dc8@google.com>
Subject: memory leak in iget_locked
From:   syzbot <syzbot+739e5b9d4646ff8618a9@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f40ddce8 Linux 5.11
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e1a434d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5528e8db7fc481ae
dashboard link: https://syzkaller.appspot.com/bug?extid=739e5b9d4646ff8618a9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10aeddd2d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+739e5b9d4646ff8618a9@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810ffd32e0 (size 608):
  comm "systemd", pid 1, jiffies 4294966945 (age 26.710s)
  hex dump (first 32 bytes):
    80 80 0c 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000159405a6>] alloc_inode+0xbe/0x100 fs/inode.c:235
    [<00000000a1ba61ba>] iget_locked+0x126/0x340 fs/inode.c:1192
    [<0000000058bf69d6>] kernfs_get_inode+0x20/0x190 fs/kernfs/inode.c:252
    [<0000000038d3c844>] kernfs_iop_lookup+0xa0/0xe0 fs/kernfs/dir.c:1100
    [<00000000f316b4af>] lookup_open fs/namei.c:3085 [inline]
    [<00000000f316b4af>] open_last_lookups fs/namei.c:3180 [inline]
    [<00000000f316b4af>] path_openat+0x95d/0x1b00 fs/namei.c:3368
    [<00000000952158a9>] do_filp_open+0xa0/0x190 fs/namei.c:3398
    [<00000000ca8d298d>] do_sys_openat2+0xed/0x230 fs/open.c:1172
    [<00000000be6807df>] do_sys_open fs/open.c:1188 [inline]
    [<00000000be6807df>] __do_sys_open fs/open.c:1196 [inline]
    [<00000000be6807df>] __se_sys_open fs/open.c:1192 [inline]
    [<00000000be6807df>] __x64_sys_open+0x7d/0xe0 fs/open.c:1192
    [<00000000ea2012e0>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000e7253572>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888111bd1ab0 (size 24):
  comm "systemd", pid 1, jiffies 4294966945 (age 26.710s)
  hex dump (first 24 bytes):
    18 34 fd 0f 81 88 ff ff 90 e3 09 82 ff ff ff ff  .4..............
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<00000000c34be1ab>] kmem_cache_zalloc include/linux/slab.h:672 [inline]
    [<00000000c34be1ab>] lsm_inode_alloc security/security.c:590 [inline]
    [<00000000c34be1ab>] security_inode_alloc+0x2a/0xb0 security/security.c:973
    [<00000000682cda2f>] inode_init_always+0x10c/0x250 fs/inode.c:170
    [<00000000b63896fb>] alloc_inode+0x44/0x100 fs/inode.c:240
    [<00000000a1ba61ba>] iget_locked+0x126/0x340 fs/inode.c:1192
    [<0000000058bf69d6>] kernfs_get_inode+0x20/0x190 fs/kernfs/inode.c:252
    [<0000000038d3c844>] kernfs_iop_lookup+0xa0/0xe0 fs/kernfs/dir.c:1100
    [<00000000f316b4af>] lookup_open fs/namei.c:3085 [inline]
    [<00000000f316b4af>] open_last_lookups fs/namei.c:3180 [inline]
    [<00000000f316b4af>] path_openat+0x95d/0x1b00 fs/namei.c:3368
    [<00000000952158a9>] do_filp_open+0xa0/0x190 fs/namei.c:3398
    [<00000000ca8d298d>] do_sys_openat2+0xed/0x230 fs/open.c:1172
    [<00000000be6807df>] do_sys_open fs/open.c:1188 [inline]
    [<00000000be6807df>] __do_sys_open fs/open.c:1196 [inline]
    [<00000000be6807df>] __se_sys_open fs/open.c:1192 [inline]
    [<00000000be6807df>] __x64_sys_open+0x7d/0xe0 fs/open.c:1192
    [<00000000ea2012e0>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000e7253572>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810ffd8ce0 (size 608):
  comm "systemd", pid 1, jiffies 4294966945 (age 26.710s)
  hex dump (first 32 bytes):
    a4 81 0c 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000159405a6>] alloc_inode+0xbe/0x100 fs/inode.c:235
    [<00000000a1ba61ba>] iget_locked+0x126/0x340 fs/inode.c:1192
    [<0000000058bf69d6>] kernfs_get_inode+0x20/0x190 fs/kernfs/inode.c:252
    [<0000000038d3c844>] kernfs_iop_lookup+0xa0/0xe0 fs/kernfs/dir.c:1100
    [<00000000f316b4af>] lookup_open fs/namei.c:3085 [inline]
    [<00000000f316b4af>] open_last_lookups fs/namei.c:3180 [inline]
    [<00000000f316b4af>] path_openat+0x95d/0x1b00 fs/namei.c:3368
    [<00000000952158a9>] do_filp_open+0xa0/0x190 fs/namei.c:3398
    [<00000000ca8d298d>] do_sys_openat2+0xed/0x230 fs/open.c:1172
    [<00000000be6807df>] do_sys_open fs/open.c:1188 [inline]
    [<00000000be6807df>] __do_sys_open fs/open.c:1196 [inline]
    [<00000000be6807df>] __se_sys_open fs/open.c:1192 [inline]
    [<00000000be6807df>] __x64_sys_open+0x7d/0xe0 fs/open.c:1192
    [<00000000ea2012e0>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000e7253572>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810ed17e28 (size 24):
  comm "systemd", pid 1, jiffies 4294966945 (age 26.710s)
  hex dump (first 24 bytes):
    18 8e fd 0f 81 88 ff ff 90 e3 09 82 ff ff ff ff  ................
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<00000000c34be1ab>] kmem_cache_zalloc include/linux/slab.h:672 [inline]
    [<00000000c34be1ab>] lsm_inode_alloc security/security.c:590 [inline]
    [<00000000c34be1ab>] security_inode_alloc+0x2a/0xb0 security/security.c:973
    [<00000000682cda2f>] inode_init_always+0x10c/0x250 fs/inode.c:170
    [<00000000b63896fb>] alloc_inode+0x44/0x100 fs/inode.c:240
    [<00000000a1ba61ba>] iget_locked+0x126/0x340 fs/inode.c:1192
    [<0000000058bf69d6>] kernfs_get_inode+0x20/0x190 fs/kernfs/inode.c:252
    [<0000000038d3c844>] kernfs_iop_lookup+0xa0/0xe0 fs/kernfs/dir.c:1100
    [<00000000f316b4af>] lookup_open fs/namei.c:3085 [inline]
    [<00000000f316b4af>] open_last_lookups fs/namei.c:3180 [inline]
    [<00000000f316b4af>] path_openat+0x95d/0x1b00 fs/namei.c:3368
    [<00000000952158a9>] do_filp_open+0xa0/0x190 fs/namei.c:3398
    [<00000000ca8d298d>] do_sys_openat2+0xed/0x230 fs/open.c:1172
    [<00000000be6807df>] do_sys_open fs/open.c:1188 [inline]
    [<00000000be6807df>] __do_sys_open fs/open.c:1196 [inline]
    [<00000000be6807df>] __se_sys_open fs/open.c:1192 [inline]
    [<00000000be6807df>] __x64_sys_open+0x7d/0xe0 fs/open.c:1192
    [<00000000ea2012e0>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000e7253572>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

[  323.608401][  


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
