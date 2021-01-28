Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F1630805A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 22:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhA1VRu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 16:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhA1VRf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:17:35 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32FEC061574;
        Thu, 28 Jan 2021 13:16:54 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j13so8303806edp.2;
        Thu, 28 Jan 2021 13:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Bn/uZbi53prTbKMwEZWHXl6XCtApRQIRtzYnDibrEI=;
        b=M1Xs1mWrpvwVSmNxKUfVObBna2/o8jikxGlcqEeHhf0DSudNj8QY6OAX3C7uy2Dpx/
         1MZMRcZeq4VuYtZTJjUVrNOseOr8M/B75LrHOC+GhGpocyFVVJRDP7TdB09LgRzkIvZM
         By9mh5EVAdU0FegixQb+tT5mLFvocEcYinNP5sBPh25nKxAwSZvDdbzX5VoG0zMcTUK9
         LBYCgT62MIreVF/Ke+S7X1DhrrxB+SKiJ72osOSrGkg790v42NGClbocqMbpYCFWoARD
         VmgwKYP4Aq1VGBmw/tAhIGRAsE899bCnYJ8Kf3HdmPScPV4Dx3xBHBlJDVFL88vm1f28
         dxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Bn/uZbi53prTbKMwEZWHXl6XCtApRQIRtzYnDibrEI=;
        b=tQtq2v8PbdGVZdA1izCOrgNR56zs+NQaXV/pWkZZ/jYoMZk3z+bWeyHcTjlxmQ6oZ9
         9aODpY4LZCz6gzGXXhRRL5DK+2RnOoYa4KscTjFPTiAuebUJSZG1hxmAf4VIqpvNQ8hJ
         NADy7mc+54AYw9ewXCGkOlUAbSnIYepSzNg0eMKQ0FskV5csdTgME3rKPj4qaZTuiemR
         WcYnxiF+3ZFGsqEh+U/m6acnvl8TCsmDv+TO0aqNEZNaxYsjmWGEjnoqQetkuT06tQ/R
         WzRpRsNfA8ElccLYX4m9PrFyhwV9/infZ8GPnlkZB6tXD8NvrKPeLHqosbyJFI/DCKeR
         ESmg==
X-Gm-Message-State: AOAM5317/v+UITeXvTqt32ri0IisNzMm44zJFgc2hqauMgaKQtt090Fl
        gWBX9CXGkrlYwb0MPuK8nE8jtRHcFLEubGo9NFg=
X-Google-Smtp-Source: ABdhPJy9bs5zjsAcg8AJRyenRTcYrzHPwabscBl9E9PA/LMnOGH2QrK37cEXMePa86ZjH47zlOt/oZjVyiAUvhdIHHc=
X-Received: by 2002:a05:6402:312e:: with SMTP id dd14mr1780887edb.366.1611868613546;
 Thu, 28 Jan 2021 13:16:53 -0800 (PST)
MIME-Version: 1.0
References: <20210127233345.339910-1-shy828301@gmail.com> <20210127233345.339910-3-shy828301@gmail.com>
 <4b0a6d22-e29b-fb85-b05f-b9f9f62ca8ea@suse.cz>
In-Reply-To: <4b0a6d22-e29b-fb85-b05f-b9f9f62ca8ea@suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 28 Jan 2021 13:16:41 -0800
Message-ID: <CAHbLzkoW_vQNgfwrVRy4hXaJkqW+era885dFQZfZy-OHZOOZdg@mail.gmail.com>
Subject: Re: [v5 PATCH 02/11] mm: vmscan: consolidate shrinker_maps handling code
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
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

On Thu, Jan 28, 2021 at 8:10 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/28/21 12:33 AM, Yang Shi wrote:
> > The shrinker map management is not purely memcg specific, it is at the intersection
> > between memory cgroup and shrinkers.  It's allocation and assignment of a structure,
> > and the only memcg bit is the map is being stored in a memcg structure.  So move the
> > shrinker_maps handling code into vmscan.c for tighter integration with shrinker code,
> > and remove the "memcg_" prefix.  There is no functional change.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> Nits below:
>
> > @@ -1581,10 +1581,10 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
> >       return false;
> >  }
> >
> > -extern int memcg_expand_shrinker_maps(int new_id);
> > -
> > -extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
> > -                                int nid, int shrinker_id);
> > +extern int alloc_shrinker_maps(struct mem_cgroup *memcg);
> > +extern void free_shrinker_maps(struct mem_cgroup *memcg);
> > +extern void set_shrinker_bit(struct mem_cgroup *memcg,
> > +                          int nid, int shrinker_id);
>
> "extern" is unnecessary and people seem to be removing them nowadays when
> touching the code

OK, will fix in v6.

>
> >  /*
> >   * We allow subsystems to populate their shrinker-related
> >   * LRU lists before register_shrinker_prepared() is called
> > @@ -212,7 +338,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >               goto unlock;
> >
> >       if (id >= shrinker_nr_max) {
> > -             if (memcg_expand_shrinker_maps(id)) {
> > +             if (expand_shrinker_maps(id)) {
> >                       idr_remove(&shrinker_idr, id);
> >                       goto unlock;
> >               }
> > @@ -601,7 +727,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>
> Above this is a comment about barriers in memcg_set_shrinker_bit() that should
> be updated.

Thanks for catching this. Will fix in v6.

>
> >                       if (ret == SHRINK_EMPTY)
> >                               ret = 0;
> >                       else
> > -                             memcg_set_shrinker_bit(memcg, nid, i);
> > +                             set_shrinker_bit(memcg, nid, i);
> >               }
> >               freed += ret;
> >
> >
>
