Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD16B40F3E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 10:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbhIQIQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 04:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbhIQIQ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:16:58 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE950C061766
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 01:05:25 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso11787474otv.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 01:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8TBdJtHgKKNE0SJ6m4JjwZ+pUMov7Rq43ETBcZVGRp4=;
        b=SXdOrMZuybo5tmTQJ6vMeJs0E3/IBzBd3s8LbNHU0uWm8DAUzESNIt02JhBawSbshz
         b3ExW2rwiP2GXtBSuvDFapw8PZjxa6zK2Dlx0eHj66jInxK7OwKYS6ttAugTMZBdM/EU
         IduAGBBTCSW7cLKK9USzNf7C5uRQB021XyqpIFyeM7Y8kApjrP900HdshXP/vtUQgUw8
         Q543DjGh0T4dLlq7THwcE8SLTM2svqnJZojNMQ8+PkmhwZBq6zPpCZJUj0srJnDBgVwE
         O9PRdmQOygimaTg7zPBBfzoMV1VIjeEx1DYA/uyifwWLBZDIW89gqe8xZyk66DJu3/t/
         4Vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8TBdJtHgKKNE0SJ6m4JjwZ+pUMov7Rq43ETBcZVGRp4=;
        b=H9b0CbfvQ7NRvjyjOnrnE2qR0HVpdeAc04UBTWbXkizSFWBbbfyqvpSGuz3XhOwLUA
         FXrJ/jC3njHGIf3a7x/SqtHfMFRZTyGoaRdSqfFhaJttwKoNQohop/Pz1jQn5hBNxYpv
         IzM64Uw6rQY4zgIx895YDfkJM46845jkpv9ZvDpS5ln4MNf2vH2kJUWB7nXDwd2/rIy0
         NHoDmnMYL5Yuc0me3NXRgsrRv5A6Zvj8frorBv8rCBSvSyCz9YGhOQJTaz8iBi4bf5Cv
         fIqAougCO/8937Gak1OzZ+sDvpfxdBWIme4ExNs3JM91umjYfLh9ZW87KdTiIOEQ14DU
         miMg==
X-Gm-Message-State: AOAM5330LtDqW2x/05FfQ1NIq35bc2xgr1EXMC7ZrWjHy7kcqYU/625f
        WPwvBeo098mIzoU4DRPvlSJM67k51/hHOoAlZjS+HA==
X-Google-Smtp-Source: ABdhPJw1du8pLRNG9d/Pnd2etZxFKqQkvXIwKB7O57pzXOPeA/cidvYKOM9WxAuabEMh4jcAH3bVKbbTbq8juNdpvyw=
X-Received: by 2002:a9d:7244:: with SMTP id a4mr8609563otk.137.1631865924892;
 Fri, 17 Sep 2021 01:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bc92ac05cb4ead3e@google.com> <CAJfpeguqH3ukKeC9Rg66pUp_jWArn3rSBxkZozTVPmTnCf+d6g@mail.gmail.com>
 <CANpmjNM4pxRk0=B+RZzpbtvViV8zSJiamQeN_7mPn-NMxnYX=g@mail.gmail.com> <CAJfpegvzgVwN_4a-ghtHSf-SCV5SEwv4aeURvK_qDzMmU2nA4Q@mail.gmail.com>
In-Reply-To: <CAJfpegvzgVwN_4a-ghtHSf-SCV5SEwv4aeURvK_qDzMmU2nA4Q@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Sep 2021 10:05:13 +0200
Message-ID: <CACT4Y+ZmFyDOg0=gXv5G8mdqhz5gwcwA9jOVuWgLi2CiYQBzYQ@mail.gmail.com>
Subject: Re: [syzbot] linux-next test error: KASAN: null-ptr-deref Read in fuse_conn_put
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+b304e8cb713be5f9d4e1@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 6 Sept 2021 at 19:35, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > On Mon, 6 Sept 2021 at 13:56, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > Thanks,
> > >
> > > Force pushed fixed commit 660585b56e63 ("fuse: wait for writepages in
> > > syncfs") to fuse.git#for-next.
> > >
> > > This is fixed as far as I'm concerned, not sure how to tell that to syzbot.
> >
> > Thanks -- we can let syzbot know:
> >
> > #syz fix: fuse: wait for writepages in syncfs
> >
> > (The syntax is just "#syz fix: <commit title>".)
>
> Yeah, but that patch has several versions, one of which is broken.
> Syzbot can't tell the difference just based on the title.

Hi Miklos,

For such cases it's useful to include Tested-by: tag into the commit
version that fixes the bug:
http://bit.do/syzbot#amend
