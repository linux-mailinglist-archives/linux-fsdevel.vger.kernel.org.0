Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F49130155
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2020 08:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgADHm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jan 2020 02:42:59 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33570 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgADHm6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jan 2020 02:42:58 -0500
Received: by mail-il1-f193.google.com with SMTP id v15so38494096iln.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jan 2020 23:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xK2TwS3vjlYqWEy+Ej+jbLlmnwjqC9aYuD596Wg/PY=;
        b=tLCwOmn6AHp4rvwnAcgYcQKiDGi/yvapnrC4pUuTRIT+3nnWJMPfJk1alvRJwv1ujP
         Ip3sgd+4YTEKteZ+ltAysBks+gvSrdI+e+PSTHQxsIVS1E1CU8Kusl0wUCP9Bnh1jTEl
         5sAZOzVNrr/2nJFldQK06QqZxMo3gnL6oGh9Xy4XIaJPs7qu9vfz2yHWBhcwM3sk0rEY
         ywTmcPb3dTDprEbqTZYAistY/IqSiwLL2RCipb4KCymVSagGg1MoWf/D6RQQxB21nIec
         0JJiCMc8HPQVZBkSpSG3od+/zZe3EptEa+ife7ER57URb0LSvoBxcErX/N8yfiQn1JID
         z4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xK2TwS3vjlYqWEy+Ej+jbLlmnwjqC9aYuD596Wg/PY=;
        b=Q5ebfr9k4LFIX2Hu/dCciD/Ltk2gH3GT6KxCK36j2gNnlzITFIjogjErpFnS1j5OCI
         Qmi6HbiHFANW200/TytAq0bne1am9m66djkU3Fk6pywa26Bwd2a3xLsT4PigyLuZrney
         e5pwBJ+hJf2Os6ukUMKFVxXmAzSMALhMZ9oelfhh2YKu0pdbaIPl4hX0GoorVe00Cg4Y
         vM1ZftY+e8DbyrHDvn2zrtUKaYWmpCKZw9Hi23fGMbjzYntTPEr05QbGRsAv7A+zrKoU
         zxBxslKtk6+DvN7DOAs08swA3mq+d2isxqiJmA4TAsfeNynY2lZgXwnOxxgFCRa5YWRX
         tDKw==
X-Gm-Message-State: APjAAAV3Jqa5RZROU01ioZR0GpphbC2AaycuSNT+ePNq3HKWF9wILaGq
        0edTWOdGkNqQHwWtzUBDz5gNZ4vfQrxPr5+/h+0=
X-Google-Smtp-Source: APXvYqzKi8MQ5YQFfpxP4sN+3skA3gx1HmjQdiuz0oed0QkcJprpo72ljj4597r2g5r82WhH/w+Mida14eYGl/7Ex+4=
X-Received: by 2002:a92:da44:: with SMTP id p4mr83213217ilq.168.1578123778055;
 Fri, 03 Jan 2020 23:42:58 -0800 (PST)
MIME-Version: 1.0
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
 <1577174006-13025-6-git-send-email-laoar.shao@gmail.com> <20200104035501.GE23195@dread.disaster.area>
In-Reply-To: <20200104035501.GE23195@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 4 Jan 2020 15:42:21 +0800
Message-ID: <CALOAHbBrSdeQjn0eR1bkhh=orGyk1O+NQa9Qt4vHTAsByG4PGA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] memcg, inode: protect page cache from freeing inode
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

On Sat, Jan 4, 2020 at 11:55 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Dec 24, 2019 at 02:53:26AM -0500, Yafang Shao wrote:
> > On my server there're some running MEMCGs protected by memory.{min, low},
> > but I found the usage of these MEMCGs abruptly became very small, which
> > were far less than the protect limit. It confused me and finally I
> > found that was because of inode stealing.
> > Once an inode is freed, all its belonging page caches will be dropped as
> > well, no matter how may page caches it has. So if we intend to protect the
> > page caches in a memcg, we must protect their host (the inode) first.
> > Otherwise the memcg protection can be easily bypassed with freeing inode,
> > especially if there're big files in this memcg.
> >
> > Supposes we have a memcg, and the stat of this memcg is,
> >       memory.current = 1024M
> >       memory.min = 512M
> > And in this memcg there's a inode with 800M page caches.
> > Once this memcg is scanned by kswapd or other regular reclaimers,
> >     kswapd <<<< It can be either of the regular reclaimers.
> >         shrink_node_memcgs
> >           switch (mem_cgroup_protected()) <<<< Not protected
> >               case MEMCG_PROT_NONE:  <<<< Will scan this memcg
> >                       beak;
> >             shrink_lruvec() <<<< Reclaim the page caches
> >             shrink_slab()   <<<< It may free this inode and drop all its
> >                                  page caches(800M).
> > So we must protect the inode first if we want to protect page caches.
> >
> > The inherent mismatch between memcg and inode is a trouble. One inode can
> > be shared by different MEMCGs, but it is a very rare case. If an inode is
> > shared, its belonging page caches may be charged to different MEMCGs.
> > Currently there's no perfect solution to fix this kind of issue, but the
> > inode majority-writer ownership switching can help it more or less.
>
> There's multiple changes in this patch set. Yes, there's some inode
> cache futzing to deal with memcgs, but it also adds some weird
> undocumented "in low reclaim" heuristic that does something magical
> with "protection" that you don't describe or document at all. PLease
> separate that out into a new patch and document it clearly (both in
> the commit message and the code, please).
>

