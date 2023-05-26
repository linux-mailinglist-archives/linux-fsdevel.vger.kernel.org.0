Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3797A7123D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 11:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243196AbjEZJiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 05:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242661AbjEZJhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 05:37:52 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812CF1BC
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 02:37:48 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-530638a60e1so472895a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 02:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685093868; x=1687685868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OhImKFQSe55qZIwZYKRHoDOla9nsNtGf9yEwE/hb1CU=;
        b=MhC1m5lPh9B7y5hKZgMp8M+aKRE0Y6UUEaQixqZD7Ll0Hpi9heGoY4lM8Rd1cj7PS1
         k9Bcv7ISjlUqHge/kc9u/mAF4GEyUm04IqgcgyoxH4DhvNXEB7gn5NGUGzwV2gn4+jDW
         Hjk1rneTfnun+jpQy0vKa9h/m7TJ6wOgE9GXOzHgwaVUgtxR/aIPwu3o2d7tOAb14Hco
         DbRKM3SwsFPKGTa2Cujmu6wQs/Rq5IELGTa7DXZll2hKTfr6cK7uNBwzkAHU8NQAu/cZ
         V2vp/sM8i9LoZ/N0VXyn2dPexxuxEtD/hz/tdvMBNVUjxh6y9amLldigyyfXYSYz34p4
         F/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685093868; x=1687685868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhImKFQSe55qZIwZYKRHoDOla9nsNtGf9yEwE/hb1CU=;
        b=bCLEckjiZVJ8eXmOvO1ZqNLm/JUEQ2YcaEz+AV4bmjeQCpLsuUXsErC5LPidhEI6Ot
         HMrseL8kY7EUMpw8DvVwcfPdf0Xcx1eWHO3XgT6JXoMB/sRG3tNJhIHZaKA5kx5aNEFk
         qXtw+2a8DzbbZy7f/3j/wTtDzpUF6ycFCkK1xZJ8BKzjsDvnvZ9ZdGs3z/fE2mCTljat
         HSkVOJHZHyrt8p0Oe0jZc5z8hxqMllMEySHxbyZja/UF6Ca3uroeLgfDiQTbb3LZ6zTp
         MZw3NylV6NCWxE4VhnOfoOwW4WxDpgKp72Vi9tcYIGW4SLVQqPQRmqKsg2FkJHKmRRJr
         r/Qg==
X-Gm-Message-State: AC+VfDxFLLOjTxeHgDw55HwbKeP1qystq/WhecTlC/5nL4Sq9gLBuyI9
        wjFF7DOu6erLbdgai51HnRkVOQ==
X-Google-Smtp-Source: ACHHUZ5tMxjKhIYzofju3ljvnTp8gkz7zQJDpQtRxmj1S+nnnQ5r1Zc0hd5x7nZPQEcw90uerFtAog==
X-Received: by 2002:a05:6a21:78a9:b0:10b:7400:cef7 with SMTP id bf41-20020a056a2178a900b0010b7400cef7mr1830343pzc.17.1685093867598;
        Fri, 26 May 2023 02:37:47 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id y123-20020a636481000000b0051b7d83ff22sm2437870pgb.80.2023.05.26.02.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 02:37:46 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q2TtH-0045Jh-14;
        Fri, 26 May 2023 19:37:43 +1000
Date:   Fri, 26 May 2023 19:37:43 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
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
Message-ID: <ZHB954zGG1ag0E/t@dread.disaster.area>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
 <ZGb2Xi6O3i2pLam8@infradead.org>
 <ZGeKm+jcBxzkMXQs@redhat.com>
 <ZGgBQhsbU9b0RiT1@dread.disaster.area>
 <ZGu0LaQfREvOQO4h@redhat.com>
 <ZGzIJlCE2pcqQRFJ@bfoster>
 <ZGzbGg35SqMrWfpr@redhat.com>
 <ZG1dAtHmbQ53aOhA@dread.disaster.area>
 <ZG+KoxDMeyogq4J0@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG+KoxDMeyogq4J0@bfoster>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 12:19:47PM -0400, Brian Foster wrote:
