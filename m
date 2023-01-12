Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D471668719
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 23:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbjALWkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 17:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239927AbjALWko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:40:44 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093475950B
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 14:40:40 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id d24-20020a5d9bd8000000b006ee2ddf6d77so12096590ion.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 14:40:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGtw6/YG9pGLEgw1kfMhBhdQ9Ew1pvZARnz/CND+o0w=;
        b=gkLEpnQYRxf6Fn03PJhY7xhlHJhnMaJedEDewwxYSC6C+RLYoO5J+/Q6gEl3gEEKkA
         1agmHVJ2LcY9Ne6tiwwEecOqLB58sLBcDqFiUJb4Da8xiCYWYXb4Q8rsHUGaaTlu6xgI
         6eQ8GdhQ3MiRL3o8qGX6OXRsmK+pyLbuAfhMlHmp/ZEnfpioItCFlluszE5nQ6GSAS4f
         frzFbUDwmOhb1o3lb5rFe2AWmqv8And4/fK3gEmQRYyHhwyt/Grhl0ChSyigknw3heKf
         gSWiXc4QEadEtwWUJFCeKmmcLrrRG4EB5B9yBboL5i7GNO6dyfMhPwq+B/xWzO7eu2sh
         1iLQ==
X-Gm-Message-State: AFqh2kpnC0ppZl6m9zdZuIKQtF1U9G1KiUYn61OJdjb0BtbRtuyYsePH
        +6H6Iu/uEEZW2IbMQ3u6v1UYssWMDB2RFwDjXdz5RyYtOl48
X-Google-Smtp-Source: AMrXdXvpowe4ELMR5GxWvuXQDFTfKovUwDQTGpi54kEKslajevKUEKlBV53zu/AUzUdqgiq/dy1VDNfQF2Y/GcQPQi5QSOeLVNwk
MIME-Version: 1.0
X-Received: by 2002:a5d:840d:0:b0:6e2:e641:b6ec with SMTP id
 i13-20020a5d840d000000b006e2e641b6ecmr6115732ion.198.1673563239420; Thu, 12
 Jan 2023 14:40:39 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:40:39 -0800
In-Reply-To: <000000000000f4b96605f20e5e2f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000651be505f218ce8b@google.com>
Subject: Re: [syzbot] [ext4?] [vfs?] KASAN: use-after-free Read in signalfd_cleanup
From:   syzbot <syzbot+8317cc9c082c19d576a0@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu,
        viro@zeniv.linux.org.uk
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

HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10a992a1480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=8317cc9c082c19d576a0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f672ee480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1357774a480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8111a570d6cb/disk-0a093b28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecc135b7fc9a/vmlinux-0a093b28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca8d73b446ea/bzImage-0a093b28.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8317cc9c082c19d576a0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __wake_up_common+0x637/0x650 kernel/sched/wait.c:100
Read of size 8 at addr ffff88801d1508f0 by task syz-executor378/5077

CPU: 0 PID: 5077 Comm: syz-executor378 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 __wake_up_common+0x637/0x650 kernel/sched/wait.c:100
 __wake_up_common_lock+0xd4/0x140 kernel/sched/wait.c:138
 __wake_up kernel/sched/wait.c:160 [inline]
 __wake_up_pollfree+0x1d/0x60 kernel/sched/wait.c:246
 wake_up_pollfree include/linux/wait.h:271 [inline]
 signalfd_cleanup+0x46/0x60 fs/signalfd.c:38
 __cleanup_sighand kernel/fork.c:1688 [inline]
 __cleanup_sighand+0x76/0xb0 kernel/fork.c:1685
 __exit_signal kernel/exit.c:209 [inline]
 release_task+0xbfa/0x1870 kernel/exit.c:255
 wait_task_zombie kernel/exit.c:1198 [inline]
 wait_consider_task+0x306d/0x3ce0 kernel/exit.c:1425
 do_wait_thread kernel/exit.c:1488 [inline]
 do_wait+0x7cd/0xd90 kernel/exit.c:1605
 kernel_wait4+0x150/0x260 kernel/exit.c:1768
 __do_sys_wait4+0x13f/0x150 kernel/exit.c:1796
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7facd1d06656
Code: 0f 1f 40 00 31 c9 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 90 48 83 ec 28 89 54 24 14 48 89 74 24
RSP: 002b:00007ffc250fbf98 EFLAGS: 00000246
 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 00007ffc250fc050 RCX: 00007facd1d06656
RDX: 0000000040000001 RSI: 00007ffc250fbfcc RDI: 00000000ffffffff
RBP: 00007ffc250fbfcc R08: 000000000000003d R09: 00007ffc251bb080
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000f4240
R13: 0000000000000002 R14: 00007ffc250fc020 R15: 00007ffc250fc010
 </TASK>

Allocated by task 5081:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 kmem_cache_alloc_bulk+0x3aa/0x730 mm/slub.c:4033
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1062
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2407
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3429
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 33:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 kmem_cache_free+0xec/0x4e0 mm/slub.c:3809
 io_req_caches_free+0x1a9/0x1e6 io_uring/io_uring.c:2737
 io_ring_exit_work+0x2e7/0xc80 io_uring/io_uring.c:2967
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff88801d1508c0
 which belongs to the cache io_kiocb of size 216
The buggy address is located 48 bytes inside of
 216-byte region [ffff88801d1508c0, ffff88801d150998)

The buggy address belongs to the physical page:
page:ffffea0000745400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1d150
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff88801beb7780 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 5081, tgid 5079 (syz-executor378), ts 61182579448, free_ts 52418879084
 prep_new_page mm/page_alloc.c:2549 [inline]
 get_page_from_freelist+0x11bb/0x2d50 mm/page_alloc.c:4324
 __alloc_pages+0x1cb/0x5c0 mm/page_alloc.c:5590
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2281
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __kmem_cache_alloc_bulk mm/slub.c:3951 [inline]
 kmem_cache_alloc_bulk+0x23d/0x730 mm/slub.c:4026
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1062
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2407
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3429
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1451 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1501
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3482
 __folio_put_small mm/swap.c:106 [inline]
 __folio_put+0xc5/0x140 mm/swap.c:129
 folio_put include/linux/mm.h:1203 [inline]
 put_page include/linux/mm.h:1272 [inline]
 anon_pipe_buf_release+0x3fb/0x4c0 fs/pipe.c:138
 pipe_buf_release include/linux/pipe_fs_i.h:183 [inline]
 pipe_read+0x614/0x1110 fs/pipe.c:324
 call_read_iter include/linux/fs.h:1846 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x7fa/0x930 fs/read_write.c:470
 ksys_read+0x1ec/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88801d150780: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801d150800: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
>ffff88801d150880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                             ^
 ffff88801d150900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801d150980: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

