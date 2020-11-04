Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0162A699C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 17:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbgKDQ1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 11:27:00 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:45838 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgKDQ1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:27:00 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A4GNdk3076280;
        Wed, 4 Nov 2020 16:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=bXyQe1l5jG4ZIB972KmmdbzfFVizt15uvcXexXVG5mk=;
 b=WkpoiqTsCM8U2+xt2sm5POiqQJ9e6+iIR2QEJsa4ndMibauF/uZYEw1SAxKA7rUAc7Zy
 /cj2Ada+oje+YGpo6PO3X9dvjLJXMfbXB8wzk6aOLXjm7KrTEsnorNJejBYglSVPMnOz
 ao22tv4Njh7xU/zcMfSMe2eE2qhEE7cxtXaCcFeSi7fXtxD53rQeSL93eahkjOXe5DuR
 L79dFwm6xlMciyhtM5ztzLnekiJJ2/MhYIML92FoV9RLpai9/NK2gHAyHYd/3FOeJfrm
 fsDox1BiDYFtqDtN1gbgXcW2kXBQ4Hg54tDqxBWVn3ma79fK4fFWW86NdeGt7o1gqKPs fA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34hhb27myv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 04 Nov 2020 16:26:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A4GQVtK109457;
        Wed, 4 Nov 2020 16:26:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34hw0k4wgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Nov 2020 16:26:46 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A4GQfD8028551;
        Wed, 4 Nov 2020 16:26:41 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Nov 2020 08:26:41 -0800
