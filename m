Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8AC70DE6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 16:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbjEWOEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 10:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbjEWOD6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 10:03:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC0111A
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 07:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684850590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d/0oQeB2oBb6hsvg356w0+OEi+j0PMCHZWqWc71xqRU=;
        b=Wlregkdeg4YIqSGf/doaYdE+VCBIZZ/pps9BWKs787vl/LbLMztPoHOdHNfJYKvTumyTho
        nZPQTWfxqo6t0QgXQtTUWaXnFROxCu37KqeoSgsA9vcUkE6ZpAEEjMppyi5g4ujxzRf7gM
        HXeoraX7yceXwQpNSyDWjHmGZPsIJWk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-qJeJ9EheMxGmP3eHxF7DNQ-1; Tue, 23 May 2023 10:02:59 -0400
X-MC-Unique: qJeJ9EheMxGmP3eHxF7DNQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6237c937691so30803356d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 07:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684850578; x=1687442578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/0oQeB2oBb6hsvg356w0+OEi+j0PMCHZWqWc71xqRU=;
        b=ejX9OG33SveUoMjwu15hf0BgLWWgmZCLv0nqZCOr3J57F1o2sB/AU3jkjBk3VH4bBL
         eb2GZvdalGksUxS9AdeZfYDGjPucI+Lv8QmlqvKv24ji10XqkoHAGQ9IYbFKH87Obhbk
         iPewdQuMHviA95nIhvw0aD633babkDSLE1VtQ5WyW35Q7drbqdXn/xzNBWJv1Cis+Pjs
         MS0y+q0MHLDuAwwBnziLp+wYxk4xQXJWWdo1d+tT1YsMY/sgV37YDJQlyT94G9eQZXyP
         aSj2R3R1bKWyMmXf93oybwK/3S6qNjSZgLONeXkYv3aIwUw2BeC3iC7iuN7u6hcMriD2
         yyDQ==
X-Gm-Message-State: AC+VfDzx0qHpf8DAw1zU4ZGR8q7CcSMXdMq6XZT9cNed5E1b5AW0p5Vr
        /4B1oNg2BdwFLJA3MgXwv84MOEKakjL0Mz5X1HyR5LY7kbn7SsQXbqFluwZnRrC/4I0YDwAhra8
        2qbCk6V4609sWRzq2BO0Ejguxgw==
X-Received: by 2002:a05:622a:1a05:b0:3f5:954:3fbb with SMTP id f5-20020a05622a1a0500b003f509543fbbmr24379213qtb.28.1684850578120;
        Tue, 23 May 2023 07:02:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7f1Odnld8SY4FHdYvR1CI3aZa8QjS4u5jebOetOFz56gyyYuQhBC5DS+nR/RS/r0Srv7S16Q==
X-Received: by 2002:a05:622a:1a05:b0:3f5:954:3fbb with SMTP id f5-20020a05622a1a0500b003f509543fbbmr24379138qtb.28.1684850577260;
        Tue, 23 May 2023 07:02:57 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id i14-20020ac871ce000000b003f4fa14decbsm67896qtp.52.2023.05.23.07.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:02:56 -0700 (PDT)
Date:   Tue, 23 May 2023 10:05:26 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, Joe Thornber <ejt@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZGzIJlCE2pcqQRFJ@bfoster>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
 <ZGb2Xi6O3i2pLam8@infradead.org>
 <ZGeKm+jcBxzkMXQs@redhat.com>
 <ZGgBQhsbU9b0RiT1@dread.disaster.area>
 <ZGu0LaQfREvOQO4h@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGu0LaQfREvOQO4h@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 02:27:57PM -0400, Mike Snitzer wrote:
