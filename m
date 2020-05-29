Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9121E81A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 17:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgE2PUl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 11:20:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:34384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgE2PUl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 11:20:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 72902B07D;
        Fri, 29 May 2020 15:20:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 024501E1289; Fri, 29 May 2020 17:20:36 +0200 (CEST)
Date:   Fri, 29 May 2020 17:20:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Martijn Coenen <maco@android.com>
Cc:     Jan Kara <jack@suse.cz>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, miklos@szeredi.hu, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Subject: Re: Writeback bug causing writeback stalls
Message-ID: <20200529152036.GA22885@quack2.suse.cz>
References: <CAB0TPYGCOZmixbzrV80132X=V5TcyQwD6V7x-8PKg_BqCva8Og@mail.gmail.com>
 <20200522144100.GE14199@quack2.suse.cz>
 <CAB0TPYF+Nqd63Xf_JkuepSJV7CzndBw6_MUqcnjusy4ztX24hQ@mail.gmail.com>
 <20200522153615.GF14199@quack2.suse.cz>
 <CAB0TPYGJ6WkaKLoqQhsxa2FQ4s-jYKkDe1BDJ89CE_QUM_aBVw@mail.gmail.com>
 <20200525073140.GI14199@quack2.suse.cz>
 <CAB0TPYHVfkYyFYqp96-PfcP60PKRX6VqrfMHJPkG=UT2956EqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <CAB0TPYHVfkYyFYqp96-PfcP60PKRX6VqrfMHJPkG=UT2956EqQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Martinj!

On Wed 27-05-20 10:14:09, Martijn Coenen wrote:
> On Mon, May 25, 2020 at 9:31 AM Jan Kara <jack@suse.cz> wrote:
> > Well, most importantly filesystems like ext4, xfs, btrfs don't hold i_rwsem
> > when writing back inode and that's deliberate because of performance. We
> > don't want to block writes (or event reads in case of XFS) for the inode
> > during writeback.
> 
> Thanks for clarifying, that makes sense. By the way, do you have an
> ETA for your fix? We are under some time pressure to get this fixed in
> our downstream kernels, but I'd much rather take a fix from upstream
> from somebody who knows this code well. Alternatively, I can take a
> stab at the idea you proposed and send a patch to LKML for review this
> week.

I understand. I have written a fix (attached). Currently its under testing
together with other cleanups. If everything works fine, I plan to submit
the patches on Monday.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--RnlQjJ0d97Da+TV1
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-writeback-Avoid-skipping-inode-writeback.patch"

From 6d0d46bfddccff7aa4ed114ce15c23dfb68ad2b2 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Fri, 29 May 2020 15:05:22 +0200
Subject: [PATCH] writeback: Avoid skipping inode writeback

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
 fs/fs-writeback.c  | 39 +++++++++++++++++++++++++++++----------
 include/linux/fs.h |  8 ++++++--
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 76ac9c7d32ec..855c6611710a 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -144,7 +144,9 @@ static void inode_io_list_del_locked(struct inode *inode,
 				     struct bdi_writeback *wb)
 {
 	assert_spin_locked(&wb->list_lock);
+	assert_spin_locked(&inode->i_lock);
 
+	inode->i_state &= ~I_SYNC_QUEUED;
 	list_del_init(&inode->i_io_list);
 	wb_io_lists_depopulated(wb);
 }
@@ -1123,7 +1125,9 @@ void inode_io_list_del(struct inode *inode)
 	struct bdi_writeback *wb;
 
 	wb = inode_to_wb_and_lock_list(inode);
+	spin_lock(&inode->i_lock);
 	inode_io_list_del_locked(inode, wb);
+	spin_unlock(&inode->i_lock);
 	spin_unlock(&wb->list_lock);
 }
 
@@ -1172,8 +1176,9 @@ void sb_clear_inode_writeback(struct inode *inode)
  * the case then the inode must have been redirtied while it was being written
  * out and we don't reset its dirtied_when.
  */
