Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD0BC1A6294
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 07:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgDMFlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 01:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgDMFlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 01:41:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D54C008675;
        Sun, 12 Apr 2020 22:41:19 -0700 (PDT)
IronPort-SDR: QGd3aujlu3k3FyTMLQPY4dHyS4rMp0l6SB+KUyHJJQtmYvh/xqINor5Tp6c163Mf5m/y5RGalY
 0wr9Wm7jmRhw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 22:41:19 -0700
IronPort-SDR: wBlWos2q9mmgP/qv0DjuwneNSDm6hCHcGF3JxM1lR5Yl1qi2CmEQZtNOQx0RVdBznHv8D6T4d8
 /jG+GkL4ppAg==
X-IronPort-AV: E=Sophos;i="5.72,377,1580803200"; 
   d="scan'208";a="256078717"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 22:41:17 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V7 2/9] fs: Remove unneeded IS_DAX() check in io_is_direct()
Date:   Sun, 12 Apr 2020 22:40:39 -0700
Message-Id: <20200413054046.1560106-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200413054046.1560106-1-ira.weiny@intel.com>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Remove the check because DAX now has it's own read/write methods and
file systems which support DAX check IS_DAX() prior to IOCB_DIRECT on
their own.  Therefore, it does not matter if the file state is DAX when
the iocb flags are created.

Also remove io_is_direct() as it is just a simple flag check.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v6:
	remove io_is_direct() as well.
	Remove Reviews since this is quite a bit different.

Changes from v3:
	Reword commit message.
	Reordered to be a 'pre-cleanup' patch
---
 drivers/block/loop.c | 6 +++---
 include/linux/fs.h   | 7 +------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 739b372a5112..9a9af78974ac 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -631,8 +631,8 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 
 static inline void loop_update_dio(struct loop_device *lo)
 {
-	__loop_update_dio(lo, io_is_direct(lo->lo_backing_file) |
-			lo->use_dio);
+	__loop_update_dio(lo, (lo->lo_backing_file->f_flags & O_DIRECT) |
+				lo->use_dio);
 }
 
 static void loop_reread_partitions(struct loop_device *lo,
@@ -1006,7 +1006,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
 		blk_queue_write_cache(lo->lo_queue, true, false);
 
-	if (io_is_direct(lo->lo_backing_file) && inode->i_sb->s_bdev) {
+	if ((lo->lo_backing_file->f_flags & O_DIRECT) && inode->i_sb->s_bdev) {
 		/* In case of direct I/O, match underlying block size */
 		unsigned short bsize = bdev_logical_block_size(
 			inode->i_sb->s_bdev);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index abedbffe2c9e..a818ced22961 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3387,11 +3387,6 @@ extern void setattr_copy(struct inode *inode, const struct iattr *attr);
 
 extern int file_update_time(struct file *file);
 
-static inline bool io_is_direct(struct file *filp)
-{
-	return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host);
-}
-
 static inline bool vma_is_dax(struct vm_area_struct *vma)
 {
 	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
@@ -3416,7 +3411,7 @@ static inline int iocb_flags(struct file *file)
 	int res = 0;
 	if (file->f_flags & O_APPEND)
 		res |= IOCB_APPEND;
-	if (io_is_direct(file))
+	if (file->f_flags & O_DIRECT)
 		res |= IOCB_DIRECT;
 	if ((file->f_flags & O_DSYNC) || IS_SYNC(file->f_mapping->host))
 		res |= IOCB_DSYNC;
-- 
2.25.1

