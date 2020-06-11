Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169031F634E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 10:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgFKIMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 04:12:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:58474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgFKIMF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:12:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B8BF9AC24;
        Thu, 11 Jun 2020 08:12:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 972DB1E0390; Thu, 11 Jun 2020 10:12:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Martijn Coenen <maco@android.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/4] writeback: Protect inode->i_io_list with inode->i_lock
Date:   Thu, 11 Jun 2020 10:11:52 +0200
Message-Id: <20200611081203.18161-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200611075033.1248-1-jack@suse.cz>
References: <20200611075033.1248-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, operations on inode->i_io_list are protected by
wb->list_lock. In the following patches we'll need to maintain
consistency between inode->i_state and inode->i_io_list so change the
code so that inode->i_lock protects also all inode's i_io_list handling.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a605c3dddabc..ff0b18331590 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -144,6 +144,7 @@ static void inode_io_list_del_locked(struct inode *inode,
 				     struct bdi_writeback *wb)
 {
 	assert_spin_locked(&wb->list_lock);
+	assert_spin_locked(&inode->i_lock);
 
 	list_del_init(&inode->i_io_list);
 	wb_io_lists_depopulated(wb);
@@ -1122,7 +1123,9 @@ void inode_io_list_del(struct inode *inode)
 	struct bdi_writeback *wb;
 
 	wb = inode_to_wb_and_lock_list(inode);
+	spin_lock(&inode->i_lock);
 	inode_io_list_del_locked(inode, wb);
+	spin_unlock(&inode->i_lock);
 	spin_unlock(&wb->list_lock);
 }
 EXPORT_SYMBOL(inode_io_list_del);
@@ -1172,8 +1175,10 @@ void sb_clear_inode_writeback(struct inode *inode)
  * the case then the inode must have been redirtied while it was being written
  * out and we don't reset its dirtied_when.
  */
-static void redirty_tail(struct inode *inode, struct bdi_writeback *wb)
+static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
 {
+	assert_spin_locked(&inode->i_lock);
+
 	if (!list_empty(&wb->b_dirty)) {
 		struct inode *tail;
 
@@ -1184,6 +1189,13 @@ static void redirty_tail(struct inode *inode, struct bdi_writeback *wb)
 	inode_io_list_move_locked(inode, wb, &wb->b_dirty);
 }
 
+static void redirty_tail(struct inode *inode, struct bdi_writeback *wb)
+{
+	spin_lock(&inode->i_lock);
+	redirty_tail_locked(inode, wb);
+	spin_unlock(&inode->i_lock);
+}
+
 /*
  * requeue inode for re-scanning after bdi->b_io list is exhausted.
  */
@@ -1394,7 +1406,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 		 * writeback is not making progress due to locked
 		 * buffers. Skip this inode for now.
 		 */
-		redirty_tail(inode, wb);
+		redirty_tail_locked(inode, wb);
 		return;
 	}
 
@@ -1414,7 +1426,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 			 * retrying writeback of the dirty page/inode
 			 * that cannot be performed immediately.
 			 */
-			redirty_tail(inode, wb);
+			redirty_tail_locked(inode, wb);
 		}
 	} else if (inode->i_state & I_DIRTY) {
 		/*
@@ -1422,7 +1434,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 		 * such as delayed allocation during submission or metadata
 		 * updates after data IO completion.
 		 */
-		redirty_tail(inode, wb);
+		redirty_tail_locked(inode, wb);
 	} else if (inode->i_state & I_DIRTY_TIME) {
 		inode->dirtied_when = jiffies;
 		inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
@@ -1669,8 +1681,8 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 */
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
+			redirty_tail_locked(inode, wb);
 			spin_unlock(&inode->i_lock);
-			redirty_tail(inode, wb);
 			continue;
 		}
 		if ((inode->i_state & I_SYNC) && wbc.sync_mode != WB_SYNC_ALL) {
-- 
2.16.4

