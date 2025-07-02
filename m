Return-Path: <linux-fsdevel+bounces-53682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1656EAF6024
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 19:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A811C28324
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 17:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCC8303DCF;
	Wed,  2 Jul 2025 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUSbs6ed"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4624D21D3EC;
	Wed,  2 Jul 2025 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477900; cv=none; b=gJ9fGfL4q1B+sPTx5kk5MBpmVwKu+oLvBIkObEWi/8uqrx13JBrHjLC6wWrabjhBsljOKcPIufCWo7pLx3wxVH1IwbR4QqrBB0h+gimtZo2vCPOk0zGcf+8sj9572dn4pJvzM4M6t5kmWfzzDZF92NZr+OjPtfAmWGnwDblUFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477900; c=relaxed/simple;
	bh=577ssRPkl4WqMX6ufBnJxwpT5dLSE8Az5EeeApGMyfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcgiwIQhw74MeQBSoZmVHPLQYxDtL8ysSVyUncsHrXbOXWVdNEfJvdtL0AW3BgP178l4v/9PLgaAJx9VP5hd9xhhpFDSAsXZVeIoKHNzxORXXVVEgRiTN5ru3bckpgqbCXcuzOtTwfQXeD9UJT3OEcpYaURJdwTxAsTtPKl6N0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUSbs6ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C201BC4CEE7;
	Wed,  2 Jul 2025 17:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751477899;
	bh=577ssRPkl4WqMX6ufBnJxwpT5dLSE8Az5EeeApGMyfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OUSbs6ediu42sId1X6xpGQnT//V1DV8JwogyEPc1CCEdfMbEw9/H8R1m16Dgp4zYt
	 s+PfbHJUjGHmZun/40kOX0TiuMXHm1WyiwxioeJDf4R2pBM6kppNttrdjzvcytg1iZ
	 lKPd/klryeu1jQsg+lfGO+RnmayGZETLXPg81bSR+DiBNpaWI8xKr0YgPMRd2G0ZKt
	 faofdeWzMU3Sp2CPZZfktVlB2nUaYRLOKJi0w6nyKWfp4+StMJK7VItueTag97uZOB
	 Pjao/FZkDw6fHsfmqGWgKFtIIq3PFCVAJ16ln9mREAfQsGJk6OiKOL1UCemq20BEzW
	 k7r0MpcZntbOQ==
Date: Wed, 2 Jul 2025 10:38:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 04/16] iomap: hide ioends from the generic writeback
 code
Message-ID: <20250702173819.GX10009@frogsfrogsfrogs>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-5-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624022135.832899-5-joannelkoong@gmail.com>

On Mon, Jun 23, 2025 at 07:21:23PM -0700, Joanne Koong wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Replace the ioend pointer in iomap_writeback_ctx with a void *wb_ctx
> one to facilitate non-block, non-ioend writeback for use.  Rename
> the submit_ioend method to writeback_submit and make it mandatory so
> that the generic writeback code stops seeing ioends and bios.
> 
> Co-developed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  .../filesystems/iomap/operations.rst          | 16 +---
>  block/fops.c                                  |  1 +
>  fs/gfs2/bmap.c                                |  1 +
>  fs/iomap/buffered-io.c                        | 91 ++++++++++---------
>  fs/xfs/xfs_aops.c                             | 60 ++++++------
>  fs/zonefs/file.c                              |  1 +
>  include/linux/iomap.h                         | 19 ++--
>  7 files changed, 93 insertions(+), 96 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index b28f215db6e5..ead56b27ec3f 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -285,7 +285,7 @@ The ``ops`` structure must be specified and is as follows:
>   struct iomap_writeback_ops {
>      int (*writeback_range)(struct iomap_writepage_ctx *wpc,
>      		struct folio *folio, u64 pos, unsigned int len, u64 end_pos);
> -    int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
> +    int (*writeback_submit)(struct iomap_writepage_ctx *wpc, int error);
>   };
>  
>  The fields are as follows:
> @@ -307,13 +307,7 @@ The fields are as follows:
>      purpose.
>      This function must be supplied by the filesystem.
>  
> -  - ``submit_ioend``: Allows the file systems to hook into writeback bio
> -    submission.
> -    This might include pre-write space accounting updates, or installing
> -    a custom ``->bi_end_io`` function for internal purposes, such as
> -    deferring the ioend completion to a workqueue to run metadata update
> -    transactions from process context before submitting the bio.
> -    This function is optional.
> +  - ``writeback_submit``: Submit the previous built writeback context.
>  
>  Pagecache Writeback Completion
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -328,12 +322,6 @@ the address space.
>  This can happen in interrupt or process context, depending on the
>  storage device.
>  
> -Filesystems that need to update internal bookkeeping (e.g. unwritten
> -extent conversions) should provide a ``->submit_ioend`` function to
> -set ``struct iomap_end::bio::bi_end_io`` to its own function.
> -This function should call ``iomap_finish_ioends`` after finishing its
> -own work (e.g. unwritten extent conversion).
> -

