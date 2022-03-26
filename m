Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B974E8480
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 23:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiCZWRR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Mar 2022 18:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiCZWRQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Mar 2022 18:17:16 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE5C314
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Mar 2022 15:15:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id g24so14541336lja.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Mar 2022 15:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=646eEJy3R0M/KTVuEwo8ILglC9PMb/NEGSld3GpAxEM=;
        b=VmaZt/FdSU9IxWnJT+n7WMNSAm9QhaWnXKkwGBa+wTkkHVbNrq8oqd2DQI4iCl0wG/
         iy7E3AujkyX5NaVU4BcnOT1fn+xKdpfC9DwBzr+NshauWtc6lfNeDSfelnnG9h7FbBG8
         I7KA+6jENZZ4Gnz9h8WRtq8IQ0/ZxgCw4o6Ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=646eEJy3R0M/KTVuEwo8ILglC9PMb/NEGSld3GpAxEM=;
        b=BnvJK2s5s4QZXIX4xU1mzO2xOkLddrSPUlJk0XfaJNimusIuESdNpCaAw8v4uIvaJw
         je6lfFffK1+jIRaoiPYnOcgD0JyWiH8/4WJpAaX6uetBDTscSLScbtiLcaCY/xVtYLQm
         Rt9hx6nDWVZdacNILd48QxeC5fm41U08VoyqE7fuWGCF3MGQDDmH6eNWM72pfjcED2k2
         QFVvAxrBxCn9IEcv0fy2NyA3Ld75774FOQIRE4mH17yWYCBNk5tE0rk5kJFgiLoIg9DZ
         kthanzujhWvmICBTRFSUGBXCp7GO3vWU3JC6fdxmasOJtw6DCRMGd6kfzdrl+QANwe/J
         flgw==
X-Gm-Message-State: AOAM530GdnWOt366rtmmI5G74BnZPGD+B2fl+8oHMBbLuvBzL3AKTmyl
        +CJOMpQWnvWFTIfyCyZhi9VPzrHSAyDy9G8QYWY=
X-Google-Smtp-Source: ABdhPJzSOGYaFYSCYu2qt5cxvHo4Vzc9AEUy3Lkba08a240eHZPpMaD38UAX2O7CH+HOO5QPwLJzMw==
X-Received: by 2002:a05:651c:2109:b0:249:907a:9560 with SMTP id a9-20020a05651c210900b00249907a9560mr13736713ljq.295.1648332936952;
        Sat, 26 Mar 2022 15:15:36 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2434b000000b004481eafa257sm1186055lfl.285.2022.03.26.15.15.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 15:15:36 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id a30so7098927ljq.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Mar 2022 15:15:35 -0700 (PDT)
X-Received: by 2002:a2e:9b10:0:b0:247:f28c:ffd3 with SMTP id
 u16-20020a2e9b10000000b00247f28cffd3mr13362606lji.152.1648332935415; Sat, 26
 Mar 2022 15:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220326114009.1690-1-aissur0002@gmail.com> <c7fcaccf-7ac0-fae8-3f41-d6552b689a70@ispras.ru>
In-Reply-To: <c7fcaccf-7ac0-fae8-3f41-d6552b689a70@ispras.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Mar 2022 15:15:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijnsoGpoXRvY9o-MYow_xNXxaHg5vWJ5Z3GaXiWeg+dg@mail.gmail.com>
Message-ID: <CAHk-=wijnsoGpoXRvY9o-MYow_xNXxaHg5vWJ5Z3GaXiWeg+dg@mail.gmail.com>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Fedor Pchelkin <aissur0002@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry, quoting everything below to bring in Eric Biggers because he
touched that particular code last.

And Christian Brauner, because he worked on all teh bitmap code with
the whole close_range thing.

I think this is all ok because the number of files aren't just
byte-aligned, they are long-aligned:

         * We make sure that nr remains a multiple of BITS_PER_LONG - otherwise
         * bitmaps handling below becomes unpleasant, to put it mildly...

but maybe I'm missing something.

The fact that there's a

     Found by Syzkaller (https://github.com/google/syzkaller).

thing in that suggested commit message makes me think there _is_
something I'm missing.

Certainly NR_OPEN_DEFAULT, sane_fdtable_size() and max_fds should
always be a multiple of BITS_PER_LONG.

So I don't _think_ there is any bug here, although it might be good to

 (a) document that "we explicitly do things in BITS_PER_LONG chunks"
even more in places

 (b) have people double-check my thinking because clearly that
syzcaller thing implies I'm full of crap

Eric, Christian?

Can somebody point to the actual syzkaller report?

                Linus

On Sat, Mar 26, 2022 at 7:17 AM Alexey Khoroshilov
<khoroshilov@ispras.ru> wrote:
>
> Looks like bfp has a set of macro suitable for such cases:
>
> #define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
> #define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
> #define BITS_ROUNDUP_BYTES(bits) \
>         (BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
>
> May be it makes sense to move them to a generic header and to use here?
>
> --
> Alexey Khoroshilov
>
>
> On 26.03.2022 14:40, Fedor Pchelkin wrote:
> > If count argument in copy_fd_bitmaps() is not a multiple of
> > BITS_PER_BYTE, then one byte is lost and is not used in further
> > manipulations with cpy value in memcpy() and memset()
> > causing a leak. The leak was introduced with close_range() call
> > using CLOSE_RANGE_UNSHARE flag.
> >
> > The patch suggests implementing an indicator (named add_byte)
> > of count being multiple of BITS_PER_BYTE and adding it to the
> > cpy value.
> >
> > Found by Syzkaller (https://github.com/google/syzkaller).
> >
> > Signed-off-by: Fedor Pchelkin <aissur0002@gmail.com>
> > Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> > ---
> >  fs/file.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/fs/file.c b/fs/file.c
> > index 3ef1479df203..3c64a6423604 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -56,10 +56,8 @@ static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
> >  {
> >       unsigned int cpy, set;
> >       unsigned int add_byte = 0;
> > -
> >       if (count % BITS_PER_BYTE != 0)
> >               add_byte = 1;
> > -
> >       cpy = count / BITS_PER_BYTE + add_byte;
> >       set = (nfdt->max_fds - count) / BITS_PER_BYTE;
> >       memcpy(nfdt->open_fds, ofdt->open_fds, cpy);
> >
>
