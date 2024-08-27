Return-Path: <linux-fsdevel+bounces-27411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 328CE96142D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51A7B21961
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166BE1CC150;
	Tue, 27 Aug 2024 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6QwQ84X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7489A1CE6F9;
	Tue, 27 Aug 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776643; cv=none; b=HOHQFSV6gll2ktLSdAg9YrMq8WGii6YbVQJ6SPlMBOvuN8iucm8DlcJDj0mmXuZq2xcUKeYhyY6Pesw4YOETzY3THp4iWST9dxlTEghd3ivJZOptTtGnxIRjh8v2A7YdAsHxhhnTFnJE4JOd5aB1L1cSD/BJ8phLXwpuoK4wysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776643; c=relaxed/simple;
	bh=mvSehc3EehbvAoAsqkIEwF2dBH7XDmmb1Qjzcd299RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDlN2zplbWyCzzPhdIzR9PaU0eW1NHsYK7NtaP0kYKLM9gXhiyPhKGEKkLsrCbUz9RaAb/n9RWHCqv/HX/0Up+fglLDX/4WZP7aQlaGGKjtthY2a0Whf0/6VGOw/Sr0lGeeQRQLfULoYN+FNhClLKPCsyfqJjGQ8Vl346WUM26A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6QwQ84X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02330C4AF0C;
	Tue, 27 Aug 2024 16:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724776643;
	bh=mvSehc3EehbvAoAsqkIEwF2dBH7XDmmb1Qjzcd299RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6QwQ84XjrmpvDnL7d4ov+VSjcsmal6lKmDXAxXSIWt8L5GaqF2cbmuoolYgTt6E1
	 tGO2Urki+JfM2mvNJ4zKA72v5F5BLpXPBrx2xzXL/xA3ghOSH0xNWbkQgG3bX+crp5
	 zB71kXyDjV823ZV3eC8Kyy1Z9k8ceXzzGqAd/724ZMWEEC2MD3J7muJVIjLpPGA54T
	 p4e++37BvxURgNvM3X+L649jj73E65VQBrEQxNkSNSDHfxYRAA6zDbHepr2kmcbiqD
	 0qbW2nCcVlshQYkz0T25r9p1sxHOR9ezyC5yvFs8wf9+ewoJCHNYLWJ8A6wKJ6WP3S
	 sRcLIO8B5z7EQ==
Date: Tue, 27 Aug 2024 09:37:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/10] xfs: support the COW fork in
 xfs_bmap_punch_delalloc_range
Message-ID: <20240827163722.GB865349@frogsfrogsfrogs>
References: <20240827051028.1751933-1-hch@lst.de>
 <20240827051028.1751933-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827051028.1751933-8-hch@lst.de>

On Tue, Aug 27, 2024 at 07:09:54AM +0200, Christoph Hellwig wrote:
> xfs_buffered_write_iomap_begin can also create delallocate reservations
> that need cleaning up, prepare for that by adding support for the COW
> fork in xfs_bmap_punch_delalloc_range.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Seems fine to me.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_aops.c      |  4 ++--
>  fs/xfs/xfs_bmap_util.c | 10 +++++++---
>  fs/xfs/xfs_bmap_util.h |  2 +-
>  fs/xfs/xfs_iomap.c     |  3 ++-
>  4 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 6dead20338e24c..559a3a57709748 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -116,7 +116,7 @@ xfs_end_ioend(
>  	if (unlikely(error)) {
>  		if (ioend->io_flags & IOMAP_F_SHARED) {
>  			xfs_reflink_cancel_cow_range(ip, offset, size, true);
> -			xfs_bmap_punch_delalloc_range(ip, offset,
> +			xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK, offset,
>  					offset + size);
>  		}
>  		goto done;
> @@ -456,7 +456,7 @@ xfs_discard_folio(
>  	 * byte of the next folio. Hence the end offset is only dependent on the
>  	 * folio itself and not the start offset that is passed in.
>  	 */
> -	xfs_bmap_punch_delalloc_range(ip, pos,
> +	xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK, pos,
>  				folio_pos(folio) + folio_size(folio));
>  }
>  
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index fe2e2c93097550..15c8f90f19a934 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -443,11 +443,12 @@ xfs_getbmap(
>  void
>  xfs_bmap_punch_delalloc_range(
>  	struct xfs_inode	*ip,
> +	int			whichfork,
>  	xfs_off_t		start_byte,
>  	xfs_off_t		end_byte)
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
> -	struct xfs_ifork	*ifp = &ip->i_df;
> +	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, whichfork);
>  	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, start_byte);
>  	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, end_byte);
>  	struct xfs_bmbt_irec	got, del;
> @@ -475,11 +476,14 @@ xfs_bmap_punch_delalloc_range(
>  			continue;
>  		}
>  
> -		xfs_bmap_del_extent_delay(ip, XFS_DATA_FORK, &icur, &got, &del);
> +		xfs_bmap_del_extent_delay(ip, whichfork, &icur, &got, &del);
>  		if (!xfs_iext_get_extent(ifp, &icur, &got))
>  			break;
>  	}
>  
> +	if (whichfork == XFS_COW_FORK && !ifp->if_bytes)
> +		xfs_inode_clear_cowblocks_tag(ip);
> +
>  out_unlock:
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  }
> @@ -590,7 +594,7 @@ xfs_free_eofblocks(
>  	 */
>  	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND)) {
>  		if (ip->i_delayed_blks) {
> -			xfs_bmap_punch_delalloc_range(ip,
> +			xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK,
>  				round_up(XFS_ISIZE(ip), mp->m_sb.sb_blocksize),
>  				LLONG_MAX);
>  		}
> diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
> index eb0895bfb9dae4..b29760d36e1ab1 100644
> --- a/fs/xfs/xfs_bmap_util.h
> +++ b/fs/xfs/xfs_bmap_util.h
> @@ -30,7 +30,7 @@ xfs_bmap_rtalloc(struct xfs_bmalloca *ap)
>  }
>  #endif /* CONFIG_XFS_RT */
>  
> -void	xfs_bmap_punch_delalloc_range(struct xfs_inode *ip,
> +void	xfs_bmap_punch_delalloc_range(struct xfs_inode *ip, int whichfork,
>  		xfs_off_t start_byte, xfs_off_t end_byte);
>  
>  struct kgetbmap {
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 1e11f48814c0d0..24d69c8c168aeb 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1215,7 +1215,8 @@ xfs_buffered_write_delalloc_punch(
>  	loff_t			length,
>  	struct iomap		*iomap)
>  {
> -	xfs_bmap_punch_delalloc_range(XFS_I(inode), offset, offset + length);
> +	xfs_bmap_punch_delalloc_range(XFS_I(inode), XFS_DATA_FORK, offset,
> +			offset + length);
>  }
>  
>  static int
> -- 
> 2.43.0
> 
> 

