Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D185376F584
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 00:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjHCWPB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 18:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHCWPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:15:01 -0400
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F862726
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 15:14:59 -0700 (PDT)
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-6bcbb3fb76eso2360723a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Aug 2023 15:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691100898; x=1691705698;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xWuGunlhpV3gfwSP4YqmV/vDFap4pRJjEoFFhevuKpY=;
        b=kdg9rB6b/V+NaOQHJwGXSTYDX4V0EL606yEUQ4acv7mRAfMErxpaAwnSaihmpt4l5v
         YC8T/72wp2CjIVDzGfRC433IVp5cCo955E+pOFA9+xnUVhKvzznb6RI0ZqJVLeZE+bsf
         ULnCKioA+viBBJvuwN1rNtI130/t431vR7d7HFM5mxun2En2G4CV/z1sMWc0bZeoZhpP
         DcPvkV4niTWEpiUFix+w03WLOuYpUTfceqvBw6ihaYVTxjYdLqI/Y3m7LSxSJfjXDEtN
         z3jhVKZ3fF2X+EYvmj4MQjlL+fsghJVuvN0w7shimA5NxjT840DQhMkGeXJy/A1RWiMX
         ezow==
X-Gm-Message-State: ABy/qLYTrdQLtvpgi9lN3wsZ2zrRRB/vbTQJnSXBwhnsLdIpUwRhY6hl
        X01WP0DWM5axMJIeXMxX9NGjxDoDEEPQFUOsZnzDYPDEuHBW
X-Google-Smtp-Source: APBJJlGYP4PCfjelT3KQBQkr0PaU2Pgbky/2cQ0pgnBhJfZYxjib7+P/x4Fe2iuj6Wp3dPTNaIHzLDE0R8dFBAUHQYseryQieW/w
MIME-Version: 1.0
X-Received: by 2002:a05:6870:7703:b0:1bb:72af:4373 with SMTP id
 dw3-20020a056870770300b001bb72af4373mr20894069oab.10.1691100898709; Thu, 03
 Aug 2023 15:14:58 -0700 (PDT)
Date:   Thu, 03 Aug 2023 15:14:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058d58e06020c1cab@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in test_bdev_super_fc
From:   syzbot <syzbot+2faac0423fdc9692822b@syzkaller.appspotmail.com>
To:     brauner@kernel.org, hch@lst.de, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d7b3af5a77e8 Add linux-next specific files for 20230728
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15a26181a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62dd327c382e3fe
dashboard link: https://syzkaller.appspot.com/bug?extid=2faac0423fdc9692822b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f98b26a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14fb7009a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5efa5e68267f/disk-d7b3af5a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b1f5d3e10263/vmlinux-d7b3af5a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/57cab469d186/bzImage-d7b3af5a.xz

The issue was bisected to:

commit 1dbd9ceb390c4c61d28cf2c9251dd2015946ce51
Author: Jan Kara <jack@suse.cz>
Date:   Mon Jul 24 17:51:45 2023 +0000

    fs: open block device after superblock creation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=173870c5a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14b870c5a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=10b870c5a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2faac0423fdc9692822b@syzkaller.appspotmail.com
Fixes: 1dbd9ceb390c ("fs: open block device after superblock creation")

MTD: Attempt to mount non-MTD device "/dev/nullb0"
==================================================================
BUG: KASAN: slab-use-after-free in test_bdev_super_fc+0x10a/0x110 fs/super.c:1242
Read of size 8 at addr ffff88807887e058 by task syz-executor798/5042

