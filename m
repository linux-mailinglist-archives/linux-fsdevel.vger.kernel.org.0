Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60DD31D4D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 06:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhBQFV6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 00:21:58 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:46983 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhBQFV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 00:21:56 -0500
Received: by mail-il1-f198.google.com with SMTP id j5so9604334ila.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Feb 2021 21:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=E3eoy7X6NYdSUyASxFWq/l34y8qh1dJOGYcOLXWNHXk=;
        b=SdmS54aUh3yI484X7rQlMCVGVj9Pt0hSRtknvrm/igw1xYIZDhXFVfQcTodrQMAqPA
         u8nDLitAeA2xE/ghWiXfn2dA4djY346zazHxHzshIb5NnJlj88dazQXVuyuHDqbwy/4M
         CZJNTrjm/sF5RdUt9abO7kFcE8i4qf+K6StHGgL3CnzV2xgrIHlcHFj2GFRDOAXmKIkb
         qM0+1EfeJrcR2bXHP0Pw0RgzFsiTwx1WXHKH+up7bwjS5nXDlJbQXYd4UJKQFIKSovO/
         xfXz3O3eUTbBP4BntfuLcIzb9d/Sy+5kWpP4cjnFzPIY9asIFlkemomtfRJvv5Po0WKE
         NolQ==
X-Gm-Message-State: AOAM533YHqarYiHr1hCogT+umFH04daFKS0WiaEEoLrqlFw7EbTED/xv
        SN+SPOD79PLVM+vjcWtW5zGYGpxldKolfV1xYU+YOPecEM4h
X-Google-Smtp-Source: ABdhPJxCPz/OJ5G/8eSJMngJE4Pqi2mfoEUGY2izFroYFK9cTw37wDrqxAg/X4d8kuJc+h4t4aXZoRHCsdIq80YNaOLyBuTRvxN4
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13eb:: with SMTP id w11mr19135535ilj.103.1613539274519;
 Tue, 16 Feb 2021 21:21:14 -0800 (PST)
