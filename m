Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1134646569B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 20:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352740AbhLATlX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 14:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245282AbhLATlV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:41:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251BFC061574;
        Wed,  1 Dec 2021 11:38:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A470EB8211D;
        Wed,  1 Dec 2021 19:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F43C53FCF;
        Wed,  1 Dec 2021 19:37:54 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/4] mm: Introduce a 'min_size' argument to fault_in_*()
Date:   Wed,  1 Dec 2021 19:37:47 +0000
Message-Id: <20211201193750.2097885-2-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201193750.2097885-1-catalin.marinas@arm.com>
References: <20211201193750.2097885-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no functional change after this patch as all callers pass a
min_size of 0. This argument will be used in subsequent patches to probe
for faults at sub-page granularity (e.g. arm64 MTE and SPARC ADI).

With a non-zero 'min_size' argument, the fault_in_*() functions return
the full range if they don't manage to fault in the minimum size.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/powerpc/kernel/kvm.c           |  2 +-
 arch/powerpc/kernel/signal_32.c     |  4 ++--
 arch/powerpc/kernel/signal_64.c     |  2 +-
 arch/x86/kernel/fpu/signal.c        |  2 +-
 drivers/gpu/drm/armada/armada_gem.c |  2 +-
 fs/btrfs/file.c                     |  6 ++---
 fs/btrfs/ioctl.c                    |  2 +-
 fs/f2fs/file.c                      |  2 +-
 fs/fuse/file.c                      |  2 +-
 fs/gfs2/file.c                      |  8 +++----
 fs/iomap/buffered-io.c              |  2 +-
 fs/ntfs/file.c                      |  2 +-
 fs/ntfs3/file.c                     |  2 +-
 include/linux/pagemap.h             |  8 ++++---
 include/linux/uio.h                 |  6 +++--
 lib/iov_iter.c                      | 28 +++++++++++++++++++-----
 mm/filemap.c                        |  2 +-
 mm/gup.c                            | 34 ++++++++++++++++++++---------
 18 files changed, 75 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 6568823cf306..7a7fb08df4c4 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -670,7 +670,7 @@ static void __init kvm_use_magic_page(void)
 
 	/* Quick self-test to see if the mapping works */
 	if (fault_in_readable((const char __user *)KVM_MAGIC_PAGE,
-			      sizeof(u32))) {
+			      sizeof(u32), 0)) {
 		kvm_patching_worked = false;
 		return;
 	}
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 3e053e2fd6b6..7c817881d418 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1048,7 +1048,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	if (new_ctx == NULL)
 		return 0;
 	if (!access_ok(new_ctx, ctx_size) ||
-	    fault_in_readable((char __user *)new_ctx, ctx_size))
+	    fault_in_readable((char __user *)new_ctx, ctx_size, 0))
 		return -EFAULT;
 
 	/*
@@ -1239,7 +1239,7 @@ SYSCALL_DEFINE3(debug_setcontext, struct ucontext __user *, ctx,
 #endif
 
 	if (!access_ok(ctx, sizeof(*ctx)) ||
-	    fault_in_readable((char __user *)ctx, sizeof(*ctx)))
+	    fault_in_readable((char __user *)ctx, sizeof(*ctx), 0))
 		return -EFAULT;
 
 	/*
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index d1e1fc0acbea..732fa4e10d24 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -688,7 +688,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	if (new_ctx == NULL)
 		return 0;
 	if (!access_ok(new_ctx, ctx_size) ||
-	    fault_in_readable((char __user *)new_ctx, ctx_size))
+	    fault_in_readable((char __user *)new_ctx, ctx_size, 0))
 		return -EFAULT;
 
 	/*
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index d5958278eba6..c9bd217e3364 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -309,7 +309,7 @@ static bool restore_fpregs_from_user(void __user *buf, u64 xrestore,
 		if (ret != X86_TRAP_PF)
 			return false;
 
-		if (!fault_in_readable(buf, size))
+		if (!fault_in_readable(buf, size, 0))
 			goto retry;
 		return false;
 	}
diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index 147abf1a3968..0f44219c0120 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -351,7 +351,7 @@ int armada_gem_pwrite_ioctl(struct drm_device *dev, void *data,
 	if (!access_ok(ptr, args->size))
 		return -EFAULT;
 
-	if (fault_in_readable(ptr, args->size))
+	if (fault_in_readable(ptr, args->size, 0))
 		return -EFAULT;
 
 	dobj = armada_gem_object_lookup(file, args->handle);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 11204dbbe053..96ac4b186b72 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1718,7 +1718,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		 * Fault pages before locking them in prepare_pages
 		 * to avoid recursive lock
 		 */
