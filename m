Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526A043B244
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 14:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhJZMW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 08:22:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53308 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbhJZMWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 08:22:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 400B71FD42;
        Tue, 26 Oct 2021 12:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635250827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nRDIrKl4b/w/2mxvlJtABbHIbMj6KnRgbfHbqHDEfHk=;
        b=I+7KbVf2VmGpWy+RevMBI+VBV2XOlTmM89mSKyESsX5rMwMiE+7NNdX6+OkhiDJhxcUMhn
        TBfBhvX3KErpqi7dpfBzd60p7BSg7LxQJau8KugBBw4iaHKZ+y4gSIxkxrl3HoiIZrpba/
        JdTMWEeXOWrgyUydozWCkRGIht6Nvs8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D497CA3B8E;
        Tue, 26 Oct 2021 12:20:26 +0000 (UTC)
Date:   Tue, 26 Oct 2021 14:20:23 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 3/4] mm/vmalloc: be more explicit about supported gfp
 flags.
Message-ID: <YXfyhzutoR1q85wt@dhcp22.suse.cz>
References: <20211025150223.13621-1-mhocko@kernel.org>
 <20211025150223.13621-4-mhocko@kernel.org>
 <163520436674.16092.18372437960890952300@noble.neil.brown.name>
 <YXep1ctN1wPP+1a8@dhcp22.suse.cz>
 <163524499768.8576.4634415079916744478@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163524499768.8576.4634415079916744478@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-10-21 21:43:17, Neil Brown wrote:
> On Tue, 26 Oct 2021, Michal Hocko wrote:
> > On Tue 26-10-21 10:26:06, Neil Brown wrote:
> > > On Tue, 26 Oct 2021, Michal Hocko wrote:
> > > > From: Michal Hocko <mhocko@suse.com>
> > > > 
> > > > The core of the vmalloc allocator __vmalloc_area_node doesn't say
> > > > anything about gfp mask argument. Not all gfp flags are supported
> > > > though. Be more explicit about constrains.
> > > > 
> > > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > > ---
> > > >  mm/vmalloc.c | 12 ++++++++++--
> > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 602649919a9d..2199d821c981 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -2980,8 +2980,16 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > > >   * @caller:		  caller's return address
> > > >   *
> > > >   * Allocate enough pages to cover @size from the page level
> > > > - * allocator with @gfp_mask flags.  Map them into contiguous
> > > > - * kernel virtual space, using a pagetable protection of @prot.
> > > > + * allocator with @gfp_mask flags. Please note that the full set of gfp
> > > > + * flags are not supported. GFP_KERNEL would be a preferred allocation mode
> > > > + * but GFP_NOFS and GFP_NOIO are supported as well. Zone modifiers are not
> > > 
> > > In what sense is GFP_KERNEL "preferred"??
> > > The choice of GFP_NOFS, when necessary, isn't based on preference but
> > > on need.
> > > 
> > > I understand that you would prefer no one ever used GFP_NOFs ever - just
> > > use the scope API.  I even agree.  But this is not the place to make
> > > that case. 
> > 
> > Any suggestion for a better wording?
> 
>  "GFP_KERNEL, GFP_NOFS, and GFP_NOIO are all supported".

OK. Check the incremental update at the end of the email

> > > > + * supported. From the reclaim modifiers__GFP_DIRECT_RECLAIM is required (aka
> > > > + * GFP_NOWAIT is not supported) and only __GFP_NOFAIL is supported (aka
> > > 
> > > I don't think "aka" is the right thing to use here.  It is short for
> > > "also known as" and there is nothing that is being known as something
> > > else.
> > > It would be appropriate to say (i.e. GFP_NOWAIT is not supported).
> > > "i.e." is short for the Latin "id est" which means "that is" and
> > > normally introduces an alternate description (whereas aka introduces an
> > > alternate name).
> > 
> > OK
> >  
> > > > + * __GFP_NORETRY and __GFP_RETRY_MAYFAIL are not supported).
> > > 
> > > Why do you think __GFP_NORETRY and __GFP_RETRY_MAYFAIL are not supported.
> > 
> > Because they cannot be passed to the page table allocator. In both cases
> > the allocation would fail when system is short on memory. GFP_KERNEL
> > used for ptes implicitly doesn't behave that way.
> 
> Could you please point me to the particular allocation which uses
> GFP_KERNEL rather than the flags passed to __vmalloc_node()?  I cannot
> find it.
> 

It is dug 
__vmalloc_area_node
  vmap_pages_range
    vmap_pages_range_noflush
      vmap_range_noflush || vmap_small_pages_range_noflush
        vmap_p4d_range
	  p4d_alloc_track
	    __p4d_alloc
	      p4d_alloc_one
	        get_zeroed_page(GFP_KERNEL_ACCOUNT)

the same applies for all other levels of page tables.

This is what I have currently
commit ae7fc6c2ef6949a76d697fc61bb350197dfca330
Author: Michal Hocko <mhocko@suse.com>
Date:   Tue Oct 26 14:16:32 2021 +0200

    fold me "mm/vmalloc: be more explicit about supported gfp flags."

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 2ddaa9410aee..82a07b04317e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2981,12 +2981,14 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
  *
  * Allocate enough pages to cover @size from the page level
  * allocator with @gfp_mask flags. Please note that the full set of gfp
- * flags are not supported. GFP_KERNEL would be a preferred allocation mode
- * but GFP_NOFS and GFP_NOIO are supported as well. Zone modifiers are not
- * supported. From the reclaim modifiers__GFP_DIRECT_RECLAIM is required (aka
- * GFP_NOWAIT is not supported) and only __GFP_NOFAIL is supported (aka
- * __GFP_NORETRY and __GFP_RETRY_MAYFAIL are not supported).
- * __GFP_NOWARN can be used to suppress error messages about failures.
+ * flags are not supported. GFP_KERNEL, GFP_NOFS, and GFP_NOIO are all
+ * supported.
+ * Zone modifiers are not supported. From the reclaim modifiers
+ * __GFP_DIRECT_RECLAIM is required (aka GFP_NOWAIT is not supported)
+ * and only __GFP_NOFAIL is supported (i.e. __GFP_NORETRY and 
+ * __GFP_RETRY_MAYFAIL are not supported).
+ *
+ * __GFP_NOWARN can be used to suppress failures messages.
  * 
  * Map them into contiguous kernel virtual space, using a pagetable
  * protection of @prot.
-- 
Michal Hocko
SUSE Labs
