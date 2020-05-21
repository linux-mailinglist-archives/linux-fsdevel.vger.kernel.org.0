Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A295E1DD5D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 20:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgEUSPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 14:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgEUSPk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 14:15:40 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839D5C061A0F
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2020 11:15:40 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a4so4978413lfh.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2020 11:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=54W3OV++I2yQ/I7iW3hxLFdkiWppKNPo6faoyw5Mf9Y=;
        b=UQPD/PT2EW5TVwSaVIjRfipituyHmtA1mBHH4953yfr3LzZinoUha6UIRpkmQUDz4Z
         sDAviIP5vN1t2wjk01lP4o7PjjKNXmrpkVYHrJlvxFKw9GfnB5uha8WcnjiW0KyJM7Ti
         9brnyP/zUBG+C2QVoFPdMGDA0IzkPTJ/97s4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54W3OV++I2yQ/I7iW3hxLFdkiWppKNPo6faoyw5Mf9Y=;
        b=uB7lRxGIGOl4QBfai98DXyql9D/kSEIjxbREklaeUOfeEdZIXcDGKdpzt+IItwJmF+
         AIPs7U1vwhp2Sobg8NEAR4nkP6kZ8Qv/4ABiCoi6W9RWoJun9B8ltKqE01I4ZOyUEjAB
         jbRy2NjIaAMPKRdzbxOu6kIZgI70ikffFxPSFMKY6iUP8067A8hPZp4vULcEdh9B/5Gl
         RrCZvcpJU8ShJzXuvs6y5kFJ89HMYXithszwnWaD1cNJ+VonDXYKHdI5fj4V66XgDfy6
         aiKTW+QNk0yoQSqTveEuuksoiNsLyuBAs4/byuMXR0gcAXCoTn5geNcYpY2dkmKWbqr6
         IcSA==
X-Gm-Message-State: AOAM530F6UOSQyZ5EqWSld2NL4xOSKrbBTW3k9ccjb23vcoazqNsPu9Q
        r4s6QOFnI39hDg8txdH8+9nAa9cKt/k=
X-Google-Smtp-Source: ABdhPJyAGrBnFxGyjfmQhlx+8TTL5Fe+zjnYYku+C4Ugi8huoED88pUQxCu/KyFSayHFcMmbQVXQlA==
X-Received: by 2002:a05:6512:3049:: with SMTP id b9mr5479782lfb.44.1590084938397;
        Thu, 21 May 2020 11:15:38 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id f2sm993474ljf.113.2020.05.21.11.15.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 11:15:37 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id m18so9456144ljo.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2020 11:15:37 -0700 (PDT)
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr3469825ljc.314.1590084936777;
 Thu, 21 May 2020 11:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200521140502.2409-1-linkinjeon@kernel.org> <eb8858fb-c3bc-3f8d-96c1-3b4082c14373@sandeen.net>
In-Reply-To: <eb8858fb-c3bc-3f8d-96c1-3b4082c14373@sandeen.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 May 2020 11:15:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVi7mSrsMP=fLXQrXK_UimybW=ziLOwSzFTtoXUacWVQ@mail.gmail.com>
Message-ID: <CAHk-=wiVi7mSrsMP=fLXQrXK_UimybW=ziLOwSzFTtoXUacWVQ@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: add the dummy mount options to be backward
 compatible with staging/exfat
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 21, 2020 at 8:44 AM Eric Sandeen <sandeen@sandeen.net> wrote:
>
> Wow, it seems wild that we'd need to maintain compatibility with options
> which only ever existed in a different codebase in a staging driver
> (what's the point of staging if every interface that makes it that far has
> to be maintained in perpetuity?)

The rules about regressions have never been about any kind of
documented behavior, or where the code lives.

The rules about regressions are always about "breaks user workflow".

Users are literally the _only_ thing that matters.

No amount of "you shouldn't have used this" or "that behavior was
undefined, it's your own fault your app broke" or "that used to work
simply because of a kernel bug" is at all relevant.

Now, reality is never entirely black-and-white. So we've had things
like "serious security issue" etc that just forces us to make changes
that may break user space. But even then the rule is that we don't
really have other options that would allow things to continue.

And obviously, if users take years to even notice that something
broke, or if we have sane ways to work around the breakage that
doesn't make for too much trouble for users (ie "ok, there are a
handful of users, and they can use a kernel command line to work
around it" kind of things) we've also been a bit less strict.

But no, "that was documented to be broken" (whether it's because the
code was in staging or because the man-page said something else) is
irrelevant. If staging code is so useful that people end up using it,
that means that it's basically regular kernel code with a flag saying
"please clean this up".

The other side of the coin is that people who talk about "API
stability" are entirely wrong. API's don't matter either. You can make
any changes to an API you like - as long as nobody notices.

Again, the regression rule is not about documentation, not about
API's, and not about the phase of the moon.

It's entirely about "we caused problems for user space that used to work".

                   Linus

PS. Obviously "API stability" is important in the sense that if you
_don't_ change any user-visible API's, that's a much safer change that
needs much less care than a change that _does_ change a user-visible
API.

So "API stability" isn't a meaningless concept, but it's not the"First
rule of kernel programming" that "no regressions" is. It's just that
there tends to be a correlation between "I made subtle API changes"
and "uhhuh, I broke user space".
