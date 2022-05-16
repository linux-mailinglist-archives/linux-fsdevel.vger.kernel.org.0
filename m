Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB985282B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 12:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiEPK5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 06:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiEPK5V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 06:57:21 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A33428E0E
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 03:57:20 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id l9-20020a0566022dc900b0065df0aa8372so4204853iow.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 03:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Yk+z4EqGd8v176tUvyL43kEfGuC703nmZAdq1JATjI8=;
        b=1xjIbqr1VJfEj5rhwHTtnLBVz5rH9iwi9PhRXTgaSBcXC+BMmoQme05S5BpKFDhwH4
         G4Ydj+SDzXGrBQLrEv0TNgF1CUpXC43mLgCP9UIapezLW1gnAX4IjPAfa6LsjmYx0Y4X
         Vxunq2164TmTtKQNOBGIFY06Swz0ZhVuksFPhILoXfrB9vY0Dp+YIQIR5JM9tDwoL1DT
         +Cc6z2T/so2LMDXaRedC/pcg97YKogX27Ga+jN5w8PPN6cgj+TckRKg9i2fLLaROXjAe
         vJ4QXd/VrTTvJBETb4JT347NS/NBCuUyqbbibOThxzGPFDr97EAOmhVxDj7oB1lhh7Uz
         BEzA==
X-Gm-Message-State: AOAM531ylYSl/mNA0xa3u6S/dRejg9DvizMWa8xNVlJ0C2Mly1yFEsVr
        H3ha84C0em3LWVscxPWlL9eI6I3ptlou7Dt67rEUYq6X1y3L
X-Google-Smtp-Source: ABdhPJxU4qflzje4zy9g4Q47iCeu/1c+2xI0GvJqo0N/OSYA+fPuErngEtwIqoHYg5koM63yen2/0+fNLL280opDE5PQzvWonk94
MIME-Version: 1.0
X-Received: by 2002:a92:cbc4:0:b0:2d1:2f29:8b8e with SMTP id
 s4-20020a92cbc4000000b002d12f298b8emr346988ilq.307.1652698639985; Mon, 16 May
 2022 03:57:19 -0700 (PDT)
Date:   Mon, 16 May 2022 03:57:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b73b505df1ee35f@google.com>
Subject: [syzbot] KASAN: use-after-free Read in handle_userfault (4)
From:   syzbot <syzbot+2972481db16665f2cb84@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

HEAD commit:    1e1b28b936ae Add linux-next specific files for 20220513
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1441e8bef00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4eb3c0c4b289571
dashboard link: https://syzkaller.appspot.com/bug?extid=2972481db16665f2cb84
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2972481db16665f2cb84@syzkaller.appspotmail.com

==================================================================
==================================================================
BUG: KASAN: use-after-free in handle_userfault+0x1364/0x1550 fs/userfaultfd.c:407
Read of size 8 at addr ffff88807de28390 by task syz-executor.2/3998

CPU: 0 PID: 3998 Comm: syz-executor.2 Not tainted 5.18.0-rc6-next-20220513-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 handle_userfault+0x1364/0x1550 fs/userfaultfd.c:407
 shmem_getpage_gfp+0x1ab6/0x1f30 mm/shmem.c:1859
 shmem_fault+0x1ae/0x750 mm/shmem.c:2078
 __do_fault+0x107/0x650 mm/memory.c:4169
 do_read_fault mm/memory.c:4515 [inline]
 do_fault mm/memory.c:4644 [inline]
 handle_pte_fault mm/memory.c:4907 [inline]
 __handle_mm_fault+0x2757/0x40f0 mm/memory.c:5046
 handle_mm_fault+0x1c8/0x790 mm/memory.c:5144
 do_user_addr_fault+0x489/0x11c0 arch/x86/mm/fault.c:1397
 handle_page_fault arch/x86/mm/fault.c:1484 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1540
 asm_exc_page_fault+0x27/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7f2f83827c93
