Return-Path: <linux-fsdevel+bounces-49612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6329DAC00EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A1516AD6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7599EC5;
	Thu, 22 May 2025 00:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGHTRsVt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E56118D;
	Thu, 22 May 2025 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872241; cv=none; b=ptuJGuZhDPK31N+kAiep4NT9mKcVZRKIjFV3cAgDMqKk0SHRspr1s/V6nalB8UQwTorEsOoxTacJWLHnlxzgm6MIhwdK6cBWPo1/6KuJ0cMq5IXJvdDNnHURto1qICVV6nEe28n++hwdo24vDfNOnnUjVz/J7mMqfEW47gOms3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872241; c=relaxed/simple;
	bh=cZKE/A1i+p6klLaZADW+m/aKH2xMNHuzR8D2me5rapY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dM7eLdQbzO+BSL/n2QV2eS+neTx5CiDoyfvbCnQL4GMLlPVTxuDxKrqGc8Zrhnt5JrPgCNCW581NXDjTfmIbJpknub0T+cK69gVOYd6qc1kYOsP1Ui4bOB0xw/bqU7SMzL3bEDJ2wwHbssz6Wbog8jx9b7d6tq6IPmYAeTX4BCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGHTRsVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E76C4CEE4;
	Thu, 22 May 2025 00:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872240;
	bh=cZKE/A1i+p6klLaZADW+m/aKH2xMNHuzR8D2me5rapY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dGHTRsVt81t852o2NCDyVvAVCgSHrRhLlXQX4SNwoeAXMO8UD0TiBO8ERibnRqL2P
	 YgXzCdHYcHuu4imFE17+Mzhvuyo6I21ZVIY7gfu70yl/tfIvLYbEL8fKKNF5LZkkkz
	 q/bc+u7C4hkL23h6iXloGyxJJwntFgI9OAo9lF64Q4RS4AaSzchiyLcm0n3hDR7VDq
	 mQzXCr4pPFIq0TbGoEt+H7sVoiD1Zx4gw+l/FI2aAqEuIj3F6R5ffKqWwapIN/9/GT
	 POYF0+z/Bb/ECXZZGDrdamui1fCKREII6xcC9GK3BmiRhnGzvyYvyXLz/oHKUNePAc
	 iNWsx4uHMm+hw==
Date: Wed, 21 May 2025 17:04:00 -0700
Subject: [PATCH 06/11] fuse: implement basic iomap reporting such as FIEMAP
 and SEEK_{DATA,HOLE}
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Message-ID: <174787195693.1483178.1715306737280115409.stgit@frogsfrogsfrogs>
In-Reply-To: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   57 +++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c        |    1 +
 fs/fuse/file.c       |   13 +++++++++
 fs/fuse/file_iomap.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 149 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 4eb75ed90db300..a39e45eeec2e3e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1626,12 +1626,20 @@ void fuse_iomap_conn_put(struct fuse_conn *fc);
 
 int fuse_iomap_add_device(struct fuse_conn *fc,
 			  const struct fuse_iomap_add_device_out *outarg);
+
+int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		      u64 start, u64 length);
+loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
+sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
 # define fuse_iomap_init_reply(...)		((void)0)
 # define fuse_iomap_conn_put(...)		((void)0)
 # define fuse_iomap_add_device(...)		(-ENOSYS)
+# define fuse_iomap_fiemap			NULL
+# define fuse_iomap_lseek(...)			(-ENOSYS)
+# define fuse_iomap_bmap(...)			(-ENOSYS)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index e1a2e491d2581a..252eab698287bd 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -416,6 +416,63 @@ DEFINE_EVENT(fuse_iomap_dev_class, name,		\
 	TP_ARGS(fc, idx, file))
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
+		__entry->start		=	start;
+		__entry->count		=	count;
+		__entry->flags		=	flags;
+	),
+
+	TP_printk("connection %u ino %llu flags 0x%x start 0x%llx count 0x%llx",
+		  __entry->connection, __entry->ino, __entry->flags,
+		  __entry->start, __entry->count)
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
+		__entry->offset		=	offset;
+		__entry->whence		=	whence;
+	),
+
+	TP_printk("connection %u ino %llu offset 0x%llx whence %d",
+		  __entry->connection, __entry->ino, __entry->offset,
+		  __entry->whence)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 83ac192e7fdd19..be75a515c4f8b6 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2230,6 +2230,7 @@ static const struct inode_operations fuse_common_inode_operations = {
 	.set_acl	= fuse_set_acl,
 	.fileattr_get	= fuse_fileattr_get,
 	.fileattr_set	= fuse_fileattr_set,
+	.fiemap		= fuse_iomap_fiemap,
 };
 
 static const struct inode_operations fuse_symlink_inode_operations = {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ada1ed9e653e42..6b54b9a8f8a84d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2844,6 +2844,12 @@ static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
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
 
@@ -2879,6 +2885,13 @@ static loff_t fuse_lseek(struct file *file, loff_t offset, int whence)
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
index faefd29a273bf3..f943cb3334a787 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -391,3 +391,73 @@ int fuse_iomap_add_device(struct fuse_conn *fc,
 
 	return put_user(ret, outarg->map_dev);
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


