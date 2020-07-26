Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E5E22E341
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 01:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgGZXU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 19:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGZXU0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 19:20:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F16C0619D2;
        Sun, 26 Jul 2020 16:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xzjjRe0yGQi2scmBKmPbc3H6/KI4Gp5nkg73wVNYJgg=; b=aFJ14mY52Cd2VWWYfrR5YV5CZ2
        E4Fh313Z3eGOZ4n7d2mBRcNTp4OYU5YRsIPkQrZGQATQEumBSRJa1CWobF9cd5yfBaLMdHQUfNQxG
        8GCFgfY8avEL+8tTihVGJ2lQoEofydAKl94pIZCvBf92wx063r4pPNwYVgHw8HCVBi9peJnFo8UVX
        hHcqAOTaLN5Zw8oPtxDvGCcVQaGm97jS6sKwJLoc4ge770k58LW0NyGR1icc4wYUfunnjL0sazDpR
        5OU1xHQz5IE2IgWybmFOcyTZtNIUrR9Fc8ToCJ6OKVOPZib9Wbb34wxNwlusSRWr2iNdAR7VnttFM
        YCUN5SFA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzpwM-00052B-3S; Sun, 26 Jul 2020 23:20:22 +0000
Date:   Mon, 27 Jul 2020 00:20:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Ensure iop->uptodate matches PageUptodate
Message-ID: <20200726232022.GH23808@casper.infradead.org>
References: <20200726091052.30576-1-willy@infradead.org>
 <20200726230657.GT2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726230657.GT2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 09:06:57AM +1000, Dave Chinner wrote:
> On Sun, Jul 26, 2020 at 10:10:52AM +0100, Matthew Wilcox (Oracle) wrote:
> > If the filesystem has block size < page size and we end up calling
> > iomap_page_create() in iomap_page_mkwrite_actor(), the uptodate bits
> > would be zero, which causes us to skip writeback of blocks which are
> > !uptodate in iomap_writepage_map().  This can lead to user data loss.
> 
> I'm still unclear on what condition gets us to
> iomap_page_mkwrite_actor() without already having initialised the
> page correctly. i.e. via a read() or write() call, or the read fault
> prior to ->page_mkwrite() which would have marked the page uptodate
> - that operation should have called iomap_page_create() and
> iomap_set_range_uptodate() on the page....
> 
> i.e. you've described the symptom, but not the cause of the issue
> you are addressing.

I don't know exactly what condition gets us there either.  It must be
possible, or there wouldn't be a call to iomap_page_create() but rather
one to to_iomap_page() like the one in iomap_finish_page_writeback().

> > Found using generic/127 with the THP patches.  I don't think this can be
> > reproduced on mainline using that test (the THP code causes iomap_pages
> > to be discarded more frequently), but inspection shows it can happen
> > with an appropriate series of operations.
> 
> That sequence of operations would be? 
> 
> > Fixes: 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O without buffer heads")
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/iomap/buffered-io.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index a2b3b5455219..f0c5027bf33f 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -53,7 +53,10 @@ iomap_page_create(struct inode *inode, struct page *page)
> >  	atomic_set(&iop->read_count, 0);
> >  	atomic_set(&iop->write_count, 0);
> >  	spin_lock_init(&iop->uptodate_lock);
> > -	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
> > +	if (PageUptodate(page))
> > +		bitmap_fill(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
> > +	else
> > +		bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
> 
> I suspect this bitmap_fill call belongs in the iomap_page_mkwrite()
> code as is the only code that can call iomap_page_create() with an
> uptodate page. Then iomap_page_create() could just use kzalloc() and
> drop the atomic_set() and bitmap_zero() calls altogether,

Way ahead of you
http://git.infradead.org/users/willy/pagecache.git/commitdiff/5a1de6fc4f815797caa4a2f37c208c67afd7c20b
