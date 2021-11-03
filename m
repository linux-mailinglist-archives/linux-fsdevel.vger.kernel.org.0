Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70169444B6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 00:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhKCXTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 19:19:11 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:38702 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhKCXTF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 19:19:05 -0400
Received: by mail-io1-f72.google.com with SMTP id g4-20020a05660226c400b005e14d3f1e6bso2644033ioo.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Nov 2021 16:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7JjUVqMLkOeIdj+bl01I5JnGMpWXlnKON367c05JG3E=;
        b=BghOJ0zag0GkANcVet8C2rHLgG6MDR52BB0lvxFpUjSQD03Tna4sc/0TyJ9WNWND76
         d9z0kL6I/3FMMKMhvg3aDjj/2Y18OSeorGk/TEvFxQJa3r04VUV+17i1+NJdKsTfqtvC
         y9wGHEgPOZm98GvOqADrYhpibp+RLOV066am1i2y5aWaJ3rZtoeeWcNvSmAvqzWhm+RO
         htfMYJDLYravOBpgbXdWit8OZhliurIwd2Irkpeph782KUNksn7R+qTq1EhjvMTAWPDh
         wf2k9AEsufsxkcJ6IqPJhvVGs4VkM8oNqlZl5cl0x6mI7TXFURy5omPvwDGrMentmpXC
         dehQ==
X-Gm-Message-State: AOAM531UESrfzkO/sehGDr+ghoL+GnhjjltUse8DQlMTqXumBqnFuMhI
        +uefTrBmAW2QTo3bEowHdiWDVHznPpx2swxB/r6rmYh7QGDJ
X-Google-Smtp-Source: ABdhPJwZPxisp2uB+w19wOhOkX5RDCAppV3eLpLHoeFB8dsk8vn6V2S3v5jTp/3RLDNIF3KgThs/3LDwvjVc6ByVVmj0zCo3/fjo
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d84:: with SMTP id l4mr1137076jaj.30.1635981388014;
 Wed, 03 Nov 2021 16:16:28 -0700 (PDT)
Date:   Wed, 03 Nov 2021 16:16:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007de81505cfea992f@google.com>
Subject: [syzbot] KASAN: use-after-free Write in io_submit_one
From:   syzbot <syzbot+3587cbbc6e1868796292@syzkaller.appspotmail.com>
To:     bcrl@kvack.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cc0356d6a02e Merge tag 'x86_core_for_v5.16_rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14058b96b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5d447cdc3ae81d9
dashboard link: https://syzkaller.appspot.com/bug?extid=3587cbbc6e1868796292
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3587cbbc6e1868796292@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: use-after-free in atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:167 [inline]
BUG: KASAN: use-after-free in __refcount_sub_and_test include/linux/refcount.h:272 [inline]
BUG: KASAN: use-after-free in __refcount_dec_and_test include/linux/refcount.h:315 [inline]
BUG: KASAN: use-after-free in refcount_dec_and_test include/linux/refcount.h:333 [inline]
BUG: KASAN: use-after-free in iocb_put fs/aio.c:1161 [inline]
BUG: KASAN: use-after-free in io_submit_one+0x6fb/0x1b80 fs/aio.c:1882
Write of size 4 at addr ffff88803d5bf5c8 by task syz-executor.1/25125

CPU: 0 PID: 25125 Comm: syz-executor.1 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:167 [inline]
 __refcount_sub_and_test include/linux/refcount.h:272 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 iocb_put fs/aio.c:1161 [inline]
 io_submit_one+0x6fb/0x1b80 fs/aio.c:1882
 __do_sys_io_submit fs/aio.c:1938 [inline]
 __se_sys_io_submit fs/aio.c:1908 [inline]
 __x64_sys_io_submit+0x18c/0x330 fs/aio.c:1908
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f881ae57ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f88183cd188 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f881af6af60 RCX: 00007f881ae57ae9
RDX: 00000000200000c0 RSI: 0000000000000001 RDI: 00007f881af4e000
RBP: 00007f881aeb1f25 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc3b5fd44f R14: 00007f88183cd300 R15: 0000000000022000
 </TASK>

