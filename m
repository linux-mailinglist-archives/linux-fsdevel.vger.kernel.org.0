Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C625616993
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiKBQps (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiKBQpc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:45:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FD2120AA;
        Wed,  2 Nov 2022 09:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74DFCB821A3;
        Wed,  2 Nov 2022 16:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FD0C433D6;
        Wed,  2 Nov 2022 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667407291;
        bh=SN1YunHOK4ZDzi/dLD2Sp5Y707LvWK3elquaycOHuN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QuqAD8RZHRG6/ET2sz1RQm05yrbE1GLDLVnVTDCNbWgRLVqtpm+54HYwrdoC4/1Vk
         c89E7I6cI2TyzzHabT2GnLeGd7SqxcEgStib4BxqCoqc0oYB3LGBBP0gCYysllNFFn
         5WVca1yStziyA684l/CUoR2ZNk5zbSzw7nvuAzjCR/fU8pVPy2HVKcP2z61FFXH09B
         Z+VpGVc8pmfU1yw0+5TW8xYc4wrf8+vIt3CbSzPmgnHTvuZSVGkHOK9D1Ox8m5RX99
         SyxiXeR/ip6CU67sBObUQv6qS8fJ40Fd0EJ6GjUkhlNePd7velAOwfwwpYEI2BoJ5P
         u01JtpcngvBag==
Date:   Wed, 2 Nov 2022 09:41:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/7] xfs: buffered write failure should not truncate the
 page cache
Message-ID: <Y2KdumAbAF0mV0sh@magnolia>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-5-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101003412.3842572-5-david@fromorbit.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 11:34:09AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> xfs_buffered_write_iomap_end() currently invalidates the page cache
> over the unused range of the delalloc extent it allocated. While the
> write allocated the delalloc extent, it does not own it exclusively
> as the write does not hold any locks that prevent either writeback
> or mmap page faults from changing the state of either the page cache
> or the extent state backing this range.
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

Same dumb question as hch -- why do we need to punch out the nondirty
pagecache after a failed write?  If the folios are uptodate then we're
evicting cache unnecessarily, and if they're !uptodate can't we let
reclaim do the dirty work for us?

I don't know if there are hysterical raisins for this or if the goal is
to undo memory consumption after a write failure?  If we're stale-ing
the write because the iomapping changed, why not leave the folio where
it is, refresh the iomapping, and come back to (possibly?) the same
folio?

--D

> TO do this, we have to walk the page cache over the range of the
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
>  fs/xfs/xfs_iomap.c | 151 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 141 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 7bb55dbc19d3..2d48fcc7bd6f 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1134,6 +1134,146 @@ xfs_buffered_write_delalloc_punch(
>  				end_fsb - start_fsb);
>  }
>  
> +/*
> + * Scan the data range passed to us for dirty page cache folios. If we find a
> + * dirty folio, punch out the preceeding range and update the offset from which
> + * the next punch will start from.
> + *
> + * We can punch out clean pages because they either contain data that has been
> + * written back - in which case the delalloc punch over that range is a no-op -
> + * or they have been read faults in which case they contain zeroes and we can
> + * remove the delalloc backing range and any new writes to those pages will do
> + * the normal hole filling operation...
> + *
> + * This makes the logic simple: we only need to keep the delalloc extents only
> + * over the dirty ranges of the page cache.
> + */
> +static int
> +xfs_buffered_write_delalloc_scan(
> +	struct inode		*inode,
> +	loff_t			*punch_start_byte,
> +	loff_t			start_byte,
> +	loff_t			end_byte)
> +{
> +	loff_t			offset = start_byte;
> +
> +	while (offset < end_byte) {
> +		struct folio	*folio;
> +
> +		/* grab locked page */
> +		folio = filemap_lock_folio(inode->i_mapping, offset >> PAGE_SHIFT);
> +		if (!folio) {
> +			offset = ALIGN_DOWN(offset, PAGE_SIZE) + PAGE_SIZE;
> +			continue;
> +		}
> +
> +		/* if dirty, punch up to offset */
> +		if (folio_test_dirty(folio)) {
> +			if (offset > *punch_start_byte) {
> +				int	error;
> +
> +				error = xfs_buffered_write_delalloc_punch(inode,
> +						*punch_start_byte, offset);
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
> +		offset = folio_next_index(folio) << PAGE_SHIFT;
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
> + */
> +static int
> +xfs_buffered_write_delalloc_release(
> +	struct inode		*inode,
> +	loff_t			start_byte,
> +	loff_t			end_byte)
> +{
> +	loff_t			punch_start_byte = start_byte;
> +	int			error = 0;
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
> +		ASSERT(start_byte >= punch_start_byte);
> +		ASSERT(start_byte < end_byte);
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
> +		ASSERT(data_end > start_byte);
> +		ASSERT(data_end <= end_byte);
> +
> +		error = xfs_buffered_write_delalloc_scan(inode,
> +				&punch_start_byte, start_byte, data_end);
> +		if (error)
> +			goto out_unlock;
> +
> +		/* The next data search starts at the end of this one. */
> +		start_byte = data_end;
> +	}
> +
> +	if (punch_start_byte < end_byte)
> +		error = xfs_buffered_write_delalloc_punch(inode,
> +				punch_start_byte, end_byte);
> +out_unlock:
> +	filemap_invalidate_unlock(inode->i_mapping);
> +	return error;
> +}
> +
>  static int
>  xfs_buffered_write_iomap_end(
>  	struct inode		*inode,
> @@ -1179,16 +1319,7 @@ xfs_buffered_write_iomap_end(
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
> -	error = xfs_buffered_write_delalloc_punch(inode, start_byte, end_byte);
> -	filemap_invalidate_unlock(inode->i_mapping);
> +	error = xfs_buffered_write_delalloc_release(inode, start_byte, end_byte);
>  	if (error && !xfs_is_shutdown(mp)) {
>  		xfs_alert(mp, "%s: unable to clean up ino 0x%llx",
>  			__func__, XFS_I(inode)->i_ino);
> -- 
> 2.37.2
> 
