Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C390E3CAE5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 23:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhGOVPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 17:15:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhGOVPt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:15:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56E92613C3;
        Thu, 15 Jul 2021 21:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626383575;
        bh=2eoV3DBsVUIXnYKXMQsw7fTnkX0xs2z47Hnn9YDnfoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MpgVnTbhKqPGXysIWxc/iZW8xzbKcOVDoeh0uz3/FcT6fxcKP0XwMvCN+43xM7Rks
         wo/6Or5fqBYYoXKSHDhmhAvwCwn6ctVzvjP9dCa7IrGlHPuOG/JgMpjb9g7Y69l68E
         XNRCgHoVdUHXprYuX+SXSwf4/i65PUPIYcRkW9u84yTu/48N+h8MSgDMmsH+K3eIqf
         1vQZuoEUrEN53/q/IwMpC27kvST5VALGQRLxD+svGo2znpktYRLuHYLmFAYnXw9wp1
         AG2gAWnjRsWEh3FuM8myxNriPfZLDGULof27xFH6bApYwUTxuVWZg3LRIjFo9ZJLwY
         Gu5lpeYCVh9uQ==
Date:   Thu, 15 Jul 2021 14:12:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 091/138] block: Add bio_for_each_folio_all()
Message-ID: <20210715211254.GE22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-92-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-92-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:17AM +0100, Matthew Wilcox (Oracle) wrote:
> Allow callers to iterate over each folio instead of each page.  The
> bio need not have been constructed using folios originally.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/bio.h | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index ade93e2de6a1..d462bbc95c4b 100644
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
> @@ -314,6 +314,47 @@ static inline struct bio_vec *bio_last_bvec_all(struct bio *bio)
>  	return &bio->bi_io_vec[bio->bi_vcnt - 1];
>  }
>  
> +struct folio_iter {
> +	struct folio *folio;
> +	size_t offset;
> +	size_t length;

Hm... so after every bio_{first,next}_folio call, we can access the
folio, the offset, and the length (both in units of bytes) within the
folio?

> +	size_t _seg_count;
> +	int _i;

And these are private variables that the iteration code should not
scribble over?

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
> +/*
> + * Iterate over each folio in a bio.
> + */
> +#define bio_for_each_folio_all(fi, bio)				\
> +	for (bio_first_folio(&fi, bio, 0); fi.folio; bio_next_folio(&fi, bio))

...so I guess a sample iteration loop would be something like:

	struct bio *bio = <get one from somewhere>;
	struct folio_iter fi;

	bio_for_each_folio_all(fi, bio) {
		if (folio_test_dirty(fi.folio))
			printk("folio idx 0x%lx is dirty, i hates dirty data!",
					folio_index(fi.folio));
			panic();
	}

I'll go look through the rest of the patches, but this so far looks
pretty straightforward to me.

--D

> +
>  enum bip_flags {
>  	BIP_BLOCK_INTEGRITY	= 1 << 0, /* block layer owns integrity data */
>  	BIP_MAPPED_INTEGRITY	= 1 << 1, /* ref tag has been remapped */
> -- 
> 2.30.2
> 
