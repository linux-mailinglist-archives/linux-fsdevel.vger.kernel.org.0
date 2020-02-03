Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26BB415083D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 15:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgBCOTA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 09:19:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:40442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727542AbgBCOTA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:19:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 92FE4AFE8;
        Mon,  3 Feb 2020 14:18:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 469811E0D69; Mon,  3 Feb 2020 15:18:56 +0100 (CET)
Date:   Mon, 3 Feb 2020 15:18:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/12] mm/gup: pass gup flags to two more routines
Message-ID: <20200203141856.GC18591@quack2.suse.cz>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-6-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201034029.4063170-6-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 31-01-20 19:40:22, John Hubbard wrote:
> In preparation for an upcoming patch, send gup flags args to two more
> routines: put_compound_head(), and undo_dev_pagemap().
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  mm/gup.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 65a40560c8d0..83473c2165f4 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1870,6 +1870,7 @@ static inline pte_t gup_get_pte(pte_t *ptep)
>  #endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
>  
>  static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
> +					    unsigned int flags,
>  					    struct page **pages)
>  {
>  	while ((*nr) - nr_start) {
> @@ -1909,7 +1910,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  
>  			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
>  			if (unlikely(!pgmap)) {
> -				undo_dev_pagemap(nr, nr_start, pages);
> +				undo_dev_pagemap(nr, nr_start, flags, pages);
>  				goto pte_unmap;
>  			}
>  		} else if (pte_special(pte))
> @@ -1974,7 +1975,7 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>  
>  		pgmap = get_dev_pagemap(pfn, pgmap);
>  		if (unlikely(!pgmap)) {
> -			undo_dev_pagemap(nr, nr_start, pages);
> +			undo_dev_pagemap(nr, nr_start, flags, pages);
>  			return 0;
>  		}
>  		SetPageReferenced(page);
> @@ -2001,7 +2002,7 @@ static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  		return 0;
>  
>  	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
> -		undo_dev_pagemap(nr, nr_start, pages);
> +		undo_dev_pagemap(nr, nr_start, flags, pages);
>  		return 0;
>  	}
>  	return 1;
> @@ -2019,7 +2020,7 @@ static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  		return 0;
>  
>  	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
> -		undo_dev_pagemap(nr, nr_start, pages);
> +		undo_dev_pagemap(nr, nr_start, flags, pages);
>  		return 0;
>  	}
>  	return 1;
> @@ -2053,7 +2054,7 @@ static int record_subpages(struct page *page, unsigned long addr,
>  	return nr;
>  }
>  
> -static void put_compound_head(struct page *page, int refs)
> +static void put_compound_head(struct page *page, int refs, unsigned int flags)
>  {
>  	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
>  	/*
> @@ -2103,7 +2104,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>  		return 0;
>  
>  	if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> -		put_compound_head(head, refs);
> +		put_compound_head(head, refs, flags);
>  		return 0;
>  	}
>  
> @@ -2163,7 +2164,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  		return 0;
>  
>  	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
> -		put_compound_head(head, refs);
> +		put_compound_head(head, refs, flags);
>  		return 0;
>  	}
>  
> @@ -2197,7 +2198,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  		return 0;
>  
>  	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
> -		put_compound_head(head, refs);
> +		put_compound_head(head, refs, flags);
>  		return 0;
>  	}
>  
> @@ -2226,7 +2227,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
>  		return 0;
>  
>  	if (unlikely(pgd_val(orig) != pgd_val(*pgdp))) {
> -		put_compound_head(head, refs);
> +		put_compound_head(head, refs, flags);
>  		return 0;
>  	}
>  
> -- 
> 2.25.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
