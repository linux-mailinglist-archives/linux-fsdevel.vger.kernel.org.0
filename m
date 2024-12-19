Return-Path: <linux-fsdevel+bounces-37869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 023239F8311
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 19:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845CF166578
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AF719F43B;
	Thu, 19 Dec 2024 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5XfggqA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2560C19AD5C;
	Thu, 19 Dec 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632246; cv=none; b=Omr3gH9Kr0rFy7sUWn4IaG1O57FbaxIuVo9ZB+iCbSQpP4Xm2/UFxAOXCpfWK7cmWHfLxl2h6W5s915CjP5DSLGVhRf9jjnEkKX97bKoDDT0MVCbD4349bmjFJIhpLztx2MXP9MUMu2nNO6QNNSBHY/088npSjLWsR0y0PLtglU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632246; c=relaxed/simple;
	bh=RSqro+ivZYy4XpddWdfxlePwg8vb5IJUxMyIHpxBwNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nALZokcN8lK32hL5Q2mHMutAf+oxp143zMiFK7JdZKhKEPLKd5F/O5pDhKT6mWtGp3ZDXdV9z87y1XLWIx1Z/h8ElDk9SPWBrA8O6pBJWBhEqAmCc1H/9DXVZ1qZKUPbbjhD47MhvDsbs/3aruavikfjDtVeoZUrlkOvim6ES/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5XfggqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE79C4CECE;
	Thu, 19 Dec 2024 18:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734632245;
	bh=RSqro+ivZYy4XpddWdfxlePwg8vb5IJUxMyIHpxBwNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5XfggqAMet/N56kdffmXIVtIEt09b8aZBhHjuctzEGjSa5L8VTx13hQBiwpnYrvj
	 vQ+aPsAy2OdjDyAWm/PDy7s8i4svd+Zzj1nYHOxjbEYVBK89leKqKdbBxi3ch+kBQc
	 pfAZTm5L+3d9A/RfuAf8SNl9XLDcOqKy/widvQzlbq7q3T/BmTK6rQ/g9tUt/DakmS
	 lSFpicBzZXVZxfwqMs8Zhm0skn+j4W9L7+HbQfk1LjLvdVcXQXkTvzD9cxM1SxSSfE
	 S1K4sr9JhsbQmrT1PMnT1o1SitJ3JOAROSv2FI9AttKU4lZ2CR3tmCrhFu5qxUfuOf
	 Nn4z7cHeS73jQ==
Date: Thu, 19 Dec 2024 10:17:25 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/10] iomap: split bios to zone append limits in the
 submission handlers
Message-ID: <20241219181725.GD6156@frogsfrogsfrogs>
References: <20241219173954.22546-1-hch@lst.de>
 <20241219173954.22546-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219173954.22546-5-hch@lst.de>

On Thu, Dec 19, 2024 at 05:39:09PM +0000, Christoph Hellwig wrote:
> Provide helpers for file systems to split bios in the direct I/O and
> writeback I/O submission handlers.
> 
> This Follows btrfs' lead and don't try to build bios to hardware limits
> for zone append commands, but instead build them as normal unconstrained
> bios and split them to the hardware limits in the I/O submission handler.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I wonder what iomap_split_ioend callsites look like now that the
alloc_len outparam from the previous version is gone, but I guess I'll
have to wait to see that.

