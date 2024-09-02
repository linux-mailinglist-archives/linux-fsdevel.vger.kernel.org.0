Return-Path: <linux-fsdevel+bounces-28255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459BD968950
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 16:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F991C2220B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 14:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB8D20FAAE;
	Mon,  2 Sep 2024 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h9/XHUsY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BC619E992;
	Mon,  2 Sep 2024 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725285648; cv=none; b=Q/at3ZkvB7LzxhR4a542bA906Eu8f8Du6N+AqssvyzPxc1cRki3mW5BQ9Xh72gicTNFnoOn1140O3FYzz5AjGzYfppr9pTQFieI0ZTckDjD6jYHLyY7otWi+nAI2MzgVWPa4jPNi0U0V7TCn91GUJTRbYwlHONp9Kvuz64bmVlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725285648; c=relaxed/simple;
	bh=0DmRN+x+rS94Y6TZe4li1VN1uvfOWEAXxh47QMvD3gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrnQnKhc9fTl8GRZlwRoRTDMvGR3uxa68Z/LUp5sn/wDMt0XK6U+ZqxjJIkMM7I3WPeSGC5PMnjXvzS9+9RkbywnU3d2n3uO5NnV+InnmFaoutofzM+X1TjO8ahUDUoX5oz5hmD5umbw2zBv3B8jinSnrGayslchs8PU9PODPvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h9/XHUsY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ouh8tM//YMSBky/0ZxoaC8YVq42vhgoGIwSy22S0uUw=; b=h9/XHUsYJaehUfGRgfew/jDW0b
	2LNLJU83qD602ukWkhBc9hSSLO2C4Ayreo73Jsm1zHn00Iwpu5PI2UZmNFyWfcjnZ0xR36/g2Z0xn
	nGDl0UlGNNSzQQBuO/mdSJ0HAoZar1BHjCbsdurqiyb4ar3GYfOvXdL40/LiV/NTrxGDAQN3cHCG8
	xZwwJThSYp6kEDrflLMInB6U3FrkaOdKiKEi4OHIOR97Riv1pa8AnvLe2Wo2rVeFYCSYxAW94YjIi
	8fc8ZCBpjZQkF6Lg2yZXCQz97RUF0nvXoBNLTu4azGdIKfDC7wpVucKA5BVUUomv45Sj5hFhnmPxV
	r4PEN4iQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sl7bh-00000006jAw-1GcP;
	Mon, 02 Sep 2024 14:00:37 +0000
Date: Mon, 2 Sep 2024 15:00:37 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: brauner@kernel.org, sfr@canb.auug.org.au, akpm@linux-foundation.org,
	linux-next@vger.kernel.org, mcgrof@kernel.org, ziy@nvidia.com,
	da.gomez@samsung.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Pankaj Raghav <p.raghav@samsung.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] mm: don't convert the page to folio before splitting in
 split_huge_page()
Message-ID: <ZtXFBTgLz3YFHk9T@casper.infradead.org>
References: <20240902124931.506061-2-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902124931.506061-2-kernel@pankajraghav.com>

On Mon, Sep 02, 2024 at 02:49:32PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Sven reported that a commit from bs > ps series was breaking the ksm ltp
> test[1].
> 
> split_huge_page() takes precisely a page that is locked, and it also
> expects the folio that contains that page to be locked after that
> huge page has been split. The changes introduced converted the page to
> folio, and passed the head page to be split, which might not be locked,
> resulting in a kernel panic.
> 
> This commit fixes it by always passing the correct page to be split from
> split_huge_page() with the appropriate minimum order for splitting.

This should be folded into the patch that is broken, not be a separate
fix commit, otherwise it introduces a bisection hazard which are to be
avoided when possible.

> [1] https://lore.kernel.org/linux-xfs/yt9dttf3r49e.fsf@linux.ibm.com/
> Reported-by: Sven Schnelle <svens@linux.ibm.com>
> Fixes: fd031210c9ce ("mm: split a folio in minimum folio order chunks")
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> This applies to the vfs.blocksize branch on the vfs tree.
> 
> @Christian, Stephen already sent a mail saying that there is a conflict
> with these changes and mm-unstable. For now, I have based these patches
> out of your tree. Let me know if you need the same patch based on
> linux-next.
> 
>  include/linux/huge_mm.h | 16 +++++++++++++++-
>  mm/huge_memory.c        | 21 +++++++++++++--------
>  2 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 7c50aeed0522..7a570e0437c9 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -319,10 +319,24 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
>  bool can_split_folio(struct folio *folio, int *pextra_pins);
>  int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  		unsigned int new_order);
> +int min_order_for_split(struct folio *folio);
>  int split_folio_to_list(struct folio *folio, struct list_head *list);
>  static inline int split_huge_page(struct page *page)
>  {
> -	return split_folio(page_folio(page));
> +	struct folio *folio = page_folio(page);
> +	int ret = min_order_for_split(folio);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * split_huge_page() locks the page before splitting and
> +	 * expects the same page that has been split to be locked when
> +	 * returned. split_folio(page_folio(page)) cannot be used here
> +	 * because it converts the page to folio and passes the head
> +	 * page to be split.
> +	 */
> +	return split_huge_page_to_list_to_order(page, NULL, ret);
>  }
>  void deferred_split_folio(struct folio *folio);
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c29af9451d92..9931ff1d9a9d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3297,12 +3297,10 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  	return ret;
>  }
>  
> -int split_folio_to_list(struct folio *folio, struct list_head *list)
> +int min_order_for_split(struct folio *folio)
>  {
> -	unsigned int min_order = 0;
> -
>  	if (folio_test_anon(folio))
> -		goto out;
> +		return 0;
>  
>  	if (!folio->mapping) {
>  		if (folio_test_pmd_mappable(folio))
> @@ -3310,10 +3308,17 @@ int split_folio_to_list(struct folio *folio, struct list_head *list)
>  		return -EBUSY;
>  	}
>  
> -	min_order = mapping_min_folio_order(folio->mapping);
> -out:
> -	return split_huge_page_to_list_to_order(&folio->page, list,
> -							min_order);
> +	return mapping_min_folio_order(folio->mapping);
> +}
> +
> +int split_folio_to_list(struct folio *folio, struct list_head *list)
> +{
> +	int ret = min_order_for_split(folio);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return split_huge_page_to_list_to_order(&folio->page, list, ret);
>  }
>  
>  void __folio_undo_large_rmappable(struct folio *folio)
> -- 
> 2.44.1
> 
> 

