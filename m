Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5841A2681E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 01:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgIMXpS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Sep 2020 19:45:18 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:60273 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725962AbgIMXpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Sep 2020 19:45:16 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 28616824433;
        Mon, 14 Sep 2020 09:45:08 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kHbg7-00079L-9D; Mon, 14 Sep 2020 09:45:03 +1000
Date:   Mon, 14 Sep 2020 09:45:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Michael Larabel <Michael@michaellarabel.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Kernel Benchmarking
Message-ID: <20200913234503.GS12096@dread.disaster.area>
References: <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
 <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com>
 <20200913004057.GR12096@dread.disaster.area>
 <CAHk-=wh5Lyr9Tr8wpNDXKeNt=Ngc3jwWaOsN_WbQr+1dAuhJSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh5Lyr9Tr8wpNDXKeNt=Ngc3jwWaOsN_WbQr+1dAuhJSQ@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=KcmsTjQD c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=7-415B0cAAAA:8
        a=rQIDHOkk6qEG7OUaQIAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 12, 2020 at 07:39:31PM -0700, Linus Torvalds wrote:
> On Sat, Sep 12, 2020 at 5:41 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > Hmmmm. So this is a typically a truncate race check, but this isn't
> > sufficient to protect the fault against all page invalidation races
> > as the page can be re-inserted into the same mapping at a different
> > page->index now within EOF.
> 
> Using some "move" ioctl or similar and using a "invalidate page
> mapping, then move it to a different point" model?

Right, that's the sort of optimisation we could do inside a
FALLOC_FL_{COLLAPSE,INSERT}_RANGE operation if we wanted to preserve
the page cache contents instead of invalidating it.

> Yeah. I think that ends up being basically an extended special case of
> the truncate thing (for the invalidate), and would require the
> filesystem to serialize externally to the page anyway.

*nod*

> Which they would presumably already do with the MMAPLOCK or similar,
> so I guess that's not a huge deal.
> 
> The real worry with (d) is that we are using the page lock for other
> things too, not *just* the truncate check. Things where the inode lock
> wouldn't be helping, like locking against throwing pages out of the
> page cache entirely, or the hugepage splitting/merging etc. It's not
> being truncated, it's just the VM shrinking the cache or modifying
> things in other ways.

Yes, that is a problem, and us FS people don't know/see all the
places this can occur. We generally find out about them when one of
our regression stress tests trips over a data corruption. :(

I have my doubts that complex page cache manipulation operations
like ->migrate_page that rely exclusively on page and internal mm
serialisation are really safe against ->fallocate based invalidation
races.  I think they probably also need to be wrapped in the
MMAPLOCK, but I don't understand all the locking and constraints
that ->migrate_page has and there's been no evidence yet that it's a
problem so I've kinda left that alone. I suspect that "no evidence"
thing comes from "filesystem people are largely unable to induce
page migrations in regression testing" so it has pretty much zero
test coverage....

Stuff like THP splitting hasn't been an issue for us because the
file-backed page cache does not support THP (yet!). That's
something I'll be looking closely at in Willy's upcoming patchset.

> So I do worry a bit about trying to make things per-inode (or even
> some per-range thing with a smarter lock) for those reasons. We use
> the page lock not just for synchronizing with filesystem operations,
> but for other page state synchronization too.

Right, I'm not suggesting the page lock goes away, just saying that
we actually need two levels of locking for file-backed pages - one
filesystem, one page level - and that carefully selecting where we
"aggregate" the locking for complex multi-object operations might
make the overall locking simpler.

> In many ways I think keeping it as a page-lock, and making the
> filesystem operations just act on the range of pages would be safer.

Possibly, but that "range of pages" lock still doesn't really solve
the filesystem level serialisation problem.  We have to prevent page
faults from running over a range even when there aren't pages in the
page cache over that range (i.e. after we invalidate the range).
Hence we cannot rely on anything struct page related - the
serialisation mechanism has to be external to the cached pages
themselves, but it also has to integrate cleanly into the existing
locking and transaction ordering constraints we have.

> But the page locking code does have some extreme downsides, exactly
> because there are so _many_ pages and we end up having to play some
> extreme size games due to that (ie the whole external hashing, but
> also just not being able to use any debug locks etc, because we just
> don't have the resources to do debugging locks at that kind of
> granularity).

*nod*

The other issue here is that serialisation via individual cache
object locking just doesn't scale in any way to the sizes of
operations that fallocate() can run. fallocate() has 64 bit
operands, so a user could ask us to lock down a full 8EB range of
file. Locking that page by page, even using 1GB huge page Xarray
slot entries, is just not practical... :/

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