Sure, I will separate it and document it in next version.

> > diff --git a/fs/inode.c b/fs/inode.c
> > index fef457a..4f4b2f3 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -54,6 +54,13 @@
> >   *   inode_hash_lock
> >   */
> >
> > +struct inode_head {
>
> not an "inode head" structure. They are inode isolation arguments.
> i.e. struct inode_isolation_args {...};
>

Agree with you that inode_isolation_args is better.
While I have a different idea, what about using inode_isolation_control ?
scan_control : to scan all MEMCGs
        v
shrink_control: to shrink all slabs in one memcg
        v
inode_isolation_control: to shrink one slab (the inode)

And in the future we may introduce dentry_isolation_control and some others.
Anyway that's a minor issue.

> > +     struct list_head *freeable;
> > +#ifdef CONFIG_MEMCG_KMEM
> > +     struct mem_cgroup *memcg;
> > +#endif
> > +};
>
> These defines are awful, too, and completely unnecesarily because
> the struct shrink_control unconditionally defines sc->memcg and
> so we can just code it throughout without caring whether memcgs are
> enabled or not.
>

Sure, will change it in next version.

> > +
> >  static unsigned int i_hash_mask __read_mostly;
> >  static unsigned int i_hash_shift __read_mostly;
> >  static struct hlist_head *inode_hashtable __read_mostly;
> > @@ -724,8 +731,10 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
> >  static enum lru_status inode_lru_isolate(struct list_head *item,
> >               struct list_lru_one *lru, spinlock_t *lru_lock, void *arg)
> >  {
> > -     struct list_head *freeable = arg;
> > +     struct inode_head *ihead = (struct inode_head *)arg;
>
> No need for a cast of a void *.
>

OK.

> > +     struct list_head *freeable = ihead->freeable;
> >       struct inode    *inode = container_of(item, struct inode, i_lru);
> > +     struct mem_cgroup *memcg = NULL;
>
>         struct inode_isolation_args *iargs = arg;
>         struct list_head *freeable = iargs->freeable;
>         struct mem_cgroup *memcg = iargs->memcg;
>         struct inode    *inode = container_of(item, struct inode, i_lru);
>

Thanks. That looks better.

> > @@ -734,6 +743,15 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
> >       if (!spin_trylock(&inode->i_lock))
> >               return LRU_SKIP;
> >
> > +#ifdef CONFIG_MEMCG_KMEM
> > +     memcg = ihead->memcg;
> > +#endif
>
> This is no longer necessary.
>

Thanks.

> > +     if (memcg && inode->i_data.nrpages &&
> > +         !(memcg_can_reclaim_inode(memcg, inode))) {
> > +             spin_unlock(&inode->i_lock);
> > +             return LRU_ROTATE;
> > +     }
>
> I'd argue that both the memcg and the inode->i_data.nrpages check
> should be inside memcg_can_reclaim_inode(), that way this entire
> chunk of code disappears when CONFIG_MEMCG_KMEM=N.
>

I will think about it and make the code better when CONFIG_MEMCG_KMEM=N.

> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index f36ada9..d1d4175 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -247,6 +247,9 @@ struct mem_cgroup {
> >       unsigned int tcpmem_active : 1;
> >       unsigned int tcpmem_pressure : 1;
> >
> > +     /* Soft protection will be ignored if it's true */
> > +     unsigned int in_low_reclaim : 1;
>
> This is the stuff that has nothing to do with the changes to the
> inode reclaim shrinker...
>

In next version I will drop this in_low_reclaim and using the
memcg_low_reclaim passed from struct scan_control.


Thanks
Yafang