> On Wed, May 24, 2023 at 10:40:34AM +1000, Dave Chinner wrote:
> > On Tue, May 23, 2023 at 11:26:18AM -0400, Mike Snitzer wrote:
> > > On Tue, May 23 2023 at 10:05P -0400, Brian Foster <bfoster@redhat.com> wrote:
> > > > On Mon, May 22, 2023 at 02:27:57PM -0400, Mike Snitzer wrote:
> > > > ... since I also happen to think there is a potentially interesting
> > > > development path to make this sort of reserve pool configurable in terms
> > > > of size and active/inactive state, which would allow the fs to use an
> > > > emergency pool scheme for managing metadata provisioning and not have to
> > > > track and provision individual metadata buffers at all (dealing with
> > > > user data is much easier to provision explicitly). So the space
> > > > inefficiency thing is potentially just a tradeoff for simplicity, and
> > > > filesystems that want more granularity for better behavior could achieve
> > > > that with more work. Filesystems that don't would be free to rely on the
> > > > simple/basic mechanism provided by dm-thin and still have basic -ENOSPC
> > > > protection with very minimal changes.
> > > > 
> > > > That's getting too far into the weeds on the future bits, though. This
> > > > is essentially 99% a dm-thin approach, so I'm mainly curious if there's
> > > > sufficient interest in this sort of "reserve mode" approach to try and
> > > > clean it up further and have dm guys look at it, or if you guys see any
> > > > obvious issues in what it does that makes it potentially problematic, or
> > > > if you would just prefer to go down the path described above...
> > > 
> > > The model that Dave detailed, which builds on REQ_PROVISION and is
> > > sticky (by provisioning same blocks for snapshot) seems more useful to
> > > me because it is quite precise.  That said, it doesn't account for
> > > hard requirements that _all_ blocks will always succeed.
> > 
> > Hmmm. Maybe I'm misunderstanding the "reserve pool" context here,
> > but I don't think we'd ever need a hard guarantee from the block
> > device that every write bio issued from the filesystem will succeed
> > without ENOSPC.
> > 
> 
> The bigger picture goal that I didn't get into in my previous mail is
> the "full device" reservation model is intended to be a simple, crude
> reference implementation that can be enabled for any arbitrary thin
> volume consumer (filesystem or application). The idea is to build that
> on a simple enough reservation mechanism that any such consumer could
> override it based on its own operational model. The goal is to guarantee
> that a particular filesystem never receives -ENOSPC from dm-thin on
> writes, but the first phase of implementing that is to simply guarantee
> every block is writeable.
> 
> As a specific filesystem is able to more explicitly provision its own
> allocations in a way that it can guarantee to return -ENOSPC from
> dm-thin up front (rather than at write bio time), it can reduce the need
> for the amount of reservation required, ultimately to zero if that
> filesystem provides the ability to pre-provision all of its writes to
> storage in some way or another.
> 
> I think for filesystems with complex metadata management like XFS, it's
> not very realistic to expect explicit 1-1 provisioning for all metadata
> changes on a per-transaction basis in the same way that can (fairly
> easily) be done for data, which means a pool mechanism is probably still
> needed for the metadata class of writes.

I'm trying to avoid need for 1-1 provisioning and the need for a
accounting based reservation pool approach. I've tried the
reservation pool thing several times, and they've all collapsed
under the complexity of behaviour guarantees under worst case write
amplification situations.

The whole point of the LBA provisioning approach is that it
completely avoids the need to care about write amplification because
the underlying device guarantees any write to a LBA that is
provisioned will succeed. It takes care of the write amplification
problem for us, and we can make it even easier for the backing
device by aligning LBA range provision requests to device region
sizes.

