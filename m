Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FB2532CE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 17:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiEXPGe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 11:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbiEXPGV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 11:06:21 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB1C65BF
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 08:06:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 202so9688071pfu.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 08:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=A+MSu7yhDzmTQ1P5umnctRMUxLsraLGzYR6+VLG96RI=;
        b=JIyI3AmKrgMY2m3+mAXmA965JPJ9r84BzAW3mJEMRuloLEIQqwW5I/6bNePLQoq9e5
         vryWWjNWZFQ0qHL5ae9Ogwu5B8kmb5xO5n2y9LS0n6fd2vnao3zzYwuPSecNbx3Pqyil
         wHmAlOQwNte5Ha9LUzXIK/9q7uZck5miPKJzbZ5A8wdUUaq1ziXGPHbNYMfGQ0uuJxFA
         KHqRR+8kUXb8r+USNmjIh9epSjyUu45b+cFlZcawQfG2rCHrJ3dC9tJT1QmIRUSjdsdH
         4X2igxO8iCqApPxqezfk53qw1s5esQNNMhj9oQd3Z9UC3ENq7PF4M6dGAZsdFd/hIgV8
         vF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A+MSu7yhDzmTQ1P5umnctRMUxLsraLGzYR6+VLG96RI=;
        b=PVR8QkrAbDKFzkRgxBBL0Y9rCOYTlJt44a0sPeYpElPB46I6iFqdyr+rb8kVOdVwSY
         qfHN+xl8/d/9JP0JPSa0AZXYib7z5zys4OjMiMDT6zI/abdLUFX3/FGJX7S/WcTrxpGf
         /J3/T9cI3FhlN4quY6XT9sGJxITNHKT9XuuG88cQDFS9/S258IUPBQ/yhW326ybntBHU
         3WoVGDNAINJVoWWOhy1ZDYHCuPHy9HvdazDQrf8JmZlV7Q6BC7fDH8ICZh2F9Qei9yXy
         1/48GEVABKULgGnqs7v8Q1QZc7tCDSNMt/aCVqMltqZhC0jPDBcejDEQwzXQYJbRSb72
         fiNA==
X-Gm-Message-State: AOAM530FGLLbl5V5wXs4+AFlaTb2S0qeE1RCkG7CcBuSvaBbXypk7MHg
        3mEdSmZh0vQtD5GdAwEucWiBH14Q69DfUVhY
X-Google-Smtp-Source: ABdhPJzLMDGr0jQRBD4rXkV4HZv9/wMc0EMOCbfiVOktQkeTS2B+14azpJjDWOuDjfQXzJx+LVIKKA==
X-Received: by 2002:a05:6a00:2402:b0:4e1:46ca:68bd with SMTP id z2-20020a056a00240200b004e146ca68bdmr28910226pfh.70.1653404776338;
        Tue, 24 May 2022 08:06:16 -0700 (PDT)
Received: from localhost ([116.235.161.35])
        by smtp.gmail.com with ESMTPSA id k18-20020a628e12000000b005186f0603fdsm9250210pfe.55.2022.05.24.08.06.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 May 2022 08:06:15 -0700 (PDT)
From:   Jchao Sun <sunjunchao2870@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, jack@suse.cz,
        Jchao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH v5] writeback: Fix inode->i_io_list not be protected by inode->i_lock error
