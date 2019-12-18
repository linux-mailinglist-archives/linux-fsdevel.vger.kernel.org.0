Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6ED6123E96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 05:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLREhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 23:37:31 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44845 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLREhb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:37:31 -0500
Received: by mail-pg1-f194.google.com with SMTP id x7so533162pgl.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 20:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hq3Jtpmlbrx/C7LlO8U+CjXhOR8vC9Ypn9AFObATYNA=;
        b=m0mvRZyYgAVJXqqx7V6pBaCs2zZWvVNQzmWsNzrIaWgkdMKx1YOe5LHKh4FRG/O53L
         1hKkyMpEt4pyhmov8nFEBCqkNDj1FsQYb/Q4Pc2FSg4k56K5MpplFkWa4lItGVSIzQlo
         ixOuMnCmAgnuNV0HxTg9rANMaIpy31C8rIpjrKG+xSe3F8J4B3HHZNKrBCZKDL8lQSz7
         Uc5izLVVt3ggDGfr1WwBuWx7NU7Z+RTF/R9LCIjcDjOX2IlJFo9dLCanjOc47nJ06BOW
         5L1+EVNRPA8+x0LfQBf8eVccoKrb3qLRyEVf9Rg2Y1kI1gB8EoK9qIfoSNQL8qtitNgl
         n+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hq3Jtpmlbrx/C7LlO8U+CjXhOR8vC9Ypn9AFObATYNA=;
        b=e1WuGKreANksJNssD2Kz2dK9T9xTy8biJo1Yn5kMGfwKzZQEZnfs+3G2TyDkHHSf5o
         2rJGypExP7j03LpsDmeU/Jkrim1oWiqlPl9E2ZWvr0UTAfWsHwnxJAnRf9lZYMYV4Keu
         xvw1yxDr51oZAWFoYtbpVZjDAslYX6mcvCd+7GF3MOWhfsFGsMhavhkQAyO3J/FCatD+
         NtGBeoBsxVrX3eT1cOi5Y8B5WgisBfDhZh9vjWht5OJy8XGumF3asJEAK84xVNL8T6po
         QY1/RtBBzIUZuabclnXDTMyaPd31leIl/T+kD7UbT74i4wfn3ZM5DeAm6Q4X288rHOCh
         s8eg==
X-Gm-Message-State: APjAAAX5dpyk8rmuQci4Y+QH9WJfb3Glr5kFNarp5MnwUPye3YyHW56I
        hAeHBhpb5M7N309vdg4/JGGb+g==
X-Google-Smtp-Source: APXvYqw4Z+MjyIjGoeFoHq83OPyFuVux49TRvZX5smVnCtBsZaQHLZiD6OnFa1PvcnW0x16ncwwXiA==
X-Received: by 2002:a63:554c:: with SMTP id f12mr682162pgm.23.1576643850343;
        Tue, 17 Dec 2019 20:37:30 -0800 (PST)
Received: from localhost ([2620:10d:c090:180::24bc])
        by smtp.gmail.com with ESMTPSA id v19sm594535pju.27.2019.12.17.20.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 20:37:29 -0800 (PST)
Date:   Tue, 17 Dec 2019 23:37:27 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] memcg, inode: protect page cache from freeing inode
Message-ID: <20191218043727.GA4877@cmpxchg.org>
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
 <20191217115603.GA10016@dhcp22.suse.cz>
 <CALOAHbBQ+XkQk6HN53O4e1=qfFiow2kvQO3ajDj=fwQEhcZ3uw@mail.gmail.com>
 <20191217165422.GA213613@cmpxchg.org>
 <20191218015124.GS19213@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218015124.GS19213@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 12:51:24PM +1100, Dave Chinner wrote:
