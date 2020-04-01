Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D90219B467
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbgDAQ6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 12:58:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732304AbgDAQ6H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QHR0nBP7pmtZR6yYdoPDKX6MpzAdmD8Z8uVqLNvp6WE=; b=HSpRWlbpDXSHKtu0uqdgYyS5Jy
        itVeV0nwFq2Zqe96fLQHOwjimg38b3f6iACBH6zjoh0HNf/NYojYLBxZ6sSydlFC9PwV1x9+QNOS3
        KptknCBl+eoBFsg9W/OGOmUJAMel/f/BZE97Lh0aPds9af28vuR1Nzjf2ZMv/g14bhtauPcnjaOl3
        QAHjCa9YsKYH463citp9XtEt40PPCoX5tqnuqKN0BOEJcAAD7CJRiuVpreqTQk3sEs9nXCymEBN6R
        nOXAwrduxHzmKLfE1srQrtHGBdeOu3Tgh8ftvzCaJVjMRsnib5ll57QfawbcUHdlqKo+rXSd84KOF
        R8Zlt5Xg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJggp-0006zl-Ff; Wed, 01 Apr 2020 16:58:07 +0000
Date:   Wed, 1 Apr 2020 09:58:07 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Handle memory allocation failure in readahead
Message-ID: <20200401165807.GH21484@bombadil.infradead.org>
References: <20200401030421.17195-1-willy@infradead.org>
 <20200401043125.GD56958@magnolia>
 <20200401112321.GF21484@bombadil.infradead.org>
 <20200401164825.GC80283@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401164825.GC80283@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 01, 2020 at 09:48:25AM -0700, Darrick J. Wong wrote:
> On Wed, Apr 01, 2020 at 04:23:21AM -0700, Matthew Wilcox wrote:
> > On Tue, Mar 31, 2020 at 09:31:25PM -0700, Darrick J. Wong wrote:
> > > On Tue, Mar 31, 2020 at 08:04:21PM -0700, Matthew Wilcox wrote:
> > > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > > 
> > > > bio_alloc() can fail when we use GFP_NORETRY.  If it does, allocate
> > > > a bio large enough for a single page like mpage_readpages() does.
> > > 
> > > Why does mpage_readpages() do that?
> > > 
> > > Is this a means to guarantee some kind of forward (readahead?) progress?
> > > Forgive my ignorance, but if memory is so tight we can't allocate a bio
> > > for readahead then why not exit having accomplished nothing?
> > 
> > As far as I can tell, it's just a general fallback in mpage_readpages().
> > 
> >  * If anything unusual happens, such as:
> >  *
> >  * - encountering a page which has buffers
> >  * - encountering a page which has a non-hole after a hole
> >  * - encountering a page with non-contiguous blocks
> >  *
> >  * then this code just gives up and calls the buffer_head-based read function.
> > 
> > The actual code for that is:
> > 
> >                 args->bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
> >                                         min_t(int, args->nr_pages,
> >                                               BIO_MAX_PAGES),
> >                                         gfp);
> >                 if (args->bio == NULL)
> >                         goto confused;
> > ...
> > confused:
> >         if (args->bio)
> >                 args->bio = mpage_bio_submit(REQ_OP_READ, op_flags, args->bio);
> >         if (!PageUptodate(page))
> >                 block_read_full_page(page, args->get_block);
> >         else
> >                 unlock_page(page);
> > 
> > As the comment implies, there are a lot of 'goto confused' cases in
> > do_mpage_readpage().
> > 
> > Ideally, yes, we'd just give up on reading this page because it's
> > only readahead, and we shouldn't stall actual work in order to reclaim
> > memory so we can finish doing readahead.  However, handling a partial
> > page read is painful.  Allocating a bio big enough for a single page is
> > much easier on the mm than allocating a larger bio (for a start, it's a
> > single allocation, not a pair of allocations), so this is a reasonable
> > compromise between simplicity of code and quality of implementation.
> 
> Hmm, ok.  I'll add a comment about that:
> 
> 		/*
> 		 * If the bio_alloc fails, try it again for a single page to
> 		 * avoid having to deal with partial page reads.  This emulates
> 		 * what do_mpage_readpage does.
> 		 */
> 		if (!ctx->bio)
> 			ctx->bio = bio_alloc(orig_gfp, 1);
> 
> ...in the hopes that if anyone ever makes partial page reads less
> painful, they'll hopefully find this breadcrumb and clean up iomap too.
> 
> If that's ok,
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

That makes perfect sense; thank you.  Assuming you'll just apply it with
that change.
