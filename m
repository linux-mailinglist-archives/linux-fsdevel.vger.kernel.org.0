Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BA1717B35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 11:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbjEaJHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbjEaJGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 05:06:53 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F41910CA
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 02:06:24 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7775dd6c7e1so95634139f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 02:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685523962; x=1688115962;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T45iOmfHCb/6zwzKz2XNzeL9kK7kDd8L12clG6idG8k=;
        b=Kr74U5vkHWY8UdI5kxBSEJUgr6VyLk3mWVPwP5qoIWVstmRJO3u6AK9Cmjd3lqvd3M
         V0wuvOjzYOrqOvhW/RJiB8MLqN6fznuWPLxYGnsh5TYW+jyKu3as325YZTN/mJGbOqhe
         yPQYlWM+2+WkX2vNOvxGlt/dfx5AM1TKcJGNl0C9Hu6oLpm2XLsj+KrLxPDBwB3UMPad
         WqdLKAWVpKyZhzX1EsuN+3JgDRoID2yk/ducUymy0WNu3Jeo5bH8IA/rdCMuD6bObPve
         5sS6Wy9eZ15oJbdo5uXslOSX8ovixJYKm3tbGb9KteJICrDNp3Hq0WKBrIFyIczz9bFf
         ywTA==
X-Gm-Message-State: AC+VfDyw/J++vyoE+SjUkhsDvguPwe7MEGeENP9v1+dRp9LV6WkBFx1C
        LBHXdXyImoBSetI8suGaIzcL7agYoaeS3mrgn6EyBQP7gcl9
X-Google-Smtp-Source: ACHHUZ6WXd5dFW0aam0p1D4QQMkpELgQIiOkkaF2nPvXf8qnOrcWVYs41w2tGnB3oOrIXvg79B3kUZJdhE30tSdASdoL06/6gd+z
MIME-Version: 1.0
X-Received: by 2002:a02:a1c6:0:b0:41a:c5e3:6bf4 with SMTP id
 o6-20020a02a1c6000000b0041ac5e36bf4mr2225787jah.6.1685523962002; Wed, 31 May
 2023 02:06:02 -0700 (PDT)
Date:   Wed, 31 May 2023 02:06:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000424f205fcf9a132@google.com>
Subject: [syzbot] [ntfs?] UBSAN: shift-out-of-bounds in ntfs_iget
From:   syzbot <syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
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

HEAD commit:    afead42fdfca Merge tag 'perf-tools-fixes-for-v6.4-2-2023-0..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15f72e49280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=162cf2103e4a7453
dashboard link: https://syzkaller.appspot.com/bug?extid=4768a8f039aa677897d0
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12da9bbd280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174e8115280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/376b8e00429d/disk-afead42f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ac81705ce028/vmlinux-afead42f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/70c52b82e56a/bzImage-afead42f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/248748d7ce8e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com

ntfs: (device loop0): ntfs_attr_find(): Inode is corrupt.  Run chkdsk.
ntfs: (device loop0): ntfs_read_locked_inode(): Failed to lookup $DATA attribute.
ntfs: (device loop0): ntfs_read_locked_inode(): Failed with error code -5.  Marking corrupt inode 0x1 as bad.  Run chkdsk.
ntfs: (device loop0): load_system_files(): Failed to load $MFTMirr.  Mounting read-only.  Run ntfsfix and/or chkdsk.
================================================================================
UBSAN: shift-out-of-bounds in fs/ntfs/inode.c:1080:43
shift exponent 44 is too large for 32-bit type 'unsigned int'
CPU: 0 PID: 5000 Comm: syz-executor185 Not tainted 6.4.0-rc4-syzkaller-00047-gafead42fdfca #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c3/0x420 lib/ubsan.c:387
 ntfs_read_locked_inode+0x4665/0x49c0 fs/ntfs/inode.c:1080
 ntfs_iget+0x113/0x190 fs/ntfs/inode.c:177
 load_and_init_upcase fs/ntfs/super.c:1663 [inline]
 load_system_files+0x151c/0x4840 fs/ntfs/super.c:1818
 ntfs_fill_super+0x19b3/0x2bd0 fs/ntfs/super.c:2900
 mount_bdev+0x2d0/0x3f0 fs/super.c:1380
 legacy_get_tree+0xef/0x190 fs/fs_context.c:610
 vfs_get_tree+0x8c/0x270 fs/super.c:1510
 do_new_mount+0x28f/0xae0 fs/namespace.c:3039
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f183b0f1afa
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd7f357638 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f183b0f1afa
RDX: 0000000020000000 RSI: 000000002001ee80 RDI: 00007ffd7f357650
RBP: 00007ffd7f357650 R08: 00007ffd7f357690 R09: 000000000001ee62
R10: 0000000000000010 R11: 0000000000000286 R12: 0000000000000004
R13: 0000555555d422c0 R14: 0000000000000010 R15: 00007ffd7f357690
 </TASK>
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
