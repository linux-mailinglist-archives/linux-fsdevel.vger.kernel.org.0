Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F31042B94D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 09:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbhJMHj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 03:39:28 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:56955 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbhJMHj2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:39:28 -0400
Received: by mail-io1-f70.google.com with SMTP id d7-20020a056602228700b005ddba37de42so1240258iod.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Oct 2021 00:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RIMCC+agGbm5m6Ry464mlGTfOVhglnM6UWPHUitoXy0=;
        b=xx3q1X8M4q7wQbkbTMbUxzY+yVfpZ2FfHdBARyZBhxYa2m6Asa8LFC4+pKWl1QO+XF
         QUGf5X/CRRsiVidZYi+ayDcj8ai2vJ0HHz1eWVYKKmxPianeXBVq2Ws30Xz3E8UlN/Uh
         U4298T7k+e9nm+cYBIFTarcTcuAQ+fSvFzIm9YBtZKCwbObjjM2f9SZ+GSSzKCKz9ucB
         sLTQU+uQTXKrTVJWVmiXdpXuQyreJfp+uGrBw5uSsP5LtMPREICS9El5zynX+lsnIMAP
         Wam0lCBlpPukuqaf1KYcqfsvxbAJi8qknQEKalEJL/St6gQf3DTioYGrqWHjg3/4uJ7F
         73jQ==
X-Gm-Message-State: AOAM532Velof6ooeYWH0DBG/9hEyMDCDK6ogEzNGWqToL1Ofks5sGQeY
        +zVrHAdF0CFJyZbegAh5rg8S3z2SGxogSq3tUbCOJL+/2HmW
X-Google-Smtp-Source: ABdhPJwcwO9gGOlpVJehz2mPatYMc+fNrZQ3KiS7LtNvGCWDo9huWuqR8bvnsEtEFP0+pT4TYZvVq2nLQ5B07ur3iKf4waSMGk3h
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2183:: with SMTP id j3mr26898921ila.29.1634110645188;
 Wed, 13 Oct 2021 00:37:25 -0700 (PDT)
