Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF6372D738
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 04:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjFMCAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 22:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjFMCAU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:00:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FB1122;
        Mon, 12 Jun 2023 19:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AdecLkDwTkadE0WTYpmaGKhXM3Tc09lhCE3OQBP/JvM=; b=grut5WIsGlgQniDfjkfiGayTD1
        bw18JRGa6k9IPG7bgwlLBrF8vBaBvEdwN92DWn+SdKgDVNDPvBHhr5Y5CBZWgu9kQ9GA9Cl9HfR7s
        0KhGo0Eb/YxJZF0QgqXfAoxrxQRINaZ8UZkFIL2AilBixO20hCVL/jKHfVMNIqsI7p3iHTMJdlQ7t
        r5M9oDbtFmPymOv53nMgjSWCj88CwxA7T4fSYIyY0W2ALi9DrmhsKMm1SsVp+G42Gs5RMQQX9IMcT
        6hYpHY7x/OTV/KtpgYw2EhOar+dwpdhRa7ogRxxmRY/csP/0vPTseCEusmbOlCYhL9PEbAR2SxzJU
        Gl+8mEWg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8tKQ-003PiX-A8; Tue, 13 Jun 2023 02:00:14 +0000
Date:   Tue, 13 Jun 2023 03:00:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 6/8] filemap: Allow __filemap_get_folio to allocate
 large folios
Message-ID: <ZIfNrnUsJbcWGSD8@casper.infradead.org>
References: <20230612203910.724378-1-willy@infradead.org>
 <20230612203910.724378-7-willy@infradead.org>
 <ZIeg4Uak9meY1tZ7@dread.disaster.area>
 <ZIe7i4kklXphsfu0@casper.infradead.org>
 <ZIfGpWYNA1yd5K/l@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIfGpWYNA1yd5K/l@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 11:30:13AM +1000, Dave Chinner wrote:
> On Tue, Jun 13, 2023 at 01:42:51AM +0100, Matthew Wilcox wrote:
> > On Tue, Jun 13, 2023 at 08:49:05AM +1000, Dave Chinner wrote:
> > > On Mon, Jun 12, 2023 at 09:39:08PM +0100, Matthew Wilcox (Oracle) wrote:
> > > > Allow callers of __filemap_get_folio() to specify a preferred folio
> > > > order in the FGP flags.  This is only honoured in the FGP_CREATE path;
> > > > if there is already a folio in the page cache that covers the index,
> > > > we will return it, no matter what its order is.  No create-around is
> > > > attempted; we will only create folios which start at the specified index.
> > > > Unmodified callers will continue to allocate order 0 folios.
> > > .....
> > > > -		/* Init accessed so avoid atomic mark_page_accessed later */
> > > > -		if (fgp_flags & FGP_ACCESSED)
> > > > -			__folio_set_referenced(folio);
> > > > +		if (!mapping_large_folio_support(mapping))
> > > > +			order = 0;
> > > > +		if (order > MAX_PAGECACHE_ORDER)
> > > > +			order = MAX_PAGECACHE_ORDER;
> > > > +		/* If we're not aligned, allocate a smaller folio */
> > > > +		if (index & ((1UL << order) - 1))
> > > > +			order = __ffs(index);
> > > 
> > > If I read this right, if we pass in an unaligned index, we won't get
> > > the size of the folio we ask for?
> > 
> > Right.  That's implied by (but perhaps not obvious from) the changelog.
> > Folios are always naturally aligned in the file, so an order-4 folio
> > has to start at a multiple of 16.  If the index you pass in is not
> > a multiple of 16, we can't create an order-4 folio without starting
> > at an earlier index.
> > 
> > For a 4kB block size filesystem, that's what we want.  Applications
> > _generally_ don't write backwards, so creating an order-4 folio is just
> > wasting memory.
> > 
> > > e.g. if we want an order-4 folio (64kB) because we have a 64kB block
> > > size in the filesystem, then we have to pass in an index that
> > > order-4 aligned, yes?
> > > 
> > > I ask this, because the later iomap code that asks for large folios
> > > only passes in "pos >> PAGE_SHIFT" so it looks to me like it won't
> > > allocate large folios for anything other than large folio aligned
> > > writes, even if we need them.
> > > 
> > > What am I missing?
> > 
> > Perhaps what you're missing is that this isn't trying to solve the
> > problem of supporting a bs > ps filesystem?
> 
> No, that's not what I'm asking about. I know there's other changes
> needed to enforce minimum folio size/alignment for bs > ps.

OK.  Bringing up the 64kB block size filesystem confused me.

> What I'm asking about is when someone does a 16kB write at offset
> 12kB, they won't get a large folio allocated at all, right? Even
> though the write is large enough to enable it?

Right.

> Indeed, if we do a 1MB write at offset 4KB, we'll get 4kB at 4KB, 8KB
> and 12kB (because we can't do order-1 folios), then order-2 at 16KB,
> order-3 at 32kB, and so on until we hit offset 1MB where we will do
> an order-0 folio allocation again (because the remaining length is
> 4KB). The next 1MB write will then follow the same pattern, right?

Yes.  Assuming we get another write ...

> I think this ends up being sub-optimal and fairly non-obvious
> non-obvious behaviour from the iomap side of the fence which is
> clearly asking for high-order folios to be allocated. i.e. a small
> amount of allocate-around to naturally align large folios when the
> page cache is otherwise empty would make a big difference to the
> efficiency of non-large-folio-aligned sequential writes...

At this point we're arguing about what I/O pattern to optimise for.
I'm going for a "do no harm" approach where we only allocate exactly as
much memory as we did before.  You're advocating for a
higher-risk/higher-reward approach.

I'd prefer the low-risk approach for now; we can change it later!
I'd like to see some amount of per-fd write history (as we have per-fd
readahead history) to decide whether to allocate large folios ahead of
the current write position.  As with readahead, I'd like to see that even
doing single-byte writes can result in the allocation of large folios,
as long as the app has done enough of them.
