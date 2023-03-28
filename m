Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C5F6CB8C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 09:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjC1HyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 03:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjC1HyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:54:06 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EFF422A
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 00:53:48 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id j4-20020a6b5504000000b00758646159fbso7102748iob.20
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 00:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679990027;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SlVrSmVb4xLt28lrc5slQniv6oNhQ+2/mxD6CxBMnM=;
        b=Oxk3uhT2SX3H/hPyTrXV4sFJTY9fSMsUw3J3lfv4bqs5znMYkVFb6j1Xi8hDRwd93N
         w/pdrpL1EVtOBq21gzp/wkKAOdaX60LYYMKRVzw9GdLJC0Hu+CRm7x8n/1uJNzy1DYV2
         nRgNf8ZocUbqKpL8FS/LmPbLYxk7SyZ9edU2MeD4Ep/mlOw9l/kr4LAZRp/A6FQ59hcb
         mkfXzZSyrpJcdwNi48N0WoYy2U0ys8dAeEYqy1dZPQPdiGJ58ZGBRtNDDMR7wjyl4gDs
         j7ybz8k1uY2uyjw9Fes5g+LfoQksGBN+nQrYk6G3gVOd7UDvJ9r3+NHRx2k/KdKVjkJt
         bX8w==
X-Gm-Message-State: AO0yUKXXqMI7aVZkoBwWh5esrtE/lFXY0ufSXbdfpBIiu/Z/To3auru5
        93PdMBIlEFw0I2eJQox0Zb8EO9dy4IIQM+BPKso77Dr+W17z
X-Google-Smtp-Source: AK7set9w0J7tYYWkCa59KAloy9lJH8PRgS4e+UfBX0Ci5HFNAeOkbDqka+QmM0mYaMf4xOzO3vsSo/lX0wTW79iAyooUuv0bhkt2
MIME-Version: 1.0
X-Received: by 2002:a02:b0c1:0:b0:406:3588:9456 with SMTP id
 w1-20020a02b0c1000000b0040635889456mr5541455jah.0.1679990027693; Tue, 28 Mar
 2023 00:53:47 -0700 (PDT)
Date:   Tue, 28 Mar 2023 00:53:47 -0700
In-Reply-To: <000000000000b62cdb05f7dfab8b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3b32005f7f12805@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in ext4_convert_inline_data_nolock
From:   syzbot <syzbot+db6caad9ebd2c8022b41@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    3a93e40326c8 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1034aed5c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c35b3803e5ad668
dashboard link: https://syzkaller.appspot.com/bug?extid=db6caad9ebd2c8022b41
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a2cd05c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158e1f29c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65fe3e7679b9/disk-3a93e403.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/169220ad146c/vmlinux-3a93e403.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f5e2d192c51/bzImage-3a93e403.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/343663881b01/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+db6caad9ebd2c8022b41@syzkaller.appspotmail.com

EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: none.
==================================================================
BUG: KASAN: slab-out-of-bounds in ext4_read_inline_data fs/ext4/inline.c:199 [inline]
BUG: KASAN: slab-out-of-bounds in ext4_convert_inline_data_nolock+0x31a/0xd80 fs/ext4/inline.c:1204
Read of size 20 at addr ffff88807645e1a3 by task syz-executor378/5075

CPU: 0 PID: 5075 Comm: syz-executor378 Not tainted 6.3.0-rc4-syzkaller-00025-g3a93e40326c8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:319 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:430
 kasan_report+0x176/0x1b0 mm/kasan/report.c:536
 kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 ext4_read_inline_data fs/ext4/inline.c:199 [inline]
 ext4_convert_inline_data_nolock+0x31a/0xd80 fs/ext4/inline.c:1204
 ext4_convert_inline_data+0x4da/0x620 fs/ext4/inline.c:2065
 ext4_fallocate+0x14d/0x2050 fs/ext4/extents.c:4701
 vfs_fallocate+0x54b/0x6b0 fs/open.c:324
 ksys_fallocate fs/open.c:347 [inline]
 __do_sys_fallocate fs/open.c:355 [inline]
 __se_sys_fallocate fs/open.c:353 [inline]
 __x64_sys_fallocate+0xbd/0x100 fs/open.c:353
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb0579425c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdcef99758 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb0579425c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000003 R08: 0000000000000003 R09: 0000000000000003
R10: 0000000000008000 R11: 0000000000000246 R12: 00007ffdcef99790
R13: 00007ffdcef99788 R14: 00007ffdcef99784 R15: 0000000000000003
 </TASK>

