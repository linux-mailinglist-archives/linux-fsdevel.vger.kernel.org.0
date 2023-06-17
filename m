Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E1E734085
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 13:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjFQLXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jun 2023 07:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjFQLXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jun 2023 07:23:01 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003CBAF
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jun 2023 04:22:59 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-34128d59c06so15604625ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jun 2023 04:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687000979; x=1689592979;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=976nUGLA1eLtjJZopusDJfTHe5lySN1BOdO4t8e0GJk=;
        b=QmVEsSU37Zcq3mREfWqisUXPU1jNd5lmbf1mlPVaSVhzBsQYveMgKhEgaogQlMRy4B
         +5qyg1MckxBB8mGKzD5vkODsoKSAv3nEEZm0aY3D+Tj0A3GiFAXGHVXpCfFLPFj2OGaI
         r7W22EYZE4mK+jHe/S/RnSq/4XUSbmvzmSPaUtyNxF+zDPa1f0Jbmi8sm3QFd0cSRoAr
         D7+zhO8pCEXKJhQDkWJQczJ4xCBEA9LJweoVNv9sQ0MQoZeZLeNAvx6SYVMBNMAGLpRk
         FnhiUCXX3OAA/pRcCksRusLys1gHyHIs0hyiUlpP0QOz4hV7A7i9rvO2QahoB2Hh3ur7
         wmOQ==
X-Gm-Message-State: AC+VfDyxoKiSk197z6nhuUIVHNpbE+zGEl36scWvEvicvMEaU4U1K2M2
        /DNIQmtzjxi02o192I2U3De3jNUvBpathvU6FyAPLIwouL1a
X-Google-Smtp-Source: ACHHUZ6CLGw8oS/wZoEcJyQld9KGJx/uFDIU4+qOLKL7d4cyna0ONvOkvR4DYF/bnu31XqwEYGY5azAOr3HIlcxp+U956QpN2ujo
MIME-Version: 1.0
X-Received: by 2002:a92:d650:0:b0:340:7430:2317 with SMTP id
 x16-20020a92d650000000b0034074302317mr1223035ilp.3.1687000979374; Sat, 17 Jun
 2023 04:22:59 -0700 (PDT)
Date:   Sat, 17 Jun 2023 04:22:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c8edb05fe518644@google.com>
Subject: [syzbot] [xfs?] UBSAN: array-index-out-of-bounds in xfs_attr3_leaf_add_work
From:   syzbot <syzbot+510dcbdc6befa1e6b2f6@syzkaller.appspotmail.com>
To:     djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
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

HEAD commit:    1f6ce8392d6f Add linux-next specific files for 20230613
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14e629dd280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d103d5f9125e9fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=510dcbdc6befa1e6b2f6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139d8d2d280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b371f1280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2d9bf45aeae9/disk-1f6ce839.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e0b03ef83e17/vmlinux-1f6ce839.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b6c21a24174d/bzImage-1f6ce839.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/65eca6891c21/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+510dcbdc6befa1e6b2f6@syzkaller.appspotmail.com

XFS (loop0): Mounting V4 Filesystem 5e6273b8-2167-42bb-911b-418aa14a1261
XFS (loop0): Ending clean mount
xfs filesystem being mounted at /root/file0 supports timestamps until 2038-01-19 (0x7fffffff)
================================================================================
UBSAN: array-index-out-of-bounds in fs/xfs/libxfs/xfs_attr_leaf.c:1560:3
index 14 is out of range for type '__u8 [1]'
CPU: 1 PID: 5021 Comm: syz-executor198 Not tainted 6.4.0-rc6-next-20230613-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0xd5/0x140 lib/ubsan.c:348
 xfs_attr3_leaf_add_work+0x1528/0x1730 fs/xfs/libxfs/xfs_attr_leaf.c:1560
 xfs_attr3_leaf_add+0x750/0x880 fs/xfs/libxfs/xfs_attr_leaf.c:1438
 xfs_attr_leaf_try_add+0x1b7/0x660 fs/xfs/libxfs/xfs_attr.c:1242
 xfs_attr_leaf_addname fs/xfs/libxfs/xfs_attr.c:444 [inline]
 xfs_attr_set_iter+0x16c4/0x2f90 fs/xfs/libxfs/xfs_attr.c:721
 xfs_xattri_finish_update+0x3c/0x140 fs/xfs/xfs_attr_item.c:332
 xfs_attr_finish_item+0x6d/0x280 fs/xfs/xfs_attr_item.c:463
 xfs_defer_finish_one fs/xfs/libxfs/xfs_defer.c:481 [inline]
 xfs_defer_finish_noroll+0x93b/0x1f20 fs/xfs/libxfs/xfs_defer.c:565
 __xfs_trans_commit+0x566/0xe20 fs/xfs/xfs_trans.c:972
 xfs_attr_set+0x12e5/0x2220 fs/xfs/libxfs/xfs_attr.c:1083
 xfs_attr_change fs/xfs/xfs_xattr.c:106 [inline]
 xfs_xattr_set+0xf2/0x1c0 fs/xfs/xfs_xattr.c:151
 __vfs_setxattr+0x173/0x1e0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x129/0x5f0 fs/xattr.c:235
 __vfs_setxattr_locked+0x1d3/0x260 fs/xattr.c:296
 vfs_setxattr+0x143/0x340 fs/xattr.c:322
 do_setxattr+0x147/0x190 fs/xattr.c:630
 setxattr+0x146/0x160 fs/xattr.c:653
 path_setxattr+0x197/0x1c0 fs/xattr.c:672
 __do_sys_setxattr fs/xattr.c:688 [inline]
 __se_sys_setxattr fs/xattr.c:684 [inline]
 __x64_sys_setxattr+0xc4/0x160 fs/xattr.c:684
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9effd537f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc33918058 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f9effd537f9
RDX: 0000000020000680 RSI: 0000000020000200 RDI: 0000000020000000
RBP: 00007f9effd13090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000058 R11: 0000000000000246 R12: 00007f9effd13120
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
