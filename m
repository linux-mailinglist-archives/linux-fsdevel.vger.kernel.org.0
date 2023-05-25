Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AACD711A4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 00:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241922AbjEYWrl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 18:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241523AbjEYWri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 18:47:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB019D9
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 15:47:33 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51144dddd4cso70846a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 15:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685054852; x=1687646852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6D4P/JK41Ddrow0l0zlRwdkdCpiqpcZbO2AfcEMcPI=;
        b=jEO/FLLakl+6KJpbcfREe6f1tZlqkXsM8SahgWW/TInIaJTeaZgPoaC1GbzKYgiz9K
         rGe2pvgx5CdD1yyu8RAMKnt99J9CxzY70P8z/YJJVASB9LMZQ4FR8NAS3V93U/I0RBfC
         SbSFxR5gomaDVFhvveBM9o+xKmRwq7fhT3Bj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685054852; x=1687646852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6D4P/JK41Ddrow0l0zlRwdkdCpiqpcZbO2AfcEMcPI=;
        b=O5OAZh4tPY0/XI6d7VaFbrmw97TLqw9n7iuk6iDTUD7uXdIi3wDJs/hUl5SI6nKT9V
         cwa7g0dMc5xrsVQoRS/rBbhfZS/JH7Nc49lFyOx/KgTLdYynQ15e1Es7ay6UmBPKhLtP
         91ThJvQK2bzobv97E2jNKpJtR9GGKyUrpHYKKKqRzDeKfJ6y7S846N1oDB4leGaCtYNr
         SQhdzlFmFzirXkCSCbI01cJuTck7w3M0dTjyVOOVuH0vd7Bi5SHcXveyPNOaNSqHnfhQ
         Zs4P0xq4whFqU176An/28zZ4+RweyDd4Z+ebR5h2No+cUhb8RS/nf+Yg4Lx0SE7yWqza
         w/fQ==
X-Gm-Message-State: AC+VfDyvnplWVym2+j3Z6hdT8Ywp1/zZFewHjMzYAGMMfHUI0EKL6tP2
        XClRzpghK75b6+kGaIZkmbLV6CX+7jweBA893/j14g==
X-Google-Smtp-Source: ACHHUZ71HRrOp6MfK+Cw+RJmShDtRB759VvBHCr7evJoSbuNfS+tOKqG+kM7n2MPzvM2d3iPlRupOezJxtTg4j5CL2g=
X-Received: by 2002:a17:907:724f:b0:96f:2b3f:61 with SMTP id
 ds15-20020a170907724f00b0096f2b3f0061mr301197ejc.7.1685054852142; Thu, 25 May
 2023 15:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
 <ZGb2Xi6O3i2pLam8@infradead.org> <ZGeKm+jcBxzkMXQs@redhat.com>
 <ZGgBQhsbU9b0RiT1@dread.disaster.area> <ZGu0LaQfREvOQO4h@redhat.com>
 <ZGzIJlCE2pcqQRFJ@bfoster> <ZGzbGg35SqMrWfpr@redhat.com> <ZG1dAtHmbQ53aOhA@dread.disaster.area>
 <ZG5taYoXDRymo/e9@redhat.com> <ZG9JD+4Zu36lnm4F@dread.disaster.area> <ZG+GKwFC7M3FfAO5@redhat.com>
