Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF257129DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 17:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244179AbjEZPpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 11:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243854AbjEZPpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 11:45:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2415410A
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 08:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685115883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lwwGmDr25PqhYMAQskstPkv/I0g5/p/MlB8xpRMcAt4=;
        b=NS1n81kWRjfz0u9nCMnXFLEBDkNmK76sacZ9rm06SXO8Ec3oyweNWO3kG81Ckn51+P/tdu
        ROsLYK6sce4Lpy4m5rcc2Pf8c9LUCR2Buub1Ix8mfH0qLw57DE3NVN1BCB0Bi8aLHkW2Pc
        QnB/JfNjay1MlzBYyimhWEMLvyPxer4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-_IGHZ9ApMNGe-Eki1llzqg-1; Fri, 26 May 2023 11:44:42 -0400
X-MC-Unique: _IGHZ9ApMNGe-Eki1llzqg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75b12ae55b1so71523585a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 08:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685115881; x=1687707881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwwGmDr25PqhYMAQskstPkv/I0g5/p/MlB8xpRMcAt4=;
        b=L2uuvLVMwkngIlQwTmEcjTkGtV1y1vI19aJaFkNqNI7mTlTXbwFXmhmxxA9mPhobIZ
         uO6rwjuzqiIbEAJl23f4oym7Mh8J7HYt6pNHXpfx1s3e0FSGFwTHoTylDbNeOFN1MyS3
         /1p9gJM5tc+FHPotdROZ/NqBJz0cO4b1b1LaUi9s4xjrtFj+Zw5TunyWXMu/O893X6iD
         bAH3OaSSAvQqOBEg3pq5w2QGlNAnxOW00nYKfP7THElR6Hdr1m0niRLF9f1dLmWWdaMi
         ITMFi51BOPnZvfNX0KonYKdyjbPMm/jkkN3zzAhCwcAdMJvqQGBnoim7N0V5D41eneX9
         y2yA==
X-Gm-Message-State: AC+VfDwH8vzS7OLa/LJc+uXMFZj/YpouppjZdP6n8JVs+0FZtGotRkzM
        GKZQHXDeyJ6PbBIH1ADjeKovrX42Yi01SY5AOuxZEnecUaqo2OCe/3NxIGKvL9yf+tFT5pZeD6B
        GS5QaQ0EddDW8RVaT5sfxzBxaRA==
X-Received: by 2002:a05:620a:8015:b0:75b:330a:a6c9 with SMTP id ee21-20020a05620a801500b0075b330aa6c9mr2220699qkb.40.1685115880927;
        Fri, 26 May 2023 08:44:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ68IfCbNV+obOCDOHjVnt0a9WEWVm0CdhqqeGKDuF+RetHzFo+oJLiJ9LfR/1mVUBidxUFCaA==
X-Received: by 2002:a05:620a:8015:b0:75b:330a:a6c9 with SMTP id ee21-20020a05620a801500b0075b330aa6c9mr2220651qkb.40.1685115880180;
        Fri, 26 May 2023 08:44:40 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id f25-20020a05620a15b900b0074df70197a6sm1230765qkk.109.2023.05.26.08.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 08:44:39 -0700 (PDT)
Date:   Fri, 26 May 2023 11:47:09 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        dm-devel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Joe Thornber <ejt@redhat.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZHDUfXBTgK0ZSl3W@bfoster>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
 <ZGb2Xi6O3i2pLam8@infradead.org>
 <ZGeKm+jcBxzkMXQs@redhat.com>
 <ZGgBQhsbU9b0RiT1@dread.disaster.area>
 <ZGu0LaQfREvOQO4h@redhat.com>
 <ZGzIJlCE2pcqQRFJ@bfoster>
 <ZGzbGg35SqMrWfpr@redhat.com>
 <ZG1dAtHmbQ53aOhA@dread.disaster.area>
 <ZG+KoxDMeyogq4J0@bfoster>
 <ZHB954zGG1ag0E/t@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHB954zGG1ag0E/t@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 07:37:43PM +1000, Dave Chinner wrote:
