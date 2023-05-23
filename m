Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1BD70CFED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 03:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjEWBAa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 21:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjEWBAB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 21:00:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD27FA;
        Mon, 22 May 2023 17:57:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0BA762D39;
        Tue, 23 May 2023 00:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177E5C433D2;
        Tue, 23 May 2023 00:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684803386;
        bh=iZruo3gH48R4deCEBmQEXla4d/PF9PtnixeGj8yIGqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fdS0FyKoYW20TlJ3SAjWq4KfAEAROGq5/V/IoajofA8+7N9tv61tTPDEmc0/19QLD
         IQdkdfT0gM2+sazOCKhu6QTW4OlaViG404c7W4buCsXxPhPopNaDBwdgtCLIs4iYrP
         AAakP0guMqgNs5Dc9rnmoVARcj0bFGBVAudjuv7KLKEXkhGBK/or2BdKWJVNOrnLCe
         f7WBpR7gJ9EsuNNpS65V/2B1t29XJoKUe8nxYcuulp5Xer+aXDCJPJY+J7xbCT0wAu
         YvH8t5wkK9eWeIuMkhDWObDCZOsAI1D7MWaXrLAgDGWMC2uGqkcvurTfrxUg/pBwES
         vF6BMrfAvMz3A==
Date:   Mon, 22 May 2023 17:56:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv5 5/5] iomap: Add per-block dirty state tracking to improve
 performance
Message-ID: <20230523005625.GE11620@frogsfrogsfrogs>
References: <ZGZPJWOybo+hQVLy@casper.infradead.org>
 <87ttw5ugse.fsf@doe.com>
 <ZGtPbzLtTsXChVLY@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGtPbzLtTsXChVLY@bfoster>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 07:18:07AM -0400, Brian Foster wrote:
> On Mon, May 22, 2023 at 10:03:05AM +0530, Ritesh Harjani wrote:
> > Matthew Wilcox <willy@infradead.org> writes:
> > 
> > > On Thu, May 18, 2023 at 06:23:44AM -0700, Christoph Hellwig wrote:
> > >> On Wed, May 17, 2023 at 02:48:12PM -0400, Brian Foster wrote:
> > >> > But I also wonder.. if we can skip the iop alloc on full folio buffered
> > >> > overwrites, isn't that also true of mapped writes to folios that don't
> > >> > already have an iop?
> > >>
> > >> Yes.
> > >
> > > Hm, well, maybe?  If somebody stores to a page, we obviously set the
> > > dirty flag on the folio, but depending on the architecture, we may
> > > or may not have independent dirty bits on the PTEs (eg if it's a PMD,
> > > we have one dirty bit for the entire folio; similarly if ARM uses the
> > > contiguous PTE bit).  If we do have independent dirty bits, we could
> > > dirty only the blocks corresponding to a single page at a time.
> > >
> > > This has potential for causing some nasty bugs, so I'm inclined to
> > > rule that if a folio is mmaped, then it's all dirty from any writable
> > > page fault.  The fact is that applications generally do not perform
> > > writes through mmap because the error handling story is so poor.
> > >
> > > There may be a different answer for anonymous memory, but that doesn't
> > > feel like my problem and shouldn't feel like any FS developer's problem.
> > 
> > Although I am skeptical too to do the changes which Brian is suggesting
> > here. i.e. not making all the blocks of the folio dirty when we are
> > going to call ->dirty_folio -> filemap_dirty_folio() (mmaped writes).
> > 
> > However, I am sorry but I coudn't completely follow your reasoning
> > above. I think what Brian is suggesting here is that
> > filemap_dirty_folio() should be similar to complete buffered overwrite
> > case where we do not allocate the iop at the ->write_begin() time.
> > Then at the writeback time we allocate an iop and mark all blocks dirty.
> > 
> 
> Yeah... I think what Willy is saying (i.e. to not track sub-page dirty
> granularity of intra-folio faults) makes sense, but I'm also not sure
> what it has to do with the idea of being consistent with how full folio
> overwrites are implemented (between buffered or mapped writes). We're
> not changing historical dirtying granularity either way. I think this is
> just a bigger picture thought for future consideration as opposed to
> direct feedback on this patch..

<nod>

> > In a way it is also the similar case as for mmapped writes too but my
> > only worry is the way mmaped writes work and it makes more
> > sense to keep the dirty state of folio and per-block within iop in sync.
> > For that matter, we can even just make sure we always allocate an iop in
> > the complete overwrites case as well. I didn't change that code because
> > it was kept that way for uptodate state as well and based on one of your
> > inputs for complete overwrite case.
> > 
> 
> Can you elaborate on your concerns, out of curiosity?
> 
> Either way, IMO it also seems reasonable to drop this behavior for the
> basic implementation of dirty tracking (so always allocate the iop for
> sub-folio tracking as you suggest above) and then potentially restore it
> as a separate optimization patch at the end of the series.

Agree.

> That said, I'm not totally clear why it exists in the first place, so
> that might warrant some investigation. Is it primarily to defer
> allocations out of task write/fault contexts?

(Assuming by 'it' you mean the behavior where we don't unconditionally
allocate iops for blocksize < foliosize...)

IIRC the reason is to reduce memory usage by eliding iop allocations
unless it's absolutely necessary for correctness was /my/ understanding
of why we don't always allocate the iop...

> To optimize the case where pagecache is dirtied but truncated or
> something and thus never written back?

...because this might very well happen.  Write a temporary .o file to
the filesystem, then delete the whole thing before writeback ever gets
its hands on the file.

> Is there any room for further improvement where the alloc could be
> avoided completely for folio overwrites instead of just deferred?

Once writeback starts, though, we need the iop so that we can know when
all the writeback for that folio is actually complete, no matter how
many IOs might be in flight for that folio.  I don't know how you'd get
around this problem.

> Was that actually the case at some point and then something later
> decided the iop was needed at writeback time, leading to current
> behavior?

It's been in iomap since the beginning when we lifted it from xfs.

--D (who is now weeks behind on reviewing things and stressed out)

> Brian
> 
> > Though I agree that we should ideally be allocatting & marking all
> > blocks in iop as dirty in the call to ->dirty_folio(), I just wanted to
> > understand your reasoning better.
> > 
> > Thanks!
> > -ritesh
> > 
> 
