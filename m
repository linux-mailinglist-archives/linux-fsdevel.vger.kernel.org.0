Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0BF6F9962
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjEGPcu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 11:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjEGPcr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 11:32:47 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD99817FE4
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 May 2023 08:32:41 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-331ab91abdeso47523625ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 May 2023 08:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683473561; x=1686065561;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJT2ZWE/xGSNSBk1dRk7exw43ywdSX0oZoIN68jOSVo=;
        b=Ne4tNvMJrmvmAWXv8FBa6+4F577a+iUgy8+egw5O8WLAIUvMc9E/tZdlHJU9vD62cH
         tILsKuQGgU5lF/8irTH6KMRBduV3j2Du58AeMfMBO+MkpkfQbkJpo0/E/ncF3UzuM8Fu
         JQYYOcxu/L1BVlbaJCaTobDg0Wh4nxhlYq6x9tlNifs4Y0WxzSEei6vNY+eZY3ZGqPip
         s/ngWYyxZOhf0RWQrUOdXwbjkZ2zZL3BaQZqMrgwZR7H+WDLUEI05is/39VbRWNrH5KV
         2FBazD6qNrWF8rMYeAycsBzrIEejpiSwNOkVgYoNLe31+5yBihBMSy+TIGI/ttXLzNBL
         ojrQ==
X-Gm-Message-State: AC+VfDyTRMADsCPrAPqHh6lo7VsDwN+6U2inxK0jeggEXlx5nMpUzF6Y
        AUVxbgQyQNAvOV44WObKIOgwSNtBMVGiZgnNDnOV8QfZ8orM
X-Google-Smtp-Source: ACHHUZ5BvlZ4/G2B5akUj0YvGRTsz2xsytuoKw1JEWj6buNoYvTJmcJO6w4gi+bvAazK/51HANWFGsIdW7c65TLGnYI/CD2IWTVd
MIME-Version: 1.0
X-Received: by 2002:a02:948e:0:b0:406:5e9b:87bd with SMTP id
 x14-20020a02948e000000b004065e9b87bdmr3372934jah.2.1683473561148; Sun, 07 May
 2023 08:32:41 -0700 (PDT)
Date:   Sun, 07 May 2023 08:32:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099e5ac05fb1c3b85@google.com>
Subject: [syzbot] [nilfs?] KASAN: slab-use-after-free Read in nilfs_load_inode_block
From:   syzbot <syzbot+78d4495558999f55d1da@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
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

HEAD commit:    fc4354c6e5c2 Merge tag 'mm-stable-2023-05-06-10-49' of git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16be474a280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73a06f6ef2d5b492
dashboard link: https://syzkaller.appspot.com/bug?extid=78d4495558999f55d1da
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cd28ea280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1273a95c280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f4adc5d40b0/disk-fc4354c6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e06af6b6985/vmlinux-fc4354c6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7d99bbab1361/bzImage-fc4354c6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/dd743241f9e7/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+78d4495558999f55d1da@syzkaller.appspotmail.com

NILFS (loop2): error -5 truncating bmap (ino=15)
==================================================================
BUG: KASAN: slab-use-after-free in nilfs_load_inode_block+0x11e/0x280 fs/nilfs2/inode.c:1012
Read of size 8 at addr ffff88801f47f430 by task syz-executor323/4999

CPU: 0 PID: 4999 Comm: syz-executor323 Not tainted 6.3.0-syzkaller-13466-gfc4354c6e5c2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:351 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:462
 kasan_report+0x176/0x1b0 mm/kasan/report.c:572
 nilfs_load_inode_block+0x11e/0x280 fs/nilfs2/inode.c:1012
 __nilfs_mark_inode_dirty+0xa5/0x280 fs/nilfs2/inode.c:1089
 nilfs_mark_inode_dirty fs/nilfs2/nilfs.h:288 [inline]
 nilfs_evict_inode+0x189/0x420 fs/nilfs2/inode.c:934
 evict+0x2a4/0x620 fs/inode.c:665
 nilfs_dispose_list+0x51d/0x5c0 fs/nilfs2/segment.c:816
 nilfs_detach_log_writer+0xaf1/0xbb0 fs/nilfs2/segment.c:2852
 nilfs_put_super+0x4d/0x160 fs/nilfs2/super.c:477
 generic_shutdown_super+0x134/0x340 fs/super.c:500
 kill_block_super+0x84/0xf0 fs/super.c:1407
 deactivate_locked_super+0xa4/0x110 fs/super.c:331
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1177
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 ptrace_notify+0x2cd/0x380 kernel/signal.c:2369
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:252 [inline]
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:279 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:284 [inline]
 syscall_exit_to_user_mode+0x157/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0b39ccba87
