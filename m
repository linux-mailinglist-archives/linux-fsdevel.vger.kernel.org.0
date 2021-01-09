Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0202EFE90
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 09:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbhAIIBQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 03:01:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbhAIIBF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:01:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 525FD23A68;
        Sat,  9 Jan 2021 07:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610179185;
        bh=xjhBwvsck2xldye/p1ipbKcdL2fe5kn+WPmc3PyBaCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MkviwhOnbQtnQ7zRPqJn3r3k0jVP814jRKJF9u7tgP1eaEBZcpAYsV4cQljL2+4TE
         byJsLl6B5qpofY9e9+OTanUCP6iHIUYxwlT7fMxGxf4qyJPg+XziHNMIMTmuV4lB0E
         XkPEWJfutVBkJiawphxzrQEvRKvEs5pijr5I4Vg2Njw2KZKHE0jKTh3E5fr4APN+eG
         iRgQnJWzUzYNMyfR25VD18x/tmSzCyt8vStCy9uPa1KepLScLBFRmqh2/Jrmg9AeZV
         GnL/Dic0UGvSFDS0Kc0vCb5n2J7lmQ83zRLHtfa8a9YP6zaTj/pNooGOBgbso04+e0
         ARt1h1TPEaKKA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 05/12] fs: don't call ->dirty_inode for lazytime timestamp updates
Date:   Fri,  8 Jan 2021 23:58:56 -0800
Message-Id: <20210109075903.208222-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210109075903.208222-1-ebiggers@kernel.org>
References: <20210109075903.208222-1-ebiggers@kernel.org>
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

