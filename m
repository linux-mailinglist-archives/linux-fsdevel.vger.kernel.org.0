Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E87162A29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 17:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgBRQNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 11:13:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgBRQNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2mHR3xMso7wPx9QoGFzx1rwYrTNRCHEQhcUJCVcR0UA=; b=rVQswF5VT6aHITV+WQUJTI3Sz+
        zyeGRgv7EpRN79/smg6b0KsiaFNp8cz2w9ayvr7zvy0kIym05YzsZ96ljemkKSswVgEtTFy8B/js+
        RMHOEglvCWUAvrjRhOBvSHoksCz5e8omrZSudJOAymhrgFTP5oDGLhx9D3WKxaqezGQ6YFY4aZQck
        tEuL6hUTKsUiqbGs4d3jIw7+MGmE7FZ+0OOzyzZIOCTOVEhwJUHhxxXROk1Ce/Pdp+LXknu9Pi9Va
        djTz61ObHmpvi9D2uCIbaJrqytqtN+DLAMk+ewJWL7KLa2wafgvXByskvEX2et7P3jPN316R1Nxgo
        cL+/rPoQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j45VN-0002zZ-IR; Tue, 18 Feb 2020 16:13:49 +0000
Date:   Tue, 18 Feb 2020 08:13:49 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/25] fs: Add zero_user_large
Message-ID: <20200218161349.GS7778@bombadil.infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-14-willy@infradead.org>
 <20200214135248.zqcqx3erb4pnlvmu@box>
 <20200214160342.GA7778@bombadil.infradead.org>
 <20200218141634.zhhjgtv44ux23l3l@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218141634.zhhjgtv44ux23l3l@box>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:16:34PM +0300, Kirill A. Shutemov wrote:
> > +               if (start1 >= PAGE_SIZE) {
> > +                       start1 -= PAGE_SIZE;
> > +                       end1 -= PAGE_SIZE;
> > +                       if (start2) {
> > +                               start2 -= PAGE_SIZE;
> > +                               end2 -= PAGE_SIZE;
> > +                       }
> 
> You assume start2/end2 is always after start1/end1 in the page.
> Is it always true? If so, I would add BUG_ON() for it.

after or zero.  Yes, I should add a BUG_ON to check for that.

> Otherwise, looks good.

Here's what I currently have (I'll add the BUG_ON later):

commit 7fabe16755365cdc6e80343ef994843ecebde60a
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Sat Feb 1 03:38:49 2020 -0500

    fs: Support THPs in zero_user_segments
    
    We can only kmap() one subpage of a THP at a time, so loop over all
    relevant subpages, skipping ones which don't need to be zeroed.  This is
    too large to inline when THPs are enabled and we actually need highmem,
    so put it in highmem.c.
    
    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index ea5cdbd8c2c3..74614903619d 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -215,13 +215,18 @@ static inline void clear_highpage(struct page *page)
        kunmap_atomic(kaddr);
 }
 
+#if defined(CONFIG_HIGHMEM) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
+void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
+               unsigned start2, unsigned end2);
+#else /* !HIGHMEM || !TRANSPARENT_HUGEPAGE */
 static inline void zero_user_segments(struct page *page,
-       unsigned start1, unsigned end1,
-       unsigned start2, unsigned end2)
+               unsigned start1, unsigned end1,
+               unsigned start2, unsigned end2)
 {
+       unsigned long i;
        void *kaddr = kmap_atomic(page);
 
-       BUG_ON(end1 > PAGE_SIZE || end2 > PAGE_SIZE);
+       BUG_ON(end1 > thp_size(page) || end2 > thp_size(page));
 
        if (end1 > start1)
                memset(kaddr + start1, 0, end1 - start1);
@@ -230,8 +235,10 @@ static inline void zero_user_segments(struct page *page,
                memset(kaddr + start2, 0, end2 - start2);
 
        kunmap_atomic(kaddr);
-       flush_dcache_page(page);
+       for (i = 0; i < hpage_nr_pages(page); i++)
+               flush_dcache_page(page + i);
 }
+#endif /* !HIGHMEM || !TRANSPARENT_HUGEPAGE */
 
 static inline void zero_user_segment(struct page *page,
        unsigned start, unsigned end)
diff --git a/mm/highmem.c b/mm/highmem.c
index 64d8dea47dd1..3a85c66ef532 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -367,9 +367,67 @@ void kunmap_high(struct page *page)
        if (need_wakeup)
                wake_up(pkmap_map_wait);
 }
