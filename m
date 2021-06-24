Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9463B350F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 19:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhFXR6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 13:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFXR6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 13:58:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925CFC061574;
        Thu, 24 Jun 2021 10:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+lCWAzHT0zMddatwrqDn8e1lQqfHJedYY57ABfGlHwc=; b=pvK2anu38wzGGJsCrk+UBnBOv3
        Cl7PZXe5/ulT2lrl2M4kwSDp13WuLYtoucaCzdDzZhpV7a3KIwfy3qVEykV9+mrj945DQvGayJXWo
        oA5f0LS78tJ7Q1JsoagwTGyi81ASVgfPyOjhL4KHsXcdFFaa5SzfXU/fVS1jcqNbqfpXz2tWOK3iK
        FMy0vBVLUhWEQ34w98V1q078Q5d539maXwd4qkKifnEr6yzr6eL5+x8OQ7NZeyObdUrfJLP7cTU3+
        kbEyVsyTNCXRKLFS+0LzJxIKtHmwEE9NB2FEiG6EJqZH4Nza6sMYO3KoYhoVuBFDutLENi7hqVFmB
        ACRrptxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwTZi-00GqIQ-AO; Thu, 24 Jun 2021 17:55:44 +0000
Date:   Thu, 24 Jun 2021 18:55:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/46] mm/migrate: Add folio_migrate_flags()
Message-ID: <YNTHGqKOu3d1/sCC@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-20-willy@infradead.org>
 <YNLwxF1T+wAQ+1em@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNLwxF1T+wAQ+1em@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 10:28:52AM +0200, Christoph Hellwig wrote:
> >  	/*
> >  	 * Please do not reorder this without considering how mm/ksm.c's
> >  	 * get_ksm_page() depends upon ksm_migrate_page() and PageSwapCache().
> >  	 */
> > -	if (PageSwapCache(page))
> > -		ClearPageSwapCache(page);
> > -	ClearPagePrivate(page);
> > -	set_page_private(page, 0);
> > +	if (folio_swapcache(folio))
> > +		folio_clear_swapcache_flag(folio);
> > +	folio_clear_private_flag(folio);
> > +
> > +	/* page->private contains hugetlb specific flags */
> > +	if (!folio_hugetlb(folio))
> > +		folio->private = NULL;
> 
> Ymmm. Dosn't the ->private handling change now?  Given that you
> added a comment it seems intentional, but I do not understand why
> it changes as part of the conversion.

Oooh.  I was based on linux-next, and Linus asked me to stop doing that.
So I rebased on -rc4 (ish), but I inadvertently brought back some of the
changes which are currently in mmotm.  This one is from:

    mm: hugetlb: alloc the vmemmap pages associated with each HugeTLB page

which contains:

-       set_page_private(page, 0);
+
+       /* page->private contains hugetlb specific flags */
+       if (!PageHuge(page))
+               set_page_private(page, 0);

So, good catch, glad you're reviewing it so closely.  I'll fix this up
as part of rebasing this patch set on top of 14-rc1.  Obviously this
second patch set isn't for merging during this merge window, but I do
hope it can go into 5.15's merge window.

The only API change I intentionally brought back was:

    mm: memcontrol: remove the pgdata parameter of mem_cgroup_page_lruvec

You'll notice that my patches have:

+static inline struct lruvec *mem_cgroup_folio_lruvec(struct folio *folio)
+{
+       return mem_cgroup_page_lruvec(&folio->page, folio_pgdat(folio));
+}

where mmotm has:

-static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
-                                               struct pglist_data *pgdat)
+static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
 {
+       pg_data_t *pgdat = page_pgdat(page);


Probably I should have cherry-picked those prereq patches into my tree
to ease the rebasing (like I did our changes to set_page_dirty), but
I'm not 100% confident I'll get all their prereq patches.
