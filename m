Return-Path: <linux-fsdevel+bounces-16290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF6A89AA0D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FCE282994
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F42440857;
	Sat,  6 Apr 2024 09:17:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF8522EF4;
	Sat,  6 Apr 2024 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395077; cv=none; b=JxnvO5PiQ6kzVxdikMzz1GNwI0si+A/j4L1ui/g3RfYKhwH834BMHW6SXcFc3Ywdh3caYNgxJT9snCEr8ZTJaYOGjUbjic+afanqOKPYC+QjpzIXB1Rt9Eri7TxJuf4iwZStkzUNafDBR3SNSVNyOtj/edpn/1Df4rc48yP7yNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395077; c=relaxed/simple;
	bh=uuwI0ExCc5LHc3HCq/LUZaJS3kD1vKo2Qex/s185n0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T6fu3aoXN/K0Uvd1W/0JL9/Q0Oc/9LV4+25OtNRd6XVFfNg/c279cMX5Vm2PW7nSbORbcHVQyMfEaUFtC5gt73Q2HWylze/QTOqr1e0fd4cFVLpXMlm1wCnDHHfXs9fHOu6OBsAiDinYT6Cy2zN7LbCxn6DxNI3R0iUCloaXguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBVBJ0JTQz4f3lfx;
	Sat,  6 Apr 2024 17:17:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 861671A058D;
	Sat,  6 Apr 2024 17:17:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REyExFm0JDpJA--.50223S29;
	Sat, 06 Apr 2024 17:17:52 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	hch@lst.de,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH vfs.all 25/26] buffer: add helpers to get and set bdev
Date: Sat,  6 Apr 2024 17:09:29 +0800
Message-Id: <20240406090930.2252838-26-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+REyExFm0JDpJA--.50223S29
X-Coremail-Antispam: 1UD129KBjvAXoW3KF17XF18uw4ktw15Gr47CFg_yoW8ZrW7Ao
	Wavw4xXr48t3sFy3yIkryFqFyUJasxtrZ5JF48WFZ8ua4ftr1q9ry3Kw12ya4xGw1FkryY
	grW5Jw45XF4Uu3ykn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYu7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
	Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

