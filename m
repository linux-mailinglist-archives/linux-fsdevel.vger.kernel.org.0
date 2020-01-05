Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9902130576
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 02:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgAEBns (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jan 2020 20:43:48 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36216 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgAEBns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jan 2020 20:43:48 -0500
Received: by mail-io1-f68.google.com with SMTP id d15so1585195iog.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jan 2020 17:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SL0fis6brZ3oO414fpFkpbvgRXsOX5vhOghpLIXzWW0=;
        b=t5z4QxS76s18OC+Bhc4iEb2ZGiI5dCXCngCtWyeGgESTvRHBVRSoeA90H8wpnHS3lA
         SzdutXy7bsgr85t9opXQYi+Nbs+yLq7IyDtf6N4YyjAYsiYCgMmkOx0Jv/WYcrzZXOIc
         1sDv4jcZTQSyZbiKh52D3h4g1dozrMKfMfIRr6iyk38gsN+7jMuxTa+G2eoLr11wzutq
         BtBmU8TOsW9Qx1QnyrkJN9zlMnYokO9vLVbq78SBZcZHczD1Iq6iqCYHzN1dU9yyKP6V
         n+wMYn5eAjlruPbh8JBdTdfBOYR7nC3TH5g43+ba4s3zyYXnZWPrxsBMn32hJ+2lEEWw
         ONGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SL0fis6brZ3oO414fpFkpbvgRXsOX5vhOghpLIXzWW0=;
        b=LQ3dSrEIQdBKg775t7E9SbKXsk6bko9p9LxL1/tnVNYLBuGlUaHLMlxly3CrpFH4Yl
         2fiF+Nhs3KIlNhEcGNSmiM1tAqUnvY+ivFoeQWbdUPMx4ELZyg7Aeq4isCbQq3XENn4C
         hJSebruYQBmzztonjVjr4XZ7qEe2N2/DHtlCa//c9QB9/kBwzTfOXftlw8v2CsTN+VaF
         pQ04iMmNvwCJyx/LowU9hTZRABoK0KGfOX0h4KAnfIg0jRZVq5/1GJGSl8+2xwyGo2KK
         e+O4tyaYpnAj+/gONJMqatrMqW0STpy3aJalWvJQmx1rF1QOsKJ4eU2T/PwuYVK6J9v6
         44yg==
X-Gm-Message-State: APjAAAUkvsZZzXL8lsyYMiRRk+jndKTZUl2z5Eewb87to74li26L3mok
        a2lLfY7FRs4Ke3KR4UuiP1QSfaFKEfQUCfuzjhM=
X-Google-Smtp-Source: APXvYqyEivy4+kX/DetgiHqBnFMXCW75VVIp5Mem8Dy/CZ5QGxj8bBUD4QqfA/VWfiRpNPzB1/5ESq/BKj/4/83zLpA=
X-Received: by 2002:a5d:980f:: with SMTP id a15mr24449396iol.203.1578188627604;
 Sat, 04 Jan 2020 17:43:47 -0800 (PST)
MIME-Version: 1.0
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
 <1577174006-13025-5-git-send-email-laoar.shao@gmail.com> <20200104033558.GD23195@dread.disaster.area>
 <CALOAHbAzDth8g8+Z5hH9QnOp02UZ5+3eQf9wAQyJM-LAhmaL9A@mail.gmail.com> <20200104212331.GG23195@dread.disaster.area>
In-Reply-To: <20200104212331.GG23195@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 5 Jan 2020 09:43:11 +0800
Message-ID: <CALOAHbBGRSfRTH7RYXfgAqtixuYvu=tRrr7zQyAvofrzktW=vA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: make memcg visible to lru walker isolation function
To:     Dave Chinner <david@fromorbit.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 5, 2020 at 5:23 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Sat, Jan 04, 2020 at 03:26:13PM +0800, Yafang Shao wrote:
> > On Sat, Jan 4, 2020 at 11:36 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Tue, Dec 24, 2019 at 02:53:25AM -0500, Yafang Shao wrote:
> > > > The lru walker isolation function may use this memcg to do something, e.g.
> > > > the inode isolatation function will use the memcg to do inode protection in
> > > > followup patch. So make memcg visible to the lru walker isolation function.
> > > >
> > > > Something should be emphasized in this patch is it replaces
> > > > for_each_memcg_cache_index() with for_each_mem_cgroup() in
> > > > list_lru_walk_node(). Because there's a gap between these two MACROs that
> > > > for_each_mem_cgroup() depends on CONFIG_MEMCG while the other one depends
> > > > on CONFIG_MEMCG_KMEM. But as list_lru_memcg_aware() returns false if
> > > > CONFIG_MEMCG_KMEM is not configured, it is safe to this replacement.
> > > >
> > > > Cc: Dave Chinner <dchinner@redhat.com>
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > >
> > > ....
> > >
> > > > @@ -299,17 +299,15 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
> > > >                                list_lru_walk_cb isolate, void *cb_arg,
> > > >                                unsigned long *nr_to_walk)
> > > >  {
> > > > +     struct mem_cgroup *memcg;
> > > >       long isolated = 0;
> > > > -     int memcg_idx;
> > > >
> > > > -     isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
> > > > -                                   nr_to_walk);
> > > > -     if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
> > > > -             for_each_memcg_cache_index(memcg_idx) {
> > > > +     if (list_lru_memcg_aware(lru)) {
> > > > +             for_each_mem_cgroup(memcg) {
> > > >                       struct list_lru_node *nlru = &lru->node[nid];
> > > >
> > > >                       spin_lock(&nlru->lock);
> > > > -                     isolated += __list_lru_walk_one(nlru, memcg_idx,
> > > > +                     isolated += __list_lru_walk_one(nlru, memcg,
> > > >                                                       isolate, cb_arg,
> > > >                                                       nr_to_walk);
> > > >                       spin_unlock(&nlru->lock);
> > > > @@ -317,7 +315,11 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
> > > >                       if (*nr_to_walk <= 0)
> > > >                               break;
> > > >               }
> > > > +     } else {
> > > > +             isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
> > > > +                                           nr_to_walk);
> > > >       }
> > > > +
> > >
> > > That's a change of behaviour. The old code always runs per-node
> > > reclaim, then if the LRU is memcg aware it also runs the memcg
> > > aware reclaim. The new code never runs global per-node reclaim
> > > if the list is memcg aware, so shrinkers that are initialised
> > > with the flags SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE seem
> > > likely to have reclaim problems with mixed memcg/global memory
> > > pressure scenarios.
> > >
> > > e.g. if all the memory is in the per-node lists, and the memcg needs
> > > to reclaim memory because of a global shortage, it is now unable to
> > > reclaim global memory.....
> > >
> >
> > Hi Dave,
> >
> > Thanks for your detailed explanation.
> > But I have different understanding.
> > The difference between for_each_mem_cgroup(memcg) and
> > for_each_memcg_cache_index(memcg_idx) is that the
> > for_each_mem_cgroup() includes the root_mem_cgroup while the
> > for_each_memcg_cache_index() excludes the root_mem_cgroup because the
> > memcg_idx of it is -1.
>
> Except that the "root" memcg that for_each_mem_cgroup() is not the
> "global root" memcg - it is whatever memcg that is passed down in
> the shrink_control, whereever that sits in the cgroup tree heirarchy.
> do_shrink_slab() only ever passes down the global root memcg to the
> shrinkers when the global root memcg is passed to shrink_slab(), and
> that does not iterate the memcg heirarchy - it just wants to
> reclaim from global caches an non-memcg aware shrinkers.
>
> IOWs, there are multiple changes in behaviour here - memcg specific
> reclaim won't do global reclaim, and global reclaim will now iterate
> all memcgs instead of just the global root memcg.
>
> > So it can reclaim global memory even if the list is memcg aware.
> > Is that right ?
>
> If the memcg passed to this fucntion is the root memcg, then yes,
> it will behave as you suggest. But for the majority of memcg-context
> reclaim, the memcg is not the root memcg and so they will not do
> global reclaim anymore...
>

Thanks for you reply.
But I have to clairfy that this change is in list_lru_walk_node(), and
the memcg is not passed to this funtion from shrink_control.
In order to make it more clear, I paste the function here.

- The new function
unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
                                 list_lru_walk_cb isolate, void *cb_arg,
                                 unsigned long *nr_to_walk)
{
        struct mem_cgroup *memcg;   <<<< A local variable
        long isolated = 0;

        if (list_lru_memcg_aware(lru)) {
                for_each_mem_cgroup(memcg) {  <<<<  scan all MEMCGs,
including root_mem_cgroup
                        struct list_lru_node *nlru = &lru->node[nid];

                        spin_lock(&nlru->lock);
                        isolated += __list_lru_walk_one(nlru, memcg,
                                                        isolate, cb_arg,
                                                        nr_to_walk);
                        spin_unlock(&nlru->lock);

                        if (*nr_to_walk <= 0)
                                break;
                }
        } else {
<<<<  scan global memory only (root_mem_cgroup)
                isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
                                              nr_to_walk);
        }

        return isolated;
}

- While the original function is,

unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
                                 list_lru_walk_cb isolate, void *cb_arg,
                                 unsigned long *nr_to_walk)
{
        long isolated = 0;
        int memcg_idx;

        isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
                                      nr_to_walk);
            <<<<  scan global memory only (root_mem_cgroup)
        if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
                for_each_memcg_cache_index(memcg_idx) {   <<<< scan
all MEMCGs excludes root_mem_cgroup
                        struct list_lru_node *nlru = &lru->node[nid];

                        spin_lock(&nlru->lock);
                        isolated += __list_lru_walk_one(nlru, memcg_idx,
                                                        isolate, cb_arg,
                                                        nr_to_walk);
                        spin_unlock(&nlru->lock);

                        if (*nr_to_walk <= 0)
                                break;
                }
        }

        return isolated;
}

Is that right ?

Thanks
Yafang
