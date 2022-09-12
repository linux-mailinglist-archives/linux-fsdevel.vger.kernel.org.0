Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530FF5B5ACC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 15:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiILNDt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 09:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiILNDr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:03:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59B922294
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 06:03:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r18so20007461eja.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 06:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gzeDS0G1ZIUKM4GYz7abbjxSlpxz2Mijey/kQuuMkfY=;
        b=CfIQzgzZCyVr9wlstJxLH+NrDFeHEXR+57tREBr4yZomgx5J01hdi8CNaswUAGNufB
         iIBvEmZsyMfvoabVa3UccxrPtjHVl7WSxqoEfDBIvdYOIpNdUBe9X8BMOGAkq4w056d4
         LwS6KRA/VKPJKviNNBIC5IZJui/QpEDlBgHgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gzeDS0G1ZIUKM4GYz7abbjxSlpxz2Mijey/kQuuMkfY=;
        b=OIvIl3hlYL5mo+mmNJ54MsB/0JTUf3OsfErAOgb8z0AZ0H2YU3UGP+rcaESxsuL7rl
         O3Y1HJBpMHBPojverghvRHa1CKNinDnOW4v1AqGZoP70Fnh81Dn4k6T21tlwLGf+flCT
         2ygNRsHS9jCmsJCWIrDCxIAIArAeiH2V0X7DTpA6Lgbr9goDU2yAUiTli0ZyIXLzHY6N
         I0J73nSBXWzNNMorGCC9aLEJSgwpWp0OGB0iw/Y+7NlGa4PjZv7hquZZioGUtHXz+AKL
         yPRs83BbjMW/Tg1gZLGOtTrL7ooMkPC38wN6S3A5owwesewz1Ypl4e4FKYNZVfWKAxcR
         f78g==
X-Gm-Message-State: ACgBeo0MBJGbgLSRjADgp39wU4vPPDFQrLgP4E9ZyvA+VxUrRnW6P31J
        8G6knsVyZPgnhZkUBxJ2rCjKVky8Y4MzjbRQq1Jdfg==
X-Google-Smtp-Source: AA6agR6cLJFEsl3AJArEYDgQd93yC5d98d7pBkVtPyhBL2/V4VYcf5vCmeKibDsuIv+RoGsTzqvskz7X8QU4DA/Xz/E=
X-Received: by 2002:a17:907:9620:b0:77d:4f86:2e66 with SMTP id
 gb32-20020a170907962000b0077d4f862e66mr3595860ejc.751.1662987824320; Mon, 12
 Sep 2022 06:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com> <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
 <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
 <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
 <CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com> <CAOQ4uxgXhVOpF8NgAcJCeW67QMKBOytzMXwy-GjdmS=DGGZ0hA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgXhVOpF8NgAcJCeW67QMKBOytzMXwy-GjdmS=DGGZ0hA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 12 Sep 2022 15:03:33 +0200
Message-ID: <CAJfpegtTHhjM5f3R4PVegCoyARA0B2VTdbwbwDva2GhBoX9NsA@mail.gmail.com>
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

On Mon, 12 Sept 2022 at 14:29, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Sep 12, 2022 at 12:29 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Sat, 10 Sept 2022 at 10:52, Amir Goldstein <amir73il@gmail.com> wrote:

> > > BTW, I see that the Android team is presenting eBPF-FUSE on LPC
> > > coming Tuesday [1].
> >
> > At first glance it looks like a filtered kernel-only passthrough +
> > fuse fallback, where filtering is provided by eBPF scripts and only
> > falls back to userspace access on more complex cases.  Maybe it's a
> > good direction, we'll see.
>
> Yeh, we'll see.
>
> > Apparently the passthrough case is
> > important enough for various use cases.
> >
>
> Indeed.
> My use case is HSM and I think that using FUSE for HSM is becoming
> more and more common these days.

HSM?

>
> One of the things that bothers me is that both this FUSE_PASSTHROUGH
> patch set and any future eBPF-FUSE passthrough implementation is
> bound to duplicate a lot of code and know how from overlayfs
> (along with the bugs).
>
> We could try to factor out some common bits to a kernel fs passthough
> library.

Yeah, although fuse/passthrough might not want all the complexity.
Getting rid of the context switch latency is the easy part.  Getting
rid of dcache duplication is the hard one, though it seems that the
current level of hacks in overlayfs seems sufficient and nobody much
cares for the corner cases (or works around them).

>
> Anotehr options to consider is not to add any passthrough logic
> to FUSE at all.
>
> Instead, implement a "switch" fs to choose between passthrough
> to one of several underlying fs "branches", where one of the branches
> could be local fs and another a FUSE fs (i.e. for the complex cases).

st_dev/st_ino management might become a headache (as it is in overlayfs).

Thanks,
Miklos
