Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BF13BF022
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 21:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhGGTV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 15:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhGGTV0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:21:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4405C061574
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jul 2021 12:18:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p21so6833968lfj.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jul 2021 12:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9wzw9s9pccPViWEsY8sbnSaeYn/7vUWP9xwygDqDs4=;
        b=NoQPLrxQZk8EoEOlUUZVRXosJonGrxSLGFu6xFMxPMvCMMHac26nrUcjXYBrBwBeDl
         RJ8UMhLlU8cSMxee2WzlEXd823HKA65OloAIEzwETJYP70FbfPa7c5mL6sCfFzu26LXc
         7nF+arBFr7IB5+xtcwxmfpfZMr85NGyBjfFWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9wzw9s9pccPViWEsY8sbnSaeYn/7vUWP9xwygDqDs4=;
        b=oIg8a9MYBoxVQeoTKRWhMC8XO2M3mTGenfiNHV6e5OZaZHnkgRma51d9zPeUC+lscZ
         N6GbSHnHmNOL4VsaqxKs+3MQLyuXoHP6QDBnTgPX7QdMGd+eSZ31xPvky99zDV3V2U21
         iHif/HAVogCly/EibSDFn7+VC/lqmuGNI4iYDII2j4H8cCrxa4z/96naSSje0N7JltNA
         OkhyUVdN5wIklHgmdag32xOrWsqOoo2NVCV41ZQ6eamkuVFTzr0Yzm31oj9UQPKjuiGf
         cMpXpZmPpO7EoiyFdDNFbx/XxYriXSENCvhEf5bEhISmfTsWd2CUCb/kyOoX1AielFsm
         AbLg==
X-Gm-Message-State: AOAM5305KUJ3ukdWTfDebMxpAkAd5w4Rr2sVAPo/ZEihB04BAj5YhaNo
        6yxqg2iYQ3okX6syDnevN7TP5nqt3o1/1F/IRME=
X-Google-Smtp-Source: ABdhPJwKiWX5ZcuvrcLGi/VqTF1696NidknYHM+BoP/Djfaxe14N0JOAIoN7No+bo87Wxs1OORcrMA==
X-Received: by 2002:a05:6512:1303:: with SMTP id x3mr19929447lfu.276.1625685522907;
        Wed, 07 Jul 2021 12:18:42 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id s13sm1705554ljp.8.2021.07.07.12.18.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 12:18:42 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id q18so6890874lfc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jul 2021 12:18:42 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr19869786lfs.377.1625685522128;
 Wed, 07 Jul 2021 12:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210707122747.3292388-1-dkadashev@gmail.com> <20210707122747.3292388-3-dkadashev@gmail.com>
In-Reply-To: <20210707122747.3292388-3-dkadashev@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Jul 2021 12:18:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=cpt_tQCirzFZRPawRpbuFTZ2MxNpXiyUF+eBXF=+sw@mail.gmail.com>
Message-ID: <CAHk-=wh=cpt_tQCirzFZRPawRpbuFTZ2MxNpXiyUF+eBXF=+sw@mail.gmail.com>
Subject: Re: [PATCH v8 02/11] namei: change filename_parentat() calling conventions
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 7, 2021 at 5:28 AM Dmitry Kadashev <dkadashev@gmail.com> wrote:
>
> Hence this preparation change splits filename_parentat() into two: one
> that always consumes the name and another that never consumes the name.
> This will allow to implement two filename_create() variants in the same
> way, and is a consistent and hopefully easier to reason about approach.

I like it.

The patch itself is a bit hard to read, but the end result seems to make sense.

My main reaction is that this could have probably done a bit more
cleanup by avoiding some of the "goto exit1" kind of things.

Just as an example, now the rule is that "do_rmdir()" always does that

>         putname(name);
>         return error;

at the end, and I think this means that this whole function could be
split into a few trivial helper functions instead, and we'd have

   long do_rmdir(int dfd, struct filename *name)
  {
        int error;

        error = rmdir_helper(...)
        if (!retry_estale(error, lookup_flags)) {
                lookup_flags |= LOOKUP_REVAL;
                error = rmdir_helper(...);
        }
        putname(name);
        return error;
  }

which gets rid of both the "goto retry" and the "goto exit1".

With the meat of "do_rmdir()" done in that "rmdir_helper()" function.

I think the same is basically true of "do_unlinkat()" too.

But I wouldn't mind that cleanup as a separate patch. My point is that
I think this new rule for when the name is consumed is better and can
result in further cleanups.

(NOTE! This is from just reading the patch, I might have missed some case).

            Linus
