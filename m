Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F3F719CC3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 14:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjFAM4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 08:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjFAM4k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:56:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6568618B
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 05:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E474660EC6
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 12:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E4FC433D2;
        Thu,  1 Jun 2023 12:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685624198;
        bh=FHIgTk3M69+TGLNzqLfENMz2sXl0FwkPiMSqIA1ea4U=;
        h=From:To:Cc:Subject:Date:From;
        b=C2TFQxQQrBUYYcj56+qJnk8S0m4H/sDJijdc3fR+xoFVPvmZT2NO15hwJF50GBK0n
         1BQ4H3+QloHO6yIcRdD5C63LLES5XbWzzXYp/qlDkDaJYF8SnjMew05MK1q2DqpGvj
         2oM7ZTkJYmz2t5mqeslX09XFLNz4XgeF1EOdz56N875UAMb7WF/uZPwPafFbIAwkBX
         xEEDkNNFyHYbxG6o2JbLrLC94zTMpnOEn93LBGfdJMMv4Za20TxWagop9QeXymDCrL
         sxQg/WVJCTjJcvw9cQHndvJJKzSyXAfgoPCM41NDgbLgJ+1aci9uOFfNem7j2K4AI1
         tATbCy21r9Usw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] zonefs: use iomap for synchronous direct writes
Date:   Thu,  1 Jun 2023 21:56:36 +0900
Message-Id: <20230601125636.205191-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the function zonefs_file_dio_append() that is used to manually
issue REQ_OP_ZONE_APPEND BIOs for processing synchronous direct writes
and use iomap instead.

To preserve the use of zone append operations for synchronous writes,
different struct iomap_dio_ops are defined. For synchronous direct
writes using zone append, zonefs_zone_append_dio_ops is introduced.
The submit_bio operation of this structure is defined as the function
zonefs_file_zone_append_dio_submit_io() which is used to change the BIO
opreation for synchronous direct IO writes to REQ_OP_ZONE_APPEND.

In order to preserve the write location check on completion of zone
append BIOs, the end_io operation is also defined using the function
zonefs_file_zone_append_dio_bio_end_io(). This check now relies on the
zonefs_zone_append_bio structure, allocated together with zone append
BIOs with a dedicated BIO set. This structure include the target inode
of a zone append BIO as well as the target append offset location for
the zone append operation. This is used to perform a check against
bio->bi_iter.bi_sector when the BIO completes, without needing to use
the zone information z_wpoffset field, thus removing the need for
taking the inode truncate mutex.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---

Changes from v1:
 * Renamed a few things (iomap operations, zonefs bio set, ...)
 * Restrict the use of the bio set to zone append synchronous writes

 fs/zonefs/file.c   | 206 ++++++++++++++++++++++++---------------------
 fs/zonefs/super.c  |   9 +-
 fs/zonefs/zonefs.h |   2 +
 3 files changed, 120 insertions(+), 97 deletions(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 132f01d3461f..c34ec5b54053 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -342,6 +342,77 @@ static loff_t zonefs_file_llseek(struct file *file, loff_t offset, int whence)
 	return generic_file_llseek_size(file, offset, whence, isize, isize);
 }
 
+struct zonefs_zone_append_bio {
+	/* The target inode of the BIO */
+	struct inode *inode;
+
+	/* For sync writes, the target append write offset */
+	u64 append_offset;
+
+	/*
+	 * This member must come last, bio_alloc_bioset will allocate enough
+	 * bytes for entire zonefs_bio but relies on bio being last.
+	 */
+	struct bio bio;
+};
+
+static inline struct zonefs_zone_append_bio *
+zonefs_zone_append_bio(struct bio *bio)
+{
+	return container_of(bio, struct zonefs_zone_append_bio, bio);
+}
+
+static void zonefs_file_zone_append_dio_bio_end_io(struct bio *bio)
+{
+	struct zonefs_zone_append_bio *za_bio = zonefs_zone_append_bio(bio);
+	struct zonefs_zone *z = zonefs_inode_zone(za_bio->inode);
+	sector_t za_sector;
+
+	if (bio->bi_status != BLK_STS_OK)
+		goto bio_end;
+
+	/*
+	 * If the file zone was written underneath the file system, the zone
+	 * append operation can still succedd (if the zone is not full) but
+	 * the write append location will not be where we expect it to be.
+	 * Check that we wrote where we intended to, that is, at z->z_wpoffset.
+	 */
+	za_sector = z->z_sector + (za_bio->append_offset >> SECTOR_SHIFT);
+	if (bio->bi_iter.bi_sector != za_sector) {
+		zonefs_warn(za_bio->inode->i_sb,
+			    "Invalid write sector %llu for zone at %llu\n",
+			    bio->bi_iter.bi_sector, z->z_sector);
+		bio->bi_status = BLK_STS_IOERR;
+	}
+
+bio_end:
+	iomap_dio_bio_end_io(bio);
+}
+
+static void zonefs_file_zone_append_dio_submit_io(const struct iomap_iter *iter,
+						  struct bio *bio,
+						  loff_t file_offset)
+{
+	struct zonefs_zone_append_bio *za_bio = zonefs_zone_append_bio(bio);
+	struct inode *inode = iter->inode;
+	struct zonefs_zone *z = zonefs_inode_zone(inode);
+
+	/*
+	 * Issue a zone append BIO to process sync dio writes. The append
+	 * file offset is saved to check the zone append write location
+	 * on completion of the BIO.
+	 */
+	za_bio->inode = inode;
+	za_bio->append_offset = file_offset;
+
+	bio->bi_opf &= ~REQ_OP_WRITE;
+	bio->bi_opf |= REQ_OP_ZONE_APPEND;
+	bio->bi_iter.bi_sector = z->z_sector;
+	bio->bi_end_io = zonefs_file_zone_append_dio_bio_end_io;
+
+	submit_bio(bio);
+}
+
 static int zonefs_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
 					int error, unsigned int flags)
 {
@@ -372,93 +443,17 @@ static int zonefs_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
 	return 0;
 }
 
