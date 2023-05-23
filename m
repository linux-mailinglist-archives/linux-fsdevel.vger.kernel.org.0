Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77A970DFDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 17:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbjEWPDA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 11:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbjEWPC7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 11:02:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F38311B;
        Tue, 23 May 2023 08:02:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d5f65a2f7so2089939b3a.1;
        Tue, 23 May 2023 08:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684854177; x=1687446177;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HlIEfunugBEM/c0BtfS1xfk8W9CsYdDOZeP9j9Q8qLY=;
        b=kq2b3yzkbVYoggHyznonZgjfaGAZVI7tBUKbeR1sbOEMtRRxrnmE/AGUC/Hj4Ti7wi
         dPCxQnTzC57hV5Zq56FOZTdwCuC/F5KWb+ySzXDFIGX1M39vLSGn0cRiGAafwkGKzZ2N
         n64PbVZdjEocjk5SotULkSwjM9T4mKWN3HdWTH1rnwzFyhWWWubfyeGBmmoAyn9V/mmu
         I4pPSX5eMBqlOiS/89jJmjmP2v0JDeaFQq/+QqBklO7V+cG2NM8l3gBN87OKe9YKxS/O
         yazP7g0nma5O08IN2dkchraRz2SvWW9Tgg/5DeJPEtedarqy5kiIWlEAWlmF4CcxrWaC
         A0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684854177; x=1687446177;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HlIEfunugBEM/c0BtfS1xfk8W9CsYdDOZeP9j9Q8qLY=;
        b=bxXPCCTqTT/ueTink+c6+i61gnrPZiWRGd+t0oJMPtCMpNEmSz9VALAW9jyxLJejPz
         wYSolFoMzD8zYqgMWnNCHvYMnH3laibV/IHy4VdUskJ10yihi7mH8st9F1tmaVUKhG3a
         qHR7ZduI1xyJi6Q9aTyiXrdp/RHg/omFfcBNYRqx3knYN1koDDgDGiUx+ld3PFmZdwQU
         1GKCzQYDp0BDy+nlCfV0vwvZ5Wb5Wckbr3TDS4OanYzv0lP9MP865w/U+7Al7VLbgr2s
         ErRe3lFUVa8Gy0vSHrFxJoxGZfTcUUYpm8RNRUW3YCm+LPrUG8LxmTNImWawunRKiw/e
         slew==
X-Gm-Message-State: AC+VfDw8vCfvbR4ZC1deoOIb/JCmIvoYYSSsgHt+/BJUJyIHgF+RiPTx
        6qDvYGoLMkj9Gk/glNtV4pc=
X-Google-Smtp-Source: ACHHUZ43qYyicOXiHsUW4zuZwaBFkg8qHDQtcm/vl/ECEc5UhsBLQEmb9L2OsLvE6oRGSSZjB+TduQ==
X-Received: by 2002:a05:6a20:8f07:b0:105:b75e:9df6 with SMTP id b7-20020a056a208f0700b00105b75e9df6mr17456838pzk.26.1684854176462;
        Tue, 23 May 2023 08:02:56 -0700 (PDT)
Received: from rh-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7808b000000b006466d70a30esm6098712pff.91.2023.05.23.08.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 08:02:56 -0700 (PDT)
Date:   Tue, 23 May 2023 20:32:42 +0530
Message-Id: <87fs7nozu5.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv5 5/5] iomap: Add per-block dirty state tracking to improve performance
In-Reply-To: <ZGzRX9YVkAYJGLqV@bfoster>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Brian Foster <bfoster@redhat.com> writes:

