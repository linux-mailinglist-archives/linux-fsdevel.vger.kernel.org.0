Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7CF102E26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 22:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfKSVSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 16:18:42 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:56796 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726711AbfKSVSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 16:18:41 -0500
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 836237E9C39;
        Wed, 20 Nov 2019 08:18:37 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iXAtO-0007v2-C9; Wed, 20 Nov 2019 08:18:34 +1100
Date:   Wed, 20 Nov 2019 08:18:34 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/28] xfs: rework unreferenced inode lookups
Message-ID: <20191119211834.GA4614@dread.disaster.area>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-29-david@fromorbit.com>
 <20191106221846.GE37080@bfoster>
 <20191114221602.GJ4614@dread.disaster.area>
 <20191115172600.GC55854@bfoster>
 <20191118010047.GS4614@dread.disaster.area>
 <20191119151344.GD10763@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119151344.GD10763@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=7-415B0cAAAA:8 a=6g2m8KwY7f5AaauT50oA:9 a=kN7pVA4lhFw_-KmI:21
        a=bRrQUF9rowBlmQs9:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 19, 2019 at 10:13:44AM -0500, Brian Foster wrote:
> On Mon, Nov 18, 2019 at 12:00:47PM +1100, Dave Chinner wrote:
> > On Fri, Nov 15, 2019 at 12:26:00PM -0500, Brian Foster wrote:
> > > On Fri, Nov 15, 2019 at 09:16:02AM +1100, Dave Chinner wrote:
> > > > On Wed, Nov 06, 2019 at 05:18:46PM -0500, Brian Foster wrote:
> > > > If so, most of this patch will go away....
> > > > 
> > > > > > +	 * attached to the buffer so we don't need to do anything more here.
> > > > > >  	 */
> > > > > > -	if (ip != free_ip) {
> > > > > > -		if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
> > > > > > -			rcu_read_unlock();
> > > > > > -			delay(1);
> > > > > > -			goto retry;
> > > > > > -		}
> > > > > > -
> > > > > > -		/*
> > > > > > -		 * Check the inode number again in case we're racing with
> > > > > > -		 * freeing in xfs_reclaim_inode().  See the comments in that
> > > > > > -		 * function for more information as to why the initial check is
> > > > > > -		 * not sufficient.
> > > > > > -		 */
> > > > > > -		if (ip->i_ino != inum) {
> > > > > > +	if (__xfs_iflags_test(ip, XFS_ISTALE)) {
> > > > > 
> > > > > Is there a correctness reason for why we move the stale check to under
> > > > > ilock (in both iflush/ifree)?
> > > > 
> > > > It's under the i_flags_lock, and so I moved it up under the lookup
> > > > hold of the i_flags_lock so we don't need to cycle it again.
> > > > 
> > > 
> > > Yeah, but in both cases it looks like it moved to under the ilock as
> > > well, which comes after i_flags_lock. IOW, why grab ilock for stale
> > > inodes when we're just going to skip them?
> > 
> > Because I was worrying about serialising against reclaim before
> > changing the state of the inode. i.e. if the inode has already been
> > isolated by not yet disposed of, we shouldn't touch the inode state
> > at all. Serialisation against reclaim in this patch is via the
> > ILOCK, hence we need to do that before setting ISTALE....
> > 
> 
> Yeah, I think my question still isn't clear... I'm not talking about
> setting ISTALE. The code I referenced above is where we test for it and
> skip the inode if it is already set. For example, the code referenced
> above in xfs_ifree_get_one_inode() currently does the following with
> respect to i_flags_lock, ILOCK and XFS_ISTALE:
> 
> 	...
> 	spin_lock(i_flags_lock)
> 	xfs_ilock_nowait(XFS_ILOCK_EXCL)
> 	if !XFS_ISTALE
> 		skip
> 	set XFS_ISTALE
> 	...

There is another place in xfs_ifree_cluster that sets ISTALE without
the ILOCK held, so the ILOCK is being used here for a different
purpose...

> The reclaim isolate code does this, however:
> 
> 	spin_trylock(i_flags_lock)
> 	if !XFS_ISTALE
> 		skip
> 	xfs_ilock(XFS_ILOCK_EXCL)
> 	...	

Which is fine, because we're not trying to avoid racing with reclaim
here. :) i.e. all we need is the i_flags lock to check the ISTALE
flag safely.

> So my question is why not do something like the following in the
> _get_one_inode() case?
> 
> 	...
> 	spin_lock(i_flags_lock)
> 	if !XFS_ISTALE
> 		skip
> 	xfs_ilock_nowait(XFS_ILOCK_EXCL)
> 	set XFS_ISTALE
> 	...

Because, like I said, I focussed on the lookup racing with reclaim
first. The above code could be used, but it puts object internal
state checks before we really know whether the object is safe to
access and whether we can trust it.

I'm just following a basic RCU/lockless lookup principle here:
don't try to use object state before you've fully validated that the
object is live and guaranteed that it can be safely referenced.

> IOW, what is the need, if any, to acquire ilock in the iflush/ifree
> paths before testing for XFS_ISTALE? Is there some specific intermediate
> state I'm missing or is this just unintentional?

It's entirely intentional - validate and claim the object we've
found in the lockless lookup, then run the code that checks/changes
the object state. Smashing state checks and lockless lookup
validation together is a nasty landmine to leave behind...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