> On Fri, May 19 2023 at  7:07P -0400,
> Dave Chinner <david@fromorbit.com> wrote:
> 
> > On Fri, May 19, 2023 at 10:41:31AM -0400, Mike Snitzer wrote:
> > > On Fri, May 19 2023 at 12:09P -0400,
> > > Christoph Hellwig <hch@infradead.org> wrote:
> > > 
> > > > FYI, I really don't think this primitive is a good idea.  In the
> > > > concept of non-overwritable storage (NAND, SMR drives) the entire
> > > > concept of a one-shoot 'provisioning' that will guarantee later writes
> > > > are always possible is simply bogus.
> > > 
> > > Valid point for sure, such storage shouldn't advertise support (and
> > > will return -EOPNOTSUPP).
> > > 
> > > But the primitive still has utility for other classes of storage.
> > 
> > Yet the thing people are wanting to us filesystem developers to use
> > this with is thinly provisioned storage that has snapshot
> > capability. That, by definition, is non-overwritable storage. These
> > are the use cases people are asking filesystes to gracefully handle
> > and report errors when the sparse backing store runs out of space.
> 
> DM thinp falls into this category but as you detailed it can be made
> to work reliably. To carry that forward we need to first establish
> the REQ_PROVISION primitive (with this series).
> 
> Follow-on associated dm-thinp enhancements can then serve as reference
> for how to take advantage of XFS's ability to operate reliably of
> thinly provisioned storage.
>  
> > e.g. journal writes after a snapshot is taken on a busy filesystem
> > are always an overwrite and this requires more space in the storage
> > device for the write to succeed. ENOSPC from the backing device for
> > journal IO is a -fatal error-. Hence if REQ_PROVISION doesn't
> > guarantee space for overwrites after snapshots, then it's not
> > actually useful for solving the real world use cases we actually
> > need device-level provisioning to solve.
> > 
> > It is not viable for filesystems to have to reprovision space for
> > in-place metadata overwrites after every snapshot - the filesystem
> > may not even know a snapshot has been taken! And it's not feasible
> > for filesystems to provision on demand before they modify metadata
> > because we don't know what metadata is going to need to be modified
> > before we start modifying metadata in transactions. If we get ENOSPC
> > from provisioning in the middle of a dirty transcation, it's all
> > over just the same as if we get ENOSPC during metadata writeback...
> > 
> > Hence what filesystems actually need is device provisioned space to
> > be -always over-writable- without ENOSPC occurring.  Ideally, if we
> > provision a range of the block device, the block device *must*
> > guarantee all future writes to that LBA range succeeds. That
> > guarantee needs to stand until we discard or unmap the LBA range,
> > and for however many writes we do to that LBA range.
> > 
> > e.g. If the device takes a snapshot, it needs to reprovision the
> > potential COW ranges that overlap with the provisioned LBA range at
> > snapshot time. e.g. by re-reserving the space from the backing pool
> > for the provisioned space so if a COW occurs there is space
> > guaranteed for it to succeed.  If there isn't space in the backing
> > pool for the reprovisioning, then whatever operation that triggers
> > the COW behaviour should fail with ENOSPC before doing anything
> > else....
> 
> Happy to implement this in dm-thinp.  Each thin block will need a bit
> to say if the block must be REQ_PROVISION'd at time of snapshot (and
> the resulting block will need the same bit set).
> 
> Walking all blocks of a thin device and triggering REQ_PROVISION for
> each will obviously make thin snapshot creation take more time.
> 
> I think this approach is better than having a dedicated bitmap hooked
> off each thin device's metadata (with bitmap being copied and walked
> at the time of snapshot). But we'll see... I'll get with Joe to
> discuss further.
> 

Hi Mike,

If you recall our most recent discussions on this topic, I was thinking
about the prospect of reserving the entire volume at mount time as an
initial solution to this problem. When looking through some of the old
reservation bits we prototyped years ago, it occurred to me that we have
enough mechanism to actually prototype this.

So FYI, I have some hacky prototype code that essentially has the
filesystem at mount time tell dm it's using the volume and expects all
further writes to succeed. dm-thin acquires reservation for the entire
range of the volume for which writes would require block allocation
(i.e., holes and shared dm blocks) or otherwise warns that the fs cannot
be "safely" mounted.

