Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B984401D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 20:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhJ2S2v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 14:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhJ2S2v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:28:51 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A76C061570
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 11:26:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z20so41879870edc.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 11:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YR8MaXQV2dAoTf7veoG8XVBeAhgdgomPxezXzaQONmo=;
        b=HVDkvGeodIU22X5kjbO7ZR0lTCWWwkScN+820L1CO6Jp/wFHT2URTkNHboM7IjptmB
         YVg/RfMSjgzCpZAxQHFmCUZlYnl5lVQQW/xElvUR6baO9Q4c6uG+lfqCGqGH4kKGh1KE
         qArq9uCu2p9WrvPFJV+b6G0oeDLEt/s/4EqMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YR8MaXQV2dAoTf7veoG8XVBeAhgdgomPxezXzaQONmo=;
        b=rbtH4U2UXR51hM3lLJwBYxvoMMMQD2Ztp91dLr2ZQ2TIyxv9CDg4+w7hsObH9jitv2
         u/7BoNN9GDVtWqayngGU1VHaoXMu0zFMAN9FWHMukuVYs9PyuT4Y4Q2bJmcjWefJL9qG
         rOXlgwywyLFTiVTGreC+CvaY7ArW4cjtvCQVK2pvVDANMUDNm5iliMRRCNskIK/9MrZ2
         x8PnAe6rr+sTdN52XIt8Md1EGit99dnQfgS6fM9yfATGt8YY5H5c24oJslY5Uv7Ro+2L
         3fV8nBJHkjnX8HoNvoj0cAo0ttqW6vtQ1O/932B0s8mWFs1YsCA7C5CbORHHW7qrJSpZ
         +cDA==
X-Gm-Message-State: AOAM530ZaDjt5SkqTtj6460FMc4sEJgzW6zOnAnuMijaiZbNNpIBPHPN
        iAXqantZHNtD99M0fNJMemZzMlX+8A4Z0jmyAVA=
X-Google-Smtp-Source: ABdhPJyFm7unmIZXWjay5bH87oE7FtkKSczLV/Bu1wRWFWJW5/vQ1JDNu6C5Pw0yhkIBxgFdeoc0TA==
X-Received: by 2002:a17:906:3486:: with SMTP id g6mr15890852ejb.71.1635531980425;
        Fri, 29 Oct 2021 11:26:20 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id z9sm4343846edb.70.2021.10.29.11.26.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 11:26:20 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id g10so41271204edj.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 11:26:20 -0700 (PDT)
X-Received: by 2002:a05:651c:17a6:: with SMTP id bn38mr12949536ljb.56.1635531495482;
 Fri, 29 Oct 2021 11:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <163551653404.1877519.12363794970541005441.stgit@warthog.procyon.org.uk>
 <CAHk-=wiy4KNREEqvd10Ku8VVSY1Lb=fxTA1TzGmqnLaHM3gdTg@mail.gmail.com> <1889041.1635530124@warthog.procyon.org.uk>
In-Reply-To: <1889041.1635530124@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Oct 2021 11:17:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_C6V_S+Aox5Fn7MuFe13ADiRVnh6UcvY4WX9JjXn3dg@mail.gmail.com>
Message-ID: <CAHk-=wg_C6V_S+Aox5Fn7MuFe13ADiRVnh6UcvY4WX9JjXn3dg@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] fscache: Replace and remove old I/O API
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net,
        CIFS <linux-cifs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-cachefs@redhat.com, Dave Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29, 2021 at 10:55 AM David Howells <dhowells@redhat.com> wrote:
>
> This means bisection is of limited value and why I'm looking at a 'flag day'.

So I'm kind of resigned to that by now, I just wanted to again clarify
that the rest of my comments are about "if we have to deal with a flag
dat anyway, then make it as simple and straightforward as possible,
rather than adding extra steps that are only noise".

> [ Snip explanation of netfslib ]
> This particular patchset is intended to enable removal of the old I/O routines
> by changing nfs and cifs to use a "fallback" method to use the new kiocb-using
> API and thus allow me to get on with the rest of it.

Ok, at least that explains that part.

But:

> However, if you would rather I just removed all of fscache and (most of[*])
> cachefiles, that I can do.

I assume and think that if you just do that part first, then the
"convert to netfslib" of afs and ceph at that later stage will mean
that the fallback code will never be needed?

So I would much prefer that streamlined model over one that adds that
temporary intermediate stage only for it to be deleted.

             Linus
