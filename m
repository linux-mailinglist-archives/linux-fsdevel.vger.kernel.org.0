Return-Path: <linux-fsdevel+bounces-11511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E570854308
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 07:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22913286527
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 06:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F1711193;
	Wed, 14 Feb 2024 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6jFj9mx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A4DB677
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707893130; cv=none; b=ayeAnjAmupI9JBZCdDfO153Q4chyj03WP5Y0q8K0f4LIN4QC2ZhDqRum+ysPMI85K/9TEFKbVS8bUHkFhWfN9xvBj4zP2F6rMZPsOD5NTMJCpVJQ7ufptsHuAdAuSy7UIK9SPR/U3Q+GdFHYDH1vuOGOrSNq21zS5SXygDcpXRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707893130; c=relaxed/simple;
	bh=tTuVr3i8XE2tA7zMiIuLnCk4pd4uJeSLOWAgHFhHd8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NvBTzCyFw6QHzm0YPDndo5NKXKmLwZUdugQ4A/5LZeX1llp6Vgssmy+jWVVP8VbK+coMq1UMH3E87VTJ8Da83dwlH7BfDrcfGAg0+VPz54pTRf4Cy8mj8VFjvigDwcqmahAFlvB01gZf98QTiC9JuuJ1MIok8M/Z1e4JspxuGR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6jFj9mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DD9C433F1;
	Wed, 14 Feb 2024 06:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707893129;
	bh=tTuVr3i8XE2tA7zMiIuLnCk4pd4uJeSLOWAgHFhHd8U=;
	h=From:To:Cc:Subject:Date:From;
	b=E6jFj9mxOxAsessn1qJWp/ME689P9Mr+JF07f4VN7N/tPYF0xEHHJcUDeMkTRyCdi
	 +FEqo03IlSaltfWz57pSO9t0/RVoGxdwAQbwpMe+i63SsKPSW94tYxNlnVQCuwPmof
	 fZn268bRMruJC8/TUzIL9eU1P9GiAo2FbgLr0YiMmaQyzPI6RPNOcvlgIsyn3ln/Zv
	 LkEqbwtwC+WX36P/Sz18TcHEhPEXrS5lLrFtGp+beUjc23LB0PtBFna+sn8chdRy/S
	 OmVrvLBhf4W8zWRoQ8EZEz0KWKIdGfZepIFI+FG4Zgkk8fVquemWZ7LvLqMzJ8+vXM
	 0qsZ6IrXBL9pA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] zonefs: Improve error handling
Date: Wed, 14 Feb 2024 15:45:26 +0900
Message-ID: <20240214064526.3433662-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Write error handling is racy and can sometime lead to the error recovery
path wrongly changing the inode size of a sequential zone file to an
incorrect value  which results in garbage data being readable at the end
of a file. There are 2 problems:

1) zonefs_file_dio_write() updates a zone file write pointer offset
   after issuing a direct IO with iomap_dio_rw(). This update is done
   only if the IO succeed for synchronous direct writes. However, for
   asynchronous direct writes, the update is done without waiting for
   the IO completion so that the next asynchronous IO can be
   immediately issued. However, if an asynchronous IO completes with a
   failure right before the i_truncate_mutex lock protecting the update,
   the update may change the value of the inode write pointer offset
   that was corrected by the error path (zonefs_io_error() function).

2) zonefs_io_error() is called when a read or write error occurs. This
   function executes a report zone operation using the callback function
   zonefs_io_error_cb(), which does all the error recovery handling
   based on the current zone condition, write pointer position and
   according to the mount options being used. However, depending on the
   zoned device being used, a report zone callback may be executed in a
   context that is different from the context of __zonefs_io_error(). As
   a result, zonefs_io_error_cb() may be executed without the inode
   truncate mutex lock held, which can lead to invalid error processing.

