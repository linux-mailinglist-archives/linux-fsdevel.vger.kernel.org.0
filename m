Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F1472110B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 17:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjFCP6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jun 2023 11:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFCP6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jun 2023 11:58:34 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02C9E1
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Jun 2023 08:57:50 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-62614a1dd47so24729326d6.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Jun 2023 08:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685807870; x=1688399870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h33Y8ZBTshpCakU2rwk1PXhPYpv5BZ6wPeCedcd+LbM=;
        b=Pzse2u3C1a9477FPJY1o1Gl1F8KuBSTkWD39DwQZBuPOpTVYUre7U3d/fI2SDhdG8z
         5jdpDJ4BQ8rDrHJxMKZ+tkKa7EFNkP2WjpT1uB06Zp6LhK/tu3SG42LeNM27VNTath/K
         FXInnyBmuRaW1hrB3cmE9/eo+b5uDywgCfz3KM9k5Zac9/COL/r7P7t1DdbZW0ulKPdN
         PZNFXVPjQEEJBuPzu3ezt0FcbA1n5P/cMkKFmBAbN8qv/jAQLOPQLGY5lJTFojuFuric
         SqxetkVGCyIQ8TgWfXWlFOiPbUfE7h8r2JGDp0zO/vhr5p/e+7z5tvwM51WVZ1lXVTYy
         OVLA==
X-Gm-Message-State: AC+VfDw7gQJ+J2phbcQNIRqjKwYFKC6pgykDKo/vsjDvNezeP/vFTAZ9
        sYexXHiwGsJ9zH71inNQEOhW
X-Google-Smtp-Source: ACHHUZ4wWtOFT5sPRaDxYAshqrzDTegg4zHApyL4QgQ9q20uQleDbcB0ClYa4RtM1+bM6Hq0UDX2uA==
X-Received: by 2002:ad4:5d6c:0:b0:5e9:2bad:c8fa with SMTP id fn12-20020ad45d6c000000b005e92badc8famr2204971qvb.33.1685807869654;
        Sat, 03 Jun 2023 08:57:49 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id m13-20020a05621402ad00b00623839cba8csm2292876qvv.44.2023.06.03.08.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 08:57:49 -0700 (PDT)
Date:   Sat, 3 Jun 2023 11:57:48 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Joe Thornber <thornber@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Joe Thornber <ejt@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZHti/MLnX5xGw9b7@redhat.com>
References: <ZG+KoxDMeyogq4J0@bfoster>
 <ZHB954zGG1ag0E/t@dread.disaster.area>
 <CAJ0trDbspRaDKzTzTjFdPHdB9n0Q9unfu1cEk8giTWoNu3jP8g@mail.gmail.com>
 <ZHFEfngPyUOqlthr@dread.disaster.area>
 <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
 <ZHYB/6l5Wi+xwkbQ@redhat.com>
 <CAJ0trDaUOevfiEpXasOESrLHTCcr=oz28ywJU+s+YOiuh7iWow@mail.gmail.com>
 <ZHYWAGmKhwwmTjW/@redhat.com>
 <CAG9=OMMnDfN++-bJP3jLmUD6O=Q_ApV5Dr392_5GqsPAi_dDkg@mail.gmail.com>
 <ZHqOvq3ORETQB31m@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHqOvq3ORETQB31m@dread.disaster.area>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02 2023 at  8:52P -0400,
Dave Chinner <david@fromorbit.com> wrote:

> On Fri, Jun 02, 2023 at 11:44:27AM -0700, Sarthak Kukreti wrote:
> > On Tue, May 30, 2023 at 8:28 AM Mike Snitzer <snitzer@kernel.org> wrote:
> > >
> > > On Tue, May 30 2023 at 10:55P -0400,
> > > Joe Thornber <thornber@redhat.com> wrote:
> > >
> > > > On Tue, May 30, 2023 at 3:02 PM Mike Snitzer <snitzer@kernel.org> wrote:
> > > >
> > > > >
> > > > > Also Joe, for you proposed dm-thinp design where you distinquish
> > > > > between "provision" and "reserve": Would it make sense for REQ_META
> > > > > (e.g. all XFS metadata) with REQ_PROVISION to be treated as an
> > > > > LBA-specific hard request?  Whereas REQ_PROVISION on its own provides
> > > > > more freedom to just reserve the length of blocks? (e.g. for XFS
> > > > > delalloc where LBA range is unknown, but dm-thinp can be asked to
> > > > > reserve space to accomodate it).
> > > > >
> > > >
> > > > My proposal only involves 'reserve'.  Provisioning will be done as part of
> > > > the usual io path.
> > >
> > > OK, I think we'd do well to pin down the top-level block interfaces in
> > > question. Because this patchset's block interface patch (2/5) header
> > > says:
> > >
> > > "This patch also adds the capability to call fallocate() in mode 0
> > > on block devices, which will send REQ_OP_PROVISION to the block
> > > device for the specified range,"
> > >
> > > So it wires up blkdev_fallocate() to call blkdev_issue_provision(). A
> > > user of XFS could then use fallocate() for user data -- which would
> > > cause thinp's reserve to _not_ be used for critical metadata.
> 
> Mike, I think you might have misunderstood what I have been proposing.
> Possibly unintentionally, I didn't call it REQ_OP_PROVISION but
> that's what I intended - the operation does not contain data at all.
> It's an operation like REQ_OP_DISCARD or REQ_OP_WRITE_ZEROS - it
> contains a range of sectors that need to be provisioned (or
> discarded), and nothing else.

