Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F258515A99E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 14:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgBLNCB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 08:02:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLNCB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 08:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PrfoQn8vKuGaB8AXEbs3Tnqd85k9K0jENuwUtYeXIDU=; b=Z2qfFEHHXtaKNTkfUtjuyEM5XP
        76QMG0G9GzhovCTT1l2WNUgEiJFOLqTL5jzXnupqhGJl0hrRU4jU3WIOCLU/q8kaYKrQkDvr5uQNI
        cKMrR32TTh6oGz3HgksXyTA2phG+DFkw5xHrBKBY26dkxgvmYdyGgIrteqPqqim++uFBJ0AFt1hC2
        /j4XOOjeicMD+AN1QCV0bGUMFF3ZrwE2VFiECftcMBR6F1GKELeiVhi79mBCoYDy6uglQOk0q93Bg
        MC7YElTajOssrz3E2owrRwel/GNP7wwjrbtJIXFZf7vuUZ7vfeKU8CTqoVcFtmKJwWxkIYh6Pflwk
        tYxYn51w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1reS-0000bf-TX; Wed, 12 Feb 2020 13:02:00 +0000
Date:   Wed, 12 Feb 2020 05:02:00 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/25] mm: Optimise find_subpage for !THP
Message-ID: <20200212130200.GC7778@bombadil.infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-3-willy@infradead.org>
 <20200212074105.GE7068@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212074105.GE7068@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 11:41:05PM -0800, Christoph Hellwig wrote:
> On Tue, Feb 11, 2020 at 08:18:22PM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > If THP is disabled, find_subpage can become a no-op.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  include/linux/pagemap.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 75bdfec49710..0842622cca90 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -340,7 +340,7 @@ static inline struct page *find_subpage(struct page *page, pgoff_t offset)
> >  
> >  	VM_BUG_ON_PAGE(PageTail(page), page);
> >  
> > -	return page + (offset & (compound_nr(page) - 1));
> > +	return page + (offset & (hpage_nr_pages(page) - 1));
> >  }
> 
> So just above the quoted code is a
> 
> 	if (PageHuge(page))
> 		return page;
> 
> So how can we get into a compound page that is not a huge page, but
> only if THP is enabled?  (Yes, maybe I'm a little rusty on VM
> internals).

That's for hugetlbfs:

        if (!PageCompound(page))
                return 0;

        page = compound_head(page);
        return page[1].compound_dtor == HUGETLB_PAGE_DTOR;

> Can you add comments describing the use case of this function and why
> it does all these checks?  It looks like black magic to me.

Would this help?

-static inline struct page *find_subpage(struct page *page, pgoff_t offset)
+/*
+ * Given the page we found in the page cache, return the page corresponding
+ * to this offset in the file
+ */
+static inline struct page *find_subpage(struct page *head, pgoff_t offset)
 {
-       if (PageHuge(page))
-               return page;
+       /* HugeTLBfs wants the head page regardless */
+       if (PageHuge(head))
+               return head;
 
-       VM_BUG_ON_PAGE(PageTail(page), page);
+       VM_BUG_ON_PAGE(PageTail(head), head);
 
-       return page + (offset & (hpage_nr_pages(page) - 1));
+       return head + (offset & (hpage_nr_pages(head) - 1));
 }

