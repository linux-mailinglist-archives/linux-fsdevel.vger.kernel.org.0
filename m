Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815E841C854
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 17:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345222AbhI2P2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 11:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345175AbhI2P2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:28:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD622C06161C;
        Wed, 29 Sep 2021 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/HT/mG+FA+pI9TQTgmsOZU/RKX7YzZZpwunc3gLz0oU=; b=UIsWQEN8qUvNd0ZtpytLaAb7qU
        JXACadCVmiOzTEg1qDV31k654zAx2rlHewxRfWNISei80ZDdWVG6wFND7If1xQgCrkwUXoDdk7G6E
        gMsV1M/fHjAHkdATbGzKkhEL6O8eixg+gYdN+QYSp6go6it9A09bjU93afpUdOqT4qhKMppil0rQE
        ivpfmtIaTc7n5vag6owKrjgm5TTrC4OCgZPQJQ/IH0YWSHcTxpJ9n2PS7pfnonS9ObwOVX9WbDbEw
        zjtVNcQLqj581CoqF9TSIUrthlm511e7UWyXeCn3Lz/KDC+wMRG8XhWtb53rQsTFEjzKvfEscPaeR
        zzBj6TIA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVbS3-00BxYi-AM; Wed, 29 Sep 2021 15:25:04 +0000
Date:   Wed, 29 Sep 2021 16:24:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YVSFRx0SVW3YeA3C@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpaTBJ/Jhz15S6a@casper.infradead.org>
 <20210923004515.GD3053272@iweiny-DESK2.sc.intel.com>
 <YUv3UEE9JZgD+A/D@casper.infradead.org>
 <20210923221241.GG3053272@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923221241.GG3053272@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 03:12:41PM -0700, Ira Weiny wrote:
> On Thu, Sep 23, 2021 at 04:41:04AM +0100, Matthew Wilcox wrote:
> > On Wed, Sep 22, 2021 at 05:45:15PM -0700, Ira Weiny wrote:
> > > On Tue, Sep 21, 2021 at 11:18:52PM +0100, Matthew Wilcox wrote:
> > > > +/**
> > > > + * page_slab - Converts from page to slab.
> > > > + * @p: The page.
> > > > + *
> > > > + * This function cannot be called on a NULL pointer.  It can be called
> > > > + * on a non-slab page; the caller should check is_slab() to be sure
> > > > + * that the slab really is a slab.
> > > > + *
> > > > + * Return: The slab which contains this page.
> > > > + */
> > > > +#define page_slab(p)		(_Generic((p),				\
> > > > +	const struct page *:	(const struct slab *)_compound_head(p), \
> > > > +	struct page *:		(struct slab *)_compound_head(p)))
> > > > +
> > > > +static inline bool is_slab(struct slab *slab)
> > > > +{
> > > > +	return test_bit(PG_slab, &slab->flags);
> > > > +}
> > > > +
> > > 
> > > I'm sorry, I don't have a dog in this fight and conceptually I think folios are
> > > a good idea...
> > > 
> > > But for this work, having a call which returns if a 'struct slab' really is a
> > > 'struct slab' seems odd and well, IMHO, wrong.  Why can't page_slab() return
> > > NULL if there is no slab containing that page?
> > 
> > No, this is a good question.
> > 
> > The way slub works right now is that if you ask for a "large" allocation,
> > it does:
> > 
> >         flags |= __GFP_COMP;
> >         page = alloc_pages_node(node, flags, order);
> > 
> > and returns page_address(page) (eventually; the code is more complex)
> > So when you call kfree(), it uses the PageSlab flag to determine if the
> > allocation was "large" or not:
> > 
> >         page = virt_to_head_page(x);
> >         if (unlikely(!PageSlab(page))) {
> >                 free_nonslab_page(page, object);
> >                 return;
> >         }
> >         slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);
> > 
> > Now, you could say that this is a bad way to handle things, and every
> > allocation from slab should have PageSlab set,
> 
> Yea basically.
> 
> So what makes 'struct slab' different from 'struct page' in an order 0
> allocation?  Am I correct in deducing that PG_slab is not set in that case?

You might mean a couple of different things by that question, so let
me say some things which are true (on x86) but might not answer your
question:

If you kmalloc(4095) bytes, it comes from a slab.  That slab would usually
be an order-3 allocation.  If that order-3 allocation fails, slab might
go as low as an order-0 allocation, but PageSlab will always be set on
that head/base page because the allocation is smaller than two pages.

If you kmalloc(8193) bytes, slub throws up its hands and does an
allocation from the page allocator.  So it allocates an order-2 page,
does not set PG_slab on it, but PG_head is set on the head page and
PG_tail is set on all three tail pages.

> > and it should use one of
> > the many other bits in page->flags to indicate whether it's a large
> > allocation or not.
> 
> Isn't the fact that it is a compound page enough to know that?

No -- regular slab allocations have PG_head set.  But it could use,
eg, slab->slab_cache == NULL to distinguish page allocations
from slab allocations.

> > I may have feelings in that direction myself.
> > But I don't think I should be changing that in this patch.
> > 
> > Maybe calling this function is_slab() is the confusing thing.
> > Perhaps it should be called SlabIsLargeAllocation().  Not sure.
> 
> Well that makes a lot more sense to me from an API standpoint but checking
> PG_slab is still likely to raise some eyebrows.

Yeah.  Here's what I have right now:

+static inline bool SlabMultiPage(const struct slab *slab)
+{
+       return test_bit(PG_head, &slab->flags);
+}
+
+/* Did this allocation come from the page allocator instead of slab? */
+static inline bool SlabPageAllocation(const struct slab *slab)
+{
+       return !test_bit(PG_slab, &slab->flags);
+}

> Regardless I like the fact that the community is at least attempting to fix
> stuff like this.  Because adding types like this make it easier for people like
> me to understand what is going on.

Yes, I dislike that 'struct page' is so hard to understand, and so easy
to misuse.  It's a very weak type.
