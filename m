Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C482DB6F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 00:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgLOXLn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 18:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgLOXLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:11:21 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE7BC0613D3;
        Tue, 15 Dec 2020 15:10:40 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id dk8so22873580edb.1;
        Tue, 15 Dec 2020 15:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CNCYDyfLbqK85vDm5hjHzQWbOVjNJhjXu61wGctb+F8=;
        b=YWJVa18gdWSNQd4V4MwE52xizIm2FtuItrZoGSkcGOMW5blpZ9uMJllLtBIQVb1CR5
         XoXCOdXMg29elarfEMZsEry1wt+aLJqvxptQXrx0sIJK1n56HCde4EYfzO145uu9GkOH
         N4O9zXHa7kn+vi1g+3fMMNdD4a8aumfj3WlvefmbH/Eb4isYfgNTZhTEDH3NY9jRHQ69
         M6BLwg/x9fbcwYn/5PqWbixwA5DKF91wcIT4OAIrtkW36M0GU/Ds9hrvY7v74qqEKzcn
         V0tRRtSmijTbHa8UjXc9vYhAdCDiOEMzAvkkkuvrdJKUEtAjbFrGMcucF4b1oQ5TX8Mj
         5bKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNCYDyfLbqK85vDm5hjHzQWbOVjNJhjXu61wGctb+F8=;
        b=hBoTSA0VSRWP6HTHep5WWyr3GktTfY9yWzNaEMsLv+uvjmiiynUtpi2ZlDth0wvrlo
         TH75ltxUFbsdVejh2d3EMKytnviLENXN1GupFEacAfefyzTUfftrJGq0YSNpFPc5pUos
         tuPypBYH3o1Al/okl9eWLXM8nx2xZQ3jcsMelQMyO2yQvjGcq44OfOBnRj89fqWBILf8
         r/y97sXvV8+CNd0sFOIw4uvVAfVmkyYVVhESiJYLQJmswpjR+ibREsW5mNepkM1KmViI
         PwLprn/CncYv/YnaaATQhcE41mjWbjpwTviYrAqmw/0HoifJXXNO4x4ItAjrAveYUTDh
         c0FA==
X-Gm-Message-State: AOAM533jrMaz6MLKPHR9w63ePogsZ0I6s/XEjbFgpxCmQDV5XNtCRF1B
        CVQJgsVYPT/fC5x/qx2aN0aX5p/yWJWvKD/adQA=
X-Google-Smtp-Source: ABdhPJxR+ByMCJElfTfLUQkytyJl4Gal4PtfC6HQ9qud4xb2PhRYCwELfYt/bF2MkYq2a+l14IdNcS18t1x+Y/rYCTA=
X-Received: by 2002:a05:6402:ca2:: with SMTP id cn2mr31375599edb.137.1608073839676;
 Tue, 15 Dec 2020 15:10:39 -0800 (PST)
MIME-Version: 1.0
References: <20201214223722.232537-1-shy828301@gmail.com> <20201214223722.232537-9-shy828301@gmail.com>
 <20201215030757.GO3913616@dread.disaster.area>
In-Reply-To: <20201215030757.GO3913616@dread.disaster.area>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 15 Dec 2020 15:10:28 -0800
Message-ID: <CAHbLzkrTeY5mNuwi7kLVrCeV2tUjr6GSK1BX1xLWLjkPNoZQYg@mail.gmail.com>
Subject: Re: [v2 PATCH 8/9] mm: memcontrol: reparent nr_deferred when memcg offline
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

On Mon, Dec 14, 2020 at 7:08 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Dec 14, 2020 at 02:37:21PM -0800, Yang Shi wrote:
> > Now shrinker's nr_deferred is per memcg for memcg aware shrinkers, add to parent's
> > corresponding nr_deferred when memcg offline.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/shrinker.h |  4 ++++
> >  mm/memcontrol.c          | 24 ++++++++++++++++++++++++
> >  mm/vmscan.c              |  2 +-
> >  3 files changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> > index 1eac79ce57d4..85cfc910dde4 100644
> > --- a/include/linux/shrinker.h
> > +++ b/include/linux/shrinker.h
> > @@ -78,6 +78,10 @@ struct shrinker {
> >  };
> >  #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
> >
> > +#ifdef CONFIG_MEMCG
> > +extern int shrinker_nr_max;
> > +#endif
> > +
> >  /* Flags */
> >  #define SHRINKER_REGISTERED  (1 << 0)
> >  #define SHRINKER_NUMA_AWARE  (1 << 1)
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 321d1818ce3d..1f191a15bee1 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -59,6 +59,7 @@
> >  #include <linux/tracehook.h>
> >  #include <linux/psi.h>
> >  #include <linux/seq_buf.h>
> > +#include <linux/shrinker.h>
> >  #include "internal.h"
> >  #include <net/sock.h>
> >  #include <net/ip.h>
> > @@ -612,6 +613,28 @@ void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
> >       }
> >  }
> >
> > +static void memcg_reparent_shrinker_deferred(struct mem_cgroup *memcg)
> > +{
> > +     int i, nid;
> > +     long nr;
> > +     struct mem_cgroup *parent;
> > +     struct memcg_shrinker_deferred *child_deferred, *parent_deferred;
> > +
> > +     parent = parent_mem_cgroup(memcg);
> > +     if (!parent)
> > +             parent = root_mem_cgroup;
> > +
> > +     for_each_node(nid) {
> > +             child_deferred = memcg->nodeinfo[nid]->shrinker_deferred;
> > +             parent_deferred = parent->nodeinfo[nid]->shrinker_deferred;
> > +             for (i = 0; i < shrinker_nr_max; i ++) {
> > +                     nr = atomic_long_read(&child_deferred->nr_deferred[i]);
> > +                     atomic_long_add(nr,
> > +                             &parent_deferred->nr_deferred[i]);
> > +             }
> > +     }
> > +}
>
> I would place this function in vmscan.c alongside the
> shrink_slab_set_nr_deferred_memcg() function so that all the
> accounting is in the one place.

Fine to me. Will incorporate in v3.

>
> > +
> >  /**
> >   * mem_cgroup_css_from_page - css of the memcg associated with a page
> >   * @page: page of interest
> > @@ -5543,6 +5566,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
> >       page_counter_set_low(&memcg->memory, 0);
> >
> >       memcg_offline_kmem(memcg);
> > +     memcg_reparent_shrinker_deferred(memcg);
> >       wb_memcg_offline(memcg);
> >
> >       drain_all_stock(memcg);
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 8d5bfd818acd..693a41e89969 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -201,7 +201,7 @@ DECLARE_RWSEM(shrinker_rwsem);
> >  #define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
> >
> >  static DEFINE_IDR(shrinker_idr);
> > -static int shrinker_nr_max;
> > +int shrinker_nr_max;
>
> Then we don't need to make yet another variable global...
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
