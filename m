Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9172A6858
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 14:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfICML5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 08:11:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfICML4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8EXrYd4RsH6BhIOlTTrp7nSzyNrjaXwYb7WWqgrRr9Y=; b=btqI5faIUT1LIYYiY9J4zINYa
        3jWPSYkalrJbyjVLIJldORJvZuDJ/zHsD1VvNmD4bdXCqkmlPA4w9XGItTEClgoh6M0RckxISoiqc
        r6niZXlB+7EoS7c6IyPny4ucc7gVTb6eTxrg3fmqRSKg4G66qRDSNmqNUpvZeEfnB4R9iTozEskz7
        bbPH5Fa24IlPi9kjfXG3Rie8eQNOoIZB8hkVd/YqYDz9+EBL80/FVfoKcColNHXuUdCBjstZufBB2
        hDA2QJyO9yDtah+GC7XcO8XZu47qpuo3x42WciEpEIuFH5lChFZiUVRS6iWB9ohV6ANbP//yvJxUm
        bozNI4a2g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i57f9-0002ll-Km; Tue, 03 Sep 2019 12:11:55 +0000
Date:   Tue, 3 Sep 2019 05:11:55 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [PATCH v5 1/2] mm: Allow the page cache to allocate large pages
Message-ID: <20190903121155.GD29434@bombadil.infradead.org>
References: <20190902092341.26712-1-william.kucharski@oracle.com>
 <20190902092341.26712-2-william.kucharski@oracle.com>
 <20190903115748.GS14028@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903115748.GS14028@dhcp22.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 01:57:48PM +0200, Michal Hocko wrote:
> On Mon 02-09-19 03:23:40, William Kucharski wrote:
> > Add an 'order' argument to __page_cache_alloc() and
> > do_read_cache_page(). Ensure the allocated pages are compound pages.
> 
> Why do we need to touch all the existing callers and change them to use
> order 0 when none is actually converted to a different order? This just
> seem to add a lot of code churn without a good reason. If anything I
> would simply add __page_cache_alloc_order and make __page_cache_alloc
> call it with order 0 argument.

Patch 2/2 uses a non-zero order.  I agree it's a lot of churn without
good reason; that's why I tried to add GFP_ORDER flags a few months ago.
Unfortunately, you didn't like that approach either.

> Also is it so much to ask callers to provide __GFP_COMP explicitly?

Yes, it's an unreasonable burden on the callers.  Those that pass 0 will
have the test optimised away by the compiler (for the non-NUMA case).
For the NUMA case, passing zero is going to be only a couple of extra
instructions to not set the GFP_COMP flag.

> >  #ifdef CONFIG_NUMA
> > -extern struct page *__page_cache_alloc(gfp_t gfp);
> > +extern struct page *__page_cache_alloc(gfp_t gfp, unsigned int order);
> >  #else
> > -static inline struct page *__page_cache_alloc(gfp_t gfp)
> > +static inline struct page *__page_cache_alloc(gfp_t gfp, unsigned int order)
> >  {
> > -	return alloc_pages(gfp, 0);
> > +	if (order > 0)
> > +		gfp |= __GFP_COMP;
> > +	return alloc_pages(gfp, order);
> >  }
> >  #endif