> On Thu, May 25, 2023 at 12:19:47PM -0400, Brian Foster wrote:
> > On Wed, May 24, 2023 at 10:40:34AM +1000, Dave Chinner wrote:
> > > On Tue, May 23, 2023 at 11:26:18AM -0400, Mike Snitzer wrote:
> > > > On Tue, May 23 2023 at 10:05P -0400, Brian Foster <bfoster@redhat.com> wrote:
> > > > > On Mon, May 22, 2023 at 02:27:57PM -0400, Mike Snitzer wrote:
> > > > > ... since I also happen to think there is a potentially interesting
> > > > > development path to make this sort of reserve pool configurable in terms
> > > > > of size and active/inactive state, which would allow the fs to use an
> > > > > emergency pool scheme for managing metadata provisioning and not have to
> > > > > track and provision individual metadata buffers at all (dealing with
> > > > > user data is much easier to provision explicitly). So the space
> > > > > inefficiency thing is potentially just a tradeoff for simplicity, and
> > > > > filesystems that want more granularity for better behavior could achieve
> > > > > that with more work. Filesystems that don't would be free to rely on the
> > > > > simple/basic mechanism provided by dm-thin and still have basic -ENOSPC
> > > > > protection with very minimal changes.
> > > > > 
> > > > > That's getting too far into the weeds on the future bits, though. This
> > > > > is essentially 99% a dm-thin approach, so I'm mainly curious if there's
> > > > > sufficient interest in this sort of "reserve mode" approach to try and
> > > > > clean it up further and have dm guys look at it, or if you guys see any
> > > > > obvious issues in what it does that makes it potentially problematic, or
> > > > > if you would just prefer to go down the path described above...
> > > > 
> > > > The model that Dave detailed, which builds on REQ_PROVISION and is
> > > > sticky (by provisioning same blocks for snapshot) seems more useful to
> > > > me because it is quite precise.  That said, it doesn't account for
> > > > hard requirements that _all_ blocks will always succeed.
> > > 
> > > Hmmm. Maybe I'm misunderstanding the "reserve pool" context here,
> > > but I don't think we'd ever need a hard guarantee from the block
> > > device that every write bio issued from the filesystem will succeed
> > > without ENOSPC.
> > > 
> > 
> > The bigger picture goal that I didn't get into in my previous mail is
> > the "full device" reservation model is intended to be a simple, crude
> > reference implementation that can be enabled for any arbitrary thin
> > volume consumer (filesystem or application). The idea is to build that
> > on a simple enough reservation mechanism that any such consumer could
> > override it based on its own operational model. The goal is to guarantee
> > that a particular filesystem never receives -ENOSPC from dm-thin on
> > writes, but the first phase of implementing that is to simply guarantee
> > every block is writeable.
> > 
> > As a specific filesystem is able to more explicitly provision its own
> > allocations in a way that it can guarantee to return -ENOSPC from
> > dm-thin up front (rather than at write bio time), it can reduce the need
> > for the amount of reservation required, ultimately to zero if that
> > filesystem provides the ability to pre-provision all of its writes to
> > storage in some way or another.
> > 
> > I think for filesystems with complex metadata management like XFS, it's
> > not very realistic to expect explicit 1-1 provisioning for all metadata
> > changes on a per-transaction basis in the same way that can (fairly
> > easily) be done for data, which means a pool mechanism is probably still
> > needed for the metadata class of writes.
> 
> I'm trying to avoid need for 1-1 provisioning and the need for a
> accounting based reservation pool approach. I've tried the
> reservation pool thing several times, and they've all collapsed
> under the complexity of behaviour guarantees under worst case write
> amplification situations.
> 
> The whole point of the LBA provisioning approach is that it
> completely avoids the need to care about write amplification because
> the underlying device guarantees any write to a LBA that is
> provisioned will succeed. It takes care of the write amplification
> problem for us, and we can make it even easier for the backing
> device by aligning LBA range provision requests to device region
> sizes.
> 
> > > If the block device can provide a guarantee that a provisioned LBA
> > > range is always writable, then everything else is a filesystem level
> > > optimisation problem and we don't have to involve the block device
> > > in any way. All we need is a flag we can ready out of the bdev at
> > > mount time to determine if the filesystem should be operating with
> > > LBA provisioning enabled...
> > > 
> > > e.g. If we need to "pre-provision" a chunk of the LBA space for
> > > filesystem metadata, we can do that ahead of time and track the
> > > pre-provisioned range(s) in the filesystem itself.
> > > 
> > > In XFS, That could be as simple as having small chunks of each AG
> > > reserved to metadata (e.g. start with the first 100MB) and limiting
> > > all metadata allocation free space searches to that specific block
> > > range. When we run low on that space, we pre-provision another 100MB
> > > chunk and then allocate all metadata out of that new range. If we
> > > start getting ENOSPC to pre-provisioning, then we reduce the size of
> > > the regions and log low space warnings to userspace. If we can't
> > > pre-provision any space at all and we've completely run out, we
> > > simply declare ENOSPC for all incoming operations that require
> > > metadata allocation until pre-provisioning succeeds again.
> > > 
> > 
> > The more interesting aspect of this is not so much how space is
> > provisioned and allocated, but how the filesystem is going to consume
> > that space in a way that guarantees -ENOSPC is provided up front before
> > userspace is allowed to make modifications.
> 
> Yeah, that's trivial with REQ_PROVISION.
> 
> If, at transaction reservation time, we don't have enough
> provisioned metadata space available for the potential allocations
> we'll need to make, we kick provisioning work off wait for more to
> come available. If that fails and none is available, we'll get an
> enospc error right there, same as if the filesystem itself has no
> blocks available for allocation.
> 
> This is no different to, say, having xfs_create() fail reservation
> because ENOSPC, then calling xfs_flush_inodes() to kick off an inode
> cache walk to trim away all the unused post-eof allocations in
> memory to free up some space we can use. When that completes,
> we try the reservation again.
> 
> There's no new behaviours we need to introduce here - it's just
> replication of existing behaviours and infrastructure.
> 

