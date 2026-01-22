Return-Path: <linux-fsdevel+bounces-75133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAsbA3dlcmmrjwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:59:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F8F6BD6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 257DA3125AC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828A7353ED9;
	Thu, 22 Jan 2026 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXceOhlo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90A530F813;
	Thu, 22 Jan 2026 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104024; cv=none; b=ScWjnV3ZzpJktrfRDkhcKRj/xDTzoVy/LaWwjwD3iw5qANOCSBEx8msymhYFp/XooyPDy70huE1rgsDmXh2pZNG8NWPHkEPLsbcqUWTKdnJBHV7RTyNO3GpbuHLs+yLcP0y8KazAEhkjpaPbiTXLAKjDicJu07FmxuGMw5s/Jac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104024; c=relaxed/simple;
	bh=mS/5Ycxc0SnLx+RNnLBvX8HjFw5Dh2HlehS96tIPSWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l57Lmb6EeSfDW+DRXkrBUqVDO1BolZ2rksHFI2sH+L1kUUk00MvrggC17mkPzdeglZ72JJBe1dIpM9bI/6tRhL/41t/hG23G5eO/RpjhOTPMvljZXZUWWc+2702C2as2vsYa1T+YpSjgHuRTyQAAs89jgrh3mCTHsPXZ36bnIBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXceOhlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F4EC116C6;
	Thu, 22 Jan 2026 17:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769104023;
	bh=mS/5Ycxc0SnLx+RNnLBvX8HjFw5Dh2HlehS96tIPSWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NXceOhloJYeQtxGRID5nwOgTPM7RvNFOTki14hlqvPKXV/DVBqx7kVswMdMLrEPrM
	 pkgjIQUFtXyEkk9E4Mk95voq5B8wRTyRB2iXVqq71GGikDJHOlMmr5hA8jyokph0fQ
	 CVHyavPYOzf3MhZWn5mNE/RUckWYhj+gCACHmX5x2FE2ffgK8Mp7sDiyR0LumWQqp2
	 pOlek23d7QDwZafI0Ji1iMVs2x8U3+s1OcidlkCiqvTbRw6XJpjTWvpVtYOFKD19c+
	 Zh0qpM81Bsq1yvbRdKlPh0RBeZxFwMUh3+YNnoy7TOi3ouaoWPEaOQA/eY7AbKuUkV
	 mFDuWvjPRl2hA==
Date: Thu, 22 Jan 2026 09:47:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/14] iov_iter: extract a iov_iter_extract_bvecs helper
 from bio code
