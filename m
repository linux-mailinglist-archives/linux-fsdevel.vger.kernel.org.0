Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1836CCFAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 03:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjC2B4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 21:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjC2B4J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:56:09 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4731BE
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 18:56:06 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id z8-20020a92cd08000000b00317b27a795aso9230972iln.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 18:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680054966; x=1682646966;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7OaTw+zxVPVnks4Ao3yniimiWG4rRyV6sGIIqnIQ6Y=;
        b=KznKQ4TVsimXf5CJ5TtVWG4d3ME/cnkSWwW2RrMulO2LtU8GDCKsskykjx8FYBk2ai
         ejBRlYW1VWEUffLPsDIql4ldW0c6WRjG4uQPTbEVN2348p/z+6WfDm7UH7h8K952/Pfv
         aa7GVYsSApXN4TfToMcvSwd4nct6UkJt9oHPMaoAj0obsG1/IoHQrO01+CwFhqcP2AQK
         okpoFxEtHuly+UYy9Pi8yxDk1eTZzFhSq9wGxRnlzz6dRSI2PtSAfg3gf7/ZQcWYleWS
         qs6jEjK7d5tkuHGQ+VttDE/qEzI+1A93kvyiwEhpiiFUlcJh+SaXx0xrsudGRhcaGC7/
         8UAA==
X-Gm-Message-State: AO0yUKXoG4OLSCG/RKZLifiPEMIO9SVb1FIyRIM690ek/3ntJLM4Ki57
        Bm+pRd66o7C/oLHMjzQlFz2rVoITPb5Q7pkiy2vd4Ar3vS6AWaRd2g==
X-Google-Smtp-Source: AK7set+oreVjgeOsML0wV2RDLYCUBNxUnqkhxRyFotcall1m3vxcdziests59jDEjmoC9zigti6mLiym9dcAbKazLRDmAVZaN+yi
MIME-Version: 1.0
X-Received: by 2002:a05:6638:cc1:b0:404:4ebe:4e5b with SMTP id
 e1-20020a0566380cc100b004044ebe4e5bmr7008740jak.5.1680054966118; Tue, 28 Mar
 2023 18:56:06 -0700 (PDT)
Date:   Tue, 28 Mar 2023 18:56:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007584ba05f80047bb@google.com>
Subject: [syzbot] [reiserfs?] KASAN: use-after-free Read in reiserfs_get_unused_objectid
From:   syzbot <syzbot+04e8b36eaa27ecf7f840@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1e760fa3596e Merge tag 'gfs2-v6.3-rc3-fix' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1746cb0ec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
dashboard link: https://syzkaller.appspot.com/bug?extid=04e8b36eaa27ecf7f840
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d5c261c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155eba51c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/17229b6e6fe0/disk-1e760fa3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/69b5d310fba0/vmlinux-1e760fa3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0c65624aace9/bzImage-1e760fa3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/18aebd583db0/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+04e8b36eaa27ecf7f840@syzkaller.appspotmail.com

REISERFS (device loop0): journal params: device loop0, size 512, journal first block 18, max trans len 256, max batch 225, max commit age 30, max trans age 30
REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using r5 hash to sort names
==================================================================
BUG: KASAN: use-after-free in reiserfs_get_unused_objectid+0x231/0x490 fs/reiserfs/objectid.c:87
Read of size 250888 at addr ffff888073c6b058 by task syz-executor137/5072