Yes, this is just context. What I'm trying to say is the semantics for
this aspect would be the same irrespective of "guaranteed writeable
space" being implemented as a reservation or preprovisioned LBA range.
I.e., it's a limited resource that has to be managed in a way to provide
specific user visible behavior.

> > You didn't really touch on
> > that here, so I'm going to assume we'd have something like a perag
> > counter of how many free blocks currently live in preprovisioned ranges,
> > and then an fs-wide total somewhere so a transaction has the ability to
> > consume these blocks at trans reservation time, the fs knows when to
> > preprovision more space (or go into -ENOSPC mode), etc.
> 
> Sure, something like that. Those are all implementation details, and
> not really that complex to implement and is largely replication of
> reservation infrastructure we already have.
> 

Ack.

> > Some accounting of that nature is necessary here in order to prevent the
> > filesystem from ever writing to unprovisioned space. So what I was
> > envisioning is rather than explicitly preprovision a physical range of
> > each AG and tracking all that, just reserve that number of arbitrarily
> > located blocks from dm for each AG.
> > 
> > The initial perag reservations can be populated at mount time,
> > replenished as needed in a very similar way as what you describe, and
> > 100% released back to the thin pool at unmount time. On top of that,
> > there's no need to track physical preprovisioned ranges at all. Not just
> > for allocation purposes, but also to avoid things like having to protect
> > background trims from preprovisioned ranges of free space dedicated for
> > metadata, etc. 
> 
> That's all well and good, but reading further down the email the
> breadth and depth of changes to filesystem and block device
> behaviour to enable this are ... significant.
> 
> > > Further, managing shared pool exhaustion doesn't require a
> > > reservation pool in the backing device and for the filesystems to
> > > request space from it. Filesystems already have their own reserve
> > > pools via pre-provisioning. If we want the filesystems to be able to
> > > release that space back to the shared pool (e.g. because the shared
> > > backing pool is critically short on space) then all we need is an
> > > extension to FITRIM to tell the filesystem to also release internal
> > > pre-provisioned reserves.
> > > 
> > > Then the backing pool admin (person or automated daemon!) can simply
> > > issue a trim on all the filesystems in the pool and spce will be
> > > returned. Then filesystems will ask for new pre-provisioned space
> > > when they next need to ingest modifications, and the backing pool
> > > can manage the new pre-provisioning space requests directly....
> > > 
> > 
> > This is written as to imply that the reservation pool is some big
> > complex thing, which makes me think there is some
> > confusion/miscommunication.
> 
> No confusion, I'm just sceptical that it will work given my
> experience trying to implement reservation based solutions multiple
> different ways over the past decade. They've all failed because
> they collapse under either the complexity explosion or space
> overhead required to handle the worst case behavioural scenarios.
> 
> At one point I calculated the worst case reservation needed ensure
> log recovery will always succeeded, ignoring write amplification,
> was about 16x the size of the log. If I took write amplification for
> dm-thinp having 64kB blocks and each inode hitting a different
> cluster in it's own dm thinp block, that write amplication hit 64x.
> 