CPU: 1 PID: 5042 Comm: syz-executor798 Not tainted 6.5.0-rc3-next-20230728-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 test_bdev_super_fc+0x10a/0x110 fs/super.c:1242
 sget_fc+0x584/0x860 fs/super.c:574
 get_tree_bdev+0x13e/0x6a0 fs/super.c:1323
 romfs_get_tree fs/romfs/super.c:561 [inline]
 romfs_get_tree+0x4e/0x60 fs/romfs/super.c:552
 vfs_get_tree+0x88/0x350 fs/super.c:1521
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8cfb721359
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffc0205068 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fffc02050b0 RCX: 00007f8cfb721359
RDX: 0000000020000040 RSI: 0000000020000080 RDI: 00000000200000c0
RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000f4240
R10: 0000000000000005 R11: 0000000000000246 R12: 00000000000f4240
R13: 00007fffc0205338 R14: 00007fffc020509c R15: 00007f8cfb76a06a
 </TASK>

Allocated by task 5038:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 alloc_super+0x52/0xb40 fs/super.c:202
 sget_fc+0x142/0x860 fs/super.c:580
 get_tree_bdev+0x13e/0x6a0 fs/super.c:1323
 romfs_get_tree fs/romfs/super.c:561 [inline]
 romfs_get_tree+0x4e/0x60 fs/romfs/super.c:552
 vfs_get_tree+0x88/0x350 fs/super.c:1521
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 4776:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15e/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2603
 worker_thread+0x687/0x1110 kernel/workqueue.c:2754
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 insert_work+0x4a/0x330 kernel/workqueue.c:1559
 __queue_work+0x5f5/0x1040 kernel/workqueue.c:1720
 queue_work_on+0xed/0x110 kernel/workqueue.c:1750
 rcu_do_batch kernel/rcu/tree.c:2139 [inline]
 rcu_core+0x7fb/0x1bb0 kernel/rcu/tree.c:2403
 __do_softirq+0x218/0x965 kernel/softirq.c:553

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:2653
 __put_super fs/super.c:345 [inline]
 put_super fs/super.c:309 [inline]
 deactivate_locked_super+0x144/0x170 fs/super.c:341
 get_tree_bdev+0x4c7/0x6a0 fs/super.c:1347
 romfs_get_tree fs/romfs/super.c:561 [inline]
 romfs_get_tree+0x4e/0x60 fs/romfs/super.c:552
 vfs_get_tree+0x88/0x350 fs/super.c:1521
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88807887e000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 88 bytes inside of
 freed 4096-byte region [ffff88807887e000, ffff88807887f000)

The buggy address belongs to the physical page:
page:ffffea0001e21e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x78878
head:ffffea0001e21e00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012842140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5038, tgid 5038 (syz-executor798), ts 42876874060, free_ts 42820208731
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d2/0x350 mm/page_alloc.c:1569
 prep_new_page mm/page_alloc.c:1576 [inline]
 get_page_from_freelist+0x10d7/0x31b0 mm/page_alloc.c:3256
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4512
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x24e/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8bc/0x1570 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x137/0x350 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1023 [inline]
 __kmalloc+0x4f/0x100 mm/slab_common.c:1037
 kmalloc include/linux/slab.h:603 [inline]
 tomoyo_realpath_from_path+0xb9/0x710 security/tomoyo/realpath.c:251
 tomoyo_mount_acl+0x1af/0x880 security/tomoyo/mount.c:105
 tomoyo_mount_permission+0x16d/0x410 security/tomoyo/mount.c:237
 security_sb_mount+0x86/0xd0 security/security.c:1361
 path_mount+0x129/0x1ed0 fs/namespace.c:3604
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1160 [inline]
 free_unref_page_prepare+0x508/0xb90 mm/page_alloc.c:2383
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2478
 __unfreeze_partials+0x21d/0x240 mm/slub.c:2655
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18b/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x172/0x3b0 mm/slub.c:3502
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 locks_alloc_lock fs/locks.c:271 [inline]
 flock_lock_inode+0xb7f/0xfe0 fs/locks.c:1039
 flock_lock_inode_wait fs/locks.c:2018 [inline]
 locks_lock_inode_wait+0x1c7/0x450 fs/locks.c:2045
 locks_lock_file_wait include/linux/filelock.h:346 [inline]
 __do_sys_flock+0x403/0x4c0 fs/locks.c:2115
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807887df00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807887df80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807887e000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88807887e080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807887e100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
