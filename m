Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE9FB0D7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 13:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbfILLEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 07:04:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38396 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbfILLEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:04:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id d10so13307303pgo.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2019 04:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JDVJTjVHxvtFP6O5OW3JkLmKyrlbWzg8T/h3zoqT2aU=;
        b=RWXVwFooObJI3Iivcf9TUL0F/45/meSuvGKZUUMkLdjfwBqZXWTJP6j5R3X2cEvZYM
         lROtGGmKCQrLQ1Ivn9LkXj8HdBifZLUE9LHCevJ2PicguQp9qgaK0SveSsKS9EePHn9+
         FOIeQ1SFJXfajv2HFmqNPWZH0AutGL9DzwwP0+y6vSPUqNKvRSDR7J2x0YF5RUk2sgI2
         BfVfSRKiP33o8JnXY3s0nRuVqk4GnPfmBXGf+iUfUX4MxINmbYQDp2Lk2AzK928T5SoA
         VAhMHtiiOfPDhrYvLYM9soPT2SnFu7tY+FTCOA3DZeeiAiInLYgOwliWMcBDJGy6m4Gu
         wvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JDVJTjVHxvtFP6O5OW3JkLmKyrlbWzg8T/h3zoqT2aU=;
        b=KeJ/WKoWALh+Yp37ZdDwtHF0S8Hktri0RimF9J/Lbfo+sw1d30Ci6kBZa2W0l4i3LC
         ZZBAdk1dPDwaIeGtK91axq7x9nEx7rB8xcWOGe3Q0TpVjCUxJZpehrTR7dc/liv0QCJ2
         74o8OYEUjE/WabhpRx+NDnjChJ42ZmzfbCbh2la5ZtEC151aODIXo8m9I3l0rBU3d1BU
         6veSuPcmo3Bho6wemSiXWuneCm9L53nGd5zNzj01uy0xagwZMC/TfTWBMROBrzIYNyaD
         rsl+BiqvtwC/VLNH3w6jiK00ha7u25AW00eWx9fIfKyXWRLT7+Sue69vgOQq/qExO8DO
         kUOQ==
X-Gm-Message-State: APjAAAXcALZ09HmgNW+PZVDBcemk4R+fY1ryBaMs/8DpbUzXlzTjn3bE
        0XWxyp05p0rTvy4cfhaNg/xc
X-Google-Smtp-Source: APXvYqwnv6Q7ldrJTF8XV4H2uNV18JziTrlQcu6vrClMrC11o2Hpt1dACpR/CXx2iZj2xSpKnBQDGA==
X-Received: by 2002:a63:66c5:: with SMTP id a188mr37327516pgc.127.1568286247035;
        Thu, 12 Sep 2019 04:04:07 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id z19sm20128152pgv.35.2019.09.12.04.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 04:04:06 -0700 (PDT)
Date:   Thu, 12 Sep 2019 21:04:00 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: [PATCH v3 2/6] ext4: move inode extension/truncate code out from
 ext4_iomap_end()
Message-ID: <784214745d589dd2bdcde2d69a69e837e6980592.1568282664.git.mbobrowski@mbobrowski.org>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568282664.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing the iomap direct IO write path
modifications, the inode extension/truncate code needs to be moved out
from ext4_iomap_end(). For direct IO, if the current code remained
within ext4_iomap_end() it would behave incorrectly. If we update the
inode size prior to converting unwritten extents we run the risk of
allowing a racing direct IO read operation to find unwritten extents
before they are converted.

The inode extension/truncate code has been moved out into a new helper
ext4_handle_inode_extension(). This helper has been designed so that
it can be used by both DAX and direct IO paths in the instance that
the result of the write is extending the inode.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/file.c  | 92 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/inode.c | 48 +-------------------------
 2 files changed, 92 insertions(+), 48 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index e52e3928dc25..6457c629b8cf 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -33,6 +33,7 @@
 #include "ext4_jbd2.h"
 #include "xattr.h"
 #include "acl.h"
+#include "truncate.h"
 
 static bool ext4_dio_checks(struct inode *inode)
 {
@@ -233,12 +234,90 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	return iov_iter_count(from);
 }
 