Ok. Can you give some examples of operations that lead to this worst
case behavior? It sounds like you're talking about inode chunk intent
initialization or some such, but I'd like to be sure I understand.

> So for recovering a 2GB log, if dm-thinp doesn't have a reserve of
> well over 100GB of pool space, there is no guarantee that log
> recovery will -always- succeed.
> 
> It's worst case numbers like this which made me conclude that
> reservation based approaches cannot provide guarantees that ENOSPC
> will never occur. The numbers are just too large when you start
> considering journals that can hold a million dirty objects,
> intent chains that might require modifying hundreds of metadata
> blocks across a dozen transactions before they complete, etc.
> 
> OTOH, REQ_PROVISION makes this "log recovery needs new space to be
> allocated" problem go away entirely. It provides a mechanism that
> ensures log recovery does not consume any new space in the backing
> pool as all the overwrites it performs are to previously provisioned
> metadata.....
> 

Ah, I see. So this relies on the change in behavior to dm-thin
snapshots to preserve overwriteably of previously provisioned metadata
to indirectly manage log recovery -> metadata write amplification.

This is useful context and helps understand the intent of that
suggestion. I also think it calls out some of the disconnect..

> This is just one of the many reasons why I think the REQ_PROVISION
> method is far better than reservations - it solves problems that
> pure runtime reservations can't.
> 
> > It's basically just an in memory counter of
> > space that is allocated out of a shared thin pool and is held in a
> > specific thin volume while it is currently in use. The counter on the
> > volume is managed indirectly by filesystem requests and/or direct
> > operations on the volume (like dm snapshots).
> >
> > Sure, you could replace the counter and reservation interface with
> > explicitly provisioned/trimmed LBA ranges that the fs can manage to
> > provide -ENOSPC guarantees, but then the fs has to do those various
> > things you've mentioned:
> > 
> > - Provision those ranges in the fs and change allocation behavior
> >   accordingly.
> 
> This is relatively simple - most of the allocator functionality is
> already there.
> 
> > - Do the background post-crash fitrim preprovision clean up thing.
> 
> We've already decided this is not needed.
> 
> > - Distinguish between trims that are intended to return preprovisioned
> >   space vs. those that come from userspace.
> 
> It's about ten lines of code in xfs_trim_extents() to do this.  i.e.
> the free space tree walk simply skips over free extents in the
> metadata provisioned region based on a flag value.
> 
> > - Have some daemon or whatever (?) responsible for communicating the
> >   need for trims in the fs to return space back to the pool.
> 
> Systems are already configured to run a periodic fstrim passes to do
> this via systemd units. And I'm pretty sure dm-thinp has a low space
> notification to userspace (via dbus?) that is already used by
> userspace agents to handle "near ENOSPC" events automatically.
> 

