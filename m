Return-Path: <linux-fsdevel+bounces-18573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D9F8BA5FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 06:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5CB280ED8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 04:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7776C51037;
	Fri,  3 May 2024 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GXB4aAio"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446D522EED
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714709865; cv=none; b=iUIsO3bnxU+22QQgM7uDC7BfOzg+cSFF+qCrmK6JR1rYtW5iG0cCUgC52xaApsBsWZNGLIWVLmAi/O6+DulkU9Wtf27Dy4H6eFvAbILYJbVvG4c1Xf7jiBcyjY2mSJ2izK3Mz7otOO2qJYKMyCF5aOv/4YHyaL5ltSjw/zDRR9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714709865; c=relaxed/simple;
	bh=37mbCXRg81hu2Jg6OwFEw0A1kjhiaqRfII19xkEketE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hzMp51dOmwbCrxVJoic8FodtT3FrQPUiIAk51JLRlAU88uxB9e/wfMmHn22i2a0P55V8Z6Mwzk+yXGErIJwBigwqXIjC0XQiap9V2ugcje5nKjP8JOmGRpeRnZ5Wwcnn/QooW+wZ0A33f7T4cQGj8QpJEFhLCChCo3kjVuVOmkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GXB4aAio; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=otYuiUfp6glLe1BtSNGdbv1TWJREe3lvfANqpWE7yEA=; b=GXB4aAiovYQDiv/DfTZLDoKISO
	TjCSAVjp7kY6hQc6Xs4n2X57ZDwjC4kVU7LmnUWl/F0zlJTt9uMJv+FprLP66tCBsXW9t74KgUJHx
	WzYvlzja8ebBcTfvrCU6anlZRSdsKvqxTlE2i4TcyGHAAQuq/6R+x4D65+ch2yHhnm8bL/C74/myK
	Bfdbqp4ifQMlZTQF42giUzQK8AMRy21ThXyoZiMUQMmYbquRlfQLqW4LpQgiAmCqdcCF4cAhBNE1S
	hDlAOWAVE/CTkiREZB41wuFQatcui/gMg2/i+9og7wx6aUxyH1/Ps6umoccbiipUm2DvB95Nrf9eb
	xpEEK46w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2kMf-00A5VX-2D
	for linux-fsdevel@vger.kernel.org;
	Fri, 03 May 2024 04:17:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 8/9] set_blocksize(): switch to passing struct file *
Date: Fri,  3 May 2024 05:17:39 +0100
Message-Id: <20240503041740.2404425-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503041740.2404425-1-viro@zeniv.linux.org.uk>
References: <20240503031833.GU2118490@ZenIV>
 <20240503041740.2404425-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/bdev.c            | 11 +++++++----
 block/ioctl.c           | 21 ++++++++++++---------
 drivers/block/pktcdvd.c |  2 +-
 fs/btrfs/dev-replace.c  |  2 +-
 fs/btrfs/volumes.c      |  4 ++--
 fs/ext4/super.c         |  2 +-
 fs/reiserfs/journal.c   |  5 ++---
 fs/xfs/xfs_buf.c        |  2 +-
 include/linux/blkdev.h  |  2 +-
 9 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b8e32d933a63..a329ff9be11d 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -144,8 +144,11 @@ static void set_init_blocksize(struct block_device *bdev)
 	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
 }
 
