Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5D45E59AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 05:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiIVDkg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 23:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIVDkf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:40:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE72375CF3;
        Wed, 21 Sep 2022 20:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31972B8341F;
        Thu, 22 Sep 2022 03:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C45C433C1;
        Thu, 22 Sep 2022 03:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663818029;
        bh=kQJ543Kb+Jf86+JnASXTVDwVcmFM2qZt1HLFcyzMyes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZRymX5YiiZIeofuGWerayoGMEVfZrrnhWAU/s6AkEuGxwQ5MuoXnMNE+hsOepP9k
         Lc99q2bchBbewuq+FkYnpCAXBwpeBQeJvewxO6HPVkeuCENyi5K5FmM5eHKMfaDdMP
         wFtYEfZTDQKx9aJUt+q6tZqRadQ8LtBFGjy9QJ2KMCxMUyWPzCouteH9wuOfBmgJG4
         PyYeXcKqD0UdjK8HNalfPWgKSZpW2DP2QEhzaSLHXw7Hd/FIdSCDOmQdPVv9fcEvjB
         ol6jGGBhYcyRZVgtSDUYliOcjOnBW3iY2kzofvv83r1fiYYDE5mbbuBds4Tn88u7Jg
         BqRdUhjvyp9wg==
Date:   Wed, 21 Sep 2022 20:40:29 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: write iomap validity checks
Message-ID: <YyvZLTvayJT0xAPr@magnolia>
References: <20220921082959.1411675-1-david@fromorbit.com>
 <20220921082959.1411675-2-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921082959.1411675-2-david@fromorbit.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 06:29:58PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> A recent multithreaded write data corruption has been uncovered in
