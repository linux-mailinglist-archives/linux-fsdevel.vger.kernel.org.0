Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6798F596614
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 01:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiHPXhg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 19:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiHPXhf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 19:37:35 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94AF690C65;
        Tue, 16 Aug 2022 16:37:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-52-176.pa.nsw.optusnet.com.au [49.181.52.176])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 5A2DB62D445;
        Wed, 17 Aug 2022 09:37:30 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oO67l-00Dz05-PZ; Wed, 17 Aug 2022 09:37:29 +1000
Date:   Wed, 17 Aug 2022 09:37:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, djwong@kernel.org,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
Message-ID: <20220816233729.GX3600936@dread.disaster.area>
References: <20220816131736.42615-1-jlayton@kernel.org>
 <CALF+zO=OrT5tBvyL1ERD+YDSXkSAFvqQu-cQkSgWvQN8z+E_rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALF+zO=OrT5tBvyL1ERD+YDSXkSAFvqQu-cQkSgWvQN8z+E_rA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62fc2a3b
        a=O3n/kZ8kT9QBBO3sWHYIyw==:117 a=O3n/kZ8kT9QBBO3sWHYIyw==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
        a=7-415B0cAAAA:8 a=Npwcd5ILmfyqQYfcuhoA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 01:14:55PM -0400, David Wysochanski wrote:
> On Tue, Aug 16, 2022 at 9:19 AM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > The i_version in xfs_trans_log_inode is bumped for any inode update,
> > including atime-only updates due to reads. We don't want to record those
> > in the i_version, as they don't represent "real" changes. Remove that
> > callsite.
> >
> > In xfs_vn_update_time, if S_VERSION is flagged, then attempt to bump the
> > i_version and turn on XFS_ILOG_CORE if it happens. In
> > xfs_trans_ichgtime, update the i_version if the mtime or ctime are being
> > updated.
> >
> > Cc: Darrick J. Wong <darrick.wong@oracle.com>
> > Cc: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/xfs/libxfs/xfs_trans_inode.c | 17 +++--------------
> >  fs/xfs/xfs_iops.c               |  4 ++++
> >  2 files changed, 7 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
> > index 8b5547073379..78bf7f491462 100644
> > --- a/fs/xfs/libxfs/xfs_trans_inode.c
> > +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> > @@ -71,6 +71,8 @@ xfs_trans_ichgtime(
> >                 inode->i_ctime = tv;
> >         if (flags & XFS_ICHGTIME_CREATE)
> >                 ip->i_crtime = tv;
> > +       if (flags & (XFS_ICHGTIME_MOD|XFS_ICHGTIME_CHG))
> > +               inode_inc_iversion(inode);
> >  }
> >
> >  /*
> > @@ -116,20 +118,7 @@ xfs_trans_log_inode(
> >                 spin_unlock(&inode->i_lock);
> >         }
> >
> > -       /*
> > -        * First time we log the inode in a transaction, bump the inode change
> > -        * counter if it is configured for this to occur. While we have the
> > -        * inode locked exclusively for metadata modification, we can usually
> > -        * avoid setting XFS_ILOG_CORE if no one has queried the value since
> > -        * the last time it was incremented. If we have XFS_ILOG_CORE already
> > -        * set however, then go ahead and bump the i_version counter
> > -        * unconditionally.
> > -        */
> > -       if (!test_and_set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags)) {
> > -               if (IS_I_VERSION(inode) &&
> > -                   inode_maybe_inc_iversion(inode, flags & XFS_ILOG_CORE))
> > -                       iversion_flags = XFS_ILOG_CORE;
> > -       }
> > +       set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags);
> >
> >         /*
> >          * If we're updating the inode core or the timestamps and it's possible
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index 45518b8c613c..162e044c7f56 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -718,6 +718,7 @@ xfs_setattr_nonsize(
> >         }
> >
> >         setattr_copy(mnt_userns, inode, iattr);
> > +       inode_inc_iversion(inode);
> >         xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
> >
> >         XFS_STATS_INC(mp, xs_ig_attrchg);
> > @@ -943,6 +944,7 @@ xfs_setattr_size(
> >
> >         ASSERT(!(iattr->ia_valid & (ATTR_UID | ATTR_GID)));
> >         setattr_copy(mnt_userns, inode, iattr);
> > +       inode_inc_iversion(inode);
> >         xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
> >
> >         XFS_STATS_INC(mp, xs_ig_attrchg);
> > @@ -1047,6 +1049,8 @@ xfs_vn_update_time(
> >                 inode->i_mtime = *now;
> >         if (flags & S_ATIME)
> >                 inode->i_atime = *now;
> > +       if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> > +               log_flags |= XFS_ILOG_CORE;
> >
> >         xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
> >         xfs_trans_log_inode(tp, ip, log_flags);
> > --
> > 2.37.2
> >
> 
> I have a test (details below) that shows an open issue with NFSv4.x +
> fscache where an xfs exported filesystem would trigger unnecessary
> over the wire READs after a umount/mount cycle of the NFS mount.  I
> previously tracked this down to atime updates, but never followed
> through on any patch.  Now that Jeff worked it out and this patch is
> under review, I built 5.19 vanilla, retested, then built 5.19 + this
> patch and verified the problem is fixed.

And so the question that needs to be answered is "why isn't relatime
working for this workload to avoid unnecessary atime updates"?

Which then makes me ask "what's changing atime on the server between
client side reads"?

Which then makes me wonder "what's actually changing iversion on the
server?" because I don't think atime is the issue here.

I suspect that Jeff's patch is affecting this test case by removing
iversion updates when the data is written back on the server. i.e.
delayed allocation and unwritten extent conversion will no longer
bump iversion when they log the inode metadata changes associated
with extent allocation to store the data being written.  There may
be other places where Jeff's patch removes implicit iversion
updates, too, so it may not be writeback that is the issue here.

How that impacts on the observed behaviour is dependent on things I
don't know, like what cachefiles is doing in the background,
especially across NFS client unmount/mount cycles. However, this all
makes me think the "atime is updated" behaviour is an observed
symptom of something else changing iversion and/or cmtime between
reads from the server...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
