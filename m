Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA9B5E90F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Sep 2022 06:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiIYETn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Sep 2022 00:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIYETm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Sep 2022 00:19:42 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AF62BEB
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 21:19:37 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id i24-20020a056e021d1800b002f7ee6bcb7eso2935120ila.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 21:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1s6u3MbbzYH+IkZ6LBMDMsWJQ9Gm59p9uP/t36mf1Ek=;
        b=ARxWPJUUoKxQ1btkYxvA96liYLzgBmDQ42RifPcvsY+rnCq2nj9GawliidcUNrppai
         /wylgy/XaupFLz7Y4GWnEEcEHOgUEMB8x4Cprz26bx2KEGwM1Zxz8ie6V0MoYw4OpAmh
         A1nri2s5e4LZVTuoGvo1+17xOFwuklO9brM5VigDg11wAXAq4gLwCGJ2cvXtMVuIzsXc
         5TmJSN0z5w+Bs3tbEFCEybO7FeHrMuyePSNZuiJXAlI0dvLaU2hSZtkqYwacpxX1MC2Y
         WkPMwe20wiUdVqLOY7KdXl+tArDa2ZP5L0eU1vT/6zxkwXDlZTh+dvmRkDiwY9FpMXPj
         LyYg==
X-Gm-Message-State: ACrzQf2JVjFw7AUXuLAETS11dH9mj/4qrfWlOronCHH9w7ZKuASts8Ng
        nM5AuhSjkqI2/g6GMBxJodTZ0iQaepQqSY4AOwr3qSr0I298
X-Google-Smtp-Source: AMsMyM7fVOztWsTEIcXvCazZx3eN9Xv8KrloipNCFoVuW+OByv0vZk0qXchhzfh3mB6ODqAH/tVm+LUHYEY7fJW9IenmZcZln2Lh
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2e08:b0:6a1:30d1:7ca7 with SMTP id
 o8-20020a0566022e0800b006a130d17ca7mr7400434iow.45.1664079576999; Sat, 24 Sep
 2022 21:19:36 -0700 (PDT)
Date:   Sat, 24 Sep 2022 21:19:36 -0700
In-Reply-To: <000000000000e4630c05e974c1eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010ae6e05e978b83e@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in evict
From:   syzbot <syzbot+6b74cf8fcd7378d8be7c@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    3db61221f4e8 Merge tag 'io_uring-6.0-2022-09-23' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120a2035080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c221af36f6d1d811
dashboard link: https://syzkaller.appspot.com/bug?extid=6b74cf8fcd7378d8be7c
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163d8eff080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159bfd60880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b74cf8fcd7378d8be7c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in native_save_fl arch/x86/include/asm/irqflags.h:35 [inline]
BUG: KASAN: stack-out-of-bounds in arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
BUG: KASAN: stack-out-of-bounds in arch_irqs_disabled arch/x86/include/asm/irqflags.h:130 [inline]
BUG: KASAN: stack-out-of-bounds in lock_acquire+0x1c3/0x3c0 kernel/locking/lockdep.c:5669
Read of size 8 at addr ffffc90004dcf95f by task syz-executor479/11095

CPU: 0 PID: 11095 Comm: syz-executor479 Not tainted 6.0.0-rc6-syzkaller-00291-g3db61221f4e8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:317
 print_report+0x108/0x1f0 mm/kasan/report.c:433
 kasan_report+0xc3/0xf0 mm/kasan/report.c:495
 native_save_fl arch/x86/include/asm/irqflags.h:35 [inline]
 arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
 arch_irqs_disabled arch/x86/include/asm/irqflags.h:130 [inline]
 lock_acquire+0x1c3/0x3c0 kernel/locking/lockdep.c:5669
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 inode_sb_list_del fs/inode.c:503 [inline]
 evict+0x161/0x620 fs/inode.c:654
 ntfs_fill_super+0x3af3/0x42a0 fs/ntfs3/super.c:1190
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4bae6c908a
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 f8 03 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca10c1e08 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffca10c1e60 RCX: 00007f4bae6c908a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffca10c1e20
RBP: 00007ffca10c1e20 R08: 00007ffca10c1e60 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000020001b80
R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000110
 </TASK>

The buggy address belongs to stack of task syz-executor479/11095
 and is located at offset 31 in frame:
 lock_acquire+0x0/0x3c0 kernel/locking/lockdep.c:5621

This frame has 3 objects:
 [32, 40) 'flags.i.i.i87'
 [64, 72) 'flags.i.i.i'
 [96, 136) 'hlock'

The buggy address belongs to the virtual mapping at
 [ffffc90004dc8000, ffffc90004dd1000) created by:
 dup_task_struct+0x8b/0x490 kernel/fork.c:977

The buggy address belongs to the physical page:
page:ffffea0001d86440 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76191
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 3696, tgid 3696 (syz-executor479), ts 1675853778124, free_ts 1675836504134
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5515
 vm_area_alloc_pages mm/vmalloc.c:2958 [inline]
 __vmalloc_area_node mm/vmalloc.c:3026 [inline]
 __vmalloc_node_range+0x8f4/0x1290 mm/vmalloc.c:3196
 alloc_thread_stack_node+0x307/0x500 kernel/fork.c:312
 dup_task_struct+0x8b/0x490 kernel/fork.c:977
 copy_process+0x637/0x3f20 kernel/fork.c:2085
 kernel_clone+0x21f/0x790 kernel/fork.c:2671
 __do_sys_clone kernel/fork.c:2805 [inline]
 __se_sys_clone kernel/fork.c:2789 [inline]
 __x64_sys_clone+0x228/0x290 kernel/fork.c:2789
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page_list+0xb4/0x7b0 mm/page_alloc.c:3522
 release_pages+0x22c3/0x2540 mm/swap.c:1012
 tlb_batch_pages_flush mm/mmu_gather.c:58 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:255 [inline]
 tlb_flush_mmu+0x850/0xa70 mm/mmu_gather.c:262
 tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:353
 exit_mmap+0x1cb/0x520 mm/mmap.c:3118
 __mmput+0x111/0x3a0 kernel/fork.c:1187
 exit_mm+0x1ef/0x2c0 kernel/exit.c:510
 do_exit+0x4e1/0x20a0 kernel/exit.c:782
 do_group_exit+0x23b/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffffc90004dcf800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90004dcf880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90004dcf900: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2
                                                    ^
 ffffc90004dcf980: 00 f2 f2 f2 00 00 00 00 00 f3 f3 f3 f3 f3 f3 f3
 ffffc90004dcfa00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

