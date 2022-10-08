Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8297F5F86BB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 20:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJHStu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 14:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJHSts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 14:49:48 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220FEDEA9
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Oct 2022 11:49:44 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id y13-20020a056e021bed00b002faba3c4afbso3885273ilv.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Oct 2022 11:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcqWwSGyuKcP0gRQSxDj0dKfGmYywAMKGeArDXcx+a8=;
        b=E5uo3PsMFbXMwa4JVI94ghIBL+Ur8M3jQt0DEfhBt2NhPDuPgkAyBsbcPMvFv+XD9W
         LpI+U85d/h65VWEzqBohGy1UpWX3DfLMSJmgwmbkJC/7Kugktmh8f9ZleR9Ni2ENLv8q
         ikHiU6tgdfPDiaaO3r1Itjc+nsAGx7U93qtoa3zqBAjTnJRT8ShEwDnLtR9SHvzFGcEc
         MsCeBK8SAkuXEKka9CjTLX6lpF2wDkUKGhivKVEVGkBU6ZlWXJDXyiJiExVyF1w/AIc2
         YQT0jew1/m572B3JI7BAmRjcEg7xqpiGafhZfx0rVkfbDHPsBOeLQuOpi7w7GGU0tjTL
         eElg==
X-Gm-Message-State: ACrzQf2AtxppM+tI5uGsOJJwZ4Lekws2zGcPLivy5+25P8CbcvR+ymYV
        UFysPagW8CaLepQhfZ7G2CZAeTGNztaOkpJc0coknKDwQD3n
X-Google-Smtp-Source: AMsMyM7k1jTeuoq6HffXhpaTygK/em9ZhFatB+H2Dyw1cP8oizSiLz2GDLUifXiInppHRvvPxAPKYsuwsg8GN6rpkd4tFkb5By0d
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13ca:b0:35a:7ece:3c6a with SMTP id
 i10-20020a05663813ca00b0035a7ece3c6amr5515228jaj.318.1665254983478; Sat, 08
 Oct 2022 11:49:43 -0700 (PDT)
Date:   Sat, 08 Oct 2022 11:49:43 -0700
In-Reply-To: <000000000000117c7505e7927cb4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c032fc05ea8a6357@google.com>
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in truncate_inode_pages_range
From:   syzbot <syzbot+5867885efe39089b339b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    e8bc52cb8df8 Merge tag 'driver-core-6.1-rc1' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a70a42880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7579993da6496f03
dashboard link: https://syzkaller.appspot.com/bug?extid=5867885efe39089b339b
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153137b8880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123cae34880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4dc25a89bfbd/disk-e8bc52cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/16c9ca5fd754/vmlinux-e8bc52cb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f3507911193f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5867885efe39089b339b@syzkaller.appspotmail.com

ntfs3: loop0: Different NTFS' sector size (1024) and media sector size (512)
==================================================================
BUG: KASAN: out-of-bounds in folio_batch_count include/linux/pagevec.h:108 [inline]
BUG: KASAN: out-of-bounds in truncate_inode_pages_range+0x512/0x17b0 mm/truncate.c:366
Read of size 1 at addr ffffc9000b40f8a0 by task syz-executor300/12162

CPU: 1 PID: 12162 Comm: syz-executor300 Not tainted 6.0.0-syzkaller-07994-ge8bc52cb8df8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:317
 print_report+0x108/0x220 mm/kasan/report.c:433
 kasan_report+0xfb/0x130 mm/kasan/report.c:495
 folio_batch_count include/linux/pagevec.h:108 [inline]
 truncate_inode_pages_range+0x512/0x17b0 mm/truncate.c:366
 ntfs_evict_inode+0x18/0xb0 fs/ntfs3/inode.c:1741
 evict+0x2a4/0x620 fs/inode.c:664
 ntfs_fill_super+0x3c6c/0x4420 fs/ntfs3/super.c:1190
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2e3/0x3d0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1170f482fa
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1170eee168 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f1170f482fa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f1170eee180
RBP: 0000000000000004 R08: 00007f1170eee1c0 R09: 00007f1170eee6b8
R10: 0000000000000000 R11: 0000000000000286 R12: 00007f1170eee1c0
R13: 0000000000000110 R14: 00007f1170eee180 R15: 0000000020001b80
 </TASK>

The buggy address belongs to stack of task syz-executor300/12162
 and is located at offset 32 in frame:
 truncate_inode_pages_range+0x0/0x17b0

This frame has 2 objects:
 [32, 160) 'fbatch'
 [192, 312) 'indices'

The buggy address belongs to the virtual mapping at
 [ffffc9000b408000, ffffc9000b411000) created by:
 dup_task_struct+0x8b/0x490 kernel/fork.c:977

The buggy address belongs to the physical page:
page:ffffea0001d7b300 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x75ecc
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 12161, tgid 12161 (syz-executor300), ts 362387697256, free_ts 362353989799
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x72b/0x7a0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
 vm_area_alloc_pages mm/vmalloc.c:2958 [inline]
 __vmalloc_area_node mm/vmalloc.c:3026 [inline]
 __vmalloc_node_range+0x8f4/0x1290 mm/vmalloc.c:3196
 alloc_thread_stack_node+0x307/0x500 kernel/fork.c:312
 dup_task_struct+0x8b/0x490 kernel/fork.c:977
 copy_process+0x637/0x3f60 kernel/fork.c:2085
 kernel_clone+0x22f/0x7a0 kernel/fork.c:2671
 __do_sys_clone kernel/fork.c:2805 [inline]
 __se_sys_clone kernel/fork.c:2789 [inline]
 __x64_sys_clone+0x276/0x2e0 kernel/fork.c:2789
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x7d/0x630 mm/page_alloc.c:3476
 mm_free_pgd kernel/fork.c:737 [inline]
 __mmdrop+0xae/0x3f0 kernel/fork.c:788
 exit_mm+0x211/0x2f0 kernel/exit.c:510
 do_exit+0x4e1/0x20a0 kernel/exit.c:782
 do_group_exit+0x23b/0x2f0 kernel/exit.c:925
 get_signal+0x172f/0x1780 kernel/signal.c:2857
 arch_do_signal_or_restart+0x8d/0x750 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop+0x74/0x160 kernel/entry/common.c:166
 exit_to_user_mode_prepare+0xad/0x110 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x2e/0x60 kernel/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffffc9000b40f780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000b40f800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000b40f880: f1 f1 f1 f1 00 00 00 00 00 00 00 00 00 00 00 00
                                  ^
 ffffc9000b40f900: 00 00 00 00 f2 f2 f2 f2 00 00 00 00 00 00 00 00
 ffffc9000b40f980: 00 00 00 00 00 00 00 f3 f3 f3 f3 f3 00 00 00 00
==================================================================