In-Reply-To: <ZG+GKwFC7M3FfAO5@redhat.com>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 25 May 2023 15:47:21 -0700
Message-ID: <CAG9=OMNhCNFhTcktxSMYbc5WXkSZ-vVVPtb4ak6B3Z2-kEVX0Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, Joe Thornber <ejt@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 9:00=E2=80=AFAM Mike Snitzer <snitzer@kernel.org> w=
rote:
>
> On Thu, May 25 2023 at  7:39P -0400,
> Dave Chinner <david@fromorbit.com> wrote:
>
> > On Wed, May 24, 2023 at 04:02:49PM -0400, Mike Snitzer wrote:
> > > On Tue, May 23 2023 at  8:40P -0400,
> > > Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > > On Tue, May 23, 2023 at 11:26:18AM -0400, Mike Snitzer wrote:
> > > > > On Tue, May 23 2023 at 10:05P -0400, Brian Foster <bfoster@redhat=
.com> wrote:
> > > > > > On Mon, May 22, 2023 at 02:27:57PM -0400, Mike Snitzer wrote:
> > > > > > ... since I also happen to think there is a potentially interes=
ting
> > > > > > development path to make this sort of reserve pool configurable=
 in terms
> > > > > > of size and active/inactive state, which would allow the fs to =
use an
> > > > > > emergency pool scheme for managing metadata provisioning and no=
t have to
> > > > > > track and provision individual metadata buffers at all (dealing=
 with
> > > > > > user data is much easier to provision explicitly). So the space
> > > > > > inefficiency thing is potentially just a tradeoff for simplicit=
y, and
> > > > > > filesystems that want more granularity for better behavior coul=
d achieve
> > > > > > that with more work. Filesystems that don't would be free to re=
ly on the
> > > > > > simple/basic mechanism provided by dm-thin and still have basic=
 -ENOSPC
> > > > > > protection with very minimal changes.
> > > > > >
> > > > > > That's getting too far into the weeds on the future bits, thoug=
h. This
> > > > > > is essentially 99% a dm-thin approach, so I'm mainly curious if=
 there's
> > > > > > sufficient interest in this sort of "reserve mode" approach to =
try and
> > > > > > clean it up further and have dm guys look at it, or if you guys=
 see any
