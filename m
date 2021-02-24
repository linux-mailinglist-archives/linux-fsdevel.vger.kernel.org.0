Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E132431F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 18:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhBXRXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 12:23:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:49604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhBXRXd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 12:23:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B3F4AEE7;
        Wed, 24 Feb 2021 17:22:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5D74F1E14EE; Wed, 24 Feb 2021 18:22:50 +0100 (CET)
Date:   Wed, 24 Feb 2021 18:22:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 1/3] mm: provide filemap_range_needs_writeback() helper
Message-ID: <20210224172250.GD849@quack2.suse.cz>
References: <20210224164455.1096727-1-axboe@kernel.dk>
 <20210224164455.1096727-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224164455.1096727-2-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 24-02-21 09:44:53, Jens Axboe wrote:
> For O_DIRECT reads/writes, we check if we need to issue a call to
> filemap_write_and_wait_range() to issue and/or wait for writeback for any
> page in the given range. The existing mechanism just checks for a page in
> the range, which is suboptimal for IOCB_NOWAIT as we'll fallback to the
> slow path (and needing retry) if there's just a clean page cache page in
> the range.
> 
> Provide filemap_range_needs_writeback() which tries a little harder to
> check if we actually need to issue and/or wait for writeback in the
> range.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h |  2 ++
>  mm/filemap.c       | 43 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 6d8b1e7337e4..4925275e6365 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2633,6 +2633,8 @@ static inline int filemap_fdatawait(struct address_space *mapping)
>  
>  extern bool filemap_range_has_page(struct address_space *, loff_t lstart,
>  				  loff_t lend);
> +extern bool filemap_range_needs_writeback(struct address_space *,
> +					  loff_t lstart, loff_t lend);
>  extern int filemap_write_and_wait_range(struct address_space *mapping,
>  				        loff_t lstart, loff_t lend);
>  extern int __filemap_fdatawrite_range(struct address_space *mapping,
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6ff2a3fb0dc7..13338f877677 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -635,6 +635,49 @@ static bool mapping_needs_writeback(struct address_space *mapping)
>  	return mapping->nrpages;
>  }
>  
> +/**
> + * filemap_range_needs_writeback - check if range potentially needs writeback
> + * @mapping:           address space within which to check
> + * @start_byte:        offset in bytes where the range starts
> + * @end_byte:          offset in bytes where the range ends (inclusive)
> + *
> + * Find at least one page in the range supplied, usually used to check if
> + * direct writing in this range will trigger a writeback. Used by O_DIRECT
> + * read/write with IOCB_NOWAIT, to see if the caller needs to do
> + * filemap_write_and_wait_range() before proceeding.
> + *
> + * Return: %true if the caller should do filemap_write_and_wait_range() before
> + * doing O_DIRECT to a page in this range, %false otherwise.
> + */
> +bool filemap_range_needs_writeback(struct address_space *mapping,
> +				   loff_t start_byte, loff_t end_byte)
> +{
> +	XA_STATE(xas, &mapping->i_pages, start_byte >> PAGE_SHIFT);
> +	pgoff_t max = end_byte >> PAGE_SHIFT;
> +	struct page *page;
> +
> +	if (!mapping_needs_writeback(mapping))
> +		return false;
> +	if (!mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) &&
> +	    !mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> +		return false;
> +	if (end_byte < start_byte)
> +		return false;
> +
> +	rcu_read_lock();
> +	xas_for_each(&xas, page, max) {
> +		if (xas_retry(&xas, page))
> +			continue;
> +		if (xa_is_value(page))
> +			continue;
> +		if (PageDirty(page) || PageLocked(page) || PageWriteback(page))
> +			break;
> +	}
> +	rcu_read_unlock();
> +	return page != NULL;
> +}
> +EXPORT_SYMBOL_GPL(filemap_range_needs_writeback);
> +
>  /**
>   * filemap_write_and_wait_range - write out & wait on a file range
>   * @mapping:	the address_space for the pages
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
