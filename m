Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43CF68E60D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 03:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBHC24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 21:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBHC2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:28:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312F52658B
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Feb 2023 18:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+FYIJ/QVZlT9R0BZU7C2h00TzB/VrCz1X8cC3mZzul0=; b=FjG7BGHoTqtsjm2YWyK/7zEYFj
        j9Q4oicPlS/0Di5KBJQ7BR+oEnrRWaxYonXYcbY/K8NRFvOqKW0RCU8+tOnTDXFNlF9mVvgiu/X4b
        o9L6TPB23brWLoWOp8K5Cx9NGowRMd5zbwGNob5AgNW0PYZ6yU5cLPvkKo09RFqnyi4jgwYUejDS0
        AGw6tKVec8m/WJUD829gWgOtNiWDkVg5Z3n3o51rdzyBP0prqIhNePZ1XsAmxUYHx6i+zJUe3JEx/
        01Rsu4lyHnNv4m7tUYQDYx8NjFQDCKO1Y8ly96JjAojlGDsl7KZO3S5KY1CbTbTfdYOFN5LLedJPu
        AJVvYTtw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPaCY-000mt8-VE; Wed, 08 Feb 2023 02:28:50 +0000
Date:   Wed, 8 Feb 2023 02:28:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     coolqyj@163.com
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Qian Yingjin <qian@ddn.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] [PATCH V2] mm/filemap: fix page end in
 filemap_get_read_batch
Message-ID: <Y+MI4mdGfXYDcp0R@casper.infradead.org>
References: <20230208022400.28962-1-coolqyj@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208022400.28962-1-coolqyj@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 08, 2023 at 10:24:00AM +0800, coolqyj@163.com wrote:
> From: Qian Yingjin <qian@ddn.com>
> 
> I was running traces of the read code against an RAID storage
> system to understand why read requests were being misaligned
> against the underlying RAID strips. I found that the page end
> offset calculation in filemap_get_read_batch() was off by one.
> 
> When a read is submitted with end offset 1048575, then it
> calculates the end page for read of 256 when it should be 255.
> "last_index" is the index of the page beyond the end of the read
> and it should be skipped when get a batch of pages for read in
> @filemap_get_read_batch().
> 
> The below simple patch fixes the problem. This code was introduced
> in kernel 5.12.
> 
> Fixes: cbd59c48ae2b ("mm/filemap: use head pages in generic_file_buffered_read")
> Signed-off-by: Qian Yingjin <qian@ddn.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: stable@vger.kernel.org

> ---
>  mm/filemap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index c4d4ace9cc70..0e20a8d6dd93 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2588,18 +2588,19 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
>  	struct folio *folio;
>  	int err = 0;
>  
> +	/* "last_index" is the index of the page beyond the end of the read */
>  	last_index = DIV_ROUND_UP(iocb->ki_pos + iter->count, PAGE_SIZE);
>  retry:
>  	if (fatal_signal_pending(current))
>  		return -EINTR;
>  
> -	filemap_get_read_batch(mapping, index, last_index, fbatch);
> +	filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
>  	if (!folio_batch_count(fbatch)) {
>  		if (iocb->ki_flags & IOCB_NOIO)
>  			return -EAGAIN;
>  		page_cache_sync_readahead(mapping, ra, filp, index,
>  				last_index - index);
> -		filemap_get_read_batch(mapping, index, last_index, fbatch);
> +		filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
>  	}
>  	if (!folio_batch_count(fbatch)) {
>  		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
> -- 
> 2.34.1
> 
