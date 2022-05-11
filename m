Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01DC52352A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 16:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbiEKOPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 10:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240025AbiEKOPg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 10:15:36 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704C66B7CB
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 07:15:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g8so2116718pfh.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 07:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=8N8bqLcwvcQzoTzZWHXpQfIBf7YC17iTKRRrunCuxgM=;
        b=TqX1fs/XpzbdJeOyLdyL2ZossXCyQpvBP0TSD2XTzf7CBx/xk9x0pGDpScBTphl0x+
         G4G8ItIak3hoCtZSDxtV8+B1KhjFj+gFokVa9WLRqg/1n7NoA82p4Q9Vvqy07TuNm79t
         Z9R3fPkL2pJmAEB7hijghMb3HoJ46c1SxRO9NfwZmFc0rKbe32db9Fco+mXgcD1o9D0v
         2HzLJDYGHRWCm14/JAuv1M4BUSgxWrw7ibBRc3MfRrY0raYDBlQNMYOZ8NqPjpuNqVg/
         EW4PjIbXgu2aR903sbDIFK5pkT52n5Jpp+NfbkwJcMsZdXRx9kbQgc4PXXVZk4rGbhSi
         gHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8N8bqLcwvcQzoTzZWHXpQfIBf7YC17iTKRRrunCuxgM=;
        b=7IlePyzJfYsbQ0C6rdUTOa9D1IuX92rGMAYfRzy3bQhuVUKG4l42krsfhSR+/Eg4di
         meHwP8rlXugxlphf9q7UkKH96+zp5JpopSXsf5MCP3+b5qm4HdU14HeDS+3R+KgYDpcz
         yOaIS/4QbPTz43kL0vBdwlJ66mgrMiHKuT9gu3mwaRHjUZZ9yaW4ffh3p93IZLwyC6qM
         doeEL5ZO1Hi/tDrGCpyp76Sfqulz/7j643tXVeYCDhuxcvn98M5abl8O+EiljoYiCoOX
         YwilQQRx/mu3DDaN+QRAaH5QtKPlWXOXS+0TOFS2Gcm+Kik+v202XI7NKhUl37h8Jggh
         lnMQ==
X-Gm-Message-State: AOAM532LXSCUoFoJDH4dtzRSXbO0Y3/vbxdsbtqnvqGp+VbiiMnCLAZr
        zOYj1/MW9PpeNPioukCE+oX/ceBS59evHw==
X-Google-Smtp-Source: ABdhPJxmWHf8IeNZORyR3nzEUbTTCxFDAkk6Zk4EWIsWkaTXB+lzCr4573sjXJJjQ8bHGXlR9uuuBA==
X-Received: by 2002:a63:e549:0:b0:3c6:d87:d3ef with SMTP id z9-20020a63e549000000b003c60d87d3efmr21228925pgj.111.1652278534581;
        Wed, 11 May 2022 07:15:34 -0700 (PDT)
Received: from localhost ([101.224.171.160])
        by smtp.gmail.com with ESMTPSA id x13-20020a62fb0d000000b0050dc762813dsm1812726pfm.23.2022.05.11.07.15.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 May 2022 07:15:34 -0700 (PDT)
From:   Jchao Sun <sunjunchao2870@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, jack@suse.cz,
        Jchao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH v4] writeback: Fix inode->i_io_list not be protected by inode->i_lock error
Date:   Wed, 11 May 2022 07:15:18 -0700
Message-Id: <20220511141518.1895-1-sunjunchao2870@gmail.com>
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
things protected by inode->i_lock.

Fixes: b35250c0816c ("writeback: Protect inode->i_io_list with inode->i_lock")
Signed-off-by: Jchao Sun <sunjunchao2870@gmail.com>
---
 fs/fs-writeback.c | 26 ++++++++++++++++++--------
 fs/inode.c        |  2 +-
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 591fe9cf1659..2bfd7ec92830 100644
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
@@ -1383,6 +1384,7 @@ static int move_expired_inodes(struct list_head *delaying_queue,
 		goto out;
 	}
 
+	spin_lock(&inode->i_lock);
 	/* Move inodes from one superblock together */
 	while (!list_empty(&tmp)) {
 		sb = wb_inode(tmp.prev)->i_sb;
@@ -1392,6 +1394,7 @@ static int move_expired_inodes(struct list_head *delaying_queue,
 				list_move(&inode->i_io_list, dispatch_queue);
 		}
 	}
+	spin_unlock(&inode->i_lock);
 out:
 	return moved;
 }
@@ -1821,8 +1824,8 @@ static long writeback_sb_inodes(struct super_block *sb,
 			 * We'll have another go at writing back this inode
 			 * when we completed a full scan of b_io.
 			 */
-			spin_unlock(&inode->i_lock);
 			requeue_io(inode, wb);
+			spin_unlock(&inode->i_lock);
 			trace_writeback_sb_inodes_requeue(inode);
 			continue;
 		}
@@ -2351,6 +2354,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 {
 	struct super_block *sb = inode->i_sb;
 	int dirtytime = 0;
+	struct bdi_writeback *wb = NULL;
 
 	trace_writeback_mark_inode_dirty(inode, flags);
 
@@ -2402,6 +2406,11 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			inode->i_state &= ~I_DIRTY_TIME;
 		inode->i_state |= flags;
 
+		if (!was_dirty) {
+			wb = locked_inode_to_wb_and_lock_list(inode);
+			spin_lock(&inode->i_lock);
+		}
+
 		/*
 		 * If the inode is queued for writeback by flush worker, just
 		 * update its dirty state. Once the flush worker is done with
@@ -2409,7 +2418,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 		 * list, based upon its state.
 		 */
 		if (inode->i_state & I_SYNC_QUEUED)
-			goto out_unlock_inode;
+			goto out_unlock;
 
 		/*
 		 * Only add valid (hashed) inodes to the superblock's
@@ -2417,22 +2426,19 @@ void __mark_inode_dirty(struct inode *inode, int flags)
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
@@ -2446,6 +2452,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 							       dirty_list);
 
 			spin_unlock(&wb->list_lock);
+			spin_unlock(&inode->i_lock);
 			trace_writeback_dirty_inode_enqueue(inode);
 
 			/*
@@ -2460,6 +2467,9 @@ void __mark_inode_dirty(struct inode *inode, int flags)
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

