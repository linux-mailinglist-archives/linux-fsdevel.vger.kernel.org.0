Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DED70C000
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjEVNr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjEVNry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:47:54 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E6DFA
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 06:47:53 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-333eb36e510so45725715ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 06:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684763272; x=1687355272;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4aast/ekNya0wedXkzIO8MimHmpqr/ODo7xmBUijHc=;
        b=jjctn49wZK9g6jCBK5/VjHcBQ8Cb2+WX7IF81CLxycrb+NEP7rC5vhElK+qiVRVNAn
         ezXey1ZtdAPMqVqn9+GygF/pu3Cg7NREnZXsaAefZYOMYnO1q3ZQX9t287slSzNEY1ZF
         vh4/lcXKxQO+twziiZgFNHcN2Ux+XzaGHq/pfGq5espopSJSp8LfZbEtSBtt1j4642SZ
         9TLjK4+iT3cDtl4/UQuOKxkyr7aatgAIHZi9E8oZGIINPypw7RKBfyITShDAePm1L1kB
         X9Q+w8aQMOmp3rYKKv5xCCmmwHjpcV8MzF3/OZJoBLs0uouwQz95xLAEqXzLucbQ93RW
         dv4g==
X-Gm-Message-State: AC+VfDyLSdCcWlwvljT2Mjj4cEi0DYlIzhHcBSLJOcydnwbUjFKtUS4a
        OTeGcFQo2GPgusMYIdrt6H9MswaxRjmfGRIdfCp0rYUrDk94
X-Google-Smtp-Source: ACHHUZ5d9veiq+OYSSIG/pl6NIZgDVfTHjzhhrjqq2b7HOWq1idHmo3KxazSnPnuYVHi8HTTWGX+zaUKMXiHW+K0B03DQcG4hUCP
MIME-Version: 1.0
X-Received: by 2002:a92:d8cb:0:b0:331:12ac:f633 with SMTP id
 l11-20020a92d8cb000000b0033112acf633mr5565248ilo.0.1684763272715; Mon, 22 May
 2023 06:47:52 -0700 (PDT)
Date:   Mon, 22 May 2023 06:47:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066a94205fc488445@google.com>
Subject: [syzbot] [block?] [reiserfs?] KASAN: user-memory-access Write in zram_slot_lock
From:   syzbot <syzbot+b8d61a58b7c7ebd2c8e0@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, reiserfs-devel@vger.kernel.org,
        senozhatsky@chromium.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    44c026a73be8 Linux 6.4-rc3
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10741fe9280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8067683055e3f5
dashboard link: https://syzkaller.appspot.com/bug?extid=b8d61a58b7c7ebd2c8e0
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1223f7d9280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1245326a280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/51c970de1750/disk-44c026a7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799aacdbebeb/vmlinux-44c026a7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0afc45e7f608/bzImage-44c026a7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fd3a214bd6ba/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b8d61a58b7c7ebd2c8e0@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 8192
REISERFS warning:  read_super_block: reiserfs filesystem is deprecated and scheduled to be removed from the kernel in 2025
REISERFS (device loop0): found reiserfs format "3.5" with non-standard journal
REISERFS (device loop0): using ordered data mode
reiserfs: using flush barriers
==================================================================
BUG: KASAN: user-memory-access in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: user-memory-access in test_and_set_bit_lock include/asm-generic/bitops/instrumented-lock.h:57 [inline]
BUG: KASAN: user-memory-access in bit_spin_lock include/linux/bit_spinlock.h:27 [inline]
BUG: KASAN: user-memory-access in zram_slot_lock+0x57/0x150 drivers/block/zram/zram_drv.c:67
Write of size 8 at addr 0000000000004128 by task syz-executor326/4993

CPU: 1 PID: 4993 Comm: syz-executor326 Not tainted 6.4.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_report+0xe6/0x540 mm/kasan/report.c:465
 kasan_report+0x176/0x1b0 mm/kasan/report.c:572
 kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 test_and_set_bit_lock include/asm-generic/bitops/instrumented-lock.h:57 [inline]
 bit_spin_lock include/linux/bit_spinlock.h:27 [inline]
 zram_slot_lock+0x57/0x150 drivers/block/zram/zram_drv.c:67
 zram_read_page drivers/block/zram/zram_drv.c:1362 [inline]
 zram_bvec_read drivers/block/zram/zram_drv.c:1409 [inline]
 zram_bio_read drivers/block/zram/zram_drv.c:1883 [inline]
 zram_submit_bio+0x18bc/0x26d0 drivers/block/zram/zram_drv.c:1933
 __submit_bio+0x205/0x2e0 block/blk-core.c:598
 __submit_bio_noacct block/blk-core.c:641 [inline]
 submit_bio_noacct_nocheck+0x467/0xc60 block/blk-core.c:704
 submit_bh fs/buffer.c:2782 [inline]
 __bread_slow fs/buffer.c:1226 [inline]
 __bread_gfp+0x1ec/0x380 fs/buffer.c:1419
 __bread include/linux/buffer_head.h:471 [inline]
 journal_init+0xf61/0x24b0 fs/reiserfs/journal.c:2788
 reiserfs_fill_super+0x1039/0x2620 fs/reiserfs/super.c:2022
 mount_bdev+0x274/0x3a0 fs/super.c:1380
 legacy_get_tree+0xef/0x190 fs/fs_context.c:610
 vfs_get_tree+0x8c/0x270 fs/super.c:1510
 do_new_mount+0x28f/0xae0 fs/namespace.c:3039
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f185eef5b0a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe122853a8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f185eef5b0a
RDX: 0000000020000080 RSI: 0000000020000140 RDI: 00007ffe122853b0
RBP: 00007ffe122853b0 R08: 00007ffe122853f0 R09: 0000000000001121
R10: 000000000120c083 R11: 0000000000000286 R12: 0000000000000004
R13: 00005555570882c0 R14: 00007ffe122853f0 R15: 0000000000000000
 </TASK>
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
