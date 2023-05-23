Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90F170DC0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjEWMNn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjEWMNm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14496119
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 05:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684843978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8wgc3k1CCGjazVA4UB27OirrT++KZ9z1N6h1KRXfnHE=;
        b=AapTwxg2x2s7L8AabQbDr7q862ArDBdP04EbeUdmqQhLBFkC2BXdkdVWSSmvwTOQA9K6ra
        zpOqNZ07EsKB/jzMs40N75I61cov4nZXDiBNW1D8VrAjPqkBJbANj+2MITjNwlEhZzA68v
        uYTxbVKOD7ChROSjw1Iaqf/Pww8Mv+4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631--Pagq1LHPTWopLxWfkrTYA-1; Tue, 23 May 2023 08:12:57 -0400
X-MC-Unique: -Pagq1LHPTWopLxWfkrTYA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75b02585128so226079285a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 05:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684843976; x=1687435976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wgc3k1CCGjazVA4UB27OirrT++KZ9z1N6h1KRXfnHE=;
        b=iPwZSOm0RPn/1/4EqIPh5sve8urYPQOzTnlYSyEVMxDoAnxLNlUO1c70uLWilkE8tt
         LJ+VZ05nR9LupeJZDYgzggeZC/JZGAHahFWINpvwj7n0Rnopni3ShVTJVlnzhI5JrEWM
         DbSyNxLy3A+aBF6VpV7fGPAUdyBZRJWkbR15LFRP8jbvC8hJVyvMGEiGCAqoR2Boqqme
         9zxtW2091ZEsmjDRmxPByANmo81B+ShX1ZMrDOHcsMkLFxucKXedp58B5O0/KJ/auc0p
         lMKz6ptzccgqnFVuoxMRBKV5TXZXfJLgqisqlEFgLLISbLpo7bS/GLoSdEkvpSpJ8AWh
         ni0w==
X-Gm-Message-State: AC+VfDyfcN0C4lzD3mQsvdnc7WSYIHpPNtYxvHfhYQs6nFegonDFAHNk
        PZ8Q3dnsITu2ZkR/qjMdth65bjeOELiexd7xC8Pp/v3JAGljE2BjInooXlYjqT/vIjSDDhfKw29
        /GJMpIrTlpH0oAVwsmKz4tEbVVA==
X-Received: by 2002:a37:64ce:0:b0:75b:23a1:8332 with SMTP id y197-20020a3764ce000000b0075b23a18332mr3563533qkb.45.1684843976543;
        Tue, 23 May 2023 05:12:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7FNkqDXRhHLpGl5jkYMW3QxNiJUEZw7VIA9JBUhK18M3anBBvU035ZO7EqdGjmP91UAt3G6w==
X-Received: by 2002:a37:64ce:0:b0:75b:23a1:8332 with SMTP id y197-20020a3764ce000000b0075b23a18332mr3563516qkb.45.1684843976247;
        Tue, 23 May 2023 05:12:56 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a123200b007590aa4b115sm2432341qkj.87.2023.05.23.05.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 05:12:55 -0700 (PDT)
Date:   Tue, 23 May 2023 08:15:26 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
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
Message-ID: <ZGyuXgGzuFWmHnsd@bfoster>
References: <ZGZPJWOybo+hQVLy@casper.infradead.org>
 <87ttw5ugse.fsf@doe.com>
 <ZGtPbzLtTsXChVLY@bfoster>
 <20230523005625.GE11620@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523005625.GE11620@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 05:56:25PM -0700, Darrick J. Wong wrote:
