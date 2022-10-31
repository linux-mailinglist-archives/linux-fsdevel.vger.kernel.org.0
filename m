Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7A6612F5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 04:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJaDnc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Oct 2022 23:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJaDn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Oct 2022 23:43:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F36132;
        Sun, 30 Oct 2022 20:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g0+529g7/BZGwQhfV0sZXm4SOXToszjU7oM5nb63tCQ=; b=N3z995FrLFnpQSTxf1ya8/EM/r
        +FPn5giW6t/23Y/fX75XcvDdwJSRyBYqN6LCsOKa0z1yOXzir7/YG9XeIMzf/+oDVJ0uu2op1bL7x
        tzLiAvhiy5PQAxGI4YHJAxm/xGIFfs1Rv12OgeYanWe4enU4XKZd3foBnSACZB1uXDi33bPOk8L2O
        0rlHhi2RlEVvaKdRQD/XvG/bXsN+OUYLxdC2eXYPDAiDPGEpAADT1y/gfjf+Vh0TBnci/J2vUYox6
        fkGP7hjDl4hMDELwt5P9NAlXXvaV6kmWrCcyGeAAH+jF1TqrkZJ5R3AN7g7VXDClYhWPG4giSdL2J
        fEYVvZNw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opLhs-003NSB-H6; Mon, 31 Oct 2022 03:43:24 +0000
Date:   Mon, 31 Oct 2022 03:43:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Aravinda Herle <araherle@in.ibm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve
 write performance
Message-ID: <Y19EXLfn8APg3adO@casper.infradead.org>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
 <20221028210422.GC3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028210422.GC3600936@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 29, 2022 at 08:04:22AM +1100, Dave Chinner wrote:
> To me, this is a fundamental architecture change in the way iomap
> interfaces with the page cache and filesystems. Folio based dirty
> tracking is top down, whilst filesystem block based dirty tracking
> *needs* to be bottom up.
> 
> The bottom up approach is what bufferheads do, and it requires a
> much bigger change that just adding dirty region tracking to the
> iomap write and writeback paths.

I agree that bufferheads do bottom-up dirty tracking, but I don't think
that what Ritesh is doing here is bottom-up dirty tracking.  Buffer
heads expose an API to dirty a block, which necessarily goes bottom-up.
There's no API here to dirty a block.  Instead there's an API to dirty
a range of a folio, so we're still top-down; we're just keeping track
of it in a more precise way.

It's a legitimate complaint that there's now state that needs to be
kept in sync with the page cache.  More below ...

> That is, moving to tracking dirty regions on a filesystem block
> boundary brings back all the coherency problems we had with
> trying to keep bufferhead dirty state coherent with page dirty
> state. This was one of the major simplifications that the iomap
> infrastructure brought to the table - all the dirty tracking is done
> by the page cache, and the filesystem has nothing to do with it at
> all....
> 
> IF we are going to change this, then there needs to be clear rules
> on how iomap dirty state is kept coherent with the folio dirty
> state, and there need to be checks placed everywhere to ensure that
> the rules are followed and enforced.
> 
> So what are the rules? If the folio is dirty, it must have at least one
> dirty region? If the folio is clean, can it have dirty regions?

If there is any dirty region, the folio must be marked dirty (otherwise
we'll never know that it needs to be written back).  The interesting
question (as your paragraph below hints) is whether removing the dirty
part of a folio from a file marks the folio clean.  I believe that's
optional, but it's probably worth doing.

> What happens to the dirty regions when truncate zeros part of a page
> beyond EOF? If the iomap regions are clean, do they need to be
> dirtied? If the regions are dirtied, do they need to be cleaned?
> Does this hold for all trailing filesystem blocks in the (multipage)
> folio, of just the one that spans the new EOF?
> 
> What happens with direct extent manipulation like fallocate()
> operations? These invalidate the parts of the page cache over the
> range we are punching, shifting, etc, without interacting directly
> with iomap, so do we now have to ensure that the sub-folio dirty
> regions are also invalidated correctly? i.e. do functions like
> xfs_flush_unmap_range() need to become iomap infrastructure so that
> they can update sub-folio dirty ranges correctly?

I'm slightly confused by this question.  As I understand the various
fallocate operations, they start by kicking out all the folios affected
by the operation (generally from the start of the operation to EOF),
so we'd writeback the (dirty part of) folios which are dirty, then
invalidate the folios in cache.  I'm not sure there's going to be
much difference.

> What about the
> folio_mark_dirty()/filemap_dirty_folio()/.folio_dirty()
> infrastructure? iomap currently treats this as top down, so it
> doesn't actually call back into iomap to mark filesystem blocks
> dirty. This would need to be rearchitected to match
> block_dirty_folio() where the bufferheads on the page are marked
> dirty before the folio is marked dirty by external operations....

Yes.  This is also going to be a performance problem.  Marking a folio as
dirty is no longer just setting the bit in struct folio and the xarray
but also setting all the bits in iop->state.  Depending on the size
of the folio, and the fs blocksize, this could be quite a lot of bits.
eg a 2MB folio with a 1k block size is 2048 bits (256 bytes, 6 cachelines
(it dirties the spinlock in cacheline 0, then the bitmap occupies 3 full
cachelines and 2 partial ones)).

I don't see the necessary churn from filemap_dirty_folio() to
iomap_dirty_folio() as being a huge deal, but it's definitely a missing
piece from this RFC.

> The easy part of this problem is tracking dirty state on a
> filesystem block boundaries. The *hard part* maintaining coherency
> with the page cache, and none of that has been done yet. I'd prefer
> that we deal with this problem once and for all at the page cache
> level because multi-page folios mean even when the filesystem block
> is the same as PAGE_SIZE, we have this sub-folio block granularity
> tracking issue.
> 
> As it is, we already have the capability for the mapping tree to
> have multiple indexes pointing to the same folio - perhaps it's time
> to start thinking about using filesystem blocks as the mapping tree
> index rather than PAGE_SIZE chunks, so that the page cache can then
> track dirty state on filesystem block boundaries natively and
> this whole problem goes away. We have to solve this sub-folio dirty
> tracking problem for multi-page folios anyway, so it seems to me
> that we should solve the sub-page block size dirty tracking problem
> the same way....

That's an interesting proposal.  From the page cache's point of
view right now, there is only one dirty bit per folio, not per page.
Anything you see contrary to that is old code that needs to be converted.
So even indexing the page cache by block offset rather than page offset
wouldn't help.

We have a number of people looking at the analogous problem for network
filesystems right now.  Dave Howells' netfs infrastructure is trying
to solve the problem for everyone (and he's been looking at iomap as
inspiration for what he's doing).  I'm kind of hoping we end up with one
unified solution that can be used for all filesystems that want sub-folio
dirty tracking.  His solution is a bit more complex than I really want
to see, at least partially because he's trying to track dirtiness at
byte granularity, no matter how much pain that causes to the server.
