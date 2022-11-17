Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FD062E4E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 19:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiKQS7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 13:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiKQS7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:59:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1957DEE3;
        Thu, 17 Nov 2022 10:59:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7EFE621C2;
        Thu, 17 Nov 2022 18:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B6AC433D6;
        Thu, 17 Nov 2022 18:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668711552;
        bh=X7BBZzkq1WwDLtaXbhrR94BabxzhK2Sp9hlbYz35l6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N78h9U1CrZc/wjO3m700R1tsOp6FBTQ/fWnDZXgeWV+trrjPt4B0USNYJXHtCmSJQ
         T3UMs9ztAxJYE6pSDXv3qT+nSy+Wnz40Q0W2HYa7QVUYQ+MpefZfxC1hBlcqddPLS9
         D0KZi8rxaRGhQvRQ6pd35j6i4q5YfTcBq/QqIefM7pCP5ym7pZZgLdMOLYh7RRGYrw
         t9xQz809uz6hmmeKQfK/rw9WGSO2GXbKPw6HIDsfeHViUlvuoN6gLiws9ibjag4ZHU
         QssrgCZxMSCXP4BQmtoSaF32vFPI1NToCejjoCNZovdcD4/5Hv8noPMeKSiLOQPwwO
         q7xumVSdD5M3g==
Date:   Thu, 17 Nov 2022 10:59:11 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/9] xfs: use iomap_valid method to detect stale cached
 iomaps
Message-ID: <Y3aEfxus3Eem0ppe@magnolia>
References: <20221117055810.498014-1-david@fromorbit.com>
 <20221117055810.498014-9-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117055810.498014-9-david@fromorbit.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 17, 2022 at 04:58:09PM +1100, Dave Chinner wrote:
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
> The validity cookie we store in the iomap is based on the type of
> iomap we return. It is expected that the iomap->flags we set in
> xfs_bmbt_to_iomap() is not perturbed by the iomap core and are
> returned to us in the iomap passed via the .iomap_valid() callback.
> This ensures that the validity cookie is always checking the correct
> inode fork sequence numbers to detect potential changes that affect
> the extent cached by the iomap.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c |  6 ++-
>  fs/xfs/xfs_aops.c        |  2 +-
>  fs/xfs/xfs_iomap.c       | 96 +++++++++++++++++++++++++++++++---------
>  fs/xfs/xfs_iomap.h       |  5 ++-
>  fs/xfs/xfs_pnfs.c        |  6 ++-
>  5 files changed, 88 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 49d0d4ea63fc..56b9b7db38bb 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -4551,7 +4551,8 @@ xfs_bmapi_convert_delalloc(
>  	 * the extent.  Just return the real extent at this offset.
>  	 */
>  	if (!isnullstartblock(bma.got.br_startblock)) {
> -		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags);
> +		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags,
> +				xfs_iomap_inode_sequence(ip, flags));
>  		*seq = READ_ONCE(ifp->if_seq);

Question beyond the scope of this series: Does it make any sense to use
to the same u64 sequencecookie for writeback validation?  I think the
answer is that we could, but that would increase (unnecessary)
invalidations during writeback due to (say) writing to the cow fork
whilst someone else messes with the data fork.

>  		goto out_trans_cancel;
>  	}
> @@ -4599,7 +4600,8 @@ xfs_bmapi_convert_delalloc(
>  	XFS_STATS_INC(mp, xs_xstrat_quick);
>  
>  	ASSERT(!isnullstartblock(bma.got.br_startblock));
> -	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags);
> +	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags,
> +				xfs_iomap_inode_sequence(ip, flags));
>  	*seq = READ_ONCE(ifp->if_seq);
>  
>  	if (whichfork == XFS_COW_FORK)
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 6aadc5815068..a22d90af40c8 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -372,7 +372,7 @@ xfs_map_blocks(
>  	    isnullstartblock(imap.br_startblock))
>  		goto allocate_blocks;
>  
> -	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0);
> +	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, XFS_WPC(wpc)->data_seq);

If I'm following this correctly, we never use wpc->iomap's sequence
counters, so (ATM) it doesn't matter that we don't call
xfs_iomap_inode_sequence here.