Date:   Wed, 13 Oct 2021 00:37:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087bc5805ce370846@google.com>
Subject: [syzbot] memory leak in __lookup_slow
From:   syzbot <syzbot+fa2fdb06a9489df021a7@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    741668ef7832 Merge tag 'usb-5.15-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147be92f300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9003c6f0b271a26c
dashboard link: https://syzkaller.appspot.com/bug?extid=fa2fdb06a9489df021a7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a35b14b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ffd62f300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa2fdb06a9489df021a7@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888111fb2b40 (size 192):
  comm "systemd-udevd", pid 4481, jiffies 4294939632 (age 509.760s)
  hex dump (first 32 bytes):
    04 80 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 70 60 00 81 88 ff ff  .........p`.....
  backtrace:
    [<ffffffff8159e60a>] __d_alloc+0x2a/0x270 fs/dcache.c:1744
    [<ffffffff8159e875>] d_alloc+0x25/0xd0 fs/dcache.c:1823
    [<ffffffff815a369b>] d_alloc_parallel+0x6b/0x920 fs/dcache.c:2575
    [<ffffffff81587407>] __lookup_slow+0x77/0x1f0 fs/namei.c:1642
    [<ffffffff8158c532>] lookup_slow fs/namei.c:1674 [inline]
    [<ffffffff8158c532>] walk_component+0x1f2/0x2a0 fs/namei.c:1970
    [<ffffffff8158d1b6>] lookup_last fs/namei.c:2425 [inline]
    [<ffffffff8158d1b6>] path_lookupat+0xc6/0x330 fs/namei.c:2449
    [<ffffffff81590eff>] filename_lookup+0xff/0x2a0 fs/namei.c:2478
    [<ffffffff815911c2>] user_path_at_empty+0x42/0x60 fs/namei.c:2801
    [<ffffffff8157c28c>] user_path_at include/linux/namei.h:57 [inline]
    [<ffffffff8157c28c>] vfs_statx+0xcc/0x1f0 fs/stat.c:221
    [<ffffffff8157c673>] vfs_fstatat fs/stat.c:243 [inline]
    [<ffffffff8157c673>] vfs_lstat include/linux/fs.h:3356 [inline]
    [<ffffffff8157c673>] __do_sys_newlstat+0x43/0xa0 fs/stat.c:398
    [<ffffffff843fddc5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843fddc5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888112a849c0 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 473.370s)
  hex dump (first 32 bytes):
    58 58 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  XX......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888112a84a28 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 473.370s)
  hex dump (first 32 bytes):
    c0 53 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  .S......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888112a84a90 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 473.370s)
  hex dump (first 32 bytes):
    98 98 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  ........".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111fb2b40 (size 192):
  comm "systemd-udevd", pid 4481, jiffies 4294939632 (age 509.930s)
  hex dump (first 32 bytes):
    04 80 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 70 60 00 81 88 ff ff  .........p`.....
  backtrace:
    [<ffffffff8159e60a>] __d_alloc+0x2a/0x270 fs/dcache.c:1744
    [<ffffffff8159e875>] d_alloc+0x25/0xd0 fs/dcache.c:1823
    [<ffffffff815a369b>] d_alloc_parallel+0x6b/0x920 fs/dcache.c:2575
    [<ffffffff81587407>] __lookup_slow+0x77/0x1f0 fs/namei.c:1642
    [<ffffffff8158c532>] lookup_slow fs/namei.c:1674 [inline]
    [<ffffffff8158c532>] walk_component+0x1f2/0x2a0 fs/namei.c:1970
    [<ffffffff8158d1b6>] lookup_last fs/namei.c:2425 [inline]
    [<ffffffff8158d1b6>] path_lookupat+0xc6/0x330 fs/namei.c:2449
    [<ffffffff81590eff>] filename_lookup+0xff/0x2a0 fs/namei.c:2478
    [<ffffffff815911c2>] user_path_at_empty+0x42/0x60 fs/namei.c:2801
    [<ffffffff8157c28c>] user_path_at include/linux/namei.h:57 [inline]
    [<ffffffff8157c28c>] vfs_statx+0xcc/0x1f0 fs/stat.c:221
    [<ffffffff8157c673>] vfs_fstatat fs/stat.c:243 [inline]
    [<ffffffff8157c673>] vfs_lstat include/linux/fs.h:3356 [inline]
    [<ffffffff8157c673>] __do_sys_newlstat+0x43/0xa0 fs/stat.c:398
    [<ffffffff843fddc5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843fddc5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888112a849c0 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 473.550s)
  hex dump (first 32 bytes):
    58 58 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  XX......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888112a84a28 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 473.550s)
  hex dump (first 32 bytes):
    c0 53 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  .S......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888112a84a90 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 473.550s)
  hex dump (first 32 bytes):
    98 98 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  ........".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111fb2b40 (size 192):
  comm "systemd-udevd", pid 4481, jiffies 4294939632 (age 510.110s)
  hex dump (first 32 bytes):
    04 80 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 70 60 00 81 88 ff ff  .........p`.....
  backtrace:
    [<ffffffff8159e60a>] __d_alloc+0x2a/0x270 fs/dcache.c:1744
    [<ffffffff8159e875>] d_alloc+0x25/0xd0 fs/dcache.c:1823
    [<ffffffff815a369b>] d_alloc_parallel+0x6b/0x920 fs/dcache.c:2575
    [<ffffffff81587407>] __lookup_slow+0x77/0x1f0 fs/namei.c:1642
    [<ffffffff8158c532>] lookup_slow fs/namei.c:1674 [inline]
    [<ffffffff8158c532>] walk_component+0x1f2/0x2a0 fs/namei.c:1970
    [<ffffffff8158d1b6>] lookup_last fs/namei.c:2425 [inline]
    [<ffffffff8158d1b6>] path_lookupat+0xc6/0x330 fs/namei.c:2449
    [<ffffffff81590eff>] filename_lookup+0xff/0x2a0 fs/namei.c:2478
    [<ffffffff815911c2>] user_path_at_empty+0x42/0x60 fs/namei.c:2801
    [<ffffffff8157c28c>] user_path_at include/linux/namei.h:57 [inline]
    [<ffffffff8157c28c>] vfs_statx+0xcc/0x1f0 fs/stat.c:221
    [<ffffffff8157c673>] vfs_fstatat fs/stat.c:243 [inline]
    [<ffffffff8157c673>] vfs_lstat include/linux/fs.h:3356 [inline]
    [<ffffffff8157c673>] __do_sys_newlstat+0x43/0xa0 fs/stat.c:398
    [<ffffffff843fddc5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843fddc5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888112a849c0 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 473.730s)
  hex dump (first 32 bytes):
    58 58 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  XX......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888112a84a28 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 473.730s)
  hex dump (first 32 bytes):
    c0 53 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  .S......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888112a84a90 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 473.730s)
  hex dump (first 32 bytes):
    98 98 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  ........".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111fb2b40 (size 192):
  comm "systemd-udevd", pid 4481, jiffies 4294939632 (age 510.290s)
  hex dump (first 32 bytes):
    04 80 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 70 60 00 81 88 ff ff  .........p`.....
  backtrace:
    [<ffffffff8159e60a>] __d_alloc+0x2a/0x270 fs/dcache.c:1744
    [<ffffffff8159e875>] d_alloc+0x25/0xd0 fs/dcache.c:1823
    [<ffffffff815a369b>] d_alloc_parallel+0x6b/0x920 fs/dcache.c:2575
    [<ffffffff81587407>] __lookup_slow+0x77/0x1f0 fs/namei.c:1642
    [<ffffffff8158c532>] lookup_slow fs/namei.c:1674 [inline]
    [<ffffffff8158c532>] walk_component+0x1f2/0x2a0 fs/namei.c:1970
    [<ffffffff8158d1b6>] lookup_last fs/namei.c:2425 [inline]
    [<ffffffff8158d1b6>] path_lookupat+0xc6/0x330 fs/namei.c:2449
    [<ffffffff81590eff>] filename_lookup+0xff/0x2a0 fs/namei.c:2478
    [<ffffffff815911c2>] user_path_at_empty+0x42/0x60 fs/namei.c:2801
    [<ffffffff8157c28c>] user_path_at include/linux/namei.h:57 [inline]
    [<ffffffff8157c28c>] vfs_statx+0xcc/0x1f0 fs/stat.c:221
    [<ffffffff8157c673>] vfs_fstatat fs/stat.c:243 [inline]
    [<ffffffff8157c673>] vfs_lstat include/linux/fs.h:3356 [inline]
    [<ffffffff8157c673>] __do_sys_newlstat+0x43/0xa0 fs/stat.c:398
    [<ffffffff843fddc5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843fddc5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888112a849c0 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 473.920s)
  hex dump (first 32 bytes):
    58 58 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  XX......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888112a84a28 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 473.920s)
  hex dump (first 32 bytes):
    c0 53 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  .S......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888112a84a90 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 473.920s)
  hex dump (first 32 bytes):
    98 98 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  ........".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111fb2b40 (size 192):
  comm "systemd-udevd", pid 4481, jiffies 4294939632 (age 510.470s)
  hex dump (first 32 bytes):
    04 80 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 70 60 00 81 88 ff ff  .........p`.....
  backtrace:
    [<ffffffff8159e60a>] __d_alloc+0x2a/0x270 fs/dcache.c:1744
    [<ffffffff8159e875>] d_alloc+0x25/0xd0 fs/dcache.c:1823
    [<ffffffff815a369b>] d_alloc_parallel+0x6b/0x920 fs/dcache.c:2575
    [<ffffffff81587407>] __lookup_slow+0x77/0x1f0 fs/namei.c:1642
    [<ffffffff8158c532>] lookup_slow fs/namei.c:1674 [inline]
    [<ffffffff8158c532>] walk_component+0x1f2/0x2a0 fs/namei.c:1970
    [<ffffffff8158d1b6>] lookup_last fs/namei.c:2425 [inline]
    [<ffffffff8158d1b6>] path_lookupat+0xc6/0x330 fs/namei.c:2449
    [<ffffffff81590eff>] filename_lookup+0xff/0x2a0 fs/namei.c:2478
    [<ffffffff815911c2>] user_path_at_empty+0x42/0x60 fs/namei.c:2801
    [<ffffffff8157c28c>] user_path_at include/linux/namei.h:57 [inline]
    [<ffffffff8157c28c>] vfs_statx+0xcc/0x1f0 fs/stat.c:221
    [<ffffffff8157c673>] vfs_fstatat fs/stat.c:243 [inline]
    [<ffffffff8157c673>] vfs_lstat include/linux/fs.h:3356 [inline]
    [<ffffffff8157c673>] __do_sys_newlstat+0x43/0xa0 fs/stat.c:398
    [<ffffffff843fddc5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843fddc5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888112a849c0 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 474.100s)
  hex dump (first 32 bytes):
    58 58 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  XX......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888112a84a28 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 474.100s)
  hex dump (first 32 bytes):
    c0 53 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  .S......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888112a84a90 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 474.100s)
  hex dump (first 32 bytes):
    98 98 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  ........".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111fb2b40 (size 192):
  comm "systemd-udevd", pid 4481, jiffies 4294939632 (age 510.650s)
  hex dump (first 32 bytes):
    04 80 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 70 60 00 81 88 ff ff  .........p`.....
  backtrace:
    [<ffffffff8159e60a>] __d_alloc+0x2a/0x270 fs/dcache.c:1744
    [<ffffffff8159e875>] d_alloc+0x25/0xd0 fs/dcache.c:1823
    [<ffffffff815a369b>] d_alloc_parallel+0x6b/0x920 fs/dcache.c:2575
    [<ffffffff81587407>] __lookup_slow+0x77/0x1f0 fs/namei.c:1642
    [<ffffffff8158c532>] lookup_slow fs/namei.c:1674 [inline]
    [<ffffffff8158c532>] walk_component+0x1f2/0x2a0 fs/namei.c:1970
    [<ffffffff8158d1b6>] lookup_last fs/namei.c:2425 [inline]
    [<ffffffff8158d1b6>] path_lookupat+0xc6/0x330 fs/namei.c:2449
    [<ffffffff81590eff>] filename_lookup+0xff/0x2a0 fs/namei.c:2478
    [<ffffffff815911c2>] user_path_at_empty+0x42/0x60 fs/namei.c:2801
    [<ffffffff8157c28c>] user_path_at include/linux/namei.h:57 [inline]
    [<ffffffff8157c28c>] vfs_statx+0xcc/0x1f0 fs/stat.c:221
    [<ffffffff8157c673>] vfs_fstatat fs/stat.c:243 [inline]
    [<ffffffff8157c673>] vfs_lstat include/linux/fs.h:3356 [inline]
    [<ffffffff8157c673>] __do_sys_newlstat+0x43/0xa0 fs/stat.c:398
    [<ffffffff843fddc5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843fddc5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888112a849c0 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 474.270s)
  hex dump (first 32 bytes):
    58 58 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  XX......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888112a84a28 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 474.270s)
  hex dump (first 32 bytes):
    c0 53 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  .S......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888112a84a90 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 474.270s)
  hex dump (first 32 bytes):
    98 98 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  ........".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111fb2b40 (size 192):
  comm "systemd-udevd", pid 4481, jiffies 4294939632 (age 510.830s)
  hex dump (first 32 bytes):
    04 80 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 70 60 00 81 88 ff ff  .........p`.....
  backtrace:
    [<ffffffff8159e60a>] __d_alloc+0x2a/0x270 fs/dcache.c:1744
    [<ffffffff8159e875>] d_alloc+0x25/0xd0 fs/dcache.c:1823
    [<ffffffff815a369b>] d_alloc_parallel+0x6b/0x920 fs/dcache.c:2575
    [<ffffffff81587407>] __lookup_slow+0x77/0x1f0 fs/namei.c:1642
    [<ffffffff8158c532>] lookup_slow fs/namei.c:1674 [inline]
    [<ffffffff8158c532>] walk_component+0x1f2/0x2a0 fs/namei.c:1970
    [<ffffffff8158d1b6>] lookup_last fs/namei.c:2425 [inline]
    [<ffffffff8158d1b6>] path_lookupat+0xc6/0x330 fs/namei.c:2449
    [<ffffffff81590eff>] filename_lookup+0xff/0x2a0 fs/namei.c:2478
    [<ffffffff815911c2>] user_path_at_empty+0x42/0x60 fs/namei.c:2801
    [<ffffffff8157c28c>] user_path_at include/linux/namei.h:57 [inline]
    [<ffffffff8157c28c>] vfs_statx+0xcc/0x1f0 fs/stat.c:221
    [<ffffffff8157c673>] vfs_fstatat fs/stat.c:243 [inline]
    [<ffffffff8157c673>] vfs_lstat include/linux/fs.h:3356 [inline]
    [<ffffffff8157c673>] __do_sys_newlstat+0x43/0xa0 fs/stat.c:398
    [<ffffffff843fddc5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843fddc5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888112a849c0 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 474.460s)
  hex dump (first 32 bytes):
    58 58 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  XX......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888112a84a28 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 474.460s)
  hex dump (first 32 bytes):
    c0 53 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  .S......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888112a84a90 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 474.460s)
  hex dump (first 32 bytes):
    98 98 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  ........".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111fb2b40 (size 192):
  comm "systemd-udevd", pid 4481, jiffies 4294939632 (age 511.010s)
  hex dump (first 32 bytes):
    04 80 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 70 60 00 81 88 ff ff  .........p`.....
  backtrace:
    [<ffffffff8159e60a>] __d_alloc+0x2a/0x270 fs/dcache.c:1744
    [<ffffffff8159e875>] d_alloc+0x25/0xd0 fs/dcache.c:1823
    [<ffffffff815a369b>] d_alloc_parallel+0x6b/0x920 fs/dcache.c:2575
    [<ffffffff81587407>] __lookup_slow+0x77/0x1f0 fs/namei.c:1642
    [<ffffffff8158c532>] lookup_slow fs/namei.c:1674 [inline]
    [<ffffffff8158c532>] walk_component+0x1f2/0x2a0 fs/namei.c:1970
    [<ffffffff8158d1b6>] lookup_last fs/namei.c:2425 [inline]
    [<ffffffff8158d1b6>] path_lookupat+0xc6/0x330 fs/namei.c:2449
    [<ffffffff81590eff>] filename_lookup+0xff/0x2a0 fs/namei.c:2478
    [<ffffffff815911c2>] user_path_at_empty+0x42/0x60 fs/namei.c:2801
    [<ffffffff8157c28c>] user_path_at include/linux/namei.h:57 [inline]
    [<ffffffff8157c28c>] vfs_statx+0xcc/0x1f0 fs/stat.c:221
    [<ffffffff8157c673>] vfs_fstatat fs/stat.c:243 [inline]
    [<ffffffff8157c673>] vfs_lstat include/linux/fs.h:3356 [inline]
    [<ffffffff8157c673>] __do_sys_newlstat+0x43/0xa0 fs/stat.c:398
    [<ffffffff843fddc5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843fddc5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888112a849c0 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 474.630s)
  hex dump (first 32 bytes):
    58 58 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  XX......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888112a84a28 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 474.630s)
  hex dump (first 32 bytes):
    c0 53 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  .S......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888112a84a90 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 474.630s)
  hex dump (first 32 bytes):
    98 98 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  ........".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
