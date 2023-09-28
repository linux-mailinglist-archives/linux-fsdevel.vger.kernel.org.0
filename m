Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CDA7B16F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 11:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjI1JPQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 05:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjI1JPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:15:15 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B37E8E;
        Thu, 28 Sep 2023 02:15:13 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-45281e0b1cbso6003342137.0;
        Thu, 28 Sep 2023 02:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695892512; x=1696497312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+39pk3B+rebODwp7G8pBElmwkG9/MQbcOK2ksYm+pXw=;
        b=UFbehgpLrDqenf7cwALrPqslATG/QO7K3OVdAPl8Hn68mWVR5tj7aJLQ49ukBvDb1K
         1DPuukKBqpWj9PHClpVVLPiyxRoXzacNDcFCJ1KOtl3WcXJsYMLUv5QszZoJyreozFwE
         yCz4MlylsNh2HZzPfqNis3+Yo8C0c9dxeF5qA3+lx37WgOhQjDaD09xwnyxTDAg15aKw
         /X8+7Mu3HjkzCvYhjo/CoEwa821wV5BlIjCQ3UDX2qa2zeJuyQXg3MsFJmgBJWZJCMUp
         nHBK10LoqbLav6v1fHP7MEgRaBb3RHvqS+NN5rvG05PvRm2qb/jL3NxxNZFfCoO5Mf3f
         dFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695892512; x=1696497312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+39pk3B+rebODwp7G8pBElmwkG9/MQbcOK2ksYm+pXw=;
        b=k+5LtTq0uhc8Ec2whaesvMbuAUrIBoNBgw9aGSFStBn8/ofZ2ezbHR+lT+SrppZ/fk
         ODAZpQ3upRmfcZr1a1tawWNT9Rm60H5FDEtMjmi9wef+8iGl/ZdLfMrwh/QG59C+JbfC
         MjLrfI/tB9+4Oy9jBLiSpzbGMNPBB/SyrMZ+iZ28eO8QSnICgzi+f2DrdAG9Xr5zjf6m
         yXe2EgW1WIn1DiAQuXR8ZjQztlnRznq6ZXED90Z7+tLTaoI/ce64OEkAwLyfogyjSCZx
         sJCIPOfSiIYpAb4ydN0xKcCaHk7T2uvDiyYiktlLZVqpGvSG0/mPx3gYZLyhB6zcttqB
         p5mQ==
X-Gm-Message-State: AOJu0YzAyD4qGUarnnFwiutEaJGxDFmKzsAYI4Bn1d6f8QAkiX9iqSav
        l8pfDhKO23WczLt1gKXbkUsDfhMnwGVijiGUNv0=
X-Google-Smtp-Source: AGHT+IHhDwnt6DOG8gWETWR4dF+oVmg42JZLjROeDabgW93k2n0H2phZbgJEYlFiH9tASiSYNvup8JCcdPIDx9NjiLU=
X-Received: by 2002:a05:6102:34c8:b0:44e:d6c3:51d6 with SMTP id
 a8-20020a05610234c800b0044ed6c351d6mr532848vst.14.1695892512057; Thu, 28 Sep
 2023 02:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230928064636.487317-1-amir73il@gmail.com> <fb6c8786-5308-412e-9d87-dac6fd35aa32@kernel.dk>
In-Reply-To: <fb6c8786-5308-412e-9d87-dac6fd35aa32@kernel.dk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 28 Sep 2023 12:15:00 +0300
Message-ID: <CAOQ4uxjC6qif-MZqkLUsd0RixD0xVHVuGDT=7HCX0kcY1okv2A@mail.gmail.com>
Subject: Re: [PATCH] ovl: punt write aio completion to workqueue
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023 at 10:08=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 9/28/23 12:46 AM, Amir Goldstein wrote:
> > I did not want to add an overlayfs specific workqueue for those
> > completions, because, as I'd mentioned before, I intend to move this
> > stacked file io infrastructure to common vfs code.
> >
> > I figured it's fine for overlayfs (or any stacked filesystem) to use it=
s
> > own s_dio_done_wq for its own private needs.
> >
> > Please help me reassure that I got this right.
>
> Looks like you're creating it lazily as well, so probably fine to use
> the same wq rather than setup something new.
>
> >               ret =3D -ENOMEM;
> >               aio_req =3D kmem_cache_zalloc(ovl_aio_request_cachep, GFP=
_KERNEL);
> >               if (!aio_req)
>
> Unrelated to this patch, but is this safe? You're allocating an aio_req
> from within the ->write_iter() handler, yet it's GFP_KERNEL? Seems like
> that should at least be GFP_NOFS, no?

I could be wrong, but since overlayfs does not have any page cache
of its own, I don't think memory reclaim poses a risk.

>
> That aside, punting to a workqueue is a very heavy handed solution to
> the problem. Maybe it's the only one you have, didn't look too closely
> at it, but it's definitely not going to increase your performance...
>

I bet it won't... but I need to worry about correctness.

What I would like to know, and that is something that I tried
to ask you in the Link: discussion, but perhaps I wasn't clear -
Are there any IOCB flags that the completion caller may set,
that will hint the submitter that completion is not from interrupt
context and that punting to workqueue is not needed?

The thing is that overlayfs does not submit io to blockdev -
It submits io to another underlying filesystem and the underlying
filesystem (e.g. ext4,xfs) is already likely to punt its write completion
to a workqueue (i.e. via iomap->end_io).

If I could tell when that is the case, then I could make punting to
workqueue in overlayfs conditional.

Anyway, I am not aware of any workloads that depend on high
io performance on overlayfs.

The only thing I have is Jiufei's commit message:
2406a307ac7d ("ovl: implement async IO routines")
who complained that overlayfs turned async io to sync io.

Jiufei,

Can you test this patch to see how it affects performance
in your workloads?

Thanks,
Amir.
