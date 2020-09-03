Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A602225BED5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 12:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgICKKO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 06:10:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:46510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgICKKH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:10:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB406B692;
        Thu,  3 Sep 2020 10:10:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3998D1E12D1; Thu,  3 Sep 2020 12:10:04 +0200 (CEST)
Date:   Thu, 3 Sep 2020 12:10:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Martijn Coenen <maco@android.com>,
        xfs <linux-xfs@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 4/4] writeback: Drop I_DIRTY_TIME_EXPIRE
Message-ID: <20200903101004.GA17269@quack2.suse.cz>
References: <20200611075033.1248-1-jack@suse.cz>
 <20200611081203.18161-4-jack@suse.cz>
 <20200902172048.GI6090@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902172048.GI6090@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-09-20 10:20:48, Darrick J. Wong wrote:
> [add linux-xfs and xfsprogs maintainer to cc]
> 
> On Thu, Jun 11, 2020 at 10:11:55AM +0200, Jan Kara wrote:
> > The only use of I_DIRTY_TIME_EXPIRE is to detect in
> > __writeback_single_inode() that inode got there because flush worker
> > decided it's time to writeback the dirty inode time stamps (either
> > because we are syncing or because of age). However we can detect this
> > directly in __writeback_single_inode() and there's no need for the
> > strange propagation with I_DIRTY_TIME_EXPIRE flag.
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/inode.c                  |  2 +-
> >  fs/fs-writeback.c                | 28 +++++++++++-----------------
> >  fs/xfs/libxfs/xfs_trans_inode.c  |  4 ++--
> 
> Urrk, so I only just noticed this when I rebased my development tree
> onto 5.9-rc3.  If you're going to change things in fs/xfs/, please cc
> the xfs list to keep us in the loop.  Changes to fs/xfs/libxfs/ have to
> be ported to userspace.

OK, will do next time. I was just dropping a generic flag XFS didn't use in
any particular way so it didn't occur to me XFS people would be interested...

								Honza

