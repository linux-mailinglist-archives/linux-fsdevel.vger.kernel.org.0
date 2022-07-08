Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6920B56B0FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 05:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbiGHD31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 23:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbiGHD30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 23:29:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABE373933;
        Thu,  7 Jul 2022 20:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oM2k/skZQvyu3mUYfkmntJvn7Ev2BYz4NH8zgIp7wHI=; b=rHG9dzm8IpPU7EfLVpII+KVjLX
        tK5RzYEsVvZxSEwtzFKftLvIoD7Gprdj8prhV6AczG/W1VhVFRA0+eJOe8FB1oYirYLF/RKjzuD1y
        UeDEi51PvWgAnfcZaU3Gwg3yJ7ho+xCZcFg47ydeQ/XmgoGz+hnH2UXSd2OVAnZpRaDhU4lA368tD
        oe+dO/0K+fc3cXMTKiXo8fOIKu03oBij5w1Ge8Sml/7vp/K9duiAF0tEeC/5h5rnSekPO7SDQxmi+
        t+Coa71RLCVtJVynZWQvpaKSs5ZIFuJtUldewmkkeABsbAtcvNHR4ZT5VhVmpe3X/ZzFhhyxT4Ch5
        5u2Qto6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9eg6-003A5X-T9; Fri, 08 Jul 2022 03:29:15 +0000
Date:   Fri, 8 Jul 2022 04:29:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 07/19] mm/migrate: Convert expected_page_refs() to
 folio_expected_refs()
Message-ID: <Ysekikp60Hhs5lV0@casper.infradead.org>
References: <20220608150249.3033815-1-willy@infradead.org>
 <20220608150249.3033815-8-willy@infradead.org>
 <6e7599d1-8a5f-bf16-383c-febd753bd051@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e7599d1-8a5f-bf16-383c-febd753bd051@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 07, 2022 at 07:50:17PM -0700, Hugh Dickins wrote:
> On Wed, 8 Jun 2022, Matthew Wilcox (Oracle) wrote:
> 
> > Now that both callers have a folio, convert this function to
> > take a folio & rename it.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  mm/migrate.c | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 2975f0c4d7cf..2e2f41572066 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -336,13 +336,18 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
> >  }
> >  #endif
> >  
> > -static int expected_page_refs(struct address_space *mapping, struct page *page)
> > +static int folio_expected_refs(struct address_space *mapping,
> > +		struct folio *folio)
> >  {
> > -	int expected_count = 1;
> > +	int refs = 1;
> > +	if (!mapping)
> > +		return refs;
> >  
> > -	if (mapping)
> > -		expected_count += compound_nr(page) + page_has_private(page);
> > -	return expected_count;
> > +	refs += folio_nr_pages(folio);
> > +	if (folio_get_private(folio))
> > +		refs++;
> > +
> > +	return refs;
> >  }
> >  
> >  /*
> > @@ -359,7 +364,7 @@ int folio_migrate_mapping(struct address_space *mapping,
> >  	XA_STATE(xas, &mapping->i_pages, folio_index(folio));
> >  	struct zone *oldzone, *newzone;
> >  	int dirty;
> > -	int expected_count = expected_page_refs(mapping, &folio->page) + extra_count;
> > +	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
> >  	long nr = folio_nr_pages(folio);
> >  
> >  	if (!mapping) {
> > @@ -669,7 +674,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
> >  		return migrate_page(mapping, &dst->page, &src->page, mode);
> >  
> >  	/* Check whether page does not have extra refs before we do more work */
> > -	expected_count = expected_page_refs(mapping, &src->page);
> > +	expected_count = folio_expected_refs(mapping, src);
> >  	if (folio_ref_count(src) != expected_count)
> >  		return -EAGAIN;
> >  
> > -- 
> > 2.35.1
> 
> This commit (742e89c9e352d38df1a5825fe40c4de73a5d5f7a in pagecache.git
> folio/for-next and recent linux-next) is dangerously wrong, at least
> for swapcache, and probably for some others.
> 
> I say "dangerously" because it tells page migration a swapcache page
> is safe for migration when it certainly is not.
> 
> The fun that typically ensues is kernel BUG at include/linux/mm.h:750!
> put_page_testzero() VM_BUG_ON_PAGE(page_ref_count(page) == 0, page),
> if CONFIG_DEBUG_VM=y (bisecting for that is what brought me to this).
> But I guess you might get silent data corruption too.
> 
> I assumed at first that you'd changed the rules, and were now expecting
> any subsystem that puts a non-zero value into folio->private to raise
> its refcount - whereas the old convention (originating with buffer heads)
> is that setting PG_private says an extra refcount has been taken, please
> call try_to_release_page() to lower it, and maybe that will use data in
> page->private to do so; but page->private free for the subsystem owning
> the page to use as it wishes, no refcount implication.  But that you
> had missed updating swapcache.
> 
> So I got working okay with the patch below; but before turning it into
> a proper patch, noticed that there were still plenty of other places
> applying the test for PG_private: so now think that maybe you set out
> with intention as above, realized it wouldn't work, but got distracted
> before cleaning up some places you'd already changed.  And patch below
> now goes in the wrong direction.
> 
> Or maybe you didn't intend any change, but the PG_private test just got
> missed in a few places.  I don't know, hope you remember, but current
> linux-next badly inconsistent.
> Over to you, thanks,