-static const struct iomap_dio_ops zonefs_write_dio_ops = {
-	.end_io			= zonefs_file_write_dio_end_io,
-};
+static struct bio_set zonefs_zone_append_bio_set;
 
-static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
-{
-	struct inode *inode = file_inode(iocb->ki_filp);
-	struct zonefs_zone *z = zonefs_inode_zone(inode);
-	struct block_device *bdev = inode->i_sb->s_bdev;
-	unsigned int max = bdev_max_zone_append_sectors(bdev);
-	pgoff_t start, end;
-	struct bio *bio;
-	ssize_t size = 0;
-	int nr_pages;
-	ssize_t ret;
-
-	max = ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
-	iov_iter_truncate(from, max);
-
-	/*
-	 * If the inode block size (zone write granularity) is smaller than the
-	 * page size, we may be appending data belonging to the last page of the
-	 * inode straddling inode->i_size, with that page already cached due to
-	 * a buffered read or readahead. So make sure to invalidate that page.
-	 * This will always be a no-op for the case where the block size is
-	 * equal to the page size.
-	 */
-	start = iocb->ki_pos >> PAGE_SHIFT;
-	end = (iocb->ki_pos + iov_iter_count(from) - 1) >> PAGE_SHIFT;
-	if (invalidate_inode_pages2_range(inode->i_mapping, start, end))
-		return -EBUSY;
-
-	nr_pages = iov_iter_npages(from, BIO_MAX_VECS);
-	if (!nr_pages)
-		return 0;
-
-	bio = bio_alloc(bdev, nr_pages,
-			REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE, GFP_NOFS);
-	bio->bi_iter.bi_sector = z->z_sector;
-	bio->bi_ioprio = iocb->ki_ioprio;
-	if (iocb_is_dsync(iocb))
-		bio->bi_opf |= REQ_FUA;
-
-	ret = bio_iov_iter_get_pages(bio, from);
-	if (unlikely(ret))
-		goto out_release;
-
-	size = bio->bi_iter.bi_size;
-	task_io_account_write(size);
-
-	if (iocb->ki_flags & IOCB_HIPRI)
-		bio_set_polled(bio, iocb);
-
-	ret = submit_bio_wait(bio);
-
-	/*
-	 * If the file zone was written underneath the file system, the zone
-	 * write pointer may not be where we expect it to be, but the zone
-	 * append write can still succeed. So check manually that we wrote where
-	 * we intended to, that is, at zi->i_wpoffset.
-	 */
-	if (!ret) {
-		sector_t wpsector =
-			z->z_sector + (z->z_wpoffset >> SECTOR_SHIFT);
-
-		if (bio->bi_iter.bi_sector != wpsector) {
-			zonefs_warn(inode->i_sb,
-				"Corrupted write pointer %llu for zone at %llu\n",
-				bio->bi_iter.bi_sector, z->z_sector);
-			ret = -EIO;
-		}
-	}
-
-	zonefs_file_write_dio_end_io(iocb, size, ret, 0);
-	trace_zonefs_file_dio_append(inode, size, ret);
-
-out_release:
-	bio_release_pages(bio, false);
-	bio_put(bio);
-
-	if (ret >= 0) {
-		iocb->ki_pos += size;
-		return size;
-	}
+static const struct iomap_dio_ops zonefs_zone_append_dio_ops = {
+	.submit_io	= zonefs_file_zone_append_dio_submit_io,
+	.end_io		= zonefs_file_write_dio_end_io,
+	.bio_set	= &zonefs_zone_append_bio_set,
+};
 
-	return ret;
-}
+static const struct iomap_dio_ops zonefs_write_dio_ops = {
+	.end_io		= zonefs_file_write_dio_end_io,
+};
 
 /*
  * Do not exceed the LFS limits nor the file zone size. If pos is under the
@@ -539,6 +534,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct zonefs_zone *z = zonefs_inode_zone(inode);
 	struct super_block *sb = inode->i_sb;
+	const struct iomap_dio_ops *dio_ops;
 	bool sync = is_sync_kiocb(iocb);
 	bool append = false;
 	ssize_t ret, count;
@@ -582,20 +578,26 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	if (append) {
-		ret = zonefs_file_dio_append(iocb, from);
+		unsigned int max = bdev_max_zone_append_sectors(sb->s_bdev);
+
+		max = ALIGN_DOWN(max << SECTOR_SHIFT, sb->s_blocksize);
+		iov_iter_truncate(from, max);
+
+		dio_ops = &zonefs_zone_append_dio_ops;
 	} else {
-		/*
-		 * iomap_dio_rw() may return ENOTBLK if there was an issue with
-		 * page invalidation. Overwrite that error code with EBUSY to
-		 * be consistent with zonefs_file_dio_append() return value for
-		 * similar issues.
-		 */
-		ret = iomap_dio_rw(iocb, from, &zonefs_write_iomap_ops,
-				   &zonefs_write_dio_ops, 0, NULL, 0);
-		if (ret == -ENOTBLK)
-			ret = -EBUSY;
+		dio_ops = &zonefs_write_dio_ops;
 	}
 
