Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B95739D0C1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFFTNY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhFFTMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:52 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C564C061767;
        Sun,  6 Jun 2021 12:11:02 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAg-0056at-2e; Sun, 06 Jun 2021 19:10:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 20/37] iov_iter: replace iov_iter_copy_from_user_atomic() with iterator-advancing variant
Date:   Sun,  6 Jun 2021 19:10:34 +0000
Message-Id: <20210606191051.1216821-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replacement is called copy_page_from_iter_atomic(); unlike the old primitive the
callers do *not* need to do iov_iter_advance() after it.  In case when they end
up consuming less than they'd been given they need to do iov_iter_revert() on
everything they had not consumed.  That, however, needs to be done only on slow
paths.

All in-tree callers converted.  And that kills the last user of iterate_all_kinds()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/porting.rst |  9 +++++++++
 fs/btrfs/file.c                       | 23 +++++++++++------------
 fs/fuse/file.c                        |  3 +--
 fs/iomap/buffered-io.c                | 14 +++++++-------
 fs/ntfs/file.c                        |  4 +---
 include/linux/uio.h                   |  4 ++--
 lib/iov_iter.c                        | 30 ++++--------------------------
 mm/filemap.c                          | 16 ++++++++--------
 8 files changed, 43 insertions(+), 60 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 0302035781be..43b492d08dec 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -890,3 +890,12 @@ been called or returned with non -EIOCBQUEUED code.
 
 mnt_want_write_file() can now only be paired with mnt_drop_write_file(),
 whereas previously it could be paired with mnt_drop_write() as well.
+
+---
+
+**mandatory**
+
+iov_iter_copy_from_user_atomic() is gone; use copy_page_from_iter_atomic().
+The difference is copy_page_from_iter_atomic() advances the iterator and
+you don't need iov_iter_advance() after it.  However, if you decide to use
+only a part of obtained data, you should do iov_iter_revert().
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 864c08d08a35..78cb8f9eaa6b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -398,7 +398,7 @@ static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
 		/*
 		 * Copy data from userspace to the current page
 		 */
-		copied = iov_iter_copy_from_user_atomic(page, i, offset, count);
+		copied = copy_page_from_iter_atomic(page, offset, count, i);
 
 		/* Flush processor's dcache for this page */
 		flush_dcache_page(page);
@@ -412,20 +412,19 @@ static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
 		 * The rest of the btrfs_file_write code will fall
 		 * back to page at a time copies after we return 0.
 		 */
-		if (!PageUptodate(page) && copied < count)
-			copied = 0;
+		if (unlikely(copied < count)) {
+			if (!PageUptodate(page)) {
+				iov_iter_revert(i, copied);
+				copied = 0;
+			}
+			if (!copied)
+				break;
+		}
 
-		iov_iter_advance(i, copied);
 		write_bytes -= copied;
 		total_copied += copied;
