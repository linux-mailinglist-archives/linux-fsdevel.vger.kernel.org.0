Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B45711CE80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 14:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfLLNir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 08:38:47 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48040 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729405AbfLLNiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:38:46 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifOg0-0005jt-HK; Thu, 12 Dec 2019 13:38:44 +0000
Date:   Thu, 12 Dec 2019 13:38:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: BUG: corrupted list in __dentry_kill (2)
Message-ID: <20191212133844.GG4203@ZenIV.linux.org.uk>
References: <000000000000b6b03205997b71cf@google.com>
 <20191212061206.GE4203@ZenIV.linux.org.uk>
 <CACT4Y+YJuV8EGSx8K_5Qd0f+fUz8MHb1awyJ78Jf8zrNmKokrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YJuV8EGSx8K_5Qd0f+fUz8MHb1awyJ78Jf8zrNmKokrA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 07:48:14AM +0100, Dmitry Vyukov wrote:
> On Thu, Dec 12, 2019 at 7:12 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, Dec 11, 2019 at 09:59:11PM -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    938f49c8 Add linux-next specific files for 20191211
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=150eba1ee00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=96834c884ba7bb81
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=31043da7725b6ec210f1
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dc83dae00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ac8396e00000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+31043da7725b6ec210f1@syzkaller.appspotmail.com
> >
> > Already fixed in a3d1e7eb5abe3aa1095bc75d1a6760d3809bd672
> 
> This commit was in the tested tree already as far as I can see.

Broken version (653f0d05be0948e7610bb786e6570bb6c48a4e75) is there, its
fixed replacement (a3d1e7eb5abe3aa1095bc75d1a6760d3809bd672) is not.

Look, I realize that your setup is oriented to "followup commit Y fixes
a bug in earlier commit X", and sometimes it's the only possibility
(when X has already been in mainline), but in general it's spelled
"bisection hazard for no damn reason".  Fixes are folded in.
Routinely.  What's more, in this case the fixed version had been done
(and pushed out) before syzbot has seen the original, so putting
any metadata into commit message hadn't been an option.

If there is some format understandable for syzbot for such cases
("bug is caused by commit X; Y is a replacement that should not
exhibit the same bug, so if you see that behaviour on a tree
that doesn't contain X, report it.  X-containing trees ought
to go extinct reasonably soon"), please tell what it is.
Otherwise this situation will keep repeating - I am not going
to stop folding fixes into developing patches.

Speaking of bisect hazards, I'd recommend to check how your bisect
went - the bug is definitely local to this commit and I really
wonder what had caused the bisect to go wrong in this particular
case.
