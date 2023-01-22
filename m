Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1C676CE7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jan 2023 13:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjAVMhG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Jan 2023 07:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjAVMhF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Jan 2023 07:37:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D241A95D
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jan 2023 04:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SGNhBhqNCIpBI9HhG3N2nX6Tciz/iXZGKmi8TMa3TTE=; b=oQxQRzWWRM16ul6rLzZ29l95DU
        UhTSOU4iKQihNIYq5l+o+r31CaOc8ZPNhvwHLBCashGXqU02suwPMkmPhnrraZlrooM2caVzdHJSY
        iTfno1Tqb0OdOauS+BTjPBhdqxtmkyGdRkV6JQotRvCW5uj8bsfwM+V9LX5CGt2O8H2JJO7eCwmIT
        9EvShG3oiKnDjdbBTsDGZse/qHvpZ3AHR8bv89/canf9TR25xdEjx3Y4Szu0rJiQWM6yWuia9nUi+
        mpdndAOZPMCxCW6X2OWrUwOc6FD8PxzMp8fJ7xTRIe+TOwkJ8m/4hE3WNmJhHIK6QcowPVm14pWbz
        Aexq5Xvw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJZad-003YM0-A0; Sun, 22 Jan 2023 12:36:51 +0000
Date:   Sun, 22 Jan 2023 12:36:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [RFC] memcpy_from_folio()
Message-ID: <Y80t49tQtWO5N22J@casper.infradead.org>
References: <Y8qr8c3+SJLGWhUo@casper.infradead.org>
 <63cb9105105ce_bd04c29434@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63cb9105105ce_bd04c29434@iweiny-mobl.notmuch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 11:15:17PM -0800, Ira Weiny wrote:
> Matthew Wilcox wrote:
> > I think I have a good folio replacement for memcpy_from_page().  One of
> > the annoying things about dealing with multi-page folios is that you
> > can't kmap the entire folio, yet on systems without highmem, you don't
> > need to.  It's also somewhat annoying in the caller to keep track
> > of n/len/offset/pos/...
> > 
> > I think this is probably the best option.  We could have a loop that
> > kmaps each page in the folio, but that seems like excessive complexity.
> 
> Why?  IMO better to contain the complexity of highmem systems into any
> memcpy_[to,from]_folio() calls then spread them around the kernel.

Sure, but look at the conversion that I posted.  It's actually simpler
than using the memcpy_from_page() API.

> > I'm happy to have highmem systems be less efficient, since they are
> > anyway.  Another potential area of concern is that folios can be quite
> > large and maybe having preemption disabled while we copy 2MB of data
> > might be a bad thing.  If so, the API is fine with limiting the amount
> > of data we copy, we just need to find out that it is a problem and
> > decide what the correct limit is, if it's not folio_size().
> 
> Why not map the pages only when needed?  I agree that keeping preemption
> disabled for a long time is a bad thing.  But kmap_local_page does not
> disable preemption, only migration.

Some of the scheduler people aren't terribly happy about even disabling
migration for a long time.  Is "copying 2MB of data" a long time?  If I've
done my sums correctly, my current laptop has 2x 16 bit LP-DDR4-4267
DIMMs installed.  That works out to 17GB/s and so copying 2MB of data
will take 118us.  Probably OK for even the most demanding workload.

> Regardless any looping on the maps is going to only be on highmem systems
> and we can map the pages only if/when needed.  Synchronization of the folio
> should be handled by the caller.  So it is fine to all allow migration
> during memcpy_from_folio().
> 
> So why not loop through the pages only when needed?

So you're proposing re-enabling migration after calling
kmap_local_folio()?  I don't really understand.

