Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46B19123DC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 04:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLRDR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 22:17:27 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:46177 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbfLRDR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 22:17:27 -0500
Received: from dread.disaster.area (pa49-195-139-249.pa.nsw.optusnet.com.au [49.195.139.249])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 6F8377E8F9C;
        Wed, 18 Dec 2019 14:17:17 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ihPps-0007DD-OZ; Wed, 18 Dec 2019 14:17:16 +1100
Date:   Wed, 18 Dec 2019 14:17:16 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 1/6] fs: add read support for RWF_UNCACHED
Message-ID: <20191218031716.GU19213@dread.disaster.area>
References: <20191217143948.26380-1-axboe@kernel.dk>
 <20191217143948.26380-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217143948.26380-2-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=KoypXv6BqLCQNZUs2nCMWg==:117 a=KoypXv6BqLCQNZUs2nCMWg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=sHR7OoHQe-bhMzIJJDcA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 07:39:43AM -0700, Jens Axboe wrote:
> If RWF_UNCACHED is set for io_uring (or preadv2(2)), we'll use private
> pages for the buffered reads. These pages will never be inserted into
> the page cache, and they are simply droped when we have done the copy at
> the end of IO.

Ok, so unlike the uncached write case, this /isn't/ coherent with
the page cache. IOWs, it can race with other reads and page faults
and mmap can change the data it has faulted into the page cache and
write it back before the RWF_UNCACHED read completes, resulting
in RWF_UNCACHED potential returning torn data.

And it's not coherent with uncached writes, either, if the
filesystem does not provide it's own serialisation between buffered
reads and writes. i.e. simple/legacy filesystems just use the page
lock to serialise buffered reads against buffered writes, while
buffered writes are serialised against each other via the
inode_lock() in generic_file_write_iter().

Further, the use of inode_dio_wait() for truncate serialisation is
optional for filesystems - it's not a generic mechanism. Filesystems
that only support buffered IO only use page locks to provide
truncate serialisation and don't call inode_dio_wait() in their
->setattr methods. Hence to serialise truncates against uncached
reads in such filesystems the uncached read needs to be page cache
coherent.

As I said previously: I don't think this is a viable approach
because it has page cache coherency issues that are just as bad, if
not worse, than direct IO.

> If pages in the read range are already in the page cache, then use those
> for just copying the data instead of starting IO on private pages.
> 
> A previous solution used the page cache even for non-cached ranges, but
> the cost of doing so was too high. Removing nodes at the end is
> expensive, even with LRU bypass.

If you want to bypass the page cache overhead all together, then
use direct IO. We should not make the same mistakes as O_DIRECT
for the same reasons (performance!). Instead, once we have the
page cache coherent path working we should then work to optimise
it with better page cache insert/remove primitives to lower the
overhead.

> On top of that, repeatedly
> instantiating new xarray nodes is very costly, as it needs to memset 576
> bytes of data, and freeing said nodes involve an RCU call per node as
> well. All that adds up, making uncached somewhat slower than O_DIRECT.

I think some of that has to do with implementation details and the
fact you appear to be focussing on PAGE_SIZE IOs. This means you are
instantiating and removing a single cached page at a time from the
mapping tree, and that means we need to allocate and free an xarray
node per IO.

I would say this is a future Xarray optimisation target, not a
reason for introducing a new incoherent IO API we'll have to support
long after we've fixed the xarray inefficiency....

> @@ -2048,6 +2057,13 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  		if (!page) {
>  			if (iocb->ki_flags & IOCB_NOWAIT)
>  				goto would_block;
> +			/* UNCACHED implies no read-ahead */
> +			if (iocb->ki_flags & IOCB_UNCACHED) {
> +				did_dio_begin = true;
> +				/* block truncate for UNCACHED reads */
> +				inode_dio_begin(inode);
> +				goto no_cached_page;
> +			}

Ok, so for every page we don't find in the cache, we go issue IO.
We also call inode_dio_begin() on every page we miss, but only call
inode_dio_end() a single time. So we leak i_dio_count on every IO
that needs to read more than a single page, which means we'll hang
in the next call to inode_dio_wait()...

>  no_cached_page:
> @@ -2234,6 +2250,14 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  			error = -ENOMEM;
>  			goto out;
>  		}
> +		if (iocb->ki_flags & IOCB_UNCACHED) {
> +			__SetPageLocked(page);
> +			page->mapping = mapping;
> +			page->index = index;
> +			clear_mapping = true;
> +			goto readpage;
> +		}

And we go through the ->readpage path, which means we a building and
issuing a single bio per page we miss. THis is highly inefficient,
and relies on bio merging to form large IOs in the block layer.
Sure, you won't notice the impact if all you do is PAGE_SIZE read()
calls, but if you are doing multi-megabyte IOs because you have
spinning rust storage then it will make a big difference.

IOWs, this does not take advantage of either the mpage_readpages or
the iomap_readpages many-pages-to-a-bio read optimisations that the
readahead path gives us, so there's more CPU and IO overhead from this
RWF_UNCACHED path than there is from the normal readahead based
buffered IO path.

Oh, and if we have random pages in the cache, this
single-page-at-atime approach that will break up large sequential
IOs in smaller, non-sequential IOs that will be dispatched
separately. It's much more CPU efficient to do a single large IO
that pulls new data into the random page in middle of the range than
it is to build, issue and complete two separate IOs. It's also much
more friendly to spinning rust to do a single large IO than two
small separated-by-a-few-sectors IOs...

IMO, this looks like an implementation hyper-focussed on brute
performance of PAGE_SIZE IOs and it compromises on coherency and
efficiency to attain that performance. Quite frankly, if performance
is so critical that you need to compromise the IO path in the way,
then just use direct IO.

Let's get a sane, clean, efficient page cache coherent read IO path
in place for RWF_UNCACHED, then optimise it for performance. If it's
done right, then the page cache/xarray insert/remove overhead should
largely disappear in the noise.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
