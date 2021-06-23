Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6863B19B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 14:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFWMTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 08:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWMTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:19:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A463C061574;
        Wed, 23 Jun 2021 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UZNtU7hYcqZpBzA1yCiqhGXNHHIoefG0OGqkF1QWY0U=; b=EneXs4ZyYT6XLmV/Zea7qgUKKt
        ruGkYX2+qqFBxvY2oAteLxRUuN7icF98hCE7dvLsRV1iPYZZntb+7EC15pwNLpyGCT6AoeaS9LH2V
        EGmItigKyXvQuzliOYAXioxwDFNS1SvAouwRCEvHEbsHEEZFQ9JcHO29vXEdjeO4dApZqkmMSb4I1
        Bq+N8q2TxmxXgrmj1pzxq3de4Q9qb5n1H5x9eaX+qhVl+Hn3cfMwobdJiy/RaSdV+xTbwuVyetn+5
        sDv+fWx72sY1KwIMvyirZaRNlQktbrPI6u9e0BXDwQ2yMDF3yTptUBVTb+2+sVHHkGoulAIh/jSpd
        K6hbJ0iQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw1nP-00FOtj-TT; Wed, 23 Jun 2021 12:16:13 +0000
Date:   Wed, 23 Jun 2021 13:15:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 46/46] mm/filemap: Add FGP_STABLE
Message-ID: <YNMl+4me2lUxiy6M@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-47-willy@infradead.org>
 <YNMeYqPkzESAkojd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNMeYqPkzESAkojd@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 01:43:30PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 22, 2021 at 01:15:51PM +0100, Matthew Wilcox (Oracle) wrote:
> > Allow filemap_get_folio() to wait for writeback to complete (if the
> > filesystem wants that behaviour).  This is the folio equivalent of
> > grab_cache_page_write_begin(), which is moved into the folio-compat
> > file as a reminder to migrate all the code using it.  This paves the
> > way for getting rid of AOP_FLAG_NOFS once grab_cache_page_write_begin()
> > is removed.
> 
> We actually should kill FGP_NOFS as well by switching everything over
> to memalloc_nofs_{save, restore} eventually, given how error prone
> all these manual flags settings are.

Well, yes, but it's been four years and we still have over 1100 uses of
GFP_NOFS.  Until someone takes on that Augean Stables, we're going to need
FGP_NOFS.  I added that context to the readahead path in f2c817bed58d,
but of course that doesn't let me remove any uses of GFP_NOFS.

> > diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> > index 78365eaee7d3..206bedd621d0 100644
> > --- a/mm/folio-compat.c
> > +++ b/mm/folio-compat.c
> > @@ -115,6 +115,7 @@ void lru_cache_add(struct page *page)
> >  }
> >  EXPORT_SYMBOL(lru_cache_add);
> >  
> > +noinline
> >  struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
> >  		int fgp_flags, gfp_t gfp)
> 
> How did that sneak in here?

Without it, pagecache_get_page() gets inlined by
grab_cache_page_write_begin() which is just too much code.