-
-		/* Return to btrfs_file_write_iter to fault page */
-		if (unlikely(copied == 0))
-			break;
-
-		if (copied < PAGE_SIZE - offset) {
-			offset += copied;
-		} else {
+		offset += copied;
+		if (offset == PAGE_SIZE) {
 			pg++;
 			offset = 0;
 		}
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 44bd301fa4fb..4722fa31a185 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1171,10 +1171,9 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_page(page);
 
-		tmp = iov_iter_copy_from_user_atomic(page, ii, offset, bytes);
+		tmp = copy_page_from_iter_atomic(page, offset, bytes, ii);
 		flush_dcache_page(page);
 
-		iov_iter_advance(ii, tmp);
 		if (!tmp) {
 			unlock_page(page);
 			put_page(page);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 354b41d20e5d..c5ff13e0e7cf 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -785,13 +785,15 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		if (mapping_writably_mapped(inode->i_mapping))
 			flush_dcache_page(page);
 
-		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
+		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
 
 		status = iomap_write_end(inode, pos, bytes, copied, page, iomap,
 				srcmap);
 
-		cond_resched();
+		if (unlikely(copied != status))
+			iov_iter_revert(i, copied - status);
 
+		cond_resched();
 		if (unlikely(status == 0)) {
 			/*
 			 * A short copy made iomap_write_end() reject the
@@ -803,11 +805,9 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 				bytes = copied;
 			goto again;
 		}
-		copied = status;
-		iov_iter_advance(i, copied);
-		pos += copied;
-		written += copied;
-		length -= copied;
+		pos += status;
+		written += status;
+		length -= status;
 
 		balance_dirty_pages_ratelimited(inode->i_mapping);
 	} while (iov_iter_count(i) && length);
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 0666d4578137..ab4f3362466d 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1690,9 +1690,7 @@ static size_t ntfs_copy_from_user_iter(struct page **pages, unsigned nr_pages,
 		len = PAGE_SIZE - ofs;
 		if (len > bytes)
 			len = bytes;
-		copied = iov_iter_copy_from_user_atomic(*pages, i, ofs,
-				len);
-		iov_iter_advance(i, copied);
+		copied = copy_page_from_iter_atomic(*pages, ofs, len, i);
 		total += copied;
 		bytes -= copied;
 		if (!bytes)
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 18b4e0a8e3bf..fd88d9911dad 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -115,8 +115,8 @@ static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
 	};
 }
 
-size_t iov_iter_copy_from_user_atomic(struct page *page,
-		struct iov_iter *i, unsigned long offset, size_t bytes);
+size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
+				  size_t bytes, struct iov_iter *i);
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
 void iov_iter_revert(struct iov_iter *i, size_t bytes);
 int iov_iter_fault_in_readable(const struct iov_iter *i, size_t bytes);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6a968d2ff081..dbd6b92f6200 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -114,28 +114,6 @@
 	n = wanted - n;						\
 }
 
-#define iterate_all_kinds(i, n, v, I, B, K, X) {		\
-	if (likely(n)) {					\
-		size_t skip = i->iov_offset;			\
-		if (likely(iter_is_iovec(i))) {			\
-			const struct iovec *iov;		\
-			struct iovec v;				\
-			iterate_iovec(i, n, v, iov, skip, (I))	\
-		} else if (iov_iter_is_bvec(i)) {		\
-			struct bio_vec v;			\
-			struct bvec_iter __bi;			\
-			iterate_bvec(i, n, v, __bi, skip, (B))	\
-		} else if (iov_iter_is_kvec(i)) {		\
-			const struct kvec *kvec;		\
-			struct kvec v;				\
-			iterate_kvec(i, n, v, kvec, skip, (K))	\
-		} else if (iov_iter_is_xarray(i)) {		\
-			struct bio_vec v;			\
-			iterate_xarray(i, n, v, skip, (X));	\
-		}						\
-	}							\
-}
-
 #define iterate_and_advance(i, n, v, I, B, K, X) {		\
 	if (unlikely(i->count < n))				\
 		n = i->count;					\
@@ -1020,8 +998,8 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_zero);
 
-size_t iov_iter_copy_from_user_atomic(struct page *page,
-		struct iov_iter *i, unsigned long offset, size_t bytes)
+size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t bytes,
+				  struct iov_iter *i)
 {
 	char *kaddr = kmap_atomic(page), *p = kaddr + offset;
 	if (unlikely(!page_copy_sane(page, offset, bytes))) {
@@ -1033,7 +1011,7 @@ size_t iov_iter_copy_from_user_atomic(struct page *page,
 		WARN_ON(1);
 		return 0;
 	}
-	iterate_all_kinds(i, bytes, v,
+	iterate_and_advance(i, bytes, v,
 		copyin((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
 		memcpy_from_page((p += v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
@@ -1044,7 +1022,7 @@ size_t iov_iter_copy_from_user_atomic(struct page *page,
 	kunmap_atomic(kaddr);
 	return bytes;
 }
-EXPORT_SYMBOL(iov_iter_copy_from_user_atomic);
+EXPORT_SYMBOL(copy_page_from_iter_atomic);
 
 static inline void pipe_truncate(struct iov_iter *i)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index 0be24942bf8e..cf9de790f493 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3661,14 +3661,16 @@ ssize_t generic_perform_write(struct file *file,
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_page(page);
 
-		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
+		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
 		flush_dcache_page(page);
 
 		status = a_ops->write_end(file, mapping, pos, bytes, copied,
 						page, fsdata);
-		if (unlikely(status < 0))
-			break;
-
+		if (unlikely(status != copied)) {
+			iov_iter_revert(i, copied - max(status, 0L));
+			if (unlikely(status < 0))
+				break;
+		}
 		cond_resched();
 
 		if (unlikely(status == 0)) {
@@ -3682,10 +3684,8 @@ ssize_t generic_perform_write(struct file *file,
 				bytes = copied;
 			goto again;
 		}
-		copied = status;
-		iov_iter_advance(i, copied);
-		pos += copied;
-		written += copied;
+		pos += status;
+		written += status;
 
 		balance_dirty_pages_ratelimited(mapping);
 	} while (iov_iter_count(i));
-- 
2.11.0

