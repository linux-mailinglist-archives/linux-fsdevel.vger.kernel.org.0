Return-Path: <linux-fsdevel+bounces-58467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F4B2E9DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90151CC33A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5371E7C23;
	Thu, 21 Aug 2025 00:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwHpp7bq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90717190685
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737957; cv=none; b=Ws8zEblJO2h7OEOfvknbMcKDEYGrCmCsq352l2Gy7SJeblK/Tb4CArRpqjOLYezkZjyinRf2PAoLyHsYZar68cfv1N7EnmUWcS5EvvoP8ukBgJUJ/5rRxc7ommfalFGvRWgV+Sstk6OCwUq3zTJn2veNsr910RxuD9HSxRjY2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737957; c=relaxed/simple;
	bh=p7AKgcSTlkfnvSvkNXlfX10OotEp4D/bnPF9K6pCBqo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfov/Xb2eh3nywmv6BfoZ1sL88xFQDyGgqvo7RLEWmhJDee3HPDQ24jAjF0kHvHDgVcHly1Qkw29KPAKCAyZRIBQWME4hxfXj8LV+NDnUMbenabeR5vP+E9XvY6cc+ICelKZBH8M74M/1gaezvBlIZHqTWhsfwgNGJ85/SVLDKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwHpp7bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFCAC4CEE7;
	Thu, 21 Aug 2025 00:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737957;
	bh=p7AKgcSTlkfnvSvkNXlfX10OotEp4D/bnPF9K6pCBqo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ZwHpp7bqWOeOzXrEzNmbq6ktFADqvp+KNynmTr7iF0GaiUPUKv/y5ESV5xjnlcKrn
	 g+ZNKWfz63OqMX26yK4In4IOHUoOr+HYVIsHMNyZQOSLGE5P1lAKsLRDhbR4p2Ljdy
	 uPw+1JV7gfeTOi+08paUcCW3k7etbjKhpTlGN1NLrCKX7biMRYsAam7VzDjbRGJyjh
	 YhG/1on1/X0wZxsGs67HE8ElpXoRfaIJ511zqGcuub4zgm9eOGlenqPa2wi/bH5WhJ
	 +Ok7CxMd0pr7RWBWOg2ER9x+GGEPJRg1QQUIF6Z3C0aEMiZpFfW6j4Fr6wmsfSzD31
	 3JubMsNzh4I9Q==
Date: Wed, 20 Aug 2025 17:59:16 -0700
Subject: [PATCH 3/4] fuse: invalidate iomap cache after file updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709912.18403.3472450651354216948.stgit@frogsfrogsfrogs>
In-Reply-To: <175573709825.18403.10618991015902453439.stgit@frogsfrogsfrogs>
References: <175573709825.18403.10618991015902453439.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The kernel doesn't know what the fuse server might have done in response
to truncate, fallocate, or ioend events.  Therefore, it must invalidate
the mapping cache after those operations to ensure cache coherency.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h      |    7 +++++++
 fs/fuse/fuse_trace.h  |   37 +++++++++++++++++++++++++++++++++++++
 fs/fuse/iomap_priv.h  |    9 +++++++++
 fs/fuse/dir.c         |    6 ++++++
 fs/fuse/file.c        |   10 +++++++---
 fs/fuse/file_iomap.c  |   49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/iomap_cache.c |   29 +++++++++++++++++++++++++++++
 7 files changed, 143 insertions(+), 4 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 54b8aab94a9cd5..0a7192b633dd3a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1769,11 +1769,15 @@ int fuse_iomap_mmap(struct file *file, struct vm_area_struct *vma);
 ssize_t fuse_iomap_buffered_read(struct kiocb *iocb, struct iov_iter *to);
 ssize_t fuse_iomap_buffered_write(struct kiocb *iocb, struct iov_iter *from);
 int fuse_iomap_setsize_start(struct inode *inode, loff_t newsize);
+int fuse_iomap_setsize_finish(struct inode *inode, loff_t newsize);
 void fuse_iomap_set_i_blkbits(struct inode *inode, u8 new_blkbits);
 int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
 			 loff_t length, loff_t new_size);
 int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 				 loff_t endpos);
