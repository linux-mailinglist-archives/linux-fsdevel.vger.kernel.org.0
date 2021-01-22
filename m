Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5236A300878
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 17:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbhAVQTF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbhAVQPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:15:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2297C061788;
        Fri, 22 Jan 2021 08:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=A1+HIPy+gc0pcVpTnVIkfesangqzonHz4LbQrFN5pFU=; b=T1Xkr38TmFFJMUcKHRZ0+IrU/+
        EtookqUKM9mM59iDg6TlakiUy42NTTUhmddrYBUKn5gln/VxGjMVg+lott3N5Ff3+e9dCbaypvvJk
        rHlsuRRB0iRh4HGcE2KNLAdwJfN5wACrTQ5wZzhwwqnbef6Nqg69N38nMz5nEX7jaxXds1eO3P/Gu
        mbfQQGl0U9sNdMZmGgZbUMpzBAvYhVymUafFAc2sO6uvK8sVTrDoynPmAW6RI3jC/YyGUJ1MtXghN
        aLorOXSi3pcJKQSkkfax4obpy0f2leS5Jh+kVkp68YCrQbv45kZnybcFCdwbB0FQe9UOz6iqveQzu
        WbZpZekw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2z41-000wkQ-RY; Fri, 22 Jan 2021 16:13:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v5 17/18] mm/filemap: Rename generic_file_buffered_read to filemap_read
Date:   Fri, 22 Jan 2021 16:01:39 +0000
Message-Id: <20210122160140.223228-18-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122160140.223228-1-willy@infradead.org>
References: <20210122160140.223228-1-willy@infradead.org>
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
index d81ae1f518f23..b0ff2e62a65ca 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3636,7 +3636,7 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			return ret;
 	}
 
-	return generic_file_buffered_read(iocb, to, ret);
+	return filemap_read(iocb, to, ret);
 }
 
 const struct file_operations btrfs_file_operations = {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 43ba79ddbd680..11a399967ad80 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2985,8 +2985,8 @@ extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
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
index 542d9c93732c2..ef910eca9e1a2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2406,23 +2406,20 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
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
@@ -2449,7 +2446,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		 * can no longer safely return -EIOCBQUEUED. Hence mark
 		 * an async read NOWAIT at that point.
 		 */
-		if ((iocb->ki_flags & IOCB_WAITQ) && written)
+		if ((iocb->ki_flags & IOCB_WAITQ) && already_read)
 			iocb->ki_flags |= IOCB_NOWAIT;
 
 		error = filemap_get_pages(iocb, iter, &pvec);
@@ -2509,7 +2506,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 			copied = copy_page_to_iter(page, offset, bytes, iter);
 
-			written += copied;
+			already_read += copied;
 			iocb->ki_pos += copied;
 			ra->prev_pos = iocb->ki_pos;
 
@@ -2526,9 +2523,9 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 	file_accessed(filp);
 
-	return written ? written : error;
+	return already_read ? already_read : error;
 }
-EXPORT_SYMBOL_GPL(generic_file_buffered_read);
+EXPORT_SYMBOL_GPL(filemap_read);
 
 /**
  * generic_file_read_iter - generic filesystem read routine
@@ -2603,7 +2600,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			goto out;
 	}
 
-	retval = generic_file_buffered_read(iocb, iter, retval);
+	retval = filemap_read(iocb, iter, retval);
 out:
 	return retval;
 }
-- 
2.29.2

