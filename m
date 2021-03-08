Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937CD33185E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 21:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhCHUW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 15:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhCHUWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:22:33 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D0FC06174A;
        Mon,  8 Mar 2021 12:22:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id m9so16649831edd.5;
        Mon, 08 Mar 2021 12:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3p1K7qixRZDMiRKjRkwZnb9DrzcEb8jXcbBFm53rg9s=;
        b=Caln3dMvsxXDLD71Ze56UjGJP3p+B/XeWTIG8AYVUOuupr1rf1sJw1TIqhfR59BNZF
         3HyEP9un1YcjnDN7H7aNTIq4yv1s/RY+zFF25Akb/W334PqjR+VFZD4A1kYOmzLVNVV4
         s9ER+BzJUHFPwnuePf/jfuPlHPW3S+51L3RtuSawnNe+roneB9K+1mDIkuc7FP4jre/7
         jPSIhyyC3o11Gica68KKnO7LGbw5lHpYZTgPVfV67B5gu4YITK8ikiFR27oj4GcgMImS
         uZKCHayfX9zATHeBQ8yCHiqpFBpgw7v+p1/tta6COdbfrz8mPpRoMPtJ5DkCZqq1KXj4
         Q/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3p1K7qixRZDMiRKjRkwZnb9DrzcEb8jXcbBFm53rg9s=;
        b=QR3bXqlQn8NyLaHympsnsNvU7TmPL4m6QLG3DHFybqYgpDkPnQJIyUGNqxR2MtGbcA
         BiDePHYNMqRBU4MDF1ZxVV5eILQKG4K86fLSBskaW388IrgF88eHdNb/INarlf2j6Ebx
         Vng0I/tKVEtvuwErU14mE1kl2WmrQLAZmZTySGbQn8/RM9VKDwugmEU6tIcam/sSoeeC
         Q+Lhch7Iq/U5uAetR6HwGJP0J4drotRM9hkGBjOa+edKKUcD/ovK0TmnVstl+YpK+N9H
         WT3hERfQCv8RTkXCJHA/dU0qmNf+3H3qj+lhZh064zS5+cPGX3TvqnnXGYdJGlwyyPdP
         hQWQ==
X-Gm-Message-State: AOAM5301T7LrkhFDtJG4oy1X7ua/g6c/jmc1mciJ64aGGXnPe7aVZJU1
        LU/+4ew18m7JeQlRprpSHapT7QsbOxAehFyBV+U=
X-Google-Smtp-Source: ABdhPJxXgBHFmRBDWrSq58/rlEQ8Ee4ZYwQpZFrx6BX5YlFLoXsxQiEQinIj3MRdqqPCbruqA0NCUhzrpVL24ERXIcY=
X-Received: by 2002:a50:8f42:: with SMTP id 60mr363572edy.168.1615234952188;
 Mon, 08 Mar 2021 12:22:32 -0800 (PST)
MIME-Version: 1.0
References: <20210217001322.2226796-1-shy828301@gmail.com> <20210217001322.2226796-6-shy828301@gmail.com>
 <CALvZod75fge=B9LNg_sxbCiwDZjjtn8A9Q2HzU_R6rcg551o6Q@mail.gmail.com> <YEZVhNhGqV33lPo9@carbon.dhcp.thefacebook.com>
In-Reply-To: <YEZVhNhGqV33lPo9@carbon.dhcp.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Mar 2021 12:22:20 -0800
Message-ID: <CAHbLzkr2KWZA2e34DNjqnK6H-Ai8ox-f7iOET6OumZArYTB8JQ@mail.gmail.com>
Subject: Re: [v8 PATCH 05/13] mm: vmscan: use kvfree_rcu instead of call_rcu
To:     Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>, paulmck@kernel.org,
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

On Mon, Mar 8, 2021 at 8:49 AM Roman Gushchin <guro@fb.com> wrote:
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
> Oh, I didn't know about this difference. Thank you for noticing!

BTW, I think I could keep you and Kirill's acked-by with this change
(using two params form kvfree_rcu) since the change seems trivial.
