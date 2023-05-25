Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA077110BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 18:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbjEYQSO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 12:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbjEYQSN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 12:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D73E51
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685031440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kfI1228BT1lPSNTcQiaLIPB09CDTdUJPSFhJvqJ8/wQ=;
        b=O1UQ5BXRbdiY4AYAra8hv1a1ZrHkMQgqV/7ApQPky0QZvYCBpImrZeMGlpYkUdPQmxDbDj
        KpVXEt5V7RHyHwU65aFUXVsWmVNyZ1TuACF8OzQ/4dQklVG4C++u0ns5FkCKnwLnsyucbL
        8eVV2FLibfuqnoZMCjbwg21Igm4DlbU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-Gxc5p_viMxmf_Oob6mgHfw-1; Thu, 25 May 2023 12:17:19 -0400
X-MC-Unique: Gxc5p_viMxmf_Oob6mgHfw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75b2c4b3e02so108465485a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 09:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685031438; x=1687623438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfI1228BT1lPSNTcQiaLIPB09CDTdUJPSFhJvqJ8/wQ=;
        b=EiaKZI8TvjXev3Xjrqs4J8SvONkY7rPl44SiFlq+s659ScTDiZIEdwV+rWXRXNi+40
         QukKuaFnXjP8SCuIik3Rh6KXXlHGDmXn2T8mZwC1/oP/5VVbVAZoJ+O+n4oD21mS9XS9
         U+ePOdsV6v8pWIqBNXZW11Ct4Hch6wvU8As6sw7bmtTUy2NCHxfYAwY1hQ2Y6gi1YWoQ
         RKnWj+7kSUp2d/OST7OkaEpFv0MBcM8YLUtttiRkmEXzJDFfmPC6ID9t8OsINCtZqsYO
         xLyiHadOgI8YfJkKm71okXmg1JcM09DOtc3Thd/RnUj1fdMG9Jf0ATzx/Oryoi0j8wMH
         jI3g==
X-Gm-Message-State: AC+VfDzbZE2ZaOvuo1ycqxTYql95HK7dOrRgGKX2QKdndJ0jp0ncIm38
        cQ9C6vZTwjwNQ6g1WN23XymAvQ1VddNXqNGfX8DpC6DGMe+8jvae9UAMjwUSzZbBHAipiBQ1s1K
        uaj6futxPVFLqYODC4sdnV0B7Bw==
X-Received: by 2002:a05:620a:2b9c:b0:75b:23a1:d8ce with SMTP id dz28-20020a05620a2b9c00b0075b23a1d8cemr2966403qkb.18.1685031438331;
        Thu, 25 May 2023 09:17:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5URREXOgS18lIhJSr4njOTwBiUKlVD8Ep70/xv62Y6p9tMFNK+fvipBkeNUIxnJhB8w+F/gA==
X-Received: by 2002:a05:620a:2b9c:b0:75b:23a1:d8ce with SMTP id dz28-20020a05620a2b9c00b0075b23a1d8cemr2966378qkb.18.1685031437846;
        Thu, 25 May 2023 09:17:17 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id a4-20020a05620a124400b0075b1c6f9628sm494265qkl.71.2023.05.25.09.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 09:17:17 -0700 (PDT)
Date:   Thu, 25 May 2023 12:19:47 -0400
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
Message-ID: <ZG+KoxDMeyogq4J0@bfoster>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
 <ZGb2Xi6O3i2pLam8@infradead.org>
 <ZGeKm+jcBxzkMXQs@redhat.com>
 <ZGgBQhsbU9b0RiT1@dread.disaster.area>
 <ZGu0LaQfREvOQO4h@redhat.com>
 <ZGzIJlCE2pcqQRFJ@bfoster>
 <ZGzbGg35SqMrWfpr@redhat.com>
 <ZG1dAtHmbQ53aOhA@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG1dAtHmbQ53aOhA@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 10:40:34AM +1000, Dave Chinner wrote:
