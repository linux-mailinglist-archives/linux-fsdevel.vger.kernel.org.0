Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F3A779ED0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 12:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbjHLKJH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Aug 2023 06:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLKJG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:09:06 -0400
Received: from mail-pj1-f79.google.com (mail-pj1-f79.google.com [209.85.216.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829D32133
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Aug 2023 03:09:09 -0700 (PDT)
Received: by mail-pj1-f79.google.com with SMTP id 98e67ed59e1d1-26b10a6dbcaso2545959a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Aug 2023 03:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691834949; x=1692439749;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0klN8QFRRXCfdr9hyJIjXeb7EawXv7mA5QclU54Tv2I=;
        b=Zg1oBKPY0+2Qr9eWQyCiiei/uDuYZieVHBI+UH9W/nRSz74XEGru/jtgsWv1JZR3Zj
         ujAGQvpNEDEluotmHf1plwojGMGOD+MKBn8zeyQ/X8EFDElj/N15zvN2MVdDyUIYZHKy
         6TkIQvjgBi/GBY8TaTFZELr8S1fJVhaCB24H88ozQFzBPDJnRAfmxes69v/kafyzxwxV
         sYkEF9fv6f7z7RcWPl6dgqyBQF+WBohPwtrI7oWc3raLB+XdgY+NyGOgDdnrEFFF6thz
         +qO8r8X3L9Nq6tYeAYwJKbXa6vRsLcDWUflUrSWfg0H4hJB+xtzps7gS67i0tpIu3fZw
         2nGQ==
X-Gm-Message-State: AOJu0Yx/xNNU7PiXnwqHLvw70okvOg6+3VhP6AHkf9v7crJ+/mY4m8X3
        ljvL78ClscM24298DcKaGY2QRO0DClMYFsgbBA6DiL+RVq3i
X-Google-Smtp-Source: AGHT+IHHe9ritngN34CjNJbOLu8fVp2zGzw8iNdruGKqEC1aaJC6oHBqphYM40VfKJW37k+GWFjDuXnUUMYwM3huQ2E39G3zVYtB
MIME-Version: 1.0
X-Received: by 2002:a17:90a:8b11:b0:268:9d52:9dc2 with SMTP id
 y17-20020a17090a8b1100b002689d529dc2mr898959pjn.4.1691834948833; Sat, 12 Aug
 2023 03:09:08 -0700 (PDT)
Date:   Sat, 12 Aug 2023 03:09:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024d7f70602b705e9@google.com>
Subject: [syzbot] [udf?] KASAN: use-after-free Read in udf_sync_fs
From:   syzbot <syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f8de32cc060b Merge tag 'tpmdd-v6.5-rc7' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12ac6b63a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=171b698bc2e613cf
dashboard link: https://syzkaller.appspot.com/bug?extid=82df44ede2faca24c729
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10df55d7a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e4d78ba80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e92cdc2deca7/disk-f8de32cc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f821f8a8a452/vmlinux-f8de32cc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b58fb75b1ad9/bzImage-f8de32cc.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/6f92232ea34d/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/9c162574e7a2/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com

         option from the mount to silence this warning.
=======================================================
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
==================================================================
BUG: KASAN: use-after-free in crc_itu_t+0x21c/0x2a0 lib/crc-itu-t.c:60
Read of size 1 at addr ffff88807615a000 by task syz-executor345/5015

CPU: 0 PID: 5015 Comm: syz-executor345 Not tainted 6.5.0-rc5-syzkaller-00296-gf8de32cc060b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 crc_itu_t+0x21c/0x2a0 lib/crc-itu-t.c:60
 udf_finalize_lvid fs/udf/super.c:1984 [inline]
 udf_sync_fs+0x1d2/0x380 fs/udf/super.c:2340
 sync_filesystem+0xec/0x220 fs/sync.c:56
 generic_shutdown_super+0x6f/0x340 fs/super.c:472
 kill_block_super+0x68/0xa0 fs/super.c:1417
 deactivate_locked_super+0xa4/0x110 fs/super.c:330
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1254
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x68f/0x2290 kernel/exit.c:874
 do_group_exit+0x206/0x2c0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f655d3c5a09
Code: Unable to access opcode bytes at 0x7f655d3c59df.
RSP: 002b:00007ffd9560b9e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f655d3c5a09
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007f655d4612d0 R08: ffffffffffffffb8 R09: 0000000000000004
R10: 0000000000001400 R11: 0000000000000246 R12: 00007f655d4612d0
R13: 0000000000000000 R14: 00007f655d462040 R15: 00007f655d393f30
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001d85680 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x7615a
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 ffffea0001d85408 ffffea0001ce1548 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO), pid 4872, tgid 4872 (sshd), ts 47777475140, free_ts 47861737656
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1570
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0x31e8/0x3370 mm/page_alloc.c:3221
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4477
 __folio_alloc+0x13/0x30 mm/page_alloc.c:4509
 vma_alloc_folio+0x48a/0x9a0 mm/mempolicy.c:2253
 do_anonymous_page mm/memory.c:4104 [inline]
 do_pte_missing mm/memory.c:3662 [inline]
 handle_pte_fault mm/memory.c:4939 [inline]
 __handle_mm_fault mm/memory.c:5079 [inline]
 handle_mm_fault+0x20c7/0x5410 mm/memory.c:5233
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
 unmap_region+0x258/0x2a0 mm/mmap.c:2318
 do_vmi_align_munmap+0x135d/0x1630 mm/mmap.c:2557
 do_vmi_munmap+0x24d/0x2d0 mm/mmap.c:2624
 __vm_munmap+0x230/0x450 mm/mmap.c:2906
 __do_sys_munmap mm/mmap.c:2923 [inline]
 __se_sys_munmap mm/mmap.c:2920 [inline]
 __x64_sys_munmap+0x69/0x80 mm/mmap.c:2920
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888076159f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888076159f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807615a000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88807615a080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807615a100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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