Fix both problems as follows:
- Problem 1: Perform the inode write pointer offset update before a
  direct write is issued with iomap_dio_rw(). This is safe to do as
  partial direct writes are not supported (IOMAP_DIO_PARTIAL is not
  set) and any failed IO will trigger the execution of zonefs_io_error()
  which will correct the inode write pointer offset to reflect the
  current state of the one on the device.
- Problem 2: Change zonefs_io_error_cb() into zonefs_handle_io_error()
  and call this function directly from __zonefs_io_error() after
  obtaining the zone information using blkdev_report_zones() with a
  simple callback function that copies to a local stack variable the
  struct blk_zone obtained from the device. This ensures that error
  handling is performed holding the inode truncate mutex.
  This change also simplifies error handling for conventional zone files
  by bypassing the execution of report zones entirely. This is safe to
  do because the condition of conventional zones cannot be read-only or
  offline and conventional zone files are always fully mapped with a
  constant file size.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 fs/zonefs/file.c  | 42 +++++++++++++++++++-----------
 fs/zonefs/super.c | 66 +++++++++++++++++++++++++++--------------------
 2 files changed, 65 insertions(+), 43 deletions(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 6ab2318a9c8e..dba5dcb62bef 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -348,7 +348,12 @@ static int zonefs_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 
 	if (error) {
-		zonefs_io_error(inode, true);
+		/*
+		 * For Sync IOs, error recovery is called from
+		 * zonefs_file_dio_write().
+		 */
+		if (!is_sync_kiocb(iocb))
+			zonefs_io_error(inode, true);
 		return error;
 	}
 
@@ -491,6 +496,14 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 			ret = -EINVAL;
 			goto inode_unlock;
 		}
+		/*
+		 * Advance the zone write pointer offset. This assumes that the
+		 * IO will succeed, which is OK to do because we do not allow
+		 * partial writes (IOMAP_DIO_PARTIAL is not set) and if the IO
+		 * fails, the error path will correct the write pointer offset.
+		 */
+		z->z_wpoffset += count;
+		zonefs_inode_account_active(inode);
 		mutex_unlock(&zi->i_truncate_mutex);
 	}
 
@@ -504,20 +517,19 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	if (ret == -ENOTBLK)
 		ret = -EBUSY;
 
-	if (zonefs_zone_is_seq(z) &&
-	    (ret > 0 || ret == -EIOCBQUEUED)) {
-		if (ret > 0)
-			count = ret;
-
-		/*
-		 * Update the zone write pointer offset assuming the write
-		 * operation succeeded. If it did not, the error recovery path
-		 * will correct it. Also do active seq file accounting.
-		 */
-		mutex_lock(&zi->i_truncate_mutex);
-		z->z_wpoffset += count;
-		zonefs_inode_account_active(inode);
-		mutex_unlock(&zi->i_truncate_mutex);
+	/*
+	 * For a failed IO or partial completion, trigger error recovery
+	 * to update the zone write pointer offset to a correct value.
+	 * For asynchronous IOs, zonefs_file_write_dio_end_io() may already
+	 * have executed error recovery if the IO already completed when we
+	 * reach here. However, we cannot know that and execute error recovery
+	 * again (that will not change anything).
+	 */
+	if (zonefs_zone_is_seq(z)) {
+		if (ret > 0 && ret != count)
+			ret = -EIO;
+		if (ret < 0 && ret != -EIOCBQUEUED)
+			zonefs_io_error(inode, true);
 	}
 
 inode_unlock:
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 93971742613a..b6e8e7c96251 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -246,16 +246,18 @@ static void zonefs_inode_update_mode(struct inode *inode)
 	z->z_mode = inode->i_mode;
 }
 