No, I understood that.

> The write IOs themselves are not tagged with anything special at all.

I know, but I've been looking at how to also handle the delalloc
usecase (and yes I know you feel it doesn't need handling, the issue
is XFS does deal nicely with ensuring it has space when it tracks its
allocations on "thick" storage -- so adding coordination between XFS
and dm-thin layers provides comparable safety.. that safety is an
expected norm).

But rather than discuss in terms of data vs metadata, the distinction
is:
1) LBA range reservation (normal case, your proposal)
2) non-LBA reservation (absolute value, LBA range is known at later stage)

But I'm clearly going off script for dwelling on wanting to handle
both.

My looking at (ab)using REQ_META being set (use 1) vs not (use 2) was
a crude simplification for branching between the 2 approaches.

And I understand I made you nervous by expanding the scope to a much
more muddled/shitty interface. ;)

We all just need to focus on your proposal and Joe's dm-thin
reservation design...

[Sarthak: FYI, this implies that it doesn't really make sense to add
dm-thinp support before Joe's design is implemented.  Otherwise we'll
have 2 different responses to REQ_OP_PROVISION.  The one that is
captured in your patchset isn't adequate to properly handle ensuring
upper layer (like XFS) can depend on the space being available across
snapshot boundaries.]

> i.e. The proposal I made does not use REQ_PROVISION anywhere in the
> metadata/data IO path; provisioned regions are created by separate
> operations and must be tracked by the underlying block device, then
> treat any write IO to those regions as "must not fail w/ ENOSPC"
> IOs.
> 
> There seems to be a lot of fear about user data requiring
> provisioning. This is unfounded - provisioning is only needed for
> explicitly provisioned space via fallocate(), not every byte of
> user data written to the filesystem (the model Brian is proposing).

As I mentioned above, I was just trying to get XFS-on-thinp to
maintain parity with how XFS's delalloc accounting works on "thick"
storage.

But happy to put that to one side.  Maintain focus like I mentioned
above.  I'm happy we have momentum and agreement on this design now.
Rather than be content with that, I was mistakenly looking at other
aspects and in doing so introduced "noise" before we've implemented
what we all completely agree on: your and joe's designs.

> Excessive use of fallocate() is self correcting - if users and/or
> their applications provision too much, they are going to get ENOSPC
> or have to pay more to expand the backing pool reserves they need.
> But that's not a problem the block device should be trying to solve;
> that's a problem for the sysadmin and/or bean counters to address.
> 
> > >
> > > The only way to distinquish the caller (between on-behalf of user data
> > > vs XFS metadata) would be REQ_META?
> > >
> > > So should dm-thinp have a REQ_META-based distinction? Or just treat
> > > all REQ_OP_PROVISION the same?
> > >
> > I'm in favor of a REQ_META-based distinction.
> 
> Why? What *requirement* is driving the need for this distinction?

Think I answered that above, XFS delalloc accounting parity on thinp.

> As the person who proposed this new REQ_OP_PROVISION architecture,
> I'm dead set against it.  Allowing the block device provide a set of
> poorly defined "conditional guarantees" policies instead of a
> mechanism with a single ironclad guarantee defeats the entire
> purpose of the proposal. 
> 
> We have a requirement from the *kernel ABI* that *user data writes*
> must not fail with ENOSPC after an fallocate() operation.  That's
> one of the high level policies we need to implement. The filesystem
> is already capable of guaranteeing it won't give the user ENOSPC
> after fallocate, we now need a guarantee from the filesystem's
> backing store that it won't give ENOSPC, too.

Yes, I was trying to navigate Joe's reluctance to even support
fallocate() for arbitrary user data.  That's where the REQ_META vs
data distinction crept in for me.  But as you say: using fallocate()
excessively is self-correcting.

> The _other thing_ we need to implement is a method of guaranteeing
> the filesystem won't shut down when the backing device goes ENOSPC
> unexpected during metadata writeback.  So we also need the backing
> device to guarantee the regions we write metadata to won't give
> ENOSPC.

