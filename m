Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2616070DF8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 16:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbjEWOnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 10:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbjEWOnH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 10:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF731C6
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 07:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684852938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LCKdglUCANFdGhErMzORCCoCaHXmNlH1rNWS89psq4Y=;
        b=cax2LlF+AbF6ghN+avZT4vlEkOfTykwpHd+hl1evqjrN9pYIWa8aPKTqHG4KFP5dfkkKng
        kq2ngZkXo+FRGPGARF5jNtEQcilM20jkSox7O2A7FySFxjTj3z2Kq4E46Tn47iRJjLovBP
        2YwyR+4KkdgY/0mp69QR/LJd6LfeSPs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-QSgunTtcPYeow1AuMFofbw-1; Tue, 23 May 2023 10:42:17 -0400
X-MC-Unique: QSgunTtcPYeow1AuMFofbw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f39e818cb5so50869311cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 07:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684852937; x=1687444937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCKdglUCANFdGhErMzORCCoCaHXmNlH1rNWS89psq4Y=;
        b=W4IaCAG8M76XxJNsPKA06Xa+P3JrPVRbo9LglUmAOFUWdl0gxdYn57F5lGUCDDRK8P
         Op2P5i2i/ezs1xqGeUPI5FjxVQxNtGCuHX3HKjd6lFTxLT1FR+5Ji+Vzm8i2664DG6MP
         i9wITUHKdoLPUabSJQunQy/HzFPdQkEVoVum09ZDyWup6JmDE+TEh/vwmMt8HGcb12aQ
         cq8FndYs6HIXDmNHrdUkn5YifduSJnRcr1OKS5Rw+DACdcaegFv69UHf7AkmrteExCp0
         E8t+Cpe2FBQkmKvMbq7/Mqb8wUmBguoBIDlpC4QOr6KCzK7CuqrKVnzLI8CRnCko8NpC
         WLTA==
X-Gm-Message-State: AC+VfDyvFLzTeIzLKsJH2aCR9IhWnXykx7tH7qw5DjFz5Oc0pkh5Xweh
        mrZKF8BHZbYKTj8ZZpeYj5IhmJ2WUIw12IJNUOvH+7KtSSGcxk2wNdOakP7ioha2yA9KZgW4WI8
        H+dM91zMCAcHpbwORB02iL9P8oA==
X-Received: by 2002:a05:622a:60c:b0:3f5:2840:cce with SMTP id z12-20020a05622a060c00b003f528400ccemr22749715qta.39.1684852937059;
        Tue, 23 May 2023 07:42:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4NriSSarNwFrAP/zBWH6Tdop0wKIL/+PTl8BbSTnJ0k2xny6jvvgd71AFlKJxxSrEYbYfalw==
X-Received: by 2002:a05:622a:60c:b0:3f5:2840:cce with SMTP id z12-20020a05622a060c00b003f528400ccemr22749680qta.39.1684852936625;
        Tue, 23 May 2023 07:42:16 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id w13-20020ac87e8d000000b003e4dab0776esm1299153qtj.40.2023.05.23.07.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:42:16 -0700 (PDT)
Date:   Tue, 23 May 2023 10:44:47 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv5 5/5] iomap: Add per-block dirty state tracking to improve
 performance
Message-ID: <ZGzRX9YVkAYJGLqV@bfoster>
References: <ZGyuXgGzuFWmHnsd@bfoster>
 <87pm6rupsn.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm6rupsn.fsf@doe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 07:13:04PM +0530, Ritesh Harjani wrote:
> Brian Foster <bfoster@redhat.com> writes:
> 
> > On Mon, May 22, 2023 at 05:56:25PM -0700, Darrick J. Wong wrote:
> >> On Mon, May 22, 2023 at 07:18:07AM -0400, Brian Foster wrote:
> >> > On Mon, May 22, 2023 at 10:03:05AM +0530, Ritesh Harjani wrote:
> >> > > Matthew Wilcox <willy@infradead.org> writes:
> >> > >
> >> > > > On Thu, May 18, 2023 at 06:23:44AM -0700, Christoph Hellwig wrote:
> >> > > >> On Wed, May 17, 2023 at 02:48:12PM -0400, Brian Foster wrote:
> >> > > >> > But I also wonder.. if we can skip the iop alloc on full folio buffered
> >> > > >> > overwrites, isn't that also true of mapped writes to folios that don't
> >> > > >> > already have an iop?
> >> > > >>
> >> > > >> Yes.
> >> > > >
> >> > > > Hm, well, maybe?  If somebody stores to a page, we obviously set the
> >> > > > dirty flag on the folio, but depending on the architecture, we may
> >> > > > or may not have independent dirty bits on the PTEs (eg if it's a PMD,
> >> > > > we have one dirty bit for the entire folio; similarly if ARM uses the
> >> > > > contiguous PTE bit).  If we do have independent dirty bits, we could
> >> > > > dirty only the blocks corresponding to a single page at a time.
> >> > > >
> >> > > > This has potential for causing some nasty bugs, so I'm inclined to
> >> > > > rule that if a folio is mmaped, then it's all dirty from any writable
> >> > > > page fault.  The fact is that applications generally do not perform
> >> > > > writes through mmap because the error handling story is so poor.
> >> > > >
> >> > > > There may be a different answer for anonymous memory, but that doesn't
> >> > > > feel like my problem and shouldn't feel like any FS developer's problem.
> >> > >
> >> > > Although I am skeptical too to do the changes which Brian is suggesting
> >> > > here. i.e. not making all the blocks of the folio dirty when we are
> >> > > going to call ->dirty_folio -> filemap_dirty_folio() (mmaped writes).
> >> > >
> >> > > However, I am sorry but I coudn't completely follow your reasoning
> >> > > above. I think what Brian is suggesting here is that
> >> > > filemap_dirty_folio() should be similar to complete buffered overwrite
> >> > > case where we do not allocate the iop at the ->write_begin() time.
> >> > > Then at the writeback time we allocate an iop and mark all blocks dirty.
> >> > >
> >> >
> >> > Yeah... I think what Willy is saying (i.e. to not track sub-page dirty
> >> > granularity of intra-folio faults) makes sense, but I'm also not sure
> >> > what it has to do with the idea of being consistent with how full folio
> >> > overwrites are implemented (between buffered or mapped writes). We're
> >> > not changing historical dirtying granularity either way. I think this is
> >> > just a bigger picture thought for future consideration as opposed to
> >> > direct feedback on this patch..
> >>
> >> <nod>
> >>
> >> > > In a way it is also the similar case as for mmapped writes too but my
> >> > > only worry is the way mmaped writes work and it makes more
> >> > > sense to keep the dirty state of folio and per-block within iop in sync.
> >> > > For that matter, we can even just make sure we always allocate an iop in
> >> > > the complete overwrites case as well. I didn't change that code because
> >> > > it was kept that way for uptodate state as well and based on one of your
> >> > > inputs for complete overwrite case.
> >> > >
> >> >
> >> > Can you elaborate on your concerns, out of curiosity?
> >> >
> >> > Either way, IMO it also seems reasonable to drop this behavior for the
> >> > basic implementation of dirty tracking (so always allocate the iop for
> >> > sub-folio tracking as you suggest above) and then potentially restore it
> >> > as a separate optimization patch at the end of the series.
> >>
> >> Agree.
> >>
> >> > That said, I'm not totally clear why it exists in the first place, so
> >> > that might warrant some investigation. Is it primarily to defer
> >> > allocations out of task write/fault contexts?
> >>
> >> (Assuming by 'it' you mean the behavior where we don't unconditionally
> >> allocate iops for blocksize < foliosize...)
> >>
> >> IIRC the reason is to reduce memory usage by eliding iop allocations
> >> unless it's absolutely necessary for correctness was /my/ understanding
> >> of why we don't always allocate the iop...
> >>
> >> > To optimize the case where pagecache is dirtied but truncated or
> >> > something and thus never written back?
> >>
> >> ...because this might very well happen.  Write a temporary .o file to
> >> the filesystem, then delete the whole thing before writeback ever gets
> >> its hands on the file.
> >>
> >
> > I don't think a simple temp write will trigger this scenario currently
> > because the folios would have to be uptodate at the time of the write to
> > bypass the iop alloc. I guess you'd have to read folios (even if backed
> > by holes) first to start seeing the !iop case at writeback time (for bs
> > != ps).
> >
> > That could change with these patches, but I was trying to reason about
> > the intent of the existing code and whether there was some known reason
> > to continue to try and defer the iop allocation as the need/complexity
> > for deferring it grows with the addition of more (i.e. dirty) tracking.
> >
> 
> Here is the 1st discussion/reasoning where the deferred iop allocation
> in the readpage path got discussed [1].
> And here is the discussion when I first pointed out the deferred
> allocation in writepage path. IMO, it got slipped in with the
> discussions maybe only on mailing list but nothing in the commit
> messages or comments.[2]
> 
> [1]: https://lore.kernel.org/linux-xfs/20210628172727.1894503-1-agruenba@redhat.com/
> [2]: https://lore.kernel.org/linux-xfs/20230130202150.pfohy5yg6dtu64ce@rh-tp/
> 
> >> > Is there any room for further improvement where the alloc could be
> >> > avoided completely for folio overwrites instead of just deferred?
> >>
> >> Once writeback starts, though, we need the iop so that we can know when
> >> all the writeback for that folio is actually complete, no matter how
> >> many IOs might be in flight for that folio.  I don't know how you'd get
> >> around this problem.
> >>
> >
> > Ok. I noticed some kind of counter or something being updated last time
> > I looked through that code, so it sounds like that's the reason the iop
> > eventually needs to exist. Thanks.
> >
> >> > Was that actually the case at some point and then something later
> >> > decided the iop was needed at writeback time, leading to current
> >> > behavior?
> >>
> >> It's been in iomap since the beginning when we lifted it from xfs.
> >>
> >
> > Not sure exactly what you're referring to here. iomap_writepage_map()
> > would warn on the (bs != ps && !iop) case up until commit 8e1bcef8e18d
> > ("iomap: Permit pages without an iop to enter writeback"), so I don't
> > see how iop allocs were deferred (other than when bs == ps, obviously)
> > prior to that.
> >
> > Heh, but I'm starting to get my wires crossed just trying to piece
> > things together here. Ritesh, ISTM the (writeback && !iop && bs != ps)
> > case is primarily a subtle side effect of the current writeback behavior
> > being driven by uptodate status. I think it's probably wise to drop it
> > at least initially, always alloc and dirty the appropriate iop ranges
> > for sub-folio blocks, and then if you or others think there is value in
> > the overwrite optimization to defer iop allocs, tack that on as a
> > separate patch and try to be consistent between buffered and mapped
> > writes.
> 
> Based on the discussion so far, I would like to think of this as follow:
> We already have some sort of lazy iop allocation in the buffered I/O
> path (discussed above). This patch series does not changes that
> behavior. For now I would like to keep the page mkwrite page as is
> without any lazy iop allocation optimization.
> I am ok to pick this optimization work as a seperate series
> because, IIUC, Christoph has some ideas on deferring iop allocations
> even further [2] (from link shared above).
> 
> Does that sound good?
> 

Could you do that in two steps where the buffered I/O path variant is
replaced by explicit dirty tracking in the initial patch, and then is
restored by a subsequent patch in the same series? That would allow
keeping it around and documenting it explicitly in the commit log for
the separate patch, but IMO makes this a bit easier to review (and
potentially debug/bisect if needed down the road).

But I don't insist if that's too troublesome for some reason...

Brian

> >
> > Darrick noted above that he also agrees with that separate patch
> > approach. For me, I think it would also be useful to show that there is
> > some measurable performance benefit on at least one reasonable workload
> > to help justify it.
> 
> Agree that when we work on such optimizations as a seperate series, it
> will be worth measuring the performance benefits of that.
> 
> 
> -ritesh
> 
> >
> > Brian
> >
> >> --D (who is now weeks behind on reviewing things and stressed out)
> >>
> >> > Brian
> >> >
> >> > > Though I agree that we should ideally be allocatting & marking all
> >> > > blocks in iop as dirty in the call to ->dirty_folio(), I just wanted to
> >> > > understand your reasoning better.
> >> > >
> >> > > Thanks!
> >> > > -ritesh
> >> > >
> >> >
> >>
> 