> > If the block device can provide a guarantee that a provisioned LBA
> > range is always writable, then everything else is a filesystem level
> > optimisation problem and we don't have to involve the block device
> > in any way. All we need is a flag we can ready out of the bdev at
> > mount time to determine if the filesystem should be operating with
> > LBA provisioning enabled...
> > 
> > e.g. If we need to "pre-provision" a chunk of the LBA space for
> > filesystem metadata, we can do that ahead of time and track the
> > pre-provisioned range(s) in the filesystem itself.
> > 
> > In XFS, That could be as simple as having small chunks of each AG
> > reserved to metadata (e.g. start with the first 100MB) and limiting
> > all metadata allocation free space searches to that specific block
> > range. When we run low on that space, we pre-provision another 100MB
> > chunk and then allocate all metadata out of that new range. If we
> > start getting ENOSPC to pre-provisioning, then we reduce the size of
> > the regions and log low space warnings to userspace. If we can't
> > pre-provision any space at all and we've completely run out, we
> > simply declare ENOSPC for all incoming operations that require
> > metadata allocation until pre-provisioning succeeds again.
> > 
> 
> The more interesting aspect of this is not so much how space is
> provisioned and allocated, but how the filesystem is going to consume
> that space in a way that guarantees -ENOSPC is provided up front before
> userspace is allowed to make modifications.

Yeah, that's trivial with REQ_PROVISION.

If, at transaction reservation time, we don't have enough
provisioned metadata space available for the potential allocations
we'll need to make, we kick provisioning work off wait for more to
come available. If that fails and none is available, we'll get an
enospc error right there, same as if the filesystem itself has no
blocks available for allocation.

This is no different to, say, having xfs_create() fail reservation
because ENOSPC, then calling xfs_flush_inodes() to kick off an inode
cache walk to trim away all the unused post-eof allocations in
memory to free up some space we can use. When that completes,
we try the reservation again.

There's no new behaviours we need to introduce here - it's just
replication of existing behaviours and infrastructure.

> You didn't really touch on
> that here, so I'm going to assume we'd have something like a perag
> counter of how many free blocks currently live in preprovisioned ranges,
> and then an fs-wide total somewhere so a transaction has the ability to
> consume these blocks at trans reservation time, the fs knows when to
> preprovision more space (or go into -ENOSPC mode), etc.

Sure, something like that. Those are all implementation details, and
not really that complex to implement and is largely replication of
reservation infrastructure we already have.

> Some accounting of that nature is necessary here in order to prevent the
> filesystem from ever writing to unprovisioned space. So what I was
> envisioning is rather than explicitly preprovision a physical range of
> each AG and tracking all that, just reserve that number of arbitrarily
> located blocks from dm for each AG.
> 
> The initial perag reservations can be populated at mount time,
> replenished as needed in a very similar way as what you describe, and
> 100% released back to the thin pool at unmount time. On top of that,
> there's no need to track physical preprovisioned ranges at all. Not just
> for allocation purposes, but also to avoid things like having to protect
> background trims from preprovisioned ranges of free space dedicated for
> metadata, etc. 

That's all well and good, but reading further down the email the
breadth and depth of changes to filesystem and block device
behaviour to enable this are ... significant.

> > Further, managing shared pool exhaustion doesn't require a
> > reservation pool in the backing device and for the filesystems to
> > request space from it. Filesystems already have their own reserve
> > pools via pre-provisioning. If we want the filesystems to be able to
> > release that space back to the shared pool (e.g. because the shared
> > backing pool is critically short on space) then all we need is an
> > extension to FITRIM to tell the filesystem to also release internal
> > pre-provisioned reserves.
> > 
> > Then the backing pool admin (person or automated daemon!) can simply
> > issue a trim on all the filesystems in the pool and spce will be
> > returned. Then filesystems will ask for new pre-provisioned space
> > when they next need to ingest modifications, and the backing pool
> > can manage the new pre-provisioning space requests directly....
> > 
> 
> This is written as to imply that the reservation pool is some big
> complex thing, which makes me think there is some
> confusion/miscommunication.

No confusion, I'm just sceptical that it will work given my
experience trying to implement reservation based solutions multiple
different ways over the past decade. They've all failed because
they collapse under either the complexity explosion or space
overhead required to handle the worst case behavioural scenarios.

At one point I calculated the worst case reservation needed ensure
log recovery will always succeeded, ignoring write amplification,
was about 16x the size of the log. If I took write amplification for
dm-thinp having 64kB blocks and each inode hitting a different
cluster in it's own dm thinp block, that write amplication hit 64x.

So for recovering a 2GB log, if dm-thinp doesn't have a reserve of
well over 100GB of pool space, there is no guarantee that log
recovery will -always- succeed.

