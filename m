Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9030D2776F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 18:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgIXQkI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 12:40:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:36618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbgIXQkH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:40:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DBE64B290;
        Thu, 24 Sep 2020 16:40:04 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 10/14] btrfs: Push inode locking and unlocking into buffered/direct write
Date:   Thu, 24 Sep 2020 11:39:17 -0500
Message-Id: <20200924163922.2547-11-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924163922.2547-1-rgoldwyn@suse.de>
References: <20200924163922.2547-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Push inode locking and unlocking closer to where we perform the I/O. For
this we need to move the write checks inside the respective functions as
well.

pos is evaluated after generic_write_checks because O_APPEND can change
iocb->ki_pos.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 70 +++++++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a9d0950fd922..72fa1c692a53 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1699,7 +1699,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					       struct iov_iter *i)
 {
 	struct file *file = iocb->ki_filp;
-	loff_t pos = iocb->ki_pos;
+	loff_t pos;
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct page **pages = NULL;
@@ -1713,14 +1713,29 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	bool only_release_metadata = false;
 	bool force_page_uptodate = false;
 	loff_t old_isize = i_size_read(inode);
+	int ilock_flags = 0;
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		ilock_flags |= BTRFS_ILOCK_TRY;
+
+	ret = btrfs_inode_lock(inode, ilock_flags);
+	if (ret < 0)
+		return ret;
+
+	ret = btrfs_write_check(iocb, i);
+	if (ret <= 0)
+		goto out;
 
+	pos = iocb->ki_pos;
 	nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
 			PAGE_SIZE / (sizeof(struct page *)));
 	nrptrs = min(nrptrs, current->nr_dirtied_pause - current->nr_dirtied);
 	nrptrs = max(nrptrs, 8);
 	pages = kmalloc_array(nrptrs, sizeof(struct page *), GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
+	if (!pages) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	while (iov_iter_count(i) > 0) {
 		struct extent_state *cached_state = NULL;
@@ -1937,6 +1952,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		pagecache_isize_extended(inode, old_isize, iocb->ki_pos);
 		iocb->ki_pos += num_written;
 	}
+out:
+	btrfs_inode_unlock(inode, ilock_flags);
 	return num_written ? num_written : ret;
 }
 
@@ -1959,15 +1976,33 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	loff_t pos = iocb->ki_pos;
+	loff_t pos;
 	ssize_t written = 0;
 	bool relock = false;
 	ssize_t written_buffered;
 	loff_t endbyte;
 	int err;
+	int ilock_flags = 0;
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		ilock_flags |= BTRFS_ILOCK_TRY;
+
+	err = btrfs_inode_lock(inode, ilock_flags);
+	if (err < 0)
+		return err;
+
+	err = btrfs_write_check(iocb, from);
+	if (err <= 0) {
+		btrfs_inode_unlock(inode, ilock_flags);
+		goto out;
+	}
+
+	pos = iocb->ki_pos;
 
-	if (check_direct_IO(fs_info, from, pos))
+	if (check_direct_IO(fs_info, from, pos)) {
+		btrfs_inode_unlock(inode, ilock_flags);
 		goto buffered;
+	}
 
 	/*
 	 * If the write DIO is beyond the EOF, we need update
@@ -1998,8 +2033,10 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (relock)
 		btrfs_inode_lock(inode, 0);
 
-	if (written < 0 || !iov_iter_count(from))
-		return written;
+	if (written < 0 || !iov_iter_count(from)) {
+		err = written;
+		goto out;
+	}
 
 buffered:
 	pos = iocb->ki_pos;
@@ -2036,8 +2073,6 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	ssize_t num_written = 0;
 	const bool sync = iocb->ki_flags & IOCB_DSYNC;
-	ssize_t err;
-	int ilock_flags = 0;
 
 	/*
 	 * If BTRFS flips readonly due to some impossible error,
@@ -2051,19 +2086,6 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	    (iocb->ki_flags & IOCB_NOWAIT))
 		return -EOPNOTSUPP;
 
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		ilock_flags |= BTRFS_ILOCK_TRY;
-
-	err = btrfs_inode_lock(inode, ilock_flags);
-	if (err < 0)
-		return err;
-
-	err = btrfs_write_check(iocb, from);
-	if (err <= 0) {
-		btrfs_inode_unlock(inode, ilock_flags);
-		return err;
-	}
-
 	if (sync)
 		atomic_inc(&BTRFS_I(inode)->sync_writers);
 
@@ -2106,8 +2128,6 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		num_written = btrfs_buffered_write(iocb, from);
 	}
 
-	btrfs_inode_unlock(inode, ilock_flags);
-
 	/*
 	 * We also have to set last_sub_trans to the current log transid,
 	 * otherwise subsequent syncs to a file that's been synced in this
@@ -2123,7 +2143,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		atomic_dec(&BTRFS_I(inode)->sync_writers);
 
 	current->backing_dev_info = NULL;
-	return num_written ? num_written : err;
+	return num_written;
 }
 
 int btrfs_release_file(struct inode *inode, struct file *filp)
-- 
2.26.2

