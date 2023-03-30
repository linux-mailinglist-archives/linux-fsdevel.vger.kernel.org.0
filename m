Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D786CFD40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 09:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjC3Hsy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 03:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjC3Hsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:48:53 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FE34C27
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 00:48:51 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id z65-20020a6bc944000000b007584beb0e28so10917453iof.21
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 00:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680162530; x=1682754530;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUsfODEsDzAR9EqvWlT1PM9QUz8OEaJY4GXMYUHR7zc=;
        b=ZLZV/3p6t3ymZtTd0vb2DX+8K65gRcrA5/0zneeeobZ6u0dUeventnlT8ufo14iWpC
         0uRlQ0BjA22JMynHQw5vRpwlfjloWI5cNTtc921p9OqDZg+8GqQjt1Nrw+2e9Va+liGM
         Rxv5PqobX7CJ6PtirWNYxpsGzjzdp8wfZTlJV0XoSFZgS2mOI3cEXkd/cViJXEJyRX5q
         g83yajQlmfHaqjJVVbPP1/uNBbp6Rz/KmuXTxxn9z+LXN7l1OfANKXET+SDHqWratGZB
         F49nS7hmMKy3+0U9gPSUJQ6zNXfpynI+cCJv8X/xTignlm2BVgW/A0bm/6K+nlZZg8eP
         yjRA==
X-Gm-Message-State: AAQBX9cWD2zE36c68DhCcfclzxCaFaScKSEdiT0e4CKaZjOAAlwsMCC5
        P2EFdAT5sLPZw5pSpWGVGx1JIbxAqiB/9Jrm6V718Z0hvMvH
X-Google-Smtp-Source: AKy350b1Dj3CFZk+cHqn2IXzGI1Q97FSUeDDxWzStstwOIrJ/00+mw1jNVvvr/SqmR0xIVy/smQidgiwb8RQwJ8M6/dled2AlGdy
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c8:b0:326:2db8:e61e with SMTP id
 8-20020a056e0220c800b003262db8e61emr2351346ilq.5.1680162530653; Thu, 30 Mar
 2023 00:48:50 -0700 (PDT)
Date:   Thu, 30 Mar 2023 00:48:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cdfab505f819529a@google.com>
Subject: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in get_max_inline_xattr_value_size
From:   syzbot <syzbot+1966db24521e5f6e23f7@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    da8e7da11e4b Merge tag 'nfsd-6.3-4' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=114fae51c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
dashboard link: https://syzkaller.appspot.com/bug?extid=1966db24521e5f6e23f7
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1597fd0ec80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14149471c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/62e9c5f4bead/disk-da8e7da1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c11aa933e2a7/vmlinux-da8e7da1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a21bdd49c84/bzImage-da8e7da1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/58216d4aadcf/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1966db24521e5f6e23f7@syzkaller.appspotmail.com

EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: none.
EXT4-fs error (device loop0): ext4_xattr_ibody_get:669: inode #18: comm syz-executor366: corrupted in-inode xattr: bad magic number in in-inode xattr
==================================================================
BUG: KASAN: slab-use-after-free in get_max_inline_xattr_value_size+0x369/0x510 fs/ext4/inline.c:62
Read of size 4 at addr ffff88807c4ac084 by task syz-executor366/5076

CPU: 0 PID: 5076 Comm: syz-executor366 Not tainted 6.3.0-rc3-syzkaller-00338-gda8e7da11e4b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:319 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:430
 kasan_report+0x176/0x1b0 mm/kasan/report.c:536
 get_max_inline_xattr_value_size+0x369/0x510 fs/ext4/inline.c:62
 ext4_get_max_inline_size+0x141/0x200 fs/ext4/inline.c:113
 ext4_prepare_inline_data+0x87/0x1d0 fs/ext4/inline.c:393
 ext4_da_write_inline_data_begin+0x208/0xe40 fs/ext4/inline.c:931
 ext4_da_write_begin+0x4da/0x960 fs/ext4/inode.c:3064
 generic_perform_write+0x300/0x5e0 mm/filemap.c:3926
 ext4_buffered_write_iter+0x122/0x3a0 fs/ext4/file.c:289
 ext4_file_write_iter+0x1d6/0x1930
 call_write_iter include/linux/fs.h:1851 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7b2/0xbb0 fs/read_write.c:584
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f63c54aea99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff3f17f0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f63c54aea99
RDX: 0000000000000010 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007fff3f17f0f0 R09: 00007fff3f17f0f0
R10: 00007fff3f17f0f0 R11: 0000000000000246 R12: 00007f63c546d960
R13: 00007fff3f17f120 R14: 00007fff3f17f100 R15: 0000000000000000
 </TASK>

