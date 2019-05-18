Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 296D722412
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 18:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbfERQVs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 May 2019 12:21:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42068 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729515AbfERQVs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 May 2019 12:21:48 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hS25e-0006JP-QQ; Sat, 18 May 2019 16:21:42 +0000
Date:   Sat, 18 May 2019 17:21:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sabin.rapan@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: BUG: unable to handle kernel paging request in do_mount
Message-ID: <20190518162142.GH17978@ZenIV.linux.org.uk>
References: <00000000000014285d05765bf72a@google.com>
 <0000000000000eaf23058912af14@google.com>
 <20190517134850.GG17978@ZenIV.linux.org.uk>
 <CACT4Y+Z8760uYQP0jKgJmVC5sstqTv9pE6K6YjK_feeK6-Obfg@mail.gmail.com>
 <CACT4Y+bQ+zW_9a3F4jY0xcAn_Hdk5yAwX2K3E38z9fttbF0SJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bQ+zW_9a3F4jY0xcAn_Hdk5yAwX2K3E38z9fttbF0SJA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 18, 2019 at 05:00:39PM +0200, Dmitry Vyukov wrote:
> On Fri, May 17, 2019 at 4:08 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Fri, May 17, 2019 at 3:48 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Fri, May 17, 2019 at 03:17:02AM -0700, syzbot wrote:
> > > > This bug is marked as fixed by commit:
> > > > vfs: namespace: error pointer dereference in do_remount()
> > > > But I can't find it in any tested tree for more than 90 days.
> > > > Is it a correct commit? Please update it by replying:
> > > > #syz fix: exact-commit-title
> > > > Until then the bug is still considered open and
> > > > new crashes with the same signature are ignored.
> > >
> > > Could somebody explain how the following situation is supposed to
> > > be handled:
> > >
> > > 1) branch B1 with commits  C1, C2, C3, C4 is pushed out
> > > 2) C2 turns out to have a bug, which gets caught and fixed
> > > 3) fix is folded in and branch B2 with C1, C2', C3', C4' is
> > > pushed out.  The bug is not in it anymore.
> > > 4) B1 is left mouldering (or is entirely removed); B2 is
> > > eventually merged into other trees.
> > >
> > > This is normal and it appears to be problematic for syzbot.
> > > How to deal with that?  One thing I will *NOT* do in such
> > > situations is giving up on folding the fixes in.  Bisection
> > > hazards alone make that a bad idea.
> >
> > linux-next creates a bit of a havoc.
> >
> > The ideal way of handling this is including Tested-by: tag into C2'.
> > Reported-by: would work too, but people suggested that Reported-by: is
> > confusing in this situation because it suggests that the commit fixes
> > a bug in some previous commit. Technically, syzbot now accepts any
> > tag, so With-inputs-from:
> > syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com would work too.
> >
> > At this point we obvious can't fix up C2'. For such cases syzbot
> > accepts #syz fix command to associate bugs with fixes. So replying
> > with "#syz fix: C2'-commit-title" should do.
> 
> What is that C2'?

In this case?  Take a look at

commit fd0002870b453c58d0d8c195954f5049bc6675fb
Author: David Howells <dhowells@redhat.com>
Date:   Tue Aug 28 14:45:06 2018 +0100

    vfs: Implement a filesystem superblock creation/configuration context

and compare with

commit f18edd10d3c7d6127b1fa97c8f3299629cf58ed5
Author: David Howells <dhowells@redhat.com>
Date:   Thu Nov 1 23:07:25 2018 +0000

    vfs: Implement a filesystem superblock creation/configuration context

There might have been intermediate forms, but that should illustrate what
happened.  Diff of those two contains (among other things) this:
@@ -985,6 +989,9 @@
 +      fc = vfs_new_fs_context(path->dentry->d_sb->s_type,
 +                              path->dentry, sb_flags, MS_RMT_MASK,
 +                              FS_CONTEXT_FOR_RECONFIGURE);
++      err = PTR_ERR(fc);
++      if (IS_ERR(fc))
++              goto err;
 +
 +      err = parse_monolithic_mount_data(fc, data, data_size);
 +      if (err < 0)

IOW, Dan's fix folded into the offending commit.  And that kind of
pattern is not rare; I would argue that appending Dan's patch at
the end of queue and leaving the crap in between would be a fucking
bad idea - it would've left a massive bisection hazard *and* made
life much more unpleasant when the things got to merging into the
mainline (or reviewing, for that matter).

What would you prefer to happen in such situations?  Commit summaries
modified enough to confuse CI tools into *NOT* noticing that those
are versions of the same patch?  Some kind of metadata telling the
same tools that such-and-such commits got folded in (and they might
have been split in process, with parts folded into different spots
in the series, at that)?

Because "never fold in, never reorder, just accumulate patches in
the end of the series" is not going to fly.  For a lot of reasons.
