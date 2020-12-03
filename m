Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECC32CE188
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 23:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgLCW0O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 17:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgLCW0O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:26:14 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD09C061A4F;
        Thu,  3 Dec 2020 14:25:33 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id v14so5053121lfo.3;
        Thu, 03 Dec 2020 14:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZUGplS6otRHZGB4uiEDdWMeSyvXO6myoGBH5DWzVgY=;
        b=st5i+4HyffCKXte4m5SNX0NoAfoeMZo+7DYMbOn/WSWRpGMwDOEEjVmjvqCfNNK4+E
         wDfsSmm8xaAj+8E4q1Ha76gyKXlHlZmh/uFE/3G5kIdvjZjP2/ABU/E9E1Vm6tXFl8UY
         eeCr0UjpemF06+PayWaIfgkEtpFz60pK0RYlaJx/eve8aH4iaixxcg8H6ZPSAWpX2k4O
         8CUP8k4CuqUicjrNbPIEhRfl7J1XduT73pfCkdQkodNYMsiXaM773QwzLrF4MSs3Ol9u
         IIVHogLCC7TG+zCfNJlN4F61Uww5HZnVH3dxgPhmAfQ9P3hfTGMHi3VatmUcqgo1mgPo
         L4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZUGplS6otRHZGB4uiEDdWMeSyvXO6myoGBH5DWzVgY=;
        b=YrpLd++Ut5s1qa6uT/TnNJkFAGXb3tfITp2e4+cHqRnpDLQ1NdujXoa9WXunc/ITvg
         pyPRVb9hK4+y7NZJ+deesdck8iSWLn+KDmCjgLAjkKq/66Vrha+Yyv0OrjfF1yunohux
         rsmdntMTcsHssbZvE34/qo9Lfbkrlq+QouCrXTiEjy37G7NMwHf09HSQOHYec45m3pyI
         eOvNljwZ+o12v9D7Om/wm8Z59ZZSpNLEYQCNor2I4j2sg6TMcOovdgcFpnv3axXoO8PG
         Ei2yuFrTJJ1pDrYZtoRMiwd34xeMh8kFWqnzz0KRCbIuxYvnAByfjS8dTpM7qp0RN3UG
         cYeQ==
X-Gm-Message-State: AOAM532T3ufgeZi1FpYwbjIwJSnXsqGlS3qPnRVUKqB09I3eQqPxaVbP
        YDBm0D5a3ifhRQq48naKpz0q9KemAES4JWnHoj4=
X-Google-Smtp-Source: ABdhPJw2KPcZ7OEA4t573BTxnublS3r8cLhXi4GH9AhB5ze7Ibd5eeYqJNdDp+L42MWu1By0HZpJj2+ibW285RfIpws=
X-Received: by 2002:a19:6a07:: with SMTP id u7mr2012587lfu.252.1607034331908;
 Thu, 03 Dec 2020 14:25:31 -0800 (PST)
MIME-Version: 1.0
References: <20201202182725.265020-1-shy828301@gmail.com> <20201202182725.265020-5-shy828301@gmail.com>
 <20201203030104.GF1375014@carbon.DHCP.thefacebook.com> <CAHbLzkoUNuKHT_4w8QaWCQA3xs2vTW4Xii26a5vpVqxrDVSX_Q@mail.gmail.com>
 <20201203200820.GC1571588@carbon.DHCP.thefacebook.com>
In-Reply-To: <20201203200820.GC1571588@carbon.DHCP.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 3 Dec 2020 14:25:20 -0800
Message-ID: <CAHbLzkrbd+gBUngiRa3OJhO3q_Z7x3w6+jkX2CkXG0Zm=jufQA@mail.gmail.com>
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

On Thu, Dec 3, 2020 at 12:09 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Dec 02, 2020 at 08:59:40PM -0800, Yang Shi wrote:
> > On Wed, Dec 2, 2020 at 7:01 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Wed, Dec 02, 2020 at 10:27:20AM -0800, Yang Shi wrote:
> > > > Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
> > > > This approach is fine with nr_deferred atthe shrinker level, but the following
> > > > patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
> > > > shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
> > > > from unregistering correctly.
> > > >
> > > > Introduce a new "state" field to indicate if shrinker is registered or not.
> > > > We could use the highest bit of flags, but it may be a little bit complicated to
> > > > extract that bit and the flags is accessed frequently by vmscan (every time shrinker
> > > > is called).  So add a new field in "struct shrinker", we may waster a little bit
> > > > memory, but it should be very few since there should be not too many registered
> > > > shrinkers on a normal system.
> > > >
> > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > ---
> > > >  include/linux/shrinker.h |  4 ++++
> > > >  mm/vmscan.c              | 13 +++++++++----
> > > >  2 files changed, 13 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> > > > index 0f80123650e2..0bb5be88e41d 100644
> > > > --- a/include/linux/shrinker.h
> > > > +++ b/include/linux/shrinker.h
> > > > @@ -35,6 +35,9 @@ struct shrink_control {
> > > >
> > > >  #define SHRINK_STOP (~0UL)
> > > >  #define SHRINK_EMPTY (~0UL - 1)
> > > > +
> > > > +#define SHRINKER_REGISTERED  0x1
> > > > +
> > > >  /*
> > > >   * A callback you can register to apply pressure to ageable caches.
> > > >   *
> > > > @@ -66,6 +69,7 @@ struct shrinker {
> > > >       long batch;     /* reclaim batch size, 0 = default */
> > > >       int seeks;      /* seeks to recreate an obj */
> > > >       unsigned flags;
> > > > +     unsigned state;
> > >
> > > Hm, can't it be another flag? It seems like we have a plenty of free bits.
> >
> > I thought about this too. But I was not convinced by myself that
> > messing flags with state is a good practice. We may add more flags in
> > the future, so we may end up having something like:
> >
> > flag
> > flag
> > flag
> > state
> > flag
> > flag
> > ...
> >
> > Maybe we could use the highest bit for state?
>
> Or just
> state
> flag
> flag
> flag
> flag
> flag
> ...
>
> ?

It is fine too. We should not add more states in foreseeable future.
