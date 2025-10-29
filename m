Return-Path: <linux-fsdevel+bounces-66050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38065C17B10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40231B24FE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50302D6E71;
	Wed, 29 Oct 2025 00:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqteoShF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187052C0F89;
	Wed, 29 Oct 2025 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699450; cv=none; b=drB9pKSIFuwSlR3hYUdsWiZgQJmad4tFUYKCIr1XjTki0hsIe0dkPrYu8E3Xgleg3R/LtjbKOQyWO1k1exqL24wWt9GcEDB+8qn34fS6xR4Ry/v/mxEqIKYU2/jkKvUOzgKWPbF/BbOUeJI1jik041B1yI68mjweyQivgNBk5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699450; c=relaxed/simple;
	bh=C1mrD0QpXHixEUiVfsrP5z/KQxVpuPnCejIDTX/+ca4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLrui1BffE3pbo3XlRKbbNHHG751QKvJywF8/rVggJ8rQuiINYkAicnMM34iRybsqFLPj3B9INMVOJZzOgDC9BSU5g0mpwORL1oyUd7eKKue6rYGY0neRGw0XhYj9z8kcBzBAyM71fPa1GRqvH7kmb33hGanldCR1srpB3MSvq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqteoShF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B34C4CEE7;
	Wed, 29 Oct 2025 00:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699449;
	bh=C1mrD0QpXHixEUiVfsrP5z/KQxVpuPnCejIDTX/+ca4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gqteoShFJxfMf+9mAxJmrUkTt/ALQuXsiqIur5LyaTp+LkcmmHe1zrPvxhRT99q47
	 FZ85TNz36zHbwl4vNp9uy5b56FSE3FwA74bJM9u+jfeistBF9YTnsnaMtSXTzLPdwW
	 IcC2ofGXXx5vCdV7IR0wTMchNsvl8Eg7LssE8TBgC2RgjPjPvs/dmN5aLFKOKOQnpJ
	 J3MfkOpUT6sO/8dqzOZi+cAYe+D9mZsAZj1b+L4CM7BmRzwHK/XkVaB49hWxSjo5xj
	 CdnBRUDmnANjvaRmGT8HBiLKOHefp0BxLnTobq2Qs+k62jKMJ7XFe00/IKBgPQyYNc
	 tA9eH74qZM+SA==
Date: Tue, 28 Oct 2025 17:57:29 -0700
Subject: [PATCH 05/10] fuse: invalidate iomap cache after file updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169812184.1426649.3326330857378130332.stgit@frogsfrogsfrogs>
In-Reply-To: <176169812012.1426649.16037866918992398523.stgit@frogsfrogsfrogs>
References: <176169812012.1426649.16037866918992398523.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_i.h      |    9 +++++++++
 fs/fuse/iomap_i.h     |    9 +++++++++
 fs/fuse/dir.c         |    6 ++++++
 fs/fuse/file.c        |   26 ++++++++++++++++----------
 fs/fuse/file_iomap.c  |   49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/iomap_cache.c |   27 +++++++++++++++++++++++++++
 6 files changed, 115 insertions(+), 11 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c38bc8c239665b..0011503981123b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1834,10 +1834,15 @@ int fuse_iomap_mmap(struct file *file, struct vm_area_struct *vma);
 ssize_t fuse_iomap_buffered_read(struct kiocb *iocb, struct iov_iter *to);
 ssize_t fuse_iomap_buffered_write(struct kiocb *iocb, struct iov_iter *from);
 int fuse_iomap_setsize_start(struct inode *inode, loff_t newsize);
+int fuse_iomap_setsize_finish(struct inode *inode, loff_t newsize);
 int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
 			 loff_t length, loff_t new_size);
 int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 				 loff_t endpos);
+void fuse_iomap_open_truncate(struct inode *inode);
+void fuse_iomap_release_truncate(struct inode *inode);
+void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
+				  size_t written);
 
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
@@ -1879,8 +1884,12 @@ enum fuse_iomap_iodir {
 # define fuse_iomap_buffered_read(...)		(-ENOSYS)
 # define fuse_iomap_buffered_write(...)		(-ENOSYS)
 # define fuse_iomap_setsize_start(...)		(-ENOSYS)
+# define fuse_iomap_setsize_finish(...)		(-ENOSYS)
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
+# define fuse_iomap_open_truncate(...)		((void)0)
+# define fuse_iomap_release_truncate(...)	((void)0)
+# define fuse_iomap_copied_file_range(...)	((void)0)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 # define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
diff --git a/fs/fuse/iomap_i.h b/fs/fuse/iomap_i.h
index f57ee46ab69d06..5a2118d4a30025 100644
--- a/fs/fuse/iomap_i.h
+++ b/fs/fuse/iomap_i.h
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
 
 #endif /* _FS_FUSE_IOMAP_I_H */
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 55a46612e3677c..0e1afe86bae0b4 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2201,6 +2201,12 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		goto error;
 	}
 
+	if (is_iomap && is_truncate) {
+		err = fuse_iomap_setsize_finish(inode, outarg.attr.size);
+		if (err)
+			goto error;
+	}
+
 	spin_lock(&fi->lock);
 	/* the kernel maintains i_mtime locally */
 	if (trust_local_cmtime) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 98beba35743268..238dba058176ab 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -100,7 +100,7 @@ static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
 	kfree(ra);
 }
 
