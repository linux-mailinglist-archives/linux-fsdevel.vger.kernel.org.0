Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22DE07EF38
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 10:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389340AbfHBI14 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 04:27:56 -0400
Received: from verein.lst.de ([213.95.11.211]:50830 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfHBI14 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:27:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6415A68C65; Fri,  2 Aug 2019 10:27:53 +0200 (CEST)
Date:   Fri, 2 Aug 2019 10:27:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] iomap: Support large pages
Message-ID: <20190802082753.GA10664@lst.de>
References: <20190731171734.21601-1-willy@infradead.org> <20190731171734.21601-2-willy@infradead.org> <20190731230315.GJ7777@dread.disaster.area> <20190801035955.GI4700@bombadil.infradead.org> <20190801162147.GB25871@lst.de> <20190801174500.GL4700@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801174500.GL4700@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 10:45:00AM -0700, Matthew Wilcox wrote:
> On Thu, Aug 01, 2019 at 06:21:47PM +0200, Christoph Hellwig wrote:
> > On Wed, Jul 31, 2019 at 08:59:55PM -0700, Matthew Wilcox wrote:
> > > -       nbits = BITS_TO_LONGS(page_size(page) / SECTOR_SIZE);
> > > -       iop = kmalloc(struct_size(iop, uptodate, nbits),
> > > -                       GFP_NOFS | __GFP_NOFAIL);
> > > -       atomic_set(&iop->read_count, 0);
> > > -       atomic_set(&iop->write_count, 0);
> > > -       bitmap_zero(iop->uptodate, nbits);
> > > +       n = BITS_TO_LONGS(page_size(page) >> inode->i_blkbits);
> > > +       iop = kmalloc(struct_size(iop, uptodate, n),
> > > +                       GFP_NOFS | __GFP_NOFAIL | __GFP_ZERO);
> > 
> > I am really worried about potential very large GFP_NOFS | __GFP_NOFAIL
> > allocations here.
> 
> I don't think it gets _very_ large here.  Assuming a 4kB block size
> filesystem, that's 512 bits (64 bytes, plus 16 bytes for the two counters)
> for a 2MB page.  For machines with an 8MB PMD page, it's 272 bytes.
> Not a very nice fraction of a page size, so probably rounded up to a 512
> byte allocation, but well under the one page that the MM is supposed to
> guarantee being able to allocate.

And if we use GB pages?

Or 512-byte blocks or at least 1k blocks, which we need to handle even
if they are not preferred by any means.  The real issue here is not just
the VMs capability to allocate these by some means, but that we do
__GFP_NOFAIL allocations in nofs context.

> > And thinking about this a bit more while walking
> > at the beach I wonder if a better option is to just allocate one
> > iomap per tail page if needed rather than blowing the head page one
> > up.  We'd still always use the read_count and write_count in the
> > head page, but the bitmaps in the tail pages, which should be pretty
> > easily doable.
> 
> We wouldn't need to allocate an iomap per tail page, even.  We could
> just use one bit of tail-page->private per block.  That'd work except
> for 512-byte block size on machines with a 64kB page.  I doubt many
> people expect that combination to work well.

We'd still need to deal with the T10 PI tuples for a case like that,
though.

> 
> One of my longer-term ambitions is to do away with tail pages under
> certain situations; eg partition the memory between allocatable-as-4kB
> pages and allocatable-as-2MB pages.  We'd need a different solution for
> that, but it's a bit of a pipe dream right now anyway.

Yes, lets focus on that.  Maybe at some point we'll also get extent
based VM instead of pages ;-)