-int set_blocksize(struct block_device *bdev, int size)
+int set_blocksize(struct file *file, int size)
 {
+	struct inode *inode = file->f_mapping->host;
+	struct block_device *bdev = I_BDEV(inode);
+
 	/* Size must be a power of two, and between 512 and PAGE_SIZE */
 	if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
 		return -EINVAL;
@@ -155,9 +158,9 @@ int set_blocksize(struct block_device *bdev, int size)
 		return -EINVAL;
 
 	/* Don't change the size if it is same as current */
-	if (bdev->bd_inode->i_blkbits != blksize_bits(size)) {
+	if (inode->i_blkbits != blksize_bits(size)) {
 		sync_blockdev(bdev);
-		bdev->bd_inode->i_blkbits = blksize_bits(size);
+		inode->i_blkbits = blksize_bits(size);
 		kill_bdev(bdev);
 	}
 	return 0;
@@ -167,7 +170,7 @@ EXPORT_SYMBOL(set_blocksize);
 
 int sb_set_blocksize(struct super_block *sb, int size)
 {
-	if (set_blocksize(sb->s_bdev, size))
+	if (set_blocksize(sb->s_bdev_file, size))
 		return 0;
 	/* If we get here, we know size is power of two
 	 * and it's value is between 512 and PAGE_SIZE */
diff --git a/block/ioctl.c b/block/ioctl.c
index a9028a2c2db5..1c800364bc70 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -473,11 +473,14 @@ static int compat_hdio_getgeo(struct block_device *bdev,
 #endif
 
 /* set the logical block size */
-static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
+static int blkdev_bszset(struct file *file, blk_mode_t mode,
 		int __user *argp)
 {
+	// this one might be file_inode(file)->i_rdev - a rare valid
+	// use of file_inode() for those.
+	dev_t dev = I_BDEV(file->f_mapping->host)->bd_dev;
+	struct file *excl_file;
 	int ret, n;
-	struct file *file;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -487,13 +490,13 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
 		return -EFAULT;
 
 	if (mode & BLK_OPEN_EXCL)
-		return set_blocksize(bdev, n);
+		return set_blocksize(file, n);
 
-	file = bdev_file_open_by_dev(bdev->bd_dev, mode, &bdev, NULL);
-	if (IS_ERR(file))
+	excl_file = bdev_file_open_by_dev(dev, mode, &dev, NULL);
+	if (IS_ERR(excl_file))
 		return -EBUSY;
-	ret = set_blocksize(bdev, n);
-	fput(file);
+	ret = set_blocksize(excl_file, n);
+	fput(excl_file);
 	return ret;
 }
 
@@ -621,7 +624,7 @@ long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	case BLKBSZGET: /* get block device soft block size (cf. BLKSSZGET) */
 		return put_int(argp, block_size(bdev));
 	case BLKBSZSET:
-		return blkdev_bszset(bdev, mode, argp);
+		return blkdev_bszset(file, mode, argp);
 	case BLKGETSIZE64:
 		return put_u64(argp, bdev_nr_bytes(bdev));
 
@@ -681,7 +684,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	case BLKBSZGET_32: /* get the logical block size (cf. BLKSSZGET) */
 		return put_int(argp, bdev_logical_block_size(bdev));
 	case BLKBSZSET_32:
-		return blkdev_bszset(bdev, mode, argp);
+		return blkdev_bszset(file, mode, argp);
 	case BLKGETSIZE64_32:
 		return put_u64(argp, bdev_nr_bytes(bdev));
 
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 05933f25b397..8a2ce8070010 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2215,7 +2215,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 		}
 		dev_info(ddev, "%lukB available on disc\n", lba << 1);
 	}
-	set_blocksize(file_bdev(bdev_file), CD_FRAMESIZE);
+	set_blocksize(bdev_file, CD_FRAMESIZE);
 
 	return 0;
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 7696beec4c21..7130040d92ab 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -316,7 +316,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	set_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
 	device->dev_stats_valid = 1;
-	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
+	set_blocksize(bdev_file, BTRFS_BDEV_BLOCKSIZE);
 	device->fs_devices = fs_devices;
 
 	ret = btrfs_get_dev_zone_info(device, false);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 43af5a9fb547..65c03ddecc59 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -483,7 +483,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 	if (flush)
 		sync_blockdev(bdev);
 	if (holder) {
-		ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);
+		ret = set_blocksize(*bdev_file, BTRFS_BDEV_BLOCKSIZE);
 		if (ret) {
 			fput(*bdev_file);
 			goto error;
@@ -2717,7 +2717,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
 	device->dev_stats_valid = 1;
-	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
+	set_blocksize(device->bdev_file, BTRFS_BDEV_BLOCKSIZE);
 
 	if (seeding_dev) {
 		btrfs_clear_sb_rdonly(sb);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 044135796f2b..9988b3a40b42 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5873,7 +5873,7 @@ static struct file *ext4_get_journal_blkdev(struct super_block *sb,
 
 	sb_block = EXT4_MIN_BLOCK_SIZE / blocksize;
 	offset = EXT4_MIN_BLOCK_SIZE % blocksize;
-	set_blocksize(bdev, blocksize);
+	set_blocksize(bdev_file, blocksize);
 	bh = __bread(bdev, sb_block, blocksize);
 	if (!bh) {
 		ext4_msg(sb, KERN_ERR, "couldn't read superblock of "
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index e539ccd39e1e..e477ee0ff35d 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2626,8 +2626,7 @@ static int journal_init_dev(struct super_block *super,
 					 MAJOR(jdev), MINOR(jdev), result);
 			return result;
 		} else if (jdev != super->s_dev)
-			set_blocksize(file_bdev(journal->j_bdev_file),
-				      super->s_blocksize);
+			set_blocksize(journal->j_bdev_file, super->s_blocksize);
 
 		return 0;
 	}
@@ -2643,7 +2642,7 @@ static int journal_init_dev(struct super_block *super,
 		return result;
 	}
 
-	set_blocksize(file_bdev(journal->j_bdev_file), super->s_blocksize);
+	set_blocksize(journal->j_bdev_file, super->s_blocksize);
 	reiserfs_info(super,
 		      "journal_init_dev: journal device: %pg\n",
 		      file_bdev(journal->j_bdev_file));
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index f0fa02264eda..2dc0eacb0999 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2043,7 +2043,7 @@ xfs_setsize_buftarg(
 	btp->bt_meta_sectorsize = sectorsize;
 	btp->bt_meta_sectormask = sectorsize - 1;
 
-	if (set_blocksize(btp->bt_bdev, sectorsize)) {
+	if (set_blocksize(btp->bt_bdev_file, sectorsize)) {
 		xfs_warn(btp->bt_mount,
 			"Cannot set_blocksize to %u on device %pg",
 			sectorsize, btp->bt_bdev);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 172c91879999..20c749b2ebc2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1474,7 +1474,7 @@ static inline void bio_end_io_acct(struct bio *bio, unsigned long start_time)
 }
 
 int bdev_read_only(struct block_device *bdev);
-int set_blocksize(struct block_device *bdev, int size);
+int set_blocksize(struct file *file, int size);
 
 int lookup_bdev(const char *pathname, dev_t *dev);
 
-- 
2.39.2


