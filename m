Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB9D415735
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 05:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbhIWDvh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 23:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbhIWDvd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:51:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2022C0613A8;
        Wed, 22 Sep 2021 20:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uMQ0LJdHQ7c4mM7EvTfGeqm/dVXZIGiACxHLT/lLI6Q=; b=ZGZo+ugLQ00vO0vKoAz2R2/AME
        S2UZfjgIGzzR0DXMWh0A/CidIkYS9+Tf4dXHDIwKxQ8MRqDQ5OxYKyWK95649aU6pWGQ4OmL3iVMz
        DoE/m/hZabJ1hKOtNq3yhOP6JER0+oEXFoW8DnxzDmvGaJPt7YChrBriNPh3BT9fl5O2bpUFKFlYt
        0XgHT1lNsIacNqqchiGtK7gftdB/3qeAUS388tft8r9uKSKcFhilp3kxgTBMsLhvt+FLPP2lp3KKX
        tKzdkNUahrdF1FCd7t8ZMHMM/A2nZGM7AyZvHXbf0pqCVFs86oa+srwEDCD+5CRWqQ/yWvFKo8uU8
        njGbmxWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTFbc-005UTs-SG; Thu, 23 Sep 2021 03:41:24 +0000
Date:   Thu, 23 Sep 2021 04:41:04 +0100
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
Message-ID: <YUv3UEE9JZgD+A/D@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpaTBJ/Jhz15S6a@casper.infradead.org>
 <20210923004515.GD3053272@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923004515.GD3053272@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 05:45:15PM -0700, Ira Weiny wrote:
> On Tue, Sep 21, 2021 at 11:18:52PM +0100, Matthew Wilcox wrote:
> > +/**
> > + * page_slab - Converts from page to slab.
> > + * @p: The page.
> > + *
> > + * This function cannot be called on a NULL pointer.  It can be called
> > + * on a non-slab page; the caller should check is_slab() to be sure
> > + * that the slab really is a slab.
> > + *
> > + * Return: The slab which contains this page.
> > + */
> > +#define page_slab(p)		(_Generic((p),				\
> > +	const struct page *:	(const struct slab *)_compound_head(p), \
> > +	struct page *:		(struct slab *)_compound_head(p)))
> > +
> > +static inline bool is_slab(struct slab *slab)
> > +{
> > +	return test_bit(PG_slab, &slab->flags);
> > +}
> > +
> 
> I'm sorry, I don't have a dog in this fight and conceptually I think folios are
> a good idea...
> 
> But for this work, having a call which returns if a 'struct slab' really is a
> 'struct slab' seems odd and well, IMHO, wrong.  Why can't page_slab() return
> NULL if there is no slab containing that page?

No, this is a good question.

The way slub works right now is that if you ask for a "large" allocation,
it does:

        flags |= __GFP_COMP;
        page = alloc_pages_node(node, flags, order);

and returns page_address(page) (eventually; the code is more complex)
So when you call kfree(), it uses the PageSlab flag to determine if the
allocation was "large" or not:

        page = virt_to_head_page(x);
        if (unlikely(!PageSlab(page))) {
                free_nonslab_page(page, object);
                return;
        }
        slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);

Now, you could say that this is a bad way to handle things, and every
allocation from slab should have PageSlab set, and it should use one of
the many other bits in page->flags to indicate whether it's a large
allocation or not.  I may have feelings in that direction myself.
But I don't think I should be changing that in this patch.

Maybe calling this function is_slab() is the confusing thing.
Perhaps it should be called SlabIsLargeAllocation().  Not sure.