The reservation pool associates with the thin volume (not the
filesystem), so if a snapshot is requested from dm, the snapshot request
locates the snapshot origin and if it's currently active, increases the
reservation pool to account for outstanding blocks that are about to
become shared, or otherwise fails the snapshot with -ENOSPC. (I suspect
discard needs similar treatment, but I hadn't got to that yet.). If the
fs is not active, there is nothing to protect and so the snapshot
proceeds as normal.

This seems to work on my simple, initial tests for protecting actively
mounted filesystems from dm-thin -ENOSPC. This definitely needs a sanity
check from dm-thin folks, however, because I don't know enough about the
broader subsystem to reason about whether it's sufficiently correct. I
just managed to beat the older prototype code into submission to get it
to do what I wanted on simple experiments.

Thoughts on something like this? I think the main advantage is that it
significantly reduces the requirements on the fs to track individual
allocations. It's basically an on/off switch from the fs perspective,
doesn't require any explicit provisioning whatsoever (though it can be
done to improve things in the future) and in fact could probably be tied
to thin volume activation to be made completely filesystem agnostic.
Another advantage is that it requires no on-disk changes, no breaking
COWs up front during snapshots, etc.

The disadvantages are that it's space inefficient wrt to thin pool free
space, but IIUC this is essentially what userspace management layers
(such as Stratis) are doing today, they just put restrictions up front
at volume configuration/creation time instead of at runtime. There also
needs to be some kind of interface between the fs and dm. I suppose we
could co-opt provision and discard primitives with a "reservation"
modifier flag to get around that in a simple way, but that sounds
potentially ugly. TBH, the more I think about this the more I think it
makes sense to reserve on volume activation (with some caveats to allow
a read-only mode, explicit bypass, etc.) and then let the
cross-subsystem interface be dictated by granularity improvements...

... since I also happen to think there is a potentially interesting
development path to make this sort of reserve pool configurable in terms
of size and active/inactive state, which would allow the fs to use an
emergency pool scheme for managing metadata provisioning and not have to
track and provision individual metadata buffers at all (dealing with
user data is much easier to provision explicitly). So the space
inefficiency thing is potentially just a tradeoff for simplicity, and
filesystems that want more granularity for better behavior could achieve
that with more work. Filesystems that don't would be free to rely on the
simple/basic mechanism provided by dm-thin and still have basic -ENOSPC
protection with very minimal changes.

That's getting too far into the weeds on the future bits, though. This
is essentially 99% a dm-thin approach, so I'm mainly curious if there's
sufficient interest in this sort of "reserve mode" approach to try and
clean it up further and have dm guys look at it, or if you guys see any
obvious issues in what it does that makes it potentially problematic, or
if you would just prefer to go down the path described above...

Brian

> > Software devices like dm-thin/snapshot should really only need to
> > keep a persistent map of the provisioned space and refresh space
> > reservations for used space within that map whenever something that
> > triggers COW behaviour occurs. i.e. a snapshot needs to reset the
> > provisioned ranges back to "all ranges are freshly provisioned"
> > before the snapshot is started. If that space is not available in
> > the backing pool, then the snapshot attempt gets ENOSPC....
> > 
> > That means filesystems only need to provision space for journals and
> > fixed metadata at mkfs time, and they only need issue a
> > REQ_PROVISION bio when they first allocate over-write in place
> > metadata. We already have online discard and/or fstrim for releasing
> > provisioned space via discards.
> > 
> > This will require some mods to filesystems like ext4 and XFS to
> > issue REQ_PROVISION and fail gracefully during metadata allocation.
> > However, doing so means that we can actually harden filesystems
> > against sparse block device ENOSPC errors by ensuring they will
> > never occur in critical filesystem structures....
> 
> Yes, let's finally _do_ this! ;)
> 
> Mike
> 

