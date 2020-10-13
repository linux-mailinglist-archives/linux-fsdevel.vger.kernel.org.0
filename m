Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CE928CF2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 15:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgJMNcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 09:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgJMNcl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:32:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70455C0613D0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2020 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uOHm79/rH5AghZZv6fFVvDRR7Z97nPls7l2vvypvxbo=; b=M/xGM6+eaifMuX2jaD5x+LNQ19
        c1tIkYblWhcx1wBIw1JqeHz6nuBanv7FREBTWJC5RfMflaZS1QUdntSOrdDDCqyrTZkwb1TwOMD49
        FUjniPyzMv5oNP9NckK6drjqyQi/Wq8epxsNshMV1jyS1CDR3dDcQJp4wgmfc6jeLOKViAi957Hvf
        9PA7BkCvINAktUqD9w9YNHP6k6faprJIg3MfKKt9TJZUWvlJUqmbsbHD9joxCEWsHMqBRKq4Q+k1P
        t/Xj7uuIAKCSOo0GVVOPQFoa8tgr/02Q1qodgpNQ36CeV3C5ORWAXKlzXtjNRYLQ86IxX3wSwjUv9
        hFK2Wn5g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSKPv-0001n6-Lo; Tue, 13 Oct 2020 13:32:39 +0000
Date:   Tue, 13 Oct 2020 14:32:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm: Don't hold a page reference while waiting for
 unlock
Message-ID: <20201013133239.GH20115@casper.infradead.org>
References: <20201013030008.27219-1-willy@infradead.org>
 <20201013030008.27219-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013030008.27219-3-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


This patch was inadvertently included.  I blame my tools.  The actual
patch 2/3 is the other one.

On Tue, Oct 13, 2020 at 04:00:06AM +0100, Matthew Wilcox (Oracle) wrote:
> In the upcoming THP patch series, if we find a !Uptodate page, it
> is because of a read error.  In this case, we want to split the THP
> into smaller pages so we can handle the error in as granular a fashion
> as possible.  But xfstests generic/273 defeats this strategy by having
> 500 threads all sleeping on the same page, each waiting for their turn
> to split the page.  None of them will ever succeed because splitting a
> page requires that you hold the only reference to it.
> 
> To fix this, use put_and_wait_on_page_locked() to sleep without holding
> a reference.  Each of the readers will then go back and retry the
> page lookup.
> 
> This requires a few changes since we now get the page lock a little
> earlier in generic_file_buffered_read().  This is unlikely to affect any
> normal workloads as pages in the page cache are generally uptodate and
> will not hit this path.  With the THP patch set and the readahead error
> injector, I see about a 25% performance improvement with this patch over
> an alternate approach which moves the page locking down.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/filemap.c | 51 ++++++++++++++-------------------------------------
>  1 file changed, 14 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index f70227941627..9916353f0f0d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1254,14 +1254,6 @@ static int __wait_on_page_locked_async(struct page *page,
>  	return ret;
>  }
>  
> -static int wait_on_page_locked_async(struct page *page,
> -				     struct wait_page_queue *wait)
> -{
> -	if (!PageLocked(page))
> -		return 0;
> -	return __wait_on_page_locked_async(compound_head(page), wait, false);
> -}
> -
>  /**
>   * put_and_wait_on_page_locked - Drop a reference and wait for it to be unlocked
>   * @page: The page to wait for.
> @@ -2128,19 +2120,21 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  					put_page(page);
>  					goto out;
>  				}
> -				error = wait_on_page_locked_async(page,
> -								iocb->ki_waitq);
> +				error = lock_page_async(page, iocb->ki_waitq);
> +				if (error)
> +					goto readpage_error;
> +			} else if (iocb->ki_flags & IOCB_NOWAIT) {
> +				put_page(page);
> +				goto would_block;
>  			} else {
> -				if (iocb->ki_flags & IOCB_NOWAIT) {
> -					put_page(page);
> -					goto would_block;
> +				if (!trylock_page(page)) {
> +					put_and_wait_on_page_locked(page,
> +							TASK_KILLABLE);
> +					goto find_page;
>  				}
> -				error = wait_on_page_locked_killable(page);
>  			}
> -			if (unlikely(error))
> -				goto readpage_error;
>  			if (PageUptodate(page))
> -				goto page_ok;
> +				goto uptodate;
>  
>  			if (inode->i_blkbits == PAGE_SHIFT ||
>  					!mapping->a_ops->is_partially_uptodate)
> @@ -2148,14 +2142,13 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  			/* pipes can't handle partially uptodate pages */
>  			if (unlikely(iov_iter_is_pipe(iter)))
>  				goto page_not_up_to_date;
> -			if (!trylock_page(page))
> -				goto page_not_up_to_date;
>  			/* Did it get truncated before we got the lock? */
>  			if (!page->mapping)
> -				goto page_not_up_to_date_locked;
> +				goto page_not_up_to_date;
>  			if (!mapping->a_ops->is_partially_uptodate(page,
>  							offset, iter->count))
> -				goto page_not_up_to_date_locked;
> +				goto page_not_up_to_date;
> +uptodate:
>  			unlock_page(page);
>  		}
>  page_ok:
> @@ -2223,28 +2216,12 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  		continue;
>  
>  page_not_up_to_date:
> -		/* Get exclusive access to the page ... */
> -		if (iocb->ki_flags & IOCB_WAITQ)
> -			error = lock_page_async(page, iocb->ki_waitq);
> -		else
> -			error = lock_page_killable(page);
> -		if (unlikely(error))
> -			goto readpage_error;
> -
> -page_not_up_to_date_locked:
>  		/* Did it get truncated before we got the lock? */
>  		if (!page->mapping) {
>  			unlock_page(page);
>  			put_page(page);
>  			continue;
>  		}
> -
> -		/* Did somebody else fill it already? */
> -		if (PageUptodate(page)) {
> -			unlock_page(page);
> -			goto page_ok;
> -		}
> -
>  readpage:
>  		if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT)) {
>  			unlock_page(page);
> -- 
> 2.28.0
> 
