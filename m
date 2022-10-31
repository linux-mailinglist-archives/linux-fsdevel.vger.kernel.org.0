Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C1B613392
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 11:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiJaK12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 06:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiJaK1S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:27:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270DFD11B;
        Mon, 31 Oct 2022 03:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dF+mjpKrM+ieCUW6dnuDNyobp/Omb5rzjfi/G66lDF4=; b=hfCa9dyOrHctmrHaXlYwvJJBqT
        t4r0KzZf2pbQnnmDgrfYXlmHnYzmM8tMJgwnZhzj2wZlczGii1ZlSxpPRvsA6hvYln88xrAJqL2lx
        GhQw3gBPPN7/fQ8LBT8wc4er/tCPo/8YNwwUaK+ABRn/lYMNeAzvKwrTZyQs3E3f7Uwla/UVdO16K
        vAF7ItqiaEGCDPl1j+qGDLIhmzt/B3nabPp2H5fAX67U6i8BvKKxWz2M1apCJZRTfj5J0qzCeXiCW
        3UThDiu3AuikF5Bq3HknkNgtRCe6XyXwfsloe8E1qewgiiMozvL/RB6pywCUWtqKerhovA5zOGQZQ
        DdF7U08g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opS0i-003ati-SB; Mon, 31 Oct 2022 10:27:16 +0000
Date:   Mon, 31 Oct 2022 10:27:16 +0000
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
Message-ID: <Y1+jBDLHovtsXbyF@casper.infradead.org>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
 <20221028210422.GC3600936@dread.disaster.area>
 <Y19EXLfn8APg3adO@casper.infradead.org>
 <20221031070853.GL3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031070853.GL3600936@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 06:08:53PM +1100, Dave Chinner wrote:
> On Mon, Oct 31, 2022 at 03:43:24AM +0000, Matthew Wilcox wrote:
> > On Sat, Oct 29, 2022 at 08:04:22AM +1100, Dave Chinner wrote:
> > > As it is, we already have the capability for the mapping tree to
> > > have multiple indexes pointing to the same folio - perhaps it's time
> > > to start thinking about using filesystem blocks as the mapping tree
> > > index rather than PAGE_SIZE chunks, so that the page cache can then
> > > track dirty state on filesystem block boundaries natively and
> > > this whole problem goes away. We have to solve this sub-folio dirty
> > > tracking problem for multi-page folios anyway, so it seems to me
> > > that we should solve the sub-page block size dirty tracking problem
> > > the same way....
> > 
> > That's an interesting proposal.  From the page cache's point of
> > view right now, there is only one dirty bit per folio, not per page.
> 
> Per folio, yes, but I thought we also had a dirty bit per index
> entry in the mapping tree. Writeback code uses the
> PAGECACHE_TAG_DIRTY mark to find the dirty folios efficiently (i.e.
> the write_cache_pages() iterator), so it's not like this is
> something new. i.e. we already have coherent, external dirty bit
> tracking mechanisms outside the folio itself that filesystems
> use.

That bit only exists (logically) for the canonical entry.  Physically
it exists for sibling entries, but it's not used; attempting to set
it on sibling entries will redirect to set it on the canonical entry.
That could be changed, but we elide entire layers of the tree once the
entry has a sufficiently high order.  So an order-6 folio occupies
a single slot one layer up; an order-7 folio occupies two slots, an
order-8 folio occupies four slots and so on.

My eventual goal is to ditch the radix tree and use the Maple Tree
(ie a B-tree), and that will always only have one slot per folio, no
matter what order it has.  Then there really only will be one bit per
folio.

> > We have a number of people looking at the analogous problem for network
> > filesystems right now.  Dave Howells' netfs infrastructure is trying
> > to solve the problem for everyone (and he's been looking at iomap as
> > inspiration for what he's doing).  I'm kind of hoping we end up with one
> > unified solution that can be used for all filesystems that want sub-folio
> > dirty tracking.  His solution is a bit more complex than I really want
> > to see, at least partially because he's trying to track dirtiness at
> > byte granularity, no matter how much pain that causes to the server.
> 
> Byte range granularity is probably overkill for block based
> filesystems - all we need is a couple of extra bits per block to be
> stored in the mapping tree alongside the folio....

I think it's overkill for network filesystems too.  By sending a
sector-misaligned write to the server, you force the server to do a R-M-W
before it commits the write to storage.  Assuming that the file has fallen
out of the server's cache, and a sufficiently busy server probably doesn't
have the memory capacity for the working set of all of its clients.

Anyway, Dave's plan for dirty tracking (as I understand the current
iteration) is to not store it linked from folio->private at all, but to
store it in a per-file tree of writes.  Then we wouldn't walk the page
cache looking for dirty folios, but walk the tree of writes choosing
which ones to write back and delete from the tree.  I don't know how
this will perform in practice, but it'll be generic enough to work for
any filesystem.