> > > > > > obvious issues in what it does that makes it potentially proble=
matic, or
> > > > > > if you would just prefer to go down the path described above...
> > > > >
> > > > > The model that Dave detailed, which builds on REQ_PROVISION and i=
s
> > > > > sticky (by provisioning same blocks for snapshot) seems more usef=
ul to
> > > > > me because it is quite precise.  That said, it doesn't account fo=
r
> > > > > hard requirements that _all_ blocks will always succeed.
> > > >
> > > > Hmmm. Maybe I'm misunderstanding the "reserve pool" context here,
> > > > but I don't think we'd ever need a hard guarantee from the block
> > > > device that every write bio issued from the filesystem will succeed
> > > > without ENOSPC.
> > > >
> > > > If the block device can provide a guarantee that a provisioned LBA
> > > > range is always writable, then everything else is a filesystem leve=
l
> > > > optimisation problem and we don't have to involve the block device
> > > > in any way. All we need is a flag we can ready out of the bdev at
> > > > mount time to determine if the filesystem should be operating with
> > > > LBA provisioning enabled...
> > > >
> > > > e.g. If we need to "pre-provision" a chunk of the LBA space for
> > > > filesystem metadata, we can do that ahead of time and track the
> > > > pre-provisioned range(s) in the filesystem itself.
> > > >
> > > > In XFS, That could be as simple as having small chunks of each AG
> > > > reserved to metadata (e.g. start with the first 100MB) and limiting
> > > > all metadata allocation free space searches to that specific block
> > > > range. When we run low on that space, we pre-provision another 100M=
B
> > > > chunk and then allocate all metadata out of that new range. If we
> > > > start getting ENOSPC to pre-provisioning, then we reduce the size o=
f
> > > > the regions and log low space warnings to userspace. If we can't
> > > > pre-provision any space at all and we've completely run out, we
> > > > simply declare ENOSPC for all incoming operations that require
> > > > metadata allocation until pre-provisioning succeeds again.
> > >
> > > This is basically saying the same thing but:
> > >
> > > It could be that the LBA space is fragmented and so falling back to
> > > the smallest region size (that matches the thinp block size) would be
> > > the last resort?  Then if/when thinp cannot even service allocating a
> > > new free thin block, dm-thinp will transition to out-of-data-space
> > > mode.
> >
> > Yes, something of that sort, though we'd probably give up if we
> > can't get at least megabyte scale reservations - a single
> > modification in XFS can modify many structures and require
> > allocation of a lot of new metadata, so the fileystem cut-off would
> > for metadata provisioning failure would be much larger than the
> > dm-thinp region size....
> >
> > > > This is built entirely on the premise that once proactive backing
> > > > device provisioning fails, the backing device is at ENOSPC and we
> > > > have to wait for that situation to go away before allowing new data
> > > > to be ingested. Hence the block device really doesn't need to know
> > > > anything about what the filesystem is doing and vice versa - The
> > > > block dev just says "yes" or "no" and the filesystem handles
> > > > everything else.
> > >
> > > Yes.
> > >
> > > > It's worth noting that XFS already has a coarse-grained
> > > > implementation of preferred regions for metadata storage. It will
> > > > currently not use those metadata-preferred regions for user data
> > > > unless all the remaining user data space is full.  Hence I'm pretty
> > > > sure that a pre-provisioning enhancment like this can be done
> > > > entirely in-memory without requiring any new on-disk state to be
> > > > added.
> > > >
> > > > Sure, if we crash and remount, then we might chose a different LBA
> > > > region for pre-provisioning. But that's not really a huge deal as w=
e
> > > > could also run an internal background post-mount fstrim operation t=
o
> > > > remove any unused pre-provisioning that was left over from when the
> > > > system went down.
> > >
> > > This would be the FITRIM with extension you mention below? Which is a
> > > filesystem interface detail?
> >
> > No. We might reuse some of the internal infrastructure we use to
> > implement FITRIM, but that's about it. It's just something kinda
> > like FITRIM but with different constraints determined by the
> > filesystem rather than the user...
> >
> > As it is, I'm not sure we'd even need it - a preiodic userspace
> > FITRIM would acheive the same result, so leaked provisioned spaces
> > would get cleaned up eventually without the filesystem having to do
> > anything specific...
> >
> > > So dm-thinp would _not_ need to have new
> > > state that tracks "provisioned but unused" block?
> >
> > No idea - that's your domain. :)
> >
> > dm-snapshot, for certain, will need to track provisioned regions
> > because it has to guarantee that overwrites to provisioned space in
> > the origin device will always succeed. Hence it needs to know how
> > much space breaking sharing in provisioned regions after a snapshot
> > has been taken with be required...
>
> dm-thinp offers its own much more scalable snapshot support (doesn't
> use old dm-snapshot N-way copyout target).
>
> dm-snapshot isn't going to be modified to support this level of
> hardening (dm-snapshot is basically in "maintenance only" now).
>
> But I understand your meaning: what you said is 100% applicable to
> dm-thinp's snapshot implementation and needs to be accounted for in
> thinp's metadata (inherent 'provisioned' flag).
>
A bit orthogonal: would dm-thinp need to differentiate between
user-triggered provision requests (eg. from fallocate()) vs
fs-triggered requests? I would lean towards user provisioned areas not
getting dedup'd on snapshot creation, but that would entail tracking
the state of the original request and possibly a provision request
flag (REQ_PROVISION_DEDUP_ON_SNAPSHOT) or an inverse flag
(REQ_PROVISION_NODEDUP). Possibly too convoluted...