I really wish you wouldn't delete the documentation that talks about
what sort of things you might do in a ->writeback_submit function.
That might be obvious to us who've been around for a long time, but I
don't think that's so obvious to the junior programmers.

>  Some filesystems may wish to `amortize the cost of running metadata
>  transactions
>  <https://lore.kernel.org/all/20220120034733.221737-1-david@fromorbit.com/>`_

<snip>

> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 80d8acfaa068..50cfddff1393 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1579,7 +1579,7 @@ u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
>  	return folio_count;
>  }
>  
> -static void iomap_writepage_end_bio(struct bio *bio)
> +static void ioend_writeback_end_bio(struct bio *bio)
>  {
>  	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
>  
> @@ -1588,42 +1588,30 @@ static void iomap_writepage_end_bio(struct bio *bio)
>  }
>  
>  /*
> - * Submit an ioend.

Please retain the summary.

> - *
> - * If @error is non-zero, it means that we have a situation where some part of
> - * the submission process has failed after we've marked pages for writeback.
> - * We cannot cancel ioend directly in that case, so call the bio end I/O handler
> - * with the error status here to run the normal I/O completion handler to clear
> - * the writeback bit and let the file system proess the errors.
> + * We cannot cancel the ioend directly in case of an error, so call the bio end
> + * I/O handler with the error status here to run the normal I/O completion
> + * handler.
>   */
> -static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
> +int ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
>  {
> -	if (!wpc->ioend)
> -		return error;
> +	struct iomap_ioend *ioend = wpc->wb_ctx;
>  
> -	/*
> -	 * Let the file systems prepare the I/O submission and hook in an I/O
> -	 * comletion handler.  This also needs to happen in case after a
> -	 * failure happened so that the file system end I/O handler gets called
> -	 * to clean up.
> -	 */
> -	if (wpc->ops->submit_ioend) {
> -		error = wpc->ops->submit_ioend(wpc, error);
> -	} else {
> -		if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
> -			error = -EIO;
> -		if (!error)
> -			submit_bio(&wpc->ioend->io_bio);
> -	}
> +	if (!ioend->io_bio.bi_end_io)
> +		ioend->io_bio.bi_end_io = ioend_writeback_end_bio;
> +
> +	if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
> +		error = -EIO;
>  
>  	if (error) {
> -		wpc->ioend->io_bio.bi_status = errno_to_blk_status(error);
> -		bio_endio(&wpc->ioend->io_bio);
> +		ioend->io_bio.bi_status = errno_to_blk_status(error);
> +		bio_endio(&ioend->io_bio);
> +		return error;
>  	}
>  
> -	wpc->ioend = NULL;
> -	return error;
> +	submit_bio(&ioend->io_bio);
> +	return 0;
>  }
> +EXPORT_SYMBOL_GPL(ioend_writeback_submit);
>  
>  static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
>  		loff_t pos, u16 ioend_flags)
> @@ -1634,7 +1622,6 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
>  			       REQ_OP_WRITE | wbc_to_write_flags(wpc->wbc),
>  			       GFP_NOFS, &iomap_ioend_bioset);
>  	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
> -	bio->bi_end_io = iomap_writepage_end_bio;
>  	bio->bi_write_hint = wpc->inode->i_write_hint;
>  	wbc_init_bio(wpc->wbc, bio);
>  	wpc->nr_folios = 0;
> @@ -1644,16 +1631,17 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
>  static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
>  		u16 ioend_flags)
>  {
> +	struct iomap_ioend *ioend = wpc->wb_ctx;
> +
>  	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
>  		return false;
>  	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
> -	    (wpc->ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
> +	    (ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
>  		return false;
> -	if (pos != wpc->ioend->io_offset + wpc->ioend->io_size)
> +	if (pos != ioend->io_offset + ioend->io_size)
>  		return false;
>  	if (!(wpc->iomap.flags & IOMAP_F_ANON_WRITE) &&
> -	    iomap_sector(&wpc->iomap, pos) !=
> -	    bio_end_sector(&wpc->ioend->io_bio))
> +	    iomap_sector(&wpc->iomap, pos) != bio_end_sector(&ioend->io_bio))
>  		return false;
>  	/*
>  	 * Limit ioend bio chain lengths to minimise IO completion latency. This
> @@ -1679,6 +1667,7 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
>  ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
>  		loff_t pos, loff_t end_pos, unsigned int dirty_len)
>  {
> +	struct iomap_ioend *ioend = wpc->wb_ctx;
>  	struct iomap_folio_state *ifs = folio->private;
>  	size_t poff = offset_in_folio(folio, pos);
>  	unsigned int ioend_flags = 0;
> @@ -1709,15 +1698,17 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
>  	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
>  		ioend_flags |= IOMAP_IOEND_BOUNDARY;
>  
> -	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
> +	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
>  new_ioend:
> -		error = iomap_submit_ioend(wpc, 0);
> -		if (error)
> -			return error;
> -		wpc->ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
> +		if (ioend) {
> +			error = wpc->ops->writeback_submit(wpc, 0);

Should we call ioend_writeback_submit directly if
!wpc->ops->writeback_submit, to avoid the indirect call hit for simpler
filesystems?

--D

