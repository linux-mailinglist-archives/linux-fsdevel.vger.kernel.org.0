Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5757400AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjF0QRA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjF0QQ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:16:58 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C2D1727
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 09:16:57 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-77a1f4e92cdso187839f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 09:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687882616; x=1690474616;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmmWO32l6+0tLvq0cR3kBF1JPORpl7by7B2xGMqwy8c=;
        b=FcAg8icx2VgGdeRou2gqtLAqA75/d11GJy78Du9DZbbk7GTT2Tl1hq2LVGZZCLy8Da
         PcJ8SzIu6CNIZkRHPDLbRgQLsG98TosD2YwZXm6qcKxNAAsQ2gFEr8kKNZ61Tf4bStgq
         NVACIvVp7XdT4tWpHzPsa+bVzH2QGDGnQec/w8Jfe7UMBG6QyWgmznfU+w+i1caDhbal
         Z6z2tD7DLgONoQJiKzYedU6XI/wIu+rrFgQQkl84Ifmc5ZzvlPWnqpHfZqgojMaQoBhk
         iai48hr/W8eMeONE4J6bv6GcdSSFM6kotQvhXYxdfCWYCsSTNxaMcslGSB51Yp9hzbo/
         +bMA==
X-Gm-Message-State: AC+VfDxgEeMG+GPMQk5lIoFqIyR6G/8HlJPBOjh11OImak5bMD9rVf4r
        zS3H+1ZsHF8H5oxTxhAqoCFm8sCaLczAzSO2butnbN5y1+AT
X-Google-Smtp-Source: ACHHUZ47VF3fPYX94LHOoXfm7+4nU08ofyIIkEIWBQUHv8RgvcYtEUPLMNV5YVomKesHRfByh7u9TZt6yc/bpma236k0UiKFHLE6
MIME-Version: 1.0
X-Received: by 2002:a6b:6018:0:b0:783:535f:85d9 with SMTP id
 r24-20020a6b6018000000b00783535f85d9mr2131481iog.2.1687882616507; Tue, 27 Jun
 2023 09:16:56 -0700 (PDT)
Date:   Tue, 27 Jun 2023 09:16:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7970f05ff1ecb4d@google.com>
Subject: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_find_extent (3)
From:   syzbot <syzbot+7ec4ebe875a7076ebb31@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    8a28a0b6f1a1 Merge tag 'net-6.4-rc8' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12f5b40b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e74b395fe4978721
dashboard link: https://syzkaller.appspot.com/bug?extid=7ec4ebe875a7076ebb31
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a2b5c0a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1181c5c0a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1e2a94b42e4e/disk-8a28a0b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b1e26b25d39/vmlinux-8a28a0b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bd8294ebd044/bzImage-8a28a0b6.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/52d75ce070c3/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/8168124ab578/mount_5.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7ec4ebe875a7076ebb31@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ext4_ext_binsearch fs/ext4/extents.c:837 [inline]
BUG: KASAN: use-after-free in ext4_find_extent+0xbc8/0xde0 fs/ext4/extents.c:953
Read of size 4 at addr ffff888073caa838 by task syz-executor976/4999

CPU: 0 PID: 4999 Comm: syz-executor976 Not tainted 6.4.0-rc7-syzkaller-00194-g8a28a0b6f1a1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:351 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:462
 kasan_report+0x176/0x1b0 mm/kasan/report.c:572
 ext4_ext_binsearch fs/ext4/extents.c:837 [inline]
 ext4_find_extent+0xbc8/0xde0 fs/ext4/extents.c:953
 ext4_ext_map_blocks+0x2d1/0x7210 fs/ext4/extents.c:4102
 ext4_map_blocks+0xa4c/0x1cf0 fs/ext4/inode.c:623
 _ext4_get_block+0x238/0x6a0 fs/ext4/inode.c:779
 __block_write_begin_int+0x548/0x1a50 fs/buffer.c:2064
 __block_write_begin fs/buffer.c:2114 [inline]
 block_page_mkwrite+0x2fc/0x620 fs/buffer.c:2588
 ext4_page_mkwrite+0x4ff/0x1290 fs/ext4/inode.c:6142
 do_page_mkwrite+0x1a4/0x600 mm/memory.c:2931
 wp_page_shared mm/memory.c:3280 [inline]
 do_wp_page+0x501/0x3690 mm/memory.c:3362
 handle_pte_fault mm/memory.c:4964 [inline]
 __handle_mm_fault mm/memory.c:5089 [inline]
 handle_mm_fault+0x2371/0x5860 mm/memory.c:5243
 do_user_addr_fault arch/x86/mm/fault.c:1440 [inline]
 handle_page_fault arch/x86/mm/fault.c:1534 [inline]
 exc_page_fault+0x7d2/0x910 arch/x86/mm/fault.c:1590
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7f4b17ab09d5
Code: 73 00 e9 06 f8 ff ff 66 c7 04 25 00 01 00 20 2e 00 e9 28 f8 ff ff b8 00 36 00 20 48 8d 35 0b 4e 0a 00 b9 25 00 00 00 48 89 c7 <f3> 48 a5 0f b6 06 88 07 e9 38 f8 ff ff 50 b9 00 36 00 20 ba ac 04
RSP: 002b:00007ffcb22cf580 EFLAGS: 00010246
RAX: 0000000020003600 RBX: 00007ffcb22cf5b8 RCX: 0000000000000025
RDX: 40854a4c23aebd1f RSI: 00007f4b17b557d8 RDI: 0000000020003600
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffcb22cf5b0
R13: 0000000000000000 R14: 431bde82d7b634db R15: 0000000000000000
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001cf2a80 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x73caa
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 ffffea0001cf2ac8 ffffea0001cf2a48 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO), pid 4990, tgid 4990 (sshd), ts 67865553810, free_ts 68052578311
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0x321c/0x33a0 mm/page_alloc.c:3502
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4768
 __folio_alloc+0x13/0x30 mm/page_alloc.c:4800
 vma_alloc_folio+0x48a/0x9a0 mm/mempolicy.c:2240
 do_anonymous_page mm/memory.c:4085 [inline]
 do_pte_missing mm/memory.c:3645 [inline]
 handle_pte_fault mm/memory.c:4947 [inline]
 __handle_mm_fault mm/memory.c:5089 [inline]
 handle_mm_fault+0x2942/0x5860 mm/memory.c:5243
 do_user_addr_fault arch/x86/mm/fault.c:1349 [inline]
 handle_page_fault arch/x86/mm/fault.c:1534 [inline]
 exc_page_fault+0x274/0x910 arch/x86/mm/fault.c:1590
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2564
 free_unref_page_list+0x596/0x830 mm/page_alloc.c:2705
 release_pages+0x2193/0x2470 mm/swap.c:1042
 tlb_batch_pages_flush mm/mmu_gather.c:97 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu+0x100/0x210 mm/mmu_gather.c:299
 tlb_finish_mmu+0xd4/0x1f0 mm/mmu_gather.c:391
 exit_mmap+0x3da/0xaf0 mm/mmap.c:3120
 __mmput+0x115/0x3c0 kernel/fork.c:1351
 exit_mm+0x227/0x310 kernel/exit.c:567
 do_exit+0x612/0x2290 kernel/exit.c:861
 do_group_exit+0x206/0x2c0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888073caa700: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888073caa780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888073caa800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                        ^
 ffff888073caa880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888073caa900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
