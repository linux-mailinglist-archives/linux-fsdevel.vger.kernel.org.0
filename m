Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22212609170
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Oct 2022 08:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJWGZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 02:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJWGZw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 02:25:52 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DBF52801
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Oct 2022 23:25:47 -0700 (PDT)
Received: by mail-qt1-f199.google.com with SMTP id cb19-20020a05622a1f9300b0039cc64d84edso5208492qtb.15
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Oct 2022 23:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zS4MOvLLBKHup6OwpYVQX/x0fY7sQQUlo90PdAN6GC4=;
        b=zS/Poi0tdO0iIFwSikXWB+bXDHumnaH21uWzsCR1zyNk5hbdhfZPIqNPNLEwPOkyOd
         qsq2WHfhDE7H6uI0E2z4N6bBoKrRcHz02xtr4FoJwQ8qDmxpkCdkdOciCqpK2gGlaax3
         wsfmLabTmEnwNpOeL4XXwmv9SeA3+I9wgHKktBBBeoFUpEPmWDTSjFDNFyFGXUH3ysjH
         sDyrhlbjWDFcKUozvXb/xKIIUYgI/IfyiZ2SwllhyHvW0MUBGa1zK9YEQy/u5qLYDHT5
         A6ORIaJbxDKTwIljgVC5O5kJTBryo3LQZ3JQ+xME02Hsf0YY37dG3oQVjcrJUAvRXeQB
         dH3w==
X-Gm-Message-State: ACrzQf0yvWU5ninCOXZ+0G7q5BRxpGAx6DINdfiEMzF1TUruOBx/0YiL
        RtIkMI0LWGHVBkYD4j8lgPeQj6IN9PeG21Xh2UNovCdCd+9C
X-Google-Smtp-Source: AMsMyM4N6XRDPdfO0DCMINcLFPdeja/B3MDwnE7tplICEHfxQYyxsKhNXCYrkDKJK4DfjpUTHi73eNR52VKbt4YiaY7wP4Is41cf
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1450:b0:363:7052:9c30 with SMTP id
 l16-20020a056638145000b0036370529c30mr18808179jad.53.1666506335963; Sat, 22
 Oct 2022 23:25:35 -0700 (PDT)
Date:   Sat, 22 Oct 2022 23:25:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bcfe805ebadbe9c@google.com>
Subject: [syzbot] KASAN: use-after-free Read in mas_next_entry
From:   syzbot <syzbot+0d2014e4da2ccced5b41@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4da34b7d175d Merge tag 'thermal-6.1-rc2' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=105ccd4a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4789759e8a6d5f57
dashboard link: https://syzkaller.appspot.com/bug?extid=0d2014e4da2ccced5b41
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103d4bc2880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100e4926880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a61ddb36c296/disk-4da34b7d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ceee41246252/vmlinux-4da34b7d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d2014e4da2ccced5b41@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in mas_safe_min lib/maple_tree.c:721 [inline]
BUG: KASAN: use-after-free in mas_next_nentry lib/maple_tree.c:4662 [inline]
BUG: KASAN: use-after-free in mas_next_entry+0x344/0x10f0 lib/maple_tree.c:4757
Read of size 8 at addr ffff88801ea79220 by task syz-executor379/3613

CPU: 0 PID: 3613 Comm: syz-executor379 Not tainted 6.1.0-rc1-syzkaller-00249-g4da34b7d175d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x220 mm/kasan/report.c:395
 kasan_report+0x139/0x170 mm/kasan/report.c:495
 mas_safe_min lib/maple_tree.c:721 [inline]
 mas_next_nentry lib/maple_tree.c:4662 [inline]
 mas_next_entry+0x344/0x10f0 lib/maple_tree.c:4757
 userfaultfd_unregister+0x1240/0x13b0 fs/userfaultfd.c:1657
 userfaultfd_ioctl+0x5a1/0x3230 fs/userfaultfd.c:2005
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efce94ac5f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efce945a318 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007efce95354a8 RCX: 00007efce94ac5f9
RDX: 0000000020000000 RSI: 000000008010aa01 RDI: 0000000000000003
RBP: 00007efce95354a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007efce95354ac
R13: 00007ffc7d044eef R14: 00007efce945a400 R15: 0000000000022000
 </TASK>

