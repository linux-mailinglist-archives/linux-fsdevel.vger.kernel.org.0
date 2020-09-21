Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD19D27289F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 16:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgIUOoc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 10:44:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:56006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727760AbgIUOo3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:44:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A0CAAD6B;
        Mon, 21 Sep 2020 14:45:04 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 08/15] btrfs: Introduce btrfs_write_check()
Date:   Mon, 21 Sep 2020 09:43:46 -0500
Message-Id: <20200921144353.31319-9-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921144353.31319-1-rgoldwyn@suse.de>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

btrfs_write_check() checks for all parameters in one place before
beginning a write. This does away with inode_unlock() after every check.
In the later patches, it will help push inode_lock/unlock() in buffered
and direct write functions respectively.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 159 ++++++++++++++++++++++++------------------------
 1 file changed, 81 insertions(+), 78 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index ca374cb5ffc9..0f961ce1fa98 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1615,6 +1615,85 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
 	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
 }
 
+static void update_time_for_write(struct inode *inode)
+{
+	struct timespec64 now;
+
+	if (IS_NOCMTIME(inode))
+		return;
+
+	now = current_time(inode);
+	if (!timespec64_equal(&inode->i_mtime, &now))
+		inode->i_mtime = now;
+
+	if (!timespec64_equal(&inode->i_ctime, &now))
+		inode->i_ctime = now;
+
+	if (IS_I_VERSION(inode))
+		inode_inc_iversion(inode);
+}
+
+static size_t btrfs_write_check(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	loff_t pos = iocb->ki_pos;
+	size_t count = iov_iter_count(from);
+	int err;
+	loff_t oldsize;
+	loff_t start_pos;
+
+	err = generic_write_checks(iocb, from);
+	if (err <= 0)
+		return err;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		size_t nocow_bytes = count;
+
+		/*
+		 * We will allocate space in case nodatacow is not set,
+		 * so bail
+		 */
+		if (check_nocow_nolock(BTRFS_I(inode), pos, &nocow_bytes)
+		    <= 0)
+			return -EAGAIN;
+		/*
+		 * There are holes in the range or parts of the range that must
+		 * be COWed (shared extents, RO block groups, etc), so just bail
+		 * out.
+		 */
+		if (nocow_bytes < count)
+			return -EAGAIN;
+	}
+
+	current->backing_dev_info = inode_to_bdi(inode);
+	err = file_remove_privs(file);
+	if (err)
+		return err;
+
+	/*
+	 * We reserve space for updating the inode when we reserve space for the
+	 * extent we are going to write, so we will enospc out there.  We don't
+	 * need to start yet another transaction to update the inode as we will
+	 * update the inode when we finish writing whatever data we write.
+	 */
+	update_time_for_write(inode);
+
+	start_pos = round_down(pos, fs_info->sectorsize);
+	oldsize = i_size_read(inode);
+	if (start_pos > oldsize) {
+		/* Expand hole size to cover write data, preventing empty gap */
+		loff_t end_pos = round_up(pos + count,
+					  fs_info->sectorsize);
+		err = btrfs_cont_expand(inode, oldsize, end_pos);
+		if (err)
+			return err;
+	}
+
+	return count;
+}
+
 static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					       struct iov_iter *i)
 {
@@ -1947,24 +2026,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	return written ? written : err;
 }
 
-static void update_time_for_write(struct inode *inode)
-{
-	struct timespec64 now;
-
-	if (IS_NOCMTIME(inode))
-		return;
-
-	now = current_time(inode);
-	if (!timespec64_equal(&inode->i_mtime, &now))
-		inode->i_mtime = now;
-
-	if (!timespec64_equal(&inode->i_ctime, &now))
-		inode->i_ctime = now;
-
-	if (IS_I_VERSION(inode))
-		inode_inc_iversion(inode);
-}
-
 static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 				    struct iov_iter *from)
 {
@@ -1972,14 +2033,9 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	u64 start_pos;
-	u64 end_pos;
 	ssize_t num_written = 0;
 	const bool sync = iocb->ki_flags & IOCB_DSYNC;
 	ssize_t err;
-	loff_t pos;
-	size_t count;
-	loff_t oldsize;
 
 	/*
 	 * If BTRFS flips readonly due to some impossible error
@@ -2001,65 +2057,12 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		inode_lock(inode);
 	}
 
-	err = generic_write_checks(iocb, from);
+	err = btrfs_write_check(iocb, from);
 	if (err <= 0) {
 		inode_unlock(inode);
 		return err;
 	}
 
-	pos = iocb->ki_pos;
-	count = iov_iter_count(from);
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		size_t nocow_bytes = count;
-
-		/*
-		 * We will allocate space in case nodatacow is not set,
-		 * so bail
-		 */
-		if (check_nocow_nolock(BTRFS_I(inode), pos, &nocow_bytes)
-		    <= 0) {
-			inode_unlock(inode);
-			return -EAGAIN;
-		}
-		/*
-		 * There are holes in the range or parts of the range that must
-		 * be COWed (shared extents, RO block groups, etc), so just bail
-		 * out.
-		 */
-		if (nocow_bytes < count) {
-			inode_unlock(inode);
-			return -EAGAIN;
-		}
-	}
-
-	current->backing_dev_info = inode_to_bdi(inode);
-	err = file_remove_privs(file);
-	if (err) {
-		inode_unlock(inode);
-		goto out;
-	}
-
-	/*
-	 * We reserve space for updating the inode when we reserve space for the
-	 * extent we are going to write, so we will enospc out there.  We don't
-	 * need to start yet another transaction to update the inode as we will
-	 * update the inode when we finish writing whatever data we write.
-	 */
-	update_time_for_write(inode);
-
-	start_pos = round_down(pos, fs_info->sectorsize);
-	oldsize = i_size_read(inode);
-	if (start_pos > oldsize) {
-		/* Expand hole size to cover write data, preventing empty gap */
-		end_pos = round_up(pos + count,
-				   fs_info->sectorsize);
-		err = btrfs_cont_expand(inode, oldsize, end_pos);
-		if (err) {
-			inode_unlock(inode);
-			goto out;
-		}
-	}
-
 	if (sync)
 		atomic_inc(&BTRFS_I(inode)->sync_writers);
 
@@ -2117,7 +2120,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 
 	if (sync)
 		atomic_dec(&BTRFS_I(inode)->sync_writers);
-out:
+
 	current->backing_dev_info = NULL;
 	return num_written ? num_written : err;
 }
-- 
2.26.2

