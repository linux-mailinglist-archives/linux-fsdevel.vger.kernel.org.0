Return-Path: <linux-fsdevel+bounces-17911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D9B8B3B1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 17:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C4CB2146F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B27515686F;
	Fri, 26 Apr 2024 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMDFW7a9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623A7148FE1;
	Fri, 26 Apr 2024 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144703; cv=none; b=H5DlhG9+nEKYv+xbBdroCLdvEB2AkxWwBL6zGYsA6QCZDiXlSMOilrTL9QmyJsGPy1w8kWfQF7A8yRzZJAkEFjL+L7+c8RViOitbeawtiW+ceoIwasaoK3KlTDB/RlPESQD+yG+Yyvd/8j5i94LoM188L78abvLFVvOYJ4MnH5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144703; c=relaxed/simple;
	bh=n/v/uLUsQ15WCp2AaJraFNUgoWERD2hobl8xT3E8igw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igMkZRKalDjubjDS8nQb9G1YKjGnkGvoC/tqc8jQMWU1RzouN3WWkcMeEnj8hGXW6iz954egJxLYC6bYBYBIzxa/f3jJCiLTEHQOq+pskV/FowSUTrtoAUP2IuWEL4D8kPQqy78WRPcvRjmHTQQcm8GacXGLyX8GpjElzymg5hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMDFW7a9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90E0C113CD;
	Fri, 26 Apr 2024 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714144703;
	bh=n/v/uLUsQ15WCp2AaJraFNUgoWERD2hobl8xT3E8igw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMDFW7a9U3o7Y2hUgw/ZUJRmT1py9N3cjjpicuoDHITq/LtsjWsdlwII4Ntim06KA
	 hbCJnkgI5gv0K0vANuxdpOy9wzDEUDGmmZQkrn/BwMbNe2FCTY+uaTGtfkR7tIr+Go
	 FvdZH5oi/tK77B3PChSAKg3Z8Ag7E5NAdU7LHLX7qDifRncH2ISkesFkgf/ZVmL3fZ
	 u+GYlfPu2fw6FDgPp8I2ItSe8swU9yEBeVQwKeCr3YpgR21LaGPVgKQiiRnL+QCT+K
	 H1/4vCZVYw8jX0TUVa5J6Q8Ju/qsXGsxyNxRpHokjThgG8OK2a9I1LqBbsZyfHXzgd
	 BcYNLQobOtPhw==
Date: Fri, 26 Apr 2024 08:18:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: willy@infradead.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 11/11] xfs: enable block size larger than page size
 support
Message-ID: <20240426151822.GG360919@frogsfrogsfrogs>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-12-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425113746.335530-12-kernel@pankajraghav.com>

On Thu, Apr 25, 2024 at 01:37:46PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Page cache now has the ability to have a minimum order when allocating
> a folio which is a prerequisite to add support for block size > page
> size.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Seems reasonable...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_ialloc.c |  5 +++++
>  fs/xfs/libxfs/xfs_shared.h |  3 +++
>  fs/xfs/xfs_icache.c        |  6 ++++--
>  fs/xfs/xfs_mount.c         |  1 -
>  fs/xfs/xfs_super.c         | 10 ++--------
>  5 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
> index e5ac3e5430c4..60005feb0015 100644
> --- a/fs/xfs/libxfs/xfs_ialloc.c
> +++ b/fs/xfs/libxfs/xfs_ialloc.c
> @@ -2975,6 +2975,11 @@ xfs_ialloc_setup_geometry(
>  		igeo->ialloc_align = mp->m_dalign;
>  	else
>  		igeo->ialloc_align = 0;
> +
> +	if (mp->m_sb.sb_blocksize > PAGE_SIZE)
> +		igeo->min_folio_order = mp->m_sb.sb_blocklog - PAGE_SHIFT;
> +	else
> +		igeo->min_folio_order = 0;
>  }
>  
>  /* Compute the location of the root directory inode that is laid out by mkfs. */
> diff --git a/fs/xfs/libxfs/xfs_shared.h b/fs/xfs/libxfs/xfs_shared.h
> index dfd61fa8332e..7d3abd182322 100644
> --- a/fs/xfs/libxfs/xfs_shared.h
> +++ b/fs/xfs/libxfs/xfs_shared.h
> @@ -229,6 +229,9 @@ struct xfs_ino_geometry {
>  	/* precomputed value for di_flags2 */
>  	uint64_t	new_diflags2;
>  
> +	/* minimum folio order of a page cache allocation */
> +	unsigned int	min_folio_order;
> +
>  };
>  
>  #endif /* __XFS_SHARED_H__ */
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 74f1812b03cb..a2629e00de41 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -89,7 +89,8 @@ xfs_inode_alloc(
>  	/* VFS doesn't initialise i_mode or i_state! */
>  	VFS_I(ip)->i_mode = 0;
>  	VFS_I(ip)->i_state = 0;
> -	mapping_set_large_folios(VFS_I(ip)->i_mapping);
> +	mapping_set_folio_min_order(VFS_I(ip)->i_mapping,
> +				    M_IGEO(mp)->min_folio_order);
>  
>  	XFS_STATS_INC(mp, vn_active);
>  	ASSERT(atomic_read(&ip->i_pincount) == 0);
> @@ -324,7 +325,8 @@ xfs_reinit_inode(
>  	inode->i_rdev = dev;
>  	inode->i_uid = uid;
>  	inode->i_gid = gid;
> -	mapping_set_large_folios(inode->i_mapping);
> +	mapping_set_folio_min_order(inode->i_mapping,
> +				    M_IGEO(mp)->min_folio_order);
>  	return error;
>  }
>  
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index 56d71282972a..a451302aa258 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -131,7 +131,6 @@ xfs_sb_validate_fsb_count(
>  	xfs_sb_t	*sbp,
>  	uint64_t	nblocks)
>  {
> -	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
>  	ASSERT(sbp->sb_blocklog >= BBSHIFT);
>  	uint64_t max_index;
>  	uint64_t max_bytes;
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index bce020374c5e..db3b82c2c381 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1623,16 +1623,10 @@ xfs_fs_fill_super(
>  		goto out_free_sb;
>  	}
>  
> -	/*
> -	 * Until this is fixed only page-sized or smaller data blocks work.
> -	 */
>  	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
>  		xfs_warn(mp,
> -		"File system with blocksize %d bytes. "
> -		"Only pagesize (%ld) or less will currently work.",
> -				mp->m_sb.sb_blocksize, PAGE_SIZE);
> -		error = -ENOSYS;
> -		goto out_free_sb;
> +"EXPERIMENTAL: Filesystem with Large Block Size (%d bytes) enabled.",
> +			mp->m_sb.sb_blocksize);
>  	}
>  
>  	/* Ensure this filesystem fits in the page cache limits */
> -- 
> 2.34.1
> 
> 

