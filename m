Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D18618E63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 03:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiKDCpG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 22:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKDCpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:45:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31FC1E3C1;
        Thu,  3 Nov 2022 19:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B67462076;
        Fri,  4 Nov 2022 02:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECBBC433D6;
        Fri,  4 Nov 2022 02:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667529901;
        bh=/0jE4wxnfsHa7OS5h1zoTRnX14BlhhgAYtontSD+goU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QhebSV3u30N+QMrsKozFq0hhvaud8wlCVNqX022uUgdQfIz0tPYAN8swZT4aNhxLF
         3JIvYoVIQ4c8gliQI0zeQ3FjbquYjZkECJ0znxkoy904ptfzyKKXnG+Za+6Mft1yFL
         1gARAUeU8iLcT94cx5M8segpPtf9cb8B5mW9kfWKuR/2m7Dnq0mgDABso09tQRvMh/
         x6Ut/TjR3G4G/b3+TX1EJ3q0VXjkBMQz3y+NXoo4A7OnJT7uVh2hezBWnZqsOjdeUu
         vr7N37u0q6j9BXIOK65jMN+ZW98hGZ9pwJPXOHvcqjsfVCdOmrDQ+o9MQTTolvngMB
         A2e28oevqKQrg==
Date:   Thu, 3 Nov 2022 19:45:01 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Vishal Moola <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 04/23] page-writeback: Convert write_cache_pages() to use
 filemap_get_folios_tag()
Message-ID: <Y2R8rRr0ZdrlT32m@magnolia>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
 <20220901220138.182896-5-vishal.moola@gmail.com>
 <20221018210152.GH2703033@dread.disaster.area>
 <Y2RAdUtJrOJmYU4L@fedora>
 <20221104003235.GZ2703033@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104003235.GZ2703033@dread.disaster.area>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 04, 2022 at 11:32:35AM +1100, Dave Chinner wrote:
