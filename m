Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C63B62E459
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 19:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbiKQSgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 13:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiKQSgD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:36:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB74F58;
        Thu, 17 Nov 2022 10:36:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57322621C2;
        Thu, 17 Nov 2022 18:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9421CC433D6;
        Thu, 17 Nov 2022 18:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668710160;
        bh=Urs7XE83NkUPQcn4DkJeXqioVogWAJ9RpRxT+/nhtps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cVbbY43ys69Lfd2oWLOvZvPg1xs18GXUFmnw6D+Kl1F7wNm48oPKZmo+v2MJWxh42
         MU8P6KjCUjKPzDOgO/Cwcai3c35baGDmCaa+FQO4L0Pwv7eTdOqtSs/punPwYOgr6j
         5GTXeYIr96dRpxEIVlL4hPLPJoYJFNb5rU+Ispc8N4LfGLfNMy1v59wDXZ+9mS5Acv
         mVcLV5tNqMDytKLQF83dhaJ/2AL+sJlzCX0bJLMBeK5sG0R1F3ZpMeqzkLS1uptX8b
         06NczGPSIDlOeaOgbZsTc1pvB9NwmftDamt8x3jPHvJvDu3AQz7RsIi1B2KfAglh78
         Q6ns7ngHzOF2g==
Date:   Thu, 17 Nov 2022 10:36:00 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/9] iomap: buffered write failure should not truncate
 the page cache
Message-ID: <Y3Z/EMhb+rFLPRbw@magnolia>
References: <20221117055810.498014-1-david@fromorbit.com>
 <20221117055810.498014-6-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117055810.498014-6-david@fromorbit.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 17, 2022 at 04:58:06PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> iomap_file_buffered_write_punch_delalloc() currently invalidates the