It's worst case numbers like this which made me conclude that
reservation based approaches cannot provide guarantees that ENOSPC
will never occur. The numbers are just too large when you start
considering journals that can hold a million dirty objects,
intent chains that might require modifying hundreds of metadata
blocks across a dozen transactions before they complete, etc.

OTOH, REQ_PROVISION makes this "log recovery needs new space to be
allocated" problem go away entirely. It provides a mechanism that
ensures log recovery does not consume any new space in the backing
pool as all the overwrites it performs are to previously provisioned
metadata.....

This is just one of the many reasons why I think the REQ_PROVISION
method is far better than reservations - it solves problems that
pure runtime reservations can't.

> It's basically just an in memory counter of
> space that is allocated out of a shared thin pool and is held in a
> specific thin volume while it is currently in use. The counter on the
> volume is managed indirectly by filesystem requests and/or direct
> operations on the volume (like dm snapshots).
>
> Sure, you could replace the counter and reservation interface with
> explicitly provisioned/trimmed LBA ranges that the fs can manage to
> provide -ENOSPC guarantees, but then the fs has to do those various
> things you've mentioned:
> 
> - Provision those ranges in the fs and change allocation behavior
>   accordingly.

This is relatively simple - most of the allocator functionality is
already there.

> - Do the background post-crash fitrim preprovision clean up thing.

We've already decided this is not needed.

> - Distinguish between trims that are intended to return preprovisioned
>   space vs. those that come from userspace.

It's about ten lines of code in xfs_trim_extents() to do this.  i.e.
the free space tree walk simply skips over free extents in the
metadata provisioned region based on a flag value.

> - Have some daemon or whatever (?) responsible for communicating the
>   need for trims in the fs to return space back to the pool.

Systems are already configured to run a periodic fstrim passes to do
this via systemd units. And I'm pretty sure dm-thinp has a low space
notification to userspace (via dbus?) that is already used by
userspace agents to handle "near ENOSPC" events automatically.

> Then this still depends on changing how dm thin snapshots work and needs
> a way to deal with delayed allocation to actually guarantee -ENOSPC
> protection..?

I think you misunderstand: I'm not proposing to use REQ_PROVISION
for writes the filesystem does not guarantee will succeed. Never
have, I think it makes no sense at all.  If the filesystem
can return ENOSPC for an unprovisioned user data write, then the
block device can too.

> > Hence I think if we get the basic REQ_PROVISION overwrite-in-place
> > guarantees defined and implemented as previously outlined, then we
> > don't need any special coordination between the fs and block devices
> > to avoid fatal ENOSPC issues with sparse and/or snapshot capable
> > block devices...
> > 
> 
> This all sounds like a good amount of coordination and unnecessary
> complexity to me. What I was thinking as a next phase (i.e. after
> initial phase full device reservation) approach for a filesystem like
> XFS would be something like this.
> 
> - Support a mount option for a configurable size metadata reservation
>   pool (with sane/conservative default).

I want this to all to work without the user having be aware that
there filesystem is running on a sparse device.

> - The pool is populated at mount time, else the fs goes right into
>   simulated -ENOSPC mode.

What are the rules of this mode?

Hmmmm.

Log recovery needs to be able to allocate new metadata (i.e. in
intent replay), so I'm guessing reservation is needed before log
recovery? But if pool reservation fails, how do we then safely
perform log recovery given the filesystem is in ENOSPC mode?

> - Thin pool reservation consumption is controlled by a flag on write
>   bios that is managed by the fs (flag polarity TBD).

So we still need a bio flag to communicate "this IO consumes
reservation".

What are the semantics of this flag?  What happens on submission
error? e.g. the bio is failed before it gets to the layer that
consumes it - how does the filesystem know that reservation was
consumed or not at completion?

How do we know when to set it for user data writes?

What happens if the device recieves a bio with this flag but there
is no reservation remaining? e.g. the filesystem or device
accounting have got out of whack?

Hmmm. On that note, what about write amplification? Or should I call
it "reservation amplification". i.e. a 4kB bio with a "consume
reservation" flag might trigger a dm-region COW or allocation and
require 512kB of dm-thinp pool space to be allocated. How much
reservation actually gets consumed, and how do we reconcile the
differences in physical consumption vs reservation consumption?