CPU: 1 PID: 5072 Comm: syz-executor137 Not tainted 6.3.0-rc3-syzkaller-00031-g1e760fa3596e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:319 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:430
 kasan_report+0x176/0x1b0 mm/kasan/report.c:536
 kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
 __asan_memmove+0x29/0x70 mm/kasan/shadow.c:94
 reiserfs_get_unused_objectid+0x231/0x490 fs/reiserfs/objectid.c:87
 reiserfs_new_inode+0x2bc/0x1da0 fs/reiserfs/inode.c:1944
 reiserfs_mkdir+0x5b0/0x8f0 fs/reiserfs/namei.c:845
 xattr_mkdir fs/reiserfs/xattr.c:76 [inline]
 create_privroot fs/reiserfs/xattr.c:882 [inline]
 reiserfs_xattr_init+0x34c/0x730 fs/reiserfs/xattr.c:1005
 reiserfs_fill_super+0x2207/0x2620 fs/reiserfs/super.c:2175
 mount_bdev+0x271/0x3a0 fs/super.c:1380
 legacy_get_tree+0xef/0x190 fs/fs_context.c:610
 vfs_get_tree+0x8c/0x270 fs/super.c:1510
 do_new_mount+0x28f/0xae0 fs/namespace.c:3042
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f650fbcb3aa
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 f8 03 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc35632868 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f650fbcb3aa
RDX: 0000000020000080 RSI: 0000000020000040 RDI: 00007ffc35632880
RBP: 00007ffc35632880 R08: 00007ffc356328c0 R09: 0000000000001132
R10: 0000000000008008 R11: 0000000000000286 R12: 0000000000000004
R13: 0000555555df42c0 R14: 0000000000008008 R15: 00007ffc356328c0
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001cf1ac0 refcount:3 mapcount:0 mapping:ffff888144c549f8 index:0x10 pfn:0x73c6b
memcg:ffff888140196000
aops:def_blk_aops ino:700000
flags: 0xfff00000002022(referenced|active|private|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000002022 0000000000000000 dead000000000122 ffff888144c549f8
raw: 0000000000000010 ffff8880751fc910 00000003ffffffff ffff888140196000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Movable, gfp_mask 0x148c48(GFP_NOFS|__GFP_NOFAIL|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 5072, tgid 5072 (syz-executor137), ts 69127009678, free_ts 60810646673
 prep_new_page mm/page_alloc.c:2552 [inline]
 get_page_from_freelist+0x3246/0x33c0 mm/page_alloc.c:4325
 __alloc_pages+0x255/0x670 mm/page_alloc.c:5591
 folio_alloc+0x1e/0x60 mm/mempolicy.c:2293
 filemap_alloc_folio+0xde/0x500 mm/filemap.c:976
 __filemap_get_folio+0x719/0xe50 mm/filemap.c:1970
 pagecache_get_page+0x2c/0x240 mm/folio-compat.c:99
 find_or_create_page include/linux/pagemap.h:632 [inline]
 grow_dev_page fs/buffer.c:989 [inline]
 grow_buffers fs/buffer.c:1054 [inline]
 __getblk_slow fs/buffer.c:1081 [inline]
 __getblk_gfp+0x215/0xa40 fs/buffer.c:1376
 __bread_gfp+0x2e/0x380 fs/buffer.c:1410
 sb_bread include/linux/buffer_head.h:341 [inline]
 read_super_block+0x91/0x800 fs/reiserfs/super.c:1604
 reiserfs_fill_super+0x912/0x2620 fs/reiserfs/super.c:1966
 mount_bdev+0x271/0x3a0 fs/super.c:1380
 legacy_get_tree+0xef/0x190 fs/fs_context.c:610
 vfs_get_tree+0x8c/0x270 fs/super.c:1510
 do_new_mount+0x28f/0xae0 fs/namespace.c:3042
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare mm/page_alloc.c:1503 [inline]
 free_unref_page_prepare+0xe2f/0xe70 mm/page_alloc.c:3387
 free_unref_page_list+0x596/0x830 mm/page_alloc.c:3528
 release_pages+0x219e/0x2470 mm/swap.c:1042
 tlb_batch_pages_flush mm/mmu_gather.c:97 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu+0x100/0x210 mm/mmu_gather.c:299
 tlb_finish_mmu+0xd4/0x1f0 mm/mmu_gather.c:391
 exit_mmap+0x2c9/0x850 mm/mmap.c:3047
 __mmput+0x115/0x3c0 kernel/fork.c:1209
 exit_mm+0x227/0x310 kernel/exit.c:563
 do_exit+0x612/0x2290 kernel/exit.c:856
 do_group_exit+0x206/0x2c0 kernel/exit.c:1019
 __do_sys_exit_group kernel/exit.c:1030 [inline]
 __se_sys_exit_group kernel/exit.c:1028 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1028
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888073c6bf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888073c6bf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888073c6c000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff888073c6c080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888073c6c100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