>  	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
>  	return 0;
>  allocate_blocks:
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 09676ff6940e..a9b3a1bcc3fd 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -48,13 +48,45 @@ xfs_alert_fsblock_zero(
>  	return -EFSCORRUPTED;
>  }
>  
> +u64
> +xfs_iomap_inode_sequence(
> +	struct xfs_inode	*ip,
> +	u16			iomap_flags)
> +{
> +	u64			cookie = 0;
> +
> +	if (iomap_flags & IOMAP_F_XATTR)
> +		return READ_ONCE(ip->i_af.if_seq);
> +	if ((iomap_flags & IOMAP_F_SHARED) && ip->i_cowfp)

I checked that IOMAP_F_SHARED is always set when we stuff the cow fork
extent into @iomap and the data fork extent into @srcmap, and hence this
is the correct flag handling logic.

> +		cookie = (u64)READ_ONCE(ip->i_cowfp->if_seq) << 32;
> +	return cookie | READ_ONCE(ip->i_df.if_seq);
> +}
> +
> +/*
> + * Check that the iomap passed to us is still valid for the given offset and
> + * length.
> + */
> +static bool
> +xfs_iomap_valid(
> +	struct inode		*inode,
> +	const struct iomap	*iomap)
> +{
> +	return iomap->validity_cookie ==
> +			xfs_iomap_inode_sequence(XFS_I(inode), iomap->flags);
> +}
> +
> +const struct iomap_page_ops xfs_iomap_page_ops = {
> +	.iomap_valid		= xfs_iomap_valid,
> +};
> +
>  int
>  xfs_bmbt_to_iomap(
>  	struct xfs_inode	*ip,
>  	struct iomap		*iomap,
>  	struct xfs_bmbt_irec	*imap,
>  	unsigned int		mapping_flags,
> -	u16			iomap_flags)
> +	u16			iomap_flags,
> +	u64			sequence_cookie)
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
>  	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> @@ -91,6 +123,9 @@ xfs_bmbt_to_iomap(
>  	if (xfs_ipincount(ip) &&
>  	    (ip->i_itemp->ili_fsync_fields & ~XFS_ILOG_TIMESTAMP))
>  		iomap->flags |= IOMAP_F_DIRTY;
> +
> +	iomap->validity_cookie = sequence_cookie;
> +	iomap->page_ops = &xfs_iomap_page_ops;
>  	return 0;
>  }
>  
> @@ -195,7 +230,8 @@ xfs_iomap_write_direct(
>  	xfs_fileoff_t		offset_fsb,
>  	xfs_fileoff_t		count_fsb,
>  	unsigned int		flags,
> -	struct xfs_bmbt_irec	*imap)
> +	struct xfs_bmbt_irec	*imap,
> +	u64			*seq)
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
>  	struct xfs_trans	*tp;
> @@ -285,6 +321,8 @@ xfs_iomap_write_direct(
>  		error = xfs_alert_fsblock_zero(ip, imap);
>  
>  out_unlock:
> +	if (seq)
> +		*seq = xfs_iomap_inode_sequence(ip, 0);

None of the callers pass NULL, so I think this can go away?

That aside, I think I'm satisfied now.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

So the next question is -- how should we regression-test the
revalidation schemes in the write and writeback paths?  Do you have
something ready to go that supersedes what I built in patches 13-16 of
https://lore.kernel.org/linux-xfs/166801781760.3992140.10078383339454429922.stgit@magnolia/T/#u

Please let me know what you're thinking.

--D

>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  	return error;
>  
> @@ -743,6 +781,7 @@ xfs_direct_write_iomap_begin(
>  	bool			shared = false;
>  	u16			iomap_flags = 0;
>  	unsigned int		lockmode = XFS_ILOCK_SHARED;
> +	u64			seq;
>  
>  	ASSERT(flags & (IOMAP_WRITE | IOMAP_ZERO));
>  
> @@ -811,9 +850,10 @@ xfs_direct_write_iomap_begin(
>  			goto out_unlock;
>  	}
>  
> +	seq = xfs_iomap_inode_sequence(ip, iomap_flags);
>  	xfs_iunlock(ip, lockmode);
>  	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags, seq);
>  
>  allocate_blocks:
>  	error = -EAGAIN;
> @@ -839,24 +879,26 @@ xfs_direct_write_iomap_begin(
>  	xfs_iunlock(ip, lockmode);
>  
>  	error = xfs_iomap_write_direct(ip, offset_fsb, end_fsb - offset_fsb,
> -			flags, &imap);
> +			flags, &imap, &seq);
>  	if (error)
>  		return error;
>  
>  	trace_xfs_iomap_alloc(ip, offset, length, XFS_DATA_FORK, &imap);
>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
> -				 iomap_flags | IOMAP_F_NEW);
> +				 iomap_flags | IOMAP_F_NEW, seq);
>  
>  out_found_cow:
> -	xfs_iunlock(ip, lockmode);
>  	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
>  	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
>  	if (imap.br_startblock != HOLESTARTBLOCK) {
> -		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0);
> +		seq = xfs_iomap_inode_sequence(ip, 0);
> +		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
>  		if (error)
> -			return error;
> +			goto out_unlock;
>  	}
> -	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED);
> +	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
> +	xfs_iunlock(ip, lockmode);
> +	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
>  
>  out_unlock:
>  	if (lockmode)
> @@ -915,6 +957,7 @@ xfs_buffered_write_iomap_begin(
>  	int			allocfork = XFS_DATA_FORK;
>  	int			error = 0;
>  	unsigned int		lockmode = XFS_ILOCK_EXCL;
> +	u64			seq;
>  
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
> @@ -1094,26 +1137,31 @@ xfs_buffered_write_iomap_begin(
>  	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
>  	 * them out if the write happens to fail.
>  	 */
> +	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_NEW);
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW, seq);
>  
>  found_imap:
> +	seq = xfs_iomap_inode_sequence(ip, 0);
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
>  
>  found_cow:
> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	seq = xfs_iomap_inode_sequence(ip, 0);
>  	if (imap.br_startoff <= offset_fsb) {
> -		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0);
> +		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
>  		if (error)
> -			return error;
> +			goto out_unlock;
> +		seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
> +		xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
> -					 IOMAP_F_SHARED);
> +					 IOMAP_F_SHARED, seq);
>  	}
>  
>  	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
> -	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0);
> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0, seq);
>  
>  out_unlock:
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> @@ -1193,6 +1241,7 @@ xfs_read_iomap_begin(
>  	int			nimaps = 1, error = 0;
>  	bool			shared = false;
>  	unsigned int		lockmode = XFS_ILOCK_SHARED;
> +	u64			seq;
>  
>  	ASSERT(!(flags & (IOMAP_WRITE | IOMAP_ZERO)));
>  
> @@ -1206,13 +1255,14 @@ xfs_read_iomap_begin(
>  			       &nimaps, 0);
>  	if (!error && (flags & IOMAP_REPORT))
>  		error = xfs_reflink_trim_around_shared(ip, &imap, &shared);
> +	seq = xfs_iomap_inode_sequence(ip, shared ? IOMAP_F_SHARED : 0);
>  	xfs_iunlock(ip, lockmode);
>  
>  	if (error)
>  		return error;
>  	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
> -				 shared ? IOMAP_F_SHARED : 0);
> +				 shared ? IOMAP_F_SHARED : 0, seq);
>  }
>  
>  const struct iomap_ops xfs_read_iomap_ops = {
> @@ -1237,6 +1287,7 @@ xfs_seek_iomap_begin(
>  	struct xfs_bmbt_irec	imap, cmap;
>  	int			error = 0;
>  	unsigned		lockmode;
> +	u64			seq;
>  
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
> @@ -1271,8 +1322,9 @@ xfs_seek_iomap_begin(
>  		if (data_fsb < cow_fsb + cmap.br_blockcount)
>  			end_fsb = min(end_fsb, data_fsb);
>  		xfs_trim_extent(&cmap, offset_fsb, end_fsb);
> +		seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
>  		error = xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
> -					  IOMAP_F_SHARED);
> +				IOMAP_F_SHARED, seq);
>  		/*
>  		 * This is a COW extent, so we must probe the page cache
>  		 * because there could be dirty page cache being backed
> @@ -1293,8 +1345,9 @@ xfs_seek_iomap_begin(
>  	imap.br_startblock = HOLESTARTBLOCK;
>  	imap.br_state = XFS_EXT_NORM;
>  done:
> +	seq = xfs_iomap_inode_sequence(ip, 0);
>  	xfs_trim_extent(&imap, offset_fsb, end_fsb);
> -	error = xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
> +	error = xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
>  out_unlock:
>  	xfs_iunlock(ip, lockmode);
>  	return error;
> @@ -1320,6 +1373,7 @@ xfs_xattr_iomap_begin(
>  	struct xfs_bmbt_irec	imap;
>  	int			nimaps = 1, error = 0;
>  	unsigned		lockmode;
> +	int			seq;
>  
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
> @@ -1336,12 +1390,14 @@ xfs_xattr_iomap_begin(
>  	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
>  			       &nimaps, XFS_BMAPI_ATTRFORK);
>  out_unlock:
> +
> +	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_XATTR);
>  	xfs_iunlock(ip, lockmode);
>  
>  	if (error)
>  		return error;
>  	ASSERT(nimaps);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_XATTR, seq);
>  }
>  
>  const struct iomap_ops xfs_xattr_iomap_ops = {
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index 0f62ab633040..4da13440bae9 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -13,14 +13,15 @@ struct xfs_bmbt_irec;
>  
>  int xfs_iomap_write_direct(struct xfs_inode *ip, xfs_fileoff_t offset_fsb,
>  		xfs_fileoff_t count_fsb, unsigned int flags,
> -		struct xfs_bmbt_irec *imap);
> +		struct xfs_bmbt_irec *imap, u64 *sequence);
>  int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
>  xfs_fileoff_t xfs_iomap_eof_align_last_fsb(struct xfs_inode *ip,
>  		xfs_fileoff_t end_fsb);
>  
> +u64 xfs_iomap_inode_sequence(struct xfs_inode *ip, u16 iomap_flags);
>  int xfs_bmbt_to_iomap(struct xfs_inode *ip, struct iomap *iomap,
>  		struct xfs_bmbt_irec *imap, unsigned int mapping_flags,
> -		u16 iomap_flags);
> +		u16 iomap_flags, u64 sequence_cookie);
>  
>  int xfs_zero_range(struct xfs_inode *ip, loff_t pos, loff_t len,
>  		bool *did_zero);
> diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
> index 37a24f0f7cd4..38d23f0e703a 100644
> --- a/fs/xfs/xfs_pnfs.c
> +++ b/fs/xfs/xfs_pnfs.c
> @@ -125,6 +125,7 @@ xfs_fs_map_blocks(
>  	int			nimaps = 1;
>  	uint			lock_flags;
>  	int			error = 0;
> +	u64			seq;
>  
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
> @@ -176,6 +177,7 @@ xfs_fs_map_blocks(
>  	lock_flags = xfs_ilock_data_map_shared(ip);
>  	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb,
>  				&imap, &nimaps, bmapi_flags);
> +	seq = xfs_iomap_inode_sequence(ip, 0);
>  
>  	ASSERT(!nimaps || imap.br_startblock != DELAYSTARTBLOCK);
>  
> @@ -189,7 +191,7 @@ xfs_fs_map_blocks(
>  		xfs_iunlock(ip, lock_flags);
>  
>  		error = xfs_iomap_write_direct(ip, offset_fsb,
> -				end_fsb - offset_fsb, 0, &imap);
> +				end_fsb - offset_fsb, 0, &imap, &seq);
>  		if (error)
>  			goto out_unlock;
>  
> @@ -209,7 +211,7 @@ xfs_fs_map_blocks(
>  	}
>  	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
>  
> -	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0, 0);
> +	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0, 0, seq);
>  	*device_generation = mp->m_generation;
>  	return error;
>  out_unlock:
> -- 
> 2.37.2
> 