> On Tue, May 23, 2023 at 11:26:18AM -0400, Mike Snitzer wrote:
> > On Tue, May 23 2023 at 10:05P -0400, Brian Foster <bfoster@redhat.com> wrote:
> > > On Mon, May 22, 2023 at 02:27:57PM -0400, Mike Snitzer wrote:
> > > ... since I also happen to think there is a potentially interesting
> > > development path to make this sort of reserve pool configurable in terms
> > > of size and active/inactive state, which would allow the fs to use an
> > > emergency pool scheme for managing metadata provisioning and not have to
> > > track and provision individual metadata buffers at all (dealing with
> > > user data is much easier to provision explicitly). So the space
> > > inefficiency thing is potentially just a tradeoff for simplicity, and
> > > filesystems that want more granularity for better behavior could achieve
> > > that with more work. Filesystems that don't would be free to rely on the
> > > simple/basic mechanism provided by dm-thin and still have basic -ENOSPC
> > > protection with very minimal changes.
> > > 
> > > That's getting too far into the weeds on the future bits, though. This
> > > is essentially 99% a dm-thin approach, so I'm mainly curious if there's
> > > sufficient interest in this sort of "reserve mode" approach to try and
> > > clean it up further and have dm guys look at it, or if you guys see any
> > > obvious issues in what it does that makes it potentially problematic, or
> > > if you would just prefer to go down the path described above...
> > 
> > The model that Dave detailed, which builds on REQ_PROVISION and is
> > sticky (by provisioning same blocks for snapshot) seems more useful to
> > me because it is quite precise.  That said, it doesn't account for
> > hard requirements that _all_ blocks will always succeed.
> 
> Hmmm. Maybe I'm misunderstanding the "reserve pool" context here,
> but I don't think we'd ever need a hard guarantee from the block
> device that every write bio issued from the filesystem will succeed
> without ENOSPC.
> 

The bigger picture goal that I didn't get into in my previous mail is
the "full device" reservation model is intended to be a simple, crude
reference implementation that can be enabled for any arbitrary thin
volume consumer (filesystem or application). The idea is to build that
on a simple enough reservation mechanism that any such consumer could
override it based on its own operational model. The goal is to guarantee
that a particular filesystem never receives -ENOSPC from dm-thin on
writes, but the first phase of implementing that is to simply guarantee
every block is writeable.

As a specific filesystem is able to more explicitly provision its own
allocations in a way that it can guarantee to return -ENOSPC from
dm-thin up front (rather than at write bio time), it can reduce the need
for the amount of reservation required, ultimately to zero if that
filesystem provides the ability to pre-provision all of its writes to
storage in some way or another.

I think for filesystems with complex metadata management like XFS, it's
not very realistic to expect explicit 1-1 provisioning for all metadata
changes on a per-transaction basis in the same way that can (fairly
easily) be done for data, which means a pool mechanism is probably still
needed for the metadata class of writes. Therefore, my expectation for
something like XFS is that it grows the ability to explicitly provision
data writes up front (we solved this part years ago), and then uses a
much smaller pool of reservation for the purpose of dealing with
metadata.

I think what you describe below around preprovisioned perag metadata
ranges is interesting because it _very closely_ maps conceptually to
what I envisioned the evolution of the reserve pool scheme to end up
looking like, but just implemented rather differently to use
reservations instead of specific LBA ranges.

Let me try to connect the dots and identify the differences/tradeoffs...

> If the block device can provide a guarantee that a provisioned LBA
> range is always writable, then everything else is a filesystem level
> optimisation problem and we don't have to involve the block device
> in any way. All we need is a flag we can ready out of the bdev at
> mount time to determine if the filesystem should be operating with
> LBA provisioning enabled...
> 
> e.g. If we need to "pre-provision" a chunk of the LBA space for
> filesystem metadata, we can do that ahead of time and track the
> pre-provisioned range(s) in the filesystem itself.
> 
> In XFS, That could be as simple as having small chunks of each AG
> reserved to metadata (e.g. start with the first 100MB) and limiting
> all metadata allocation free space searches to that specific block
> range. When we run low on that space, we pre-provision another 100MB
> chunk and then allocate all metadata out of that new range. If we
> start getting ENOSPC to pre-provisioning, then we reduce the size of
> the regions and log low space warnings to userspace. If we can't
> pre-provision any space at all and we've completely run out, we
> simply declare ENOSPC for all incoming operations that require
> metadata allocation until pre-provisioning succeeds again.
> 

The more interesting aspect of this is not so much how space is
provisioned and allocated, but how the filesystem is going to consume
that space in a way that guarantees -ENOSPC is provided up front before
userspace is allowed to make modifications. You didn't really touch on
that here, so I'm going to assume we'd have something like a perag
counter of how many free blocks currently live in preprovisioned ranges,
and then an fs-wide total somewhere so a transaction has the ability to
consume these blocks at trans reservation time, the fs knows when to
preprovision more space (or go into -ENOSPC mode), etc.

