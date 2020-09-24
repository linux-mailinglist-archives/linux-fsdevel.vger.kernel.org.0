Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9FF2776F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 18:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgIXQkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 12:40:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:36540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbgIXQkE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:40:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2950EB28E;
        Thu, 24 Sep 2020 16:40:02 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 09/14] btrfs: Introduce btrfs_inode_lock()/unlock()
Date:   Thu, 24 Sep 2020 11:39:16 -0500
Message-Id: <20200924163922.2547-10-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924163922.2547-1-rgoldwyn@suse.de>
References: <20200924163922.2547-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

btrfs_inode_lock/unlock() acquires the inode->i_rwsem depending on the
flags passed. ilock_flags determines the type of lock to be taken:

BTRFS_ILOCK_SHARED - for shared locks, for possible parallel DIO
BTRFS_ILOCK_TRY - for the RWF_NOWAIT sequence

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h |  7 +++++++
 fs/btrfs/file.c  | 31 ++++++++++++++++---------------
 fs/btrfs/inode.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 15 deletions(-)

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
index 61885b180c8c..a9d0950fd922 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1975,7 +1975,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 * not unlock the i_mutex at this case.
 	 */
 	if (pos + iov_iter_count(from) <= inode->i_size) {
-		inode_unlock(inode);
+		btrfs_inode_unlock(inode, 0);
 		relock = true;
 	}
 	down_read(&BTRFS_I(inode)->dio_sem);
@@ -1996,7 +1996,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 	up_read(&BTRFS_I(inode)->dio_sem);
 	if (relock)
-		inode_lock(inode);
+		btrfs_inode_lock(inode, 0);
 
 	if (written < 0 || !iov_iter_count(from))
 		return written;
@@ -2037,6 +2037,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	ssize_t num_written = 0;
 	const bool sync = iocb->ki_flags & IOCB_DSYNC;
 	ssize_t err;
+	int ilock_flags = 0;
 
 	/*
 	 * If BTRFS flips readonly due to some impossible error,
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
index 0730131b6590..cdde4422a6fa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -96,6 +96,51 @@ static void __endio_write_update_ordered(struct btrfs_inode *inode,
 					 const u64 offset, const u64 bytes,
 					 const bool uptodate);
 
+/*
+ *  btrfs_inode_lock() - Lock i_rwsem based on arguments passed
+ *
+ * ilock_flags can have the following bit set:
+ *  BTRFS_ILOCK_SHARED - acquire a shared lock on the inode
+ *  BTRFS_ILOCK_TRY - try to acquire the lock. if fails on first attempt
+ *		      return -EAGAIN
+ */
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
+/*
+ * btrfs_inode_unlock() - Unock i_rwsem
+ * ilock_flags should contain the same bits set as passed to
+ * btrfs_inode_lock() to decide whether the lock acquired is shared
+ * of exclusive.
+ */
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

