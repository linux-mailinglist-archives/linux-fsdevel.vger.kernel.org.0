Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1713862AFB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 00:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiKOXxu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 18:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKOXxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:53:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C621BC15;
        Tue, 15 Nov 2022 15:53:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBC0BB81B58;
        Tue, 15 Nov 2022 23:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76939C433D6;
        Tue, 15 Nov 2022 23:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668556423;
        bh=tinpog2j2TyOwTj0/2DkQxmgA7ouFbzuhWwiDwP3sD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GYwkLPL4a+wEKDYPunTywJdNP9aoJRgEJGYmi6LMCUlMfSh23ktgwWDYuQbhDPHRP
         j0m1mvNJ6Oq4jeAThlq1hadt3ueR9cdnQYt0R/qW6tfxgeUWHOX3OQNg7eh8bUchN9
         /Ir0dV07sDw0KXBccvKw62yHCOgXsL1mP2qBq/OIaUuPk6k/GSRNFXiqWQvonRK+5x
         YGdy0B9ByUESYUd1CoMicmJpzcNZzgJ9ks0FlX/6VlS+P87rr15dDqOQX0lS6QEqol
         R7T3csuowLxntIZa2R2oKM00GJuCWr3PIH9s56TtgDYCSpTmz/54fR63RuOFICpe/I
         tlATG4/x32Oqw==
Date:   Tue, 15 Nov 2022 15:53:43 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/9] xfs: punching delalloc extents on write failure is
 racy
Message-ID: <Y3Qmh15IxBhfUIJc@magnolia>
References: <20221115013043.360610-1-david@fromorbit.com>
 <20221115013043.360610-4-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115013043.360610-4-david@fromorbit.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:30:37PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> xfs_buffered_write_iomap_end() has a comment about the safety of
> punching delalloc extents based holding the IOLOCK_EXCL. This
> comment is wrong, and punching delalloc extents is not race free.
> 
> When we punch out a delalloc extent after a write failure in
> xfs_buffered_write_iomap_end(), we punch out the page cache with
> truncate_pagecache_range() before we punch out the delalloc extents.
> At this point, we only hold the IOLOCK_EXCL, so there is nothing
> stopping mmap() write faults racing with this cleanup operation,
> reinstantiating a folio over the range we are about to punch and
> hence requiring the delalloc extent to be kept.
> 
> If this race condition is hit, we can end up with a dirty page in
> the page cache that has no delalloc extent or space reservation
> backing it. This leads to bad things happening at writeback time.
> 
> To avoid this race condition, we need the page cache truncation to
> be atomic w.r.t. the extent manipulation. We can do this by holding
> the mapping->invalidate_lock exclusively across this operation -
> this will prevent new pages from being inserted into the page cache
> whilst we are removing the pages and the backing extent and space
> reservation.
> 
> Taking the mapping->invalidate_lock exclusively in the buffered
> write IO path is safe - it naturally nests inside the IOLOCK (see
> truncate and fallocate paths). iomap_zero_range() can be called from
> under the mapping->invalidate_lock (from the truncate path via
> either xfs_zero_eof() or xfs_truncate_page(), but iomap_zero_iter()
> will not instantiate new delalloc pages (because it skips holes) and
> hence will not ever need to punch out delalloc extents on failure.
> 
> Fix the locking issue, and clean up the code logic a little to avoid
> unnecessary work if we didn't allocate the delalloc extent or wrote
> the entire region we allocated.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Didn't I already tag this...?

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iomap.c | 41 +++++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 5cea069a38b4..a2e45ea1b0cb 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1147,6 +1147,10 @@ xfs_buffered_write_iomap_end(
>  		written = 0;
>  	}
>  
> +	/* If we didn't reserve the blocks, we're not allowed to punch them. */
> +	if (!(iomap->flags & IOMAP_F_NEW))
> +		return 0;
> +
>  	/*
>  	 * start_fsb refers to the first unused block after a short write. If
>  	 * nothing was written, round offset down to point at the first block in
> @@ -1158,27 +1162,28 @@ xfs_buffered_write_iomap_end(
>  		start_fsb = XFS_B_TO_FSB(mp, offset + written);
>  	end_fsb = XFS_B_TO_FSB(mp, offset + length);
>  
> +	/* Nothing to do if we've written the entire delalloc extent */
> +	if (start_fsb >= end_fsb)
> +		return 0;
> +
>  	/*
> -	 * Trim delalloc blocks if they were allocated by this write and we
> -	 * didn't manage to write the whole range.
> -	 *
> -	 * We don't need to care about racing delalloc as we hold i_mutex
> -	 * across the reserve/allocate/unreserve calls. If there are delalloc
> -	 * blocks in the range, they are ours.
> +	 * Lock the mapping to avoid races with page faults re-instantiating
> +	 * folios and dirtying them via ->page_mkwrite between the page cache
> +	 * truncation and the delalloc extent removal. Failing to do this can
> +	 * leave dirty pages with no space reservation in the cache.
>  	 */
> -	if ((iomap->flags & IOMAP_F_NEW) && start_fsb < end_fsb) {
> -		truncate_pagecache_range(VFS_I(ip), XFS_FSB_TO_B(mp, start_fsb),
> -					 XFS_FSB_TO_B(mp, end_fsb) - 1);
> -
> -		error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
> -					       end_fsb - start_fsb);
> -		if (error && !xfs_is_shutdown(mp)) {
> -			xfs_alert(mp, "%s: unable to clean up ino %lld",
> -				__func__, ip->i_ino);
> -			return error;
> -		}
> +	filemap_invalidate_lock(inode->i_mapping);
> +	truncate_pagecache_range(VFS_I(ip), XFS_FSB_TO_B(mp, start_fsb),
> +				 XFS_FSB_TO_B(mp, end_fsb) - 1);
> +
> +	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
> +				       end_fsb - start_fsb);
> +	filemap_invalidate_unlock(inode->i_mapping);
> +	if (error && !xfs_is_shutdown(mp)) {
> +		xfs_alert(mp, "%s: unable to clean up ino %lld",
> +			__func__, ip->i_ino);
> +		return error;
>  	}
> -
>  	return 0;
>  }
>  
> -- 
> 2.37.2
> 