> On Thu, Nov 03, 2022 at 03:28:05PM -0700, Vishal Moola wrote:
> > On Wed, Oct 19, 2022 at 08:01:52AM +1100, Dave Chinner wrote:
> > > On Thu, Sep 01, 2022 at 03:01:19PM -0700, Vishal Moola (Oracle) wrote:
> > > > Converted function to use folios throughout. This is in preparation for
> > > > the removal of find_get_pages_range_tag().
> > > > 
> > > > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > > > ---
> > > >  mm/page-writeback.c | 44 +++++++++++++++++++++++---------------------
> > > >  1 file changed, 23 insertions(+), 21 deletions(-)
> > > > 
> > > > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > > > index 032a7bf8d259..087165357a5a 100644
> > > > --- a/mm/page-writeback.c
> > > > +++ b/mm/page-writeback.c
> > > > @@ -2285,15 +2285,15 @@ int write_cache_pages(struct address_space *mapping,
> > > >  	int ret = 0;
> > > >  	int done = 0;
> > > >  	int error;
> > > > -	struct pagevec pvec;
> > > > -	int nr_pages;
> > > > +	struct folio_batch fbatch;
> > > > +	int nr_folios;
> > > >  	pgoff_t index;
> > > >  	pgoff_t end;		/* Inclusive */
> > > >  	pgoff_t done_index;
> > > >  	int range_whole = 0;
> > > >  	xa_mark_t tag;
> > > >  
> > > > -	pagevec_init(&pvec);
> > > > +	folio_batch_init(&fbatch);
> > > >  	if (wbc->range_cyclic) {
> > > >  		index = mapping->writeback_index; /* prev offset */
> > > >  		end = -1;
> > > > @@ -2313,17 +2313,18 @@ int write_cache_pages(struct address_space *mapping,
> > > >  	while (!done && (index <= end)) {
> > > >  		int i;
> > > >  
> > > > -		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
> > > > -				tag);
> > > > -		if (nr_pages == 0)
> > > > +		nr_folios = filemap_get_folios_tag(mapping, &index, end,
> > > > +				tag, &fbatch);
> > > 
> > > This can find and return dirty multi-page folios if the filesystem
> > > enables them in the mapping at instantiation time, right?
> > 
> > Yup, it will.
> > 
> > > > +
> > > > +		if (nr_folios == 0)
> > > >  			break;
> > > >  
> > > > -		for (i = 0; i < nr_pages; i++) {
> > > > -			struct page *page = pvec.pages[i];
> > > > +		for (i = 0; i < nr_folios; i++) {
> > > > +			struct folio *folio = fbatch.folios[i];
> > > >  
> > > > -			done_index = page->index;
> > > > +			done_index = folio->index;
> > > >  
> > > > -			lock_page(page);
> > > > +			folio_lock(folio);
> > > >  
> > > >  			/*
> > > >  			 * Page truncated or invalidated. We can freely skip it
> > > > @@ -2333,30 +2334,30 @@ int write_cache_pages(struct address_space *mapping,
> > > >  			 * even if there is now a new, dirty page at the same
> > > >  			 * pagecache address.
> > > >  			 */
> > > > -			if (unlikely(page->mapping != mapping)) {
> > > > +			if (unlikely(folio->mapping != mapping)) {
> > > >  continue_unlock:
> > > > -				unlock_page(page);
> > > > +				folio_unlock(folio);
> > > >  				continue;
> > > >  			}
> > > >  
> > > > -			if (!PageDirty(page)) {
> > > > +			if (!folio_test_dirty(folio)) {
> > > >  				/* someone wrote it for us */
> > > >  				goto continue_unlock;
> > > >  			}
> > > >  
> > > > -			if (PageWriteback(page)) {
> > > > +			if (folio_test_writeback(folio)) {
> > > >  				if (wbc->sync_mode != WB_SYNC_NONE)
> > > > -					wait_on_page_writeback(page);
> > > > +					folio_wait_writeback(folio);
> > > >  				else
> > > >  					goto continue_unlock;
> > > >  			}
> > > >  
> > > > -			BUG_ON(PageWriteback(page));
> > > > -			if (!clear_page_dirty_for_io(page))
> > > > +			BUG_ON(folio_test_writeback(folio));
> > > > +			if (!folio_clear_dirty_for_io(folio))
> > > >  				goto continue_unlock;
> > > >  
> > > >  			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
> > > > -			error = (*writepage)(page, wbc, data);
> > > > +			error = writepage(&folio->page, wbc, data);
> > > 
> > > Yet, IIUC, this treats all folios as if they are single page folios.
> > > i.e. it passes the head page of a multi-page folio to a callback
> > > that will treat it as a single PAGE_SIZE page, because that's all
> > > the writepage callbacks are currently expected to be passed...
> > > 
> > > So won't this break writeback of dirty multipage folios?
> > 
> > Yes, it appears it would. But it wouldn't because its already 'broken'.
> 
> It is? Then why isn't XFS broken on existing kernels? Oh, we don't
> know because it hasn't been tested?
> 
> Seriously - if this really is broken, and this patchset further
> propagating the brokeness, then somebody needs to explain to me why
> this is not corrupting data in XFS.

It looks like iomap_do_writepage finds the folio size correctly

	end_pos = folio_pos(folio) + folio_size(folio);

and iomap_writpage_map will map out the correct number of blocks

	unsigned nblocks = i_blocks_per_folio(inode, folio);

	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {

right?  The interface is dangerous because anyone who enables multipage
folios has to be aware that ->writepage can be handed a multipage folio.

(That said, the lack of mention of xfs in the testing plan doesn't give
me much confidence anyone has checked this...)

> I get it that page/folios are in transition, but passing a
> multi-page folio page to an interface that expects a PAGE_SIZE
> struct page is a pretty nasty landmine, regardless of how broken the
> higher level iteration code already might be.
> 
> At minimum, it needs to be documented, though I'd much prefer that
> we explicitly duplicate write_cache_pages() as write_cache_folios()
> with a callback that takes a folio and change the code to be fully
> multi-page folio safe. Then filesystems that support folios (and
> large folios) natively can be passed folios without going through
> this crappy "folio->page, page->folio" dance because the writepage
> APIs are unaware of multi-page folio constructs.

Agree.  Build the new one, move callers over, and kill the old one.

> Then you can convert the individual filesystems using
> write_cache_pages() to call write_cache_folios() one at a time,
> updating the filesystem callback to do the conversion from folio to
> struct page and checking that it an order-0 page that it has been
> handed....
> 
> > The current find_get_pages_range_tag() actually has the exact same
> > issue. The current code to fill up the pages array is:
> > 
> > 		pages[ret] = &folio->page;
> > 		if (++ret == nr_pages) {
> > 			*index = folio->index + folio_nr_pages(folio);
> > 			goto out;
> 
> "It's already broken so we can make it more broken" isn't an
> acceptible answer....
> 
> > Its not great to leave it 'broken' but its something that isn't - or at
> > least shouldn't be - creating any problems at present. And I believe Matthew
> > has plans to address them at some point before they actually become problems?
> 
> You are modifying the interfaces and doing folio conversions that
> expose and propagate the brokenness. The brokeness needs to be
> either avoided or fixed and not propagated further. Doing the above
> write_cache_folios() conversion avoids the propagating the
> brokenness, adds runtime detection of brokenness, and provides the
> right interface for writeback iteration of folios.
> 
> Fixing the generic writeback iterator properly is not much extra
> work, and it sets the model for filesytsems that have copy-pasted
> write_cache_pages() and then hacked it around for their own purposes
> (e.g. ext4, btrfs) to follow.
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
