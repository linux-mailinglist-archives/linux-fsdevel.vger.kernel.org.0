Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4EB308BBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 18:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhA2Rh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 12:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhA2Rfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:35:52 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0544C0613D6;
        Fri, 29 Jan 2021 09:34:42 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id d2so11480209edz.3;
        Fri, 29 Jan 2021 09:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Omw5Ys8o3vFL1EfQiRnB9qvp9jJo/sSZIBuGwWy4rQw=;
        b=P0udmoE4cNOfopGGDdUneugQsQ/x1aX+JDuhmR0HowCh/+jrrZGT2l7oaPkNT9lnYH
         bzg6zxVIcGudkcFcuY5TF5P8XLde+LRySzA5DOaAtkYCU1l6IRJdbmObU7g0RxyCrARy
         QbdDYAY5Ky2ij5Vy+Ge8Du2yFvoXqGMXowlM8E2DAfcD6u2z0esPkAAoiNZusd43i9zd
         K5kiUvDV+xHSZpYgIXgilfjFPZHdbBau5ttK3/s/KShoF+EAjmddHnpaZGWH7uO7ccfc
         hsnURnsttDRemCYnJQR9/bmiMNZCpbj1I76rNb5p1UYnKgqXkru9zjBRkBQ2okGMAkiH
         RO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Omw5Ys8o3vFL1EfQiRnB9qvp9jJo/sSZIBuGwWy4rQw=;
        b=L/IcI6HgHS8UEI24Jg0LKYkZF9a8yOlSXomhssIwx2f11nSr2wMxAHFEsQcPaWNW3j
         6euiv3BeVZCwG+os3Pup1+z0fgxqChlFQILav4QvWaT91k6gP6F1VYaMAIwLftbw3qPt
         gmY1zu+oeNe4oklVEVGuRt/rOyVufhxzFZKOEOkqAG9wtcBVMpEfEGWydGIwrUrbf7f4
         tnBe+mRd02gRwr3LMEETq7ZZF3kNxPilsYxntnN1UGRMP4c6BZWulFlDHUkV37wLhGFp
         cfauXK2yAJYuRtf3aRJDRyBtyfSD8vK1glsRKpt7HVbWujuvapoOe8Cd9GhC4et0Hve0
         t2WA==
X-Gm-Message-State: AOAM533oZAx5IOqvqG2lgkG+3xLImn1/BWIi86y45+d9Nrxixhs0dG2v
        wYrZNp3GzSgdehIIzPtGL5U7A9FtlAJJjGtNAEk=
X-Google-Smtp-Source: ABdhPJzJ9q7GFSTWtDLwX7jFAbH8oqLzoNJhAF7eKIMW47rYuGUgnjAMcsfVYtTT854WgHhPgyCIDk2+eJs4bi/x/ss=
X-Received: by 2002:a50:e8c1:: with SMTP id l1mr6358721edn.168.1611941681756;
 Fri, 29 Jan 2021 09:34:41 -0800 (PST)
MIME-Version: 1.0
References: <20210127233345.339910-1-shy828301@gmail.com> <20210127233345.339910-10-shy828301@gmail.com>
 <a519ccbd-7fae-ae8a-9900-bd49a758b5c8@suse.cz>
In-Reply-To: <a519ccbd-7fae-ae8a-9900-bd49a758b5c8@suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 29 Jan 2021 09:34:29 -0800
Message-ID: <CAHbLzkocuf94V4eegX2G=7GS=Q1Vbt8xrbs-8ASeYjNQfceOQQ@mail.gmail.com>
Subject: Re: [v5 PATCH 09/11] mm: vmscan: don't need allocate
 shrinker->nr_deferred for memcg aware shrinkers
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
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

On Fri, Jan 29, 2021 at 7:40 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/28/21 12:33 AM, Yang Shi wrote:
> > Now nr_deferred is available on per memcg level for memcg aware shrinkers, so don't need
> > allocate shrinker->nr_deferred for such shrinkers anymore.
> >
> > The prealloc_memcg_shrinker() would return -ENOSYS if !CONFIG_MEMCG or memcg is disabled
> > by kernel command line, then shrinker's SHRINKER_MEMCG_AWARE flag would be cleared.
> > This makes the implementation of this patch simpler.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> > @@ -525,8 +528,20 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
> >   */
> >  int prealloc_shrinker(struct shrinker *shrinker)
> >  {
> > -     unsigned int size = sizeof(*shrinker->nr_deferred);
> > +     unsigned int size;
> > +     int err;
> > +
> > +     if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> > +             err = prealloc_memcg_shrinker(shrinker);
> > +             if (!err)
> > +                     return 0;
>
> Nit: this err == 0 case is covered below:

Aha, thanks. Will fix in v6.

>
> > +             if (err != -ENOSYS)
> > +                     return err;
> > +
> > +             shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
> > +     }
> >
> > +     size = sizeof(*shrinker->nr_deferred);
> >       if (shrinker->flags & SHRINKER_NUMA_AWARE)
> >               size *= nr_node_ids;
> >
