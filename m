Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97271119FDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 01:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfLKAX5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 19:23:57 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:57919 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726769AbfLKAX4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:23:56 -0500
Received: from dread.disaster.area (pa49-195-139-249.pa.nsw.optusnet.com.au [49.195.139.249])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 05A387E9B8C;
        Wed, 11 Dec 2019 11:23:51 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iepnB-0006Pe-C7; Wed, 11 Dec 2019 11:23:49 +1100
Date:   Wed, 11 Dec 2019 11:23:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: make buffered writes work with RWF_UNCACHED
Message-ID: <20191211002349.GC19213@dread.disaster.area>
References: <20191210162454.8608-1-axboe@kernel.dk>
 <20191210162454.8608-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210162454.8608-4-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=KoypXv6BqLCQNZUs2nCMWg==:117 a=KoypXv6BqLCQNZUs2nCMWg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=OUdnQ-l5LQdgMwZtS0UA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 09:24:52AM -0700, Jens Axboe wrote:
> If RWF_UNCACHED is set for io_uring (or pwritev2(2)), we'll drop the
> cache instantiated for buffered writes. If new pages aren't
> instantiated, we leave them alone. This provides similar semantics to
> reads with RWF_UNCACHED set.

So what about filesystems that don't use generic_perform_write()?
i.e. Anything that uses the iomap infrastructure (i.e.
iomap_file_buffered_write()) instead of generic_file_write_iter())
will currently ignore RWF_UNCACHED. That's XFS and gfs2 right now,
but there are likely to be more in the near future as more
filesystems are ported to the iomap infrastructure.

I'd also really like to see extensive fsx and fstress testing of
this new IO mode before it is committed - this is going to exercise page
cache coherency across different operations in new and unique
ways. that means we need patches to fstests to detect and use this
functionality when available, and new tests that explicitly exercise
combinations of buffered, mmap, dio and uncached for a range of
different IO size and alignments (e.g. mixing sector sized uncached
IO with page sized buffered/mmap/dio and vice versa).

We are not going to have a repeat of the copy_file_range() data
corruption fuckups because no testing was done and no test
infrastructure was written before the new API was committed.

> +void write_drop_cached_pages(struct page **pgs, struct address_space *mapping,
> +			     unsigned *nr)
> +{
> +	loff_t start, end;
> +	int i;
> +
> +	end = 0;
> +	start = LLONG_MAX;
> +	for (i = 0; i < *nr; i++) {
> +		struct page *page = pgs[i];
> +		loff_t off;
> +
> +		off = (loff_t) page_to_index(page) << PAGE_SHIFT;
> +		if (off < start)
> +			start = off;
> +		if (off > end)
> +			end = off;
> +		get_page(page);
> +	}
> +
> +	__filemap_fdatawrite_range(mapping, start, end, WB_SYNC_NONE);
> +
> +	for (i = 0; i < *nr; i++) {
> +		struct page *page = pgs[i];
> +
> +		lock_page(page);
> +		if (page->mapping == mapping) {
> +			wait_on_page_writeback(page);
> +			if (!page_has_private(page) ||
> +			    try_to_release_page(page, 0))
> +				remove_mapping(mapping, page);
> +		}
> +		unlock_page(page);
> +	}
> +	*nr = 0;
> +}
> +EXPORT_SYMBOL_GPL(write_drop_cached_pages);
> +
> +#define GPW_PAGE_BATCH		16

In terms of performance, file fragmentation and premature filesystem
aging, this is also going to suck *really badly* for filesystems
that use delayed allocation because it is going to force conversion
of delayed allocation extents during the write() call. IOWs,
it adds all the overheads of doing delayed allocation, but it reaps
none of the benefits because it doesn't allow large contiguous
extents to build up in memory before physical allocation occurs.
i.e. there is no "delayed" in this allocation....

So it might work fine on a pristine, empty filesystem where it is
easy to find contiguous free space accross multiple allocations, but
it's going to suck after a few months of production usage has
fragmented all the free space into tiny pieces...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
