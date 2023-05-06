Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F856F8DB4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 03:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjEFBn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 21:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjEFBn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 21:43:58 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9E649E2
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 18:43:56 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3340a320b8bso11029955ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 May 2023 18:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683337436; x=1685929436;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEAVY+G+dyIbuZjjPxrcrCEx2E1ib4FojCVjLcKiTGM=;
        b=Ge0dJ7swgs3X+06K2MvSeATQFC3EsYonrLuwVDDfIoD4ltZKrbSl1CJtk4uNy42uCR
         /Hf4aNckHiT/LqLSnBXWsK0+Acvpl0K5qXDKlmQ6+ey+huaqRrDAipNRmxcGcwHM7RRP
         YCMFNKyby7dCHItroPte/w5AjGpmtUBEwK9drjh9pwpmIgHd/3fM9wpd3dUWThfEWsze
         YWuyDHBdMv55pE3qcTOz1DQdL2+yxCFWxmVxUjqrjErsXFOmLUDDsFpoERC8Cyvmx/IV
         Anv15xSYW6sc5rQAiEXe1ZypQlPAdj40PMKjqTiNfCFkFF39dBQaQDGFCgXZo6XPBimL
         2Q9A==
X-Gm-Message-State: AC+VfDy1jIY1RYoFMaoCLSemp6DVU2a+IxOYTkY55WaK3Z3b41XCEKLu
        Pq8pcuJf9FAGqJ7h7qt5gDbxKHQJHXuv92mmPuCv6CbcqahE
X-Google-Smtp-Source: ACHHUZ40r2kaXH+BdAcVW2IrF2fQz/wl0ztSgOji8xFrvl6Nr86JnqB8W8mKq8kyxy3Df6TYZbXqDfgrF5+Rb0GcYZGqsOqdPfSQ
MIME-Version: 1.0
X-Received: by 2002:a02:84c1:0:b0:40f:ae69:a144 with SMTP id
 f59-20020a0284c1000000b0040fae69a144mr1384969jai.5.1683337435893; Fri, 05 May
 2023 18:43:55 -0700 (PDT)
Date:   Fri, 05 May 2023 18:43:55 -0700
In-Reply-To: <000000000000725cab05f55f1bb0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7582c05fafc8901@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_exclop_balance (2)
From:   syzbot <syzbot+5e466383663438b99b44@syzkaller.appspotmail.com>
To:     chris@chrisdown.name, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    7163a2111f6c Merge tag 'acpi-6.4-rc1-3' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175bb84c280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73a06f6ef2d5b492
dashboard link: https://syzkaller.appspot.com/bug?extid=5e466383663438b99b44
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12048338280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ff7314280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/01051811f2fe/disk-7163a211.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a26c68e4c8a6/vmlinux-7163a211.xz
kernel image: https://storage.googleapis.com/syzbot-assets/17380fb8dad4/bzImage-7163a211.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b30a249e8609/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5e466383663438b99b44@syzkaller.appspotmail.com

assertion failed: fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED, in fs/btrfs/ioctl.c:463
------------[ cut here ]------------
kernel BUG at fs/btrfs/messages.c:259!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8630 Comm: syz-executor102 Not tainted 6.3.0-syzkaller-13225-g7163a2111f6c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:btrfs_assertfail+0x18/0x20 fs/btrfs/messages.c:259
Code: df e8 2c 05 36 f7 e9 50 fb ff ff e8 b2 90 01 00 66 90 66 0f 1f 00 89 d1 48 89 f2 48 89 fe 48 c7 c7 80 32 2c 8b e8 c8 60 ff ff <0f> 0b 66 0f 1f 44 00 00 66 0f 1f 00 53 48 89 fb e8 73 31 de f6 48
RSP: 0018:ffffc9000ae27e48 EFLAGS: 00010246
RAX: 0000000000000066 RBX: 1ffff1100fa13c18 RCX: e812ce05a9b3c300
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffffff816f0fec R09: fffff520015c4f7d
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88807d09e0c0
R13: ffff88807d09c000 R14: ffff88807d09c678 R15: dffffc0000000000
FS:  00007f2bb10a8700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2bb0c90000 CR3: 0000000028447000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_exclop_balance+0x153/0x1f0 fs/btrfs/ioctl.c:463
 btrfs_ioctl_balance+0x482/0x7c0 fs/btrfs/ioctl.c:3562
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2bb853ec69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2bb10a82f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2bb85c87c0 RCX: 00007f2bb853ec69
RDX: 0000000020000540 RSI: 00000000c4009420 RDI: 0000000000000004
RBP: 00007f2bb85951d0 R08: 00007f2bb10a8700 R09: 0000000000000000
R10: 00007f2bb10a8700 R11: 0000000000000246 R12: 7fffffffffffffff
R13: 0000000100000001 R14: 8000000000000001 R15: 00007f2bb85c87c8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_assertfail+0x18/0x20 fs/btrfs/messages.c:259
Code: df e8 2c 05 36 f7 e9 50 fb ff ff e8 b2 90 01 00 66 90 66 0f 1f 00 89 d1 48 89 f2 48 89 fe 48 c7 c7 80 32 2c 8b e8 c8 60 ff ff <0f> 0b 66 0f 1f 44 00 00 66 0f 1f 00 53 48 89 fb e8 73 31 de f6 48
RSP: 0018:ffffc9000ae27e48 EFLAGS: 00010246
RAX: 0000000000000066 RBX: 1ffff1100fa13c18 RCX: e812ce05a9b3c300
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffffff816f0fec R09: fffff520015c4f7d
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88807d09e0c0
R13: ffff88807d09c000 R14: ffff88807d09c678 R15: dffffc0000000000
FS:  00007f2bb10a8700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2bb0c90000 CR3: 0000000028447000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
