Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7364758E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Dec 2021 13:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242539AbhLOMfX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Dec 2021 07:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbhLOMfV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:35:21 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B502DC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Dec 2021 04:35:21 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id g17so54627190ybe.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Dec 2021 04:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/PPAsdJy1fvI4IOk7fwhrZPqTZxBHd9OaF3oRGCQhSE=;
        b=W044lgVz7oRByJHiznLwmwuOhHSsIr9WupRS5mvk2WZ9VbtiG5EK3x8N6zldAG079F
         SkUvnhF2zswp6UvcJZEDGkw5ZzrBd8tPuevXvcjR8WZGRP0Vek4u6zRY/B78EnA/w9fl
         vaUDkKJ3IED9TBzE4j+Cm1JI8UHqEUKxfDIc11VzejXBcZlmwf28OLn3zljG5QT29JUq
         c5l/9c8WEz+Btspj0KgGAln22fEFaBV3WhjcDEHAb98qIlJyFPxSoawx5vWbhvY98CLr
         tM3/p0ZROCe+YBgg4vEAL5AmEH0kV4Rr94PT63I9CBl/M4IuUeWl+ZrdpNS4QyK/0/6V
         B0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/PPAsdJy1fvI4IOk7fwhrZPqTZxBHd9OaF3oRGCQhSE=;
        b=02pbStpdQKe2clraHauKyx1wCIGDEwFHDCjRn+eo8bnvE8apIKJ7cGBgWuNG1Y8O3P
         ivs9+ZRCvDiG8q6wR3NwgGneIBXg+7BsJ4EtKvkuUoFkj1rL7j+cSQTPg/9Xvu0D2gsI
         SXshsH7x2m7Jp4r/6jVmequI0MNEi1bu54Vihj3UPIQPXykHlc7oy0IYeBlIMVjA45qT
         y6BAiXnsrhx+Ohri7z5715MXfTTUbRHlGhSoG3wKrIVhgK4rOvEMikO4uLiResl2drZm
         v6X/499kCSAq1NTECO2UlvABvedVhh/ftxZ72M3kjrwqjBk8uPyvwGMyreBXUkHjFDFY
         q7Jg==
X-Gm-Message-State: AOAM532TzI6W72fom8w5woEFxNBM3UZPDMYHInKXAmZNI0dREvEuRDVK
        brFv7WheQ6eafuKZLHLlzklFp220evy5cEvKFqYjMg==
X-Google-Smtp-Source: ABdhPJyxflIhvpUmrJZ5mUXlnXimvj20RtQWT1adLFErhhGflKCG4cbZFFkiqSaQvpBKD6qVNrEcGYUKSk146eY/mL8=
X-Received: by 2002:a25:d157:: with SMTP id i84mr5541033ybg.703.1639571720913;
 Wed, 15 Dec 2021 04:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20211213165342.74704-1-songmuchun@bytedance.com>
 <20211213165342.74704-3-songmuchun@bytedance.com> <YbihOFJHqvQ9hsjO@cmpxchg.org>
In-Reply-To: <YbihOFJHqvQ9hsjO@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 15 Dec 2021 20:34:45 +0800
Message-ID: <CAMZfGtVTztinpOTCAAWW+0Q7SAcGfFW4PVW+bHnFQLN-nDBwSg@mail.gmail.com>
Subject: Re: [PATCH v4 02/17] mm: introduce kmem_cache_alloc_lru
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org,
        Kari Argillander <kari.argillander@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 14, 2021 at 9:50 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Dec 14, 2021 at 12:53:27AM +0800, Muchun Song wrote:
> > +/*
> > + * The allocated list lru pointers array is not accounted directly.
> > + * Moreover, it should not come from DMA buffer and is not readily
> > + * reclaimable. So those GFP bits should be masked off.
> > + */
> > +#define LRUS_CLEAR_MASK      (__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT | __GFP_ZERO)
>
> There is already GFP_RECLAIM_MASK for this purpose, you can use that.

Cool. Thanks.

>
> > +int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
> > +                      gfp_t gfp)
> > +{
> > +     int i;
> > +     unsigned long flags;
> > +     struct list_lru_memcg *mlrus;
> > +     struct list_lru_memcg_table {
> > +             struct list_lru_per_memcg *mlru;
> > +             struct mem_cgroup *memcg;
> > +     } *table;
> > +
> > +     if (!list_lru_memcg_aware(lru) || memcg_list_lru_allocated(memcg, lru))
> > +             return 0;
> > +
> > +     gfp &= ~LRUS_CLEAR_MASK;
>
>         gfp &= GFP_RECLAIM_MASK;
