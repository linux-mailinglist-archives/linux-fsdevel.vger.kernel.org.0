Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1614725107
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 02:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbjFGALN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 6 Jun 2023 20:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbjFGALK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 20:11:10 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547DE1988
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 17:11:07 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-77a13410773so136679439f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 17:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686096666; x=1688688666;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvlqLDNCjcUMI27YWV13I+7apL/AauOa3lyDOfDowi0=;
        b=WCC3FKTAmC4YjVdvjY9/1nQTun455s2WAKSPnJAQGmR+FudMBySN9s6LR8eL/5Vmyo
         mPqpe48aIlLFNojGimoTR19Dz8S2gcuR0/plZfT8yjLYlFb9k+CZPi6aNF2MPemAlMNE
         VizQ3poobi8UtJK6EOP/5Jon2vBmPKp5vYfuGz6GYUiHushV3KnhZIxe9ZWeZY6l4Vgp
         V/yYQT+O3zqfmiRVxFMlChRB2rqQnNTID+8p2ItZnWHs82/BoR1osSlo1cE/mfeOYUVN
         Vt5oy2EjrKF2Uc85f+hu9kUF0Ioyh6KL0ZI5Y+baWXuc3iOyt99FLg8DUHsmlN56IksC
         UVJQ==
X-Gm-Message-State: AC+VfDyxUsC4UjXoWN8SOTn89tkpy2QLiWCTtY8EM2awYQqaqygqlU7v
        0Ga7CDPpEORVrpPq1uyzTTKnGKXDveryUSQ2oCuqCNkDEY5o
X-Google-Smtp-Source: ACHHUZ6hxjmjoQBl7YkEjN+gapxJqI8BUJ940W5pnhXmHWFfDg5cj7lkfeTbINmsg/bktA3n/i4kHhung4GEwRq2wA5dsDMl7NsL
MIME-Version: 1.0
X-Received: by 2002:a92:c94a:0:b0:33e:325a:cc11 with SMTP id
 i10-20020a92c94a000000b0033e325acc11mr700329ilq.5.1686096666553; Tue, 06 Jun
 2023 17:11:06 -0700 (PDT)
Date:   Tue, 06 Jun 2023 17:11:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ddfe0405fd7ef847@google.com>
Subject: [syzbot] [ext4?] KASAN: slab-use-after-free Read in __ext4_iget
From:   syzbot <syzbot+5407ecf3112f882d2ef3@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a4d7d7011219 Merge tag 'spi-fix-v6.4-rc5' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1455f745280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=5407ecf3112f882d2ef3
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dedc2e62381b/disk-a4d7d701.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4809d6c705ea/vmlinux-a4d7d701.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5a89bc184831/bzImage-a4d7d701.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5407ecf3112f882d2ef3@syzkaller.appspotmail.com

loop5: detected capacity change from 0 to 2048
==================================================================
BUG: KASAN: slab-use-after-free in __ext4_iget+0x2f2/0x3f30 fs/ext4/inode.c:4700
Read of size 8 at addr ffff888078ca5550 by task syz-executor.5/26112

CPU: 1 PID: 26112 Comm: syz-executor.5 Not tainted 6.4.0-rc5-syzkaller-00016-ga4d7d7011219 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:351 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:462
 kasan_report+0x176/0x1b0 mm/kasan/report.c:572
 __ext4_iget+0x2f2/0x3f30 fs/ext4/inode.c:4700
 __ext4_fill_super fs/ext4/super.c:5446 [inline]
 ext4_fill_super+0x545b/0x6c60 fs/ext4/super.c:5672
 get_tree_bdev+0x405/0x620 fs/super.c:1303
 vfs_get_tree+0x8c/0x270 fs/super.c:1510
 do_new_mount+0x28f/0xae0 fs/namespace.c:3039
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2842e8d69a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2843c59f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000000007b1 RCX: 00007f2842e8d69a
RDX: 0000000020000780 RSI: 0000000020000000 RDI: 00007f2843c59fe0
RBP: 00007f2843c5a020 R08: 00007f2843c5a020 R09: 0000000002000480
R10: 0000000002000480 R11: 0000000000000202 R12: 0000000020000780
R13: 0000000020000000 R14: 00007f2843c59fe0 R15: 00000000200000c0
 </TASK>

