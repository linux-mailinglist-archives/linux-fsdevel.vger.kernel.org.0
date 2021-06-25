Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29313B426F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 13:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhFYLY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 07:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhFYLY2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:24:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECEDC061574;
        Fri, 25 Jun 2021 04:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MxqlUJ3JEfvJSuTDy3ct+hOA2fZl3KeDyOJOsYrfY68=; b=Hp2byn0nwonbL4cSpb44RHkEAn
        /xjABFgKBSHHs71Zy3+jk4RP8KylyuCDr/yegMw1x5fZmik5LvECBXAAKSxEaDMcUAZ3/d6BHRRA3
        g9BGyT+AhulwBcbzMEJY2RY7BAA9/E7JIQUpm5+AlPFt1iw0yiZD5HB/x5COrzaWbhlV1S15R7s/p
        v51nItC8j2CxoQ99R0CL7MQS1t4ZC06mocFYB++dWcnZDVyXMno+cDSQyEcoqv5jKwJ7lIvdn3eHj
        DOGCf0S3Y+X2gJbSsipB0IRvyyZ0ms0/1iuBF80YA6+Eat/6pfrRgs3ut2ecgqpK2uvkAE6jJn+Og
        EFniDs9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwjts-0001Iu-OL; Fri, 25 Jun 2021 11:21:36 +0000
Date:   Fri, 25 Jun 2021 12:21:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/46] mm/memcg: Add folio_uncharge_cgroup()
Message-ID: <YNW8PLZvX/Od+Ldn@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-16-willy@infradead.org>
 <YNWTCG3s910H3to2@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNWTCG3s910H3to2@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 25, 2021 at 10:25:44AM +0200, Michal Hocko wrote:
> On Tue 22-06-21 13:15:20, Matthew Wilcox wrote:
> > Reimplement mem_cgroup_uncharge() as a wrapper around
> > folio_uncharge_cgroup().
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Similar to the previous patch. Is there any reason why we cannot simply
> stick with mem_cgroup_{un}charge and only change the parameter to folio?

There are a dozen callers of mem_cgroup_charge() and most of them
aren't quite ready to convert to folios at this point in the patch
series.  So either we need a new name for the variant that takes a
folio, or we need to play fun games with _Generic to allow
mem_cgroup_charge() to take either a folio or a page, or we convert
all callers to open-code their call to page_folio, like this:

-	if (mem_cgroup_charge(vmf->cow_page, vma->vm_mm, GFP_KERNEL)) {
+	if (mem_cgroup_charge(page_folio(vmf->cow_page), vma->vm_mm,
+			GFP_KERNEL)) {

I've generally gone with creating compat functions to minimise the
merge conflicts when people are adding new callers or changing code near
existing ones.  But if you don't like the new name, we have options.

> > ---
> >  include/linux/memcontrol.h |  5 +++++
> >  mm/folio-compat.c          |  5 +++++
> >  mm/memcontrol.c            | 14 +++++++-------
> >  3 files changed, 17 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index a50e5cee6d2c..d4b2bc939eee 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -705,6 +705,7 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
> >  }
> >  
> >  int folio_charge_cgroup(struct folio *, struct mm_struct *, gfp_t);
> > +void folio_uncharge_cgroup(struct folio *);
> >  
> >  int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
> >  int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
> > @@ -1224,6 +1225,10 @@ static inline int folio_charge_cgroup(struct folio *folio,
> >  	return 0;
> >  }
> >  
> > +static inline void folio_uncharge_cgroup(struct folio *folio)
> > +{
> > +}
> > +
> >  static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> >  				    gfp_t gfp_mask)
> >  {
> > diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> > index 1d71b8b587f8..d229b979b00d 100644
> > --- a/mm/folio-compat.c
> > +++ b/mm/folio-compat.c
> > @@ -54,4 +54,9 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp)
> >  {
> >  	return folio_charge_cgroup(page_folio(page), mm, gfp);
> >  }
> > +
> > +void mem_cgroup_uncharge(struct page *page)
> > +{
> > +	folio_uncharge_cgroup(page_folio(page));
> > +}
> >  #endif
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 69638f84d11b..a6befc0843e7 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6717,24 +6717,24 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> >  }
> >  
> >  /**
> > - * mem_cgroup_uncharge - uncharge a page
> > - * @page: page to uncharge
> > + * folio_uncharge_cgroup - Uncharge a folio.
> > + * @folio: Folio to uncharge.
> >   *
> > - * Uncharge a page previously charged with mem_cgroup_charge().
> > + * Uncharge a folio previously charged with folio_charge_cgroup().
> >   */
> > -void mem_cgroup_uncharge(struct page *page)
> > +void folio_uncharge_cgroup(struct folio *folio)
> >  {
> >  	struct uncharge_gather ug;
> >  
> >  	if (mem_cgroup_disabled())
> >  		return;
> >  
> > -	/* Don't touch page->lru of any random page, pre-check: */
> > -	if (!page_memcg(page))
> > +	/* Don't touch folio->lru of any random page, pre-check: */
> > +	if (!folio_memcg(folio))
> >  		return;
> >  
> >  	uncharge_gather_clear(&ug);
> > -	uncharge_page(page, &ug);
> > +	uncharge_page(&folio->page, &ug);
> >  	uncharge_batch(&ug);
> >  }
> >  
> > -- 
> > 2.30.2
> 
> -- 
> Michal Hocko
> SUSE Labs
