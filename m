Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50169FD0A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 22:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfKNVxx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 16:53:53 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:46844 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726812AbfKNVxx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:53:53 -0500
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id CCFE13A235F;
        Fri, 15 Nov 2019 08:53:50 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iVN3m-0003gD-4F; Fri, 15 Nov 2019 08:53:50 +1100
Date:   Fri, 15 Nov 2019 08:53:50 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/28] xfs: use xfs_ail_push_all in xfs_reclaim_inodes
Message-ID: <20191114215350.GI4614@dread.disaster.area>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-27-david@fromorbit.com>
 <20191106172215.GD37080@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106172215.GD37080@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=6BWFxZc-ePnZL1BRICgA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 06, 2019 at 12:22:15PM -0500, Brian Foster wrote:
> On Fri, Nov 01, 2019 at 10:46:16AM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > If we are reclaiming all inodes, it is likely we need to flush the
> > entire AIL to do that. We have mechanisms to do that without needing
> > to push to a specific LSN.
> > 
> > Convert xfs_relaim_all_inodes() to use xfs_ail_push_all variant so
> > we can get rid of the hacky xfs_ail_push_sync() scaffolding we used
> > to support the intermediate stages of the non-blocking reclaim
> > changeset.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  fs/xfs/xfs_icache.c     | 17 +++++++++++------
> >  fs/xfs/xfs_trans_ail.c  | 32 --------------------------------
> >  fs/xfs/xfs_trans_priv.h |  2 --
> >  3 files changed, 11 insertions(+), 40 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> > index 71a729e29260..11bf4768d491 100644
> > --- a/fs/xfs/xfs_icache.c
> > +++ b/fs/xfs/xfs_icache.c
> ...
> > @@ -1066,13 +1074,10 @@ xfs_reclaim_all_inodes(
> >  				      xfs_inode_reclaim_isolate, &ra, to_free);
> >  		xfs_dispose_inodes(&ra.freeable);
> >  
> > -		if (freed == 0) {
> > +		if (freed == 0)
> >  			xfs_log_force(mp, XFS_LOG_SYNC);
> > -			xfs_ail_push_all(mp->m_ail);
> > -		} else if (ra.lowest_lsn != NULLCOMMITLSN) {
> > -			xfs_ail_push_sync(mp->m_ail, ra.lowest_lsn);
> > -		}
> > -		cond_resched();
> > +		else if (ra.dirty_skipped)
> > +			congestion_wait(BLK_RW_ASYNC, HZ/10);
> 
> Why not use xfs_ail_push_all_sync() in this function and skip the direct
> stall? This is only used in the unmount and quiesce paths so the big
> hammer approach seems reasonable.

Ok, that's a good simplification :)

-Dave.
-- 
Dave Chinner
david@fromorbit.com
