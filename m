Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D289D711E04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 04:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjEZCfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 22:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjEZCfe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 22:35:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0BE1B1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 19:35:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96f6e83e12fso29642866b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 19:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685068526; x=1687660526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+W8m3Ca/C7ABr7TnX4n7WXczAjnHTy6VxW28/pga+l4=;
        b=Wavv/Ov2JSnmm+7j2BYBnmhKRyztSttW1+mnqq7+2MZ9K1A7mAmZr4EJLFq5EASJ6x
         t2/A3ejCByvnHo+RksigZM4+BFRkPM7YDCuoT3AfyWAv8H7eZA9+C6oL5/qxyUSzxjfC
         JCU/e5goHDnpHb9hX4afGFLT/JVQv7M4AnxEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685068526; x=1687660526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+W8m3Ca/C7ABr7TnX4n7WXczAjnHTy6VxW28/pga+l4=;
        b=Qstk2qBZ1N6AYimVFKcA3tdKfs/nbd2C7SJN5/PMVdx2PndtakIPpXZ60/Dp81+Sjx
         jyym2wuLNq71KJXtW5Vk9cHX4KSEjrN+cSB/UnFimHkRv3Woka1CCF7Fbmsztp4UjxFO
         cofzM/q8klgNNCwkCU+5Iz4ncV1cfiGC2w79jEIPnpaQKngnyM53KbcSyTALXDA1OaLI
         ng2IlqtPW1EH1jAzt0gxmKdUcElfhga/q8yvhuvw/x44PWEbX+7dHVu0sL41yb3D8qv/
         nu3eKhHRW07kMsodXXIwSCFouz8yKOr9bXuKRnqIcx9G2/JMZ7mKGcGJNdl9ACfJzNx/
         PJ4w==
X-Gm-Message-State: AC+VfDy7Wi1JKw5JQO457fsKb5gwYmbbacfHuX2OoGXV4m9Akm8u047h
        vwRXsx3fWo3fEGkBVZgHuggySmAFSLUByFz/X3SukA==
X-Google-Smtp-Source: ACHHUZ4+v93lsnr3vDJxsBIB4NIbwy545X9nEEDCwOA1BxMR0ul1C//JHHo5qpf1DdQM1Wstuba6WbgbYuA6QotLgOc=
X-Received: by 2002:a17:906:dacb:b0:96b:e92:4feb with SMTP id
 xi11-20020a170906dacb00b0096b0e924febmr572925ejb.60.1685068526183; Thu, 25
 May 2023 19:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <ZGeKm+jcBxzkMXQs@redhat.com> <ZGgBQhsbU9b0RiT1@dread.disaster.area>
 <ZGu0LaQfREvOQO4h@redhat.com> <ZGzIJlCE2pcqQRFJ@bfoster> <ZGzbGg35SqMrWfpr@redhat.com>
 <ZG1dAtHmbQ53aOhA@dread.disaster.area> <ZG5taYoXDRymo/e9@redhat.com>
 <ZG9JD+4Zu36lnm4F@dread.disaster.area> <ZG+GKwFC7M3FfAO5@redhat.com>
 <CAG9=OMNhCNFhTcktxSMYbc5WXkSZ-vVVPtb4ak6B3Z2-kEVX0Q@mail.gmail.com> <ZHANCbnHuhnwCrGz@dread.disaster.area>
In-Reply-To: <ZHANCbnHuhnwCrGz@dread.disaster.area>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 25 May 2023 19:35:14 -0700
Message-ID: <CAG9=OMPxHOzYcy8TQRnvNfNvPvvU=A1pceyL72JfyQwJSKNjQQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
To:     Dave Chinner <david@fromorbit.com>
Cc:     Mike Snitzer <snitzer@kernel.org>, Joe Thornber <ejt@redhat.com>,
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

