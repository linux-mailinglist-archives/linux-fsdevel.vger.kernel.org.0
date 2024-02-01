Return-Path: <linux-fsdevel+bounces-9920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2E28461C9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 21:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CB928B3E6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 20:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C14685627;
	Thu,  1 Feb 2024 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hZbliN24"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA7E82C7D
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706818206; cv=none; b=Pl1ltiZfm9+5vKqV49ZqRD5nV152belQHipkmXHs2lphGjfY3BE2cCDLvkUbvy7WpnFSxaGNRNdlyXAondIhMlx/iRFsf9qoNqQ+A/zg/ywoVAIbGx8wjQOKvBc7TDgp4jDKl1o0oHLbwWPE6fSESYz7axeSm16C/MjPkB4r0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706818206; c=relaxed/simple;
	bh=bvZQEB8iyjmdVUWBh/COyv9ylvSdfoSMGClnBNveSRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSsoVFzwRGOoIhJXCjCx29qu+e8MSD27RX0EkGFNsdkcZjVy311LKpv4pOgK7ss6HYTgsbgVKQpKHs0VLWSQwS6jCOWy8PuR5O7SquA/ds3cIMZYGQZyK+4NY56xcNAJD9lO43L9DsB0rvS/BvKVSVqd5P1ZqIKHWGRU7O9a/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hZbliN24; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0gzOElUCdojNqD0lDLrskflJ3j28TYAYIbO09sjYKBI=; b=hZbliN24rKRY/RhmrHtR7H/K0C
	EaWJf9/1nazmdNFXgbApB51Zl3riH1/bwgM/99SBu2fvREEym3X8LKTd74p1B+U0VeaKbH6oT2KIB
	sYzXIPnSp4mFX6csfJaPWcbvYlv2b8x60F3UH7n4dKQcDSVYbQLrUZZNUqp69kNQsamQKgrpRhK2+
	q7pk0SELXqwWm5DUZbfzVEMleuTlTRshcjIGrtoAggrsVLOtcocVaXgyiOfWXWUu/npVYfrKvBGSG
	yOyPxNRQbvEEZcrrjcgw2/n39hJqRvuDXrinf4QOXwQe9X+G6Xzaa9UdfmDpUeAqCztiN4hSEtxrB
	rdsc2zaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVdNd-0000000Ghse-28OW;
	Thu, 01 Feb 2024 20:09:49 +0000
Date: Thu, 1 Feb 2024 20:09:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Tony Luck <tony.luck@intel.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	David Hildenbrand <david@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Benjamin LaHaise <bcrl@kvack.org>, jglisse@redhat.com,
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH rfc 3/9] mm: migrate: remove migrate_folio_extra()
Message-ID: <Zbv6jSYvUhtNWlPk@casper.infradead.org>
References: <20240129070934.3717659-1-wangkefeng.wang@huawei.com>
 <20240129070934.3717659-4-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129070934.3717659-4-wangkefeng.wang@huawei.com>

On Mon, Jan 29, 2024 at 03:09:28PM +0800, Kefeng Wang wrote:
> Convert migrate_folio_extra() to __migrate_folio() which will be used
> by migrate_folio() and filemap_migrate_folio(), also directly call
> folio_migrate_mapping() in __migrate_device_pages() to simplify code.