> > 
> >  fs/ext4/verity.c           |   16 +++++++---------
> >  include/linux/highmem.h    |   29 +++++++++++++++++++++++++++++
> >  include/linux/page-flags.h |    1 +
> >  3 files changed, 37 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> > index e4da1704438e..afe847c967a4 100644
> > --- a/fs/ext4/verity.c
> > +++ b/fs/ext4/verity.c
> > @@ -42,18 +42,16 @@ static int pagecache_read(struct inode *inode, void *buf, size_t count,
> >  			  loff_t pos)
> >  {
> >  	while (count) {
> > -		size_t n = min_t(size_t, count,
> > -				 PAGE_SIZE - offset_in_page(pos));
> > -		struct page *page;
> > +		struct folio *folio;
> > +		size_t n;
> >  
> > -		page = read_mapping_page(inode->i_mapping, pos >> PAGE_SHIFT,
> > +		folio = read_mapping_folio(inode->i_mapping, pos >> PAGE_SHIFT,
> >  					 NULL);
> 
> Is this an issue with how many pages get read into the page
> cache?  I went off on a tangent thinking this read the entire folio into
> the cache.  But I see now I was wrong.  If this is operating page by page
> why change this function at all?

The folio may (indeed _should_) be already present in the cache, otherwise
the cache isn't doing a very good job.  If read_mapping_folio() ends up
having to allocate the folio, today it only allocates a single page folio.
But if somebody else allocated it through the readahead code, and the
filesystem supports multi-page folios, then it will be larger than a
single page.  All callers must be prepared to handle a multi-page folio.

> > -		if (IS_ERR(page))
> > -			return PTR_ERR(page);
> > -
> > -		memcpy_from_page(buf, page, offset_in_page(pos), n);
> > +		if (IS_ERR(folio))
> > +			return PTR_ERR(folio);
> >  
> > -		put_page(page);
> > +		n = memcpy_from_file_folio(buf, folio, pos, count);
> > +		folio_put(folio);
> >  
> >  		buf += n;
> >  		pos += n;
> > diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> > index 9fa462561e05..9917357b9e8f 100644
> > --- a/include/linux/highmem.h
> > +++ b/include/linux/highmem.h
> > @@ -414,6 +414,35 @@ static inline void memzero_page(struct page *page, size_t offset, size_t len)
> >  	kunmap_local(addr);
> >  }
> >  
> > +/**
> > + * memcpy_from_file_folio - Copy some bytes from a file folio.
> > + * @to: The destination buffer.
> > + * @folio: The folio to copy from.
> > + * @pos: The position in the file.
> > + * @len: The maximum number of bytes to copy.
> > + *
> > + * Copy up to @len bytes from this folio.  This may be limited by PAGE_SIZE
> 
> I have a problem with 'may be limited'.  How is the caller to know this?

... from the return value?

> Won't this propagate a lot of checks in the caller?  Effectively replacing
> one complexity in the callers for another?

Look at the caller I converted!  It _reduces_ the amount of checks in
the caller.

> > + * if the folio comes from HIGHMEM, and by the size of the folio.
> > + *
> > + * Return: The number of bytes copied from the folio.
> > + */
> > +static inline size_t memcpy_from_file_folio(char *to, struct folio *folio,
> > +		loff_t pos, size_t len)
> > +{
> > +	size_t offset = offset_in_folio(folio, pos);
> > +	char *from = kmap_local_folio(folio, offset);
> > +
> > +	if (folio_test_highmem(folio))
> > +		len = min(len, PAGE_SIZE - offset);
> > +	else
> > +		len = min(len, folio_size(folio) - offset);
> > +
> > +	memcpy(to, from, len);
> 
> Do we need flush_dcache_page() for the pages?

Why?  memcpy_from_page() doesn't have one.

> I gave this an attempt today before I realized read_mapping_folio() only
> reads a single page.  :-(
> 
> How does memcpy_from_file_folio() work beyond a single page?  And in that
> case what is the point?  The more I think about this the more confused I
> get.

In the highmem case, we map a single page and so cannot go beyond a
single page.  If the folio wasn't allocated from highmem, we're just
using its address directly, so we can access the whole folio.

Hope I've cleared up your confusions.
