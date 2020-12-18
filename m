Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596B92DDC7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 01:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbgLRA5n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 19:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgLRA5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 19:57:43 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D41EC0617A7;
        Thu, 17 Dec 2020 16:57:02 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id 6so773487ejz.5;
        Thu, 17 Dec 2020 16:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbD/dRrGbDxXh6bC3folm4DWgmxDRpxAq9bBC6SC4+k=;
        b=ktLyBKf5jk0WsNYOBxZRR7EL07+cV0+O1zB7xk6iP83sDjUUrilu6t7VfNHv/4bWoe
         s2H0Tf2FvmJ8dhuCJX+m/fgvI1HW+YF8Km6OlQuNS4v4wjs+jnmVI4o900tvYZoBQyz4
         PSswVY2ngKmnoOtWSZbcSzlxq4ZAi1znC5dIMLmCbGKF6Xj4+MG5DndjTYTUc+1HjQGn
         VnURW9+FYdAMPLi/F8j6qAxwNyWxrtdo9WQY2yHRBb7xwwaPf7IOgVxI7JdQp8JtRdz7
         3zgSkscNXGHJVcFxIRd0GO90mWl2qqIZnES3ygBslfwnVAW6+IjIBdRc3ZNQhm9Z2QfF
         IV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbD/dRrGbDxXh6bC3folm4DWgmxDRpxAq9bBC6SC4+k=;
        b=hEA1VOnVDqmiFyTc6wr8RyCqI1NYJLj/se8L8iNN/xO7rV5erqsb3rlZoewOgYjQ/L
         4j/56L2/CRssqAaBNBOB/jwN9XmByhWrSKwuYT2h3Xkv55PA6EjI1Gr6ajldBQYWnOhb
         MQhSm+SSP5bPvXodbUJvuCEBxUtKNibWl8VX37BHZSXRJKawQfSMBsPkqCmQi+isLb9M
         xiDJlDs2QD+4YZSEsR+AiCy4e1sF2iweSV9wyN0Y+G8l3lIVdoQgbh9S1AdQRp2uuypL
         GrXoaYirKDR0QqOSR7udOqBTytJlfgPqPLJEuxOf7LKjQRNTk6iaRn5iIHdyNztBI2kO
         N+nA==
X-Gm-Message-State: AOAM532KrQSK/45cpXbDfJ0Y0y3rb0guRlogIdWcvGUJtUaQASsoAgHP
        rwabWNcukncH6pnLppOaFd5pCg7DFAJjYNyuUCE=
X-Google-Smtp-Source: ABdhPJxpn+YTVGd4P8X3A0/vXff0+YwH+btvdcy+G+SRmu3ePx33v5ttN3GVJ8D6gHv5BTyUUOhaZQor7ll9FCTHzGU=
X-Received: by 2002:a17:906:720e:: with SMTP id m14mr603462ejk.161.1608253021411;
 Thu, 17 Dec 2020 16:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20201214223722.232537-1-shy828301@gmail.com> <20201214223722.232537-8-shy828301@gmail.com>
 <20201215030528.GN3913616@dread.disaster.area> <CAHbLzkoOcTuidghuR_pLsE4RX_6DiwXW+k2EQRJxrB6BDqhvBA@mail.gmail.com>
In-Reply-To: <CAHbLzkoOcTuidghuR_pLsE4RX_6DiwXW+k2EQRJxrB6BDqhvBA@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 17 Dec 2020 16:56:48 -0800
Message-ID: <CAHbLzkoWco5gq8tuxbTsfpTF3GPUQLn9uNUTy1nUNwKGVPonmg@mail.gmail.com>
Subject: Re: [v2 PATCH 7/9] mm: vmscan: don't need allocate
 shrinker->nr_deferred for memcg aware shrinkers
