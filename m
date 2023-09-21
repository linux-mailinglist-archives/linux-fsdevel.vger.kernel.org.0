Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062197A99A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjIUSQn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjIUSQ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:16:27 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D198E56D2C
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:27:27 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-76d846a4b85so479063241.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695317246; x=1695922046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqxVhLwqye/UsnUxei2rqlDhlDKCnmqE9txR81hAj8E=;
        b=HUHcpHynUGa6xKLAyplshjx4crJXOLBrgrNOW7VxbD07ceZqHfiO1fAHEZ7iHeUWFH
         7LgrGsR05rCJ1U9PvylMwTfKIeylkJCugZwWIm0LTfyRbwE9CRssbsA6Hth2lpXl7P/Z
         qHK2rgkaIkmJyA858zWGs2FseluzAyezxxOk9UqhicN2WUJ58yoIPacH+X2BRpu32ppc
         lsFhni+wVIVJW+bTLaOhmdu6RftsfDF+jZ1dKlqmLAofRmB7UaNjeiMfPaDW/v5tZxaT
         acwdgTHmu5Jdp55I7jor63WjFmnq8MYqMGlpBq7p8xHwGV5lgKeTOPlxJLbYQBz1OQHC
         GX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317246; x=1695922046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqxVhLwqye/UsnUxei2rqlDhlDKCnmqE9txR81hAj8E=;
        b=mApUlndQGMXz1SNFzeqjU0IGxQl+CFo/UDhB0dLiHDM2ff53FRJSpiDmsH+dt1Wh/6
         abFgFQlzzsmuBnX42Ne6/hFIEMCD0O9pH9sUC8zdeVMyQ68PpUcTm6Hp6FA8uzpyzsT0
         ts++hj5Hr80+3tqOzu8123ZD0zmOYKYTBNheWyQBLy1Q75C+zv2S6TNWE2X+viEy4iXQ
         Oup0blvEj9cYBp41VC7JqgnT68G/SPqgcvef/m1jW+ghyVDIF7jcl84ibAY5O+2vchuq
         zdQMov9L797WilKEoqfjsgH0yr1eE92sMewS1ItFyt+Hj5xZrA86S05iBRDJnFbce6xC
         rJIg==
X-Gm-Message-State: AOJu0YxGJIkfzFRTlQKBCaH4ZoXld7uLoo+MqJI2SEa6VwU+z8HWnuV2
        OggfPxI/lEwlRARaGOpoBHe8EJHn0qXr0vi/A8Znu2GWU3k=
X-Google-Smtp-Source: AGHT+IHg5sdX2HdNOPxtLLTNZ1fmHjkc5nVxf95bSZie/R+67aBrtLLbE1rN7G+MiG2EzIEMWX3G8ympR/j7Y7mBGZU=
X-Received: by 2002:a67:db0a:0:b0:452:6bb2:3620 with SMTP id
 z10-20020a67db0a000000b004526bb23620mr4997828vsj.22.1695292272899; Thu, 21
 Sep 2023 03:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
 <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
 <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com>
 <CAJfpegu2+aMaEmUCjem7em0om8ZWr0ENfvihxXMkSsoV-vLKrw@mail.gmail.com>
 <CAOQ4uxgySnycfgqgNkZ83h5U4k-m4GF2bPvqgfFuWzerf2gHRQ@mail.gmail.com>
 <CAOQ4uxi_Kv+KLbDyT3GXbaPHySbyu6fqMaWGvmwqUbXDSQbOPA@mail.gmail.com>
 <CAJfpegvRBj8tRQnnQ-1doKctqM796xTv+S4C7Z-tcCSpibMAGw@mail.gmail.com>
 <CAOQ4uxjBA81pU_4H3t24zsC1uFCTx6SaGSWvcC5LOetmWNQ8yA@mail.gmail.com>
 <CAJfpegs1DB5qwobtTky2mtyCiFdhO_Au0cJVbkHQ4cjk_+B9=A@mail.gmail.com>
 <CAOQ4uxgpLvATavet1pYAV7e1DfaqEXnO4pfgqx37FY4-j0+Zzg@mail.gmail.com> <CAJfpegvS_KPprPCDCQ-HyWfaVoM7M2ioJivrKYNqy0P0GbZ1ww@mail.gmail.com>
In-Reply-To: <CAJfpegvS_KPprPCDCQ-HyWfaVoM7M2ioJivrKYNqy0P0GbZ1ww@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 Sep 2023 13:31:00 +0300
Message-ID: <CAOQ4uxhkcZ8Qf+n1Jr0R8_iGoi2Wj1-ZTQ4SNooryXzxxV_naw@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 12:30=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Thu, 21 Sept 2023 at 11:17, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > I don't mind dropping the "inode bound" patch altogether
> > and staying with server managed backing_id without support
> > for auto-close-on-evict and only support per-file-auto-close
> > as is already implemented in my POC.
>
> Lets do that, then.

Ok. Two follow up design questions.

I used this in/out struct for both open/close ioctls,
because I needed the flags for different modes:

struct fuse_backing_map {
       int32_t         fd;
       uint32_t        flags;
       uint32_t        backing_id;
       uint32_t        padding;
};

I prefer to leave it like that (with flags=3D0) for future extensions
over the ioctl that inputs fd and outputs backing_id.
I hope you are ok with this.

The second thing is mmap passthrough.

I noticed that the current mmap passthough patch
uses the backing file as is, which is fine for io and does
pass the tests, but the path of that file is not a "fake path".

So either FUSE mmap passthrough needs to allocate
a backing file with "fake path"
OR if it is not important, than maybe it is not important for
overlayfs either?

Which one is it?
Do you have an idea how to dig ourselves out of this hole?

Thanks,
Amir.
