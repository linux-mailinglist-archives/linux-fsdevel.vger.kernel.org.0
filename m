Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2DE11EB59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 20:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfLMT57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 14:57:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:58940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728930AbfLMT57 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 14:57:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3EBEB1DD;
        Fri, 13 Dec 2019 19:57:57 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, darrick.wong@oracle.com, fdmanana@kernel.org,
        nborisov@suse.com, dsterba@suse.cz, jthumshirn@suse.de,
        linux-fsdevel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 1/8] fs: Export generic_file_buffered_read()
Date:   Fri, 13 Dec 2019 13:57:43 -0600
Message-Id: <20191213195750.32184-2-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191213195750.32184-1-rgoldwyn@suse.de>
References: <20191213195750.32184-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Export generic_file_buffered_read() to be used to
supplement incomplete direct reads.

While we are at it, correct the comments and variable names.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h |  2 ++
 mm/filemap.c       | 13 +++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..3883adaa0e01 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3098,6 +3098,8 @@ extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
 extern int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    size_t *count, unsigned int flags);
+extern ssize_t generic_file_buffered_read(struct kiocb *iocb,
+		struct iov_iter *to, ssize_t already_read);
 extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
diff --git a/mm/filemap.c b/mm/filemap.c
index bf6aa30be58d..dc2c7e3472a0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1994,7 +1994,7 @@ static void shrink_readahead_size_eio(struct file *filp,
  * generic_file_buffered_read - generic file read routine
  * @iocb:	the iocb to read
  * @iter:	data destination
- * @written:	already copied
+ * @copied:	already copied
  *
  * This is a generic file read routine, and uses the
  * mapping->a_ops->readpage() function for the actual low-level stuff.
@@ -2003,11 +2003,11 @@ static void shrink_readahead_size_eio(struct file *filp,
  * of the logic when it comes to error handling etc.
  *
  * Return:
- * * total number of bytes copied, including those the were already @written
+ * * total number of bytes copied, including those that were @copied
  * * negative error code if nothing was copied
  */
-static ssize_t generic_file_buffered_read(struct kiocb *iocb,
-		struct iov_iter *iter, ssize_t written)
+ssize_t generic_file_buffered_read(struct kiocb *iocb,
+		struct iov_iter *iter, ssize_t copied)
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
@@ -2148,7 +2148,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		prev_offset = offset;
 
 		put_page(page);
-		written += ret;
+		copied += ret;
 		if (!iov_iter_count(iter))
 			goto out;
 		if (ret < nr) {
@@ -2256,8 +2256,9 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 	*ppos = ((loff_t)index << PAGE_SHIFT) + offset;
 	file_accessed(filp);
-	return written ? written : error;
+	return copied ? copied : error;
 }
+EXPORT_SYMBOL_GPL(generic_file_buffered_read);
 
 /**
  * generic_file_read_iter - generic filesystem read routine
-- 
2.16.4

