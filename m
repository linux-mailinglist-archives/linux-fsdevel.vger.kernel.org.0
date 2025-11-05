Return-Path: <linux-fsdevel+bounces-67055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B37C33A8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 02:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6ADB4E2D0D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 01:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAB7245022;
	Wed,  5 Nov 2025 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8t/bTbi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265B023D7D9
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306111; cv=none; b=lRMEaNiiqiVg6vANOtKT6KfKdnDwYTPioLKjy6l07PdjSLZr8wkDOkFerUW7Vimm/Zl4lZUvC7azaSSnq2+BTLEj8jTTRuXkvGiYDbRuH2Tc0PuCLXWr2exfBGuY0C7DvMfkT9G0i1lLA6G2bZ0a5w6NzQs1tbK0EjcrexV8Zsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306111; c=relaxed/simple;
	bh=JzRLFLT8FcAx03RhwvkAxNsUTu7xK70LPCEWRRs7h/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtrtREnNMOj+ABI7yF/4SfMgzy5hp8uvnZWVHd1ZbGuSlN9RMHtGXIdFZVQOLatAwUwxhozDGMSqAQpP5icbuBa9eFEOxzVLeZ9nAAmX2iEvhJovjE4kg4KNarTUE9CgEv+wdMzVRnRO25+o4a2dFQpYXnb8YWfXrIwwPU9ikUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8t/bTbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3288C116B1;
	Wed,  5 Nov 2025 01:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762306110;
	bh=JzRLFLT8FcAx03RhwvkAxNsUTu7xK70LPCEWRRs7h/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8t/bTbiRgzXqyLMTz+zwTJMcHy8YKofC4x5IU5vNh/Gbu7QUcxrVhFWeHvuhqz4X
	 yp8HGtphVUVrW7srNtO6SbFmq5Sz7KVx5VT3rHhyrQmlM94H6/dsteaIRZ7MFsfWY4
	 0AOg0q1KswbqtKtIBaOUvhkZGvc6EDC3nAUpizqbRANDn2TTFQa9mAyMzaekzygen5
	 7snJ/Lxxe4rsvrw++LL4NcE1QjIZbPc/GRCxvl8WRBC8ve9k0rAswkq4xLqRreFgiK
	 BtziXl6C7jrZVZBKPTlEwCUHVF4xesbpVV9qukOvog0JZDplkWJhlU1nfc7RRP829e
	 a4eqUDBIUIVmw==
Date: Tue, 4 Nov 2025 17:28:30 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 3/8] iomap: optimize pending async writeback accounting
Message-ID: <20251105012830.GE196362@frogsfrogsfrogs>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
 <20251104205119.1600045-4-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104205119.1600045-4-joannelkoong@gmail.com>