> On Tue, May 23, 2023 at 07:13:04PM +0530, Ritesh Harjani wrote:
>> Brian Foster <bfoster@redhat.com> writes:
>> 
>> > On Mon, May 22, 2023 at 05:56:25PM -0700, Darrick J. Wong wrote:
>> >> On Mon, May 22, 2023 at 07:18:07AM -0400, Brian Foster wrote:
>> >> > On Mon, May 22, 2023 at 10:03:05AM +0530, Ritesh Harjani wrote:
>> >> > > Matthew Wilcox <willy@infradead.org> writes:
>> >> > >
>> >> > > > On Thu, May 18, 2023 at 06:23:44AM -0700, Christoph Hellwig wrote:
>> >> > > >> On Wed, May 17, 2023 at 02:48:12PM -0400, Brian Foster wrote:
>> >> > > >> > But I also wonder.. if we can skip the iop alloc on full folio buffered
>> >> > > >> > overwrites, isn't that also true of mapped writes to folios that don't
>> >> > > >> > already have an iop?
>> >> > > >>
>> >> > > >> Yes.
>> >> > > >
>> >> > > > Hm, well, maybe?  If somebody stores to a page, we obviously set the
>> >> > > > dirty flag on the folio, but depending on the architecture, we may
>> >> > > > or may not have independent dirty bits on the PTEs (eg if it's a PMD,
>> >> > > > we have one dirty bit for the entire folio; similarly if ARM uses the
>> >> > > > contiguous PTE bit).  If we do have independent dirty bits, we could
>> >> > > > dirty only the blocks corresponding to a single page at a time.
>> >> > > >
>> >> > > > This has potential for causing some nasty bugs, so I'm inclined to
>> >> > > > rule that if a folio is mmaped, then it's all dirty from any writable
>> >> > > > page fault.  The fact is that applications generally do not perform
>> >> > > > writes through mmap because the error handling story is so poor.
>> >> > > >
>> >> > > > There may be a different answer for anonymous memory, but that doesn't
>> >> > > > feel like my problem and shouldn't feel like any FS developer's problem.
>> >> > >
>> >> > > Although I am skeptical too to do the changes which Brian is suggesting
>> >> > > here. i.e. not making all the blocks of the folio dirty when we are
>> >> > > going to call ->dirty_folio -> filemap_dirty_folio() (mmaped writes).
>> >> > >
>> >> > > However, I am sorry but I coudn't completely follow your reasoning
>> >> > > above. I think what Brian is suggesting here is that
>> >> > > filemap_dirty_folio() should be similar to complete buffered overwrite
>> >> > > case where we do not allocate the iop at the ->write_begin() time.
>> >> > > Then at the writeback time we allocate an iop and mark all blocks dirty.
>> >> > >
>> >> >
>> >> > Yeah... I think what Willy is saying (i.e. to not track sub-page dirty
>> >> > granularity of intra-folio faults) makes sense, but I'm also not sure
>> >> > what it has to do with the idea of being consistent with how full folio
>> >> > overwrites are implemented (between buffered or mapped writes). We're
>> >> > not changing historical dirtying granularity either way. I think this is
>> >> > just a bigger picture thought for future consideration as opposed to
>> >> > direct feedback on this patch..
>> >>
>> >> <nod>
>> >>
>> >> > > In a way it is also the similar case as for mmapped writes too but my
>> >> > > only worry is the way mmaped writes work and it makes more
>> >> > > sense to keep the dirty state of folio and per-block within iop in sync.
>> >> > > For that matter, we can even just make sure we always allocate an iop in
>> >> > > the complete overwrites case as well. I didn't change that code because
>> >> > > it was kept that way for uptodate state as well and based on one of your
>> >> > > inputs for complete overwrite case.
>> >> > >
>> >> >
>> >> > Can you elaborate on your concerns, out of curiosity?
>> >> >
>> >> > Either way, IMO it also seems reasonable to drop this behavior for the
>> >> > basic implementation of dirty tracking (so always allocate the iop for
>> >> > sub-folio tracking as you suggest above) and then potentially restore it
>> >> > as a separate optimization patch at the end of the series.
>> >>
>> >> Agree.
>> >>
>> >> > That said, I'm not totally clear why it exists in the first place, so
>> >> > that might warrant some investigation. Is it primarily to defer
>> >> > allocations out of task write/fault contexts?
>> >>
>> >> (Assuming by 'it' you mean the behavior where we don't unconditionally
>> >> allocate iops for blocksize < foliosize...)
>> >>
>> >> IIRC the reason is to reduce memory usage by eliding iop allocations
>> >> unless it's absolutely necessary for correctness was /my/ understanding
>> >> of why we don't always allocate the iop...
>> >>
>> >> > To optimize the case where pagecache is dirtied but truncated or
>> >> > something and thus never written back?
>> >>
>> >> ...because this might very well happen.  Write a temporary .o file to
>> >> the filesystem, then delete the whole thing before writeback ever gets
>> >> its hands on the file.
>> >>
>> >
>> > I don't think a simple temp write will trigger this scenario currently
>> > because the folios would have to be uptodate at the time of the write to
>> > bypass the iop alloc. I guess you'd have to read folios (even if backed
>> > by holes) first to start seeing the !iop case at writeback time (for bs
>> > != ps).
>> >
>> > That could change with these patches, but I was trying to reason about
>> > the intent of the existing code and whether there was some known reason
>> > to continue to try and defer the iop allocation as the need/complexity
>> > for deferring it grows with the addition of more (i.e. dirty) tracking.
>> >
>> 
>> Here is the 1st discussion/reasoning where the deferred iop allocation
>> in the readpage path got discussed [1].
>> And here is the discussion when I first pointed out the deferred
>> allocation in writepage path. IMO, it got slipped in with the
>> discussions maybe only on mailing list but nothing in the commit
>> messages or comments.[2]
>> 
>> [1]: https://lore.kernel.org/linux-xfs/20210628172727.1894503-1-agruenba@redhat.com/
>> [2]: https://lore.kernel.org/linux-xfs/20230130202150.pfohy5yg6dtu64ce@rh-tp/
>> 
>> >> > Is there any room for further improvement where the alloc could be
>> >> > avoided completely for folio overwrites instead of just deferred?
>> >>
>> >> Once writeback starts, though, we need the iop so that we can know when
>> >> all the writeback for that folio is actually complete, no matter how
>> >> many IOs might be in flight for that folio.  I don't know how you'd get
>> >> around this problem.
>> >>
>> >
>> > Ok. I noticed some kind of counter or something being updated last time
>> > I looked through that code, so it sounds like that's the reason the iop
>> > eventually needs to exist. Thanks.
>> >
>> >> > Was that actually the case at some point and then something later
>> >> > decided the iop was needed at writeback time, leading to current
>> >> > behavior?
>> >>
>> >> It's been in iomap since the beginning when we lifted it from xfs.
>> >>
>> >
>> > Not sure exactly what you're referring to here. iomap_writepage_map()
>> > would warn on the (bs != ps && !iop) case up until commit 8e1bcef8e18d
>> > ("iomap: Permit pages without an iop to enter writeback"), so I don't
>> > see how iop allocs were deferred (other than when bs == ps, obviously)
>> > prior to that.
>> >
>> > Heh, but I'm starting to get my wires crossed just trying to piece
>> > things together here. Ritesh, ISTM the (writeback && !iop && bs != ps)
>> > case is primarily a subtle side effect of the current writeback behavior
>> > being driven by uptodate status. I think it's probably wise to drop it
>> > at least initially, always alloc and dirty the appropriate iop ranges
>> > for sub-folio blocks, and then if you or others think there is value in
>> > the overwrite optimization to defer iop allocs, tack that on as a
>> > separate patch and try to be consistent between buffered and mapped
>> > writes.
>> 
>> Based on the discussion so far, I would like to think of this as follow:
>> We already have some sort of lazy iop allocation in the buffered I/O
>> path (discussed above). This patch series does not changes that
>> behavior. For now I would like to keep the page mkwrite page as is
>> without any lazy iop allocation optimization.
>> I am ok to pick this optimization work as a seperate series
>> because, IIUC, Christoph has some ideas on deferring iop allocations
>> even further [2] (from link shared above).
>> 
>> Does that sound good?
>> 
>
> Could you do that in two steps where the buffered I/O path variant is
> replaced by explicit dirty tracking in the initial patch, and then is
> restored by a subsequent patch in the same series? That would allow

