Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F251AC2E7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2019 01:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392784AbfIFXPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 19:15:31 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:54774 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732440AbfIFXPb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:15:31 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 9307A36115B;
        Sat,  7 Sep 2019 09:15:27 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i6NRu-0004fL-K6; Sat, 07 Sep 2019 09:15:26 +1000
Date:   Sat, 7 Sep 2019 09:15:26 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Lukas Czerner <lczerner@redhat.com>
Subject: Re: [Q] gfs2: mmap write vs. punch_hole consistency
Message-ID: <20190906231526.GA16973@dread.disaster.area>
References: <20190906205241.2292-1-agruenba@redhat.com>
 <20190906212758.GO1119@dread.disaster.area>
 <CAHc6FU5BxOHkgHKKWTL7jFq0oL4TbAPpe49QDB6X35ndjYTWKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU5BxOHkgHKKWTL7jFq0oL4TbAPpe49QDB6X35ndjYTWKQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
        a=7-415B0cAAAA:8 a=8fbbZ4Ib-xQoSIbtoJoA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 11:48:31PM +0200, Andreas Gruenbacher wrote:
> On Fri, Sep 6, 2019 at 11:28 PM Dave Chinner <david@fromorbit.com> wrote:
> > On Fri, Sep 06, 2019 at 10:52:41PM +0200, Andreas Gruenbacher wrote:
> > > Hi,
> > >
> > > I've just fixed a mmap write vs. truncate consistency issue on gfs on
> > > filesystems with a block size smaller that the page size [1].
> > >
> > > It turns out that the same problem exists between mmap write and hole
> > > punching, and since xfstests doesn't seem to cover that,
> >
> > AFAIA, fsx exercises it pretty often. Certainly it's found problems
> > with XFS in the past w.r.t. these operations.
> >
> > > I've written a
> > > new test [2].
> >
> > I suspect that what we really want is a test that runs
> > _test_generic_punch using mmap rather than pwrite...
> >
> > > Ext4 and xfs both pass that test; they both apparently
> > > mark the pages that have a hole punched in them as read-only so that
> > > page_mkwrite is called before those pages can be written to again.
> >
> > XFS invalidates the range being hole punched (see
> > xfs_flush_unmap_range() under XFS_MMAPLOCK_EXCL, which means any
> > attempt to fault that page back in will block on the MMAPLOCK until
> > the hole punch finishes.
> 
> This isn't about writes during the hole punching, this is about writes
> once the hole is punched.

How do you prevent this:

hole punch process:		other process
  clean page
  invalidate page
				write page fault
				instantiate new page
				page_mkwrite
				page dirty
  do hole punch
  overwrite hole

Firstly, you end up with a dirty page over a hole with no backing
store, and second, you get no page fault on overwrite because the
pages are already dirty.

That's the problem the MMAPLOCK in XFS solves - it's integral to
ensuring the page faults on mmap write are correctly serialised with
both the page cache invalidation and the underlying extent
manipulation that the hole punch operation then does.

i.e. if you want a page fault /after/ a hole punch, you have to
prevent it occurring during the hole punch after the page has
already been marked clean and/or invalidated.

> For example, the test case I've posted
> creates the following file layout with 1k blocksize:
> 
>   DDDD DDDD DDDD
> 
> Then it punches a hole like this:
> 
>   DDHH HHHH HHDD
> 
> Then it fills the hole again with mwrite:
> 
>   DDDD DDDD DDDD
> 
> As far as I can tell, that needs to trigger page faults on all three
> pages.

Yes, but only /after/ the hole has been punched.

> I did get these on ext4; judging from the fact that xfs works,
> the also seem to occur there; but on gfs2, page_mkwrite isn't called
> for the two partially mapped pages, only for the page in the middle
> that's entirely within the hole. And I don't see where those pages are
> marked read-only; it appears like pagecache_isize_extended isn't
> called on ext4 or xfs. So how does this work there?

As I said in my last response, the answer is in
xfs_flush_unmap_range(). That uses truncate_pagecache_range() to do
the necessary page cache manipulation.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
