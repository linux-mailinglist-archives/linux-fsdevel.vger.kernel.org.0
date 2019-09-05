Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF604AABAA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 21:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390293AbfIETCk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 15:02:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388248AbfIETCk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7bfMom3kvI9piHWLFD7o7TyhCUjgttUXe8jaXRejLR8=; b=U5GYyvEK7x+uCm9f4YTJH8HpN
        pG3IMkxK89E6n+y0fFaj91iBPfUVIelVCRFvVhXK72M3IHVRi9o6B61XXKT+wV/i75wzWHbnAS/NY
        J0ajDZ/1mTik6rqlMEk8uK4ufWZIQ/7/GxrHurQylWosywbJJJETsmesuSlLCTJXRc5tmEpAoVxs6
        gF2NeZhikWBN8t1vEi1PIOM47gxoNtw3rda4xiSYteNFepeArY6eUxOvTLhBfxxxQimmKRPsmAoxN
        +ajG8Z0iAVCo6deWkoQX3e/3ALxVP9d3jd8XbdokQUE74ysudSk6eBQLiAoJ2kERzseelD8xzPEID
        dgTxrTeoA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5x1i-0000MN-7n; Thu, 05 Sep 2019 19:02:38 +0000
Date:   Thu, 5 Sep 2019 12:02:38 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Kirill Shutemov <kirill@shutemov.name>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [PATCH 1/3] mm: Add __page_cache_alloc_order
Message-ID: <20190905190238.GT29434@bombadil.infradead.org>
References: <20190905182348.5319-1-willy@infradead.org>
 <20190905182348.5319-2-willy@infradead.org>
 <75104154-A1A4-4FE3-920C-0069E1B5848D@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75104154-A1A4-4FE3-920C-0069E1B5848D@fb.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 06:58:53PM +0000, Song Liu wrote:
> > On Sep 5, 2019, at 11:23 AM, Matthew Wilcox <willy@infradead.org> wrote:
> > This new function allows page cache pages to be allocated that are
> > larger than an order-0 page.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> > include/linux/pagemap.h | 14 +++++++++++---
> > mm/filemap.c            | 11 +++++++----
> > 2 files changed, 18 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 103205494ea0..d2147215d415 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -208,14 +208,22 @@ static inline int page_cache_add_speculative(struct page *page, int count)
> > }
> > 
> > #ifdef CONFIG_NUMA
> > -extern struct page *__page_cache_alloc(gfp_t gfp);
> > +extern struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int order);
> 
> I guess we need __page_cache_alloc(gfp_t gfp) here for CONFIG_NUMA. 

... no?  The __page_cache_alloc() below is outside the ifdef/else/endif, so
it's the same for both NUMA and non-NUMA.

> > #else
> > -static inline struct page *__page_cache_alloc(gfp_t gfp)
> > +static inline
> > +struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int order)
> > {
> > -	return alloc_pages(gfp, 0);
> > +	if (order > 0)
> > +		gfp |= __GFP_COMP;
> > +	return alloc_pages(gfp, order);
> > }
> > #endif
> > 
> > +static inline struct page *__page_cache_alloc(gfp_t gfp)
> > +{
> > +	return __page_cache_alloc_order(gfp, 0);
> 
> Maybe "return alloc_pages(gfp, 0);" here to avoid checking "order > 0"?

For non-NUMA cases, the __page_cache_alloc_order() will be inlined into
__page_cache_alloc() and the copiler will eliminate the test.  Or you
need a better compiler ;-)

> > -struct page *__page_cache_alloc(gfp_t gfp)
> > +struct page *__page_cache_alloc_order(gfp_t gfp, unsigned int order)
> > {
> > 	int n;
> > 	struct page *page;
> > 
> > +	if (order > 0)
> > +		gfp |= __GFP_COMP;
> > +
> 
> I think it will be good to have separate __page_cache_alloc() for order 0, 
> so that we avoid checking "order > 0", but that may require too much 
> duplication. So I am on the fence for this one. 

We're about to dive into the page allocator ... two extra instructions
here aren't going to be noticable.
