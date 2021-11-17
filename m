Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965AB453FBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 05:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhKQEvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 23:51:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230362AbhKQEvg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 23:51:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A640617E4;
        Wed, 17 Nov 2021 04:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637124518;
        bh=PaCQK9OcWvVCxVcVFvUIIp+dLbwqCFPxSiJVxDpNV18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kwfDRIcPmvU0duRN65O39l5QjUFh0jQ9kjZLHLdynWUyubQbPDP2Ckm3D0daybUdl
         s4Kgjw+RIcdd0jJv2EYFbDNGoHevLfYyrSHXzwJ443cbz0ibh9X53Oy0KkOHGw4upE
         NLRDF9gLgSQIvO4LtIJ2EnaIuSmS9vNRCoLQlOL3x25SxE/uB8QRqEzbOn8y3TQTde
         cD0rWPc4iBgHC/gB07X+OTdYf7Uk/H9ZQpNDH4hzT76LsriCLczSKgS7u8qkCPRqJx
         FJyzP/2iIGYJBG6SikeCDdLxHhw3Fyp/qia1txuLeolGzBl9Cg6iC5HnPugl7Y8mbp
         pc5RIW7bUaWzg==
Date:   Tue, 16 Nov 2021 20:48:37 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 06/28] block: Add bio_for_each_folio_all()
Message-ID: <20211117044837.GQ24307@magnolia>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108040551.1942823-7-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 04:05:29AM +0000, Matthew Wilcox (Oracle) wrote:
> Allow callers to iterate over each folio instead of each page.  The
> bio need not have been constructed using folios originally.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  Documentation/core-api/kernel-api.rst |  1 +
>  include/linux/bio.h                   | 53 ++++++++++++++++++++++++++-
>  2 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
> index 2e7186805148..7f0cb604b6ab 100644
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
> index a783cac49978..e3c9e8207f12 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -166,7 +166,7 @@ static inline void bio_advance(struct bio *bio, unsigned int nbytes)
>   */
>  #define bio_for_each_bvec_all(bvl, bio, i)		\
>  	for (i = 0, bvl = bio_first_bvec_all(bio);	\
> -	     i < (bio)->bi_vcnt; i++, bvl++)		\
> +	     i < (bio)->bi_vcnt; i++, bvl++)
>  
>  #define bio_iter_last(bvec, iter) ((iter).bi_size == (bvec).bv_len)
>  
> @@ -260,6 +260,57 @@ static inline struct bio_vec *bio_last_bvec_all(struct bio *bio)
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
> +static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
> +				   int i)
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
> 2.33.0
> 