Allocated by task 20729:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:711
 slab_alloc_node mm/slub.c:3451 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc_lru+0x11f/0x2e0 mm/slub.c:3482
 alloc_inode_sb include/linux/fs.h:2705 [inline]
 reiserfs_alloc_inode+0x2a/0xc0 fs/reiserfs/super.c:642
 alloc_inode fs/inode.c:260 [inline]
 iget5_locked+0xa0/0x270 fs/inode.c:1241
 reiserfs_fill_super+0x12e4/0x2620 fs/reiserfs/super.c:2053
 mount_bdev+0x2d0/0x3f0 fs/super.c:1380
 legacy_get_tree+0xef/0x190 fs/fs_context.c:610
 vfs_get_tree+0x8c/0x270 fs/super.c:1510
 do_new_mount+0x28f/0xae0 fs/namespace.c:3039
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:491
 __call_rcu_common kernel/rcu/tree.c:2627 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:2741
 dispose_list fs/inode.c:698 [inline]
 evict_inodes+0x5f8/0x690 fs/inode.c:748
 generic_shutdown_super+0x98/0x340 fs/super.c:479
 kill_block_super+0x84/0xf0 fs/super.c:1407
 deactivate_locked_super+0xa4/0x110 fs/super.c:331
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1177
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:491
 __call_rcu_common kernel/rcu/tree.c:2627 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:2741
 dispose_list fs/inode.c:698 [inline]
 evict_inodes+0x5f8/0x690 fs/inode.c:748
 generic_shutdown_super+0x98/0x340 fs/super.c:479
 kill_block_super+0x84/0xf0 fs/super.c:1407
 deactivate_locked_super+0xa4/0x110 fs/super.c:331
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1177
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888078ca4f80
 which belongs to the cache reiser_inode_cache of size 1568
The buggy address is located 1488 bytes inside of
 freed 1568-byte region [ffff888078ca4f80, ffff888078ca55a0)

The buggy address belongs to the physical page:
page:ffffea0001e32800 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888078ca5cc0 pfn:0x78ca0
head:ffffea0001e32800 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888019f32101
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff8881400cba00 dead000000000122 0000000000000000
raw: ffff888078ca5cc0 000000008013000a 00000001ffffffff ffff888019f32101
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d20d0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 965, tgid 940 (syz-executor.1), ts 1300044371541, free_ts 1155942618814
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0x321c/0x33a0 mm/page_alloc.c:3502
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4768
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3192
 __slab_alloc mm/slub.c:3291 [inline]
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc_lru+0x1b9/0x2e0 mm/slub.c:3482
 alloc_inode_sb include/linux/fs.h:2705 [inline]
 reiserfs_alloc_inode+0x2a/0xc0 fs/reiserfs/super.c:642
 alloc_inode fs/inode.c:260 [inline]
 new_inode_pseudo+0x65/0x1d0 fs/inode.c:1018
 new_inode+0x29/0x1d0 fs/inode.c:1046
 reiserfs_create+0x182/0x6e0 fs/reiserfs/namei.c:641
 lookup_open fs/namei.c:3492 [inline]
 open_last_lookups fs/namei.c:3560 [inline]
 path_openat+0x13df/0x3170 fs/namei.c:3788
 do_filp_open+0x234/0x490 fs/namei.c:3818
 do_sys_openat2+0x13f/0x500 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_open fs/open.c:1380 [inline]
 __se_sys_open fs/open.c:1376 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1376
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2564
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2659
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:711
 slab_alloc_node mm/slub.c:3451 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc+0x11f/0x2e0 mm/slub.c:3475
 getname_flags+0xbc/0x4e0 fs/namei.c:140
 getname fs/namei.c:219 [inline]
 __do_sys_mkdirat fs/namei.c:4153 [inline]
 __se_sys_mkdirat fs/namei.c:4151 [inline]
 __x64_sys_mkdirat+0x7c/0xa0 fs/namei.c:4151
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888078ca5400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888078ca5480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888078ca5500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff888078ca5580: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888078ca5600: fc fc fc fc 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
