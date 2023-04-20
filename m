Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F46F6E8706
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 02:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjDTAyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 20:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjDTAyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:54:14 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119A035AF
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 17:54:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94f0dd117dcso26608566b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 17:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681952049; x=1684544049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEZZksfYsGWpaWEP90hGUd/QDkimEQeeLBa7ojWXyLA=;
        b=mHIqqwSc25lfW3PRtDHaxw4X6N2TnD+fDXQQXVKqR+Y4Ni7XFmZuF2Anv4LTKQqX8D
         +UVwoeT1jGo7BVoinlsnl4aqpck+17bBw8kNVcn9qz+AZJbYuvkShd+gKGb13fm9VE2o
         MxLZ0mnclVkF8kl6G805ooDsknwHf00fYwQFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681952049; x=1684544049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEZZksfYsGWpaWEP90hGUd/QDkimEQeeLBa7ojWXyLA=;
        b=fmuucLowp1Yijoi+/KAgrPN8ZaidQvP1vOoP9hI3ge9pR1V6LdQYCdzvKxosfxoCQc
         /WwvfJlU8Yh6B4IeNgk9Kxqsfnq4xZk+7OQrP3zZJeM9IQu7i0Dx0GMR6GLCMAMz+gVF
         TiCDv7pWrnoUxBZw71O7+9cp4mNx7himS4tL0w5S6KT8wMhH2t2rPO2GwXata0NsMvfr
         eCeuBiZySrABVXk4QC2fYiFOwfWFOq7dLDKA5q4KT111vpD5eaQ9niTOsSWvsUcGOOXv
         Lwqx5dNBygXr+ACCWwMrNPhSU6FN+xF7f+uZ4LnDMoptNaTwVMkcgqKskMRDPL6YJ1QB
         HQVA==
X-Gm-Message-State: AAQBX9esymeAh1CN6y3bEpIXJMSDyUGTdKXe/NfB5MnsLdAHJ1/f3xIb
        QMj3BVxvOs06TFmxOGHPGczKVWQHyodPYNIApjnrZQ==
X-Google-Smtp-Source: AKy350YAC+sf3TWZtlZrZvPaKG0+dzlZ7DQ7BVfpG5/0uqvM2SXFWEF2eIB5c1sxQ1bKurWeSP65JttCPBnGIFCMuXg=
X-Received: by 2002:a05:6402:406:b0:504:9ae7:f73b with SMTP id
 q6-20020a056402040600b005049ae7f73bmr7162959edv.2.1681952049439; Wed, 19 Apr
 2023 17:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230418221207.244685-1-sarthakkukreti@chromium.org> <20230418221207.244685-2-sarthakkukreti@chromium.org>
 <20230419153611.GE360885@frogsfrogsfrogs> <ZEAUHnWqt9cIiJRb@redhat.com>
 <20230419172602.GE360881@frogsfrogsfrogs> <20230419232118.GL447837@dread.disaster.area>
In-Reply-To: <20230419232118.GL447837@dread.disaster.area>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Wed, 19 Apr 2023 17:53:58 -0700
Message-ID: <CAG9=OMNYp+uY9VG5VVB=-cjFBJj5iXbsiNWN5KxMXtwnGDFfbw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] block: Introduce provisioning primitives
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, "Theodore Ts'o" <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Daniil Lunev <dlunev@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19, 2023 at 4:21=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Wed, Apr 19, 2023 at 10:26:02AM -0700, Darrick J. Wong wrote:
> > On Wed, Apr 19, 2023 at 12:17:34PM -0400, Mike Snitzer wrote:
> > > (And obviously needs fixing independent of this patchset)
> > >
> > > Shouldn't mkfs first check that the underlying storage supports
> > > REQ_OP_PROVISION by verifying
> > > /sys/block/<dev>/queue/provision_max_bytes exists and is not 0?
> > > (Just saying, we need to add new features more defensively.. you just
> > > made the case based on this scenario's implications alone)
> >
> > Not for fallocate -- for regular files, there's no way to check if the
> > filesystem actually supports the operation requested other than to try
> > it and see if it succeeds.  We probably should've defined a DRY_RUN fla=
g
> > for that purpose back when it was introduced.
>
> That ignores the fact that fallocate() was never intended to
> guarantee it will work in all contexts - it's an advisory interface
> at it's most basic level. If the call succeeds, then great, it does
> what is says on the box, but if it fails then it should have no
> visible effect on user data at all and the application still needs
> to perform whatever modification it needed done in some other way.
>
> IOWs, calling it one a block device without first checking if the
> block device supports that fallocate operation is exactly how it is
> supposed to be used. If the kernel can't handle this gracefully
> without corrupting data, then that's a kernel bug and not an
> application problem.
>
> > For fallocate calls to block devices, yes, the program can check the
> > queue limits in sysfs if fstat says the supplied path is a block device=
,
> > but I don't know that most programs are that thorough.  The fallocate(1=
)
> > CLI program does not check.
>
> Right. fallocate() was intended to just do the right thing without
> the application having to jump thrown an unknown number of hoops to
> determine if fallocate() can be used or not in the context it is
> executing in.  The kernel implementation is supposed to abstract all that
> context-dependent behaviour away from the application; all the
> application has to do is implement the fallocate() fast path and a
> single generic "do the right thing the slow way" fallback when the
> fallocate() method it called is not supported...
>
I added a separate commit[1] to fix this so that we only
truncate_bdev_range() iff we are in a supported de-allocate mode call.
Subsequently, the REQ_OP_PROVISION patch is a bit simpler when rebased
on top.

[1] https://www.spinics.net/lists/kernel/msg4765688.html

Best
Sarthak

> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
