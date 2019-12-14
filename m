Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8278A11EEFA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2019 01:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfLNABL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 19:01:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfLNABK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 19:01:10 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D852253D;
        Sat, 14 Dec 2019 00:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576281669;
        bh=fiwkE+WR44drUBdQZzKt9uUx9+pgPBFXL1PTAdIGWmI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rfS7lmo4sKdsU8/9O6Cdg83KzGwAvi74SCgclriejgHs616kAxKeHTgH/xGstAzCV
         98KkrRpVNNdi9kRRPDHgQMtACFTuXMeBU4Ia3GGkgwPKBq/bQROiiZL09x01pIVAvo
         8bJ/+v2g2jLxEPaBwarTE+QKyUZjkx3+9NNrkz34=
Date:   Fri, 13 Dec 2019 16:01:09 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com
Subject: Re: [PATCH 3/5] mm: make buffered writes work with RWF_UNCACHED
Message-Id: <20191213160109.6c680b680e34891a2db387a9@linux-foundation.org>
In-Reply-To: <20191210204304.12266-4-axboe@kernel.dk>
References: <20191210204304.12266-1-axboe@kernel.dk>
        <20191210204304.12266-4-axboe@kernel.dk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 10 Dec 2019 13:43:02 -0700 Jens Axboe <axboe@kernel.dk> wrote:

> If RWF_UNCACHED is set for io_uring (or pwritev2(2)), we'll drop the
> cache instantiated for buffered writes. If new pages aren't
> instantiated, we leave them alone. This provides similar semantics to
> reads with RWF_UNCACHED set.
> 

Wouid be nice to see a description of the proposed userspace API(s)
for exploiting this feature.

> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -285,6 +285,7 @@ enum positive_aop_returns {
>  #define AOP_FLAG_NOFS			0x0002 /* used by filesystem to direct
>  						* helper code (eg buffer layer)
>  						* to clear GFP_FS from alloc */
> +#define AOP_FLAG_UNCACHED		0x0004
>  
>  /*
>   * oh the beauties of C type declarations.
> @@ -3106,6 +3107,10 @@ extern ssize_t generic_file_direct_write(struct kiocb *, struct iov_iter *);
>  extern ssize_t generic_perform_write(struct file *, struct iov_iter *,
>  				     struct kiocb *);
>  
> +struct pagevec;
> +extern void write_drop_cached_pages(struct pagevec *pvec,
> +				struct address_space *mapping);
> +
>  ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
>  		rwf_t flags);
>  ssize_t vfs_iter_write(struct file *file, struct iov_iter *iter, loff_t *ppos,
> diff --git a/mm/filemap.c b/mm/filemap.c
> index fe37bd2b2630..2e36129ebe38 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3287,10 +3287,12 @@ struct page *grab_cache_page_write_begin(struct address_space *mapping,
>  					pgoff_t index, unsigned flags)
>  {
>  	struct page *page;
> -	int fgp_flags = FGP_LOCK|FGP_WRITE|FGP_CREAT;
> +	int fgp_flags = FGP_LOCK|FGP_WRITE;
>  
>  	if (flags & AOP_FLAG_NOFS)
>  		fgp_flags |= FGP_NOFS;
> +	if (!(flags & AOP_FLAG_UNCACHED))
> +		fgp_flags |= FGP_CREAT;
>  
>  	page = pagecache_get_page(mapping, index, fgp_flags,
>  			mapping_gfp_mask(mapping));
> @@ -3301,21 +3303,65 @@ struct page *grab_cache_page_write_begin(struct address_space *mapping,
>  }
>  EXPORT_SYMBOL(grab_cache_page_write_begin);
>  
> +/*
> + * Start writeback on the pages in pgs[], and then try and remove those pages
> + * from the page cached. Used with RWF_UNCACHED.
> + */
> +void write_drop_cached_pages(struct pagevec *pvec,
> +			     struct address_space *mapping)
> +{
> +	loff_t start, end;
> +	int i;
> +
> +	end = 0;
> +	start = LLONG_MAX;
> +	for (i = 0; i < pagevec_count(pvec); i++) {
> +		loff_t off = page_offset(pvec->pages[i]);
> +		if (off < start)
> +			start = off;
> +		if (off > end)
> +			end = off;
> +	}
> +
> +	__filemap_fdatawrite_range(mapping, start, end, WB_SYNC_NONE);
> +
> +	for (i = 0; i < pagevec_count(pvec); i++) {
> +		struct page *page = pvec->pages[i];
> +
> +		lock_page(page);
> +		if (page->mapping == mapping) {
> +			wait_on_page_writeback(page);
> +			if (!page_has_private(page) ||
> +			    try_to_release_page(page, 0))
> +				remove_mapping(mapping, page);
> +		}
> +		unlock_page(page);
> +	}

This is kinda invalidate_inode_pages2_range(), only much less so?  Why
doesn't this code need to do all the things which
invalidate_inode_pages2_range() does?  What happens if these pages are
mmapped, faulted in?  Not faulted in?


> +	pagevec_release(pvec);
> +}

