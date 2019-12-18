Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF59123CAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 02:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfLRBvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 20:51:32 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:37103 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbfLRBvc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 20:51:32 -0500
Received: from dread.disaster.area (pa49-195-139-249.pa.nsw.optusnet.com.au [49.195.139.249])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id BCE683A233D;
        Wed, 18 Dec 2019 12:51:24 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ihOUm-0006hR-50; Wed, 18 Dec 2019 12:51:24 +1100
Date:   Wed, 18 Dec 2019 12:51:24 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] memcg, inode: protect page cache from freeing inode
Message-ID: <20191218015124.GS19213@dread.disaster.area>
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
 <20191217115603.GA10016@dhcp22.suse.cz>
 <CALOAHbBQ+XkQk6HN53O4e1=qfFiow2kvQO3ajDj=fwQEhcZ3uw@mail.gmail.com>
 <20191217165422.GA213613@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217165422.GA213613@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=KoypXv6BqLCQNZUs2nCMWg==:117 a=KoypXv6BqLCQNZUs2nCMWg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=FOH2dFAWAAAA:8
        a=pGLkceISAAAA:8 a=fwyzoN0nAAAA:8 a=Z4Rwk6OoAAAA:8 a=ITPUzNMLBOTpTxmZEqwA:9
        a=GopG2n2KI2kB6-sx:21 a=ggBNlrDwpJVTDhj1:21 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
        a=i3VuKzQdj-NEYjvDI-p3:22 a=Sc3RvPAMVtkGz6dGeUiH:22
        a=HkZW87K1Qel5hWWM3VKY:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:54:22AM -0500, Johannes Weiner wrote:
> CCing Dave
> 
> On Tue, Dec 17, 2019 at 08:19:08PM +0800, Yafang Shao wrote:
> > On Tue, Dec 17, 2019 at 7:56 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > What do you mean by this exactly. Are those inodes reclaimed by the
> > > regular memory reclaim or by other means? Because shrink_node does
> > > exclude shrinking slab for protected memcgs.
> > 
> > By the regular memory reclaim, kswapd, direct reclaimer or memcg reclaimer.
> > IOW, the current->reclaim_state it set.
> > 
> > Take an example for you.
> > 
> > kswapd
> >     balance_pgdat
> >         shrink_node_memcgs
> >             switch (mem_cgroup_protected)  <<<< memory.current= 1024M
> > memory.min = 512M a file has 800M page caches
> >                 case MEMCG_PROT_NONE:  <<<< hard limit is not reached.
> >                       beak;
> >             shrink_lruvec
> >             shrink_slab <<< it may free the inode and the free all its
> > page caches (800M)

<looks at patch>

Oh, great, yet another special heuristic reclaim hack for some
whacky memcg reclaim corner case.

> This problem exists independent of cgroup protection.
> 
> The inode shrinker may take down an inode that's still holding a ton
> of (potentially active) page cache pages when the inode hasn't been
> referenced recently.

Ok, please explain to me how are those pages getting repeated
referenced and kept active without referencing the inode in some
way?

e.g. active mmap pins a struct file which pins the inode.
e.g. open fd pins a struct file which pins the inode.
e.g. open/read/write/close keeps a dentry active in cache which pins
the inode when not actively referenced by the open fd.

AFAIA, all of the cases where -file pages- are being actively
referenced require also actively referencing the inode in some way.
So why is the inode being reclaimed as an unreferenced inode at the
end of the LRU if these are actively referenced file pages?

> IMO we shouldn't be dropping data that the VM still considers hot
> compared to other data, just because the inode object hasn't been used
> as recently as other inode objects (e.g. drowned in a stream of
> one-off inode accesses).

It should not be drowned by one-off inode accesses because if
the file data is being actively referenced then there should be
frequent active references to the inode that contains the data and
that should be keeping it away from the tail of the inode LRU.

If the inode is not being frequently referenced, then it
isn't really part of the current working set of inodes, is it?

> I've carried the below patch in my private tree for testing cache
> aging decisions that the shrinker interfered with. (It would be nicer
> if page cache pages could pin the inode of course, but reclaim cannot
> easily participate in the inode refcounting scheme.)
> 
> Thoughts?
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index fef457a42882..bfcaaaf6314f 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -753,7 +753,13 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  		return LRU_ROTATE;
>  	}
>  
> -	if (inode_has_buffers(inode) || inode->i_data.nrpages) {
> +	/* Leave the pages to page reclaim */
> +	if (inode->i_data.nrpages) {
> +		spin_unlock(&inode->i_lock);
> +		return LRU_ROTATE;
> +	}

<sigh>

Remember this?

commit 69056ee6a8a3d576ed31e38b3b14c70d6c74edcc
Author: Dave Chinner <dchinner@redhat.com>
Date:   Tue Feb 12 15:35:51 2019 -0800

    Revert "mm: don't reclaim inodes with many attached pages"
    
    This reverts commit a76cf1a474d7d ("mm: don't reclaim inodes with many
    attached pages").
    
    This change causes serious changes to page cache and inode cache
    behaviour and balance, resulting in major performance regressions when
    combining worklaods such as large file copies and kernel compiles.
    
      https://bugzilla.kernel.org/show_bug.cgi?id=202441
    
    This change is a hack to work around the problems introduced by changing
    how agressive shrinkers are on small caches in commit 172b06c32b94 ("mm:
    slowly shrink slabs with a relatively small number of objects").  It
    creates more problems than it solves, wasn't adequately reviewed or
    tested, so it needs to be reverted.
    
    Link: http://lkml.kernel.org/r/20190130041707.27750-2-david@fromorbit.com
    Fixes: a76cf1a474d7d ("mm: don't reclaim inodes with many attached pages")
    Signed-off-by: Dave Chinner <dchinner@redhat.com>
    Cc: Wolfgang Walter <linux@stwm.de>
    Cc: Roman Gushchin <guro@fb.com>
    Cc: Spock <dairinin@gmail.com>
    Cc: Rik van Riel <riel@surriel.com>
    Cc: Michal Hocko <mhocko@kernel.org>
    Cc: <stable@vger.kernel.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/fs/inode.c b/fs/inode.c
index 0cd47fe0dbe5..73432e64f874 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -730,11 +730,8 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
                return LRU_REMOVED;
        }
 
-       /*
-        * Recently referenced inodes and inodes with many attached pages
-        * get one more pass.
-        */
-       if (inode->i_state & I_REFERENCED || inode->i_data.nrpages > 1) {
+       /* recently referenced inodes get one more pass */
+       if (inode->i_state & I_REFERENCED) {
                inode->i_state &= ~I_REFERENCED;
                spin_unlock(&inode->i_lock);
                return LRU_ROTATE;


-- 
Dave Chinner
david@fromorbit.com
