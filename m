Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F19B1638D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 01:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgBSA7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 19:59:23 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:53932 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726482AbgBSA7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:59:22 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 368A83A2380;
        Wed, 19 Feb 2020 11:59:16 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j4Dhr-0004cn-HF; Wed, 19 Feb 2020 11:59:15 +1100
Date:   Wed, 19 Feb 2020 11:59:15 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 07/19] mm: Put readahead pages in cache earlier
Message-ID: <20200219005915.GV10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-12-willy@infradead.org>
 <20200218061459.GM10776@dread.disaster.area>
 <20200218154222.GQ7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218154222.GQ7778@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=vUdR-S3ouboEXt6xVngA:9
        a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 07:42:22AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 18, 2020 at 05:14:59PM +1100, Dave Chinner wrote:
> > On Mon, Feb 17, 2020 at 10:45:52AM -0800, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > At allocation time, put the pages in the cache unless we're using
> > > ->readpages.  Add the readahead_for_each() iterator for the benefit of
> > > the ->readpage fallback.  This iterator supports huge pages, even though
> > > none of the filesystems to be converted do yet.
> > 
> > This could be better written - took me some time to get my head
> > around it and the code.
> > 
> > "When populating the page cache for readahead, mappings that don't
> > use ->readpages need to have their pages added to the page cache
> > before ->readpage is called. Do this insertion earlier so that the
> > pages can be looked up immediately prior to ->readpage calls rather
> > than passing them on a linked list. This early insert functionality
> > is also required by the upcoming ->readahead method that will
> > replace ->readpages.
> > 
> > Optimise and simplify the readpage loop by adding a
> > readahead_for_each() iterator to provide the pages we need to read.
> > This iterator also supports huge pages, even though none of the
> > filesystems have been converted to use them yet."
> 
> Thanks, I'll use that.
> 
> > > +static inline struct page *readahead_page(struct readahead_control *rac)
> > > +{
> > > +	struct page *page;
> > > +
> > > +	if (!rac->_nr_pages)
> > > +		return NULL;
> > 
> > Hmmmm.
> > 
> > > +
> > > +	page = xa_load(&rac->mapping->i_pages, rac->_start);
> > > +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> > > +	rac->_batch_count = hpage_nr_pages(page);
> > 
> > So we could have rac->_nr_pages = 2, and then we get an order 2
> > large page returned, and so rac->_batch_count = 4.
> 
> Well, no, we couldn't.  rac->_nr_pages is incremented by 4 when we add
> an order-2 page to the readahead.

I don't see any code that does that. :)

i.e. we aren't actually putting high order pages into the page
cache here - page_alloc() allocates order-0 pages) - so there's
nothing in the patch that tells me how rac->_nr_pages behaves
when allocating large pages...

IOWs, we have an undocumented assumption in the implementation...

> I can put a
> 	BUG_ON(rac->_batch_count > rac->_nr_pages)
> in here to be sure to catch any logic error like that.

Definitely necessary given that we don't insert large pages for
readahead yet. A comment explaining the assumptions that the
code makes for large pages is probably in order, too.

> > > -		page->index = offset;
> > > -		list_add(&page->lru, &page_pool);
> > > +		if (use_list) {
> > > +			page->index = offset;
> > > +			list_add(&page->lru, &page_pool);
> > > +		} else if (add_to_page_cache_lru(page, mapping, offset,
> > > +					gfp_mask) < 0) {
> > > +			put_page(page);
> > > +			goto read;
> > > +		}
> > 
> > Ok, so that's why you put read code at the end of the loop. To turn
> > the code into spaghetti :/
> > 
> > How much does this simplify down when we get rid of ->readpages and
> > can restructure the loop? This really seems like you're trying to
> > flatten two nested loops into one by the use of goto....
> 
> I see it as having two failure cases in this loop.  One for "page is
> already present" (which already existed) and one for "allocated a page,
> but failed to add it to the page cache" (which used to be done later).
> I didn't want to duplicate the "call read_pages()" code.  So I reshuffled
> the code rather than add a nested loop.  I don't think the nested loop
> is easier to read (we'll be at 5 levels of indentation for some statements).
> Could do it this way ...

Can we move the update of @rac inside read_pages()? The next
start offset^Windex we start at is rac._start + rac._nr_pages, right?

so read_pages() could do:

{
	if (readahead_count(rac)) {
		/* do readahead */
	}

	/* advance the readahead cursor */
	rac->_start += rac->_nr_pages;
	rac._nr_pages = 0;
}

and then we only need to call read_pages() in these cases and so
the requirement for avoiding duplicating code is avoided...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