Sorry, I couldn't follow it. Can you please elaborate.

So, what I was suggesting was - for buffered I/O path we should continue
to have the lazy iop allocation scheme whereever possible.
Rest of the optimizations of further deferring the iop allocation
including in the ->mkwrite path should be dealt seperately in a later
patch series.

Also we already have a seperate patch in this series which defers the
iop allocation if the write completely overwrites the folio [1].
Earlier the behavior was that it skips it entirely if the folio was
uptodate, but since we require it for per-block dirty tracking, we
defer iop allocation only if it was a complete overwrite of the folio. 

[1]: https://lore.kernel.org/linux-xfs/ZGzRX9YVkAYJGLqV@bfoster/T/#m048d0a097f7abb09da1c12c9a02afbcc3b9d39ee


-ritesh

> keeping it around and documenting it explicitly in the commit log for
> the separate patch, but IMO makes this a bit easier to review (and
> potentially debug/bisect if needed down the road).
>
> But I don't insist if that's too troublesome for some reason...
>
> Brian
>
>> >
>> > Darrick noted above that he also agrees with that separate patch
>> > approach. For me, I think it would also be useful to show that there is
>> > some measurable performance benefit on at least one reasonable workload
>> > to help justify it.
>> 
>> Agree that when we work on such optimizations as a seperate series, it
>> will be worth measuring the performance benefits of that.
>> 
>> 
>> -ritesh
>> 
>> >
>> > Brian
>> >
>> >> --D (who is now weeks behind on reviewing things and stressed out)
>> >>
>> >> > Brian
>> >> >
>> >> > > Though I agree that we should ideally be allocatting & marking all
>> >> > > blocks in iop as dirty in the call to ->dirty_folio(), I just wanted to
>> >> > > understand your reasoning better.
>> >> > >
>> >> > > Thanks!
>> >> > > -ritesh
>> >> > >
>> >> >
>> >>
>> 
