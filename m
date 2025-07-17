Return-Path: <linux-fsdevel+bounces-55337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A32BB09811
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6EE1769D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B8E2522A7;
	Thu, 17 Jul 2025 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/CcvsC+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628E2459F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795140; cv=none; b=PlsSBHnzAw6e1f3U+ym6fyKZZOig9M+ndXJg1LdrtNvF2OD5O9Ju64hHLYo/kT7F9OVhShvmx4P0fsxIKqZNhJXT/kI70VYp9COyhKb35lcCQkktJR5UZxPjoDzX95Kjy07PVay8gPfEtsAySPKOZgtfIEeNviQFSdN8jn0dVy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795140; c=relaxed/simple;
	bh=WKPc7i964T6SGpMd2RjqyiHKLxEa7/5BVsSpvOrI1UA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fKW6/f/074cG96ZBMn4K1mfaUa0D4lNeUwytI3+sa8FfHu3TpXMLP41NY7PMEIIoiKg9m1eoeUJu4sb32CRqU1RlAYnP0zsYrnm9wrbgViNzPwhc380AlL9Q82p8yMOQYh+CmjiYSO0VYeD7cWzXot/YIS2cKd3NOuinCDysJBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/CcvsC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51272C4CEE3;
	Thu, 17 Jul 2025 23:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795140;
	bh=WKPc7i964T6SGpMd2RjqyiHKLxEa7/5BVsSpvOrI1UA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=l/CcvsC+Hnm1xtEzKf3ZnX+xzdaFiJHVaLarXxza+7aPdI+ELr2Vt4sZTissBXN3b
	 XA3jGedj7VWLbZo5EK2J/2GNGh4kVgS5dmOdcO6ek0aNthn2NnK2fBKhIyr3qAGJyF
	 oYWmulJ9fC4KKM1tTM4UwYjeaS2AoWsaC0sNUa3NK+aQP7hKVg58UQIIRDXq51y1XX
	 x3FMvz+jTlSKLeidzyF8SWwC6TVF7nLa5qjIE7ZtMob3rNvQwaHPBezlEOQPxAU1rj
	 pfbvsEQeUm2mUrmsHM/VQt4DfDlWIjlIdNqFCogLpIeB5zrZ+Jjp1B0OYhdjRNbqC1
	 muZR2Ikny8ccg==
Date: Thu, 17 Jul 2025 16:32:19 -0700
Subject: [PATCH 3/4] fuse: invalidate iomap cache after file updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450507.713483.2894484469298978641.stgit@frogsfrogsfrogs>
In-Reply-To: <175279450420.713483.16534356247856109745.stgit@frogsfrogsfrogs>
References: <175279450420.713483.16534356247856109745.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_i.h      |   16 +++++++++++++
 fs/fuse/fuse_trace.h  |   59 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c        |   10 ++++++--
 fs/fuse/file_iomap.c  |   42 ++++++++++++++++++++++++++++++++++-
 fs/fuse/iomap_cache.c |   29 ++++++++++++++++++++++++
 5 files changed, 152 insertions(+), 4 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 196d2b57e80bb1..3b51aa6b50b8ab 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1735,6 +1735,9 @@ int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
 			 loff_t length, loff_t new_size);
 int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 				 loff_t endpos);
+void fuse_iomap_open_truncate(struct inode *inode);
+void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
+				  size_t written);
 
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
@@ -1799,6 +1802,15 @@ fuse_iomap_cache_lookup(struct inode *inode,
 			enum fuse_iomap_fork whichfork,
 			loff_t off, uint64_t len,
 			struct fuse_iomap *mval);
+
+int fuse_iomap_cache_invalidate_range(struct inode *inode, loff_t offset,
+				      uint64_t length);
+static inline int fuse_iomap_cache_invalidate(struct inode *inode,
+					      loff_t offset)
+{
+	return fuse_iomap_cache_invalidate_range(inode, offset,
+						 FUSE_IOMAP_INVAL_TO_EOF);
+}
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1826,12 +1838,16 @@ fuse_iomap_cache_lookup(struct inode *inode,
 # define fuse_iomap_set_i_blkbits(...)		((void)0)
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
+# define fuse_iomap_open_truncate(...)		((void)0)
+# define fuse_iomap_copied_file_range(...)	((void)0)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 # define fuse_iomap_fadvise			NULL
 # define fuse_has_iomap_cache(...)		(false)
 # define fuse_iomap_cache_remove(...)		(-ENOSYS)
 # define fuse_iomap_cache_add(...)		(-ENOSYS)
 # define fuse_iomap_cache_upsert(...)		(-ENOSYS)
+# define fuse_iomap_cache_invalidate_range(...)	(-ENOSYS)
+# define fuse_iomap_cache_invalidate(...)	(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 88f1dd2ccbc9d5..547c548163ab54 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -1151,6 +1151,7 @@ DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_truncate_down);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_punch_range);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_setsize);
 DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_flush_unmap_range);
+DEFINE_FUSE_IOMAP_FILE_RANGE_EVENT(fuse_iomap_cache_invalidate_range);
 
 TRACE_EVENT(fuse_iomap_set_i_blkbits,
 	TP_PROTO(const struct inode *inode, u8 new_blkbits),
@@ -1314,6 +1315,64 @@ DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_inline_write);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_iomap);
 DEFINE_FUSE_IOMAP_INLINE_EVENT(fuse_iomap_set_inline_srcmap);
 
