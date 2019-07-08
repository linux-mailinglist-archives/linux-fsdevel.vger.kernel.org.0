Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C586242D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 17:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388976AbfGHP1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 11:27:09 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:35997 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388494AbfGHP1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:27:07 -0400
Received: by mail-io1-f71.google.com with SMTP id k21so19418660ioj.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2019 08:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3nI8UbSCiooQf96iEA6wfjiUATlcUVGksrHHHOQhhhs=;
        b=GrICsouaCCDTG4OMHdVRa1WvOTXXh5aRVwzBzK/ETfPk6ZvbCdD2vsgBC+z4BZsfVu
         3nACMhF6CX882orftIjaKSL4nUbHwpxHOmExYsm8k8/Mhezsw6NjFT4gnLRE5Q7zHQb9
         B4oWyLRZDdE9XuXAjmYUPwKPVDcybHeXm9B/T7PTQZd6MCloupkr4h59px8wAEPctL3S
         nF5hfcHCgBT1bi8+hQQd6iVLuL6mz4pKleTqZQVvOebhbxIK1n8LtKfJlPGjJ8aiMIhw
         MUgCRmC/eN0ntp/WXdf+dAw9noFd3KoGovOj0mMYgKNgx6l+8ZtC6IyYG9IDKFNwK83g
         i5+Q==
X-Gm-Message-State: APjAAAVpJYFoqfjzjIwUnryVvAgaHg12uQ4urG3SQ3tdfeEhfAH2ppuw
        BqUoiZxfz9CNCNa6QvWDr9tuJfTd6xksJ/tZs6L/WU3OvwpP
X-Google-Smtp-Source: APXvYqycAClhmc4W0ti+D9tCXsNSD9MBYwivSwqYPI1u7OpcYY3vXDxVd8tgt++cGt0IhLdRDc+zw5sPnC7pY0b56WN6EB5QWVnz
MIME-Version: 1.0
X-Received: by 2002:a5d:8ad0:: with SMTP id e16mr14295286iot.262.1562599626231;
 Mon, 08 Jul 2019 08:27:06 -0700 (PDT)
Date:   Mon, 08 Jul 2019 08:27:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5d738058d2d1396@google.com>
Subject: WARNING in __mark_chain_precision
From:   syzbot <syzbot+4da3ff23081bafe74fc2@syzkaller.appspotmail.com>
To:     ast@kernel.org, bcrl@kvack.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        jakub.kicinski@netronome.com, john.fastabend@gmail.com,
        kafai@fb.com, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        xdp-newbies@vger.kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e5a3e259 Merge branch 'bpf-tcp-rtt-hook'
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14190c2da00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd16b8dc9d0d210c
dashboard link: https://syzkaller.appspot.com/bug?extid=4da3ff23081bafe74fc2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1409ce0da00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17226a0da00000

The bug was bisected to:

commit b53119f13a04879c3bf502828d99d13726639ead
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Mar 7 01:22:54 2019 +0000

     pin iocb through aio.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11427b8ba00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13427b8ba00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15427b8ba00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4da3ff23081bafe74fc2@syzkaller.appspotmail.com
Fixes: b53119f13a04 ("pin iocb through aio.")

------------[ cut here ]------------
verifier backtracking bug
WARNING: CPU: 0 PID: 9104 at kernel/bpf/verifier.c:1785  
__mark_chain_precision+0x19bb/0x1ee0 kernel/bpf/verifier.c:1785
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 9104 Comm: syz-executor284 Not tainted 5.2.0-rc5+ #34
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x744 kernel/panic.c:219
  __warn.cold+0x20/0x4d kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:__mark_chain_precision+0x19bb/0x1ee0 kernel/bpf/verifier.c:1785
Code: 08 31 ff 89 de e8 95 ba f2 ff 84 db 0f 85 ce fe ff ff e8 48 b9 f2 ff  
48 c7 c7 e0 44 91 87 c6 05 1c 15 1f 08 01 e8 03 f1 c4 ff <0f> 0b 41 bc f2  
ff ff ff e9 af fe ff ff e8 d3 3c 2c 00 e9 c2 e7 ff
RSP: 0018:ffff88809f04f380 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815ad926 RDI: ffffed1013e09e62
RBP: ffff88809f04f4d0 R08: ffff88809987a540 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88809af0c280 R14: 0000000000000001 R15: ffff88809f65cb00
  mark_chain_precision kernel/bpf/verifier.c:1822 [inline]
  check_cond_jmp_op+0xcd8/0x3c30 kernel/bpf/verifier.c:5842
  do_check+0x60f4/0x8a20 kernel/bpf/verifier.c:7782
  bpf_check+0x6f99/0x9950 kernel/bpf/verifier.c:9293
  bpf_prog_load+0xe68/0x1670 kernel/bpf/syscall.c:1698
  __do_sys_bpf+0xa20/0x42d0 kernel/bpf/syscall.c:2849
  __se_sys_bpf kernel/bpf/syscall.c:2808 [inline]
  __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:2808
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440369
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffca85a2fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440369
RDX: 0000000000000048 RSI: 0000000020000200 RDI: 0000000000000005
RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000401bf0
R13: 0000000000401c80 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
