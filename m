Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4502551F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 02:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgH1Afq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 20:35:46 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:36716 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbgH1Afq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 20:35:46 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id C82003A7122;
        Fri, 28 Aug 2020 10:35:42 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kBSMn-0007ec-DX; Fri, 28 Aug 2020 10:35:41 +1000
Date:   Fri, 28 Aug 2020 10:35:41 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, y-goto@fujitsu.com
Subject: Re: [PATCH] fs: Kill DCACHE_DONTCACHE dentry even if
 DCACHE_REFERENCED is set
Message-ID: <20200828003541.GD12096@dread.disaster.area>
References: <20200821015953.22956-1-lihao2018.fnst@cn.fujitsu.com>
 <20200827063748.GA12096@dread.disaster.area>
 <6b3b3439-2199-8f00-ceca-d65769e94fe0@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b3b3439-2199-8f00-ceca-d65769e94fe0@cn.fujitsu.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=IuRgj43g c=1 sm=1 tr=0 cx=a_idp_d
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=omOdbC7AAAAA:8 a=7-415B0cAAAA:8
        a=4EakmT0XTRVUVr4ZEt4A:9 a=CjuIK1q_8ugA:10 a=baC4JDFNLZpnPwus_NF9:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 05:58:07PM +0800, Li, Hao wrote:
> On 2020/8/27 14:37, Dave Chinner wrote:
> > On Fri, Aug 21, 2020 at 09:59:53AM +0800, Hao Li wrote:
> >> Currently, DCACHE_REFERENCED prevents the dentry with DCACHE_DONTCACHE
> >> set from being killed, so the corresponding inode can't be evicted. If
> >> the DAX policy of an inode is changed, we can't make policy changing
> >> take effects unless dropping caches manually.
> >>
> >> This patch fixes this problem and flushes the inode to disk to prepare
> >> for evicting it.
> >>
> >> Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
> >> ---
> >>  fs/dcache.c | 3 ++-
> >>  fs/inode.c  | 2 +-
> >>  2 files changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/dcache.c b/fs/dcache.c
> >> index ea0485861d93..486c7409dc82 100644
> >> --- a/fs/dcache.c
> >> +++ b/fs/dcache.c
> >> @@ -796,7 +796,8 @@ static inline bool fast_dput(struct dentry *dentry)
> >>  	 */
> >>  	smp_rmb();
> >>  	d_flags = READ_ONCE(dentry->d_flags);
> >> -	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED;
> >> +	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED
> >> +			| DCACHE_DONTCACHE;
> > Seems reasonable, but you need to update the comment above as to
> > how this flag fits into this code....
> 
> Yes. I will change it. Thanks.
> 
> >
> >>  	/* Nothing to do? Dropping the reference was all we needed? */
> >>  	if (d_flags == (DCACHE_REFERENCED | DCACHE_LRU_LIST) && !d_unhashed(dentry))
> >> diff --git a/fs/inode.c b/fs/inode.c
> >> index 72c4c347afb7..5218a8aebd7f 100644
> >> --- a/fs/inode.c
> >> +++ b/fs/inode.c
> >> @@ -1632,7 +1632,7 @@ static void iput_final(struct inode *inode)
> >>  	}
> >>  
> >>  	state = inode->i_state;
> >> -	if (!drop) {
> >> +	if (!drop || (drop && (inode->i_state & I_DONTCACHE))) {
> >>  		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
> >>  		spin_unlock(&inode->i_lock);
> > What's this supposed to do? We'll only get here with drop set if the
> > filesystem is mounting or unmounting.
> 
> The variable drop will also be set to True if I_DONTCACHE is set on
> inode->i_state.
> Although mounting/unmounting will set the drop variable, it won't set
> I_DONTCACHE if I understand correctly. As a result,
> drop && (inode->i_state & I_DONTCACHE) will filter out mounting/unmounting.

So what does this have to do with changing the way the dcache
treats DCACHE_DONTCACHE?

Also, if I_DONTCACHE is set, but the inode has also been unlinked or
is unhashed, should we be writing it back? i.e. it might have been
dropped for a different reason to I_DONTCACHE....

IOWs, if there is a problem with how I_DONTCACHE is being handled,
then the problem must already exists regardless of the
DCACHE_DONTCACHE behaviour, right? So shouldn't this be a separate
bug fix with it's own explanation of the problem and the fix?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
