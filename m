Return-Path: <linux-fsdevel+bounces-53684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A66AF6039
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 19:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782DA3B203B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 17:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17040303DE6;
	Wed,  2 Jul 2025 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJejDLyx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FDF303DC3;
	Wed,  2 Jul 2025 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478020; cv=none; b=fZWdtTSOITvtNqg5R62XL8xWUoYO9fNVLG+UIg3EAsiDia6nM5C7xsFJJHVAKa4C6Knsl5bl+v6S3m/NetfW7za/anVzSls9AGDzL+5dWmdJWAxvXESfRldL4KYHpUSTeJNgqnJkhFgggHdb6f6b4PHZO7WI/WhK+DKUr+2VUVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478020; c=relaxed/simple;
	bh=AsRi7Oo06o0A6LPJ2PqTZTk+ZiiXn1kgv7BNzl2XOaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLhcx+2BXmfGvZnEzCO8TdxAtVYrpl3NeUWfg9oFcyGNzoX6bBc/TQzGJ1k4Ueqc7FCdTX7uPe3e2eWouKIhBqQ2SdXeqcphciHpuNZS9B7TJUyXlt0eJd8cWIBLvG/SgTeLq5Mo+0nrwNfaowI93ZS0vL3h9Wn9FLMSLrK4Uh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJejDLyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29A0C4CEF1;
	Wed,  2 Jul 2025 17:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751478019;
	bh=AsRi7Oo06o0A6LPJ2PqTZTk+ZiiXn1kgv7BNzl2XOaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJejDLyxcGUUShyI0lDwzhjoe91BJ9BC1o9s0Y2z7zhGoQC1r6WFO9+FfliSjLpvZ
	 o3OfjvEOmc5uuZApJiFPeibRkyUtX+yHR6CBSMfICl05+1gAmEJQqD6Xa3ZVOPaM+L
	 LAKpbV6SxQ4EeJ+OdlUGBFXWvF6n30VKqVVoR4+yYgJj+Pl8AIpLFICRhWGRnFfDmF
	 zU6ujaTvsZi+XhjecMPtA7Rek2lCaI/pTYJRu1/WWxptPcs3W/eAkK22TJtHQlR8rV
	 mGE3kWjafby1Wf4BLajPh99yLIjBheAALbqiA6cZWgz5s8YMM+v+bR1b8DsAGXCk7J
	 7dHWKilRmuhEA==
Date: Wed, 2 Jul 2025 10:40:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 06/16] iomap: move all ioend handling to ioend.c
Message-ID: <20250702174019.GZ10009@frogsfrogsfrogs>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-7-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624022135.832899-7-joannelkoong@gmail.com>

