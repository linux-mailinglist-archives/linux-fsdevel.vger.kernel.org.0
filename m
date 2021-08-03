Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070BC3DF554
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 21:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbhHCTS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 15:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239672AbhHCTSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628018322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d4E1Qin+ePcwNeaFJu+kDVoz1ZDgT3Tu2W5ZUgmPT3Q=;
        b=FyWHxquRRB3ZjgHNvUXuuTOdTpAt7+GPv0phr/Z+LnxGAiqnI0xJ9ffNgGmHd9RDgt+3TI
        sPHtD3pZ0BS1lJPpdhEWumAdmWHYtw8qg95j/zPGiKhNveS897jW57W7ZJZ4GDA8csOx4F
        pTtTfyx7EIzsLIHRxfR9Dpv+8bInmys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-I4hoRkuWOxmVpzPQ0rrEZQ-1; Tue, 03 Aug 2021 15:18:41 -0400
X-MC-Unique: I4hoRkuWOxmVpzPQ0rrEZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D5771802968;
        Tue,  3 Aug 2021 19:18:39 +0000 (UTC)
Received: from max.com (unknown [10.40.193.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 271F460C0F;
        Tue,  3 Aug 2021 19:18:36 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v5 04/12] Turn iov_iter_fault_in_readable into fault_in_iov_iter_readable
Date:   Tue,  3 Aug 2021 21:18:10 +0200
Message-Id: <20210803191818.993968-5-agruenba@redhat.com>
In-Reply-To: <20210803191818.993968-1-agruenba@redhat.com>
References: <20210803191818.993968-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Turn iov_iter_fault_in_readable into a function that returns the number of
bytes faulted in instead of returning a non-zero value when any of the
requested pages couldn't be faulted in.  This supports the existing users that
require all pages to be faulted in, but also new users that are happy if any
pages can be faulted in.

Rename iov_iter_fault_in_readable to an unfortunately clumsy
fault_in_iov_iter_readable to make sure that code that uses it can be fixed
instead of breaking silently.

Fix up the existing users.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/btrfs/file.c        |  3 ++-
 fs/f2fs/file.c         |  6 +++---
 fs/fuse/file.c         |  2 +-
 fs/iomap/buffered-io.c |  2 +-
 fs/ntfs/file.c         |  2 +-
 include/linux/uio.h    |  2 +-
 lib/iov_iter.c         | 33 ++++++++++++++++++++++-----------
 mm/filemap.c           |  2 +-
 8 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index ee34497500e1..8ff9e0bb5b0f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1698,7 +1698,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		 * Fault pages before locking them in prepare_pages
 		 * to avoid recursive lock
 		 */
-		if (unlikely(iov_iter_fault_in_readable(i, write_bytes))) {
+		if (unlikely(fault_in_iov_iter_readable(i, write_bytes) !=
+				write_bytes)) {
 			ret = -EFAULT;
 			break;
 		}
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6afd4562335f..7c172573f18a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4255,16 +4255,16 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	ret = generic_write_checks(iocb, from);
 	if (ret > 0) {
+		size_t count = iov_iter_count(from);
 		bool preallocated = false;
 		size_t target_size = 0;
 		int err;
 
-		if (iov_iter_fault_in_readable(from, iov_iter_count(from)))
+		if (fault_in_iov_iter_readable(from, count) != count)
 			set_inode_flag(inode, FI_NO_PREALLOC);
 
 		if ((iocb->ki_flags & IOCB_NOWAIT)) {
-			if (!f2fs_overwrite_io(inode, iocb->ki_pos,
-						iov_iter_count(from)) ||
+			if (!f2fs_overwrite_io(inode, iocb->ki_pos, count) ||
 				f2fs_has_inline_data(inode) ||
 				f2fs_force_buffered_io(inode, iocb, from)) {
 				clear_inode_flag(inode, FI_NO_PREALLOC);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 97f860cfc195..d5dd01f20f1e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1160,7 +1160,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
  again:
 		err = -EFAULT;
-		if (iov_iter_fault_in_readable(ii, bytes))
+		if (fault_in_iov_iter_readable(ii, bytes) != bytes)
 			break;
 
 		err = -ENOMEM;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87ccb3438bec..d5de094fef73 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -749,7 +749,7 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
+		if (unlikely(fault_in_iov_iter_readable(i, bytes) != bytes)) {
 			status = -EFAULT;
 			break;
 		}
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index ab4f3362466d..cddac274c35a 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1829,7 +1829,7 @@ static ssize_t ntfs_perform_write(struct file *file, struct iov_iter *i,
 		 * pages being swapped out between us bringing them into memory
 		 * and doing the actual copying.
 		 */
-		if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
+		if (unlikely(fault_in_iov_iter_readable(i, bytes) != bytes)) {
 			status = -EFAULT;
 			break;
 		}
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 82c3c3e819e0..12d30246c2e9 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -119,7 +119,7 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
 				  size_t bytes, struct iov_iter *i);
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
 void iov_iter_revert(struct iov_iter *i, size_t bytes);
-int iov_iter_fault_in_readable(const struct iov_iter *i, size_t bytes);
+size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t bytes);
 size_t iov_iter_single_seg_count(const struct iov_iter *i);
 size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 92d877a698f0..c0fa1618561c 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -432,33 +432,44 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
 }
 
 /*
+ * fault_in_iov_iter_readable - fault in iov iterator for reading
+ * @i: iterator
+ * @size: maximum length
+ *
  * Fault in one or more iovecs of the given iov_iter, to a maximum length of
- * bytes.  For each iovec, fault in each page that constitutes the iovec.
+ * @size.  For each iovec, fault in each page that constitutes the iovec.
+ *
+ * Returns the number of bytes faulted in, or 0 if no bytes could be faulted in
+ * (i.e., because the address is invalid).
  *
- * Return 0 on success, or non-zero if the memory could not be accessed (i.e.
- * because it is an invalid address).
+ * Always returns the number of avaliable bytes for non-user space iterators.
  */
-int iov_iter_fault_in_readable(const struct iov_iter *i, size_t bytes)
+size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t size)
 {
+	if (size > i->count)
+		size = i->count;
+
 	if (iter_is_iovec(i)) {
 		const struct iovec *p;
+		size_t bytes = size;
 		size_t skip;
 
-		if (bytes > i->count)
-			bytes = i->count;
 		for (p = i->iov, skip = i->iov_offset; bytes; p++, skip = 0) {
 			size_t len = min(bytes, p->iov_len - skip);
+			size_t ret;
 
 			if (unlikely(!len))
 				continue;
-			if (fault_in_readable(p->iov_base + skip, len) != len)
-				return -EFAULT;
-			bytes -= len;
+			ret = fault_in_readable(p->iov_base + skip, len);
+			bytes -= ret;
+			if (ret != len)
+				break;
 		}
+		return size - bytes;
 	}
-	return 0;
+	return size;
 }
-EXPORT_SYMBOL(iov_iter_fault_in_readable);
+EXPORT_SYMBOL(fault_in_iov_iter_readable);
 
 void iov_iter_init(struct iov_iter *i, unsigned int direction,
 			const struct iovec *iov, unsigned long nr_segs,
diff --git a/mm/filemap.c b/mm/filemap.c
index 4dec3bc7752e..5f5aed060c9e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3643,7 +3643,7 @@ ssize_t generic_perform_write(struct file *file,
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
+		if (unlikely(fault_in_iov_iter_readable(i, bytes) != bytes)) {
 			status = -EFAULT;
 			break;
 		}
-- 
2.26.3

