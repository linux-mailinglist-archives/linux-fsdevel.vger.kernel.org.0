Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A1B4167DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 00:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243406AbhIWWOQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 18:14:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:44436 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243412AbhIWWOO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:14:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="223597605"
X-IronPort-AV: E=Sophos;i="5.85,317,1624345200"; 
   d="scan'208";a="223597605"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 15:12:42 -0700
X-IronPort-AV: E=Sophos;i="5.85,317,1624345200"; 
   d="scan'208";a="514282857"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 15:12:41 -0700
Date:   Thu, 23 Sep 2021 15:12:41 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20210923221241.GG3053272@iweiny-DESK2.sc.intel.com>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpaTBJ/Jhz15S6a@casper.infradead.org>
 <20210923004515.GD3053272@iweiny-DESK2.sc.intel.com>
 <YUv3UEE9JZgD+A/D@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUv3UEE9JZgD+A/D@casper.infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 04:41:04AM +0100, Matthew Wilcox wrote:
> On Wed, Sep 22, 2021 at 05:45:15PM -0700, Ira Weiny wrote:
> > On Tue, Sep 21, 2021 at 11:18:52PM +0100, Matthew Wilcox wrote:
> > > +/**
> > > + * page_slab - Converts from page to slab.
> > > + * @p: The page.
> > > + *
> > > + * This function cannot be called on a NULL pointer.  It can be called
> > > + * on a non-slab page; the caller should check is_slab() to be sure
> > > + * that the slab really is a slab.
> > > + *
> > > + * Return: The slab which contains this page.
> > > + */
> > > +#define page_slab(p)		(_Generic((p),				\
> > > +	const struct page *:	(const struct slab *)_compound_head(p), \
> > > +	struct page *:		(struct slab *)_compound_head(p)))
> > > +
> > > +static inline bool is_slab(struct slab *slab)
> > > +{
> > > +	return test_bit(PG_slab, &slab->flags);
> > > +}
> > > +
> > 
> > I'm sorry, I don't have a dog in this fight and conceptually I think folios are
> > a good idea...
> > 
> > But for this work, having a call which returns if a 'struct slab' really is a
> > 'struct slab' seems odd and well, IMHO, wrong.  Why can't page_slab() return
> > NULL if there is no slab containing that page?
> 
> No, this is a good question.
> 
> The way slub works right now is that if you ask for a "large" allocation,
> it does:
> 
>         flags |= __GFP_COMP;
>         page = alloc_pages_node(node, flags, order);
> 
> and returns page_address(page) (eventually; the code is more complex)
> So when you call kfree(), it uses the PageSlab flag to determine if the
> allocation was "large" or not:
> 
>         page = virt_to_head_page(x);
>         if (unlikely(!PageSlab(page))) {
>                 free_nonslab_page(page, object);
>                 return;
>         }
>         slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);
> 
> Now, you could say that this is a bad way to handle things, and every
> allocation from slab should have PageSlab set,

Yea basically.

So what makes 'struct slab' different from 'struct page' in an order 0
allocation?  Am I correct in deducing that PG_slab is not set in that case?

> and it should use one of
> the many other bits in page->flags to indicate whether it's a large
> allocation or not.

Isn't the fact that it is a compound page enough to know that?

> I may have feelings in that direction myself.
> But I don't think I should be changing that in this patch.
> 
> Maybe calling this function is_slab() is the confusing thing.
> Perhaps it should be called SlabIsLargeAllocation().  Not sure.

Well that makes a lot more sense to me from an API standpoint but checking
PG_slab is still likely to raise some eyebrows.

Regardless I like the fact that the community is at least attempting to fix
stuff like this.  Because adding types like this make it easier for people like
me to understand what is going on.

Ira

