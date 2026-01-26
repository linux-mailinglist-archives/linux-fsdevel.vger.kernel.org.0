Return-Path: <linux-fsdevel+bounces-75523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDHaOhXDd2nckgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:40:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AA78CAE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB6843023054
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 19:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3941F4CBC;
	Mon, 26 Jan 2026 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdHLArBC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C8D3B2BA;
	Mon, 26 Jan 2026 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456400; cv=none; b=XThGrzxsf9zkPXkrBlTot7FfvRP/SC0DEoM3Yc5Ds6G4NtI9Xjq9Zumhkdp7yRUBD51tYvoN2Mw1dsqLCjNmR3pbOmVtdr5QnW3nPEVd32mgAojXCWQAuzwv1MWZo4ESgBuRQOvoURjpx6KtmgomMr9oRJqe8JqfCwVulgUYJ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456400; c=relaxed/simple;
	bh=BAt4M7A75yIZxDL2kvP8H0oonHCKGlotbg4X9J0BV5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxoRZ6jsR3bFr0e1wZL2Daob23HXl52RWjJvWrwVIJc19fAUz93v4j6I1gtpAg3i2npi7EBVmpmux4wTzjdr9lUeuTGCZ00aohizOjfpGigQ3/79D8nT3wfpbLHg6S+U4QfkhSs5lRHeY5fxjWWh0uaZi5HDi6ZlPJvAlUOcYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdHLArBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46708C19422;
	Mon, 26 Jan 2026 19:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769456400;
	bh=BAt4M7A75yIZxDL2kvP8H0oonHCKGlotbg4X9J0BV5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PdHLArBC7mkgH5O7Kn+UMocUcwmLr9K3DhGIY/JpHK3mQJQvcYsYidgxvl5hc26mg
	 A2P+jl2G1B8M0s9axEX654dB08eLNkyOuBkIqG6+75yaU98H9VYG+UqcJKjFqwcdhz
	 7A2l/wDheKBRPyDAUCUiJ47ZaCvp2304foXe1AIEJhgj2YtNPMvcV5SPWeA/p2L13q
	 7X2giSvwZ59Z+yOpAvejME3MZwujCz1FWopP33om2z4Ia1HHZYwjyIxSfuesnTojuB
	 3Jr5yyvIcs3WWPSJp8S1zBVjZvLGR0z7UQ+OoKRwnRS3KZtkhPYoTtFaiI3aFOvHbq
	 STdYJ+aIBg+Rg==
Date: Mon, 26 Jan 2026 11:39:59 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 06/15] block: add helpers to bounce buffer an iov_iter
 into bios
Message-ID: <20260126193959.GW5910@frogsfrogsfrogs>
References: <20260126055406.1421026-1-hch@lst.de>
 <20260126055406.1421026-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126055406.1421026-7-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75523-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email,samsung.com:email]
X-Rspamd-Queue-Id: 69AA78CAE3
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 06:53:37AM +0100, Christoph Hellwig wrote:
> Add helpers to implement bounce buffering of data into a bio to implement
> direct I/O for cases where direct user access is not possible because
> stable in-flight data is required.  These are intended to be used as
> easily as bio_iov_iter_get_pages for the zero-copy path.
> 
> The write side is trivial and just copies data into the bounce buffer.
> The read side is a lot more complex because it needs to perform the copy
> from the completion context, and without preserving the iov_iter through
> the call chain.  It steals a trick from the integrity data user interface
> and uses the first vector in the bio for the bounce buffer data that is
> fed to the block I/O stack, and uses the others to record the user
> buffer fragments.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Anuj Gupta <anuj20.g@samsung.com
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Tested-by: Anuj Gupta <anuj20.g@samsung.com>

