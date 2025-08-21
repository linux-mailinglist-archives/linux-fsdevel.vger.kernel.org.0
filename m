Return-Path: <linux-fsdevel+bounces-58449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9563B2E9CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9235EA05B4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E277F1E5B64;
	Thu, 21 Aug 2025 00:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yc4fpXu4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B75BC2FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737679; cv=none; b=e1j7PmsKygu6Qo5y5bpWMM1ek6Ng+thgDsSFKuW6QFaORs6gq2b+F+yYxJLRXCCbwOvHEKkdFwzHkxrDOXjRA2KTlBdlHHwV/kOwQIikGjOPU1XVK0ztkicb7mPiT9+5JiqfQLQ6xDv3pTMt+uUBX5/ipr7cDSZeoNXBMJaj/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737679; c=relaxed/simple;
	bh=7b+axWvT2+a6jMFwPkBeT20EIgAn6D6Njydnjp8V4BA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5TJ29kwNmEmxu81GwJGw+aWiYfSYizSfooCSWNnMQ7MIppuHmSAb5xXdEO5ceQOxA/jtrCgb236MnW3HgpGVdwzqxbjQ0/sluD3XWZUzutfu1nVDKPKueGb6gk7k7FAM+R525a8xDc1fjrpSrhogvRuUn8AIuAbYlmJ9yyXIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yc4fpXu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B17C4CEE7;
	Thu, 21 Aug 2025 00:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737675;
	bh=7b+axWvT2+a6jMFwPkBeT20EIgAn6D6Njydnjp8V4BA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Yc4fpXu4Eq3fEWkhLYRqycA9/IjYRlUmMVrRcqyXz6RvO5Rq+B2DzbYqeLSE7DPHY
	 930HxUjFQ/Sl8bmDr1hHsYOzu6AJNB8zxkl4d+bCNdJeOPpdXY2fTnEKhB5H4J+kq6
	 S4SGP6ypgILl69LGB68baTa6vaKYgwP1V5eBJRDWaeIPYH0MFpSvoXAktc3oS0e4z1
	 mdb7NHV7u+o5LAd8YbdPHfbxfR0CTFqhz/vfYsnZjoG/2VTjawEoS51EPpxl8W5euQ
	 sUc44PQJnVsV2em4oYsBAhdsFzNdFRrqApS91LtcWm0i7HEgGCpUfMn5zlMN0suSjj
	 YYM7wz/dbhDqQ==
Date: Wed, 20 Aug 2025 17:54:35 -0700
Subject: [PATCH 08/23] fuse: implement basic iomap reporting such as FIEMAP
 and SEEK_{DATA,HOLE}
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709287.17510.13438479869040184371.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Implement the basic file mapping reporting functions like FIEMAP, BMAP,
and SEEK_DATA/HOLE.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h     |    8 ++++++
 fs/fuse/fuse_trace.h |   46 ++++++++++++++++++++++++++++++++
 fs/fuse/dir.c        |    1 +
 fs/fuse/file.c       |   13 +++++++++
 fs/fuse/file_iomap.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6a155bdd389af6..e7dc8229bcc5e7 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1651,6 +1651,11 @@ int fuse_iomap_backing_open(struct fuse_conn *fc, struct fuse_backing *fb);
 int fuse_iomap_backing_close(struct fuse_conn *fc, struct fuse_backing *fb);
 void fuse_iomap_mount(struct fuse_mount *fm);
 void fuse_iomap_unmount(struct fuse_mount *fm);
+
+int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		      u64 start, u64 length);
+loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
+sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1658,6 +1663,9 @@ void fuse_iomap_unmount(struct fuse_mount *fm);
 # define fuse_iomap_backing_close(...)		(-EOPNOTSUPP)
 # define fuse_iomap_mount(...)			((void)0)
 # define fuse_iomap_unmount(...)		((void)0)
+# define fuse_iomap_fiemap			NULL
+# define fuse_iomap_lseek(...)			(-ENOSYS)
+# define fuse_iomap_bmap(...)			(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index c3671a605a32f6..d2a926124a5d54 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -495,6 +495,52 @@ TRACE_EVENT(fuse_iomap_dev_add,
 		  __entry->fd,
 		  __entry->flags)
 );
