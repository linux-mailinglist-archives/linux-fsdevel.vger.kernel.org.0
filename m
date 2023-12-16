Return-Path: <linux-fsdevel+bounces-6308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0488157FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 07:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F9B1F23F2C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 06:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE4812E4D;
	Sat, 16 Dec 2023 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hac5i32D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC7D10A00;
	Sat, 16 Dec 2023 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xiSK1F35rHpZWUgm/bdMTInxhSrYy62fl78Ydp6QZJA=; b=hac5i32DsaZHjY4GwPrQjsdIKT
	NpajQ6R5JGxdujxDuV2HHY9RJ4dZouscdlYMNOGTkU6nXy155cXbBlx9B0M+DTkFD9obr33BGI487
	36Z5RLoKqqj8dfFxZ7Wo8OuKhPxnLYnXe4bq65B1A+WGCwYGbUZ6ACTCK5FHPVFEKJzsryFnVDbfz
	EpiaraTo2japVRpvFPLRo+87JIFHgRSQuy8lkjpUDaMy2pc8UsfVm6qsr7YbncFbJljvnE+D/Knw9
	X5+TYuqomBpamoZ8w/Wthequ7PWyfVnn5+JjZWegFp0pst7J2yWGubbXVsvISF9wTZwJ5X2d5JlSV
	QfVW2amg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rENyM-007bj0-ID; Sat, 16 Dec 2023 06:16:26 +0000
Date: Sat, 16 Dec 2023 06:16:26 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 04/11] writeback: Simplify the loops in
 write_cache_pages()
Message-ID: <ZX1AugplMA2BWnaG@casper.infradead.org>
References: <20231214132544.376574-1-hch@lst.de>
 <20231214132544.376574-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214132544.376574-5-hch@lst.de>

On Thu, Dec 14, 2023 at 02:25:37PM +0100, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Collapse the two nested loops into one.  This is needed as a step
> towards turning this into an iterator.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/page-writeback.c | 98 ++++++++++++++++++++++-----------------------
>  1 file changed, 49 insertions(+), 49 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 5a3df8665ff4f9..2087d16115710e 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2460,6 +2460,7 @@ int write_cache_pages(struct address_space *mapping,
>  		      void *data)
>  {
>  	int error;
> +	int i = 0;
>  
>  	if (wbc->range_cyclic) {
>  		wbc->index = mapping->writeback_index; /* prev offset */
> @@ -2477,67 +2478,66 @@ int write_cache_pages(struct address_space *mapping,
>  	folio_batch_init(&wbc->fbatch);
>  	wbc->err = 0;
>  
> -	while (wbc->index <= wbc->end) {
> -		int i;
> -
> -		writeback_get_batch(mapping, wbc);
> +	for (;;) {
> +		struct folio *folio;
> +		unsigned long nr;
>  
> +		if (i == wbc->fbatch.nr) {
> +			writeback_get_batch(mapping, wbc);
> +			i = 0;
> +		}
>  		if (wbc->fbatch.nr == 0)
>  			break;
>  
> -		for (i = 0; i < wbc->fbatch.nr; i++) {
> -			struct folio *folio = wbc->fbatch.folios[i];
> -			unsigned long nr;
> +		folio = wbc->fbatch.folios[i++];
>  
> -			wbc->done_index = folio->index;
> +		wbc->done_index = folio->index;
>  
> -			folio_lock(folio);
> -			if (!should_writeback_folio(mapping, wbc, folio)) {
> -				folio_unlock(folio);
> -				continue;
> -			}
> +		folio_lock(folio);
> +		if (!should_writeback_folio(mapping, wbc, folio)) {
> +			folio_unlock(folio);
> +			continue;
> +		}
>  
> -			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
> -
> -			error = writepage(folio, wbc, data);
> -			nr = folio_nr_pages(folio);
> -			if (unlikely(error)) {
> -				/*
> -				 * Handle errors according to the type of
> -				 * writeback. There's no need to continue for
> -				 * background writeback. Just push done_index
> -				 * past this page so media errors won't choke
> -				 * writeout for the entire file. For integrity
> -				 * writeback, we must process the entire dirty
> -				 * set regardless of errors because the fs may
> -				 * still have state to clear for each page. In
> -				 * that case we continue processing and return
> -				 * the first error.
> -				 */
> -				if (error == AOP_WRITEPAGE_ACTIVATE) {
> -					folio_unlock(folio);
> -					error = 0;
> -				} else if (wbc->sync_mode != WB_SYNC_ALL) {
> -					wbc->err = error;
> -					wbc->done_index = folio->index + nr;
> -					return writeback_finish(mapping,
> -							wbc, true);
> -				}
> -				if (!wbc->err)
> -					wbc->err = error;
> -			}
> +		trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
>  
> +		error = writepage(folio, wbc, data);
> +		nr = folio_nr_pages(folio);
> +		if (unlikely(error)) {
>  			/*
> -			 * We stop writing back only if we are not doing
> -			 * integrity sync. In case of integrity sync we have to
> -			 * keep going until we have written all the pages
> -			 * we tagged for writeback prior to entering this loop.
> +			 * Handle errors according to the type of
> +			 * writeback. There's no need to continue for
> +			 * background writeback. Just push done_index
> +			 * past this page so media errors won't choke
> +			 * writeout for the entire file. For integrity
> +			 * writeback, we must process the entire dirty
> +			 * set regardless of errors because the fs may
> +			 * still have state to clear for each page. In
> +			 * that case we continue processing and return
> +			 * the first error.
>  			 */
> -			wbc->nr_to_write -= nr;
> -			if (wbc->nr_to_write <= 0 &&
> -			    wbc->sync_mode == WB_SYNC_NONE)
> +			if (error == AOP_WRITEPAGE_ACTIVATE) {
> +				folio_unlock(folio);
> +				error = 0;
> +			} else if (wbc->sync_mode != WB_SYNC_ALL) {
> +				wbc->err = error;
> +				wbc->done_index = folio->index + nr;
>  				return writeback_finish(mapping, wbc, true);
> +			}
> +			if (!wbc->err)
> +				wbc->err = error;
>  		}
> +
> +		/*
> +		 * We stop writing back only if we are not doing
> +		 * integrity sync. In case of integrity sync we have to
> +		 * keep going until we have written all the pages
> +		 * we tagged for writeback prior to entering this loop.
> +		 */
> +		wbc->nr_to_write -= nr;
> +		if (wbc->nr_to_write <= 0 &&
> +		    wbc->sync_mode == WB_SYNC_NONE)
> +			return writeback_finish(mapping, wbc, true);
>  	}
>  
>  	return writeback_finish(mapping, wbc, false);
> -- 
> 2.39.2
> 

