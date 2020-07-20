Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105402260AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 15:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgGTNV2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 09:21:28 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30727 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgGTNV0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595251287; x=1626787287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CipjjmpkSlBvPonJQDojYQBwzAmEiK1Iwsc66BIXqmA=;
  b=TwaNRj5eCznm9vKgkfKN669p+UHOa3z2wtqcAw0WorpaZYg6Exv+DbLt
   HhV7j/lNZUzpQCUyythwD5kZkp46LL70ZEmP7xNGlOcZKOkyhmm03VJpu
   4rphqXjOEEMZcgeJY+NbF3JH878BCAbDwispFR35Po52570GPuTzV737N
   Cd2AB8AAKBlyBFDYCdVD+4VzzbEQBkWF3Y8f7SlbxwmokJT3lvN9gOXK1
   Oanemgt58TWPWzVZBD++DZd71Jn6fCJHnAr1QadZ20EOn2KXyMIzqJ8Ut
   uPTbmp8+U4xM4vZYyvq7lE3n5XJqRxtHOhQEikLwbo82YFTkHz7Z0GF9n
   A==;
IronPort-SDR: vuK+9ci2eI47JRiDrPAoMbpDo5Vh/vIdJhELAmL7VHcgWiqKKewCjPfhbAvGkVcfwUu9LR8QdY
 F8ZjMCk9nIXfu2nM8ioyhhqnQiwcsjo4SnxNU/cqH1ncNQKbGcfIXmAHh2XALDVYsYKPlPAR8L
 WRkb9RuHrJtxXRQ1ADSmpoB+R+Uf0LfJzkf89QILNJrZmeUkBUgN8kNuqtVHqHfrFZOXclXCTA
 SmTALpGJF53oX6w+M3vX0oLwtTTJm/jwPRIvOESCQjtOF/mBhM2m2PgyF29pz1IPrCEV8Mzd/j
 FoY=
X-IronPort-AV: E=Sophos;i="5.75,375,1589212800"; 
   d="scan'208";a="143013754"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 21:21:26 +0800
IronPort-SDR: RiGmFeqeko3xrYHAxtFItAdKZKt/EZZ2a/46VMylQ7pWQ1gSc7if2Ugvzrv3q4i31seTGLqiOR
 iCaeV85OEE/CgR6DsEtJcUgXdZE0idXt8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 06:09:44 -0700
IronPort-SDR: u0dMrs2+U6AzfmZ1VM8LEYGz0klBxvsnaw6bwSfwKSHlCbUH6Z135BirRNglC6P1lV4a+1YXwf
 GFB3aqXw6ljw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Jul 2020 06:21:25 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/2] zonefs: use zone-append for AIO as well
Date:   Mon, 20 Jul 2020 22:21:18 +0900
Message-Id: <20200720132118.10934-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720132118.10934-1-johannes.thumshirn@wdc.com>
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we get an async I/O iocb with an O_APPEND or RWF_APPEND flag set,
submit it using REQ_OP_ZONE_APPEND to the block layer.

As an REQ_OP_ZONE_APPEND bio must not be split, this does come with an
additional constraint, namely the buffer submitted to zonefs must not be
bigger than the max zone append size of the underlying device. For
synchronous I/O we don't care about this constraint as we can return short
writes, for AIO we need to return an error on too big buffers.

On a successful completion, the position the data is written to is
returned via AIO's res2 field to the calling application.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c  | 143 +++++++++++++++++++++++++++++++++++++++------
 fs/zonefs/zonefs.h |   3 +
 2 files changed, 128 insertions(+), 18 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 5832e9f69268..f155a658675b 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -24,6 +24,8 @@
 
 #include "zonefs.h"
 
