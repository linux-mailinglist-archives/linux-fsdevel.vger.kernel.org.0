Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9968473D2FE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jun 2023 20:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjFYS24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jun 2023 14:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjFYS2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jun 2023 14:28:55 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939B9138
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jun 2023 11:28:53 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7835d5bfaecso12619839f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jun 2023 11:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687717733; x=1690309733;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ju2DdSfEbV8SlpVDU55Jl3Losecf9PbROboDA08RpUY=;
        b=jS+yXVevBE27cxIbuffx4ql++Men0p43n0pfaEt8gCsL4jYbQ07iQ4KS115h4ReAhK
         zvO9LUgelbNN6b/rN4CNjFz1UyvpzcL/ipadxSuNlU0qelFy4LGlxpAAPJ3VzQF90n/e
         IufS62+g/EgjgQKn9IT8ck2tAfZGkJMzlAvhhs0GffOFVSeSTbq1b3TA4NMgJ7MNRMQb
         cDQan3PtaMMpKGXIkhPkkI6snERmOPld6MH0gBtAUdFqv6b46DKMAlw831wsNsYyqICY
         BxJo5YkH8YguCuA+NL2tUPyGxlPoUZJwsukgDlYND0iRUfd6bxUTgo/2SkcXLxq5Q7Jo
         qibg==
X-Gm-Message-State: AC+VfDwAA0ss8JzDQ0Okal5lgF+YekTm3/QesWViMf0cvhed8Kc3URsd
        1ZOeYtEuiF4/YuHBXjNz0D2PpfcYpJcV28EYUPmibThfK6rT
X-Google-Smtp-Source: ACHHUZ65ciJYqUAxOExe2+7A0M8Lk5wG0Bsm/QUTau1i/GE+ziDcP/4cJLdhp9xFveMGns5DeHRZwGQT1s+H70WjOjBdg2ej1jyD
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1137:b0:426:8d01:a26a with SMTP id
 f23-20020a056638113700b004268d01a26amr6229697jar.2.1687717732875; Sun, 25 Jun
 2023 11:28:52 -0700 (PDT)
Date:   Sun, 25 Jun 2023 11:28:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3038a05fef867f8@google.com>
Subject: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in f2fs_truncate_data_blocks_range
From:   syzbot <syzbot+12cb4425b22169b52036@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    e660abd551f1 Merge tag 'acpi-6.4-rc8' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13471cdb280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=12cb4425b22169b52036
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a63660a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131640c0a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2e47c18aa0be/disk-e660abd5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/716ba16b9d0f/vmlinux-e660abd5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab18bb4a6fb6/bzImage-e660abd5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c0c0363e4409/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+12cb4425b22169b52036@syzkaller.appspotmail.com

RSP: 002b:00007fff6c2d5898 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6711ef01e9
RDX: 00007f6711eae1c3 RSI: 00000000000001f8 RDI: 00000000200000c0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: 00007fff6c2d5760 R11: 0000000000000246 R12: 00007fff6c2d58c0
R13: 0000000000000000 R14: 431bde82d7b634db R15: 0000000000000000
 </TASK>
==================================================================
BUG: KASAN: slab-use-after-free in f2fs_truncate_data_blocks_range+0x122a/0x14c0 fs/f2fs/file.c:574
Read of size 4 at addr ffff88802a25c000 by task syz-executor148/5000

CPU: 1 PID: 5000 Comm: syz-executor148 Not tainted 6.4.0-rc7-syzkaller-00041-ge660abd551f1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 f2fs_truncate_data_blocks_range+0x122a/0x14c0 fs/f2fs/file.c:574
 truncate_dnode+0x229/0x2e0 fs/f2fs/node.c:944
 f2fs_truncate_inode_blocks+0x64b/0xde0 fs/f2fs/node.c:1154
 f2fs_do_truncate_blocks+0x4ac/0xf30 fs/f2fs/file.c:721
 f2fs_truncate_blocks+0x7b/0x300 fs/f2fs/file.c:749
 f2fs_truncate.part.0+0x4a5/0x630 fs/f2fs/file.c:799
 f2fs_truncate include/linux/fs.h:825 [inline]
 f2fs_setattr+0x1738/0x2090 fs/f2fs/file.c:1006
 notify_change+0xb2c/0x1180 fs/attr.c:483
 do_truncate+0x143/0x200 fs/open.c:66
 handle_truncate fs/namei.c:3295 [inline]
 do_open fs/namei.c:3640 [inline]
 path_openat+0x2083/0x2750 fs/namei.c:3791
 do_filp_open+0x1ba/0x410 fs/namei.c:3818
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_creat fs/open.c:1448 [inline]
 __se_sys_creat fs/open.c:1442 [inline]
 __x64_sys_creat+0xcd/0x120 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6711ef01e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff6c2d5898 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6711ef01e9