So that we have unified APIs, there are no functional changes and
prepare to convert buffer_head to use bdev_file.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/fops.c                  |  2 +-
 drivers/md/md-bitmap.c        |  2 +-
 fs/affs/file.c                |  2 +-
 fs/buffer.c                   | 10 +++++-----
 fs/direct-io.c                |  4 ++--
 fs/ext2/xattr.c               |  2 +-
 fs/ext4/mmp.c                 |  2 +-
 fs/ext4/page-io.c             |  5 ++---
 fs/ext4/xattr.c               |  2 +-
 fs/gfs2/aops.c                |  2 +-
 fs/gfs2/meta_io.c             |  2 +-
 fs/jbd2/commit.c              |  2 +-
 fs/jbd2/journal.c             |  2 +-
 fs/jbd2/transaction.c         |  8 ++++----
 fs/mpage.c                    | 10 +++++-----
 fs/nilfs2/btnode.c            |  4 ++--
 fs/nilfs2/gcinode.c           |  2 +-
 fs/nilfs2/mdt.c               |  2 +-
 fs/nilfs2/page.c              |  4 ++--
 fs/ntfs3/inode.c              |  2 +-
 fs/reiserfs/fix_node.c        |  2 +-
 fs/reiserfs/journal.c         |  2 +-
 fs/reiserfs/prints.c          |  4 ++--
 fs/reiserfs/stree.c           |  2 +-
 fs/reiserfs/tail_conversion.c |  2 +-
 include/linux/buffer_head.h   | 20 +++++++++++++++++++-
 include/trace/events/block.h  |  2 +-
 27 files changed, 61 insertions(+), 44 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 7d177be788cd..edae216e31dd 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -407,7 +407,7 @@ static const struct iomap_ops blkdev_iomap_ops = {
 static int blkdev_get_block(struct inode *inode, sector_t iblock,
 		struct buffer_head *bh, int create)
 {
-	bh->b_bdev = I_BDEV(inode);
+	bh_set_bdev_file(bh, inode->i_private);
 	bh->b_blocknr = iblock;
 	set_buffer_mapped(bh);
 	return 0;
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 059afc24c08b..fd6c95e0c625 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -381,7 +381,7 @@ static int read_file_page(struct file *file, unsigned long index,
 			}
 
 			bh->b_blocknr = block;
-			bh->b_bdev = inode->i_sb->s_bdev;
+			bh_set_bdev_file(bh, inode->i_sb->s_bdev_file);
 			if (count < blocksize)
 				count = 0;
 			else
diff --git a/fs/affs/file.c b/fs/affs/file.c
index 04c018e19602..f15b24202aab 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -365,7 +365,7 @@ affs_get_block(struct inode *inode, sector_t block, struct buffer_head *bh_resul
 err_alloc:
 	brelse(ext_bh);
 	clear_buffer_mapped(bh_result);
-	bh_result->b_bdev = NULL;
+	bh_set_bdev_file(bh_result, NULL);
 	// unlock cache
 	affs_unlock_ext(inode);
 	return -ENOSPC;
diff --git a/fs/buffer.c b/fs/buffer.c
index 7900720fc54b..e4d74eb63265 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -129,7 +129,7 @@ static void buffer_io_error(struct buffer_head *bh, char *msg)
 	if (!test_bit(BH_Quiet, &bh->b_state))
 		printk_ratelimited(KERN_ERR
 			"Buffer I/O error on dev %pg, logical block %llu%s\n",
-			bh->b_bdev, (unsigned long long)bh->b_blocknr, msg);
+			bh_bdev(bh), (unsigned long long)bh->b_blocknr, msg);
 }
 
 /*
@@ -1367,7 +1367,7 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		struct buffer_head *bh = __this_cpu_read(bh_lrus.bhs[i]);
 
-		if (bh && bh->b_blocknr == block && bh->b_bdev == bdev &&
+		if (bh && bh->b_blocknr == block && bh_bdev(bh) == bdev &&
 		    bh->b_size == size) {
 			if (i) {
 				while (i) {
@@ -1564,7 +1564,7 @@ static void discard_buffer(struct buffer_head * bh)
 
 	lock_buffer(bh);
 	clear_buffer_dirty(bh);
-	bh->b_bdev = NULL;
+	bh_set_bdev_file(bh, NULL);
 	b_state = READ_ONCE(bh->b_state);
 	do {
 	} while (!try_cmpxchg(&bh->b_state, &b_state,
@@ -2005,7 +2005,7 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
 {
 	loff_t offset = (loff_t)block << inode->i_blkbits;
 
-	bh->b_bdev = iomap_bdev(iomap);
+	bh_set_bdev_file(bh, iomap->bdev_file);
 
 	/*
 	 * Block points to offset in file we need to map, iomap contains
@@ -2781,7 +2781,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 	if (buffer_prio(bh))
 		opf |= REQ_PRIO;
 
-	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
+	bio = bio_alloc(bh_bdev(bh), 1, opf, GFP_NOIO);
 
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 62c97ff9e852..49475f530e0f 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -673,7 +673,7 @@ static inline int dio_new_bio(struct dio *dio, struct dio_submit *sdio,
 	sector = start_sector << (sdio->blkbits - 9);
 	nr_pages = bio_max_segs(sdio->pages_in_io);
 	BUG_ON(nr_pages <= 0);
-	dio_bio_alloc(dio, sdio, map_bh->b_bdev, sector, nr_pages);
+	dio_bio_alloc(dio, sdio, bh_bdev(map_bh), sector, nr_pages);
 	sdio->boundary = 0;
 out:
 	return ret;
@@ -948,7 +948,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 					map_bh->b_blocknr << sdio->blkfactor;
 				if (buffer_new(map_bh)) {
 					clean_bdev_aliases(
-						map_bh->b_bdev,
+						bh_bdev(map_bh),
 						map_bh->b_blocknr,
 						map_bh->b_size >> i_blkbits);
 				}
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index c885dcc3bd0d..42e595e87a74 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -80,7 +80,7 @@
 	} while (0)
 # define ea_bdebug(bh, f...) do { \
 		printk(KERN_DEBUG "block %pg:%lu: ", \
-			bh->b_bdev, (unsigned long) bh->b_blocknr); \
+			bh_bdev(bh), (unsigned long) bh->b_blocknr); \
 		printk(f); \
 		printk("\n"); \
 	} while (0)
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index bd946d0c71b7..5641bd34d021 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -384,7 +384,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 
 	BUILD_BUG_ON(sizeof(mmp->mmp_bdevname) < BDEVNAME_SIZE);
 	snprintf(mmp->mmp_bdevname, sizeof(mmp->mmp_bdevname),
-		 "%pg", bh->b_bdev);
+		 "%pg", bh_bdev(bh));
 
 	/*
 	 * Start a kernel thread to update the MMP block periodically.
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 312bc6813357..1b02b6a28eca 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -93,8 +93,7 @@ struct ext4_io_end_vec *ext4_last_io_end_vec(ext4_io_end_t *io_end)
 static void buffer_io_error(struct buffer_head *bh)
 {
 	printk_ratelimited(KERN_ERR "Buffer I/O error on device %pg, logical block %llu\n",
-		       bh->b_bdev,
-			(unsigned long long)bh->b_blocknr);
+			   bh_bdev(bh), (unsigned long long)bh->b_blocknr);
 }
 
 static void ext4_finish_bio(struct bio *bio)
@@ -397,7 +396,7 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 	 * bio_alloc will _always_ be able to allocate a bio if
 	 * __GFP_DIRECT_RECLAIM is set, see comments for bio_alloc_bioset().
 	 */
-	bio = bio_alloc(bh->b_bdev, BIO_MAX_VECS, REQ_OP_WRITE, GFP_NOIO);
+	bio = bio_alloc(bh_bdev(bh), BIO_MAX_VECS, REQ_OP_WRITE, GFP_NOIO);
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_end_io = ext4_end_bio;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index b67a176bfcf9..005af215e24a 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -68,7 +68,7 @@
 	       inode->i_sb->s_id, inode->i_ino, ##__VA_ARGS__)
 # define ea_bdebug(bh, fmt, ...)					\
 	printk(KERN_DEBUG "block %pg:%lu: " fmt "\n",			\
-	       bh->b_bdev, (unsigned long)bh->b_blocknr, ##__VA_ARGS__)
+	       bh_bdev(bh), (unsigned long)bh->b_blocknr, ##__VA_ARGS__)
 #else
 # define ea_idebug(inode, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 # define ea_bdebug(bh, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 974aca9c8ea8..24b6cf9021ca 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -622,7 +622,7 @@ static void gfs2_discard(struct gfs2_sbd *sdp, struct buffer_head *bh)
 			spin_unlock(&sdp->sd_ail_lock);
 		}
 	}