Looks good, thanks for addressing my feedback on the last revision :)
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  block/bio.c         | 179 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/bio.h |  26 +++++++
>  2 files changed, 205 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 285b573ae82f..49f7548a31d6 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1266,6 +1266,185 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
>  	return bio_iov_iter_align_down(bio, iter, len_align_mask);
>  }
>  
> +static struct folio *folio_alloc_greedy(gfp_t gfp, size_t *size)
> +{
> +	struct folio *folio;
> +
> +	while (*size > PAGE_SIZE) {
> +		folio = folio_alloc(gfp | __GFP_NORETRY, get_order(*size));
> +		if (folio)
> +			return folio;
> +		*size = rounddown_pow_of_two(*size - 1);
> +	}
> +
> +	return folio_alloc(gfp, get_order(*size));
> +}
> +
> +static void bio_free_folios(struct bio *bio)
> +{
> +	struct bio_vec *bv;
> +	int i;
> +
> +	bio_for_each_bvec_all(bv, bio, i) {
> +		struct folio *folio = page_folio(bv->bv_page);
> +
> +		if (!is_zero_folio(folio))
> +			folio_put(folio);
> +	}
> +}
> +
> +static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter)
> +{
> +	size_t total_len = iov_iter_count(iter);
> +
> +	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
> +		return -EINVAL;
> +	if (WARN_ON_ONCE(bio->bi_iter.bi_size))
> +		return -EINVAL;
> +	if (WARN_ON_ONCE(bio->bi_vcnt >= bio->bi_max_vecs))
> +		return -EINVAL;
> +
> +	do {
> +		size_t this_len = min(total_len, SZ_1M);
> +		struct folio *folio;
> +
> +		if (this_len > PAGE_SIZE * 2)
> +			this_len = rounddown_pow_of_two(this_len);
> +
> +		if (bio->bi_iter.bi_size > BIO_MAX_SIZE - this_len)
> +			break;
> +
> +		folio = folio_alloc_greedy(GFP_KERNEL, &this_len);
> +		if (!folio)
> +			break;
> +		bio_add_folio_nofail(bio, folio, this_len, 0);
> +
> +		if (copy_from_iter(folio_address(folio), this_len, iter) !=
> +				this_len) {
> +			bio_free_folios(bio);
> +			return -EFAULT;
> +		}
> +
> +		total_len -= this_len;
> +	} while (total_len && bio->bi_vcnt < bio->bi_max_vecs);
> +
> +	if (!bio->bi_iter.bi_size)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter)
> +{
> +	size_t len = min(iov_iter_count(iter), SZ_1M);
> +	struct folio *folio;
> +
> +	folio = folio_alloc_greedy(GFP_KERNEL, &len);
> +	if (!folio)
> +		return -ENOMEM;
> +
> +	do {
> +		ssize_t ret;
> +
> +		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec + 1, len,
> +				&bio->bi_vcnt, bio->bi_max_vecs - 1, 0);
> +		if (ret <= 0) {
> +			if (!bio->bi_vcnt)
> +				return ret;
> +			break;
> +		}
> +		len -= ret;
> +		bio->bi_iter.bi_size += ret;
> +	} while (len && bio->bi_vcnt < bio->bi_max_vecs - 1);
> +
> +	/*
> +	 * Set the folio directly here.  The above loop has already calculated
> +	 * the correct bi_size, and we use bi_vcnt for the user buffers.  That
> +	 * is safe as bi_vcnt is only used by the submitter and not the actual
> +	 * I/O path.
> +	 */
> +	bvec_set_folio(&bio->bi_io_vec[0], folio, bio->bi_iter.bi_size, 0);
> +	if (iov_iter_extract_will_pin(iter))
> +		bio_set_flag(bio, BIO_PAGE_PINNED);
> +	return 0;
> +}
> +
> +/**
> + * bio_iov_iter_bounce - bounce buffer data from an iter into a bio
> + * @bio:	bio to send
> + * @iter:	iter to read from / write into
> + *
> + * Helper for direct I/O implementations that need to bounce buffer because
> + * we need to checksum the data or perform other operations that require
> + * consistency.  Allocates folios to back the bounce buffer, and for writes
> + * copies the data into it.  Needs to be paired with bio_iov_iter_unbounce()
> + * called on completion.
> + */
> +int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter)
> +{
> +	if (op_is_write(bio_op(bio)))
> +		return bio_iov_iter_bounce_write(bio, iter);
> +	return bio_iov_iter_bounce_read(bio, iter);
> +}
> +
> +static void bvec_unpin(struct bio_vec *bv, bool mark_dirty)
> +{
> +	struct folio *folio = page_folio(bv->bv_page);
> +	size_t nr_pages = (bv->bv_offset + bv->bv_len - 1) / PAGE_SIZE -
> +			bv->bv_offset / PAGE_SIZE + 1;
> +
> +	if (mark_dirty)
> +		folio_mark_dirty_lock(folio);
> +	unpin_user_folio(folio, nr_pages);
> +}
> +
> +static void bio_iov_iter_unbounce_read(struct bio *bio, bool is_error,
> +		bool mark_dirty)
> +{
> +	unsigned int len = bio->bi_io_vec[0].bv_len;
> +
> +	if (likely(!is_error)) {
> +		void *buf = bvec_virt(&bio->bi_io_vec[0]);
> +		struct iov_iter to;
> +
> +		iov_iter_bvec(&to, ITER_DEST, bio->bi_io_vec + 1, bio->bi_vcnt,
> +				len);
> +		/* copying to pinned pages should always work */
> +		WARN_ON_ONCE(copy_to_iter(buf, len, &to) != len);
> +	} else {
> +		/* No need to mark folios dirty if never copied to them */
> +		mark_dirty = false;
> +	}
> +
> +	if (bio_flagged(bio, BIO_PAGE_PINNED)) {
> +		int i;
> +
> +		for (i = 0; i < bio->bi_vcnt; i++)
> +			bvec_unpin(&bio->bi_io_vec[1 + i], mark_dirty);
> +	}
> +
> +	folio_put(page_folio(bio->bi_io_vec[0].bv_page));
> +}
> +
> +/**
> + * bio_iov_iter_unbounce - finish a bounce buffer operation
> + * @bio:	completed bio
> + * @is_error:	%true if an I/O error occurred and data should not be copied
> + * @mark_dirty:	If %true, folios will be marked dirty.
> + *
> + * Helper for direct I/O implementations that need to bounce buffer because
> + * we need to checksum the data or perform other operations that require
> + * consistency.  Called to complete a bio set up by bio_iov_iter_bounce().
> + * Copies data back for reads, and marks the original folios dirty if
> + * requested and then frees the bounce buffer.
> + */
> +void bio_iov_iter_unbounce(struct bio *bio, bool is_error, bool mark_dirty)
> +{
> +	if (op_is_write(bio_op(bio)))
> +		bio_free_folios(bio);
> +	else
> +		bio_iov_iter_unbounce_read(bio, is_error, mark_dirty);
> +}
> +
>  static void submit_bio_wait_endio(struct bio *bio)
>  {
>  	complete(bio->bi_private);
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index c75a9b3672aa..95cfc79b88b8 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -403,6 +403,29 @@ static inline int bio_iov_vecs_to_alloc(struct iov_iter *iter, int max_segs)
>  	return iov_iter_npages(iter, max_segs);
>  }
>  
> +/**
> + * bio_iov_bounce_nr_vecs - calculate number of bvecs for a bounce bio
> + * @iter:	iter to bounce from
> + * @op:		REQ_OP_* for the bio
> + *
> + * Calculates how many bvecs are needed for the next bio to bounce from/to
> + * @iter.
> + */
> +static inline unsigned short
> +bio_iov_bounce_nr_vecs(struct iov_iter *iter, blk_opf_t op)
> +{
> +	/*
> +	 * We still need to bounce bvec iters, so don't special case them
> +	 * here unlike in bio_iov_vecs_to_alloc.
> +	 *
> +	 * For reads we need to use a vector for the bounce buffer, account
> +	 * for that here.
> +	 */
> +	if (op_is_write(op))
> +		return iov_iter_npages(iter, BIO_MAX_VECS);
> +	return iov_iter_npages(iter, BIO_MAX_VECS - 1) + 1;
> +}
> +
>  struct request_queue;
>  
>  void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
> @@ -456,6 +479,9 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty);
>  extern void bio_set_pages_dirty(struct bio *bio);
>  extern void bio_check_pages_dirty(struct bio *bio);
>  
> +int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter);
> +void bio_iov_iter_unbounce(struct bio *bio, bool is_error, bool mark_dirty);
> +
>  extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
>  			       struct bio *src, struct bvec_iter *src_iter);
>  extern void bio_copy_data(struct bio *dst, struct bio *src);
> -- 
> 2.47.3
> 
> 

