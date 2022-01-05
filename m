Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC844853E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 14:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbiAEN4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 08:56:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240446AbiAEN4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 08:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641390997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAnb9ExP59W1WcCw2keeKsSqnGFwaEvZYymHit+h4EI=;
        b=fTYujzEax7ok53pvTqwmAvNpOthD7mNk7NgG15FvgKPnznW07PEdhuRBReNQ9ZLIybEU3R
        Ix2zaklekSKIR4BRqnpkXIU72rxpHKuC1zEL82oDpqD0DlM9t68CQbBnEg2jKcSBszMLo9
        K/EOfACHU9kvMe1v+VLRivlOv4A27Tg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-fm-E3BaKNJWhSZvvs5iBgQ-1; Wed, 05 Jan 2022 08:56:37 -0500
X-MC-Unique: fm-E3BaKNJWhSZvvs5iBgQ-1
Received: by mail-qk1-f197.google.com with SMTP id q5-20020a05620a0d8500b004738c1b48beso23151504qkl.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jan 2022 05:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lAnb9ExP59W1WcCw2keeKsSqnGFwaEvZYymHit+h4EI=;
        b=tnsd3koI/MJFr3q4XVRRzxbxIZ6uQrxoyineTFQC3jVreNHsrEko3tlK/l08NghU3A
         Cs4X6doh8fotq/OkqyZZ478ck6K/hGgOfq6BfbVULk70pPLsSAS7G6NRSe14Y+cHdeLe
         qOeEL3MGalPi2bZuaXSfakp9zCHrzUE1Aus3jUmLPET4yDWt98iIH4Qu8UZZtU+kexQb
         C7fi8+ru4K85MXjDDe88/iiDVNZyeP7L/mFL7ZRd/qPmLgGLmbMb/Hjfpd8UYUgkxf0z
         gk8T1tzJM4rEEv9d2wqJufLRTRvAvZmCiW2Vzf3Pz5yJN/sSsUUEjaI9e2tSuJvRDeMN
         jjDw==
X-Gm-Message-State: AOAM5315i8JnAPD+XB+BWJEJiF3Dghm5DwUxav7l9Ppgi9XbcaOyzbA9
        5UymEUyGdLEYa78evN/ynJwcVXsxB7Gzo8EB7IEH0Qxnj3/AFhGtdgBAI33fAK6Psk5uRDDPVqL
        /wScnth7Ss9LstevnFdPf0vGj0g==
X-Received: by 2002:a05:622a:5d2:: with SMTP id d18mr48565496qtb.154.1641390996343;
        Wed, 05 Jan 2022 05:56:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLR1ABO1/WYGPP2Y/t4JrQrCYiXSEhy35dlzb+duuFRPMjZDF5icGiWJ/ql+fcnfkoGDzDYg==
X-Received: by 2002:a05:622a:5d2:: with SMTP id d18mr48565477qtb.154.1641390995995;
        Wed, 05 Jan 2022 05:56:35 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id s126sm31397679qkf.7.2022.01.05.05.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 05:56:35 -0800 (PST)
Date:   Wed, 5 Jan 2022 08:56:33 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <YdWjkW7hhbTl4TQa@bfoster>
References: <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <YdPyhpdxykDscMtJ@infradead.org>
 <YdSNGAupnxF/ouis@casper.infradead.org>
 <YdSOgyvDnZadYpUP@infradead.org>
 <20220104192227.GA398655@magnolia>
 <20220104215227.GJ945095@dread.disaster.area>
 <20220104231230.GG31606@magnolia>
 <20220105021022.GL945095@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105021022.GL945095@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 05, 2022 at 01:10:22PM +1100, Dave Chinner wrote:
> On Tue, Jan 04, 2022 at 03:12:30PM -0800, Darrick J. Wong wrote:
> > On Wed, Jan 05, 2022 at 08:52:27AM +1100, Dave Chinner wrote:
> > > On Tue, Jan 04, 2022 at 11:22:27AM -0800, Darrick J. Wong wrote:
> > > > On Tue, Jan 04, 2022 at 10:14:27AM -0800, hch@infradead.org wrote:
> > > > > On Tue, Jan 04, 2022 at 06:08:24PM +0000, Matthew Wilcox wrote:
> > > > > > I think it's fine to put in a fix like this now that's readily
> > > > > > backportable.  For folios, I can't help but think we want a
> > > > > > restructuring to iterate per-extent first, then per-folio and finally
> > > > > > per-sector instead of the current model where we iterate per folio,
> > > > > > looking up the extent for each sector.
> > > > > 
> > > > > We don't look up the extent for each sector.  We look up the extent
> > > > > once and then add as much of it as we can to the bio until either the
> > > > > bio is full or the extent ends.  In the first case we then allocate
> > > > > a new bio and add it to the ioend.
> > > > 
> > > > Can we track the number of folios that have been bio_add_folio'd to the
> > > > iomap_ioend, and make iomap_can_add_to_ioend return false when the
> > > > number of folios reaches some threshold?  I think that would solve the
> > > > problem of overly large ioends while not splitting folios across ioends
> > > > unnecessarily.
> > > 
> > > See my reply to Christoph up thread.
> > > 
> > > The problem is multiple blocks per page/folio - bio_add_folio() will
> > > get called for the same folio many times, and we end up not knowing
> > > when a new page/folio is attached. Hence dynamically calculating it
> > > as we build the bios is .... convoluted.
> > 
> > Hm.  Indulge me in a little more frame-shifting for a moment --
> > 
> > As I see it, the problem here is that we're spending too much time
> > calling iomap_finish_page_writeback over and over and over, right?
> > 

