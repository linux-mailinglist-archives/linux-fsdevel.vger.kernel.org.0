Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAD1443B53
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 03:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhKCC0Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 22:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhKCC0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 22:26:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15076C061714;
        Tue,  2 Nov 2021 19:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5zRgZ6/y0k3uMlXT0720QEVqvpr6GZYnv9MDOweyttY=; b=UsfmVHtYxZJzEvxzAeezzifOAD
        h63h0LwXGLtcenDkzokC4jxWvaGiBb2S+SpLOvYQ/GH9PWEIuA5bXUvnz548cXT1NeDE0Xo7Dog4M
        gCtuKOM+PAKYbjO2KtQldoOiRaN8y3q+6j2H3XHdAw8Hl4QShz6QqgLpL5yYhafItoEe9EMpy302q
        kERgPVsh7nX9rxpHfcGsD6CWciCsOiJy3roDZkOQREy+bQSLC7GaMT2anyfOxihWNkUIj/1EiEkGq
        opkzjZ/ImfeAPeKy6uZe566+hAfEPOpEYJD0QgW66VS3ZNQik99jgNtCl699biW+ygOOJuVG5cAu8
        bzf1Tqdw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mi5ue-004uNI-4n; Wed, 03 Nov 2021 02:22:35 +0000
Date:   Wed, 3 Nov 2021 02:22:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "wangjianjian (C)" <wangjianjian3@huawei.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/21] block: Add bio_add_folio()
Message-ID: <YYHyTDjIXCYdFXv7@casper.infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-3-willy@infradead.org>
 <d1d037a13796462a968b5de97c459ecc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1d037a13796462a968b5de97c459ecc@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 03, 2021 at 01:25:57AM +0000, wangjianjian (C) wrote:
> diff --git a/block/bio.c b/block/bio.c
> index 15ab0d6d1c06..0e911c4fb9f2 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1033,6 +1033,28 @@ int bio_add_page(struct bio *bio, struct page *page,  }  EXPORT_SYMBOL(bio_add_page);
>  
> +/**
> + * bio_add_folio - Attempt to add part of a folio to a bio.
> + * @bio: BIO to add to.
> + * @folio: Folio to add.
> + * @len: How many bytes from the folio to add.
> + * @off: First byte in this folio to add.
> + *
> + * Filesystems that use folios can call this function instead of 
> +calling
> + * bio_add_page() for each page in the folio.  If @off is bigger than
> + * PAGE_SIZE, this function can create a bio_vec that starts in a page
> + * after the bv_page.  BIOs do not support folios that are 4GiB or larger.
> + *
> + * Return: Whether the addition was successful.
> + */
> +bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
> +		size_t off)
> +{
> +	if (len > UINT_MAX || off > UINT_MAX)
> +		return 0;
> +	return bio_add_page(bio, &folio->page, len, off) > 0; }
> +
> 
> 
> Newline.

I think it's your mail system that's mangled it.  Here's how it looked
to the rest of the world:

https://lore.kernel.org/linux-xfs/20211101203929.954622-3-willy@infradead.org/