-	bh->b_bdev = NULL;
+	bh_set_bdev_file(bh, NULL);
 	clear_buffer_mapped(bh);
 	clear_buffer_req(bh);
 	clear_buffer_new(bh);
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index f814054c8cd0..2052d3fc2c24 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -218,7 +218,7 @@ static void gfs2_submit_bhs(blk_opf_t opf, struct buffer_head *bhs[], int num)
 		struct buffer_head *bh = *bhs;
 		struct bio *bio;
 
-		bio = bio_alloc(bh->b_bdev, num, opf, GFP_NOIO);
+		bio = bio_alloc(bh_bdev(bh), num, opf, GFP_NOIO);
 		bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 		while (num > 0) {
 			bh = *bhs;
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 5e122586e06e..413f32b2f308 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -1014,7 +1014,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 				clear_buffer_mapped(bh);
 				clear_buffer_new(bh);
 				clear_buffer_req(bh);
-				bh->b_bdev = NULL;
+				bh_set_bdev_file(bh, NULL);
 			}
 		}
 
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index abd42a6ccd0e..c1ce32d99267 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -434,7 +434,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 
 	folio_set_bh(new_bh, new_folio, new_offset);
 	new_bh->b_size = bh_in->b_size;
-	new_bh->b_bdev = journal->j_dev;
+	bh_set_bdev_file(new_bh, journal->j_dev_file);
 	new_bh->b_blocknr = blocknr;
 	new_bh->b_private = bh_in;
 	set_buffer_mapped(new_bh);
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index cb0b8d6fc0c6..04021f54ca97 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -929,7 +929,7 @@ static void warn_dirty_buffer(struct buffer_head *bh)
 	       "JBD2: Spotted dirty metadata buffer (dev = %pg, blocknr = %llu). "
 	       "There's a risk of filesystem corruption in case of system "
 	       "crash.\n",