-static void redirty_tail(struct inode *inode, struct bdi_writeback *wb)
+static void __redirty_tail(struct inode *inode, struct bdi_writeback *wb)
 {
+	assert_spin_locked(&inode->i_lock);
 	if (!list_empty(&wb->b_dirty)) {
 		struct inode *tail;
 
@@ -1182,6 +1187,14 @@ static void redirty_tail(struct inode *inode, struct bdi_writeback *wb)
 			inode->dirtied_when = jiffies;
 	}
 	inode_io_list_move_locked(inode, wb, &wb->b_dirty);
+	inode->i_state &= ~I_SYNC_QUEUED;
+}
+
+static void redirty_tail(struct inode *inode, struct bdi_writeback *wb)
+{
+	spin_lock(&inode->i_lock);
+	__redirty_tail(inode, wb);
+	spin_unlock(&inode->i_lock);
 }
 
 /*
@@ -1250,8 +1263,11 @@ static int move_expired_inodes(struct list_head *delaying_queue,
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
@@ -1394,7 +1410,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 		 * writeback is not making progress due to locked
 		 * buffers. Skip this inode for now.
 		 */
-		redirty_tail(inode, wb);
+		__redirty_tail(inode, wb);
 		return;
 	}
 
@@ -1414,7 +1430,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 			 * retrying writeback of the dirty page/inode
 			 * that cannot be performed immediately.
 			 */
-			redirty_tail(inode, wb);
+			__redirty_tail(inode, wb);
 		}
 	} else if (inode->i_state & I_DIRTY) {
 		/*
@@ -1422,10 +1438,11 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 		 * such as delayed allocation during submission or metadata
 		 * updates after data IO completion.
 		 */
-		redirty_tail(inode, wb);
+		__redirty_tail(inode, wb);
 	} else if (inode->i_state & I_DIRTY_TIME) {
 		inode->dirtied_when = jiffies;
 		inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
+		inode->i_state &= ~I_SYNC_QUEUED;
 	} else {
 		/* The inode is clean. Remove from writeback lists. */
 		inode_io_list_del_locked(inode, wb);
@@ -1669,8 +1686,9 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 */
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
+			inode->i_state &= ~I_SYNC_QUEUED;
+			__redirty_tail(inode, wb);
 			spin_unlock(&inode->i_lock);
-			redirty_tail(inode, wb);
 			continue;
 		}
 		if ((inode->i_state & I_SYNC) && wbc.sync_mode != WB_SYNC_ALL) {
@@ -2289,11 +2307,12 @@ void __mark_inode_dirty(struct inode *inode, int flags)
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
index 45cc10cdf6dd..b02290d19edd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2156,6 +2156,10 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  *
  * I_CREATING		New object's inode in the middle of setting up.
  *
+ * I_SYNC_QUEUED	Inode is queued in b_io or b_more_io writeback lists.
+ *			Used to detect that mark_inode_dirty() should not move
+ * 			inode between dirty lists.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  */
 #define I_DIRTY_SYNC		(1 << 0)
@@ -2173,11 +2177,11 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_DIO_WAKEUP		(1 << __I_DIO_WAKEUP)
 #define I_LINKABLE		(1 << 10)
 #define I_DIRTY_TIME		(1 << 11)
-#define __I_DIRTY_TIME_EXPIRED	12
-#define I_DIRTY_TIME_EXPIRED	(1 << __I_DIRTY_TIME_EXPIRED)
+#define I_DIRTY_TIME_EXPIRED	(1 << 12)
 #define I_WB_SWITCH		(1 << 13)
 #define I_OVL_INUSE		(1 << 14)
 #define I_CREATING		(1 << 15)
+#define I_SYNC_QUEUED		(1 << 16)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
-- 
2.16.4


--RnlQjJ0d97Da+TV1--