On Thu, May 25, 2023 at 6:36=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Thu, May 25, 2023 at 03:47:21PM -0700, Sarthak Kukreti wrote:
> > On Thu, May 25, 2023 at 9:00=E2=80=AFAM Mike Snitzer <snitzer@kernel.or=
g> wrote:
> > > On Thu, May 25 2023 at  7:39P -0400,
> > > Dave Chinner <david@fromorbit.com> wrote:
> > > > On Wed, May 24, 2023 at 04:02:49PM -0400, Mike Snitzer wrote:
> > > > > On Tue, May 23 2023 at  8:40P -0400,
> > > > > Dave Chinner <david@fromorbit.com> wrote:
> > > > > > It's worth noting that XFS already has a coarse-grained
> > > > > > implementation of preferred regions for metadata storage. It wi=
ll
> > > > > > currently not use those metadata-preferred regions for user dat=
a
> > > > > > unless all the remaining user data space is full.  Hence I'm pr=
etty
> > > > > > sure that a pre-provisioning enhancment like this can be done
> > > > > > entirely in-memory without requiring any new on-disk state to b=
e
> > > > > > added.
> > > > > >
> > > > > > Sure, if we crash and remount, then we might chose a different =
LBA
> > > > > > region for pre-provisioning. But that's not really a huge deal =
as we
> > > > > > could also run an internal background post-mount fstrim operati=
on to
> > > > > > remove any unused pre-provisioning that was left over from when=
 the
> > > > > > system went down.
> > > > >
> > > > > This would be the FITRIM with extension you mention below? Which =
is a
> > > > > filesystem interface detail?
> > > >
> > > > No. We might reuse some of the internal infrastructure we use to
> > > > implement FITRIM, but that's about it. It's just something kinda
> > > > like FITRIM but with different constraints determined by the
> > > > filesystem rather than the user...
> > > >
> > > > As it is, I'm not sure we'd even need it - a preiodic userspace
> > > > FITRIM would acheive the same result, so leaked provisioned spaces
> > > > would get cleaned up eventually without the filesystem having to do
> > > > anything specific...
> > > >
> > > > > So dm-thinp would _not_ need to have new
> > > > > state that tracks "provisioned but unused" block?
> > > >
> > > > No idea - that's your domain. :)
> > > >
> > > > dm-snapshot, for certain, will need to track provisioned regions
> > > > because it has to guarantee that overwrites to provisioned space in
> > > > the origin device will always succeed. Hence it needs to know how
> > > > much space breaking sharing in provisioned regions after a snapshot
> > > > has been taken with be required...
> > >
> > > dm-thinp offers its own much more scalable snapshot support (doesn't
> > > use old dm-snapshot N-way copyout target).
> > >
> > > dm-snapshot isn't going to be modified to support this level of
> > > hardening (dm-snapshot is basically in "maintenance only" now).
>
> Ah, of course. Sorry for the confusion, I was kinda using
> dm-snapshot as shorthand for "dm-thinp + snapshots".
>
> > > But I understand your meaning: what you said is 100% applicable to
> > > dm-thinp's snapshot implementation and needs to be accounted for in
> > > thinp's metadata (inherent 'provisioned' flag).
>
> *nod*
>
> > A bit orthogonal: would dm-thinp need to differentiate between
> > user-triggered provision requests (eg. from fallocate()) vs
> > fs-triggered requests?
>
> Why?  How is the guarantee the block device has to provide to
> provisioned areas different for user vs filesystem internal
> provisioned space?
>
After thinking this through, I stand corrected. I was primarily
concerned with how this would balloon thin snapshot sizes if users
potentially provision a large chunk of the filesystem but that's
putting the cart way before the horse.

Best
Sarthak

> > I would lean towards user provisioned areas not
> > getting dedup'd on snapshot creation,
>
> <twitch>
>
> Snapshotting is a clone operation, not a dedupe operation.
>
> Yes, the end result of both is that you have a block shared between
> multiple indexes that needs COW on the next overwrite, but the two
> operations that get to that point are very different...
>
> </pedantic mode disegaged>
>
> > but that would entail tracking
> > the state of the original request and possibly a provision request
> > flag (REQ_PROVISION_DEDUP_ON_SNAPSHOT) or an inverse flag
> > (REQ_PROVISION_NODEDUP). Possibly too convoluted...
>
> Let's not try to add everyone's favourite pony to this interface
> before we've even got it off the ground.
>
> It's the simple precision of the API, the lack of cross-layer
> communication requirements and the ability to implement and optimise
> the independent layers independently that makes this a very
> appealing solution.
>
> We need to start with getting the simple stuff working and prove the
> concept. Then once we can observe the behaviour of a working system
> we can start working on optimising individual layers for efficiency
> and performance....
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
