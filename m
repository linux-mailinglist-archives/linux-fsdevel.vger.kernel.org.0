Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7188D74A3B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 20:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjGFSZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 14:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGFSZ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:25:58 -0400
Received: from mail-pj1-f79.google.com (mail-pj1-f79.google.com [209.85.216.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C463B1BF8
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 11:25:45 -0700 (PDT)
Received: by mail-pj1-f79.google.com with SMTP id 98e67ed59e1d1-262d296873aso1718112a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jul 2023 11:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688667945; x=1691259945;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OZzgEZl6/g7psZ0E4d9jCKRJiroc9+4BEHoe0FwqD0A=;
        b=kw+vs5vo0LiU/L4V20Z3QtyIDU5xRXS60jWX3zhjDGcziSI0QWssjxhrq6aOvjfX+s
         OveKeUG9o/Lqph58hLP5b+fpVpW8T+v8L2Vxn5GeHoIFGGjJk/KXnnU/KyzByCPCvzg8
         OLPtpOFg29WLxjXhSRTf1cLr12MKoHi3m+dqRhzrV0hbAqyFFh3ebWoSvRzByjmnQxWm
         dFMtwjMTqF+/3CpfupQzY0omCh7Oj91nS24+I5M2COfPYKP8jdI/I5JyZ4XKyBhN5NEI
         C2YfzAi5vuF4HN7FnS7+IfGKVfpHjH5WaQ+2qR5vkAkcrVmsDEzjMiaC8cmAOQW0U3yf
         oTtQ==
X-Gm-Message-State: ABy/qLaB1eapjuVWEyj9U9ojaIp/OWHcQ2EJhCAlN2KzXHcaTHcam1ql
        pYw1AIu885QqzSLZzPSxziVT66eWWjnHO+jwKG/KOrwJJbkY
X-Google-Smtp-Source: APBJJlERvrpoZOMihfbOTAEJysCghlB1JQkU8loiCXpqc2u7eML+so9n5tmRY1ZNli1dxl9JKH9Jdyj8VD5cudXSRC/XpN2FqPEo
MIME-Version: 1.0
X-Received: by 2002:a17:90b:1215:b0:263:347:25b3 with SMTP id
 gl21-20020a17090b121500b00263034725b3mr2029757pjb.6.1688667944984; Thu, 06
 Jul 2023 11:25:44 -0700 (PDT)
Date:   Thu, 06 Jul 2023 11:25:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000126ec05ffd5a528@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_enable_quotas
From:   syzbot <syzbot+693985588d7a5e439483@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    995b406c7e97 Merge tag 'csky-for-linus-6.5' of https://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15fdda4f280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71a52faf60231bc7
dashboard link: https://syzkaller.appspot.com/bug?extid=693985588d7a5e439483
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/01122b567c73/disk-995b406c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75b7a37e981e/vmlinux-995b406c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/758b5afcf092/bzImage-995b406c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+693985588d7a5e439483@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/super.c:7010!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 27977 Comm: syz-executor.2 Not tainted 6.4.0-syzkaller-10098-g995b406c7e97 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:ext4_quota_enable fs/ext4/super.c:7010 [inline]
RIP: 0010:ext4_enable_quotas+0xb7a/0xb90 fs/ext4/super.c:7057
Code: ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 3a f7 ff ff 49 89 d6 48 89 df e8 03 10 99 ff 4c 89 f2 e9 27 f7 ff ff e8 46 60 40 ff <0f> 0b e8 3f 60 40 ff 0f 0b e8 18 6e 6e 08 0f 1f 84 00 00 00 00 00
RSP: 0018:ffffc9000392f880 EFLAGS: 00010293
RAX: ffffffff824b91aa RBX: 0000000000000000 RCX: ffff88803c1d8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000392fa50 R08: ffffffff824b8aa4 R09: 1ffff11010674957
R10: dffffc0000000000 R11: ffffed1010674958 R12: 0000000000000001
R13: 0000000000000000 R14: ffff88807f545464 R15: dffffc0000000000
FS:  00007f5112313700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002007f000 CR3: 000000002cb28000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __ext4_fill_super fs/ext4/super.c:5562 [inline]
 ext4_fill_super+0x6157/0x6ce0 fs/ext4/super.c:5696
 get_tree_bdev+0x468/0x6c0 fs/super.c:1318
 vfs_get_tree+0x8c/0x270 fs/super.c:1519
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f511168d8ba
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5112312f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000000005d8 RCX: 00007f511168d8ba
RDX: 0000000020000580 RSI: 00000000200005c0 RDI: 00007f5112312fe0
RBP: 00007f5112313020 R08: 00007f5112313020 R09: 0000000001008002
R10: 0000000001008002 R11: 0000000000000202 R12: 0000000020000580
R13: 00000000200005c0 R14: 00007f5112312fe0 R15: 0000000020000100
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_quota_enable fs/ext4/super.c:7010 [inline]
RIP: 0010:ext4_enable_quotas+0xb7a/0xb90 fs/ext4/super.c:7057
Code: ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 3a f7 ff ff 49 89 d6 48 89 df e8 03 10 99 ff 4c 89 f2 e9 27 f7 ff ff e8 46 60 40 ff <0f> 0b e8 3f 60 40 ff 0f 0b e8 18 6e 6e 08 0f 1f 84 00 00 00 00 00
RSP: 0018:ffffc9000392f880 EFLAGS: 00010293
RAX: ffffffff824b91aa RBX: 0000000000000000 RCX: ffff88803c1d8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000392fa50 R08: ffffffff824b8aa4 R09: 1ffff11010674957
R10: dffffc0000000000 R11: ffffed1010674958 R12: 0000000000000001
R13: 0000000000000000 R14: ffff88807f545464 R15: dffffc0000000000
FS:  00007f5112313700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2d324000 CR3: 000000002cb28000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