Allocated by task 5023:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:769
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x11f/0x2e0 mm/slub.c:3476
 mt_alloc_one lib/maple_tree.c:159 [inline]
 mas_alloc_nodes+0x26e/0x780 lib/maple_tree.c:1233
 mas_node_count_gfp lib/maple_tree.c:1318 [inline]
 mas_preallocate+0x131/0x350 lib/maple_tree.c:5717
 vma_iter_prealloc mm/internal.h:972 [inline]
 __split_vma+0x1e0/0x7f0 mm/mmap.c:2177
 mprotect_fixup+0x5f5/0x920 mm/mprotect.c:663
 do_mprotect_pkey+0x8f8/0xc60 mm/mprotect.c:831
 __do_sys_mprotect mm/mprotect.c:852 [inline]
 __se_sys_mprotect mm/mprotect.c:849 [inline]
 __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:849
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5023:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook mm/slub.c:1807 [inline]
 slab_free mm/slub.c:3787 [inline]
 kmem_cache_free+0x297/0x520 mm/slub.c:3809
 mas_destroy+0x1bdc/0x2280 lib/maple_tree.c:5774
 mas_store_prealloc+0x351/0x460 lib/maple_tree.c:5702
 vma_complete+0x1ed/0x970 mm/mmap.c:572
 __split_vma+0x7b9/0x7f0 mm/mmap.c:2214
 mprotect_fixup+0x5f5/0x920 mm/mprotect.c:663
 do_mprotect_pkey+0x8f8/0xc60 mm/mprotect.c:831
 __do_sys_mprotect mm/mprotect.c:852 [inline]
 __se_sys_mprotect mm/mprotect.c:849 [inline]
 __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:849
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88807645e000
 which belongs to the cache maple_node of size 256
The buggy address is located 163 bytes to the right of
 allocated 256-byte region [ffff88807645e000, ffff88807645e100)

The buggy address belongs to the physical page:
page:ffffea0001d91780 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7645e
head:ffffea0001d91780 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff8880124cd000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5023, tgid 5023 (rm), ts 57145564531, free_ts 41308598324
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
 mt_alloc_one lib/maple_tree.c:159 [inline]
 mas_alloc_nodes+0x26e/0x780 lib/maple_tree.c:1233
 mas_node_count_gfp lib/maple_tree.c:1318 [inline]
 mas_preallocate+0x131/0x350 lib/maple_tree.c:5717
 vma_iter_prealloc mm/internal.h:972 [inline]
 __split_vma+0x1e0/0x7f0 mm/mmap.c:2177
 mprotect_fixup+0x5f5/0x920 mm/mprotect.c:663
 do_mprotect_pkey+0x8f8/0xc60 mm/mprotect.c:831
 __do_sys_mprotect mm/mprotect.c:852 [inline]
 __se_sys_mprotect mm/mprotect.c:849 [inline]
 __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:849
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1454 [inline]
 free_pcp_prepare mm/page_alloc.c:1504 [inline]
 free_unref_page_prepare+0xe2f/0xe70 mm/page_alloc.c:3388
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:3483
 discard_slab mm/slub.c:2098 [inline]
 __unfreeze_partials+0x1b1/0x1f0 mm/slub.c:2637
 put_cpu_partial+0x116/0x180 mm/slub.c:2713
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:769
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x11f/0x2e0 mm/slub.c:3476
 vm_area_alloc+0x24/0xe0 kernel/fork.c:458
 mmap_region+0xbfb/0x20c0 mm/mmap.c:2553
 do_mmap+0x8c9/0xf70 mm/mmap.c:1364
 vm_mmap_pgoff+0x1ce/0x2e0 mm/util.c:542
 ksys_mmap_pgoff+0x4f9/0x6d0 mm/mmap.c:1410
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807645e080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807645e100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807645e180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                               ^
 ffff88807645e200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807645e280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

