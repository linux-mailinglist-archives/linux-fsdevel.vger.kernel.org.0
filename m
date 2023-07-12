Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8590F7509F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 15:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjGLNrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 09:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGLNrp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:47:45 -0400
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A668E4D
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 06:47:44 -0700 (PDT)
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-6b86d2075f0so7863091a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 06:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689169663; x=1691761663;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mCE24WH1lXYovXM2HlQwa6eWQaAUVS64bXOvqxEQpY4=;
        b=DZ6Ez+jXdLHBtNSNES3hZvDm/yQ3XxoL6Mya+TUkYabu5U0nINP5ILs9axpNL4Xgmd
         jKbxTdk/ZoMFzcTvWlVrN/AM0iYPbFeM796UiQaXg4N6Mv8g5uxPQkWRQq70aQsI9/4g
         euJIY7uQAx1gQ6i8qzakLUoDaf1FiEqAC0KbImJ5NVHOYBqqzHALytNsUKnBNDrsxd8R
         Sf1rKYfHQqoOYiyOO1XVPtw2KfK06ttgtDuHzKnW1CdcA/WVKS2/DVRckN5ZIxwlK0B3
         MdddKJ39/5j2fYRUwPppYe3JE2WG53wCdTUfwdi8E/3aJa6X9A2eQqOn2lO0VwnUq97b
         7cTw==
X-Gm-Message-State: ABy/qLbK8kDEX1ZIdjoQ85FSNRdrerHeBsHTGf53xTrQoc/v/uBY4RFd
        j8nrdwCI9HOjan2FKqv0oNcOXwfJ9GwlVnyeCPvCmPOFQ/sXdFIOVA==
X-Google-Smtp-Source: APBJJlH9s57jWiu6UVP1IhbEXg3Hau7HP6SyHnNysmfNUoVjs3wLM7tk+MkqW/eJgAftrFSnDTd/G9m3jG+DXngBUzrr1pe7hu4a
MIME-Version: 1.0
X-Received: by 2002:a9d:7348:0:b0:6b4:5ee1:a988 with SMTP id
 l8-20020a9d7348000000b006b45ee1a988mr5124318otk.5.1689169663529; Wed, 12 Jul
 2023 06:47:43 -0700 (PDT)
Date:   Wed, 12 Jul 2023 06:47:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c29dab06004a752b@google.com>
Subject: [syzbot] [fs?] UBSAN: shift-out-of-bounds in befs_check_sb
From:   syzbot <syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        luisbg@kernel.org, salah.triki@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1310fc5ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6c2f785de9e303f
dashboard link: https://syzkaller.appspot.com/bug?extid=fc26c366038b54261e53
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107f12e8a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174014a2a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/896ca272ae74/disk-3f01e9fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/deff7fbe3b2c/vmlinux-3f01e9fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca3863031cc5/bzImage-3f01e9fe.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9c7c5305480d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com

memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=5019 'syz-executor590'
loop0: detected capacity change from 0 to 128
================================================================================
UBSAN: shift-out-of-bounds in fs/befs/super.c:96:9
shift exponent 3229888891 is too large for 32-bit type 'int'
CPU: 0 PID: 5019 Comm: syz-executor590 Not tainted 6.5.0-rc1-syzkaller-00006-g3f01e9fed845 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x221/0x5a0 lib/ubsan.c:387
 befs_check_sb.cold+0x19/0x6f fs/befs/super.c:96
 befs_fill_super+0x9b5/0x1110 fs/befs/linuxvfs.c:873
 mount_bdev+0x315/0x3e0 fs/super.c:1391
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x8d/0x350 fs/super.c:1519
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x136e/0x1e70 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe1b84908ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd994dbc28 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd994dbc30 RCX: 00007fe1b84908ba
RDX: 0000000020000100 RSI: 0000000020009e40 RDI: 00007ffd994dbc30
RBP: 0000000000000004 R08: 00007ffd994dbc70 R09: 0000000000009e1f
R10: 0000000003008001 R11: 0000000000000282 R12: 00007ffd994dbc70
R13: 0000000000000003 R14: 0000000000010000 R15: 0000000000000001
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