> - All fs data writes are explicitly reserved up front in the write path.
>   Delalloc maps to explicit reservation, overwrites are easy and just
>   involve an explicit provision.

This is the first you've mentioned an "explicit provision"
operation. Is this like REQ_PROVISION, or something else?

This seems to imply that the ->iomap_begin method has to do
explicit provisioning callouts when we get a write that lands in an
IOMAP_MAPPED extent? Or something else?

Can you describe this mechanism in more detail?

> - Metadata writes are not reserved or provisioned at all. They allocate
>   out of the thin pool on write (if needed), just as they do today. On
>   an -ENOSPC metadata write error, the fs goes into simulated -ENOSPC mode
>   and allows outstanding metadata writes to now use the bio flag to
>   consume emergency reservation.

Okay. We need two pools in the backing device? The normal free space
pool, and an emergency reservation pool?

Without reading further, this implies that the filesystem is
reliant on the emergency reservation pool being large enough that
it can write any dirty metadata it has outstanding without ENOSPC
occuring. How does the size of this emergency pool get configured?

> So this means that metadata -ENOSPC protection is only as reliable as
> the size of the specified pool. This is by design, so the filesystem
> still does not have to track provisioning, allocation or overwrites of
> its own metadata usage. Users with metadata heavy workloads or who
> happen to be sensitive to -ENOSPC errors can be more aggressive with
> pool size, while other users might be able to get away with a smaller
> pool. Users who are super paranoid and want perfection can continue to
> reserve the entire device and pay for the extra storage.

Oh. Hand tuning. :(

> Users who are not sure can test their workload in an appropriate
> environment, collect some data/metrics on maximum outstanding dirty
> metadata, and then use that as a baseline/minimum pool size for reliable
> behavior going forward.  This is also where something like Stratis can
> come in to generate this sort of information, make recommendations or
> implement heuristics (based on things like fs size, amount of RAM, for
> e.g.) to provide sane defaults based on use case. I.e., this is
> initially exposed as a userspace/tuning issue instead of a
> filesystem/dm-thin hard guarantee.

Which are the same things people have been complaining about for years.

> Finally, if you really want to get to that last step of maximally
> efficient and safe provisioning in the fs, implement a
> 'thinreserve=adaptive' mode in the fs that alters the acquisition and
> consumption of dm-thin reserved blocks to be adaptive in nature and
> promises to do it's own usage throttling against outstanding
> reservation. I think this is the mode that most closely resembles your
> preprovisioned range mechanism.
>
> For example, adaptive mode could add the logic/complexity where you do
> the per-ag provision thing (just using reservation instead of physical
> ranges), change the transaction path to attempt to increase the
> reservation pool or go into -ENOSPC mode, and flag all writes to be
> satisfied from the reserve pool (because you've done the
> provision/reservation up front).

Ok, so why not just go straight to this model using REQ_PROVISION?

If we then want to move to a different "accounting only" model for
provisioning, we just change REQ_PROVISION?

But I still see the problem of write amplification accounting being
unsolved by the "filesystem accounting only" approach advocated
here.  We have no idea when the backing device has snapshots taken,
we have no idea when a filesystem write IO actually consumes more
thinp blocks than filesystem blocks, etc.  How does the filesystem
level reservation pool address these problems?

> Thoughts on any of the above?

I'd say it went wrong at the requirements stage, resulting in an
overly complex, over-engineered solution.

> One general tradeoff with using reservations vs. preprovisioning is the
> the latter can just use the provision/trim primitives to alloc/free LBA
> ranges. My thought on that is those primitives could possibly be
> modified to do the same sort of things with reservation as for physical
> allocations. That seems fairly easy to do with bio op flags/modifiers,
> though one thing I'm not sure about is how to submit a provision bio to
> request a certain amount location agnostic blocks. I'd have to
> investigate that more.

Sure, if the constrained LBA space aspect of the REQ_PROVISION
implementation causes issues, then we see if we can optimise away
the fixed LBA space requirement.


-- 
Dave Chinner
david@fromorbit.com
