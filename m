Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748E41BA26F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 13:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgD0Lc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 07:32:29 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54669 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgD0LcY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587987143; x=1619523143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DntH3FOL+F2qJ4JB8bNfeHvJeRnIrbJq4X8RpN63JaA=;
  b=Yoto8M4qPNQgCbc+IqvOuBBrApwrt9o5HrPeeQNbM9ocRphq4EUShvk0
   sunyl59ILAH+BQjcDR7tJ1g6U47/FSbscIJA0AoS6KQDYwZJS8zY6siuZ
   Vf0EqaDC3+YZN4xHweSHTRuNBtPkGaUwNqZuCjRgz20p6sQ+Cq1WJyCLE
   +YcThcMunDh5O+FJilnTZ/2yhEnUTdE16HiJjqKNKjcl2g//6UkDGptC+
   W5/ebHo9RJe4Oyr6nOVyLGAEcAFGWVjkX9Xs6lKH/2daU5QxIafHc9EXc
   2veIft4OBjujNRo7erYiv4WAQ8Nm4V34qOMvI+kxJoYKw5k9eeO4hPaY4
   w==;
IronPort-SDR: CFeN4TVPYrqNSFkUqkopv6CB17lSjO897oeRB/bYgvkhs995oKbs9QLDV5jH53Eh76gLBza2oV
 gfXk/ABsei+iWR6k9MLhiwcw1tgd2nqU/iS+ew78zAGI3+NMT9ng0uVqxljQi0Iv3nHjuBaC4D
 xdeJA9H6ndmEgWZl+DfiE8wRFiLyrwGPLvVIEHfRXC1dU0CbjK/VYNqK7f5+7qcmmUVahFYF7+
 bRD3oFZty3pK0nAr/cgFLb9g1rZQLl7WcMzyZBvknhaeBvUCueDPyLmm2AiFphTl06OSukRWjc
 Gkc=
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; 
   d="scan'208";a="136552043"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 19:32:23 +0800
IronPort-SDR: WjSYjOL0HF4khqQ4VD4pHL+Q/9JBXmyLlfak+EEJp4t70xFVPTH1KlbBZEA2RczcYAQ5qNXw64
 O/bTHzHqTCQPjL+IvAcM+LKe9bljAUCoY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 04:23:04 -0700
IronPort-SDR: qnZ+m6BGrkVN8e7G19Rgpc/vKbQ8ZrA7EKoUryCFxRF9iJCbP2xV6twI1jJx7wU27A0KcICSKB
 jQqlzKwmF1/g==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Apr 2020 04:32:22 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v8 11/11] zonefs: use REQ_OP_ZONE_APPEND for sync DIO
Date:   Mon, 27 Apr 2020 20:31:53 +0900
Message-Id: <20200427113153.31246-12-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
References: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
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

