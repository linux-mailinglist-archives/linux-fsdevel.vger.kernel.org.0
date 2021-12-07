Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B0446C316
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 19:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbhLGSwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 13:52:55 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:47815 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbhLGSwy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:52:54 -0500
Received: by mail-il1-f199.google.com with SMTP id g14-20020a056e021e0e00b002a26cb56bd4so12795175ila.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Dec 2021 10:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IUVj85S6PaeVhUcViFQHX8PAG9j4UnRxeaSkiD5JR1w=;
        b=G5v+O858U308UjnyXnoZFbDKrOtc3x6S8+3oFSeWbY0D+gCqdMh8qUJfqKeeBgpXEd
         4ZUDfja6RM/KO+b8RkCPJFxFiOBeyD+QZ3aLdziIUhnZsFpmcpzktwnhP3BZYnWx6FgT
         0io4JlP0gipy+GOmXgZHIWUu1/+hfOHXBMrlBT7XYdmTrCGmmGUHUd9w89a6KYkJhOiG
         2FnrkrQkq9ibfrr9vl07iuaO79FvunJ3fgm/m6DidVDXmmggpmfAlGaRAD2pmXIvyqOT
         NUlsaV7dBsVjySO2mf9A62TfIDxdKoXj5L0LwM2EgXoA0Kfn+iODmhyIgazKjSP3ZwIK
         xDNA==
X-Gm-Message-State: AOAM533CSchDg/xDRoJebdB6CCzmViXUK1MPDNDLd+hsTYmBz/KJ3szC
        hKsdpRQWDMpCJTRrPtXpHpIguaZFfCti4P5coy4G9SrJmfJs
X-Google-Smtp-Source: ABdhPJzROWoN+IXDOH7W2hG9rxkwpmbLRyxHGwMhvCfg7DyuRxTJ8WnT5Rl4QVpq2QAdZ9GUX8LrXx7RNF3Dih4l16rDipGbnJGJ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26d0:: with SMTP id g16mr1200059ioo.70.1638902963736;
 Tue, 07 Dec 2021 10:49:23 -0800 (PST)
Date:   Tue, 07 Dec 2021 10:49:23 -0800
In-Reply-To: <0000000000007de81505cfea992f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f993de05d292d4fd@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in io_submit_one
From:   syzbot <syzbot+3587cbbc6e1868796292@syzkaller.appspotmail.com>
To:     bcrl@kvack.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    04fe99a8d936 Add linux-next specific files for 20211207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16eaddadb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4589399873466942
dashboard link: https://syzkaller.appspot.com/bug?extid=3587cbbc6e1868796292
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17db884db00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e9eabdb00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3587cbbc6e1868796292@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: use-after-free in atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:176 [inline]
BUG: KASAN: use-after-free in __refcount_sub_and_test include/linux/refcount.h:272 [inline]
BUG: KASAN: use-after-free in __refcount_dec_and_test include/linux/refcount.h:315 [inline]
BUG: KASAN: use-after-free in refcount_dec_and_test include/linux/refcount.h:333 [inline]
BUG: KASAN: use-after-free in iocb_put fs/aio.c:1188 [inline]
BUG: KASAN: use-after-free in io_submit_one+0x6fb/0x1b80 fs/aio.c:1909
Write of size 4 at addr ffff8880182820c8 by task syz-executor415/6540