Date:   Tue, 16 Feb 2021 21:21:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000049fbd305bb816399@google.com>
Subject: memory leak in path_openat (2)
From:   syzbot <syzbot+921ef0ccfeed3a496721@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dcc0b490 Merge tag 'powerpc-5.11-8' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1316c614d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2fbb1a71525e1d5
dashboard link: https://syzkaller.appspot.com/bug?extid=921ef0ccfeed3a496721
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1378ba4cd00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e73fc2d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+921ef0ccfeed3a496721@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810ffa0780 (size 192):
  comm "systemd-udevd", pid 9109, jiffies 4294974202 (age 70.810s)
  hex dump (first 32 bytes):
    44 80 00 00 06 00 00 00 00 00 00 00 00 00 00 00  D...............
    00 00 00 00 00 00 00 00 c0 63 f1 0f 81 88 ff ff  .........c......
  backtrace:
    [<000000000f4d69f8>] __d_alloc+0x2a/0x270 fs/dcache.c:1716
    [<00000000a20f7fde>] d_alloc+0x25/0xd0 fs/dcache.c:1795
    [<000000007cbd02b4>] d_alloc_parallel+0x6b/0x940 fs/dcache.c:2547
    [<00000000fda6bfea>] lookup_open fs/namei.c:3033 [inline]
    [<00000000fda6bfea>] open_last_lookups fs/namei.c:3180 [inline]
    [<00000000fda6bfea>] path_openat+0xca3/0x1b00 fs/namei.c:3368
    [<00000000e92e3050>] do_filp_open+0xa0/0x190 fs/namei.c:3398
    [<00000000ca660767>] do_sys_openat2+0xed/0x230 fs/open.c:1172
    [<000000002fb778b6>] do_sys_open fs/open.c:1188 [inline]
    [<000000002fb778b6>] __do_sys_open fs/open.c:1196 [inline]
    [<000000002fb778b6>] __se_sys_open fs/open.c:1192 [inline]
    [<000000002fb778b6>] __x64_sys_open+0x7d/0xe0 fs/open.c:1192
    [<0000000011942ea6>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000076bff2b1>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810ffea360 (size 608):
  comm "systemd-udevd", pid 9109, jiffies 4294974202 (age 70.810s)
  hex dump (first 32 bytes):
    a4 81 0c 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000cbb42cce>] alloc_inode+0xbe/0x100 fs/inode.c:235
    [<00000000dc171831>] iget_locked+0x126/0x340 fs/inode.c:1192
    [<0000000025e74921>] kernfs_get_inode+0x20/0x190 fs/kernfs/inode.c:252
    [<000000008b802090>] kernfs_iop_lookup+0xa0/0xe0 fs/kernfs/dir.c:1100
    [<00000000e4bc5624>] lookup_open fs/namei.c:3085 [inline]
    [<00000000e4bc5624>] open_last_lookups fs/namei.c:3180 [inline]
    [<00000000e4bc5624>] path_openat+0x95d/0x1b00 fs/namei.c:3368
    [<00000000e92e3050>] do_filp_open+0xa0/0x190 fs/namei.c:3398
    [<00000000ca660767>] do_sys_openat2+0xed/0x230 fs/open.c:1172
    [<000000002fb778b6>] do_sys_open fs/open.c:1188 [inline]
    [<000000002fb778b6>] __do_sys_open fs/open.c:1196 [inline]
    [<000000002fb778b6>] __se_sys_open fs/open.c:1192 [inline]
    [<000000002fb778b6>] __x64_sys_open+0x7d/0xe0 fs/open.c:1192
    [<0000000011942ea6>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000076bff2b1>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810ec1b2b8 (size 24):
  comm "systemd-udevd", pid 9109, jiffies 4294974202 (age 70.810s)
  hex dump (first 24 bytes):
    98 a4 fe 0f 81 88 ff ff 30 e1 09 82 ff ff ff ff  ........0.......
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<00000000d6a1f02a>] kmem_cache_zalloc include/linux/slab.h:672 [inline]
    [<00000000d6a1f02a>] lsm_inode_alloc security/security.c:590 [inline]
    [<00000000d6a1f02a>] security_inode_alloc+0x2a/0xb0 security/security.c:973
    [<000000009366b0d8>] inode_init_always+0x10c/0x250 fs/inode.c:170
    [<00000000357b1464>] alloc_inode+0x44/0x100 fs/inode.c:240
    [<00000000dc171831>] iget_locked+0x126/0x340 fs/inode.c:1192
    [<0000000025e74921>] kernfs_get_inode+0x20/0x190 fs/kernfs/inode.c:252
    [<000000008b802090>] kernfs_iop_lookup+0xa0/0xe0 fs/kernfs/dir.c:1100
    [<00000000e4bc5624>] lookup_open fs/namei.c:3085 [inline]
    [<00000000e4bc5624>] open_last_lookups fs/namei.c:3180 [inline]
    [<00000000e4bc5624>] path_openat+0x95d/0x1b00 fs/namei.c:3368
    [<00000000e92e3050>] do_filp_open+0xa0/0x190 fs/namei.c:3398
    [<00000000ca660767>] do_sys_openat2+0xed/0x230 fs/open.c:1172
    [<000000002fb778b6>] do_sys_open fs/open.c:1188 [inline]
    [<000000002fb778b6>] __do_sys_open fs/open.c:1196 [inline]
    [<000000002fb778b6>] __se_sys_open fs/open.c:1192 [inline]
    [<000000002fb778b6>] __x64_sys_open+0x7d/0xe0 fs/open.c:1192
    [<0000000011942ea6>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000076bff2b1>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810ffc3f00 (size 192):
  comm "kdevtmpfs", pid 21, jiffies 4294974223 (age 70.600s)
  hex dump (first 32 bytes):
    08 80 00 00 06 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 90 56 00 81 88 ff ff  ..........V.....
  backtrace:
    [<000000000f4d69f8>] __d_alloc+0x2a/0x270 fs/dcache.c:1716
    [<00000000a20f7fde>] d_alloc+0x25/0xd0 fs/dcache.c:1795
    [<00000000e1f38abc>] __lookup_hash+0x77/0xd0 fs/namei.c:1441
    [<000000002b4d8a6a>] filename_create+0xc3/0x240 fs/namei.c:3470
    [<0000000049e829fd>] handle_create+0x49/0x28a drivers/base/devtmpfs.c:207
    [<0000000033a814c1>] handle drivers/base/devtmpfs.c:377 [inline]
    [<0000000033a814c1>] devtmpfs_work_loop drivers/base/devtmpfs.c:392 [inline]
    [<0000000033a814c1>] devtmpfsd+0x14e/0x1d3 drivers/base/devtmpfs.c:434
    [<00000000f978b357>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<000000000ea26e78>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

BUG: memory leak
unreferenced object 0xffff888114e342d0 (size 720):
  comm "kdevtmpfs", pid 21, jiffies 4294974223 (age 70.600s)
  hex dump (first 32 bytes):
    00 00 00 00 01 00 00 00 00 00 20 00 00 00 00 00  .......... .....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000d4c4e200>] shmem_alloc_inode+0x18/0x40 mm/shmem.c:3826
    [<00000000bbfd1b25>] alloc_inode+0x27/0x100 fs/inode.c:233
    [<00000000639a7c47>] new_inode_pseudo fs/inode.c:927 [inline]
    [<00000000639a7c47>] new_inode+0x23/0x100 fs/inode.c:956
    [<000000004e164ffa>] shmem_get_inode+0xcd/0x460 mm/shmem.c:2303
    [<00000000c3e9d654>] shmem_mknod+0x37/0x130 mm/shmem.c:2925
    [<0000000094c3aa16>] vfs_mknod+0x339/0x430 fs/namei.c:3554
    [<00000000a44105b5>] handle_create+0x1db/0x28a drivers/base/devtmpfs.c:215
    [<0000000033a814c1>] handle drivers/base/devtmpfs.c:377 [inline]
    [<0000000033a814c1>] devtmpfs_work_loop drivers/base/devtmpfs.c:392 [inline]
    [<0000000033a814c1>] devtmpfsd+0x14e/0x1d3 drivers/base/devtmpfs.c:434
    [<00000000f978b357>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<000000000ea26e78>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

BUG: memory leak
unreferenced object 0xffff88810ffa0780 (size 192):
  comm "systemd-udevd", pid 9109, jiffies 4294974202 (age 70.960s)
  hex dump (first 32 bytes):
    44 80 00 00 06 00 00 00 00 00 00 00 00 00 00 00  D...............
    00 00 00 00 00 00 00 00 c0 63 f1 0f 81 88 ff ff  .........c......
  backtrace:
    [<000000000f4d69f8>] __d_alloc+0x2a/0x270 fs/dcache.c:1716
    [<00000000a20f7fde>] d_alloc+0x25/0xd0 fs/dcache.c:1795
    [<000000007cbd02b4>] d_alloc_parallel+0x6b/0x940 fs/dcache.c:2547
    [<00000000fda6bfea>] lookup_open fs/namei.c:3033 [inline]
    [<00000000fda6bfea>] open_last_lookups fs/namei.c:3180 [inline]
    [<00000000fda6bfea>] path_openat+0xca3/0x1b00 fs/namei.c:3368
    [<00000000e92e3050>] do_filp_open+0xa0/0x190 fs/namei.c:3398
    [<00000000ca660767>] do_sys_openat2+0xed/0x230 fs/open.c:1172
    [<000000002fb778b6>] do_sys_open fs/open.c:1188 [inline]
    [<000000002fb778b6>] __do_sys_open fs/open.c:1196 [inline]
    [<000000002fb778b6>] __se_sys_open fs/open.c:1192 [inline]
    [<000000002fb778b6>] __x64_sys_open+0x7d/0xe0 fs/open.c:1192
    [<0000000011942ea6>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000076bff2b1>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810ffea360 (size 608):
  comm "systemd-udevd", pid 9109, jiffies 4294974202 (age 70.960s)
  hex dump (first 32 bytes):
    a4 81 0c 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000cbb42cce>] alloc_inode+0xbe/0x100 fs/inode.c:235
    [<00000000dc171831>] iget_locked+0x126/0x340 fs/inode.c:1192
    [<0000000025e74921>] kernfs_get_inode+0x20/0x190 fs/kernfs/inode.c:252
    [<000000008b802090>] kernfs_iop_lookup+0xa0/0xe0 fs/kernfs/dir.c:1100
    [<00000000e4bc5624>] lookup_open fs/namei.c:3085 [inline]
    [<00000000e4bc5624>] open_last_lookups fs/namei.c:3180 [inline]
    [<00000000e4bc5624>] path_openat+0x95d/0x1b00 fs/namei.c:3368
    [<00000000e92e3050>] do_filp_open+0xa0/0x190 fs/namei.c:3398
    [<00000000ca660767>] do_sys_openat2+0xed/0x230 fs/open.c:1172
    [<000000002fb778b6>] do_sys_open fs/open.c:1188 [inline]
    [<000000002fb778b6>] __do_sys_open fs/open.c:1196 [inline]
    [<000000002fb778b6>] __se_sys_open fs/open.c:1192 [inline]
    [<000000002fb778b6>] __x64_sys_open+0x7d/0xe0 fs/open.c:1192
    [<0000000011942ea6>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000076bff2b1>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810ec1b2b8 (size 24):
  comm "systemd-udevd", pid 9109, jiffies 4294974202 (age 70.960s)
  hex dump (first 24 bytes):
    98 a4 fe 0f 81 88 ff ff 30 e1 09 82 ff ff ff ff  ........0.......
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<00000000d6a1f02a>] kmem_cache_zalloc include/linux/slab.h:672 [inline]
    [<00000000d6a1f02a>] lsm_inode_alloc security/security.c:590 [inline]
    [<00000000d6a1f02a>] security_inode_alloc+0x2a/0xb0 security/security.c:973
    [<000000009366b0d8>] inode_init_always+0x10c/0x250 fs/inode.c:170
    [<00000000357b1464>] alloc_inode+0x44/0x100 fs/inode.c:240
    [<00000000dc171831>] iget_locked+0x126/0x340 fs/inode.c:1192
    [<0000000025e74921>] kernfs_get_inode+0x20/0x190 fs/kernfs/inode.c:252
    [<000000008b802090>] kernfs_iop_lookup+0xa0/0xe0 fs/kernfs/dir.c:1100
    [<00000000e4bc5624>] lookup_open fs/namei.c:3085 [inline]
    [<00000000e4bc5624>] open_last_lookups fs/namei.c:3180 [inline]
    [<00000000e4bc5624>] path_openat+0x95d/0x1b00 fs/namei.c:3368
    [<00000000e92e3050>] do_filp_open+0xa0/0x190 fs/namei.c:3398
    [<00000000ca660767>] do_sys_openat2+0xed/0x230 fs/open.c:1172
    [<000000002fb778b6>] do_sys_open fs/open.c:1188 [inline]
    [<000000002fb778b6>] __do_sys_open fs/open.c:1196 [inline]
    [<000000002fb778b6>] __se_sys_open fs/open.c:1192 [inline]
    [<000000002fb778b6>] __x64_sys_open+0x7d/0xe0 fs/open.c:1192
    [<0000000011942ea6>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000076bff2b1>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810ffc3f00 (size 192):
  comm "kdevtmpfs", pid 21, jiffies 4294974223 (age 70.750s)
  hex dump (first 32 bytes):
    08 80 00 00 06 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 90 56 00 81 88 ff ff  ..........V.....
  backtrace:
    [<000000000f4d69f8>] __d_alloc+0x2a/0x270 fs/dcache.c:1716
    [<00000000a20f7fde>] d_alloc+0x25/0xd0 fs/dcache.c:1795
    [<00000000e1f38abc>] __lookup_hash+0x77/0xd0 fs/namei.c:1441
    [<000000002b4d8a6a>] filename_create+0xc3/0x240 fs/namei.c:3470
    [<0000000049e829fd>] handle_create+0x49/0x28a drivers/base/devtmpfs.c:207
    [<0000000033a814c1>] handle drivers/base/devtmpfs.c:377 [inline]
    [<0000000033a814c1>] devtmpfs_work_loop drivers/base/devtmpfs.c:392 [inline]
    [<0000000033a814c1>] devtmpfsd+0x14e/0x1d3 drivers/base/devtmpfs.c:434
    [<00000000f978b357>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<000000000ea26e78>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

BUG: memory leak
unreferenced object 0xffff888114e342d0 (size 720):
  comm "kdevtmpfs", pid 21, jiffies 4294974223 (age 70.750s)
  hex dump (first 32 bytes):
    00 00 00 00 01 00 00 00 00 00 20 00 00 00 00 00  .......... .....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000d4c4e200>] shmem_alloc_inode+0x18/0x40 mm/shmem.c:3826
    [<00000000bbfd1b25>] alloc_inode+0x27/0x100 fs/inode.c:233
    [<00000000639a7c47>] new_inode_pseudo fs/inode.c:927 [inline]
    [<00000000639a7c47>] new_inode+0x23/0x100 fs/inode.c:956
    [<000000004e164ffa>] shmem_get_inode+0xcd/0x460 mm/shmem.c:2303
    [<00000000c3e9d654>] shmem_mknod+0x37/0x130 mm/shmem.c:2925
    [<0000000094c3aa16>] vfs_mknod+0x339/0x430 fs/namei.c:3554
    [<00000000a44105b5>] handle_create+0x1db/0x28a drivers/base/devtmpfs.c:215
    [<0000000033a814c1>] handle drivers/base/devtmpfs.c:377 [inline]
    [<0000000033a814c1>] devtmpfs_work_loop drivers/base/devtmpfs.c:392 [inline]
    [<0000000033a814c1>] devtmpfsd+0x14e/0x1d3 drivers/base/devtmpfs.c:434
    [<00000000f978b357>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<000000000ea26e78>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