Allocated by task 4998:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:769
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x11f/0x2e0 mm/slub.c:3476
 anon_vma_chain_alloc mm/rmap.c:141 [inline]
 anon_vma_fork+0x1fa/0x580 mm/rmap.c:364
 dup_mmap kernel/fork.c:660 [inline]
 dup_mm kernel/fork.c:1545 [inline]
 copy_mm+0xae3/0x1670 kernel/fork.c:1594
 copy_process+0x1905/0x3fc0 kernel/fork.c:2264
 kernel_clone+0x222/0x800 kernel/fork.c:2679
 __do_sys_clone kernel/fork.c:2820 [inline]
 __se_sys_clone kernel/fork.c:2804 [inline]
 __x64_sys_clone+0x235/0x280 kernel/fork.c:2804
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5013:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook mm/slub.c:1807 [inline]
 slab_free mm/slub.c:3787 [inline]
 kmem_cache_free+0x297/0x520 mm/slub.c:3809
 anon_vma_chain_free mm/rmap.c:146 [inline]
 unlink_anon_vmas+0x59e/0x5f0 mm/rmap.c:447
 free_pgtables+0x348/0x4f0 mm/memory.c:383
 exit_mmap+0x2c1/0x850 mm/mmap.c:3040
 __mmput+0x115/0x3c0 kernel/fork.c:1204
 exit_mm+0x227/0x310 kernel/exit.c:563
 do_exit+0x612/0x2290 kernel/exit.c:856
 do_group_exit+0x206/0x2c0 kernel/exit.c:1019
 __do_sys_exit_group kernel/exit.c:1030 [inline]
 __se_sys_exit_group kernel/exit.c:1028 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1028
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88807c4ac070
 which belongs to the cache anon_vma_chain of size 80
The buggy address is located 20 bytes inside of
 freed 80-byte region [ffff88807c4ac070, ffff88807c4ac0c0)

The buggy address belongs to the physical page:
page:ffffea0001f12b00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7c4ac
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888140007280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000240024 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12800(GFP_NOWAIT|__GFP_NOWARN|__GFP_NORETRY), pid 4998, tgid 4998 (dhcpcd-run-hook), ts 47082738820, free_ts 47079213294
 prep_new_page mm/page_alloc.c:2553 [inline]
 get_page_from_freelist+0x3246/0x33c0 mm/page_alloc.c:4326
 __alloc_pages+0x255/0x670 mm/page_alloc.c:5592
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3193
 __slab_alloc mm/slub.c:3292 [inline]
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x1b9/0x2e0 mm/slub.c:3476
 anon_vma_chain_alloc mm/rmap.c:141 [inline]
 anon_vma_clone+0x98/0x4d0 mm/rmap.c:288
 anon_vma_fork+0x87/0x580 mm/rmap.c:351
 dup_mmap kernel/fork.c:660 [inline]
 dup_mm kernel/fork.c:1545 [inline]
 copy_mm+0xae3/0x1670 kernel/fork.c:1594
 copy_process+0x1905/0x3fc0 kernel/fork.c:2264
 kernel_clone+0x222/0x800 kernel/fork.c:2679
 __do_sys_clone kernel/fork.c:2820 [inline]
 __se_sys_clone kernel/fork.c:2804 [inline]
 __x64_sys_clone+0x235/0x280 kernel/fork.c:2804
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1454 [inline]
 free_pcp_prepare mm/page_alloc.c:1504 [inline]
 free_unref_page_prepare+0xe2f/0xe70 mm/page_alloc.c:3388
 free_unref_page_list+0x596/0x830 mm/page_alloc.c:3529
 release_pages+0x219e/0x2470 mm/swap.c:1042
 tlb_batch_pages_flush mm/mmu_gather.c:97 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu+0x100/0x210 mm/mmu_gather.c:299
 tlb_finish_mmu+0xd4/0x1f0 mm/mmu_gather.c:391
 exit_mmap+0x2c9/0x850 mm/mmap.c:3042
 __mmput+0x115/0x3c0 kernel/fork.c:1204
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
 ffff88807c4abf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807c4ac000: fa fb fb fb fb fb fb fb fb fb fc fc fc fc fa fb
>ffff88807c4ac080: fb fb fb fb fb fb fb fb fc fc fc fc fa fb fb fb
                   ^
 ffff88807c4ac100: fb fb fb fb fb fb fc fc fc fc fa fb fb fb fb fb
 ffff88807c4ac180: fb fb fb fb fc fc fc fc fa fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
