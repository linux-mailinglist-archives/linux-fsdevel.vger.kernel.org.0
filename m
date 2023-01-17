Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B1E66D781
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 09:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbjAQIHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 03:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbjAQIHf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:07:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFDCA245;
        Tue, 17 Jan 2023 00:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hvgk7w+cUmN1kDaRzCfPjjA8Chz40k3bd5sO917U728=; b=Zw7gwJnEfuWdz1VemBkqeJ2nTL
        1QRninlkVKWFylUm6HgSoGtqM8u3ynHzM3idlmVOoms+CooSh1Oq79+yaYQnDqRx/uBHGV+YBg/70
        GU8Oxg4TXSdonnoti1wdWo8SzcW1tcFMCZrqZegLHQxXEPrvfzJcpdzFYuud4tcLtn3AcpYzaBXrV
        znWlWOR0xk5YdfWWx/l92KYFVFgQfQSLuPxaNdtPXGBKVE9SdINsrOup/ZKDx+K2tbay4BvK+cuPi
        g9ooiV3WK1sFAxrJTzM+dC9KEzi2gANG184w62EibrDb8rUorN1FUWQOidgiMzsed2OKyb1dSfpQ7
        XuMRqyjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHh0C-00DHAu-Pc; Tue, 17 Jan 2023 08:07:28 +0000
Date:   Tue, 17 Jan 2023 00:07:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/34] iov_iter, block: Make bio structs pin pages
 rather than ref'ing if appropriate
Message-ID: <Y8ZXQArEsIRNO9k/@infradead.org>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391056047.2311931.6772604381276147664.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167391056047.2311931.6772604381276147664.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	size = iov_iter_extract_pages(iter, &pages,
> +				      UINT_MAX - bio->bi_iter.bi_size,
> +				      nr_pages, gup_flags, &offset);
>  	if (unlikely(size <= 0))


> +	bio_set_cleanup_mode(bio, iter, gup_flags);

This should move out to bio_iov_iter_get_pages and only be called
once.

> +++ b/block/blk-map.c
> @@ -285,24 +285,24 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>  		gup_flags |= FOLL_PCI_P2PDMA;
>  
>  	while (iov_iter_count(iter)) {
> -		struct page **pages, *stack_pages[UIO_FASTIOV];
> +		struct page *stack_pages[UIO_FASTIOV];
> +		struct page **pages = stack_pages;
>  		ssize_t bytes;
>  		size_t offs;
>  		int npages;
>  
> -		if (nr_vecs <= ARRAY_SIZE(stack_pages)) {
> -			pages = stack_pages;
> -			bytes = iov_iter_get_pages(iter, pages, LONG_MAX,
> -						   nr_vecs, &offs, gup_flags);
> -		} else {
> -			bytes = iov_iter_get_pages_alloc(iter, &pages,
> -						LONG_MAX, &offs, gup_flags);
> -		}
> +		if (nr_vecs > ARRAY_SIZE(stack_pages))
> +			pages = NULL;
> +
> +		bytes = iov_iter_extract_pages(iter, &pages, LONG_MAX,
> +					       nr_vecs, gup_flags, &offs);
>  		if (unlikely(bytes <= 0)) {
>  			ret = bytes ? bytes : -EFAULT;
>  			goto out_unmap;
>  		}
>  
> +		bio_set_cleanup_mode(bio, iter, gup_flags);

Same here - one call outside of the loop.

> +static inline void bio_set_cleanup_mode(struct bio *bio, struct iov_iter *iter,
> +					unsigned int gup_flags)
> +{
> +	unsigned int cleanup_mode;
> +
> +	bio_clear_flag(bio, BIO_PAGE_REFFED);

.. and this should not be needed.  Instead:

> +	cleanup_mode = iov_iter_extract_mode(iter, gup_flags);
> +	if (cleanup_mode & FOLL_GET)
> +		bio_set_flag(bio, BIO_PAGE_REFFED);
> +	if (cleanup_mode & FOLL_PIN)
> +		bio_set_flag(bio, BIO_PAGE_PINNED);

We could warn if a not match flag is set here if we really care.

