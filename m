Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3637E2DB6E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 00:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbgLOXIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 18:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730553AbgLOXIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:08:39 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EFCC061793;
        Tue, 15 Dec 2020 15:07:58 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id lt17so30083002ejb.3;
        Tue, 15 Dec 2020 15:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r18zDPp7Li8nfMcyLfci2xWIPMPHZANppnoHDsk75xs=;
        b=BJXxwhtq9T0BneVaLpbysNqCfNj2z9hBKFp78OPn1ACejUsdztd9OOirIEDwa4P1xv
         yDQrcoIYNgx+D76GNcecaKzWDQF9bRP7xIpQlG/ZqklDKfYatnF4CbSKnix5mFJqHfrx
         g8xFsZGjd4bX87d9wxFOK3jw803djSIy+4NHEQJuSNrmRW2nunTEPEBLaesVzpxEHsQD
         fCbChOmtVQwC0LSgTzZpyqWCxcBjhRfcbNPGzAqRmLZldWGw7TzBLzGWNaAdxSbqS1Vf
         NQShFCEb0mIH3N7Mtd3AxavVJ8hh39f1MIwdj7j1YVp4Q0FPhMw2E6LSnLpztHmaq+36
         58OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r18zDPp7Li8nfMcyLfci2xWIPMPHZANppnoHDsk75xs=;
        b=ZLHq+QBKrLV7hVs73lJQxQ55NPhc/vpdW+CiBeTVur6tHaI0FT3N3a6u+rf15ihh8i
         4h77iIGC+tjq9Wziv2LUsWD1wwbbs9fTOKVz4B+fMrmoh+3kLfyXMgRwsWDXNDtgVrbA
         VRnHlGaFSIl5mKbsCJ32e6bNWmjzyqMGTdCxpGY+HKcJHarex7eHhCzlnbxq2fqMsaGL
         pFnNO9LfYEExNwu/rkRzowCQCWXAOhlIuSU3RwAHur/RI7io35V+ua9p2sn9GinEtEva
         y71z6lsuXPaiiX+4g8RA0i4Nmo7MSd7r9Iyi3MtYPiQafetSeJqelMDQQIQK6aTNUie6
         Rmrg==
X-Gm-Message-State: AOAM531801QLWg6bS4wUP4C+XHiplGHfhF7Iw015P7qzy5Bym/JZbvf5
        141vbGviZe5SfeeS1IOWbymyi6SQVEvnxhu1Rqk=
X-Google-Smtp-Source: ABdhPJyxsCJeyFmSmOBjir74ypT6mbs7+dyKRuofmup0MP7qL4k+bJETRP3WCX1h6g/EiBuDKVBIH/Xe1avfbNpRNc0=
X-Received: by 2002:a17:906:7cc6:: with SMTP id h6mr28020461ejp.161.1608073677205;
 Tue, 15 Dec 2020 15:07:57 -0800 (PST)
MIME-Version: 1.0
References: <20201214223722.232537-1-shy828301@gmail.com> <20201214223722.232537-8-shy828301@gmail.com>
 <20201215030528.GN3913616@dread.disaster.area>
In-Reply-To: <20201215030528.GN3913616@dread.disaster.area>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 15 Dec 2020 15:07:45 -0800
Message-ID: <CAHbLzkoOcTuidghuR_pLsE4RX_6DiwXW+k2EQRJxrB6BDqhvBA@mail.gmail.com>
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

On Mon, Dec 14, 2020 at 7:05 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Dec 14, 2020 at 02:37:20PM -0800, Yang Shi wrote:
> > Now nr_deferred is available on per memcg level for memcg aware shrinkers, so don't need
> > allocate shrinker->nr_deferred for such shrinkers anymore.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index bce8cf44eca2..8d5bfd818acd 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -420,7 +420,15 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
> >   */
> >  int prealloc_shrinker(struct shrinker *shrinker)
> >  {
> > -     unsigned int size = sizeof(*shrinker->nr_deferred);
> > +     unsigned int size;
> > +
> > +     if (is_deferred_memcg_aware(shrinker)) {
> > +             if (prealloc_memcg_shrinker(shrinker))
> > +                     return -ENOMEM;
> > +             return 0;
> > +     }
> > +
> > +     size = sizeof(*shrinker->nr_deferred);
> >
> >       if (shrinker->flags & SHRINKER_NUMA_AWARE)
> >               size *= nr_node_ids;
> > @@ -429,26 +437,18 @@ int prealloc_shrinker(struct shrinker *shrinker)
> >       if (!shrinker->nr_deferred)
> >               return -ENOMEM;
> >
> > -     if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> > -             if (prealloc_memcg_shrinker(shrinker))
> > -                     goto free_deferred;
> > -     }
> > -
> >       return 0;
> > -
> > -free_deferred:
> > -     kfree(shrinker->nr_deferred);
> > -     shrinker->nr_deferred = NULL;
> > -     return -ENOMEM;
> >  }
>
> I'm trying to put my finger on it, but this seems wrong to me. If
> memcgs are disabled, then prealloc_memcg_shrinker() needs to fail.
> The preallocation code should not care about internal memcg details
> like this.
>
>         /*
>          * If the shrinker is memcg aware and memcgs are not
>          * enabled, clear the MEMCG flag and fall back to non-memcg
>          * behaviour for the shrinker.
>          */
>         if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
>                 error = prealloc_memcg_shrinker(shrinker);
>                 if (!error)
>                         return 0;
>                 if (error != -ENOSYS)
>                         return error;
>
>                 /* memcgs not enabled! */
>                 shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
>         }
>
>         size = sizeof(*shrinker->nr_deferred);
>         ....
>         return 0;
> }
>
> This guarantees that only the shrinker instances taht have a
> correctly set up memcg attached to them will have the
> SHRINKER_MEMCG_AWARE flag set. Hence in all the rest of the shrinker
> code, we only ever need to check for SHRINKER_MEMCG_AWARE to
> determine what we should do....

Thanks. I see your point. We could move the memcg specific details
into prealloc_memcg_shrinker().

It seems we have to acquire shrinker_rwsem before we check and modify
SHIRNKER_MEMCG_AWARE bit if we may clear it.

>
> >  void free_prealloced_shrinker(struct shrinker *shrinker)
> >  {
> > -     if (!shrinker->nr_deferred)
> > +     if (is_deferred_memcg_aware(shrinker)) {
> > +             unregister_memcg_shrinker(shrinker);
> >               return;
> > +     }
> >
> > -     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > -             unregister_memcg_shrinker(shrinker);
> > +     if (!shrinker->nr_deferred)
> > +             return;
> >
> >       kfree(shrinker->nr_deferred);
> >       shrinker->nr_deferred = NULL;
>
> e.g. then this function can simply do:
>
> {
>         if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>                 return unregister_memcg_shrinker(shrinker);
>         kfree(shrinker->nr_deferred);
>         shrinker->nr_deferred = NULL;
> }
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
