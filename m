Return-Path: <linux-fsdevel+bounces-79827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFyQCvoHr2kUMAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:48:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FB323DE4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 468D2300F283
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 17:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7792D3727;
	Mon,  9 Mar 2026 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6V5j7ql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CDC2741DF;
	Mon,  9 Mar 2026 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078464; cv=none; b=DJjxtf6BLvAkwvBxRleSk/1JCBSoUy+NxtAs8d+2iqzZ8AbOAZHAt1AcQQJRiNfQPkgPuq/bpy160D8hAhSt6BsHToIg972IR/pYzCKjC+zAESO9FCNPQoK8KfDddRgzhTUZd2SnVAkDZz4PQ4rp6STjZT3JgMzk8r/aj59E+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078464; c=relaxed/simple;
	bh=8wpmxwysGJodPcvT1iwKqM++GLGtatzyTLcY1QwLjBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J92kxVVyTmk4sU8xnpeT6hnvpLOqWDjBHV8wq2OEK1HknpwPdKn0ZYasRergZozHNcqYErULjglsIkDU84DP1ji7x4rvVsXAK5H2vKMtMtEXUZ5tjeR5GdjRfQkRyDr5xzSGy8z6CuDDRYiaaJqXbtycQGHk54P9qtpspV3FaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6V5j7ql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430CEC4CEF7;
	Mon,  9 Mar 2026 17:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773078464;
	bh=8wpmxwysGJodPcvT1iwKqM++GLGtatzyTLcY1QwLjBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E6V5j7ql5gCAfX9nxygS+aIzmHqVbbyUznFtOVawVJsFmN4qkYYKWG7b37+SBxGg9
	 YFA5xRqaQ3LbrZa8/8KhyAgGO4TuX5kK6jWKiS13Zo4vHaiM+a2QbyzpxRQWnTYhqU
	 EJFz19dWYOqeTiyiOgen7DUi0zcGRfD6oX1WDDFhByChMaR7nFEZ16+pLztU69Vww7
	 89GYHLumBmCwfPv1MDQAJrn2mJWmuTasudI5yDEJMATFBUKgv3NBoV/IL9xn4G9JZQ
	 3olot5NBVsORUDT46Fu41hsZzr2J+nDBfhj0C3HSAkjZm4qCK0+mVuclfumrm8f+6N
	 GrhqmTLVBJyPw==
Date: Mon, 9 Mar 2026 10:47:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 6/8] xfs: only flush when COW fork blocks overlap data
 fork holes
Message-ID: <20260309174743.GP6033@frogsfrogsfrogs>
References: <20260309134506.167663-1-bfoster@redhat.com>
 <20260309134506.167663-7-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309134506.167663-7-bfoster@redhat.com>
X-Rspamd-Queue-Id: 28FB323DE4F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79827-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:45:04AM -0400, Brian Foster wrote:
> The zero range hole mapping flush case has been lifted from iomap
> into XFS. Now that we have more mapping context available from the
> ->iomap_begin() handler, we can isolate the flush further to when we
> know a hole is fronted by COW blocks.
> 
> Rather than purely rely on pagecache dirty state, explicitly check
> for the case where a range is a hole in both forks. Otherwise trim
> to the range where there does happen to be overlap and use that for
> the pagecache writeback check. This might prevent some spurious
> zeroing, but more importantly makes it easier to remove the flush
> entirely.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Makes sense,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iomap.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 0f44d9aef25b..ce342b9ce2f0 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1781,10 +1781,12 @@ xfs_buffered_write_iomap_begin(
>  {
>  	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter,
>  						     iomap);
> +	struct address_space	*mapping = inode->i_mapping;
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
> +	xfs_fileoff_t		cow_fsb = NULLFILEOFF;
>  	struct xfs_bmbt_irec	imap, cmap;
>  	struct xfs_iext_cursor	icur, ccur;
>  	xfs_fsblock_t		prealloc_blocks = 0;
> @@ -1852,6 +1854,8 @@ xfs_buffered_write_iomap_begin(
>  		}
>  		cow_eof = !xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb,
>  				&ccur, &cmap);
> +		if (!cow_eof)
> +			cow_fsb = cmap.br_startoff;
>  	}
>  
>  	/* We never need to allocate blocks for unsharing a hole. */
> @@ -1866,17 +1870,37 @@ xfs_buffered_write_iomap_begin(
>  	 * writeback to remap pending blocks and restart the lookup.
>  	 */
>  	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
> -		if (filemap_range_needs_writeback(inode->i_mapping, offset,
> -						  offset + count - 1)) {
> +		loff_t	start, end;
> +
> +		imap.br_blockcount = imap.br_startoff - offset_fsb;
> +		imap.br_startoff = offset_fsb;
> +		imap.br_startblock = HOLESTARTBLOCK;
> +		imap.br_state = XFS_EXT_NORM;
> +
> +		if (cow_fsb == NULLFILEOFF)
> +			goto found_imap;
> +		if (cow_fsb > offset_fsb) {
> +			xfs_trim_extent(&imap, offset_fsb,
> +					cow_fsb - offset_fsb);
> +			goto found_imap;
> +		}
> +
> +		/* COW fork blocks overlap the hole */
> +		xfs_trim_extent(&imap, offset_fsb,
> +			    cmap.br_startoff + cmap.br_blockcount - offset_fsb);
> +		start = XFS_FSB_TO_B(mp, imap.br_startoff);
> +		end = XFS_FSB_TO_B(mp,
> +				   imap.br_startoff + imap.br_blockcount) - 1;
> +		if (filemap_range_needs_writeback(mapping, start, end)) {
>  			xfs_iunlock(ip, lockmode);
> -			error = filemap_write_and_wait_range(inode->i_mapping,
> -						offset, offset + count - 1);
> +			error = filemap_write_and_wait_range(mapping, start,
> +							     end);
>  			if (error)
>  				return error;
>  			goto restart;
>  		}
> -		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
> -		goto out_unlock;
> +
> +		goto found_imap;
>  	}
>  
>  	/*
> -- 
> 2.52.0
> 
> 

