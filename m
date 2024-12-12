Return-Path: <linux-fsdevel+bounces-37226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B959EFCC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 20:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7DB188277C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 19:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41C41A4F22;
	Thu, 12 Dec 2024 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+Zjmk66"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2877125948B;
	Thu, 12 Dec 2024 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033110; cv=none; b=WQKRuCYjTciXtyOzUSL6Fg7psXYEMlwcfKy45ZntsnnAjSyErNOmFmwXLXfb8hGq1I1ALeB6kgOT65RtpvBsW+PQ69XoFfUzi7+h4rhKoWOmx9azPN3s0DxqLnqk7NqOL4h21cnSlf1FHlsT8M6ozBcvbDkseCN5elPaWCqU36s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033110; c=relaxed/simple;
	bh=gsLCGFtWgIXUFQz1VGBwsNAGRHxfQL6jWLeT9DNmUqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uI3yPhbBJxA5HiCHD595FwoCfVYTqOgp3JamnohABj11kdLXmK9q2wjbfXP4xjRKXbbMUiVaXUcsPxH02da4oCmCD0X6pmbCDsqIRtGRZ2lJgmRh84MKNpnvrRUjLvhOwVWvD2zrGYDfKLCOVwkCQrnNbKy4UcwXkq7UfYJ1EDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+Zjmk66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B096DC4CECE;
	Thu, 12 Dec 2024 19:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734033109;
	bh=gsLCGFtWgIXUFQz1VGBwsNAGRHxfQL6jWLeT9DNmUqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+Zjmk66502NSkJ7jyzB40SrQUoMvUrcyUm7/r9OKYweJc/aSXW8B/mVsHhpYJPD1
	 YkLto214WNw15TEla55ZwmTkt7dS3bbcX5dLBc22SiAMAuzWrpy2F7NDUhljx+H7tY
	 ecr9z2lY/FHNH5+kLygE3tJNxnZo6dIHlIKZlfzHvKVCuKaGfGVwqLj7SgktbUjwPq
	 w/e9HMshDvNyveVmPwsDhBLs+Y77kxaA8ercVgGUGfFNcuC757/gZ8PUVQ1dCwA7zr
	 /pG/ardDn+h/N50p2OrcYzgbbR+CyrgWoOq41iF71zjsH+7vLblKfk66THIEFjbeJc
	 3nq2Ti0pvbXEw==
Date: Thu, 12 Dec 2024 11:51:49 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/8] iomap: split bios to zone append limits in the
 submission handlers
Message-ID: <20241212195149.GH6678@frogsfrogsfrogs>
References: <20241211085420.1380396-1-hch@lst.de>
 <20241211085420.1380396-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211085420.1380396-5-hch@lst.de>

