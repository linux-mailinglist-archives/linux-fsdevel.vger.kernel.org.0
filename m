Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62651616AD3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 18:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiKBRfm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 13:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBRfl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:35:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0B42DAA0;
        Wed,  2 Nov 2022 10:35:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ED0761AE4;
        Wed,  2 Nov 2022 17:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9627C433D6;
        Wed,  2 Nov 2022 17:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667410538;
        bh=FwVjkMRz8G5EONaOT/VaQYLHHSojaT8ZricWsseLz4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rqwY9/BDyJN2mtdYT+oyChE7m2Q1VKJPc4b10bQCSHO0ipBnQm9jwXpEL5cUiaFGc
         4EW0+QN4wGmdscriJ4CSEqQjmCezT0ooihhyCfN3J4AegG68Q4WCbUVIMwrxu7Wp2r
         0yB9Tn01CUdYdTIk8EudiycXzRAHNVTPXNaU855pgFWO16BieOanWqiF48HOYW9gyZ
         9WyQT9a2xx/SznroQSG9Daf8skId2EHMYeCLGKcP06nm6lEOSX8DXL2Vz1C0xWs/sv
         svSv3hVPahtkpBb1IulilEAWlaU5RNd9VeH9GackjkoS4zrOR7/T0SnzdH18+MeL3x
         0AvhJxxwjrh9A==
Date:   Wed, 2 Nov 2022 10:35:38 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve
 write performance
Message-ID: <Y2Kqahg+u2HzgeQG@magnolia>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
 <20221028210422.GC3600936@dread.disaster.area>
 <Y19EXLfn8APg3adO@casper.infradead.org>
 <Y2IyTx0VwXMxzs0G@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2IyTx0VwXMxzs0G@infradead.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 02:03:11AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 31, 2022 at 03:43:24AM +0000, Matthew Wilcox wrote:
> > I agree that bufferheads do bottom-up dirty tracking, but I don't think
> > that what Ritesh is doing here is bottom-up dirty tracking.  Buffer
> > heads expose an API to dirty a block, which necessarily goes bottom-up.
> > There's no API here to dirty a block.  Instead there's an API to dirty
> > a range of a folio, so we're still top-down; we're just keeping track
> > of it in a more precise way.
> 
> Agreed.

Me three.  Er, too.

Unlike bufferheads which are scattered all over the kernel, the details
of dirty state tracking are now confined to buffered-io.c, and the
external functions remain the same.  From my POV that makes the dirty
state an implementation detail of iomap that callers don't have to care
about.

Just so long as nobody imports that nonfeature of the bufferhead code
where dirtying an already dirty bufferhead skips marking the folio dirty
and writepage failures also fail to redirty the page.  That bit us hard
recently and I strongly prefer not to repeat that.

> > If there is any dirty region, the folio must be marked dirty (otherwise
> > we'll never know that it needs to be written back).  The interesting
> > question (as your paragraph below hints) is whether removing the dirty
> > part of a folio from a file marks the folio clean.  I believe that's
> > optional, but it's probably worth doing.
> 
> Also agreed.
> 
> > > What happens with direct extent manipulation like fallocate()
> > > operations? These invalidate the parts of the page cache over the
> > > range we are punching, shifting, etc, without interacting directly
> > > with iomap, so do we now have to ensure that the sub-folio dirty
> > > regions are also invalidated correctly? i.e. do functions like
> > > xfs_flush_unmap_range() need to become iomap infrastructure so that
> > > they can update sub-folio dirty ranges correctly?
> > 
> > I'm slightly confused by this question.  As I understand the various
> > fallocate operations, they start by kicking out all the folios affected
> > by the operation (generally from the start of the operation to EOF),
> > so we'd writeback the (dirty part of) folios which are dirty, then
> > invalidate the folios in cache.  I'm not sure there's going to be
> > much difference.
> 
> Yes.  As far as I can tell all pagecache manipulation for the
> fallocate operations is driven by the file system and it is
> only done by those the punch/zero/move ranges.  The file system
> then goes though the normal pagecache truncate helpers rounded to
> the block size, which through the ops should do the right thing.

Yes, AFAICT.

> > Yes.  This is also going to be a performance problem.  Marking a folio as
> > dirty is no longer just setting the bit in struct folio and the xarray
> > but also setting all the bits in iop->state.  Depending on the size
> > of the folio, and the fs blocksize, this could be quite a lot of bits.
> > eg a 2MB folio with a 1k block size is 2048 bits (256 bytes, 6 cachelines
> > (it dirties the spinlock in cacheline 0, then the bitmap occupies 3 full
> > cachelines and 2 partial ones)).
> 
> We can always optimize by having a bit for the fairly common all dirty
> case and only track and look at the array if that is no the case.

Yes, it would help to make the ranges in the bit array better defined
than the semi-opencoded logic there is now.  (I'm whining specifically
about the test_bit calls sprinkled around).  Once that's done it
shouldn't be hard to add one more bit for the all-dirty state.  Though
I'd want to see the numbers to prove that it saves us time anywhere.

--D

> > filesystems right now.  Dave Howells' netfs infrastructure is trying
> > to solve the problem for everyone (and he's been looking at iomap as
> > inspiration for what he's doing).
> 
> Btw, I never understod why the network file systems don't just use
> iomap.  There is nothing block specific in the core iomap code.
