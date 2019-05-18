Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5A822547
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 23:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfERVl4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 May 2019 17:41:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45252 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfERVlz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 May 2019 17:41:55 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hS75R-0006cQ-1J; Sat, 18 May 2019 21:41:49 +0000
Date:   Sat, 18 May 2019 22:41:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Theodore Ts'o <tytso@mit.edu>, Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sabin.rapan@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: BUG: unable to handle kernel paging request in do_mount
Message-ID: <20190518214148.GI17978@ZenIV.linux.org.uk>
References: <00000000000014285d05765bf72a@google.com>
 <0000000000000eaf23058912af14@google.com>
 <20190517134850.GG17978@ZenIV.linux.org.uk>
 <CACT4Y+Z8760uYQP0jKgJmVC5sstqTv9pE6K6YjK_feeK6-Obfg@mail.gmail.com>
 <CACT4Y+bQ+zW_9a3F4jY0xcAn_Hdk5yAwX2K3E38z9fttbF0SJA@mail.gmail.com>
 <20190518162142.GH17978@ZenIV.linux.org.uk>
 <20190518201843.GD14277@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190518201843.GD14277@mit.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 18, 2019 at 04:18:43PM -0400, Theodore Ts'o wrote:

> > What would you prefer to happen in such situations?  Commit summaries
> > modified enough to confuse CI tools into *NOT* noticing that those
> > are versions of the same patch?  Some kind of metadata telling the
> > same tools that such-and-such commits got folded in (and they might
> > have been split in process, with parts folded into different spots
> > in the series, at that)?
> > 
> > Because "never fold in, never reorder, just accumulate patches in
> > the end of the series" is not going to fly.  For a lot of reasons.
> 
> As far as I'm concerned, this is the tools problem; I don't think it's
> worth it for developers to feel they need to twist themselves into
> knots just to try to make the CI tools' life easier.

FWIW, what _is_ the underlying problem?  It looks like the basic issue
is with rebase/cherry-pick of a commit; it seems to be trying to
handle two things:
	1) report X' in commit C' is similar to report X in commit C,
with C' apparently being a rebase/cherry-pick/whatnot of C; don't
want to lose that information
	2) reports X, Y and Z in commit C don't seem to be reoccuring
on the current tree, without any claimed fix in it.  Want to keep
an eye on those.

... and getting screwed by a mix of those two: reports X, Y and Z in
commit C don't seem to be reoccuring on the current tree, even though
it does contain a commit C' that seems to be a rebase of C.  A fix for
C is *not* present as an identifiable commit in the current tree.
Was it lost or was it renamed/merged with other commits/replaced by
another fix?

What I don't quite understand is why does the tool care.  Suppose
we have a buggy commit + clearly marked fix.  And see a report
very similar to the original ones, on the tree with alleged fix
clearly present.  IME the earlier reports are often quite relevant -
the fix might have been incomplete/racy/etc., and in that case
the old reports (*AND* pointer to the commit that was supposed to
have fixed those) are very useful.

What's the problem these reminders are trying to solve?  Computational
resources eaten by comparisons?
