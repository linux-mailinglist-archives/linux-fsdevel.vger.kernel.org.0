Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF4A3EC23B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 13:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbhHNLHw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 07:07:52 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:41867 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbhHNLHv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 07:07:51 -0400
Received: by mail-io1-f70.google.com with SMTP id s22-20020a5e98160000b02905afde383110so3161274ioj.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Aug 2021 04:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wsW3REPCg0yO0FBNGfNYXSFDoQbZPXDfAhUBMiCqMMg=;
        b=Pj7liPnT0/zdj7NrR3m9VLlcgccozq/CgVplPIPNTIhbk8Dh6sscMxm1x3yMwTlZiq
         ukiXmFG0dkbAme60hUFxeBFvYihBqDcxnTT68f3QV8Qldve9ofdsCgf5iUGPjZntjWAc
         yJyEulgxpuCwQg4XJRh0UhEfnnjfaVnpAlwT/2gIv0oJPyTIPsUmrqpOrr7KcswuevBc
         R1eFySyRycAbvnu1cQ3kxBymvgKYoudhG5fK71Ss05bZRbjBPOtt7tMtbgtjtRVAWlbs
         O6KoW4odDZ7+r8YjTUhvCNktPAAj2LgNgTTSgivz6IwFI+4pdGHUG3gXutXwJiT5ydlH
         1Fdg==
X-Gm-Message-State: AOAM531ta0HO2NtLqeG4mx91kjlYpulN9ChfI9oRraytkA9/9jTX8cRC
        VRdXbqcnd6tPfmL/A0CeGdtA8ybhwBU+ASz1wsTVo9w9HV6w
X-Google-Smtp-Source: ABdhPJy3i2Rih7zyXOdcEtyIAqKIPAXgPY3nXc7/tFap5i8zaBQdjCqekQN60qgT06qxOig675pVNdve1PjY/G1PYHJo7rpca924
MIME-Version: 1.0
X-Received: by 2002:a5e:c808:: with SMTP id y8mr5480411iol.108.1628939243525;
 Sat, 14 Aug 2021 04:07:23 -0700 (PDT)
Date:   Sat, 14 Aug 2021 04:07:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f899f205c982f8b0@google.com>
Subject: [syzbot] KASAN: use-after-free Read in bdev_evict_inode
From:   syzbot <syzbot+1fb38bb7d3ce0fa3e1c4@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    92d00774360d Add linux-next specific files for 20210810
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10922209300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6933fa6f9a86ca9
dashboard link: https://syzkaller.appspot.com/bug?extid=1fb38bb7d3ce0fa3e1c4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115c5381300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c7d036300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1fb38bb7d3ce0fa3e1c4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in wb_put_many include/linux/backing-dev-defs.h:250 [inline]
BUG: KASAN: use-after-free in wb_put include/linux/backing-dev-defs.h:268 [inline]
BUG: KASAN: use-after-free in inode_detach_wb include/linux/writeback.h:251 [inline]
BUG: KASAN: use-after-free in bdev_evict_inode+0x3c3/0x410 fs/block_dev.c:832
Read of size 8 at addr ffff888146568060 by task syz-executor103/6845

CPU: 1 PID: 6845 Comm: syz-executor103 Not tainted 5.14.0-rc5-next-20210810-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 wb_put_many include/linux/backing-dev-defs.h:250 [inline]
 wb_put include/linux/backing-dev-defs.h:268 [inline]
 inode_detach_wb include/linux/writeback.h:251 [inline]
 bdev_evict_inode+0x3c3/0x410 fs/block_dev.c:832
 evict+0x2ed/0x6b0 fs/inode.c:590
 iput_final fs/inode.c:1670 [inline]
 iput.part.0+0x539/0x850 fs/inode.c:1696
 iput+0x58/0x70 fs/inode.c:1686
 device_release+0x9f/0x240 drivers/base/core.c:2193
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 put_device+0x1b/0x30 drivers/base/core.c:3463
 put_disk block/genhd.c:1338 [inline]
 blk_cleanup_disk+0x6b/0x80 block/genhd.c:1354
 loop_remove drivers/block/loop.c:2415 [inline]
 loop_control_remove drivers/block/loop.c:2463 [inline]
 loop_control_ioctl+0x3db/0x450 drivers/block/loop.c:2495
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x444dc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffbac3e7b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000002bef4 RCX: 0000000000444dc9
RDX: 0000000000000000 RSI: 0000000000004c81 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fffbac3e7e0 R09: 00007fffbac3e7e0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffbac3e7dc
R13: 00007fffbac3e810 R14: 00007fffbac3e7f0 R15: 000000000000003c

