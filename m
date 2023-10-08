Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6917BCF71
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Oct 2023 19:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjJHRxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Oct 2023 13:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjJHRxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Oct 2023 13:53:34 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15959A3
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Oct 2023 10:53:33 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-65b0e623189so21928276d6.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Oct 2023 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696787612; x=1697392412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoHkOolvbXuiBjBFAhRFOR3o92Q7/alDKQFQWTlw/Sk=;
        b=G60286+fn5LPQ20dSz3YryxWef5WVuvlQv55A0wGuTebrzsXGoto8cfaavUx2G/roo
         VsP9CcppGUuhjQKs4WGQHl1xiYFLbqfkEZpGw7elXc5U7vejb1dndHxIYHgw7eH7kkaz
         LEjqY3H+RqwfEDXpO598obicVYCczAr7xhbEQUUAJcEFEALxX5k6A7X5I2wz4NId1isv
         +Z9xc85hhXRG++HkcdEEipnCSwXz2Gk6pPllOQheHse+QNR/Jr/PvuY01/l8mN+t0hzJ
         N49gA+y4p3A0WYFZ8zcJ2WmAYQB7LA593/d0q1QDcCD1BW0zHJ7q+Bnlu8QzTWZofd3f
         4A8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696787612; x=1697392412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoHkOolvbXuiBjBFAhRFOR3o92Q7/alDKQFQWTlw/Sk=;
        b=Ku4Dxs7NPlGyFrrBjOLuVA/Yn9xMg4FitvSsKhkT2JdQ6+nOyYRSQQuYF2e/5lCpJI
         R8AOvFdX9zpoGqNNnNKoWn1s5MBQBHLTJKPLupwHW3FSYIXb/EREvj+gy5nuS7Nt/inc
         uE6Qa6vwkiQeFtrzGjhEU5UavoWjam/nwkzKisb+OSLWMMGwykZWNVL4ZYqnfgkosjW+
         QwWR7DdlbB9oe5i3e7h0YII7ImoRoNm1eqk1nt9izpH5cL/Ux4Egzc/H94x/h6bSJq3o
         e0qUFFmyNJf8hvuxIEPFh/nXD3Wx5evVfJU18uGjz4EKrGr26ohxlre3wqGyC8xhPyZJ
         5ejQ==
X-Gm-Message-State: AOJu0Yw5jEZNReoeCSiha0VB4pWQSD32O/8G+CBx6NiJdoddcItDpH8O
        a/zYubSZac5yS6TUDkWvgRHy8rySlTS7Xuz6/tg=
X-Google-Smtp-Source: AGHT+IFiuqWuLbFaVBfZVRkqqIaQtrM7vylAr4pR7heAUFHIGuYEs0loLe7U2Zx5YMJ5fBI/Jf6zZdE08WpSRA/66Xc=
X-Received: by 2002:a05:6214:3bc4:b0:65c:fd5b:d74e with SMTP id
 ng4-20020a0562143bc400b0065cfd5bd74emr13583565qvb.26.1696787612122; Sun, 08
 Oct 2023 10:53:32 -0700 (PDT)
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
 <CAOQ4uxgpLvATavet1pYAV7e1DfaqEXnO4pfgqx37FY4-j0+Zzg@mail.gmail.com>
 <CAJfpegvS_KPprPCDCQ-HyWfaVoM7M2ioJivrKYNqy0P0GbZ1ww@mail.gmail.com>
 <CAOQ4uxhkcZ8Qf+n1Jr0R8_iGoi2Wj1-ZTQ4SNooryXzxxV_naw@mail.gmail.com>
 <CAJfpegstwnUSCX1vf2VsRqE_UqHuBegDnYmqt5LmXdR5CNLAVg@mail.gmail.com> <CAOQ4uxhu0RXf7Lf0zthfMv9vUzwKM3_FUdqeqANxqUsA5CRa7g@mail.gmail.com>
In-Reply-To: <CAOQ4uxhu0RXf7Lf0zthfMv9vUzwKM3_FUdqeqANxqUsA5CRa7g@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 8 Oct 2023 20:53:20 +0300
Message-ID: <CAOQ4uxjQx3nBPuWiS0upV_q9Qe7xW=iJDG8Wyjq+rZfvWC3NWw@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 22, 2023 at 3:45=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Sep 21, 2023 at 2:50=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
...
> > As for close, I don't see why we'd need anything else than the backing =
ID...
> >
>
> OK. dropped the inode bound mode, updated the example
> to do server managed backing id for the rdonly shared fds.
>
> Pushed this to the fuse-backing-id branches:
>
> [1] https://github.com/amir73il/linux/commits/fuse-backing-fd
> [2] https://github.com/amir73il/libfuse/commits/fuse-backing-fd
>
> > >
> > > The second thing is mmap passthrough.
> > >
> > > I noticed that the current mmap passthough patch
> > > uses the backing file as is, which is fine for io and does
> > > pass the tests, but the path of that file is not a "fake path".
> > >
> > > So either FUSE mmap passthrough needs to allocate
> > > a backing file with "fake path"
> >
> > Drat.
> >
> > > OR if it is not important, than maybe it is not important for
> > > overlayfs either?
> >
> > We took great pains to make sure that /proc/self/maps, etc display the
> > correct overlayfs path.  I don't see why FUSE should be different.
> >
>
> Now I will go have a think about how to ease the pain
> in this area for vfs. I have some ideas...

Ok, posted your original suggestion for opt-in to fake path:
https://lore.kernel.org/linux-fsdevel/20231007084433.1417887-1-amir73il@gma=
il.com/

Now the problem is that on FUSE_DEV_IOC_BACKING_OPEN ioctl,
the fake (fuse) path is not known.

We can set the fake path on the first FOPEN_PASSTHROUGH response,
but then the whole concept of a backing id that is not bound to a
single file/inode
becomes a bit fuzzy.

One solution is to allocate a backing_file container per fuse file on
FOPEN_PASSTHROUGH response.

Thanks,
Amir.
