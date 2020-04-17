Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1404F1ADD30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 14:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgDQMQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 08:16:09 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50670 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgDQMQH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587125769; x=1618661769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DntH3FOL+F2qJ4JB8bNfeHvJeRnIrbJq4X8RpN63JaA=;
  b=bdxz2ycmWoAx2/yAQk2lY32iplyNpr4lbGhqbzUVILVySz0WdPUrvlFF
   DvFtb6UMWwWjHJjjIIvKhXfh7eKds6oN7foWVmq3v6mEC1G2/DSHfQQE0
   7AWrQMeVKFrKvY7DHKw4jbkiXGq852RHwfww4Pz1aRAM1ynnhA3CVFVyU
   3ej34UdC8ZO/L/gl/KCZpp6RoQdb4nat53Q67978RJKRg1KrWXBFbRmBg
   tduFo3Au2Whcgf4sRIIQZU0TErYPzg3T/7eH6oguoEqr4m5OA9cQ0129p
   JMczvFJTMn+QO9p3TgrytlUlNtRXSJ08OcrzqLUZ/7RtlxQt9JTrXIMz/
   A==;
IronPort-SDR: ygJbTuMf9h6W7UKWtj/TFkTNNF9hqxjl3gr5jPYCBif284SJXM553o12Cl5+C4Xgq+IE3zSKD+
 VXzE9taDzRirhh7d/ArkByrHRiXK5CPNHrHuRtGF+vusClOfq9a8bZeiFrs1LjUMMJM0Tdnaf7
 HZ131LRHZDQftpdnvQgEHIOG3EYZaN1JTwme3RyUC0VL9FOmiU5bnQ4fcbxEQVQ1YVuRlMRFBq
 PqA8HXXW1roXozydmDfLJtYczL4m4EgI5mzqmETUngLMN4QtJOxi5EdDwgFenyPlADK66ABmNh
 dwc=
X-IronPort-AV: E=Sophos;i="5.72,394,1580745600"; 
   d="scan'208";a="237989235"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2020 20:16:08 +0800
IronPort-SDR: kkeLWFAAxNb9FfEAE7nPvW9d3Vh1t/xY3EX0k139hidFR6dbsJwQ8smgzK90q+yq1raegqCTEV
 8fc5Kfq+PQ0U7ae2alUo99iDFHxU1ZaP4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 05:07:05 -0700
IronPort-SDR: FTnxkZXjU4DFTvIsctm6WMqZ1KWfVRnVbcxfd6QFruAxT7pPPhVUihHPUT02ZXpKbSO36ZBLC1
 dKhi/uJiaUwQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Apr 2020 05:16:05 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v7 11/11] zonefs: use REQ_OP_ZONE_APPEND for sync DIO
Date:   Fri, 17 Apr 2020 21:15:36 +0900
Message-Id: <20200417121536.5393-12-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Synchronous direct I/O to a sequential write only zone can be issued using
the new REQ_OP_ZONE_APPEND request operation. As dispatching multiple
BIOs can potentially result in reordering, we cannot support asynchronous
IO via this interface.

We also can only dispatch up to queue_max_zone_append_sectors() via the
new zone-append method and have to return a short write back to user-space
in case an IO larger than queue_max_zone_append_sectors() has been issued.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 80 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 3ce9829a6936..0bf7009f50a2 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -20,6 +20,7 @@
 #include <linux/mman.h>
 #include <linux/sched/mm.h>
 #include <linux/crc32.h>
+#include <linux/task_io_accounting_ops.h>
 
 #include "zonefs.h"
 
@@ -596,6 +597,61 @@ static const struct iomap_dio_ops zonefs_write_dio_ops = {
 	.end_io			= zonefs_file_write_dio_end_io,
 };
 
+static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+	struct block_device *bdev = inode->i_sb->s_bdev;
+	unsigned int max;
+	struct bio *bio;
+	ssize_t size;
+	int nr_pages;
+	ssize_t ret;
+
+	nr_pages = iov_iter_npages(from, BIO_MAX_PAGES);
+	if (!nr_pages)
+		return 0;
+
+	max = queue_max_zone_append_sectors(bdev_get_queue(bdev));
+	max = ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
+	iov_iter_truncate(from, max);
+
+	bio = bio_alloc_bioset(GFP_NOFS, nr_pages, &fs_bio_set);
+	if (!bio)
+		return -ENOMEM;
+
+	bio_set_dev(bio, bdev);
+	bio->bi_iter.bi_sector = zi->i_zsector;
+	bio->bi_write_hint = iocb->ki_hint;
+	bio->bi_ioprio = iocb->ki_ioprio;
+	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
+	if (iocb->ki_flags & IOCB_DSYNC)
+		bio->bi_opf |= REQ_FUA;
+
+	ret = bio_iov_iter_get_pages(bio, from);
+	if (unlikely(ret)) {
+		bio_io_error(bio);
+		return ret;
+	}
+	size = bio->bi_iter.bi_size;
+	task_io_account_write(ret);
+
+	if (iocb->ki_flags & IOCB_HIPRI)
+		bio_set_polled(bio, iocb);
+
+	ret = submit_bio_wait(bio);
+
+	bio_put(bio);
+
+	zonefs_file_write_dio_end_io(iocb, size, ret, 0);
+	if (ret >= 0) {
+		iocb->ki_pos += size;
+		return size;
+	}
+
+	return ret;
+}
+
 /*
  * Handle direct writes. For sequential zone files, this is the only possible
  * write path. For these files, check that the user is issuing writes
@@ -611,6 +667,8 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct super_block *sb = inode->i_sb;
+	bool sync = is_sync_kiocb(iocb);
+	bool append = false;
 	size_t count;
 	ssize_t ret;
 
@@ -619,7 +677,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	 * as this can cause write reordering (e.g. the first aio gets EAGAIN
 	 * on the inode lock but the second goes through but is now unaligned).
 	 */
-	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ && !is_sync_kiocb(iocb) &&
+	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ && !sync &&
 	    (iocb->ki_flags & IOCB_NOWAIT))
 		return -EOPNOTSUPP;
 
@@ -643,16 +701,22 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	/* Enforce sequential writes (append only) in sequential zones */
-	mutex_lock(&zi->i_truncate_mutex);
-	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ && iocb->ki_pos != zi->i_wpoffset) {
+	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ) {
+		mutex_lock(&zi->i_truncate_mutex);
+		if (iocb->ki_pos != zi->i_wpoffset) {
+			mutex_unlock(&zi->i_truncate_mutex);
+			ret = -EINVAL;
+			goto inode_unlock;
+		}
 		mutex_unlock(&zi->i_truncate_mutex);
-		ret = -EINVAL;
-		goto inode_unlock;
+		append = sync;
 	}
-	mutex_unlock(&zi->i_truncate_mutex);
 
-	ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
-			   &zonefs_write_dio_ops, is_sync_kiocb(iocb));
+	if (append)
+		ret = zonefs_file_dio_append(iocb, from);
+	else
+		ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
+				   &zonefs_write_dio_ops, sync);
 	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
 	    (ret > 0 || ret == -EIOCBQUEUED)) {
 		if (ret > 0)
-- 
2.24.1