+	/*
+	 * iomap_dio_rw() may return ENOTBLK if there was an issue with
+	 * page invalidation. Overwrite that error code with EBUSY so that
+	 * the user can make sense of the error.
+	 */
+	ret = iomap_dio_rw(iocb, from, &zonefs_write_iomap_ops,
+			   dio_ops, 0, NULL, 0);
+	if (ret == -ENOTBLK)
+		ret = -EBUSY;
+
 	if (zonefs_zone_is_seq(z) &&
 	    (ret > 0 || ret == -EIOCBQUEUED)) {
 		if (ret > 0)
@@ -900,3 +902,15 @@ const struct file_operations zonefs_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.iopoll		= iocb_bio_iopoll,
 };
+
+int zonefs_file_bioset_init(void)
+{
+	return bioset_init(&zonefs_zone_append_bio_set, BIO_POOL_SIZE,
+			   offsetof(struct zonefs_zone_append_bio, bio),
+			   BIOSET_NEED_BVECS);
+}
+
+void zonefs_file_bioset_exit(void)
+{
+	bioset_exit(&zonefs_zone_append_bio_set);
+}
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 23b8b299c64e..56c00111966a 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1412,10 +1412,14 @@ static int __init zonefs_init(void)
 
 	BUILD_BUG_ON(sizeof(struct zonefs_super) != ZONEFS_SUPER_SIZE);
 
-	ret = zonefs_init_inodecache();
+	ret = zonefs_file_bioset_init();
 	if (ret)
 		return ret;
 
+	ret = zonefs_init_inodecache();
+	if (ret)
+		goto destroy_bioset;
+
 	ret = zonefs_sysfs_init();
 	if (ret)
 		goto destroy_inodecache;
@@ -1430,6 +1434,8 @@ static int __init zonefs_init(void)
 	zonefs_sysfs_exit();
 destroy_inodecache:
 	zonefs_destroy_inodecache();
+destroy_bioset:
+	zonefs_file_bioset_exit();
 
 	return ret;
 }
@@ -1439,6 +1445,7 @@ static void __exit zonefs_exit(void)
 	unregister_filesystem(&zonefs_type);
 	zonefs_sysfs_exit();
 	zonefs_destroy_inodecache();
+	zonefs_file_bioset_exit();
 }
 
 MODULE_AUTHOR("Damien Le Moal");
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 8175652241b5..f663b8ebc2cb 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -279,6 +279,8 @@ extern const struct file_operations zonefs_dir_operations;
 extern const struct address_space_operations zonefs_file_aops;
 extern const struct file_operations zonefs_file_operations;
 int zonefs_file_truncate(struct inode *inode, loff_t isize);
+int zonefs_file_bioset_init(void);
+void zonefs_file_bioset_exit(void);
 
 /* In sysfs.c */
 int zonefs_sysfs_register(struct super_block *sb);
-- 
2.40.1