-	       bh->b_bdev, (unsigned long long)bh->b_blocknr);
+	       bh_bdev(bh), (unsigned long long)bh->b_blocknr);
 }
 
 /* Call t_frozen trigger and copy buffer data into jh->b_frozen_data. */
@@ -990,7 +990,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 	/* If it takes too long to lock the buffer, trace it */
 	time_lock = jbd2_time_diff(start_lock, jiffies);
 	if (time_lock > HZ/10)
-		trace_jbd2_lock_buffer_stall(bh->b_bdev->bd_dev,
+		trace_jbd2_lock_buffer_stall(bh_bdev(bh)->bd_dev,
 			jiffies_to_msecs(time_lock));
 
 	/* We now hold the buffer lock so it is safe to query the buffer
@@ -2374,7 +2374,7 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 			write_unlock(&journal->j_state_lock);
 			jbd2_journal_put_journal_head(jh);
 			/* Already zapped buffer? Nothing to do... */
-			if (!bh->b_bdev)
+			if (!bh_bdev(bh))
 				return 0;
 			return -EBUSY;
 		}
@@ -2428,7 +2428,7 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 	clear_buffer_new(bh);
 	clear_buffer_delay(bh);
 	clear_buffer_unwritten(bh);
-	bh->b_bdev = NULL;
+	bh_set_bdev_file(bh, NULL);
 	return may_free;
 }
 
