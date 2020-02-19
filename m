Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A548616393E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 02:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBSBXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 20:23:24 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:43320 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726795AbgBSBXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:23:24 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 36F4A3A325B;
        Wed, 19 Feb 2020 12:23:20 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j4E58-0004eU-Jt; Wed, 19 Feb 2020 12:23:18 +1100
Date:   Wed, 19 Feb 2020 12:23:18 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 11/19] btrfs: Convert from readpages to readahead
Message-ID: <20200219012318.GY10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-19-willy@infradead.org>
 <20200218065758.GQ10776@dread.disaster.area>
 <20200218211228.GF24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218211228.GF24185@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=14rPMwcjc7DfypWj1-kA:9
        a=AEfJ2Jny-4_AqVfN:21 a=ibXzlZxNEIkIBOHq:21 a=CjuIK1q_8ugA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 01:12:28PM -0800, Matthew Wilcox wrote:
> On Tue, Feb 18, 2020 at 05:57:58PM +1100, Dave Chinner wrote:
> > On Mon, Feb 17, 2020 at 10:45:59AM -0800, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
....
> > >  
> > > -		if (nr) {
> > > -			u64 contig_start = page_offset(pagepool[0]);
> > > +		ASSERT(contig_start + nr * PAGE_SIZE - 1 == contig_end);
> > 
> > Ok, yes it does. :)
> > 
> > I don't see how readahead_for_each_batch() guarantees that, though.
> 
> I ... don't see how it doesn't?  We start at rac->_start and iterate
> through the consecutive pages in the page cache.  readahead_for_each_batch()
> does assume that __do_page_cache_readahead() has its current behaviour
> of putting the pages in the page cache in order, and kicks off a new
> call to ->readahead() every time it has to skip an index for whatever
> reason (eg page already in page cache).

And there is the comment I was looking for while reading
readahead_for_each_batch() :)

> 
> > > -	if (bio)
> > > -		return submit_one_bio(bio, 0, bio_flags);
> > > -	return 0;
> > > +	if (bio) {
> > > +		if (submit_one_bio(bio, 0, bio_flags))
> > > +			return;
> > > +	}
> > >  }
> > 
> > Shouldn't that just be
> > 
> > 	if (bio)
> > 		submit_one_bio(bio, 0, bio_flags);
> 
> It should, but some overzealous person decided to mark submit_one_bio()
> as __must_check, so I have to work around that.

/me looks at code

Ngggh.

I rather dislike functions that are named in a way that look like
they belong to core kernel APIs but in reality are local static
functions.

I'd ask for this to be fixed if it was generic code, but it's btrfs
specific code so they can deal with the ugliness of their own
creation. :/

> > Confusing when put alongside rac->_batch_count counting the number
> > of pages in the batch, and "batch" being the index into the page
> > array, and they aren't the same counts....
> 
> Yes.  Renamed to 'i'.
> 
> > > +	XA_STATE(xas, &rac->mapping->i_pages, rac->_start);
> > > +	struct page *page;
> > > +
> > > +	rac->_batch_count = 0;
> > > +	xas_for_each(&xas, page, rac->_start + rac->_nr_pages - 1) {
> > 
> > That just iterates pages in the start,end doesn't it? What
> > guarantees that this fills the array with a contiguous page range?
> 
> The behaviour of __do_page_cache_readahead().  Dave Howells also has a
> usecase for xas_for_each_contig(), so I'm going to add that soon.
> 
> > > +		VM_BUG_ON_PAGE(!PageLocked(page), page);
> > > +		VM_BUG_ON_PAGE(PageTail(page), page);
> > > +		array[batch++] = page;
> > > +		rac->_batch_count += hpage_nr_pages(page);
> > > +		if (PageHead(page))
> > > +			xas_set(&xas, rac->_start + rac->_batch_count);
> > 
> > What on earth does this do? Comments please!
> 
> 		/*
> 		 * The page cache isn't using multi-index entries yet,
> 		 * so xas_for_each() won't do the right thing for
> 		 * large pages.  This can be removed once the page cache
> 		 * is converted.
> 		 */

Oh, it's changing the internal xarray lookup cursor position to
point at the correct next page index? Perhaps it's better to say
that instead of "won't do the right thing"?

> > > +#define readahead_for_each_batch(rac, array, size, nr)			\
> > > +	for (; (nr = readahead_page_batch(rac, array, size));		\
> > > +			readahead_next(rac))
> > 
> > I had to go look at the caller to work out what "size" refered to
> > here.
> > 
> > This is complex enough that it needs proper API documentation.
> 
> How about just:
> 
> -#define readahead_for_each_batch(rac, array, size, nr)                 \
> -       for (; (nr = readahead_page_batch(rac, array, size));           \
> +#define readahead_for_each_batch(rac, array, array_sz, nr)             \
> +       for (; (nr = readahead_page_batch(rac, array, array_sz));       \

Yup, that's fine - now the macro documents itself.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