Some accounting of that nature is necessary here in order to prevent the
filesystem from ever writing to unprovisioned space. So what I was
envisioning is rather than explicitly preprovision a physical range of
each AG and tracking all that, just reserve that number of arbitrarily
located blocks from dm for each AG.

The initial perag reservations can be populated at mount time,
replenished as needed in a very similar way as what you describe, and
100% released back to the thin pool at unmount time. On top of that,
there's no need to track physical preprovisioned ranges at all. Not just
for allocation purposes, but also to avoid things like having to protect
background trims from preprovisioned ranges of free space dedicated for
metadata, etc. 

> This is built entirely on the premise that once proactive backing
> device provisioning fails, the backing device is at ENOSPC and we
> have to wait for that situation to go away before allowing new data
> to be ingested. Hence the block device really doesn't need to know
> anything about what the filesystem is doing and vice versa - The
> block dev just says "yes" or "no" and the filesystem handles
> everything else.
> 

Yup, everything you describe about going into a simulated -ENOSPC mode
would work exactly the same. The primary difference is that the internal
provisioned space accounting in the filesystem is backed by dynamic
reservation in dm, rather than physically provisioned LBA ranges.

> It's worth noting that XFS already has a coarse-grained
> implementation of preferred regions for metadata storage. It will
> currently not use those metadata-preferred regions for user data
> unless all the remaining user data space is full.  Hence I'm pretty
> sure that a pre-provisioning enhancment like this can be done
> entirely in-memory without requiring any new on-disk state to be
> added.
> 
> Sure, if we crash and remount, then we might chose a different LBA
> region for pre-provisioning. But that's not really a huge deal as we
> could also run an internal background post-mount fstrim operation to
> remove any unused pre-provisioning that was left over from when the
> system went down.
> 

None of this is really needed..

> Further, managing shared pool exhaustion doesn't require a
> reservation pool in the backing device and for the filesystems to
> request space from it. Filesystems already have their own reserve
> pools via pre-provisioning. If we want the filesystems to be able to
> release that space back to the shared pool (e.g. because the shared
> backing pool is critically short on space) then all we need is an
> extension to FITRIM to tell the filesystem to also release internal
> pre-provisioned reserves.
> 
> Then the backing pool admin (person or automated daemon!) can simply
> issue a trim on all the filesystems in the pool and spce will be
> returned. Then filesystems will ask for new pre-provisioned space
> when they next need to ingest modifications, and the backing pool
> can manage the new pre-provisioning space requests directly....
> 

This is written as to imply that the reservation pool is some big
complex thing, which makes me think there is some
confusion/miscommunication. It's basically just an in memory counter of
space that is allocated out of a shared thin pool and is held in a
specific thin volume while it is currently in use. The counter on the
volume is managed indirectly by filesystem requests and/or direct
operations on the volume (like dm snapshots).

Sure, you could replace the counter and reservation interface with
explicitly provisioned/trimmed LBA ranges that the fs can manage to
provide -ENOSPC guarantees, but then the fs has to do those various
things you've mentioned:

- Provision those ranges in the fs and change allocation behavior
  accordingly.
- Do the background post-crash fitrim preprovision clean up thing.
- Distinguish between trims that are intended to return preprovisioned
  space vs. those that come from userspace.
- Have some daemon or whatever (?) responsible for communicating the
  need for trims in the fs to return space back to the pool.

Then this still depends on changing how dm thin snapshots work and needs
a way to deal with delayed allocation to actually guarantee -ENOSPC
protection..?

> Hence I think if we get the basic REQ_PROVISION overwrite-in-place
> guarantees defined and implemented as previously outlined, then we
> don't need any special coordination between the fs and block devices
> to avoid fatal ENOSPC issues with sparse and/or snapshot capable
> block devices...
> 

This all sounds like a good amount of coordination and unnecessary
complexity to me. What I was thinking as a next phase (i.e. after
initial phase full device reservation) approach for a filesystem like
XFS would be something like this.

- Support a mount option for a configurable size metadata reservation
  pool (with sane/conservative default).
- The pool is populated at mount time, else the fs goes right into
  simulated -ENOSPC mode.
- Thin pool reservation consumption is controlled by a flag on write
  bios that is managed by the fs (flag polarity TBD).
- All fs data writes are explicitly reserved up front in the write path.
  Delalloc maps to explicit reservation, overwrites are easy and just
  involve an explicit provision.
