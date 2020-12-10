Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4472D661B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 20:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393265AbgLJTOh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 14:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393309AbgLJTNU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 14:13:20 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6727DC0617A6;
        Thu, 10 Dec 2020 11:12:35 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id w1so4247852ejf.11;
        Thu, 10 Dec 2020 11:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RTDvHTEKqVC+mjz0XehoDoae3BLNFHK2pu91mZg+aGw=;
        b=NjJLG16LJsoXr1mpyosfDeS73eAn/zxzt1vzc2n50zH88d2Py/RvO144+T+g9gWnjV
         S/YOhd5aRJs+E8zlkvImUxGjvHxlqc5OJ8vWCCDcCZFQ7HGtTO241PHIvSdNMpG4nKC6
         0ZVvi6XoIJD713uO1rpa5SXh0bX+cTA33BU7wnDRcbq7FNlZip0DNgl22FmgN1blScBW
         DKpraG1uMZD+Za2BhU4GExY6I9gEO8vwMavcFv7YlQZbnx/XGIV/in1IK4Hv5c6i4Dm3
         ZAdvY2P6+R4fiJqbzi5gI+SPdjT0ikgVJ5owRXIUsxRdsKRZBo/X9x8jD/kWq3jATgm1
         icCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTDvHTEKqVC+mjz0XehoDoae3BLNFHK2pu91mZg+aGw=;
        b=Dsw6o4p7L+Uj6KtO2ro7VFejtvIlQIcrJZBmd5CI6QAZTA2FgsteSg6zniJgtEbwqT
         gwsthr3sXiUDJ7tGycA9Qqna7eLfWYtka9tRz4RPOemVHynAti6YqYM0SdmgIgL72izx
         7QuQGKuAcjV2J7ed5uEPb2iRvoZHROCCRU2hXRxQKUIQmNqeQvOsppw6DCxw8XdJx17X
         G9pZwOza57FHx+vfaYRVAWd/lmJhiXr4qRV3QOsII99ROAiqAZ6gxU+E42W4kDzzCT9h
         B4OyLAlOEn+tRjk6rbzGqJuFzV85Cn9r/eUprpcH1r2oZcctZLGixs02vzYIWNDyRzNQ
         loSw==
X-Gm-Message-State: AOAM533e50AJjOP5peDE1l5w8/AlsDI0yMjnQ2v7moHSNFvFZeMhJfGj
        KjWil460643DxOjWIQauPEaHyOI4/CWSDBdpAL4=
X-Google-Smtp-Source: ABdhPJywr4rJuVSY3Z6ENZ+k0JTkQOilCOq4TnF75kgf6EqiLSKQAZ+GcDwt2qyuXOnj0ze1LzTkCJ/VA2ieytp9hXc=
X-Received: by 2002:a17:906:24c3:: with SMTP id f3mr7594468ejb.238.1607627554147;
 Thu, 10 Dec 2020 11:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20201202182725.265020-1-shy828301@gmail.com> <20201202182725.265020-6-shy828301@gmail.com>
 <20201210153356.GE264602@cmpxchg.org>
In-Reply-To: <20201210153356.GE264602@cmpxchg.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 10 Dec 2020 11:12:22 -0800
Message-ID: <CAHbLzkoSSQ_4aY1cNmJGZyL+r6yO3L41KWHi8ZQnDhFTNi-v_Q@mail.gmail.com>
Subject: Re: [PATCH 5/9] mm: memcontrol: add per memcg shrinker nr_deferred
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 7:36 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Dec 02, 2020 at 10:27:21AM -0800, Yang Shi wrote:
> > @@ -504,6 +577,34 @@ int memcg_expand_shrinker_maps(int new_id)
> >       return ret;
> >  }
> >
> > +int memcg_expand_shrinker_deferred(int new_id)
> > +{
> > +     int size, old_size, ret = 0;
> > +     struct mem_cgroup *memcg;
> > +
> > +     size = (new_id + 1) * sizeof(atomic_long_t);
> > +     old_size = memcg_shrinker_deferred_size;
> > +     if (size <= old_size)
> > +             return 0;
> > +
> > +     mutex_lock(&memcg_shrinker_mutex);
>
> The locking is somewhat confusing. I was wondering why we first read
> memcg_shrinker_deferred_size "locklessly", then change it while
> holding the &memcg_shrinker_mutex.
>
> memcg_shrinker_deferred_size only changes under shrinker_rwsem(write),
> correct? This should be documented in a comment, IMO.

Yes, it is correct.

>
> memcg_shrinker_mutex looks superfluous then. The memcg allocation path
> is the read-side of memcg_shrinker_deferred_size, and so simply needs
> to take shrinker_rwsem(read) to lock out shrinker (de)registration.

I see you point. Yes, it seems shrinker_{maps|deferred} allocation
could be synchronized with shrinker registration by shrinker_rwsem.

memcg_shrinker_mutex is just renamed from memcg_shrinker_map_mutex
which was introduced by shrinker_maps patchset. I'm not quite sure why
this mutex was introduced at the first place, I guess the main purpose
is to *not* exacerbate the contention of shrinker_rwsem?

If that contention is not a concern, we could remove that dedicated mutex.

>
> Also, isn't memcg_shrinker_deferred_size just shrinker_nr_max? And

No, it is variable. It is nr * sizeof(atomit_long_t). The nr is the
current last shrinker ID. If a new shrinker is registered, the nr may
grow.

> memcg_expand_shrinker_deferred() is only called when size >= old_size
> in the first place (because id >= shrinker_nr_max)?

Yes.
