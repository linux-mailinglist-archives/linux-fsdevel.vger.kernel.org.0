Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7610870480F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 10:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjEPInp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 04:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjEPInp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 04:43:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E3419BD
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 01:43:41 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc3a2d333so20735578a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 01:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1684226619; x=1686818619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsvkyiQIZcXFRnw5JtgczhaN+1zii3bfe1Uc4Na4ptE=;
        b=eoH9zorHTQS2PUxOOSwEC9u7n/myRrVpM6UO5aFz2u9D+QRvGqPofXK6JSfJctf/V1
         vIR6LcsVvYWGQ4/mGFg1+3cXOR4bsj3z/SP5Se5odbgT6lK8/qE5Qu0eHcK4nT/ZvqXd
         fAOUYmJa1SBQkgg6xenMPd+b/exq3cqsHZJ10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684226619; x=1686818619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsvkyiQIZcXFRnw5JtgczhaN+1zii3bfe1Uc4Na4ptE=;
        b=NvTBSXFJ7BO7rSo6kOMGdodO9Y9Ltz+Cp4fXzbp2u30YROzIBpqFFa74v817JHLBtO
         1rRutN/+/ajwK85fjzl44I/vv8AYy2Bw/SdtHnPOCnR3LPXXX95B89cJWs73932NV7X0
         jYgDsL6+r8YFnGU1MeLIvU207Xc5eDEGi3H6p6YL7ZHAnajGwOjafK32fXX9zHIV7uhJ
         wvnEUyN3ksT9VHblnh4cJn6wBe8JW8WJQsthrUUAJ3c6+wxhsdMuZ8vEwPg0ZROq6+3s
         1hYu+tXbaAmIcbp778pIeTEtfTyG8GB980Stl12vFnR74iy+soeeWINLNYrN6g3/CHpJ
         985g==
X-Gm-Message-State: AC+VfDwzHDCUyfxzLnm2TmKHljjYthB6a1DhUpRL+yeCECBm8E+rENTs
        gxF+HIhpb4R0REdlHlNUur37xfEEgTVRR6e1h4iuYw==
X-Google-Smtp-Source: ACHHUZ5jXQmJ+cwngVlOzDSz7YD/lSXFECl8FUDgx+vA1uWKYB7+lrAuL+TfJpCUaFsm49FQPbuuTlwkHeijBKI171c=
X-Received: by 2002:a17:907:25c3:b0:961:b0:3dff with SMTP id
 ae3-20020a17090725c300b0096100b03dffmr33443440ejc.14.1684226619617; Tue, 16
 May 2023 01:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com> <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
 <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
 <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
 <CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com>
 <CAOQ4uxgXhVOpF8NgAcJCeW67QMKBOytzMXwy-GjdmS=DGGZ0hA@mail.gmail.com>
 <CAOQ4uxg2k3DsTdiMKNm4ESZinjS513Pj2EeKGW4jQR_o5Mp3-Q@mail.gmail.com>
 <CAJfpegv1ByQg750uHTGOTZ7CJ4OrYp6i4MKXU13mwZPUEk+pnA@mail.gmail.com>
 <CAOQ4uxjrhf8D081Z8aG71=Kjjub28MwR3xsaAHD4cK48-FzjNA@mail.gmail.com>
 <87353xjqoj.fsf@vostro.rath.org> <93b77b5d-a1bc-7bb9-ffea-3876068bd369@fastmail.fm>
 <CAL=UVf78XujrotZnLjLcOYaaFHAjVEof-Qx_+peOtpdaRMoCow@mail.gmail.com>
In-Reply-To: <CAL=UVf78XujrotZnLjLcOYaaFHAjVEof-Qx_+peOtpdaRMoCow@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 16 May 2023 10:43:28 +0200
Message-ID: <CAJfpegv5haUDq=gMQZhpS0k8e4r_99Ms-ut8J+dyBm4Bo4OCwQ@mail.gmail.com>
Subject: Re: [fuse-devel] [PATCH RESEND V12 3/8] fuse: Definitions and ioctl
 for passthrough
To:     Paul Lawrence <paullawrence@google.com>
Cc:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        Amir Goldstein <amir73il@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        kernel-team <kernel-team@android.com>,
        Peng Tao <bergwolf@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Stefano Duo <duostefano93@gmail.com>,
        David Anderson <dvander@google.com>, wuyan <wu-yan@tcl.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Akilesh Kailash <akailash@google.com>,
        Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 15 May 2023 at 23:45, Paul Lawrence <paullawrence@google.com> wrote=
:
>
> On Mon, May 15, 2023 at 2:11=E2=80=AFPM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> > On 5/15/23 22:16, Nikolaus Rath wrote:

> > > One thing that struck me when we discussed FUSE-BPF at LSF was that f=
rom
> > > a userspace point of view, FUSE-BPF presents an almost completely
> > > different API than traditional FUSE (at least in its current form).
> > >
> > > As long as there is no support for falling back to standard FUSE
> > > callbacks, using FUSE-BPF means that most of the existing API no long=
er
> > > works, and instead there is a large new API surface that doesn't work=
 in
> > > standard FUSE (the pre-filter and post-filter callbacks for each
> > > operation).
> > >
> > > I think this means that FUSE-BPF file systems won't work with FUSE, a=
nd
> > > FUSE filesystems won't work with FUSE-BPF.
> >
> > Is that so? I think found some incompatibilities in the patches (need t=
o
> > double check), but doesn't it just do normal fuse operations and then
> > replies with an ioctl to do passthrough? BPF is used for additional
> > filtering, that would have to be done otherwise in userspace.

I think Nikolaus' concern is that the BPF hooks add a major upgrade to
the API, i.e. it looks very difficult to port a BPF based fs to
non-BPF based fuse.  The new API should at least come with sufficient
warnings about portability issues.

I don't think the other direction has problems. The fuse API/ABI must
remain backward compatible and old filesystems must be able to work
after this feature is added.

Thanks,
Miklos
