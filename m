Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FCE2A9113
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 09:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgKFIOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 03:14:24 -0500
Received: from verein.lst.de ([213.95.11.211]:50564 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgKFIOY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:14:24 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 46A1D68B05; Fri,  6 Nov 2020 09:14:21 +0100 (CET)
Date:   Fri, 6 Nov 2020 09:14:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v2 11/18] mm/filemap: Convert filemap_update_page to
 return an errno
Message-ID: <20201106081420.GF31585@lst.de>
References: <20201104204219.23810-1-willy@infradead.org> <20201104204219.23810-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104204219.23810-12-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 04, 2020 at 08:42:12PM +0000, Matthew Wilcox (Oracle) wrote:
> Use AOP_TRUNCATED_PAGE to indicate that no error occurred, but the
> page we looked up is no longer valid.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  mm/filemap.c | 42 +++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 25945fefdd39..93c054f51677 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2231,24 +2231,21 @@ static int filemap_read_page(struct file *file, struct address_space *mapping,
>  	return error;
>  }
>  
> +static int filemap_update_page(struct kiocb *iocb,
> +		struct address_space *mapping, struct iov_iter *iter,
> +		struct page *page, loff_t pos, loff_t count)
>  {
>  	struct inode *inode = mapping->host;
>  	int error;
>  
>  	if (iocb->ki_flags & IOCB_WAITQ) {
>  		error = lock_page_async(page, iocb->ki_waitq);
> +		if (error)
> +			goto error;
>  	} else {
>  		if (!trylock_page(page)) {
>  			put_and_wait_on_page_locked(page, TASK_KILLABLE);
> +			return AOP_TRUNCATED_PAGE;
>  		}
>  	}
>  
> @@ -2267,25 +2264,24 @@ static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
>  		goto readpage;
>  uptodate:
>  	unlock_page(page);
> +	return 0;
>  
>  readpage:
>  	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
>  		unlock_page(page);
> +		error = -EAGAIN;
> +	} else {
> +		error = filemap_read_page(iocb->ki_filp, mapping, page);
> +		if (!error)
> +			return 0;
>  	}
> +error:
>  	put_page(page);
> +	return error;
>  truncated:
>  	unlock_page(page);
>  	put_page(page);
> +	return AOP_TRUNCATED_PAGE;

We could still consolidate the page unlocking by having another label.
Or even better move the put_page into the caller like I did in my
series, which would conceputally fit in pretty nicely here:

> +			err = filemap_update_page(iocb, mapping, iter, page,
>  					pg_pos, pg_count);
> +			if (err)
>  				pvec->nr--;

But otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
