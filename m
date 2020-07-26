Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE12D22E369
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 01:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgGZXxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 19:53:40 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:58787 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbgGZXxk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 19:53:40 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id B4C1ED7B18E;
        Mon, 27 Jul 2020 09:53:36 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jzqSV-0001Lq-3k; Mon, 27 Jul 2020 09:53:35 +1000
Date:   Mon, 27 Jul 2020 09:53:35 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Ensure iop->uptodate matches PageUptodate
Message-ID: <20200726235335.GU2005@dread.disaster.area>
References: <20200726091052.30576-1-willy@infradead.org>
 <20200726230657.GT2005@dread.disaster.area>
 <20200726232022.GH23808@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726232022.GH23808@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=GbM89rAVvsayrku5YkoA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 12:20:22AM +0100, Matthew Wilcox wrote:
> On Mon, Jul 27, 2020 at 09:06:57AM +1000, Dave Chinner wrote:
> > On Sun, Jul 26, 2020 at 10:10:52AM +0100, Matthew Wilcox (Oracle) wrote:
> > > If the filesystem has block size < page size and we end up calling
> > > iomap_page_create() in iomap_page_mkwrite_actor(), the uptodate bits
> > > would be zero, which causes us to skip writeback of blocks which are
> > > !uptodate in iomap_writepage_map().  This can lead to user data loss.
> > 
> > I'm still unclear on what condition gets us to
> > iomap_page_mkwrite_actor() without already having initialised the
> > page correctly. i.e. via a read() or write() call, or the read fault
> > prior to ->page_mkwrite() which would have marked the page uptodate
> > - that operation should have called iomap_page_create() and
> > iomap_set_range_uptodate() on the page....
> > 
> > i.e. you've described the symptom, but not the cause of the issue
> > you are addressing.
> 
> I don't know exactly what condition gets us there either.  It must be
> possible, or there wouldn't be a call to iomap_page_create() but rather
> one to to_iomap_page() like the one in iomap_finish_page_writeback().

Yes, I understand the code accepts it can happen; what I dislike is
code that asserts subtle behaviour can happen, then doesn't describe
that exactly why/how that condition can occur. And then, because we
don't know exactly how something happens, we add work arounds to
hide issues we can't reason through fully. That's .... suboptimal.

Christoph might know off the top of his head how we get into this
state. Once we work it out, then we need to add comments...

> > > reproduced on mainline using that test (the THP code causes iomap_pages
> > > to be discarded more frequently), but inspection shows it can happen
> > > with an appropriate series of operations.
> > 
> > That sequence of operations would be? 
> > 
> > > Fixes: 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O without buffer heads")
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > >  fs/iomap/buffered-io.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index a2b3b5455219..f0c5027bf33f 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -53,7 +53,10 @@ iomap_page_create(struct inode *inode, struct page *page)
> > >  	atomic_set(&iop->read_count, 0);
> > >  	atomic_set(&iop->write_count, 0);
> > >  	spin_lock_init(&iop->uptodate_lock);
> > > -	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
> > > +	if (PageUptodate(page))
> > > +		bitmap_fill(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
> > > +	else
> > > +		bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
> > 
> > I suspect this bitmap_fill call belongs in the iomap_page_mkwrite()
> > code as is the only code that can call iomap_page_create() with an
> > uptodate page. Then iomap_page_create() could just use kzalloc() and
> > drop the atomic_set() and bitmap_zero() calls altogether,
> 
> Way ahead of you
> http://git.infradead.org/users/willy/pagecache.git/commitdiff/5a1de6fc4f815797caa4a2f37c208c67afd7c20b

*nod*

I would suggest breaking that out as a separate cleanup patch and
not hide is in a patch that contains both THP modifications and bug
fixes. It stands alone as a valid cleanup.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
