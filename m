Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8948D7E004
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 18:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbfHAQVz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 12:21:55 -0400
Received: from verein.lst.de ([213.95.11.211]:44781 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfHAQVy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:21:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A955168AFE; Thu,  1 Aug 2019 18:21:48 +0200 (CEST)
Date:   Thu, 1 Aug 2019 18:21:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
        hch@lst.de, linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] iomap: Support large pages
Message-ID: <20190801162147.GB25871@lst.de>
References: <20190731171734.21601-1-willy@infradead.org> <20190731171734.21601-2-willy@infradead.org> <20190731230315.GJ7777@dread.disaster.area> <20190801035955.GI4700@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801035955.GI4700@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 08:59:55PM -0700, Matthew Wilcox wrote:
> -       nbits = BITS_TO_LONGS(page_size(page) / SECTOR_SIZE);
> -       iop = kmalloc(struct_size(iop, uptodate, nbits),
> -                       GFP_NOFS | __GFP_NOFAIL);
> -       atomic_set(&iop->read_count, 0);
> -       atomic_set(&iop->write_count, 0);
> -       bitmap_zero(iop->uptodate, nbits);
> +       n = BITS_TO_LONGS(page_size(page) >> inode->i_blkbits);
> +       iop = kmalloc(struct_size(iop, uptodate, n),
> +                       GFP_NOFS | __GFP_NOFAIL | __GFP_ZERO);

I am really worried about potential very large GFP_NOFS | __GFP_NOFAIL
allocations here.  And thinking about this a bit more while walking
at the beach I wonder if a better option is to just allocate one
iomap per tail page if needed rather than blowing the head page one
up.  We'd still always use the read_count and write_count in the
head page, but the bitmaps in the tail pages, which should be pretty
easily doable.

Note that we'll also need to do another optimization first that I
skipped in the initial iomap writeback path work:  We only really need
an iomap if the blocksize is smaller than the page and there actually
is an extent boundary inside that page.  If a (small or huge) page is
backed by a single extent we can skip the whole iomap thing.  That is at
least for now, because I have a series adding optional t10 protection
information tuples (8 bytes per 512 bytes of data) to the end of
the iomap, which would grow it quite a bit for the PI case, and would
make also allocating the updatodate bit dynamically uglies (but not
impossible).

Note that we'll also need to remove the line that limits the iomap
allocation size in iomap_begin to 1024 times the page size to a better
chance at contiguous allocations for huge page faults and generally
avoid pointless roundtrips to the allocator.  It might or might be
time to revisit that limit in general, not just for huge pages.
