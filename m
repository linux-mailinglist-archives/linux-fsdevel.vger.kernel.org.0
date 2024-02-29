Return-Path: <linux-fsdevel+bounces-13194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A38086CD4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 16:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A5A286D47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 15:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE1814A0B8;
	Thu, 29 Feb 2024 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="yrMVoKsg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE351468F6
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221407; cv=none; b=P4xi+oHgeC6G68o+/9GebFuLyspyT5dP/PwGs41uA7ID3J+Gfl2ukbT7Xr53wXHKvQJm0tQ3Mb/Ni+3e5qbl5+bQyETi14RTrNjWyFSPv+QXu6nnYOBNH6krxTxrs6eavj8MGODUtzaEt3mqSAtfGzZNyruITmasjl4Q0ulobVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221407; c=relaxed/simple;
	bh=alYWuRaQtoNIeLNKiPRndKJKCIYT8Jjg4qzCaC9e7Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h12FYhXML6dn9jaYzT3moAQrbpDu/5Jc29uzu3MaU7aqW1gjuEMVPmUcrAkToL8HrXzq3+wjwzC2OoS8NpPY9DTtcP97pQSFWlQctuFj37WOMI0ZzkKiph9p/eUKqC//Oo4fNu3NEgij4EqkpLFBmJnCXlrUb0pImupdKJpkokM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=yrMVoKsg; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TlwVC1QM7z9t6P;
	Thu, 29 Feb 2024 16:43:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709221395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhY5acBq23AQHjFzA7rJoEyE+uhuCPJWo/OtOJ63pUc=;
	b=yrMVoKsgLYtqPC0noCEFYpxcI4eYNL4RvpPE3EHHe1IZgGc77DfD9W3GJ2ZFzmZvcdx6bq
	EXIqpyUnv5jtqSB/cimAy3VXhxnxbWqd1a/sLukESkUQoy8tIuYYAve+SP0qr3A9d5fGBT
	+9fq3/Bi5sk8ptYXjOxLJZ74FyiA79OdM++m+S8IMAXRiAAdrEYHjz1PAONBcJiFKhFbWQ
	xsp8yK/QMaySSZpjTbxGAu9Un9TGYuthHaaewASPZHAQWUoNM62KlLbZYatGQcYicULHSc
	GmyS8eb6BMP1OpBIVqQiXr1SroVkPZPRAgI4D9q9nM3sDAx33dVa+yBa5t8OtA==
Date: Thu, 29 Feb 2024 16:43:13 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	p.raghav@samsung.com
Subject: Re: [PATCH 1/1] mm: Convert pagecache_isize_extended to use a folio
Message-ID: <vvgprzxyghgd5jf433wsnnz2f2aha6ophr5qhmxpru6ea6nscb@imnx6l7hn2bh>
References: <20240228182230.1401088-1-willy@infradead.org>
 <20240228182230.1401088-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228182230.1401088-2-willy@infradead.org>
X-Rspamd-Queue-Id: 4TlwVC1QM7z9t6P

On Wed, Feb 28, 2024 at 06:22:28PM +0000, Matthew Wilcox (Oracle) wrote:
> Remove four hidden calls to compound_head().  Also exit early if the
> filesystem block size is >= PAGE_SIZE instead of just equal to PAGE_SIZE.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Look good to me.
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

> ---
>  mm/truncate.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 725b150e47ac..25776e1915b8 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -781,31 +781,29 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
>  {
>  	int bsize = i_blocksize(inode);
>  	loff_t rounded_from;
> -	struct page *page;
> -	pgoff_t index;
> +	struct folio *folio;
>  
>  	WARN_ON(to > inode->i_size);
>  
> -	if (from >= to || bsize == PAGE_SIZE)
> +	if (from >= to || bsize >= PAGE_SIZE)
>  		return;
>  	/* Page straddling @from will not have any hole block created? */
>  	rounded_from = round_up(from, bsize);
>  	if (to <= rounded_from || !(rounded_from & (PAGE_SIZE - 1)))
>  		return;
>  
> -	index = from >> PAGE_SHIFT;
> -	page = find_lock_page(inode->i_mapping, index);
> -	/* Page not cached? Nothing to do */
> -	if (!page)
> +	folio = filemap_lock_folio(inode->i_mapping, from / PAGE_SIZE);
> +	/* Folio not cached? Nothing to do */
> +	if (IS_ERR(folio))
>  		return;
>  	/*
> -	 * See clear_page_dirty_for_io() for details why set_page_dirty()
> +	 * See folio_clear_dirty_for_io() for details why folio_mark_dirty()
>  	 * is needed.
>  	 */
> -	if (page_mkclean(page))
> -		set_page_dirty(page);
> -	unlock_page(page);
> -	put_page(page);
> +	if (folio_mkclean(folio))
> +		folio_mark_dirty(folio);
> +	folio_unlock(folio);
> +	folio_put(folio);
>  }
>  EXPORT_SYMBOL(pagecache_isize_extended);
>  
> -- 
> 2.43.0
> 

