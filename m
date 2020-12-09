Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862472D43BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 15:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbgLIOAS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 09:00:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:54308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbgLIOAQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:00:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E1909ACEB;
        Wed,  9 Dec 2020 13:59:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 98A661E133E; Wed,  9 Dec 2020 14:59:34 +0100 (CET)
Date:   Wed, 9 Dec 2020 14:59:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+f427adf9324b92652ccc@syzkaller.appspotmail.com>
Cc:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: kernel BUG at fs/notify/dnotify/dnotify.c:LINE! (2)
Message-ID: <20201209135934.GB28118@quack2.suse.cz>
References: <000000000000be4c9505b4c35420@google.com>
 <20201209133842.GA28118@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209133842.GA28118@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 09-12-20 14:38:42, Jan Kara wrote:
> Hello!
> 
> so I was debugging the dnotify crash below (it's 100% reproducible for me)
> and I came to the following. The reproducer opens 'file0' on FUSE
> filesystem which is a directory at that point. Then it attached dnotify
> mark to the directory 'file0' and then it does something to the FUSE fs
> which I don't understand but the result is that when FUSE is unmounted the
> 'file0' inode is actually a regular file (note that I've verified this is
> really the same inode pointer). This then confuses dnotify which doesn't
> tear down its structures properly and eventually crashes. So my question
> is: How can an inode on FUSE filesystem morph from a dir to a regular file?
> I presume this could confuse much more things than just dnotify?
> 
> Before I dwelve more into FUSE internals, any idea Miklos what could have
> gone wrong and how to debug this further?

I've got an idea where to look and indeed it is the fuse_do_getattr() call
that finds attributes returned by the server are inconsistent so it calls
make_bad_inode() which, among other things, does:

	inode->i_mode = S_IFREG;

Indeed calling make_bad_inode() on a live inode doesn't look like a good
idea. IMHO FUSE needs to come up with some other means of marking the inode
as stale. Miklos?

								Honza

> On Mon 23-11-20 02:05:16, syzbot wrote:
> > syzbot found the following issue on:
> > 
> > HEAD commit:    27bba9c5 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11b82225500000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=330f3436df12fd44
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f427adf9324b92652ccc
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d3f015500000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17162d4d500000
> > 
> > Bisection is inconclusive: the issue happens on the oldest tested release.
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16570525500000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=15570525500000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11570525500000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+f427adf9324b92652ccc@syzkaller.appspotmail.com
> > 
> > wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
> > ------------[ cut here ]------------
> > kernel BUG at fs/notify/dnotify/dnotify.c:118!
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 1 PID: 648 Comm: kworker/u4:4 Not tainted 5.10.0-rc4-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Workqueue: events_unbound fsnotify_mark_destroy_workfn
> > RIP: 0010:dnotify_free_mark fs/notify/dnotify/dnotify.c:118 [inline]
> > RIP: 0010:dnotify_free_mark+0x4b/0x60 fs/notify/dnotify/dnotify.c:112
> > Code: 80 3c 02 00 75 26 48 83 bd 80 00 00 00 00 75 15 e8 0a d3 a0 ff 48 89 ee 48 8b 3d 68 8c 1d 0b 5d e9 aa 06 e2 ff e8 f5 d2 a0 ff <0f> 0b e8 ae 4d e2 ff eb d3 66 90 66 2e 0f 1f 84 00 00 00 00 00 41
> > RSP: 0018:ffffc90002f1fc38 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: ffffffff8958ae60 RCX: 1ffff920005e3f95
> > RDX: ffff888012601a40 RSI: ffffffff81cf5ceb RDI: ffff88801aea2080
> > RBP: ffff88801aea2000 R08: 0000000000000001 R09: ffffffff8ebb170f
> > R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880171a2000
> > R13: ffffc90002f1fc98 R14: ffff88801aea2010 R15: ffff88801aea2018
> > FS:  0000000000000000(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000056045fa95978 CR3: 0000000012121000 CR4: 00000000001506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  fsnotify_final_mark_destroy+0x71/0xb0 fs/notify/mark.c:205
> >  fsnotify_mark_destroy_workfn+0x1eb/0x340 fs/notify/mark.c:840
> >  process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
> >  worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
> >  kthread+0x3af/0x4a0 kernel/kthread.c:292
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> > Modules linked in:
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > syzbot can test patches for this issue, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