Yeap.

> That's the whole point of REQ_OP_PROVISION: from the layers above
> the block device, there is -zero- difference between the guarantee
> we need for user data writes to avoid ENOSPC and for metadata writes
> to avoid ENOSPC. They are one and the same.

I know.  The difference comes from delalloc initially needing an
absolute value of reserve rather than a specific LBA range.

> Hence if the block device is going to say "I support provisioning"
> but then give different conditional guarantees according to the
> *type of data* in the IO request, then it does not provide the
> functionality the higher layers actually require from it.

I was going for relaxing the "dynamic" approach (Brian's) to be
best-effort -- and really only for XFS delalloc usecase.  Every other
usecase would respect your and Joe's vision.

> Indeed, what type of data the IO contains is *context dependent*.
> For example, sometimes we write metadata with user data IO and but
> we still need provisioning guarantees as if it was issued as
> metadata IO. This is the case for mkfs initialising the file system
> by writing directly to the block device.

I'm aware.

> IOWs, filesystem metadata IO issued from kernel context would be
> considered metadata IO, but from userspace it would be considered
> normal user data IO and hence treated differently. But the reality
> is that they both need the same provisioning guarantees to be
> provided by the block device.

What I was looking at is making the fallocate interface able to
express: I need dave's requirements (bog-standard actually) vs I need
non-LBA best effort.

> So how do userspace tools deal with this if the block device
> requires REQ_META on user data IOs to do the right thing here? And
> if we provide a mechanism to allow this, how do we prevent userspace
> for always using it on writes to fallocate() provisioned space?
> 
> It's just not practical for the block device to add arbitrary
> constraints based on the type of IO because we then have to add
> mechanisms to userspace APIs to allow them to control the IO context
> so the block device will do the right thing. Especially considering
> we really only need one type of guarantee regardless of where the IO
> originates from or what type of data the IO contains....

If anything my disposition on the conditional to require a REQ_META
(or some fallocate generated REQ_UNSHARE ditto to reflect the same) to
perform your approach to REQ_OP_PROVISION and honor fallocate()
requirements is a big problem.  Would be much better to have a flag to
express "this reservation does not have an LBA range _yet_,
nevertheless try to be mindful of this expected near-term block
allocation".

But I'll stop inlining repetitive (similar but different) answers to
your concern now ;)
 
> > Does that imply that
> > REQ_META also needs to be passed through the block/filesystem stack
> > (eg. REQ_OP_PROVION + REQ_META on a loop device translates to a
> > fallocate(<insert meta flag name>) to the underlying file)?
> 
> This is exactly the same case as above: the loopback device does
> user data IO to the backing file. Hence we have another situation
> where metadata IO is issued to fallocate()d user data ranges as user
> data ranges and so would be given a lesser guarantee that would lead
> to upper filesystem failure. BOth upper and lower filesystem data
> and metadata need to be provided the same ENOSPC guarantees by their
> backing stores....
> 
> The whole point of the REQ_OP_PROVISION proposal I made is that it
> doesn't require any special handling in corner cases like this.
> There are no cross-layer interactions needed to make everything work
> correctly because the provisioning guarantee is not -data type
> dependent*. The entire user IO path code remains untouched and
> blissfully unaware of provisioned regions.
> 
> And, realistically, if we have to start handling complex corner
> cases in the filesystem and IO path layers to make REQ_OP_PROVISION
> work correctly because of arbitary constraints imposed by the block
> layer implementations, then we've failed miserably at the design and
> architecture stage.
> 
> Keep in mind that every attempt made so far to address the problems
> with block device ENOSPC errors has failed because of the complexity
> of the corner cases that have arisen during design and/or
> implementation. It's pretty ironic that now we have a proposal that
> is remarkably simple, free of corner cases and has virtually no
> cross-layer coupling at all, the first thing that people want to do
> is add arbitrary implementation constraints that result in complex
> cross-layer corner cases that now need to be handled....
> 
> Put simply: if we restrict REQ_OP_PROVISION guarantees to just
> REQ_META writes (or any other specific type of write operation) then
> it's simply not worth persuing at the filesystem level because the
> guarantees we actually need just aren't there and the complexity of
> discovering and handling those corner cases just isn't worth the
> effort.

Here is where I get to say: I think you misunderstood me (but it was
my fault for not being absolutely clear: I'm very much on the same
page as you and Joe; and your visions need to just be implemented
ASAP).

I was taking your designs as a given, but looking further at: how do
we also handle the non-LBA (delalloc) usecase _before_ we include
REQ_OP_PROVISION in kernel.

But I'm happy to let the delalloc case go (we can revisit addressing
it if/when needed).

Mike
