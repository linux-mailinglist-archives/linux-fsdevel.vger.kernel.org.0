Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA9AB1508A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 15:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgBCOo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 09:44:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:54508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbgBCOoz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:44:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D41F3ACA0;
        Mon,  3 Feb 2020 14:44:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 52A011E0D5D; Mon,  3 Feb 2020 15:44:48 +0100 (CET)
Date:   Mon, 3 Feb 2020 15:44:48 +0100
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
Subject: Re: [PATCH v3 09/12] mm: dump_page(): better diagnostics for huge
 pinned pages
Message-ID: <20200203144448.GG18591@quack2.suse.cz>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-10-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201034029.4063170-10-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 31-01-20 19:40:26, John Hubbard wrote:
> As part of pin_user_pages() and related API calls, pages are
> "dma-pinned". For the case of compound pages of order > 1, the per-page
> accounting of dma pins is accomplished via the 3rd struct page in the
> compound page. In order to support debugging of any pin_user_pages()-
> related problems, enhance dump_page() so as to report the pin count
> in that case.
> 
> Documentation/core-api/pin_user_pages.rst is also updated accordingly.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  Documentation/core-api/pin_user_pages.rst |  7 +++++
>  mm/debug.c                                | 34 +++++++++++++++++------
>  2 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core-api/pin_user_pages.rst
> index 3f72b1ea1104..dd21ea140ef4 100644
> --- a/Documentation/core-api/pin_user_pages.rst
> +++ b/Documentation/core-api/pin_user_pages.rst
> @@ -215,6 +215,13 @@ Those are both going to show zero, unless CONFIG_DEBUG_VM is set. This is
>  because there is a noticeable performance drop in unpin_user_page(), when they
>  are activated.
>  
> +Other diagnostics
> +=================
> +
> +dump_page() has been enhanced slightly, to handle these new counting fields, and
> +to better report on compound pages in general. Specifically, for compound pages
> +with order > 1, the exact (hpage_pinned_refcount) pincount is reported.
> +
>  References
>  ==========
>  
> diff --git a/mm/debug.c b/mm/debug.c
> index beb1c59d784b..db81b11345be 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -57,10 +57,20 @@ static void __dump_tail_page(struct page *page, int mapcount)
>  			page, page_ref_count(page), mapcount, page->mapping,
>  			page_to_pgoff(page));
>  	} else {
> -		pr_warn("page:%px compound refcount:%d mapcount:%d mapping:%px "
> -			"index:%#lx compound_mapcount:%d\n",
> -			page, page_ref_count(head), mapcount, head->mapping,
> -			page_to_pgoff(head), compound_mapcount(page));
> +		if (hpage_pincount_available(page))
> +			pr_warn("page:%px compound refcount:%d mapcount:%d "
> +				"mapping:%px index:%#lx compound_mapcount:%d "
> +				"compound_pincount:%d\n",
> +				page, page_ref_count(head), mapcount,
> +				head->mapping, page_to_pgoff(head),
> +				compound_mapcount(page),
> +				compound_pincount(page));
> +		else
> +			pr_warn("page:%px compound refcount:%d mapcount:%d "
> +				"mapping:%px index:%#lx compound_mapcount:%d\n",
> +				page, page_ref_count(head), mapcount,
> +				head->mapping, page_to_pgoff(head),
> +				compound_mapcount(page));
>  	}
>  
>  	if (page_ref_count(page) != 0)
> @@ -103,10 +113,18 @@ void __dump_page(struct page *page, const char *reason)
>  
>  	if (PageTail(page))
>  		__dump_tail_page(page, mapcount);
> -	else
> -		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
> -			page, page_ref_count(page), mapcount,
> -			page->mapping, page_to_pgoff(page));
> +	else {
> +		if (hpage_pincount_available(page))
> +			pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
> +				"index:%#lx compound pincount: %d\n",
> +				page, page_ref_count(page), mapcount,
> +				page->mapping, page_to_pgoff(page),
> +				compound_pincount(page));
> +		else
> +			pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
> +				"index:%#lx\n", page, page_ref_count(page),
> +				mapcount, page->mapping, page_to_pgoff(page));
> +	}
>  	if (PageKsm(page))
>  		type = "ksm ";
>  	else if (PageAnon(page))
> -- 
> 2.25.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