On Tue, Nov 04, 2025 at 12:51:14PM -0800, Joanne Koong wrote:
> Pending writebacks must be accounted for to determine when all requests
> have completed and writeback on the folio should be ended. Currently
> this is done by atomically incrementing ifs->write_bytes_pending for
> every range to be written back.
> 
> Instead, the number of atomic operations can be minimized by setting
> ifs->write_bytes_pending to the folio size, internally tracking how many
> bytes are written back asynchronously, and then after sending off all
> the requests, decrementing ifs->write_bytes_pending by the number of
> bytes not written back asynchronously. Now, for N ranges written back,
> only N + 2 atomic operations are required instead of 2N + 2.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Seems reasonable to bias write_bytes_pending upwards and then decrement
it as needed; and then you don't have problems with transient
write_bytes_pending==0.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/fuse/file.c         |  4 +--
>  fs/iomap/buffered-io.c | 58 +++++++++++++++++++++++++-----------------
>  fs/iomap/ioend.c       |  2 --
>  include/linux/iomap.h  |  2 --
>  4 files changed, 36 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 8275b6681b9b..b343a6f37563 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1885,7 +1885,8 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
>  		 * scope of the fi->lock alleviates xarray lock
>  		 * contention and noticeably improves performance.
>  		 */
> -		iomap_finish_folio_write(inode, ap->folios[i], 1);
> +		iomap_finish_folio_write(inode, ap->folios[i],
> +					 ap->descs[i].length);
>  
>  	wake_up(&fi->page_waitq);
>  }
> @@ -2221,7 +2222,6 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
>  		ap = &wpa->ia.ap;
>  	}
>  
> -	iomap_start_folio_write(inode, folio, 1);
>  	fuse_writepage_args_page_fill(wpa, folio, ap->num_folios,
>  				      offset, len);
>  	data->nr_bytes += len;
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index c79b59e52a49..e3171462ba08 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1641,16 +1641,25 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
>  }
>  EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
>  
> -void iomap_start_folio_write(struct inode *inode, struct folio *folio,
> -		size_t len)
> +static void iomap_writeback_init(struct inode *inode, struct folio *folio)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  
>  	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
> -	if (ifs)
> -		atomic_add(len, &ifs->write_bytes_pending);
> +	if (ifs) {
> +		WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending) != 0);
> +		/*
> +		 * Set this to the folio size. After processing the folio for
> +		 * writeback in iomap_writeback_folio(), we'll subtract any
> +		 * ranges not written back.
> +		 *
> +		 * We do this because otherwise, we would have to atomically
> +		 * increment ifs->write_bytes_pending every time a range in the
> +		 * folio needs to be written back.
> +		 */
> +		atomic_set(&ifs->write_bytes_pending, folio_size(folio));
> +	}
>  }
> -EXPORT_SYMBOL_GPL(iomap_start_folio_write);
>  
>  void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
>  		size_t len)
> @@ -1667,7 +1676,7 @@ EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
>  
>  static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
>  		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
> -		bool *wb_pending)
> +		size_t *bytes_submitted)
>  {
>  	do {
>  		ssize_t ret;
> @@ -1681,11 +1690,11 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
>  		pos += ret;
>  
>  		/*
> -		 * Holes are not be written back by ->writeback_range, so track
> +		 * Holes are not written back by ->writeback_range, so track
>  		 * if we did handle anything that is not a hole here.
>  		 */
>  		if (wpc->iomap.type != IOMAP_HOLE)
> -			*wb_pending = true;
> +			*bytes_submitted += ret;
>  	} while (rlen);
>  
>  	return 0;
> @@ -1756,7 +1765,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
>  	u64 pos = folio_pos(folio);
>  	u64 end_pos = pos + folio_size(folio);
>  	u64 end_aligned = 0;
> -	bool wb_pending = false;
> +	size_t bytes_submitted = 0;
>  	int error = 0;
>  	u32 rlen;
>  
> @@ -1776,14 +1785,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
>  			iomap_set_range_dirty(folio, 0, end_pos - pos);
>  		}
>  
> -		/*
> -		 * Keep the I/O completion handler from clearing the writeback
> -		 * bit until we have submitted all blocks by adding a bias to
> -		 * ifs->write_bytes_pending, which is dropped after submitting
> -		 * all blocks.
> -		 */
> -		WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending) != 0);
> -		iomap_start_folio_write(inode, folio, 1);
> +		iomap_writeback_init(inode, folio);
>  	}
>  
>  	/*
> @@ -1798,13 +1800,13 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
>  	end_aligned = round_up(end_pos, i_blocksize(inode));
>  	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
>  		error = iomap_writeback_range(wpc, folio, pos, rlen, end_pos,
> -				&wb_pending);
> +				&bytes_submitted);
>  		if (error)
>  			break;
>  		pos += rlen;
>  	}
>  
> -	if (wb_pending)
> +	if (bytes_submitted)
>  		wpc->nr_folios++;
>  
>  	/*
> @@ -1822,12 +1824,20 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
>  	 * bit ourselves right after unlocking the page.
>  	 */
>  	if (ifs) {
> -		if (atomic_dec_and_test(&ifs->write_bytes_pending))
> -			folio_end_writeback(folio);
> -	} else {
> -		if (!wb_pending)
> -			folio_end_writeback(folio);
> +		/*
> +		 * Subtract any bytes that were initially accounted to
> +		 * write_bytes_pending but skipped for writeback.
> +		 */
> +		size_t bytes_not_submitted = folio_size(folio) -
> +				bytes_submitted;
> +
> +		if (bytes_not_submitted)
> +			iomap_finish_folio_write(inode, folio,
> +					bytes_not_submitted);
> +	} else if (!bytes_submitted) {
> +		folio_end_writeback(folio);
>  	}
> +
>  	mapping_set_error(inode->i_mapping, error);
>  	return error;
>  }
> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> index b49fa75eab26..86f44922ed3b 100644
> --- a/fs/iomap/ioend.c
> +++ b/fs/iomap/ioend.c
> @@ -194,8 +194,6 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
>  	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
>  		goto new_ioend;
>  
> -	iomap_start_folio_write(wpc->inode, folio, map_len);
> -
>  	/*
>  	 * Clamp io_offset and io_size to the incore EOF so that ondisk
>  	 * file size updates in the ioend completion are byte-accurate.
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index a5032e456079..b49e47f069db 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -478,8 +478,6 @@ int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
>  
>  void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
>  		int error);
> -void iomap_start_folio_write(struct inode *inode, struct folio *folio,
> -		size_t len);
>  void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
>  		size_t len);
>  
> -- 
> 2.47.3
> 
> 