Allocated by task 3602:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x70 mm/kasan/common.c:52
 __kasan_slab_alloc+0x65/0x70 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 kmem_cache_alloc_bulk+0x43d/0x580 mm/slub.c:3854
 mt_alloc_bulk lib/maple_tree.c:157 [inline]
 mas_alloc_nodes+0x386/0x650 lib/maple_tree.c:1256
 mas_node_count_gfp lib/maple_tree.c:1316 [inline]
 mas_node_count lib/maple_tree.c:1330 [inline]
 mas_expected_entries+0x215/0x340 lib/maple_tree.c:5822
 dup_mmap+0x5f6/0xff0 kernel/fork.c:613
 dup_mm+0x8c/0x310 kernel/fork.c:1526
 copy_mm+0xcb/0x160 kernel/fork.c:1575
 copy_process+0x1973/0x3fc0 kernel/fork.c:2253
 kernel_clone+0x227/0x640 kernel/fork.c:2671
 __do_sys_clone kernel/fork.c:2812 [inline]
 __se_sys_clone kernel/fork.c:2796 [inline]
 __x64_sys_clone+0x276/0x2e0 kernel/fork.c:2796
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 3613:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 kmem_cache_free_bulk+0x137/0x1a0 mm/slub.c:3779
 mt_free_bulk lib/maple_tree.c:163 [inline]
 mas_destroy+0x2d02/0x37b0 lib/maple_tree.c:5769
 mas_store_prealloc+0x35d/0x450 lib/maple_tree.c:5704
 vma_mas_store mm/mmap.c:435 [inline]
 __vma_adjust+0x1a93/0x2120 mm/mmap.c:811
 __split_vma+0x374/0x4f0
 userfaultfd_unregister+0x119b/0x13b0 fs/userfaultfd.c:1641
 userfaultfd_ioctl+0x5a1/0x3230 fs/userfaultfd.c:2005
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801ea79200
 which belongs to the cache maple_node of size 256
The buggy address is located 32 bytes inside of
 256-byte region [ffff88801ea79200, ffff88801ea79300)

The buggy address belongs to the physical page:
page:ffffea00007a9e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ea78
head:ffffea00007a9e00 order:1 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff88801204fdc0
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3602, tgid 3602 (syz-executor379), ts 40896714662, free_ts 36283338200
 prep_new_page mm/page_alloc.c:2538 [inline]
 get_page_from_freelist+0x72b/0x7a0 mm/page_alloc.c:4287
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5554
 alloc_slab_page+0x70/0xf0 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x7f4/0xeb0 mm/slub.c:3180
 kmem_cache_alloc_bulk+0x1f1/0x580 mm/slub.c:3830
 mt_alloc_bulk lib/maple_tree.c:157 [inline]
 mas_alloc_nodes+0x386/0x650 lib/maple_tree.c:1256
 mas_node_count_gfp lib/maple_tree.c:1316 [inline]
 mas_preallocate+0x133/0x340 lib/maple_tree.c:5719
 mmap_region+0x1446/0x1db0 mm/mmap.c:2681
 do_mmap+0x8d9/0xf60 mm/mmap.c:1412
 vm_mmap_pgoff+0x1e5/0x2f0 mm/util.c:520
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1458 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1508
 free_unref_page_prepare mm/page_alloc.c:3386 [inline]
 free_unref_page+0x7d/0x630 mm/page_alloc.c:3482
 free_slab mm/slub.c:2031 [inline]
 discard_slab mm/slub.c:2037 [inline]
 __unfreeze_partials+0x1ab/0x200 mm/slub.c:2586
 put_cpu_partial+0x116/0x180 mm/slub.c:2662
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x1f/0x70 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 kmem_cache_alloc_node+0x1ca/0x340 mm/slub.c:3443
 __alloc_skb+0xd5/0x620 net/core/skbuff.c:497
 alloc_skb include/linux/skbuff.h:1267 [inline]
 alloc_skb_with_frags+0xb4/0x780 net/core/skbuff.c:6124
 sock_alloc_send_pskb+0x930/0xa70 net/core/sock.c:2719
 unix_dgram_sendmsg+0x5b3/0x2050 net/unix/af_unix.c:1943
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg net/socket.c:734 [inline]
 __sys_sendto+0x46d/0x5f0 net/socket.c:2117
 __do_sys_sendto net/socket.c:2129 [inline]
 __se_sys_sendto net/socket.c:2125 [inline]
 __x64_sys_sendto+0xda/0xf0 net/socket.c:2125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88801ea79100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801ea79180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801ea79200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88801ea79280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801ea79300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
