Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C53D4B0E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2019 01:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfJKXid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 19:38:33 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:38640 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbfJKXic (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 19:38:32 -0400
Received: from dread.disaster.area (pa49-181-198-88.pa.nsw.optusnet.com.au [49.181.198.88])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 11FAC3639EB;
        Sat, 12 Oct 2019 10:38:29 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iJ4UO-0007v4-0D; Sat, 12 Oct 2019 10:38:28 +1100
Date:   Sat, 12 Oct 2019 10:38:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 25/26] xfs: rework unreferenced inode lookups
Message-ID: <20191011233827.GP16973@dread.disaster.area>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-26-david@fromorbit.com>
 <20191011125522.GA13167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191011125522.GA13167@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=ocld+OpnWJCUTqzFQA3oTA==:117 a=ocld+OpnWJCUTqzFQA3oTA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=9fGYlBlKfAZRPwy0aZMA:9 a=QEXdDO2ut3YA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 05:55:22AM -0700, Christoph Hellwig wrote:
> On Wed, Oct 09, 2019 at 02:21:23PM +1100, Dave Chinner wrote:
> > 	4. it xfs_ilock_nowait() fails until the rcu grace period
> 
> Should this be:
> 
> > 	4. if xfs_ilock_nowait() fails before the rcu grace period
> 
> ?
> 
> > +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> >  	kmem_zone_free(xfs_inode_zone, ip);
> >  }
> >  
> > @@ -131,6 +132,7 @@ xfs_inode_free(
> >  	 * free state. The ip->i_flags_lock provides the barrier against lookup
> >  	 * races.
> >  	 */
> > +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> 
> This introduceѕ a non-owner unlock of an exclusively held rwsem.  As-is
> this will make lockdep very unhappy.  We have a non-owner unlock version
> of up_read, but not of up_write currently.  I'm also not sure if those
> are allowed from RCU callback, which IIRC can run from softirq context.
> 
> That being said this scheme of only unlocking the inode in the rcu free
> callback makes totaly sense to me, so I wish we can accomodate it
> somehow.

AFAICT it is safe to do this. Lockdep just needs to be bashed about
the head a bit to make it shut up.

> > @@ -312,7 +327,8 @@ xfs_iget_cache_hit(
> >  			rcu_read_lock();
> >  			spin_lock(&ip->i_flags_lock);
> >  			wake = !!__xfs_iflags_test(ip, XFS_INEW);
> > -			ip->i_flags &= ~(XFS_INEW | XFS_IRECLAIM);
> > +			ip->i_flags &= ~XFS_INEW | XFS_IRECLAIM;
> 
> This change looks wrong to me, or did I miss something?  We now
> clear all bits that are not XFS_I_NEW and XFS_IRECLAIM, which
> already is set in ~XFS_INEW.  So if that was the intent just:
> 
> 		ip->i_flags &= ~XFS_INEW;

Nah, I screwed up backing out a change. This line should not be
modified at all.

> 
> > + * This requires code that requires such pins to do the following under a single
> 
> This adds an > 80 char line.  (there are a few more below.
> 
> > +		/* push the AIL to clean dirty reclaimable inodes */
> > +		xfs_ail_push_all(mp->m_ail);
> > +
> > +		/* push the AIL to clean dirty reclaimable inodes */
> > +		xfs_ail_push_all(mp->m_ail);
> > +
> 
> This looks spurious vs the rest of the patch.

Looks like rebase failure fallout. I must have missed it on
cleanup. I'll sort that out.

> > +			if (__xfs_iflags_test(ip, XFS_ISTALE)) {
> > +				spin_unlock(&ip->i_flags_lock);
> > +				if (ip != free_ip)
> >  					xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > -				}
> > +				rcu_read_unlock();
> > +				continue;
> 
> This unlock out of order.  Should be harmless, but also pointless.
> 
> I think this code would be a lot easier to understand if we fatored
> this inner loop into a new helper.  Untested patch that does, and
> also removes a no incorrect comment below:

*nod*

I'll put a refacting patch at the start of the series to split this
into separate code movement and algorithm modification patches....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
