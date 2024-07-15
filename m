Return-Path: <linux-fsdevel+bounces-23705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7809318B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 18:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3A01C218F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 16:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154FF1CFB9;
	Mon, 15 Jul 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdLW+j6Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951F17BB5;
	Mon, 15 Jul 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061993; cv=none; b=tsTBFVuOstY3VbNQA0TY6V8HbS6Wtlkag7I5kE+SrghAyUfLrs9cpla7HEjFEDmmxjcYOXwCJW00988HAj3bqpt0xLnB1kw0QoCY38MIwBO2bNLOo0laayRkF59hxvo1UBABPsFP5Gnafjlb8+8zDkGsinvuc7OAAGcsPWu2p20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061993; c=relaxed/simple;
	bh=CKsM6X/ILuteI/53RzhvTkmwmrJCL208UsIV57Va2XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNuuVTdbnrUp02jBOSdpNOhioNj9EPEi6NcZFsY0Moy0M7DKxiSCSlsxbFP3dDvUOE8LWVRVIqHoPo/JXF+xwV/K51LHlsVXhVUK1yco4ge5zdbOqdmHZOpS+L/X3eGTLf6QC67X9M9zdtIfnLoLbs4bi2w3IVCYmCkFv70HG68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdLW+j6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C15C32782;
	Mon, 15 Jul 2024 16:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721061993;
	bh=CKsM6X/ILuteI/53RzhvTkmwmrJCL208UsIV57Va2XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdLW+j6Y+Ki7ty31Vru/uvWcM/bxoTE4hvdOxHnGU07Kdd2OSMBKVf9ECGreERRqs
	 Zi9Ek+1I4cz2tW2Vx//6jjeOgwNXNwUQ0EFxlvKz0bTEKwZvHpdp9M6X1YhDg3XWOB
	 RKiY4IJADKm3BBoqvlFqU0/xk9ZKv5e9/lAEeGf3Se5PZ7lbaGCPHZUdGi9fSABPG8
	 BwBKcbHj0IE6e/xujl5RVkZj4wxa6lUjkgWRxDLityGAWyPpsY2d4gMBbILfX6arRW
	 wx/iUL/JppWzfd7b8kmn2WjqbtFaWhc/X2nyXlhBBT7PqoyESqdN7GsUgqKkpHn3Xz
	 USjUiKDmoaENg==
Date: Mon, 15 Jul 2024 09:46:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, ryan.roberts@arm.com, hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v10 10/10] xfs: enable block size larger than page size
 support
Message-ID: <20240715164632.GV612460@frogsfrogsfrogs>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
 <20240715094457.452836-11-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715094457.452836-11-kernel@pankajraghav.com>

On Mon, Jul 15, 2024 at 11:44:57AM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Page cache now has the ability to have a minimum order when allocating
> a folio which is a prerequisite to add support for block size > page
> size.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_ialloc.c |  5 +++++
>  fs/xfs/libxfs/xfs_shared.h |  3 +++
>  fs/xfs/xfs_icache.c        |  6 ++++--
>  fs/xfs/xfs_mount.c         |  1 -
>  fs/xfs/xfs_super.c         | 30 ++++++++++++++++++++++--------
>  5 files changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
> index 14c81f227c5bb..1e76431d75a4b 100644
> --- a/fs/xfs/libxfs/xfs_ialloc.c
> +++ b/fs/xfs/libxfs/xfs_ialloc.c
> @@ -3019,6 +3019,11 @@ xfs_ialloc_setup_geometry(
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
> index 34f104ed372c0..e67a1c7cc0b02 100644
> --- a/fs/xfs/libxfs/xfs_shared.h
> +++ b/fs/xfs/libxfs/xfs_shared.h
> @@ -231,6 +231,9 @@ struct xfs_ino_geometry {
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
> index cf629302d48e7..0fcf235e50235 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -88,7 +88,8 @@ xfs_inode_alloc(
>  
>  	/* VFS doesn't initialise i_mode! */
>  	VFS_I(ip)->i_mode = 0;
> -	mapping_set_large_folios(VFS_I(ip)->i_mapping);
> +	mapping_set_folio_min_order(VFS_I(ip)->i_mapping,
> +				    M_IGEO(mp)->min_folio_order);
>  
>  	XFS_STATS_INC(mp, vn_active);
>  	ASSERT(atomic_read(&ip->i_pincount) == 0);
> @@ -325,7 +326,8 @@ xfs_reinit_inode(
>  	inode->i_uid = uid;
>  	inode->i_gid = gid;
>  	inode->i_state = state;
> -	mapping_set_large_folios(inode->i_mapping);
> +	mapping_set_folio_min_order(inode->i_mapping,
> +				    M_IGEO(mp)->min_folio_order);
>  	return error;
>  }
>  
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index 3949f720b5354..c6933440f8066 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -134,7 +134,6 @@ xfs_sb_validate_fsb_count(
>  {
>  	uint64_t		max_bytes;
>  
> -	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
>  	ASSERT(sbp->sb_blocklog >= BBSHIFT);
>  
>  	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 27e9f749c4c7f..3c455ef588d48 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1638,16 +1638,30 @@ xfs_fs_fill_super(
>  		goto out_free_sb;
>  	}
>  
> -	/*
> -	 * Until this is fixed only page-sized or smaller data blocks work.
> -	 */
>  	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
> -		xfs_warn(mp,
> -		"File system with blocksize %d bytes. "
> -		"Only pagesize (%ld) or less will currently work.",
> +		size_t max_folio_size = mapping_max_folio_size_supported();
> +
> +		if (!xfs_has_crc(mp)) {
> +			xfs_warn(mp,
> +"V4 Filesystem with blocksize %d bytes. Only pagesize (%ld) or less is supported.",
>  				mp->m_sb.sb_blocksize, PAGE_SIZE);
> -		error = -ENOSYS;
> -		goto out_free_sb;
> +			error = -ENOSYS;
> +			goto out_free_sb;
> +		}
> +
> +		if (mp->m_sb.sb_blocksize > max_folio_size) {
> +			xfs_warn(mp,
> +"block size (%u bytes) not supported; maximum folio size supported in "\
> +"the page cache is (%ld bytes). Check MAX_PAGECACHE_ORDER (%d)",
> +			mp->m_sb.sb_blocksize, max_folio_size,
> +			MAX_PAGECACHE_ORDER);
> +			error = -ENOSYS;
> +			goto out_free_sb;

Nit: Continuation lines should be indented, not lined up with the next
statement:

			xfs_warn(mp,
"block size (%u bytes) not supported; maximum folio size supported in "\
"the page cache is (%ld bytes). Check MAX_PAGECACHE_ORDER (%d)",
					mp->m_sb.sb_blocksize,
					max_folio_size,
					MAX_PAGECACHE_ORDER);
			error = -ENOSYS;
			goto out_free_sb;

With that fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +		}
> +
> +		xfs_warn(mp,
> +"EXPERIMENTAL: V5 Filesystem with Large Block Size (%d bytes) enabled.",
> +			mp->m_sb.sb_blocksize);
>  	}
>  
>  	/* Ensure this filesystem fits in the page cache limits */
> -- 
> 2.44.1
> 
> 

