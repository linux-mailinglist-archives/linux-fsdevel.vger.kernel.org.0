Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674D31EA0DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 11:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgFAJTa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 05:19:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:38726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgFAJTH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:19:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 433E4B05D;
        Mon,  1 Jun 2020 09:19:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DEDA21E0B00; Mon,  1 Jun 2020 11:19:04 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Martijn Coenen <maco@android.com>,
        tj@kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] writeback: Fix sync livelock due to b_dirty_time processing
Date:   Mon,  1 Jun 2020 11:18:56 +0200
Message-Id: <20200601091904.4786-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200601091202.31302-1-jack@suse.cz>
References: <20200601091202.31302-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we are processing writeback for sync(2), move_expired_inodes()
didn't set any inode expiry value (older_than_this). This can result in
writeback never completing if there's steady stream of inodes added to
b_dirty_time list as writeback rechecks dirty lists after each writeback
round whether there's more work to be done. Fix the problem by using
sync(2) start time is inode expiry value when processing b_dirty_time
list similarly as for ordinarily dirtied inodes. This requires some
refactoring of older_than_this handling which simplifies the code
noticeably as a bonus.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c                | 37 ++++++++++++++-----------------------
 include/trace/events/writeback.h |  9 ++++-----
 2 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 855c6611710a..b9aa4ff83bbd 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -42,7 +42,6 @@
 struct wb_writeback_work {
 	long nr_pages;
 	struct super_block *sb;
-	unsigned long *older_than_this;
 	enum writeback_sync_modes sync_mode;
 	unsigned int tagged_writepages:1;
 	unsigned int for_kupdate:1;
@@ -1233,16 +1232,14 @@ static bool inode_dirtied_after(struct inode *inode, unsigned long t)
 #define EXPIRE_DIRTY_ATIME 0x0001
 
 /*
- * Move expired (dirtied before work->older_than_this) dirty inodes from
+ * Move expired (dirtied before older_than_this) dirty inodes from
  * @delaying_queue to @dispatch_queue.
  */
 static int move_expired_inodes(struct list_head *delaying_queue,
 			       struct list_head *dispatch_queue,
 			       int flags,
-			       struct wb_writeback_work *work)
+			       unsigned long older_than_this)
 {
-	unsigned long *older_than_this = NULL;
-	unsigned long expire_time;
 	LIST_HEAD(tmp);
 	struct list_head *pos, *node;
 	struct super_block *sb = NULL;
@@ -1250,16 +1247,9 @@ static int move_expired_inodes(struct list_head *delaying_queue,
 	int do_sb_sort = 0;
 	int moved = 0;
 
-	if ((flags & EXPIRE_DIRTY_ATIME) == 0)
-		older_than_this = work->older_than_this;
-	else if (!work->for_sync) {
-		expire_time = jiffies - (dirtytime_expire_interval * HZ);
-		older_than_this = &expire_time;
-	}
 	while (!list_empty(delaying_queue)) {
 		inode = wb_inode(delaying_queue->prev);
-		if (older_than_this &&
-		    inode_dirtied_after(inode, *older_than_this))
+		if (inode_dirtied_after(inode, older_than_this))
 			break;
 		list_move(&inode->i_io_list, &tmp);
 		moved++;
@@ -1305,18 +1295,22 @@ static int move_expired_inodes(struct list_head *delaying_queue,
  *                                           |
  *                                           +--> dequeue for IO
  */
-static void queue_io(struct bdi_writeback *wb, struct wb_writeback_work *work)
+static void queue_io(struct bdi_writeback *wb, struct wb_writeback_work *work,
+		     unsigned long older_than_this)
 {
 	int moved;
+	unsigned long time_expire_jif = older_than_this;
 
 	assert_spin_locked(&wb->list_lock);
 	list_splice_init(&wb->b_more_io, &wb->b_io);
-	moved = move_expired_inodes(&wb->b_dirty, &wb->b_io, 0, work);
+	moved = move_expired_inodes(&wb->b_dirty, &wb->b_io, 0, older_than_this);
+	if (!work->for_sync)
+		time_expire_jif = jiffies - dirtytime_expire_interval * HZ;
 	moved += move_expired_inodes(&wb->b_dirty_time, &wb->b_io,
-				     EXPIRE_DIRTY_ATIME, work);
+				     EXPIRE_DIRTY_ATIME, time_expire_jif);
 	if (moved)
 		wb_io_lists_populated(wb);
-	trace_writeback_queue_io(wb, work, moved);
+	trace_writeback_queue_io(wb, work, older_than_this, moved);
 }
 
 static int write_inode(struct inode *inode, struct writeback_control *wbc)
@@ -1829,7 +1823,7 @@ static long writeback_inodes_wb(struct bdi_writeback *wb, long nr_pages,
 	blk_start_plug(&plug);
 	spin_lock(&wb->list_lock);
 	if (list_empty(&wb->b_io))
-		queue_io(wb, &work);
+		queue_io(wb, &work, jiffies);
 	__writeback_inodes_wb(wb, &work);
 	spin_unlock(&wb->list_lock);
 	blk_finish_plug(&plug);
@@ -1857,14 +1851,11 @@ static long wb_writeback(struct bdi_writeback *wb,
 {
 	unsigned long wb_start = jiffies;
 	long nr_pages = work->nr_pages;
-	unsigned long oldest_jif;
+	unsigned long oldest_jif = jiffies;
 	struct inode *inode;
 	long progress;
 	struct blk_plug plug;
 
-	oldest_jif = jiffies;
-	work->older_than_this = &oldest_jif;
-
 	blk_start_plug(&plug);
 	spin_lock(&wb->list_lock);
 	for (;;) {
@@ -1905,7 +1896,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 
 		trace_writeback_start(wb, work);
 		if (list_empty(&wb->b_io))
-			queue_io(wb, work);
+			queue_io(wb, work, oldest_jif);
 		if (work->sb)
 			progress = writeback_sb_inodes(work->sb, wb, work);
 		else
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 85a33bea76f1..b4500bdee2c0 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -498,8 +498,9 @@ DEFINE_WBC_EVENT(wbc_writepage);
 TRACE_EVENT(writeback_queue_io,
 	TP_PROTO(struct bdi_writeback *wb,
 		 struct wb_writeback_work *work,
+		 unsigned long older_than_this,
 		 int moved),
-	TP_ARGS(wb, work, moved),
+	TP_ARGS(wb, work, older_than_this, moved),
 	TP_STRUCT__entry(
 		__array(char,		name, 32)
 		__field(unsigned long,	older)
@@ -509,11 +510,9 @@ TRACE_EVENT(writeback_queue_io,
 		__field(ino_t,		cgroup_ino)
 	),
 	TP_fast_assign(
-		unsigned long *older_than_this = work->older_than_this;
 		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
-		__entry->older	= older_than_this ?  *older_than_this : 0;
-		__entry->age	= older_than_this ?
-				  (jiffies - *older_than_this) * 1000 / HZ : -1;
+		__entry->older	= older_than_this;
+		__entry->age	= (jiffies - older_than_this) * 1000 / HZ;
 		__entry->moved	= moved;
 		__entry->reason	= work->reason;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
-- 
2.16.4

