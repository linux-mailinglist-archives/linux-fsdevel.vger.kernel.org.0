Return-Path: <linux-fsdevel+bounces-79829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI7OOCIIr2kUMAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:49:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 971AD23DEB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87B383028B12
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 17:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B292D7D42;
	Mon,  9 Mar 2026 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aA8+4Zye"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33A8286D4D;
	Mon,  9 Mar 2026 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078522; cv=none; b=iRq4hgsC30bjrqNGdDFhPZOWsH0K65Oe1BaAV1MLF+bCt8v7SUBIZJNFAhcmw9dMNZSI7B0Ayp1r/twOtglmLS5EpnOTOzR1omfLO67TVR2akjriPtT2WHHVVDYPAiNlg13cHUIGuGBIX1llk8HXcOM+BA2pH1CNPsurEFOXgxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078522; c=relaxed/simple;
	bh=BWnRP00H0rMzZBStq7b1pJLgF+7X6fSfYyFMoDmoQug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1vuFRqIDWTZRIRvbaBQ6+ZqRWpOKwKMiZcWc8aQA8ow+839q7fzc4B2gmh1U54qeP+hGIl1Tcou2yqddbYSJVS25f66hr5Ve2PgQz7Hr/ywN60ypBFYA8toTAIFUZaiRA2jZZFEygBbxDAByr8KAVmnYwvL4Dq388zNCdUm7Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aA8+4Zye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7BAC4CEF7;
	Mon,  9 Mar 2026 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773078522;
	bh=BWnRP00H0rMzZBStq7b1pJLgF+7X6fSfYyFMoDmoQug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aA8+4ZyeLbn+OccqMmTAGRag7/ydKgi0iVZcJAliq3l00k2YeZ/xXcoNgVem8gNPS
	 cXk4+tUDZ8En8/MazRAvYuZuQ3whLuuu2XStTBeMth7TFlCx9jpq/qUty5k4shcoFy
	 +AHHpQUwp65k3ZXR6o1zbImErXhfH/CITpV+vuuz1EV+RkciIUxMCrofGnb00nJ6a3
	 vY78e99HGZ1OCnFbNeB9WTOFQY2R82UVxufsDbeDCAA2rFPK+6knF339voeclbcmWH
	 RLQXM2jSArsTJNeKHs2pR6R4bedyLthqdwR/7tVZhG+mIHx/3a26PIHmFBKAQ11FEV
	 GYe1g9dQpHeog==
Date: Mon, 9 Mar 2026 10:48:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 7/8] xfs: replace zero range flush with folio batch
Message-ID: <20260309174841.GQ6033@frogsfrogsfrogs>
References: <20260309134506.167663-1-bfoster@redhat.com>
 <20260309134506.167663-8-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309134506.167663-8-bfoster@redhat.com>
X-Rspamd-Queue-Id: 971AD23DEB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79829-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lst.de:email]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:45:05AM -0400, Brian Foster wrote:
> Now that the zero range pagecache flush is purely isolated to
> providing zeroing correctness in this case, we can remove it and
> replace it with the folio batch mechanism that is used for handling
> unwritten extents.
> 
> This is still slightly odd in that XFS reports a hole vs. a mapping
> that reflects the COW fork extents, but that has always been the
> case in this situation and so a separate issue. We drop the iomap
> warning that assumes the folio batch is always associated with
> unwritten mappings, but this is mainly a development assertion as
> otherwise the core iomap fbatch code doesn't care much about the
> mapping type if it's handed the set of folios to process.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

This is (in the end) a much cleaner solution :)
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c |  4 ----
>  fs/xfs/xfs_iomap.c     | 20 ++++++--------------
>  2 files changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 0999aca6e5cc..4422a6d477d7 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1633,10 +1633,6 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  	while ((ret = iomap_iter(&iter, ops)) > 0) {
>  		const struct iomap *srcmap = iomap_iter_srcmap(&iter);
>  
> -		if (WARN_ON_ONCE((iter.iomap.flags & IOMAP_F_FOLIO_BATCH) &&
> -				 srcmap->type != IOMAP_UNWRITTEN))
> -			return -EIO;
> -
>  		if (!(iter.iomap.flags & IOMAP_F_FOLIO_BATCH) &&
>  		    (srcmap->type == IOMAP_HOLE ||
>  		     srcmap->type == IOMAP_UNWRITTEN)) {
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index ce342b9ce2f0..df240931f07a 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1781,7 +1781,6 @@ xfs_buffered_write_iomap_begin(
>  {
>  	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter,
>  						     iomap);
> -	struct address_space	*mapping = inode->i_mapping;
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> @@ -1813,7 +1812,6 @@ xfs_buffered_write_iomap_begin(
>  	if (error)
>  		return error;
>  
> -restart:
>  	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
>  	if (error)
>  		return error;
> @@ -1866,8 +1864,8 @@ xfs_buffered_write_iomap_begin(
>  
>  	/*
>  	 * We may need to zero over a hole in the data fork if it's fronted by
> -	 * COW blocks and dirty pagecache. To make sure zeroing occurs, force
> -	 * writeback to remap pending blocks and restart the lookup.
> +	 * COW blocks and dirty pagecache. Scan such file ranges for dirty
> +	 * cache and fill the iomap batch with folios that need zeroing.
>  	 */
>  	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
>  		loff_t	start, end;
> @@ -1889,16 +1887,10 @@ xfs_buffered_write_iomap_begin(
>  		xfs_trim_extent(&imap, offset_fsb,
>  			    cmap.br_startoff + cmap.br_blockcount - offset_fsb);
>  		start = XFS_FSB_TO_B(mp, imap.br_startoff);
> -		end = XFS_FSB_TO_B(mp,
> -				   imap.br_startoff + imap.br_blockcount) - 1;
> -		if (filemap_range_needs_writeback(mapping, start, end)) {
> -			xfs_iunlock(ip, lockmode);
> -			error = filemap_write_and_wait_range(mapping, start,
> -							     end);
> -			if (error)
> -				return error;
> -			goto restart;
> -		}
> +		end = XFS_FSB_TO_B(mp, imap.br_startoff + imap.br_blockcount);
> +		iomap_fill_dirty_folios(iter, &start, end, &iomap_flags);
> +		xfs_trim_extent(&imap, offset_fsb,
> +				XFS_B_TO_FSB(mp, start) - offset_fsb);
>  
>  		goto found_imap;
>  	}
> -- 
> 2.52.0
> 
> 

