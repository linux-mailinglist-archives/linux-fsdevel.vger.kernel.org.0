Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C7830AD4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 18:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhBARCJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 12:02:09 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:46556 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBARCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:02:05 -0500
Received: by mail-il1-f198.google.com with SMTP id j5so14316057ila.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Feb 2021 09:01:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EWHtb+elGAwzn686GSK54ajAkHsqWpmvTIhfzBAVZI0=;
        b=aoI7uKOgI69b2OjnlSNWz6A4x8or7WrdCK7CvALpdnu/hQZBP3bIs66w4/suopsnc8
         t8fqm7fXzgWMa2wNndoydqBk/lIPKjANlzFybSJg7v3LHr8MHeo9auSQuYAOZY7X0kDV
         /xyg/laC0Y5N7anXwhlFPkCuukPmz1GZEIyeF09zNF3thol43lZDtUel+E/uAg3ugfV6
         Zh7POkucHXL4IHXRA2hKjHmdbRrZvwPItyT4U97bGn1MzUNYg/zMVJ4YvBTtmKptO7/p
         Bp4r7uL4U7SF0xQW44fonbFPFJL4UlgfoUdxfCGeW5OdRFULFc1TZIDP8L/yGywnFIrI
         v90w==
X-Gm-Message-State: AOAM530N/+KG4khauO8U7G6uqc3tZDE3MYC/IScnaQ1Hhk4FTTfZK8X6
        PdV4/nxyjKHOL2ywQVqV9OTspjFaUlIH1M4dTZNdvN0sVfZd
X-Google-Smtp-Source: ABdhPJzgbEz31b0MoVZpmBvS3j3/sAlK/F+rBuq4XjqKuB5flxKmji0NAa3iSEvRUOohZvc0kP2DdFMiZdSim/kbVMmNhvOvBc+M
MIME-Version: 1.0
X-Received: by 2002:a92:130e:: with SMTP id 14mr13350176ilt.58.1612198883902;
 Mon, 01 Feb 2021 09:01:23 -0800 (PST)
Date:   Mon, 01 Feb 2021 09:01:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c84e1a05ba494df4@google.com>
Subject: KASAN: use-after-free Read in bdgrab
From:   syzbot <syzbot+e4122ba0796a5de0373d@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d03154e8 Add linux-next specific files for 20210128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13a9591b500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6953ffb584722a1
dashboard link: https://syzkaller.appspot.com/bug?extid=e4122ba0796a5de0373d
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e4122ba0796a5de0373d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in bdgrab+0x4c/0x50 fs/block_dev.c:921
Read of size 8 at addr ffff888015f5a2a8 by task syz-executor.2/16939

CPU: 1 PID: 16939 Comm: syz-executor.2 Not tainted 5.11.0-rc5-next-20210128-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
 bdgrab+0x4c/0x50 fs/block_dev.c:921
 bdget_disk+0x91/0x180 block/genhd.c:802
 bdev_del_partition+0x41/0x110 block/partitions/core.c:460
 blkpg_do_ioctl+0x2e8/0x340 block/ioctl.c:33
 blkpg_ioctl block/ioctl.c:60 [inline]
 blkdev_ioctl+0x577/0x6d0 block/ioctl.c:541
 block_ioctl+0xf9/0x140 fs/block_dev.c:1650
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e219
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2c4d9e5c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045e219
RDX: 0000000020000240 RSI: 0000000000001269 RDI: 0000000000000004
RBP: 000000000119bfc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bf8c
R13: 00007ffc408bf1af R14: 00007f2c4d9e69c0 R15: 000000000119bf8c

Allocated by task 12685:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:403 [inline]
 ____kasan_kmalloc mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc.constprop.0+0xa0/0xd0 mm/kasan/common.c:406
 kasan_slab_alloc include/linux/kasan.h:208 [inline]
 slab_post_alloc_hook mm/slab.h:516 [inline]
 slab_alloc_node mm/slub.c:2907 [inline]
 slab_alloc mm/slub.c:2915 [inline]
 kmem_cache_alloc+0x15e/0x380 mm/slub.c:2920
 bdev_alloc_inode+0x18/0x80 fs/block_dev.c:778
 alloc_inode+0x61/0x230 fs/inode.c:234
 new_inode_pseudo fs/inode.c:928 [inline]
 new_inode+0x27/0x2f0 fs/inode.c:957
 bdev_alloc+0x20/0x2f0 fs/block_dev.c:868
 add_partition+0x1a7/0x860 block/partitions/core.c:346
 bdev_add_partition+0xb6/0x130 block/partitions/core.c:449
 blkpg_do_ioctl+0x2d0/0x340 block/ioctl.c:43
 blkpg_ioctl block/ioctl.c:60 [inline]
 blkdev_ioctl+0x577/0x6d0 block/ioctl.c:541
 block_ioctl+0xf9/0x140 fs/block_dev.c:1650
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 16880:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:357
 ____kasan_slab_free.part.0+0xe1/0x110 mm/kasan/common.c:364
 kasan_slab_free include/linux/kasan.h:191 [inline]
 slab_free_hook mm/slub.c:1562 [inline]
 slab_free_freelist_hook+0x82/0x1d0 mm/slub.c:1600
 slab_free mm/slub.c:3161 [inline]
 kmem_cache_free+0x8b/0x740 mm/slub.c:3177
 i_callback+0x3f/0x70 fs/inode.c:223
 rcu_do_batch kernel/rcu/tree.c:2507 [inline]
 rcu_core+0x746/0x1390 kernel/rcu/tree.c:2742
 __do_softirq+0x2bc/0xa29 kernel/softirq.c:343

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:345
 __call_rcu kernel/rcu/tree.c:2987 [inline]
 call_rcu+0xbb/0x750 kernel/rcu/tree.c:3062
 destroy_inode+0x129/0x1b0 fs/inode.c:289
 iput_final fs/inode.c:1654 [inline]
 iput.part.0+0x57e/0x810 fs/inode.c:1680
 iput+0x58/0x70 fs/inode.c:1670
 bdev_del_partition+0xc8/0x110 block/partitions/core.c:479
 blkpg_do_ioctl+0x2e8/0x340 block/ioctl.c:33
 blkpg_ioctl block/ioctl.c:60 [inline]
 blkdev_ioctl+0x577/0x6d0 block/ioctl.c:541
 block_ioctl+0xf9/0x140 fs/block_dev.c:1650
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff888015f5a280
 which belongs to the cache bdev_cache of size 2792
The buggy address is located 40 bytes inside of
 2792-byte region [ffff888015f5a280, ffff888015f5ad68)
The buggy address belongs to the page:
page:000000006fcc45fe refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15f58
head:000000006fcc45fe order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff88800fdc2b40
raw: 0000000000000000 00000000800b000b 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888015f5a180: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
 ffff888015f5a200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888015f5a280: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888015f5a300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888015f5a380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