diff --git a/fs/mpage.c b/fs/mpage.c
index fa8b99a199fa..40594afa63cb 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -126,7 +126,7 @@ static void map_buffer_to_folio(struct folio *folio, struct buffer_head *bh,
 	do {
 		if (block == page_block) {
 			page_bh->b_state = bh->b_state;
-			page_bh->b_bdev = bh->b_bdev;
+			bh_copy_bdev_file(page_bh, bh);
 			page_bh->b_blocknr = bh->b_blocknr;
 			break;
 		}
@@ -216,7 +216,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 			page_block++;
 			block_in_file++;
 		}
-		bdev = map_bh->b_bdev;
+		bdev = bh_bdev(map_bh);
 	}
 
 	/*
@@ -272,7 +272,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 			page_block++;
 			block_in_file++;
 		}
-		bdev = map_bh->b_bdev;
+		bdev = bh_bdev(map_bh);
 	}
 
 	if (first_hole != blocks_per_page) {
@@ -515,7 +515,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 				boundary_block = bh->b_blocknr;
 				boundary_bdev = bh->b_bdev;
 			}
-			bdev = bh->b_bdev;
+			bdev = bh_bdev(bh);
 		} while ((bh = bh->b_this_page) != head);
 
 		if (first_unmapped)
@@ -565,7 +565,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 		}
 		page_block++;
 		boundary = buffer_boundary(&map_bh);
-		bdev = map_bh.b_bdev;
+		bdev = bh_bdev(&map_bh);
 		if (block_in_file == last_block)
 			break;
 		block_in_file++;
diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 0131d83b912d..3f81d00fc031 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -59,7 +59,7 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 		BUG();
 	}
 	memset(bh->b_data, 0, i_blocksize(inode));
-	bh->b_bdev = inode->i_sb->s_bdev;
+	bh_set_bdev_file(bh, inode->i_sb->s_bdev_file);
 	bh->b_blocknr = blocknr;
 	set_buffer_mapped(bh);
 	set_buffer_uptodate(bh);
@@ -118,7 +118,7 @@ int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
 		goto found;
 	}
 	set_buffer_mapped(bh);
-	bh->b_bdev = inode->i_sb->s_bdev;
+	bh_set_bdev_file(bh, inode->i_sb->s_bdev_file);
 	bh->b_blocknr = pblocknr; /* set block address for read */
 	bh->b_end_io = end_buffer_read_sync;
 	get_bh(bh);
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index bf9a11d58817..83d2b5e034ad 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -84,7 +84,7 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
 	}
 
 	if (!buffer_mapped(bh)) {
-		bh->b_bdev = inode->i_sb->s_bdev;
+		bh_set_bdev_file(bh, inode->i_sb->s_bdev_file);
 		set_buffer_mapped(bh);
 	}
 	bh->b_blocknr = pbn;
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 4f792a0ad0f0..10f33017a1c9 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -89,7 +89,7 @@ static int nilfs_mdt_create_block(struct inode *inode, unsigned long block,
 	if (buffer_uptodate(bh))
 		goto failed_bh;
 
-	bh->b_bdev = sb->s_bdev;
+	bh_set_bdev_file(bh, sb->s_bdev_file);
 	err = nilfs_mdt_insert_new_block(inode, block, bh, init_block);
 	if (likely(!err)) {
 		get_bh(bh);
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 14e470fb8870..b6cc95dd13c0 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -111,7 +111,7 @@ void nilfs_copy_buffer(struct buffer_head *dbh, struct buffer_head *sbh)
 
 	dbh->b_state = sbh->b_state & NILFS_BUFFER_INHERENT_BITS;
 	dbh->b_blocknr = sbh->b_blocknr;
-	dbh->b_bdev = sbh->b_bdev;
+	bh_copy_bdev_file(dbh, sbh);
 
 	bh = dbh;
 	bits = sbh->b_state & (BIT(BH_Uptodate) | BIT(BH_Mapped));
@@ -216,7 +216,7 @@ static void nilfs_copy_folio(struct folio *dst, struct folio *src,
 		lock_buffer(dbh);
 		dbh->b_state = sbh->b_state & mask;
 		dbh->b_blocknr = sbh->b_blocknr;
-		dbh->b_bdev = sbh->b_bdev;
+		bh_copy_bdev_file(dbh, sbh);
 		sbh = sbh->b_this_page;
 		dbh = dbh->b_this_page;
 	} while (dbh != dbufs);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3c4c878f6d77..c795fd2000ee 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -609,7 +609,7 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 	lbo = ((u64)lcn << cluster_bits) + off;
 
 	set_buffer_mapped(bh);
-	bh->b_bdev = sb->s_bdev;
+	bh_set_bdev_file(bh, sb->s_bdev_file);
 	bh->b_blocknr = lbo >> sb->s_blocksize_bits;
 
 	valid = ni->i_valid;
diff --git a/fs/reiserfs/fix_node.c b/fs/reiserfs/fix_node.c
index 6c13a8d9a73c..2b288b1539d9 100644
--- a/fs/reiserfs/fix_node.c
+++ b/fs/reiserfs/fix_node.c
@@ -2332,7 +2332,7 @@ static void tb_buffer_sanity_check(struct super_block *sb,
 				       "in tree %s[%d] (%b)",
 				       descr, level, bh);
 
-		if (bh->b_bdev != sb->s_bdev)
+		if (bh_bdev(bh) != sb->s_bdev)
 			reiserfs_panic(sb, "jmacd-4", "buffer has wrong "
 				       "device %s[%d] (%b)",
 				       descr, level, bh);
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index e539ccd39e1e..724113cb79d3 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -618,7 +618,7 @@ static void reiserfs_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
 	if (buffer_journaled(bh)) {
 		reiserfs_warning(NULL, "clm-2084",
 				 "pinned buffer %lu:%pg sent to disk",
-				 bh->b_blocknr, bh->b_bdev);
+				 bh->b_blocknr, bh_bdev(bh));
 	}
 	if (uptodate)
 		set_buffer_uptodate(bh);
diff --git a/fs/reiserfs/prints.c b/fs/reiserfs/prints.c
index 84a194b77f19..249a458b6e28 100644
--- a/fs/reiserfs/prints.c
+++ b/fs/reiserfs/prints.c
@@ -156,7 +156,7 @@ static int scnprintf_buffer_head(char *buf, size_t size, struct buffer_head *bh)
 {
 	return scnprintf(buf, size,
 			 "dev %pg, size %zd, blocknr %llu, count %d, state 0x%lx, page %p, (%s, %s, %s)",
-			 bh->b_bdev, bh->b_size,
+			 bh_bdev(bh), bh->b_size,
 			 (unsigned long long)bh->b_blocknr,
 			 atomic_read(&(bh->b_count)),
 			 bh->b_state, bh->b_page,
@@ -561,7 +561,7 @@ static int print_super_block(struct buffer_head *bh)
 		return 1;
 	}
 
-	printk("%pg\'s super block is in block %llu\n", bh->b_bdev,
+	printk("%pg\'s super block is in block %llu\n", bh_bdev(bh),
 	       (unsigned long long)bh->b_blocknr);
 	printk("Reiserfs version %s\n", version);
 	printk("Block count %u\n", sb_block_count(rs));
diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index 5faf702f8d15..23998f071d9c 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -331,7 +331,7 @@ static inline int key_in_buffer(
 	       || chk_path->path_length > MAX_HEIGHT,
 	       "PAP-5050: pointer to the key(%p) is NULL or invalid path length(%d)",
 	       key, chk_path->path_length);
-	RFALSE(!PATH_PLAST_BUFFER(chk_path)->b_bdev,
+	RFALSE(!bh_bdev(PATH_PLAST_BUFFER(chk_path)),
 	       "PAP-5060: device must not be NODEV");
 
 	if (comp_keys(get_lkey(chk_path, sb), key) == 1)
diff --git a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
index 2cec61af2a9e..300e6737a0db 100644
--- a/fs/reiserfs/tail_conversion.c
+++ b/fs/reiserfs/tail_conversion.c
@@ -187,7 +187,7 @@ void reiserfs_unmap_buffer(struct buffer_head *bh)
 	clear_buffer_mapped(bh);
 	clear_buffer_req(bh);
 	clear_buffer_new(bh);
-	bh->b_bdev = NULL;
+	bh_set_bdev_file(bh, NULL);
 	unlock_buffer(bh);
 }
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index d78454a4dd1f..4c6f0d0332c8 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/blk_types.h>
+#include <linux/blkdev.h>
 #include <linux/fs.h>
 #include <linux/linkage.h>
 #include <linux/pagemap.h>
@@ -136,6 +137,23 @@ BUFFER_FNS(Meta, meta)
 BUFFER_FNS(Prio, prio)
 BUFFER_FNS(Defer_Completion, defer_completion)
 
+static __always_inline void bh_set_bdev_file(struct buffer_head *bh,
+					     struct file *bdev_file)
+{
+	bh->b_bdev = bdev_file ? file_bdev(bdev_file) : NULL;
+}
+
+static __always_inline void bh_copy_bdev_file(struct buffer_head *dbh,
+					      struct buffer_head *sbh)
+{
+	dbh->b_bdev = sbh->b_bdev;
+}
+
+static __always_inline struct block_device *bh_bdev(struct buffer_head *bh)
+{
+	return bh->b_bdev;
+}
+
 static __always_inline void set_buffer_uptodate(struct buffer_head *bh)
 {
 	/*
@@ -377,7 +395,7 @@ static inline void
 map_bh(struct buffer_head *bh, struct super_block *sb, sector_t block)
 {
 	set_buffer_mapped(bh);
-	bh->b_bdev = sb->s_bdev;
+	bh_set_bdev_file(bh, sb->s_bdev_file);
 	bh->b_blocknr = block;
 	bh->b_size = sb->s_blocksize;
 }
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 0e128ad51460..95d3ed978864 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -26,7 +26,7 @@ DECLARE_EVENT_CLASS(block_buffer,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= bh->b_bdev->bd_dev;
+		__entry->dev		= bh_bdev(bh)->bd_dev;
 		__entry->sector		= bh->b_blocknr;
 		__entry->size		= bh->b_size;
 	),
-- 
2.39.2


