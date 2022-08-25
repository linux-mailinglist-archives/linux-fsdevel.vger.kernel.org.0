Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F159B5A0D7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 12:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbiHYKHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 06:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiHYKHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED5DA61ED
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Aug 2022 03:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661422024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ap7P6BiMLcpyXayMvF0NROeX0VDV2S0asu7x91XcRzQ=;
        b=fLFtDtkvhxpwWWG3RCxQWzPdiQaeEliEOAxQRTe0jt2r97G+7eCkxPD2edcWrBGxo7qCHe
        eboKtf05ZQsdxQNwkWWHDEehdHGpU+Wrs5WlgLizcLByJMbWBh82tD/GCkQ+UoA5rJ1LEv
        /cMoYg8/LPcr60GQVOicN8Ja5OtKpTQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-wJ2GLmB_MPaDrKYO8nMtSg-1; Thu, 25 Aug 2022 06:07:00 -0400
X-MC-Unique: wJ2GLmB_MPaDrKYO8nMtSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17C938032FB;
        Thu, 25 Aug 2022 10:07:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B0144010FA6;
        Thu, 25 Aug 2022 10:06:58 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jlayton@kernel.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, ebiggers@kernel.org,
        david@fromorbit.com, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v5] fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE
Date:   Thu, 25 Aug 2022 12:06:57 +0200
Message-Id: <20220825100657.44217-1-lczerner@redhat.com>
In-Reply-To: <20220824160349.39664-2-lczerner@redhat.com>
References: <20220824160349.39664-2-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
v2: Reworked according to suggestions from Jan
v3: Update documentation, add comments, change flag to flags in
    xfs_fs_dirty_inode()
v4: Update documentation, simplify condition in xfs_fs_dirty_inode()
v5: Update comment for condition in __mark_inode_dirty()


 Documentation/filesystems/vfs.rst |  3 +++
 fs/fs-writeback.c                 | 37 +++++++++++++++++++++----------
 fs/xfs/xfs_super.c                | 10 +++++++--
 include/linux/fs.h                |  9 ++++----
 4 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 6cd6953e175b..b2ef2449aed9 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -274,6 +274,9 @@ or bottom half).
 	This is specifically for the inode itself being marked dirty,
 	not its data.  If the update needs to be persisted by fdatasync(),
 	then I_DIRTY_DATASYNC will be set in the flags argument.
+	I_DIRTY_TIME will be set in the flags in case lazytime is enabled
+	and struct inode has times updated since the last ->dirty_inode
+	call.
 
 ``write_inode``
 	this method is called when the VFS needs to write an inode to
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 05221366a16d..45860591d51f 100644
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
@@ -2369,6 +2374,20 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 	trace_writeback_mark_inode_dirty(inode, flags);
 
 	if (flags & I_DIRTY_INODE) {
+		/*
+		 * Inode timestamp update will piggback on this dirtying.
+		 * We tell ->dirty_inode callback that timestamps need to
+		 * be updated by setting I_DIRTY_TIME in flags.
+		 */
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
@@ -2378,7 +2397,8 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 		 */
 		trace_writeback_dirty_inode_start(inode, flags);
 		if (sb->s_op->dirty_inode)
-			sb->s_op->dirty_inode(inode, flags & I_DIRTY_INODE);
+			sb->s_op->dirty_inode(inode,
+				flags & (I_DIRTY_INODE | I_DIRTY_TIME));
 		trace_writeback_dirty_inode(inode, flags);
 
 		/* I_DIRTY_INODE supersedes I_DIRTY_TIME. */
@@ -2399,21 +2419,15 @@ void __mark_inode_dirty(struct inode *inode, int flags)
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
@@ -2486,7 +2500,6 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 out_unlock:
 	if (wb)
 		spin_unlock(&wb->list_lock);
-out_unlock_inode:
 	spin_unlock(&inode->i_lock);
 }
 EXPORT_SYMBOL(__mark_inode_dirty);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 9ac59814bbb6..f029c6702dda 100644
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
@@ -661,7 +661,13 @@ xfs_fs_dirty_inode(
 
 	if (!(inode->i_sb->s_flags & SB_LAZYTIME))
 		return;
-	if (flag != I_DIRTY_SYNC || !(inode->i_state & I_DIRTY_TIME))
+
+	/*
+	 * Only do the timestamp update if the inode is dirty (I_DIRTY_SYNC)
+	 * and has dirty timestamp (I_DIRTY_TIME). I_DIRTY_TIME can be passed
+	 * in flags possibly together with I_DIRTY_SYNC.
+	 */
+	if ((flags & ~I_DIRTY_TIME) != I_DIRTY_SYNC || !(flags & I_DIRTY_TIME))
 		return;
 
 	if (xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9eced4cc286e..56a4b4b02477 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2371,13 +2371,14 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
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

