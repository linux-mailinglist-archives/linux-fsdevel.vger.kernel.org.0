Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6E22EC62B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 23:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbhAFWV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 17:21:57 -0500
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:34521 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbhAFWV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 17:21:57 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id BE3D476AF41;
        Thu,  7 Jan 2021 09:21:12 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kxHB1-003m7x-Iw; Thu, 07 Jan 2021 09:21:11 +1100
Date:   Thu, 7 Jan 2021 09:21:11 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: block_dev: compute nr_vecs hint for improving
 writeback bvecs allocation
Message-ID: <20210106222111.GE331610@dread.disaster.area>
References: <20210105132647.3818503-1-ming.lei@redhat.com>
 <20210105183938.GA3878@lst.de>
 <20210106084548.GA3845805@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106084548.GA3845805@T590>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=dbeGUg55DdRa2WVwu8kA:9 a=CjuIK1q_8ugA:10 a=igBNqPyMv6gA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 06, 2021 at 04:45:48PM +0800, Ming Lei wrote:
> On Tue, Jan 05, 2021 at 07:39:38PM +0100, Christoph Hellwig wrote:
> > At least for iomap I think this is the wrong approach.  Between the
> > iomap and writeback_control we know the maximum size of the writeback
> > request and can just use that.
> 
> I think writeback_control can tell us nothing about max pages in single
> bio:

By definition, the iomap tells us exactly how big the IO is going to
be. i.e. an iomap spans a single contiguous range that we are going
to issue IO on. Hence we can use that to size the bio exactly
right for direct IO.

> - wbc->nr_to_write controls how many pages to writeback, this pages
>   usually don't belong to same bio. Also this number is often much
>   bigger than BIO_MAX_PAGES.
> 
> - wbc->range_start/range_end is similar too, which is often much more
>   bigger than BIO_MAX_PAGES.
> 
> Also page/blocks_in_page can be mapped to different extent too, which is
> only available when wpc->ops->map_blocks() is returned,

We only allocate the bio -after- calling ->map_blocks() to obtain
the iomap for the given writeback range request. Hence we
already know how large the BIO could be before we allocate it.

> which looks not
> different with mpage_writepages(), in which bio is allocated with
> BIO_MAX_PAGES vecs too.

__mpage_writepage() only maps a page at a time, so it can't tell
ahead of time how big the bio is going to need to be as it doesn't
return/cache a contiguous extent range. So it's actually very
different to the iomap writeback code, and effectively does require
a BIO_MAX_PAGES vecs allocation all the time...

> Or you mean we can use iomap->length for this purpose? But iomap->length
> still is still too big in case of xfs.

if we are doing small random writeback into large extents (i.e.
iomap->length is large), then it is trivial to detect that we are
doing random writes rather than sequential writes by checking if the
current page is sequential to the last sector in the current bio.
We already do this non-sequential IO checking to determine if a new
bio needs to be allocated in iomap_can_add_to_ioend(), and we also
know how large the current contiguous range mapped into the current
bio chain is (ioend->io_size). Hence we've got everything we need to
determine whether we should do a large or small bio vec allocation
in the iomap writeback path...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
