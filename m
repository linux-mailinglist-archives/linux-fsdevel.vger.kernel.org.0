Return-Path: <linux-fsdevel+bounces-10064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7B4847705
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027822851F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 18:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D1A14C5AF;
	Fri,  2 Feb 2024 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZgcd9zP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134491474C5;
	Fri,  2 Feb 2024 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897118; cv=none; b=T4rw9m7mIPR+hgKmdhccmlSNqI5lhOCJmYIipWK6qUM436Askd/TzHvlnE5LHce73GLHHKa2ywDQqCA6ajjJfWW+phzGMAQvhDHD46HSxeeOSs0A7dGlRrKRDN7GFLvtBnskgktREG1Qv6YAnSvvkhmQIvl/jyqmkMDy9Vbledw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897118; c=relaxed/simple;
	bh=olo2S86ZYQ/eGQSOM1XFs9GP1TojuSirmzniy3SSRwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRDNJl31PFcuoYIubnecG810e7j/fba92yKDUijRNkyyLsvEN+Pp7obQvLy2j5UL8R9VO0tNbEK5a6QLb6E3eHkfGNY0junFz76q/gxfpw9gUNGVjRmqexlTBa/qfJmYCac5RcpUT7KNvkdo6EKtuQXZSA1c7MiOHS7Hg4GOK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZgcd9zP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04C0C433F1;
	Fri,  2 Feb 2024 18:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706897117;
	bh=olo2S86ZYQ/eGQSOM1XFs9GP1TojuSirmzniy3SSRwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZgcd9zPA3O/QuDNLFlQ9JscwJzCtLhDmmPswtCc1dYYJHOSkyksL1ZzPuN3W0IAt
	 x4OFrgQbC0KnEfSCY4lDfDby76KV0w+JEWSJMfyS1jt8n6ytRx81ZfdvhqR63vTanv
	 JaS0looi220Et9Xf9Lot83//FNqb1RHIO/JfTpx1JckTXN24Nryl6C4t1C2acXKsne
	 nCHepnmLgjrL2CyKsoX5pzbUL7NYxQC+m09quZGKLaQFhkLTr2puYGdtHgMTRqpk4t
	 +zZiIEsRaNFvbOvSgXCKagvpkhbKzB0tceUOXOKZAB0G0b58iumOdpo7PW9yhpiGgX
	 OTMhkSDbysRXQ==
Date: Fri, 2 Feb 2024 10:05:17 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH 4/6] fs: xfs: Support atomic write for statx
Message-ID: <20240202180517.GJ6184@frogsfrogsfrogs>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-5-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124142645.9334-5-john.g.garry@oracle.com>

On Wed, Jan 24, 2024 at 02:26:43PM +0000, John Garry wrote:
> Support providing info on atomic write unit min and max for an inode.
> 
> For simplicity, currently we limit the min at the FS block size, but a
> lower limit could be supported in future.
> 
> The atomic write unit min and max is limited by the guaranteed extent
> alignment for the inode.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_iops.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_iops.h |  4 ++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index a0d77f5f512e..0890d2f70f4d 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -546,6 +546,44 @@ xfs_stat_blksize(
>  	return PAGE_SIZE;
>  }
>  
> +void xfs_get_atomic_write_attr(

static void?

> +	struct xfs_inode *ip,
> +	unsigned int *unit_min,
> +	unsigned int *unit_max)

Weird indenting here.

> +{
> +	xfs_extlen_t		extsz = xfs_get_extsz(ip);
> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> +	struct block_device	*bdev = target->bt_bdev;
> +	unsigned int		awu_min, awu_max, align;
> +	struct request_queue	*q = bdev->bd_queue;
> +	struct xfs_mount	*mp = ip->i_mount;
> +
> +	/*
> +	 * Convert to multiples of the BLOCKSIZE (as we support a minimum
> +	 * atomic write unit of BLOCKSIZE).
> +	 */
> +	awu_min = queue_atomic_write_unit_min_bytes(q);
> +	awu_max = queue_atomic_write_unit_max_bytes(q);
> +
> +	awu_min &= ~mp->m_blockmask;

Why do you round /down/ the awu_min value here?

> +	awu_max &= ~mp->m_blockmask;

Actually -- since the atomic write units have to be powers of 2, why is
rounding needed here at all?

> +
> +	align = XFS_FSB_TO_B(mp, extsz);
> +
> +	if (!awu_max || !xfs_inode_atomicwrites(ip) || !align ||
> +	    !is_power_of_2(align)) {

...and if you take my suggestion to make a common helper to validate the
atomic write unit parameters, this can collapse into:

	alloc_unit_bytes = xfs_inode_alloc_unitsize(ip);
	if (!xfs_inode_has_atomicwrites(ip) ||
	    !bdev_validate_atomic_write(bdev, alloc_unit_bytes)) {
		/* not supported, return zeroes */
		*unit_min = 0;
		*unit_max = 0;
		return;
	}

	*unit_min = max(alloc_unit_bytes, awu_min);
	*unit_max = min(alloc_unit_bytes, awu_max);

--D

> +		*unit_min = 0;
> +		*unit_max = 0;
> +	} else {
> +		if (awu_min)
> +			*unit_min = min(awu_min, align);
> +		else
> +			*unit_min = mp->m_sb.sb_blocksize;
> +
> +		*unit_max = min(awu_max, align);
> +	}
> +}
> +
>  STATIC int
>  xfs_vn_getattr(
>  	struct mnt_idmap	*idmap,
> @@ -619,6 +657,13 @@ xfs_vn_getattr(
>  			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
>  			stat->dio_offset_align = bdev_logical_block_size(bdev);
>  		}
> +		if (request_mask & STATX_WRITE_ATOMIC) {
> +			unsigned int unit_min, unit_max;
> +
> +			xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
> +			generic_fill_statx_atomic_writes(stat,
> +				unit_min, unit_max);
> +		}
>  		fallthrough;
>  	default:
>  		stat->blksize = xfs_stat_blksize(ip);
> diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
> index 7f84a0843b24..76dd4c3687aa 100644
> --- a/fs/xfs/xfs_iops.h
> +++ b/fs/xfs/xfs_iops.h
> @@ -19,4 +19,8 @@ int xfs_vn_setattr_size(struct mnt_idmap *idmap,
>  int xfs_inode_init_security(struct inode *inode, struct inode *dir,
>  		const struct qstr *qstr);
>  
> +void xfs_get_atomic_write_attr(struct xfs_inode *ip,
> +		unsigned int *unit_min,
> +		unsigned int *unit_max);
> +
>  #endif /* __XFS_IOPS_H__ */
> -- 
> 2.31.1
> 
> 

