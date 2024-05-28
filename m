Return-Path: <linux-fsdevel+bounces-20360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAD08D21EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 18:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0F91C230BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 16:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA7174EE1;
	Tue, 28 May 2024 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e+/iCc0Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C841D172BCE;
	Tue, 28 May 2024 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914914; cv=none; b=pNbW/Kh6zTVjdtejPuX/HJ6BW4t9o+Bc0twq9RDeJ8A+2hapztIO2uddqFBRHX+/1yN/Yxz5hxXxy+T/wiGEWyQ88TYotM33GNt+YuYYisZn0g/KZz/nkTp5WJdefAySSyQa7DaQs4k6IK9NyB7sq7SEl1G90+yjjps4B3DYpYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914914; c=relaxed/simple;
	bh=ZUIxx2xeFJYxqRMAfylam9w+4tK2gVq5ifvkLE0pePw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1MpC/ShSJAPCy0VHkMoIy+Tq4aFFmH2l74aCG7kng1GFY3spSpGqq4gGOmZIfZTCl1/XTG07jh/n8WXZt1xeZQLYjsLXrnHrziUA3jpFMofFzIsxzJdBTw5i6D/7qoCGIM0CZtl6RoZVycwfFialFXGrnKSQkwK3zvnt8kVauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e+/iCc0Q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=rNhqStnPi0LQIT1jWD+BHswn8m4DZffZMrQiTgaOunA=; b=e+/iCc0QLvuuxR+UQ68sbys9bL
	NnFieCYhYgcNRXIZz0irZsz7essAW2lr6Nfu7LGTxabfQB0gDN/2jzaJQnIOhxBOKMZkXQJ67VOtI
	E0teEhPWNoz92oKsv4fi6rNe3n+HrwDaf1XQ6fmggrPVjVPT3b4poMAZAxABHkjSzlIrFJVQWwini
	+t0jVAAUS1Qm0cw7tP0r1PQYiLohUywQJMSP7rdUv80LWRfb9Qx5kn07jG7qQcWHsaNHW0DNb4khh
	3UZCS6nrY8WC5FvpPwweJ8bHtueHssBwFikQ81olBEgX29x9EW2eoN/qvvPi8I8KMmLTM/9EaI7uU
	czTj4LOg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBzzz-00000008pj3-0mih;
	Tue, 28 May 2024 16:48:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 1/7] fs: Introduce buffered_write_operations
Date: Tue, 28 May 2024 17:48:22 +0100
Message-ID: <20240528164829.2105447-2-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528164829.2105447-1-willy@infradead.org>
References: <20240528164829.2105447-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Start the process of moving write_begin and write_end out from the
address_space_operations to their own struct.

The new write_begin returns the folio or an ERR_PTR instead of returning
the folio by reference.  It also accepts len as a size_t and (as
documented) the len may be larger than PAGE_SIZE.

Pass an optional buffered_write_operations pointer to various functions
in filemap.c.  The old names are available as macros for now, except
for generic_file_write_iter() which is used as a function pointer by
many filesystems.  If using the new functions, the filesystem can have
per-operation fsdata instead of per-page fsdata.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst | 23 ++++++++
 fs/jfs/file.c                         |  3 +-
 fs/ramfs/file-mmu.c                   |  3 +-
 fs/ufs/file.c                         |  2 +-
 include/linux/fs.h                    |  3 --
 include/linux/pagemap.h               | 21 ++++++++
 mm/filemap.c                          | 77 +++++++++++++++++----------
 7 files changed, 97 insertions(+), 35 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index e664061ed55d..e62a8a83ea9e 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -413,6 +413,29 @@ path after ->swap_activate() returned success.
 
 ->swap_rw will be called for swap IO if SWP_FS_OPS was set by ->swap_activate().
 
+buffered_write_operations
+=========================
+
+	struct folio *(*write_begin)(struct file *, struct address_space *,
+			loff_t pos, size_t len, void **fsdata);
+	size_t (*write_end)(struct file *, struct address_space *,
+			loff_t pos, size_t len, size_t copied,
+			struct folio *folio, void **fsdata);
+
+For write_begin, 'len' is typically the remaining length of the write,
+and is not capped to PAGE_SIZE.  For write_end, len will be limited so
+that pos + len <= folio_pos(folio) + folio_size(folio).  copied will
+not exceed len.  pos + len will not exceed MAX_LFS_FILESIZE.
+
+write_begin may return an ERR_PTR.  write_end may return a number less
+than copied if it needs the caller to retry from an earlier position in
+the file.  It cannot signal an error; that must be done by write_begin().
+
+write_begin should lock the folio and increase its refcount.  write_end
+should unlock it and drop the refcount, possibly after setting it
+uptodate (it can only use folio_end_read() for this if it knows the folio
+was not previously uptodate; probably best not to use it).
+
 file_lock_operations
 ====================
 
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
index b45c7edc3225..5de2a232d07f 100644
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
index 0283cf366c2a..4c6c2042cbeb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3115,10 +3115,7 @@ extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
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
index ee633712bba0..2921c1cc6335 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -18,6 +18,27 @@
 
 struct folio_batch;
 