+TRACE_EVENT(fuse_iomap_open_truncate,
+	TP_PROTO(const struct inode *inode),
+
+	TP_ARGS(inode),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize)
+);
+
+TRACE_EVENT(fuse_iomap_copied_file_range,
+	TP_PROTO(const struct inode *inode, loff_t offset,
+		 size_t written),
+	TP_ARGS(inode, offset, written),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
+		__field(loff_t,		offset)
+		__field(size_t,		written)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->offset		=	offset;
+		__entry->written	=	written;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx offset 0x%llx written 0x%zx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->offset, __entry->written)
+);
+
 DECLARE_EVENT_CLASS(fuse_iomap_cache_lock_class,
 	TP_PROTO(const struct inode *inode, unsigned int lock_flags,
 		 unsigned long caller_ip),
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 78e776878427e3..b390041f5c6659 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -278,9 +278,11 @@ static int fuse_open(struct inode *inode, struct file *file)
 	if (is_wb_truncate || dax_truncate)
 		fuse_release_nowrite(inode);
 	if (!err) {
-		if (is_truncate)
+		if (is_truncate) {
 			truncate_pagecache(inode, 0);
-		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
+			if (fuse_has_iomap_fileio(inode))
+				fuse_iomap_open_truncate(inode);
+		} else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
 			invalidate_inode_pages2(inode->i_mapping);
 	}
 	if (dax_truncate)
@@ -3181,7 +3183,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (err)
 		goto out;
 
-	if (!fuse_has_iomap_fileio(inode_out))
+	if (fuse_has_iomap_fileio(inode_out))
+		fuse_iomap_copied_file_range(inode_out, pos_out, outarg.size);
+	else
 		truncate_inode_pages_range(inode_out->i_mapping,
 				   ALIGN_DOWN(pos_out, PAGE_SIZE),
 				   ALIGN(pos_out + outarg.size, PAGE_SIZE) - 1);
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 122860af4bc42f..bffadbf5660bff 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -864,6 +864,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 			fuse_iomap_inline_free(iomap);
 			if (err)
 				goto out_err;
+			fuse_iomap_cache_invalidate_range(inode, pos, written);
 		} else {
 			fuse_iomap_inline_free(iomap);
 		}
@@ -938,6 +939,13 @@ static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
 
 	trace_fuse_iomap_ioend_error(inode, &inarg, err);
 
+	/*
+	 * If the ioend completed successfully, invalidate the range that we
+	 * just completed.
+	 */
+	if (!err)
+		fuse_iomap_cache_invalidate_range(inode, pos, written);
+
 	/*
 	 * Preserve the original error code if userspace didn't respond or
 	 * returned success despite the error we passed along via the ioend.
@@ -2122,7 +2130,10 @@ fuse_iomap_setsize(
 	error = inode_newsize_ok(inode, newsize);
 	if (error)
 		return error;
-	return fuse_iomap_setattr_size(inode, newsize);
+	error = fuse_iomap_setattr_size(inode, newsize);
+	if (error)
+		return error;
+	return fuse_iomap_cache_invalidate(inode, newsize);
 }
 
 /*
@@ -2233,6 +2244,14 @@ fuse_iomap_fallocate(
 
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
@@ -2293,3 +2312,24 @@ int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice)
 		inode_unlock_shared(inode);
 	return ret;
 }
+
+void fuse_iomap_open_truncate(struct inode *inode)
+{
+	ASSERT(fuse_has_iomap(inode));
+	ASSERT(fuse_has_iomap_fileio(inode));
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
+	ASSERT(fuse_has_iomap_fileio(inode));
+
+	trace_fuse_iomap_copied_file_range(inode, offset, written);
+
+	fuse_iomap_cache_invalidate_range(inode, offset, written);
+}
diff --git a/fs/fuse/iomap_cache.c b/fs/fuse/iomap_cache.c
index 239441d2903cc8..87f03d8c9a76aa 100644
--- a/fs/fuse/iomap_cache.c
+++ b/fs/fuse/iomap_cache.c
@@ -1427,6 +1427,35 @@ fuse_iomap_cache_remove(
 	return ret;
 }
 
+int fuse_iomap_cache_invalidate_range(struct inode *inode, loff_t offset,
+				      uint64_t length)
+{
+	loff_t aligned_offset;
+	const unsigned int blocksize = i_blocksize(inode);
+	int ret, ret2;
+
+	if (!fuse_has_iomap_cache(inode))
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
+	fuse_iomap_cache_lock(inode, FUSE_IOMAP_LOCK_EXCL);
+	ret = fuse_iomap_cache_remove(inode, FUSE_IOMAP_READ_FORK,
+			aligned_offset, length);
+	ret2 = fuse_iomap_cache_remove(inode, FUSE_IOMAP_WRITE_FORK,
+			aligned_offset, length);
+	fuse_iomap_cache_unlock(inode, FUSE_IOMAP_LOCK_EXCL);
+	if (ret)
+		return ret;
+	return ret2;
+}
+
 static void
 fuse_iext_add_mapping(
 	struct fuse_iomap_cache	*ip,