> >  include/linux/fs.h               |  1 -
> >  include/trace/events/writeback.h |  1 -
> >  5 files changed, 14 insertions(+), 22 deletions(-)
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 40ec5c7ef0d3..4db497f02ffb 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -4887,7 +4887,7 @@ static void __ext4_update_other_inode_time(struct super_block *sb,
> >  	    (inode->i_state & I_DIRTY_TIME)) {
> >  		struct ext4_inode_info	*ei = EXT4_I(inode);
> >  
> > -		inode->i_state &= ~(I_DIRTY_TIME | I_DIRTY_TIME_EXPIRED);
> > +		inode->i_state &= ~I_DIRTY_TIME;
> >  		spin_unlock(&inode->i_lock);
> >  
> >  		spin_lock(&ei->i_raw_lock);
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index ae17d64a3e18..149227160ff0 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -1238,7 +1238,7 @@ static bool inode_dirtied_after(struct inode *inode, unsigned long t)
> >   */
> >  static int move_expired_inodes(struct list_head *delaying_queue,
> >  			       struct list_head *dispatch_queue,
> > -			       int flags, unsigned long dirtied_before)
> > +			       unsigned long dirtied_before)
> >  {
> >  	LIST_HEAD(tmp);
> >  	struct list_head *pos, *node;
> > @@ -1254,8 +1254,6 @@ static int move_expired_inodes(struct list_head *delaying_queue,
> >  		list_move(&inode->i_io_list, &tmp);
> >  		moved++;
> >  		spin_lock(&inode->i_lock);
> > -		if (flags & EXPIRE_DIRTY_ATIME)
> > -			inode->i_state |= I_DIRTY_TIME_EXPIRED;
> >  		inode->i_state |= I_SYNC_QUEUED;
> >  		spin_unlock(&inode->i_lock);
> >  		if (sb_is_blkdev_sb(inode->i_sb))
> > @@ -1303,11 +1301,11 @@ static void queue_io(struct bdi_writeback *wb, struct wb_writeback_work *work,
> >  
> >  	assert_spin_locked(&wb->list_lock);
> >  	list_splice_init(&wb->b_more_io, &wb->b_io);
> > -	moved = move_expired_inodes(&wb->b_dirty, &wb->b_io, 0, dirtied_before);
> > +	moved = move_expired_inodes(&wb->b_dirty, &wb->b_io, dirtied_before);
> >  	if (!work->for_sync)
> >  		time_expire_jif = jiffies - dirtytime_expire_interval * HZ;
> >  	moved += move_expired_inodes(&wb->b_dirty_time, &wb->b_io,
> > -				     EXPIRE_DIRTY_ATIME, time_expire_jif);
> > +				     time_expire_jif);
> >  	if (moved)
> >  		wb_io_lists_populated(wb);
> >  	trace_writeback_queue_io(wb, work, dirtied_before, moved);
> > @@ -1483,18 +1481,14 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
> >  	spin_lock(&inode->i_lock);
> >  
> >  	dirty = inode->i_state & I_DIRTY;
> > -	if (inode->i_state & I_DIRTY_TIME) {
> > -		if ((dirty & I_DIRTY_INODE) ||
> > -		    wbc->sync_mode == WB_SYNC_ALL ||
> > -		    unlikely(inode->i_state & I_DIRTY_TIME_EXPIRED) ||
> > -		    unlikely(time_after(jiffies,
> > -					(inode->dirtied_time_when +
> > -					 dirtytime_expire_interval * HZ)))) {
> > -			dirty |= I_DIRTY_TIME | I_DIRTY_TIME_EXPIRED;
> > -			trace_writeback_lazytime(inode);
> > -		}
> > -	} else
> > -		inode->i_state &= ~I_DIRTY_TIME_EXPIRED;
> > +	if ((inode->i_state & I_DIRTY_TIME) &&
> > +	    ((dirty & I_DIRTY_INODE) ||
> > +	     wbc->sync_mode == WB_SYNC_ALL || wbc->for_sync ||
> > +	     time_after(jiffies, inode->dirtied_time_when +
> > +			dirtytime_expire_interval * HZ))) {
> > +		dirty |= I_DIRTY_TIME;
> > +		trace_writeback_lazytime(inode);
> > +	}
> >  	inode->i_state &= ~dirty;
> >  
> >  	/*
> > diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
> > index b5dfb6654842..1b4df6636944 100644
> > --- a/fs/xfs/libxfs/xfs_trans_inode.c
> > +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> > @@ -96,9 +96,9 @@ xfs_trans_log_inode(
> >  	 * to log the timestamps, or will clear already cleared fields in the
> >  	 * worst case.
> >  	 */
> > -	if (inode->i_state & (I_DIRTY_TIME | I_DIRTY_TIME_EXPIRED)) {
> > +	if (inode->i_state & I_DIRTY_TIME) {
> >  		spin_lock(&inode->i_lock);
> > -		inode->i_state &= ~(I_DIRTY_TIME | I_DIRTY_TIME_EXPIRED);
> > +		inode->i_state &= ~I_DIRTY_TIME;
> >  		spin_unlock(&inode->i_lock);
> >  	}
> >  
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 48556efcdcf0..45eadf5bea5d 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2178,7 +2178,6 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
> >  #define I_DIO_WAKEUP		(1 << __I_DIO_WAKEUP)
> >  #define I_LINKABLE		(1 << 10)
> >  #define I_DIRTY_TIME		(1 << 11)
> > -#define I_DIRTY_TIME_EXPIRED	(1 << 12)
> >  #define I_WB_SWITCH		(1 << 13)
> >  #define I_OVL_INUSE		(1 << 14)
> >  #define I_CREATING		(1 << 15)
> > diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> > index 7565dcd59697..e7cbccc7c14c 100644
> > --- a/include/trace/events/writeback.h
> > +++ b/include/trace/events/writeback.h
> > @@ -20,7 +20,6 @@
> >  		{I_CLEAR,		"I_CLEAR"},		\
> >  		{I_SYNC,		"I_SYNC"},		\
> >  		{I_DIRTY_TIME,		"I_DIRTY_TIME"},	\
> > -		{I_DIRTY_TIME_EXPIRED,	"I_DIRTY_TIME_EXPIRED"}, \
> >  		{I_REFERENCED,		"I_REFERENCED"}		\
> >  	)
> >  
> > -- 
> > 2.16.4
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
