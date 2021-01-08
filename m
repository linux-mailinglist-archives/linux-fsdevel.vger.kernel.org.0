Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360322EF9CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 22:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbhAHVBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 16:01:04 -0500
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:60828 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728511AbhAHVBD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:01:03 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 3438676566F;
        Sat,  9 Jan 2021 08:00:17 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kxyrp-004RRw-51; Sat, 09 Jan 2021 08:00:17 +1100
Date:   Sat, 9 Jan 2021 08:00:17 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: block_dev: compute nr_vecs hint for improving
 writeback bvecs allocation
Message-ID: <20210108210017.GK331610@dread.disaster.area>
References: <20210105132647.3818503-1-ming.lei@redhat.com>
 <20210105183938.GA3878@lst.de>
 <20210106084548.GA3845805@T590>
 <20210106222111.GE331610@dread.disaster.area>
 <20210108075922.GB3982620@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108075922.GB3982620@T590>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=0TDAt5E3tB6VCO8953IA:9 a=qZgZfBh61L_KZ1-l:21 a=JzxU2LrYxQ7o857g:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 08, 2021 at 03:59:22PM +0800, Ming Lei wrote:
> On Thu, Jan 07, 2021 at 09:21:11AM +1100, Dave Chinner wrote:
> > On Wed, Jan 06, 2021 at 04:45:48PM +0800, Ming Lei wrote:
> > > On Tue, Jan 05, 2021 at 07:39:38PM +0100, Christoph Hellwig wrote:
> > > > At least for iomap I think this is the wrong approach.  Between the
> > > > iomap and writeback_control we know the maximum size of the writeback
> > > > request and can just use that.
> > > 
> > > I think writeback_control can tell us nothing about max pages in single
> > > bio:
> > 
> > By definition, the iomap tells us exactly how big the IO is going to
> > be. i.e. an iomap spans a single contiguous range that we are going
> > to issue IO on. Hence we can use that to size the bio exactly
> > right for direct IO.
> 
> When I trace wpc->iomap.length in iomap_add_to_ioend() on the following fio
> randwrite/write, the length is 1GB most of times, maybe because it is
> one fresh XFS.

Yes, that's exactly what I said it would do.

> Another reason is that pages in the range may be contiguous physically,
> so lots of pages may share one single bvec.

The iomap layer does not care about this, and there's no way this
can be detected ahead of time, anyway, because we are only passed a
single page at a time. When we get large pages from the page cache,
we'll still only get one page at a time, but we'll get physically
contiguous pages and so it will still be a 1 page : 1 bvec
relationship at the iomap layer.

> > > - wbc->nr_to_write controls how many pages to writeback, this pages
> > >   usually don't belong to same bio. Also this number is often much
> > >   bigger than BIO_MAX_PAGES.
> > > 
> > > - wbc->range_start/range_end is similar too, which is often much more
> > >   bigger than BIO_MAX_PAGES.
> > > 
> > > Also page/blocks_in_page can be mapped to different extent too, which is
> > > only available when wpc->ops->map_blocks() is returned,
> > 
> > We only allocate the bio -after- calling ->map_blocks() to obtain
> > the iomap for the given writeback range request. Hence we
> > already know how large the BIO could be before we allocate it.
> > 
> > > which looks not
> > > different with mpage_writepages(), in which bio is allocated with
> > > BIO_MAX_PAGES vecs too.
> > 
> > __mpage_writepage() only maps a page at a time, so it can't tell
> > ahead of time how big the bio is going to need to be as it doesn't
> > return/cache a contiguous extent range. So it's actually very
> > different to the iomap writeback code, and effectively does require
> > a BIO_MAX_PAGES vecs allocation all the time...
> > 
> > > Or you mean we can use iomap->length for this purpose? But iomap->length
> > > still is still too big in case of xfs.
> > 
> > if we are doing small random writeback into large extents (i.e.
> > iomap->length is large), then it is trivial to detect that we are
> > doing random writes rather than sequential writes by checking if the
> > current page is sequential to the last sector in the current bio.
> > We already do this non-sequential IO checking to determine if a new
> > bio needs to be allocated in iomap_can_add_to_ioend(), and we also
> > know how large the current contiguous range mapped into the current
> > bio chain is (ioend->io_size). Hence we've got everything we need to
> > determine whether we should do a large or small bio vec allocation
> > in the iomap writeback path...
> 
> page->index should tell us if the workload is random or sequential, however
> still not easy to decide how many pages there will be in the next bio
> when iomap->length is large.

page->index doesn't tell us anything about what type of IO is being
done - it just tells us where in the file we need to map to find the
physical block we need to write it to. OTOH, the iomap writeback
context contains all the information about current IO being build -
offset, size, current bio, etc - and the page->index gets compared
against the state in the iomap writepage context.

So, if the wpc->iomap.length is large, current page->index does not
map sequentially to the end of wpc->ioend->io_bio (or
wpc->io_end->io_offset + wpc->ioend->io_size) and
wpc->io_end->io_size == page_size(page) for the currently held bio,
then we are clearly doing random single page writeback into a large
allocated extent. Hence in that case we can do small bvec
allocations for the new bio.

Sure, the first bio in a ->writepages invocation doesn't have this
information, so we've going to have to assume BIO_MAX_PAGES for the
first bio. But for every bio after that in the ->writepages
invocation we have the state of the previous contiguous writeback
range held in the wpc structure and can use that info to optimise
the thousands of random single pages that are written after then
first one...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
