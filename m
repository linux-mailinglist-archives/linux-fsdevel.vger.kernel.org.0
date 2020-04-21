Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F8F1B3021
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 21:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgDUTSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 15:18:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:63577 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgDUTSL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:18:11 -0400
IronPort-SDR: F3KEJIkJREHfHsaVRQSniuFF65XeHlh3l9pU+Mt6SQDbqXUC/ro8T/X3rxP82xdOWa5SBf5GXG
 B353qkVleg0w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 12:18:09 -0700
IronPort-SDR: qxrgeZ+elvO/Ko482Y5NX1hquScoymT10g5HvU48ztv2nfaJUIzlKPrnRmi538CSTvS7Zokhsd
 ljTqGyxnyffQ==
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="290576896"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 12:18:10 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V9 02/11] fs: Remove unneeded IS_DAX() check in io_is_direct()
Date:   Tue, 21 Apr 2020 12:17:44 -0700
Message-Id: <20200421191754.3372370-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200421191754.3372370-1-ira.weiny@intel.com>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v8:
	Rebase to latest Linus tree

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
index da693e6a834e..14372df0f354 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -634,8 +634,8 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 
 static inline void loop_update_dio(struct loop_device *lo)
 {
-	__loop_update_dio(lo, io_is_direct(lo->lo_backing_file) |
-			lo->use_dio);
+	__loop_update_dio(lo, (lo->lo_backing_file->f_flags & O_DIRECT) |
+				lo->use_dio);
 }
 
 static void loop_reread_partitions(struct loop_device *lo,
@@ -1028,7 +1028,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
 		blk_queue_write_cache(lo->lo_queue, true, false);
 
-	if (io_is_direct(lo->lo_backing_file) && inode->i_sb->s_bdev) {
+	if ((lo->lo_backing_file->f_flags & O_DIRECT) && inode->i_sb->s_bdev) {
 		/* In case of direct I/O, match underlying block size */
 		unsigned short bsize = bdev_logical_block_size(
 			inode->i_sb->s_bdev);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f6f59b4f22a..a87cc5845a02 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3394,11 +3394,6 @@ extern void setattr_copy(struct inode *inode, const struct iattr *attr);
 
 extern int file_update_time(struct file *file);
 
-static inline bool io_is_direct(struct file *filp)
-{
-	return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host);
-}
-
 static inline bool vma_is_dax(const struct vm_area_struct *vma)
 {
 	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
@@ -3423,7 +3418,7 @@ static inline int iocb_flags(struct file *file)
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

