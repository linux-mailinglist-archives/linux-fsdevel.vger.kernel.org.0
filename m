Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6436670B431
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 06:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjEVEsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 00:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEVEsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 00:48:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0273E0;
        Sun, 21 May 2023 21:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sf1vUGySm93NVvSQNDSjPT97WzzcWoXQW+ZpEUsSaAo=; b=O9glmJ2RZZQQnbrQPEYVTHOzc7
        6R5Sh+GyQ2vqMtVRPituEQjV1HBhn3qfA2whgbVcPuwsUFsTVnWU/uu5pVxqQuV9m7A/u48LouDiG
        1YGsG5C9Bh3Pelp6q4kHk76DuF5bch3aPFnC0GQv2gWaQpCBG+HejCHo0jFUdoAiCBQdMsYPHGJUZ
        w/FjdWtx0RWBPHo/P5BlU0VvJupEDfxhbYHll+Zd4uWdIayMgjWh50RR/5twyWC5tiyGCnLQZOkE2
        Yw90THTxelS2Y9HVRlDJkDq/KsWmefV90W2wMFj2gGwD5Z2sO+LvkUk44sKypO26HE32Pcvq04mj5
        C7Fv8dBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q0xSw-008lzR-PJ; Mon, 22 May 2023 04:48:14 +0000
Date:   Mon, 22 May 2023 05:48:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv5 5/5] iomap: Add per-block dirty state tracking to improve
 performance
Message-ID: <ZGr0DhOFH6AwoBB0@casper.infradead.org>
References: <ZGZPJWOybo+hQVLy@casper.infradead.org>
 <87ttw5ugse.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttw5ugse.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 10:03:05AM +0530, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Thu, May 18, 2023 at 06:23:44AM -0700, Christoph Hellwig wrote:
> >> On Wed, May 17, 2023 at 02:48:12PM -0400, Brian Foster wrote:
> >> > But I also wonder.. if we can skip the iop alloc on full folio buffered
> >> > overwrites, isn't that also true of mapped writes to folios that don't
> >> > already have an iop?
> >>
> >> Yes.
> >
> > Hm, well, maybe?  If somebody stores to a page, we obviously set the
> > dirty flag on the folio, but depending on the architecture, we may
> > or may not have independent dirty bits on the PTEs (eg if it's a PMD,
> > we have one dirty bit for the entire folio; similarly if ARM uses the
> > contiguous PTE bit).  If we do have independent dirty bits, we could
> > dirty only the blocks corresponding to a single page at a time.
> >
> > This has potential for causing some nasty bugs, so I'm inclined to
> > rule that if a folio is mmaped, then it's all dirty from any writable
> > page fault.  The fact is that applications generally do not perform
> > writes through mmap because the error handling story is so poor.
> >
> > There may be a different answer for anonymous memory, but that doesn't
> > feel like my problem and shouldn't feel like any FS developer's problem.
> 
> Although I am skeptical too to do the changes which Brian is suggesting
> here. i.e. not making all the blocks of the folio dirty when we are
> going to call ->dirty_folio -> filemap_dirty_folio() (mmaped writes).
> 
> However, I am sorry but I coudn't completely follow your reasoning
> above. I think what Brian is suggesting here is that
> filemap_dirty_folio() should be similar to complete buffered overwrite
> case where we do not allocate the iop at the ->write_begin() time.
> Then at the writeback time we allocate an iop and mark all blocks dirty.
> 
> In a way it is also the similar case as for mmapped writes too but my
> only worry is the way mmaped writes work and it makes more
> sense to keep the dirty state of folio and per-block within iop in sync.
> For that matter, we can even just make sure we always allocate an iop in
> the complete overwrites case as well. I didn't change that code because
> it was kept that way for uptodate state as well and based on one of your
> inputs for complete overwrite case.
> 
> Though I agree that we should ideally be allocatting & marking all
> blocks in iop as dirty in the call to ->dirty_folio(), I just wanted to
> understand your reasoning better.

Think about it at a higher level than the implementation ("do we allocate
an iop or not").  If userspace dirties one page in a folio, should it
dirty all pages in the folio, or just the page that was actually dirtied?
I appreciate you're thinking about this from the point of view of 64kB
pages on PPC and using single-page folios, but pretend we've allocated a
1MB folio, mmaped it (or a part of it?)  and now userspace stores to it.
How much of it do we want to write back?

My argument is that this is RARE.  Userspace generally does not
mmap(MAP_SHARED), store to it and call msync() to do writes.  Writes are
almost always done using the write() syscall.  Userspace gets a lot more
control about when the writeback happens, and they actually get errors
back from the write() syscall.

If we attempt to track which pages have actually been dirtied, I worry
the fs and the mm will lose track of what the other needs to know.
eg the mm will make every page in the folio writable and then not notify
the fs when subsequent pages in the folio are stored to.

