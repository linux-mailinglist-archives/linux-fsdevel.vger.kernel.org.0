Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27D22A4D53
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 18:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgKCRn2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 12:43:28 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:44713 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgKCRn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:43:28 -0500
Received: by mail-il1-f198.google.com with SMTP id s70so9734487ili.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 09:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3PbhNGIds7XOrD/2VjJDM9R8/om7poBeAPU/xJajmXA=;
        b=i5B2r2C+DXJ++DJeS5HbWMeFSgST51rh/Pp1NoIbvHzGv9155MNW9y6LHMVD6yge7g
         jLwZFNV1zMtyvV3trHeyhpDjoxeqBtbE7hmm20X3iRsQmzP0+cw3vwl+yFwY7lTROrNI
         xelHgc9egUgQ87BTDwJVES5N8pVmO2z6gz+KotzUm+t8N4YBWMKkBAmHfy9mRFtySi5E
         jqQ9vrfxYz+Aug+Oo6i729EZEXq6nDkZAxH0gFPWkQS8iVp+UBTx5r5YKY/TCAjjh3hR
         LNIXvxjwh7QR8L7RcS5WcoCOm9zfJJTi3orpGk6xrhWp9Vvgfjop5dg3k3Oz59suMfnv
         rSYw==
X-Gm-Message-State: AOAM533igroIKMka1x4Q5p3/j/Hpy/Cdj8k1aqwTC93di1KA2c32mpmF
        ao+zoYTgxdmW9gIdRa33n5NRqEvFUmZZUr55emu61wk9UyfF
X-Google-Smtp-Source: ABdhPJweEsMdDkQm/7IWQ1kYD0ypZOoNQxN1yi13kh7ih2M2CSqeiPGWmGr0ILEoDeLgcCIH4tZjhEFNEHKSV+ln1DZkDR3hI9Sp
MIME-Version: 1.0
X-Received: by 2002:a02:cbb5:: with SMTP id v21mr8929106jap.80.1604425406103;
 Tue, 03 Nov 2020 09:43:26 -0800 (PST)
Date:   Tue, 03 Nov 2020 09:43:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000664beb05b33766bd@google.com>
Subject: general protection fault in __fget_files
From:   syzbot <syzbot+4bbd040ddada1c7801f4@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b49976d8 Add linux-next specific files for 20201102
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=158bbb82500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe87d079ac78e2be
dashboard link: https://syzkaller.appspot.com/bug?extid=4bbd040ddada1c7801f4
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1559ef32500000

The issue was bisected to:

commit 4d004099a668c41522242aa146a38cc4eb59cb1e
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Oct 2 09:04:21 2020 +0000

    lockdep: Fix lockdep recursion

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14fb9c3a500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16fb9c3a500000
console output: https://syzkaller.appspot.com/x/log.txt?x=12fb9c3a500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4bbd040ddada1c7801f4@syzkaller.appspotmail.com
Fixes: 4d004099a668 ("lockdep: Fix lockdep recursion")

general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
CPU: 1 PID: 8824 Comm: io_uring-sq Not tainted 5.10.0-rc1-next-20201102-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:fcheck_files include/linux/fdtable.h:99 [inline]
RIP: 0010:__fget_files+0xef/0x400 fs/file.c:829
Code: db 74 1d e8 43 0d ac ff 0f b6 1d c1 82 14 0b 31 ff 89 de e8 43 05 ac ff 84 db 0f 84 d0 01 00 00 e8 26 0d ac ff 48 8b 44 24 10 <80> 38 00 0f 85 c3 02 00 00 48 8b 44 24 08 48 8b 68 58 48 89 e8 48
RSP: 0018:ffffc900023dfb28 EFLAGS: 00010293
RAX: dffffc000000000b RBX: 0000000000000001 RCX: ffffffff81c4157a
RDX: ffff88814193b500 RSI: ffffffff81c4139a RDI: 0000000000000005
RBP: ffffc900023dfd20 R08: 0000000000000001 R09: ffffffff8ebb4667
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000003 R15: ffffc900023dfd30
FS:  0000000000000000(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f42329d7db8 CR3: 000000001b67b000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __io_file_get fs/io_uring.c:2770 [inline]
 io_file_get+0x454/0x8b0 fs/io_uring.c:6295
 io_req_set_file fs/io_uring.c:6304 [inline]
 io_init_req fs/io_uring.c:6724 [inline]
 io_submit_sqes+0xf1c/0x25f0 fs/io_uring.c:6774
 __io_sq_thread fs/io_uring.c:6921 [inline]
 io_sq_thread+0x4d2/0x1700 fs/io_uring.c:6990
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Modules linked in:
---[ end trace 71851a1d0e522d2e ]---
RIP: 0010:fcheck_files include/linux/fdtable.h:99 [inline]
RIP: 0010:__fget_files+0xef/0x400 fs/file.c:829
Code: db 74 1d e8 43 0d ac ff 0f b6 1d c1 82 14 0b 31 ff 89 de e8 43 05 ac ff 84 db 0f 84 d0 01 00 00 e8 26 0d ac ff 48 8b 44 24 10 <80> 38 00 0f 85 c3 02 00 00 48 8b 44 24 08 48 8b 68 58 48 89 e8 48
RSP: 0018:ffffc900023dfb28 EFLAGS: 00010293
RAX: dffffc000000000b RBX: 0000000000000001 RCX: ffffffff81c4157a
RDX: ffff88814193b500 RSI: ffffffff81c4139a RDI: 0000000000000005
RBP: ffffc900023dfd20 R08: 0000000000000001 R09: ffffffff8ebb4667
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000003 R15: ffffc900023dfd30
FS:  0000000000000000(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdc225dc7c CR3: 000000000b08e000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
