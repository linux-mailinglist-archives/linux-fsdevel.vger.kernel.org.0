Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7AA11A05F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 02:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfLKBOU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 20:14:20 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:43833 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726364AbfLKBOU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:14:20 -0500
Received: from dread.disaster.area (pa49-195-139-249.pa.nsw.optusnet.com.au [49.195.139.249])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6BDCB3A17C3;
        Wed, 11 Dec 2019 12:14:16 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ieqZz-0006ks-OJ; Wed, 11 Dec 2019 12:14:15 +1100
Date:   Wed, 11 Dec 2019 12:14:15 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com
Subject: Re: [PATCH 5/5] iomap: support RWF_UNCACHED for buffered writes
Message-ID: <20191211011415.GE19213@dread.disaster.area>
References: <20191210204304.12266-1-axboe@kernel.dk>
 <20191210204304.12266-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210204304.12266-6-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=KoypXv6BqLCQNZUs2nCMWg==:117 a=KoypXv6BqLCQNZUs2nCMWg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=jrjSQ4xLuvOdQEvsSiwA:9 a=1EYIUCybxSlyurgE:21
        a=lqDuZKyFASzqTwhE:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 01:43:04PM -0700, Jens Axboe wrote:
> This adds support for RWF_UNCACHED for file systems using iomap to
> perform buffered writes. We use the generic infrastructure for this,
> by tracking pages we created and calling write_drop_cached_pages()
> to issue writeback and prune those pages.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
.....
>  static loff_t
>  iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
>  {
> +	struct address_space *mapping = inode->i_mapping;
>  	struct iov_iter *i = data;
> +	struct pagevec pvec;
>  	long status = 0;
>  	ssize_t written = 0;
>  
> +	pagevec_init(&pvec);
> +

Ok, so the actor is called after we've already mapped and allocated
an extent of arbitrary length. It may be a delalloc extent, it might
be unwritten, it could be a COW mapping, etc.

>  	do {
>  		struct page *page;
>  		unsigned long offset;	/* Offset into pagecache page */
>  		unsigned long bytes;	/* Bytes to write to page */
>  		size_t copied;		/* Bytes copied from user */
> +		bool drop_page = false;	/* drop page after IO */
> +		unsigned lflags = flags;
>  
>  		offset = offset_in_page(pos);
>  		bytes = min_t(unsigned long, PAGE_SIZE - offset,
> @@ -832,10 +851,17 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  			break;
>  		}
>  
> -		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap,
> -				srcmap);
> -		if (unlikely(status))
> +retry:
> +		status = iomap_write_begin(inode, pos, bytes, lflags, &page,
> +						iomap, srcmap);
> +		if (unlikely(status)) {
> +			if (status == -ENOMEM && (lflags & IOMAP_UNCACHED)) {
> +				drop_page = true;
> +				lflags &= ~IOMAP_UNCACHED;
> +				goto retry;
> +			}
>  			break;
> +		}
>  
>  		if (mapping_writably_mapped(inode->i_mapping))
>  			flush_dcache_page(page);
> @@ -844,10 +870,16 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  
>  		flush_dcache_page(page);
>  
> +		if (drop_page)
> +			get_page(page);
> +
>  		status = iomap_write_end(inode, pos, bytes, copied, page, iomap,
>  				srcmap);
> -		if (unlikely(status < 0))
> +		if (unlikely(status < 0)) {
> +			if (drop_page)
> +				put_page(page);
>  			break;
> +		}
>  		copied = status;
>  
>  		cond_resched();
> @@ -864,15 +896,29 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  			 */
>  			bytes = min_t(unsigned long, PAGE_SIZE - offset,
>  						iov_iter_single_seg_count(i));
> +			if (drop_page)
> +				put_page(page);
>  			goto again;
>  		}
> +
> +		if (drop_page &&
> +		    ((pos >> PAGE_SHIFT) != ((pos + copied) >> PAGE_SHIFT))) {
> +			if (!pagevec_add(&pvec, page))
> +				write_drop_cached_pages(&pvec, mapping);
> +		} else {
> +			if (drop_page)
> +				put_page(page);
> +			balance_dirty_pages_ratelimited(inode->i_mapping);
> +		}

This looks like it's a problem: this is going to write the
data, which can cause the extent mapping of the file to change
beyond the range that was written (e.g. due to speculative delayed
allocation) and so the iomap we have already cached to direct write
behaviour may now be stale.

IOWs, to be safe we need to terminate the write loop at this point,
return to iomap_apply() and remap the range we are writing into so
that we don't end up using a stale iomap. That kinda defeats the
purpose of iomap - we are trying to do a single extent mapping per
IO instead of per-page, and this pulls it back to an iomap per 16
pages for large user IOs. And it has the issues with breaking
delayed allocation optimisations, too.

Hence, IMO, this is the wrong layer in iomap to be dealing with
writeback and cache residency for uncached IO. We should be caching
residency/invalidation at a per-IO level, not a per-page level.

Sure, have the write actor return a flag (e.g. in the iomap) to say
that it encountered cached pages so that we can decide whether or
not to invalidate the entire range we just wrote in iomap_apply, but
doing it between mappings in iomap_apply means that the writeback is
done once per user IO, and cache invalidation only occurs if no
cached pages were encountered during that IO. i.e. add this to
iomap_apply() after ops->iomap_end() has been called:


	if (flags & RWF_UNCACHED) {
		ret = filemap_write_and_wait_range(mapping, start, end);
		if (ret)
			goto out;

		if (!drop_cache)
			goto out;

		/*
		 * Try to invalidate cache pages for the range we
		 * just wrote. We don't care if invalidation fails
		 * as the write has still worked and leaving clean
		 * uptodate pages * in the page cache isn't a
		 * corruption vector for uncached IO.
		 */
		invalidate_inode_pages2_range(mapping,
				start >> PAGE_SHIFT, end >> PAGE_SHIFT);
	}
out:
	return written ? written : ret;
}

Note that this doesn't solve the write error return issue. i.e.
if filemap_write_and_wait_range() fails, should that error be
returned or ignored?

And that leads to my next question: what data integrity guarantees
does RWF_UNCACHED give? What if the underlying device has a volatile
write cache or we dirtied metadata during block allocation? i.e.  to
a user, "UNCACHED" kinda implies that the write has ended up on
stable storage because they are saying "do not cache this data". To
me, none of this implementation guarantees data integrity, and users
would still need O_DSYNC or fsync() with RWF_UNCACHED IO. That seems
sane to me (same as direct io requirements) but whatever is decided
here, it will need to be spelled out clearly in the man page so that 
users don't get it wrong.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
