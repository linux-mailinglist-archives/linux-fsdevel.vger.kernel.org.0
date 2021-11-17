Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3883A453FB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 05:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhKQEsZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 23:48:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhKQEsZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 23:48:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FD6C61507;
        Wed, 17 Nov 2021 04:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637124327;
        bh=mn0jqU4DN2iADFJAwVuRs/A+Y69Iek8YMLmH/Ny06Ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eis1Dv3RXlf2J2KDdWuniZwuV+VVvkxQ+Avq/i9vOd2JUNkJ3VPcE252Sc4o9BFWu
         b6HZjuSv7xKTCm4v9vuEsV7Fjox6t8ODBH9zEKxJ0yaNen+l8QNx6WaMfEieJZLjWu
         ak9I1KI7I9xOlxUXdrPWRxUgpMwGLIMWhcx4VkJiULBUWnWCndECWSYURmeZDb/eGV
         GrW9OaMMKOzRYx0TBnBVLRjITCGxh16dJt26R4hkjQOMySzSmNVIK80bcqwq3p6eXM
         wvW3EFfMUXWswSJ/PtbxIFfUSaitctVlWPSgFAQr5Q+2CJhT15H5UIhPkNoolht3jT
         sZdsABUcwkPlQ==
Date:   Tue, 16 Nov 2021 20:45:27 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 02/28] mm: Add functions to zero portions of a folio
Message-ID: <20211117044527.GO24307@magnolia>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108040551.1942823-3-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 04:05:25AM +0000, Matthew Wilcox (Oracle) wrote:
> These functions are wrappers around zero_user_segments(), which means
> that zero_user_segments() can now be called for compound pages even when
> CONFIG_TRANSPARENT_HUGEPAGE is disabled.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/highmem.h | 44 ++++++++++++++++++++++++++++++++++++++---
>  mm/highmem.c            |  2 --
>  2 files changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 25aff0f2ed0b..c343c69bb5b4 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -231,10 +231,10 @@ static inline void tag_clear_highpage(struct page *page)
>   * If we pass in a base or tail page, we can zero up to PAGE_SIZE.
>   * If we pass in a head page, we can zero up to the size of the compound page.
>   */
> -#if defined(CONFIG_HIGHMEM) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> +#ifdef CONFIG_HIGHMEM
>  void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
>  		unsigned start2, unsigned end2);
> -#else /* !HIGHMEM || !TRANSPARENT_HUGEPAGE */
> +#else
>  static inline void zero_user_segments(struct page *page,
>  		unsigned start1, unsigned end1,
>  		unsigned start2, unsigned end2)
> @@ -254,7 +254,7 @@ static inline void zero_user_segments(struct page *page,
>  	for (i = 0; i < compound_nr(page); i++)
>  		flush_dcache_page(page + i);
>  }
> -#endif /* !HIGHMEM || !TRANSPARENT_HUGEPAGE */
> +#endif
>  
>  static inline void zero_user_segment(struct page *page,
>  	unsigned start, unsigned end)
> @@ -364,4 +364,42 @@ static inline void memzero_page(struct page *page, size_t offset, size_t len)
>  	kunmap_local(addr);
>  }
>  
> +/**
> + * folio_zero_segments() - Zero two byte ranges in a folio.
> + * @folio: The folio to write to.
> + * @start1: The first byte to zero.
> + * @end1: One more than the last byte in the first range.
> + * @start2: The first byte to zero in the second range.
> + * @end2: One more than the last byte in the second range.
> + */
> +static inline void folio_zero_segments(struct folio *folio,
> +		size_t start1, size_t end1, size_t start2, size_t end2)
> +{
> +	zero_user_segments(&folio->page, start1, end1, start2, end2);
> +}
> +
> +/**
> + * folio_zero_segment() - Zero a byte range in a folio.
> + * @folio: The folio to write to.
> + * @start: The first byte to zero.
> + * @end: One more than the last byte in the first range.
> + */
> +static inline void folio_zero_segment(struct folio *folio,
> +		size_t start, size_t end)
> +{
> +	zero_user_segments(&folio->page, start, end, 0, 0);
> +}
> +
> +/**
> + * folio_zero_range() - Zero a byte range in a folio.
> + * @folio: The folio to write to.
> + * @start: The first byte to zero.
> + * @length: The number of bytes to zero.
> + */
> +static inline void folio_zero_range(struct folio *folio,
> +		size_t start, size_t length)
> +{
> +	zero_user_segments(&folio->page, start, start + length, 0, 0);

At first I thought "Gee, this is wrong, end should be start+length-1!"

Then I looked at zero_user_segments and realized that despite the
parameter name "endi1", it really wants you to tell it the next byte.
Not the end byte of the range you want to zero.

Then I looked at the other two new functions and saw that you documented
this, and now I get why Linus ranted about this some time ago.

The code looks right, but the "end" names rankle me.  Can we please
change them all?  Or at least in the new functions, if you all already
fought a flamewar over this that I'm not aware of?

Almost-Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +}
> +
>  #endif /* _LINUX_HIGHMEM_H */
> diff --git a/mm/highmem.c b/mm/highmem.c
> index 88f65f155845..819d41140e5b 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -359,7 +359,6 @@ void kunmap_high(struct page *page)
>  }
>  EXPORT_SYMBOL(kunmap_high);
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
>  		unsigned start2, unsigned end2)
>  {
> @@ -416,7 +415,6 @@ void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
>  	BUG_ON((start1 | start2 | end1 | end2) != 0);
>  }
>  EXPORT_SYMBOL(zero_user_segments);
> -#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  #endif /* CONFIG_HIGHMEM */
>  
>  #ifdef CONFIG_KMAP_LOCAL
> -- 
> 2.33.0
> 