RDX: 00007f6711eae1c3 RSI: 00000000000001f8 RDI: 00000000200000c0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: 00007fff6c2d5760 R11: 0000000000000246 R12: 00007fff6c2d58c0
R13: 0000000000000000 R14: 431bde82d7b634db R15: 0000000000000000
 </TASK>

Allocated by task 4667:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:711 [inline]
 slab_alloc_node mm/slub.c:3451 [inline]
 kmem_cache_alloc_node+0x185/0x3e0 mm/slub.c:3496
 __alloc_skb+0x288/0x330 net/core/skbuff.c:644
 alloc_skb include/linux/skbuff.h:1288 [inline]
 alloc_skb_with_frags+0x9a/0x6c0 net/core/skbuff.c:6380
 sock_alloc_send_pskb+0x7a7/0x930 net/core/sock.c:2729
 unix_dgram_sendmsg+0x41b/0x1950 net/unix/af_unix.c:1944
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 sock_write_iter+0x295/0x3d0 net/socket.c:1140
 call_write_iter include/linux/fs.h:1868 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x945/0xd50 fs/read_write.c:584
 ksys_write+0x1ec/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 4668:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3786 [inline]
 kmem_cache_free+0xe9/0x480 mm/slub.c:3808
 kfree_skbmem+0xef/0x1b0 net/core/skbuff.c:971
 __kfree_skb net/core/skbuff.c:1029 [inline]
 consume_skb net/core/skbuff.c:1244 [inline]
 consume_skb+0xdf/0x170 net/core/skbuff.c:1238
 __unix_dgram_recvmsg+0x42c/0xb90 net/unix/af_unix.c:2532
 unix_dgram_recvmsg+0xc4/0xf0 net/unix/af_unix.c:2549
 sock_recvmsg_nosec net/socket.c:1019 [inline]
 sock_recvmsg+0xe2/0x160 net/socket.c:1040
 sock_read_iter+0x2bd/0x3b0 net/socket.c:1118
 call_read_iter include/linux/fs.h:1862 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x778/0x8a0 fs/read_write.c:470
 ksys_read+0x1ec/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88802a25c000
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 0 bytes inside of
 freed 240-byte region [ffff88802a25c000, ffff88802a25c0f0)

The buggy address belongs to the physical page:
page:ffffea0000a89700 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a25c
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff888019647500 dead000000000122 0000000000000000
raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 4667, tgid 4667 (dhcpcd), ts 55006053414, free_ts 46990193370
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0xf41/0x2c00 mm/page_alloc.c:3502
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4768
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3192
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3291
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 kmem_cache_alloc_node+0x138/0x3e0 mm/slub.c:3496
 __alloc_skb+0x288/0x330 net/core/skbuff.c:644
 alloc_skb include/linux/skbuff.h:1288 [inline]
 alloc_skb_with_frags+0x9a/0x6c0 net/core/skbuff.c:6380
 sock_alloc_send_pskb+0x7a7/0x930 net/core/sock.c:2729
 unix_dgram_sendmsg+0x41b/0x1950 net/unix/af_unix.c:1944
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 sock_write_iter+0x295/0x3d0 net/socket.c:1140
 call_write_iter include/linux/fs.h:1868 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x945/0xd50 fs/read_write.c:584
 ksys_write+0x1ec/0x250 fs/read_write.c:637
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2564
 free_unref_page+0x33/0x370 mm/page_alloc.c:2659
 __folio_put_small mm/swap.c:106 [inline]
 __folio_put+0xc5/0x140 mm/swap.c:129
 folio_put include/linux/mm.h:1430 [inline]
 put_page include/linux/mm.h:1499 [inline]
 anon_pipe_buf_release+0x3fb/0x4c0 fs/pipe.c:138
 pipe_buf_release include/linux/pipe_fs_i.h:203 [inline]
 pipe_read+0x620/0x1170 fs/pipe.c:324
 call_read_iter include/linux/fs.h:1862 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x778/0x8a0 fs/read_write.c:470
 ksys_read+0x1ec/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88802a25bf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802a25bf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88802a25c000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88802a25c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff88802a25c100: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
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
