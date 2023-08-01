Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA65776BB7A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjHARjz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 13:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHARjx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:39:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF73AE53
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 10:39:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bf3f59905so668980466b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 10:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1690911591; x=1691516391;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivsrqKOW5+RBN/23WaOMu4w/3nEVDXK3pwN3IVQbwrg=;
        b=p/HvLdr4e22KQa7Ap/nSedg3RBnJnfOnR2/ASn446qZTGnN3MPoDntSs5cCzHUcjBi
         uHpBTR0vvR2jCcLRNNoixXkO9G4kcVEV9UVxpUhKrn0apfbtYit33f2wF5snL/XsMG+g
         tyl9khyo2UU3sFFPEo2LLpOuFAmPhniGfWanA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690911591; x=1691516391;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivsrqKOW5+RBN/23WaOMu4w/3nEVDXK3pwN3IVQbwrg=;
        b=Ur8QWO+Qn7UYsYYvGDodq5ZxhTGF2wfERnFy5qZsBwqWLc4J5dyHSj9w/VyPZYUM9c
         Fbck2h41xHFgpHuNZ1GrZFfhKkHM7ovcIrdGjKFvHvg+QjpMtmcIOhX+kDC8ANhRqogA
         4PHJaqGVAoKmVfVvYSbW/QHDYurb1TlmCl0Px0jfdDw6wtd7sS2JLZenIoAzZKXOb8Ig
         tPLHPAuXR1dhxrVFc3oJfFBg1Ct6uCLhN4fhlTAEwe5ALVgE3Xlm6/3FTHJfIMqgfsOT
         RvOo+VlCcBKRBfADsfPsCVPGrog7twyiPJmNFq4rBrRYp5Nam2LzM0tYdXuFys7uEUFO
         MwBw==
X-Gm-Message-State: ABy/qLZk8Q/XEmA9zThfU7quo504AtkjKFIX2Cs1iPwO3PVcjd6y9ogz
        HPnwoaj9t1cc/fIT2m4tHuj/vH1bE0mCJuFHUTSoXg==
X-Google-Smtp-Source: APBJJlHC3hBUMrKECYQNae6ajdDbb4N76SS+T8LqCAGGQK/5741zKq4yQtxhAqV885bUoqDMNGMAMdX4Mi1aen3CbAk=
X-Received: by 2002:a17:907:1dca:b0:991:bf04:204f with SMTP id
 og10-20020a1709071dca00b00991bf04204fmr3020588ejc.60.1690911591050; Tue, 01
 Aug 2023 10:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <87wmymk0k9.fsf@vostro.rath.org> <CAJfpegs+FfWGCOxX1XERGHfYRZzCzcLZ99mnchfb8o9U0kTS-A@mail.gmail.com>
 <87tttpk2kp.fsf@vostro.rath.org> <87r0osjufc.fsf@vostro.rath.org>
 <CAJfpegu7BtYzPE-NK_t3nFBT3fy2wGyyuJRP=wVGnvZh2oQPBA@mail.gmail.com>
 <CAJfpeguJESTqU7d0d0_2t=99P3Yt5a8-T4ADTF3tUdg5ou2qow@mail.gmail.com>
 <87o7jrjant.fsf@vostro.rath.org> <CAJfpegvTTUvrcpzVsJwH63n+zNw+h6krtiCPATCzZ+ePZMVt2Q@mail.gmail.com>
 <2e44acdd-b113-43c3-80cb-150f09478383@app.fastmail.com> <CAJfpegtoi2jNaKjvqMqrWQQrDoJkTZqheXFAb3MMVv7WVsHi0A@mail.gmail.com>
 <87mszarbmp.fsf@vostro.rath.org>
In-Reply-To: <87mszarbmp.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 1 Aug 2023 19:39:39 +0200
Message-ID: <CAJfpegs=i7a+_vkUe=mpe9SndoEngbxDDG7rT9RMt003z4F+DQ@mail.gmail.com>
Subject: Re: [fuse-devel] Semantics of fuse_notify_delete()
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Martin Kaspar via fuse-devel 
        <fuse-devel@lists.sourceforge.net>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 1 Aug 2023 at 18:05, Nikolaus Rath <Nikolaus@rath.org> wrote:

> Is it possible that you are running into a variant of
> https://github.com/libfuse/libfuse/issues/730? This was fixed in libfuse
> 3.14.1 and introduced in 3.13.0.

Yes, that was it: a rogue libfuse3 instance installed in /usr/local/lib.

With the debian libfuse3 I get ENOTEMPTY as expected.  Will look at
why this is happening tomorrow.

Thanks,
Miklos
