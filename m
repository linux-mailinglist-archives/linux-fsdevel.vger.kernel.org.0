Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45F5D83B0E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 23:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfHFV2P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 17:28:15 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:43585 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbfHFV2P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:28:15 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 66E3A3611D8;
        Wed,  7 Aug 2019 07:28:11 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hv6z2-00059Y-Ao; Wed, 07 Aug 2019 07:27:04 +1000
Date:   Wed, 7 Aug 2019 07:27:04 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/24] xfs: don't block kswapd in inode reclaim
Message-ID: <20190806212704.GI7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-18-david@fromorbit.com>
 <20190806182131.GE2979@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806182131.GE2979@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=BnAoINNY7SeVK6BmJucA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 02:21:31PM -0400, Brian Foster wrote:
> On Thu, Aug 01, 2019 at 12:17:45PM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > We have a number of reasons for blocking kswapd in XFS inode
> > reclaim, mainly all to do with the fact that memory reclaim has no
> > feedback mechanisms to throttle on dirty slab objects that need IO
> > to reclaim.
> > 
> > As a result, we currently throttle inode reclaim by issuing IO in
> > the reclaim context. The unfortunate side effect of this is that it
> > can cause long tail latencies in reclaim and for some workloads this
> > can be a problem.
> > 
> > Now that the shrinkers finally have a method of telling kswapd to
> > back off, we can start the process of making inode reclaim in XFS
> > non-blocking. The first thing we need to do is not block kswapd, but
> > so that doesn't cause immediate serious problems, make sure inode
> > writeback is always underway when kswapd is running.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  fs/xfs/xfs_icache.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> > index 0b0fd10a36d4..2fa2f8dcf86b 100644
> > --- a/fs/xfs/xfs_icache.c
> > +++ b/fs/xfs/xfs_icache.c
> > @@ -1378,11 +1378,22 @@ xfs_reclaim_inodes_nr(
> >  	struct xfs_mount	*mp,
> >  	int			nr_to_scan)
> >  {
> > -	/* kick background reclaimer and push the AIL */
> > +	int			sync_mode = SYNC_TRYLOCK;
> > +
> > +	/* kick background reclaimer */
> >  	xfs_reclaim_work_queue(mp);
> > -	xfs_ail_push_all(mp->m_ail);
> >  
> > -	return xfs_reclaim_inodes_ag(mp, SYNC_TRYLOCK | SYNC_WAIT, &nr_to_scan);
> > +	/*
> > +	 * For kswapd, we kick background inode writeback. For direct
> > +	 * reclaim, we issue and wait on inode writeback to throttle
> > +	 * reclaim rates and avoid shouty OOM-death.
> > +	 */
> > +	if (current_is_kswapd())
> > +		xfs_ail_push_all(mp->m_ail);
> 
> So we're unblocking kswapd from dirty items, but we already kick the AIL
> regardless of kswapd or not in inode reclaim. Why the change to no
> longer kick the AIL in the !kswapd case? Whatever the reasoning, a
> mention in the commit log would be helpful...

Because we used to block reclaim, we never knew how long it would be
before it came back (say it had to write 1024 inode buffers), so
every time we entered reclaim here we kicked the AIL in case we did
get blocked for a long time.

Now kswapd doesn't block at all, we know it's going to enter this
code repeatedly while direct reclaim is blocked, and so we only need
it to kick background inode writeback via kswapd rather than all
reclaim now.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