- Metadata writes are not reserved or provisioned at all. They allocate
  out of the thin pool on write (if needed), just as they do today. On
  an -ENOSPC metadata write error, the fs goes into simulated -ENOSPC mode
  and allows outstanding metadata writes to now use the bio flag to
  consume emergency reservation.

So this means that metadata -ENOSPC protection is only as reliable as
the size of the specified pool. This is by design, so the filesystem
still does not have to track provisioning, allocation or overwrites of
its own metadata usage. Users with metadata heavy workloads or who
happen to be sensitive to -ENOSPC errors can be more aggressive with
pool size, while other users might be able to get away with a smaller
pool. Users who are super paranoid and want perfection can continue to
reserve the entire device and pay for the extra storage.

Users who are not sure can test their workload in an appropriate
environment, collect some data/metrics on maximum outstanding dirty
metadata, and then use that as a baseline/minimum pool size for reliable
behavior going forward. This is also where something like Stratis can
come in to generate this sort of information, make recommendations or
implement heuristics (based on things like fs size, amount of RAM, for
e.g.) to provide sane defaults based on use case. I.e., this is
initially exposed as a userspace/tuning issue instead of a
filesystem/dm-thin hard guarantee.

Finally, if you really want to get to that last step of maximally
efficient and safe provisioning in the fs, implement a
'thinreserve=adaptive' mode in the fs that alters the acquisition and
consumption of dm-thin reserved blocks to be adaptive in nature and
promises to do it's own usage throttling against outstanding
reservation. I think this is the mode that most closely resembles your
preprovisioned range mechanism.

For example, adaptive mode could add the logic/complexity where you do
the per-ag provision thing (just using reservation instead of physical
ranges), change the transaction path to attempt to increase the
reservation pool or go into -ENOSPC mode, and flag all writes to be
satisfied from the reserve pool (because you've done the
provision/reservation up front).

At this point the "reserve pool" concept is very different and pretty
much managed entirely by the filesystem. It's just a counter of the set
of blocks the fs is anticipating to write to in the near term, but it's
built on the same underlying reservation mechanism used differently by
other filesystems. So something like ext4 could elide the need for an
adaptive mode, implement the moderate data/metadata pool mechanism and
rely on userspace tools or qualified administrators to do the sizing
correctly, while simultaneously using the same underlying mechanism that
XFS is using for finer grained provisioning.

> As a bonus, if we can implement the guarantees in dm-thin/-snapshot
> and have a filesystem make use of it, then we also have a reference
> implementation to point at device vendors and standards
> associations....
> 

I think that's a ways ahead yet.. :P

Thoughts on any of the above? Does that describe enough of the big
picture? (Mike, I hope this at least addresses the whole "why even do
this?" question). I am deliberately trying to work through a progression
that starts simple and generic but actually 100% solves the problem
(even if in a dumb way), then iterates to something that addresses the
biggest drawback with the reference implementation with minimal changes
required to individual filesystems (i.e. metadata pool sizing), and
finally ends up allowing any particular filesystem to refine from there
to achieve maximal efficiency based on its own cost/benefit analysis.

Another way to look at it is... step 1 is to implement the
'thinreserve=full' mount option, which can be trivially implemented by
any filesystem with a couple function calls. Step two is to implement
'thinsreserve=N' support, which consists of a standard iomap
provisioning implementation for data and a bio tagging/error handling
approach that is still pretty simple for most filesystems to implement.
Finally, 'thinreserve=adaptive' is the filesystems best effort to
guarantee -ENOSPC safety with maximal space efficiency.

One general tradeoff with using reservations vs. preprovisioning is the
the latter can just use the provision/trim primitives to alloc/free LBA
ranges. My thought on that is those primitives could possibly be
modified to do the same sort of things with reservation as for physical
allocations. That seems fairly easy to do with bio op flags/modifiers,
though one thing I'm not sure about is how to submit a provision bio to
request a certain amount location agnostic blocks. I'd have to
investigate that more.

So in summary, I can sort of see how this problem could be solved with
this combination of physically preprovisioned ranges and changes to
dm-thin snapshot behavior and whatnot (I'm still missing how this is
supposed to handle delalloc, mostly), but I think that involves more
complexity and customization work than is really necessary. Either way,
this is a distinctly different approach to what I was thinking of
morphing the prototype bits into. So to me the relevant question is does
something like the progression that is outlined above for a block
reservation approach seem a reasonable path to ultimately be able to
accomplish the same sort of results in the fs? If so, then I'm happy to
try and push things in that direction to at least try to prove it out.
If not, then I'm also happy to just leave it alone.. ;)

Brian

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

