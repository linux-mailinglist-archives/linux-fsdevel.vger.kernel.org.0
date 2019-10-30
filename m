Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD9EE9616
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 06:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfJ3FcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 01:32:09 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:56197 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfJ3FcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 01:32:09 -0400
Received: by mail-il1-f197.google.com with SMTP id n81so1065230ili.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2019 22:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mbTIn03M48tLQ3Ae3NFBVUq/hfQBC8WrnQ5NE/Xg208=;
        b=U2dzJBrM0u8u9Ad4cNMB5OfgH0VvmXcye/I+OQz+YQViHijh4RucxudMuBwchAg/R6
         W3SgdGjUpjdNgAs0Nh1tmt4nQVUO2qhNyEh04KPKl+fymJIXdxpI75Ndha+WAId/KeLb
         DB6KLH4AIC3gXTmFwH7DPEjbKdCKJGfQ1E+3cshXDsRVUMxCbOtAgSXtWd2e8i9vKVB8
         9HXd5xNTxu7uQeiWw0W9l28fh3aJTjo6gyJhZjK6+QDGlHTzdUG7v86vSHTdXPVZzKS6
         WlhA++IaS04NFW/v7/LIFS+IKC00ExEQR5gxvEj/PeEEXx5LowXDFbH7kaSPgxa0byfz
         6VlQ==
X-Gm-Message-State: APjAAAXg2+conVNyGSZ0LnW7lmsNmkveufrg5Y+rYbr51sT5EyRtrkaw
        WU049hIH6rFohdE7Fqdxr0nBhlEfW9NGBBy2OEZAksABE0+1
X-Google-Smtp-Source: APXvYqx18oKmF/BSsIkvWFJj4i4V9vr7G/Bknv+KRm5J3e6SMSZP3B8etPPoqOn8D0S7nfK4MHVieihGsTrQatA/SpcuGAK22Cnk
MIME-Version: 1.0
X-Received: by 2002:a92:9c94:: with SMTP id x20mr29794180ill.149.1572413528010;
 Tue, 29 Oct 2019 22:32:08 -0700 (PDT)
Date:   Tue, 29 Oct 2019 22:32:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6fb2a05961a0dd8@google.com>
Subject: BUG: unable to handle kernel paging request in io_wq_cancel_all
From:   syzbot <syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c57cf383 Add linux-next specific files for 20191029
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=161e9e04e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb86688f30db053d
dashboard link: https://syzkaller.appspot.com/bug?extid=221cc24572a2fed23b6b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168671d4e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140f4898e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffffc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8856 Comm: syz-executor355 Not tainted 5.4.0-rc5-next-20191029  
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:92 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:109 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:135 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:166 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:182 [inline]
RIP: 0010:check_memory_region+0x123/0x1a0 mm/kasan/generic.c:192
Code: 49 89 d9 49 29 c1 e9 68 ff ff ff 5b b8 01 00 00 00 41 5c 41 5d 5d c3  
4d 85 c9 74 ef 4d 01 e1 eb 09 48 83 c0 01 4c 39 c8 74 e1 <80> 38 00 74 f2  
eb 8c 4d 39 c2 74 4d e8 8c e4 ff ff 31 c0 5b 41 5c
RSP: 0018:ffff888090717b30 EFLAGS: 00010216
RAX: fffffc0000000000 RBX: dffffc0000000001 RCX: ffffffff81d256a8
RDX: 0000000000000001 RSI: 0000000000000008 RDI: fffffffffffffffc
RBP: ffff888090717b48 R08: 1fffffffffffffff R09: dffffc0000000001
R10: dffffc0000000000 R11: 0000000000000003 R12: fffffbffffffffff
R13: ffff8880a0f685c0 R14: ffff8880a4146458 R15: 0000000000000000
FS:  0000000001f6c880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffc0000000000 CR3: 00000000a0083000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __kasan_check_write+0x14/0x20 mm/kasan/common.c:98
  set_bit include/asm-generic/bitops-instrumented.h:28 [inline]
  io_wq_cancel_all+0x28/0x2a0 fs/io-wq.c:617
  io_uring_flush+0x35a/0x4e0 fs/io_uring.c:3936
  filp_close+0xbd/0x170 fs/open.c:1174
  close_files fs/file.c:388 [inline]
  put_files_struct fs/file.c:416 [inline]
  put_files_struct+0x1d7/0x2f0 fs/file.c:413
  exit_files+0x83/0xb0 fs/file.c:445
  do_exit+0x8d2/0x2e60 kernel/exit.c:812
  do_group_exit+0x135/0x360 kernel/exit.c:921
  __do_sys_exit_group kernel/exit.c:932 [inline]
  __se_sys_exit_group kernel/exit.c:930 [inline]
  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:930
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440018
Code: 00 00 be 3c 00 00 00 eb 19 66 0f 1f 84 00 00 00 00 00 48 89 d7 89 f0  
0f 05 48 3d 00 f0 ff ff 77 21 f4 48 89 d7 44 89 c0 0f 05 <48> 3d 00 f0 ff  
ff 76 e0 f7 d8 64 41 89 01 eb d8 0f 1f 84 00 00 00
RSP: 002b:00007ffc5afbadb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440018
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004bfcf0 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d2180 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: fffffc0000000000
---[ end trace 3dc71453331dd723 ]---
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:92 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:109 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:135 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:166 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:182 [inline]
RIP: 0010:check_memory_region+0x123/0x1a0 mm/kasan/generic.c:192
Code: 49 89 d9 49 29 c1 e9 68 ff ff ff 5b b8 01 00 00 00 41 5c 41 5d 5d c3  
4d 85 c9 74 ef 4d 01 e1 eb 09 48 83 c0 01 4c 39 c8 74 e1 <80> 38 00 74 f2  
eb 8c 4d 39 c2 74 4d e8 8c e4 ff ff 31 c0 5b 41 5c
RSP: 0018:ffff888090717b30 EFLAGS: 00010216
RAX: fffffc0000000000 RBX: dffffc0000000001 RCX: ffffffff81d256a8
RDX: 0000000000000001 RSI: 0000000000000008 RDI: fffffffffffffffc
RBP: ffff888090717b48 R08: 1fffffffffffffff R09: dffffc0000000001
R10: dffffc0000000000 R11: 0000000000000003 R12: fffffbffffffffff
R13: ffff8880a0f685c0 R14: ffff8880a4146458 R15: 0000000000000000
FS:  0000000001f6c880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffc0000000000 CR3: 00000000a0083000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
