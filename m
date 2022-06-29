Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B519A55FD37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 12:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbiF2Ka4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 06:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiF2Kay (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:30:54 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490323DDDB
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jun 2022 03:30:52 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id v185so17616689ybe.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jun 2022 03:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=INE3jM6i4CeBqiu3iP4gMcpfjuGPLjLxHaF42Uyh3HU=;
        b=gme5wrsat75qWp+Pcx6ZLUMXoFWSPo8SFk5+xY2sKMY14XML7lv7BZvDJ1XsF+R4pF
         H3XtfFAN7qI5e9jmkPQabM9C1cZvrazFcxkGWUN8u49ugGN5ZgE4uLnkUYNhQuPi4lCZ
         +uzhBRF2JTFseNh2HTIIBQ8WHh/1cppxJ6VLgcPGolWvn3oakRGqpYgHlWaZQI7qYur6
         WKhVL3asnCkiK66XXK9hKxBW+Kr8EDh4QueImd3KWxHYLj7f6FJC0FyCJ9Aoq3/krPPC
         PboTmDlG9/DJbi0qt+VVk0f7YCRqyYql31Z/lg1k67WVKQeRTUrOmIk8udCKjik37KcD
         Ojvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=INE3jM6i4CeBqiu3iP4gMcpfjuGPLjLxHaF42Uyh3HU=;
        b=G9t/DhTPcR/mVlzePsNirYtmLAOf9JJrk4uZ662YXvD3Xoj+deTE+0urmpMPyyb19I
         ihaeFk/XC3CScG0KLi+qafoqhqAePzULtLyzrGqohT596pweUzclkzFi5/TfUIK6egSs
         5wJLvNVlpdN1VSPi5mOa52TQYRgBx5QhVltBPEKTlDV4Uxi+gi0xZ1kD2W5X1wz6BSOc
         /SugNb3Fc5VkIrlqiNm9VW/6MsBDSQUVxjwswm7anTXKI1NgdaeTaIoFA6k9BoGqNNM9
         02iCV4Thpre41tLcPIvJI87wv9dH6JPO1ucqokMh05VBmVGnjHK6XALlIjxF/uP0UYva
         jwcg==
X-Gm-Message-State: AJIora/WGDemXgovV7XYYcxi5CQnrSK2XSn1R95ZP0yAw7vie3wK4rJD
        I7kEHc84eEZA0cpqdGm6JvUhsp06BGRNWSBf/1VcRA==
X-Google-Smtp-Source: AGRyM1u0k0MWRsbjlhZ+2t5dOIIfgGJepBD4oMisQfYbCc9kMnwW7juStqFdeNdnecD+2jq2Tx/943q3+X6LctTtJdA=
X-Received: by 2002:a25:b9c7:0:b0:66c:e02d:9749 with SMTP id
 y7-20020a25b9c7000000b0066ce02d9749mr2693651ybj.494.1656498651378; Wed, 29
 Jun 2022 03:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220625110115.39956-1-Jason@zx2c4.com> <20220625110115.39956-8-Jason@zx2c4.com>
 <YrlzkAlheCR0ZMuO@phenom.ffwll.local>
In-Reply-To: <YrlzkAlheCR0ZMuO@phenom.ffwll.local>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Wed, 29 Jun 2022 16:00:39 +0530
Message-ID: <CAO_48GE_-pLAq+HfjoJNGPO=dsj5g84oVQuF1vaxsXcfOcZ6KA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] dma-buf: remove useless FMODE_LSEEK flag
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 27 Jun 2022 at 14:38, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Sat, Jun 25, 2022 at 01:01:14PM +0200, Jason A. Donenfeld wrote:
> > This is already set by anon_inode_getfile(), since dma_buf_fops has
> > non-NULL ->llseek, so we don't need to set it here too.
> >
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> I'm assuming this is part of a vfs cleanup and lands through that tree?
> For that:
>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
FWIW, please feel free to add
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>

>
> > ---
> >  drivers/dma-buf/dma-buf.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 32f55640890c..3f08e0b960ec 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -549,7 +549,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf=
_export_info *exp_info)
> >               goto err_dmabuf;
> >       }
> >
> > -     file->f_mode |=3D FMODE_LSEEK;
> >       dmabuf->file =3D file;
> >
> >       mutex_init(&dmabuf->lock);
> > --
> > 2.35.1
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch


Best,
Sumit.
