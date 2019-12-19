Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F88012595C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 02:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfLSBqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 20:46:30 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42149 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfLSBqa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 20:46:30 -0500
Received: by mail-io1-f68.google.com with SMTP id n11so2553133iom.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 17:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2SgtbmiE52TkBbM+NsUg7fsReaApD1ViuURteA0TONY=;
        b=exIYWYdUd5e9sF3wpiYUP1tj+O2AApY+wimd+88F2bzOrK00+VoWBK8ZXd0j6VvDaK
         MZwNHBuEDCnn32CkYXi2j2JHJE/egf0n4MabJgTikkzghRoqjZw/lf093tIYRwVJbcmg
         DSKEK1qcB5Qjx19e6pU0ys8GpnaVPNeWqHTPlleWd0x/XSdXWo18gFJ3Iper8f/iWj/I
         T/KvBH/rdY7HlRCb1E/ioWWug20LVv5VTSbLdYIf82vRQUnN7Oj9/Ph5ltgIYl/SKNfM
         gn1wlt22XGggZQMVnQotxIynD0ZYK3bYPDCbUdmc0CQxkdva4/ULXxhTFdn2MxyCTawx
         DIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SgtbmiE52TkBbM+NsUg7fsReaApD1ViuURteA0TONY=;
        b=DSNYWY2dHYCg2NWftxEId45TPItOJKiSebnHK6QOfALcdRA3//pBNFoX7pfknB5FwG
         lej8SPJDBel4pl8IImiLH51e4FH0ZsCXoWa0YMuUkSffZtnTyv0cPpcm0Naf1scalDmP
         WSMaHDtNmCq5FmXLMoZ7r/Jix2DgL94hXWDGnc4PmNgQv/IJ+jVhP9ObFKBMhLSP7TMo
         K5awNkhnTm0eSh/lyDp2ZPosppkMJDdgS23KXQnHGJYhxbf/yTUTjzuoT14+0tSuyeR+
         RtjgbkUb7u78rTI9lu//Uaypn0xyyWULfw39EMpIuvlmdBHG3O15+b5he64Jbx69d/1b
         fnNg==
X-Gm-Message-State: APjAAAWrJAIMucr99pShthfiCbx8rgDUAclVw9u4gvD4u9CB/t1hLWhb
        j6/3Ga8XBmPx+NPT6SNyPuN4b63OL2f8T5jxlDQ=
X-Google-Smtp-Source: APXvYqxC4/AdMrwil8H0EDnQLkcKv+RHzbV/jx4ADdNxuc2pUfaowdGYyD0PqHoeajONMsCTqvyeJCnKN0VCG2XJDMQ=
X-Received: by 2002:a6b:b941:: with SMTP id j62mr4258784iof.168.1576719989349;
 Wed, 18 Dec 2019 17:46:29 -0800 (PST)
MIME-Version: 1.0
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
 <1576582159-5198-5-git-send-email-laoar.shao@gmail.com> <20191218175310.GA4730@localhost.localdomain>
In-Reply-To: <20191218175310.GA4730@localhost.localdomain>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 19 Dec 2019 09:45:53 +0800
Message-ID: <CALOAHbCXeGbOBwqmhYcKDYg24P4GJ+c9X7dd5MwjGZKn66r=Kg@mail.gmail.com>
Subject: Re: [PATCH 4/4] memcg, inode: protect page cache from freeing inode
To:     Roman Gushchin <guro@fb.com>
Cc:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 19, 2019 at 1:53 AM Roman Gushchin <guro@fb.com> wrote:
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
> > +             }
> > +     }
>
> Not directly related to this approach, but I wonder, if we should scale down
> the size of shrinker lists depending on the memory protection (like we do with
> LRU lists)? It won't fix the problem with huge inodes being reclaimed at once
> without a need, but will help scale the memory pressure for protected cgroups.
>

Same with what we are doing in get_scan_count() to calculate how many
pages we should scan ?
I guess we should.

