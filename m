Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CEE7A4CEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 17:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjIRPno (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 11:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjIRPnk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:43:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE91FE;
        Mon, 18 Sep 2023 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rj2lPT4ijRerOpK7UwrimNkow+34fyVgpBIesK0KMQc=; b=qoEX3H+xID+BmrY//PeamZj9yO
        r14kN7qdBG0ZeZR8nJOK+PI/cbqASQLdisdX5fqZup87JfFblAbBOjgI0aYrG+/YduUe8wgG+FazP
        8gwRGoQv9KUtaKiA40RCuVvdH5QwatL19c/NHUK7XUyF3bO6KVYRjyrFdr1/ol8LqbGEB63ETKKsP
        hJ+MzvqzaCvjKzGKobFWtx9vPU3XSqOKBR+PI5BCA3OWYLJ3Ox4uGndSJZFc7y3QO5DhUFXIVF54+
        Wq/RNkL8rqb2IGyzKxzFHKdn62ZtgQJ6Ms3l4kc6/jUPYe4M9IYeTzwL1heddCzn21cKupOvO25P/
        nPVqcegA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiEVV-00BKBs-16; Mon, 18 Sep 2023 13:41:45 +0000
Date:   Mon, 18 Sep 2023 14:41:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/18] mm/filemap: allocate folios with mapping order
 preference
Message-ID: <ZQhTmF9VkShSequJ@casper.infradead.org>
References: <20230918110510.66470-1-hare@suse.de>
 <20230918110510.66470-8-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918110510.66470-8-hare@suse.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:04:59PM +0200, Hannes Reinecke wrote:
> +++ b/mm/filemap.c
> @@ -507,9 +507,14 @@ static void __filemap_fdatawait_range(struct address_space *mapping,
>  	pgoff_t end = end_byte >> PAGE_SHIFT;
>  	struct folio_batch fbatch;
>  	unsigned nr_folios;
> +	unsigned int order = mapping_min_folio_order(mapping);
>  
>  	folio_batch_init(&fbatch);
>  
> +	if (order) {
> +		index = ALIGN_DOWN(index, 1 << order);
> +		end = ALIGN_DOWN(end, 1 << order);
> +	}
>  	while (index <= end) {
>  		unsigned i;
>  

I don't understand why this function needs to change at all.
filemap_get_folios_tag() should return any folios which overlap
(index, end).  And aligning 'end' _down_ certainly sets off alarm bells
for me.  We surely would need to align _up_.  Except i don't think we
need to do anything to this function.

> @@ -2482,7 +2487,8 @@ static int filemap_create_folio(struct file *file,
>  	struct folio *folio;
>  	int error;
>  
> -	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
> +	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
> +				    mapping_min_folio_order(mapping));
>  	if (!folio)
>  		return -ENOMEM;
>  

Surely we need to align 'index' here?

> @@ -2542,9 +2548,16 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>  	pgoff_t last_index;
>  	struct folio *folio;
>  	int err = 0;
> +	unsigned int order = mapping_min_folio_order(mapping);
>  
>  	/* "last_index" is the index of the page beyond the end of the read */
>  	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
> +	if (order) {
> +		/* Align with folio order */
> +		WARN_ON(index % 1 << order);
> +		index = ALIGN_DOWN(index, 1 << order);
> +		last_index = ALIGN(last_index, 1 << order);
> +	}

Not sure I see the point of this.  filemap_get_read_batch() returns any
folio which contains 'index'.

>  retry:
>  	if (fatal_signal_pending(current))
>  		return -EINTR;
> @@ -2561,7 +2574,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>  		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
>  			return -EAGAIN;
>  		err = filemap_create_folio(filp, mapping,
> -				iocb->ki_pos >> PAGE_SHIFT, fbatch);
> +				index, fbatch);

... ah, you align index here.  I wonder if we wouldn't be better passing
iocb->ki_pos to filemap_create_folio() to emphasise that the caller
can't assume anything about the alignment/size of the folio.

> @@ -3676,7 +3689,8 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
>  repeat:
>  	folio = filemap_get_folio(mapping, index);
>  	if (IS_ERR(folio)) {
> -		folio = filemap_alloc_folio(gfp, 0);
> +		folio = filemap_alloc_folio(gfp,
> +				mapping_min_folio_order(mapping));
>  		if (!folio)
>  			return ERR_PTR(-ENOMEM);
>  		err = filemap_add_folio(mapping, folio, index, gfp);

This needs to align index.