Allocated by task 1:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0x9b/0xd0 mm/kasan/common.c:522
 kmalloc_node include/linux/slab.h:609 [inline]
 kzalloc_node include/linux/slab.h:732 [inline]
 bdi_alloc+0x43/0x180 mm/backing-dev.c:810
 __alloc_disk_node+0x6e/0x500 block/genhd.c:1270
 __blk_mq_alloc_disk+0xec/0x190 block/blk-mq.c:3145
 loop_add+0x324/0x940 drivers/block/loop.c:2344
 loop_init+0x1f4/0x216 drivers/block/loop.c:2575
 do_one_initcall+0x103/0x650 init/main.c:1285
 do_initcall_level init/main.c:1360 [inline]
 do_initcalls init/main.c:1376 [inline]
 do_basic_setup init/main.c:1395 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1597
 kernel_init+0x1a/0x1d0 init/main.c:1489
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Freed by task 6845:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xfb/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1681 [inline]
 slab_free_freelist_hook+0x7e/0x190 mm/slub.c:1706
 slab_free mm/slub.c:3444 [inline]
 kfree+0xe4/0x530 mm/slub.c:4504
 kref_put include/linux/kref.h:65 [inline]
 bdi_put+0x72/0xa0 mm/backing-dev.c:976
 disk_release+0x7b/0x270 block/genhd.c:1089
 device_release+0x9f/0x240 drivers/base/core.c:2193
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 put_device+0x1b/0x30 drivers/base/core.c:3463
 put_disk block/genhd.c:1338 [inline]
 blk_cleanup_disk+0x6b/0x80 block/genhd.c:1354
 loop_remove drivers/block/loop.c:2415 [inline]
 loop_control_remove drivers/block/loop.c:2463 [inline]
 loop_control_ioctl+0x3db/0x450 drivers/block/loop.c:2495
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:348
 insert_work+0x48/0x370 kernel/workqueue.c:1332
 __queue_work+0x5c1/0xed0 kernel/workqueue.c:1498
 flush_delayed_work+0xc6/0xf0 kernel/workqueue.c:3195
 wb_shutdown+0x1bb/0x230 mm/backing-dev.c:363
 bdi_unregister+0x180/0x5a0 mm/backing-dev.c:947
 del_gendisk+0x5a6/0x730 block/genhd.c:616
 loop_remove drivers/block/loop.c:2414 [inline]
 loop_control_remove drivers/block/loop.c:2463 [inline]
 loop_control_ioctl+0x3b5/0x450 drivers/block/loop.c:2495
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Second to last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:348
 insert_work+0x48/0x370 kernel/workqueue.c:1332
 __queue_work+0x5c1/0xed0 kernel/workqueue.c:1498
 __queue_delayed_work+0x1c8/0x270 kernel/workqueue.c:1645
 mod_delayed_work_on+0xdd/0x220 kernel/workqueue.c:1719
 mod_delayed_work include/linux/workqueue.h:537 [inline]
 wb_shutdown+0x178/0x230 mm/backing-dev.c:360
 bdi_unregister+0x180/0x5a0 mm/backing-dev.c:947
 del_gendisk+0x5a6/0x730 block/genhd.c:616
 loop_remove drivers/block/loop.c:2414 [inline]
 loop_control_remove drivers/block/loop.c:2463 [inline]
 loop_control_ioctl+0x3b5/0x450 drivers/block/loop.c:2495
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff888146568000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 96 bytes inside of
 4096-byte region [ffff888146568000, ffff888146569000)
The buggy address belongs to the page:
page:ffffea0005195a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x146568
head:ffffea0005195a00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x57ff00000010200(slab|head|node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff00000010200 dead000000000100 dead000000000122 ffff888010842140
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, ts 8085403015, free_ts 0
 prep_new_page mm/page_alloc.c:2424 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4152
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5374
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2033
 alloc_pages+0x29f/0x300 mm/mempolicy.c:2183
 alloc_slab_page mm/slub.c:1744 [inline]
 allocate_slab mm/slub.c:1881 [inline]
 new_slab+0x319/0x490 mm/slub.c:1944
 ___slab_alloc+0x8b9/0xf50 mm/slub.c:2955
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3042
 slab_alloc_node mm/slub.c:3133 [inline]
 kmem_cache_alloc_node_trace+0x183/0x400 mm/slub.c:3217
 kmalloc_node include/linux/slab.h:609 [inline]
 kzalloc_node include/linux/slab.h:732 [inline]
 bdi_alloc+0x43/0x180 mm/backing-dev.c:810
 __alloc_disk_node+0x6e/0x500 block/genhd.c:1270
 __blk_mq_alloc_disk+0xec/0x190 block/blk-mq.c:3145
 loop_add+0x324/0x940 drivers/block/loop.c:2344
 loop_init+0x1f4/0x216 drivers/block/loop.c:2575
 do_one_initcall+0x103/0x650 init/main.c:1285
 do_initcall_level init/main.c:1360 [inline]
 do_initcalls init/main.c:1376 [inline]
 do_basic_setup init/main.c:1395 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1597
 kernel_init+0x1a/0x1d0 init/main.c:1489
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888146567f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888146567f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888146568000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff888146568080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888146568100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
