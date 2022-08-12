Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9944D5910D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 14:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbiHLMhl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 08:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbiHLMhg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:37:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D64FAAB1B2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Aug 2022 05:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660307854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4b5TcHOqyCwZexnXbcE3n8VMRW8SX70RNYBuSIOHTA=;
        b=GrbQjQL1K/ye40Wy/DfXKd97+GGwOBBxSIBzfyNssuCQpm6DBxjJY9I2XBwNVlqKPiYeiO
        eKiT62oQf0ChxS9VyETkQ08XHMz7xI3re0UfeFQyyIw4/Jqi7veg3R0d+UgDdOyYIhPR0q
        TWtbWwC3L8ThN3nZbX/ssgMdLYn3/po=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633--egzUpTKPJCOrl60cH0DDw-1; Fri, 12 Aug 2022 08:37:31 -0400
X-MC-Unique: -egzUpTKPJCOrl60cH0DDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0B501C07828;
        Fri, 12 Aug 2022 12:37:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D7852026D64;
        Fri, 12 Aug 2022 12:37:29 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jlayton@kernel.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, ebiggers@kernel.org,
        david@fromorbit.com, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 2/3] fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE
Date:   Fri, 12 Aug 2022 14:37:26 +0200
Message-Id: <20220812123727.46397-2-lczerner@redhat.com>
In-Reply-To: <20220812123727.46397-1-lczerner@redhat.com>
References: <20220812123727.46397-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
v3: Update documentation, add comments, change flag to flags in
    xfs_fs_dirty_inode()

 Documentation/filesystems/vfs.rst |  2 ++
 fs/fs-writeback.c                 | 34 ++++++++++++++++++++-----------
 fs/xfs/xfs_super.c                | 12 +++++++++--
 include/linux/fs.h                |  9 ++++----
 4 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 6cd6953e175b..5d72b6ba4e63 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -274,6 +274,8 @@ or bottom half).
 	This is specifically for the inode itself being marked dirty,
 	not its data.  If the update needs to be persisted by fdatasync(),
 	then I_DIRTY_DATASYNC will be set in the flags argument.
+	If the inode has dirty timestamp and lazytime is enabled
+	I_DIRTY_TIME will be set in the flags.
 
 ``write_inode``
 	this method is called when the VFS needs to write an inode to
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
index 9ac59814bbb6..13efc77a1e79 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -653,7 +653,7 @@ xfs_fs_destroy_inode(
 static void
 xfs_fs_dirty_inode(
 	struct inode			*inode,
-	int				flag)
+	int				flags)
 {
 	struct xfs_inode		*ip = XFS_I(inode);
 	struct xfs_mount		*mp = ip->i_mount;
@@ -661,7 +661,15 @@ xfs_fs_dirty_inode(
 
 	if (!(inode->i_sb->s_flags & SB_LAZYTIME))
 		return;
-	if (flag != I_DIRTY_SYNC || !(inode->i_state & I_DIRTY_TIME))
+
+	/*
+	 * Only do the timestamp update if the inode is dirty (I_DIRTY_SYNC)
+	 * and has dirty timestamp (I_DIRTY_TIME). I_DIRTY_TIME can be either
+	 * already set in i_state, or passed in flags possibly together with
+	 * I_DIRTY_SYNC.
+	 */
+	if ((flags & ~I_DIRTY_TIME) != I_DIRTY_SYNC ||
+	    !((inode->i_state | flags) & I_DIRTY_TIME))
 		return;
 
 	if (xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5113f65c786f..e220d26d771a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2376,13 +2376,14 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  *			don't have to write inode on fdatasync() when only
  *			e.g. the timestamps have changed.
  * I_DIRTY_PAGES	Inode has dirty pages.  Inode itself may be clean.
- * I_DIRTY_TIME		The inode itself only has dirty timestamps, and the
+ * I_DIRTY_TIME		The inode itself has dirty timestamps, and the
  *			lazytime mount option is enabled.  We keep track of this
  *			separately from I_DIRTY_SYNC in order to implement
  *			lazytime.  This gets cleared if I_DIRTY_INODE
- *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set.  I.e.
- *			either I_DIRTY_TIME *or* I_DIRTY_INODE can be set in
- *			i_state, but not both.  I_DIRTY_PAGES may still be set.
+ *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set. But
+ *			I_DIRTY_TIME can still be set if I_DIRTY_SYNC is already
+ *			in place because writeback might already be in progress
+ *			and we don't want to lose the time update
  * I_NEW		Serves as both a mutex and completion notification.
  *			New inodes set I_NEW.  If two processes both create
  *			the same inode, one of them will release its inode and
-- 
2.37.1