+void fuse_iomap_open_truncate(struct inode *inode);
+void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
+				  size_t written);
 
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
@@ -1814,9 +1818,12 @@ enum fuse_iomap_iodir {
 # define fuse_iomap_buffered_read(...)		(-ENOSYS)
 # define fuse_iomap_buffered_write(...)		(-ENOSYS)
 # define fuse_iomap_setsize_start(...)		(-ENOSYS)
+# define fuse_iomap_setsize_finish(...)		(-ENOSYS)
 # define fuse_iomap_set_i_blkbits(...)		((void)0)
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
+# define fuse_iomap_open_truncate(...)		((void)0)
+# define fuse_iomap_copied_file_range(...)	((void)0)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 # define fuse_iomap_fadvise			NULL
 # define fuse_inode_caches_iomaps(...)		(false)
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 94e7a4222d2ac2..cd8aa9e0633eee 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -991,6 +991,7 @@ DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_down);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_punch_range);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_setsize);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_flush_unmap_range);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_cache_invalidate_range);
 
 TRACE_EVENT(fuse_iomap_set_i_blkbits,
 	TP_PROTO(const struct inode *inode, u8 new_blkbits),
@@ -1150,6 +1151,42 @@ DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_write);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_iomap);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_srcmap);
 
+TRACE_EVENT(fuse_iomap_open_truncate,
+	TP_PROTO(const struct inode *inode),
+
+	TP_ARGS(inode),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+	),
+
+	TP_printk(FUSE_INODE_FMT,
+		  FUSE_INODE_PRINTK_ARGS)
+);
+
+TRACE_EVENT(fuse_iomap_copied_file_range,
+	TP_PROTO(const struct inode *inode, loff_t offset,
+		 size_t written),
+	TP_ARGS(inode, offset, written),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->length		=	written;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT(),
+		  FUSE_IO_RANGE_PRINTK_ARGS())
+);
+
 DECLARE_EVENT_CLASS(fuse_iext_class,
 	TP_PROTO(const struct inode *inode, const struct fuse_iext_cursor *cur,
 		 int state, unsigned long caller_ip),
diff --git a/fs/fuse/iomap_priv.h b/fs/fuse/iomap_priv.h
index 8f1aef381942b6..e78c49af638e0f 100644
--- a/fs/fuse/iomap_priv.h
+++ b/fs/fuse/iomap_priv.h
@@ -177,6 +177,15 @@ fuse_iomap_cache_lookup(struct inode *inode, enum fuse_iomap_iodir iodir,
 			loff_t off, uint64_t len,
 			struct fuse_iomap_lookup *mval);
 
+int fuse_iomap_cache_invalidate_range(struct inode *inode, loff_t offset,
+				      uint64_t length);
+static inline int fuse_iomap_cache_invalidate(struct inode *inode,
+					      loff_t offset)
+{
+	return fuse_iomap_cache_invalidate_range(inode, offset,
+						 FUSE_IOMAP_INVAL_TO_EOF);
+}
+
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_PRIV_H */
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 305b926b4a589a..05cb79beb8e426 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2187,6 +2187,12 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		goto error;
 	}
 
+	if (fuse_inode_has_iomap(inode) && is_truncate) {
+		err = fuse_iomap_setsize_finish(inode, outarg.attr.size);
+		if (err)
+			goto error;
+	}
+
 	spin_lock(&fi->lock);
 	/* the kernel maintains i_mtime locally */
 	if (trust_local_cmtime) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6575deae7e65f6..701042c04ab733 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -279,9 +279,11 @@ static int fuse_open(struct inode *inode, struct file *file)
 	if (is_wb_truncate || dax_truncate)
 		fuse_release_nowrite(inode);
 	if (!err) {
-		if (is_truncate)
+		if (is_truncate) {
 			truncate_pagecache(inode, 0);
-		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
+			if (fuse_inode_has_iomap(inode))
+				fuse_iomap_open_truncate(inode);
+		} else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
 			invalidate_inode_pages2(inode->i_mapping);
 	}
 	if (dax_truncate)
@@ -3131,7 +3133,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (err)
 		goto out;
 
-	if (!fuse_inode_has_iomap(inode_out))
+	if (fuse_inode_has_iomap(inode_out))
+		fuse_iomap_copied_file_range(inode_out, pos_out, outarg.size);
+	else
 		truncate_inode_pages_range(inode_out->i_mapping,
 				   ALIGN_DOWN(pos_out, PAGE_SIZE),
 				   ALIGN(pos_out + outarg.size, PAGE_SIZE) - 1);
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 706eff6863d0a7..b4a2c4ea00a6f8 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -896,6 +896,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 			fuse_iomap_inline_free(iomap);
 			if (err)
 				return err;