Message-ID: <20260122174703.GX5945@frogsfrogsfrogs>
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119074425.4005867-4-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75133-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53F8F6BD6A
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 08:44:10AM +0100, Christoph Hellwig wrote:
> Massage __bio_iov_iter_get_pages so that it doesn't need the bio, and
> move it to lib/iov_iter.c so that it can be used by block code for
> other things than filling a bio and by other subsystems like netfs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c         | 120 +++++++-------------------------------------
>  include/linux/uio.h |   3 ++
>  lib/iov_iter.c      |  98 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 119 insertions(+), 102 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 46ff33f4de04..12cd3c5f6d6d 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1172,102 +1172,6 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
>  	bio_set_flag(bio, BIO_CLONED);
>  }
>  
> -static unsigned int get_contig_folio_len(struct page **pages,
> -					 unsigned int *num_pages, size_t left,
> -					 size_t offset)
> -{
> -	struct folio *folio = page_folio(pages[0]);
> -	size_t contig_sz = min_t(size_t, PAGE_SIZE - offset, left);
> -	unsigned int max_pages, i;
> -	size_t folio_offset, len;
> -
> -	folio_offset = PAGE_SIZE * folio_page_idx(folio, pages[0]) + offset;
> -	len = min(folio_size(folio) - folio_offset, left);
> -
> -	/*
> -	 * We might COW a single page in the middle of a large folio, so we have
> -	 * to check that all pages belong to the same folio.
> -	 */
> -	left -= contig_sz;
> -	max_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
> -	for (i = 1; i < max_pages; i++) {
> -		size_t next = min_t(size_t, PAGE_SIZE, left);
> -
> -		if (page_folio(pages[i]) != folio ||
> -		    pages[i] != pages[i - 1] + 1)
> -			break;
> -		contig_sz += next;
> -		left -= next;
> -	}
> -
> -	*num_pages = i;
> -	return contig_sz;
> -}
> -
> -#define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
> -
> -/**
> - * __bio_iov_iter_get_pages - pin user or kernel pages and add them to a bio
> - * @bio: bio to add pages to
> - * @iter: iov iterator describing the region to be mapped
> - *
> - * Extracts pages from *iter and appends them to @bio's bvec array.  The pages
> - * will have to be cleaned up in the way indicated by the BIO_PAGE_PINNED flag.
> - * For a multi-segment *iter, this function only adds pages from the next
> - * non-empty segment of the iov iterator.
> - */
> -static ssize_t __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> -{
> -	iov_iter_extraction_t extraction_flags = 0;
> -	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
> -	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
> -	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
> -	struct page **pages = (struct page **)bv;

Huh.  We type-abuse an array of bio_vec's as an array of struct page
pointers??

As a straight hoist the patch looks correct but I'm confused about this.

--D

> -	ssize_t size;
> -	unsigned int i = 0;
> -	size_t offset, left, len;
> -
> -	/*
> -	 * Move page array up in the allocated memory for the bio vecs as far as
> -	 * possible so that we can start filling biovecs from the beginning
> -	 * without overwriting the temporary page array.
> -	 */
> -	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
> -	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
> -
> -	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
> -		extraction_flags |= ITER_ALLOW_P2PDMA;
> -
> -	size = iov_iter_extract_pages(iter, &pages,
> -				      UINT_MAX - bio->bi_iter.bi_size,
> -				      nr_pages, extraction_flags, &offset);
> -	if (unlikely(size <= 0))
> -		return size ? size : -EFAULT;
> -
> -	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
> -	for (left = size; left > 0; left -= len) {
> -		unsigned int nr_to_add;
> -
> -		if (bio->bi_vcnt > 0) {
> -			struct bio_vec *prev = &bio->bi_io_vec[bio->bi_vcnt - 1];
> -
> -			if (!zone_device_pages_have_same_pgmap(prev->bv_page,
> -					pages[i]))
> -				break;
> -		}
> -
> -		len = get_contig_folio_len(&pages[i], &nr_to_add, left, offset);
> -		__bio_add_page(bio, pages[i], len, offset);
> -		i += nr_to_add;
> -		offset = 0;
> -	}
> -
> -	iov_iter_revert(iter, left);
> -	while (i < nr_pages)
> -		bio_release_page(bio, pages[i++]);
> -	return size - left;
> -}
> -
>  /*
>   * Aligns the bio size to the len_align_mask, releasing excessive bio vecs that
>   * __bio_iov_iter_get_pages may have inserted, and reverts the trimmed length
> @@ -1325,7 +1229,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
>  int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
>  			   unsigned len_align_mask)
>  {
> -	ssize_t ret;
> +	iov_iter_extraction_t flags = 0;
>  
>  	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
>  		return -EIO;
> @@ -1338,14 +1242,26 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
>  
>  	if (iov_iter_extract_will_pin(iter))
>  		bio_set_flag(bio, BIO_PAGE_PINNED);
> +	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
> +		flags |= ITER_ALLOW_P2PDMA;
>  
>  	do {
> -		ret = __bio_iov_iter_get_pages(bio, iter);
> -	} while (ret > 0 && iov_iter_count(iter) && !bio_full(bio, 0));
> +		ssize_t ret;
> +
> +		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
> +				UINT_MAX - bio->bi_iter.bi_size, &bio->bi_vcnt,
> +				bio->bi_max_vecs, flags);
> +		if (ret <= 0) {
> +			if (!bio->bi_vcnt)
> +				return ret;
> +			break;
> +		}
> +		bio->bi_iter.bi_size += ret;
> +	} while (iov_iter_count(iter) && !bio_full(bio, 0));
>  
> -	if (bio->bi_vcnt)
> -		return bio_iov_iter_align_down(bio, iter, len_align_mask);
> -	return ret;
> +	if (is_pci_p2pdma_page(bio->bi_io_vec->bv_page))
> +		bio->bi_opf |= REQ_NOMERGE;
> +	return bio_iov_iter_align_down(bio, iter, len_align_mask);
>  }
>  
>  static void submit_bio_wait_endio(struct bio *bio)
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 5b127043a151..a9bc5b3067e3 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -389,6 +389,9 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i, struct page ***pages,
>  			       size_t maxsize, unsigned int maxpages,
>  			       iov_iter_extraction_t extraction_flags,
>  			       size_t *offset0);
> +ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
> +		size_t max_size, unsigned short *nr_vecs,
> +		unsigned short max_vecs, iov_iter_extraction_t extraction_flags);
>  
>  /**
>   * iov_iter_extract_will_pin - Indicate how pages from the iterator will be retained
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 896760bad455..545250507f08 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1845,3 +1845,101 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i,
>  	return -EFAULT;
>  }
>  EXPORT_SYMBOL_GPL(iov_iter_extract_pages);
> +
> +static unsigned int get_contig_folio_len(struct page **pages,
> +		unsigned int *num_pages, size_t left, size_t offset)
> +{
> +	struct folio *folio = page_folio(pages[0]);
> +	size_t contig_sz = min_t(size_t, PAGE_SIZE - offset, left);
> +	unsigned int max_pages, i;
> +	size_t folio_offset, len;
> +
> +	folio_offset = PAGE_SIZE * folio_page_idx(folio, pages[0]) + offset;
> +	len = min(folio_size(folio) - folio_offset, left);
> +
> +	/*
> +	 * We might COW a single page in the middle of a large folio, so we have
> +	 * to check that all pages belong to the same folio.
> +	 */
> +	left -= contig_sz;
> +	max_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
> +	for (i = 1; i < max_pages; i++) {
> +		size_t next = min_t(size_t, PAGE_SIZE, left);
> +
> +		if (page_folio(pages[i]) != folio ||
> +		    pages[i] != pages[i - 1] + 1)
> +			break;
> +		contig_sz += next;
> +		left -= next;
> +	}
> +
> +	*num_pages = i;
> +	return contig_sz;
> +}
> +
> +#define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
> +
> +/**
> + * iov_iter_extract_bvecs - Extract bvecs from an iterator
> + * @iter:	the iterator to extract from
> + * @bv:		bvec return array
> + * @max_size:	maximum size to extract from @iter
> + * @nr_vecs:	number of vectors in @bv (on in and output)
> + * @max_vecs:	maximum vectors in @bv, including those filled before calling
> + * @extraction_flags: flags to qualify request
> + *
> + * Like iov_iter_extract_pages(), but returns physically contiguous ranges
> + * contained in a single folio as a single bvec instead of multiple entries.
> + *
> + * Returns the number of bytes extracted when successful, or a negative errno.
> + * If @nr_vecs was non-zero on entry, the number of successfully extracted bytes
> + * can be 0.
> + */
> +ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
> +		size_t max_size, unsigned short *nr_vecs,
> +		unsigned short max_vecs, iov_iter_extraction_t extraction_flags)
> +{
> +	unsigned short entries_left = max_vecs - *nr_vecs;
> +	unsigned short nr_pages, i = 0;
> +	size_t left, offset, len;
> +	struct page **pages;
> +	ssize_t size;
> +
> +	/*
> +	 * Move page array up in the allocated memory for the bio vecs as far as
> +	 * possible so that we can start filling biovecs from the beginning
> +	 * without overwriting the temporary page array.
> +	 */
> +	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
> +	pages = (struct page **)(bv + *nr_vecs) +
> +		entries_left * (PAGE_PTRS_PER_BVEC - 1);
> +
> +	size = iov_iter_extract_pages(iter, &pages, max_size, entries_left,
> +			extraction_flags, &offset);
> +	if (unlikely(size <= 0))
> +		return size ? size : -EFAULT;
> +
> +	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
> +	for (left = size; left > 0; left -= len) {
> +		unsigned int nr_to_add;
> +
> +		if (*nr_vecs > 0 &&
> +		    !zone_device_pages_have_same_pgmap(bv[*nr_vecs - 1].bv_page,
> +				pages[i]))
> +			break;
> +
> +		len = get_contig_folio_len(&pages[i], &nr_to_add, left, offset);
> +		bvec_set_page(&bv[*nr_vecs], pages[i], len, offset);
> +		i += nr_to_add;
> +		(*nr_vecs)++;
> +		offset = 0;
> +	}
> +
> +	iov_iter_revert(iter, left);
> +	if (iov_iter_extract_will_pin(iter)) {
> +		while (i < nr_pages)
> +			unpin_user_page(pages[i++]);
> +	}
> +	return size - left;
> +}
> +EXPORT_SYMBOL_GPL(iov_iter_extract_bvecs);
> -- 
> 2.47.3
> 
> 

