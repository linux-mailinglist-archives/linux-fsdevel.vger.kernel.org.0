Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1831F6351
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgFKIMI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 04:12:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:58480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgFKIMG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:12:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BC7A1AC53;
        Thu, 11 Jun 2020 08:12:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 995401E1289; Thu, 11 Jun 2020 10:12:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Martijn Coenen <maco@android.com>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org
Subject: [PATCH 2/4] writeback: Avoid skipping inode writeback
Date:   Thu, 11 Jun 2020 10:11:53 +0200
Message-Id: <20200611081203.18161-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200611075033.1248-1-jack@suse.cz>
References: <20200611075033.1248-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Inode's i_io_list list head is used to attach inode to several different
lists - wb->{b_dirty, b_dirty_time, b_io, b_more_io}. When flush worker
prepares a list of inodes to writeback e.g. for sync(2), it moves inodes
to b_io list. Thus it is critical for sync(2) data integrity guarantees
that inode is not requeued to any other writeback list when inode is
queued for processing by flush worker. That's the reason why
writeback_single_inode() does not touch i_io_list (unless the inode is
completely clean) and why __mark_inode_dirty() does not touch i_io_list
if I_SYNC flag is set.

However there are two flaws in the current logic:

1) When inode has only I_DIRTY_TIME set but it is already queued in b_io
list due to sync(2), concurrent __mark_inode_dirty(inode, I_DIRTY_SYNC)
can still move inode back to b_dirty list resulting in skipping
writeback of inode time stamps during sync(2).

2) When inode is on b_dirty_time list and writeback_single_inode() races
with __mark_inode_dirty() like:

writeback_single_inode()		__mark_inode_dirty(inode, I_DIRTY_PAGES)
  inode->i_state |= I_SYNC
  __writeback_single_inode()
					  inode->i_state |= I_DIRTY_PAGES;
					  if (inode->i_state & I_SYNC)
					    bail
  if (!(inode->i_state & I_DIRTY_ALL))
  - not true so nothing done

We end up with I_DIRTY_PAGES inode on b_dirty_time list and thus
standard background writeback will not writeback this inode leading to
possible dirty throttling stalls etc. (thanks to Martijn Coenen for this
analysis).

Fix these problems by tracking whether inode is queued in b_io or
b_more_io lists in a new I_SYNC_QUEUED flag. When this flag is set, we
know flush worker has queued inode and we should not touch i_io_list.
On the other hand we also know that once flush worker is done with the
inode it will requeue the inode to appropriate dirty list. When
I_SYNC_QUEUED is not set, __mark_inode_dirty() can (and must) move inode
to appropriate dirty list.

Reported-by: Martijn Coenen <maco@android.com>
Fixes: 0ae45f63d4ef ("vfs: add support for a lazytime mount option")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c  | 17 ++++++++++++-----
 include/linux/fs.h |  8 ++++++--
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index ff0b18331590..f470c10641c5 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -146,6 +146,7 @@ static void inode_io_list_del_locked(struct inode *inode,
 	assert_spin_locked(&wb->list_lock);
 	assert_spin_locked(&inode->i_lock);
 
+	inode->i_state &= ~I_SYNC_QUEUED;
 	list_del_init(&inode->i_io_list);
 	wb_io_lists_depopulated(wb);
 }
@@ -1187,6 +1188,7 @@ static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
 			inode->dirtied_when = jiffies;
 	}
 	inode_io_list_move_locked(inode, wb, &wb->b_dirty);
+	inode->i_state &= ~I_SYNC_QUEUED;
 }
 
 static void redirty_tail(struct inode *inode, struct bdi_writeback *wb)
@@ -1262,8 +1264,11 @@ static int move_expired_inodes(struct list_head *delaying_queue,
 			break;
 		list_move(&inode->i_io_list, &tmp);
 		moved++;
+		spin_lock(&inode->i_lock);
 		if (flags & EXPIRE_DIRTY_ATIME)
-			set_bit(__I_DIRTY_TIME_EXPIRED, &inode->i_state);
+			inode->i_state |= I_DIRTY_TIME_EXPIRED;
+		inode->i_state |= I_SYNC_QUEUED;
+		spin_unlock(&inode->i_lock);
 		if (sb_is_blkdev_sb(inode->i_sb))
 			continue;
 		if (sb && sb != inode->i_sb)
@@ -1438,6 +1443,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 	} else if (inode->i_state & I_DIRTY_TIME) {
 		inode->dirtied_when = jiffies;
 		inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
+		inode->i_state &= ~I_SYNC_QUEUED;
 	} else {
 		/* The inode is clean. Remove from writeback lists. */
 		inode_io_list_del_locked(inode, wb);
@@ -2301,11 +2307,12 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 		inode->i_state |= flags;
 
 		/*
-		 * If the inode is being synced, just update its dirty state.
-		 * The unlocker will place the inode on the appropriate
-		 * superblock list, based upon its state.
+		 * If the inode is queued for writeback by flush worker, just
+		 * update its dirty state. Once the flush worker is done with
+		 * the inode it will place it on the appropriate superblock
+		 * list, based upon its state.
 		 */
-		if (inode->i_state & I_SYNC)
+		if (inode->i_state & I_SYNC_QUEUED)
 			goto out_unlock_inode;
 
 		/*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 19ef6c88c152..48556efcdcf0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2157,6 +2157,10 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  *
  * I_DONTCACHE		Evict inode as soon as it is not used anymore.
  *
+ * I_SYNC_QUEUED	Inode is queued in b_io or b_more_io writeback lists.
+ *			Used to detect that mark_inode_dirty() should not move
+ * 			inode between dirty lists.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  */
 #define I_DIRTY_SYNC		(1 << 0)
@@ -2174,12 +2178,12 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_DIO_WAKEUP		(1 << __I_DIO_WAKEUP)
 #define I_LINKABLE		(1 << 10)
 #define I_DIRTY_TIME		(1 << 11)
-#define __I_DIRTY_TIME_EXPIRED	12
-#define I_DIRTY_TIME_EXPIRED	(1 << __I_DIRTY_TIME_EXPIRED)
+#define I_DIRTY_TIME_EXPIRED	(1 << 12)
 #define I_WB_SWITCH		(1 << 13)
 #define I_OVL_INUSE		(1 << 14)
 #define I_CREATING		(1 << 15)
 #define I_DONTCACHE		(1 << 16)
+#define I_SYNC_QUEUED		(1 << 17)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
-- 
2.16.4

