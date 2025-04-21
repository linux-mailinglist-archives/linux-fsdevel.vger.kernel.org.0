Return-Path: <linux-fsdevel+bounces-46854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B45A957D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 23:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F1D3B4F3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 21:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E61219304;
	Mon, 21 Apr 2025 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWbByfGy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568421DEFDD;
	Mon, 21 Apr 2025 21:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745270303; cv=none; b=Hclo0GMqd0jU7X5wP9eWOc+zUcmgCMjbhzvydV5KGQHiQN6BQPa0BPgYQAk9DO9Ky/8dmrLJWerOScbSAT1dRKWV+DO5awuW3dIQtjpleMQ/WlZrB/fAjMPtZppjlUEWfS7jsUfMuVgOyegIJZWi22HGC/sB42S5ILxjCH76PtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745270303; c=relaxed/simple;
	bh=nm/spt30O/o+pWKt15dVV16PBqrGcK+Efxp5WTZ2q6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smcROfiPRPZA/TePjKbihSrBlvq7TCvldH85ZtLCJQDrAEKzYRXz0dSFJ0yzEjmA3a4LtbZVtPeTS0GJlwO89tWxbcqw8yOS4kJyRlqVKBnBtFgt1739DGvCjD7vvhmQTwrLOQuz6GHtKFKMaoMbJlj/RDc9lSTLq6dzOd8Angc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWbByfGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A947C4CEE4;
	Mon, 21 Apr 2025 21:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745270302;
	bh=nm/spt30O/o+pWKt15dVV16PBqrGcK+Efxp5WTZ2q6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWbByfGyg2xHttX9Ke26F3lJ1auGSoAUUYDxTSvYY6oNDze89JhBx8wO6MuaIB8iC
	 hxkrcEKiVfGpKMchkp24LvMHJ1VOxPz0QCcQEQ3EFFPxOTfvUKMcm9UNAzioMoQRhw
	 i56Dxsawujw3GjTPFtyTOFSa1uWp1GlEXQTea26FmqBRDro+VlbHXBU3CUcmPu9NiZ
	 myflRWL5UcGgR1Cof63Af0ZwwUByuJ/YMuYnpvfTKBMFbSVLhPtPHMclwJwCy3ECe2
	 DzDI4+Uk4keuyw+wju8weC66y0XX682AXNQRr2eDWLX+e7iNok28P0D1WldgSuA2JK
	 L5zNy4wM6v+QQ==
Date: Mon, 21 Apr 2025 14:18:20 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH v7 11/14] xfs: add xfs_file_dio_write_atomic()
Message-ID: <aAa2HMvKcIGdbJlF@bombadil.infradead.org>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-12-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415121425.4146847-12-john.g.garry@oracle.com>

On Tue, Apr 15, 2025 at 12:14:22PM +0000, John Garry wrote:
> Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.
> 
> The function works based on two operating modes:
> - HW offload, i.e. REQ_ATOMIC-based
> - CoW based with out-of-places write and atomic extent remapping
> 
> The preferred method is HW offload as it will be faster. If HW offload is
> not possible, then we fallback to the CoW-based method.
> 
> HW offload would not be possible for the write length exceeding the HW
> offload limit, the write spanning multiple extents, unaligned disk blocks,
> etc.
> 
> Apart from the write exceeding the HW offload limit, other conditions for
> HW offload can only be detected in the iomap handling for the write. As
> such, we use a fallback method to issue the write if we detect in the
> ->iomap_begin() handler that HW offload is not possible. Special code
> -ENOPROTOOPT is returned from ->iomap_begin() to inform that HW offload
> not possible.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/xfs/xfs_file.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index ba4b02abc6e4..81a377f65aa3 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -728,6 +728,72 @@ xfs_file_dio_write_zoned(
>  	return ret;
>  }
>  
> +/*
> + * Handle block atomic writes
> + *
> + * Two methods of atomic writes are supported:
> + * - REQ_ATOMIC-based, which would typically use some form of HW offload in the
> + *   disk
> + * - COW-based, which uses a COW fork as a staging extent for data updates
> + *   before atomically updating extent mappings for the range being written
> + *
> + */
> +static noinline ssize_t
> +xfs_file_dio_write_atomic(
> +	struct xfs_inode	*ip,
> +	struct kiocb		*iocb,
> +	struct iov_iter		*from)
> +{
> +	unsigned int		iolock = XFS_IOLOCK_SHARED;
> +	ssize_t			ret, ocount = iov_iter_count(from);
> +	const struct iomap_ops	*dops;
> +
> +	/*
> +	 * HW offload should be faster, so try that first if it is already
> +	 * known that the write length is not too large.
> +	 */
> +	if (ocount > xfs_inode_buftarg(ip)->bt_bdev_awu_max)
> +		dops = &xfs_atomic_write_cow_iomap_ops;
> +	else
> +		dops = &xfs_direct_write_iomap_ops;
> +
> +retry:
> +	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
> +	if (ret)
> +		return ret;
> +
> +	ret = xfs_file_write_checks(iocb, from, &iolock, NULL);
> +	if (ret)
> +		goto out_unlock;
> +
> +	/* Demote similar to xfs_file_dio_write_aligned() */
> +	if (iolock == XFS_IOLOCK_EXCL) {
> +		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
> +		iolock = XFS_IOLOCK_SHARED;
> +	}
> +
> +	trace_xfs_file_direct_write(iocb, from);
> +	ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops,
> +			0, NULL, 0);
> +
> +	/*
> +	 * The retry mechanism is based on the ->iomap_begin method returning
> +	 * -ENOPROTOOPT, which would be when the REQ_ATOMIC-based write is not
> +	 * possible. The REQ_ATOMIC-based method typically not be possible if
> +	 * the write spans multiple extents or the disk blocks are misaligned.
> +	 */
> +	if (ret == -ENOPROTOOPT && dops == &xfs_direct_write_iomap_ops) {

Based on feedback from LSFMM, due to the performance variaibility this
can introduce, it sounded like some folks would like to opt-in to not
have a software fallback and just require an error out.

Could an option be added to not allow the software fallback?

If so, then I think the next patch would also need updating.

Or are you suggesting that without the software fallback atomic writes
greater than fs block size are not possible?

  Luis

> +		xfs_iunlock(ip, iolock);
> +		dops = &xfs_atomic_write_cow_iomap_ops;
> +		goto retry;
> +	}
> +
> +out_unlock:
> +	if (iolock)
> +		xfs_iunlock(ip, iolock);
> +	return ret;
> +}
> +
>  /*
>   * Handle block unaligned direct I/O writes
>   *
> @@ -843,6 +909,8 @@ xfs_file_dio_write(
>  		return xfs_file_dio_write_unaligned(ip, iocb, from);
>  	if (xfs_is_zoned_inode(ip))
>  		return xfs_file_dio_write_zoned(ip, iocb, from);
> +	if (iocb->ki_flags & IOCB_ATOMIC)
> +		return xfs_file_dio_write_atomic(ip, iocb, from);
>  	return xfs_file_dio_write_aligned(ip, iocb, from,
>  			&xfs_direct_write_iomap_ops, &xfs_dio_write_ops, NULL);
>  }
> -- 
> 2.31.1
> 

