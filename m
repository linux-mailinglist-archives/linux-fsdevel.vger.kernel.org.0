Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98863315A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 19:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhCHSP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 13:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhCHSPQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:15:16 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F4BC06174A;
        Mon,  8 Mar 2021 10:15:16 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id mm21so22183872ejb.12;
        Mon, 08 Mar 2021 10:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/bzyPjovQ9TJfpqIkZJGibSjbqLtnRGGO1V2kB7/2Q=;
        b=oT47EDYu5ZrDjIsPLw10d/GmM4ySkio4jkFzzhG3F1k2nUmyG4zpwIg9brdLIjhvH7
         qQurFccmVjEpKc5/3/eeY+4IEo1je2kAdN8RMsGWgswPfZb+3T8oSRWQtnNeNNfdWjhP
         0A1rR8InatWETyJvi00eTrVWuScMq/s38yA80bWk7hvcAoWsYdci6cI5m7P0wHbSJyzb
         a3Lv2ZdqVlYr6S0bNxxgcOFaruzl/LaWJhdD5mSzEhqx0A/ID5uknvSuW16TpX5XeDsP
         mXCNbqMQgxSSvwm2z5mqFNbOeKOYXS1siv4Gi/c1GzEDhpbpqv6dun/zFyYpfm4+K7pt
         rCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/bzyPjovQ9TJfpqIkZJGibSjbqLtnRGGO1V2kB7/2Q=;
        b=n9yDtv+Wb6KpkZENS/Juvp+hOpFUAiiW7HdDpVimsyC3AUFm7eJi/URX8LKXx8nK9I
         f3IZCnRnxnXt6NGoGoO/jNGGZWNA37TZPkdg6kuRgebooqXPHZ33YlRhPk1ht2A9w80C
         I0WD3sSld1Al6z12MDO+KhGaAZBcFOedcsvSvldUjZ4aP8CBea+ufHsiKkwHqgaCyUdB
         ZVNuSnhfSZXtL+qvaCvgU2ifzWlSuGpUnnWNTKnTyp+CyVUEsRjHLx+VoRtTQxtOmmC1
         eV0NVlD0ll5yGV4ym07r2XQ8PWF1rAn4iP+eyizgJGTx7+kdOuO+/szfgD/ZoGD5gZqb
         OkOQ==
X-Gm-Message-State: AOAM531zegPxF8G7Z5pKAals/xeEVlRLhKhZUHiN8BdTbBXU1xqPGhSC
        KutNXC70hAkQxgLe8oTQ8homtWke3Oelgw5zV/8=
X-Google-Smtp-Source: ABdhPJzEtTVkv8kuvlaSOiCjwhpHgBuYuDk4ONeS1aBsrVoMOmnjPFX7SSO1+yQH37wno17IK5bLkfwFj6HxNQFjjLA=
X-Received: by 2002:a17:906:789:: with SMTP id l9mr15985654ejc.161.1615227315315;
 Mon, 08 Mar 2021 10:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20210217001322.2226796-1-shy828301@gmail.com> <20210217001322.2226796-6-shy828301@gmail.com>
 <CALvZod75fge=B9LNg_sxbCiwDZjjtn8A9Q2HzU_R6rcg551o6Q@mail.gmail.com> <20210308145444.GN2696@paulmck-ThinkPad-P72>
In-Reply-To: <20210308145444.GN2696@paulmck-ThinkPad-P72>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Mar 2021 10:15:03 -0800
Message-ID: <CAHbLzkoxVkzYDbFY4DmsQrj+8jv9xbsWAjdRHgKbgNgc0xWaqw@mail.gmail.com>
Subject: Re: [v8 PATCH 05/13] mm: vmscan: use kvfree_rcu instead of call_rcu
To:     paulmck@kernel.org
Cc:     Shakeel Butt <shakeelb@google.com>, Roman Gushchin <guro@fb.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 8, 2021 at 6:54 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, Mar 07, 2021 at 10:13:04PM -0800, Shakeel Butt wrote:
> > On Tue, Feb 16, 2021 at 4:13 PM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > Using kvfree_rcu() to free the old shrinker_maps instead of call_rcu().
> > > We don't have to define a dedicated callback for call_rcu() anymore.
> > >
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> > >  mm/vmscan.c | 7 +------
> > >  1 file changed, 1 insertion(+), 6 deletions(-)
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 2e753c2516fa..c2a309acd86b 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -192,11 +192,6 @@ static inline int shrinker_map_size(int nr_items)
> > >         return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
> > >  }
> > >
> > > -static void free_shrinker_map_rcu(struct rcu_head *head)
> > > -{
> > > -       kvfree(container_of(head, struct memcg_shrinker_map, rcu));
> > > -}
> > > -
> > >  static int expand_one_shrinker_map(struct mem_cgroup *memcg,
> > >                                    int size, int old_size)
> > >  {
> > > @@ -219,7 +214,7 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
> > >                 memset((void *)new->map + old_size, 0, size - old_size);
> > >
> > >                 rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
> > > -               call_rcu(&old->rcu, free_shrinker_map_rcu);
> > > +               kvfree_rcu(old);
> >
> > Please use kvfree_rcu(old, rcu) instead of kvfree_rcu(old). The single
> > param can call synchronize_rcu().
>
> Especially given that you already have the ->rcu field that the
> two-argument form requires.
>
> The reason for using the single-argument form is when you have lots of
> little data structures, such that getting rid of that rcu_head structure
> is valuable enough to be worth the occasional call to synchronize_rcu().
> However, please note that this call to synchronize_rcu() happens only
> under OOM conditions.

Thanks, Shakeel and Paul. I didn't realize the difference. Will use
the two params form in the new version.

>
>                                                         Thanx, Paul