+
+TRACE_EVENT(fuse_iomap_fiemap,
+	TP_PROTO(const struct inode *inode, u64 start, u64 count,
+		unsigned int flags),
+
+	TP_ARGS(inode, start, count, flags),
+
+	TP_STRUCT__entry(
+		FUSE_IO_RANGE_FIELDS()
+		__field(unsigned int,		flags)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	start;
+		__entry->length		=	count;
+		__entry->flags		=	flags;
+	),
+
+	TP_printk(FUSE_IO_RANGE_FMT("fiemap") " flags 0x%x",
+		  FUSE_IO_RANGE_PRINTK_ARGS(),
+		  __entry->flags)
+);
+
+TRACE_EVENT(fuse_iomap_lseek,
+	TP_PROTO(const struct inode *inode, loff_t offset, int whence),
+
+	TP_ARGS(inode, offset, whence),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(loff_t,			offset)
+		__field(int,			whence)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->offset		=	offset;
+		__entry->whence		=	whence;
+	),
+
+	TP_printk(FUSE_INODE_FMT " offset 0x%llx whence %d",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->offset,
+		  __entry->whence)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 8e922dcadb8675..4ea763699c1bae 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2298,6 +2298,7 @@ static const struct inode_operations fuse_common_inode_operations = {
 	.set_acl	= fuse_set_acl,
 	.fileattr_get	= fuse_fileattr_get,
 	.fileattr_set	= fuse_fileattr_set,
+	.fiemap		= fuse_iomap_fiemap,
 };
 
 static const struct inode_operations fuse_symlink_inode_operations = {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 0ba2b62e06679e..54432cf0be82ba 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2516,6 +2516,12 @@ static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
 	struct fuse_bmap_out outarg;
 	int err;
 
+	if (fuse_has_iomap(inode)) {
+		sector_t alt_sec = fuse_iomap_bmap(mapping, block);
+		if (alt_sec > 0)
+			return alt_sec;
+	}
+
 	if (!inode->i_sb->s_bdev || fm->fc->no_bmap)
 		return 0;
 
@@ -2551,6 +2557,13 @@ static loff_t fuse_lseek(struct file *file, loff_t offset, int whence)
 	struct fuse_lseek_out outarg;
 	int err;
 
+	if (fuse_has_iomap(inode)) {
+		loff_t alt_pos = fuse_iomap_lseek(file, offset, whence);
+
+		if (alt_pos >= 0 || (alt_pos < 0 && alt_pos != -ENOSYS))
+			return alt_pos;
+	}
+
 	if (fm->fc->no_lseek)
 		goto fallback;
 
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 6e0e222da3046c..691ca3a4ec95e5 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -4,6 +4,7 @@
  * Author: Darrick J. Wong <djwong@kernel.org>
  */
 #include <linux/iomap.h>
+#include <linux/fiemap.h>
 #include "fuse_i.h"
 #include "fuse_trace.h"
 #include "iomap_priv.h"
@@ -622,3 +623,73 @@ void fuse_iomap_unmount(struct fuse_mount *fm)
 	fuse_flush_requests_and_wait(fc, secs_to_jiffies(60));
 	fuse_send_destroy(fm);
 }
+
+int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		      u64 start, u64 count)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	int error;
+
+	/*
+	 * We are called directly from the vfs so we need to check per-inode
+	 * support here explicitly.
+	 */
+	if (!fuse_has_iomap(inode))
+		return -EOPNOTSUPP;
+
+	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR)
+		return -EOPNOTSUPP;
+
+	if (fuse_is_bad(inode))
+		return -EIO;
+
+	if (!fuse_allow_current_process(fc))
+		return -EACCES;
+
+	trace_fuse_iomap_fiemap(inode, start, count, fieinfo->fi_flags);
+
+	inode_lock_shared(inode);
+	error = iomap_fiemap(inode, fieinfo, start, count,
+			&fuse_iomap_ops);
+	inode_unlock_shared(inode);
+
+	return error;
+}
+
+sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block)
+{
+	ASSERT(fuse_has_iomap(mapping->host));
+
+	return iomap_bmap(mapping, block, &fuse_iomap_ops);
+}
+
+loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
+{
+	struct inode *inode = file->f_mapping->host;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	ASSERT(fuse_has_iomap(inode));
+
+	if (fuse_is_bad(inode))
+		return -EIO;
+
+	if (!fuse_allow_current_process(fc))
+		return -EACCES;
+
+	trace_fuse_iomap_lseek(inode, offset, whence);
+
+	switch (whence) {
+	case SEEK_HOLE:
+		offset = iomap_seek_hole(inode, offset, &fuse_iomap_ops);
+		break;
+	case SEEK_DATA:
+		offset = iomap_seek_data(inode, offset, &fuse_iomap_ops);
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	if (offset < 0)
+		return offset;
+	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
+}