> ---
>  fs/iomap/Makefile      |  1 +
>  fs/iomap/buffered-io.c | 49 ++++++++++++++----------
>  fs/iomap/ioend.c       | 86 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iomap.h  |  9 +++++
>  4 files changed, 125 insertions(+), 20 deletions(-)
>  create mode 100644 fs/iomap/ioend.c
> 
> diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
> index 381d76c5c232..69e8ebb41302 100644
> --- a/fs/iomap/Makefile
> +++ b/fs/iomap/Makefile
> @@ -12,6 +12,7 @@ iomap-y				+= trace.o \
>  				   iter.o
>  iomap-$(CONFIG_BLOCK)		+= buffered-io.o \
>  				   direct-io.o \
> +				   ioend.o \
>  				   fiemap.o \
>  				   seek.o
>  iomap-$(CONFIG_SWAP)		+= swapfile.o
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8c18fb2a82e0..0b68c9584a7f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -40,7 +40,8 @@ struct iomap_folio_state {
>  	unsigned long		state[];
>  };
>  
> -static struct bio_set iomap_ioend_bioset;
> +struct bio_set iomap_ioend_bioset;
> +EXPORT_SYMBOL_GPL(iomap_ioend_bioset);
>  
>  static inline bool ifs_is_fully_uptodate(struct folio *folio,
>  		struct iomap_folio_state *ifs)
> @@ -1539,15 +1540,15 @@ static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
>   * ioend after this.
>   */
>  static u32
> -iomap_finish_ioend(struct iomap_ioend *ioend, int error)
> +iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
>  {
>  	struct inode *inode = ioend->io_inode;
>  	struct bio *bio = &ioend->io_bio;
>  	struct folio_iter fi;
>  	u32 folio_count = 0;
>  
> -	if (error) {
> -		mapping_set_error(inode->i_mapping, error);
> +	if (ioend->io_error) {
> +		mapping_set_error(inode->i_mapping, ioend->io_error);
>  		if (!bio_flagged(bio, BIO_QUIET)) {
>  			pr_err_ratelimited(
>  "%s: writeback error on inode %lu, offset %lld, sector %llu",
> @@ -1566,6 +1567,24 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  	return folio_count;
>  }
>  
> +static u32
> +iomap_finish_ioend(struct iomap_ioend *ioend, int error)
> +{
> +	if (ioend->io_parent) {
> +		struct bio *bio = &ioend->io_bio;
> +
> +		ioend = ioend->io_parent;
> +		bio_put(bio);
> +	}
> +
> +	if (error)
> +		cmpxchg(&ioend->io_error, 0, error);
> +
> +	if (!atomic_dec_and_test(&ioend->io_remaining))
> +		return 0;
> +	return iomap_finish_ioend_buffered(ioend);
> +}
> +
>  /*
>   * Ioend completion routine for merged bios. This can only be called from task
>   * contexts as merged ioends can be of unbound length. Hence we have to break up
> @@ -1667,8 +1686,10 @@ EXPORT_SYMBOL_GPL(iomap_sort_ioends);
>  
>  static void iomap_writepage_end_bio(struct bio *bio)
>  {
> -	iomap_finish_ioend(iomap_ioend_from_bio(bio),
> -			blk_status_to_errno(bio->bi_status));
> +	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
> +
> +	ioend->io_error = blk_status_to_errno(bio->bi_status);
> +	iomap_finish_ioend_buffered(ioend);

Hmm.  This wasn't in the previous version of the patch.  But my guess is
that anyone using the io_parent chaining has its own ->submit_ioend
function and therefore set its own bi_end_io function?  IOWs, letting
iomap submit the bio itself is not compatible with io_parent != NULL.

If so, then you might want to note that in the declaration of io_parent
in iomap.h; and with that,

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  }
>  
>  /*
> @@ -1713,7 +1734,6 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct inode *inode, loff_t pos,
>  		u16 ioend_flags)
>  {
> -	struct iomap_ioend *ioend;
>  	struct bio *bio;
>  
>  	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
> @@ -1721,21 +1741,10 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
>  			       GFP_NOFS, &iomap_ioend_bioset);
>  	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
>  	bio->bi_end_io = iomap_writepage_end_bio;
> -	wbc_init_bio(wbc, bio);
>  	bio->bi_write_hint = inode->i_write_hint;
> -
> -	ioend = iomap_ioend_from_bio(bio);
> -	INIT_LIST_HEAD(&ioend->io_list);
> -	ioend->io_flags = ioend_flags;
> -	if (pos > wpc->iomap.offset)
> -		wpc->iomap.flags &= ~IOMAP_F_BOUNDARY;
> -	ioend->io_inode = inode;
> -	ioend->io_size = 0;
> -	ioend->io_offset = pos;
> -	ioend->io_sector = bio->bi_iter.bi_sector;
> -
> +	wbc_init_bio(wbc, bio);
>  	wpc->nr_folios = 0;
> -	return ioend;
> +	return iomap_init_ioend(inode, bio, pos, ioend_flags);
>  }
>  
>  static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> new file mode 100644
> index 000000000000..1b032323ee4e
> --- /dev/null
> +++ b/fs/iomap/ioend.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Christoph Hellwig.
> + */
> +#include <linux/iomap.h>
> +
> +struct iomap_ioend *iomap_init_ioend(struct inode *inode,
> +		struct bio *bio, loff_t file_offset, u16 ioend_flags)
> +{
> +	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
> +
> +	atomic_set(&ioend->io_remaining, 1);
> +	ioend->io_error = 0;
> +	ioend->io_parent = NULL;
> +	INIT_LIST_HEAD(&ioend->io_list);
> +	ioend->io_flags = ioend_flags;
> +	ioend->io_inode = inode;
> +	ioend->io_offset = file_offset;
> +	ioend->io_size = bio->bi_iter.bi_size;
> +	ioend->io_sector = bio->bi_iter.bi_sector;
> +	return ioend;
> +}
> +EXPORT_SYMBOL_GPL(iomap_init_ioend);
> +
> +/*
> + * Split up to the first @max_len bytes from @ioend if the ioend covers more
> + * than @max_len bytes.
> + *
> + * If @is_append is set, the split will be based on the hardware limits for
> + * REQ_OP_ZONE_APPEND commands and can be less than @max_len if the hardware
> + * limits don't allow the entire @max_len length.
> + *
> + * The bio embedded into @ioend must be a REQ_OP_WRITE because the block layer
> + * does not allow splitting REQ_OP_ZONE_APPEND bios.  The file systems has to
> + * switch the operation after this call, but before submitting the bio.
> + */
> +struct iomap_ioend *iomap_split_ioend(struct iomap_ioend *ioend,
> +		unsigned int max_len, bool is_append)
> +{
> +	struct bio *bio = &ioend->io_bio;
> +	struct iomap_ioend *split_ioend;
> +	unsigned int nr_segs;
> +	int sector_offset;
> +	struct bio *split;
> +
> +	if (is_append) {
> +		struct queue_limits *lim = bdev_limits(bio->bi_bdev);
> +
> +		max_len = min(max_len,
> +			      lim->max_zone_append_sectors << SECTOR_SHIFT);
> +
> +		sector_offset = bio_split_rw_at(bio, lim, &nr_segs, max_len);
> +		if (unlikely(sector_offset < 0))
> +			return ERR_PTR(sector_offset);
> +		if (!sector_offset)
> +			return NULL;
> +	} else {
> +		if (bio->bi_iter.bi_size <= max_len)
> +			return NULL;
> +		sector_offset = max_len >> SECTOR_SHIFT;
> +	}
> +
> +	/* ensure the split ioend is still block size aligned */
> +	sector_offset = ALIGN_DOWN(sector_offset << SECTOR_SHIFT,
> +			i_blocksize(ioend->io_inode)) >> SECTOR_SHIFT;
> +
> +	split = bio_split(bio, sector_offset, GFP_NOFS, &iomap_ioend_bioset);
> +	if (IS_ERR_OR_NULL(split))
> +		return ERR_CAST(split);
> +	split->bi_private = bio->bi_private;
> +	split->bi_end_io = bio->bi_end_io;
> +
> +	split_ioend = iomap_init_ioend(ioend->io_inode, split, ioend->io_offset,
> +			ioend->io_flags);
> +	split_ioend->io_parent = ioend;
> +
> +	atomic_inc(&ioend->io_remaining);
> +	ioend->io_offset += split_ioend->io_size;
> +	ioend->io_size -= split_ioend->io_size;
> +
> +	split_ioend->io_sector = ioend->io_sector;
> +	if (!is_append)
> +		ioend->io_sector += (split_ioend->io_size >> SECTOR_SHIFT);
> +	return split_ioend;
> +}
> +EXPORT_SYMBOL_GPL(iomap_split_ioend);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 36a7298b6cea..0d221fbe0eb3 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -358,6 +358,9 @@ struct iomap_ioend {
>  	struct list_head	io_list;	/* next ioend in chain */
>  	u16			io_flags;	/* IOMAP_IOEND_* */
>  	struct inode		*io_inode;	/* file being written to */
> +	atomic_t		io_remaining;	/* completetion defer count */
> +	int			io_error;	/* stashed away status */
> +	struct iomap_ioend	*io_parent;	/* parent for completions */
>  	size_t			io_size;	/* size of the extent */
>  	loff_t			io_offset;	/* offset in the file */
>  	sector_t		io_sector;	/* start sector of ioend */
> @@ -408,6 +411,10 @@ struct iomap_writepage_ctx {
>  	u32			nr_folios;	/* folios added to the ioend */
>  };
>  
> +struct iomap_ioend *iomap_init_ioend(struct inode *inode, struct bio *bio,
> +		loff_t file_offset, u16 ioend_flags);
> +struct iomap_ioend *iomap_split_ioend(struct iomap_ioend *ioend,
> +		unsigned int max_len, bool is_append);
>  void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
>  void iomap_ioend_try_merge(struct iomap_ioend *ioend,
>  		struct list_head *more_ioends);
> @@ -479,4 +486,6 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
>  # define iomap_swapfile_activate(sis, swapfile, pagespan, ops)	(-EIO)
>  #endif /* CONFIG_SWAP */
>  
> +extern struct bio_set iomap_ioend_bioset;
> +
>  #endif /* LINUX_IOMAP_H */
> -- 
> 2.45.2
> 
> 