This feels like two patches?  First convert __migrate_device_pages()
then do the other thing?

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  include/linux/migrate.h |  2 --
>  mm/migrate.c            | 32 +++++++++++---------------------
>  mm/migrate_device.c     | 13 +++++++------
>  3 files changed, 18 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 2ce13e8a309b..517f70b70620 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -63,8 +63,6 @@ extern const char *migrate_reason_names[MR_TYPES];
>  #ifdef CONFIG_MIGRATION
>  
>  void putback_movable_pages(struct list_head *l);
> -int migrate_folio_extra(struct address_space *mapping, struct folio *dst,
> -		struct folio *src, enum migrate_mode mode, int extra_count);
>  int migrate_folio(struct address_space *mapping, struct folio *dst,
>  		struct folio *src, enum migrate_mode mode);
>  int migrate_pages(struct list_head *l, new_folio_t new, free_folio_t free,
> diff --git a/mm/migrate.c b/mm/migrate.c
> index cdae25b7105f..a51ceebbe3b1 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -655,22 +655,24 @@ EXPORT_SYMBOL(folio_migrate_copy);
>   *                    Migration functions
>   ***********************************************************/
>  
> -int migrate_folio_extra(struct address_space *mapping, struct folio *dst,
> -		struct folio *src, enum migrate_mode mode, int extra_count)
> +static int __migrate_folio(struct address_space *mapping, struct folio *dst,
> +			   struct folio *src, enum migrate_mode mode,
> +			   void *src_private)
>  {
>  	int rc;
>  
> -	BUG_ON(folio_test_writeback(src));	/* Writeback must be complete */
> -
> -	rc = folio_migrate_mapping(mapping, dst, src, extra_count);
> -
> +	rc = folio_migrate_mapping(mapping, dst, src, 0);
>  	if (rc != MIGRATEPAGE_SUCCESS)
>  		return rc;
>  
> +	if (src_private)
> +		folio_attach_private(dst, folio_detach_private(src));
> +
>  	if (mode != MIGRATE_SYNC_NO_COPY)
>  		folio_migrate_copy(dst, src);
>  	else
>  		folio_migrate_flags(dst, src);
> +
>  	return MIGRATEPAGE_SUCCESS;
>  }
>  
> @@ -689,7 +691,8 @@ int migrate_folio_extra(struct address_space *mapping, struct folio *dst,
>  int migrate_folio(struct address_space *mapping, struct folio *dst,
>  		struct folio *src, enum migrate_mode mode)
>  {
> -	return migrate_folio_extra(mapping, dst, src, mode, 0);
> +	BUG_ON(folio_test_writeback(src));	/* Writeback must be complete */
> +	return __migrate_folio(mapping, dst, src, mode, NULL);
>  }
>  EXPORT_SYMBOL(migrate_folio);
>  
> @@ -843,20 +846,7 @@ EXPORT_SYMBOL_GPL(buffer_migrate_folio_norefs);
>  int filemap_migrate_folio(struct address_space *mapping,
>  		struct folio *dst, struct folio *src, enum migrate_mode mode)
>  {
> -	int ret;
> -
> -	ret = folio_migrate_mapping(mapping, dst, src, 0);
> -	if (ret != MIGRATEPAGE_SUCCESS)
> -		return ret;
> -
> -	if (folio_get_private(src))
> -		folio_attach_private(dst, folio_detach_private(src));
> -
> -	if (mode != MIGRATE_SYNC_NO_COPY)
> -		folio_migrate_copy(dst, src);
> -	else
> -		folio_migrate_flags(dst, src);
> -	return MIGRATEPAGE_SUCCESS;
> +	return __migrate_folio(mapping, dst, src, mode, folio_get_private(src));
>  }
>  EXPORT_SYMBOL_GPL(filemap_migrate_folio);
>  
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index d49a48d87d72..bea71d69295a 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -695,7 +695,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  		struct page *page = migrate_pfn_to_page(src_pfns[i]);
>  		struct address_space *mapping;
>  		struct folio *newfolio, *folio;
> -		int r;
> +		int r, extra_cnt = 0;
>  
>  		if (!newpage) {
>  			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> @@ -757,14 +757,15 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  			continue;
>  		}
>  
> +		BUG_ON(folio_test_writeback(folio));
> +
>  		if (migrate && migrate->fault_page == page)
> -			r = migrate_folio_extra(mapping, newfolio, folio,
> -						MIGRATE_SYNC_NO_COPY, 1);
> -		else
> -			r = migrate_folio(mapping, newfolio, folio,
> -					  MIGRATE_SYNC_NO_COPY);
> +			extra_cnt = 1;
> +		r = folio_migrate_mapping(mapping, newfolio, folio, extra_cnt);
>  		if (r != MIGRATEPAGE_SUCCESS)
>  			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> +		else
> +			folio_migrate_flags(newfolio, folio);
>  	}
>  
>  	if (notified)
> -- 
> 2.27.0
> 

