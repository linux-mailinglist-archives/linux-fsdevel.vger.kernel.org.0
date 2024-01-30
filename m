Return-Path: <linux-fsdevel+bounces-9492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB20841B98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 06:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDFC6B231DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 05:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC5E3839C;
	Tue, 30 Jan 2024 05:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MuJjlDIw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8190381B9;
	Tue, 30 Jan 2024 05:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594062; cv=none; b=PE06QfeYFepMwKW9iIBg0VgNPoIl7MC0NOeKyaN73IIT4As3u3kPYaSrfMVQ8vaVPCfHNVFkqIXSh35uiqPTrOYOPDkvClMEMWXKsLBbEuCIispgkjEJMuB4AqALFeobFQ6yRMCNfEsAxlnyyMQ9kLGrE3ELzK8xZ4k6v5iqGi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594062; c=relaxed/simple;
	bh=dkuYEzYpITu1HQ0h5gF4Cg9LPRIjo2PFmBa7ZMeaq/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOKMy5xocfPf6KH/vPQn5Uge9XRXZUGR9+su7TaqN2TA3VkOACHUmcWmgcx9QjW0w0tUO+bZxdFHnJJcxHDLuQdTTDqjeiAYeOj5Q74aEJfKy7pZ6ZvLzutlMv/xLc8tsGbyvhpYRQWnLv1YBsVE6YCF8WBabi41DsEyQTZR418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MuJjlDIw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=c6QBcK6hZm/AsW8HURTe3yrT8n/4oDbgtP25uaPmGHc=; b=MuJjlDIw9GLIdwLHzp5MOU6s9D
	tJPMCn7glheGLvoTY5JbW7t4WcUhr+IMq8vUsY4bcNJmyB4W4RH8ewt7C4Lhbn/fzdNXdXkdwFf5j
	qzj0kiSf4yHCymfXiwmSFcLzdLnFQr3PGRTSBSKERufs7fL0Ao4BCxH8FBY1vNeLE8ZTpVmg2ga9J
	gPJoTwnmGOLnYFSfmS+jvv1l2RWo2SIhrLeVmN2rXJ/C1omgbSWRxDGyBCpYfBZsEVKkOM5QXujBP
	bei3UUOMUX2tpP/MEg6aNSMbWFFE8uLdtOmUvBfCFfT39V8RI/eZXBXQLqQKrpXbDX5dl+Ef6fxGc
	WzM5CGmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUh4a-00000008zkh-0eKg;
	Tue, 30 Jan 2024 05:54:16 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 1/3] fs: Introduce buffered_write_operations
Date: Tue, 30 Jan 2024 05:54:11 +0000
Message-ID: <20240130055414.2143959-2-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130055414.2143959-1-willy@infradead.org>
References: <20240130055414.2143959-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Start the process of moving write_begin and write_end out from the
address_space_operations to their own struct.  Make them take a folio
instead of a page, and pass a pointer to the fsdata to write_end
(so that we don't need to initialise it).

Pass an optional buffered_write_operations pointer to various functions
in filemap.c.  The old names are available as macros for now, except
for generic_file_write_iter() which is used as a function pointer by
many filesystems.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/file.c           |  3 +-
 fs/ramfs/file-mmu.c     |  3 +-
 fs/ufs/file.c           |  2 +-
 include/linux/fs.h      |  3 --
 include/linux/pagemap.h | 22 +++++++++++++
 mm/filemap.c            | 70 +++++++++++++++++++++++++++--------------
 6 files changed, 71 insertions(+), 32 deletions(-)

diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 01b6912e60f8..9c62445ea6be 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -4,8 +4,7 @@
  *   Portions Copyright (C) Christoph Hellwig, 2001-2002
  */
 
-#include <linux/mm.h>
-#include <linux/fs.h>
+#include <linux/pagemap.h>
 #include <linux/posix_acl.h>
 #include <linux/quotaops.h>
 #include "jfs_incore.h"
diff --git a/fs/ramfs/file-mmu.c b/fs/ramfs/file-mmu.c
index c7a1aa3c882b..a621b08b0235 100644
--- a/fs/ramfs/file-mmu.c
+++ b/fs/ramfs/file-mmu.c
@@ -24,8 +24,7 @@
  * caches is sufficient.
  */
 
-#include <linux/fs.h>
-#include <linux/mm.h>
+#include <linux/pagemap.h>
 #include <linux/ramfs.h>
 #include <linux/sched.h>
 
diff --git a/fs/ufs/file.c b/fs/ufs/file.c
index 6558882a89ef..b557d4a14143 100644
--- a/fs/ufs/file.c
+++ b/fs/ufs/file.c
@@ -24,7 +24,7 @@
  *  ext2 fs regular file handling primitives
  */
 
-#include <linux/fs.h>
+#include <linux/pagemap.h>
 
 #include "ufs_fs.h"
 #include "ufs.h"
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..92dc0cf08b1f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3048,10 +3048,7 @@ extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
 ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *to,
 		ssize_t already_read);
 extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
-extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
-extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_direct_write(struct kiocb *, struct iov_iter *);
-ssize_t generic_perform_write(struct kiocb *, struct iov_iter *);
 ssize_t direct_write_fallback(struct kiocb *iocb, struct iov_iter *iter,
 		ssize_t direct_written, ssize_t buffered_written);
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2df35e65557d..a5c474ad230e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -18,6 +18,28 @@
 
 struct folio_batch;
 
+struct buffered_write_operations {
+	int (*write_begin)(struct file *, struct address_space *mapping,
+			loff_t pos, size_t len, struct folio **foliop,
+			void **fsdata);
+	int (*write_end)(struct file *, struct address_space *mapping,
+			loff_t pos, size_t len, size_t copied,
+			struct folio *folio, void **fsdata);
+};
+
+ssize_t filemap_write_iter(struct kiocb *, struct iov_iter *,
+		const struct buffered_write_operations *);
+ssize_t __filemap_write_iter(struct kiocb *, struct iov_iter *,
+		const struct buffered_write_operations *);
+ssize_t filemap_perform_write(struct kiocb *, struct iov_iter *,
+		const struct buffered_write_operations *);
+
+ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
+#define generic_perform_write(kiocb, iter)		\
+	filemap_perform_write(kiocb, iter, NULL)
+#define __generic_file_write_iter(kiocb, iter)		\
+	__filemap_write_iter(kiocb, iter, NULL)
+
 unsigned long invalidate_mapping_pages(struct address_space *mapping,
 					pgoff_t start, pgoff_t end);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 750e779c23db..66d779b787c8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -95,7 +95,7 @@
  *    ->invalidate_lock		(filemap_fault)
  *      ->lock_page		(filemap_fault, access_process_vm)
  *
- *  ->i_rwsem			(generic_perform_write)
+ *  ->i_rwsem			(filemap_perform_write)
  *    ->mmap_lock		(fault_in_readable->do_page_fault)
  *
  *  bdi->wb.list_lock
@@ -3890,7 +3890,8 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 }
 EXPORT_SYMBOL(generic_file_direct_write);
 
-ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
+ssize_t filemap_perform_write(struct kiocb *iocb, struct iov_iter *i,
+		const struct buffered_write_operations *ops)
 {
 	struct file *file = iocb->ki_filp;
 	loff_t pos = iocb->ki_pos;
@@ -3900,9 +3901,9 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 	ssize_t written = 0;
 
 	do {
-		struct page *page;
-		unsigned long offset;	/* Offset into pagecache page */
-		unsigned long bytes;	/* Bytes to write to page */
+		struct folio *folio;
+		size_t offset;		/* Offset into pagecache folio */
+		size_t bytes;		/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
 		void *fsdata = NULL;
 
@@ -3927,19 +3928,31 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
-		status = a_ops->write_begin(file, mapping, pos, bytes,
+		if (ops)
+			status = ops->write_begin(file, mapping, pos, bytes,
+						&folio, &fsdata);
+		else {
+			struct page *page;
+			status = a_ops->write_begin(file, mapping, pos, bytes,
 						&page, &fsdata);
+			if (status >= 0)
+				folio = page_folio(page);
+		}
 		if (unlikely(status < 0))
 			break;
 
 		if (mapping_writably_mapped(mapping))
-			flush_dcache_page(page);
+			flush_dcache_folio(folio);
 
-		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
-		flush_dcache_page(page);
+		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
+		flush_dcache_folio(folio);
 
-		status = a_ops->write_end(file, mapping, pos, bytes, copied,
-						page, fsdata);
+		if (ops)
+			status = ops->write_end(file, mapping, pos, bytes,
+					copied, folio, &fsdata);
+		else
+			status = a_ops->write_end(file, mapping, pos, bytes,
+					copied, &folio->page, fsdata);
 		if (unlikely(status != copied)) {
 			iov_iter_revert(i, copied - max(status, 0L));
 			if (unlikely(status < 0))
@@ -3969,12 +3982,13 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 	iocb->ki_pos += written;
 	return written;
 }
-EXPORT_SYMBOL(generic_perform_write);
+EXPORT_SYMBOL(filemap_perform_write);
 
 /**
- * __generic_file_write_iter - write data to a file
- * @iocb:	IO state structure (file, offset, etc.)
- * @from:	iov_iter with data to write
+ * __filemap_write_iter - write data to a file
+ * @iocb: IO state structure (file, offset, etc.)
+ * @from: iov_iter with data to write
+ * @ops: How to inform the filesystem that a write is starting/finishing.
  *
  * This function does all the work needed for actually writing data to a
  * file. It does all basic checks, removes SUID from the file, updates
@@ -3992,7 +4006,8 @@ EXPORT_SYMBOL(generic_perform_write);
  * * number of bytes written, even for truncated writes
  * * negative error code if no data has been written at all
  */
-ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+ssize_t __filemap_write_iter(struct kiocb *iocb, struct iov_iter *from,
+		const struct buffered_write_operations *ops)
 {
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
@@ -4019,27 +4034,29 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		if (ret < 0 || !iov_iter_count(from) || IS_DAX(inode))
 			return ret;
 		return direct_write_fallback(iocb, from, ret,
-				generic_perform_write(iocb, from));
+				filemap_perform_write(iocb, from, ops));
 	}
 
-	return generic_perform_write(iocb, from);
+	return filemap_perform_write(iocb, from, ops);
 }
-EXPORT_SYMBOL(__generic_file_write_iter);
+EXPORT_SYMBOL(__filemap_write_iter);
 
 /**
- * generic_file_write_iter - write data to a file
+ * filemap_write_iter - write data to a file
  * @iocb:	IO state structure
  * @from:	iov_iter with data to write
  *
- * This is a wrapper around __generic_file_write_iter() to be used by most
+ * This is a wrapper around __filemap_write_iter() to be used by most
  * filesystems. It takes care of syncing the file in case of O_SYNC file
  * and acquires i_rwsem as needed.
+ *
  * Return:
- * * negative error code if no data has been written at all of
+ * * negative error code if no data has been written at all or if
  *   vfs_fsync_range() failed for a synchronous write
  * * number of bytes written, even for truncated writes
  */
-ssize_t generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+ssize_t filemap_write_iter(struct kiocb *iocb, struct iov_iter *from,
+		const struct buffered_write_operations *ops)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
@@ -4048,13 +4065,18 @@ ssize_t generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	inode_lock(inode);
 	ret = generic_write_checks(iocb, from);
 	if (ret > 0)
-		ret = __generic_file_write_iter(iocb, from);
+		ret = __filemap_write_iter(iocb, from, ops);
 	inode_unlock(inode);
 
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
 	return ret;
 }
+
+ssize_t generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return filemap_write_iter(iocb, from, NULL);
+}
 EXPORT_SYMBOL(generic_file_write_iter);
 
 /**
-- 
2.43.0


