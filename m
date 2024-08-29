Return-Path: <linux-fsdevel+bounces-27958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ED59652AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 00:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DAD21F21056
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 22:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B17F1BAECD;
	Thu, 29 Aug 2024 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mzVS94Ox"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C79D26296;
	Thu, 29 Aug 2024 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724969522; cv=none; b=XFKFCEY1q98RxHIKauQ/66ykQcagv5NPGDguKGWR71mn8g3HJYl11dImgaC4I1g+J3pc1Jurq6IrWE2qWwrLwv0Az+sj05YnkCTyQr78e0kyuY4kOezyFuOJPDJ2B9zESvXjxVlH7bGAl2t/QH2XLvwX6B6KVdYALix7VNhL80A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724969522; c=relaxed/simple;
	bh=DevfjA9nYbUkDAc+ZWbkTJGqwYUf+3w9J196uxoOS/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jt/BOdVcTVO1cCW89SNIM4jaEmMQxz9uiSfQO9dqtHn7j1mrp4e/CMvCpdi6HTgVX/IvEDwNm+ffs5+KLgfnQJsXF8IYnW2iJns+ihxsNKFeuL1tYZEZ/iPP+rqcUaf1+uvuXJxuDOUSQ7uEIXAqj6ApYaFcVDwSxPJA/AjUZlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mzVS94Ox; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cluY4o3sKBSLScF/Teq2ofGGdYtENiSAyED2EAKIs78=; b=mzVS94Oxz0ViRqldoe5ZZiqQPQ
	vWJdXxMTCNPxNG3KtUP86F10zUufqOiR66z03/EZgspXZhYFAllr4x+fHcue1QcI604ITY0XlV9H4
	d9Mxr6S0Angqab1MH0Lvg3XximaLie9b10KWD8HGdHCiv5XSlOJxOeGHWQ956qFCbt9yYFNS6b8TT
	YeYXnuyYZaBlexuII1PKqthXKQKqKjkY4i25Hvb7BkC/tcyHYyY89M1MU1wAV2YrEqIy0mDRcmBox
	UTemC3lLeiXLuRMF59cMEfdSobjBB4hNndOFcYL5MG8A2Ze9xGvmzPBJWrS5zHYzrYwpZ0VECNqrC
	fSwVEqmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sjnMf-00000002ZPG-0LKr;
	Thu, 29 Aug 2024 22:11:37 +0000
Date: Thu, 29 Aug 2024 23:11:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: brauner@kernel.org, akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org, hare@suse.de,
	gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
	david@fromorbit.com, Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	cl@os.amperecomputing.com, p.raghav@samsung.com, mcgrof@kernel.org,
	ryan.roberts@arm.com, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v13 04/10] mm: split a folio in minimum folio order chunks
Message-ID: <ZtDyGHTSy3Bi3FkS@casper.infradead.org>
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
 <20240822135018.1931258-5-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822135018.1931258-5-kernel@pankajraghav.com>

