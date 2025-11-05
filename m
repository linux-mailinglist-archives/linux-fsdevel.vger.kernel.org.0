Return-Path: <linux-fsdevel+bounces-67224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8380DC3835C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 23:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19242189A7E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 22:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D702EFD95;
	Wed,  5 Nov 2025 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5IcYbS8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD52C296BB3;
	Wed,  5 Nov 2025 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382237; cv=none; b=pFYJBe9V4hYXcv0zDA99N1xGQK2Qf4rMPhNVbuVpKbUCeAag8wJEjtevL474/NzxyOHqtfPphD6V3sBa7aJv08rGG2tYdJ4CE6qRol/44bmMEaISeUOI34hhcysjO/qE6p/nPa6UTs3xV3MrykWNogZiqeSlS140/avkbAOBTtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382237; c=relaxed/simple;
	bh=q+C3/IslLpBtokaaPSnhZWXbEjSBqlpoHmBWRxFsodI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sg4w6wLS5smKZ3vTJePbI0fu2/VmpWhzCNTs9IcB9FyrJYzD12haATcxB8q2UFe2dh7/JGOaO6JY/wnL+N3mk/P8FRmorv/IbESUOtfTeRR1pdGkEwLQv3LqXeDmPpGLmFUmmRqY/WCAeJbliAvekcpqdPcX9te6SVnaihTReiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5IcYbS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4876AC4CEFB;
	Wed,  5 Nov 2025 22:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762382236;
	bh=q+C3/IslLpBtokaaPSnhZWXbEjSBqlpoHmBWRxFsodI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O5IcYbS84fxyFSuOR/5dI9tPNB7thCsZYBtMSEIQiUXhFTWKaHLJlAStw3OJsm2Xo
	 udPlC66/X8WFDYHfJqC7h4aai0y1wARt7j4TA6LZxPa2vr0VW2gr283YpSDY3GnROx
	 WgHl8hf63njPD7k2dJg/lTy0On98qWpdAcAQ+n4ZpT88ZFoZX/UL/+D+2MJQHGbLs/
	 FiVJWB6w4QD8RvS0FRBTtYo7HG3X0n/ygGPlE+Avd5O0mkRNtCZNb5rPC5zHPf4Uch
	 7ll/fMbFK1xlPIxHt8BDyLbjM/XflmwMcNNSsw/KZc+PmfQBqAqZcy9QvKcA7q8x0U
	 Oc/VysDYKiVoA==
Date: Wed, 5 Nov 2025 14:37:15 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/6] xfs: replace zero range flush with folio batch
Message-ID: <20251105223715.GI196370@frogsfrogsfrogs>
References: <20251016190303.53881-1-bfoster@redhat.com>
 <20251016190303.53881-7-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016190303.53881-7-bfoster@redhat.com>

On Thu, Oct 16, 2025 at 03:03:03PM -0400, Brian Foster wrote:
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
> ---
>  fs/iomap/buffered-io.c |  4 ----
>  fs/xfs/xfs_iomap.c     | 16 ++++------------
>  2 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d6de689374c3..7bc4b8d090ee 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1534,10 +1534,6 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
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
> index 29f1462819fa..5a845a0ded79 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1704,7 +1704,6 @@ xfs_buffered_write_iomap_begin(
>  {
>  	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter,
>  						     iomap);
> -	struct address_space	*mapping = inode->i_mapping;
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> @@ -1736,7 +1735,6 @@ xfs_buffered_write_iomap_begin(
>  	if (error)
>  		return error;
>  
> -restart:
>  	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
>  	if (error)
>  		return error;
> @@ -1812,16 +1810,10 @@ xfs_buffered_write_iomap_begin(
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
> +		iomap_flags |= iomap_fill_dirty_folios(iter, &start, end);
> +		xfs_trim_extent(&imap, offset_fsb,
> +				XFS_B_TO_FSB(mp, start) - offset_fsb);

Hrm, ok.  This replaces the pagecache flush with passing in folios and
letting iomap zero the folios regardless of whatever's in the mapping.
That seems to me like a reasonable way to solve the immediate problem
without the huge reengineering ->iomap_begin project.

The changes here mostly look ok to me, though I wonder how well this all
meshes with all the other iomap work headed to 6.19...

--D

>  
>  		goto found_imap;
>  	}
> -- 
> 2.51.0
> 
> 