-
 EXPORT_SYMBOL(kunmap_high);
-#endif
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
+               unsigned start2, unsigned end2)
+{
+       unsigned int i;
+
+       BUG_ON(end1 > thp_size(page) || end2 > thp_size(page));
+
+       for (i = 0; i < hpage_nr_pages(page); i++) {
+               void *kaddr;
+               unsigned this_end;
+
+               if (end1 == 0 && start2 >= PAGE_SIZE) {
+                       start2 -= PAGE_SIZE;
+                       end2 -= PAGE_SIZE;
+                       continue;
+               }
+
+               if (start1 >= PAGE_SIZE) {
+                       start1 -= PAGE_SIZE;
+                       end1 -= PAGE_SIZE;
+                       if (start2) {
+                               start2 -= PAGE_SIZE;
+                               end2 -= PAGE_SIZE;
+                       }
+                       continue;
+               }
+
+               kaddr = kmap_atomic(page + i);
+
+               this_end = min_t(unsigned, end1, PAGE_SIZE);
+               if (end1 > start1)
+                       memset(kaddr + start1, 0, this_end - start1);
+               end1 -= this_end;
+               start1 = 0;
+
+               if (start2 >= PAGE_SIZE) {
+                       start2 -= PAGE_SIZE;
+                       end2 -= PAGE_SIZE;
+               } else {
+                       this_end = min_t(unsigned, end2, PAGE_SIZE);
+                       if (end2 > start2)
+                               memset(kaddr + start2, 0, this_end - start2);
+                       end2 -= this_end;
+                       start2 = 0;
+               }
+
+               kunmap_atomic(kaddr);
+               flush_dcache_page(page + i);
+
+               if (!end1 && !end2)
+                       break;
+       }
+
+       BUG_ON((start1 | start2 | end1 | end2) != 0);
+}
+EXPORT_SYMBOL(zero_user_segments);
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif /* CONFIG_HIGHMEM */
 
 #if defined(HASHED_PAGE_VIRTUAL)
 



> > +                       continue;
> > +               }
> > +
> > +               kaddr = kmap_atomic(page + i);
> > +
> > +               this_end = min_t(unsigned, end1, PAGE_SIZE);
> > +               if (end1 > start1)
> > +                       memset(kaddr + start1, 0, this_end - start1);
> > +               end1 -= this_end;
> > +               start1 = 0;
> > +
> > +               if (start2 >= PAGE_SIZE) {
> > +                       start2 -= PAGE_SIZE;
> > +                       end2 -= PAGE_SIZE;
> > +               } else {
> > +                       this_end = min_t(unsigned, end2, PAGE_SIZE);
> > +                       if (end2 > start2)
> > +                               memset(kaddr + start2, 0, this_end - start2);
> > +                       end2 -= this_end;
> > +                       start2 = 0;
> > +               }
> > +
> > +               kunmap_atomic(kaddr);
> > +               flush_dcache_page(page + i);
> > +
> > +               if (!end1 && !end2)
> > +                       break;
> > +       }
> > +
> > +       BUG_ON((start1 | start2 | end1 | end2) != 0);
> >  }
> > 
> > I think at this point it has to move out-of-line too.
> > 
> > > > +static inline void zero_user_large(struct page *page,
> > > > +		unsigned start, unsigned size)
> > > > +{
> > > > +	unsigned int i;
> > > > +
> > > > +	for (i = 0; i < thp_order(page); i++) {
> > > > +		if (start > PAGE_SIZE) {
> > > 
> > > Off-by-one? >= ?
> > 
> > Good catch; I'd also noticed that when I came to redo the zero_user_segments().
> > 
> 
> -- 
>  Kirill A. Shutemov