-		if (unlikely(fault_in_iov_iter_readable(i, write_bytes))) {
+		if (unlikely(fault_in_iov_iter_readable(i, write_bytes, 0))) {
 			ret = -EFAULT;
 			break;
 		}
@@ -2021,7 +2021,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		if (left == prev_left) {
 			err = -ENOTBLK;
 		} else {
-			fault_in_iov_iter_readable(from, left);
+			fault_in_iov_iter_readable(from, left, 0);
 			prev_left = left;
 			goto again;
 		}
@@ -3772,7 +3772,7 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 			 * the first time we are retrying. Fault in as many pages
 			 * as possible and retry.
 			 */
-			fault_in_iov_iter_writeable(to, left);
+			fault_in_iov_iter_writeable(to, left, 0);
 			prev_left = left;
 			goto again;
 		}
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 92138ac2a4e2..c7d74c8776a1 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2223,7 +2223,7 @@ static noinline int search_ioctl(struct inode *inode,
 
 	while (1) {
 		ret = -EFAULT;
-		if (fault_in_writeable(ubuf + sk_offset, *buf_size - sk_offset))
+		if (fault_in_writeable(ubuf + sk_offset, *buf_size - sk_offset, 0))
 			break;
 
 		ret = btrfs_search_forward(root, &key, path, sk->min_transid);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 92ec2699bc85..fb6eceac0d57 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4276,7 +4276,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		size_t target_size = 0;
 		int err;
 
-		if (fault_in_iov_iter_readable(from, iov_iter_count(from)))
+		if (fault_in_iov_iter_readable(from, iov_iter_count(from), 0))
 			set_inode_flag(inode, FI_NO_PREALLOC);
 
 		if ((iocb->ki_flags & IOCB_NOWAIT)) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9d6c5f6361f7..c823b9f70215 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1162,7 +1162,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
  again:
 		err = -EFAULT;
-		if (fault_in_iov_iter_readable(ii, bytes))
+		if (fault_in_iov_iter_readable(ii, bytes, 0))
 			break;
 
 		err = -ENOMEM;
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 3e718cfc19a7..f7bd3bfd0690 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -847,7 +847,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
 		size_t leftover;
 
 		gfs2_holder_allow_demote(gh);
-		leftover = fault_in_iov_iter_writeable(to, window_size);
+		leftover = fault_in_iov_iter_writeable(to, window_size, 0);
 		gfs2_holder_disallow_demote(gh);
 		if (leftover != window_size) {
 			if (!gfs2_holder_queued(gh))
@@ -916,7 +916,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 		size_t leftover;
 
 		gfs2_holder_allow_demote(gh);
-		leftover = fault_in_iov_iter_readable(from, window_size);
+		leftover = fault_in_iov_iter_readable(from, window_size, 0);
 		gfs2_holder_disallow_demote(gh);
 		if (leftover != window_size) {
 			if (!gfs2_holder_queued(gh))
@@ -985,7 +985,7 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		size_t leftover;
 
 		gfs2_holder_allow_demote(&gh);
-		leftover = fault_in_iov_iter_writeable(to, window_size);
+		leftover = fault_in_iov_iter_writeable(to, window_size, 0);
 		gfs2_holder_disallow_demote(&gh);
 		if (leftover != window_size) {
 			if (!gfs2_holder_queued(&gh)) {
@@ -1063,7 +1063,7 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 		size_t leftover;
 
 		gfs2_holder_allow_demote(gh);
-		leftover = fault_in_iov_iter_readable(from, window_size);
+		leftover = fault_in_iov_iter_readable(from, window_size, 0);
 		gfs2_holder_disallow_demote(gh);
 		if (leftover != window_size) {
 			from->count = min(from->count, window_size - leftover);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1753c26c8e76..e7a529405775 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -750,7 +750,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		if (unlikely(fault_in_iov_iter_readable(i, bytes))) {
+		if (unlikely(fault_in_iov_iter_readable(i, bytes, 0))) {
 			status = -EFAULT;
 			break;
 		}
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 2ae25e48a41a..441aeefda8b6 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1830,7 +1830,7 @@ static ssize_t ntfs_perform_write(struct file *file, struct iov_iter *i,
 		 * pages being swapped out between us bringing them into memory
 		 * and doing the actual copying.
 		 */
-		if (unlikely(fault_in_iov_iter_readable(i, bytes))) {
+		if (unlikely(fault_in_iov_iter_readable(i, bytes, 0))) {
 			status = -EFAULT;
 			break;
 		}
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 787b53b984ee..208686bda052 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -990,7 +990,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		frame_vbo = pos & ~(frame_size - 1);
 		index = frame_vbo >> PAGE_SHIFT;
 
-		if (unlikely(fault_in_iov_iter_readable(from, bytes))) {
+		if (unlikely(fault_in_iov_iter_readable(from, bytes, 0))) {
 			err = -EFAULT;
 			goto out;
 		}
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1a0c646eb6ff..79d328031247 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -909,9 +909,11 @@ void folio_add_wait_queue(struct folio *folio, wait_queue_entry_t *waiter);
 /*
  * Fault in userspace address range.
  */
-size_t fault_in_writeable(char __user *uaddr, size_t size);
-size_t fault_in_safe_writeable(const char __user *uaddr, size_t size);
-size_t fault_in_readable(const char __user *uaddr, size_t size);
+size_t fault_in_writeable(char __user *uaddr, size_t size, size_t min_size);
+size_t fault_in_safe_writeable(const char __user *uaddr, size_t size,
+			       size_t min_size);
+size_t fault_in_readable(const char __user *uaddr, size_t size,
+			 size_t min_size);
 
 int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
 		pgoff_t index, gfp_t gfp);
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 6350354f97e9..06c54c3ab3f8 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -134,8 +134,10 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
 				  size_t bytes, struct iov_iter *i);
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
 void iov_iter_revert(struct iov_iter *i, size_t bytes);
-size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t bytes);
-size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t bytes);
+size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t bytes,
+				  size_t min_size);
+size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t bytes,
+				   size_t min_size);
 size_t iov_iter_single_seg_count(const struct iov_iter *i);
 size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 66a740e6e153..ecb95bb5c423 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -191,7 +191,7 @@ static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t b
 	buf = iov->iov_base + skip;
 	copy = min(bytes, iov->iov_len - skip);
 
-	if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_writeable(buf, copy)) {
+	if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_writeable(buf, copy, 0)) {
 		kaddr = kmap_atomic(page);
 		from = kaddr + offset;
 
@@ -275,7 +275,7 @@ static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t
 	buf = iov->iov_base + skip;
 	copy = min(bytes, iov->iov_len - skip);
 
-	if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_readable(buf, copy)) {
+	if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_readable(buf, copy, 0)) {
 		kaddr = kmap_atomic(page);
 		to = kaddr + offset;
 
@@ -433,6 +433,7 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
  * fault_in_iov_iter_readable - fault in iov iterator for reading
  * @i: iterator
  * @size: maximum length
+ * @min_size: minimum size to be faulted in
  *
  * Fault in one or more iovecs of the given iov_iter, to a maximum length of
  * @size.  For each iovec, fault in each page that constitutes the iovec.
@@ -442,25 +443,32 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
  *
  * Always returns 0 for non-userspace iterators.
  */
-size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t size)
+size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t size,
+				  size_t min_size)
 {
 	if (iter_is_iovec(i)) {
 		size_t count = min(size, iov_iter_count(i));
 		const struct iovec *p;
 		size_t skip;
+		size_t orig_size = size;
 
 		size -= count;
 		for (p = i->iov, skip = i->iov_offset; count; p++, skip = 0) {
 			size_t len = min(count, p->iov_len - skip);
+			size_t min_len = min(len, min_size);
 			size_t ret;
 
 			if (unlikely(!len))
 				continue;
-			ret = fault_in_readable(p->iov_base + skip, len);
+			ret = fault_in_readable(p->iov_base + skip, len,
+						min_len);
 			count -= len - ret;
+			min_size -= min(min_size, len - ret);
 			if (ret)
 				break;
 		}
+		if (min_size)
+			return orig_size;
 		return count + size;
 	}
 	return 0;
@@ -471,6 +479,7 @@ EXPORT_SYMBOL(fault_in_iov_iter_readable);
  * fault_in_iov_iter_writeable - fault in iov iterator for writing
  * @i: iterator
  * @size: maximum length
+ * @min_size: minimum size to be faulted in
  *
  * Faults in the iterator using get_user_pages(), i.e., without triggering
  * hardware page faults.  This is primarily useful when we already know that
@@ -481,25 +490,32 @@ EXPORT_SYMBOL(fault_in_iov_iter_readable);
  *
  * Always returns 0 for non-user-space iterators.
  */
-size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t size)
+size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t size,
+				   size_t min_size)
 {
 	if (iter_is_iovec(i)) {
 		size_t count = min(size, iov_iter_count(i));
 		const struct iovec *p;
 		size_t skip;
+		size_t orig_size = size;
 
 		size -= count;
 		for (p = i->iov, skip = i->iov_offset; count; p++, skip = 0) {
 			size_t len = min(count, p->iov_len - skip);
+			size_t min_len = min(len, min_size);
 			size_t ret;
 
 			if (unlikely(!len))
 				continue;
-			ret = fault_in_safe_writeable(p->iov_base + skip, len);
+			ret = fault_in_safe_writeable(p->iov_base + skip, len,
+						      min_len);
 			count -= len - ret;
+			min_size -= min(min_size, len - ret);
 			if (ret)
 				break;
 		}
+		if (min_size)
+			return orig_size;
 		return count + size;
 	}
 	return 0;
diff --git a/mm/filemap.c b/mm/filemap.c
index daa0e23a6ee6..e5d7f5b1e5cc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3743,7 +3743,7 @@ ssize_t generic_perform_write(struct file *file,
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		if (unlikely(fault_in_iov_iter_readable(i, bytes))) {
+		if (unlikely(fault_in_iov_iter_readable(i, bytes, 0))) {
 			status = -EFAULT;
 			break;
 		}
diff --git a/mm/gup.c b/mm/gup.c
index 2c51e9748a6a..baa8240615a4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1662,13 +1662,15 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
  * fault_in_writeable - fault in userspace address range for writing
  * @uaddr: start of address range
  * @size: size of address range
+ * @min_size: minimum size to be faulted in
  *
  * Returns the number of bytes not faulted in (like copy_to_user() and
  * copy_from_user()).
  */
-size_t fault_in_writeable(char __user *uaddr, size_t size)
+size_t fault_in_writeable(char __user *uaddr, size_t size, size_t min_size)
 {
 	char __user *start = uaddr, *end;
+	size_t faulted_in = size;
 
 	if (unlikely(size == 0))
 		return 0;
@@ -1688,8 +1690,10 @@ size_t fault_in_writeable(char __user *uaddr, size_t size)
 
 out:
 	if (size > uaddr - start)
-		return size - (uaddr - start);
-	return 0;
+		faulted_in = uaddr - start;
+	if (faulted_in < min_size)
+		return size;
+	return size - faulted_in;
 }
 EXPORT_SYMBOL(fault_in_writeable);
 
@@ -1697,6 +1701,7 @@ EXPORT_SYMBOL(fault_in_writeable);
  * fault_in_safe_writeable - fault in an address range for writing
  * @uaddr: start of address range
  * @size: length of address range
+ * @min_size: minimum size to be faulted in
  *
  * Faults in an address range using get_user_pages, i.e., without triggering
  * hardware page faults.  This is primarily useful when we already know that
@@ -1711,13 +1716,15 @@ EXPORT_SYMBOL(fault_in_writeable);
  * Returns the number of bytes not faulted in, like copy_to_user() and
  * copy_from_user().
  */
-size_t fault_in_safe_writeable(const char __user *uaddr, size_t size)
+size_t fault_in_safe_writeable(const char __user *uaddr, size_t size,
+			       size_t min_size)
 {
 	unsigned long start = (unsigned long)untagged_addr(uaddr);
 	unsigned long end, nstart, nend;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	int locked = 0;
+	size_t faulted_in = size;
 
 	nstart = start & PAGE_MASK;
 	end = PAGE_ALIGN(start + size);
@@ -1750,9 +1757,11 @@ size_t fault_in_safe_writeable(const char __user *uaddr, size_t size)
 	}
 	if (locked)
 		mmap_read_unlock(mm);
-	if (nstart == end)
-		return 0;
-	return size - min_t(size_t, nstart - start, size);
+	if (nstart != end)
+		faulted_in = min_t(size_t, nstart - start, size);
+	if (faulted_in < min_size)
+		return size;
+	return size - faulted_in;
 }
 EXPORT_SYMBOL(fault_in_safe_writeable);
 
@@ -1760,14 +1769,17 @@ EXPORT_SYMBOL(fault_in_safe_writeable);
  * fault_in_readable - fault in userspace address range for reading
  * @uaddr: start of user address range
  * @size: size of user address range
+ * @min_size: minimum size to be faulted in
  *
  * Returns the number of bytes not faulted in (like copy_to_user() and
  * copy_from_user()).
  */
-size_t fault_in_readable(const char __user *uaddr, size_t size)
+size_t fault_in_readable(const char __user *uaddr, size_t size,
+			 size_t min_size)
 {
 	const char __user *start = uaddr, *end;
 	volatile char c;
+	size_t faulted_in = size;
 
 	if (unlikely(size == 0))
 		return 0;
@@ -1788,8 +1800,10 @@ size_t fault_in_readable(const char __user *uaddr, size_t size)
 out:
 	(void)c;
 	if (size > uaddr - start)
-		return size - (uaddr - start);
-	return 0;
+		faulted_in = uaddr - start;
+	if (faulted_in < min_size)
+		return size;
+	return size - faulted_in;
 }
 EXPORT_SYMBOL(fault_in_readable);
 
