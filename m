Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425A8302D3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 22:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732228AbhAYVHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 16:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732078AbhAYVH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:07:28 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3719C06174A;
        Mon, 25 Jan 2021 13:06:42 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ox12so20114285ejb.2;
        Mon, 25 Jan 2021 13:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FX9j6fg/l3UnkjnVovfbEoZ/VqeYVGd4XAUneqdYGy4=;
        b=DMtqO9rfFBKbqSFMAzoPBZgstYNBfe9bsglQhNCo3FXF1ZAm9pbpoCu/H0E9kWke5f
         bu8Z5w+LmC92NS2470l4llha0LtbIdevkh2Jex5wA7Ac6n2Gah9pHRPPzbvfndnzMdBh
         U3LTDwLrQdi8VFiu+w7bhJ5fw4wNRcYJ7gk9pkK3SNSkC2Jn9WOTdTgtnT68BY/xntlE
         68H2Npz6SP5jvETKHGiU3p8JKGk/lydaQ61RG59vtw5zlf+yjAWxxp/VR3rCJKSNfHyP
         0RHjXe4b2KAZ02nA6G0YGs+o2Z3oWOKDOTyFNAgfxOG4EXoDjPfLpgDXIXZlu7tR0mJd
         6DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FX9j6fg/l3UnkjnVovfbEoZ/VqeYVGd4XAUneqdYGy4=;
        b=eaOTxF+bG44zmroO+qtGEaljkhaMIP4SQGe8k57KIkHYfImwBLkGYqK6vPFHblEEQv
         zKowpBHbk7XxbmxM3CE0xZSnDxiDK0Y0/O4eEemdfOkzGm6lMJsk7pB4DbQmyZ8mU8Xh
         kaJqGYp0BCMxvPORYcG/TccjxzZYM0Wqe17fDRNgu/SoNIDkZGR8SW4awsappHYLj453
         Q3dqBaJB9HHYhsDVJvmu8Bojz5RDPXnCNr0AZ5sSB7Oz/vsGm2J8JE0lZfVYTfvUvU8y
         yK5wzL/KAY4tOz25EQPf2zVi1geZ/wON+L6daXKJAKhRUv5cXrkPFHVy8gGDs5AQ54Ca
         9CxA==
X-Gm-Message-State: AOAM530k/nMLIBPG+bDj9Ke3Nm+M39D7hjmBk77eGL4acjmHH7HOPtr7
        GsGK3lMe6cXP9Eh2wrVE4IXZJYudGu3Shxp1j68=
X-Google-Smtp-Source: ABdhPJyiwfxNZpAkTfcMRZ2FWtH2Y+PYzlxEANL1/0TqlA6dV9oKAa/+FOiAhCvB+cYclrXR1HGe4HhBvK9t/iHKcdQ=
X-Received: by 2002:a17:906:94d3:: with SMTP id d19mr1422050ejy.383.1611608801446;
 Mon, 25 Jan 2021 13:06:41 -0800 (PST)
MIME-Version: 1.0
References: <20210121230621.654304-1-shy828301@gmail.com> <20210121230621.654304-5-shy828301@gmail.com>
 <af9204cb-2298-ee7c-5307-295d33befd8a@virtuozzo.com>
In-Reply-To: <af9204cb-2298-ee7c-5307-295d33befd8a@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 25 Jan 2021 13:06:28 -0800
Message-ID: <CAHbLzkpPBGxzpyvxDaMpjiL9T6eeS0B9QJSkChAK-YbPWSMY6A@mail.gmail.com>
Subject: Re: [v4 PATCH 04/11] mm: vmscan: remove memcg_shrinker_map_size
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>,
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

On Mon, Jan 25, 2021 at 12:36 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 22.01.2021 02:06, Yang Shi wrote:
> > Both memcg_shrinker_map_size and shrinker_nr_max is maintained, but actually the
> > map size can be calculated via shrinker_nr_max, so it seems unnecessary to keep both.
> > Remove memcg_shrinker_map_size since shrinker_nr_max is also used by iterating the
> > bit map.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index d3f3701dfcd2..40e7751ef961 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -185,8 +185,7 @@ static LIST_HEAD(shrinker_list);
> >  static DECLARE_RWSEM(shrinker_rwsem);
> >
> >  #ifdef CONFIG_MEMCG
> > -
> > -static int memcg_shrinker_map_size;
> > +static int shrinker_nr_max;
> >
> >  static void free_shrinker_map_rcu(struct rcu_head *head)
> >  {
> > @@ -248,7 +247,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
> >               return 0;
> >
> >       down_write(&shrinker_rwsem);
> > -     size = memcg_shrinker_map_size;
> > +     size = (shrinker_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
> >       for_each_node(nid) {
> >               map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
> >               if (!map) {
> > @@ -266,10 +265,11 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
> >  static int expand_shrinker_maps(int new_id)
> >  {
> >       int size, old_size, ret = 0;
> > +     int new_nr_max = new_id + 1;
> >       struct mem_cgroup *memcg;
> >
> > -     size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
> > -     old_size = memcg_shrinker_map_size;
> > +     size = (new_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
> > +     old_size = (shrinker_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
> >
> >       if (size <= old_size)
> >               return 0;
>
> This looks a BUG:
>
> expand_shrinker_maps(id == 1)
> {
>         old_size = 64;
>         size = 64;
>
>         ===>return 0 and shrinker_nr_max remains 0.
> }
>
> Then shrink_slab_memcg() misses this shrinker since shrinker_nr_max == 0.

Yes, thanks for catching this. It should be fixed by the below patch:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bb254d39339f..47010a69b400 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -287,7 +287,7 @@ static int expand_shrinker_info(int new_id)
        old_d_size = shrinker_nr_max * sizeof(atomic_long_t);
        old_size = old_m_size + old_d_size;
        if (size <= old_size)
-               return 0;
+               goto out;

        if (!root_mem_cgroup)
                goto out;

>
> >
> > @@ -286,9 +286,10 @@ static int expand_shrinker_maps(int new_id)
> >                       goto out;
> >               }
> >       } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
> > +
> >  out:
> >       if (!ret)
> > -             memcg_shrinker_map_size = size;
> > +             shrinker_nr_max = new_nr_max;
> >
> >       return ret;
> >  }
> > @@ -321,7 +322,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
> >  #define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
> >
> >  static DEFINE_IDR(shrinker_idr);
> > -static int shrinker_nr_max;
> >
> >  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >  {
> > @@ -338,8 +338,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >                       idr_remove(&shrinker_idr, id);
> >                       goto unlock;
> >               }
> > -
> > -             shrinker_nr_max = id + 1;
> >       }
> >       shrinker->id = id;
> >       ret = 0;
> >
>
>
