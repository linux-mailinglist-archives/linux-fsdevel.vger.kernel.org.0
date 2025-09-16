Return-Path: <linux-fsdevel+bounces-61552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F71B589D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54271B264EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B561F1A5B92;
	Tue, 16 Sep 2025 00:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYcEEdhH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B78DD528;
	Tue, 16 Sep 2025 00:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983183; cv=none; b=TpQQUwXop/b9oGXL6JJBTb/LS9Hen8t+/7q+gnWsnhYZ4M5sLAdQdLzkClIF5L95/190qCyQQ6q3r3TQ+xAPaymcEs1uh6/LMzFydHeRZs8KzhrQJwkKGl/XgwV3VrBbLVl+rLHi3ctIZFq4I52CYtGU08REcTzrge7ajkDJS+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983183; c=relaxed/simple;
	bh=2ONlPuy29lRDQF0QI2yP+KaY6vsgvj50g9jNDrNfqLo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xa6LOh02zBg5tmZhwdVOFq+OgfjWMHaVQr2TEZ8g/C8wW1RoWMoIzd6Rrj7QL2jvdhIwAkQuhVTjVuI0YWoDmEVRAcrblsD6VuoOIuX57bgAw42oGNHAyjtNuNfsr3L5Q4CWYdEjozdT/2s3yjWRQ5eSedQsUfQiMUd3eq2sVj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYcEEdhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE06C4CEF1;
	Tue, 16 Sep 2025 00:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983182;
	bh=2ONlPuy29lRDQF0QI2yP+KaY6vsgvj50g9jNDrNfqLo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AYcEEdhH/7QpUuqzmT4nd92BspT+W1m9BkgJ/ynHS3Gf58ae86/1VN7T9HlbLtVur
	 QuEKS7FnjxwU2xME2+TZnsNh7G5HlWz8nyyq7u2AfbWnTAJnL5UG6BUkaviodBETuJ
	 DQZdFkuQZaEt0Fj1aDKpupI/vSbVwLscPZp4pUFwjw+065R1XyY4UkqfsOZ03eCLoU
	 KEX3LUmoyhpgxU1ewszdnU17NzBmy0P6ZU4OZBGNHDTD0f0kRn9o4k4P9FoUf1GhEv
	 sxcH0a/s718WTNhWFk/0am1kE9AuC5KwZ85HrFon15aoRWo1CzOiSC+6qRET2X72Uv
	 HHMM3Bv9zvtlg==
Date: Mon, 15 Sep 2025 17:39:42 -0700
Subject: [PATCH 05/10] fuse: invalidate iomap cache after file updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798153032.384360.217141397449475281.stgit@frogsfrogsfrogs>
In-Reply-To: <175798152863.384360.10608991871408828112.stgit@frogsfrogsfrogs>
References: <175798152863.384360.10608991871408828112.stgit@frogsfrogsfrogs>
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
 fs/fuse/iomap_priv.h  |    9 +++++++++
 fs/fuse/dir.c         |    6 ++++++
 fs/fuse/file.c        |   10 +++++++---
 fs/fuse/file_iomap.c  |   42 +++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/iomap_cache.c |   27 +++++++++++++++++++++++++++
 6 files changed, 97 insertions(+), 4 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 33b65253b2e9be..c6ec9383a99ce5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1831,10 +1831,14 @@ int fuse_iomap_mmap(struct file *file, struct vm_area_struct *vma);
 ssize_t fuse_iomap_buffered_read(struct kiocb *iocb, struct iov_iter *to);
 ssize_t fuse_iomap_buffered_write(struct kiocb *iocb, struct iov_iter *from);
 int fuse_iomap_setsize_start(struct inode *inode, loff_t newsize);
+int fuse_iomap_setsize_finish(struct inode *inode, loff_t newsize);
 int fuse_iomap_fallocate(struct file *file, int mode, loff_t offset,
 			 loff_t length, loff_t new_size);
 int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 				 loff_t endpos);
+void fuse_iomap_open_truncate(struct inode *inode);
+void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
+				  size_t written);
 
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
@@ -1875,8 +1879,11 @@ enum fuse_iomap_iodir {
 # define fuse_iomap_buffered_read(...)		(-ENOSYS)
 # define fuse_iomap_buffered_write(...)		(-ENOSYS)
 # define fuse_iomap_setsize_start(...)		(-ENOSYS)
+# define fuse_iomap_setsize_finish(...)		(-ENOSYS)
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
+# define fuse_iomap_open_truncate(...)		((void)0)
+# define fuse_iomap_copied_file_range(...)	((void)0)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
 # define fuse_iomap_dev_inval(...)		(-ENOSYS)
 # define fuse_iomap_fadvise			NULL
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
index 9adaf262bda975..c7291d968ba89c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2208,6 +2208,12 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
index 0ed13082d0d00d..130395403535dd 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -279,9 +279,11 @@ static int fuse_open(struct inode *inode, struct file *file)
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
@@ -3140,7 +3142,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (err)
 		goto out;
 
-	if (!is_iomap)
+	if (is_iomap)
+		fuse_iomap_copied_file_range(inode_out, pos_out, outarg.size);
+	else
 		truncate_inode_pages_range(inode_out->i_mapping,
 				   ALIGN_DOWN(pos_out, PAGE_SIZE),
 				   ALIGN(pos_out + outarg.size, PAGE_SIZE) - 1);
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index b568a862f120ff..b410cae0dec5dd 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -895,6 +895,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 			fuse_iomap_inline_free(iomap);
 			if (err)
 				return err;
+			fuse_iomap_cache_invalidate_range(inode, pos, written);
 		} else {
 			fuse_iomap_inline_free(iomap);
 		}
@@ -1035,9 +1036,11 @@ static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
 
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
 
@@ -2220,6 +2223,18 @@ fuse_iomap_setsize_start(
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
@@ -2302,6 +2317,14 @@ fuse_iomap_fallocate(
 
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
@@ -2319,6 +2342,8 @@ fuse_iomap_fallocate(
 	 */
 	if (new_size) {
 		error = fuse_iomap_setsize_start(inode, new_size);
+		if (!error)
+			error = fuse_iomap_setsize_finish(inode, new_size);
 		if (error)
 			return error;
 
@@ -2403,3 +2428,18 @@ int fuse_iomap_dev_inval(struct fuse_conn *fc,
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
+void fuse_iomap_copied_file_range(struct inode *inode, loff_t offset,
+				  size_t written)
+{
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	fuse_iomap_cache_invalidate_range(inode, offset, written);
+}
diff --git a/fs/fuse/iomap_cache.c b/fs/fuse/iomap_cache.c
index 572bccf99a97a8..f1be73da571440 100644
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


