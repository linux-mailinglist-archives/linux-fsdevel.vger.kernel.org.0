Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BFE2F554C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 00:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbhAMXu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 18:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729555AbhAMXtV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 18:49:21 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB28C061575;
        Wed, 13 Jan 2021 15:48:40 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id 6so5615684ejz.5;
        Wed, 13 Jan 2021 15:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxBGvawjchkt3PkBeFPglNIYbXfNwIwM3XGy8lG49Os=;
        b=AfdoteZDe3xUjLlIDNDLWd9Uf3cGhaAjkvrrCqckV1VoC8npQcL2xFuorx8afbtim+
         SQuh4mC0lT44zU8JH6P+bDEl2pf6kvZoOKWYiQp9cA96lI0DgtLS12IVYGgL+rC5wkm8
         cS8F+nZfJQaE5TfdqhW0AotCJEVT27up6WF3tSAHmbn/UeDkVkFUOo2z2+iywe5zJYbe
         RVq7VRqszIGny+V3aVIG6wQKR0WnXGFttX8jNrL9IilvGENapTjbcX036MAkr4rZPmuZ
         T8rKrx5rlF/F9g0rY1u5AtDyz4NvTeFJr8KMhHh9EqpMYW8uI1F86HNkCiVHK36hKaGQ
         JQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxBGvawjchkt3PkBeFPglNIYbXfNwIwM3XGy8lG49Os=;
        b=ql+Ff0mpC5YnSL+pKyp/qQM42i21dE09CaWDMoGAPE95D7528AbEtFRxb2IzegavZM
         3hDIW6O7pQ3sKB3V0IWLRIubhlBsUpLGZkT2IXmKVWzq6mI61+Rye+fI/yjcWVl+0WOM
         XemZd167KREEaUKgUQEGxOv/2JbynYKXSxO9tQGWE+sBao4FktwIf1bk2ykbP8kOqLWl
         kCU4NY16+U+ABQWuGsQDKpDcv2bnKbDMczK7AVwkuxVOi42GBACCp523cO+oYCFA0KJY
         lrccQpPlN13nzddHCLTFl2C99WmtWrSe10JLNO7fCgNdObBUf13VOD6+uP9LarXrsPU4
         cJGQ==
X-Gm-Message-State: AOAM533/eTFO10Jq38w+hnQpeMrhx84vYoQq03ACdCtT7r5JxtNL5VMi
        hP6D5wG9AD7psZpD9Oi2qZWw5jOlhZC/nuduTu+lDSXCvYy4/w==
X-Google-Smtp-Source: ABdhPJzo5LMkPw9QOaRIWmHNxXmPhpnoc1H63/T35dxn5b2PlL41yBvCJpVtev2FCnnftyWiGi3AmQuhX6au8I8gl+4=
X-Received: by 2002:a17:906:1a4e:: with SMTP id j14mr3231194ejf.507.1610581719097;
 Wed, 13 Jan 2021 15:48:39 -0800 (PST)
MIME-Version: 1.0
References: <20210105225817.1036378-1-shy828301@gmail.com> <20210105225817.1036378-5-shy828301@gmail.com>
 <955422c5-0703-e9fb-f309-6ed6b5fc0e0a@virtuozzo.com>
In-Reply-To: <955422c5-0703-e9fb-f309-6ed6b5fc0e0a@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 13 Jan 2021 15:48:27 -0800
Message-ID: <CAHbLzkqo=bHcrLBPd68teEAtfLcOsZZ+e3Eds9EfGakhDbW8zA@mail.gmail.com>
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

The type of shrinker_maps->map is "unsigned long *", I think we should
do "(shrinker_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long)".

And the "/ BITS_PER_BYTE" makes calculating the pointer of nr_deferred
array harder in the following patch since the length of the map array
may be not multiple of "unsigned long". Without the nr_deferred array,
this change seems fine.

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
