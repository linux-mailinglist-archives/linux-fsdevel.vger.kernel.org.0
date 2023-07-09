Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2F074C418
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 14:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjGIMcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 08:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGIMcw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 08:32:52 -0400
Received: from mail-pj1-f78.google.com (mail-pj1-f78.google.com [209.85.216.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5BE12A
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 Jul 2023 05:32:51 -0700 (PDT)
Received: by mail-pj1-f78.google.com with SMTP id 98e67ed59e1d1-262f7a3bc80so5976904a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Jul 2023 05:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688905970; x=1691497970;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6EniVOaw9gyk03or5BKg9EbqyWrmMeOPg9KKXf8+m8=;
        b=W/tPslyZirWsmb8sjXEyMmzpl7S/wYTj/E/4Lmpb/7k13QqUrF9W8/DoY79l8E5WJl
         1EABBk/11IpqNnWXvOYtMZ0ExCKPbbec4MD5q9ZaIkuclq3aJfkda+jm1o6DJ8zWBPTX
         pXR3/fCJ/PoLlJchb+SAgWmc/vjKHtNn9AAmtBkPtI1fdt+Da4TnkUC4ziSHJIBj0nRM
         G3D/Qn+k+Afye4kNwwiCMGvzTzUDd0ubPG5omWOIRrTxZD//MQyEDkU8BoM/NQ+Zm5ZP
         a7eqHxJ3Yc+be819UbRZmSiGEnuX6A7GHHj82zHUWyCgwOzPJUAUIoBdOHzEhLPtpWTv
         IaNA==
X-Gm-Message-State: ABy/qLZhRQQTSCIlUSAUT5u3s2N2pBpMwpOac3QCBnjtn1d1YLawNk+b
        0XrQXlDs0cz8WUBK5Hf1wbFJFMvzjIB4nQ+YzWpYwQ6JgSPL
X-Google-Smtp-Source: APBJJlE8NgIH1meEwWoDFpQ4FcvLOM9oqrIwO1KMptPMiwh3AXaM5TRaOFE/yHli6GD5tPlyAj4XzHsTNoKhBMJy1ISwiVD5YJCl
MIME-Version: 1.0
X-Received: by 2002:a17:90a:dc86:b0:262:d8e7:abff with SMTP id
 j6-20020a17090adc8600b00262d8e7abffmr9006179pjv.2.1688905970549; Sun, 09 Jul
 2023 05:32:50 -0700 (PDT)
Date:   Sun, 09 Jul 2023 05:32:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f098a06000d10a5@google.com>
Subject: [syzbot] [ntfs3?] UBSAN: array-index-out-of-bounds in truncate_inode_pages_final
From:   syzbot <syzbot+e295147e14b474e4ad70@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e40939bbfc68 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15866358a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c84f463eb74eab24
dashboard link: https://syzkaller.appspot.com/bug?extid=e295147e14b474e4ad70
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101c2da4a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/257596b75aaf/disk-e40939bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9c75b8d61081/vmlinux-e40939bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f0233129f4f/Image-e40939bb.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5b0c90b3f3a1/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e295147e14b474e4ad70@syzkaller.appspotmail.com

ntfs3: loop0: Different NTFS sector size (1024) and media sector size (512).
================================================================================
UBSAN: array-index-out-of-bounds in ./include/linux/pagevec.h:126:2
index 255 is out of range for type 'struct folio *[15]'
CPU: 1 PID: 8246 Comm: syz-executor.0 Not tainted 6.4.0-rc7-syzkaller-ge40939bbfc68 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0xfc/0x148 lib/ubsan.c:348
 folio_batch_add include/linux/pagevec.h:126 [inline]
 find_lock_entries+0x8fc/0xd84 mm/filemap.c:2127
 truncate_inode_pages_range+0x1b0/0xf74 mm/truncate.c:364
 truncate_inode_pages mm/truncate.c:449 [inline]
 truncate_inode_pages_final+0x90/0xc0 mm/truncate.c:484
 ntfs_evict_inode+0x20/0x48 fs/ntfs3/inode.c:1791
 evict+0x260/0x68c fs/inode.c:665
 iput_final fs/inode.c:1747 [inline]
 iput+0x734/0x818 fs/inode.c:1773
 ntfs_fill_super+0x327c/0x3990 fs/ntfs3/super.c:1267
 get_tree_bdev+0x360/0x54c fs/super.c:1303
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1455
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