Allocated by task 25125:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 __kasan_slab_alloc+0x83/0xb0 mm/kasan/common.c:467
 kasan_slab_alloc include/linux/kasan.h:259 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:3213 [inline]
 slab_alloc mm/slub.c:3221 [inline]
 kmem_cache_alloc+0x209/0x390 mm/slub.c:3226
 aio_get_req fs/aio.c:1028 [inline]
 io_submit_one+0xfd/0x1b80 fs/aio.c:1875
 __do_sys_io_submit fs/aio.c:1938 [inline]
 __se_sys_io_submit fs/aio.c:1908 [inline]
 __x64_sys_io_submit+0x18c/0x330 fs/aio.c:1908
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 25125:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xff/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:1700 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1726
 slab_free mm/slub.c:3492 [inline]
 kmem_cache_free+0x95/0x5d0 mm/slub.c:3508
 iocb_destroy fs/aio.c:1080 [inline]
 iocb_put fs/aio.c:1163 [inline]
 iocb_put fs/aio.c:1159 [inline]
 aio_complete_rw+0x474/0x8c0 fs/aio.c:1440
 aio_rw_done fs/aio.c:1510 [inline]
 aio_read+0x30d/0x460 fs/aio.c:1537
 __io_submit_one fs/aio.c:1830 [inline]
 io_submit_one+0xe2b/0x1b80 fs/aio.c:1879
 __do_sys_io_submit fs/aio.c:1938 [inline]
 __se_sys_io_submit fs/aio.c:1908 [inline]
 __x64_sys_io_submit+0x18c/0x330 fs/aio.c:1908
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88803d5bf500
 which belongs to the cache aio_kiocb of size 216
The buggy address is located 200 bytes inside of
 216-byte region [ffff88803d5bf500, ffff88803d5bf5d8)
The buggy address belongs to the page:
page:ffffea0000f56fc0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3d5bf
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea000211f880 0000000200000002 ffff888145dae280
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 22913, ts 1044095753625, free_ts 1044067792778
 prep_new_page mm/page_alloc.c:2426 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4155
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5381
 alloc_pages+0x1a7/0x300 mm/mempolicy.c:2191
 alloc_slab_page mm/slub.c:1770 [inline]
 allocate_slab mm/slub.c:1907 [inline]
 new_slab+0x319/0x490 mm/slub.c:1970
 ___slab_alloc+0x921/0xfe0 mm/slub.c:3001
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3088
 slab_alloc_node mm/slub.c:3179 [inline]
 slab_alloc mm/slub.c:3221 [inline]
 kmem_cache_alloc+0x363/0x390 mm/slub.c:3226
 aio_get_req fs/aio.c:1028 [inline]
 io_submit_one+0xfd/0x1b80 fs/aio.c:1875
 __do_sys_io_submit fs/aio.c:1938 [inline]
 __se_sys_io_submit fs/aio.c:1908 [inline]
 __x64_sys_io_submit+0x18c/0x330 fs/aio.c:1908
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1340 [inline]
 free_pcp_prepare+0x326/0x810 mm/page_alloc.c:1391
 free_unref_page_prepare mm/page_alloc.c:3317 [inline]
 free_unref_page_list+0x1a9/0xfa0 mm/page_alloc.c:3433
 release_pages+0x3f4/0x1480 mm/swap.c:970
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu mm/mmu_gather.c:249 [inline]
 tlb_finish_mmu+0x165/0x8c0 mm/mmu_gather.c:340
 exit_mmap+0x1ea/0x630 mm/mmap.c:3173
 __mmput+0x122/0x4b0 kernel/fork.c:1114
 mmput+0x56/0x60 kernel/fork.c:1135
 exit_mm kernel/exit.c:502 [inline]
 do_exit+0xab8/0x2a20 kernel/exit.c:813
 do_group_exit+0x125/0x310 kernel/exit.c:923
 get_signal+0x47d/0x21d0 kernel/signal.c:2855
 arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:868
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff88803d5bf480: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803d5bf500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88803d5bf580: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
                                              ^
 ffff88803d5bf600: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
 ffff88803d5bf680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