To:     Dave Chinner <david@fromorbit.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 3:07 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Mon, Dec 14, 2020 at 7:05 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Dec 14, 2020 at 02:37:20PM -0800, Yang Shi wrote:
> > > Now nr_deferred is available on per memcg level for memcg aware shrinkers, so don't need
> > > allocate shrinker->nr_deferred for such shrinkers anymore.
> > >
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> > >  mm/vmscan.c | 28 ++++++++++++++--------------
> > >  1 file changed, 14 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index bce8cf44eca2..8d5bfd818acd 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -420,7 +420,15 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
> > >   */
> > >  int prealloc_shrinker(struct shrinker *shrinker)
> > >  {
> > > -     unsigned int size = sizeof(*shrinker->nr_deferred);
> > > +     unsigned int size;
> > > +
> > > +     if (is_deferred_memcg_aware(shrinker)) {
> > > +             if (prealloc_memcg_shrinker(shrinker))
> > > +                     return -ENOMEM;
> > > +             return 0;
> > > +     }
> > > +
> > > +     size = sizeof(*shrinker->nr_deferred);
> > >
> > >       if (shrinker->flags & SHRINKER_NUMA_AWARE)
> > >               size *= nr_node_ids;
> > > @@ -429,26 +437,18 @@ int prealloc_shrinker(struct shrinker *shrinker)
> > >       if (!shrinker->nr_deferred)
> > >               return -ENOMEM;
> > >
> > > -     if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> > > -             if (prealloc_memcg_shrinker(shrinker))
> > > -                     goto free_deferred;
> > > -     }
> > > -
> > >       return 0;
> > > -
> > > -free_deferred:
> > > -     kfree(shrinker->nr_deferred);
> > > -     shrinker->nr_deferred = NULL;
> > > -     return -ENOMEM;
> > >  }
> >
> > I'm trying to put my finger on it, but this seems wrong to me. If
> > memcgs are disabled, then prealloc_memcg_shrinker() needs to fail.
> > The preallocation code should not care about internal memcg details
> > like this.
> >
> >         /*
> >          * If the shrinker is memcg aware and memcgs are not
> >          * enabled, clear the MEMCG flag and fall back to non-memcg
> >          * behaviour for the shrinker.
> >          */
> >         if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> >                 error = prealloc_memcg_shrinker(shrinker);
> >                 if (!error)
> >                         return 0;
> >                 if (error != -ENOSYS)
> >                         return error;
> >
> >                 /* memcgs not enabled! */
> >                 shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
> >         }
> >
> >         size = sizeof(*shrinker->nr_deferred);
> >         ....
> >         return 0;
> > }
> >
> > This guarantees that only the shrinker instances taht have a
> > correctly set up memcg attached to them will have the
> > SHRINKER_MEMCG_AWARE flag set. Hence in all the rest of the shrinker
> > code, we only ever need to check for SHRINKER_MEMCG_AWARE to
> > determine what we should do....
>
> Thanks. I see your point. We could move the memcg specific details
> into prealloc_memcg_shrinker().
>
> It seems we have to acquire shrinker_rwsem before we check and modify
> SHIRNKER_MEMCG_AWARE bit if we may clear it.

Hi Dave,

Is it possible that shrinker register races with shrinker unregister?
It seems impossible to me by a quick visual code inspection. But I'm
not a VFS expert so I'm not quite sure.

If it is impossible the implementation would be quite simple otherwise
we need move shrinker_rwsem acquire/release to
prealloc_shrinker/free_prealloced_shrinker/unregister_shrinker to
protect SHRINKER_MEMCG_AWARE update.

>
> >
> > >  void free_prealloced_shrinker(struct shrinker *shrinker)
> > >  {
> > > -     if (!shrinker->nr_deferred)
> > > +     if (is_deferred_memcg_aware(shrinker)) {
> > > +             unregister_memcg_shrinker(shrinker);
> > >               return;
> > > +     }
> > >
> > > -     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > > -             unregister_memcg_shrinker(shrinker);
> > > +     if (!shrinker->nr_deferred)
> > > +             return;
> > >
> > >       kfree(shrinker->nr_deferred);
> > >       shrinker->nr_deferred = NULL;
> >
> > e.g. then this function can simply do:
> >
> > {
> >         if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> >                 return unregister_memcg_shrinker(shrinker);
> >         kfree(shrinker->nr_deferred);
> >         shrinker->nr_deferred = NULL;
> > }
> >
> > Cheers,
> >
> > Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
