Return-Path: <linux-fsdevel+bounces-75129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCf6GypmcmmrjwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:02:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E23836BE1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F767318D468
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFBB261B8F;
	Thu, 22 Jan 2026 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STNbxxCg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F3355815;
	Thu, 22 Jan 2026 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102758; cv=none; b=sqA2urHmEhrHpOCxtIZ58t/K9BmvLnGm2RgjW6TNPyyqCNg6QZjV8bt0QfgUXoH1UAaSLQDV1d846CW1kOfenEiffGlebGNY8lD5S5jceFMnMbVY5tWBt5wzeDqaWItPyJHbjncCg3RWomO3nkjr0R6HN3HTGrhQMDfhAUfdN6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102758; c=relaxed/simple;
	bh=ShDs56bVZ41qCAw/Y8qeFLhYDOkxrwORZfAc7tHLkC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8EsFyoQR8WOrEu/dadalzHOxn/hMVleoX1Uw6j6X1zKapouNnsqHGNx8Si+lBx20kv94I9uLeduSlQFgmSFZ5qxPBzzG3zArlcvE2M0V2xN5S+VJ4HQdPBP7OvP2Jj2UrmzOgdyBe0rzPJG9gVWin1QpqnjSSDxMt18+zDSbsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STNbxxCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEEBC116C6;
	Thu, 22 Jan 2026 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769102757;
	bh=ShDs56bVZ41qCAw/Y8qeFLhYDOkxrwORZfAc7tHLkC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STNbxxCgos2tN9hgGuLBZEuyNdKg8XWeLIHth4j5iEQo7ktwf9U+AbRsmVE5Nf40c
	 iaYCMWsJVE1skQzAJjfmprfWFBa5jnubD/mkeZSpalby1pMnS5SRELAzu+rp3RBfL9
	 S3EP09NR1E+ZlOXkKewB1hYSxTdzTvpT7aPEvV4O0GWMK6jmUZWzZVBnxFPFBA5fNW
	 l5x1M8cmANF/TcJiemsC+7MgcCDurJ3hxZa98pFafV0e9KnGdDySxgjdpyAw21aW8N
	 7CcdifiFCIqd9qeQxM8GiJOzCkdqDdr6bOumMau5tjCCaKlutzBNnqWzraBVC1tuI1
	 eaFWaW1w7zGqg==
Date: Thu, 22 Jan 2026 09:25:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/14] block: add helpers to bounce buffer an iov_iter
 into bios
Message-ID: <20260122172556.GV5945@frogsfrogsfrogs>
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119074425.4005867-6-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-75129-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E23836BE1E
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 08:44:12AM +0100, Christoph Hellwig wrote:
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
> ---
>  block/bio.c         | 178 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/bio.h |  26 +++++++
>  2 files changed, 204 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index c51b4e2470e2..da795b1df52a 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1266,6 +1266,184 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
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

Hrm.  Should we combine this with the slightly different version that is
in xfs_healthmon?

/* Allocate as much memory as we can get for verification buffer. */
static struct folio *
xfs_verify_alloc_folio(
	const unsigned int	iosize)
{
	unsigned int		order = get_order(iosize);

	while (order > 0) {
		struct folio	*folio =
			folio_alloc(GFP_KERNEL | __GFP_NORETRY, order);

		if (folio)
			return folio;
		order--;
	}

	return folio_alloc(GFP_KERNEL, 0);
}

> +static void bio_free_folios(struct bio *bio)
> +{
> +	struct bio_vec *bv;
> +	int i;
> +
> +	bio_for_each_bvec_all(bv, bio, i) {
> +		struct folio *folio = page_folio(bv->bv_page);
> +
> +		if (!is_zero_folio(folio))
> +			folio_put(page_folio(bv->bv_page));

Isn't folio_put's argument just @folio again?

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
> +		if (bio->bi_iter.bi_size > UINT_MAX - this_len)

Now that I've seen UINT_MAX appear twice in terms of limiting bio size,
I wonder if that ought to be encoded as a constant somewhere?

#define BIO_ITER_MAX_SIZE	(UINT_MAX)

(apologies if I'm digging up some horrible old flamewar from the 1830s)

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
> +	 * is safe as bi_vcnt is only for user by the submitter and not looked

"...for use by the submitter..." ?

> +	 * at by the actual I/O path.
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
> +		WARN_ON_ONCE(copy_to_iter(buf, len, &to) != len);

I wonder, under what circumstances would the copy_to_iter come up short?

Something evil like $program initiates a directio read from a PI disk, a
BPF guy starts screaming in a datacenter to wobble the disk, and that
gives a compromised systemd enough time to attach to $program with
ptrace to unmap a page in the middle of the read buffer before
bio_iov_iter_unbounce_read gets called?

--D

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

