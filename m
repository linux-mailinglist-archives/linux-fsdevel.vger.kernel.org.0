Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7066CAE13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 21:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjC0TDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 15:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjC0TDW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:03:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552461FEC
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 12:03:21 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w9so40404138edc.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 12:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679943799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0ghZ1kSKlZdqatmnx42j3cdVxww5WX0KcSX3cNH0pY=;
        b=GZv9urPFey1fxRUNEi+tYS+/0UcA2aLrBrpjzF5C86bDgfL5cCTvJPG+RpaxMlM6UX
         4CI/8EEdtGO17DhytwmA/L0/TIYId0Iq6wloSimww3bRIOHUXqlaWN6IM4oJ68JsChYK
         2SEMnospnaW4lEyb0Q2PJIW/WhGqzeUsnhkhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679943799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0ghZ1kSKlZdqatmnx42j3cdVxww5WX0KcSX3cNH0pY=;
        b=XlpI0PhQAc/VXBZ/q6PS4yNoeACoMlp7Pu36SA11i+wTE4rjhtO4zH+R4RzdmHCxwg
         WaHAYP04PxQRVPKzhRpe25O7eXnF31NEExrbqPrcT0q2FiypetNlRR5YbfmcNer/ZvGu
         9MvYQqeSA8Y7WRffnXfFdEQNBE+0Cb+IUmYrZVgTjlIySKkpokJRtP9jRoH2lIwvNZsF
         omhzSS4joIsxpHW95ekdoKuTVt4jyJixgfIQ/FkQvfC/wEQxkotR2J4UBpVDzdeqDuEH
         ol0HSXKaOwlHDNscYYQ6y39vQ7VJE16QP9XIZVkM7clFMXwIUaOoSHkHVwwkBAXY51WF
         z8Lw==
X-Gm-Message-State: AAQBX9cM+S7ECpUkRiZIOxFO4gjFKWYngBNS36gGhn1tF577JkkwF6C2
        ix3dn5clEQOq7PgqibzNcrG2GaER5X/exgD6/Ep96w==
X-Google-Smtp-Source: AKy350ZAJ/JXPSxzLyaQBy8AwuSjLHm7D49dvYtjZz8QYueeBr3cJ+o+s/09/9W+iFE76oFr14iqrQ==
X-Received: by 2002:a17:906:3193:b0:932:1af9:7386 with SMTP id 19-20020a170906319300b009321af97386mr12567596ejy.27.1679943799554;
        Mon, 27 Mar 2023 12:03:19 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a25-20020a17090680d900b008e3bf17fb2asm14488606ejx.19.2023.03.27.12.03.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 12:03:19 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id x3so40269746edb.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 12:03:18 -0700 (PDT)
X-Received: by 2002:a50:a6d1:0:b0:4fa:794a:c0cc with SMTP id
 f17-20020a50a6d1000000b004fa794ac0ccmr6860204edc.2.1679943798751; Mon, 27 Mar
 2023 12:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230327180449.87382-1-axboe@kernel.dk> <20230327180449.87382-2-axboe@kernel.dk>
In-Reply-To: <20230327180449.87382-2-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Mar 2023 12:03:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4SOZ=kfxOe+pFvWFM4HHTAhXMwwcm3D_R6qR_m148Yw@mail.gmail.com>
Message-ID: <CAHk-=wh4SOZ=kfxOe+pFvWFM4HHTAhXMwwcm3D_R6qR_m148Yw@mail.gmail.com>
Subject: Re: [PATCH 1/4] fs: make do_loop_readv_writev() deal with ITER_UBUF
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:04=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -748,10 +748,21 @@ static ssize_t do_loop_readv_writev(struct file *fi=
lp, struct iov_iter *iter,
>         if (flags & ~RWF_HIPRI)
>                 return -EOPNOTSUPP;
>
> +       if (WARN_ON_ONCE(iter->iter_type !=3D ITER_IOVEC &&
> +                        iter->iter_type !=3D ITER_UBUF))
> +               return -EINVAL;

Hmm. I think it might actually be nicer for the "iter_is_ubuf(iter)"
case to be outside the loop entirely, and be done before this
WARN_ON_ONCE().

If it's a single ITER_UBUF, that code really shouldn't loop at all -
it's literally just the old case of "call ->read/write with a single
buffer".

So i think I'd prefer this patch to be something along the lines of
this instead:

  --- a/fs/read_write.c
  +++ b/fs/read_write.c
  @@ -748,6 +748,19 @@ static ssize_t do_loop_readv_writev(struct file
*filp, struct iov_iter *iter,
        if (flags & ~RWF_HIPRI)
                return -EOPNOTSUPP;

  +     /* Single user buffer? */
  +     if (iter_is_ubuf(iter)) {
  +             void __user *addr =3D iter->ubuf + iter->iov_offset;
  +             size_t len =3D iov_iter_count(iter);
  +
  +             if (type =3D=3D READ)
  +                     return filp->f_op->read(filp, addr, len, ppos);
  +             return filp->f_op->write(filp, addr, len, ppos);
  +     }
  +
  +     if (WARN_ON_ONCE(!iter_is_iovec(iter)))
  +             return -EINVAL;
  +
        while (iov_iter_count(iter)) {
                struct iovec iovec =3D iov_iter_iovec(iter);
                ssize_t nr;

which keeps the existing iovec loop, and just adds that "is it a
simple buffer" case at the top (and the WARN_ON_ONCE() for any other
iter type).

Hmm?

                         Linus
