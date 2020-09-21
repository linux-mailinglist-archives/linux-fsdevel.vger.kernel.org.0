Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F5D2728AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 16:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgIUOoh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 10:44:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:56140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbgIUOog (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:44:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9EA9AF76;
        Mon, 21 Sep 2020 14:45:09 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 10/15] btrfs: Push inode locking and unlocking into buffered/direct write
Date:   Mon, 21 Sep 2020 09:43:48 -0500
Message-Id: <20200921144353.31319-11-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921144353.31319-1-rgoldwyn@suse.de>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Push inode locking and unlocking closer to where we perform the I/O. For
this we need to move the write checks inside the respective functions as
well.

pos is assigned after write checks because generic_write_check can
modify iocb->ki_pos.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 67 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7e18334e8121..d9c3be19d7b3 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1698,7 +1698,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					       struct iov_iter *i)
 {
 	struct file *file = iocb->ki_filp;
-	loff_t pos = iocb->ki_pos;
+	loff_t pos;
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct page **pages = NULL;
@@ -1712,14 +1712,29 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
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
@@ -1936,6 +1951,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		pagecache_isize_extended(inode, old_isize, iocb->ki_pos);
 		iocb->ki_pos += num_written;
 	}
+out:
+	btrfs_inode_unlock(inode, ilock_flags);
 	return num_written ? num_written : ret;
 }
 
@@ -1958,15 +1975,33 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
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
@@ -1997,8 +2032,10 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
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
@@ -2036,7 +2073,6 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	ssize_t num_written = 0;
 	const bool sync = iocb->ki_flags & IOCB_DSYNC;
 	ssize_t err;
-	int ilock_flags = 0;
 
 	/*
 	 * If BTRFS flips readonly due to some impossible error
@@ -2051,19 +2087,6 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
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
 
@@ -2106,8 +2129,6 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		num_written = btrfs_buffered_write(iocb, from);
 	}
 
-	btrfs_inode_unlock(inode, ilock_flags);
-
 	/*
 	 * We also have to set last_sub_trans to the current log transid,
 	 * otherwise subsequent syncs to a file that's been synced in this
-- 
2.26.2

