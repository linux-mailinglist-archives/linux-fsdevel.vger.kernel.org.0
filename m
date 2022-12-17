Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91E764F7AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 05:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiLQE7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 23:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiLQE7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 23:59:49 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD875F415
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 20:59:47 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id i7-20020a056e021b0700b003033a763270so2901653ilv.19
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 20:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uMyRiAn4BOTag1dhYuWSfY/4/XD9/1smv7l0jbo2Ue8=;
        b=bZPuORf2BVU8pjmWX6VqawC7Jxjdk/oHrU4dFBvmb7qe15aN2vQAcHLl5J1t80WpYn
         4xdGD0UhSoaWPZYddqg/GWhGwmxhGIsJv+jb265o4ucJgw9iTZfAOQvcgPrI8UhDPhax
         UoRSAXY9I7t+dytR/x5sUT8ixZiV8Qe6vR31rzAIM7bs5VaRPP8j6uxKQSE2mew9kHuV
         KNAVexQbFHcfpgnbvel4YnJvVaRu1C/i8XFjs3P1kUaOpR9s/c5xzUOjRew0srQFEnSm
         tznWNUfxeBi06ArBxoVScqvTZmYuWZjkOaAUEHaIwl3maorov+tl7tq/9YAnVSc3W/DB
         rUtQ==
X-Gm-Message-State: ANoB5pkSlKgL6sFVaWUyijjhgFPuUm17+sepuWz6wKGGRRHOr+tllRtj
        zQdCW8iMy7Dl9sT+0TUXvK2YV5c+cOAd4SWXsTifmnb5lfwd
X-Google-Smtp-Source: AA0mqf71Km3zPAhUquEN9Ur8W0SsFGNGzDINx8oI3F+5B7l+D6oVPEoS8gkBGJfiVG+Q7UPH9dpWAEyWPUI5RNjgFnmsKOINDw3W
MIME-Version: 1.0
X-Received: by 2002:a05:6638:372c:b0:38a:5ae5:d212 with SMTP id
 k44-20020a056638372c00b0038a5ae5d212mr8776331jav.257.1671253186944; Fri, 16
 Dec 2022 20:59:46 -0800 (PST)
Date:   Fri, 16 Dec 2022 20:59:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089a42105effef437@google.com>
Subject: [syzbot] KASAN: use-after-free Read in hfsplus_release_folio
From:   syzbot <syzbot+57e3e98f7e3b80f64d56@syzkaller.appspotmail.com>
To:     damien.lemoal@opensource.wdc.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    830b3c68c1fb Linux 6.1
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11c5aa9d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a194ed4fc682723
dashboard link: https://syzkaller.appspot.com/bug?extid=57e3e98f7e3b80f64d56
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d9a63f880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16335357880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/955d55d85d6c/disk-830b3c68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7ef0e1f6a0c3/vmlinux-830b3c68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/27601eb5ff0b/bzImage-830b3c68.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1cd85a260e69/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57e3e98f7e3b80f64d56@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
==================================================================
BUG: KASAN: use-after-free in hfsplus_release_folio+0x497/0x560 fs/hfsplus/inode.c:92
Read of size 4 at addr ffff888027fe6038 by task syz-executor976/3639

CPU: 1 PID: 3639 Comm: syz-executor976 Not tainted 6.1.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 hfsplus_release_folio+0x497/0x560 fs/hfsplus/inode.c:92
 block_invalidate_folio+0x661/0xa60 fs/buffer.c:1526
 folio_invalidate mm/truncate.c:159 [inline]
 truncate_cleanup_folio+0x1be/0x5c0 mm/truncate.c:179
 truncate_inode_pages_range+0x2c8/0x17f0 mm/truncate.c:369
 hfsplus_evict_inode+0x25/0xf0 fs/hfsplus/super.c:168
 evict+0x2a4/0x620 fs/inode.c:664
 hfsplus_put_super+0x207/0x320 fs/hfsplus/super.c:302
 generic_shutdown_super+0x130/0x310 fs/super.c:492
 kill_block_super+0x79/0xd0 fs/super.c:1428
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1186
 task_work_run+0x243/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x664/0x2070 kernel/exit.c:820
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:950
 __do_sys_exit_group kernel/exit.c:961 [inline]
 __se_sys_exit_group kernel/exit.c:959 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:959
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe998bb1cb9
Code: Unable to access opcode bytes at 0x7fe998bb1c8f.
RSP: 002b:00007ffd05507518 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fe998c273f0 RCX: 00007fe998bb1cb9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 00000000000005f6
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe998c273f0
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

Allocated by task 3639:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:553 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 hfsplus_btree_open+0x5a/0xd00 fs/hfsplus/btree.c:142
 hfsplus_fill_super+0xa7b/0x1b50 fs/hfsplus/super.c:473
 mount_bdev+0x26c/0x3a0 fs/super.c:1401
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 3639:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 __kmem_cache_free+0x71/0x110 mm/slub.c:3674
 hfsplus_put_super+0x1c7/0x320 fs/hfsplus/super.c:300
 generic_shutdown_super+0x130/0x310 fs/super.c:492
 kill_block_super+0x79/0xd0 fs/super.c:1428
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1186
 task_work_run+0x243/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x664/0x2070 kernel/exit.c:820
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:950
 __do_sys_exit_group kernel/exit.c:961 [inline]
 __se_sys_exit_group kernel/exit.c:959 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:959
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888027fe6000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 56 bytes inside of
 4096-byte region [ffff888027fe6000, ffff888027fe7000)

The buggy address belongs to the physical page:
page:ffffea00009ff800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27fe0
head:ffffea00009ff800 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888012842140
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3639, tgid 3639 (syz-executor976), ts 50631674390, free_ts 50602085924
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4291
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 alloc_slab_page+0xbd/0x190 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 __kmem_cache_alloc_node+0x252/0x310 mm/slub.c:3437
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc+0x9e/0x1a0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 tomoyo_realpath_from_path+0xcd/0x5f0 security/tomoyo/realpath.c:251
 tomoyo_mount_acl security/tomoyo/mount.c:141 [inline]
 tomoyo_mount_permission+0x972/0xa90 security/tomoyo/mount.c:237
 security_sb_mount+0x70/0xd0 security/security.c:979
 path_mount+0xbd/0x10c0 fs/namespace.c:3312
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3483
 free_slab mm/slub.c:2031 [inline]
 discard_slab mm/slub.c:2037 [inline]
 __unfreeze_partials+0x1ab/0x200 mm/slub.c:2586
 put_cpu_partial+0x106/0x170 mm/slub.c:2662
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x1f/0x70 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 __kmem_cache_alloc_node+0x1d7/0x310 mm/slub.c:3437
 kmalloc_trace+0x26/0x60 mm/slab_common.c:1045
 kmalloc include/linux/slab.h:553 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 kset_create lib/kobject.c:937 [inline]
 kset_create_and_add+0x55/0x280 lib/kobject.c:980
 register_queue_kobjects net/core/net-sysfs.c:1766 [inline]
 netdev_register_kobject+0x1a2/0x310 net/core/net-sysfs.c:2019
 register_netdevice+0x1043/0x1790 net/core/dev.c:10057
 register_netdev+0x37/0x50 net/core/dev.c:10183
 ip6_tnl_init_net+0x22a/0x350 net/ipv6/ip6_tunnel.c:2257
 ops_init+0x34e/0x5c0 net/core/net_namespace.c:135
 setup_net+0x4bb/0xc10 net/core/net_namespace.c:332

Memory state around the buggy address:
 ffff888027fe5f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888027fe5f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888027fe6000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff888027fe6080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888027fe6100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
