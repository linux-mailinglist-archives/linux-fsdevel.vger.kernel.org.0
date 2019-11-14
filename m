Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88E9FD099
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 22:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKNVwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 16:52:03 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:57444 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726613AbfKNVwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:52:03 -0500
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C973D43FE93;
        Fri, 15 Nov 2019 08:51:57 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iVN1w-0003fs-HT; Fri, 15 Nov 2019 08:51:56 +1100
Date:   Fri, 15 Nov 2019 08:51:56 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/28] xfs: reclaim inodes from the LRU
Message-ID: <20191114215156.GH4614@dread.disaster.area>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-25-david@fromorbit.com>
 <20191106172104.GB37080@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106172104.GB37080@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=7-415B0cAAAA:8 a=kI0OJltd-DUvDqvnONAA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 06, 2019 at 12:21:04PM -0500, Brian Foster wrote:
> On Fri, Nov 01, 2019 at 10:46:14AM +1100, Dave Chinner wrote:
> > -	struct xfs_inode	*ip,
> > -	int			flags,
> > -	xfs_lsn_t		*lsn)
> > +enum lru_status
> > +xfs_inode_reclaim_isolate(
> > +	struct list_head	*item,
> > +	struct list_lru_one	*lru,
> > +	spinlock_t		*lru_lock,
> 
> Did we ever establish whether we should cycle the lru_lock during long
> running scans?

I'm still evaluating this.

In theory, because it's non-blocking, the lock hold time isn't huge,
but OTOH I think the hold time is causing lock contention problems on
unlink workloads.  I've found a bunch of perf/blocking problems in
the last few days, and each one of them I sort out puts more
pressure on the lru list lock on unlinks.

> > -	/*
> > -	 * Do unlocked checks to see if the inode already is being flushed or in
> > -	 * reclaim to avoid lock traffic. If the inode is not clean, return the
> > -	 * position in the AIL for the caller to push to.
> > -	 */
> > -	if (!xfs_inode_clean(ip)) {
> > -		*lsn = ip->i_itemp->ili_item.li_lsn;
> > -		return false;
> > +	if (!__xfs_iflock_nowait(ip)) {
> > +		lsn = ip->i_itemp->ili_item.li_lsn;
> 
> This looks like a potential crash vector if we ever got here with a
> clean inode.

I'm not sure we can ever fail a flush lock attempt on a clean inode.
But I'll rework the lsn grabbing, I think.

> > +		ra->dirty_skipped++;
> > +		goto out_unlock_inode;
> >  	}
> >  
> > -	if (__xfs_iflags_test(ip, XFS_IFLOCK | XFS_IRECLAIM))
> > -		return false;
> > +	if (XFS_FORCED_SHUTDOWN(ip->i_mount))
> > +		goto reclaim;
> >  
> >  	/*
> > -	 * The radix tree lock here protects a thread in xfs_iget from racing
> > -	 * with us starting reclaim on the inode.  Once we have the
> > -	 * XFS_IRECLAIM flag set it will not touch us.
> > -	 *
> > -	 * Due to RCU lookup, we may find inodes that have been freed and only
> > -	 * have XFS_IRECLAIM set.  Indeed, we may see reallocated inodes that
> > -	 * aren't candidates for reclaim at all, so we must check the
> > -	 * XFS_IRECLAIMABLE is set first before proceeding to reclaim.
> > +	 * Now the inode is locked, we can actually determine if it is dirty
> > +	 * without racing with anything.
> >  	 */
> > -	spin_lock(&ip->i_flags_lock);
> > -	if (!__xfs_iflags_test(ip, XFS_IRECLAIMABLE) ||
> > -	    __xfs_iflags_test(ip, XFS_IRECLAIM)) {
> > -		/* not a reclaim candidate. */
> > -		spin_unlock(&ip->i_flags_lock);
> > -		return false;
> > +	ret = LRU_ROTATE;
> > +	if (xfs_ipincount(ip)) {
> > +		ra->dirty_skipped++;
> 
> Hmm.. didn't we have an LSN check here?

Yes, but if the inode was not in the AIL, it would crash, so I
removed it :P

> Altogether, I think the logic in this function would be a lot more
> simple if we had something like the following:
> 
> 	...
> 	/* ret == LRU_SKIP */
>         if (!xfs_inode_clean(ip)) {
> 		ret = LRU_ROTATE;
>                 lsn = ip->i_itemp->ili_item.li_lsn;
>                 ra->dirty_skipped++;
>         }
>         if (lsn && XFS_LSN_CMP(lsn, ra->lowest_lsn) < 0)
>                 ra->lowest_lsn = lsn;
>         return ret;
> 
> ... as the non-reclaim exit path.

Yeah, that was what I was thinking when you pointed out the
iflock_nowait issue above. I'll end up with something like this, I
think....

> >  void
> >  xfs_reclaim_all_inodes(
> >  	struct xfs_mount	*mp)
> >  {
> ...
> > +	while (list_lru_count(&mp->m_inode_lru)) {
> 
> It seems unnecessary to call this twice per-iter:
> 
> 	while ((to_free = list_lru_count(&mp->m_inode_lru))) {
> 		...
> 	}

*nod*.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