Code: ff d0 48 89 c7 b8 3c 00 00 00 0f 05 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcfc3da598 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f0b39ccba87
RDX: 00007ffcfc3da659 RSI: 000000000000000a RDI: 00007ffcfc3da650
RBP: 00007ffcfc3da650 R08: 00000000ffffffff R09: 00007ffcfc3da430
R10: 00005555563da683 R11: 0000000000000202 R12: 00007ffcfc3db710
R13: 00005555563da5f0 R14: 00007ffcfc3da5c0 R15: 00007ffcfc3db730
 </TASK>

Allocated by task 5216:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 nilfs_find_or_create_root+0x137/0x4e0 fs/nilfs2/the_nilfs.c:810
 nilfs_attach_checkpoint+0x123/0x4d0 fs/nilfs2/super.c:529
 nilfs_fill_super+0x321/0x600 fs/nilfs2/super.c:1074
 nilfs_mount+0x67d/0x9a0 fs/nilfs2/super.c:1326
 legacy_get_tree+0xef/0x190 fs/fs_context.c:610
 vfs_get_tree+0x8c/0x270 fs/super.c:1510
 do_new_mount+0x28f/0xae0 fs/namespace.c:3039
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 4999:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook mm/slub.c:1807 [inline]
 slab_free mm/slub.c:3786 [inline]
 __kmem_cache_free+0x264/0x3c0 mm/slub.c:3799
 nilfs_segctor_destroy fs/nilfs2/segment.c:2775 [inline]
 nilfs_detach_log_writer+0x8c1/0xbb0 fs/nilfs2/segment.c:2838
 nilfs_put_super+0x4d/0x160 fs/nilfs2/super.c:477
 generic_shutdown_super+0x134/0x340 fs/super.c:500
 kill_block_super+0x84/0xf0 fs/super.c:1407
 deactivate_locked_super+0xa4/0x110 fs/super.c:331
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1177
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 ptrace_notify+0x2cd/0x380 kernel/signal.c:2369
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:252 [inline]
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:279 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:284 [inline]
 syscall_exit_to_user_mode+0x157/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801f47f400
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 48 bytes inside of
 freed 256-byte region [ffff88801f47f400, ffff88801f47f500)

The buggy address belongs to the physical page:
page:ffffea00007d1f80 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801f47f600 pfn:0x1f47e
head:ffffea00007d1f80 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012441b40 ffffea00008ccc90 ffffea00007a7510
raw: ffff88801f47f600 000000000010000e 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 9284804112, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0x321c/0x33a0 mm/page_alloc.c:3502
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4768
 alloc_page_interleave+0x22/0x1d0 mm/mempolicy.c:2112
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3192
 __slab_alloc mm/slub.c:3291 [inline]
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 __kmem_cache_alloc_node+0x1b8/0x290 mm/slub.c:3490
 kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1057
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 bus_add_driver+0x163/0x620 drivers/base/bus.c:657
 driver_register+0x23a/0x320 drivers/base/driver.c:246
 do_one_initcall+0x23d/0x7d0 init/main.c:1246
 do_initcall_level+0x157/0x210 init/main.c:1319
 do_initcalls+0x3f/0x80 init/main.c:1335
 kernel_init_freeable+0x43b/0x5d0 init/main.c:1571
 kernel_init+0x1d/0x2a0 init/main.c:1462
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801f47f300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801f47f380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801f47f400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88801f47f480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801f47f500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