-struct zonefs_ioerr_data {
-	struct inode	*inode;
-	bool		write;
-};
-
 static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 			      void *data)
 {
-	struct zonefs_ioerr_data *err = data;
-	struct inode *inode = err->inode;
+	struct blk_zone *z = data;
+
+	*z = *zone;
+	return 0;
+}
+
+static void zonefs_handle_io_error(struct inode *inode, struct blk_zone *zone,
+				   bool write)
+{
 	struct zonefs_zone *z = zonefs_inode_zone(inode);
 	struct super_block *sb = inode->i_sb;
 	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
@@ -270,8 +272,8 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	data_size = zonefs_check_zone_condition(sb, z, zone);
 	isize = i_size_read(inode);
 	if (!(z->z_flags & (ZONEFS_ZONE_READONLY | ZONEFS_ZONE_OFFLINE)) &&
-	    !err->write && isize == data_size)
-		return 0;
+	    !write && isize == data_size)
+		return;
 
 	/*
 	 * At this point, we detected either a bad zone or an inconsistency
@@ -292,7 +294,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	 * In all cases, warn about inode size inconsistency and handle the
 	 * IO error according to the zone condition and to the mount options.
 	 */
-	if (zonefs_zone_is_seq(z) && isize != data_size)
+	if (isize != data_size)
 		zonefs_warn(sb,
 			    "inode %lu: invalid size %lld (should be %lld)\n",
 			    inode->i_ino, isize, data_size);
@@ -352,8 +354,6 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	zonefs_i_size_write(inode, data_size);
 	z->z_wpoffset = data_size;
 	zonefs_inode_account_active(inode);
-
-	return 0;
 }
 
 /*
@@ -367,23 +367,25 @@ void __zonefs_io_error(struct inode *inode, bool write)
 {
 	struct zonefs_zone *z = zonefs_inode_zone(inode);
 	struct super_block *sb = inode->i_sb;
-	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 	unsigned int noio_flag;
-	unsigned int nr_zones = 1;
-	struct zonefs_ioerr_data err = {
-		.inode = inode,
-		.write = write,
-	};
+	struct blk_zone zone;
 	int ret;
 
 	/*
-	 * The only files that have more than one zone are conventional zone
-	 * files with aggregated conventional zones, for which the inode zone
-	 * size is always larger than the device zone size.
+	 * Conventional zone have no write pointer and cannot become read-only
+	 * or offline. So simply fake a report for a single or aggregated zone
+	 * and let zonefs_handle_io_error() correct the zone inode information
+	 * according to the mount options.
 	 */
-	if (z->z_size > bdev_zone_sectors(sb->s_bdev))
-		nr_zones = z->z_size >>
-			(sbi->s_zone_sectors_shift + SECTOR_SHIFT);
+	if (!zonefs_zone_is_seq(z)) {
+		zone.start = z->z_sector;
+		zone.len = z->z_size >> SECTOR_SHIFT;
+		zone.wp = zone.start + zone.len;
+		zone.type = BLK_ZONE_TYPE_CONVENTIONAL;
+		zone.cond = BLK_ZONE_COND_NOT_WP;
+		zone.capacity = zone.len;
+		goto handle_io_error;
+	}
 
 	/*
 	 * Memory allocations in blkdev_report_zones() can trigger a memory
@@ -394,12 +396,20 @@ void __zonefs_io_error(struct inode *inode, bool write)
 	 * the GFP_NOIO context avoids both problems.
 	 */
 	noio_flag = memalloc_noio_save();
-	ret = blkdev_report_zones(sb->s_bdev, z->z_sector, nr_zones,
-				  zonefs_io_error_cb, &err);
-	if (ret != nr_zones)
+	ret = blkdev_report_zones(sb->s_bdev, z->z_sector, 1,
+				  zonefs_io_error_cb, &zone);
+	memalloc_noio_restore(noio_flag);
+
+	if (ret != 1) {
 		zonefs_err(sb, "Get inode %lu zone information failed %d\n",
 			   inode->i_ino, ret);
-	memalloc_noio_restore(noio_flag);
+		zonefs_warn(sb, "remounting filesystem read-only\n");
+		sb->s_flags |= SB_RDONLY;
+		return;
+	}
+
+handle_io_error:
+	zonefs_handle_io_error(inode, &zone, write);
 }
 
 static struct kmem_cache *zonefs_inode_cachep;
-- 
2.43.0


