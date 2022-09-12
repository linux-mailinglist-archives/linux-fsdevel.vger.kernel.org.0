Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8EE5B5AD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 15:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiILNFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 09:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiILNFc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:05:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4921B7A0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 06:05:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id v16so19995677ejr.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 06:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=eaXOhVseihlyB1PoXp6N7FNhC7DVTJ8Jvn3d4LOayMM=;
        b=XZXoVGNBz4SDWtC11sW9kbGf8AgVFkxXVJPC+u92tNy4rwFNYUWnn6Pf8j8WgdQPaW
         H5R8ickKFRp9s3LGOF7ZWChtxEk6ifII5to5DwKbNn70zrNVIDAjzZwk4ymxtzFchrXz
         vIHEHwSh13FaflcYfOz1CBe0SI7Gb20VsvsOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eaXOhVseihlyB1PoXp6N7FNhC7DVTJ8Jvn3d4LOayMM=;
        b=LjJaF/kM0WsIRxm85T9JmNTajdsKe8d2EqwWHhq4oxxIuwfAbKn8rr55qOExfQYydS
         +uVTH7ccKNOiJWrzUP39hnY1syvZHtcI5XKpw+yQhtE++nQBBer/MCVmM035qpjC1Qc/
         agwuer8fqB2/LBNJ4g1A94SQKQDTl/nKeQ9AR3/Th9O2mnjSS3ACpsy6LIL4h9vZ4YGI
         ZaI5z6+uSyVNuv6Q7+vxj0LNE8qszIRS9gIa4ej57B9RJBfZUqlWRIDtyDuKycJBF/2r
         yJlGhfkZEZs2OeHqwfo8PBZaZgeIWhiwab4a6JmacP+0Ko/kDqIb47Kcq54I2KLXMOJV
         s2dw==
X-Gm-Message-State: ACgBeo2fIsUSdyET3MBVzlJqV1tLkJQVuKN1bx1iL5U79WypENlqxRSV
        D30YkcOTWcF8zRjLC8sJvA/IvAIhlLQJ0JdLWAYf/A==
X-Google-Smtp-Source: AA6agR6M9IV1T8UC//wBipdDtCsPz4JDjppYPke2RpDEAJD8C5hjA2XyW3X8et1+vfGSXl7r598tM6O8fYwta4ZE33c=
X-Received: by 2002:a17:907:9620:b0:77d:4f86:2e66 with SMTP id
 gb32-20020a170907962000b0077d4f862e66mr3601478ejc.751.1662987928648; Mon, 12
 Sep 2022 06:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com> <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
 <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
 <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
 <CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com>
 <CAOQ4uxgXhVOpF8NgAcJCeW67QMKBOytzMXwy-GjdmS=DGGZ0hA@mail.gmail.com> <CAJfpegtTHhjM5f3R4PVegCoyARA0B2VTdbwbwDva2GhBoX9NsA@mail.gmail.com>
In-Reply-To: <CAJfpegtTHhjM5f3R4PVegCoyARA0B2VTdbwbwDva2GhBoX9NsA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 12 Sep 2022 15:05:17 +0200
Message-ID: <CAJfpegu+Q4Uh07GvXKEp4qa6YB6VdP7akyH0V=dd0PGX66J+2A@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 3/8] fuse: Definitions and ioctl for passthrough
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Peng Tao <bergwolf@gmail.com>,
        Akilesh Kailash <akailash@google.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 12 Sept 2022 at 15:03, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 12 Sept 2022 at 14:29, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Mon, Sep 12, 2022 at 12:29 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Sat, 10 Sept 2022 at 10:52, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > > BTW, I see that the Android team is presenting eBPF-FUSE on LPC
> > > > coming Tuesday [1].
> > >
> > > At first glance it looks like a filtered kernel-only passthrough +
> > > fuse fallback, where filtering is provided by eBPF scripts and only
> > > falls back to userspace access on more complex cases.  Maybe it's a
> > > good direction, we'll see.
> >
> > Yeh, we'll see.
> >
> > > Apparently the passthrough case is
> > > important enough for various use cases.
> > >
> >
> > Indeed.
> > My use case is HSM and I think that using FUSE for HSM is becoming
> > more and more common these days.
>
> HSM?
>
> >
> > One of the things that bothers me is that both this FUSE_PASSTHROUGH
> > patch set and any future eBPF-FUSE passthrough implementation is
> > bound to duplicate a lot of code and know how from overlayfs
> > (along with the bugs).
> >
> > We could try to factor out some common bits to a kernel fs passthough
> > library.
>
> Yeah, although fuse/passthrough might not want all the complexity.
> Getting rid of the context switch latency is the easy part.  Getting
> rid of dcache duplication is the hard one, though it seems that the

s/dcache/page cache/

> current level of hacks in overlayfs seems sufficient and nobody much
> cares for the corner cases (or works around them).
>
> >
> > Anotehr options to consider is not to add any passthrough logic
> > to FUSE at all.
> >
> > Instead, implement a "switch" fs to choose between passthrough
> > to one of several underlying fs "branches", where one of the branches
> > could be local fs and another a FUSE fs (i.e. for the complex cases).
>
> st_dev/st_ino management might become a headache (as it is in overlayfs).
>
> Thanks,
> Miklos
