Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F36D22B11B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 16:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgGWORc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 10:17:32 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35077 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGWORc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:17:32 -0400
X-Originating-IP: 84.44.14.226
Received: from nexussix (unknown [84.44.14.226])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 70E95E0009;
        Thu, 23 Jul 2020 14:17:26 +0000 (UTC)
Message-ID: <455c6bf929ea197a7c18ba3f9e8464148b333297.camel@kernel.wtf>
Subject: Re: WARNING in __kernel_read
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, v9fs-developer@lists.sourceforge.net,
        syzbot <syzbot+d012ca3f813739c37c25@syzkaller.appspotmail.com>
Date:   Thu, 23 Jul 2020 17:17:25 +0300
In-Reply-To: <20200714110239.GE16178@lst.de>
References: <00000000000003d32b05aa4d493c@google.com>
         <20200714110239.GE16178@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I'm trying to help clean up syzkaller submissions and this caught my
attention and I wanted to get your advice.

With commit: 6209dd9132e8ea5545cffc84483841e88ea8cc5b `kernel_read` was
modified to use `__kernel_read` by Christoph Hellwig.

One of the syzkaller tests executes following system calls:

open("./file0", O_WRONLY|O_CREAT|O_EXCL|O_DIRECT|0x4, 000) = 5
open("/dev/char/4:1", O_RDWR)           = 6
mount(NULL, "./file0", "9p", 0,
"trans=fd,rfdno=0x0000000000000005,wfdno=0x0000000000000006,"

This initiates a `__kernel_read` call from `p9_read_work` (and
`p9_fd_read`) and since the `file->f_mode` does not contain FMODE_READ
, a WARN_ON_ONCE is thrown.

```
if (WARN_ON_ONCE(!(file->f_mode & FMODE_READ)))
         return -EINVAL;
```

Can you help me understand what's wrong and fix this issue? 
Is it already being worked on?

Thank you

Cengiz Can

On Tue, 2020-07-14 at 13:02 +0200, Christoph Hellwig wrote:
> On Mon, Jul 13, 2020 at 12:03:17AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> 
> This is not a crash, but a WARN_ON_ONCE, someone really needs to fix
> syzbot to report this correctly.
> 
> The fix should be queued up by the 9p maintainers.
> 
> > HEAD commit:    a581387e Merge tag 'io_uring-5.8-2020-07-10' of
> > git://git...
> > git tree:       upstream
> > console output: 
> > https://syzkaller.appspot.com/x/log.txt?x=13e730eb100000
> > kernel config:  
> > https://syzkaller.appspot.com/x/.config?x=66ad203c2bb6d8b
> > dashboard link: 
> > https://syzkaller.appspot.com/bug?extid=d012ca3f813739c37c25
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      
> > https://syzkaller.appspot.com/x/repro.syz?x=12e0222b100000
> > C reproducer:   
> > https://syzkaller.appspot.com/x/repro.c?x=162a004f100000
> > 
> > The bug was bisected to:
> > 
> > commit 6209dd9132e8ea5545cffc84483841e88ea8cc5b
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Fri May 8 07:00:28 2020 +0000
> > 
> >     fs: implement kernel_read using __kernel_read
> > 
> > bisection log:  
> > https://syzkaller.appspot.com/x/bisect.txt?x=152d91fb100000
> > final crash:    
> > https://syzkaller.appspot.com/x/report.txt?x=172d91fb100000
> > console output: 
> > https://syzkaller.appspot.com/x/log.txt?x=132d91fb100000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the
> > commit:
> > Reported-by: syzbot+d012ca3f813739c37c25@syzkaller.appspotmail.com
> > Fixes: 6209dd9132e8 ("fs: implement kernel_read using
> > __kernel_read")
> > 
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 5 at fs/read_write.c:427
> > __kernel_read+0x41d/0x4d0 fs/read_write.c:427
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.8.0-rc4-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine,
> > BIOS Google 01/01/2011
> > Workqueue: events p9_read_work
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x18f/0x20d lib/dump_stack.c:118
> >  panic+0x2e3/0x75c kernel/panic.c:231
> >  __warn.cold+0x20/0x45 kernel/panic.c:600
> >  report_bug+0x1bd/0x210 lib/bug.c:198
> >  handle_bug+0x38/0x90 arch/x86/kernel/traps.c:235
> >  exc_invalid_op+0x13/0x40 arch/x86/kernel/traps.c:255
> >  asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:542
> > RIP: 0010:__kernel_read+0x41d/0x4d0 fs/read_write.c:427
> > Code: fd ff ff e8 75 19 b6 ff 45 31 c9 45 31 c0 b9 01 00 00 00 4c
> > 89 f2 89 ee 4c 89 ef e8 5d 22 12 00 e9 46 ff ff ff e8 53 19 b6 ff
> > <0f> 0b 49 c7 c4 ea ff ff ff e9 11 fe ff ff 4c 89 f7 e8 2d 76 f5 ff
> > RSP: 0018:ffffc90000cbfbc8 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: ffff8880a9786ac0 RCX: ffffffff81bd9ac4
> > RDX: ffff8880a95a2140 RSI: ffffffff81bd9e3d RDI: 0000000000000005
> > RBP: ffff888096bc8060 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 1ffffffff1829bdd R12: 00000000081d801e
> > R13: ffffc90000cbfc98 R14: ffff8880a9786b44 R15: 0000000000000007
> >  kernel_read+0x52/0x70 fs/read_write.c:457
> >  p9_fd_read net/9p/trans_fd.c:263 [inline]
> >  p9_read_work+0x2ac/0xff0 net/9p/trans_fd.c:298
> >  process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
> >  worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
> >  kthread+0x3b5/0x4a0 kernel/kthread.c:291
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
> > Kernel Offset: disabled
> > Rebooting in 86400 seconds..
> > 
> > 
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process see: 
> > https://goo.gl/tpsmEJ#bisection
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
> ---end quoted text---