> the iomap write code. The core of the problem is partial folio
> writes can be flushed to disk while a new racing write can map it
> and fill the rest of the page:
> 
> writeback			new write
> 
> allocate blocks
>   blocks are unwritten
> submit IO
> .....
> 				map blocks
> 				iomap indicates UNWRITTEN range
> 				loop {
> 				  lock folio
> 				  copyin data
> .....
> IO completes
>   runs unwritten extent conv
>     blocks are marked written
> 				  <iomap now stale>
> 				  get next folio
> 				}
> 
> Now add memory pressure such that memory reclaim evicts the
> partially written folio that has already been written to disk.
> 
> When the new write finally gets to the last partial page of the new
> write, it does not find it in cache, so it instantiates a new page,
> sees the iomap is unwritten, and zeros the part of the page that
> it does not have data from. This overwrites the data on disk that
> was originally written.
> 
> The full description of the corruption mechanism can be found here:
> 
> https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/
> 
> To solve this problem, we need to check whether the iomap is still
> valid after we lock each folio during the write. We have to do it
> after we lock the page so that we don't end up with state changes
> occurring while we wait for the folio to be locked.
> 
> Hence we need a mechanism to be able to check that the cached iomap
> is still valid (similar to what we already do in buffered
> writeback), and we need a way for ->begin_write to back out and
> tell the high level iomap iterator that we need to remap the
> remaining write range.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 53 +++++++++++++++++++++++++++++++++---------
>  fs/iomap/iter.c        | 33 ++++++++++++++++++++++++--
>  include/linux/iomap.h  | 17 ++++++++++++++
>  3 files changed, 90 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ca5c62901541..44c806d46be4 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -584,8 +584,9 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
>  	return iomap_read_inline_data(iter, folio);
>  }
>  
> -static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
> -		size_t len, struct folio **foliop)
> +static int iomap_write_begin(struct iomap_iter *iter,
> +		const struct iomap_ops *ops, loff_t pos, size_t len,
> +		struct folio **foliop)
>  {
>  	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> @@ -618,6 +619,27 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  		status = (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
>  		goto out_no_page;
>  	}
> +
> +	/*
> +	 * Now we have a locked folio, before we do anything with it we need to
> +	 * check that the iomap we have cached is not stale. The inode extent
> +	 * mapping can change due to concurrent IO in flight (e.g.
> +	 * IOMAP_UNWRITTEN state can change and memory reclaim could have

Earlier, we were talking this specific problem involves zeroing folio
areas around a folio-unaligned write to a !uptodate folio backed by an
unwritten extent.  Is the scope of this corruption still limited to
*just* that case?  Or does it affect any write to a new mapping or
beyond EOF?  Can it affect a write to an extent that somehow gets
switched to unwritten or a hole after the mapping has been sampled?

> +	 * reclaimed a previously partially written page at this index after IO
> +	 * completion before this write reaches this file offset) and hence we
> +	 * could do the wrong thing here (zero a page range incorrectly or fail
> +	 * to zero) and corrupt data.
> +	 */
> +	if (ops->iomap_valid) {
> +		bool iomap_valid = ops->iomap_valid(iter->inode, &iter->iomap);

At this point in the (xfs) buffered write cycle, we've taken the IOLOCK
and folio lock.  Is it possible for ->iomap_valid to detect that the
mapping is no longer valid, trylock the ILOCK, and update the mapping so
that we don't have to drop the folio lock and go all the way back to
->iomap_begin?

If we have to pay the cost of an indirect call, we could try to update
the mapping if one's available, right?  Obviously, if we don't find a
mapping we're probably going to have to drop the folio lock and allocate
more space.

> +
> +		if (!iomap_valid) {
> +			iter->iomap.flags |= IOMAP_F_STALE;
> +			status = 0;
> +			goto out_unlock;
> +		}
> +	}
> +
>  	if (pos + len > folio_pos(folio) + folio_size(folio))
>  		len = folio_pos(folio) + folio_size(folio) - pos;
>  
> @@ -727,7 +749,8 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  	return ret;
>  }
>  
> -static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> +static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
> +		const struct iomap_ops *ops)
>  {
>  	loff_t length = iomap_length(iter);
>  	loff_t pos = iter->pos;
> @@ -770,9 +793,11 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  			break;
>  		}
>  
> -		status = iomap_write_begin(iter, pos, bytes, &folio);
> +		status = iomap_write_begin(iter, ops, pos, bytes, &folio);
>  		if (unlikely(status))
>  			break;
> +		if (iter->iomap.flags & IOMAP_F_STALE)
> +			break;
>  
>  		page = folio_file_page(folio, pos >> PAGE_SHIFT);
>  		if (mapping_writably_mapped(mapping))
> @@ -825,14 +850,15 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  		iter.flags |= IOMAP_NOWAIT;
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = iomap_write_iter(&iter, i);
> +		iter.processed = iomap_write_iter(&iter, i, ops);
>  	if (iter.pos == iocb->ki_pos)
>  		return ret;
>  	return iter.pos - iocb->ki_pos;
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>  
> -static loff_t iomap_unshare_iter(struct iomap_iter *iter)
> +static loff_t iomap_unshare_iter(struct iomap_iter *iter,
> +		const struct iomap_ops *ops)
>  {
>  	struct iomap *iomap = &iter->iomap;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> @@ -853,9 +879,11 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
>  		struct folio *folio;
>  
> -		status = iomap_write_begin(iter, pos, bytes, &folio);
> +		status = iomap_write_begin(iter, ops, pos, bytes, &folio);
>  		if (unlikely(status))
>  			return status;
> +		if (iter->iomap.flags & IOMAP_F_STALE)
> +			break;
>  
>  		status = iomap_write_end(iter, pos, bytes, bytes, folio);
>  		if (WARN_ON_ONCE(status == 0))
> @@ -886,12 +914,13 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  	int ret;
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = iomap_unshare_iter(&iter);
> +		iter.processed = iomap_unshare_iter(&iter, ops);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_unshare);
>  
> -static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> +static loff_t iomap_zero_iter(struct iomap_iter *iter,
> +		const struct iomap_ops *ops, bool *did_zero)
>  {
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	loff_t pos = iter->pos;
> @@ -908,9 +937,11 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		size_t offset;
>  		size_t bytes = min_t(u64, SIZE_MAX, length);
>  
> -		status = iomap_write_begin(iter, pos, bytes, &folio);
> +		status = iomap_write_begin(iter, ops, pos, bytes, &folio);
>  		if (status)
>  			return status;
> +		if (iter->iomap.flags & IOMAP_F_STALE)
> +			break;
>  
>  		offset = offset_in_folio(folio, pos);
>  		if (bytes > folio_size(folio) - offset)
> @@ -946,7 +977,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  	int ret;
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = iomap_zero_iter(&iter, did_zero);
> +		iter.processed = iomap_zero_iter(&iter, ops, did_zero);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_zero_range);
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index a1c7592d2ade..370e8a23c1b8 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -7,12 +7,36 @@
>  #include <linux/iomap.h>
>  #include "trace.h"
>  
> +/*
> + * Advance to the next range we need to map.
> + *
> + * If the iomap is marked IOMAP_F_STALE, it means the existing map was not fully
> + * processed - it was aborted because the extent the iomap spanned may have been
> + * changed during the operation. In this case, the iteration behaviour is to
> + * remap the unprocessed range of the iter, and that means we may need to remap
> + * even when we've made no progress (i.e. iter->processed = 0). Hence the
> + * "finished iterating" case needs to distinguish between
> + * (processed = 0) meaning we are done and (processed = 0 && stale) meaning we
> + * need to remap the entire remaining range.
> + *
> + * We also need to preserve IOMAP_F_STALE on the iomap so that the next call
> + * to iomap_begin() knows that it is reprocessing a stale map. Similarly, we
> + * need to preserve IOMAP_F_NEW as the filesystem may not realise that it
> + * is remapping a region that it allocated in the previous cycle and we still
> + * need to initialise partially filled pages within the remapped range.

Must the ->iomap_begin implementation also take care to carry-over the
IOMAP_F_NEW to the mapping if IOMAP_F_STALE is set?  Is it responsible
for dropping IOMAP_F_STALE, or will iomap_iter* do that?

> + *
> + */
>  static inline int iomap_iter_advance(struct iomap_iter *iter)
>  {
> +	bool stale = iter->iomap.flags & IOMAP_F_STALE;
> +	int new = iter->iomap.flags & IOMAP_F_NEW;
> +
>  	/* handle the previous iteration (if any) */
>  	if (iter->iomap.length) {
> -		if (iter->processed <= 0)
> +		if (iter->processed < 0)
>  			return iter->processed;
> +		if (!iter->processed && !stale)
> +			return 0;
>  		if (WARN_ON_ONCE(iter->processed > iomap_length(iter)))
>  			return -EIO;
>  		iter->pos += iter->processed;
> @@ -25,6 +49,8 @@ static inline int iomap_iter_advance(struct iomap_iter *iter)
>  	iter->processed = 0;
>  	memset(&iter->iomap, 0, sizeof(iter->iomap));
>  	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
> +	if (stale)
> +		iter->iomap.flags |= IOMAP_F_STALE | new;
>  	return 1;
>  }
>  
> @@ -33,6 +59,7 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
>  	WARN_ON_ONCE(iter->iomap.offset > iter->pos);
>  	WARN_ON_ONCE(iter->iomap.length == 0);
>  	WARN_ON_ONCE(iter->iomap.offset + iter->iomap.length <= iter->pos);
> +	WARN_ON_ONCE(iter->iomap.flags & IOMAP_F_STALE);
>  
>  	trace_iomap_iter_dstmap(iter->inode, &iter->iomap);
>  	if (iter->srcmap.type != IOMAP_HOLE)
> @@ -68,8 +95,10 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  
>  	trace_iomap_iter(iter, ops, _RET_IP_);
>  	ret = iomap_iter_advance(iter);
> -	if (ret <= 0)
> +	if (ret < 0)
>  		return ret;
> +	if (!ret && !(iter->iomap.flags & IOMAP_F_STALE))
> +		return 0;
>  
>  	ret = ops->iomap_begin(iter->inode, iter->pos, iter->len, iter->flags,
>  			       &iter->iomap, &iter->srcmap);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 238a03087e17..308931f0840a 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -62,8 +62,13 @@ struct vm_fault;
>   *
>   * IOMAP_F_SIZE_CHANGED indicates to the iomap_end method that the file size
>   * has changed as the result of this write operation.
> + *
> + * IOMAP_F_STALE indicates that the iomap is not valid any longer and the file
> + * range it covers needs to be remapped by the high level before the operation
> + * can proceed.

I think it might be worth mentioning that /any/ iomap_iter caller can
set this flag in the loop body and kick things back to ->iomap_begin.

>   */
>  #define IOMAP_F_SIZE_CHANGED	0x100
> +#define IOMAP_F_STALE		0x200
>  
>  /*
>   * Flags from 0x1000 up are for file system specific usage:
> @@ -165,6 +170,18 @@ struct iomap_ops {

Hmmmm I wish this ops struct had been named better.  Oh well.

--D

>  	 */
>  	int (*iomap_end)(struct inode *inode, loff_t pos, loff_t length,
>  			ssize_t written, unsigned flags, struct iomap *iomap);
> +
> +	/*
> +	 * Check that the cached iomap still maps correctly to the filesystem's
> +	 * internal extent map. FS internal extent maps can change while iomap
> +	 * is iterating a cached iomap, so this hook allows iomap to detect that
> +	 * the iomap needs to be refreshed during a long running write
> +	 * operation.
> +	 *
> +	 * This is called with the folio over the specified file position
> +	 * held locked by the iomap code.
> +	 */
> +	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
>  };
>  
>  /**
> -- 
> 2.37.2
> 