> > > Nor would the block
> > > layer need an extra discard flag for a new class of "provisioned"
> > > blocks.
> >
> > Right, I don't see that the discard operations need to care whether
> > the underlying storage is provisioned. dm-thinp and dm-snapshot can
> > treat REQ_OP_DISCARD as "this range is not longer in use" and do
> > whatever they want with them.
> >
> > > If XFS tracked this "provisioned but unused" state, dm-thinp could
> > > just discard the block like its told.  Would be nice to avoid dm-thin=
p
> > > needing to track "provisioned but unused".
> > >
> > > That said, dm-thinp does still need to know if a block was provisione=
d
> > > (given our previous designed discussion, to allow proper guarantees
> > > from this interface at snapshot time) so that XFS and other
> > > filesystems don't need to re-provision areas they already
> > > pre-provisioned.
> >
> > Right.
> >
> > I've simply assumed that dm-thinp would need to track entire
> > provisioned regions - used or unused - so it knows which writes to
> > empty or shared regions have a reservation to allow allocation to
> > succeed when the backing pool is otherwise empty.....
> >
> > > However, it may be that if thinp did track "provisioned but unused"
> > > it'd be useful to allow snapshots to share provisioned blocks that
> > > were never used.  Meaning, we could then avoid "breaking sharing" at
> > > snapshot-time for "provisioned but unused" blocks.  But allowing this
> > > "optimization" undercuts the gaurantee that XFS needs for thinp
> > > storage that allows snapshots... SO, I think I answered my own
> > > question: thinp doesnt need to track "provisioned but unused" blocks
> > > but we must always ensure snapshots inherit provisoned blocks ;)
> >
> > Sounds like a potential optimisation, but I haven't thought through
> > a potential snapshot device implementation that far to comment
> > sanely. I stopped once I got to the point where accounting tricks
> > count be used to guarantee space is available for breaking sharing
> > of used provisioned space after a snapshot was taken....
> >
> > > > Further, managing shared pool exhaustion doesn't require a
> > > > reservation pool in the backing device and for the filesystems to
> > > > request space from it. Filesystems already have their own reserve
> > > > pools via pre-provisioning. If we want the filesystems to be able t=
o
> > > > release that space back to the shared pool (e.g. because the shared
> > > > backing pool is critically short on space) then all we need is an
> > > > extension to FITRIM to tell the filesystem to also release internal
> > > > pre-provisioned reserves.
> > >
> > > So by default FITRIM will _not_ discard provisioned blocks.  Only if
> > > a flag is used will it result in discarding provisioned blocks.
> >
> > No. FITRIM results in discard of any unused free space in the
> > filesystem that matches the criteria set by the user. We don't care
> > if free space was once provisioned used space - we'll issue a
> > discard for the range regardless. The "special" FITRIM extension I
> > mentioned is to get filesystem metadata provisioning released;
> > that's completely separate to user data provisioning through
> > fallocate() which FITRIM will always discard if it has been freed...
> >
> > IOWs, normal behaviour will be that a FITRIM ends up discarding a
> > mix of unprovisioned and provisioned space. Nobody will be able to
> > predict what mix the device is going to get at any point in time.
> > Also, if we turn on online discard, the block device is going to get
> > a constant stream of discard operations that will also be a mix of
> > provisioned and unprovisioned space that is not longer in use by the
> > filesystem.
> >
> > I suspect that you need to stop trying to double guess what
> > operations the filesystem will use provisioning for, what it will
> > send discards for and when it will send discards for them.. Just
> > assume the device will receive a constant stream of both
> > REQ_PROVISION and REQ_OP_DISCARD (for both provisioned and
> > unprovisioned regions) operations whenver the filesystem is active
> > on a thinp device.....
>
> Yeah, I was getting tripped up in the weeds a bit.  It's pretty
> straight-forward (and like I said at the start of our subthread here:
> this follow-on work, to inherit provisioned flag, can build on this
> REQ_PROVISION patchset).
>
> All said, I've now gotten this sub-thread on Joe Thornber's radar and
> we've started discussing. We'll be discussing with more focus
> tomorrow.
>
From the perspective of this patch series, I'll wait for more feedback
before sending out v8 (which would be the above patches and the
follow-on patch to pass through FALLOC_FL_UNSHARE_RANGE [1]).

[1] https://listman.redhat.com/archives/dm-devel/2023-May/054188.html

Thanks!
Sarthak

> Mike
