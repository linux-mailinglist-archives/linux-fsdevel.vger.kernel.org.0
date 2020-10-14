Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE3528E8D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 00:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgJNWhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 18:37:48 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:51032 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727387AbgJNWhs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 18:37:48 -0400
Received: from dread.disaster.area (pa49-195-69-88.pa.nsw.optusnet.com.au [49.195.69.88])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6F07D3ABC6E;
        Thu, 15 Oct 2020 09:37:43 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kSpOx-000a89-2B; Thu, 15 Oct 2020 09:37:43 +1100
Date:   Thu, 15 Oct 2020 09:37:43 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: use page dirty state to seek data over
 unwritten extents
Message-ID: <20201014223743.GD7391@dread.disaster.area>
References: <20201012140350.950064-1-bfoster@redhat.com>
 <20201012140350.950064-2-bfoster@redhat.com>
 <20201013225344.GA7391@dread.disaster.area>
 <20201014125955.GA1109375@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014125955.GA1109375@bfoster>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=5g0Hk5519kQvxAqikqd8LA==:117 a=5g0Hk5519kQvxAqikqd8LA==:17
        a=kj9zAlcOel0A:10 a=afefHYAZSVUA:10 a=7-415B0cAAAA:8
        a=gAKjYB2y7psOtSEJf4oA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 08:59:55AM -0400, Brian Foster wrote:
> On Wed, Oct 14, 2020 at 09:53:44AM +1100, Dave Chinner wrote:
> > On Mon, Oct 12, 2020 at 10:03:49AM -0400, Brian Foster wrote:
> > > iomap seek hole/data currently uses page Uptodate state to track
> > > data over unwritten extents. This is odd and unpredictable in that
> > > the existence of clean pages changes behavior. For example:
> > > 
> > >   $ xfs_io -fc "falloc 0 32k" -c "seek -d 0" \
> > > 	    -c "pread 16k 4k" -c "seek -d 0" /mnt/file
> > >   Whence  Result
> > >   DATA    EOF
> > >   ...
> > >   Whence  Result
> > >   DATA    16384
> > 
> > I don't think there is any way around this, because the page cache
> > lookup done by the seek hole/data code is an
> > unlocked operation and can race with other IO and operations. That
> > is, seek does not take IO serialisation locks at all so
> > read/write/page faults/fallocate/etc all run concurrently with it...
> > 
> > i.e. we get an iomap that is current at the time the iomap_begin()
> > call is made, but we don't hold any locks to stabilise that extent
> > range while we do a page cache traversal looking for cached data.
> > That means any region of the unwritten iomap can change state while
> > we are running the page cache seek.
> > 
> 
> Hm, Ok.. that makes sense..
> 
> > We cannot determine what the data contents without major overhead,
> > and if we are seeking over a large unwritten extent covered by clean
> > pages that then gets partially written synchronously by another
> > concurrent write IO then we might trip across clean uptodate pages
> > with real data in them by the time the page cache scan gets to it.
> > 
> > Hence the only thing we are looking at here is whether there is data
> > present in the cache or not. As such, I think assuming that only
> > dirty/writeback pages contain actual user data in a seek data/hole
> > operation is a fundametnally incorrect premise.
> > 
> 
> ... but afaict this kind of thing is already possible because nothing
> stops a subsequently cleaned page (i.e., dirtied and written back) from
> also being dropped from cache before the scan finds it.  IOW, I don't
> really see how this justifies using one page state check over another as
> opposed to pointing out the whole page scanning thing itself seems to be
> racy. Perhaps the reasoning wrt to seek is simply that we should either
> see one state (hole) or the next (data) and we don't terribly care much
> about seek being racy..?

lseek() is inherently racy, and there's nothing we can do to prevent
that. i.e. even if we lock lseek up tight and guarantee the lookup
we do is absolutely correct, something can come in between dropping
the locks and returning that information to userspace that makes it
incorrect.

My point is that if we see a page that has uptodate data in it, then
userspace needs to be told that so it can determine if it is
actual data or just zeroed pages by reading it. If there's no page
in the cache, then seek hole/data simply doesn't know there was ever
data there, and there's nothing a page cache scan can do about that
sort of race. And there's nothing userspace can do about that sort
of race, either, because lseek() is inherently racy.

> My concern is more the issue described by patch 2. Note that patch 2
> doesn't necessarily depend on this one. The tradeoff without patch 1 is
> just that we'd explicitly zero and dirty any uptodate new EOF page as
> opposed to a page that was already dirty (or writeback).

I haven't looked at patch 2 - changes to seek hole/data need to be
correct from a stand alone perspective...

> Truncate does hold iolock/mmaplock, but ISTM that is still not
> sufficient because of the same page reclaim issue mentioned above. E.g.,
> a truncate down lands on a dirty page over an unwritten block,
> iomap_truncate_page() receives the unwritten mapping, page is flushed
> and reclaimed (changing block state), iomap_truncate_page() (still using
> the unwritten mapping) has nothing to do without a page and thus stale
> data is exposed.

So the problem here is only the new partial EOF block after the
truncate down completes? i.e. iomap_zero_range_actor() if failing to
zero the partial page that covers the new EOF if the block is
unwritten?

So, truncate_setsize() zeros the new partial EOF page, but it does
so without dirtying the page at all. Hence if the page is dirty in
memory over an unwritten extent when we run iomap_truncate_page(),
it's ready to be written out with the tail already zeroed in the
page cache. The only problem is that iomap_truncate_page() didn't
return "did_zeroing = true", and hence the followup "did_zeroing"
flush doesn't trigger.

And, FWIW, I suspect that follow flush is invalid for a truncate
down, too, because ip->i_d.di_size > new_isize  because both
write_cache_pages and __filemap_fdatawait_range() do nothing if
start > end as per the call in xfs_setattr_size().

> ISTM that either the filesystem needs to be more involved with the
> stabilization of unwritten mappings in general or truncate page needs to
> do something along the lines of block_truncate_page() (which we used
> pre-iomap) and just explicitly zero/dirty the new page if the block is
> otherwise mapped. Thoughts? Other ideas?

I suspect that iomap_truncate_page() needs to attempt to invalidate
the range being truncated first. i.e. call
invalidate_inode_pages2_range() and if it gets EBUSY returned we
know that there is a dirty cached page over the offset we are
truncating, and we now know that we must zero the page range
regardless of whether it sits over an unwritten extent or not.  Then
we just have to make sure the xfs_setattr_size does the right thing
with did_zeroing on truncate down....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
