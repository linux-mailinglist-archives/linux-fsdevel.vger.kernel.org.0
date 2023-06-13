Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80F972D684
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 02:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbjFMAm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 20:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjFMAm5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 20:42:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4355B197;
        Mon, 12 Jun 2023 17:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p7aw0VIsZS7Nht2qNh9pInAE4cDjMXwvVzTJV++TJ18=; b=Oa7yGVO4QLU5iHwKdEBisWwj6g
        Dfn3h0LAbAx9d1afS+ERlQklZ16sjepLfWcBT6B1hJ2aqQk5VWaPukWSVnnsBILqu+nqVVZI5+PS3
        ndVA+tsFlG3jkyT3nlsLyVFgfxyZAIrEL3G18x4v//HlCGZ+EBh0ZuYi+bxEozLcyDLHS8hn0rctM
        WnN60qur4j292dFhLFsdiEQ+/B+IZ0lpCbPLaMmG9cjlIgLtu5yV3XRHJ1M7EU9Ql+6cBmRHlmqiI
        fvycyf26CBNVe9+7EARU5x4fYc9oDGEPxvYkk3A2g7rnCLafqpj4BopGF9EXorA9UeXsPxz5+BYAy
        PQ2AbWTw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8s7X-003L19-3f; Tue, 13 Jun 2023 00:42:51 +0000
Date:   Tue, 13 Jun 2023 01:42:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 6/8] filemap: Allow __filemap_get_folio to allocate
 large folios
Message-ID: <ZIe7i4kklXphsfu0@casper.infradead.org>
References: <20230612203910.724378-1-willy@infradead.org>
 <20230612203910.724378-7-willy@infradead.org>
 <ZIeg4Uak9meY1tZ7@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIeg4Uak9meY1tZ7@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 08:49:05AM +1000, Dave Chinner wrote:
> On Mon, Jun 12, 2023 at 09:39:08PM +0100, Matthew Wilcox (Oracle) wrote:
> > Allow callers of __filemap_get_folio() to specify a preferred folio
> > order in the FGP flags.  This is only honoured in the FGP_CREATE path;
> > if there is already a folio in the page cache that covers the index,
> > we will return it, no matter what its order is.  No create-around is
> > attempted; we will only create folios which start at the specified index.
> > Unmodified callers will continue to allocate order 0 folios.
> .....
> > -		/* Init accessed so avoid atomic mark_page_accessed later */
> > -		if (fgp_flags & FGP_ACCESSED)
> > -			__folio_set_referenced(folio);
> > +		if (!mapping_large_folio_support(mapping))
> > +			order = 0;
> > +		if (order > MAX_PAGECACHE_ORDER)
> > +			order = MAX_PAGECACHE_ORDER;
> > +		/* If we're not aligned, allocate a smaller folio */
> > +		if (index & ((1UL << order) - 1))
> > +			order = __ffs(index);
> 
> If I read this right, if we pass in an unaligned index, we won't get
> the size of the folio we ask for?

Right.  That's implied by (but perhaps not obvious from) the changelog.
Folios are always naturally aligned in the file, so an order-4 folio
has to start at a multiple of 16.  If the index you pass in is not
a multiple of 16, we can't create an order-4 folio without starting
at an earlier index.

For a 4kB block size filesystem, that's what we want.  Applications
_generally_ don't write backwards, so creating an order-4 folio is just
wasting memory.

> e.g. if we want an order-4 folio (64kB) because we have a 64kB block
> size in the filesystem, then we have to pass in an index that
> order-4 aligned, yes?
> 
> I ask this, because the later iomap code that asks for large folios
> only passes in "pos >> PAGE_SHIFT" so it looks to me like it won't
> allocate large folios for anything other than large folio aligned
> writes, even if we need them.
> 
> What am I missing?

Perhaps what you're missing is that this isn't trying to solve the
problem of supporting a bs > ps filesystem?  That's also a worthwhile
project, but it's not this project.  In fact, I'd say that project is
almost orthogonal to this one; for this usage we can always fall back to
smaller folios on memory pressure or misalignment.  For a bs > ps block
device, we have to allocate folios at least as large as the blocksize
and cannot fall back to smaller folios.  For a bs > ps filesystem on a
bdev with bs == ps, we can fall back (as your prototype showed).
