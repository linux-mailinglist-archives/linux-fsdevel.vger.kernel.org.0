Return-Path: <linux-fsdevel+bounces-65728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C36C0F413
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8DA46798F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ED73101DA;
	Mon, 27 Oct 2025 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fz3XFv1x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C48433B3;
	Mon, 27 Oct 2025 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581428; cv=none; b=Z91hUnT0kZAYvv7UD2KaLJ0NgaoN91XhKXoIzU2p9wUDJwGqRhkDWxRztXeTz5qkRT/oUO5U2nqxT5EWG/24RCNc0qXxxmpxCs1HtQ+Fn+iQa/qAuDoaE+8HP7ZsBfv7jWg+37A/FblZl3/ImR7kPatx5QIxY0TIMg0SLrKzh6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581428; c=relaxed/simple;
	bh=KWyZcSM7YJrEzRFYOxV0414nu6sPOX/btOQt6jFmdC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ab79jgiVUD2L7ngWiVqv/5Xb8Wkj/vrfqS+9ulTtogIy9nOeJ2VQLwY6fP1KIsfTiN/H9My2WQO0gZyjZ7DveZwfoWAoNCifH7m7bVwlrCI3l4KIjeATxO3cVzIldvEJ+wiRoXBK5JHkgqXTdG8mBHwOhN/tEJHRv5ClBoK8KKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fz3XFv1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384E3C4CEF1;
	Mon, 27 Oct 2025 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761581428;
	bh=KWyZcSM7YJrEzRFYOxV0414nu6sPOX/btOQt6jFmdC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fz3XFv1xeLDxN9Z+GUBiYC6REQ1R+bLRG+rOBXhw8W1swbwxIVQYDx5re/OjljcA4
	 AAqu1vGKF5S5d+vmHa3A+aS0vjvmgrBa5leLvp9YNtXsKDpt0sCtONm79hogyse/FQ
	 tVSHO3Lu0wmtWVAxRIoVa0A/NqvVaFTHBp5aerwrtWiKCfnlFWeTrO0kGNlQJ5Rwq/
	 ZjfVRJgYKG7xZADPntuLvQlAJVMulAw+3VCnkb+lYmjRE1txzYIjCQZrrWyiAeF1XH
	 nRc61CS28D7FCAwkk1e+obVchEUmzQXRShWtfIJhZ0qgRc4mrrbtvdvKadskLcczSi
	 XICgRlx5JEoOw==
Date: Mon, 27 Oct 2025 09:10:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/4] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
Message-ID: <20251027161027.GS3356773@frogsfrogsfrogs>
References: <20251023135559.124072-1-hch@lst.de>
 <20251023135559.124072-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023135559.124072-2-hch@lst.de>

On Thu, Oct 23, 2025 at 03:55:42PM +0200, Christoph Hellwig wrote:
> From: Qu Wenruo <wqu@suse.com>
> 
> Btrfs requires all of its bios to be fs block aligned, normally it's
> totally fine but with the incoming block size larger than page size
> (bs > ps) support, the requirement is no longer met for direct IOs.
> 
> Because iomap_dio_bio_iter() calls bio_iov_iter_get_pages(), only
> requiring alignment to be bdev_logical_block_size().
> 
> In the real world that value is either 512 or 4K, on 4K page sized
> systems it means bio_iov_iter_get_pages() can break the bio at any page
> boundary, breaking btrfs' requirement for bs > ps cases.
> 
> To address this problem, introduce a new public iomap dio flag,
> IOMAP_DIO_FSBLOCK_ALIGNED.
> 
> When calling __iomap_dio_rw() with that new flag, iomap_dio::flags will
> inherit that new flag, and iomap_dio_bio_iter() will take fs block size
> into the calculation of the alignment, and pass the alignment to
> bio_iov_iter_get_pages(), respecting the fs block size requirement.
> 
> The initial user of this flag will be btrfs, which needs to calculate the
> checksum for direct read and thus requires the biovec to be fs block
> aligned for the incoming bs > ps support.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/direct-io.c  | 13 ++++++++++++-
>  include/linux/iomap.h |  8 ++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 5d5d63efbd57..ce9cbd2bace0 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -336,10 +336,18 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	int nr_pages, ret = 0;
>  	u64 copied = 0;
>  	size_t orig_count;
> +	unsigned int alignment = bdev_logical_block_size(iomap->bdev);
>  
>  	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
>  		return -EINVAL;
>  
> +	/*
> +	 * Align to the larger one of bdev and fs block size, to meet the
> +	 * alignment requirement of both layers.
> +	 */
> +	if (dio->flags & IOMAP_DIO_FSBLOCK_ALIGNED)
> +		alignment = max(alignment, fs_block_size);
> +
>  	if (dio->flags & IOMAP_DIO_WRITE) {
>  		bio_opf |= REQ_OP_WRITE;
>  
> @@ -434,7 +442,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  		bio->bi_end_io = iomap_dio_bio_end_io;
>  
>  		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
> -				bdev_logical_block_size(iomap->bdev) - 1);
> +					     alignment - 1);
>  		if (unlikely(ret)) {
>  			/*
>  			 * We have to stop part way through an IO. We must fall
> @@ -639,6 +647,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iomi.flags |= IOMAP_NOWAIT;
>  
> +	if (dio_flags & IOMAP_DIO_FSBLOCK_ALIGNED)
> +		dio->flags |= IOMAP_DIO_FSBLOCK_ALIGNED;
> +
>  	if (iov_iter_rw(iter) == READ) {
>  		/* reads can always complete inline */
>  		dio->flags |= IOMAP_DIO_INLINE_COMP;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 73dceabc21c8..4da13fe24ce8 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -518,6 +518,14 @@ struct iomap_dio_ops {
>   */
>  #define IOMAP_DIO_PARTIAL		(1 << 2)
>  
> +/*
> + * Ensure each bio is aligned to fs block size.
> + *
> + * For filesystems which need to calculate/verify the checksum of each fs
> + * block. Otherwise they may not be able to handle unaligned bios.
> + */
> +#define IOMAP_DIO_FSBLOCK_ALIGNED	(1 << 3)

A new flag requires an update to IOMAP_F_FLAGS_STRINGS in trace.h for
tracepoint decoding.

The rest of the changes look ok to me, modulo hch's subsequent fixups.

--D

>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>  		unsigned int dio_flags, void *private, size_t done_before);
> -- 
> 2.47.3
> 
> 