+static struct bio_set zonefs_dio_bio_set;
+
 static inline int zonefs_zone_mgmt(struct zonefs_inode_info *zi,
 				   enum req_opf op)
 {
@@ -700,16 +702,71 @@ static const struct iomap_dio_ops zonefs_write_dio_ops = {
 	.end_io			= zonefs_file_write_dio_end_io,
 };
 
+struct zonefs_dio {
+	struct kiocb		*iocb;
+	struct task_struct	*waiter;
+	int			error;
+	struct work_struct	work;
+	size_t			size;
+	u64			sector;
+	struct completion	completion;
+	struct bio		bio;
+};
+
+static void zonefs_dio_complete_work(struct work_struct *work)
+{
+	struct zonefs_dio *dio = container_of(work, struct zonefs_dio, work);
+	struct kiocb *iocb = dio->iocb;
+	size_t size = dio->size;
+	int ret;
+
+	ret = zonefs_file_write_dio_end_io(iocb, size, dio->error, 0);
+	if (ret == 0)
+		iocb->ki_pos += size;
+
+	iocb->ki_complete(iocb, ret, dio->sector);
+
+	bio_put(&dio->bio);
+}
+
+static void zonefs_file_dio_append_end_io(struct bio *bio)
+{
+	struct zonefs_dio *dio = container_of(bio, struct zonefs_dio, bio);
+	struct kiocb *iocb = dio->iocb;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (bio->bi_status)
+		dio->error = blk_status_to_errno(bio->bi_status);
+	else
+		dio->sector = bio->bi_iter.bi_sector << SECTOR_SHIFT;
+
+	if (is_sync_kiocb(iocb)) {
+		struct task_struct *waiter = dio->waiter;
+
+		blk_wake_io_task(waiter);
+		WRITE_ONCE(dio->waiter, NULL);
+	} else {
+		INIT_WORK(&dio->work, zonefs_dio_complete_work);
+		queue_work(ZONEFS_SB(inode->i_sb)->s_dio_done_wq, &dio->work);
+	}
+
+	bio_release_pages(bio, false);
+	bio_put(bio);
+}
+
 static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct block_device *bdev = inode->i_sb->s_bdev;
+	struct zonefs_dio *dio;
 	unsigned int max;
 	struct bio *bio;
-	ssize_t size;
 	int nr_pages;
 	ssize_t ret;
+	bool sync = is_sync_kiocb(iocb);
+	bool polled;
+	blk_qc_t qc;
 
 	max = queue_max_zone_append_sectors(bdev_get_queue(bdev));
 	max = ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
@@ -720,15 +777,24 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 		return 0;
 
 
-	bio = bio_alloc_bioset(GFP_NOFS, nr_pages, &fs_bio_set);
+	bio = bio_alloc_bioset(GFP_NOFS, nr_pages, &zonefs_dio_bio_set);
 	if (!bio)
 		return -ENOMEM;
 
+	dio = container_of(bio, struct zonefs_dio, bio);
+	dio->iocb = iocb;
+	dio->error = 0;
+	if (sync) {
+		dio->waiter = current;
+		init_completion(&dio->completion);
+	}
+
 	bio_set_dev(bio, bdev);
 	bio->bi_iter.bi_sector = zi->i_zsector;
 	bio->bi_write_hint = iocb->ki_hint;
 	bio->bi_ioprio = iocb->ki_ioprio;
 	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
+	bio->bi_end_io = zonefs_file_dio_append_end_io;
 	if (iocb->ki_flags & IOCB_DSYNC)
 		bio->bi_opf |= REQ_FUA;
 
@@ -737,21 +803,41 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 		bio_io_error(bio);
 		return ret;
 	}
-	size = bio->bi_iter.bi_size;
+	dio->size = bio->bi_iter.bi_size;
 	task_io_account_write(ret);
 
-	if (iocb->ki_flags & IOCB_HIPRI)
+	if (iocb->ki_flags & IOCB_HIPRI) {
 		bio_set_polled(bio, iocb);
+		polled = true;
+	}
 
-	ret = submit_bio_wait(bio);
+	bio_get(bio);
+	qc = submit_bio(bio);
 
-	bio_put(bio);
+	if (polled)
+		WRITE_ONCE(iocb->ki_cookie, qc);
 
