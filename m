Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E66055F1DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 01:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiF1XWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 19:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiF1XV6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:21:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF6931232;
        Tue, 28 Jun 2022 16:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B793D61B48;
        Tue, 28 Jun 2022 23:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB57C341C8;
        Tue, 28 Jun 2022 23:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656458516;
        bh=mvd108VoYWDpztrLlNxd/Ocw8JptaMrNIfozkzNfEyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pm5TaYlbrZy4ar+PW/ZRulRugpktmXUTZggQFy5cFGcWRiZCHgd/ZVhusgmkiqwbp
         rvp/NWy3soV23NmZzKhhtBV6wEuDl4O9at1/7oROEgWyovUduFB5Wp47gjBc8tyHTz
         JH7XBKheqgh+dp2DipEHKADDxDIaBYa8UDIF5HyMZMqtVlnLJF/AkviXVVG6nYiS9i
         4TAu+NcV+zjVyTWo+ohlW8zzCYNm7iJb+/oxDCUIpVzU+K/DfXocoLFagDVaydCFC+
         RKLyaQeG5qnTvh9dpE9+hg4IArGHoJwzMG0VLrQGqAlpvCYeGaHNmplkaQwqfriTW/
         H0tmEYzsPzE4w==
Date:   Tue, 28 Jun 2022 16:21:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org
Subject: Re: Multi-page folio issues in 5.19-rc4 (was [PATCH v3 25/25] xfs:
 Support large folios)
Message-ID: <YruNE72sW4Aizq8U@magnolia>
References: <20211216210715.3801857-26-willy@infradead.org>
 <YrO243DkbckLTfP7@magnolia>
 <Yrku31ws6OCxRGSQ@magnolia>
 <Yrm6YM2uS+qOoPcn@casper.infradead.org>
 <YrosM1+yvMYliw2l@magnolia>
 <20220628073120.GI227878@dread.disaster.area>
 <YrrlrMK/7pyZwZj2@casper.infradead.org>
 <Yrrmq4hmJPkf5V7s@casper.infradead.org>
 <Yrr/oBlf1Eig8uKS@casper.infradead.org>
 <20220628221757.GJ227878@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628221757.GJ227878@dread.disaster.area>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 08:17:57AM +1000, Dave Chinner wrote:
> On Tue, Jun 28, 2022 at 02:18:24PM +0100, Matthew Wilcox wrote:
> > On Tue, Jun 28, 2022 at 12:31:55PM +0100, Matthew Wilcox wrote:
> > > On Tue, Jun 28, 2022 at 12:27:40PM +0100, Matthew Wilcox wrote:
> > > > On Tue, Jun 28, 2022 at 05:31:20PM +1000, Dave Chinner wrote:
> > > > > So using this technique, I've discovered that there's a dirty page
> > > > > accounting leak that eventually results in fsx hanging in
> > > > > balance_dirty_pages().
> > > > 
> > > > Alas, I think this is only an accounting error, and not related to
> > > > the problem(s) that Darrick & Zorro are seeing.  I think what you're
> > > > seeing is dirty pages being dropped at truncation without the
> > > > appropriate accounting.  ie this should be the fix:
> > > 
> > > Argh, try one that actually compiles.
> > 
> > ... that one's going to underflow the accounting.  Maybe I shouldn't
> > be writing code at 6am?
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index f7248002dad9..4eec6ee83e44 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/shrinker.h>
> >  #include <linux/mm_inline.h>
> >  #include <linux/swapops.h>
> > +#include <linux/backing-dev.h>
> >  #include <linux/dax.h>
> >  #include <linux/khugepaged.h>
> >  #include <linux/freezer.h>
> > @@ -2439,11 +2440,15 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> >  		__split_huge_page_tail(head, i, lruvec, list);
> >  		/* Some pages can be beyond EOF: drop them from page cache */
> >  		if (head[i].index >= end) {
> > -			ClearPageDirty(head + i);
> > -			__delete_from_page_cache(head + i, NULL);
> > +			struct folio *tail = page_folio(head + i);
> > +
> >  			if (shmem_mapping(head->mapping))
> >  				shmem_uncharge(head->mapping->host, 1);
> > -			put_page(head + i);
> > +			else if (folio_test_clear_dirty(tail))
> > +				folio_account_cleaned(tail,
> > +					inode_to_wb(folio->mapping->host));
> > +			__filemap_remove_folio(tail, NULL);
> > +			folio_put(tail);
> >  		} else if (!PageAnon(page)) {
> >  			__xa_store(&head->mapping->i_pages, head[i].index,
> >  					head + i, 0);
> > 
> 
> Yup, that fixes the leak.
> 
> Tested-by: Dave Chinner <dchinner@redhat.com>

Four hours of generic/522 running is long enough to conclude that this
is likely the fix for my problem and migrate long soak testing to my
main g/522 rig and:

Tested-by: Darrick J. Wong <djwong@kernel.org>

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
