Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD95195C61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 18:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0RTG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 13:19:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0RTG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pmoPc0t0rO7dKiZX8bkxD81FxQnQZxtzBtxiWnWoIco=; b=KfSj33LLKULI6TqjSZXIDA4xpZ
        aKDU1684S2fu+GP3SHEY5FbSWhwRyOwWYql/bw+OCgfJMRq/UrAZ/FHjAQJHtagnlbrnjCT7qUqZI
        7MklHb6bqLvl57nDGRaxWhS7i33YQgGyLPx+Bj9LL3G5naaB4AKlfI/M4MnqBE2BIXcKydPU2qbS5
        p6PPPPXSvjHSFShFmHuUvv9782ASi1bkHwaWw/tNfwayL/iiuo1dvK/tyqprYuYg0iAifkiHdKETE
        REv7RVRCChXPByCWtab2MmFqxneYCRMM34m+WETr4Qh/oLpC/Ey0LwGvHnzAlm4XVRX0iWC2BEh46
        xCgB++ow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHsdM-000286-Lz; Fri, 27 Mar 2020 17:19:04 +0000
Date:   Fri, 27 Mar 2020 10:19:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 02/10] block: Introduce REQ_OP_ZONE_APPEND
Message-ID: <20200327171904.GD11524@infradead.org>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
 <20200327165012.34443-3-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327165012.34443-3-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +/**
> + * bio_full - check if the bio is full
> + * @bio:	bio to check
> + * @len:	length of one segment to be added
> + *
> + * Return true if @bio is full and one segment with @len bytes can't be
> + * added to the bio, otherwise return false
> + */
> +bool bio_full(struct bio *bio, unsigned len)
> +{
> +	if (bio->bi_vcnt >= bio->bi_max_vecs)
> +		return true;
> +
> +	if (bio->bi_iter.bi_size > UINT_MAX - len)
> +		return true;
> +
> +	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
> +		return bio_can_zone_append(bio, len);
> +
> +	return false;
> +}

If you need to move bio_full out of line that should be a separate
prep patch.  But I'd rather unshare a little more code rather than
spreading zone append conditionals over lots of fast path functions.

> +static bool bio_try_merge_zone_append_page(struct bio *bio, struct page *page,
> +					   unsigned int len, unsigned int off)
> +{
> +	struct request_queue *q = bio->bi_disk->queue;
> +	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> +	unsigned long mask = queue_segment_boundary(q);
> +	phys_addr_t addr1 = page_to_phys(bv->bv_page) + bv->bv_offset;
> +	phys_addr_t addr2 = page_to_phys(page) + off + len - 1;
> +
> +	if ((addr1 | mask) != (addr2 | mask))
> +		return false;
> +	if (bv->bv_len + len > queue_max_segment_size(q))
> +		return false;
> +	return true;
> +}

This seems to be identical to bio_try_merge_pc_page, except for not
passing an explicit queue argument, and for not calling
__bio_try_merge_page.  I'd rather factor out a new
__bio_can_merge_pc_page or similar helper in a prep patch and use
that in both functions.

>  /**
>   * __bio_try_merge_page - try appending data to an existing bvec.
>   * @bio: destination bio
> @@ -856,6 +911,12 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>  	if (bio->bi_vcnt > 0) {
>  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
>  
> +		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> +			if (!bio_try_merge_zone_append_page(bio, page, len,
> +							    off))
> +				return false;
> +		}
> +
>  		if (page_is_mergeable(bv, page, len, off, same_page)) {
>  			if (bio->bi_iter.bi_size > UINT_MAX - len)
>  				return false;

I'd rather have a separare __bio_try_merge_append_page helper to avoid
the conditional in __bio_try_merge_page.

> @@ -916,6 +977,7 @@ int bio_add_page(struct bio *bio, struct page *page,
>  	if (!__bio_try_merge_page(bio, page, len, offset, &same_page)) {
>  		if (bio_full(bio, len))
>  			return 0;
> +
>  		__bio_add_page(bio, page, len, offset);
>  	}
>  	return len;
> @@ -948,7 +1010,7 @@ static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
>  
>  	len = min_t(size_t, bv->bv_len - iter->iov_offset, iter->count);
>  	size = bio_add_page(bio, bv->bv_page, len,
> -				bv->bv_offset + iter->iov_offset);
> +			    bv->bv_offset + iter->iov_offset);

Spurious whitespace changes.

>  	if (unlikely(size != len))
>  		return -EINVAL;
>  	iov_iter_advance(iter, size);
> @@ -1448,7 +1510,7 @@ struct bio *bio_copy_user_iov(struct request_queue *q,
>   */
>  struct bio *bio_map_user_iov(struct request_queue *q,
>  			     struct iov_iter *iter,
> -			     gfp_t gfp_mask)
> +			     gfp_t gfp_mask, unsigned int op)

Why do we need to pass the op here? bio_map_user_iov is only used
for SG_IO passthrough.

>  				if (!__bio_add_pc_page(q, bio, page, n, offs,
> -						&same_page)) {
> +						       &same_page)) {

Spurious whitespace change.

>  extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
>  			   unsigned int, unsigned int);
> +

Spurious whitespace change.

> +static inline unsigned int queue_max_zone_append_sectors(const struct request_queue *q)

This adds an overly long line.
