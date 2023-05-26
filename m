Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A9A712A04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 17:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbjEZPzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 11:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjEZPzD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 11:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104511BC
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685116454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yvxKbFohSEsTJ6py9Z2WVJoxOwakRTNCjSwfmDukp7I=;
        b=MzfDShTVTa7dWXJOul1ueljuYqZqwuoAkZEm3OEA76bTceY2obUIqLMeh8wtT6TdK044zZ
        xtRjApPoZO7ScbOUcPs/2ZUkQTlXBlxZUxKqC/O9Dosh4yA9jq0nXuR/6c5gvcbqL8OOMC
        UBTAl+3G/NC8uGU3uPqFSHhbqJq+xxQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-Z_-hehJnP-6bT3mEeyTmyA-1; Fri, 26 May 2023 11:54:12 -0400
X-MC-Unique: Z_-hehJnP-6bT3mEeyTmyA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6238d8b7fdcso7484246d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 08:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685116451; x=1687708451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvxKbFohSEsTJ6py9Z2WVJoxOwakRTNCjSwfmDukp7I=;
        b=jBAyW+bejp39s1jKoGdnjjAW+PbyMeDKi/6rUOX0P1nJzzz78DMdderiWCniejwJsK
         FlSokG9ioytqc/1Li/B8HILZfjLZEb65bdm2kqQouoFx1GP40knDuc1sTcYgkobD/nsd
         PCxIQ7I65vIqNzQ69BPTz9DOjRR69qvcXnEYL2AgbDzk3GRuQYq55zu27R1Qclx22yTN
         rBJ1PfYyACl/sxdvAjVPUICgj33WRa5+VvMy0f6lspcAkSzb/1dYeOoREeyZnZUDkKlU
         qQvRDp3kRqMeD0kz3O3uZyBOqUdzqAuhC8pjZcR+HPrsgkzaGEKtGpDCVViWiwC/SdH+
         ZxAA==
X-Gm-Message-State: AC+VfDw1dHbOgRzGJAd03neaa616Xh/CNUhpr5VkAFtW6dLS6YTwAwv4
        9Q736tlSwRZ+K60kCD+7LGC5oQ2RnZztnC/5oBTe1V2RMAGTYJX9C8LOT/Ff7AAJ3sQgRNJtvF9
        ynjUpKd/x/vSgu70wNeg2NN0w9w==
X-Received: by 2002:a05:6214:20e2:b0:621:6217:f528 with SMTP id 2-20020a05621420e200b006216217f528mr2129224qvk.30.1685116451614;
        Fri, 26 May 2023 08:54:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7crxinp6L7mS4raZXU4iJU8lF1hK2z1fz8ghdfLF7RtzHOAE7Y1Kt0NJxyPfYsUfrY8tCFQg==
X-Received: by 2002:a05:6214:20e2:b0:621:6217:f528 with SMTP id 2-20020a05621420e200b006216217f528mr2129188qvk.30.1685116451285;
        Fri, 26 May 2023 08:54:11 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id m6-20020a0ce8c6000000b006260bff22d7sm310600qvo.27.2023.05.26.08.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 08:54:10 -0700 (PDT)
Date:   Fri, 26 May 2023 11:56:41 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Joe Thornber <ejt@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Bart Van Assche <bvanassche@google.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
Message-ID: <ZHDWuac/IvLKgPbK@bfoster>
References: <ZGu0LaQfREvOQO4h@redhat.com>
 <ZGzIJlCE2pcqQRFJ@bfoster>
 <ZGzbGg35SqMrWfpr@redhat.com>
 <ZG1dAtHmbQ53aOhA@dread.disaster.area>
 <ZG5taYoXDRymo/e9@redhat.com>
 <ZG9JD+4Zu36lnm4F@dread.disaster.area>
 <ZG+GKwFC7M3FfAO5@redhat.com>
 <CAG9=OMNhCNFhTcktxSMYbc5WXkSZ-vVVPtb4ak6B3Z2-kEVX0Q@mail.gmail.com>
 <ZHANCbnHuhnwCrGz@dread.disaster.area>
 <CAG9=OMPxHOzYcy8TQRnvNfNvPvvU=A1pceyL72JfyQwJSKNjQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9=OMPxHOzYcy8TQRnvNfNvPvvU=A1pceyL72JfyQwJSKNjQQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 07:35:14PM -0700, Sarthak Kukreti wrote:
