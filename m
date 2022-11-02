Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1236168BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiKBQ1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiKBQ1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:27:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBC92FFCC;
        Wed,  2 Nov 2022 09:22:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0312E61A34;
        Wed,  2 Nov 2022 16:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B87AC433C1;
        Wed,  2 Nov 2022 16:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667406140;
        bh=WePlibzaGr0qUWH/HgQvgiJMlle89nYWyhwRO9X4Efw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTQ5ojPrD2SvYExC2Wf97uXFPg5Cf9H2ZChW+51neB4fz+E4RtcG+jntyWOP7qbMb
         4bodRG+K/U6fQXOAlzzfipyCEgRwUeJRbd0QiRQ+3bpW/oKEFyrfsXIc1WkclaYCN/
         5LZBT2Yv8xQ4vLsytDCKxtAPbnX6KeUkyTuqz5vD4EaE/coU2skokJou42bxDApQXZ
         wjGJyAESEJcph1ss7134rAKJ/KdOID27RtPZaIM+Px8D8Gb7hYk5v0xRiOLcfQ9zAx
         O/ikDiQcEPpqCVVgPJ0UHO28Yuqu4+AFAbvlCbBrP8Wq0UY4EHA973JxUyfh3brQ6J
         StUW9G6jqvOhA==
Date:   Wed, 2 Nov 2022 09:22:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/7] xfs: punching delalloc extents on write failure is
 racy
Message-ID: <Y2KZOyASX3rksFvK@magnolia>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-3-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101003412.3842572-3-david@fromorbit.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 11:34:07AM +1100, Dave Chinner wrote:
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

Every time I've read this comment I've thought it didn't smell right...

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

...and now that we've renamed MMAPLOCK to the file mapping invalidation
lock, it's really obvious that we should've been holding it as a
precondition of truncate_pagecache* all along.

I might ask Jan or willy if those truncation functions should have
debugging asserts to check the status of invalidate_lock any time we
move to kick a folio out of the mapping.  But IIRC there was some hangup
about that where filesystems that don't remove folios below EOF don't
take invalidate_lock or something?

> +				 XFS_FSB_TO_B(mp, end_fsb) - 1);
> +
> +	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
> +				       end_fsb - start_fsb);
> +	filemap_invalidate_unlock(inode->i_mapping);
> +	if (error && !xfs_is_shutdown(mp)) {
> +		xfs_alert(mp, "%s: unable to clean up ino %lld",
> +			__func__, ip->i_ino);

Minor nits for some cleanup patch later: Can we log the errno
encountered, and convert the inumber to 0x%llx?

Nevertheless, the reasoning is sound, so:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +		return error;
>  	}
> -
>  	return 0;
>  }
>  
> -- 
> 2.37.2
> 