+static int ext4_handle_inode_extension(struct inode *inode, loff_t offset,
+				       ssize_t len, size_t count)
+{
+	handle_t *handle;
+	bool truncate = false;
+	ext4_lblk_t written_blk, end_blk;
+	int ret = 0, blkbits = inode->i_blkbits;
+
+	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		goto orphan_del;
+	}
+
+	if (ext4_update_inode_size(inode, offset + len))
+		ext4_mark_inode_dirty(handle, inode);
+
+	/*
+	 * We may need truncate allocated but not written blocks
+	 * beyond EOF.
+	 */
+	written_blk = ALIGN(offset + len, 1 << blkbits);
+	end_blk = ALIGN(offset + count, 1 << blkbits);
+	if (written_blk < end_blk && ext4_can_truncate(inode))
+		truncate = true;
+
+	/*
+	 * Remove the inode from the orphan list if it has been
+	 * extended and everything went OK.
+	 */
+	if (!truncate && inode->i_nlink)
+		ext4_orphan_del(handle, inode);
+	ext4_journal_stop(handle);
+
+	if (truncate) {
+		ext4_truncate_failed_write(inode);
+orphan_del:
+		/*
+		 * If the truncate operation failed early the inode
+		 * may still be on the orphan list. In that case, we
+		 * need try remove the inode from the linked list in
+		 * memory.
+		 */
+		if (inode->i_nlink)
+			ext4_orphan_del(NULL, inode);
+	}
+	return ret;
+}
+
+/*
+ * The inode may have been placed onto the orphan list or has had
+ * blocks allocated beyond EOF as a result of an extension. We need to
+ * ensure that any necessary cleanup routines are performed if the
+ * error path has been taken for a write.
+ */
+static int ext4_handle_failed_inode_extension(struct inode *inode, loff_t size)
+{
+	handle_t *handle;
+
+	if (size > i_size_read(inode))
+		ext4_truncate_failed_write(inode);
+
+	if (!list_empty(&EXT4_I(inode)->i_orphan)) {
+		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+		if (IS_ERR(handle)) {
+			if (inode->i_nlink)
+				ext4_orphan_del(NULL, inode);
+			return PTR_ERR(handle);
+		}
+		if (inode->i_nlink)
+			ext4_orphan_del(handle, inode);
+		ext4_journal_stop(handle);
+	}
+	return 0;
+}
+
 #ifdef CONFIG_FS_DAX
 static ssize_t
 ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
+	int error = 0;
+	loff_t offset;
+	struct inode *inode = file_inode(iocb->ki_filp);
 
 	if (!inode_trylock(inode)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
@@ -255,7 +334,18 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ret)
 		goto out;
 
+	offset = iocb->ki_pos;
 	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
+	if (ret > 0 && iocb->ki_pos > i_size_read(inode))
+		error = ext4_handle_inode_extension(inode, offset, ret,
+						    iov_iter_count(from));
+
+	if (ret < 0)
+		error = ext4_handle_failed_inode_extension(inode,
+							   iocb->ki_pos);
+
+	if (error)
+		ret = error;
 out:
 	inode_unlock(inode);
 	if (ret > 0)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 420fe3deed39..761ce6286b05 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3601,53 +3601,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 			  ssize_t written, unsigned flags, struct iomap *iomap)
 {
-	int ret = 0;
-	handle_t *handle;
-	int blkbits = inode->i_blkbits;
-	bool truncate = false;
-
-	if (!(flags & IOMAP_WRITE) || (flags & IOMAP_FAULT))
-		return 0;
-
-	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
-	if (IS_ERR(handle)) {
-		ret = PTR_ERR(handle);
-		goto orphan_del;
-	}
-	if (ext4_update_inode_size(inode, offset + written))
-		ext4_mark_inode_dirty(handle, inode);
-	/*
-	 * We may need to truncate allocated but not written blocks beyond EOF.
-	 */
-	if (iomap->offset + iomap->length > 
-	    ALIGN(inode->i_size, 1 << blkbits)) {
-		ext4_lblk_t written_blk, end_blk;
-
-		written_blk = (offset + written) >> blkbits;
-		end_blk = (offset + length) >> blkbits;
-		if (written_blk < end_blk && ext4_can_truncate(inode))
-			truncate = true;
-	}
-	/*
-	 * Remove inode from orphan list if we were extending a inode and
-	 * everything went fine.
-	 */
-	if (!truncate && inode->i_nlink &&
-	    !list_empty(&EXT4_I(inode)->i_orphan))
-		ext4_orphan_del(handle, inode);
-	ext4_journal_stop(handle);
-	if (truncate) {
-		ext4_truncate_failed_write(inode);
-orphan_del:
-		/*
-		 * If truncate failed early the inode might still be on the
-		 * orphan list; we need to make sure the inode is removed from
-		 * the orphan list in that case.
-		 */
-		if (inode->i_nlink)
-			ext4_orphan_del(NULL, inode);
-	}
-	return ret;
+	return 0;
 }
 
 const struct iomap_ops ext4_iomap_ops = {
-- 
2.20.1

