Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A741E2F3984
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 20:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404668AbhALTEu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 14:04:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404093AbhALTEu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:04:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A3DD2312F;
        Tue, 12 Jan 2021 19:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610478249;
        bh=hmxMN17tKWaM2hsNCmfmSb2YECH36i4GDPyEe2gO7gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jfP9ayF3Bht5l+XL74ExT6oANuXRjIN05trgBbs+srth9qeDfGwxeUu0QcJZv8VCE
         edaeKWIsx2TiW/iK+uEBPM8hTUTnv09wng43nlxBKFjdT8km0rqByuPKmCHPrXhFZs
         nyTTgwS7cHbByEkW3TA7q+2wLyXHvHN9Bp9wwWSHkQIECBojD9jx6ebwmDVf007wP1
         yvlBMTdo3kMFalEKHJM3sC7o2mozf3itA8TSFwN3eYT6K58qpzO08YQhxWsDNa/TIs
         3tczf7gw3/0t/yTPXN47F2C2HFSSCmaiUZGa9Z4f+VOt/tqMWuhjV8Ebz6K6RbCAD9
         rwZ6XAe3/39Cw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v3 05/11] fs: don't call ->dirty_inode for lazytime timestamp updates
Date:   Tue, 12 Jan 2021 11:02:47 -0800
Message-Id: <20210112190253.64307-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112190253.64307-1-ebiggers@kernel.org>
References: <20210112190253.64307-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

There is no need to call ->dirty_inode for lazytime timestamp updates
(i.e. for __mark_inode_dirty(I_DIRTY_TIME)), since by the definition of
lazytime, filesystems must ignore these updates.  Filesystems only need
to care about the updated timestamps when they expire.

Therefore, only call ->dirty_inode when I_DIRTY_INODE is set.

Based on a patch from Christoph Hellwig:
https://lore.kernel.org/r/20200325122825.1086872-4-hch@lst.de

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/inode.c   | 12 +-----------
 fs/f2fs/super.c   |  3 ---
 fs/fs-writeback.c |  6 +++---
 fs/gfs2/super.c   |  2 --
 4 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 27946882d4ce4..4cc6c7834312f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5933,26 +5933,16 @@ int __ext4_mark_inode_dirty(handle_t *handle, struct inode *inode,
  * If the inode is marked synchronous, we don't honour that here - doing
  * so would cause a commit on atime updates, which we don't bother doing.
  * We handle synchronous inodes at the highest possible level.
- *
- * If only the I_DIRTY_TIME flag is set, we can skip everything.  If
- * I_DIRTY_TIME and I_DIRTY_SYNC is set, the only inode fields we need
- * to copy into the on-disk inode structure are the timestamp files.
  */
 void ext4_dirty_inode(struct inode *inode, int flags)
 {
 	handle_t *handle;
 
-	if (flags == I_DIRTY_TIME)
-		return;
 	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
 	if (IS_ERR(handle))
-		goto out;
-
+		return;
 	ext4_mark_inode_dirty(handle, inode);
-
 	ext4_journal_stop(handle);
-out:
-	return;
 }
 
 int ext4_change_inode_journal_flag(struct inode *inode, int val)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b4a07fe62d1a5..cc98dc49f4a26 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1196,9 +1196,6 @@ static void f2fs_dirty_inode(struct inode *inode, int flags)
 			inode->i_ino == F2FS_META_INO(sbi))
 		return;
 
-	if (flags == I_DIRTY_TIME)
-		return;
-
 	if (is_inode_flag_set(inode, FI_AUTO_RECOVER))
 		clear_inode_flag(inode, FI_AUTO_RECOVER);
 
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index c41cb887eb7d3..b7616bbd55336 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2255,16 +2255,16 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 	 * Don't do this for I_DIRTY_PAGES - that doesn't actually
 	 * dirty the inode itself
 	 */
-	if (flags & (I_DIRTY_INODE | I_DIRTY_TIME)) {
+	if (flags & I_DIRTY_INODE) {
 		trace_writeback_dirty_inode_start(inode, flags);
 
 		if (sb->s_op->dirty_inode)
 			sb->s_op->dirty_inode(inode, flags);
 
 		trace_writeback_dirty_inode(inode, flags);
-	}
-	if (flags & I_DIRTY_INODE)
+
 		flags &= ~I_DIRTY_TIME;
+	}
 	dirtytime = flags & I_DIRTY_TIME;
 
 	/*
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 2f56acc41c049..042b94288ff11 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -562,8 +562,6 @@ static void gfs2_dirty_inode(struct inode *inode, int flags)
 	int need_endtrans = 0;
 	int ret;
 
-	if (!(flags & I_DIRTY_INODE))
-		return;
 	if (unlikely(gfs2_withdrawn(sdp)))
 		return;
 	if (!gfs2_glock_is_locked_by_me(ip->i_gl)) {
-- 
2.30.0

