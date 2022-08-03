Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67593588ACF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 12:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbiHCKx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 06:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbiHCKxx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C954286F0
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Aug 2022 03:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659524027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=doXYw7E5VLvw7n6vVIR09pFS1doVs35mgegqvhxvfjA=;
        b=ENY6uRkELflidIi9ISNobR06vcDqkCjApYp2Nx0EvgvhWNHdKs8/q5QHU67A0jMQxbRALu
        XrmV+z5o6Ksz6aFbiN9VDq/7lrlSUqCvbC2FL6kP5r7K4FkXY5cJVejAgW23zRrFW7BL/c
        NHvT/4THBxFs6vM7FH04WMnu3FaO87A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-ck28BSQ-PAaolYdadZAu1Q-1; Wed, 03 Aug 2022 06:53:43 -0400
X-MC-Unique: ck28BSQ-PAaolYdadZAu1Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 625F0185A7B2;
        Wed,  3 Aug 2022 10:53:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35CC91121314;
        Wed,  3 Aug 2022 10:53:42 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     jlayton@kernel.org, tytso@mit.edu, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 2/3] fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE
Date:   Wed,  3 Aug 2022 12:53:39 +0200
Message-Id: <20220803105340.17377-2-lczerner@redhat.com>
In-Reply-To: <20220803105340.17377-1-lczerner@redhat.com>
References: <20220803105340.17377-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently the I_DIRTY_TIME will never get set if the inode already has
I_DIRTY_INODE with assumption that it supersedes I_DIRTY_TIME.  That's
true, however ext4 will only update the on-disk inode in
->dirty_inode(), not on actual writeback. As a result if the inode
already has I_DIRTY_INODE state by the time we get to
__mark_inode_dirty() only with I_DIRTY_TIME, the time was already filled
into on-disk inode and will not get updated until the next I_DIRTY_INODE
update, which might never come if we crash or get a power failure.

The problem can be reproduced on ext4 by running xfstest generic/622
with -o iversion mount option.

Fix it by allowing I_DIRTY_TIME to be set even if the inode already has
I_DIRTY_INODE. Also make sure that the case is properly handled in
writeback_single_inode() as well. Additionally changes in
xfs_fs_dirty_inode() was made to accommodate for I_DIRTY_TIME in flag.

Thanks Jan Kara for suggestions on how to make this work properly.

Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Suggested-by: Jan Kara <jack@suse.cz>
---
v2: Reworked according to suggestions from Jan

 fs/fs-writeback.c  | 34 ++++++++++++++++++++++------------
 fs/xfs/xfs_super.c |  3 ++-
 include/linux/fs.h |  6 +++---
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 05221366a16d..638dbf143727 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1718,9 +1718,14 @@ static int writeback_single_inode(struct inode *inode,
 	 */
 	if (!(inode->i_state & I_DIRTY_ALL))
 		inode_cgwb_move_to_attached(inode, wb);
-	else if (!(inode->i_state & I_SYNC_QUEUED) &&
-		 (inode->i_state & I_DIRTY))
-		redirty_tail_locked(inode, wb);
+	else if (!(inode->i_state & I_SYNC_QUEUED)) {
+		if ((inode->i_state & I_DIRTY))
+			redirty_tail_locked(inode, wb);
+		else if (inode->i_state & I_DIRTY_TIME) {
+			inode->dirtied_when = jiffies;
+			inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
+		}
+	}
 
 	spin_unlock(&wb->list_lock);
 	inode_sync_complete(inode);
@@ -2369,6 +2374,17 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 	trace_writeback_mark_inode_dirty(inode, flags);
 
 	if (flags & I_DIRTY_INODE) {
+
+		/* Inode timestamp update will piggback on this dirtying */
+		if (inode->i_state & I_DIRTY_TIME) {
+			spin_lock(&inode->i_lock);
+			if (inode->i_state & I_DIRTY_TIME) {
+				inode->i_state &= ~I_DIRTY_TIME;
+				flags |= I_DIRTY_TIME;
+			}
+			spin_unlock(&inode->i_lock);
+		}
+
 		/*
 		 * Notify the filesystem about the inode being dirtied, so that
 		 * (if needed) it can update on-disk fields and journal the
@@ -2378,7 +2394,8 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 		 */
 		trace_writeback_dirty_inode_start(inode, flags);
 		if (sb->s_op->dirty_inode)
-			sb->s_op->dirty_inode(inode, flags & I_DIRTY_INODE);
+			sb->s_op->dirty_inode(inode,
+				flags & (I_DIRTY_INODE | I_DIRTY_TIME));
 		trace_writeback_dirty_inode(inode, flags);
 
 		/* I_DIRTY_INODE supersedes I_DIRTY_TIME. */
@@ -2399,21 +2416,15 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 	 */
 	smp_mb();
 
-	if (((inode->i_state & flags) == flags) ||
-	    (dirtytime && (inode->i_state & I_DIRTY_INODE)))
+	if ((inode->i_state & flags) == flags)
 		return;
 
 	spin_lock(&inode->i_lock);
-	if (dirtytime && (inode->i_state & I_DIRTY_INODE))
-		goto out_unlock_inode;
 	if ((inode->i_state & flags) != flags) {
 		const int was_dirty = inode->i_state & I_DIRTY;
 
 		inode_attach_wb(inode, NULL);
 
-		/* I_DIRTY_INODE supersedes I_DIRTY_TIME. */
-		if (flags & I_DIRTY_INODE)
-			inode->i_state &= ~I_DIRTY_TIME;
 		inode->i_state |= flags;
 
 		/*
@@ -2486,7 +2497,6 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 out_unlock:
 	if (wb)
 		spin_unlock(&wb->list_lock);
-out_unlock_inode:
 	spin_unlock(&inode->i_lock);
 }
 EXPORT_SYMBOL(__mark_inode_dirty);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index aa977c7ea370..cff05a4771b5 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -658,7 +658,8 @@ xfs_fs_dirty_inode(
 
 	if (!(inode->i_sb->s_flags & SB_LAZYTIME))
 		return;
-	if (flag != I_DIRTY_SYNC || !(inode->i_state & I_DIRTY_TIME))
+	if ((flag & ~I_DIRTY_TIME) != I_DIRTY_SYNC ||
+	    !((inode->i_state | flag) & I_DIRTY_TIME))
 		return;
 
 	if (xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9ad5e3520fae..2243797badf2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2245,9 +2245,9 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  *			lazytime mount option is enabled.  We keep track of this
  *			separately from I_DIRTY_SYNC in order to implement
  *			lazytime.  This gets cleared if I_DIRTY_INODE
- *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set.  I.e.
- *			either I_DIRTY_TIME *or* I_DIRTY_INODE can be set in
- *			i_state, but not both.  I_DIRTY_PAGES may still be set.
+ *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set. But
+ *			I_DIRTY_TIME can still be set if I_DIRTY_SYNC is already
+ *			in place.
  * I_NEW		Serves as both a mutex and completion notification.
  *			New inodes set I_NEW.  If two processes both create
  *			the same inode, one of them will release its inode and
-- 
2.37.1

