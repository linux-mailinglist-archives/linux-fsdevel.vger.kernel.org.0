Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3BC453FB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 05:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhKQEvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 23:51:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231356AbhKQEvI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 23:51:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8258061507;
        Wed, 17 Nov 2021 04:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637124490;
        bh=GdnaMj2YI3JO2s0r4LO9LvGuvXD0/qHXCK4v0JlMbDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ukzGZAO4BEk4QO+P3SYZe+TWcN/89duFJxnK7uYVvk/wjrmqoVZkP+e85LjOsIp6x
         PNfaGjop7Gf7xemtQgMjKOXvSgBmBYXl5+m/F1FcjMwfZtXWGy1FaWR6uUrTzg3sWs
         n8Ep+POEuQ7ctIlw+sxC2KeRKAhqSRnVQqC6kY1XEr8qFzlzM3L2/xjTaF5I8XXsgl
         MEB0l2UHzqUabtYEUoALwymNxTauZ1COTny3I+VVTRjPrcvI6OTSIAXYO+RZDxsPMV
         9UbPjTFCp3QYXxwjq9V2xzlhFSHZLOjP9ecIIVsh6ItGUXfPRgTNITKWBEeG8uaCoH
         sOb3O1C3lR6zg==
Date:   Tue, 16 Nov 2021 20:48:10 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 05/28] block: Add bio_add_folio()
Message-ID: <20211117044810.GP24307@magnolia>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108040551.1942823-6-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 04:05:28AM +0000, Matthew Wilcox (Oracle) wrote:
> This is a thin wrapper around bio_add_page().  The main advantage here
> is the documentation that folios larger than 2GiB are not supported.
> It's not currently possible to allocate folios that large, but if it
> ever becomes possible, this function will fail gracefully instead of
> doing I/O to the wrong bytes.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  block/bio.c         | 22 ++++++++++++++++++++++
>  include/linux/bio.h |  3 ++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 15ab0d6d1c06..4b3087e20d51 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1033,6 +1033,28 @@ int bio_add_page(struct bio *bio, struct page *page,
>  }
>  EXPORT_SYMBOL(bio_add_page);
>  
> +/**
> + * bio_add_folio - Attempt to add part of a folio to a bio.
> + * @bio: BIO to add to.
> + * @folio: Folio to add.
> + * @len: How many bytes from the folio to add.
> + * @off: First byte in this folio to add.
> + *
> + * Filesystems that use folios can call this function instead of calling
> + * bio_add_page() for each page in the folio.  If @off is bigger than
> + * PAGE_SIZE, this function can create a bio_vec that starts in a page
> + * after the bv_page.  BIOs do not support folios that are 4GiB or larger.
> + *
> + * Return: Whether the addition was successful.
> + */
> +bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
> +		   size_t off)
> +{
> +	if (len > UINT_MAX || off > UINT_MAX)
> +		return 0;
> +	return bio_add_page(bio, &folio->page, len, off) > 0;
> +}
> +
>  void __bio_release_pages(struct bio *bio, bool mark_dirty)
>  {
>  	struct bvec_iter_all iter_all;
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index fe6bdfbbef66..a783cac49978 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -409,7 +409,8 @@ extern void bio_uninit(struct bio *);
>  extern void bio_reset(struct bio *);
>  void bio_chain(struct bio *, struct bio *);
>  
> -extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
> +int bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
> +bool bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
>  extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
>  			   unsigned int, unsigned int);
>  int bio_add_zone_append_page(struct bio *bio, struct page *page,
> -- 
> 2.33.0
> 
