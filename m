Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E642D74FFB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 08:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjGLGt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 02:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjGLGt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:49:57 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32DEDC
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 23:49:55 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-39ec7630322so7191817b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 23:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689144595; x=1691736595;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cw46mmK8seHK/M0HZxlyIi+BsrhITOMxcvJeOxHfpO0=;
        b=kGHbnb+zKiHNBT2KmUcixE7oxXnhhSmJDkuuIrOCnlyNSaQFHcp+a0Y3G37sjDe9pu
         cFPiREbgF4yMo8+72EXdquZyYCmbSZYbFwIzkUKPXaeP/1x5tlfQteGnhP0d0MhIbat6
         5jGCT98ayUO/WJDiuT1sjfc60Ye4w9g1xBmsQc5MEzy4QqGaQ767Q15YBhqhqZA7cp1/
         22Yr/xuSTKOhV4TPao1Uh5V15Svc3oSam8VV54NRsIfANnXGRuyFuoEOKWNBbSqyeBcZ
         klo2bDtvbeDUKbJkt24fuI5wdB+TlfNyqRPI7Lu+ilvddDa/4561Jux8XWPsic3P8T9c
         ZXsw==
X-Gm-Message-State: ABy/qLY0vqcnzDC5zEUjnuA91cMktu4fpzsRfYBfFIZ+f6+vNREPdNWK
        QQ0QxLp8RoLADbbLbdyElwXfWnioYOpzEnceYvasw8XvRQXH
X-Google-Smtp-Source: APBJJlGy6MzaHlFWWxQBzAuJhaqpRlf0DMrVyO+cQ1Tkow80XnLBnxPPhoQEUBvWEfWU+fwRAM73H/2xpOFrzvZvJIR8HfP20TwI
MIME-Version: 1.0
X-Received: by 2002:a05:6808:208a:b0:3a4:1265:67e7 with SMTP id
 s10-20020a056808208a00b003a4126567e7mr4380466oiw.8.1689144595341; Tue, 11 Jul
 2023 23:49:55 -0700 (PDT)
Date:   Tue, 11 Jul 2023 23:49:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009467500600449f6c@google.com>
Subject: [syzbot] [ntfs3?] KASAN: use-after-free Read in bcmp
From:   syzbot <syzbot+53ce40c8c0322c06aea5@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8689f4f2ea56 Merge tag 'mmc-v6.5-2' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1658af44a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15873d91ff37a949
dashboard link: https://syzkaller.appspot.com/bug?extid=53ce40c8c0322c06aea5
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f82688a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d54a78a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c84becffd011/disk-8689f4f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cfa539e85d0d/vmlinux-8689f4f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c60700b69248/bzImage-8689f4f2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/15e5129dfa97/mount_0.gz

The issue was bisected to:

commit 6a4cd3ea7d771be17177d95ff67d22cfa2a38b50
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Mon May 8 07:56:13 2023 +0000

    fs/ntfs3: Alternative boot if primary boot is corrupted

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10346eb0a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12346eb0a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=14346eb0a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+53ce40c8c0322c06aea5@syzkaller.appspotmail.com
Fixes: 6a4cd3ea7d77 ("fs/ntfs3: Alternative boot if primary boot is corrupted")

ntfs3: loop0: Different NTFS sector size (4096) and media sector size (512).
ntfs3: loop0: RAW NTFS volume: Filesystem size 16384.00 Gb > volume size 0.00 Gb. Mount in read-only.
ntfs3: loop0: NTFS 16384.00 Gb is too big to use 32 bits per cluster.
==================================================================
BUG: KASAN: use-after-free in memcmp lib/string.c:681 [inline]
BUG: KASAN: use-after-free in bcmp+0xc0/0x1e0 lib/string.c:713
Read of size 8 at addr ffff888074005002 by task syz-executor256/5017

CPU: 0 PID: 5017 Comm: syz-executor256 Not tainted 6.4.0-syzkaller-12365-g8689f4f2ea56 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 memcmp lib/string.c:681 [inline]
 bcmp+0xc0/0x1e0 lib/string.c:713
 ntfs_init_from_boot fs/ntfs3/super.c:860 [inline]
 ntfs_fill_super+0x9e6/0x4cb0 fs/ntfs3/super.c:1141
 get_tree_bdev+0x468/0x6c0 fs/super.c:1318
 vfs_get_tree+0x8c/0x270 fs/super.c:1519
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f08206ada0a
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc5e683e78 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f08206ada0a
RDX: 00000000200000c0 RSI: 0000000020000000 RDI: 00007ffc5e683e90
RBP: 00007ffc5e683e90 R08: 00007ffc5e683ed0 R09: 0000000000000000
R10: 0000000000800000 R11: 0000000000000286 R12: 0000000000000004
R13: 0000555555bbb2c0 R14: 0000000000800000 R15: 00007ffc5e683ed0
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001d00140 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x74005
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 ffffea0001d00188 ffff8880b9843020 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO), pid 5017, tgid 5017 (syz-executor256), ts 72917555675, free_ts 72955416955
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1570
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0x31e8/0x3370 mm/page_alloc.c:3221
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4477
 __folio_alloc+0x13/0x30 mm/page_alloc.c:4509
 vma_alloc_folio+0x48a/0x9a0 mm/mempolicy.c:2240
 do_anonymous_page mm/memory.c:4097 [inline]
 do_pte_missing mm/memory.c:3662 [inline]
 handle_pte_fault mm/memory.c:4932 [inline]
 __handle_mm_fault mm/memory.c:5072 [inline]
 handle_mm_fault+0x20c7/0x5410 mm/memory.c:5226
 do_user_addr_fault arch/x86/mm/fault.c:1343 [inline]
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x3cf/0x7c0 arch/x86/mm/fault.c:1542
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1161 [inline]
 free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2348
 free_unref_page_list+0x596/0x830 mm/page_alloc.c:2489
 release_pages+0x2193/0x2470 mm/swap.c:1042
 tlb_batch_pages_flush mm/mmu_gather.c:97 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu+0x100/0x210 mm/mmu_gather.c:299
 tlb_finish_mmu+0xd4/0x1f0 mm/mmu_gather.c:391
 unmap_region+0x258/0x2a0 mm/mmap.c:2313
 do_vmi_align_munmap+0x135d/0x1630 mm/mmap.c:2552
 do_vmi_munmap+0x24d/0x2d0 mm/mmap.c:2619
 __vm_munmap+0x230/0x450 mm/mmap.c:2899
 __do_sys_munmap mm/mmap.c:2916 [inline]
 __se_sys_munmap mm/mmap.c:2913 [inline]
 __x64_sys_munmap+0x69/0x80 mm/mmap.c:2913
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888074004f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888074004f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888074005000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff888074005080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888074005100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
