Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2C256D4D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 08:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiGKGlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 02:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGKGlY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:41:24 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB9717594
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Jul 2022 23:41:22 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id g4-20020a056e021a2400b002dc45b0ba54so2799606ile.17
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Jul 2022 23:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=W3Kz+I1koeulszWwKka+ACCAqii80NtWXfp+IS9cHao=;
        b=xmSXNBthh2zEiySq7Z1NqUkrfz3CIC8K1rIzVU7q8+37oxnwUt+aClBKEqKEaglYao
         ThN9uKQWQ2u3HRWubzpU/mDO/yPohQ0+KK2L2i2z611HksZNxKgVWYPHoGlf9eKUPfgh
         7aY2UJLVeb/xSmjJhCEJezojzZ+XL1MwUfe/LWIibtXyIUbDcdGXUDF9oUxOAyC85+xu
         4/3R+KYzvnrzrOP7zt7ZungwmSuLCr9GvJTHKkdVQnYVhL8m/W3nxxPlexiy6+uz2AKt
         whvbtQZx9qeBwGkIrgmI4R3+J9ClO4kReIuCY1fpKdjmptiHrWdJPcFj76s4RWMjrMtE
         bQkw==
X-Gm-Message-State: AJIora9gCUWeARe22J/A30rJjovCY+aA/uxzoLcPshRpT/Qsxk4l+UM6
        J0da0sP2TMWeXAYw8dnwA35+c3+JusPt1sawKXKRh3OvtSOw
X-Google-Smtp-Source: AGRyM1tckUCk0+fbHQnzT+47Fyw/9pK9qqc1cnysayIJtjXHOXnrryWanU2swGq/ycieai4v4mYK1T/h+7xxDJdjV310QHtExxEj
MIME-Version: 1.0
X-Received: by 2002:a92:c901:0:b0:2da:8497:501f with SMTP id
 t1-20020a92c901000000b002da8497501fmr8441207ilp.182.1657521682332; Sun, 10
 Jul 2022 23:41:22 -0700 (PDT)
Date:   Sun, 10 Jul 2022 23:41:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001544f005e381d722@google.com>
Subject: [syzbot] KASAN: use-after-free Read in kill_fasync
From:   syzbot <syzbot+382c8824777dca2812fe@syzkaller.appspotmail.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cb71b93c2dc3 Add linux-next specific files for 20220628
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13a297cc080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=382c8824777dca2812fe
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115fdbec080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132e4c92080000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a3c0a4080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17a3c0a4080000
console output: https://syzkaller.appspot.com/x/log.txt?x=13a3c0a4080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+382c8824777dca2812fe@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in kill_fasync+0x45e/0x470 fs/fcntl.c:1014
Read of size 8 at addr ffff88807dc93168 by task kworker/0:2/144

CPU: 0 PID: 144 Comm: kworker/0:2 Not tainted 5.19.0-rc4-next-20220628-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
Workqueue: events key_garbage_collector
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xbe/0x1f0 mm/kasan/report.c:495
 kill_fasync+0x45e/0x470 fs/fcntl.c:1014
 post_one_notification.isra.0+0x6e4/0x990 kernel/watch_queue.c:128
 remove_watch_from_object+0x35a/0x9d0 kernel/watch_queue.c:527
 remove_watch_list include/linux/watch_queue.h:115 [inline]
 key_gc_unused_keys.constprop.0+0x2e5/0x600 security/keys/gc.c:135
 key_garbage_collector+0x3d7/0x920 security/keys/gc.c:297
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>

Allocated by task 5494:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 alloc_pipe_info+0x105/0x590 fs/pipe.c:790
 get_pipe_inode fs/pipe.c:881 [inline]
 create_pipe_files+0x8d/0x880 fs/pipe.c:913
 __do_pipe_flags fs/pipe.c:962 [inline]
 do_pipe2+0x96/0x1b0 fs/pipe.c:1010
 __do_sys_pipe2 fs/pipe.c:1028 [inline]
 __se_sys_pipe2 fs/pipe.c:1026 [inline]
 __x64_sys_pipe2+0x50/0x70 fs/pipe.c:1026
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Freed by task 5494:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1c0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1780
 slab_free mm/slub.c:3534 [inline]
 kfree+0xe2/0x4d0 mm/slub.c:4562
 put_pipe_info fs/pipe.c:711 [inline]
 pipe_release+0x2b6/0x310 fs/pipe.c:734
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xaf1/0x29f0 kernel/exit.c:795
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

The buggy address belongs to the object at ffff88807dc93000
 which belongs to the cache kmalloc-cg-512 of size 512
The buggy address is located 360 bytes inside of
 512-byte region [ffff88807dc93000, ffff88807dc93200)

The buggy address belongs to the physical page:
page:ffffea0001f72400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7dc90
head:ffffea0001f72400 order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888011842dc0
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5470, tgid 5470 (syz-executor105), ts 76271246150, free_ts 76264094282
 prep_new_page mm/page_alloc.c:2535 [inline]
 get_page_from_freelist+0x210d/0x3a30 mm/page_alloc.c:4282
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5506
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2280
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x89d/0xef0 mm/slub.c:3031
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 kmem_cache_alloc_trace+0x323/0x3e0 mm/slub.c:3282
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 alloc_pipe_info+0x105/0x590 fs/pipe.c:790
 get_pipe_inode fs/pipe.c:881 [inline]
 create_pipe_files+0x8d/0x880 fs/pipe.c:913
 __do_pipe_flags fs/pipe.c:962 [inline]
 do_pipe2+0x96/0x1b0 fs/pipe.c:1010
 __do_sys_pipe2 fs/pipe.c:1028 [inline]
 __se_sys_pipe2 fs/pipe.c:1026 [inline]
 __x64_sys_pipe2+0x50/0x70 fs/pipe.c:1026
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1503
 free_unref_page_prepare mm/page_alloc.c:3383 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3479
 __stack_depot_save+0x168/0x500 lib/stackdepot.c:489
 kasan_save_stack+0x2e/0x40 mm/kasan/common.c:39
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
 kmalloc include/linux/slab.h:605 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 kobject_get_path+0xbe/0x230 lib/kobject.c:147
 kobject_uevent_env+0x254/0x1640 lib/kobject_uevent.c:529
 call_crda+0x17e/0x3b0 net/wireless/reg.c:583
 reg_query_database net/wireless/reg.c:1158 [inline]
 reg_process_hint_core net/wireless/reg.c:2693 [inline]
 reg_process_hint+0x925/0x1710 net/wireless/reg.c:3036
 reg_process_pending_hints net/wireless/reg.c:3124 [inline]
 reg_todo+0x1a5/0x7d0 net/wireless/reg.c:3212
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302

Memory state around the buggy address:
 ffff88807dc93000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807dc93080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807dc93100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88807dc93180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807dc93200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