CPU: 0 PID: 6540 Comm: syz-executor415 Not tainted 5.16.0-rc4-next-20211207-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xa5/0x3ed mm/kasan/report.c:255
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:176 [inline]
 __refcount_sub_and_test include/linux/refcount.h:272 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 iocb_put fs/aio.c:1188 [inline]
 io_submit_one+0x6fb/0x1b80 fs/aio.c:1909
 __do_sys_io_submit fs/aio.c:1965 [inline]
 __se_sys_io_submit fs/aio.c:1935 [inline]
 __x64_sys_io_submit+0x18c/0x330 fs/aio.c:1935
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f9604613139
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfcd47e58 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9604613139
RDX: 0000000020000800 RSI: 0000000000000002 RDI: 00007f96045cb000
RBP: 00007f96045d7120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f96045d71b0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 6540:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:260 [inline]
 slab_post_alloc_hook mm/slab.h:766 [inline]
 slab_alloc_node mm/slub.c:3231 [inline]
 slab_alloc mm/slub.c:3239 [inline]
 kmem_cache_alloc+0x202/0x3a0 mm/slub.c:3244
 aio_get_req fs/aio.c:1055 [inline]
 io_submit_one+0xfd/0x1b80 fs/aio.c:1902
 __do_sys_io_submit fs/aio.c:1965 [inline]
 __se_sys_io_submit fs/aio.c:1935 [inline]
 __x64_sys_io_submit+0x18c/0x330 fs/aio.c:1935
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 6540:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:236 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1754
 slab_free mm/slub.c:3510 [inline]
 kmem_cache_free+0xdd/0x580 mm/slub.c:3527
 iocb_destroy fs/aio.c:1107 [inline]
 iocb_put fs/aio.c:1190 [inline]
 iocb_put fs/aio.c:1186 [inline]
 aio_complete_rw+0x474/0x8c0 fs/aio.c:1467
 aio_rw_done fs/aio.c:1537 [inline]
 aio_read+0x30d/0x460 fs/aio.c:1564
 __io_submit_one fs/aio.c:1857 [inline]
 io_submit_one+0xe2b/0x1b80 fs/aio.c:1906
 __do_sys_io_submit fs/aio.c:1965 [inline]
 __se_sys_io_submit fs/aio.c:1935 [inline]
 __x64_sys_io_submit+0x18c/0x330 fs/aio.c:1935
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff888018282000
 which belongs to the cache aio_kiocb of size 216
The buggy address is located 200 bytes inside of
 216-byte region [ffff888018282000, ffff8880182820d8)
The buggy address belongs to the page:
page:ffffea000060a080 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x18282
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 0000000000000000 dead000000000122 ffff888144b95dc0
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 6540, ts 72148479011, free_ts 72144305967
 prep_new_page mm/page_alloc.c:2433 [inline]
 get_page_from_freelist+0xa72/0x2f40 mm/page_alloc.c:4164
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5376
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2271
 alloc_slab_page mm/slub.c:1799 [inline]
 allocate_slab mm/slub.c:1944 [inline]
 new_slab+0x28d/0x3a0 mm/slub.c:2004
 ___slab_alloc+0x6be/0xd60 mm/slub.c:3019
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3106
 slab_alloc_node mm/slub.c:3197 [inline]
 slab_alloc mm/slub.c:3239 [inline]
 kmem_cache_alloc+0x35c/0x3a0 mm/slub.c:3244
 aio_get_req fs/aio.c:1055 [inline]
 io_submit_one+0xfd/0x1b80 fs/aio.c:1902
 __do_sys_io_submit fs/aio.c:1965 [inline]
 __se_sys_io_submit fs/aio.c:1935 [inline]
 __x64_sys_io_submit+0x18c/0x330 fs/aio.c:1935
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1351 [inline]
 free_pcp_prepare+0x414/0xb60 mm/page_alloc.c:1403
 free_unref_page_prepare mm/page_alloc.c:3324 [inline]
 free_unref_page_list+0x1a9/0xfa0 mm/page_alloc.c:3440
 release_pages+0x818/0x18e0 mm/swap.c:980
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu mm/mmu_gather.c:249 [inline]
 tlb_finish_mmu+0x165/0x8c0 mm/mmu_gather.c:340
 exit_mmap+0x21b/0x670 mm/mmap.c:3180
 __mmput+0x122/0x4b0 kernel/fork.c:1115
 mmput+0x56/0x60 kernel/fork.c:1136
 exec_mmap fs/exec.c:1029 [inline]
 begin_new_exec+0x1047/0x2ef0 fs/exec.c:1288
 load_elf_binary+0x7db/0x4da0 fs/binfmt_elf.c:1000
 search_binary_handler fs/exec.c:1725 [inline]
 exec_binprm fs/exec.c:1766 [inline]
 bprm_execve fs/exec.c:1835 [inline]
 bprm_execve+0x7ef/0x19b0 fs/exec.c:1797
 do_execveat_common+0x5e3/0x780 fs/exec.c:1924
 do_execve fs/exec.c:1992 [inline]
 __do_sys_execve fs/exec.c:2068 [inline]
 __se_sys_execve fs/exec.c:2063 [inline]
 __x64_sys_execve+0x8f/0xc0 fs/exec.c:2063
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff888018281f80: fc fc 00 00 00 00 fc fc 00 00 00 00 fc fc fc fc
 ffff888018282000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888018282080: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
                                              ^
 ffff888018282100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888018282180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

