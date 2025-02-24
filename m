Return-Path: <linux-fsdevel+bounces-42501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BE8A42E06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001853B285C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 20:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DF324502B;
	Mon, 24 Feb 2025 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0QG5Yju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E61253BE;
	Mon, 24 Feb 2025 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429458; cv=none; b=PMWbjSUv52aGoF8q9ohJrotSwetXFClK3GA8o0WMEN6nDOdpJp/2sXDX5E20BWfnLIPyrltByLKlqUEXe//5AqPjqijVF7uoZhAn8PtUobkMiOWv8qNum0hgxuaOdUnHeFnKjmiPOjmw4E4EjF31nuLw4C+g8C+IUP8JHTSSg54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429458; c=relaxed/simple;
	bh=+M384LVeG2Il1wh2/bradd1uAF59wMWgiJLPtUje9YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atf/F59tD2g9qKTsQVz38dENwbgxNYD0kQqWcA4qOeXxjNEh1rOmja/t/jWK3yjNanSWC2s/oENz2laLdklqmZjDqnGRfS1S5uhB8iqwWczXtlNso/AsK25Dh1eiyiZonlidOXln5PCUMMardgjAxtRkgn7oEaE9gdh/gmEz/+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0QG5Yju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E71C4CED6;
	Mon, 24 Feb 2025 20:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740429458;
	bh=+M384LVeG2Il1wh2/bradd1uAF59wMWgiJLPtUje9YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0QG5YjuEOX+85Kc164Adk9WSqRgX2J/Imv3o/5bb6WJJF6lQLHqZjKDMLHNuw7du
	 EIy16qcZ3s5FjXK4+suVZgI/gj2JawEpD6yEoH8MtG03aTeRa8G0mQyglebShUYnB2
	 +pCQUApEacIAh4NaumCZPbpfnbzXLIlLE4Lykx3C+PvQC8q+G0xkqDqHdbiZuObGZ3
	 E4c+jlZwmOOX9A+StxpD303Rx7QxYrE1+ycQfKsuXSM1PvL2c3Ivzco3mefdKZ1Ub5
	 kFxuoxkz4qJ0rpPf7SVK2ybv3+vHc+CHu27CLSsF0eFWgTcmLLSjcbXSFbyFCXlkeT
	 FaEbNFacnDz1w==
Date: Mon, 24 Feb 2025 12:37:37 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 11/11] xfs: Allow block allocator to take an alignment
 hint
Message-ID: <20250224203737.GL21808@frogsfrogsfrogs>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-12-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213135619.1148432-12-john.g.garry@oracle.com>

On Thu, Feb 13, 2025 at 01:56:19PM +0000, John Garry wrote:
> When issuing an atomic write by the CoW method, give the block allocator a
> hint to naturally align the data blocks.
> 
> This means that we have a better chance to issuing the atomic write via
> HW offload next time.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 7 ++++++-
>  fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
>  fs/xfs/xfs_reflink.c     | 8 ++++++--
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 0ef19f1469ec..9bfdfb7cdcae 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3454,6 +3454,12 @@ xfs_bmap_compute_alignments(
>  		align = xfs_get_cowextsz_hint(ap->ip);
>  	else if (ap->datatype & XFS_ALLOC_USERDATA)
>  		align = xfs_get_extsz_hint(ap->ip);
> +
> +	if (align > 1 && ap->flags & XFS_BMAPI_EXTSZALIGN)
> +		args->alignment = align;
> +	else
> +		args->alignment = 1;
> +
>  	if (align) {
>  		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
>  					ap->eof, 0, ap->conv, &ap->offset,
> @@ -3782,7 +3788,6 @@ xfs_bmap_btalloc(
>  		.wasdel		= ap->wasdel,
>  		.resv		= XFS_AG_RESV_NONE,
>  		.datatype	= ap->datatype,
> -		.alignment	= 1,
>  		.minalignslop	= 0,
>  	};
>  	xfs_fileoff_t		orig_offset;
> diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
> index 4b721d935994..7a31697331dc 100644
> --- a/fs/xfs/libxfs/xfs_bmap.h
> +++ b/fs/xfs/libxfs/xfs_bmap.h
> @@ -87,6 +87,9 @@ struct xfs_bmalloca {
>  /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
>  #define XFS_BMAPI_NORMAP	(1u << 10)
>  
> +/* Try to naturally align allocations to extsz hint */
> +#define XFS_BMAPI_EXTSZALIGN	(1u << 11)

IMO "naturally" makes things confusing here -- are we aligning to the
extent size hint, or are we aligning to the length requested?  Or
whatever it is that "naturally" means.

(FWIW you and I have bumped over this repeatedly, so maybe this is
simple one of those cognitive friction things where block storage always
deals with powers of two and "naturally" means a lot, vs. filesystems
where we don't usually enforce alignment anywhere.)

I suggest "Try to align allocations to the extent size hint" for the
comment, and with that:
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +
>  #define XFS_BMAPI_FLAGS \
>  	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
>  	{ XFS_BMAPI_METADATA,	"METADATA" }, \
> @@ -98,7 +101,8 @@ struct xfs_bmalloca {
>  	{ XFS_BMAPI_REMAP,	"REMAP" }, \
>  	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
>  	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
> -	{ XFS_BMAPI_NORMAP,	"NORMAP" }
> +	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
> +	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }
>  
>  
>  static inline int xfs_bmapi_aflag(int w)
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index d097d33dc000..033dff86ecf0 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -445,6 +445,11 @@ xfs_reflink_fill_cow_hole(
>  	int			nimaps;
>  	int			error;
>  	bool			found;
> +	uint32_t		bmapi_flags = XFS_BMAPI_COWFORK |
> +					      XFS_BMAPI_PREALLOC;
> +
> +	if (atomic)
> +		bmapi_flags |= XFS_BMAPI_EXTSZALIGN;
>  
>  	resaligned = xfs_aligned_fsb_count(imap->br_startoff,
>  		imap->br_blockcount, xfs_get_cowextsz_hint(ip));
> @@ -478,8 +483,7 @@ xfs_reflink_fill_cow_hole(
>  	/* Allocate the entire reservation as unwritten blocks. */
>  	nimaps = 1;
>  	error = xfs_bmapi_write(tp, ip, imap->br_startoff, imap->br_blockcount,
> -			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC, 0, cmap,
> -			&nimaps);
> +			bmapi_flags, 0, cmap, &nimaps);
>  	if (error)
>  		goto out_trans_cancel;
>  
> -- 
> 2.31.1
> 
> 