On Thu, Aug 22, 2024 at 03:50:12PM +0200, Pankaj Raghav (Samsung) wrote:
> @@ -317,9 +319,10 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
>  bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
>  int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  		unsigned int new_order);
> +int split_folio_to_list(struct folio *folio, struct list_head *list);
>  static inline int split_huge_page(struct page *page)
>  {
> -	return split_huge_page_to_list_to_order(page, NULL, 0);
> +	return split_folio(page_folio(page));

Oh!  You can't do this!

split_huge_page() takes a precise page, NOT a folio.  That page is
locked.  When we return from split_huge_page(), the new folio which
contains the precise page is locked.

You've made it so that the caller's page's folio won't necessarily
be locked.  More testing was needed ;-P

>  }
>  void deferred_split_folio(struct folio *folio);
>  
> @@ -495,6 +498,12 @@ static inline int split_huge_page(struct page *page)
>  {
>  	return 0;
>  }
> +
> +static inline int split_folio_to_list(struct folio *folio, struct list_head *list)
> +{
> +	return 0;
> +}
> +
>  static inline void deferred_split_folio(struct folio *folio) {}
>  #define split_huge_pmd(__vma, __pmd, __address)	\
>  	do { } while (0)
> @@ -622,7 +631,4 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
>  	return split_folio_to_list_to_order(folio, NULL, new_order);
>  }
>  
> -#define split_folio_to_list(f, l) split_folio_to_list_to_order(f, l, 0)
> -#define split_folio(f) split_folio_to_order(f, 0)
> -
>  #endif /* _LINUX_HUGE_MM_H */
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index cf8e34f62976f..06384b85a3a20 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3303,6 +3303,9 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
>   * released, or if some unexpected race happened (e.g., anon VMA disappeared,
>   * truncation).
>   *
> + * Callers should ensure that the order respects the address space mapping
> + * min-order if one is set for non-anonymous folios.
> + *
>   * Returns -EINVAL when trying to split to an order that is incompatible
>   * with the folio. Splitting to order 0 is compatible with all folios.
>   */
> @@ -3384,6 +3387,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  		mapping = NULL;
>  		anon_vma_lock_write(anon_vma);
>  	} else {
> +		unsigned int min_order;
>  		gfp_t gfp;
>  
>  		mapping = folio->mapping;
> @@ -3394,6 +3398,14 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  			goto out;
>  		}
>  
> +		min_order = mapping_min_folio_order(folio->mapping);
> +		if (new_order < min_order) {
> +			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
> +				     min_order);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
>  		gfp = current_gfp_context(mapping_gfp_mask(mapping) &
>  							GFP_RECLAIM_MASK);
>  
> @@ -3506,6 +3518,25 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  	return ret;
>  }
>  
> +int split_folio_to_list(struct folio *folio, struct list_head *list)
> +{
> +	unsigned int min_order = 0;
> +
> +	if (folio_test_anon(folio))
> +		goto out;
> +
> +	if (!folio->mapping) {
> +		if (folio_test_pmd_mappable(folio))
> +			count_vm_event(THP_SPLIT_PAGE_FAILED);
> +		return -EBUSY;
> +	}
> +
> +	min_order = mapping_min_folio_order(folio->mapping);
> +out:
> +	return split_huge_page_to_list_to_order(&folio->page, list,
> +							min_order);
> +}
> +
>  void __folio_undo_large_rmappable(struct folio *folio)
>  {
>  	struct deferred_split *ds_queue;
> @@ -3736,6 +3767,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  		struct vm_area_struct *vma = vma_lookup(mm, addr);
>  		struct folio_walk fw;
>  		struct folio *folio;
> +		struct address_space *mapping;
> +		unsigned int target_order = new_order;
>  
>  		if (!vma)
>  			break;
> @@ -3753,7 +3786,13 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  		if (!is_transparent_hugepage(folio))
>  			goto next;
>  
> -		if (new_order >= folio_order(folio))
> +		if (!folio_test_anon(folio)) {
> +			mapping = folio->mapping;
> +			target_order = max(new_order,
> +					   mapping_min_folio_order(mapping));
> +		}
> +
> +		if (target_order >= folio_order(folio))
>  			goto next;
>  
>  		total++;
> @@ -3771,9 +3810,14 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  		folio_get(folio);
>  		folio_walk_end(&fw, vma);
>  
> -		if (!split_folio_to_order(folio, new_order))
> +		if (!folio_test_anon(folio) && folio->mapping != mapping)
> +			goto unlock;
> +
> +		if (!split_folio_to_order(folio, target_order))
>  			split++;
>  
> +unlock:
> +
>  		folio_unlock(folio);
>  		folio_put(folio);
>  
> @@ -3802,6 +3846,8 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
>  	pgoff_t index;
>  	int nr_pages = 1;
>  	unsigned long total = 0, split = 0;
> +	unsigned int min_order;
> +	unsigned int target_order;
>  
>  	file = getname_kernel(file_path);
>  	if (IS_ERR(file))
> @@ -3815,6 +3861,8 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
>  		 file_path, off_start, off_end);
>  
>  	mapping = candidate->f_mapping;
> +	min_order = mapping_min_folio_order(mapping);
> +	target_order = max(new_order, min_order);
>  
>  	for (index = off_start; index < off_end; index += nr_pages) {
>  		struct folio *folio = filemap_get_folio(mapping, index);
> @@ -3829,15 +3877,19 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
>  		total++;
>  		nr_pages = folio_nr_pages(folio);
>  
> -		if (new_order >= folio_order(folio))
> +		if (target_order >= folio_order(folio))
>  			goto next;
>  
>  		if (!folio_trylock(folio))
>  			goto next;
>  
> -		if (!split_folio_to_order(folio, new_order))
> +		if (folio->mapping != mapping)
> +			goto unlock;
> +
> +		if (!split_folio_to_order(folio, target_order))
>  			split++;
>  
> +unlock:
>  		folio_unlock(folio);
>  next:
>  		folio_put(folio);
> -- 
> 2.44.1
> 