> page cache over the unused range of the delalloc extent that was
> allocated. While the write allocated the delalloc extent, it does
> not own it exclusively as the write does not hold any locks that
> prevent either writeback or mmap page faults from changing the state
> of either the page cache or the extent state backing this range.
> 
> Whilst xfs_bmap_punch_delalloc_range() already handles races in
> extent conversion - it will only punch out delalloc extents and it
> ignores any other type of extent - the page cache truncate does not
> discriminate between data written by this write or some other task.
> As a result, truncating the page cache can result in data corruption
> if the write races with mmap modifications to the file over the same
> range.
> 
> generic/346 exercises this workload, and if we randomly fail writes
> (as will happen when iomap gets stale iomap detection later in the
> patchset), it will randomly corrupt the file data because it removes
> data written by mmap() in the same page as the write() that failed.
> 
> Hence we do not want to punch out the page cache over the range of
> the extent we failed to write to - what we actually need to do is
> detect the ranges that have dirty data in cache over them and *not
> punch them out*.
> 
> To do this, we have to walk the page cache over the range of the
> delalloc extent we want to remove. This is made complex by the fact
> we have to handle partially up-to-date folios correctly and this can
> happen even when the FSB size == PAGE_SIZE because we now support
> multi-page folios in the page cache.
> 
> Because we are only interested in discovering the edges of data
> ranges in the page cache (i.e. hole-data boundaries) we can make use
> of mapping_seek_hole_data() to find those transitions in the page
> cache. As we hold the invalidate_lock, we know that the boundaries
> are not going to change while we walk the range. This interface is
> also byte-based and is sub-page block aware, so we can find the data
> ranges in the cache based on byte offsets rather than page, folio or
> fs block sized chunks. This greatly simplifies the logic of finding
> dirty cached ranges in the page cache.
> 
> Once we've identified a range that contains cached data, we can then
> iterate the range folio by folio. This allows us to determine if the
> data is dirty and hence perform the correct delalloc extent punching
> operations. The seek interface we use to iterate data ranges will
> give us sub-folio start/end granularity, so we may end up looking up
> the same folio multiple times as the seek interface iterates across
> each discontiguous data region in the folio.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 187 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 169 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 77f391fd90ca..028cdf115477 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -832,6 +832,151 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>  
> +/*
> + * Scan the data range passed to us for dirty page cache folios. If we find a
> + * dirty folio, punch out the preceeding range and update the offset from which
> + * the next punch will start from.
> + *
> + * We can punch out clean pages because they either contain data that has been

I got briefly confused by this when I read this in the v2 patchset,
because I thought we were punching out clean pages, not the delalloc
iomapping under them.  Maybe:

"We can punch out storage reservations under clean pages..."

> + * written back - in which case the delalloc punch over that range is a no-op -
> + * or they have been read faults in which case they contain zeroes and we can
> + * remove the delalloc backing range and any new writes to those pages will do
> + * the normal hole filling operation...
> + *
> + * This makes the logic simple: we only need to keep the delalloc extents only
> + * over the dirty ranges of the page cache.
> + *
> + * This function uses [start_byte, end_byte) intervals (i.e. open ended) to
> + * simplify range iterations.
> + */
> +static int iomap_write_delalloc_scan(struct inode *inode,
> +		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
> +		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
> +{
> +	while (start_byte < end_byte) {
> +		struct folio	*folio;
> +
> +		/* grab locked page */
> +		folio = filemap_lock_folio(inode->i_mapping,
> +				start_byte >> PAGE_SHIFT);
> +		if (!folio) {
> +			start_byte = ALIGN_DOWN(start_byte, PAGE_SIZE) +
> +					PAGE_SIZE;
> +			continue;
> +		}
> +
> +		/* if dirty, punch up to offset */
> +		if (folio_test_dirty(folio)) {
> +			if (start_byte > *punch_start_byte) {
> +				int	error;
> +
> +				error = punch(inode, *punch_start_byte,
> +						start_byte - *punch_start_byte);
> +				if (error) {
> +					folio_unlock(folio);
> +					folio_put(folio);
> +					return error;
> +				}
> +			}
> +
> +			/*
> +			 * Make sure the next punch start is correctly bound to
> +			 * the end of this data range, not the end of the folio.
> +			 */
> +			*punch_start_byte = min_t(loff_t, end_byte,
> +					folio_next_index(folio) << PAGE_SHIFT);
> +		}
> +
> +		/* move offset to start of next folio in range */
> +		start_byte = folio_next_index(folio) << PAGE_SHIFT;
> +		folio_unlock(folio);
> +		folio_put(folio);
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Punch out all the delalloc blocks in the range given except for those that
> + * have dirty data still pending in the page cache - those are going to be
> + * written and so must still retain the delalloc backing for writeback.
> + *
> + * As we are scanning the page cache for data, we don't need to reimplement the
> + * wheel - mapping_seek_hole_data() does exactly what we need to identify the
> + * start and end of data ranges correctly even for sub-folio block sizes. This
> + * byte range based iteration is especially convenient because it means we don't
> + * have to care about variable size folios, nor where the start or end of the
> + * data range lies within a folio, if they lie within the same folio or even if
> + * there are multiple discontiguous data ranges within the folio.
> + *
> + * Intervals are of the form [start_byte, end_byte) (i.e. open ended) because
> + * it matches the intervals returned by mapping_seek_hole_data(). i.e. SEEK_DATA
> + * returns the start of a data range (start_byte), and SEEK_HOLE(start_byte)
> + * returns the end of the data range (data_end). Using closed intervals would
> + * require sprinkling this code with magic "+ 1" and "- 1" arithmetic and expose
> + * the code to subtle off-by-one bugs....
> + */
> +static int iomap_write_delalloc_release(struct inode *inode,
> +		loff_t start_byte, loff_t end_byte,
> +		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
> +{
> +	loff_t punch_start_byte = start_byte;
> +	int error = 0;
> +
> +	/*
> +	 * Lock the mapping to avoid races with page faults re-instantiating
> +	 * folios and dirtying them via ->page_mkwrite whilst we walk the
> +	 * cache and perform delalloc extent removal. Failing to do this can
> +	 * leave dirty pages with no space reservation in the cache.
> +	 */
> +	filemap_invalidate_lock(inode->i_mapping);
> +	while (start_byte < end_byte) {
> +		loff_t		data_end;
> +
> +		start_byte = mapping_seek_hole_data(inode->i_mapping,
> +				start_byte, end_byte, SEEK_DATA);
> +		/*
> +		 * If there is no more data to scan, all that is left is to
> +		 * punch out the remaining range.
> +		 */
> +		if (start_byte == -ENXIO || start_byte == end_byte)
> +			break;
> +		if (start_byte < 0) {
> +			error = start_byte;
> +			goto out_unlock;
> +		}
> +		WARN_ON_ONCE(start_byte < punch_start_byte);
> +		WARN_ON_ONCE(start_byte > end_byte);
> +
> +		/*
> +		 * We find the end of this contiguous cached data range by
> +		 * seeking from start_byte to the beginning of the next hole.
> +		 */
> +		data_end = mapping_seek_hole_data(inode->i_mapping, start_byte,
> +				end_byte, SEEK_HOLE);
> +		if (data_end < 0) {
> +			error = data_end;
> +			goto out_unlock;
> +		}
> +		WARN_ON_ONCE(data_end <= start_byte);
> +		WARN_ON_ONCE(data_end > end_byte);
> +
> +		error = iomap_write_delalloc_scan(inode, &punch_start_byte,
> +				start_byte, data_end, punch);
> +		if (error)
> +			goto out_unlock;
> +
> +		/* The next data search starts at the end of this one. */
> +		start_byte = data_end;
> +	}
> +
> +	if (punch_start_byte < end_byte)
> +		error = punch(inode, punch_start_byte,
> +				end_byte - punch_start_byte);
> +out_unlock:
> +	filemap_invalidate_unlock(inode->i_mapping);
> +	return error;
> +}
> +
>  /*
>   * When a short write occurs, the filesystem may need to remove reserved space
>   * that was allocated in ->iomap_begin from it's ->iomap_end method. For
> @@ -842,18 +987,34 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>   * allocated for this iomap.
>   *
>   * This function uses [start_byte, end_byte) intervals (i.e. open ended) to
> - * simplify range iterations, but converts them back to {offset,len} tuples for
> - * the punch callback.
> + * simplify range iterations.
> + *
> + * The punch() callback *must* only punch delalloc extents in the range passed
> + * to it. It must skip over all other types of extents in the range and leave
> + * them completely unchanged. It must do this punch atomically with respect to
> + * other extent modifications.
> + *
> + * The punch() callback may be called with a folio locked to prevent writeback
> + * extent allocation racing at the edge of the range we are currently punching.
> + * The locked folio may or may not cover the range being punched, so it is not
> + * safe for the punch() callback to lock folios itself.
> + *
> + * Lock order is:
> + *
> + * inode->i_rwsem (shared or exclusive)
> + *   inode->i_mapping->invalidate_lock (exclusive)
> + *     folio_lock()
> + *       ->punch
> + *         internal filesystem allocation lock

Yay locking diagrams!

>   */
>  int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
>  		struct iomap *iomap, loff_t offset, loff_t length,
>  		ssize_t written,
>  		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
>  {
> -	loff_t			start_byte;
> -	loff_t			end_byte;
> -	int			blocksize = 1 << inode->i_blkbits;
> -	int			error = 0;
> +	loff_t start_byte;
> +	loff_t end_byte;
> +	int blocksize = 1 << inode->i_blkbits;

int blocksize = i_blocksize(inode);

With all those bits fixed up I think I'm ready (again) to send this to
the fstests cloud and see what happens.  If you end up doing a v4 then
please fix these things before submitting them.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
>  	if (iomap->type != IOMAP_DELALLOC)
>  		return 0;
> @@ -877,18 +1038,8 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
>  	if (start_byte >= end_byte)
>  		return 0;
>  
> -	/*
> -	 * Lock the mapping to avoid races with page faults re-instantiating
> -	 * folios and dirtying them via ->page_mkwrite between the page cache
> -	 * truncation and the delalloc extent removal. Failing to do this can
> -	 * leave dirty pages with no space reservation in the cache.
> -	 */
> -	filemap_invalidate_lock(inode->i_mapping);
> -	truncate_pagecache_range(inode, start_byte, end_byte - 1);
> -	error = punch(inode, start_byte, end_byte - start_byte);
> -	filemap_invalidate_unlock(inode->i_mapping);
> -
> -	return error;
> +	return iomap_write_delalloc_release(inode, start_byte, end_byte,
> +					punch);
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
>  
> -- 
> 2.37.2
> 
