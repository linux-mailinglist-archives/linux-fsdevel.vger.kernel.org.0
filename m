Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0681813014E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2020 08:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgADH0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jan 2020 02:26:51 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:33669 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgADH0u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jan 2020 02:26:50 -0500
Received: by mail-il1-f196.google.com with SMTP id v15so38478012iln.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jan 2020 23:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4USNzvDLp/jyy/kPx70cSKAWD4PRDCrYfn94EJlOaio=;
        b=JS2Hu8eFeQjooDGgpOE3mupsoTlqoEgC/pzbymKFSBrdxuTe8XQpaeZ9dV1q1bm959
         yqwfjj6NvnAI5H7f/1cSICaLM6kNI3nn3X7PkmRsULXF/MahGSsyY66+0cmRhDsjcZqM
         j0HwW4DO/HPUPGW5XE9AiU6iJ+wDxadef2SWdfHTqaofJ1bJv5FwgFuqhcz9/bf5dcUV
         pyO+BuxIu+q4hQBd4fh9/54Qaz4INhahpautM+eB0kiV6m+u/aJM2BO9+Fqwi1eGIs/J
         xg0pI2+8E8Eulyf7a6TxfifiHsXPuAttgjOFYzDUMBbH/JdDMz8x/lCfKxLx+RA9kVHt
         3KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4USNzvDLp/jyy/kPx70cSKAWD4PRDCrYfn94EJlOaio=;
        b=GOC9LoTgaLgtwRkDCNnyRnkAWC9niM136z7vw/PzWEf0zGejFpzwua2KC5VK5cdG/y
         Rcy7zf1aj/cClaYprSQk8wtjGuNi6DPbS9i/VqEltPCyiTM6gFqAEae+qwJyQKsoQppC
         dsUVXZsUweRLCuPYXq6UiYRAeCWvQDyQl2cGQnHExvXxjWCFrb370OSOHnNE6MJ8vGt1
         PjLvWxS46Gu34E6KvuNltf3U+M9YdeVbAgIIidB+1faYQ1ZExNwI+e2J2HplobLkJVYl
         edvTp66361HAUewRcsS4R2pRiorU/T0D4M7h0BbTVglalc1kFEF7kUC12nT4vaOXmFXu
         V/Jg==
X-Gm-Message-State: APjAAAWudryZu9yXPNjNUofjgzbNPZcDzpwV6d9pmOdVeuLEE8OQmPRY
        sTbM56qArqj03GTjGPDLtOeUQhbh+6gcYMEawz4=
X-Google-Smtp-Source: APXvYqyhUdzkt1LEV3/mnjboJOnzFbBNyxAIqFqasq6eUlGxIHSns3eIUOhEp8lzDyPFPxc5FWwv01ZoSr8eB8W+Ir8=
X-Received: by 2002:a92:3a07:: with SMTP id h7mr81250759ila.203.1578122810054;
 Fri, 03 Jan 2020 23:26:50 -0800 (PST)
MIME-Version: 1.0
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
 <1577174006-13025-5-git-send-email-laoar.shao@gmail.com> <20200104033558.GD23195@dread.disaster.area>
In-Reply-To: <20200104033558.GD23195@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 4 Jan 2020 15:26:13 +0800
Message-ID: <CALOAHbAzDth8g8+Z5hH9QnOp02UZ5+3eQf9wAQyJM-LAhmaL9A@mail.gmail.com>
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

On Sat, Jan 4, 2020 at 11:36 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Dec 24, 2019 at 02:53:25AM -0500, Yafang Shao wrote:
> > The lru walker isolation function may use this memcg to do something, e.g.
> > the inode isolatation function will use the memcg to do inode protection in
> > followup patch. So make memcg visible to the lru walker isolation function.
> >
> > Something should be emphasized in this patch is it replaces
> > for_each_memcg_cache_index() with for_each_mem_cgroup() in
> > list_lru_walk_node(). Because there's a gap between these two MACROs that
> > for_each_mem_cgroup() depends on CONFIG_MEMCG while the other one depends
> > on CONFIG_MEMCG_KMEM. But as list_lru_memcg_aware() returns false if
> > CONFIG_MEMCG_KMEM is not configured, it is safe to this replacement.
> >
> > Cc: Dave Chinner <dchinner@redhat.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> ....
>
> > @@ -299,17 +299,15 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
> >                                list_lru_walk_cb isolate, void *cb_arg,
> >                                unsigned long *nr_to_walk)
> >  {
> > +     struct mem_cgroup *memcg;
> >       long isolated = 0;
> > -     int memcg_idx;
> >
> > -     isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
> > -                                   nr_to_walk);
> > -     if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
> > -             for_each_memcg_cache_index(memcg_idx) {
> > +     if (list_lru_memcg_aware(lru)) {
> > +             for_each_mem_cgroup(memcg) {
> >                       struct list_lru_node *nlru = &lru->node[nid];
> >
> >                       spin_lock(&nlru->lock);
> > -                     isolated += __list_lru_walk_one(nlru, memcg_idx,
> > +                     isolated += __list_lru_walk_one(nlru, memcg,
> >                                                       isolate, cb_arg,
> >                                                       nr_to_walk);
> >                       spin_unlock(&nlru->lock);
> > @@ -317,7 +315,11 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
> >                       if (*nr_to_walk <= 0)
> >                               break;
> >               }
> > +     } else {
> > +             isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
> > +                                           nr_to_walk);
> >       }
> > +
>
> That's a change of behaviour. The old code always runs per-node
> reclaim, then if the LRU is memcg aware it also runs the memcg
> aware reclaim. The new code never runs global per-node reclaim
> if the list is memcg aware, so shrinkers that are initialised
> with the flags SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE seem
> likely to have reclaim problems with mixed memcg/global memory
> pressure scenarios.
>
> e.g. if all the memory is in the per-node lists, and the memcg needs
> to reclaim memory because of a global shortage, it is now unable to
> reclaim global memory.....
>

Hi Dave,

Thanks for your detailed explanation.
But I have different understanding.
The difference between for_each_mem_cgroup(memcg) and
for_each_memcg_cache_index(memcg_idx) is that the
for_each_mem_cgroup() includes the root_mem_cgroup while the
for_each_memcg_cache_index() excludes the root_mem_cgroup because the
memcg_idx of it is -1.
So it can reclaim global memory even if the list is memcg aware.
Is that right ?

Thanks
Yafang
