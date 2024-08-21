Return-Path: <linux-fsdevel+bounces-26507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA7395A38C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410701C20FB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312611B2536;
	Wed, 21 Aug 2024 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFVb/U6N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8090213E022;
	Wed, 21 Aug 2024 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260168; cv=none; b=PuVdq4nGsKkWlUU9Vb4YlKtP6YQ7Z5iLlYWORZrtoQCKBx9PkzlxVFa+/FijG+Vf6fPnUEnCeTruCS5l7sOT7A9z7+9laBrLjKYZ5jqHQPCoE88pMgx0XT9zPufIIEmCGIcwmAnwYOlmJvlUng4rUQ4JNkkNB9HxifwA0SrbdE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260168; c=relaxed/simple;
	bh=QC4AG6z/uAbk4TVuk1RdFIllYC4yOGoMABFL0qyB2uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBzPsEF/Nx9udARqwnSoLGw0HYUW7OepegLl4JynSVtGYdEde9CSMYo9JzGw0/mubwk3Aj3cW6W9LIwW0o3/bCTQ8GdqwY2/UCneM9BxNvCif3FrJyoJcuLo/TEjqX+R/T7K14DPYlrwrcW+psutRtcuT5NIGTTYjCAPD0UucfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFVb/U6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D31FC32781;
	Wed, 21 Aug 2024 17:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724260168;
	bh=QC4AG6z/uAbk4TVuk1RdFIllYC4yOGoMABFL0qyB2uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFVb/U6NU+QAdAgMIAFMZYdcRApL1DwH0pwNUyVtC3yB1XHPavZGPvXTSB+PxUyN7
	 FgCijz34hjijW36s/61Ndef7NICAcqhMY7KzD5jGy70maGB0wruua+PW35cp2HIZW3
	 0swmpOeZ98SXY33DnQU3ERy5M8wV9aHMH0ldsm9kOtshvhmZFsoJm14hPAe0gWhG9r
	 nvrCPnNiBZuwxTqMqzDZznpTn+DbTmE+e3UIfh8NK8bh5CoJ54mm5sXrn+axJtIHQy
	 T/kIVIAxLlWE7zWA2FK6LVrjxNlt3wpPTqKySk6FWDFaYZ1nN2hlgOQkxPowye1nfE
	 P0irENwBUSn3A==
Date: Wed, 21 Aug 2024 10:09:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, chandan.babu@oracle.com, dchinner@redhat.com,
	hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	kbusch@kernel.org
Subject: Re: [PATCH v5 5/7] xfs: Support atomic write for statx
Message-ID: <20240821170927.GK865349@frogsfrogsfrogs>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817094800.776408-6-john.g.garry@oracle.com>

On Sat, Aug 17, 2024 at 09:47:58AM +0000, John Garry wrote:
> Support providing info on atomic write unit min and max for an inode.
> 
> For simplicity, currently we limit the min at the FS block size, but a
> lower limit could be supported in future. This is required by iomap
> DIO.
> 
> The atomic write unit min and max is limited by the guaranteed extent
> alignment for the inode.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_iops.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 6e017aa6f61d..c20becd3a7c9 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -570,6 +570,27 @@ xfs_stat_blksize(
>  	return PAGE_SIZE;
>  }
>  
> +static void
> +xfs_get_atomic_write_attr(
> +	struct xfs_inode	*ip,
> +	unsigned int		*unit_min,
> +	unsigned int		*unit_max)
> +{
> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> +	struct xfs_mount	*mp = ip->i_mount;
> +	struct xfs_sb		*sbp = &mp->m_sb;
> +	unsigned int		extsz_bytes = XFS_FSB_TO_B(mp, ip->i_extsize);
> +
> +	if (!xfs_inode_has_atomicwrites(ip)) {

Here's where you might want to check that DIFLAG2_ATOMICWRITES is sset
and stripe alignment still makes sense before handing out nonzero
STATX_WRITE_ATOMIC information.  The rest of the patch looks ok to me.

--D

> +		*unit_min = 0;
> +		*unit_max = 0;
> +		return;
> +	}
> +
> +	*unit_min = sbp->sb_blocksize;
> +	*unit_max = min(target->bt_bdev_awu_max, extsz_bytes);
> +}
> +
>  STATIC int
>  xfs_vn_getattr(
>  	struct mnt_idmap	*idmap,
> @@ -643,6 +664,13 @@ xfs_vn_getattr(
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
> -- 
> 2.31.1
> 
> 

