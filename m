Return-Path: <linux-fsdevel+bounces-17984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF008B4845
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 23:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEA01C213C8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 21:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D43145B3E;
	Sat, 27 Apr 2024 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UiBsKh7/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACB5A94A;
	Sat, 27 Apr 2024 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714252388; cv=none; b=BpiywYQsYlYX38wYWvhjLOwvlHANPe+PRlOyQDz5TmOzfCCxTXkYanwam22TpPZ8VxYzACuQESCvE6nZ1Y4mzf4gklXakrO8sJvoWvyvb/xLU35U93NnkJePA17TPt68EmmO4mfqeUwhBPBDauwkdXKw6tNHpvkXclm6F1iIaBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714252388; c=relaxed/simple;
	bh=r4NGhejj79ghjawb1edryTjprXuMxikLIrLf5O+qfUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1iWoMu9M5ZurOrCuSKD+SnRLKKX0t61BRmDG2IsXLwfjdE/DnQmSrp/mFwcuixonUf6gj3chWsYaLt+GIWfWiQ0cjLtGKdO+nG4eR73vjY+WTFglnSb5Ykheyuc5KceE0ydwX8DII2RF+1fy3tH7CXNnJpmvidNzupP4HgHIT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UiBsKh7/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T09a3W2M0shAKd9LrH44PfI4tW9LI+0vm0S2Nbv0AhQ=; b=UiBsKh7/9WyTJ7r7iPYPSJPmlb
	guVLn9LqAICStN8o8btol1aGryFeHpJkPC+UtSlRxWLd5qb2wltp9Xy+E+885mvoSiAGIL0iMxLh8
	rz0Kg2NHX31ObY6XWc2ncuvJ1/mq7vgeC1oTdhwRN+jVrCgHsAGSffG7r46Dc1El7LJJxgub5/gpQ
	HwMrV2MDbi4yWs4/Gwo6CzEhTty7mt6FcVhsPBq3RH+pUJV8a0PxSZBX07U+bRmGGL2DFCDSRRyC5
	gNhL+zTd5sUkklUjJey97nqpuxkCvl2mMaOLUTLOeiECY8Lz1e426CeilocbkIvCUYwf00ufB6lww
	R8HiciCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0pM1-006HAz-0A;
	Sat, 27 Apr 2024 21:13:05 +0000
Date: Sat, 27 Apr 2024 22:13:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7/7] set_blocksize(): switch to passing struct file *, fail
 if it's not opened exclusive
Message-ID: <20240427211305.GG1495312@ZenIV>
References: <20240427210920.GR2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427210920.GR2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/bdev.c            | 14 ++++++++++----
 block/ioctl.c           | 21 ++++++++++++---------
 drivers/block/pktcdvd.c |  2 +-
 fs/btrfs/dev-replace.c  |  2 +-
 fs/btrfs/volumes.c      |  4 ++--
 fs/ext4/super.c         |  2 +-
 fs/reiserfs/journal.c   |  5 ++---
 fs/xfs/xfs_buf.c        |  2 +-
 include/linux/blkdev.h  |  2 +-
 9 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b8e32d933a63..a89bce368b64 100644
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
@@ -154,10 +157,13 @@ int set_blocksize(struct block_device *bdev, int size)
 	if (size < bdev_logical_block_size(bdev))
 		return -EINVAL;
 
+	if (!file->private_data)
+		return -EINVAL;
+
 	/* Don't change the size if it is same as current */
-	if (bdev->bd_inode->i_blkbits != blksize_bits(size)) {
+	if (inode->i_blkbits != blksize_bits(size)) {
 		sync_blockdev(bdev);
-		bdev->bd_inode->i_blkbits = blksize_bits(size);
+		inode->i_blkbits = blksize_bits(size);
 		kill_bdev(bdev);
 	}
 	return 0;
@@ -167,7 +173,7 @@ EXPORT_SYMBOL(set_blocksize);
 
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


