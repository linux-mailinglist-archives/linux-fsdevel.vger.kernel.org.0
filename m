Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07BE6CCD39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 00:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjC1Wae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 18:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1Wac (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:30:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947E7135
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 15:30:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id eg48so55727290edb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 15:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680042630; x=1682634630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJfRco4kA86ZpVUshPX/QvkQ5+1BbmuE5+EK3S/1HNE=;
        b=IFvdJr5SpSCWBTxW9Ub40K5VEnCg/3bb8AgPBueBVJtTS3qQOrHjbPdbLqIWxUmPIJ
         T3OCeDRDhK2DRvSCu9+a9I4lmOk/PejF3szbSkx5hUr+596xEPsGwstOxANovht8jEnP
         q2vpnazE0w0PIrqFxjfmuTPYEDt7fK0D1bYDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680042630; x=1682634630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJfRco4kA86ZpVUshPX/QvkQ5+1BbmuE5+EK3S/1HNE=;
        b=3Fsk8dCiMBU3aCaEvqjSpyPdKV2DOVxvyoHDWD3IB8JBl7DX5k8OOfjnjQa/ism39W
         tDafiTIOwvYQOnQVCn6s299ouiP4OBs9Bp5ZapZLKbPOGTZBnjaU8QOVTaoszaRvg+99
         skdN6XdleidVX38oOcjvy8CGlO6i+Uzzu9M2RrM4TgM6947a5GuC7GPzBP9Fc9gnCI3b
         zbCUyBbPcsL/MUlS7oJl8NcBZ9GXrKiC74/0j3GmpDojSSxzpoLG4Of2A3wvPG2GOz88
         JhqWIy8lB4FJTRAWQ12mEig62od+lPryGt7yJ7SJwcyVTUDWnPVVQcaBNhZFkPrcx/8h
         iFhQ==
X-Gm-Message-State: AAQBX9dacNjgpBm23GwGFeD37/YKknJ9mo/ZV1EXd0NNV5PUy+LSTE0w
        vdDmI9Xp4sXxGMlJvHroWkSd9/b+z+0gQaObl5T+aQ==
X-Google-Smtp-Source: AKy350b7UUWD5Ots7MwCDgaXMxyEiOxWUgq2ek5zR9dYSt2DjWzIGgoig/QFOuUKASUbQ/SbhatshA==
X-Received: by 2002:a17:906:8398:b0:900:a150:cea3 with SMTP id p24-20020a170906839800b00900a150cea3mr17770530ejx.9.1680042629775;
        Tue, 28 Mar 2023 15:30:29 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170907984400b009323f08827dsm15497020ejc.13.2023.03.28.15.30.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 15:30:29 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id eg48so55727021edb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 15:30:29 -0700 (PDT)
X-Received: by 2002:a17:907:7b8a:b0:931:6e39:3d0b with SMTP id
 ne10-20020a1709077b8a00b009316e393d0bmr8855650ejc.15.1680042628829; Tue, 28
 Mar 2023 15:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230328215811.903557-1-axboe@kernel.dk> <20230328215811.903557-4-axboe@kernel.dk>
 <CAHk-=winXSHgikHZSyDrmoN=WNZWKoR1JrKGW6Vv4mqn6F4EmA@mail.gmail.com> <416ec013-72db-7ef0-2205-e8fa0165b712@kernel.dk>
In-Reply-To: <416ec013-72db-7ef0-2205-e8fa0165b712@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Mar 2023 15:30:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-mSanfxOGr4i4_TsYvxQVpzCWCsqdZr3LACHWfdVnhw@mail.gmail.com>
Message-ID: <CAHk-=wi-mSanfxOGr4i4_TsYvxQVpzCWCsqdZr3LACHWfdVnhw@mail.gmail.com>
Subject: Re: [PATCH 3/9] iov_iter: overlay struct iovec and ubuf/len
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

 thing

On Tue, Mar 28, 2023 at 3:19=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> Nobody should use it, though. The one case where I thought we'd use
> it was iov_iter_iovec(), but that doesn't work...

You only think that because all your conversions are bogus and wrong.

Your latest "[PATCH 7/9] ALSA: pcm.. " patch is just wrong.

Doing this:

-       if (!iter_is_iovec(from))
+       if (!from->user_backed)

does not work AT ALL. You also need to switch all the uses of
"from->iov" to use the "iter_iov()" helper (that you didn't use).

Because "from->iov" is _only_ valid as a iov pointer for an ITER_IOV.

For an ITER_UBUF, that will be the user pointer in the union, and to
get the iov, you need to do that

    iov =3D &from->ubuf_iov

thing.

The "overlay ubuf as an iov" does *not* make "from->iov" work at all.
Really. You still need to *generate* that pointer from the overlaid
data.

So your latest patches may build, but they most definitely won't work.

I would in fact suggest renaming the "iov" member entirely, to make
sure that nobody uses the "direct access" model ever.

           Linus
