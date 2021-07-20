Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F993CF1BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 03:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344048AbhGTBPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 21:15:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238318AbhGTA6p (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 20:58:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 410F161004;
        Tue, 20 Jul 2021 01:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626744535;
        bh=45got/es61xzhcsJqmAAohKb8WL0wk+ATYQu22DHInM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDc8rfvvE0h4hOM+M7QpIwBxdgLrl/llbVOuXZZxf4/KTWlYloBlSUEl6wxiy02Ze
         r5DqFHgNEeQx4aNl9tOK8yAywHG48gVzFn5qAEoib6J6M2VqJ0BijzwTDpHUbHLhOa
         RvGbd8sd4C8unWKSmVUw+f00ug9zIblwRanulDZcyAiJ6ahRtZHJ/jSbM+faTUaKoV
         8zb2OxSRI/05CytVoZfhMPsvv7fHrGvYeUOA4VXfmB0V3wliaQa59J/XGcbXPNU6yJ
         8jzvgyggwgWss754qPBERzz8ACiRO7EqU4GfofHe6BJaNL95pMGv9vp0Qmn2aje43Q
         R/i63DAh51pqw==
Date:   Mon, 19 Jul 2021 18:28:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 01/17] block: Add bio_add_folio()
Message-ID: <20210720012854.GN22357@magnolia>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-2-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:45PM +0100, Matthew Wilcox (Oracle) wrote:
> This is a thin wrapper around bio_add_page().  The main advantage here
> is the documentation that the submitter can expect to see folios in the
> completion handler, and that stupidly large folios are not supported.
> It's not currently possible to allocate stupidly large folios, but if
> it ever becomes possible, this function will fail gracefully instead of
> doing I/O to the wrong bytes.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks fine to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  block/bio.c         | 21 +++++++++++++++++++++
>  include/linux/bio.h |  3 ++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 1fab762e079b..c64e35548fb2 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -933,6 +933,27 @@ int bio_add_page(struct bio *bio, struct page *page,
>  }
>  EXPORT_SYMBOL(bio_add_page);
>  
> +/**
> + * bio_add_folio - Attempt to add part of a folio to a bio.
> + * @bio: Bio to add to.
> + * @folio: Folio to add.
> + * @len: How many bytes from the folio to add.
> + * @off: First byte in this folio to add.
> + *
> + * Always uses the head page of the folio in the bio.  If a submitter only
> + * uses bio_add_folio(), it can count on never seeing tail pages in the
> + * completion routine.  BIOs do not support folios that are 4GiB or larger.
> + *
> + * Return: The number of bytes from this folio added to the bio.
> + */
> +size_t bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
> +		size_t off)
> +{
> +	if (len > UINT_MAX || off > UINT_MAX)
> +		return 0;
> +	return bio_add_page(bio, &folio->page, len, off);
> +}
> +
>  void bio_release_pages(struct bio *bio, bool mark_dirty)
>  {
>  	struct bvec_iter_all iter_all;
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 2203b686e1f0..ade93e2de6a1 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -462,7 +462,8 @@ extern void bio_uninit(struct bio *);
>  extern void bio_reset(struct bio *);
>  void bio_chain(struct bio *, struct bio *);
>  
> -extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
> +int bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
> +size_t bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
>  extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
>  			   unsigned int, unsigned int);
>  int bio_add_zone_append_page(struct bio *bio, struct page *page,
> -- 
> 2.30.2
> 
