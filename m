Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84B34155CD1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 18:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBGR2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 12:28:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgBGR2K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=myivX2M64tawJU//p7NCr6Swfjc7dU+qI4Gkm/F5Jqc=; b=jsmA99uv7NiFtEqo3DAeR4gvwh
        Th9hLO16uiY9OHU7Kw9vz7yMFE3bMq3xH4ymZ/62PDWYug/SoCdc2K3/MjcOnzliNVh5LgxBjGLGT
        gUbjWlYInXfl9ym+ZF4osdy3erkprlCYHCRkHCl8msISCezgHexDSjHIiIN24r0IfifglrRemmjox
        As9m6xHUi4b9H+uJrKGhH2TYdkeEqnStsyN/TF9uayWe+LwUcdwOODkVcp1pgCnJuhJgZWd1KYlvZ
        ZP62GgD0gtCZNSB+iJw8XabBeKdEiYlL299zlcgk2HiGmYZv/d6I2SWNhRVBBxnGNyhm6Dl6mR8dv
        S8I7TzAg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j07Pu-0001vf-4e; Fri, 07 Feb 2020 17:27:46 +0000
Date:   Fri, 7 Feb 2020 09:27:46 -0800
From:   Matthew Wilcox <willy@infradead.org>
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
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v5 01/12] mm: dump_page(): better diagnostics for
 compound pages
Message-ID: <20200207172746.GE8731@bombadil.infradead.org>
References: <20200207033735.308000-1-jhubbard@nvidia.com>
 <20200207033735.308000-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207033735.308000-2-jhubbard@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 07:37:24PM -0800, John Hubbard wrote:
> A compound page collects the refcount in the head page, while leaving
> the refcount of each tail page at zero. Therefore, when debugging a
> problem that involves compound pages, it's best to have diagnostics that
> reflect that situation. However, dump_page() is oblivious to these
> points.
> 
> Change dump_page() as follows:
> 
> 1) For tail pages, print relevant head page information: refcount, in
>    particular. But only do this if the page is not corrupted so badly
>    that the pointer to the head page is all wrong.
> 
> 2) Do a separate check to catch any (rare) cases of the tail page's
>    refcount being non-zero, and issue a separate, clear pr_warn() if
>    that ever happens.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/debug.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index ecccd9f17801..f074077eee11 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -42,6 +42,33 @@ const struct trace_print_flags vmaflag_names[] = {
>  	{0, NULL}
>  };
>  
> +static void __dump_tail_page(struct page *page, int mapcount)
> +{
> +	struct page *head = compound_head(page);
> +
> +	if ((page < head) || (page >= head + MAX_ORDER_NR_PAGES)) {
> +		/*
> +		 * Page is hopelessly corrupted, so limit any reporting to
> +		 * information about the page itself. Do not attempt to look at
> +		 * the head page.
> +		 */
> +		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
> +			"index:%#lx (corrupted tail page case)\n",
> +			page, page_ref_count(page), mapcount, page->mapping,
> +			page_to_pgoff(page));
> +	} else {
> +		pr_warn("page:%px compound refcount:%d mapcount:%d mapping:%px "
> +			"index:%#lx compound_mapcount:%d\n",
> +			page, page_ref_count(head), mapcount, head->mapping,
> +			page_to_pgoff(head), compound_mapcount(page));
> +	}
> +
> +	if (page_ref_count(page) != 0) {
> +		pr_warn("page:%px PROBLEM: non-zero refcount (==%d) on this "
> +			"tail page\n", page, page_ref_count(page));
> +	}
> +}
> +
>  void __dump_page(struct page *page, const char *reason)
>  {
>  	struct address_space *mapping;
> @@ -75,12 +102,8 @@ void __dump_page(struct page *page, const char *reason)
>  	 */
>  	mapcount = PageSlab(page) ? 0 : page_mapcount(page);
>  
> -	if (PageCompound(page))
> -		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
> -			"index:%#lx compound_mapcount: %d\n",
> -			page, page_ref_count(page), mapcount,
> -			page->mapping, page_to_pgoff(page),
> -			compound_mapcount(page));
> +	if (PageTail(page))
> +		__dump_tail_page(page, mapcount);
>  	else
>  		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
>  			page, page_ref_count(page), mapcount,

A definite improvement, but I think we could do better.  For example,
you've changed PageCompound to PageTail here, whereas we really do want
to dump some more information for PageHead pages than the plain vanilla
order-0 page has.  Another thing is that page_mapping() calls compound_head(),
so if the page is corrupted, we're going to get a funky pointer dereference.

I spent a bit of time on this reimplementation ... what do you think?

 - Print the mapping pointer using %p insted of %px.  The actual value of
   the pointer can be read out of the raw page dump and using %p gives a
   chance to correlate it to earlier printk of the mapping pointer.
 - Add the order of the page for compound pages
 - Dump the raw head page as well as the raw page being dumped

diff --git a/mm/debug.c b/mm/debug.c
index ecccd9f17801..0564d4cb8233 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -44,8 +44,10 @@ const struct trace_print_flags vmaflag_names[] = {
 
 void __dump_page(struct page *page, const char *reason)
 {
+	struct page *head = compound_head(page);
 	struct address_space *mapping;
 	bool page_poisoned = PagePoisoned(page);
+	bool compound = PageCompound(page);
 	/*
 	 * Accessing the pageblock without the zone lock. It could change to
 	 * "isolate" again in the meantime, but since we are just dumping the
@@ -66,25 +68,32 @@ void __dump_page(struct page *page, const char *reason)
 		goto hex_only;
 	}
 
-	mapping = page_mapping(page);
+	if (page < head || (page >= head + MAX_ORDER_NR_PAGES)) {
+		/* Corrupt page, cannot call page_mapping */
+		mapping = page->mapping;
+		head = page;
+		compound = false;
+	} else {
+		mapping = page_mapping(page);
+	}
 
 	/*
 	 * Avoid VM_BUG_ON() in page_mapcount().
 	 * page->_mapcount space in struct page is used by sl[aou]b pages to
 	 * encode own info.
 	 */
-	mapcount = PageSlab(page) ? 0 : page_mapcount(page);
+	mapcount = PageSlab(head) ? 0 : page_mapcount(head);
 
-	if (PageCompound(page))
-		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
-			"index:%#lx compound_mapcount: %d\n",
-			page, page_ref_count(page), mapcount,
+	if (compound)
+		pr_warn("page:%px head:%px refcount:%d mapcount:%d mapping:%p "
+			"index:%#lx order:%u compound_mapcount: %d\n",
+			page, head, page_ref_count(page), mapcount,
 			page->mapping, page_to_pgoff(page),
-			compound_mapcount(page));
+			compound_order(head), compound_mapcount(page));
 	else
-		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
+		pr_warn("page:%px refcount:%d mapcount:%d mapping:%p index:%#lx\n",
 			page, page_ref_count(page), mapcount,
-			page->mapping, page_to_pgoff(page));
+			mapping, page_to_pgoff(page));
 	if (PageKsm(page))
 		type = "ksm ";
 	else if (PageAnon(page))
@@ -106,6 +115,10 @@ void __dump_page(struct page *page, const char *reason)
 	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
 			sizeof(struct page), false);
+	if (!page_poisoned && compound)
+		print_hex_dump(KERN_WARNING, "head: ", DUMP_PREFIX_NONE, 32,
+			sizeof(unsigned long), head,
+			sizeof(struct page), false);
 
 	if (reason)
 		pr_warn("page dumped because: %s\n", reason);