-static void fuse_file_put(struct fuse_file *ff, bool sync)
+static void fuse_file_put(struct fuse_file *ff, struct inode *inode, bool sync)
 {
 	if (refcount_dec_and_test(&ff->count)) {
 		struct fuse_release_args *ra = &ff->args->release_args;
@@ -109,6 +109,8 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 		if (ra && ra->inode)
 			fuse_file_io_release(ff, ra->inode);
 
+		fuse_iomap_release_truncate(inode);
+
 		if (!args) {
 			/* Do nothing when server does not implement 'open' */
 		} else if (sync) {
@@ -279,9 +281,11 @@ static int fuse_open(struct inode *inode, struct file *file)
 	if ((is_wb_truncate || dax_truncate) && !is_iomap)
 		fuse_release_nowrite(inode);
 	if (!err) {
-		if (is_truncate)
+		if (is_truncate) {
 			truncate_pagecache(inode, 0);
-		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
+			if (is_iomap)
+				fuse_iomap_open_truncate(inode);
+		} else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
 			invalidate_inode_pages2(inode->i_mapping);
 	}
 	if (dax_truncate)
@@ -367,7 +371,7 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	 * own ref to the file, the IO completion has to drop the ref, which is
 	 * how the fuse server can end up closing its clients' files.
 	 */
-	fuse_file_put(ff, false);
+	fuse_file_put(ff, &fi->inode, false);
 }
 
 void fuse_release_common(struct file *file, bool isdir)
@@ -398,7 +402,7 @@ void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
 {
 	WARN_ON(refcount_read(&ff->count) > 1);
 	fuse_prepare_release(fi, ff, flags, FUSE_RELEASE, true);
-	fuse_file_put(ff, true);
+	fuse_file_put(ff, &fi->inode, true);
 }
 EXPORT_SYMBOL_GPL(fuse_sync_release);
 
@@ -903,7 +907,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		folio_put(ap->folios[i]);
 	}
 	if (ia->ff)
-		fuse_file_put(ia->ff, false);
+		fuse_file_put(ia->ff, inode, false);
 
 	fuse_io_free(ia);
 }
@@ -1864,7 +1868,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 	if (wpa->bucket)
 		fuse_sync_bucket_dec(wpa->bucket);
 
-	fuse_file_put(wpa->ia.ff, false);
+	fuse_file_put(wpa->ia.ff, wpa->inode, false);
 
 	kfree(ap->folios);
 	kfree(wpa);
@@ -2020,7 +2024,7 @@ int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
 	ff = __fuse_write_file_get(fi);
 	err = fuse_flush_times(inode, ff);
 	if (ff)
-		fuse_file_put(ff, false);
+		fuse_file_put(ff, inode, false);
 
 	return err;
 }
@@ -2238,7 +2242,7 @@ static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
 	}
 
 	if (data->ff)
-		fuse_file_put(data->ff, false);
+		fuse_file_put(data->ff, wpc->inode, false);
 
 	return error;
 }
@@ -3150,7 +3154,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		goto out;
 	}
 
-	if (!is_iomap)
+	if (is_iomap)
+		fuse_iomap_copied_file_range(inode_out, pos_out, outarg.size);
+	else
 		truncate_inode_pages_range(inode_out->i_mapping,
 				   ALIGN_DOWN(pos_out, PAGE_SIZE),
 				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index ed7e07795679a6..25a16d23dd667d 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -906,6 +906,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 			fuse_iomap_inline_free(iomap);
 			if (err)
 				return err;
+			fuse_iomap_cache_invalidate_range(inode, pos, written);
 		} else {
 			fuse_iomap_inline_free(iomap);
 		}
@@ -1053,9 +1054,11 @@ static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
 
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
 
@@ -2290,6 +2293,18 @@ fuse_iomap_setsize_start(
 	return filemap_write_and_wait(inode->i_mapping);
 }
 
+int
+fuse_iomap_setsize_finish(
+	struct inode		*inode,
+	loff_t			newsize)
+{
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
@@ -2372,6 +2387,14 @@ fuse_iomap_fallocate(
 
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
@@ -2389,6 +2412,8 @@ fuse_iomap_fallocate(
 	 */
 	if (new_size) {
 		error = fuse_iomap_setsize_start(inode, new_size);
+		if (!error)
+			error = fuse_iomap_setsize_finish(inode, new_size);
 		if (error)
 			return error;
 
@@ -2473,3 +2498,25 @@ int fuse_iomap_dev_inval(struct fuse_conn *fc,
 	up_read(&fc->killsb);
 	return ret;
 }
+
+void fuse_iomap_open_truncate(struct inode *inode)
+{
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	fuse_iomap_cache_invalidate(inode, 0);
+}
+
+void fuse_iomap_release_truncate(struct inode *inode)
+{
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	fuse_iomap_cache_invalidate(inode, 0);
+}
+
+void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
+				  size_t written)
+{
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	fuse_iomap_cache_invalidate_range(inode, offset, written);
+}
diff --git a/fs/fuse/iomap_cache.c b/fs/fuse/iomap_cache.c
index 4b54609b59490e..0c8a38bd5723a2 100644
--- a/fs/fuse/iomap_cache.c
+++ b/fs/fuse/iomap_cache.c
@@ -1412,6 +1412,33 @@ fuse_iomap_cache_remove(
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


