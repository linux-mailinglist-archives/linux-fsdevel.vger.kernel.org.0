Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3624412B016
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 02:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfL0BEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 20:04:04 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43320 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfL0BEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 20:04:04 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so22972026ioo.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2019 17:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sm197CHJjHN6LEdkX01bTusjZhcWBh9t5ofpInbcGek=;
        b=Li1O3yUJ/WcaGdAIwYXi16c4e/l8vbUkYPvw1M2FhtVw62AqlWsfQHJLMldXls9Jkd
         f14Yj1PfgLvDtf4oo4Cf/ahir7zoZRJfAwiLbqIqfiUEMS2qof+x8PSBLLjE0SWRVV24
         Ox6E0YZKXs26bMhGbHKOK/TuRzolfdGloR7mXPJPbT1s1WcDkQDghKl5R6J6AY89LoLb
         KYHBzgUbLhSzGutsGyuc8PNLZMlcqZ6Qr1cTX+9J/1MlRcFHyN9Q5iWjIBeUfkUaMCFl
         /DZZsYi1rWBj5r45c+Pmt+30c2wpXjdVpB8J2AGJz2Fex8krJNCqwnj26lD3MU1Wta3V
         G/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sm197CHJjHN6LEdkX01bTusjZhcWBh9t5ofpInbcGek=;
        b=S3/q4a1vtEVsRtMpF6tZl8WNVv0avhRM0cPrDtwOuA0ZZDhmhFmFV9brLdDvx71DcL
         QzTKcQ1U9Sm9m646Tj0l/g6P8XKDyKycKzxuv6ujP0TnqyKhMWtAXk6eVDAkICNGRaEp
         jlDWPbWMOQEk8/DHpv4hLoPQVCG+hKPZLQ8aruiz1FoSAff4ASZ75iFPJZamfHbuG36K
         5zAB3u3+7ABdSdYGvEfVBVBM3TRrWnnVcUR9yAR2AmRwXNhijWXYLR8EbXQNKLQvKDsM
         CQUQceULWmOUX5U6D3sGUKR6tkZcRfXwv0PJ3y7SOUwtjlb18yPY2dINIbWTscYM5iCn
         y/7Q==
X-Gm-Message-State: APjAAAWnITLrAZVftd0URk+64GETg9DvzDt42P6qdvj3UXcf4UBwBaYW
        Nte/Bnk+6ccL9N08rYI8SmjbtUOJ2Sk9NfMFfUU=
X-Google-Smtp-Source: APXvYqyTYz+FFa8wQ1NLm83a6cU06qGs79Dhp75qEi35sGCZAl4l9Sq0dk8QvvzZpl/XEGpM80GyOCJE8jlHgiBMqbk=
X-Received: by 2002:a02:856a:: with SMTP id g97mr38412724jai.97.1577408643244;
 Thu, 26 Dec 2019 17:04:03 -0800 (PST)
MIME-Version: 1.0
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
 <1577174006-13025-2-git-send-email-laoar.shao@gmail.com> <20191226212320.GA22734@tower.dhcp.thefacebook.com>
In-Reply-To: <20191226212320.GA22734@tower.dhcp.thefacebook.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 27 Dec 2019 09:03:27 +0800
Message-ID: <CALOAHbCQ=9dpKBjfbWv8hyU_D4Xiv5oDHFE4Ofuv57a6boo+iA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mm, memcg: reduce size of struct mem_cgroup by
 using bit field
To:     Roman Gushchin <guro@fb.com>
Cc:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 27, 2019 at 5:23 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Dec 24, 2019 at 02:53:22AM -0500, Yafang Shao wrote:
> > There are some members in struct mem_group can be either 0(false) or
> > 1(true), so we can define them using bit field to reduce size. With this
> > patch, the size of struct mem_cgroup can be reduced by 64 bytes in theory,
> > but as there're some MEMCG_PADDING()s, the real number may be different,
> > which is relate with the cacheline size. Anyway, this patch could reduce
> > the size of struct mem_cgroup more or less.
>
> It seems it's not really related to the rest of the patchset, isn't it?
>

Right.

> Can you, please, post it separately?
>

Sure. Will post it separately.

> Also, I'd move the tcp-related stuff up, so that all oom-related fields
> would be together.

OK. Thanks for your comment.

> Otherwise lgtm.
>
> Thanks!
>
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/linux/memcontrol.h | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index a7a0a1a5..612a457 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -229,20 +229,26 @@ struct mem_cgroup {
> >       /*
> >        * Should the accounting and control be hierarchical, per subtree?
> >        */
> > -     bool use_hierarchy;
> > +     unsigned int use_hierarchy : 1;
> >
> >       /*
> >        * Should the OOM killer kill all belonging tasks, had it kill one?
> >        */
> > -     bool oom_group;
> > +     unsigned int  oom_group : 1;
> >
> >       /* protected by memcg_oom_lock */
> > -     bool            oom_lock;
> > -     int             under_oom;
> > +     unsigned int oom_lock : 1;
> >
> > -     int     swappiness;
> >       /* OOM-Killer disable */
> > -     int             oom_kill_disable;
> > +     unsigned int oom_kill_disable : 1;
> > +
> > +     /* Legacy tcp memory accounting */
> > +     unsigned int tcpmem_active : 1;
> > +     unsigned int tcpmem_pressure : 1;
> > +
> > +     int under_oom;
> > +
> > +     int     swappiness;
> >
> >       /* memory.events and memory.events.local */
> >       struct cgroup_file events_file;
> > @@ -297,9 +303,6 @@ struct mem_cgroup {
> >
> >       unsigned long           socket_pressure;
> >
> > -     /* Legacy tcp memory accounting */
> > -     bool                    tcpmem_active;
> > -     int                     tcpmem_pressure;
> >
> >  #ifdef CONFIG_MEMCG_KMEM
> >          /* Index in the kmem_cache->memcg_params.memcg_caches array */
> > --
> > 1.8.3.1
> >
> >
