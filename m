Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DA5744995
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jul 2023 16:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjGAOWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jul 2023 10:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbjGAOV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jul 2023 10:21:59 -0400
Received: from mail-pj1-f77.google.com (mail-pj1-f77.google.com [209.85.216.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0568E3C35
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Jul 2023 07:21:54 -0700 (PDT)
Received: by mail-pj1-f77.google.com with SMTP id 98e67ed59e1d1-262dc0bab18so2732851a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Jul 2023 07:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688221314; x=1690813314;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OT8IPwfbE64wzXdylWaPxtAqsU48uR9clEZjxfkIm00=;
        b=bujngPEMfKT3fGTAKqcBxnvwDIDqa8xYd3R+w250Tq0Mz69yfxLcrlPm+MwQ42TclA
         HnJ9Yl/C4ALNws0aE+JzVfw+fUO4sWLhu/rAjDmlA85sVnDTM+M7B8N4yknSTvtgsXPo
         rOyEsLqrZ79MCKvBewnKLa53blv+scCE5zYJXq+wYpyKSmnOjkQ6QxBC5o5AFq1EkV1m
         FALpcD/n9ImQdzpIjHdJgBZpx0nG1kptISwbfwSLUvhJI8F07yxkTi+5UUwNENpxSHM6
         6P3J66eiFAcyk6OfDWCjUnXQbXfnE/8WLt4XSw/MD/G1koREpuGijDg7veuqGQHaG95q
         HK2A==
X-Gm-Message-State: ABy/qLbfz3IvXpaSuLbv7s5RFcLueUWSqvhuxOfmWRhTGftJd64QLCGR
        uq7hsF5rQ8DWVpkc7xFayY5xGF3Up5/PR1ng8SbZp7aPm4oO
X-Google-Smtp-Source: APBJJlH9bi9qfBOjoH2i36RqLtgB5R0q2IcMIeBbWh5J0+zMQVMH3/phBQXMUzmWT9cpoE/06oTWS+uRWTimSnEHfd6EpPaFALY5
MIME-Version: 1.0
X-Received: by 2002:a17:902:f389:b0:1b2:436b:931d with SMTP id
 f9-20020a170902f38900b001b2436b931dmr4212186ple.2.1688221313898; Sat, 01 Jul
 2023 07:21:53 -0700 (PDT)
Date:   Sat, 01 Jul 2023 07:21:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7a0c305ff6da727@google.com>
Subject: [syzbot] [overlayfs?] KASAN: invalid-free in init_file
From:   syzbot <syzbot+ada42aab05cf51b00e98@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1ef6663a587b Merge tag 'tag-chrome-platform-for-v6.5' of g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=120fd3a8a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=33c8c2baba1cfc7e
dashboard link: https://syzkaller.appspot.com/bug?extid=ada42aab05cf51b00e98
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130a5670a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aac680a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6561f5e7c861/disk-1ef6663a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aed67f7d3a9d/vmlinux-1ef6663a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/baa651e2ed8e/bzImage-1ef6663a.xz

The issue was bisected to:

commit 62d53c4a1dfe347bd87ede46ffad38c9a3870338
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Thu Jun 15 11:22:28 2023 +0000

    fs: use backing_file container for internal files with "fake" f_path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=156341e0a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=176341e0a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=136341e0a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ada42aab05cf51b00e98@syzkaller.appspotmail.com
Fixes: 62d53c4a1dfe ("fs: use backing_file container for internal files with "fake" f_path")

RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fbb808467a9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
RBP: 00007ffdc0c78ff0 R08: 0000000000000001 R09: 00007fbb80800034
R10: 000000007ffff000 R11: 0000000000000246 R12: 0000000000000006
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
==================================================================
BUG: KASAN: invalid-free in init_file+0x195/0x200 fs/file_table.c:163
Free of addr ffff88801ea5a800 by task syz-executor145/4991

CPU: 0 PID: 4991 Comm: syz-executor145 Not tainted 6.4.0-syzkaller-01224-g1ef6663a587b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:351 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:462
 kasan_report_invalid_free+0xeb/0x100 mm/kasan/report.c:537
 ____kasan_slab_free+0xfb/0x120
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook mm/slub.c:1807 [inline]
 slab_free mm/slub.c:3786 [inline]
 kmem_cache_free+0x297/0x520 mm/slub.c:3808
 init_file+0x195/0x200 fs/file_table.c:163
 alloc_empty_backing_file+0x67/0xd0 fs/file_table.c:267
 backing_file_open+0x26/0x100 fs/open.c:1166
 ovl_open_realfile+0x1f6/0x350 fs/overlayfs/file.c:64
 ovl_real_fdget_meta fs/overlayfs/file.c:122 [inline]
 ovl_real_fdget fs/overlayfs/file.c:143 [inline]
 ovl_splice_read+0x7cc/0x8c0 fs/overlayfs/file.c:430
 splice_direct_to_actor+0x2a8/0x9a0 fs/splice.c:961
 do_splice_direct+0x286/0x3d0 fs/splice.c:1070
 do_sendfile+0x623/0x1070 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbb808467a9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdc0c78fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fbb808467a9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
RBP: 00007ffdc0c78ff0 R08: 0000000000000001 R09: 00007fbb80800034
R10: 000000007ffff000 R11: 0000000000000246 R12: 0000000000000006
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 4991:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 alloc_empty_backing_file+0x52/0xd0 fs/file_table.c:263
 backing_file_open+0x26/0x100 fs/open.c:1166
 ovl_open_realfile+0x1f6/0x350 fs/overlayfs/file.c:64
 ovl_real_fdget_meta fs/overlayfs/file.c:122 [inline]
 ovl_real_fdget fs/overlayfs/file.c:143 [inline]
 ovl_splice_read+0x7cc/0x8c0 fs/overlayfs/file.c:430
 splice_direct_to_actor+0x2a8/0x9a0 fs/splice.c:961
 do_splice_direct+0x286/0x3d0 fs/splice.c:1070
 do_sendfile+0x623/0x1070 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801ea5a800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes inside of
 480-byte region [ffff88801ea5a800, ffff88801ea5a9e0)

The buggy address belongs to the physical page:
page:ffffea00007a9600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ea58
head:ffffea00007a9600 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012441c80 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 733, tgid 733 (kworker/u4:0), ts 6534177535, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1744
 prep_new_page mm/page_alloc.c:1751 [inline]
 get_page_from_freelist+0x320e/0x3390 mm/page_alloc.c:3523
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4794
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3192
 __slab_alloc mm/slub.c:3291 [inline]
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 __kmem_cache_alloc_node+0x1b8/0x290 mm/slub.c:3490
 kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1057
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 alloc_bprm+0x56/0x900 fs/exec.c:1512
 kernel_execve+0x96/0xa10 fs/exec.c:1987
 call_usermodehelper_exec_async+0x233/0x370 kernel/umh.c:110
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801ea5a700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801ea5a780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801ea5a800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                   ^
 ffff88801ea5a880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88801ea5a900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
