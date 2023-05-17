Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A6D706128
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 09:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjEQHaz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 03:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjEQHa1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 03:30:27 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1C24ECE
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 00:29:44 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3382e29ab5bso2337915ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 00:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684308584; x=1686900584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADedZ/WY3YNjj9GmrcvwgF5LoClJPsLiHV4NF/cJ9c4=;
        b=KFsvl9cbw+/UIftAp4TvEjTqi+6ueAJwlCQWXyAGUEszwrwgrlGiaCK80aN+GQL1Vj
         Q8YDPMmO8rwjjngI/I28Lb1Uecf/BBMvO0FqaIjTa29giaG08EKqSQvHF8ar/db1Z71M
         JjGMG6Q2IMcAXzA8f/dDUXLejQVkMFB16N47SXtb4OZNLVucF/RQ2ozuzcgdc/8N76ZH
         6kO98DLsnFnVRhrkGIAzCGSTE9zumm7q1PpRNxUuuJ2dV5iOLThuwFNztwIz85oZrwQB
         IVvGMmiPpEsM5ipXJT3zimtBPaL62AmoXOQxmoacyvZFQTkD37AC2+eI8v+SvtiS88Vm
         zSlg==
X-Gm-Message-State: AC+VfDxgxMf10Gw4mj0h3DCZBj2WDT/bHYsHcZk/6voffIAT9WwvRp8k
        /GabIo9uaA3/DA3j+EWrfNKgQapCFtlTm+B+P41OlIEV5jpD
X-Google-Smtp-Source: ACHHUZ7LJjXOpQOsqlKq3oV+JyPcfCZoY5PZqcGiOy8X05BL06l5aRuXzswwhoVm671TanfyoyvAhIQ9lYGCYWT3wnDxhBlRx8Ku
MIME-Version: 1.0
X-Received: by 2002:a92:ce90:0:b0:331:2d3a:2cf5 with SMTP id
 r16-20020a92ce90000000b003312d3a2cf5mr993127ilo.2.1684308584059; Wed, 17 May
 2023 00:29:44 -0700 (PDT)
Date:   Wed, 17 May 2023 00:29:44 -0700
In-Reply-To: <0000000000000d7d6e05fb6bd2d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8632905fbdea615@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_search_dir
From:   syzbot <syzbot+34a0f26f0f61c4888ea4@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    f1fcbaa18b28 Linux 6.4-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1064d8fc280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94af80bb8ddd23c4
dashboard link: https://syzkaller.appspot.com/bug?extid=34a0f26f0f61c4888ea4
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1172c85a280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1694e5ce280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2ddd2c9b7bc9/disk-f1fcbaa1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f999d7594125/vmlinux-f1fcbaa1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eff89a0460f3/bzImage-f1fcbaa1.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/e79f7be33fee/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/0571f920dadd/mount_7.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+34a0f26f0f61c4888ea4@syzkaller.appspotmail.com

EXT4-fs (loop0): mounting ext3 file system using the ext4 subsystem
EXT4-fs (loop0): 1 truncate cleaned up
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
==================================================================
BUG: KASAN: slab-out-of-bounds in ext4_search_dir+0xf2/0x1b0 fs/ext4/namei.c:1539
Read of size 1 at addr ffff88801f58d3ed by task syz-executor303/4999

CPU: 0 PID: 4999 Comm: syz-executor303 Not tainted 6.4.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:351 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:462
 kasan_report+0x176/0x1b0 mm/kasan/report.c:572
 ext4_search_dir+0xf2/0x1b0 fs/ext4/namei.c:1539
 ext4_find_inline_entry+0x4ba/0x5e0 fs/ext4/inline.c:1719
 __ext4_find_entry+0x2b4/0x1b30 fs/ext4/namei.c:1612
 ext4_lookup_entry fs/ext4/namei.c:1767 [inline]
 ext4_lookup+0x17a/0x750 fs/ext4/namei.c:1835
 lookup_open fs/namei.c:3470 [inline]
 open_last_lookups fs/namei.c:3560 [inline]
 path_openat+0x11e9/0x3170 fs/namei.c:3788
 do_filp_open+0x234/0x490 fs/namei.c:3818
 do_sys_openat2+0x13f/0x500 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_open fs/open.c:1380 [inline]
 __se_sys_open fs/open.c:1376 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1376
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd8cce6ccf9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff8e028488 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000010c1d RCX: 00007fd8cce6ccf9
RDX: 0000000000000000 RSI: 0000000000141042 RDI: 0000000020000100
RBP: 0000000000000000 R08: 000000000001f210 R09: 00000000200012c0
R10: 00007fd8bc65f000 R11: 0000000000000246 R12: 00007fff8e0284bc
R13: 00007fff8e0284f0 R14: 00007fff8e0284d0 R15: 0000000000000004
 </TASK>

