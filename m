Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0693E2A495F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 16:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgKCPU4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 10:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgKCPSv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:18:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CF9C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 07:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p3irT3qFc+4BiDVPWzQS/NgjF9KfOecBSFvDs8AOBLo=; b=bcCphGH0lgZ2Kfq/L/sSvuEjUH
        5VfW5MkUG7AiQwiRQtdaRi5BQHUc58AAlbIGC3A3yJrkATxZcj5+tTFdOgZcUVjSKwzkyG3hhxIz7
        IkUW/IxqrAbr/o7nV/QF25JpNz9lSWB1xwfXtExmA8y0KUcrj4ijwRB0RWmsxbMb4Ts1HbEldJzvM
        qRkzM8C1Yf3YgWUeQN6dQgwuxgvdGX/89f7+64Ks0Wor4j7m9Jm+4HIdGj67YCACBsbLhluRm0OoA
        r3PlYLkyDe82wubHKYJJonJfrJgts8NedZMGDx6/SnRvl8BUrAXU32XGeg+1Thakyi/5c3FlS5Y5+
        ITpPIhVw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZy59-0006Ee-LI; Tue, 03 Nov 2020 15:18:47 +0000
Date:   Tue, 3 Nov 2020 15:18:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 11/17] mm/filemap: Add filemap_range_uptodate
Message-ID: <20201103151847.GZ27442@casper.infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-12-willy@infradead.org>
 <20201103074944.GK8389@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103074944.GK8389@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 08:49:44AM +0100, Christoph Hellwig wrote:
> On Mon, Nov 02, 2020 at 06:43:06PM +0000, Matthew Wilcox (Oracle) wrote:
> > Move the complicated condition and the calculations out of
> > filemap_update_page() into its own function.
> 
> The logic looks good, but the flow inside of filemap_update_page looks
> odd.  The patch below relative to this commit shows how I'd do it:

I have a simplification in mind that gets rid of the awkward 'first'
parameter.  In filemap_get_pages(), do:

                if ((iocb->ki_flags & IOCB_WAITQ) && (pagevec_count(pvec) > 1))
                        iocb->ki_flags |= IOCB_NOWAIT;

before calling filemap_update_page().  That matches what Kent did in
filemap_read():

                if ((iocb->ki_flags & IOCB_WAITQ) && already_read)
                        iocb->ki_flags |= IOCB_NOWAIT;

> diff --git a/mm/filemap.c b/mm/filemap.c
> index 81b569d818a3f8..304180c022d38a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2266,40 +2266,39 @@ static int filemap_update_page(struct kiocb *iocb,
>  	if (!trylock_page(page)) {
>  		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO))
>  			goto error;
> -		if (iocb->ki_flags & IOCB_WAITQ) {
> -			if (!first)
> -				goto error;
> -			error = __lock_page_async(page, iocb->ki_waitq);
> -			if (error)
> -				goto error;
> -		} else {
> +		if (!(iocb->ki_flags & IOCB_WAITQ)) {
>  			put_and_wait_on_page_locked(page, TASK_KILLABLE);
>  			return AOP_TRUNCATED_PAGE;
>  		}
> +		if (!first)
> +			goto error;
> +		error = __lock_page_async(page, iocb->ki_waitq);
> +		if (error)
> +			goto error;
>  	}

I see where you're going there.  OK.

>  
> +	error = AOP_TRUNCATED_PAGE;
>  	if (!page->mapping)
> -		goto truncated;
> -	if (filemap_range_uptodate(iocb, mapping, iter, page)) {
> -		unlock_page(page);
> -		return 0;
> -	}
> +		goto error_unlock_page;
>  
> -	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
> -		unlock_page(page);
> +	if (!filemap_range_uptodate(iocb, mapping, iter, page)) {
>  		error = -EAGAIN;
> -	} else {
> +		if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
> +			goto error_unlock_page;
>  		error = filemap_read_page(iocb->ki_filp, mapping, page);
> -		if (!error)
> -			return 0;
> +		if (error)
> +			goto error;
> +		return 0; /* filemap_read_page unlocks the page */
>  	}
> +
> +	unlock_page(page);
> +	return 0;
> +
> +error_unlock_page:
> +	unlock_page(page);
>  error:
>  	put_page(page);
>  	return error;
> -truncated:
> -	unlock_page(page);
> -	put_page(page);
> -	return AOP_TRUNCATED_PAGE;
>  }

There's something niggling at me about this change ... I'll play with
it a bit.
