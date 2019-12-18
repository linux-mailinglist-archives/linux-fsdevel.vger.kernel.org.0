Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0C80123D26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 03:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfLRCeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 21:34:25 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:43936 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfLRCeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 21:34:25 -0500
Received: by mail-il1-f195.google.com with SMTP id v69so343714ili.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 18:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQnxUgnPs5XIy6wqoYk0lFfMX967lDJfnU21RxvBckA=;
        b=k186DmuaofohJF7sA2JaDqoAoEoV0LknoS1gvsgg5HlMX26R0W46/SzFpUIqDARcwR
         00LGuKYdC/Ah2l3m0FR74FLbLClrUzr6U8RYQtkA/0LD6Dgn/egZaW+oTa+SHdQUfwJd
         iL2ln/3IZ4wbuHmxIOKiQ5aXlfD9dijmb3wY/DigOIQqRHgyNcHP4qBM47VT/mOwquP7
         VLtcQ7v8wwfy8rRzfBNcW+uzUuUkn4/vvU1u8UoPYxfIBTfDREXtbiOY9wTjFOnrvK+x
         HqEOa3iBtKa1jUoL9Xdjh2kkCOg9BpjCmtq0cUSBLholVaawuOUpfkNm23f0VMqusdRt
         zCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQnxUgnPs5XIy6wqoYk0lFfMX967lDJfnU21RxvBckA=;
        b=lnXiP3cQHivcuuFGMI2w2Fia9ZeY4uaM1UsUwKjgBbLLEuVW/srH7nGebgs34K2vcw
         +7YRP5cF0xLTywf4d79mmjuKZlowY/zh3NBrV8ZvgtrR51AzPpWNOFGqFUmwblWf5Mpe
         o6yT3Vkt68x+enAWi8LjidLVsTu6i6oZeLfntiNKzHgqiuSXYJEmZNMoASuOKClhwz7T
         TY0SetcQw0bUzjuXHh//3N8iHRYqKO2i8eP0kaBWM+YaczQSr/QT+TPJlOJ9jM+2vjp0
         vzEekV9H5Kj7+re6efztJ3l7t4asrizR1UkqybCOQGREBf/JFxpOSEpbwvH/9JChgM77
         f3xw==
X-Gm-Message-State: APjAAAVM8tfebJaRqU7CtPlGONhrU+4tufBlwDdlCuGuBWgsFi/5flHh
        kUCcNqJrgxD+SyTkhONmra2NvIxMM0TDsSvVYGo=
X-Google-Smtp-Source: APXvYqwsvCYyaOnogcb9qTavCG/3wnUELhgd4jAyUzdx2KEuXdrobreXrAdzYkKZtBgU05a5vSqnzcxIuWQzb5m2PMc=
X-Received: by 2002:a92:5c8a:: with SMTP id d10mr621616ilg.137.1576636464386;
 Tue, 17 Dec 2019 18:34:24 -0800 (PST)
MIME-Version: 1.0
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
 <1576582159-5198-5-git-send-email-laoar.shao@gmail.com> <20191218022122.GT19213@dread.disaster.area>
In-Reply-To: <20191218022122.GT19213@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 18 Dec 2019 10:33:48 +0800
Message-ID: <CALOAHbBQyWWn7XqhGZbhxbHUW-J+kVG2w1B8DB+HS61nCRYgRw@mail.gmail.com>
Subject: Re: [PATCH 4/4] memcg, inode: protect page cache from freeing inode
To:     Dave Chinner <david@fromorbit.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 10:21 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Dec 17, 2019 at 06:29:19AM -0500, Yafang Shao wrote:
> > On my server there're some running MEMCGs protected by memory.{min, low},
> > but I found the usage of these MEMCGs abruptly became very small, which
> > were far less than the protect limit. It confused me and finally I
> > found that was because of inode stealing.
> > Once an inode is freed, all its belonging page caches will be dropped as
> > well, no matter how may page caches it has. So if we intend to protect the
> > page caches in a memcg, we must protect their host (the inode) first.
> > Otherwise the memcg protection can be easily bypassed with freeing inode,
> > especially if there're big files in this memcg.
> > The inherent mismatch between memcg and inode is a trouble. One inode can
> > be shared by different MEMCGs, but it is a very rare case. If an inode is
> > shared, its belonging page caches may be charged to different MEMCGs.
> > Currently there's no perfect solution to fix this kind of issue, but the
> > inode majority-writer ownership switching can help it more or less.
> >
> > Cc: Roman Gushchin <guro@fb.com>
> > Cc: Chris Down <chris@chrisdown.name>
> > Cc: Dave Chinner <dchinner@redhat.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  fs/inode.c                 |  9 +++++++++
> >  include/linux/memcontrol.h | 15 +++++++++++++++
> >  mm/memcontrol.c            | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >  mm/vmscan.c                |  4 ++++
> >  4 files changed, 74 insertions(+)
> >
> > diff --git a/fs/inode.c b/fs/inode.c
> > index fef457a..b022447 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -734,6 +734,15 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
> >       if (!spin_trylock(&inode->i_lock))
> >               return LRU_SKIP;
> >
> > +
> > +     /* Page protection only works in reclaimer */
> > +     if (inode->i_data.nrpages && current->reclaim_state) {
> > +             if (mem_cgroup_inode_protected(inode)) {
> > +                     spin_unlock(&inode->i_lock);
> > +                     return LRU_ROTATE;
>
> Urk, so after having plumbed the memcg all the way down to the
> list_lru walk code so that we only walk inodes in that memcg, we now
> have to do a lookup from the inode back to the owner memcg to
> determine if we should reclaim it? IOWs, I think the layering here
> is all wrong - if memcg info is needed in the shrinker, it should
> come from the shrink_control->memcg pointer, not be looked up from
> the object being isolated...
>

Agree with you that the layering here is not good.
I had tried to use shrink_control->memcg pointer as an argument or
something else,  but I found that will change lots of code.
I don't want to change too much code, so I implement it this way,
although it looks a litte strange.

> i.e. this code should read something like this:
>
>         if (memcg && inode->i_data.nrpages &&
>             (!memcg_can_reclaim_inode(memcg, inode)) {
>                 spin_unlock(&inode->i_lock);
>                 return LRU_ROTATE;
>         }
>
> This code does not need comments because it is obvious what it does,
> and it provides a generic hook into inode reclaim for the memcg code
> to decide whether the shrinker should reclaim the inode or not.
>
> This is how the memcg code should interact with other shrinkers, too
> (e.g. the dentry cache isolation function), so you need to look at
> how to make the memcg visible to the lru walker isolation
> functions....
>

Thanks for your suggestion.
I will rethink it torwards this way.

Thanks
Yafang
