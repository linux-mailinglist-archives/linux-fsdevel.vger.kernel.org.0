Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2CF442DF3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 13:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhKBMcz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 08:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231527AbhKBMcp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635856210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/UbEKOEjuEBf0ESv+4xLl4syhrRMqk6/DeGkUllIat0=;
        b=F7e9ZF4w+k8Ci2utLhPo2qeD9H7JiGpoPljutQleMVyMPz19aHaoNVlbwJOHzugMnURUks
        bNGLmDKHp7eGtcioPSKMUIhhY+CBSzXhgR1Uqj129cwD2ZfkLQC9yHrUPAMVVgz/z3+E+5
        CY2q/5S9f506FvkM8bL8VFBc+PLWg+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-_GbDSNK3MYyEn1lSYl_MOw-1; Tue, 02 Nov 2021 08:30:07 -0400
X-MC-Unique: _GbDSNK3MYyEn1lSYl_MOw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 599E880A5C0;
        Tue,  2 Nov 2021 12:30:05 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.195.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3276819811;
        Tue,  2 Nov 2021 12:30:02 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v9 04/17] iov_iter: Turn iov_iter_fault_in_readable into fault_in_iov_iter_readable
Date:   Tue,  2 Nov 2021 13:29:32 +0100
Message-Id: <20211102122945.117744-5-agruenba@redhat.com>
In-Reply-To: <20211102122945.117744-1-agruenba@redhat.com>
References: <20211102122945.117744-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Turn iov_iter_fault_in_readable into a function that returns the number
of bytes not faulted in, similar to copy_to_user, instead of returning a
non-zero value when any of the requested pages couldn't be faulted in.
This supports the existing users that require all pages to be faulted in
as well as new users that are happy if any pages can be faulted in.

Rename iov_iter_fault_in_readable to fault_in_iov_iter_readable to make
sure this change doesn't silently break things.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/btrfs/file.c        |  2 +-
 fs/f2fs/file.c         |  2 +-
 fs/fuse/file.c         |  2 +-
 fs/iomap/buffered-io.c |  2 +-
 fs/ntfs/file.c         |  2 +-
 fs/ntfs3/file.c        |  2 +-
 include/linux/uio.h    |  2 +-
 lib/iov_iter.c         | 33 +++++++++++++++++++++------------
 mm/filemap.c           |  2 +-
 9 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7ff577005d0f..f37211d3bb69 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1710,7 +1710,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		 * Fault pages before locking them in prepare_pages
 		 * to avoid recursive lock
 		 */
-		if (unlikely(iov_iter_fault_in_readable(i, write_bytes))) {
+		if (unlikely(fault_in_iov_iter_readable(i, write_bytes))) {
 			ret = -EFAULT;
 			break;
 		}
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9c8ef33bd8d3..eb971e1e7227 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4276,7 +4276,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		size_t target_size = 0;
 		int err;
 
-		if (iov_iter_fault_in_readable(from, iov_iter_count(from)))
+		if (fault_in_iov_iter_readable(from, iov_iter_count(from)))
 			set_inode_flag(inode, FI_NO_PREALLOC);
 
 		if ((iocb->ki_flags & IOCB_NOWAIT)) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 11404f8c21c7..4b6d8e13322d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1164,7 +1164,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
  again:
 		err = -EFAULT;
-		if (iov_iter_fault_in_readable(ii, bytes))
+		if (fault_in_iov_iter_readable(ii, bytes))
 			break;
 
 		err = -ENOMEM;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9cc5798423d1..1753c26c8e76 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -750,7 +750,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
+		if (unlikely(fault_in_iov_iter_readable(i, bytes))) {
 			status = -EFAULT;
 			break;
 		}
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index ab4f3362466d..a43adeacd930 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1829,7 +1829,7 @@ static ssize_t ntfs_perform_write(struct file *file, struct iov_iter *i,
 		 * pages being swapped out between us bringing them into memory
 		 * and doing the actual copying.
 		 */
-		if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
+		if (unlikely(fault_in_iov_iter_readable(i, bytes))) {
 			status = -EFAULT;
 			break;
 		}
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 424450e77ad5..a52388387175 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -987,7 +987,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		frame_vbo = pos & ~(frame_size - 1);
 		index = frame_vbo >> PAGE_SHIFT;
 
-		if (unlikely(iov_iter_fault_in_readable(from, bytes))) {
+		if (unlikely(fault_in_iov_iter_readable(from, bytes))) {
 			err = -EFAULT;
 			goto out;
 		}
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 207101a9c5c3..d18458af6681 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -133,7 +133,7 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
 				  size_t bytes, struct iov_iter *i);
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
 void iov_iter_revert(struct iov_iter *i, size_t bytes);
-int iov_iter_fault_in_readable(const struct iov_iter *i, size_t bytes);
+size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t bytes);
 size_t iov_iter_single_seg_count(const struct iov_iter *i);
 size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index c88908f0f138..ce3d4f610626 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -430,33 +430,42 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
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
+ * Returns the number of bytes not faulted in (like copy_to_user() and
+ * copy_from_user()).
  *
- * Return 0 on success, or non-zero if the memory could not be accessed (i.e.
- * because it is an invalid address).
+ * Always returns 0 for non-userspace iterators.
  */
-int iov_iter_fault_in_readable(const struct iov_iter *i, size_t bytes)
+size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t size)
 {
 	if (iter_is_iovec(i)) {
+		size_t count = min(size, iov_iter_count(i));
 		const struct iovec *p;
 		size_t skip;
 
-		if (bytes > i->count)
-			bytes = i->count;
-		for (p = i->iov, skip = i->iov_offset; bytes; p++, skip = 0) {
-			size_t len = min(bytes, p->iov_len - skip);
+		size -= count;
+		for (p = i->iov, skip = i->iov_offset; count; p++, skip = 0) {
+			size_t len = min(count, p->iov_len - skip);
+			size_t ret;
 
 			if (unlikely(!len))
 				continue;
-			if (fault_in_readable(p->iov_base + skip, len))
-				return -EFAULT;
-			bytes -= len;
+			ret = fault_in_readable(p->iov_base + skip, len);
+			count -= len - ret;
+			if (ret)
+				break;
 		}
+		return count + size;
 	}
 	return 0;
 }
-EXPORT_SYMBOL(iov_iter_fault_in_readable);
+EXPORT_SYMBOL(fault_in_iov_iter_readable);
 
 void iov_iter_init(struct iov_iter *i, unsigned int direction,
 			const struct iovec *iov, unsigned long nr_segs,
diff --git a/mm/filemap.c b/mm/filemap.c
index ff34f4087f87..4dd5edcd39fd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3757,7 +3757,7 @@ ssize_t generic_perform_write(struct file *file,
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
+		if (unlikely(fault_in_iov_iter_readable(i, bytes))) {
 			status = -EFAULT;
 			break;
 		}
-- 
2.31.1

