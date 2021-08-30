Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6F23FBC99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 20:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhH3SoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 14:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhH3SoW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:44:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1968EC061575;
        Mon, 30 Aug 2021 11:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HTdApohf3fKpGokZqXcDVUqyTvtY54Ltdsz34HGavd8=; b=EgOq2CKpqZ4hVB4ORDcVotdj4v
        zW4VqF6Rb++MLTTFWBAxYBeNKBVU5n2MdiA5mHBNqs66FDAmW/3GPrErUtrgQVMyo5IRi1fZCF1CZ
        FjwIWQfKdC4oIidVjoFGMcDF8SqZtRVzBA3I6xfp5wnqyhgSvG9UP/Z02RZY0S1S0Da2GbO6uA54u
        oDaq1vxhmOMbMBmrtN0dwuKQGiorsEgZcyqgaf+MThFtd5OvK/+jOV0qb6cdU0i2P4p5lyn6KQUBj
        5MctOwRLxlqT8XSNkGfHuEiczwYsh4HIRkdXix4Rc5BJN/xJIFywVvGVaz0+Jh5fHKALziiRfUJ7r
        gKQh/m2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKmFJ-000RIR-F2; Mon, 30 Aug 2021 18:43:07 +0000
Date:   Mon, 30 Aug 2021 19:43:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: Discontiguous folios/pagesets
Message-ID: <YS0mtYZ+PEAaM7pI@casper.infradead.org>
References: <YSqIry5dKg+kqAxJ@casper.infradead.org>
 <1FC3646C-259F-4AA4-B7E0-B13E19EDC595@dilger.ca>
 <20210830182818.GA9892@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830182818.GA9892@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 30, 2021 at 11:28:18AM -0700, Darrick J. Wong wrote:
> On Sat, Aug 28, 2021 at 01:27:29PM -0600, Andreas Dilger wrote:
> > On Aug 28, 2021, at 1:04 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > > 
> > > The current folio work is focused on permitting the VM to use
> > > physically contiguous chunks of memory.  Both Darrick and Johannes
> > > have pointed out the advantages of supporting logically-contiguous,
> > > physically-discontiguous chunks of memory.  Johannes wants to be able to
> > > use order-0 allocations to allocate larger folios, getting the benefit
> > > of managing the memory in larger chunks without requiring the memory
> > > allocator to be able to find contiguous chunks.  Darrick wants to support
> > > non-power-of-two block sizes.
> > 
> > What is the use case for non-power-of-two block sizes?  The main question
> > is whether that use case is important enough to add the complexity and
> > overhead in order to support it?
> 
> For copy-on-write to a XFS realtime volume where the allocation extent
> size (we support bigalloc too! :P) is not a power of two (e.g. you set
> up a 4 disk raid5 with 64k stripes, now the extent size is 192k).
> 
> Granted, I don't think folios handling 192k chunks is absolutely
> *required* for folios; the only hard requirement is that if any page in
> a 192k extent becomes dirty, the rest have to get written out all the
> same time, and the cow remap can only happen after the last page
> finishes writeback.

I /think/ "all pages get written out at the same time" is basically the
same thing as "support a non-power-of-two block size".

If we only have page A in the cache at the time it's going to be written
back, we have to read in pages B and C in order to calculate the parity P.
That will annoy writeback-because-we're-low-on-memory; I know we allow
a certain amount of allocation to happen in the writeback path, but
requiring 128kB to be allocated is a bit much.

So we have to allow page A being dirty to pin pages B and C in the cache.
I suppose that's possible; we could make (clean) pages B and C follow
page A on the LRU, so they're going to still be in RAM at the time that
page A is written back.  I don't fully understand how the LRU works,
but I assume it'd be a nightmare to ensure that A, B and C all move
around the system in the same way.  Much easier to ensure that ABC stay
linked together and all get written back at once.
