Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682CA1BD2EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 05:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgD2Dam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 23:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726567AbgD2Dal (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:30:41 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D884C03C1AD
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 20:30:41 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id f8so400174lfe.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 20:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2TI7CerNdrp5A6O6fiQbGr7STfYhiESWfFVCA8vmVU0=;
        b=wTqjBVFa2uRyEmnvVl4u3zFHwlO3ljDd+Ngp1Nc8E9g2ZTKEkLULHqU7JTmLSZbok0
         AKpFmxRbN29ag2mFg+6DJ8/DWKcqgt2UWaX9+UUn9345IzE/Emvj9KqpY+BTN2gQVHMI
         wdQhxCHVzK8MjNgEz55RVRPAOjej81ee5PPRv/N51QYyohwPGx/HLkn0Vhmeo2MoBDj2
         jz+ljZcJa28H6iLIszjZKSkbuzJaJPxvk0uBKPe08e4Lkb0ihSdiFPttj/B4STFpWQgU
         WsFrICY4Cl9ptZdDclvWcrhJh9iQ/DQ5G60wI/FkkpFMfiQLnlVWtKDo/10nAj0USx5C
         4Yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TI7CerNdrp5A6O6fiQbGr7STfYhiESWfFVCA8vmVU0=;
        b=n4kHjLL8Mbu5hyD1n0A5SOr6bF6/DJFOqLyJiRFffMxv8kp4ejP2yE63KaOmTYHoH7
         gc13HkViX0yzT7+Jw/eGHtjymvPF+v/2t/vQMk/kPimkVeabkkomuuh2BOHUaBrQNzmQ
         EjCyQkzRUPFCY1yRs+1C0xQ6iJ9Ggju686hJ74REJTuvvYV33CocFRytnFMrTUsS32gk
         BF+daaoNOhDroWtWdXfgfM5kaib+7J2DblAbt97rGjpg19+SRX/HsvcMBLpuWxXb0P0m
         McBx/CeAVd+le9+c/leexv8aaCZMf83CeZHHubBri3CHCGWfDaJDGbDZBK/gx/BSGtLR
         Lmew==
X-Gm-Message-State: AGi0PuaGamKNdAQUWH8ecRMCu84pi4d8Nn1Q3Xxg5fLA6Zk1O44sYa5f
        ueFhzVL5ImmCsaPhlEO5OBR6djkXFAYYagw2Jijc0QNK
X-Google-Smtp-Source: APiQypIhu+D+NYyGc6aDVaCL3fwrGr6QHRs63cH7J5+S0wtewoZYpKa1DgGyMfdDUkXZCWbyAaELX35gTx3GXZa+Bh8=
X-Received: by 2002:a19:f719:: with SMTP id z25mr21987672lfe.63.1588131039305;
 Tue, 28 Apr 2020 20:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200429023104.131925-1-jannh@google.com> <20200429024648.GA23230@ZenIV.linux.org.uk>
In-Reply-To: <20200429024648.GA23230@ZenIV.linux.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 Apr 2020 05:30:12 +0200
Message-ID: <CAG48ez3UsadMEHac-muTMvCgLPNV=BnFjn2sNWm59iQ-hxF+rw@mail.gmail.com>
Subject: Re: [PATCH] epoll: Fix UAF dentry name access in wakeup source setup
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        NeilBrown <neilb@suse.de>, "Rafael J . Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 4:46 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Wed, Apr 29, 2020 at 04:31:04AM +0200, Jann Horn wrote:
> > I'm guessing this will go through akpm's tree?
> >
> >  fs/eventpoll.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 8c596641a72b0..5052a41670479 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -1450,7 +1450,7 @@ static int reverse_path_check(void)
> >
> >  static int ep_create_wakeup_source(struct epitem *epi)
> >  {
> > -     const char *name;
> > +     struct name_snapshot name;
> >       struct wakeup_source *ws;
> >
> >       if (!epi->ep->ws) {
> > @@ -1459,8 +1459,9 @@ static int ep_create_wakeup_source(struct epitem *epi)
> >                       return -ENOMEM;
> >       }
> >
> > -     name = epi->ffd.file->f_path.dentry->d_name.name;
> > -     ws = wakeup_source_register(NULL, name);
> > +     take_dentry_name_snapshot(&name, epi->ffd.file->f_path.dentry);
> > +     ws = wakeup_source_register(NULL, name.name.name);
> > +     release_dentry_name_snapshot(&name);
>
> I'm not sure I like it.  Sure, it won't get freed under you that way; it still
> can go absolutely stale by the time you return from wakeup_source_register().
> What is it being used for?

The one user I'm aware of is Android; they use EPOLLWAKEUP in the
following places:

https://cs.android.com/search?q=EPOLLWAKEUP%20-file:strace%20-file:uapi%2F%20-file:syscall%2Fzerrors%20-file:sys%2Funix%2Fzerrors%20-file:prebuilts%2F%20-file:mod.rs%20-file:libcap-ng%2F%20-file:tests%2F&sq=

I see timerfds, /dev/input/event*, some other stuff with input devices
and video devices, binder, netlink socket, and some other stuff like
that - nothing that's actually likely to be renamed.


Searching on cs.android.com for places that parse this stuff, there
seems to be some code that uploads it as part of bug reports or
something (?), and some parser whose precise purpose I can't figure
out right now:
<https://cs.android.com/android/platform/superproject/+/master:frameworks/base/core/java/com/android/internal/os/KernelWakelockReader.java;l=210?q=%2Fwakeup_sources%20-file:sepolicy%20&ss=android>

(Arve might know what this is actually good for.)


Anyway, I don't think that name is actually particularly critical to
the correct functioning of the system; and the bug is a memory
corruption issue, so we should fix it somehow. And adding
infrastructure to power management so that it can invoke a callback to
figure out the (potentially, under rare circumstances, changing) name
of a wakeup source seems like a bit of overkill to me.
