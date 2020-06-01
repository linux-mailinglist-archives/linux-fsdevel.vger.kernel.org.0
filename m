Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25831EA0D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 11:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgFAJTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 05:19:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:38730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgFAJTH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:19:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 43A48B118;
        Mon,  1 Jun 2020 09:19:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E384B1E0E58; Mon,  1 Jun 2020 11:19:04 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Martijn Coenen <maco@android.com>,
        tj@kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] writeback: Drop I_DIRTY_TIME_EXPIRE
Date:   Mon,  1 Jun 2020 11:18:57 +0200
Message-Id: <20200601091904.4786-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200601091202.31302-1-jack@suse.cz>
References: <20200601091202.31302-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only use of I_DIRTY_TIME_EXPIRE is to detect in
__writeback_single_inode() that inode got there because flush worker
decided it's time to writeback the dirty inode time stamps (either
because we are syncing or because of age). However we can detect this
directly in __writeback_single_inode() and there's no need for the
strange propagation with I_DIRTY_TIME_EXPIRE flag.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c                  |  2 +-
 fs/fs-writeback.c                | 15 +++++----------
 fs/xfs/libxfs/xfs_trans_inode.c  |  4 ++--
 include/linux/fs.h               |  1 -
 include/trace/events/writeback.h |  1 -
 5 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2a4aae6acdcb..038cfe85f9cb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4881,7 +4881,7 @@ static int other_inode_match(struct inode * inode, unsigned long ino,
 	    (inode->i_state & I_DIRTY_TIME)) {
 		struct ext4_inode_info	*ei = EXT4_I(inode);
 
-		inode->i_state &= ~(I_DIRTY_TIME | I_DIRTY_TIME_EXPIRED);
+		inode->i_state &= ~I_DIRTY_TIME;
 		spin_unlock(&inode->i_lock);
 
 		spin_lock(&ei->i_raw_lock);
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index b9aa4ff83bbd..62e2e1ed345a 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1237,7 +1237,6 @@ static bool inode_dirtied_after(struct inode *inode, unsigned long t)
  */
 static int move_expired_inodes(struct list_head *delaying_queue,
 			       struct list_head *dispatch_queue,
-			       int flags,
 			       unsigned long older_than_this)
 {
 	LIST_HEAD(tmp);
@@ -1254,8 +1253,6 @@ static int move_expired_inodes(struct list_head *delaying_queue,
 		list_move(&inode->i_io_list, &tmp);
 		moved++;
 		spin_lock(&inode->i_lock);
-		if (flags & EXPIRE_DIRTY_ATIME)
-			inode->i_state |= I_DIRTY_TIME_EXPIRED;
 		inode->i_state |= I_SYNC_QUEUED;
 		spin_unlock(&inode->i_lock);
 		if (sb_is_blkdev_sb(inode->i_sb))
@@ -1303,11 +1300,11 @@ static void queue_io(struct bdi_writeback *wb, struct wb_writeback_work *work,
 
 	assert_spin_locked(&wb->list_lock);
 	list_splice_init(&wb->b_more_io, &wb->b_io);
-	moved = move_expired_inodes(&wb->b_dirty, &wb->b_io, 0, older_than_this);
+	moved = move_expired_inodes(&wb->b_dirty, &wb->b_io, older_than_this);
 	if (!work->for_sync)
 		time_expire_jif = jiffies - dirtytime_expire_interval * HZ;
 	moved += move_expired_inodes(&wb->b_dirty_time, &wb->b_io,
-				     EXPIRE_DIRTY_ATIME, time_expire_jif);
+				     time_expire_jif);
 	if (moved)
 		wb_io_lists_populated(wb);
 	trace_writeback_queue_io(wb, work, older_than_this, moved);
@@ -1485,16 +1482,14 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	dirty = inode->i_state & I_DIRTY;
 	if (inode->i_state & I_DIRTY_TIME) {
 		if ((dirty & I_DIRTY_INODE) ||
-		    wbc->sync_mode == WB_SYNC_ALL ||
-		    unlikely(inode->i_state & I_DIRTY_TIME_EXPIRED) ||
+		    wbc->sync_mode == WB_SYNC_ALL || wbc->for_sync ||
 		    unlikely(time_after(jiffies,
 					(inode->dirtied_time_when +
 					 dirtytime_expire_interval * HZ)))) {
-			dirty |= I_DIRTY_TIME | I_DIRTY_TIME_EXPIRED;
+			dirty |= I_DIRTY_TIME;
 			trace_writeback_lazytime(inode);
 		}
-	} else
-		inode->i_state &= ~I_DIRTY_TIME_EXPIRED;
+	}
 	inode->i_state &= ~dirty;
 
 	/*
diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index 2b8ccb5b975d..3c903f2c498d 100644
--- a/fs/xfs/libxfs/xfs_trans_inode.c
+++ b/fs/xfs/libxfs/xfs_trans_inode.c
@@ -96,9 +96,9 @@ xfs_trans_log_inode(
 	 * to log the timestamps, or will clear already cleared fields in the
 	 * worst case.
 	 */
-	if (inode->i_state & (I_DIRTY_TIME | I_DIRTY_TIME_EXPIRED)) {
+	if (inode->i_state & I_DIRTY_TIME) {
 		spin_lock(&inode->i_lock);
-		inode->i_state &= ~(I_DIRTY_TIME | I_DIRTY_TIME_EXPIRED);
+		inode->i_state &= ~I_DIRTY_TIME;
 		spin_unlock(&inode->i_lock);
 	}
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b02290d19edd..2c141d53949f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2177,7 +2177,6 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_DIO_WAKEUP		(1 << __I_DIO_WAKEUP)
 #define I_LINKABLE		(1 << 10)
 #define I_DIRTY_TIME		(1 << 11)
-#define I_DIRTY_TIME_EXPIRED	(1 << 12)
 #define I_WB_SWITCH		(1 << 13)
 #define I_OVL_INUSE		(1 << 14)
 #define I_CREATING		(1 << 15)
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index b4500bdee2c0..a48e1f83fcdc 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -20,7 +20,6 @@
 		{I_CLEAR,		"I_CLEAR"},		\
 		{I_SYNC,		"I_SYNC"},		\
 		{I_DIRTY_TIME,		"I_DIRTY_TIME"},	\
-		{I_DIRTY_TIME_EXPIRED,	"I_DIRTY_TIME_EXPIRED"}, \
 		{I_REFERENCED,		"I_REFERENCED"}		\
 	)
 
-- 
2.16.4