Code: 00 00 00 00 00 66 90 48 89 7c 24 f0 48 89 74 24 e8 48 89 54 24 e0 48 89 4c 24 d8 48 8b 4c 24 f0 48 8b 74 24 e8 4c 8b 44 24 e0 <8b> 81 0c 01 00 00 44 8b 89 08 01 00 00 48 8b 54 24 d8 c1 e0 04 8d
RSP: 002b:00007f2f84a73158 EFLAGS: 00010216
RAX: 00007f2f83827c70 RBX: 00007f2f8399bf60 RCX: 0000000020816000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020816000
RBP: 00007f2f838e308d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020816000 R11: 0000000000000000 R12: 0000000000000000
R13: 00007ffe2fc20eaf R14: 00007f2f84a73300 R15: 0000000000022000
 </TASK>

Allocated by task 3998:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3229 [inline]
 kmem_cache_alloc+0x142/0x3b0 mm/slub.c:3239
 __do_sys_userfaultfd+0x9b/0x3e0 fs/userfaultfd.c:2098
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Freed by task 3998:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1727 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1753
 slab_free mm/slub.c:3507 [inline]
 kmem_cache_free+0xdd/0x5a0 mm/slub.c:3524
 userfaultfd_ctx_put fs/userfaultfd.c:180 [inline]
 userfaultfd_ctx_put+0x312/0x400 fs/userfaultfd.c:168
 handle_userfault+0xfb6/0x1550 fs/userfaultfd.c:555
 shmem_getpage_gfp+0x1ab6/0x1f30 mm/shmem.c:1859
 shmem_fault+0x1ae/0x750 mm/shmem.c:2078
 __do_fault+0x107/0x650 mm/memory.c:4169
 do_read_fault mm/memory.c:4515 [inline]
 do_fault mm/memory.c:4644 [inline]
 handle_pte_fault mm/memory.c:4907 [inline]
 __handle_mm_fault+0x2757/0x40f0 mm/memory.c:5046
 handle_mm_fault+0x1c8/0x790 mm/memory.c:5144
 do_user_addr_fault+0x489/0x11c0 arch/x86/mm/fault.c:1397
 handle_page_fault arch/x86/mm/fault.c:1484 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1540
 asm_exc_page_fault+0x27/0x30 arch/x86/include/asm/idtentry.h:570

The buggy address belongs to the object at ffff88807de28200
 which belongs to the cache userfaultfd_ctx_cache of size 408
The buggy address is located 400 bytes inside of
 408-byte region [ffff88807de28200, ffff88807de28398)

The buggy address belongs to the physical page:
page:ffffea0001f78a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7de28
head:ffffea0001f78a00 order:1 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888145a11dc0
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 3955, tgid 3952 (syz-executor.2), ts 194794080949, free_ts 180867939487
 prep_new_page mm/page_alloc.c:2439 [inline]
 get_page_from_freelist+0xa25/0x3d00 mm/page_alloc.c:4259
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5483
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2280
 alloc_slab_page mm/slub.c:1797 [inline]
 allocate_slab+0x26c/0x3c0 mm/slub.c:1942
 new_slab mm/slub.c:2002 [inline]
 ___slab_alloc+0x985/0xd90 mm/slub.c:3002
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3089
 slab_alloc_node mm/slub.c:3180 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3229 [inline]
 kmem_cache_alloc+0x360/0x3b0 mm/slub.c:3239
 __do_sys_userfaultfd+0x9b/0x3e0 fs/userfaultfd.c:2098
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1354 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1404
 free_unref_page_prepare mm/page_alloc.c:3290 [inline]
 free_unref_page+0x19/0x7b0 mm/page_alloc.c:3405
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2521
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3222 [inline]
 kmem_cache_alloc_trace+0x26d/0x3f0 mm/slub.c:3253
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 kernfs_fop_open+0x317/0xda0 fs/kernfs/file.c:621
 do_dentry_open+0x4a1/0x11f0 fs/open.c:824
 do_open fs/namei.c:3520 [inline]
 path_openat+0x1c71/0x2910 fs/namei.c:3653
 do_filp_open+0x1aa/0x400 fs/namei.c:3680
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1256
 do_sys_open fs/open.c:1272 [inline]
 __do_sys_openat fs/open.c:1288 [inline]
 __se_sys_openat fs/open.c:1283 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1283
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Memory state around the buggy address:
 ffff88807de28280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807de28300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807de28380: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
                         ^
 ffff88807de28400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807de28480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