> On Thu, May 25, 2023 at 6:36 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Thu, May 25, 2023 at 03:47:21PM -0700, Sarthak Kukreti wrote:
> > > On Thu, May 25, 2023 at 9:00 AM Mike Snitzer <snitzer@kernel.org> wrote:
> > > > On Thu, May 25 2023 at  7:39P -0400,
> > > > Dave Chinner <david@fromorbit.com> wrote:
> > > > > On Wed, May 24, 2023 at 04:02:49PM -0400, Mike Snitzer wrote:
> > > > > > On Tue, May 23 2023 at  8:40P -0400,
> > > > > > Dave Chinner <david@fromorbit.com> wrote:
> > > > > > > It's worth noting that XFS already has a coarse-grained
> > > > > > > implementation of preferred regions for metadata storage. It will
> > > > > > > currently not use those metadata-preferred regions for user data
> > > > > > > unless all the remaining user data space is full.  Hence I'm pretty
> > > > > > > sure that a pre-provisioning enhancment like this can be done
> > > > > > > entirely in-memory without requiring any new on-disk state to be
> > > > > > > added.
> > > > > > >
> > > > > > > Sure, if we crash and remount, then we might chose a different LBA
> > > > > > > region for pre-provisioning. But that's not really a huge deal as we
> > > > > > > could also run an internal background post-mount fstrim operation to
> > > > > > > remove any unused pre-provisioning that was left over from when the
> > > > > > > system went down.
> > > > > >
> > > > > > This would be the FITRIM with extension you mention below? Which is a
> > > > > > filesystem interface detail?
> > > > >
> > > > > No. We might reuse some of the internal infrastructure we use to
> > > > > implement FITRIM, but that's about it. It's just something kinda
> > > > > like FITRIM but with different constraints determined by the
> > > > > filesystem rather than the user...
> > > > >
> > > > > As it is, I'm not sure we'd even need it - a preiodic userspace
> > > > > FITRIM would acheive the same result, so leaked provisioned spaces
> > > > > would get cleaned up eventually without the filesystem having to do
> > > > > anything specific...
> > > > >
> > > > > > So dm-thinp would _not_ need to have new
> > > > > > state that tracks "provisioned but unused" block?
> > > > >
> > > > > No idea - that's your domain. :)
> > > > >
> > > > > dm-snapshot, for certain, will need to track provisioned regions
> > > > > because it has to guarantee that overwrites to provisioned space in
> > > > > the origin device will always succeed. Hence it needs to know how
> > > > > much space breaking sharing in provisioned regions after a snapshot
> > > > > has been taken with be required...
> > > >
> > > > dm-thinp offers its own much more scalable snapshot support (doesn't
> > > > use old dm-snapshot N-way copyout target).
> > > >
> > > > dm-snapshot isn't going to be modified to support this level of
> > > > hardening (dm-snapshot is basically in "maintenance only" now).
> >
> > Ah, of course. Sorry for the confusion, I was kinda using
> > dm-snapshot as shorthand for "dm-thinp + snapshots".
> >
> > > > But I understand your meaning: what you said is 100% applicable to
> > > > dm-thinp's snapshot implementation and needs to be accounted for in
> > > > thinp's metadata (inherent 'provisioned' flag).
> >
> > *nod*
> >
> > > A bit orthogonal: would dm-thinp need to differentiate between
> > > user-triggered provision requests (eg. from fallocate()) vs
> > > fs-triggered requests?
> >
> > Why?  How is the guarantee the block device has to provide to
> > provisioned areas different for user vs filesystem internal
> > provisioned space?
> >
> After thinking this through, I stand corrected. I was primarily
> concerned with how this would balloon thin snapshot sizes if users
> potentially provision a large chunk of the filesystem but that's
> putting the cart way before the horse.
> 

I think that's a legitimate concern. At some point to provide full
-ENOSPC protection the filesystem needs to provision space before it
writes to it, whether it be data or metadata, right? At what point does
that turn into a case where pretty much everything the fs wrote is
provisioned, and therefore a snapshot is just a full copy operation?

That might be Ok I guess, but if that's an eventuality then what's the
need to track provision state at dm-thin block level? Using some kind of
flag you mention below could be a good way to qualify which blocks you'd
want to copy vs. which to share on snapshot and perhaps mitigate that
problem.

> Best
> Sarthak
> 
> > > I would lean towards user provisioned areas not
> > > getting dedup'd on snapshot creation,
> >
> > <twitch>
> >
> > Snapshotting is a clone operation, not a dedupe operation.
> >
> > Yes, the end result of both is that you have a block shared between
> > multiple indexes that needs COW on the next overwrite, but the two
> > operations that get to that point are very different...
> >
> > </pedantic mode disegaged>
> >
> > > but that would entail tracking
> > > the state of the original request and possibly a provision request
> > > flag (REQ_PROVISION_DEDUP_ON_SNAPSHOT) or an inverse flag
> > > (REQ_PROVISION_NODEDUP). Possibly too convoluted...
> >
> > Let's not try to add everyone's favourite pony to this interface
> > before we've even got it off the ground.
> >
> > It's the simple precision of the API, the lack of cross-layer
> > communication requirements and the ability to implement and optimise
> > the independent layers independently that makes this a very
> > appealing solution.
> >
> > We need to start with getting the simple stuff working and prove the
> > concept. Then once we can observe the behaviour of a working system
> > we can start working on optimising individual layers for efficiency
> > and performance....
> >

I think to prove the concept may not necessarily require changes to
dm-thin at all. If you want to guarantee preexisting metadata block
writeability, just scan through and provision all metadata blocks at
mount time. Hit the log, AG bufs, IIRC XFS already has btree walking
code that can be used for btrees and associated metadata, etc. Maybe
online scrub has something even better to hook into temporarily for this
sort of thing?

Mount performance would obviously be bad, but that doesn't matter for
the purposes of a prototype. The goal should really be that once
mounted, you have established expected writeability invariants and have
the ability to test for reliable prevention of -ENOSPC errors from
dm-thin from that point forward. If that ultimately works, then refine
the ideal implementation from there and ask dm to do whatever
writeability tracking and whatnot.

FWIW, that may also help deal with things like the fact that xfs_repair
can basically relocate the entire set of filesystem metadata to
completely different ranges of free space, completely breaking any
writeability guarantees tracked by previous provisions of those ranges.

Brian

> > Cheers,
> >
> > Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
> 

