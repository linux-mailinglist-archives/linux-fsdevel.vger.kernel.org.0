Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210E17BAAA5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 21:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjJETsB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 15:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJETsA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:48:00 -0400
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D198DDE
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 12:47:58 -0700 (PDT)
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-6c6370774e8so1849883a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Oct 2023 12:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696535278; x=1697140078;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+rJYWdpX39fnELsnaA+2kd6nQscj6bBDfjIPgrB9Ju0=;
        b=wlCcJ1deMt6Bw6bTBLMBei8pmJ6DjqT3Geoh55ZPHZuziud9phGy5Eu8CA7rzZqw9n
         +/GtVhr9RwfHvi2vjC+vT8lQbEUK4eMYCjbtlPN+ffnLQ3IAFyfO+U7hffhiEFIekQie
         Ag/Pbs/2E4s4kBnoJakXuhN2xgIV5AWitKo27w7bhzcqIBFfJ0q2o/teGu9kvQ3fU9TT
         U0roj8CuBXMeaB4XUQqSt4WyfLd7DZQKGBksrpqXIncbE+D3Or+eB+/cAaSEvqBUS20O
         0Gi82i/CIKkfq5to1As7Dg8BJW/hvgwZZBtjNQmmtHmXT+J3gAemBofZHete+kWQTNdj
         ZU7A==
X-Gm-Message-State: AOJu0YyuV4TEgOg6hxbVQ7u3cN+2qLEXWXl7uIrzss6gvBNchA7XoeSW
        ZcaF2aUr+wK49AIONPWZKuJMgXp1uVhdDWTn3qwrUtau68rl
X-Google-Smtp-Source: AGHT+IFUijQ5HWSsoSG3N0LC7VwaXmm+icbh/NGey9Tl9HOTXcuEWtAJ9WROrzOwSqClh5RBXfvO6mNgx1M4GTSql85R+ljbkhRO
MIME-Version: 1.0
X-Received: by 2002:a9d:7dcf:0:b0:6c4:7e6c:cb4e with SMTP id
 k15-20020a9d7dcf000000b006c47e6ccb4emr1782895otn.5.1696535278207; Thu, 05 Oct
 2023 12:47:58 -0700 (PDT)
Date:   Thu, 05 Oct 2023 12:47:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b49ce0606fd665a@google.com>
Subject: [syzbot] [ntfs3?] WARNING in attr_data_get_block (3)
From:   syzbot <syzbot+a9850b21d99643eadbb8@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        clang-built-linux@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e402b08634b3 Merge tag 'soc-fixes-6.6' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=111e0d01680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12da82ece7bf46f9
dashboard link: https://syzkaller.appspot.com/bug?extid=a9850b21d99643eadbb8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b684e6680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ede4d6680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/41cd2d7ae4a2/disk-e402b086.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/06c5c0caa862/vmlinux-e402b086.xz
kernel image: https://storage.googleapis.com/syzbot-assets/483b777ed71c/bzImage-e402b086.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/f17ff5020b6d/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/6aff89451d15/mount_2.gz

The issue was bisected to:

commit 6e5be40d32fb1907285277c02e74493ed43d77fe
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Aug 13 14:21:30 2021 +0000

    fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f20a7c680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17f20a7c680000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f20a7c680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a9850b21d99643eadbb8@syzkaller.appspotmail.com
Fixes: 6e5be40d32fb ("fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5033 at fs/ntfs3/attrib.c:1059 attr_data_get_block+0x1926/0x2da0
Modules linked in:
CPU: 1 PID: 5033 Comm: syz-executor106 Not tainted 6.6.0-rc3-syzkaller-00214-ge402b08634b3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:attr_data_get_block+0x1926/0x2da0 fs/ntfs3/attrib.c:1059
Code: 80 e1 07 80 c1 03 38 c1 0f 8c 48 ff ff ff 48 8d bc 24 e0 01 00 00 e8 19 74 18 ff 48 8b 54 24 58 e9 31 ff ff ff e8 ba 01 be fe <0f> 0b bb ea ff ff ff e9 11 fa ff ff e8 a9 01 be fe e9 0f f9 ff ff
RSP: 0018:ffffc9000406f6a0 EFLAGS: 00010293
RAX: ffffffff82d008b6 RBX: 00000000ffffffff RCX: ffff888025380000
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000ffffffff
RBP: ffffc9000406f908 R08: ffffffff82d0038f R09: 1ffffffff20df689
R10: dffffc0000000000 R11: fffffbfff20df68a R12: 1ffff9200080def4
R13: 000000000000001c R14: ffff888076620140 R15: dffffc0000000000
FS:  00007f36f9b9c6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f36f9b9cd58 CR3: 0000000026956000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ntfs_fallocate+0xc6d/0x1100 fs/ntfs3/file.c:610
 vfs_fallocate+0x551/0x6b0 fs/open.c:324
 do_vfs_ioctl+0x22da/0x2b40 fs/ioctl.c:850
 __do_sys_ioctl fs/ioctl.c:869 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f37091ff5a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f36f9b9c218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000003f RCX: 00007f37091ff5a9
RDX: 0000000020000780 RSI: 0000000040305828 RDI: 0000000000000004
RBP: 00007f37092aa6d8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f37092aa6d0
R13: 00007f3709277a14 R14: 726665646f747561 R15: 61635f6563617073
 </TASK>


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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
