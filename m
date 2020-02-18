Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB23163478
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 22:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgBRVM3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 16:12:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRVM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C6+FIzbRd5o0hW1kRRKUBom8n/N7TIIIJ10n6Bm+gNU=; b=SdZgWPmlYVT0XMUjMwdirbyYq5
        z/MvgHdWZUONYcHl0TnpfiGDmf095oomwV/N/RH6GifFj/rwydwe+kq6f2tbOAtJRElqxHz5Dgnh+
        EW7uBjnC3wOpboaXgsOCVQRD30ui8pjcMOhoklr/TvrXbI8o6CiPf6ruIhRLe6FKvhd2qrDgFPK1I
        KmNAWjN7hvSGK0O5AQs3X+tXrG9yBpfQMM6X25JmPmgGOzUnAROE3QwvicPpE9MgRzP8MlaGrDSXQ
        mBWD91boJiYlTGiZfTXKX3BebkqowPF+MM0ZAndsu5z1koT2azK+W51G0UZDdJcX2CL0ZNSIzEO5Y
        20S6gvOQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4AAO-0006yP-HR; Tue, 18 Feb 2020 21:12:28 +0000
Date:   Tue, 18 Feb 2020 13:12:28 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 11/19] btrfs: Convert from readpages to readahead
Message-ID: <20200218211228.GF24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-19-willy@infradead.org>
 <20200218065758.GQ10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218065758.GQ10776@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:57:58PM +1100, Dave Chinner wrote:
> On Mon, Feb 17, 2020 at 10:45:59AM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Use the new readahead operation in btrfs.  Add a
> > readahead_for_each_batch() iterator to optimise the loop in the XArray.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/btrfs/extent_io.c    | 46 +++++++++++++----------------------------
> >  fs/btrfs/extent_io.h    |  3 +--
> >  fs/btrfs/inode.c        | 16 +++++++-------
> >  include/linux/pagemap.h | 27 ++++++++++++++++++++++++
> >  4 files changed, 49 insertions(+), 43 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index c0f202741e09..e97a6acd6f5d 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -4278,52 +4278,34 @@ int extent_writepages(struct address_space *mapping,
> >  	return ret;
> >  }
> >  
> > -int extent_readpages(struct address_space *mapping, struct list_head *pages,
> > -		     unsigned nr_pages)
> > +void extent_readahead(struct readahead_control *rac)
> >  {
> >  	struct bio *bio = NULL;
> >  	unsigned long bio_flags = 0;
> >  	struct page *pagepool[16];
> >  	struct extent_map *em_cached = NULL;
> > -	struct extent_io_tree *tree = &BTRFS_I(mapping->host)->io_tree;
> > -	int nr = 0;
> > +	struct extent_io_tree *tree = &BTRFS_I(rac->mapping->host)->io_tree;
> >  	u64 prev_em_start = (u64)-1;
> > +	int nr;
> >  
> > -	while (!list_empty(pages)) {
> > -		u64 contig_end = 0;
> > -
> > -		for (nr = 0; nr < ARRAY_SIZE(pagepool) && !list_empty(pages);) {
> > -			struct page *page = lru_to_page(pages);
> > -
> > -			prefetchw(&page->flags);
> > -			list_del(&page->lru);
> > -			if (add_to_page_cache_lru(page, mapping, page->index,
> > -						readahead_gfp_mask(mapping))) {
> > -				put_page(page);
> > -				break;
> > -			}
> > -
> > -			pagepool[nr++] = page;
> > -			contig_end = page_offset(page) + PAGE_SIZE - 1;
> > -		}
> > +	readahead_for_each_batch(rac, pagepool, ARRAY_SIZE(pagepool), nr) {
> > +		u64 contig_start = page_offset(pagepool[0]);
> > +		u64 contig_end = page_offset(pagepool[nr - 1]) + PAGE_SIZE - 1;
> 
> So this assumes a contiguous page range is returned, right?

Yes.  That's documented in the readahead API and is the behaviour of
the code.  I mean, btrfs asserts it's true while most of the rest of
the kernel is indifferent to it, but it's the documented and actual
behaviour.

> >  
> > -		if (nr) {
> > -			u64 contig_start = page_offset(pagepool[0]);
> > +		ASSERT(contig_start + nr * PAGE_SIZE - 1 == contig_end);
> 
> Ok, yes it does. :)
> 
> I don't see how readahead_for_each_batch() guarantees that, though.

I ... don't see how it doesn't?  We start at rac->_start and iterate
through the consecutive pages in the page cache.  readahead_for_each_batch()
does assume that __do_page_cache_readahead() has its current behaviour
of putting the pages in the page cache in order, and kicks off a new
call to ->readahead() every time it has to skip an index for whatever
reason (eg page already in page cache).

> > -	if (bio)
> > -		return submit_one_bio(bio, 0, bio_flags);
> > -	return 0;
> > +	if (bio) {
> > +		if (submit_one_bio(bio, 0, bio_flags))
> > +			return;
> > +	}
> >  }
> 
> Shouldn't that just be
> 
> 	if (bio)
> 		submit_one_bio(bio, 0, bio_flags);

It should, but some overzealous person decided to mark submit_one_bio()
as __must_check, so I have to work around that.

> > +static inline unsigned int readahead_page_batch(struct readahead_control *rac,
> > +		struct page **array, unsigned int size)
> > +{
> > +	unsigned int batch = 0;
> 
> Confusing when put alongside rac->_batch_count counting the number
> of pages in the batch, and "batch" being the index into the page
> array, and they aren't the same counts....

Yes.  Renamed to 'i'.

> > +	XA_STATE(xas, &rac->mapping->i_pages, rac->_start);
> > +	struct page *page;
> > +
> > +	rac->_batch_count = 0;
> > +	xas_for_each(&xas, page, rac->_start + rac->_nr_pages - 1) {
> 
> That just iterates pages in the start,end doesn't it? What
> guarantees that this fills the array with a contiguous page range?

The behaviour of __do_page_cache_readahead().  Dave Howells also has a
usecase for xas_for_each_contig(), so I'm going to add that soon.

> > +		VM_BUG_ON_PAGE(!PageLocked(page), page);
> > +		VM_BUG_ON_PAGE(PageTail(page), page);
> > +		array[batch++] = page;
> > +		rac->_batch_count += hpage_nr_pages(page);
> > +		if (PageHead(page))
> > +			xas_set(&xas, rac->_start + rac->_batch_count);
> 
> What on earth does this do? Comments please!

		/*
		 * The page cache isn't using multi-index entries yet,
		 * so xas_for_each() won't do the right thing for
		 * large pages.  This can be removed once the page cache
		 * is converted.
		 */

> > +
> > +		if (batch == size)
> > +			break;
> > +	}
> > +
> > +	return batch;
> > +}
> 
> Seems a bit big for an inline function.

It's only called by btrfs at the moment.  If it gets more than one caller,
then sure, let's move it out of line.

> > +
> > +#define readahead_for_each_batch(rac, array, size, nr)			\
> > +	for (; (nr = readahead_page_batch(rac, array, size));		\
> > +			readahead_next(rac))
> 
> I had to go look at the caller to work out what "size" refered to
> here.
> 
> This is complex enough that it needs proper API documentation.

How about just:

-#define readahead_for_each_batch(rac, array, size, nr)                 \
-       for (; (nr = readahead_page_batch(rac, array, size));           \
+#define readahead_for_each_batch(rac, array, array_sz, nr)             \
+       for (; (nr = readahead_page_batch(rac, array, array_sz));       \

(corresponding rename in readahead_page_batch).  I mean, we could also
do:

#define readahead_for_each_batch(rac, array, nr)			\
	for (; (nr = readahead_page_batch(rac, array, ARRAY_SIZE(array)); \
			readahead_next(rac))

making it less flexible, but easier to use.
