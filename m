Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FAE4B67BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 10:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiBOJhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 04:37:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiBOJhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:37:34 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8C0B9D72
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 01:37:23 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JybVP4Wm0z1FD4N;
        Tue, 15 Feb 2022 17:33:01 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 17:37:21 +0800
Subject: Re: [PATCH 06/10] mm/truncate: Split invalidate_inode_page() into
 mapping_shrink_folio()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-7-willy@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9685489d-0a77-7b3e-b78e-c54aab45a9da@huawei.com>
Date:   Tue, 15 Feb 2022 17:37:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220214200017.3150590-7-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/2/15 4:00, Matthew Wilcox (Oracle) wrote:
> Some of the callers already have the address_space and can avoid calling
> folio_mapping() and checking if the folio was already truncated.  Also
> add kernel-doc and fix the return type (in case we ever support folios
> larger than 4TB).
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/mm.h  |  1 -
>  mm/internal.h       |  1 +
>  mm/memory-failure.c |  4 ++--
>  mm/truncate.c       | 34 +++++++++++++++++++++++-----------
>  4 files changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4637368d9455..53b301dc5c14 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1853,7 +1853,6 @@ extern void truncate_setsize(struct inode *inode, loff_t newsize);
>  void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to);
>  void truncate_pagecache_range(struct inode *inode, loff_t offset, loff_t end);
>  int generic_error_remove_page(struct address_space *mapping, struct page *page);
> -int invalidate_inode_page(struct page *page);
>  
>  #ifdef CONFIG_MMU
>  extern vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
> diff --git a/mm/internal.h b/mm/internal.h
> index b7a2195c12b1..927a17d58b85 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -100,6 +100,7 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio);
>  int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
>  bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
>  		loff_t end);
> +long invalidate_inode_page(struct page *page);
>  
>  /**
>   * folio_evictable - Test whether a folio is evictable.
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 97a9ed8f87a9..0b72a936b8dd 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2139,7 +2139,7 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
>   */
>  static int __soft_offline_page(struct page *page)
>  {
> -	int ret = 0;
> +	long ret = 0;
>  	unsigned long pfn = page_to_pfn(page);
>  	struct page *hpage = compound_head(page);
>  	char const *msg_page[] = {"page", "hugepage"};
> @@ -2196,7 +2196,7 @@ static int __soft_offline_page(struct page *page)
>  			if (!list_empty(&pagelist))
>  				putback_movable_pages(&pagelist);
>  
> -			pr_info("soft offline: %#lx: %s migration failed %d, type %pGp\n",
> +			pr_info("soft offline: %#lx: %s migration failed %ld, type %pGp\n",
>  				pfn, msg_page[huge], ret, &page->flags);
>  			if (ret > 0)
>  				ret = -EBUSY;
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 8aa86e294775..b1bdc61198f6 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -273,18 +273,9 @@ int generic_error_remove_page(struct address_space *mapping, struct page *page)
>  }
>  EXPORT_SYMBOL(generic_error_remove_page);
>  
> -/*
> - * Safely invalidate one page from its pagecache mapping.
> - * It only drops clean, unused pages. The page must be locked.
> - *
> - * Returns 1 if the page is successfully invalidated, otherwise 0.
> - */
> -int invalidate_inode_page(struct page *page)
> +static long mapping_shrink_folio(struct address_space *mapping,
> +		struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
> -	struct address_space *mapping = folio_mapping(folio);
> -	if (!mapping)
> -		return 0;
>  	if (folio_test_dirty(folio) || folio_test_writeback(folio))
>  		return 0;
>  	if (folio_ref_count(folio) > folio_nr_pages(folio) + 1)
> @@ -295,6 +286,27 @@ int invalidate_inode_page(struct page *page)
>  	return remove_mapping(mapping, folio);
>  }
>  
> +/**
> + * invalidate_inode_page() - Remove an unused page from the pagecache.
> + * @page: The page to remove.
> + *
> + * Safely invalidate one page from its pagecache mapping.
> + * It only drops clean, unused pages.
> + *
> + * Context: Page must be locked.
> + * Return: The number of pages successfully removed.
> + */
> +long invalidate_inode_page(struct page *page)
> +{
> +	struct folio *folio = page_folio(page);
> +	struct address_space *mapping = folio_mapping(folio);
> +
> +	/* The page may have been truncated before it was locked */
> +	if (!mapping)
> +		return 0;
> +	return mapping_shrink_folio(mapping, folio);
> +}
> +
>  /**
>   * truncate_inode_pages_range - truncate range of pages specified by start & end byte offsets
>   * @mapping: mapping to truncate
> 

