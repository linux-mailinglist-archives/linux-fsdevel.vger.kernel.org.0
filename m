Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858787AC704
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Sep 2023 09:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjIXHuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 03:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjIXHuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 03:50:05 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3844112
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 00:49:57 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3ae33bc5584so4915564b6e.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 00:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695541797; x=1696146597;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQdCC3iDzc1EqHBtyKVAKzUBetO1Nn5fGK6Vt8x2SAw=;
        b=etg7Tb6h/vvTJ//a4PjGqFSYV1r67ncgxo7dx9ShZ1bze1Ji2FYFRVo/i1/IuBvuZM
         5NqnCRN9CpGHUPiFDAret4ms9bM3fwxZFaUxsWrlLc2xfpaPcUEHKC3Kqg1nLCMI2R4C
         cAsqUiF86L0Lre/FqXSIQ+Cg4tgO8d6Xq6fDdPLWPm49INoGOxYR0+pdlGZK7yJsNUSj
         KnYmeoEqothvQ81AHrBLa8t09kp5P0cPGeIo7XihB5wOUfnXFyT4ID01Pit/YGDbPNCg
         yovdcitG+7Em7rt4TmlxwC5VDq2f4e0vcmvp5PKWnjlNy1rdAKIGZBhHzoSYeCGh1jyv
         T0KA==
X-Gm-Message-State: AOJu0YwWwuAjWieaTwuk2hstmqZPUsa64EQsCMpiWVBRlsQcARGqGHXa
        3XDfJf9ltFDHBUze3k4RRojIMwl0RX9xi9e8BZ0B1LKX2Yvs
X-Google-Smtp-Source: AGHT+IHwdMUvkbLqFcHI/c5EGsGujCL+3pGY8pIgOZdevbYouBFUcoR4cPUdCSy8jew+6pP1zAbWN04k8YYTndQj7svb5iWz8xQ6
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f0a:b0:3ad:aeed:7ed9 with SMTP id
 m10-20020a0568080f0a00b003adaeed7ed9mr2448378oiw.2.1695541796931; Sun, 24 Sep
 2023 00:49:56 -0700 (PDT)
Date:   Sun, 24 Sep 2023 00:49:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000820e380606161640@google.com>
Subject: [syzbot] [mm?] [hfs?] KASAN: slab-out-of-bounds Read in generic_perform_write
From:   syzbot <syzbot+4a2376bc62e59406c414@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2cf0f7156238 Merge tag 'nfs-for-6.6-2' of git://git.linux-..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=153cd286680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4ca82a1bedd37e4
dashboard link: https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e88918680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10aea78c680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eac482f1f6bc/disk-2cf0f715.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7a69dad9f1ff/vmlinux-2cf0f715.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16676b650375/bzImage-2cf0f715.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c040f8fc7107/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10e0a282680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12e0a282680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14e0a282680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4a2376bc62e59406c414@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy_from_iter lib/iov_iter.c:380 [inline]
BUG: KASAN: slab-out-of-bounds in copy_page_from_iter_atomic+0x908/0x12f0 lib/iov_iter.c:590
Read of size 1024 at addr ffff888020b4ec00 by task kworker/u4:7/1273

CPU: 0 PID: 1273 Comm: kworker/u4:7 Not tainted 6.6.0-rc2-syzkaller-00018-g2cf0f7156238 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Workqueue: loop0 loop_rootcg_workfn
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 kasan_check_range+0x27e/0x290 mm/kasan/generic.c:187
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 memcpy_from_iter lib/iov_iter.c:380 [inline]
 copy_page_from_iter_atomic+0x908/0x12f0 lib/iov_iter.c:590
 generic_perform_write+0x392/0x630 mm/filemap.c:3950
 shmem_file_write_iter+0xfc/0x120 mm/shmem.c:2865
 do_iter_write+0x84f/0xde0 fs/read_write.c:860
 lo_write_bvec drivers/block/loop.c:249 [inline]
 lo_write_simple drivers/block/loop.c:271 [inline]
 do_req_filebacked drivers/block/loop.c:495 [inline]
 loop_handle_cmd drivers/block/loop.c:1915 [inline]
 loop_process_work+0x14c3/0x22a0 drivers/block/loop.c:1950
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 5038:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1023 [inline]
 __kmalloc+0xb9/0x230 mm/slab_common.c:1036
 kmalloc include/linux/slab.h:603 [inline]
 hfsplus_read_wrapper+0x545/0x1330 fs/hfsplus/wrapper.c:178
 hfsplus_fill_super+0x38e/0x1c90 fs/hfsplus/super.c:413
 mount_bdev+0x237/0x300 fs/super.c:1629
 legacy_get_tree+0xef/0x190 fs/fs_context.c:638
 vfs_get_tree+0x8c/0x280 fs/super.c:1750
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888020b4ec00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes inside of
 allocated 512-byte region [ffff888020b4ec00, ffff888020b4ee00)

The buggy address belongs to the physical page:
page:ffffea000082d300 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x20b4c
head:ffffea000082d300 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012841c80 ffffea000085e900 dead000000000002
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 12443144717, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31db/0x3360 mm/page_alloc.c:3170
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4426
 alloc_page_interleave+0x22/0x1d0 mm/mempolicy.c:2131
 alloc_slab_page+0x6a/0x160 mm/slub.c:1870
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2070
 ___slab_alloc+0xc85/0x1310 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x1af/0x270 mm/slub.c:3517
 kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1114
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 dev_pm_qos_constraints_allocate+0x8f/0x400 drivers/base/power/qos.c:204
 __dev_pm_qos_add_request+0x121/0x4a0 drivers/base/power/qos.c:344
 dev_pm_qos_add_request+0x3a/0x60 drivers/base/power/qos.c:394
 usb_hub_create_port_device+0x4c6/0xc40 drivers/usb/core/port.c:727
 hub_configure drivers/usb/core/hub.c:1685 [inline]
 hub_probe+0x2469/0x3570 drivers/usb/core/hub.c:1922
 usb_probe_interface+0x5c4/0xb00 drivers/usb/core/driver.c:396
 really_probe+0x294/0xc30 drivers/base/dd.c:658
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888020b4ed00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888020b4ed80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888020b4ee00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff888020b4ee80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888020b4ef00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