>
>
> > +
> >       /*
> >        * Referenced or dirty inodes are still in use. Give them another pass
> >        * through the LRU as we canot reclaim them now.
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 1a315c7..21338f0 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -247,6 +247,9 @@ struct mem_cgroup {
> >       unsigned int tcpmem_active : 1;
> >       unsigned int tcpmem_pressure : 1;
> >
> > +     /* Soft protection will be ignored if it's true */
> > +     unsigned int in_low_reclaim : 1;
> > +
> >       int under_oom;
> >
> >       int     swappiness;
> > @@ -363,6 +366,7 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
> >
> >  enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
> >                                               struct mem_cgroup *memcg);
> > +unsigned long mem_cgroup_inode_protected(struct inode *inode);
> >
> >  int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
> >                         gfp_t gfp_mask, struct mem_cgroup **memcgp,
> > @@ -850,6 +854,11 @@ static inline enum mem_cgroup_protection mem_cgroup_protected(
> >       return MEMCG_PROT_NONE;
> >  }
> >
> > +static inline unsigned long mem_cgroup_inode_protected(struct inode *inode)
> > +{
> > +     return 0;
> > +}
> > +
> >  static inline int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
> >                                       gfp_t gfp_mask,
> >                                       struct mem_cgroup **memcgp,
> > @@ -926,6 +935,12 @@ static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
> >       return NULL;
> >  }
> >
> > +static inline struct mem_cgroup *
> > +mem_cgroup_from_css(struct cgroup_subsys_state *css)
> > +{
> > +     return NULL;
> > +}
> > +
> >  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> >  {
> >  }
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 234370c..efb53f3 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6355,6 +6355,52 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
> >  }
> >
> >  /**
> > + * Once an inode is freed, all its belonging page caches will be dropped as
> > + * well, even if there're lots of page caches. So if we intend to protect
> > + * page caches in a memcg, we must protect their host first. Otherwise the
> > + * memory usage can be dropped abruptly if there're big files in this
> > + * memcg. IOW the memcy protection can be easily bypassed with freeing
> > + * inode. We should prevent it.
> > + * The inherent mismatch between memcg and inode is a trouble. One inode
> > + * can be shared by different MEMCGs, but it is a very rare case. If
> > + * an inode is shared, its belonging page caches may be charged to
> > + * different MEMCGs. Currently there's no perfect solution to fix this
> > + * kind of issue, but the inode majority-writer ownership switching can
> > + * help it more or less.
> > + */
> > +unsigned long mem_cgroup_inode_protected(struct inode *inode)
> > +{
> > +     unsigned long cgroup_size;
> > +     unsigned long protect = 0;
> > +     struct bdi_writeback *wb;
> > +     struct mem_cgroup *memcg;
> > +
> > +     wb = inode_to_wb(inode);
> > +     if (!wb)
> > +             goto out;
> > +
> > +     memcg = mem_cgroup_from_css(wb->memcg_css);
> > +     if (!memcg || memcg == root_mem_cgroup)
> > +             goto out;
> > +
> > +     protect = mem_cgroup_protection(memcg, memcg->in_low_reclaim);
> > +     if (!protect)
> > +             goto out;
> > +
> > +     cgroup_size = mem_cgroup_size(memcg);
> > +     /*
> > +      * Don't need to protect this inode, if the usage is still above
> > +      * the limit after reclaiming this inode and its belonging page
> > +      * caches.
> > +      */
> > +     if (inode->i_data.nrpages + protect < cgroup_size)
> > +             protect = 0;
> > +
> > +out:
> > +     return protect;
> > +}
> > +
> > +/**
> >   * mem_cgroup_try_charge - try charging a page
> >   * @page: page to charge
> >   * @mm: mm context of the victim
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 3c4c2da..1cc7fc2 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2666,6 +2666,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> >                               sc->memcg_low_skipped = 1;
> >                               continue;
> >                       }
> > +                     memcg->in_low_reclaim = 1;
> >                       memcg_memory_event(memcg, MEMCG_LOW);
> >                       break;
> >               case MEMCG_PROT_NONE:
> > @@ -2693,6 +2694,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> >               shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
> >                           sc->priority);
> >
> > +             if (memcg->in_low_reclaim)
> > +                     memcg->in_low_reclaim = 0;
> > +
> >               /* Record the group's reclaim efficiency */
> >               vmpressure(sc->gfp_mask, memcg, false,
> >                          sc->nr_scanned - scanned,
> > --
> > 1.8.3.1
> >
