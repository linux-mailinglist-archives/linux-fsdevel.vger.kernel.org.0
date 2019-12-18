Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96C79123D04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 03:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfLRCVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 21:21:31 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:59587 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbfLRCVb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 21:21:31 -0500
Received: from dread.disaster.area (pa49-195-139-249.pa.nsw.optusnet.com.au [49.195.139.249])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 73DBB3A2971;
        Wed, 18 Dec 2019 13:21:24 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ihOxm-0006rs-AM; Wed, 18 Dec 2019 13:21:22 +1100
Date:   Wed, 18 Dec 2019 13:21:22 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 4/4] memcg, inode: protect page cache from freeing inode
Message-ID: <20191218022122.GT19213@dread.disaster.area>
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
 <1576582159-5198-5-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576582159-5198-5-git-send-email-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=KoypXv6BqLCQNZUs2nCMWg==:117 a=KoypXv6BqLCQNZUs2nCMWg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=FOH2dFAWAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8
        a=Kq0Fw4N6cfM2Gj6mMccA:9 a=CjuIK1q_8ugA:10 a=i3VuKzQdj-NEYjvDI-p3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 06:29:19AM -0500, Yafang Shao wrote:
> On my server there're some running MEMCGs protected by memory.{min, low},
> but I found the usage of these MEMCGs abruptly became very small, which
> were far less than the protect limit. It confused me and finally I
> found that was because of inode stealing.
> Once an inode is freed, all its belonging page caches will be dropped as
> well, no matter how may page caches it has. So if we intend to protect the
> page caches in a memcg, we must protect their host (the inode) first.
> Otherwise the memcg protection can be easily bypassed with freeing inode,
> especially if there're big files in this memcg.
> The inherent mismatch between memcg and inode is a trouble. One inode can
> be shared by different MEMCGs, but it is a very rare case. If an inode is
> shared, its belonging page caches may be charged to different MEMCGs.
> Currently there's no perfect solution to fix this kind of issue, but the
> inode majority-writer ownership switching can help it more or less.
> 
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Chris Down <chris@chrisdown.name>
> Cc: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  fs/inode.c                 |  9 +++++++++
>  include/linux/memcontrol.h | 15 +++++++++++++++
>  mm/memcontrol.c            | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  mm/vmscan.c                |  4 ++++
>  4 files changed, 74 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index fef457a..b022447 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -734,6 +734,15 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  	if (!spin_trylock(&inode->i_lock))
>  		return LRU_SKIP;
>  
> +
> +	/* Page protection only works in reclaimer */
> +	if (inode->i_data.nrpages && current->reclaim_state) {
> +		if (mem_cgroup_inode_protected(inode)) {
> +			spin_unlock(&inode->i_lock);
> +			return LRU_ROTATE;

Urk, so after having plumbed the memcg all the way down to the
list_lru walk code so that we only walk inodes in that memcg, we now
have to do a lookup from the inode back to the owner memcg to
determine if we should reclaim it? IOWs, I think the layering here
is all wrong - if memcg info is needed in the shrinker, it should
come from the shrink_control->memcg pointer, not be looked up from
the object being isolated...

i.e. this code should read something like this:

	if (memcg && inode->i_data.nrpages &&
	    (!memcg_can_reclaim_inode(memcg, inode)) {
		spin_unlock(&inode->i_lock);
		return LRU_ROTATE;
	}

This code does not need comments because it is obvious what it does,
and it provides a generic hook into inode reclaim for the memcg code
to decide whether the shrinker should reclaim the inode or not.

This is how the memcg code should interact with other shrinkers, too
(e.g. the dentry cache isolation function), so you need to look at
how to make the memcg visible to the lru walker isolation
functions....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
