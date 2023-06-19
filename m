Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7D9735B11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 17:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjFSPYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 11:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFSPYt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:24:49 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B685FA
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 08:24:47 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-77e41268d40so62659239f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 08:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687188287; x=1689780287;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bcDmpyYLHAMJ85onJYMN0r/KdlWgRJsi8m67AeFqA2Q=;
        b=LpDqC4Up1iuwVVMYJdQXrvzuDbTLr1H62sF+Da/NQsZuB/a27xu3oFQtGVpxiTcR2W
         2aILgDU6zsgKICVCVvnMnpxoHUQPg4HJ4vqfAPmfHhLrhIwmsfe7uPdwscHstdyVuQfl
         NXJYKfBEeSGKiu0kdQ/OtsAOyk7b90v14Qt6CmhwiVTKkaqr/gaxZtElrPIDYmKQHmRp
         K/tUIfJYR2ZDUVrWq7jBhXNEoQ1LbgJG1ru3/agz2+fSEyRPUA4fls2jeb7N4sYAOlFU
         e0mwDhy6Q6P0iK4FG3PLp2eUeIyH7NIA4/GvBGUultU+VSQ5cOgvX04ccMv+jKMk4IAx
         Xfzw==
X-Gm-Message-State: AC+VfDycrGV3Sg/nMiPVbLgcdzHgmJaMfKRCHzUdKKT8iwfGQx9oFkDN
        Fvy1Wjxju/g127c/bbwv8KSnDKrc6P1AphXaiSWvX1SOX/Ce
X-Google-Smtp-Source: ACHHUZ6TIgteXfkalZHs0TmKVeLSoGrKnohITVB6cf/aFVMrjprJ+1jKAbbO2cAlwl+sFbENtOjlylSxTVc/f+l+sNcebooUpwMA
MIME-Version: 1.0
X-Received: by 2002:a02:2ac7:0:b0:41a:c455:f4c8 with SMTP id
 w190-20020a022ac7000000b0041ac455f4c8mr2740129jaw.3.1687188286996; Mon, 19
 Jun 2023 08:24:46 -0700 (PDT)
Date:   Mon, 19 Jun 2023 08:24:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084090905fe7d22bb@google.com>
Subject: [syzbot] [udf?] KASAN: use-after-free Read in udf_finalize_lvid
From:   syzbot <syzbot+46073c22edd7f242c028@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=164eceef280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
dashboard link: https://syzkaller.appspot.com/bug?extid=46073c22edd7f242c028
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167bc85b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165bbae3280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e44e674ee0cc/disk-40f71e7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ed0a3681597b/vmlinux-40f71e7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/320a8bdb797c/bzImage-40f71e7c.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/52d1f2684156/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/ff7382a27de2/mount_3.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+46073c22edd7f242c028@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in crc_itu_t+0xd2/0xe0 lib/crc-itu-t.c:60
Read of size 1 at addr ffff888071a7e000 by task syz-executor298/5001

CPU: 1 PID: 5001 Comm: syz-executor298 Not tainted 6.4.0-rc6-syzkaller-00195-g40f71e7cd3c6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 crc_itu_t+0xd2/0xe0 lib/crc-itu-t.c:60
 udf_finalize_lvid+0xe0/0x1d0 fs/udf/super.c:1988
 udf_close_lvid.isra.0+0x406/0x550 fs/udf/super.c:2056
 udf_put_super+0x1bb/0x230 fs/udf/super.c:2326
 generic_shutdown_super+0x158/0x480 fs/super.c:500
 kill_block_super+0xa1/0x100 fs/super.c:1407
 deactivate_locked_super+0x98/0x160 fs/super.c:331
 deactivate_super+0xb1/0xd0 fs/super.c:362
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1177
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 ptrace_notify+0x118/0x140 kernel/signal.c:2371
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:252 [inline]
 syscall_exit_to_user_mode_prepare+0x129/0x220 kernel/entry/common.c:279
 __syscall_exit_to_user_mode_work kernel/entry/common.c:284 [inline]
 syscall_exit_to_user_mode+0xd/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f082b4a11f7
Code: 07 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd2475cbc8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f082b4a11f7
RDX: 00007ffd2475cc89 RSI: 000000000000000a RDI: 00007ffd2475cc80
RBP: 00007ffd2475cc80 R08: 00000000ffffffff R09: 00007ffd2475ca60
R10: 000055555740b66b R11: 0000000000000202 R12: 00007ffd2475dcf0
R13: 000055555740b5f0 R14: 00007ffd2475cbf0 R15: 0000000000000004
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001c69f80 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x71a7e
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 ffffea0001c69fc8 ffffea0001c42348 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO), pid 5006, tgid 5006 (syz-executor298), ts 46591154745, free_ts 46799828739
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0xf41/0x2c00 mm/page_alloc.c:3502
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4768
 __folio_alloc+0x16/0x40 mm/page_alloc.c:4800
 vma_alloc_folio+0x155/0x890 mm/mempolicy.c:2240
 do_anonymous_page mm/memory.c:4085 [inline]
 do_pte_missing mm/memory.c:3645 [inline]
 handle_pte_fault mm/memory.c:4947 [inline]
 __handle_mm_fault+0x224c/0x41c0 mm/memory.c:5089
 handle_mm_fault+0x2af/0x9f0 mm/memory.c:5243
 do_user_addr_fault+0x2ca/0x1210 arch/x86/mm/fault.c:1349
 handle_page_fault arch/x86/mm/fault.c:1534 [inline]
 exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1590
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2564
 free_unref_page_list+0xe3/0xa70 mm/page_alloc.c:2705
 release_pages+0xcd8/0x1380 mm/swap.c:1042
 tlb_batch_pages_flush+0xa8/0x1a0 mm/mmu_gather.c:97
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu mm/mmu_gather.c:299 [inline]
 tlb_finish_mmu+0x14b/0x7e0 mm/mmu_gather.c:391
 exit_mmap+0x2b2/0x930 mm/mmap.c:3123
 __mmput+0x128/0x4c0 kernel/fork.c:1351
 mmput+0x60/0x70 kernel/fork.c:1373
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9b0/0x29b0 kernel/exit.c:861
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888071a7df00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888071a7df80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888071a7e000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff888071a7e080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888071a7e100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