I think the fundamental problem is an excessively large page list that
requires a tight enough loop in iomap_finish_ioend() with no opportunity
for scheduling. AIUI, this can occur a few different ways atm. The first
is a large bio chain associated with an ioend. Another potential vector
is a series of large bio vecs, since IIUC a vector can cover something
like 4GB worth of pages if physically contiguous. Since Trond's instance
seems to be via the completion workqueue, yet another vector is likely
via a chain of merged ioends.

IOW, I think there is potential for such a warning in either of the two
loops in iomap_finish_ioend() or the ioend loop in iomap_finish_ioends()
depending on circumstance. Trond's earlier feedback on his initial patch
(i.e. without ioend size capping) suggests he's hitting more of the bio
chain case, since a cond_resched() in the bio iteration loop in
iomap_finish_ioend() mitigated the problem but lifting it outside into
iomap_finish_ioends() did not.

> > If we have a single page with a single mapping that fits in a single
> > bio, that means we call bio_add_page once, and on the other end we call
> > iomap_finish_page_writeback once.
> > 
> > If we have (say) an 8-page folio with 4 blocks per page, in the worst
> > case we'd create 32 different ioends, each with a single-block bio,
> > which means 32 calls to iomap_finish_page_writeback, right?
> 
> Yes, but in this case, we've had to issue and complete 32 bios and
> ioends to get one call to end_page_writeback(). That is overhead we
> cannot avoid if we have worst-case physical fragmentation of the
> filesystem. But, quite frankly, if that's the case we just don't
> care about performance of IO completion - performance will suck
> because we're doing 32 IOs instead of 1 for that data, not because
> IO completion has to do more work per page/folio....
> 
> > From what I can see, the number of bio_add_folio calls is proportional
> > to the amount of ioend work we do without providing any external signs
> > of life to the watchdog, right?
> > 
> > So forget the number of folios or the byte count involved.  Isn't the
> > number of future iomap_finish_page_writeback calls exactly the metric
> > that we want to decide when to cut off ioend submission?
> 
> Isn't that exactly what I suggested by counting bio segments in the
> ioend at bio submission time? I mean, iomap_finish_page_writeback()
> iterates bio segments, not pages, folios or filesystem blocks....
> 
> > > Hence generic iomap code will only end up calling
> > > iomap_finish_ioends() with the same ioend that was submitted. i.e.
> > > capped to 4096 pages by this patch. THerefore it does not need
> > > cond_resched() calls - the place that needs it is where the ioends
> > > are merged and then finished. That is, in the filesystem completion
> > > processing that does the merging....
> > 
> > Huh?  I propose adding cond_resched to iomap_finish_ioends (plural),
> 
> Which is only called from XFS on merged ioends after XFS has
> processed the merged ioend.....
> 
> > which walks a list of ioends and calls iomap_finish_ioend (singular) on
> > each ioend.  IOWs, we'd call cond_resched in between finishing one ioend
> > and starting on the next one.  Isn't that where ioends are finished?
> > 
> > (I'm starting to wonder if we're talking past each other?)
> > 
> > So looking at xfs_end_io:
> > 
> > /* Finish all pending io completions. */
> > void
> > xfs_end_io(
> > 	struct work_struct	*work)
> > {
> > 	struct xfs_inode	*ip =
> > 		container_of(work, struct xfs_inode, i_ioend_work);
> > 	struct iomap_ioend	*ioend;
> > 	struct list_head	tmp;
> > 	unsigned long		flags;
> > 
> > 	spin_lock_irqsave(&ip->i_ioend_lock, flags);
> > 	list_replace_init(&ip->i_ioend_list, &tmp);
> > 	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
> > 
> > 	iomap_sort_ioends(&tmp);
> > 	while ((ioend = list_first_entry_or_null(&tmp, struct iomap_ioend,
> > 			io_list))) {
> > 		list_del_init(&ioend->io_list);
> > 
> > Here we pull the first ioend off the sorted list of ioends.
> > 
> > 		iomap_ioend_try_merge(ioend, &tmp);
> > 
> > Now we've merged that first ioend with as many subsequent ioends as we
> > could merge.  Let's say there were 200 ioends, each 100MB.  Now ioend
> 
> Ok, so how do we get to this completion state right now?
> 
> 1. an ioend is a physically contiguous extent so submission is
>    broken down into an ioend per physical extent.
> 2. we merge logically contiguous ioends at completion.
> 
> So, if we have 200 ioends of 100MB each that are logically
> contiguous we'll currently always merge them into a single 20GB
> ioend that gets processed as a single entity even if submission
> broke them up because they were physically discontiguous.
> 
> Now, with this patch we add:
> 
> 3. Individual ioends are limited to 16MB.
> 4. completion can only merge physically contiguous ioends.
> 5. we cond_resched() between physically contiguous ioend completion.
> 
> Submission will break that logically contiguous 20GB dirty range
> down into 200x6x16MB ioends.
> 
> Now completion will only merge ioends that are both physically and
> logically contiguous. That results in a maximum merged ioend chain
> size of 100MB at completion. They'll get merged one 100MB chunk at a
> time.
> 

I'm missing something with the reasoning here.. how does a contiguity
check in the ioend merge code guarantee we don't construct an
excessively large list of pages via a chain of merged ioends? Obviously
it filters out the discontig case, but what if the extents are
physically contiguous?

> > is a chain (of those other 199 ioends) representing 20GB of data.
> > 
> > 		xfs_end_ioend(ioend);
> 
> We now do one conversion transaction for the entire 100MB extent,
> then....
> 
> > At the end of this routine, we call iomap_finish_ioends on the 20GB
> > ioend chain.  This now has to mark 5.2 million pages...
> 
> run iomap_finish_ioends() on 100MB of pages, which is about 25,000
> pages, not 5 million...
> 
> > 		cond_resched();
> > 
> > ...before we get to the cond_resched.
> 
> ... and so in this scenario this patch reduces the time between
> reschedule events by a factor of 200 - the number of physical
> extents the ioends map....
> 
> That's kind of my point - we can't ignore why the filesystem needs
> merging or how it should optimise merging for it's own purposes in
> this discussion. Because logically merged ioends require the
> filesystem to do internal loops over physical discontiguities,
> requiring us to drive cond_resched() into both the iomap loops and
> the lower layer filesystem loops.
> 
> i.e. when we have ioend merging based on logical contiguity, we need
> to limit the number of the loops the filesystem does internally, not
> just the loops that the ioend code is doing...
> 
> > I'd really rather do the
> > cond_resched between each of those 200 ioends that (supposedly) are
> > small enough not to trip the hangcheck timers.
> > 
> > 	}
> > }
> > /*
> >  * Mark writeback finished on a chain of ioends.  Caller must not call
> >  * this function from atomic/softirq context.
> >  */
> > void
> > iomap_finish_ioends(struct iomap_ioend *ioend, int error)
> > {
> > 	struct list_head tmp;
> > 
> > 	list_replace_init(&ioend->io_list, &tmp);
> > 	iomap_finish_ioend(ioend, error);
> > 
> > 	while (!list_empty(&tmp)) {
> > 		cond_resched();
> > 
> > So I propose doing it ^^^ here instead.
> > 
> > 		ioend = list_first_entry(&tmp, struct iomap_ioend, io_list);
> > 		list_del_init(&ioend->io_list);
> > 		iomap_finish_ioend(ioend, error);
> > 	}
> > }

