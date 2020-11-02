Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFA42A337F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 20:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgKBTAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 14:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKBTAN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:00:13 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E16C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 11:00:11 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id r7so12484370qkf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 11:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XWZf9/UhYv4G6VmJ+Bk1hbFhCA//zACfvngw3x+8vNE=;
        b=R897Ejv8j/1FGKjM+qZ0XYnRPDaOt8eV1hOuSnVGbHFG/AVOgUIv6HeWQDiXX0Vo7n
         +CNJUJO1wVs2jxmHkm/ZAx33xxC7VXYIrAsDjQXnnbcEfMX4yuIVcu6/MwAeK2bWr1KD
         bwjkfBFICjGe5MeyHEKXc1Sa7F1xECCMRkwMPc83jvpZEAc/9IiqtEphuLHiLUIUURXW
         Y7XthOPVYLATfICY6nzp3UMu0j/EgJf9Y6ISj30EXY6B96Pld2AbHeTjmW1p0Da4gJTs
         VGDHKP2btlBWp/wCMl83S7cLbpqMHQhmBvcCF5HJouQcdf/MiHvNh8vbhrUP/+0FkhQY
         riew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XWZf9/UhYv4G6VmJ+Bk1hbFhCA//zACfvngw3x+8vNE=;
        b=gsene6d+U75cPtwARpZiiM+u1JayY6jX4ZBV8mP+B5m22DR0TU6IVLo/hlh+WKlD2v
         gGIDSzzrzSLLGc3Z2NnZ2lRxKjBQQTGsPmP7yD4QWIFwL9i708KdCa9TH40ArZRfvZhV
         ezQfeKLGSHGJJ5tDcmIzYByuRf3L+MrSNTMXwrVAAdlXjQGZcoQ6Vkp1mPEk1xIM+JNY
         l89f/jzcQJIIdTb+6YYqnht76ZdEOCFWb7PfQ6QC3OjKcXuA4lhi0Ewcj9CT5j9WrYjH
         TEjBIm0I5LMjdPMxacy0rRfNQz/wJZSnOCNpuF8O3td4uiRJHqZqFATqMZSodVleISby
         UDDA==
X-Gm-Message-State: AOAM5321dVLeVLfbtCB2Asqm0HnFK6xNJuRgB7UsutcsNeNbujtUKiYQ
        /LgFvO+4h5l4q4G9eDhR3w==
X-Google-Smtp-Source: ABdhPJyEDnrCikgCG/5pzbAWtxIK0kZDt3RfBnOHMMENws2kdD0Z7dEGfSow7iEjpJF959gJ511Dtw==
X-Received: by 2002:a05:620a:16b6:: with SMTP id s22mr15552936qkj.422.1604343611079;
        Mon, 02 Nov 2020 11:00:11 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id p5sm8703768qtu.13.2020.11.02.11.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:00:10 -0800 (PST)
Date:   Mon, 2 Nov 2020 14:00:08 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 04/17] mm/filemap: Support readpage splitting a page
Message-ID: <20201102190008.GG2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-5-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:42:59PM +0000, Matthew Wilcox (Oracle) wrote:
> For page splitting to succeed, the thread asking to split the
> page has to be the only one with a reference to the page.  Calling
> wait_on_page_locked() while holding a reference to the page will
> effectively prevent this from happening with sufficient threads waiting
> on the same page.  Use put_and_wait_on_page_locked() to sleep without
> holding a reference to the page, then retry the page lookup after the
> page is unlocked.
> 
> Since we now get the page lock a little earlier in filemap_update_page(),
> we can eliminate a number of duplicate checks.  The original intent
> (commit ebded02788b5 ("avoid unnecessary calls to lock_page when waiting
> for IO to complete during a read")) behind getting the page lock later
> was to avoid re-locking the page after it has been brought uptodate by
> another thread.  We still avoid that because we go through the normal
> lookup path again after the winning thread has brought the page uptodate.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/filemap.c | 76 ++++++++++++++++------------------------------------
>  1 file changed, 23 insertions(+), 53 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 709774a60379..550e023abb52 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1347,14 +1347,6 @@ static int __wait_on_page_locked_async(struct page *page,
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
> @@ -2281,64 +2273,42 @@ static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
>  	struct inode *inode = mapping->host;
>  	int error;
>  
> -	/*
> -	 * See comment in do_read_cache_page on why
> -	 * wait_on_page_locked is used to avoid unnecessarily
> -	 * serialisations and why it's safe.
> -	 */
>  	if (iocb->ki_flags & IOCB_WAITQ) {
> -		error = wait_on_page_locked_async(page,
> -						iocb->ki_waitq);
> +		error = lock_page_async(page, iocb->ki_waitq);
> +		if (error) {
> +			put_page(page);
> +			return ERR_PTR(error);
> +		}
>  	} else {
> -		error = wait_on_page_locked_killable(page);
> -	}
> -	if (unlikely(error)) {
> -		put_page(page);
> -		return ERR_PTR(error);
> +		if (!trylock_page(page)) {
> +			put_and_wait_on_page_locked(page, TASK_KILLABLE);
> +			return NULL;
> +		}
>  	}
> -	if (PageUptodate(page))
> -		return page;
>  
> +	if (!page->mapping)
> +		goto truncated;

Since we're dropping our ref to the page, it could potentially be truncated and
then reused, no? So we should be checking page->mapping == mapping &&
page->index == index (and stashing page->index before dropping our ref, or
passing it in).

> +	if (PageUptodate(page))
> +		goto uptodate;
>  	if (inode->i_blkbits == PAGE_SHIFT ||
>  			!mapping->a_ops->is_partially_uptodate)
> -		goto page_not_up_to_date;
> +		goto readpage;
>  	/* pipes can't handle partially uptodate pages */
>  	if (unlikely(iov_iter_is_pipe(iter)))
> -		goto page_not_up_to_date;
> -	if (!trylock_page(page))
> -		goto page_not_up_to_date;
> -	/* Did it get truncated before we got the lock? */
> -	if (!page->mapping)
> -		goto page_not_up_to_date_locked;
> +		goto readpage;
>  	if (!mapping->a_ops->is_partially_uptodate(page,
> -				pos & ~PAGE_MASK, count))
> -		goto page_not_up_to_date_locked;
> +				pos & (thp_size(page) - 1), count))
> +		goto readpage;
> +uptodate:
>  	unlock_page(page);
>  	return page;
>  
> -page_not_up_to_date:
> -	/* Get exclusive access to the page ... */
> -	error = lock_page_for_iocb(iocb, page);
> -	if (unlikely(error)) {
> -		put_page(page);
> -		return ERR_PTR(error);
> -	}
> -
> -page_not_up_to_date_locked:
> -	/* Did it get truncated before we got the lock? */
> -	if (!page->mapping) {
> -		unlock_page(page);
> -		put_page(page);
> -		return NULL;
> -	}
> -
> -	/* Did somebody else fill it already? */
> -	if (PageUptodate(page)) {
> -		unlock_page(page);
> -		return page;
> -	}
> -
> +readpage:
>  	return filemap_read_page(iocb, filp, mapping, page);
> +truncated:
> +	unlock_page(page);
> +	put_page(page);
> +	return NULL;
>  }
>  
>  static struct page *filemap_create_page(struct kiocb *iocb,
> -- 
> 2.28.0
> 
