Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A9874808F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 11:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjGEJOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 05:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjGEJOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9451716
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jul 2023 02:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688548447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9KObcq/9SecuVmm4CKMewq3+txouKYR5j2YkQYcKiE=;
        b=UR2jKDxozHaJrKNvE9YcZBLbLXIuA8MXSy9lxsfBV+GeizoKdFYzSAVq/65zWLMGvRTNOH
        5aDd7Q0gJZfpvpnZA87meWRZuapl5109VMh21kEdWz55/O1A4ZRSPHW1XQ8+AGV067hdiV
        zHR+fz+nV0BL3uOM2SfSB1JYLUYBdU0=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-UaWa-6bMM56zqLYchOS3tw-1; Wed, 05 Jul 2023 05:14:06 -0400
X-MC-Unique: UaWa-6bMM56zqLYchOS3tw-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3459772e100so26465645ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jul 2023 02:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688548446; x=1691140446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9KObcq/9SecuVmm4CKMewq3+txouKYR5j2YkQYcKiE=;
        b=I4epU4+6o4xeRI4pQGYyIkA+SqPHj9nzhL0hqGPhi2fyAu2UBdswY2cz0wdWlrJzrb
         zU1nV6eawOrwiG8bzGm3pp9suByGF4uO9u2epiITi+6RSnA7hiAKv8tzGevfqlz6Lnqm
         vTmAFhssiCHnH1FSDtUOwDp9e+Zioy/WMWC5THUnVridWgEFCmni5x16zxoaBifdkNne
         tnK80T1nh476jL25lTpo10JJxD5nmFdUHWjQGjFYbUvccpcw7S98+qWAx4kKgBRkVftv
         CpCdWZPUlAp4z7hLSEZq/CYBjDmFnHgWib0KwK/GpA8saSwkM1rcUzRXoqZ8RvQtu17P
         r7lg==
X-Gm-Message-State: ABy/qLbEvH1X3U5a2wABL8AU+titfLjpFcuF9KXbvpS93GM+DY/lcd6A
        eZDcWJJswYn17uucMM53MW1qKMh0uOqgcY+vDENwq4CaMOdRM9DtPEfKhqRagpqwLiTIeudiPm3
        fOkJk6BEHUTtxp0CBFEPfzS1JgFZ1MVgHabXUtKZz0w==
X-Received: by 2002:a92:d809:0:b0:345:6ffa:63c7 with SMTP id y9-20020a92d809000000b003456ffa63c7mr13304524ilm.32.1688548446204;
        Wed, 05 Jul 2023 02:14:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGKQ+5bkvgdDYPjsRcfDKzBh+CiwEjAZyS/bvVvWU80dbfQX28sQg9bP5Uj+kvZiRjbGJlXe8Ub1JjVpdx09U4=
X-Received: by 2002:a92:d809:0:b0:345:6ffa:63c7 with SMTP id
 y9-20020a92d809000000b003456ffa63c7mr13304516ilm.32.1688548445956; Wed, 05
 Jul 2023 02:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230626-fs-overlayfs-mount-api-param-v1-1-29afb997a19f@kernel.org>
 <CAOQ4uxiOsHEx30ERLYeLdnOdFG1rw_OnXo+rBbKCY-ZzNxV_uQ@mail.gmail.com>
 <CAL7ro1GgW-2gUhB=TBxwDAiybbQBbFabkU2tBNbBH85Q_KZWew@mail.gmail.com> <CAOQ4uxhkMYMnPL81RoWdnxCsiNtf-AbBVPcRj=hbo4vd8yp=QA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhkMYMnPL81RoWdnxCsiNtf-AbBVPcRj=hbo4vd8yp=QA@mail.gmail.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Wed, 5 Jul 2023 11:13:54 +0200
Message-ID: <CAL7ro1FomqdO22a+=pntO5cBhDpz6hp96PVa_q6FKU7jRgunpQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: move all parameter handling into params.{c,h}
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 4, 2023 at 5:14=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Mon, Jul 3, 2023 at 12:16=E2=80=AFPM Alexander Larsson <alexl@redhat.c=
om> wrote:
> >
> > On Mon, Jun 26, 2023 at 4:40=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > On Mon, Jun 26, 2023 at 1:23=E2=80=AFPM Christian Brauner <brauner@ke=
rnel.org> wrote:
> > > >
> > > > While initially I thought that we couldn't move all new mount api
> > > > handling into params.{c,h} it turns out it is possible. So this jus=
t
> > > > moves a good chunk of code out of super.c and into params.{c,h}.
> > > >
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > ---
> > > >
> > >
> > > Thank you for this cleanup!
> > >
> > > Alex,
> > >
> > > I took the liberty to resolve the conflicts with your branch, see:
> > >
> > > https://github.com/amir73il/linux/commits/overlay-verity
> >
> > Thanks, I took a look at this and it seems good. Updated my branch to t=
his too.
> >
>
> FYI, I pushed this cleanup commit to overlayfs-next, so
> you can rebase overlay-verity v5 on top of that.

I rebased it and added some changes based on reviews from erics.

> I will send this cleanup to Linus, so we have a clean slate for
> the 6.6 cycle.

Thanks.

--
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

