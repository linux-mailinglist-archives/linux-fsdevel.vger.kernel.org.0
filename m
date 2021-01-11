Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBB42F1CDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 18:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389856AbhAKRoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 12:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbhAKRoh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:44:37 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A152C061795;
        Mon, 11 Jan 2021 09:44:22 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id p22so583590edu.11;
        Mon, 11 Jan 2021 09:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mCsEhqQNufWXvKqj70hNQJtFIr+1/eY9BnkZgw3eEHU=;
        b=WdLVaygag1lUeO2+2wpkBrCYfxnEdHj4D5uhqiQcd1rffCviN40OIBwfF5EZGfzcbJ
         /tIf0s/pDpkVoBElls4oaurZVwT25r//ITjTV6/qtnJSIGoyMc207SSHO7GMX/9Zpwj/
         3RQlLSUNdt5EdGr+eqpHTIZ0pM7bay7FWREwTGnSp5YLq82bfhAcd4xjZVZRusS1AcOi
         nRuWM/NajK2ST7AUnoEVtHNSWoUs0A/+Hvji6s3DnBT0xF78oSQMOxUf54hMoaJTWfS6
         kFN0kfJvkrnsrlKtwNpr5lhVqAkUUMT1lLmrv0iQHwEi7SIF3ADG69b0QGGCK9OSkbmW
         yKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mCsEhqQNufWXvKqj70hNQJtFIr+1/eY9BnkZgw3eEHU=;
        b=fPtex7sKuoAUYMg60WCSSfPJjnlNa/wCYY3t/HeUh+0p54hyVqg20dNcXHvjOQx/Sx
         ttIcoeBeuvCqA+Tc7vsypTYLC8FQeEI8tDue1C81sI3EbZ4FYAPiFQy/CheeQYkXyO//
         4AQr4gDOxxF1ZZOlXs5rxWIi9xo1wfxv+3UM4NRv6umpWxtZ7qHEedesc3Z0vJ56/AQy
         LyydinmO1sVbeG22XY+0aYsuuO38NCVoQubaphCgefBUr8n8LuvhMfTqERsmJJl/eKXM
         xMIQ94PHQL9WY9GOay/ABM6qCBAVehyIrYLSY1fmS2/bePj+ilgitcaxDDxdK3hkO9D/
         X1pQ==
X-Gm-Message-State: AOAM533dNwlXYQun1uuBm4/kfHazXgC4LtPH2lhOGSgWvWqtzGSDXG2u
        IxIv50J8Ge4IcLKJsr/tD5668ROfCcpsyzS0VAk=
X-Google-Smtp-Source: ABdhPJx+WjTFsu1b1mLfoswctxuuFRdJ4IseoJGWW0pPXYoP6QNr7dABxfqivghOWslz8YEXEX7UuskT+H2yOSzeWgs=
X-Received: by 2002:a05:6402:ca2:: with SMTP id cn2mr364738edb.137.1610387061325;
 Mon, 11 Jan 2021 09:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20210105225817.1036378-1-shy828301@gmail.com> <20210105225817.1036378-5-shy828301@gmail.com>
 <955422c5-0703-e9fb-f309-6ed6b5fc0e0a@virtuozzo.com>
In-Reply-To: <955422c5-0703-e9fb-f309-6ed6b5fc0e0a@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 11 Jan 2021 09:44:09 -0800
Message-ID: <CAHbLzkry4Nt0DNF5ss+CD=WDS=bwtQy2zbaQ=nmRkN575mC_vw@mail.gmail.com>
Subject: Re: [v3 PATCH 04/11] mm: vmscan: remove memcg_shrinker_map_size
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

On Wed, Jan 6, 2021 at 2:16 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 06.01.2021 01:58, Yang Shi wrote:
> > Both memcg_shrinker_map_size and shrinker_nr_max is maintained, but actually the
> > map size can be calculated via shrinker_nr_max, so it seems unnecessary to keep both.
> > Remove memcg_shrinker_map_size since shrinker_nr_max is also used by iterating the
> > bit map.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index ddb9f972f856..8da765a85569 100644
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
> >  static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
> >  {
> > @@ -248,7 +247,7 @@ int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
> >               return 0;
> >
> >       down_read(&shrinker_rwsem);
> > -     size = memcg_shrinker_map_size;
> > +     size = DIV_ROUND_UP(shrinker_nr_max, BITS_PER_LONG) * sizeof(unsigned long);
> >       for_each_node(nid) {
> >               map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
> >               if (!map) {
> > @@ -269,7 +268,7 @@ static int memcg_expand_shrinker_maps(int new_id)
> >       struct mem_cgroup *memcg;
> >
> >       size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
> > -     old_size = memcg_shrinker_map_size;
> > +     old_size = DIV_ROUND_UP(shrinker_nr_max, BITS_PER_LONG) * sizeof(unsigned long);
> >       if (size <= old_size)
> >               return 0;
>
> These bunch of DIV_ROUND_UP() looks too complex. Since now all the shrinker maps allocation
> logic in the only file, can't we simplify this to look better? I mean something like below
> to merge in your patch:

Thanks for the suggestion. Will incorporate in v4.

>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b951c289ef3a..27b6371a1656 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -247,7 +247,7 @@ int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
>                 return 0;
>
>         down_read(&shrinker_rwsem);
> -       size = DIV_ROUND_UP(shrinker_nr_max, BITS_PER_LONG) * sizeof(unsigned long);
> +       size = shrinker_nr_max / BITS_PER_BYTE;
>         for_each_node(nid) {
>                 map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
>                 if (!map) {
> @@ -264,13 +264,11 @@ int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
>
>  static int memcg_expand_shrinker_maps(int new_id)
>  {
> -       int size, old_size, ret = 0;
> +       int size, old_size, new_nr_max, ret = 0;
>         struct mem_cgroup *memcg;
>
>         size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
> -       old_size = DIV_ROUND_UP(shrinker_nr_max, BITS_PER_LONG) * sizeof(unsigned long);
> -       if (size <= old_size)
> -               return 0;

BTW, it seems the above chunk needs to be kept.

> +       new_nr_max = size * BITS_PER_BYTE;
>
>         if (!root_mem_cgroup)
>                 goto out;
> @@ -287,6 +285,9 @@ static int memcg_expand_shrinker_maps(int new_id)
>         } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
>
>  out:
> +       if (ret == 0)
> +               shrinker_nr_max = new_nr_max;
> +
>         return ret;
>  }
>
> @@ -334,8 +335,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>                         idr_remove(&shrinker_idr, id);
>                         goto unlock;
>                 }
> -
> -               shrinker_nr_max = id + 1;
>         }
>         shrinker->id = id;
>         ret = 0;
>
