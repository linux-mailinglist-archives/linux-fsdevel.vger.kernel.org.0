Return-Path: <linux-fsdevel+bounces-24491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A261093FB99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F5D1C228D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 16:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A7D1553A2;
	Mon, 29 Jul 2024 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TU6eKuRi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC87D15ECDB;
	Mon, 29 Jul 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271321; cv=none; b=Mn5MCLMPMtxVItJ7mjHl5gJpWOGI9PQ7mKbDQ0t/TI2HY1roGybm4iIetf4XMq3ePvglgQfGPA710GfzZH7oe5DqjmvenaSIkQ/Cnbwkzns3Wv7d0sVy4XYSAtReLY5eLjaGH0Fbs/QG0mK2CsMwvmH73DAilp6hHfmViVGqjcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271321; c=relaxed/simple;
	bh=STYJUioiL118Hlgwr4HXrqxbmA6PLG6V/dHdCUeL6U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPAv8UTfqxqFxj9o3aZOMSQ72bpKYIGtxWY5gtPbOlmY+Phgq/v86HaQUCFcS+zGYkyjv4NV94D+Xt0FfybHygtX04s9IL6/6FOKUOxf7mGyQCH3iEtAf4qXwvtuEAxceiDBOoIy1ZgfOKKuDuPazAgp+StKejEgUpXfsqPUTY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TU6eKuRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544D8C32786;
	Mon, 29 Jul 2024 16:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722271320;
	bh=STYJUioiL118Hlgwr4HXrqxbmA6PLG6V/dHdCUeL6U4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TU6eKuRicd3lcz+xcXI3oydUQnDeDfXJtlTH6WrdTIkHpdwcgLDqW+VSGdu4B3XAy
	 +91WIAIwEsRg15HYw9/eSnBEn0e33DMneMzn3ey1eKWeUaDr5NprWTmV4ZFkHvjqTN
	 xArt2eisQtQ3LQGXuXXdeY4rtfC5ZU8XcfdhOv0cwV0HCM/6EexXjEJl3Biuvt2yLH
	 HSt7d/BXS+b2o08R/vqKhLamKYkk2nTei6HBE3PWSuElvD9q87KyDAwtRaiY7ZLbtR
	 3ZxpP359LF0FoaOsM5BjKx8TEr8Buc/ZP5u1BlAm/toJ/b54e6qCOFItLoXgEQDC2+
	 NUdQ3e9FKksgg==
Date: Mon, 29 Jul 2024 09:41:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, ryan.roberts@arm.com, hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v11 10/10] xfs: enable block size larger than page size
 support
Message-ID: <20240729164159.GC6352@frogsfrogsfrogs>
References: <20240726115956.643538-1-kernel@pankajraghav.com>
 <20240726115956.643538-11-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726115956.643538-11-kernel@pankajraghav.com>

On Fri, Jul 26, 2024 at 01:59:56PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Page cache now has the ability to have a minimum order when allocating
> a folio which is a prerequisite to add support for block size > page
> size.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_ialloc.c |  5 +++++
>  fs/xfs/libxfs/xfs_shared.h |  3 +++
>  fs/xfs/xfs_icache.c        |  6 ++++--
>  fs/xfs/xfs_mount.c         |  1 -
>  fs/xfs/xfs_super.c         | 28 ++++++++++++++++++++--------
>  include/linux/pagemap.h    | 13 +++++++++++++
>  6 files changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
> index 0af5b7a33d055..1921b689888b8 100644
> --- a/fs/xfs/libxfs/xfs_ialloc.c
> +++ b/fs/xfs/libxfs/xfs_ialloc.c
> @@ -3033,6 +3033,11 @@ xfs_ialloc_setup_geometry(
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
> index 2f7413afbf46c..33b84a3a83ff6 100644
> --- a/fs/xfs/libxfs/xfs_shared.h
> +++ b/fs/xfs/libxfs/xfs_shared.h
> @@ -224,6 +224,9 @@ struct xfs_ino_geometry {
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
> index 27e9f749c4c7f..b2f5a1706c59d 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1638,16 +1638,28 @@ xfs_fs_fill_super(
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
> +"block size (%u bytes) not supported; Only block size (%ld) or less is supported",
> +			mp->m_sb.sb_blocksize, max_folio_size);

Dumb nit: Please indent ^^^ this second line so that it doesn't start on
the same column as the separate statement below it.

--D

> +			error = -ENOSYS;
> +			goto out_free_sb;
> +		}
> +
> +		xfs_warn(mp,
> +"EXPERIMENTAL: V5 Filesystem with Large Block Size (%d bytes) enabled.",
> +			mp->m_sb.sb_blocksize);
>  	}
>  
>  	/* Ensure this filesystem fits in the page cache limits */
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 3a876d6801a90..61a7649d86e57 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -373,6 +373,19 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>  #define MAX_XAS_ORDER		(XA_CHUNK_SHIFT * 2 - 1)
>  #define MAX_PAGECACHE_ORDER	min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER)
>  
> +/*
> + * mapping_max_folio_size_supported() - Check the max folio size supported
> + *
> + * The filesystem should call this function at mount time if there is a
> + * requirement on the folio mapping size in the page cache.
> + */
> +static inline size_t mapping_max_folio_size_supported(void)
> +{
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		return 1U << (PAGE_SHIFT + MAX_PAGECACHE_ORDER);
> +	return PAGE_SIZE;
> +}
> +
>  /*
>   * mapping_set_folio_order_range() - Set the orders supported by a file.
>   * @mapping: The address space of the file.
> -- 
> 2.44.1
> 
> 

