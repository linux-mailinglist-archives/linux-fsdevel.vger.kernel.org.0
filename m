Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAAB3B32DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 17:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhFXPyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 11:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhFXPyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:54:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DDFC061574;
        Thu, 24 Jun 2021 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RhOughdPQBT8FH1TMb9mE3gkCHTQi+TVzms17GvbwF4=; b=rgTJ5jhkLChatsb8/9DhxRKKlK
        XqXuAqqgu0z7SI+WEhiWiUDaik6wSA4GU/op+TcncBjx/2cuXPqSOsuYPA1mf4UvEBWh81tWuHIRZ
        DsMXSjsH3nOuoEuOU/pOMPihqSv7zMZJ9ylt4JfjWd/kb5msg5HIOxQJ4C5GgWoP3Xy8rEeSFcTjU
        i5haAaP+y/afjxw887oqx8TIsmyxzxu5CJqBZ52B4Qa3SkrfXnZaj15eAUlA3d1v8CSHfla0dYJGh
        wQlxkX3VfkbHCFIJ9jU8D0MliVK2EWIXq+pActYJoxUhWd8l0izXSTGs0+0p27ihIb48SxXUK8L6A
        10ohojPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwRe3-00GjYi-NI; Thu, 24 Jun 2021 15:52:03 +0000
Date:   Thu, 24 Jun 2021 16:51:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/46] mm: Add folio_rmapping()
Message-ID: <YNSqHzKM5oi2XSxZ@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-3-willy@infradead.org>
 <YNLpStcUTkcHG0R9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNLpStcUTkcHG0R9@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 09:56:58AM +0200, Christoph Hellwig wrote:
> > +static inline void *folio_rmapping(struct folio *folio)
> 
> This name, just like the old one is not exaclty descriptive.  I guess the
> r stands for raw somehow?  As a casual contributor to the fringes of the
> MM I would have no idea when to use it.
> 
> All this of course also applies to the existing (__)page_rmapping, but
> maybe this is a good time to sort it out.

Yes, good point.  I don't like the name rmapping either, since
we already have rmap which has nothing to do with this.  I'll
leave page_rmapping() alone for now; no need to add that churn.
I think they all become calls to folio_raw_mapping() later.

> >  
> >  struct anon_vma *page_anon_vma(struct page *page)
> >  {
> > +	struct folio *folio = page_folio(page);
> > +	unsigned long mapping = (unsigned long)folio->mapping;
> >  
> >  	if ((mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
> >  		return NULL;
> > +	return folio_rmapping(folio);
> 
> It feelds kinda silly to not just open code folio_rmapping here
> given that we alredy went half the way. 

Yeah, I thought about that too.  Done:

-       return folio_rmapping(folio);
+       return (void *)(mapping - PAGE_MAPPING_ANON);