-	zonefs_file_write_dio_end_io(iocb, size, ret, 0);
-	if (ret >= 0) {
-		iocb->ki_pos += size;
-		return size;
+	if (!sync)
+		return -EIOCBQUEUED;
+
+	for (;;) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (!READ_ONCE(dio->waiter))
+			break;
+
+		if (!(iocb->ki_flags & IOCB_HIPRI) ||
+		    !blk_poll(bdev_get_queue(bdev), qc, true))
+			blk_io_schedule();
 	}
+	__set_current_state(TASK_RUNNING);
+
+	ret = zonefs_file_write_dio_end_io(iocb, dio->size,
+					   dio->error, 0);
+	if (ret == 0) {
+		ret = dio->size;
+		iocb->ki_pos += dio->size;
+	}
+	bio_put(bio);
 
 	return ret;
 }
@@ -813,7 +899,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 			goto inode_unlock;
 		}
 		mutex_unlock(&zi->i_truncate_mutex);
-		append = sync;
+		append = sync || iocb->ki_flags & IOCB_APPEND;
 	}
 
 	if (append)
@@ -821,8 +907,8 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	else
 		ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
 				   &zonefs_write_dio_ops, sync);
-	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
-	    (ret > 0 || ret == -EIOCBQUEUED)) {
+
+	if (ret > 0 || ret == -EIOCBQUEUED) {
 		if (ret > 0)
 			count = ret;
 		mutex_lock(&zi->i_truncate_mutex);
@@ -1580,6 +1666,11 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 	if (!sb->s_root)
 		goto cleanup;
 
+	sbi->s_dio_done_wq = alloc_workqueue("zonefs-dio/%s", WQ_MEM_RECLAIM,
+					     0, sb->s_id);
+	if (!sbi->s_dio_done_wq)
+		goto cleanup;
+
 	/* Create and populate files in zone groups directories */
 	for (t = 0; t < ZONEFS_ZTYPE_MAX; t++) {
 		ret = zonefs_create_zgroup(&zd, t);
@@ -1603,8 +1694,14 @@ static void zonefs_kill_super(struct super_block *sb)
 {
 	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 
-	if (sb->s_root)
+	if (sb->s_root) {
 		d_genocide(sb->s_root);
+
+		if (sbi->s_dio_done_wq) {
+			destroy_workqueue(sbi->s_dio_done_wq);
+			sbi->s_dio_done_wq = NULL;
+		}
+	}
 	kill_block_super(sb);
 	kfree(sbi);
 }
@@ -1651,17 +1748,27 @@ static int __init zonefs_init(void)
 	if (ret)
 		return ret;
 
+	ret = bioset_init(&zonefs_dio_bio_set, 4,
+			  offsetof(struct zonefs_dio, bio), BIOSET_NEED_BVECS);
+	if (ret)
+		goto destroy_inodecache;
+
 	ret = register_filesystem(&zonefs_type);
-	if (ret) {
-		zonefs_destroy_inodecache();
-		return ret;
-	}
+	if (ret)
+		goto exit_bioset;
 
 	return 0;
+
+exit_bioset:
+	bioset_exit(&zonefs_dio_bio_set);
+destroy_inodecache:
+	zonefs_destroy_inodecache();
+	return ret;
 }
 
 static void __exit zonefs_exit(void)
 {
+	bioset_exit(&zonefs_dio_bio_set);
 	zonefs_destroy_inodecache();
 	unregister_filesystem(&zonefs_type);
 }
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 51141907097c..fe91df5eeffe 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -185,6 +185,9 @@ struct zonefs_sb_info {
 
 	unsigned int		s_max_open_zones;
 	atomic_t		s_open_zones;
+
+	/* AIO completions deferred from interrupt context */
+	struct workqueue_struct *s_dio_done_wq;
 };
 
 static inline struct zonefs_sb_info *ZONEFS_SB(struct super_block *sb)
-- 
2.26.2

