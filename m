Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481B72CCE28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 06:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgLCFAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 00:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgLCFAd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 00:00:33 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634ACC061A4D;
        Wed,  2 Dec 2020 20:59:53 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id jx16so1490888ejb.10;
        Wed, 02 Dec 2020 20:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKGVg3cjoOrKRnpZuJPclcM34b/MdOnvCpoVioB4GiE=;
        b=aA3dQ5LwD94gHv9tuPNuUTnydYahQYDyWyTmwK7CdUxoIyAgiHV3lFQIu9GU7MkGGm
         +MEB1P9NgZdsBkS+/oy4qafMnAmQS67ktM2RFqAPox/x+zvdGzJz/uqei3aNltfJkjKh
         M2j3O7a62J5kp0St7LaBLBaGqn1GQQEwjhL8NxHNq29hSZt9y6ubPgCLoulUvnSDDrKI
         GInIO9fBexHoAGvIeMBSGPlok8o6C/LxRWEDAZhiXKmxUmYkKzksnKK/VT/YOsku3Voc
         6inFezZ0jt4dz95SILjpO12BsoExFtRfUI5TenhIQTR00z+mAVEsVh/PUQZkIbXKno4o
         uwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKGVg3cjoOrKRnpZuJPclcM34b/MdOnvCpoVioB4GiE=;
        b=HrP3PbMD94GG39j0ILtlQypEBd5wK+2LDgins9p0cyWGHh7KflawAv1Cf4T0bwEuVS
         DXL/dMEOofRUNjbkoGqNVTzeaCIpLnFBCH6ZwrBObdggByVKnOJe4HIXZqpZ6nC1WBjv
         huvj+k50uFr2bEbDIIXFZz7NTuESH35e47wM/mjLEa4qwDtKDJWBUmByiY+iAcfpQ+zQ
         AWt1JOmbhMwSP6Wctdd1uHTILVdWbC7zX3vWp4iw83XrcnxNW/OUYAqKFEQswAzddRsB
         vkCL9vICLZ6Z2pmdDteEhdgfmQUshWjvt6FC/W/EiLyks27AUQFsfXPRY6fnDlfovFk5
         E6ZQ==
X-Gm-Message-State: AOAM533eicim+elmsySMOKMwtb9nI5GATpLMAopLHEAVc0UQ4Yyukqca
        Wbt0f8GQ5ky+WnQMUvZBoyFXPyNVGjT53m52V58=
X-Google-Smtp-Source: ABdhPJzy0wACDe5vcyUC6PWOelt+YwF9TErWrS5iOQVmq9w+OL/9iO2OP92bKuLVWAfv3guXpwKa7CwZ5v8vxT9DNh8=
X-Received: by 2002:a17:906:cd06:: with SMTP id oz6mr997936ejb.25.1606971592123;
 Wed, 02 Dec 2020 20:59:52 -0800 (PST)
MIME-Version: 1.0
References: <20201202182725.265020-1-shy828301@gmail.com> <20201202182725.265020-5-shy828301@gmail.com>
 <20201203030104.GF1375014@carbon.DHCP.thefacebook.com>
In-Reply-To: <20201203030104.GF1375014@carbon.DHCP.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 2 Dec 2020 20:59:40 -0800
Message-ID: <CAHbLzkoUNuKHT_4w8QaWCQA3xs2vTW4Xii26a5vpVqxrDVSX_Q@mail.gmail.com>
Subject: Re: [PATCH 4/9] mm: vmscan: use a new flag to indicate shrinker is registered
To:     Roman Gushchin <guro@fb.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
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

On Wed, Dec 2, 2020 at 7:01 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Dec 02, 2020 at 10:27:20AM -0800, Yang Shi wrote:
> > Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
> > This approach is fine with nr_deferred atthe shrinker level, but the following
> > patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
> > shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
> > from unregistering correctly.
> >
> > Introduce a new "state" field to indicate if shrinker is registered or not.
> > We could use the highest bit of flags, but it may be a little bit complicated to
> > extract that bit and the flags is accessed frequently by vmscan (every time shrinker
> > is called).  So add a new field in "struct shrinker", we may waster a little bit
> > memory, but it should be very few since there should be not too many registered
> > shrinkers on a normal system.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/shrinker.h |  4 ++++
> >  mm/vmscan.c              | 13 +++++++++----
> >  2 files changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> > index 0f80123650e2..0bb5be88e41d 100644
> > --- a/include/linux/shrinker.h
> > +++ b/include/linux/shrinker.h
> > @@ -35,6 +35,9 @@ struct shrink_control {
> >
> >  #define SHRINK_STOP (~0UL)
> >  #define SHRINK_EMPTY (~0UL - 1)
> > +
> > +#define SHRINKER_REGISTERED  0x1
> > +
> >  /*
> >   * A callback you can register to apply pressure to ageable caches.
> >   *
> > @@ -66,6 +69,7 @@ struct shrinker {
> >       long batch;     /* reclaim batch size, 0 = default */
> >       int seeks;      /* seeks to recreate an obj */
> >       unsigned flags;
> > +     unsigned state;
>
> Hm, can't it be another flag? It seems like we have a plenty of free bits.

I thought about this too. But I was not convinced by myself that
messing flags with state is a good practice. We may add more flags in
the future, so we may end up having something like:

flag
flag
flag
state
flag
flag
...

Maybe we could use the highest bit for state?

>
> >
> >       /* These are for internal use */
> >       struct list_head list;
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 457ce04eebf2..0d628299e55c 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -378,6 +378,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
> >       if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> >               idr_replace(&shrinker_idr, shrinker, shrinker->id);
> >  #endif
> > +     shrinker->state |= SHRINKER_REGISTERED;
> >       up_write(&shrinker_rwsem);
> >  }
> >
> > @@ -397,13 +398,17 @@ EXPORT_SYMBOL(register_shrinker);
> >   */
> >  void unregister_shrinker(struct shrinker *shrinker)
> >  {
> > -     if (!shrinker->nr_deferred)
> > -             return;
> > -     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > -             unregister_memcg_shrinker(shrinker);
> >       down_write(&shrinker_rwsem);
> > +     if (!shrinker->state) {
> > +             up_write(&shrinker_rwsem);
> > +             return;
> > +     }
> >       list_del(&shrinker->list);
> > +     shrinker->state &= ~SHRINKER_REGISTERED;
> >       up_write(&shrinker_rwsem);
> > +
> > +     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > +             unregister_memcg_shrinker(shrinker);
> >       kfree(shrinker->nr_deferred);
> >       shrinker->nr_deferred = NULL;
> >  }
> > --
> > 2.26.2
> >
