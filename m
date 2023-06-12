Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A947172D545
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 01:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjFLX7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 19:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjFLX67 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:58:59 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A8C1718
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 16:58:58 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-76c5c78bc24so684183639f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 16:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686614337; x=1689206337;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I60cThygFBEQa4s2JlbXnAAnVmBToxnr0RN30Ke0zVQ=;
        b=KdZSCeBSF4YUacGPgnfMkHsMpRBBdzfQVre93JwMP6cvHvSCLvGFof1+NegHclyWWt
         8KAWDO6jj2ZxbyMxCJn4SCKLvzumGEqrmY1ST1OoLkrqZ+7tfXCueLnCSrj/m11K8Ifr
         2CgEOfgW1Pu4tzHome95DEEpDJijc8z8DcFKqy+Oo8Rdq1v3pyomg6EsNbkR5VKspwwG
         L806hiMmcArd/+LV91PS1lxp/ZOVJJqCrB5ZGISOvA/aoFhjRsiUvzl1on3GRovWcDOu
         foi4Fo3b9z0dt5i5eDecm8BtMnWXGAKmx71tkW5X4Qpx6eLg2+bjDbn2i+zdppnaUw9K
         8P4A==
X-Gm-Message-State: AC+VfDysII75NqvKBhaMmOx6Zo41BCkFJWN1CuiOhrl3xNe33ozZjmps
        P2NxUq9klvW7/LIMS6IyxngBZSWdWIF46WNTeCSKFyDk6jQv
X-Google-Smtp-Source: ACHHUZ55nByCQPnYhdB5pelTum4aoB271NyGVXkbd+02MVKqPl6kKOb6Qyck86RgkYKlcyQyrKcBRql2C2vDgw1c8shsLlJ000FZ
MIME-Version: 1.0
X-Received: by 2002:a02:a1c8:0:b0:41d:86fc:4b43 with SMTP id
 o8-20020a02a1c8000000b0041d86fc4b43mr4688613jah.4.1686614337718; Mon, 12 Jun
 2023 16:58:57 -0700 (PDT)
Date:   Mon, 12 Jun 2023 16:58:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079134b05fdf78048@google.com>
Subject: [syzbot] [ext4?] UBSAN: shift-out-of-bounds in ext2_fill_super (2)
From:   syzbot <syzbot+af5e10f73dbff48f70af@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
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

HEAD commit:    908f31f2a05b Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=124e9053280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1058fe68f4b7b2c
dashboard link: https://syzkaller.appspot.com/bug?extid=af5e10f73dbff48f70af
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f66595280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14abde43280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/87d095820229/disk-908f31f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a1bf67af9675/vmlinux-908f31f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7784a88b37e8/Image-908f31f2.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2816e591e0fa/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+af5e10f73dbff48f70af@syzkaller.appspotmail.com

memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=5969 'syz-executor354'
loop0: detected capacity change from 0 to 512
EXT2-fs (loop0): (no)user_xattr optionsnot supported
================================================================================
UBSAN: shift-out-of-bounds in fs/ext2/super.c:1015:40
shift exponent 63 is too large for 32-bit type 'int'
CPU: 0 PID: 5969 Comm: syz-executor354 Not tainted 6.4.0-rc4-syzkaller-g908f31f2a05b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x2f4/0x36c lib/ubsan.c:387
 ext2_fill_super+0x2270/0x2450 fs/ext2/super.c:1015
 mount_bdev+0x274/0x370 fs/super.c:1380
 ext2_mount+0x44/0x58 fs/ext2/super.c:1491
 legacy_get_tree+0xd4/0x16c fs/fs_context.c:610
 vfs_get_tree+0x90/0x274 fs/super.c:1510
 do_new_mount+0x25c/0x8c4 fs/namespace.c:3039
 path_mount+0x590/0xe04 fs/namespace.c:3369
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
================================================================================
EXT2-fs (loop0): error: can't find an ext2 filesystem on dev loop0.


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
