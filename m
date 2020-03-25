Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B87AA19284D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 13:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgCYM2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 08:28:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54680 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbgCYM2h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fUMRiqcR3QbpI9KipJLCvjYPl6+nc19Qgf3nmLi9ugA=; b=Nvp1Hr65GnU3cDNOHLB4oGSUId
        GlmDae0MlPtksI1qgGxRX1hTGTdOBAqnNVAuSAE7Z1X1wOdBXnV2+fnrhwGI/b4+OxEefk3XfD95k
        Wwq7C5nL4fbcD0+nf2wCOglMtnoKj0/V6slVbO/FLboT/ZZOKRYepQuZiagqyADdCufjNy3QTy7FX
        Js6zPTKqInxstVTIkClzxVTvapNjEMUxgjV7A2Nvi6RxJnx1Sm2uBXsUwHJEkmRyEcGCp1pK7+QoR
        DManta9Eei/bneT0cPDGgcV3y0P124YvfjJrPKSdCcEKEdmchJ0bullSD2MhplNzghPMV2Ua+7YoE
        1WuQtvkw==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH596-0003HP-Gi; Wed, 25 Mar 2020 12:28:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] fs: avoid double-writing the inode on a lazytime expiration
Date:   Wed, 25 Mar 2020 13:28:23 +0100
Message-Id: <20200325122825.1086872-3-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325122825.1086872-1-hch@lst.de>
References: <20200325122825.1086872-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the case that an inode has dirty timestamp for longer than the
lazytime expiration timeout (or if all such inodes are being flushed
out due to a sync or syncfs system call), we need to inform the file
system that the inode is dirty so that the inode's timestamps can be
copied out to the on-disk data structures.  That's because if the file
system supports lazytime, it will have ignored the dirty_inode(inode,
I_DIRTY_TIME) notification when the timestamp was modified in memory.q
Previously, this was accomplished by calling mark_inode_dirty_sync(),
but that has the unfortunate side effect of also putting the inode the
writeback list, and that's not necessary in this case, since we will
immediately call write_inode() afterwards.  Replace the call to
mark_inode_dirty_sync() with a new lazytime_expired method to clearly
separate out this case.

Eric Biggers noticed that this was causing problems for fscrypt after
the key was removed[1].

Based on a patch from Theodore Ts'o.

[1] https://lore.kernel.org/r/20200306004555.GB225345@gmail.com

Fixes: 0ae45f63d4ef ("vfs: add support for a lazytime mount option")
Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/super.c    |  6 ++++++
 fs/f2fs/super.c    |  6 ++++++
 fs/fs-writeback.c  |  3 ++-
 fs/inode.c         |  3 ++-
 fs/xfs/xfs_super.c | 12 +++---------
 include/linux/fs.h |  1 +
 6 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0c7c4adb664e..ebbf6370ccd6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1448,6 +1448,11 @@ static struct dquot **ext4_get_dquots(struct inode *inode)
 	return EXT4_I(inode)->i_dquot;
 }
 
+static void ext4_lazytime_expired(struct inode *inode)
+{
+	return ext4_dirty_inode(inode, I_DIRTY_SYNC);
+}
+
 static const struct dquot_operations ext4_quota_operations = {
 	.get_reserved_space	= ext4_get_reserved_space,
 	.write_dquot		= ext4_write_dquot,
@@ -1480,6 +1485,7 @@ static const struct super_operations ext4_sops = {
 	.destroy_inode	= ext4_destroy_inode,
 	.write_inode	= ext4_write_inode,
 	.dirty_inode	= ext4_dirty_inode,
+	.lazytime_expired = ext4_lazytime_expired,
 	.drop_inode	= ext4_drop_inode,
 	.evict_inode	= ext4_evict_inode,
 	.put_super	= ext4_put_super,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 65a7a432dfee..529334573944 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1100,6 +1100,11 @@ static void f2fs_dirty_inode(struct inode *inode, int flags)
 	f2fs_inode_dirtied(inode, false);
 }
 
+static void f2fs_lazytime_expired(struct inode *inode)
+{
+	return f2fs_dirty_inode(inode, I_DIRTY_SYNC);
+}
+
 static void f2fs_free_inode(struct inode *inode)
 {
 	fscrypt_free_inode(inode);
@@ -2355,6 +2360,7 @@ static const struct super_operations f2fs_sops = {
 	.drop_inode	= f2fs_drop_inode,
 	.write_inode	= f2fs_write_inode,
 	.dirty_inode	= f2fs_dirty_inode,
+	.lazytime_expired = f2fs_lazytime_expired,
 	.show_options	= f2fs_show_options,
 #ifdef CONFIG_QUOTA
 	.quota_read	= f2fs_quota_read,
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 76ac9c7d32ec..dc2d65c765ae 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1505,7 +1505,8 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	spin_unlock(&inode->i_lock);
 
 	if (dirty & I_DIRTY_TIME)
-		mark_inode_dirty_sync(inode);
+		inode->i_sb->s_op->lazytime_expired(inode);
+
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
 	if (dirty & ~I_DIRTY_PAGES) {
 		int err = write_inode(inode, wbc);
diff --git a/fs/inode.c b/fs/inode.c
index 93d9252a00ab..96cf26ed4c7b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1674,7 +1674,8 @@ int generic_update_time(struct inode *inode, struct timespec64 *time, int flags)
 	if (flags & S_MTIME)
 		inode->i_mtime = *time;
 	if ((flags & (S_ATIME | S_CTIME | S_MTIME)) &&
-	    !(inode->i_sb->s_flags & SB_LAZYTIME))
+	    (!inode->i_sb->s_op->lazytime_expired ||
+	     !(inode->i_sb->s_flags & SB_LAZYTIME)))
 		dirty = true;
 
 	if (dirty)
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 2094386af8ac..e5aafd40dd0f 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -612,19 +612,13 @@ xfs_fs_destroy_inode(
 }
 
 static void
-xfs_fs_dirty_inode(
-	struct inode			*inode,
-	int				flag)
+xfs_fs_lazytime_expired(
+	struct inode			*inode)
 {
 	struct xfs_inode		*ip = XFS_I(inode);
 	struct xfs_mount		*mp = ip->i_mount;
 	struct xfs_trans		*tp;
 
-	if (!(inode->i_sb->s_flags & SB_LAZYTIME))
-		return;
-	if (flag != I_DIRTY_SYNC || !(inode->i_state & I_DIRTY_TIME))
-		return;
-
 	if (xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp))
 		return;
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
@@ -1053,7 +1047,7 @@ xfs_fs_free_cached_objects(
 static const struct super_operations xfs_super_operations = {
 	.alloc_inode		= xfs_fs_alloc_inode,
 	.destroy_inode		= xfs_fs_destroy_inode,
-	.dirty_inode		= xfs_fs_dirty_inode,
+	.lazytime_expired	= xfs_fs_lazytime_expired,
 	.drop_inode		= xfs_fs_drop_inode,
 	.put_super		= xfs_fs_put_super,
 	.sync_fs		= xfs_fs_sync_fs,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index abedbffe2c9e..07c213cdecf3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1948,6 +1948,7 @@ struct super_operations {
 	int (*write_inode) (struct inode *, struct writeback_control *wbc);
 	int (*drop_inode) (struct inode *);
 	void (*evict_inode) (struct inode *);
+	void (*lazytime_expired)(struct inode *inode);
 	void (*put_super) (struct super_block *);
 	int (*sync_fs)(struct super_block *sb, int wait);
 	int (*freeze_super) (struct super_block *);
-- 
2.25.1