Yeah, Ok. To be clear, I'm not trying to suggest any of these particular
things are complex or the whole thing is intractable or anything like
that. I'm pretty sure I understand how this can all be made to work, at
least for metadata. But I am saying this makes a bunch of customization
changes that could lead to a very XFS centric approach, may be more work
than necessary, and hasn't been described in a way that explains how it
actually (or helps) solves the broader -ENOSPC problem.

> > Then this still depends on changing how dm thin snapshots work and needs
> > a way to deal with delayed allocation to actually guarantee -ENOSPC
> > protection..?
> 
> I think you misunderstand: I'm not proposing to use REQ_PROVISION
> for writes the filesystem does not guarantee will succeed. Never
> have, I think it makes no sense at all.  If the filesystem
> can return ENOSPC for an unprovisioned user data write, then the
> block device can too.
> 

Well, yes.. that's why I was asking. :) I still don't parse what you're
saying here.

Is this intended to prevent -ENOSPC from dm-thin for data writes, or is
that an exercise for the reader?

> > > Hence I think if we get the basic REQ_PROVISION overwrite-in-place
> > > guarantees defined and implemented as previously outlined, then we
> > > don't need any special coordination between the fs and block devices
> > > to avoid fatal ENOSPC issues with sparse and/or snapshot capable
> > > block devices...
> > > 
> > 
> > This all sounds like a good amount of coordination and unnecessary
> > complexity to me. What I was thinking as a next phase (i.e. after
> > initial phase full device reservation) approach for a filesystem like
> > XFS would be something like this.
> > 
> > - Support a mount option for a configurable size metadata reservation
> >   pool (with sane/conservative default).
> 
> I want this to all to work without the user having be aware that
> there filesystem is running on a sparse device.
> 

Reservation (or provision) support can certainly be autodetected.

> > - The pool is populated at mount time, else the fs goes right into
> >   simulated -ENOSPC mode.
> 
> What are the rules of this mode?
> 

Earlier you mentioned that the filesystem would "declare -ENOSPC" when
preprovisioning starts to fail. The rules here would be exactly the
same.

> Hmmmm.
> 
> Log recovery needs to be able to allocate new metadata (i.e. in
> intent replay), so I'm guessing reservation is needed before log
> recovery? But if pool reservation fails, how do we then safely
> perform log recovery given the filesystem is in ENOSPC mode?
> 
> > - Thin pool reservation consumption is controlled by a flag on write
> >   bios that is managed by the fs (flag polarity TBD).
> 
> So we still need a bio flag to communicate "this IO consumes
> reservation".
> 
> What are the semantics of this flag?  What happens on submission
> error? e.g. the bio is failed before it gets to the layer that
> consumes it - how does the filesystem know that reservation was
> consumed or not at completion?
> 

The semantics are to use reservation or not. If so, then it's implied
reservation exists and if not that's a bug. If reservation is not
enabled, then dm-thin processes those writes exactly as it does today
(allocates out of the pool when necessary, fails otherwise).

> How do we know when to set it for user data writes?
> 

User data is always reserved before writes are accepted, so reservation
is always enabled for user data write bios.

> What happens if the device recieves a bio with this flag but there
> is no reservation remaining? e.g. the filesystem or device
> accounting have got out of whack?
> 

That's a bug. Almost the same as if the filesystem were to allow a
delalloc write that can't ultimately allocate because in-core counters
become inconsistent with free space btrees (not like that hasn't
happened before ;).

Let's not get too into the weeds here as if to imply coding errors
translate to design flaws. I'd say it probably should warn, fallback
to normal pool allocation.

> Hmmm. On that note, what about write amplification? Or should I call
> it "reservation amplification". i.e. a 4kB bio with a "consume
> reservation" flag might trigger a dm-region COW or allocation and
> require 512kB of dm-thinp pool space to be allocated. How much
> reservation actually gets consumed, and how do we reconcile the
> differences in physical consumption vs reservation consumption?
> 

