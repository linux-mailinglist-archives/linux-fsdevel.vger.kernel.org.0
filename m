Return-Path: <linux-fsdevel+bounces-31967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 124D199E952
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 14:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85396B24ED2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 12:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0231EBFED;
	Tue, 15 Oct 2024 12:15:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2865B18733B;
	Tue, 15 Oct 2024 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994546; cv=none; b=nKKX364O4owcDP5K1j4fD13NquvSOeA8xMZbQcrHyPwJAVroANcR6ibgFAc+RUyc7wm/AggWQQuQdx87cAgdLVeuJLQ7fSTB7dQbLRJqhUyI2j/fTkydh6+XEtyPzbKAQXSdAHl2gG9Gls8VXOsK2EGGKUz+T9HZLLUv105ge48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994546; c=relaxed/simple;
	bh=Pm0CbbyeNfc4CERynVhX1FoI8demKB1DJmMEgEJ6AHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvsNw68reidUIGU8o9hJl25yWjfYPZfkptTPXtQTJ6lyq//9NlqemRqit/64pBlNR4farvhWoYvc2utEq7acIVAobc+QsEHUIa0ubU6UrpzXcRo2WvU+FM6nH9YL42O3zAjR3xr1YuLiqX9f1ajxHbuLmCSWicaiixjgNA0UlJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B6E7B227AAC; Tue, 15 Oct 2024 14:15:39 +0200 (CEST)
Date: Tue, 15 Oct 2024 14:15:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com,
	hch@lst.de, cem@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v8 5/7] xfs: Support atomic write for statx
Message-ID: <20241015121539.GB32583@lst.de>
References: <20241015090142.3189518-1-john.g.garry@oracle.com> <20241015090142.3189518-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015090142.3189518-6-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 15, 2024 at 09:01:40AM +0000, John Garry wrote:
> Support providing info on atomic write unit min and max for an inode.
> 
> For simplicity, currently we limit the min at the FS block size. As for
> max, we limit also at FS block size, as there is no current method to
> guarantee extent alignment or granularity for regular files.
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_buf.c   |  7 +++++++
>  fs/xfs/xfs_buf.h   |  3 +++
>  fs/xfs/xfs_inode.h | 15 +++++++++++++++
>  fs/xfs/xfs_iops.c  | 25 +++++++++++++++++++++++++
>  4 files changed, 50 insertions(+)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index aa4dbda7b536..e279e5e139ff 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -2115,6 +2115,13 @@ xfs_alloc_buftarg(
>  	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
>  					    mp, ops);
>  
> +	if (bdev_can_atomic_write(btp->bt_bdev)) {
> +		struct request_queue *q = bdev_get_queue(btp->bt_bdev);
> +
> +		btp->bt_bdev_awu_min = queue_atomic_write_unit_min_bytes(q);
> +		btp->bt_bdev_awu_max = queue_atomic_write_unit_max_bytes(q);

Consumers of the block layer should never see request_queue.  While there
is a few leftovers still I've cleaned most of this up.  Please add
bdev_atomic_write_unit_min_bytes and bdev_atomic_write_unit_max_bytes
helpers for use by file systems and stacking drivers, similar to the
other queue limits.

> +	/* Atomic write unit values */
> +	unsigned int		bt_bdev_awu_min, bt_bdev_awu_max;

Nit: While having two struct members declare on the same line using the
same type specification is perfectly valid C, it looks odd and we avoid
it in XFS (and most of the kernel).  Please split this into two lines.

> +	struct xfs_mount	*mp = ip->i_mount;
> +	struct xfs_sb		*sbp = &mp->m_sb;
> +
> +	if (!xfs_inode_can_atomicwrite(ip)) {
> +		*unit_min = *unit_max = 0;
> +		return;
> +	}
> +
> +	*unit_min = *unit_max = sbp->sb_blocksize;

Nit: I'd do with the single use sbp local variable here.

> +}
> +
>  STATIC int
>  xfs_vn_getattr(
>  	struct mnt_idmap	*idmap,
> @@ -643,6 +660,14 @@ xfs_vn_getattr(
>  			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
>  			stat->dio_offset_align = bdev_logical_block_size(bdev);
>  		}
> +		if (request_mask & STATX_WRITE_ATOMIC) {
> +			unsigned int unit_min, unit_max;

Nit: XFS (unlike the rest of the kernel) uses tab alignments for
variables.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


