Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2771E1CEFBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 10:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgELI4Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 04:56:24 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16037 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729135AbgELI4W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 04:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589273783; x=1620809783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=we2PS0L+kq3Y5Q7oruSHo5wZ/NQT+esEYAv00kJsoiI=;
  b=WsWYco5Lnz84Fvc35Eg3oiRbwo9XxkPfW6R9/3VzvaGe9KYzXGQ49Kf7
   FFDtWhBJZcmOpKwr0jX4GnZqX2vk445ypyOelJRUNI9Uw0L9zGkFudIRi
   eZGvKw1sU2bCQXa78SBFUyqaa8Yghc4peK8IpYr2kK/3YdJYdfhPcahOq
   dZ7iUcCILeTMweoZkYpF6PdiaY9NzQMzPTxActHQNK31T9GGt6hUk3bDT
   OIkzjAqJEyCNxpJn9nqITif/sdtpfOTB/Riw3wE+J7c2RQKIXzt4IounE
   4J/nSs4Y2mWqMFEmgI+ENpixHyr4uCLLtgt+l+xjQIF5+gQgqmWHkaQIk
   A==;
IronPort-SDR: b8yHKoY1xrnUrhcXWBnoQeLVVQ84NU3Y/m6U0mV1WhxnKKgrk7eK4I+xoy8ZzAxWHptf1p75Jp
 JUCIlNJhtF8tFEXqvrBnJYf5XjsJY1dNLTrlz4AtjO9yN6DZMW6Xld5C/ptVEkXm6KiWbJ3MMt
 MJs1CIuLX44gjK5HvOFgQ/z73Fc+RuKYI/QXGxSMF1XoPSGnU7c1/qfLBaS70JZRNI6TitAyAd
 +q9IrpI7M8gHLLj4D89IT8IHjVAEi6NaLddm9itBFby5i6TmFzDo77zr0ZLhBDBMfN903E1CkB
 I1U=
X-IronPort-AV: E=Sophos;i="5.73,383,1583164800"; 
   d="scan'208";a="141823574"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2020 16:56:23 +0800
IronPort-SDR: 493YmtxBDQhLwlH9yUs2wYEuVQobPIBqcNfMBQCLDyuv/XnNn2jN52hyvnScaKbonRNosKwvea
 yo+VG7DZNy9lTbWpJ4/XGl81wldpMwRRo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 01:46:04 -0700
IronPort-SDR: lA+ig10vldVJTg4SSXDemIszuei6fSTAC6GZnbEI1D4qvvO0ow2M7yKB7goDKMQfr8Yvh4k+Hu
 zfHQOKAUV2Gg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 May 2020 01:56:20 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v11 10/10] zonefs: use REQ_OP_ZONE_APPEND for sync DIO
Date:   Tue, 12 May 2020 17:55:54 +0900
Message-Id: <20200512085554.26366-11-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
References: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
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
Acked-by: Damien Le Moal <damien.lemoal@wdc.com>
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