+struct buffered_write_operations {
+	struct folio *(*write_begin)(struct file *, struct address_space *,
+			loff_t pos, size_t len, void **fsdata);
+	size_t (*write_end)(struct file *, struct address_space *,
+			loff_t pos, size_t len, size_t copied,
+			struct folio *folio, void **fsdata);
+};
+
+ssize_t filemap_write_iter(struct kiocb *, struct iov_iter *,
+		const struct buffered_write_operations *, void *fsdata);
+ssize_t __filemap_write_iter(struct kiocb *, struct iov_iter *,
+		const struct buffered_write_operations *, void *fsdata);
+ssize_t filemap_perform_write(struct kiocb *, struct iov_iter *,
+		const struct buffered_write_operations *, void *fsdata);
+
+ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
+#define generic_perform_write(kiocb, iter)		\
+	filemap_perform_write(kiocb, iter, NULL, NULL)
+#define __generic_file_write_iter(kiocb, iter)		\
+	__filemap_write_iter(kiocb, iter, NULL, NULL)
+
 unsigned long invalidate_mapping_pages(struct address_space *mapping,
 					pgoff_t start, pgoff_t end);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 382c3d06bfb1..162ac110c423 100644
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
@@ -3975,7 +3975,8 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 }
 EXPORT_SYMBOL(generic_file_direct_write);
 
-ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
+ssize_t filemap_perform_write(struct kiocb *iocb, struct iov_iter *i,
+		const struct buffered_write_operations *ops, void *fsdata)
 {
 	struct file *file = iocb->ki_filp;
 	loff_t pos = iocb->ki_pos;
@@ -3985,11 +3986,10 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 	ssize_t written = 0;
 
 	do {
-		struct page *page;
-		unsigned long offset;	/* Offset into pagecache page */
-		unsigned long bytes;	/* Bytes to write to page */
+		struct folio *folio;
+		size_t offset;		/* Offset into pagecache folio */
+		size_t bytes;		/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
-		void *fsdata = NULL;
 
 		offset = (pos & (PAGE_SIZE - 1));
 		bytes = min_t(unsigned long, PAGE_SIZE - offset,
@@ -4012,19 +4012,33 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
-		status = a_ops->write_begin(file, mapping, pos, bytes,
+		if (ops) {
+			folio = ops->write_begin(file, mapping, pos, bytes, &fsdata);
+			if (IS_ERR(folio)) {
+				status = PTR_ERR(folio);
+				break;
+			}
+		} else {
+			struct page *page;
+			status = a_ops->write_begin(file, mapping, pos, bytes,
 						&page, &fsdata);
-		if (unlikely(status < 0))
-			break;
+			if (unlikely(status < 0))
+				break;
+			folio = page_folio(page);
+		}
 
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
@@ -4054,12 +4068,13 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
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
@@ -4077,7 +4092,8 @@ EXPORT_SYMBOL(generic_perform_write);
  * * number of bytes written, even for truncated writes
  * * negative error code if no data has been written at all
  */
-ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+ssize_t __filemap_write_iter(struct kiocb *iocb, struct iov_iter *from,
+		const struct buffered_write_operations *ops, void *fsdata)
 {
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
@@ -4104,27 +4120,29 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		if (ret < 0 || !iov_iter_count(from) || IS_DAX(inode))
 			return ret;
 		return direct_write_fallback(iocb, from, ret,
-				generic_perform_write(iocb, from));
+				filemap_perform_write(iocb, from, ops, fsdata));
 	}
 
-	return generic_perform_write(iocb, from);
+	return filemap_perform_write(iocb, from, ops, fsdata);
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
+		const struct buffered_write_operations *ops, void *fsdata)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
@@ -4133,13 +4151,18 @@ ssize_t generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	inode_lock(inode);
 	ret = generic_write_checks(iocb, from);
 	if (ret > 0)
-		ret = __generic_file_write_iter(iocb, from);
+		ret = __filemap_write_iter(iocb, from, ops, fsdata);
 	inode_unlock(inode);
 
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
 	return ret;
 }
+
+ssize_t generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return filemap_write_iter(iocb, from, NULL, NULL);
+}
 EXPORT_SYMBOL(generic_file_write_iter);
 
 /**
-- 
2.43.0