Date:   Wed, 4 Nov 2020 08:26:40 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 resend 1/2] mm: Add become_kswapd and restore_kswapd
Message-ID: <20201104162640.GD7115@magnolia>
References: <20201103131754.94949-1-laoar.shao@gmail.com>
 <20201103131754.94949-2-laoar.shao@gmail.com>
 <20201103194819.GM7123@magnolia>
 <CALOAHbBbMdmq0UFy9gWikXufzSdZmSjdUa8Pbkwr31ZdvnodQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbBbMdmq0UFy9gWikXufzSdZmSjdUa8Pbkwr31ZdvnodQQ@mail.gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=5 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=5
 clxscore=1015 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040122
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 04, 2020 at 10:17:16PM +0800, Yafang Shao wrote:
> On Wed, Nov 4, 2020 at 3:48 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Tue, Nov 03, 2020 at 09:17:53PM +0800, Yafang Shao wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > >
> > > Since XFS needs to pretend to be kswapd in some of its worker threads,
> > > create methods to save & restore kswapd state.  Don't bother restoring
> > > kswapd state in kswapd -- the only time we reach this code is when we're
> > > exiting and the task_struct is about to be destroyed anyway.
> > >
> > > Cc: Dave Chinner <david@fromorbit.com>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  fs/xfs/libxfs/xfs_btree.c | 14 ++++++++------
> > >  include/linux/sched/mm.h  | 23 +++++++++++++++++++++++
> > >  mm/vmscan.c               | 16 +---------------
> > >  3 files changed, 32 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
> > > index 2d25bab..a04a442 100644
> > > --- a/fs/xfs/libxfs/xfs_btree.c
> > > +++ b/fs/xfs/libxfs/xfs_btree.c
> > > @@ -2813,8 +2813,9 @@ struct xfs_btree_split_args {
> > >  {
> > >       struct xfs_btree_split_args     *args = container_of(work,
> > >                                               struct xfs_btree_split_args, work);
> > > +     bool                    is_kswapd = args->kswapd;
> > >       unsigned long           pflags;
> > > -     unsigned long           new_pflags = PF_MEMALLOC_NOFS;
> > > +     int                     memalloc_nofs;
> > >
> > >       /*
> > >        * we are in a transaction context here, but may also be doing work
> > > @@ -2822,16 +2823,17 @@ struct xfs_btree_split_args {
> > >        * temporarily to ensure that we don't block waiting for memory reclaim
> > >        * in any way.
> > >        */
> > > -     if (args->kswapd)
> > > -             new_pflags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
> > > -
> > > -     current_set_flags_nested(&pflags, new_pflags);
> > > +     if (is_kswapd)
> > > +             pflags = become_kswapd();
> > > +     memalloc_nofs = memalloc_nofs_save();
> > >
> > >       args->result = __xfs_btree_split(args->cur, args->level, args->ptrp,
> > >                                        args->key, args->curp, args->stat);
> > >       complete(args->done);
> > >
> > > -     current_restore_flags_nested(&pflags, new_pflags);
> > > +     memalloc_nofs_restore(memalloc_nofs);
> > > +     if (is_kswapd)
> > > +             restore_kswapd(pflags);
> >
> > Note that there's a trivial merge conflict with the mrlock_t removal
> > series.  I'll carry the fix in the tree, assuming that everything
> > passes.
> >
> 
> This patchset is based on Andrew's tree currently.
> Seems I should rebase this patchset on your tree instead of Andrew's tree ?

That depends on whether or not you want me to push these two patches
through the xfs tree or if they're going through Andrew (Morton?)'s
quiltset.

Frankly I'd rather take them via xfs since most of the diff is xfs...

--D

> > --D
> >
> > >  }
> > >
> > >  /*
> > > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > > index d5ece7a..2faf03e 100644
> > > --- a/include/linux/sched/mm.h
> > > +++ b/include/linux/sched/mm.h
> > > @@ -278,6 +278,29 @@ static inline void memalloc_nocma_restore(unsigned int flags)
> > >  }
> > >  #endif
> > >
> > > +/*
> > > + * Tell the memory management code that this thread is working on behalf
> > > + * of background memory reclaim (like kswapd).  That means that it will
> > > + * get access to memory reserves should it need to allocate memory in
> > > + * order to make forward progress.  With this great power comes great
> > > + * responsibility to not exhaust those reserves.
> > > + */
> > > +#define KSWAPD_PF_FLAGS              (PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD)
> > > +
> > > +static inline unsigned long become_kswapd(void)
> > > +{
> > > +     unsigned long flags = current->flags & KSWAPD_PF_FLAGS;
> > > +
> > > +     current->flags |= KSWAPD_PF_FLAGS;
> > > +
> > > +     return flags;
> > > +}
> > > +
> > > +static inline void restore_kswapd(unsigned long flags)
> > > +{
> > > +     current->flags &= ~(flags ^ KSWAPD_PF_FLAGS);
> > > +}
> > > +
> > >  #ifdef CONFIG_MEMCG
> > >  DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
> > >  /**
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 1b8f0e0..77bc1dd 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -3869,19 +3869,7 @@ static int kswapd(void *p)
> > >       if (!cpumask_empty(cpumask))
> > >               set_cpus_allowed_ptr(tsk, cpumask);
> > >
> > > -     /*
> > > -      * Tell the memory management that we're a "memory allocator",
> > > -      * and that if we need more memory we should get access to it
> > > -      * regardless (see "__alloc_pages()"). "kswapd" should
> > > -      * never get caught in the normal page freeing logic.
> > > -      *
> > > -      * (Kswapd normally doesn't need memory anyway, but sometimes
> > > -      * you need a small amount of memory in order to be able to
> > > -      * page out something else, and this flag essentially protects
> > > -      * us from recursively trying to free more memory as we're
> > > -      * trying to free the first piece of memory in the first place).
> > > -      */
> > > -     tsk->flags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
> > > +     become_kswapd();
> > >       set_freezable();
> > >
> > >       WRITE_ONCE(pgdat->kswapd_order, 0);
> > > @@ -3931,8 +3919,6 @@ static int kswapd(void *p)
> > >                       goto kswapd_try_sleep;
> > >       }
> > >
> > > -     tsk->flags &= ~(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD);
> > > -
> > >       return 0;
> > >  }
> > >
> > > --
> > > 1.8.3.1
> > >
> 
> 
> 
> -- 
> Thanks
> Yafang
