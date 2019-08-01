Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7391E7E150
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 19:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbfHARpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 13:45:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfHARpB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tMgjBYsrubSb9pgotqA8mXtCx85t7Qpa3qg3Loua/zQ=; b=jt4hKtVOP0JruDnFEiVIbs+R4
        5Jr/p4/PDSk4xZQOJOmNoL5pmHs9yrvrN7admwjQqoOTEkO9GxfqdWGhid7xBBqLvmHVwONWt5LTF
        T+KWHP8aKH6aPKQ+DjlcDihPn6agAZQfktblmSjb4cvENxHNRIaDvqj2JRbADO6WhLOM34thWRQAJ
        xxl8y/8U3IaAvdOjWAtlQ+FC7khQvj1UjaN8MY08Xzb3YojKgOEb3gfPVGROyM3tPOPbA0XDNy7Lt
        qXSoPKF4ih9PVP4zcqLaYDCgD7NnbrSn9D5gNfpeRUDk89WlYQzgrrdeNF5/tSERP892V3Lyo7Hsp
        Me8zIzZew==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1htF8O-0004C9-4L; Thu, 01 Aug 2019 17:45:00 +0000
Date:   Thu, 1 Aug 2019 10:45:00 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] iomap: Support large pages
Message-ID: <20190801174500.GL4700@bombadil.infradead.org>
References: <20190731171734.21601-1-willy@infradead.org>
 <20190731171734.21601-2-willy@infradead.org>
 <20190731230315.GJ7777@dread.disaster.area>
 <20190801035955.GI4700@bombadil.infradead.org>
 <20190801162147.GB25871@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801162147.GB25871@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 06:21:47PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 31, 2019 at 08:59:55PM -0700, Matthew Wilcox wrote:
> > -       nbits = BITS_TO_LONGS(page_size(page) / SECTOR_SIZE);
> > -       iop = kmalloc(struct_size(iop, uptodate, nbits),
> > -                       GFP_NOFS | __GFP_NOFAIL);
> > -       atomic_set(&iop->read_count, 0);
> > -       atomic_set(&iop->write_count, 0);
> > -       bitmap_zero(iop->uptodate, nbits);
> > +       n = BITS_TO_LONGS(page_size(page) >> inode->i_blkbits);
> > +       iop = kmalloc(struct_size(iop, uptodate, n),
> > +                       GFP_NOFS | __GFP_NOFAIL | __GFP_ZERO);
> 
> I am really worried about potential very large GFP_NOFS | __GFP_NOFAIL
> allocations here.

I don't think it gets _very_ large here.  Assuming a 4kB block size
filesystem, that's 512 bits (64 bytes, plus 16 bytes for the two counters)
for a 2MB page.  For machines with an 8MB PMD page, it's 272 bytes.
Not a very nice fraction of a page size, so probably rounded up to a 512
byte allocation, but well under the one page that the MM is supposed to
guarantee being able to allocate.

> And thinking about this a bit more while walking
> at the beach I wonder if a better option is to just allocate one
> iomap per tail page if needed rather than blowing the head page one
> up.  We'd still always use the read_count and write_count in the
> head page, but the bitmaps in the tail pages, which should be pretty
> easily doable.

We wouldn't need to allocate an iomap per tail page, even.  We could
just use one bit of tail-page->private per block.  That'd work except
for 512-byte block size on machines with a 64kB page.  I doubt many
people expect that combination to work well.

One of my longer-term ambitions is to do away with tail pages under
certain situations; eg partition the memory between allocatable-as-4kB
pages and allocatable-as-2MB pages.  We'd need a different solution for
that, but it's a bit of a pipe dream right now anyway.

> Note that we'll also need to do another optimization first that I
> skipped in the initial iomap writeback path work:  We only really need
> an iomap if the blocksize is smaller than the page and there actually
> is an extent boundary inside that page.  If a (small or huge) page is
> backed by a single extent we can skip the whole iomap thing.  That is at
> least for now, because I have a series adding optional t10 protection
> information tuples (8 bytes per 512 bytes of data) to the end of
> the iomap, which would grow it quite a bit for the PI case, and would
> make also allocating the updatodate bit dynamically uglies (but not
> impossible).
> 
> Note that we'll also need to remove the line that limits the iomap
> allocation size in iomap_begin to 1024 times the page size to a better
> chance at contiguous allocations for huge page faults and generally
> avoid pointless roundtrips to the allocator.  It might or might be
> time to revisit that limit in general, not just for huge pages.

I think that's beyond my current understanding of the iomap code ;-)
