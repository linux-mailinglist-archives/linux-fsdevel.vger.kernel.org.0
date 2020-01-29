Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6674914D353
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 00:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgA2XAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 18:00:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2XAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 18:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PK0g+/3O99lm08wVW89CDaU61bRcrU5br3+oiXW0Ri8=; b=NNmcNFI/+NovGu/ALrhlYSdMk
        iMh/bxDYsf89LTuLM0oYbWjkx8BUoLx9CJ5yP5DmLsua+ZgtQFpZBZw+t46d4ItZbXS07hR4u9c4c
        fzBY/MSHIT6SGgyRZc45kkRkbMW1kbyCb20Y/ZfoWmJ7X0yFRULFsY0EI/E6cVBx2ZlfXoWxiXKdG
        Jvcfw2J/lFYJ7R3kySyPktPeHl96BFh9aeR4Orbz6FNEUCmrl22IF4LnWM1KYyXwAkPyUgHD79h41
        BxHK1Mq+iogUJwdXU4cOT+8uYbU5DwlmanyV6QRL8Wgt7gSmijtdjgeCTOv4DQSIzDd9ZlFCVUF1x
        Bq/iau1ow==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwwJR-000199-9a; Wed, 29 Jan 2020 22:59:57 +0000
Date:   Wed, 29 Jan 2020 14:59:57 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] mm: dump_page: print head page's refcount, for
 compound pages
Message-ID: <20200129225957.GH6615@bombadil.infradead.org>
References: <20200129032417.3085670-1-jhubbard@nvidia.com>
 <20200129032417.3085670-2-jhubbard@nvidia.com>
 <20200129112510.ulims6u36ofk2qwa@box>
 <b74e8aa9-fcfd-0340-594c-61f185a0ae65@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b74e8aa9-fcfd-0340-594c-61f185a0ae65@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 02:26:06PM -0800, John Hubbard wrote:
> On 1/29/20 3:25 AM, Kirill A. Shutemov wrote:
> > On Tue, Jan 28, 2020 at 07:24:10PM -0800, John Hubbard wrote:
> >> When debugging a problem that involves compound pages, it is extremely
> >> helpful if dump_page() reports not only the page->_refcount, but also
> >> the refcount of the head page of the compound page. That's because the
> >> head page collects refcounts for the entire compound page.
> >>
> >> Therefore, enhance dump_page() so as to print out the refcount of the
> >> head page of a compound page.
> >>
> >> This approach (printing information about a struct page that is not the
> >> struct page that was passed into dump_page()) has a precedent:
> >> compound_mapcount is already being printed.
> > 
> > refcount on a tail must always be 0. I think we should only print it when
> > it is non-zero, emphasizing this fact with a standalone message.
> > 
> 
> Hi Kirill,
> 
> Yes, good point, that sounds like just the right balance. And it avoids adding 
> a new item to print in the common case, which is very nice. Here's what I've
> changed it to for the next version (I'll also rewrite the commit description 
> accordingly):
> 
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index a90da5337c14..3a45e2b77de0 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -75,12 +75,17 @@ void __dump_page(struct page *page, const char *reason)
>  	 */
>  	mapcount = PageSlab(page) ? 0 : page_mapcount(page);
>  
> -	if (PageCompound(page))
> -		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
> -			"index:%#lx compound_mapcount: %d\n",
> -			page, page_ref_count(page), mapcount,
> +	if (PageCompound(page)) {
> +		pr_warn("page:%px compound refcount:%d mapcount:%d mapping:%px "
> +			"index:%#lx compound_mapcount:%d\n",
> +			page, page_ref_count(compound_head(page)), mapcount,
>  			page->mapping, page_to_pgoff(page),
>  			compound_mapcount(page));
> +
> +		if (page != compound_head(page) && page_ref_count(page) != 0)
> +			pr_warn("page:%px PROBLEM: non-zero refcount (==%d) on "
> +				"this tail page\n", page, page_ref_count(page));
> +	}
>  	else
>  		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
>  			page, page_ref_count(page), mapcount,

I have a hunk in my current tree which looks like this:

@@ -77,6 +77,11 @@ void __dump_page(struct page *page, const char *reason)
                pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx
\n",
                        page, page_ref_count(page), mapcount,
                        page->mapping, page_to_pgoff(page));
+       if (PageTail(page)) {
+               struct page *head = compound_head(page);
+               pr_warn("head:%px mapping:%px index:%#lx\n",
+                       head, head->mapping, page_to_pgoff(head));
+       }
        if (PageKsm(page))
                pr_warn("ksm flags: %#lx(%pGp)\n", page->flags, &page->flags);
        else if (PageAnon(page))

I wonder if we can combine these two patches in some more useful way?

I also think we probably want a sanity check that 'head' and 'page'
are within a sane range of each other (ie head < page and head +
MAX_ORDER_NR_PAGES > page) to protect against a struct page that contains
complete garbage.
