Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E5120D297
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 20:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgF2Suo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 14:50:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:64953 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgF2Sum (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:42 -0400
IronPort-SDR: zdyGspA+0Ky6GT6Z6Khafy/YAc9VBgYqI5YeTNlDwlpSqcX/RQ8NErcHZU0pqOds9NAPKp735d
 Jrdum12DTGTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="207507327"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="207507327"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 09:22:27 -0700
IronPort-SDR: os2Ht+UR7dpHX226R9l8Q3duEk2cndGzRWQEHWdR0n0I5B84JCw2azs6EJ3GRY7fy6lfd7qlyy
 R0/3FZf3sxpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="294929029"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga002.jf.intel.com with ESMTP; 29 Jun 2020 09:22:27 -0700
Date:   Mon, 29 Jun 2020 09:22:27 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/7] mm: Store compound_nr as well as compound_order
Message-ID: <20200629162227.GF2454695@iweiny-DESK2.sc.intel.com>
References: <20200629151959.15779-1-willy@infradead.org>
 <20200629151959.15779-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629151959.15779-2-willy@infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 04:19:53PM +0100, Matthew Wilcox wrote:
> This removes a few instructions from functions which need to know how many
> pages are in a compound page.  The storage used is either page->mapping
> on 64-bit or page->index on 32-bit.  Both of these are fine to overlay
> on tail pages.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm.h       | 5 ++++-
>  include/linux/mm_types.h | 1 +
>  mm/page_alloc.c          | 5 +++--
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index dc7b87310c10..af0305ad090f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -911,12 +911,15 @@ static inline int compound_pincount(struct page *page)
>  static inline void set_compound_order(struct page *page, unsigned int order)
>  {
>  	page[1].compound_order = order;
> +	page[1].compound_nr = 1U << order;
                              ^^^
			      1UL?

Ira

>  }
>  
>  /* Returns the number of pages in this potentially compound page. */
>  static inline unsigned long compound_nr(struct page *page)
>  {
> -	return 1UL << compound_order(page);
> +	if (!PageHead(page))
> +		return 1;
> +	return page[1].compound_nr;
>  }
>  
>  /* Returns the number of bytes in this potentially compound page. */
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 64ede5f150dc..561ed987ab44 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -134,6 +134,7 @@ struct page {
>  			unsigned char compound_dtor;
>  			unsigned char compound_order;
>  			atomic_t compound_mapcount;
> +			unsigned int compound_nr; /* 1 << compound_order */
>  		};
>  		struct {	/* Second tail page of compound page */
>  			unsigned long _compound_pad_1;	/* compound_head */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 48eb0f1410d4..c7beb5f13193 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -673,8 +673,6 @@ void prep_compound_page(struct page *page, unsigned int order)
>  	int i;
>  	int nr_pages = 1 << order;
>  
> -	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
> -	set_compound_order(page, order);
>  	__SetPageHead(page);
>  	for (i = 1; i < nr_pages; i++) {
>  		struct page *p = page + i;
> @@ -682,6 +680,9 @@ void prep_compound_page(struct page *page, unsigned int order)
>  		p->mapping = TAIL_MAPPING;
>  		set_compound_head(p, page);
>  	}
> +
> +	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
> +	set_compound_order(page, order);
>  	atomic_set(compound_mapcount_ptr(page), -1);
>  	if (hpage_pincount_available(page))
>  		atomic_set(compound_pincount_ptr(page), 0);
> -- 
> 2.27.0
> 
> 