The filesystem has no concept of the amount of reservation. Only whether
outstanding writes have been reserved or not. In this specific reference
implementation, all data writes are reserved and metadata writes are not
(until an -ENOSPC error happens and the fs decides to "declare -ENOSPC"
based on underlying volume state). 

> > - All fs data writes are explicitly reserved up front in the write path.
> >   Delalloc maps to explicit reservation, overwrites are easy and just
> >   involve an explicit provision.
> 
> This is the first you've mentioned an "explicit provision"
> operation. Is this like REQ_PROVISION, or something else?
> 
> This seems to imply that the ->iomap_begin method has to do
> explicit provisioning callouts when we get a write that lands in an
> IOMAP_MAPPED extent? Or something else?
> 
> Can you describe this mechanism in more detail?
> 

So something I've hacked up from the older prototype is to essentially
implement a simple form of a REQ_PROVISION|REQ_RESERVE type operation.
You can think of it like REQ_PROVISION as implemented by this series,
but it doesn't actually do the COW breaking and allocation and whatnot
right away. Instead, it reserves however many blocks out of the pool
might be required to guarantee subsequent writes to the specified region
are guaranteed not to fail with -ENOSPC.

(Note that the prototype isn't currently using REQ_PROVISION. It's just
a function call at the moment. I'm just explaining the concept.)

So the idea for user data in general is something like:

iomap looks up an extent, does a "reserve provision" over it based on
the size of the write, etc. If that succeeds, then the write can proceed
to dirty pages with a guarantee that dm-thin will not -ENOSPC at
writeback time.

If the extent is a hole, then delalloc translates to location agnostic
reservation that is eventually translated to a "reserve provision" at
filesystem allocation time. Note that this does introduce an aspect of
reservation amplification due to block size differences, but this was
already addressed by the older prototype. The same 'flush inodes on
-ENOSPC' mechanism you refer to above provides a feedback mechanism to
allow outstanding reservations to flush and prevent any premature error
problems.

And that can be optimized further in various ways. For example, to
simply map outstanding delalloc extents in the fs and do the "reserve
provision" across the ultimate LBA ranges to release overprovisioned
reserves, while still deferring writeback to later. A shrinker could be
used to allow the thin pool to signal lower space conditions to active
volumes to smooth out behavior rather than waiting for an actual
-ENOSPC, etc. etc.

> > - Metadata writes are not reserved or provisioned at all. They allocate
> >   out of the thin pool on write (if needed), just as they do today. On
> >   an -ENOSPC metadata write error, the fs goes into simulated -ENOSPC mode
> >   and allows outstanding metadata writes to now use the bio flag to
> >   consume emergency reservation.
> 
> Okay. We need two pools in the backing device? The normal free space
> pool, and an emergency reservation pool?
> 

Err not exactly.. it's really just selective use of the bio flag that
allows reserve consumption. Always enabled on data, never on metadata,
until -ENOSPC error and the fs decides to open reserves for metadata and
attempt to allow a full quiesce.

> Without reading further, this implies that the filesystem is
> reliant on the emergency reservation pool being large enough that
> it can write any dirty metadata it has outstanding without ENOSPC
> occuring. How does the size of this emergency pool get configured?
> 
> > So this means that metadata -ENOSPC protection is only as reliable as
> > the size of the specified pool. This is by design, so the filesystem
> > still does not have to track provisioning, allocation or overwrites of
> > its own metadata usage. Users with metadata heavy workloads or who
> > happen to be sensitive to -ENOSPC errors can be more aggressive with
> > pool size, while other users might be able to get away with a smaller
> > pool. Users who are super paranoid and want perfection can continue to
> > reserve the entire device and pay for the extra storage.
> 
> Oh. Hand tuning. :(
> 

Yes and no.. from the fs perspective it's hand tuning. From a user
perspective it can be if desired I guess, but really intended to be done
by the management software that already exists with intent to help
manage this problem. To put another way, any complex user of thin
provisioning who is concerned about this problem is already doing some
degree of tuning here to try and prevent it.

Also, an alternative to what I describe above could be for a filesystem
to implement thinreserve=N mode with a throttle to best ensure -ENOSPC
reliability at the cost of performance. It's still a tunable, but maybe
easier to turn into a heuristic. Not sure, just a random thought.

> > Users who are not sure can test their workload in an appropriate
> > environment, collect some data/metrics on maximum outstanding dirty
> > metadata, and then use that as a baseline/minimum pool size for reliable
> > behavior going forward.  This is also where something like Stratis can
> > come in to generate this sort of information, make recommendations or
> > implement heuristics (based on things like fs size, amount of RAM, for
> > e.g.) to provide sane defaults based on use case. I.e., this is
> > initially exposed as a userspace/tuning issue instead of a
> > filesystem/dm-thin hard guarantee.
> 
> Which are the same things people have been complaining about for years.
> 

Priorities and progress. I don't think that because this isn't the
absolute perfect, most easily usable, completely efficient solution
right off the bat is a very good argument to imply it's not a feasible
approach in general. This is why I'm trying to describe the intended
progression here. Users are already dealing with this sort of thing
through Stratis, and this is a step to at least try to make things
better. 

And really, the same could be said for preprovisioning until/unless it's
able to fully guarantee prevention of -ENOSPC errors for data and
metadata. That is exactly the same sort of thing "people have been
complaining about for years."

> > Finally, if you really want to get to that last step of maximally
> > efficient and safe provisioning in the fs, implement a
> > 'thinreserve=adaptive' mode in the fs that alters the acquisition and
> > consumption of dm-thin reserved blocks to be adaptive in nature and
> > promises to do it's own usage throttling against outstanding
> > reservation. I think this is the mode that most closely resembles your
> > preprovisioned range mechanism.
> >
> > For example, adaptive mode could add the logic/complexity where you do
> > the per-ag provision thing (just using reservation instead of physical
> > ranges), change the transaction path to attempt to increase the
> > reservation pool or go into -ENOSPC mode, and flag all writes to be
> > satisfied from the reserve pool (because you've done the
> > provision/reservation up front).
> 
> Ok, so why not just go straight to this model using REQ_PROVISION?
> 

A couple reasons.. one is I've also been trying to hack around this
problem for a while and have yet to see a full solution that can't
either be completely broken or just driven to impracticality performance
or space consumption wise.

We had an offline discussion with some of the Stratis and dm folks
fairly recently where they explained what Stratis is doing now to
mitigate this. Almost everybody agrees this approach stinks, which is
why I expected a similar first reaction to my "phase 1 full reservation"
model. The thought process there, however, is that rather than continue
to try and hack up various invasive solutions to provide such a simple
user visible behavior and ultimately not making progress, why not take
what they're doing and users are apparently already using and work to
make it better?

IOW, when thinking about the prospect of "hand tuning" above, I think
the more appropriate way to look at it is not that we're providing some
full end-user solution right off the bat. Instead, we're taking Stratis'
already existing "no overprovision" mode and starting to improve on it.
Step one lifts it into the kernel to make it dynamic (runtime
reservation vs provision time no overprovision enforcement), next steps
focus on making it more efficient while preserving the -ENOSPC safety
guarantee. No end user really needs to interact with it directly
until/unless filesystems grow the super-smart ability to do everything
automagically.

So it could very well be that this all remains an experimental feature
until "adaptive mode" can be made to work, but at least we have the
ability to solve the problem incrementally and without permanent
changes. The ability to just rip it out without having made any
permanent changes to filesystems or thin pool metadata should it just
happen to fail spectatularly is also a feature IMO. It could also be the
case that the simple sizing mechanism works well enough, and Stratis is
able to make good enough recommendations that most users are satisifed,
and there's really no need for the levels of complexity we're talking
about for adaptive mode (or preprovisioning) at all.

> If we then want to move to a different "accounting only" model for
> provisioning, we just change REQ_PROVISION?
> 

AFAIU this relies on some permanent changes to dm that are not
necessarily trivial to undo..? If so, I think it's actually wiser to
move in the opposite direction. If reservation proves too broad and
expensive due to things like amplification, then move toward physical
provisioning and permanent snapshot changes to address that problem.

The benefit of this is that the reservation approach solves the
fundamental problem from the start, even if the implementation is
ultimately too impractical to be useful, so this mitigates the risk of
getting too far down the road with permanent changes to disk formats and
whatnot only to find the solution doesn't ultimately work.

> But I still see the problem of write amplification accounting being
> unsolved by the "filesystem accounting only" approach advocated
> here.  We have no idea when the backing device has snapshots taken,
> we have no idea when a filesystem write IO actually consumes more
> thinp blocks than filesystem blocks, etc.  How does the filesystem
> level reservation pool address these problems?
> 

This is a fair concern in general, but as mentioned above, I think still
highlights a misunderstanding with the reserve metadata pool idea.

The key point I think is that metadata writes are not actually reserved.
The reserve pool exists solely to handle the -ENOSPC mode transition,
not to continuously supply ongoing metadata transactions. This means
write amplification is less of a concern: every successful FSB sized
write allocates DMB (device mapper block) sized blocks out of the thin
pool, further reducing the odds that subsequent writes to any
overlapping FSB blocks will ever require reservation for the current
active cycle of the log.

A snapshot could happen at any point, but dm-thin snapshots already call
into freeze infrastructure, which already quiesces the log. After that
point the game starts all over, all overwrites require allocation, and
the pool has to be sized large enough to acommodate that the filesystem
is able to quiesce in the event of -ENOSPC, particularly if snapshots
are in use.

So I'm not saying write amplification is not a problem. I think things like
crashing a filesystem, doing a snapshot, then running recovery could
exacerbate this problem, for example. But that's another corner case
that I don't necessarily think discredits the idea. For example, if XFS
really wanted to, it could add another pass to log recovery to do
"reserve provisions" on affected metadata before recovering anything, or
just scan and reserve provision the entire metadata allocated portion of
the fs, or refuse to proceed and require full reservation for any time
the log is dirty, etc. etc.

I think this is something that could use some examples (re: my earlier
question) to help work through whether the pool approach is sane, or if
the size would just always be too big. If not, you could still decide
that the configurable pool approach just doesn't work at all for XFS,
but track the outstanding metadata block usage somewhere (or estimate
based on existing ag buffer btree block counters), reserve that number
of blocks at mount time, and use that to guarantee all metadata block
overwrites will always succeed in the exact same way a preprovision
scheme would. A snapshot while mounted would bump the volume side
reservation appropriately or fail.

I suspect that trades off mount time performance for better snapshot
behavior, but again is just another handwavy option on the table for
consideration that doesn't preclude other fs' from possibly doing
something more simple.

Brian

> > Thoughts on any of the above?
> 
> I'd say it went wrong at the requirements stage, resulting in an
> overly complex, over-engineered solution.
> 
> > One general tradeoff with using reservations vs. preprovisioning is the
> > the latter can just use the provision/trim primitives to alloc/free LBA
> > ranges. My thought on that is those primitives could possibly be
> > modified to do the same sort of things with reservation as for physical
> > allocations. That seems fairly easy to do with bio op flags/modifiers,
> > though one thing I'm not sure about is how to submit a provision bio to
> > request a certain amount location agnostic blocks. I'd have to
> > investigate that more.
> 
> Sure, if the constrained LBA space aspect of the REQ_PROVISION
> implementation causes issues, then we see if we can optimise away
> the fixed LBA space requirement.
> 
> 
> -- 
> Dave Chinner
> david@fromorbit.com
> 

