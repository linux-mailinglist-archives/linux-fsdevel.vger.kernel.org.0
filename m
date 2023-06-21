Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA270737A04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 06:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjFUEBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 00:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjFUEBH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:01:07 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEF619B0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 21:00:47 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-77d99de0e9bso419921239f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 21:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687320047; x=1689912047;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PgVoTAj3kuss3kFr1267Rg5VeIZx1hZjiH49N3zkAhA=;
        b=HOJUiRMK7tcUwD3B2IoTRU/n+TL3bIIQGk0TWuAe/p0zTxsiqaV+qm3l+Wi/0Q/4Ek
         +9yZYAIoVNLoR8EU51balXFi/tNghQMZSdGVPIlcQpdK1kYTxwNIxfL0j6fVvXUoHYUM
         W+HgRLGT/OZytgIpRZSDTlH8jM2405DMvCLDw8zjalPCi7/JM1voUpMxWa/dLkMlfh+d
         YL5SC5OEBcWA7MjfB4OVk3aWl6V1mYp5QY1Yr03Q1D+Tc1gjWwLMbUCSS/vViOqrE/4L
         GsgvRt+2aBJwbpO3AiUToyy21skz+YxZBoUDa1NX9XKKJ7/JM3hNcX6EbeKcQWjuFU3q
         mwUg==
X-Gm-Message-State: AC+VfDwUw1poxflrSNGPOAnLC7bnVhtAPAcf84YdqQQygt5MHSvuEbOo
        hYySUQCtPfolQta9rE2TzaHpwL51PLtMJMpSo4I6Y1q2zERX4ZA8Fg==
X-Google-Smtp-Source: ACHHUZ45C64BJjKSVk1PjWF96QGQgC8o90sOe7KtjM/Jxj2R97YCAGYSR5ZaiOBQ6cOzRHovOtR7eUj/DquuyhpZAc0KLcW25gy2
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22b6:b0:41c:fc86:d338 with SMTP id
 z22-20020a05663822b600b0041cfc86d338mr4651191jas.2.1687320047317; Tue, 20 Jun
 2023 21:00:47 -0700 (PDT)
Date:   Tue, 20 Jun 2023 21:00:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000afa6e05fe9bd037@google.com>
Subject: [syzbot] [hfs?] KASAN: wild-memory-access Read in hfsplus_bnode_read_u16
From:   syzbot <syzbot+9947d6d413633b3877d2@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1376ceef280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff8f87c7ab0e04e
dashboard link: https://syzkaller.appspot.com/bug?extid=9947d6d413633b3877d2
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b4a78b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120c7727280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/073eea957569/disk-40f71e7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c8a97aaa4cdc/vmlinux-40f71e7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f536015eacbd/bzImage-40f71e7c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a357fe8e79fa/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9947d6d413633b3877d2@syzkaller.appspotmail.com

         option from the mount to silence this warning.
=======================================================
==================================================================
BUG: KASAN: wild-memory-access in memcpy_from_page include/linux/highmem.h:417 [inline]
BUG: KASAN: wild-memory-access in hfsplus_bnode_read fs/hfsplus/bnode.c:32 [inline]
BUG: KASAN: wild-memory-access in hfsplus_bnode_read_u16+0x146/0x2c0 fs/hfsplus/bnode.c:45
Read of size 1 at addr 000508800000103f by task syz-executor206/4992

CPU: 1 PID: 4992 Comm: syz-executor206 Not tainted 6.4.0-rc6-syzkaller-00195-g40f71e7cd3c6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_report+0xe6/0x540 mm/kasan/report.c:465
 kasan_report+0x176/0x1b0 mm/kasan/report.c:572
 kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 memcpy_from_page include/linux/highmem.h:417 [inline]
 hfsplus_bnode_read fs/hfsplus/bnode.c:32 [inline]
 hfsplus_bnode_read_u16+0x146/0x2c0 fs/hfsplus/bnode.c:45
 hfsplus_bnode_find+0x769/0x10c0 fs/hfsplus/bnode.c:522
 hfsplus_bmap_alloc+0xc9/0x640 fs/hfsplus/btree.c:390
 hfs_btree_inc_height+0x11e/0xdb0 fs/hfsplus/brec.c:475
 hfsplus_brec_insert+0x166/0xdd0 fs/hfsplus/brec.c:75
 __hfsplus_ext_write_extent+0x36b/0x5b0 fs/hfsplus/extents.c:107
 __hfsplus_ext_cache_extent+0x84/0xe00 fs/hfsplus/extents.c:186
 hfsplus_ext_read_extent fs/hfsplus/extents.c:218 [inline]
 hfsplus_file_extend+0x439/0x1b10 fs/hfsplus/extents.c:461
 hfsplus_get_block+0x406/0x14e0 fs/hfsplus/extents.c:245
 __block_write_begin_int+0x548/0x1a50 fs/buffer.c:2064
 __block_write_begin fs/buffer.c:2114 [inline]
 block_write_begin+0x9c/0x1f0 fs/buffer.c:2175
 cont_write_begin+0x643/0x880 fs/buffer.c:2534
 hfsplus_write_begin+0x8a/0xd0 fs/hfsplus/inode.c:52
 cont_expand_zero fs/buffer.c:2461 [inline]
 cont_write_begin+0x316/0x880 fs/buffer.c:2524
 hfsplus_write_begin+0x8a/0xd0 fs/hfsplus/inode.c:52
 generic_cont_expand_simple+0x18b/0x2a0 fs/buffer.c:2425
 hfsplus_setattr+0x16d/0x280 fs/hfsplus/inode.c:263
 notify_change+0xc8b/0xf40 fs/attr.c:483
 do_truncate+0x220/0x300 fs/open.c:66
 do_sys_ftruncate+0x2e4/0x380 fs/open.c:194
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ffa4b6957c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdd40bdb58 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffa4b6957c9
RDX: 0000000000000000 RSI: 0000000000048280 RDI: 0000000000000004
RBP: 00007ffa4b655060 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000005f1 R11: 0000000000000246 R12: 00007ffa4b6550f0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
