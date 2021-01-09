Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCE12EFE8A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 09:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbhAIIBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 03:01:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbhAIIBG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:01:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 971DF23A7C;
        Sat,  9 Jan 2021 07:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610179186;
        bh=D2cLsgvBZJFGW9YnFrwrA+vuwvsBuSsiyb+lhDCp2YA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r5QndVHWjZk6u7rqhVsoxams/JD8MNoS8E8134pGAOKcfy/W4HnDInVFwg8sbEEFp
         7CHWAHWyQGIZoZ94yydkwzpAYhvMJVjbbgEVWlnMuxDKf7+Z2i0RO0Iv7oxCRhCAII
         AAktC4bPG7raefyxI2t2J3xz9PNXgYIHwLsRDAy+EIJc4gnOYAEg9v30npfco7nljx
         GorEyuHhWKODU/RpYM79+YYzl5L5vAf1Wdp0QxuBxG+91+l0APfc5JobO+OM+DATCD
         12YJuHKBOJhm05uzuD/Za3XLnD6cU5qNsKwkodBMng8GKiyR1lQSs4XDmiU2uqfyk8
         G/LTIYYbI+Svw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 09/12] fs: improve comments for writeback_single_inode()
Date:   Fri,  8 Jan 2021 23:59:00 -0800
Message-Id: <20210109075903.208222-10-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210109075903.208222-1-ebiggers@kernel.org>
References: <20210109075903.208222-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Some comments for writeback_single_inode() and
__writeback_single_inode() are outdated or not very helpful, especially
with regards to writeback list handling.  Update them.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fs-writeback.c | 57 +++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cee1df6e3bd43..e91980f493884 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1442,9 +1442,15 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 }
 
 /*
- * Write out an inode and its dirty pages. Do not update the writeback list
- * linkage. That is left to the caller. The caller is also responsible for
- * setting I_SYNC flag and calling inode_sync_complete() to clear it.
+ * Write out an inode and its dirty pages (or some of its dirty pages, depending
+ * on @wbc->nr_to_write), and clear the relevant dirty flags from i_state.
+ *
+ * This doesn't remove the inode from the writeback list it is on, except
+ * potentially to move it from b_dirty_time to b_dirty due to timestamp
+ * expiration.  The caller is otherwise responsible for writeback list handling.
+ *
+ * The caller is also responsible for setting the I_SYNC flag beforehand and
+ * calling inode_sync_complete() to clear it afterwards.
  */
 static int
 __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
@@ -1487,9 +1493,10 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	}
 
 	/*
-	 * Some filesystems may redirty the inode during the writeback
-	 * due to delalloc, clear dirty metadata flags right before
-	 * write_inode()
+	 * Get and clear the dirty flags from i_state.  This needs to be done
+	 * after calling writepages because some filesystems may redirty the
+	 * inode during writepages due to delalloc.  It also needs to be done
+	 * after handling timestamp expiration, as that may dirty the inode too.
 	 */
 	spin_lock(&inode->i_lock);
 	dirty = inode->i_state & I_DIRTY;
@@ -1524,12 +1531,13 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 }
 
 /*
- * Write out an inode's dirty pages. Either the caller has an active reference
- * on the inode or the inode has I_WILL_FREE set.
+ * Write out an inode's dirty data and metadata on-demand, i.e. separately from
+ * the regular batched writeback done by the flusher threads in
+ * writeback_sb_inodes().  @wbc controls various aspects of the write, such as
+ * whether it is a data-integrity sync (%WB_SYNC_ALL) or not (%WB_SYNC_NONE).
  *
- * This function is designed to be called for writing back one inode which
- * we go e.g. from filesystem. Flusher thread uses __writeback_single_inode()
- * and does more profound writeback list handling in writeback_sb_inodes().
+ * To prevent the inode from going away, either the caller must have a reference
+ * to the inode, or the inode must have I_WILL_FREE or I_FREEING set.
  */
 static int writeback_single_inode(struct inode *inode,
 				  struct writeback_control *wbc)
@@ -1544,23 +1552,23 @@ static int writeback_single_inode(struct inode *inode,
 		WARN_ON(inode->i_state & I_WILL_FREE);
 
 	if (inode->i_state & I_SYNC) {
-		if (wbc->sync_mode != WB_SYNC_ALL)
-			goto out;
 		/*
-		 * It's a data-integrity sync. We must wait. Since callers hold
-		 * inode reference or inode has I_WILL_FREE set, it cannot go
-		 * away under us.
+		 * Writeback is already running on the inode.  For WB_SYNC_NONE,
+		 * that's enough and we can just return.  For WB_SYNC_ALL, we
+		 * must wait for the existing writeback to complete, then do
+		 * writeback again if there's anything left.
 		 */
+		if (wbc->sync_mode != WB_SYNC_ALL)
+			goto out;
 		__inode_wait_for_writeback(inode);
 	}
 	WARN_ON(inode->i_state & I_SYNC);
 	/*
-	 * Skip inode if it is clean and we have no outstanding writeback in
-	 * WB_SYNC_ALL mode. We don't want to mess with writeback lists in this
-	 * function since flusher thread may be doing for example sync in
-	 * parallel and if we move the inode, it could get skipped. So here we
-	 * make sure inode is on some writeback list and leave it there unless
-	 * we have completely cleaned the inode.
+	 * If the inode is already fully clean, then there's nothing to do.
+	 *
+	 * For data-integrity syncs we also need to check whether any pages are
+	 * still under writeback, e.g. due to prior WB_SYNC_NONE writeback.  If
+	 * there are any such pages, we'll need to wait for them.
 	 */
 	if (!(inode->i_state & I_DIRTY_ALL) &&
 	    (wbc->sync_mode != WB_SYNC_ALL ||
@@ -1576,8 +1584,9 @@ static int writeback_single_inode(struct inode *inode,
 	wb = inode_to_wb_and_lock_list(inode);
 	spin_lock(&inode->i_lock);
 	/*
-	 * If inode is clean, remove it from writeback lists. Otherwise don't
-	 * touch it. See comment above for explanation.
+	 * If the inode is now fully clean, then it can be safely removed from
+	 * its writeback list (if any).  Otherwise the flusher threads are
+	 * responsible for the writeback lists.
 	 */
 	if (!(inode->i_state & I_DIRTY_ALL))
 		inode_io_list_del_locked(inode, wb);
-- 
2.30.0

