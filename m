Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1829B67EA6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 17:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjA0QIe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 11:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjA0QIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:08:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05055CD37;
        Fri, 27 Jan 2023 08:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H0xktbbCg7yyawJvFqwNEBr7Z282R2k+DgeY+M1reRM=; b=QxQgrczA2jmsCOY7T+s0lb/6Jw
        kls7TefyCIG7LAnVJnJruPpDd894mKOgoA9zfi3HwVGthinDmFlhLzynbRBSg0I/ZursU5/5hHWR8
        skEtnmNj8GwiVVivvryFAFYSMoRB3jdGNK7CD6RDjlg5Fh9n1x7ZK3UjvbLp8nYUlXzT0ra+6NnhS
        U7DKVhezRom7tkyeoRIoqFukPvNlVQH9eBEUbsA9MEB1956WrorAUdPEeTZXXVwK/NUDWAuwtSt/a
        1eAd4upnktS5EhC5YMffXkZJG6AhuoqQFmmPr3W3/sOjsdLF8ZdcS/kRKyTV/4TVKt44U5e9+4CpB
        MNu7Wsog==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLRGp-007r3x-Vf; Fri, 27 Jan 2023 16:08:08 +0000
Date:   Fri, 27 Jan 2023 16:08:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 24/31] ext4: Convert ext4_mpage_readpages() to work on
 folios
Message-ID: <Y9P251BErHVfsum5@casper.infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-25-willy@infradead.org>
 <Y9NPyMThUWG5hxX6@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9NPyMThUWG5hxX6@sol.localdomain>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:15:04PM -0800, Eric Biggers wrote:
> On Thu, Jan 26, 2023 at 08:24:08PM +0000, Matthew Wilcox (Oracle) wrote:
> >  int ext4_mpage_readpages(struct inode *inode,
> > -		struct readahead_control *rac, struct page *page)
> > +		struct readahead_control *rac, struct folio *folio)
> >  {
> >  	struct bio *bio = NULL;
> >  	sector_t last_block_in_bio = 0;
> > @@ -247,16 +247,15 @@ int ext4_mpage_readpages(struct inode *inode,
> >  		int fully_mapped = 1;
> >  		unsigned first_hole = blocks_per_page;
> >  
> > -		if (rac) {
> > -			page = readahead_page(rac);
> > -			prefetchw(&page->flags);
> > -		}
> > +		if (rac)
> > +			folio = readahead_folio(rac);
> > +		prefetchw(&folio->flags);
> 
> Unlike readahead_page(), readahead_folio() puts the folio immediately.  Is that
> really safe?

It's safe until we unlock the page.  The page cache holds a refcount,
and truncation has to lock the page before it can remove it from the
page cache.

Putting the refcount in readahead_folio() is a transitional step; once
all filesystems are converted to use readahead_folio(), I'll hoist the
refcount put to the caller.  Having ->readahead() and ->read_folio()
with different rules for who puts the folio is a long-standing mistake.

> > @@ -299,11 +298,11 @@ int ext4_mpage_readpages(struct inode *inode,
> >  
> >  				if (ext4_map_blocks(NULL, inode, &map, 0) < 0) {
> >  				set_error_page:
> > -					SetPageError(page);
> > -					zero_user_segment(page, 0,
> > -							  PAGE_SIZE);
> > -					unlock_page(page);
> > -					goto next_page;
> > +					folio_set_error(folio);
> > +					folio_zero_segment(folio, 0,
> > +							  folio_size(folio));
> > +					folio_unlock(folio);
> > +					continue;
> 
> This is 'continuing' the inner loop, not the outer loop as it should.

Oops.  Will fix.  I didn't get any extra failures from xfstests
with this bug, although I suspect I wasn't testing with block size <
page size, which is probably needed to make a difference.