> On Mon, May 22, 2023 at 07:18:07AM -0400, Brian Foster wrote:
> > On Mon, May 22, 2023 at 10:03:05AM +0530, Ritesh Harjani wrote:
> > > Matthew Wilcox <willy@infradead.org> writes:
> > > 
> > > > On Thu, May 18, 2023 at 06:23:44AM -0700, Christoph Hellwig wrote:
> > > >> On Wed, May 17, 2023 at 02:48:12PM -0400, Brian Foster wrote:
> > > >> > But I also wonder.. if we can skip the iop alloc on full folio buffered
> > > >> > overwrites, isn't that also true of mapped writes to folios that don't
> > > >> > already have an iop?
> > > >>
> > > >> Yes.
> > > >
> > > > Hm, well, maybe?  If somebody stores to a page, we obviously set the
> > > > dirty flag on the folio, but depending on the architecture, we may
> > > > or may not have independent dirty bits on the PTEs (eg if it's a PMD,
> > > > we have one dirty bit for the entire folio; similarly if ARM uses the
> > > > contiguous PTE bit).  If we do have independent dirty bits, we could
> > > > dirty only the blocks corresponding to a single page at a time.
> > > >
> > > > This has potential for causing some nasty bugs, so I'm inclined to
> > > > rule that if a folio is mmaped, then it's all dirty from any writable
> > > > page fault.  The fact is that applications generally do not perform
> > > > writes through mmap because the error handling story is so poor.
> > > >
> > > > There may be a different answer for anonymous memory, but that doesn't
> > > > feel like my problem and shouldn't feel like any FS developer's problem.
> > > 
> > > Although I am skeptical too to do the changes which Brian is suggesting
> > > here. i.e. not making all the blocks of the folio dirty when we are
> > > going to call ->dirty_folio -> filemap_dirty_folio() (mmaped writes).
> > > 
> > > However, I am sorry but I coudn't completely follow your reasoning
> > > above. I think what Brian is suggesting here is that
> > > filemap_dirty_folio() should be similar to complete buffered overwrite
> > > case where we do not allocate the iop at the ->write_begin() time.
> > > Then at the writeback time we allocate an iop and mark all blocks dirty.
> > > 
> > 
> > Yeah... I think what Willy is saying (i.e. to not track sub-page dirty
> > granularity of intra-folio faults) makes sense, but I'm also not sure
> > what it has to do with the idea of being consistent with how full folio
> > overwrites are implemented (between buffered or mapped writes). We're
> > not changing historical dirtying granularity either way. I think this is
> > just a bigger picture thought for future consideration as opposed to
> > direct feedback on this patch..
> 
> <nod>
> 
> > > In a way it is also the similar case as for mmapped writes too but my
> > > only worry is the way mmaped writes work and it makes more
> > > sense to keep the dirty state of folio and per-block within iop in sync.
> > > For that matter, we can even just make sure we always allocate an iop in
> > > the complete overwrites case as well. I didn't change that code because
> > > it was kept that way for uptodate state as well and based on one of your
> > > inputs for complete overwrite case.
> > > 
> > 
> > Can you elaborate on your concerns, out of curiosity?
> > 
> > Either way, IMO it also seems reasonable to drop this behavior for the
> > basic implementation of dirty tracking (so always allocate the iop for
> > sub-folio tracking as you suggest above) and then potentially restore it
> > as a separate optimization patch at the end of the series.
> 
> Agree.
> 
> > That said, I'm not totally clear why it exists in the first place, so
> > that might warrant some investigation. Is it primarily to defer
> > allocations out of task write/fault contexts?
> 
> (Assuming by 'it' you mean the behavior where we don't unconditionally
> allocate iops for blocksize < foliosize...)
> 
> IIRC the reason is to reduce memory usage by eliding iop allocations
> unless it's absolutely necessary for correctness was /my/ understanding
> of why we don't always allocate the iop...
> 
> > To optimize the case where pagecache is dirtied but truncated or
> > something and thus never written back?
> 
> ...because this might very well happen.  Write a temporary .o file to
> the filesystem, then delete the whole thing before writeback ever gets
> its hands on the file.
> 

I don't think a simple temp write will trigger this scenario currently
because the folios would have to be uptodate at the time of the write to
bypass the iop alloc. I guess you'd have to read folios (even if backed
by holes) first to start seeing the !iop case at writeback time (for bs
!= ps).

That could change with these patches, but I was trying to reason about
the intent of the existing code and whether there was some known reason
to continue to try and defer the iop allocation as the need/complexity
for deferring it grows with the addition of more (i.e. dirty) tracking.

> > Is there any room for further improvement where the alloc could be
> > avoided completely for folio overwrites instead of just deferred?
> 
> Once writeback starts, though, we need the iop so that we can know when
> all the writeback for that folio is actually complete, no matter how
> many IOs might be in flight for that folio.  I don't know how you'd get
> around this problem.
> 

Ok. I noticed some kind of counter or something being updated last time
I looked through that code, so it sounds like that's the reason the iop
eventually needs to exist. Thanks.

> > Was that actually the case at some point and then something later
> > decided the iop was needed at writeback time, leading to current
> > behavior?
> 
> It's been in iomap since the beginning when we lifted it from xfs.
> 

Not sure exactly what you're referring to here. iomap_writepage_map()
would warn on the (bs != ps && !iop) case up until commit 8e1bcef8e18d
("iomap: Permit pages without an iop to enter writeback"), so I don't
see how iop allocs were deferred (other than when bs == ps, obviously)
prior to that.

Heh, but I'm starting to get my wires crossed just trying to piece
things together here. Ritesh, ISTM the (writeback && !iop && bs != ps)
case is primarily a subtle side effect of the current writeback behavior
being driven by uptodate status. I think it's probably wise to drop it
at least initially, always alloc and dirty the appropriate iop ranges
for sub-folio blocks, and then if you or others think there is value in
the overwrite optimization to defer iop allocs, tack that on as a
separate patch and try to be consistent between buffered and mapped
writes.

Darrick noted above that he also agrees with that separate patch
approach. For me, I think it would also be useful to show that there is
some measurable performance benefit on at least one reasonable workload
to help justify it.

Brian

> --D (who is now weeks behind on reviewing things and stressed out)
> 
> > Brian
> > 
> > > Though I agree that we should ideally be allocatting & marking all
> > > blocks in iop as dirty in the call to ->dirty_folio(), I just wanted to
> > > understand your reasoning better.
> > > 
> > > Thanks!
> > > -ritesh
> > > 
> > 
> 

