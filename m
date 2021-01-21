Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164902FE0C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 05:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbhAUEds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 23:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbhAUEcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:32:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61BFC061757
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 20:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y+YZjugSxtOMhD7w+UVgF8LVSiiUqDAF+4/fFl2qLlg=; b=Ek0VmSQeXYll6EFJpx73fuMuc3
        CGl4yGv1l+LVYzVM7jYUjcpdQY1Myr3skSJcUEWK1S+FGFJF8+Ap3QOVqArXgRtexIH5mu+vH1GvA
        uI6BEP5/DNrvPhjW567Q5aR0CcDURZMIoCyBON+Co6hxUon9eAPkBI01McdHsY5yTNHjRuJS41723
        jYXKlh9zPEPlK5m/nd6rI2w/BZGhQkcqG1/hey86PxQdxjEG16TPDX4MGqPAZ3a71r39tSeYNnH5B
        6+k+CJW4NTGokUoY0Ix46xru1cDeqJHSA+hhGGSbLAdB6nD55hqLzN3b3IeU33aPGvTuIR1GF8wVx
        V3e2cklw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2RbV-00GboC-SX; Thu, 21 Jan 2021 04:30:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@lst.de>, kent.overstreet@gmail.com,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 17/18] mm/filemap: Rename generic_file_buffered_read to filemap_read
Date:   Thu, 21 Jan 2021 04:16:15 +0000
Message-Id: <20210121041616.3955703-18-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121041616.3955703-1-willy@infradead.org>
References: <20210121041616.3955703-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Rename generic_file_buffered_read to match the naming of filemap_fault,
also update the written parameter to a more descriptive name and
improve the kerneldoc comment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 fs/btrfs/file.c    |  2 +-
 include/linux/fs.h |  4 ++--
 mm/filemap.c       | 35 ++++++++++++++++-------------------
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 87355a38a6547..1a4913e1fd128 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3633,7 +3633,7 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			return ret;
 	}
 
-	return generic_file_buffered_read(iocb, to, ret);
+	return filemap_read(iocb, to, ret);
 }
 
 const struct file_operations btrfs_file_operations = {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8d559d43f2af9..a79f65607236a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2948,8 +2948,8 @@ extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
 extern int generic_write_check_limits(struct file *file, loff_t pos,
 		loff_t *count);
 extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
-extern ssize_t generic_file_buffered_read(struct kiocb *iocb,
-		struct iov_iter *to, ssize_t already_read);
+ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *to,
+		ssize_t already_read);
 extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
diff --git a/mm/filemap.c b/mm/filemap.c
index 5563bfe5e544b..50d87aff0ef86 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2383,23 +2383,20 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 }
 
 /**
- * generic_file_buffered_read - generic file read routine
- * @iocb:	the iocb to read
- * @iter:	data destination
- * @written:	already copied
+ * filemap_read - Read data from the page cache.
+ * @iocb: The iocb to read.
+ * @iter: Destination for the data.
+ * @already_read: Number of bytes already read by the caller.
  *
- * This is a generic file read routine, and uses the
- * mapping->a_ops->readpage() function for the actual low-level stuff.
+ * Copies data from the page cache.  If the data is not currently present,
+ * uses the readahead and readpage address_space operations to fetch it.
  *
- * This is really ugly. But the goto's actually try to clarify some
- * of the logic when it comes to error handling etc.
- *
- * Return:
- * * total number of bytes copied, including those the were already @written
- * * negative error code if nothing was copied
+ * Return: Total number of bytes copied, including those already read by
+ * the caller.  If an error happens before any bytes are copied, returns
+ * a negative error number.
  */
-ssize_t generic_file_buffered_read(struct kiocb *iocb,
-		struct iov_iter *iter, ssize_t written)
+ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
+		ssize_t already_read)
 {
 	struct file *filp = iocb->ki_filp;
 	struct file_ra_state *ra = &filp->f_ra;
@@ -2423,7 +2420,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		 * can no longer safely return -EIOCBQUEUED. Hence mark
 		 * an async read NOWAIT at that point.
 		 */
-		if ((iocb->ki_flags & IOCB_WAITQ) && written)
+		if ((iocb->ki_flags & IOCB_WAITQ) && already_read)
 			iocb->ki_flags |= IOCB_NOWAIT;
 
 		error = filemap_get_pages(iocb, iter, &pvec);
@@ -2483,7 +2480,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 			copied = copy_page_to_iter(page, offset, bytes, iter);
 
-			written += copied;
+			already_read += copied;
 			iocb->ki_pos += copied;
 			ra->prev_pos = iocb->ki_pos;
 
@@ -2500,9 +2497,9 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 	file_accessed(filp);
 
-	return written ? written : error;
+	return already_read ? already_read : error;
 }
-EXPORT_SYMBOL_GPL(generic_file_buffered_read);
+EXPORT_SYMBOL_GPL(filemap_read);
 
 /**
  * generic_file_read_iter - generic filesystem read routine
@@ -2576,7 +2573,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			goto out;
 	}
 
-	retval = generic_file_buffered_read(iocb, iter, retval);
+	retval = filemap_read(iocb, iter, retval);
 out:
 	return retval;
 }
-- 
2.29.2

