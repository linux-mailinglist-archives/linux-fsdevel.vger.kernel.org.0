Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD452728A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgIUOoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 10:44:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:56074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbgIUOod (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:44:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C9BCAF3F;
        Mon, 21 Sep 2020 14:45:07 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 09/15] btrfs: Introduce btrfs_inode_lock()/unlock()
Date:   Mon, 21 Sep 2020 09:43:47 -0500
Message-Id: <20200921144353.31319-10-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921144353.31319-1-rgoldwyn@suse.de>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Helper functions for locking/unlocking i_rwsem.
btrfs_inode_lock/unlock() acquires the inode->i_rwsem depending on the
flags passed. ilock_flags determines the type of lock to be taken:

BTRFS_ILOCK_SHARED - for shared locks, for possible parallel DIO
BTRFS_ILOCK_TRY - for the RWF_NOWAIT sequence

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h |  7 +++++++
 fs/btrfs/file.c  | 31 ++++++++++++++++---------------
 fs/btrfs/inode.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b47a8dcff028..ea15771bf3da 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3053,6 +3053,13 @@ extern const struct iomap_ops btrfs_dio_iomap_ops;
 extern const struct iomap_dio_ops btrfs_dio_ops;
 extern const struct iomap_dio_ops btrfs_sync_dops;
 
+/* ilock flags definition */
+#define BTRFS_ILOCK_SHARED	(1 << 0)
+#define BTRFS_ILOCK_TRY 	(1 << 1)
+
+int btrfs_inode_lock(struct inode *inode, int ilock_flags);
+void btrfs_inode_unlock(struct inode *inode, int ilock_flags);
+
 /* ioctl.c */
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0f961ce1fa98..7e18334e8121 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1974,7 +1974,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 * not unlock the i_mutex at this case.
 	 */
 	if (pos + iov_iter_count(from) <= inode->i_size) {
-		inode_unlock(inode);
+		btrfs_inode_unlock(inode, 0);
 		relock = true;
 	}
 	down_read(&BTRFS_I(inode)->dio_sem);
@@ -1995,7 +1995,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 	up_read(&BTRFS_I(inode)->dio_sem);
 	if (relock)
-		inode_lock(inode);
+		btrfs_inode_lock(inode, 0);
 
 	if (written < 0 || !iov_iter_count(from))
 		return written;
@@ -2036,6 +2036,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	ssize_t num_written = 0;
 	const bool sync = iocb->ki_flags & IOCB_DSYNC;
 	ssize_t err;
+	int ilock_flags = 0;
 
 	/*
 	 * If BTRFS flips readonly due to some impossible error
@@ -2050,16 +2051,16 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	    (iocb->ki_flags & IOCB_NOWAIT))
 		return -EOPNOTSUPP;
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (!inode_trylock(inode))
-			return -EAGAIN;
-	} else {
-		inode_lock(inode);
-	}
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		ilock_flags |= BTRFS_ILOCK_TRY;
+
+	err = btrfs_inode_lock(inode, ilock_flags);
+	if (err < 0)
+		return err;
 
 	err = btrfs_write_check(iocb, from);
 	if (err <= 0) {
-		inode_unlock(inode);
+		btrfs_inode_unlock(inode, ilock_flags);
 		return err;
 	}
 
@@ -2105,7 +2106,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		num_written = btrfs_buffered_write(iocb, from);
 	}
 
-	inode_unlock(inode);
+	btrfs_inode_unlock(inode, ilock_flags);
 
 	/*
 	 * We also have to set last_sub_trans to the current log transid,
@@ -3405,7 +3406,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 			return ret;
 	}
 
-	inode_lock(inode);
+	btrfs_inode_lock(inode, 0);
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size) {
 		ret = inode_newsize_ok(inode, offset + len);
@@ -3644,9 +3645,9 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 		return generic_file_llseek(file, offset, whence);
 	case SEEK_DATA:
 	case SEEK_HOLE:
-		inode_lock_shared(inode);
+		btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
 		offset = find_desired_extent(inode, offset, whence);
-		inode_unlock_shared(inode);
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 		break;
 	}
 
@@ -3690,10 +3691,10 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	if (check_direct_read(btrfs_sb(inode->i_sb), to, iocb->ki_pos))
 		return 0;
 
-	inode_lock_shared(inode);
+	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
 	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
 			is_sync_kiocb(iocb));
-	inode_unlock_shared(inode);
+	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 	return ret;
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0730131b6590..f305efac75ae 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -96,6 +96,37 @@ static void __endio_write_update_ordered(struct btrfs_inode *inode,
 					 const u64 offset, const u64 bytes,
 					 const bool uptodate);
 
+int btrfs_inode_lock(struct inode *inode, int ilock_flags)
+{
+	if (ilock_flags & BTRFS_ILOCK_SHARED) {
+		if (ilock_flags & BTRFS_ILOCK_TRY) {
+			if (!inode_trylock_shared(inode))
+				return -EAGAIN;
+			else
+				return 0;
+		}
+		inode_lock_shared(inode);
+	} else {
+		if (ilock_flags & BTRFS_ILOCK_TRY) {
+			if (!inode_trylock(inode))
+				return -EAGAIN;
+			else
+				return 0;
+		}
+		inode_lock(inode);
+	}
+	return 0;
+}
+
+void btrfs_inode_unlock(struct inode *inode, int ilock_flags)
+{
+	if (ilock_flags & BTRFS_ILOCK_SHARED)
+		inode_unlock_shared(inode);
+	else
+		inode_unlock(inode);
+
+}
+
 /*
  * Cleanup all submitted ordered extents in specified range to handle errors
  * from the btrfs_run_delalloc_range() callback.
-- 
2.26.2

