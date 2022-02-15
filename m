Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BD54B65FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 09:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiBOI0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 03:26:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiBOI0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:26:36 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDEC1112
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 00:26:25 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JyYzf0dbmz9sfV;
        Tue, 15 Feb 2022 16:24:46 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 16:26:22 +0800
Subject: Re: [PATCH 08/10] mm: Turn deactivate_file_page() into
 deactivate_file_folio()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-9-willy@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <56e09280-c1dd-6bdb-81f0-524af99c5f4f@huawei.com>
Date:   Tue, 15 Feb 2022 16:26:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220214200017.3150590-9-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
> This function has one caller which already has a reference to the
> page, so we don't need to use get_page_unless_zero().  Also move the
> prototype to mm/internal.h.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/swap.h |  1 -
>  mm/internal.h        |  1 +
>  mm/swap.c            | 33 ++++++++++++++++-----------------
>  mm/truncate.c        |  2 +-
>  4 files changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 304f174b4d31..064e60e9f63f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -372,7 +372,6 @@ extern void lru_add_drain(void);
>  extern void lru_add_drain_cpu(int cpu);
>  extern void lru_add_drain_cpu_zone(struct zone *zone);
>  extern void lru_add_drain_all(void);
> -extern void deactivate_file_page(struct page *page);
>  extern void deactivate_page(struct page *page);
>  extern void mark_page_lazyfree(struct page *page);
>  extern void swap_setup(void);
> diff --git a/mm/internal.h b/mm/internal.h
> index 927a17d58b85..d886b87b1294 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -66,6 +66,7 @@ static inline void wake_throttle_isolated(pg_data_t *pgdat)
>  vm_fault_t do_swap_page(struct vm_fault *vmf);
>  void folio_rotate_reclaimable(struct folio *folio);
>  bool __folio_end_writeback(struct folio *folio);
> +void deactivate_file_folio(struct folio *folio);
>  
>  void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
>  		unsigned long floor, unsigned long ceiling);
> diff --git a/mm/swap.c b/mm/swap.c
> index bcf3ac288b56..745915127b1f 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -639,32 +639,31 @@ void lru_add_drain_cpu(int cpu)
>  }
>  
>  /**
> - * deactivate_file_page - forcefully deactivate a file page
> - * @page: page to deactivate
> + * deactivate_file_folio() - Forcefully deactivate a file folio.
> + * @folio: Folio to deactivate.
>   *
> - * This function hints the VM that @page is a good reclaim candidate,
> - * for example if its invalidation fails due to the page being dirty
> + * This function hints to the VM that @folio is a good reclaim candidate,
> + * for example if its invalidation fails due to the folio being dirty
>   * or under writeback.
>   */
> -void deactivate_file_page(struct page *page)
> +void deactivate_file_folio(struct folio *folio)
>  {
> +	struct pagevec *pvec;
> +
>  	/*
> -	 * In a workload with many unevictable page such as mprotect,
> -	 * unevictable page deactivation for accelerating reclaim is pointless.
> +	 * In a workload with many unevictable pages such as mprotect,
> +	 * unevictable folio deactivation for accelerating reclaim is pointless.
>  	 */
> -	if (PageUnevictable(page))
> +	if (folio_test_unevictable(folio))
>  		return;
>  
> -	if (likely(get_page_unless_zero(page))) {
> -		struct pagevec *pvec;
> -
> -		local_lock(&lru_pvecs.lock);
> -		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate_file);
> +	folio_get(folio);

Should we comment the assumption that caller already hold the refcnt?

Anyway, this patch looks good to me. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> +	local_lock(&lru_pvecs.lock);
> +	pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate_file);
>  
> -		if (pagevec_add_and_need_flush(pvec, page))
> -			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
> -		local_unlock(&lru_pvecs.lock);
> -	}
> +	if (pagevec_add_and_need_flush(pvec, &folio->page))
> +		pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
> +	local_unlock(&lru_pvecs.lock);
>  }
>  
>  /*
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 567557c36d45..14486e75ec28 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -525,7 +525,7 @@ static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
>  			 * of interest and try to speed up its reclaim.
>  			 */
>  			if (!ret) {
> -				deactivate_file_page(&folio->page);
> +				deactivate_file_folio(folio);
>  				/* It is likely on the pagevec of a remote CPU */
>  				if (nr_pagevec)
>  					(*nr_pagevec)++;
> 