+			fuse_iomap_cache_invalidate_range(inode, pos, written);
 		} else {
 			fuse_iomap_inline_free(iomap);
 		}
@@ -1036,9 +1037,11 @@ static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
 
 	/*
 	 * If there weren't any ioend errors, update the incore isize, which
-	 * confusingly takes the new i_size as "pos".
+	 * confusingly takes the new i_size as "pos".  Invalidate cached
+	 * mappings for the file range that we just completed.
 	 */
 	fuse_write_update_attr(inode, pos + written, written);
+	fuse_iomap_cache_invalidate_range(inode, pos, written);
 	return 0;
 }
 
@@ -2201,6 +2204,19 @@ fuse_iomap_setsize_start(
 	return filemap_write_and_wait(inode->i_mapping);
 }
 
+int
+fuse_iomap_setsize_finish(
+	struct inode		*inode,
+	loff_t			newsize)
+{
+	ASSERT(fuse_has_iomap(inode));
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	trace_fuse_iomap_setsize(inode, newsize, 0);
+
+	return fuse_iomap_cache_invalidate(inode, newsize);
+}
+
 /*
  * Prepare for a file data block remapping operation by flushing and unmapping
  * all pagecache for the entire range.
@@ -2309,6 +2325,14 @@ fuse_iomap_fallocate(
 
 	trace_fuse_iomap_fallocate(inode, mode, offset, length, new_size);
 
+	if (mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE))
+		error = fuse_iomap_cache_invalidate(inode, offset);
+	else
+		error = fuse_iomap_cache_invalidate_range(inode, offset,
+							  length);
+	if (error)
+		return error;
+
 	/*
 	 * If we unmapped blocks from the file range, then we zero the
 	 * pagecache for those regions and push them to disk rather than make
@@ -2326,6 +2350,8 @@ fuse_iomap_fallocate(
 	 */
 	if (new_size) {
 		error = fuse_iomap_setsize_start(inode, new_size);
+		if (!error)
+			error = fuse_iomap_setsize_finish(inode, new_size);
 		if (error)
 			return error;
 
@@ -2415,3 +2441,24 @@ int fuse_iomap_dev_inval(struct fuse_conn *fc,
 	up_read(&fc->killsb);
 	return ret;
 }
+
+void fuse_iomap_open_truncate(struct inode *inode)
+{
+	ASSERT(fuse_has_iomap(inode));
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	trace_fuse_iomap_open_truncate(inode);
+
+	fuse_iomap_cache_invalidate(inode, 0);
+}
+
+void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
+				  size_t written)
+{
+	ASSERT(fuse_has_iomap(inode));
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	trace_fuse_iomap_copied_file_range(inode, offset, written);
+
+	fuse_iomap_cache_invalidate_range(inode, offset, written);
+}
diff --git a/fs/fuse/iomap_cache.c b/fs/fuse/iomap_cache.c
index 572bccf99a97a8..a13eb5eec72415 100644
--- a/fs/fuse/iomap_cache.c
+++ b/fs/fuse/iomap_cache.c
@@ -1412,6 +1412,35 @@ fuse_iomap_cache_remove(
 	return ret;
 }
 
+int fuse_iomap_cache_invalidate_range(struct inode *inode, loff_t offset,
+				      uint64_t length)
+{
+	loff_t aligned_offset;
+	const unsigned int blocksize = i_blocksize(inode);
+	int ret, ret2;
+
+	if (!fuse_inode_caches_iomaps(inode))
+		return 0;
+
+	trace_fuse_iomap_cache_invalidate_range(inode, offset, length);
+
+	aligned_offset = round_down(offset, blocksize);
+	if (length != FUSE_IOMAP_INVAL_TO_EOF) {
+		length += offset - aligned_offset;
+		length = round_up(length, blocksize);
+	}
+
+	fuse_iomap_cache_lock(inode);
+	ret = fuse_iomap_cache_remove(inode, READ_MAPPING,
+				      aligned_offset, length);
+	ret2 = fuse_iomap_cache_remove(inode, WRITE_MAPPING,
+				       aligned_offset, length);
+	fuse_iomap_cache_unlock(inode);
+	if (ret)
+		return ret;
+	return ret2;
+}
+
 static void
 fuse_iext_add_mapping(
 	struct fuse_iomap_cache		*ip,