Date:   Tue, 24 May 2022 08:05:40 -0700
Message-Id: <20220524150540.12552-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit b35250c0816c ("writeback: Protect inode->i_io_list with
inode->i_lock") made inode->i_io_list not only protected by
wb->list_lock but also inode->i_lock, but inode_io_list_move_locked()
was missed. Add lock there and also update comment describing
things protected by inode->i_lock. This also fixes a race where
__mark_inode_dirty() could move inode under flush worker's hands
and thus sync(2) could miss writing some inodes.

Fixes: b35250c0816c ("writeback: Protect inode->i_io_list with inode->i_lock")
Signed-off-by: Jchao Sun <sunjunchao2870@gmail.com>
---
 fs/fs-writeback.c | 37 ++++++++++++++++++++++++++++---------
 fs/inode.c        |  2 +-
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 591fe9cf1659..99793bb838e5 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -120,6 +120,7 @@ static bool inode_io_list_move_locked(struct inode *inode,
 				      struct list_head *head)
 {
 	assert_spin_locked(&wb->list_lock);
+	assert_spin_locked(&inode->i_lock);
 
 	list_move(&inode->i_io_list, head);
 
@@ -1365,9 +1366,9 @@ static int move_expired_inodes(struct list_head *delaying_queue,
 		inode = wb_inode(delaying_queue->prev);
 		if (inode_dirtied_after(inode, dirtied_before))
 			break;
+		spin_lock(&inode->i_lock);
 		list_move(&inode->i_io_list, &tmp);
 		moved++;
-		spin_lock(&inode->i_lock);
 		inode->i_state |= I_SYNC_QUEUED;
 		spin_unlock(&inode->i_lock);
 		if (sb_is_blkdev_sb(inode->i_sb))
@@ -1383,7 +1384,12 @@ static int move_expired_inodes(struct list_head *delaying_queue,
 		goto out;
 	}
 
-	/* Move inodes from one superblock together */
+	/*
+	 * Although inode's i_io_list is moved from 'tmp' to 'dispatch_queue',
+	 * we don't take inode->i_lock here because it is just a pointless overhead.
+	 * Inode is already marked as I_SYNC_QUEUED so writeback list handling is
+	 * fully under our control.
+	 */
 	while (!list_empty(&tmp)) {
 		sb = wb_inode(tmp.prev)->i_sb;
 		list_for_each_prev_safe(pos, node, &tmp) {
@@ -1821,8 +1827,8 @@ static long writeback_sb_inodes(struct super_block *sb,
 			 * We'll have another go at writing back this inode
 			 * when we completed a full scan of b_io.
 			 */
-			spin_unlock(&inode->i_lock);
 			requeue_io(inode, wb);
+			spin_unlock(&inode->i_lock);
 			trace_writeback_sb_inodes_requeue(inode);
 			continue;
 		}
@@ -2351,6 +2357,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 {
 	struct super_block *sb = inode->i_sb;
 	int dirtytime = 0;
+	struct bdi_writeback *wb = NULL;
 
 	trace_writeback_mark_inode_dirty(inode, flags);
 
@@ -2402,6 +2409,17 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			inode->i_state &= ~I_DIRTY_TIME;
 		inode->i_state |= flags;
 
+		/*
+		 * Grab inode's wb early because it requires dropping i_lock and we
+		 * need to make sure following checks happen atomically with dirty
+		 * list handling so that we don't move inodes under flush worker's
+		 * hands.
+		 */
+		if (!was_dirty) {
+			wb = locked_inode_to_wb_and_lock_list(inode);
+			spin_lock(&inode->i_lock);
+		}
+
 		/*
 		 * If the inode is queued for writeback by flush worker, just
 		 * update its dirty state. Once the flush worker is done with
@@ -2409,7 +2427,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 		 * list, based upon its state.
 		 */
 		if (inode->i_state & I_SYNC_QUEUED)
-			goto out_unlock_inode;
+			goto out_unlock;
 
 		/*
 		 * Only add valid (hashed) inodes to the superblock's
@@ -2417,22 +2435,19 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 		 */
 		if (!S_ISBLK(inode->i_mode)) {
 			if (inode_unhashed(inode))
-				goto out_unlock_inode;
+				goto out_unlock;
 		}
 		if (inode->i_state & I_FREEING)
-			goto out_unlock_inode;
+			goto out_unlock;
 
 		/*
 		 * If the inode was already on b_dirty/b_io/b_more_io, don't
 		 * reposition it (that would break b_dirty time-ordering).
 		 */
 		if (!was_dirty) {
-			struct bdi_writeback *wb;
 			struct list_head *dirty_list;
 			bool wakeup_bdi = false;
 
-			wb = locked_inode_to_wb_and_lock_list(inode);
-
 			inode->dirtied_when = jiffies;
 			if (dirtytime)
 				inode->dirtied_time_when = jiffies;
@@ -2446,6 +2461,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 							       dirty_list);
 
 			spin_unlock(&wb->list_lock);
+			spin_unlock(&inode->i_lock);
 			trace_writeback_dirty_inode_enqueue(inode);
 
 			/*
@@ -2460,6 +2476,9 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			return;
 		}
 	}
+out_unlock:
+	if (wb)
+		spin_unlock(&wb->list_lock);
 out_unlock_inode:
 	spin_unlock(&inode->i_lock);
 }
diff --git a/fs/inode.c b/fs/inode.c
index 9d9b422504d1..bd4da9c5207e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -27,7 +27,7 @@
  * Inode locking rules:
  *
  * inode->i_lock protects:
- *   inode->i_state, inode->i_hash, __iget()
+ *   inode->i_state, inode->i_hash, __iget(), inode->i_io_list
  * Inode LRU list locks protect:
  *   inode->i_sb->s_inode_lru, inode->i_lru
  * inode->i_sb->s_inode_list_lock protects:
-- 
2.17.1