On Wed, Dec 11, 2024 at 09:53:44AM +0100, Christoph Hellwig wrote:
> Provide helpers for file systems to split bios in the direct I/O and
> writeback I/O submission handlers.
> 
> This Follows btrfs' lead and don't try to build bios to hardware limits
> for zone append commands, but instead build them as normal unconstrained
> bios and split them to the hardware limits in the I/O submission handler.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/Makefile      |  1 +
>  fs/iomap/buffered-io.c | 43 ++++++++++++++-----------
>  fs/iomap/ioend.c       | 73 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iomap.h  |  9 ++++++
>  4 files changed, 108 insertions(+), 18 deletions(-)
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
> index 129cd96c6c96..8125f758a99d 100644
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
> @@ -1709,7 +1728,6 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct inode *inode, loff_t pos,
>  		u16 ioend_flags)
>  {
> -	struct iomap_ioend *ioend;
>  	struct bio *bio;
>  
>  	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
> @@ -1717,21 +1735,10 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
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
> index 000000000000..f3d98121c593
> --- /dev/null
> +++ b/fs/iomap/ioend.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Christoph Hellwig.
> + */
> +#include <linux/iomap.h>
> +
> +struct iomap_ioend *iomap_init_ioend(struct inode *inode,
> +		struct bio *bio, loff_t file_offset, u16 flags)
> +{

Nit: s/flags/ioend_flags/ to be consistent with the previous few
patches.

> +	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
> +
> +	atomic_set(&ioend->io_remaining, 1);
> +	ioend->io_error = 0;
> +	ioend->io_parent = NULL;
> +	INIT_LIST_HEAD(&ioend->io_list);
> +	ioend->io_flags = flags;
> +	ioend->io_inode = inode;
> +	ioend->io_offset = file_offset;
> +	ioend->io_size = bio->bi_iter.bi_size;
> +	ioend->io_sector = bio->bi_iter.bi_sector;
> +	return ioend;
> +}
> +EXPORT_SYMBOL_GPL(iomap_init_ioend);
> +
> +struct iomap_ioend *iomap_split_ioend(struct iomap_ioend *ioend, bool is_append,

Can you determine is_append from (ioend->io_flags & ZONE_APPEND)?

Also it's not clear to me what the initial and output state of
*alloc_len is supposed to be?  I guess you set it to the number of bytes
the @ioend covers?  And this function either returns NULL and alloc_len
untouched; or it returns a new ioend and the number of bytes remaining
in the passed-in ioend?

(or, as bfoster said, please improve the comments)

> +		unsigned int *alloc_len)
> +{
> +	struct bio *bio = &ioend->io_bio;
> +	struct iomap_ioend *split_ioend;
> +	struct bio *split;
> +	int sector_offset;
> +	unsigned int nr_segs;
> +
> +	if (is_append) {
> +		struct queue_limits *lim = bdev_limits(bio->bi_bdev);
> +
> +		sector_offset = bio_split_rw_at(bio, lim, &nr_segs,
> +			min(lim->max_zone_append_sectors << SECTOR_SHIFT,
> +			    *alloc_len));
> +		if (!sector_offset)
> +			return NULL;
> +	} else {
> +		if (bio->bi_iter.bi_size <= *alloc_len)
> +			return NULL;
> +		sector_offset = *alloc_len >> SECTOR_SHIFT;
> +	}
> +
> +	/* ensure the split ioend is still block size aligned */
> +	sector_offset = ALIGN_DOWN(sector_offset << SECTOR_SHIFT,
> +			i_blocksize(ioend->io_inode)) >> SECTOR_SHIFT;
> +
> +	split = bio_split(bio, sector_offset, GFP_NOFS, &iomap_ioend_bioset);
> +	if (!split)
> +		return NULL;
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
> +
> +	*alloc_len -= split->bi_iter.bi_size;
> +	return split_ioend;
> +}
> +EXPORT_SYMBOL_GPL(iomap_split_ioend);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 173d490c20ba..eaa8cb9083eb 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -354,6 +354,9 @@ struct iomap_ioend {
>  	struct list_head	io_list;	/* next ioend in chain */
>  	u16			io_flags;	/* IOMAP_IOEND_* */
>  	struct inode		*io_inode;	/* file being written to */
> +	atomic_t		io_remaining;	/* completetion defer count */
> +	int			io_error;	/* stashed away status */
> +	struct iomap_ioend	*io_parent;	/* parent for completions */

I guess this means ioends can chain together, sort of like how bios can
when you split them?

--D

>  	size_t			io_size;	/* size of the extent */
>  	loff_t			io_offset;	/* offset in the file */
>  	sector_t		io_sector;	/* start sector of ioend */
> @@ -404,6 +407,10 @@ struct iomap_writepage_ctx {
>  	u32			nr_folios;	/* folios added to the ioend */
>  };
>  
> +struct iomap_ioend *iomap_init_ioend(struct inode *inode, struct bio *bio,
> +		loff_t file_offset, u16 flags);
> +struct iomap_ioend *iomap_split_ioend(struct iomap_ioend *ioend, bool is_append,
> +		unsigned int *alloc_len);
>  void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
>  void iomap_ioend_try_merge(struct iomap_ioend *ioend,
>  		struct list_head *more_ioends);
> @@ -475,4 +482,6 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
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