Allocated by task 4730:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:711
 kmem_cache_alloc_bulk+0x3d2/0x4b0 mm/slub.c:4033
 mt_alloc_bulk lib/maple_tree.c:164 [inline]
 mas_alloc_nodes+0x3df/0x800 lib/maple_tree.c:1309
 mas_node_count_gfp lib/maple_tree.c:1367 [inline]
 mas_preallocate+0x131/0x350 lib/maple_tree.c:5781
 vma_iter_prealloc mm/internal.h:1029 [inline]
 __split_vma+0x1e0/0x7f0 mm/mmap.c:2253
 do_vmi_align_munmap+0x4ac/0x1820 mm/mmap.c:2398
 do_vmi_munmap+0x24a/0x2b0 mm/mmap.c:2530
 mmap_region+0x811/0x2250 mm/mmap.c:2578
 do_mmap+0x8c9/0xf70 mm/mmap.c:1394
 vm_mmap_pgoff+0x1db/0x410 mm/util.c:543
 ksys_mmap_pgoff+0x4f9/0x6d0 mm/mmap.c:1440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 4730:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook mm/slub.c:1807 [inline]
 slab_free mm/slub.c:3786 [inline]
 kmem_cache_free_bulk+0x506/0x760 mm/slub.c:3904
 mt_free_bulk lib/maple_tree.c:169 [inline]
 mas_destroy+0x1c50/0x2310 lib/maple_tree.c:5836
 mas_store_prealloc+0x351/0x460 lib/maple_tree.c:5766
 vma_complete+0x1ec/0xb40 mm/mmap.c:585
 __split_vma+0x7c2/0x7f0 mm/mmap.c:2290
 do_vmi_align_munmap+0x4ac/0x1820 mm/mmap.c:2398
 do_vmi_munmap+0x24a/0x2b0 mm/mmap.c:2530
 mmap_region+0x811/0x2250 mm/mmap.c:2578
 do_mmap+0x8c9/0xf70 mm/mmap.c:1394
 vm_mmap_pgoff+0x1db/0x410 mm/util.c:543
 ksys_mmap_pgoff+0x4f9/0x6d0 mm/mmap.c:1440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801f58d200
 which belongs to the cache maple_node of size 256
The buggy address is located 237 bytes to the right of
 allocated 256-byte region [ffff88801f58d200, ffff88801f58d300)

The buggy address belongs to the physical page:
page:ffffea00007d6300 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1f58c
head:ffffea00007d6300 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012e4d000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4730, tgid 4730 (S50sshd), ts 42005657182, free_ts 36967331489
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0x321c/0x33a0 mm/page_alloc.c:3502
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4768
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3192
 __kmem_cache_alloc_bulk mm/slub.c:3951 [inline]
 kmem_cache_alloc_bulk+0x196/0x4b0 mm/slub.c:4026
 mt_alloc_bulk lib/maple_tree.c:164 [inline]
 mas_alloc_nodes+0x3df/0x800 lib/maple_tree.c:1309
 mas_node_count_gfp lib/maple_tree.c:1367 [inline]
 mas_preallocate+0x131/0x350 lib/maple_tree.c:5781
 vma_iter_prealloc mm/internal.h:1029 [inline]
 mmap_region+0x1342/0x2250 mm/mmap.c:2711
 do_mmap+0x8c9/0xf70 mm/mmap.c:1394
 vm_mmap_pgoff+0x1db/0x410 mm/util.c:543
 ksys_mmap_pgoff+0x4f9/0x6d0 mm/mmap.c:1440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2564
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2659
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:711
 slab_alloc_node mm/slub.c:3451 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc_lru+0x11f/0x2e0 mm/slub.c:3482
 __d_alloc+0x31/0x710 fs/dcache.c:1769
 d_alloc fs/dcache.c:1849 [inline]
 d_alloc_parallel+0xce/0x13a0 fs/dcache.c:2638
 lookup_open fs/namei.c:3417 [inline]
 open_last_lookups fs/namei.c:3560 [inline]
 path_openat+0x90e/0x3170 fs/namei.c:3788
 do_filp_open+0x234/0x490 fs/namei.c:3818
 do_sys_openat2+0x13f/0x500 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88801f58d280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801f58d300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801f58d380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                          ^
 ffff88801f58d400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801f58d480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
