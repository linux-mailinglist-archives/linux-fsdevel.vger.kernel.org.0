Return-Path: <linux-fsdevel+bounces-55324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6BCB09802
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D9118921A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531BB279DDC;
	Thu, 17 Jul 2025 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuG8pM5d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B459928751C
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794952; cv=none; b=eb1c/L7lrm/zP+JppgaJVPFepTyr6/gcHyiLqjxhl0oEkKX6N1mUjvVzHdCUMZcqqySkCv2wPHfHmX5clcBqZxRLFkt8dG4MALuS3oSikbHuX8y9hs+NPBqC0c77TErkKhMeBzxEoi1UOzqMPK3Ne8U3pAOH+D2LiUbl6DzOe+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794952; c=relaxed/simple;
	bh=V/DwR23Orb996I8NOZF9p3NJFEP/dDM4UWgTTvboi+0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBKAdMAhe88/0iM6xlhDLlnyWhliD64YiKJq31ZPO3iQySO6iv6HIhWA98frzw54/Fr62ozjFqZq1DQEH5VeE4GmkD5ioNcMisLXE4wjBWGVAFDurv6GFF+VMgqhjjaORlsFrHZF1EOXg41vapEJPYSTlYCpPxHOrhnyK8cPtM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuG8pM5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926F9C4CEF4;
	Thu, 17 Jul 2025 23:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794952;
	bh=V/DwR23Orb996I8NOZF9p3NJFEP/dDM4UWgTTvboi+0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ZuG8pM5ddBTD6u0jIrvZEkJrZnzi0IFe/NQxQZ6VTaLXPedxZdyuzqUl4TMvCELV5
	 96HDcPiz9BzwLrKj1FDGMsh2LBerRgSrsExFuNNFzIh1FJ/R6dy+ZBis8CmaPMOO8G
	 Ij8VqNcnfY7cjfnqNRqkb6uT5MpVlpXRgtogT0DkB789F9MXCJtetQeJZ59wy4O72P
	 knaIa8xowDT+xQpLAYvUtyXO1pft3+6XYTMkRjZ+mfj9l/gcGMBlx7RKUY3rCVPtOl
	 vo5V/eP5bbj0+JkvDAAdx7Kho+wSlXGlXICk0uaHcW9xIgA7x6+fZQDaHHnoLkRaFR
	 7OAPsAFFxtA3w==
Date: Thu, 17 Jul 2025 16:29:12 -0700
Subject: [PATCH 04/13] fuse: implement basic iomap reporting such as FIEMAP
 and SEEK_{DATA,HOLE}
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450022.711291.7491701760321787367.stgit@frogsfrogsfrogs>
In-Reply-To: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
References: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   66 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c        |    1 +
 fs/fuse/file.c       |   13 +++++++++
 fs/fuse/file_iomap.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 158 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 850c187434a61a..4df51454858146 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1643,6 +1643,11 @@ void fuse_iomap_conn_put(struct fuse_conn *fc);
 
 int fuse_iomap_dev_add(struct fuse_conn *fc, const struct fuse_backing_map *map);
 void fuse_iomap_conn_destroy(struct fuse_mount *fm);
+
+int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		      u64 start, u64 length);
+loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
+sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1651,6 +1656,9 @@ void fuse_iomap_conn_destroy(struct fuse_mount *fm);
 # define fuse_iomap_conn_put(...)		((void)0)
 # define fuse_iomap_dev_add(...)		(-ENOSYS)
 # define fuse_iomap_conn_destroy(...)		((void)0)
+# define fuse_iomap_fiemap			NULL
+# define fuse_iomap_lseek(...)			(-ENOSYS)
+# define fuse_iomap_bmap(...)			(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 5c8533053f8eed..9c02ca07571e1c 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -472,6 +472,72 @@ DEFINE_EVENT(fuse_iomap_dev_class, name,		\
 	TP_ARGS(fc, idx, fb))
 DEFINE_FUSE_IOMAP_DEV_EVENT(fuse_iomap_add_dev);
 DEFINE_FUSE_IOMAP_DEV_EVENT(fuse_iomap_remove_dev);
+
+TRACE_EVENT(fuse_iomap_fiemap,
+	TP_PROTO(const struct inode *inode, u64 start, u64 count,
+		unsigned int flags),
+
+	TP_ARGS(inode, start, count, flags),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
+		__field(u64,		start)
+		__field(u64,		count)
+		__field(unsigned int,	flags)
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
+		__entry->start		=	start;
+		__entry->count		=	count;
+		__entry->flags		=	flags;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx flags 0x%x start 0x%llx count 0x%llx",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->flags, __entry->start,
+		  __entry->count)
+);
+
+TRACE_EVENT(fuse_iomap_lseek,
+	TP_PROTO(const struct inode *inode, loff_t offset, int whence),
+
+	TP_ARGS(inode, offset, whence),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
+		__field(loff_t,		offset)
+		__field(int,		whence)
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
+		__entry->whence		=	whence;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx offset 0x%llx whence %d",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->offset, __entry->whence)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4d841869ba3d0a..5efd763d188559 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2257,6 +2257,7 @@ static const struct inode_operations fuse_common_inode_operations = {
 	.set_acl	= fuse_set_acl,
 	.fileattr_get	= fuse_fileattr_get,
 	.fileattr_set	= fuse_fileattr_set,
+	.fiemap		= fuse_iomap_fiemap,
 };
 
 static const struct inode_operations fuse_symlink_inode_operations = {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ee79cb7bc05805..d143990d9ed931 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2569,6 +2569,12 @@ static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
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
 
@@ -2604,6 +2610,13 @@ static loff_t fuse_lseek(struct file *file, loff_t offset, int whence)
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
index 4724d5678112db..fb33185852ff0b 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -608,3 +608,73 @@ void fuse_iomap_conn_destroy(struct fuse_mount *fm)
 	fuse_flush_requests(fc, 60 * HZ);
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