Hmm.. I'm not seeing how this is much different from Dave's patch, and
I'm not totally convinced the cond_resched() in Dave's patch is
effective without something like Darrick's earlier suggestion to limit
the $object (page/folio/whatever) count of the entire merged mapping (to
ensure that iomap_finish_ioend() is no longer a soft lockup vector by
itself).

Trond reports that the test patch mitigates his reproducer, but that
patch also includes the ioend size cap and so the test doesn't
necessarily isolate whether the cond_resched() is effective or whether
the additional submission/completion overhead is enough to avoid the
pathological conditions that enable it via the XFS merging code. I'd be
curious to have a more tangible datapoint on that. The easiest way to
test without getting into the weeds of looking at merging behavior is
probably just see whether the problem returns with the cond_resched()
removed and all of the other changes in place. Trond, is that something
you can test?

Brian

> 
> Yes, but this only addresses a single aspect of the issue when
> filesystem driven merging is used. That is, we might have just had
> to do a long unbroken loop in xfs_end_ioend() that might have to run
> conversion of several thousand physical extents that the logically
> merged ioends might have covered. Hence even with the above, we'd
> still need to add cond_resched() calls to the XFS code. Hence from
> an XFS IO completion point of view, we only want to merge to
> physical extent boundaries and issue cond_resched() at physical
> extent boundaries because that's what our filesystem completion
> processing loops on, not pages/folios.
> 
> Hence my point that we cannot ignore what the filesystem is doing
> with these merged ioends and only think about iomap in isolation.
> 
> Cheers,
> 
> Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
> 

