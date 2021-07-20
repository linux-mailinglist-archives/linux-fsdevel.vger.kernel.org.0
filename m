Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5020B3CF162
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 03:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbhGTAwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 20:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236874AbhGTAu0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 20:50:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6A8C6115B;
        Tue, 20 Jul 2021 01:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626744585;
        bh=PylUwAl+xcXt4KK9dSrgWcx8BRZ08iQRRV5ddM1yetU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGJonETlzbajpqBeoOiUxqonmHUmA1Omfuja27RxGvrDQ2sXvKwLGNgYTUVTfWLSw
         DF+ZsNY2Pnq/KGWk3Njqeb9FsqM1UFRby1XGg3fHaM1jcoZxQBsq16bVCG6+MN9w+f
         hEzEEKLHmF8R2VstG+GwdTX9B0CPEkjraNaPNz1GIpVcXZso8lIZSH4AZ2BufW9Uvi
         2gE3Xm1Zbnpy2wO895cBGqD1rKEjMoPOuRtCPfBhtshTgpvR1LGuXU24007YKIxtyU
         BHzWTfEOHuyrC6zoFfrgGBz2+ji0hxg2JMNDDiFaBVl5v2IJh/7zOrJUgoxrKJhDLc
         DSrhdK2hLIGgg==
Date:   Mon, 19 Jul 2021 18:29:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 02/17] block: Add bio_for_each_folio_all()
Message-ID: <20210720012945.GO22357@magnolia>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-3-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:46PM +0100, Matthew Wilcox (Oracle) wrote:
> Allow callers to iterate over each folio instead of each page.  The
> bio need not have been constructed using folios originally.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Whoops, I never did remember to circle back and ack this patch.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  Documentation/core-api/kernel-api.rst |  1 +
>  include/linux/bio.h                   | 53 ++++++++++++++++++++++++++-
>  2 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
> index 2a7444e3a4c2..b804605f705e 100644
> --- a/Documentation/core-api/kernel-api.rst
> +++ b/Documentation/core-api/kernel-api.rst
> @@ -279,6 +279,7 @@ Accounting Framework
>  Block Devices
>  =============
>  
> +.. kernel-doc:: include/linux/bio.h
>  .. kernel-doc:: block/blk-core.c
>     :export:
>  
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index ade93e2de6a1..a90a79ad7bd1 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -189,7 +189,7 @@ static inline void bio_advance_iter_single(const struct bio *bio,
>   */
>  #define bio_for_each_bvec_all(bvl, bio, i)		\
>  	for (i = 0, bvl = bio_first_bvec_all(bio);	\
> -	     i < (bio)->bi_vcnt; i++, bvl++)		\
> +	     i < (bio)->bi_vcnt; i++, bvl++)
>  
>  #define bio_iter_last(bvec, iter) ((iter).bi_size == (bvec).bv_len)
>  
> @@ -314,6 +314,57 @@ static inline struct bio_vec *bio_last_bvec_all(struct bio *bio)
>  	return &bio->bi_io_vec[bio->bi_vcnt - 1];
>  }
>  
> +/**
> + * struct folio_iter - State for iterating all folios in a bio.
> + * @folio: The current folio we're iterating.  NULL after the last folio.
> + * @offset: The byte offset within the current folio.
> + * @length: The number of bytes in this iteration (will not cross folio
> + *	boundary).
> + */
> +struct folio_iter {
> +	struct folio *folio;
> +	size_t offset;
> +	size_t length;
> +	/* private: for use by the iterator */
> +	size_t _seg_count;
> +	int _i;
> +};
> +
> +static inline
> +void bio_first_folio(struct folio_iter *fi, struct bio *bio, int i)
> +{
> +	struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
> +
> +	fi->folio = page_folio(bvec->bv_page);
> +	fi->offset = bvec->bv_offset +
> +			PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
> +	fi->_seg_count = bvec->bv_len;
> +	fi->length = min(folio_size(fi->folio) - fi->offset, fi->_seg_count);
> +	fi->_i = i;
> +}
> +
> +static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
> +{
> +	fi->_seg_count -= fi->length;
> +	if (fi->_seg_count) {
> +		fi->folio = folio_next(fi->folio);
> +		fi->offset = 0;
> +		fi->length = min(folio_size(fi->folio), fi->_seg_count);
> +	} else if (fi->_i + 1 < bio->bi_vcnt) {
> +		bio_first_folio(fi, bio, fi->_i + 1);
> +	} else {
> +		fi->folio = NULL;
> +	}
> +}
> +
> +/**
> + * bio_for_each_folio_all - Iterate over each folio in a bio.
> + * @fi: struct folio_iter which is updated for each folio.
> + * @bio: struct bio to iterate over.
> + */
> +#define bio_for_each_folio_all(fi, bio)				\
> +	for (bio_first_folio(&fi, bio, 0); fi.folio; bio_next_folio(&fi, bio))
> +
>  enum bip_flags {
>  	BIP_BLOCK_INTEGRITY	= 1 << 0, /* block layer owns integrity data */
>  	BIP_MAPPED_INTEGRITY	= 1 << 1, /* ref tag has been remapped */
> -- 
> 2.30.2
> 
