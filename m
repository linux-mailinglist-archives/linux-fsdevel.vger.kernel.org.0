Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5264321C823
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jul 2020 10:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgGLIoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jul 2020 04:44:19 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:48734 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgGLIoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jul 2020 04:44:18 -0400
Received: by mail-il1-f199.google.com with SMTP id q9so7230853ilt.15
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2020 01:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hNr1tIRlvbH20zaT/8dcl97UmNnkqXdA8xn65ajghas=;
        b=iFazHnGomuM1vx1UsKG9ZuOxg3p+qlHrdLgnf10FXyehrfcXqqel2QJnG9LLI9dP42
         K7GbnYa+0BxQ+BudluwAOBNQAORFCOw8w/psQjPuApw1jE1Fm5zOqnz/gDL3WWsYG3Aq
         danzzB2+3He1jpehZ1gAb/VeXVzHjKmkeBQKrUBLt334W61lBpDjd3/EoLNm3hJOmbXL
         Q7AAjoA8bGxFyOrprQelRx4KckTDUOTT7kzOgc1S4rHALQRbjALL7Y1v0OTGZ8J3QG8n
         XsuRbD/jU8uiURnZOw9AOZhq2FF9RKQ4pidJfCJXpVr7rvnYAZNGmwbkyQNBu5XGr5vt
         cNgw==
X-Gm-Message-State: AOAM531s8QwFkwLPZHTasOHQd9BORItgbKd3e3tfDFSmk5d6ZnoYizeo
        1iFdsyDE678Y0YkDaJcOhK1eEwqm8tx8Eq65otE8ll6wLBg/
X-Google-Smtp-Source: ABdhPJwkGhN2zTd+VnNCjMQ/aUmDoI4F0/coh3xZ0ddSMc0fv2nrT/LNkwAlbZj2Zk5PvNbTbuplIIDPg1K6yUtPrrbaV2gquIrw
MIME-Version: 1.0
X-Received: by 2002:a6b:c80a:: with SMTP id y10mr55355839iof.67.1594543457754;
 Sun, 12 Jul 2020 01:44:17 -0700 (PDT)
Date:   Sun, 12 Jul 2020 01:44:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060e43005aa3a9476@google.com>
Subject: KMSAN: uninit-value in path_openat
From:   syzbot <syzbot+4191a44ad556eacc1a7a@syzkaller.appspotmail.com>
To:     glider@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f0d5ec90 kmsan: apply __no_sanitize_memory to dotraplinkag..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=159636b7100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86e4f8af239686c6
dashboard link: https://syzkaller.appspot.com/bug?extid=4191a44ad556eacc1a7a
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1073c0bd100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13974b2f100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4191a44ad556eacc1a7a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in may_create_in_sticky fs/namei.c:1060 [inline]
BUG: KMSAN: uninit-value in do_open fs/namei.c:3207 [inline]
BUG: KMSAN: uninit-value in path_openat+0x48be/0x5d50 fs/namei.c:3346
CPU: 1 PID: 8815 Comm: syz-executor333 Not tainted 5.7.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 may_create_in_sticky fs/namei.c:1060 [inline]
 do_open fs/namei.c:3207 [inline]
 path_openat+0x48be/0x5d50 fs/namei.c:3346
 do_file_open_root+0x469/0xb40 fs/namei.c:3401
 file_open_root+0x6f1/0x760 fs/open.c:1128
 do_handle_open+0xa11/0xe30 fs/fhandle.c:232
 __do_compat_sys_open_by_handle_at fs/fhandle.c:277 [inline]
 __se_compat_sys_open_by_handle_at+0x8e/0xa0 fs/fhandle.c:274
 __ia32_compat_sys_open_by_handle_at+0x4a/0x70 fs/fhandle.c:274
 do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
 do_fast_syscall_32+0x3bf/0x6d0 arch/x86/entry/common.c:398
 entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f3bdd9
Code: 90 e8 0b 00 00 00 f3 90 0f ae e8 eb f9 8d 74 26 00 89 3c 24 c3 90 90 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ff8507fc EFLAGS: 00000207 ORIG_RAX: 0000000000000156
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 0000000020000200
RDX: 0000000000002f40 RSI: 0000000000000001 RDI: 00000000080bb4c8
RBP: 0000000000000012 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Local variable ----nd@do_file_open_root created at:
 do_file_open_root+0xa4/0xb40 fs/namei.c:3385
 do_file_open_root+0xa4/0xb40 fs/namei.c:3385
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