> On Tue, Dec 17, 2019 at 11:54:22AM -0500, Johannes Weiner wrote:
> > CCing Dave
> > 
> > On Tue, Dec 17, 2019 at 08:19:08PM +0800, Yafang Shao wrote:
> > > On Tue, Dec 17, 2019 at 7:56 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > > What do you mean by this exactly. Are those inodes reclaimed by the
> > > > regular memory reclaim or by other means? Because shrink_node does
> > > > exclude shrinking slab for protected memcgs.
> > > 
> > > By the regular memory reclaim, kswapd, direct reclaimer or memcg reclaimer.
> > > IOW, the current->reclaim_state it set.
> > > 
> > > Take an example for you.
> > > 
> > > kswapd
> > >     balance_pgdat
> > >         shrink_node_memcgs
> > >             switch (mem_cgroup_protected)  <<<< memory.current= 1024M
> > > memory.min = 512M a file has 800M page caches
> > >                 case MEMCG_PROT_NONE:  <<<< hard limit is not reached.
> > >                       beak;
> > >             shrink_lruvec
> > >             shrink_slab <<< it may free the inode and the free all its
> > > page caches (800M)
> 
> <looks at patch>
> 
> Oh, great, yet another special heuristic reclaim hack for some
> whacky memcg reclaim corner case.
> 
> > This problem exists independent of cgroup protection.
> > 
> > The inode shrinker may take down an inode that's still holding a ton
> > of (potentially active) page cache pages when the inode hasn't been
> > referenced recently.
> 
> Ok, please explain to me how are those pages getting repeated
> referenced and kept active without referencing the inode in some
> way?
> 
> e.g. active mmap pins a struct file which pins the inode.
> e.g. open fd pins a struct file which pins the inode.
> e.g. open/read/write/close keeps a dentry active in cache which pins
> the inode when not actively referenced by the open fd.
> 
> AFAIA, all of the cases where -file pages- are being actively
> referenced require also actively referencing the inode in some way.
> So why is the inode being reclaimed as an unreferenced inode at the
> end of the LRU if these are actively referenced file pages?
> 
> > IMO we shouldn't be dropping data that the VM still considers hot
> > compared to other data, just because the inode object hasn't been used
> > as recently as other inode objects (e.g. drowned in a stream of
> > one-off inode accesses).
> 
> It should not be drowned by one-off inode accesses because if
> the file data is being actively referenced then there should be
> frequent active references to the inode that contains the data and
> that should be keeping it away from the tail of the inode LRU.
> 
> If the inode is not being frequently referenced, then it
> isn't really part of the current working set of inodes, is it?

The inode doesn't have to be currently open for its data to be used
frequently and recently.

Executables that run periodically come to mind.

An sqlite file database that is periodically opened and queried, then
closed again.

A git repository.

I don't want a find or an updatedb, which doesn't produce active
pages, and could be funneled through the cache with otherwise no side
effects, kick out all my linux tree git objects via the inode shrinker
just because I haven't run a git command in a few minutes.

> > I've carried the below patch in my private tree for testing cache
> > aging decisions that the shrinker interfered with. (It would be nicer
> > if page cache pages could pin the inode of course, but reclaim cannot
> > easily participate in the inode refcounting scheme.)
> > 
> > Thoughts?
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index fef457a42882..bfcaaaf6314f 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -753,7 +753,13 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
> >  		return LRU_ROTATE;
> >  	}
> >  
> > -	if (inode_has_buffers(inode) || inode->i_data.nrpages) {
> > +	/* Leave the pages to page reclaim */
> > +	if (inode->i_data.nrpages) {
> > +		spin_unlock(&inode->i_lock);
> > +		return LRU_ROTATE;
> > +	}
> 
> <sigh>
> 
> Remember this?
> 
> commit 69056ee6a8a3d576ed31e38b3b14c70d6c74edcc
> Author: Dave Chinner <dchinner@redhat.com>
> Date:   Tue Feb 12 15:35:51 2019 -0800
> 
>     Revert "mm: don't reclaim inodes with many attached pages"
>     
>     This reverts commit a76cf1a474d7d ("mm: don't reclaim inodes with many
>     attached pages").
>     
>     This change causes serious changes to page cache and inode cache
>     behaviour and balance, resulting in major performance regressions when
>     combining worklaods such as large file copies and kernel compiles.
>     
>       https://bugzilla.kernel.org/show_bug.cgi?id=202441

I don't remember this, but reading this bugzilla thread is immensely
frustrating.

We've been carrying this patch here in our tree for over half a decade
now to work around this exact stalling in the xfs shrinker:

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index d53a316162d6..45b3a4d07813 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1344,7 +1344,7 @@ xfs_reclaim_inodes_nr(
        xfs_reclaim_work_queue(mp);
        xfs_ail_push_all(mp->m_ail);

-       return xfs_reclaim_inodes_ag(mp, SYNC_TRYLOCK | SYNC_WAIT, &nr_to_scan);
+       return xfs_reclaim_inodes_ag(mp, SYNC_TRYLOCK, &nr_to_scan);
 }

Because if we don't, our warmstorage machines lock up within minutes,
long before Roman's patch.

The fact that xfs stalls on individual inodes while there might be a
ton of clean cache on the LRUs is an xfs problem, not a VM problem.

The right thing to do to avoid stalls in the inode shrinker is to skip
over the dirty inodes and yield back to LRU reclaim; not circumvent
page aging and drop clean inodes on the floor when those may or may
not hold gigabytes of cache data that the inode shrinker knows
*absolutely nothing* about.

This entire approach is backwards.
