Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E43139C5E2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jun 2021 06:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFEE3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Jun 2021 00:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFEE3O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Jun 2021 00:29:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29C5C061767;
        Fri,  4 Jun 2021 21:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t1o5jsPuj2bB+x0v0RUVBeVs8O94UkaRJZY+bRal2wE=; b=N30XP8vw531RzbUTEevaTgcCB8
        eWi047CVUkbEVL+xY1VH/Bs8bUv0IfWJPW7Q+K9AbKl6aDx3/wq3xxw6QhlZvd9IXM9Qz9VKU4A9+
        LAgSXAupsfxhTEefruKrmODaJpOvj5k9o5Ie7BrlRf6pZYsTk+S+euwHoM2yPCCAFL8c+DEGilo8U
        hUtxoqrqebBUuIy+uBSN/lPKtGblDN/EYHeEIVD2ZAFeNFJH+LJH1vDNBHuNGO4ckXcYIIi7udS1n
        OWlBSwCb3Trf4qdtoWtY8WvY+u/ZRQUGxTcIz+cmDIKdZpNTutXB3wRzOQ1Da4QLjqjOgjn2qdRoA
        w6qZqqUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lpNtj-00Dpag-C1; Sat, 05 Jun 2021 04:27:05 +0000
Date:   Sat, 5 Jun 2021 05:26:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/33] mm: Add folio_try_get_rcu
Message-ID: <YLr9E4tWle9Qa1Xy@casper.infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-9-willy@infradead.org>
 <YK9VagEO+bKurYlz@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK9VagEO+bKurYlz@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 27, 2021 at 09:16:42AM +0100, Christoph Hellwig wrote:
> On Tue, May 11, 2021 at 10:47:10PM +0100, Matthew Wilcox (Oracle) wrote:
> > +static inline bool folio_ref_try_add_rcu(struct folio *folio, int count)
> 
> Should this have a __ prefix and/or a don't use direct comment?

I think it will get used directly ... its page counterpart is:

mm/gup.c:       if (unlikely(!page_cache_add_speculative(head, refs)))

I deliberately left kernel-doc off this function so it's not described,
but described folio_try_get_rcu() in excruciating detail.  I hope that's
enough.  There's no comment on page_cache_add_speculative() today, so
again, we're status quo.

> > +{
> > +#ifdef CONFIG_TINY_RCU
> > +	/*
> > +	 * The caller guarantees the folio will not be freed from interrupt
> > +	 * context, so (on !SMP) we only need preemption to be disabled
> > +	 * and TINY_RCU does that for us.
> > +	 */
> > +# ifdef CONFIG_PREEMPT_COUNT
> > +	VM_BUG_ON(!in_atomic() && !irqs_disabled());
> > +# endif
> 
> 	VM_BUG_ON(IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
> 		  !in_atomic() && !irqs_disabled());
> 
> ?

I'm just moving it over, and honestly, I think it's slightly clearer
this way.  We can't check it if PREEMPT_COUNT isn't enabled, and I
think that's expressed better by the ifdef than the IS_ENABLED().

> > +	VM_BUG_ON_FOLIO(folio_ref_count(folio) == 0, folio);
> > +	folio_ref_add(folio, count);
> > +#else
> > +	if (unlikely(!folio_ref_add_unless(folio, count, 0))) {
> > +		/* Either the folio has been freed, or will be freed. */
> > +		return false;
> > +	}
> > +#endif
> > +	return true;
> 
> but is this tiny rcu optimization really worth it?  I guess we're just
> preserving it from the existing code and don't rock the boat..

I wondered that myself.  It's been there since Nick introduced it in
2008 with commit e286781d5f2e.  We certainly cared about small systems
more then, but apparently we still care about UP enough to maintain
CONFIG_TINY_RCU, so maybe this optimisation is still relevant.

> > @@ -1746,6 +1746,26 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
> >  }
> >  EXPORT_SYMBOL(page_cache_prev_miss);
> >  
> > +/*
> > + * Lockless page cache protocol:
> > + * On the lookup side:
> > + * 1. Load the folio from i_pages
> > + * 2. Increment the refcount if it's not zero
> > + * 3. If the folio is not found by xas_reload(), put the refcount and retry
> > + *
> > + * On the removal side:
> > + * A. Freeze the page (by zeroing the refcount if nobody else has a reference)
> > + * B. Remove the page from i_pages
> > + * C. Return the page to the page allocator
> > + *
> > + * This means that any page may have its reference count temporarily
> > + * increased by a speculative page cache (or fast GUP) lookup as it can
> > + * be allocated by another user before the RCU grace period expires.
> > + * Because the refcount temporarily acquired here may end up being the
> > + * last refcount on the page, any page allocation must be freeable by
> > + * put_folio().
> > + */
> > +
> >  /*
> >   * mapping_get_entry - Get a page cache entry.
> >   * @mapping: the address_space to search
> 
> Is this really a good place for the comment?  I'd expect it either near
> a relevant function or at the top of a file.

It's right before mapping_get_entry() which is the main lookup function
for the page cache, so I think it meets your first criteria?
