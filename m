Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0E35E59B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 05:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiIVDoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 23:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiIVDoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:44:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0AAAB054;
        Wed, 21 Sep 2022 20:44:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07046B8343E;
        Thu, 22 Sep 2022 03:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D4EC433D6;
        Thu, 22 Sep 2022 03:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663818241;
        bh=f0sOuHVsFPfv11RgNumV+ME1qm/dIxvoqrOeyuZW56g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yw43GG5Gp7RNIpk+S9jZphwDLubc0KO2mhvOVRHzYq8MYoJS3jH6NzfZeY4nwFW5Q
         wIQt0MaKNKJdPoMFteeitDjus+vouT8Oo8rWF2v4rrDmpUt8aJQFqVqDLASUnvX3y3
         p+M8D9bEO635qrZ3MHsU/voGyZUyYkSpVu81TkjHOfpzNKif5+dcdMpVwKKBfpdjgt
         /G8D5e3RvkIXFYEkF5eTG7tLOHjcV/Qj2qDHh93TGHxNp+3K6TXoz88/bYHtJqMOLF
         0crJTC6flEipcbZ3z5NHUoHWYFXyiC4m7wzAHQlY0gAR3gSYNo8LcfP5MxhRy1tN11
         0fa1rf7Us7pEw==
Date:   Wed, 21 Sep 2022 20:44:01 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: use iomap_valid method to detect stale cached
 iomaps
Message-ID: <YyvaAY6UT1gKRF9U@magnolia>
References: <20220921082959.1411675-1-david@fromorbit.com>
 <20220921082959.1411675-3-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921082959.1411675-3-david@fromorbit.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 06:29:59PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Now that iomap supports a mechanism to validate cached iomaps for
> buffered write operations, hook it up to the XFS buffered write ops
> so that we can avoid data corruptions that result from stale cached
> iomaps. See:
> 
> https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/
> 
> or the ->iomap_valid() introduction commit for exact details of the
> corruption vector.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/xfs_iomap.c | 53 ++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 07da03976ec1..2e77ae817e6b 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -91,6 +91,12 @@ xfs_bmbt_to_iomap(
>  	if (xfs_ipincount(ip) &&
>  	    (ip->i_itemp->ili_fsync_fields & ~XFS_ILOG_TIMESTAMP))
>  		iomap->flags |= IOMAP_F_DIRTY;
> +
> +	/*
> +	 * Sample the extent tree sequence so that we can detect if the tree
> +	 * changes while the iomap is still being used.
> +	 */
> +	*((int *)&iomap->private) = READ_ONCE(ip->i_df.if_seq);
>  	return 0;
>  }
>  
> @@ -915,6 +921,7 @@ xfs_buffered_write_iomap_begin(
>  	int			allocfork = XFS_DATA_FORK;
>  	int			error = 0;
>  	unsigned int		lockmode = XFS_ILOCK_EXCL;
> +	u16			remap_flags = 0;
>  
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
> @@ -926,6 +933,20 @@ xfs_buffered_write_iomap_begin(
>  
>  	ASSERT(!XFS_IS_REALTIME_INODE(ip));
>  
> +	/*
> +	 * If we are remapping a stale iomap, preserve the IOMAP_F_NEW flag
> +	 * if it is passed to us. This will only be set if we are remapping a
> +	 * range that we just allocated and hence had set IOMAP_F_NEW on. We
> +	 * need to set it again here so any further writes over this newly
> +	 * allocated region we are remapping are preserved.
> +	 *
> +	 * This pairs with the code in xfs_buffered_write_iomap_end() that skips
> +	 * punching newly allocated delalloc regions that have iomaps marked as
> +	 * stale.
> +	 */
> +	if (iomap->flags & IOMAP_F_STALE)
> +		remap_flags = iomap->flags & IOMAP_F_NEW;
> +
>  	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
>  	if (error)
>  		return error;
> @@ -1100,7 +1121,7 @@ xfs_buffered_write_iomap_begin(
>  
>  found_imap:
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, remap_flags);

Ah, ok, so the ->iomap_begin function /is/ required to detect
IOMAP_F_STALE, carryover any IOMAP_F_NEW, and drop the IOMAP_F_STALE.

>  found_cow:
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> @@ -1160,13 +1181,20 @@ xfs_buffered_write_iomap_end(
>  
>  	/*
>  	 * Trim delalloc blocks if they were allocated by this write and we
> -	 * didn't manage to write the whole range.
> +	 * didn't manage to write the whole range. If the iomap was marked stale
> +	 * because it is no longer valid, we are going to remap this range
> +	 * immediately, so don't punch it out.
>  	 *
> -	 * We don't need to care about racing delalloc as we hold i_mutex
> +	 * XXX (dgc): This next comment and assumption is totally bogus because
> +	 * iomap_page_mkwrite() runs through here and it doesn't hold the
> +	 * i_rwsem. Hence this whole error handling path may be badly broken.

That probably needs fixing, though I'll break that out as a separate
reply to the cover letter.

> +	 *
> +	 * We don't need to care about racing delalloc as we hold i_rwsem
>  	 * across the reserve/allocate/unreserve calls. If there are delalloc
>  	 * blocks in the range, they are ours.
>  	 */
> -	if ((iomap->flags & IOMAP_F_NEW) && start_fsb < end_fsb) {
> +	if (((iomap->flags & (IOMAP_F_NEW | IOMAP_F_STALE)) == IOMAP_F_NEW) &&
> +	    start_fsb < end_fsb) {
>  		truncate_pagecache_range(VFS_I(ip), XFS_FSB_TO_B(mp, start_fsb),
>  					 XFS_FSB_TO_B(mp, end_fsb) - 1);
>  
> @@ -1182,9 +1210,26 @@ xfs_buffered_write_iomap_end(
>  	return 0;
>  }
>  
> +/*
> + * Check that the iomap passed to us is still valid for the given offset and
> + * length.
> + */
> +static bool
> +xfs_buffered_write_iomap_valid(
> +	struct inode		*inode,
> +	const struct iomap	*iomap)
> +{
> +	int			seq = *((int *)&iomap->private);
> +
> +	if (seq != READ_ONCE(XFS_I(inode)->i_df.if_seq))
> +		return false;
> +	return true;
> +}

Wheee, thanks for tackling this one. :)

--D

> +
>  const struct iomap_ops xfs_buffered_write_iomap_ops = {
>  	.iomap_begin		= xfs_buffered_write_iomap_begin,
>  	.iomap_end		= xfs_buffered_write_iomap_end,
> +	.iomap_valid		= xfs_buffered_write_iomap_valid,
>  };
>  
>  static int
> -- 
> 2.37.2
> 