On Mon, Jun 23, 2025 at 07:21:25PM -0700, Joanne Koong wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Now that the writeback code has the proper abstractions, all the ioend
> code can be self-contained in ioend.c.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 215 ----------------------------------------
>  fs/iomap/internal.h    |   1 -
>  fs/iomap/ioend.c       | 220 ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 219 insertions(+), 217 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index b4a8d2241d70..c262f883f9f9 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1559,221 +1559,6 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
>  }
>  EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
>  
> -/*
> - * We're now finished for good with this ioend structure.  Update the page
> - * state, release holds on bios, and finally free up memory.  Do not use the
> - * ioend after this.
> - */
> -u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
> -{
> -	struct inode *inode = ioend->io_inode;
> -	struct bio *bio = &ioend->io_bio;
> -	struct folio_iter fi;
> -	u32 folio_count = 0;
> -
> -	if (ioend->io_error) {
> -		mapping_set_error(inode->i_mapping, ioend->io_error);
> -		if (!bio_flagged(bio, BIO_QUIET)) {
> -			pr_err_ratelimited(
> -"%s: writeback error on inode %lu, offset %lld, sector %llu",
> -				inode->i_sb->s_id, inode->i_ino,
> -				ioend->io_offset, ioend->io_sector);
> -		}
> -	}
> -
> -	/* walk all folios in bio, ending page IO on them */
> -	bio_for_each_folio_all(fi, bio) {
> -		iomap_finish_folio_write(inode, fi.folio, fi.length);
> -		folio_count++;
> -	}
> -
> -	bio_put(bio);	/* frees the ioend */
> -	return folio_count;
> -}
> -
> -static void ioend_writeback_end_bio(struct bio *bio)
> -{
> -	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
> -
> -	ioend->io_error = blk_status_to_errno(bio->bi_status);
> -	iomap_finish_ioend_buffered(ioend);
> -}
> -
> -/*
> - * We cannot cancel the ioend directly in case of an error, so call the bio end
> - * I/O handler with the error status here to run the normal I/O completion
> - * handler.
> - */
> -int ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
> -{
> -	struct iomap_ioend *ioend = wpc->wb_ctx;
> -
> -	if (!ioend->io_bio.bi_end_io)
> -		ioend->io_bio.bi_end_io = ioend_writeback_end_bio;
> -
> -	if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
> -		error = -EIO;
> -
> -	if (error) {
> -		ioend->io_bio.bi_status = errno_to_blk_status(error);
> -		bio_endio(&ioend->io_bio);
> -		return error;
> -	}
> -
> -	submit_bio(&ioend->io_bio);
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(ioend_writeback_submit);
> -
> -static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
> -		loff_t pos, u16 ioend_flags)
> -{
> -	struct bio *bio;
> -
> -	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
> -			       REQ_OP_WRITE | wbc_to_write_flags(wpc->wbc),
> -			       GFP_NOFS, &iomap_ioend_bioset);
> -	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
> -	bio->bi_write_hint = wpc->inode->i_write_hint;
> -	wbc_init_bio(wpc->wbc, bio);
> -	wpc->nr_folios = 0;
> -	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
> -}
> -
> -static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
> -		u16 ioend_flags)
> -{
> -	struct iomap_ioend *ioend = wpc->wb_ctx;
> -
> -	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
> -		return false;
> -	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
> -	    (ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
> -		return false;
> -	if (pos != ioend->io_offset + ioend->io_size)
> -		return false;
> -	if (!(wpc->iomap.flags & IOMAP_F_ANON_WRITE) &&
> -	    iomap_sector(&wpc->iomap, pos) != bio_end_sector(&ioend->io_bio))
> -		return false;
> -	/*
> -	 * Limit ioend bio chain lengths to minimise IO completion latency. This
> -	 * also prevents long tight loops ending page writeback on all the
> -	 * folios in the ioend.
> -	 */
> -	if (wpc->nr_folios >= IOEND_BATCH_SIZE)
> -		return false;
> -	return true;
> -}
> -
> -/*
> - * Test to see if we have an existing ioend structure that we could append to
> - * first; otherwise finish off the current ioend and start another.
> - *
> - * If a new ioend is created and cached, the old ioend is submitted to the block
> - * layer instantly.  Batching optimisations are provided by higher level block
> - * plugging.
> - *
> - * At the end of a writeback pass, there will be a cached ioend remaining on the
> - * writepage context that the caller will need to submit.
> - */
> -ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
> -		loff_t pos, loff_t end_pos, unsigned int dirty_len)
> -{
> -	struct iomap_ioend *ioend = wpc->wb_ctx;
> -	size_t poff = offset_in_folio(folio, pos);
> -	unsigned int ioend_flags = 0;
> -	unsigned int map_len = min_t(u64, dirty_len,
> -		wpc->iomap.offset + wpc->iomap.length - pos);
> -	int error;
> -
> -	trace_iomap_add_to_ioend(wpc->inode, pos, dirty_len, &wpc->iomap);
> -
> -	WARN_ON_ONCE(!folio->private && map_len < dirty_len);
> -
> -	switch (wpc->iomap.type) {
> -	case IOMAP_INLINE:
> -		WARN_ON_ONCE(1);
> -		return -EIO;
> -	case IOMAP_HOLE:
> -		return map_len;
> -	default:
> -		break;
> -	}
> -
> -	if (wpc->iomap.type == IOMAP_UNWRITTEN)
> -		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
> -	if (wpc->iomap.flags & IOMAP_F_SHARED)
> -		ioend_flags |= IOMAP_IOEND_SHARED;
> -	if (folio_test_dropbehind(folio))
> -		ioend_flags |= IOMAP_IOEND_DONTCACHE;
> -	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
> -		ioend_flags |= IOMAP_IOEND_BOUNDARY;
> -
> -	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
> -new_ioend:
> -		if (ioend) {
> -			error = wpc->ops->writeback_submit(wpc, 0);
> -			if (error)
> -				return error;
> -		}
> -		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
> -	}
> -
> -	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
> -		goto new_ioend;
> -
> -	iomap_start_folio_write(wpc->inode, folio, map_len);
> -
> -	/*
> -	 * Clamp io_offset and io_size to the incore EOF so that ondisk
> -	 * file size updates in the ioend completion are byte-accurate.
> -	 * This avoids recovering files with zeroed tail regions when
> -	 * writeback races with appending writes:
> -	 *
> -	 *    Thread 1:                  Thread 2:
> -	 *    ------------               -----------
> -	 *    write [A, A+B]
> -	 *    update inode size to A+B
> -	 *    submit I/O [A, A+BS]
> -	 *                               write [A+B, A+B+C]
> -	 *                               update inode size to A+B+C
> -	 *    <I/O completes, updates disk size to min(A+B+C, A+BS)>
> -	 *    <power failure>
> -	 *
> -	 *  After reboot:
> -	 *    1) with A+B+C < A+BS, the file has zero padding in range
> -	 *       [A+B, A+B+C]
> -	 *
> -	 *    |<     Block Size (BS)   >|
> -	 *    |DDDDDDDDDDDD0000000000000|
> -	 *    ^           ^        ^
> -	 *    A          A+B     A+B+C
> -	 *                       (EOF)
> -	 *
> -	 *    2) with A+B+C > A+BS, the file has zero padding in range
> -	 *       [A+B, A+BS]
> -	 *
> -	 *    |<     Block Size (BS)   >|<     Block Size (BS)    >|
> -	 *    |DDDDDDDDDDDD0000000000000|00000000000000000000000000|
> -	 *    ^           ^             ^           ^
> -	 *    A          A+B           A+BS       A+B+C
> -	 *                             (EOF)
> -	 *
> -	 *    D = Valid Data
> -	 *    0 = Zero Padding
> -	 *
> -	 * Note that this defeats the ability to chain the ioends of
> -	 * appending writes.
> -	 */
> -	ioend->io_size += map_len;
> -	if (ioend->io_offset + ioend->io_size > end_pos)
> -		ioend->io_size = end_pos - ioend->io_offset;
> -
> -	wbc_account_cgroup_owner(wpc->wbc, folio, map_len);
> -	return map_len;
> -}
> -EXPORT_SYMBOL_GPL(iomap_add_to_ioend);
> -
>  static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
>  		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
>  		bool *wb_pending)
> diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
> index f6992a3bf66a..d05cb3aed96e 100644
> --- a/fs/iomap/internal.h
> +++ b/fs/iomap/internal.h
> @@ -4,7 +4,6 @@
>  
>  #define IOEND_BATCH_SIZE	4096
>  
> -u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
>  u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
>  
>  #endif /* _IOMAP_INTERNAL_H */
> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> index 18894ebba6db..81f4bac5a3a9 100644
> --- a/fs/iomap/ioend.c
> +++ b/fs/iomap/ioend.c
> @@ -1,10 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (c) 2024-2025 Christoph Hellwig.
> + * Copyright (c) 2016-2025 Christoph Hellwig.
>   */
>  #include <linux/iomap.h>
>  #include <linux/list_sort.h>
> +#include <linux/pagemap.h>
> +#include <linux/writeback.h>
>  #include "internal.h"
> +#include "trace.h"
>  
>  struct bio_set iomap_ioend_bioset;
>  EXPORT_SYMBOL_GPL(iomap_ioend_bioset);
> @@ -28,6 +31,221 @@ struct iomap_ioend *iomap_init_ioend(struct inode *inode,
>  }
>  EXPORT_SYMBOL_GPL(iomap_init_ioend);
>  
> +/*
> + * We're now finished for good with this ioend structure.  Update the folio
> + * state, release holds on bios, and finally free up memory.  Do not use the
> + * ioend after this.
> + */
> +static u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
> +{
> +	struct inode *inode = ioend->io_inode;
> +	struct bio *bio = &ioend->io_bio;
> +	struct folio_iter fi;
> +	u32 folio_count = 0;
> +
> +	if (ioend->io_error) {
> +		mapping_set_error(inode->i_mapping, ioend->io_error);
> +		if (!bio_flagged(bio, BIO_QUIET)) {
> +			pr_err_ratelimited(
> +"%s: writeback error on inode %lu, offset %lld, sector %llu",
> +				inode->i_sb->s_id, inode->i_ino,
> +				ioend->io_offset, ioend->io_sector);
> +		}
> +	}
> +
> +	/* walk all folios in bio, ending page IO on them */
> +	bio_for_each_folio_all(fi, bio) {
> +		iomap_finish_folio_write(inode, fi.folio, fi.length);
> +		folio_count++;
> +	}
> +
> +	bio_put(bio);	/* frees the ioend */
> +	return folio_count;
> +}
> +
> +static void ioend_writeback_end_bio(struct bio *bio)
> +{
> +	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
> +
> +	ioend->io_error = blk_status_to_errno(bio->bi_status);
> +	iomap_finish_ioend_buffered(ioend);
> +}
> +
> +/*
> + * We cannot cancel the ioend directly in case of an error, so call the bio end
> + * I/O handler with the error status here to run the normal I/O completion
> + * handler.
> + */
> +int ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
> +{
> +	struct iomap_ioend *ioend = wpc->wb_ctx;
> +
> +	if (!ioend->io_bio.bi_end_io)
> +		ioend->io_bio.bi_end_io = ioend_writeback_end_bio;
> +
> +	if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
> +		error = -EIO;
> +
> +	if (error) {
> +		ioend->io_bio.bi_status = errno_to_blk_status(error);
> +		bio_endio(&ioend->io_bio);
> +		return error;
> +	}
> +
> +	submit_bio(&ioend->io_bio);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ioend_writeback_submit);
> +
> +static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
> +		loff_t pos, u16 ioend_flags)
> +{
> +	struct bio *bio;
> +
> +	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
> +			       REQ_OP_WRITE | wbc_to_write_flags(wpc->wbc),
> +			       GFP_NOFS, &iomap_ioend_bioset);
> +	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
> +	bio->bi_write_hint = wpc->inode->i_write_hint;
> +	wbc_init_bio(wpc->wbc, bio);
> +	wpc->nr_folios = 0;
> +	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
> +}
> +
> +static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
> +		u16 ioend_flags)
> +{
> +	struct iomap_ioend *ioend = wpc->wb_ctx;
> +
> +	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
> +		return false;
> +	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
> +	    (ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
> +		return false;
> +	if (pos != ioend->io_offset + ioend->io_size)
> +		return false;
> +	if (!(wpc->iomap.flags & IOMAP_F_ANON_WRITE) &&
> +	    iomap_sector(&wpc->iomap, pos) != bio_end_sector(&ioend->io_bio))
> +		return false;
> +	/*
> +	 * Limit ioend bio chain lengths to minimise IO completion latency. This
> +	 * also prevents long tight loops ending page writeback on all the
> +	 * folios in the ioend.
> +	 */
> +	if (wpc->nr_folios >= IOEND_BATCH_SIZE)
> +		return false;
> +	return true;
> +}
> +
> +/*
> + * Test to see if we have an existing ioend structure that we could append to
> + * first; otherwise finish off the current ioend and start another.
> + *
> + * If a new ioend is created and cached, the old ioend is submitted to the block
> + * layer instantly.  Batching optimisations are provided by higher level block
> + * plugging.
> + *
> + * At the end of a writeback pass, there will be a cached ioend remaining on the
> + * writepage context that the caller will need to submit.
> + */
> +ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
> +		loff_t pos, loff_t end_pos, unsigned int dirty_len)
> +{
> +	struct iomap_ioend *ioend = wpc->wb_ctx;
> +	size_t poff = offset_in_folio(folio, pos);
> +	unsigned int ioend_flags = 0;
> +	unsigned int map_len = min_t(u64, dirty_len,
> +		wpc->iomap.offset + wpc->iomap.length - pos);
> +	int error;
> +
> +	trace_iomap_add_to_ioend(wpc->inode, pos, dirty_len, &wpc->iomap);
> +
> +	WARN_ON_ONCE(!folio->private && map_len < dirty_len);
> +
> +	switch (wpc->iomap.type) {
> +	case IOMAP_INLINE:
> +		WARN_ON_ONCE(1);
> +		return -EIO;
> +	case IOMAP_HOLE:
> +		return map_len;
> +	default:
> +		break;
> +	}
> +
> +	if (wpc->iomap.type == IOMAP_UNWRITTEN)
> +		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
> +	if (wpc->iomap.flags & IOMAP_F_SHARED)
> +		ioend_flags |= IOMAP_IOEND_SHARED;
> +	if (folio_test_dropbehind(folio))
> +		ioend_flags |= IOMAP_IOEND_DONTCACHE;
> +	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
> +		ioend_flags |= IOMAP_IOEND_BOUNDARY;
> +
> +	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
> +new_ioend:
> +		if (ioend) {
> +			error = wpc->ops->writeback_submit(wpc, 0);
> +			if (error)
> +				return error;
> +		}
> +		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
> +	}
> +
> +	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
> +		goto new_ioend;
> +
> +	iomap_start_folio_write(wpc->inode, folio, map_len);
> +
> +	/*
> +	 * Clamp io_offset and io_size to the incore EOF so that ondisk
> +	 * file size updates in the ioend completion are byte-accurate.
> +	 * This avoids recovering files with zeroed tail regions when
> +	 * writeback races with appending writes:
> +	 *
> +	 *    Thread 1:                  Thread 2:
> +	 *    ------------               -----------
> +	 *    write [A, A+B]
> +	 *    update inode size to A+B
> +	 *    submit I/O [A, A+BS]
> +	 *                               write [A+B, A+B+C]
> +	 *                               update inode size to A+B+C
> +	 *    <I/O completes, updates disk size to min(A+B+C, A+BS)>
> +	 *    <power failure>
> +	 *
> +	 *  After reboot:
> +	 *    1) with A+B+C < A+BS, the file has zero padding in range
> +	 *       [A+B, A+B+C]
> +	 *
> +	 *    |<     Block Size (BS)   >|
> +	 *    |DDDDDDDDDDDD0000000000000|
> +	 *    ^           ^        ^
> +	 *    A          A+B     A+B+C
> +	 *                       (EOF)
> +	 *
> +	 *    2) with A+B+C > A+BS, the file has zero padding in range
> +	 *       [A+B, A+BS]
> +	 *
> +	 *    |<     Block Size (BS)   >|<     Block Size (BS)    >|
> +	 *    |DDDDDDDDDDDD0000000000000|00000000000000000000000000|
> +	 *    ^           ^             ^           ^
> +	 *    A          A+B           A+BS       A+B+C
> +	 *                             (EOF)
> +	 *
> +	 *    D = Valid Data
> +	 *    0 = Zero Padding
> +	 *
> +	 * Note that this defeats the ability to chain the ioends of
> +	 * appending writes.
> +	 */
> +	ioend->io_size += map_len;
> +	if (ioend->io_offset + ioend->io_size > end_pos)
> +		ioend->io_size = end_pos - ioend->io_offset;
> +
> +	wbc_account_cgroup_owner(wpc->wbc, folio, map_len);
> +	return map_len;
> +}
> +EXPORT_SYMBOL_GPL(iomap_add_to_ioend);
> +
>  static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  {
>  	if (ioend->io_parent) {
> -- 
> 2.47.1
> 
> 

