Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A262A14CD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 10:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgJaJ2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 05:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgJaJ2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:28:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F6AC0613D5
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 02:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UVuvskOd7u+cW+9FE21ypaPGl+5Mur2FVKlFNoSP4LQ=; b=V1HLFl0izdyBDWpSlqawDTXJBs
        lx0AQba6PUflfbCt/aXdj3P9hEhRFmOX0nIvYzjVrxdYakRh/KdB9IP9dEe7BFFKPABHYC2mWsUZz
        MkwnCvpJnGsknEcAS4m8uoNclTZ74jKhnWs+NMHpomVWYSW+g+sE8yEOApDN81REUWy8jQctMaiLW
        QbmFRs6JKG/Pz5IDeGiZPHcGnze/0a8M4kjy7VuJV5EYHmJtIyOmeWk9IAxiC/l/allMzZ2aEUoBH
        3kvECAUgROf0RyGUd11QVEVGGE/flivZLWFOczbtVRVKBH4NEmwBsNoOnwDj1SfocEK8I/kII1k3n
        k8xSTmgw==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYnBV-0000CU-Fv; Sat, 31 Oct 2020 09:28:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/13] mm: rename generic_file_buffered_read to filemap_read
Date:   Sat, 31 Oct 2020 10:00:03 +0100
Message-Id: <20201031090004.452516-13-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031090004.452516-1-hch@lst.de>
References: <20201031090004.452516-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename generic_file_buffered_read to match the naming of filemap_fault,
also update the written parameter to a more descriptive name and
improve the kerneldoc comment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/file.c    |  2 +-
 include/linux/fs.h |  4 ++--
 mm/filemap.c       | 34 ++++++++++++++++------------------
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 87355a38a65470..1a4913e1fd1289 100644
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
index 8d559d43f2af92..a79f65607236ae 100644
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
index 904b0a4fb9e008..743d764f3eab1c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2372,23 +2372,21 @@ static int filemap_read_pages(struct kiocb *iocb, struct iov_iter *iter,
 }
 
 /**
- * generic_file_buffered_read - generic file read routine
- * @iocb:	the iocb to read
- * @iter:	data destination
- * @written:	already copied
+ * filemap_read - read data from the page cache
+ * @iocb:		the iocb to read
+ * @iter:		data destination
+ * @already_read:	number of bytes already read by the caller
  *
- * This is a generic file read routine, and uses the
- * mapping->a_ops->readpage() function for the actual low-level stuff.
- *
- * This is really ugly. But the goto's actually try to clarify some
- * of the logic when it comes to error handling etc.
+ * Read data from the pagecache using the ->readpage address space
+ * operation.
  *
  * Return:
- * * total number of bytes copied, including those the were already @written
- * * negative error code if nothing was copied
+ *  Total number of bytes copied, including those already read by the caller as
+ *  passed in the @already_read argument.  Negative error code if an error
+ *  happened before any bytes were copied.
  */
-ssize_t generic_file_buffered_read(struct kiocb *iocb,
-		struct iov_iter *iter, ssize_t written)
+ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
+		ssize_t already_read)
 {
 	struct file *filp = iocb->ki_filp;
 	struct file_ra_state *ra = &filp->f_ra;
@@ -2422,7 +2420,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		 * can no longer safely return -EIOCBQUEUED. Hence mark
 		 * an async read NOWAIT at that point.
 		 */
-		if ((iocb->ki_flags & IOCB_WAITQ) && written)
+		if ((iocb->ki_flags & IOCB_WAITQ) && already_read)
 			iocb->ki_flags |= IOCB_NOWAIT;
 
 		i = 0;
@@ -2482,7 +2480,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 			copied = copy_page_to_iter(pages[i], offset, bytes, iter);
 
-			written += copied;
+			already_read += copied;
 			iocb->ki_pos += copied;
 			ra->prev_pos = iocb->ki_pos;
 
@@ -2501,9 +2499,9 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	if (pages != pages_onstack)
 		kfree(pages);
 
-	return written ? written : error;
+	return already_read ? already_read : error;
 }
-EXPORT_SYMBOL_GPL(generic_file_buffered_read);
+EXPORT_SYMBOL_GPL(filemap_read);
 
 /**
  * generic_file_read_iter - generic filesystem read routine
@@ -2577,7 +2575,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			goto out;
 	}
 
-	retval = generic_file_buffered_read(iocb, iter, retval);
+	retval = filemap_read(iocb, iter, retval);
 out:
 	return retval;
 }
-- 
2.28.0