Ugh.  The problem I'm trying to solve is that we're short on page flags.
We _seemed_ to have correlation between "page->private != NULL" and
"PG_private is set", and so I thought I could make progress towards
removing PG_private.  But the rule you set out above wasn't written down
anywhere that I was able to find it.

I'm about to go to sleep, but I'll think on this some more tomorrow.

> Hugh
> 
> --- a/mm/migrate.c	2022-07-06 14:24:44.499941975 -0700
> +++ b/mm/migrate.c	2022-07-06 15:49:25.000000000 -0700
> @@ -351,6 +351,10 @@ unlock:
>  }
>  #endif
>  
> +static inline bool folio_counted_private(struct folio *folio)
> +{
> +	return !folio_test_swapcache(folio) && folio_get_private(folio);
> +}
>  static int folio_expected_refs(struct address_space *mapping,
>  		struct folio *folio)
>  {
> @@ -359,7 +363,7 @@ static int folio_expected_refs(struct ad
>  		return refs;
>  
>  	refs += folio_nr_pages(folio);
> -	if (folio_get_private(folio))
> +	if (folio_counted_private(folio))
>  		refs++;
>  
>  	return refs;
> --- a/mm/vmscan.c	2022-07-06 14:24:44.531942217 -0700
> +++ b/mm/vmscan.c	2022-07-06 15:49:37.000000000 -0700
> @@ -2494,6 +2494,10 @@ shrink_inactive_list(unsigned long nr_to
>   * The downside is that we have to touch folio->_refcount against each folio.
>   * But we had to alter folio->flags anyway.
>   */
> +static inline bool folio_counted_private(struct folio *folio)
> +{
> +	return !folio_test_swapcache(folio) && folio_get_private(folio);
> +}
>  static void shrink_active_list(unsigned long nr_to_scan,
>  			       struct lruvec *lruvec,
>  			       struct scan_control *sc,
> @@ -2538,8 +2542,9 @@ static void shrink_active_list(unsigned
>  		}
>  
>  		if (unlikely(buffer_heads_over_limit)) {
> -			if (folio_get_private(folio) && folio_trylock(folio)) {
> -				if (folio_get_private(folio))
> +			if (folio_counted_private(folio) &&
> +			    folio_trylock(folio)) {
> +				if (folio_counted_private(folio))
>  					filemap_release_folio(folio, 0);
>  				folio_unlock(folio);
>  			}
