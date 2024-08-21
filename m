Return-Path: <linux-fsdevel+bounces-26437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B9F9594A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C67B224A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 06:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1274816DEA3;
	Wed, 21 Aug 2024 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dfH/rXdl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BDD16DC34;
	Wed, 21 Aug 2024 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724221890; cv=none; b=sxlOKZQDYqnW0k4oKt4+UUnZ2C+QdYSZE44Bg1AfGXnsQe8aXAOm0t5o571swPkdW7Sn8UFJUrh5fO4G38eULToggdSKn25utDp1+cQxKtUioHcEuMjhrtdPGzwANuXFwvd8SnjL7bBzT/s5M5OqCkz2SQjx2RmcI7vwdUEWDbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724221890; c=relaxed/simple;
	bh=WNDTWIYVoeTaQc8ip6uIYTr3sUeaMNBX5kglkTVyBD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoTIe12mjwlfwHoPEXbDO7R3doks5p7qZOFdAQJ8Dcdw/7WHuFpCY7Vl6vnSzDlobq0dL61FwjsmkmqmAdOdYuGECaFTF3fjkU3sbSiGkFH2K044mHQFAqPYSaurVPOHYFf+ISYgPdHzSMAoxE9Nc59xya4zxEp9Am7B6V+B9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dfH/rXdl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=V9mgMURNOhTBMKoMnincYbZsHjdjqPlsl4d8zlD52Ow=; b=dfH/rXdlXYUKMMctA5aC5+/rfo
	9p8qhYQcC+po2NXjTV8UNrcH9cQdGg9pksAm+9Xqw9Cdd5lYNHTiSPrlwcTR1okHP4v3jx5qdyuPo
	n47ZzCnT5CYeJPlAzijW/OVZ1s83iqPMWGsozt7BFxguq3WWhIyVVyJjqAUDYD6IGKgCG6XThIUBG
	ULCNz4xEcJhgl4I8NTI+EkgFehsw9OO95ORx2Zn5nRJ8lO8y0jBi7pKUrAdLkTiCU/QQJDlQyPwNe
	KZdlxnju1zCB63hByai4IhgXLV+fC2b+YKl/wjBChHEfaitmFRHgCUCdSQWTWvNddqfjlP9C4n/h3
	N11Hbj+Q==;
Received: from 2a02-8389-2341-5b80-94d5-b2c4-989b-ff6e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:94d5:b2c4:989b:ff6e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgesQ-00000007iUI-20Gf;
	Wed, 21 Aug 2024 06:31:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 6/6] xfs: refactor xfs_file_fallocate
Date: Wed, 21 Aug 2024 08:30:32 +0200
Message-ID: <20240821063108.650126-7-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821063108.650126-1-hch@lst.de>
References: <20240821063108.650126-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Refactor xfs_file_fallocate into separate helpers for each mode,
two factors for i_size handling and a single switch statement over the
supported modes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c | 327 +++++++++++++++++++++++++++++-----------------
 1 file changed, 205 insertions(+), 122 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 489bc1b173c268..9d3bac7731bdcb 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -852,6 +852,189 @@ static inline bool xfs_file_sync_writes(struct file *filp)
 	return false;
 }
 
+static int
+xfs_falloc_newsize(
+	struct file		*file,
+	int			mode,
+	loff_t			offset,
+	loff_t			len,
+	loff_t			*new_size)
+{
+	struct inode		*inode = file_inode(file);
+
+	if ((mode & FALLOC_FL_KEEP_SIZE) || offset + len <= i_size_read(inode))
+		return 0;
+	*new_size = offset + len;
+	return inode_newsize_ok(inode, *new_size);
+}
+
+static int
+xfs_falloc_setsize(
+	struct file		*file,
+	loff_t			new_size)
+{
+	struct iattr iattr = {
+		.ia_valid	= ATTR_SIZE,
+		.ia_size	= new_size,
+	};
+
+	if (!new_size)
+		return 0;
+	return xfs_vn_setattr_size(file_mnt_idmap(file), file_dentry(file),
+			&iattr);
+}
+
+static int
+xfs_falloc_collapse_range(
+	struct file		*file,
+	loff_t			offset,
+	loff_t			len)
+{
+	struct inode		*inode = file_inode(file);
+	loff_t			new_size = i_size_read(inode) - len;
+	int			error;
+
+	if (!xfs_is_falloc_aligned(XFS_I(inode), offset, len))
+		return -EINVAL;
+
+	/*
+	 * There is no need to overlap collapse range with EOF, in which case it
+	 * is effectively a truncate operation
+	 */
+	if (offset + len >= i_size_read(inode))
+		return -EINVAL;
+
+	error = xfs_collapse_file_space(XFS_I(inode), offset, len);
+	if (error)
+		return error;
+	return xfs_falloc_setsize(file, new_size);
+}
+
+static int
+xfs_falloc_insert_range(
+	struct file		*file,
+	loff_t			offset,
+	loff_t			len)
+{
+	struct inode		*inode = file_inode(file);
+	loff_t			isize = i_size_read(inode);
+	int			error;
+
+	if (!xfs_is_falloc_aligned(XFS_I(inode), offset, len))
+		return -EINVAL;
+
+	/*
+	 * New inode size must not exceed ->s_maxbytes, accounting for
+	 * possible signed overflow.
+	 */
+	if (inode->i_sb->s_maxbytes - isize < len)
+		return -EFBIG;
+
+	/* Offset should be less than i_size */
+	if (offset >= isize)
+		return -EINVAL;
+
+	error = xfs_falloc_setsize(file, isize + len);
+	if (error)
+		return error;
+
+	/*
+	 * Perform hole insertion now that the file size has been updated so
+	 * that if we crash during the operation we don't leave shifted extents
+	 * past EOF and hence losing access to the data that is contained within
+	 * them.
+	 */
+	return xfs_insert_file_space(XFS_I(inode), offset, len);
+}
+
+/*
+ * Punch a hole and prealloc the range.  We use a hole punch rather than
+ * unwritten extent conversion for two reasons:
+ *
+ *   1.) Hole punch handles partial block zeroing for us.
+ *   2.) If prealloc returns ENOSPC, the file range is still zero-valued by
+ *	 virtue of the hole punch.
+ */
+static int
+xfs_falloc_zero_range(
+	struct file		*file,
+	int			mode,
+	loff_t			offset,
+	loff_t			len)
+{
+	struct inode		*inode = file_inode(file);
+	unsigned int		blksize = i_blocksize(inode);
+	loff_t			new_size = 0;
+	int			error;
+
+	trace_xfs_zero_file_space(XFS_I(inode));
+
+	error = xfs_falloc_newsize(file, mode, offset, len, &new_size);
+	if (error)
+		return error;
+
+	error = xfs_free_file_space(XFS_I(inode), offset, len);
+	if (error)
+		return error;
+
+	len = round_up(offset + len, blksize) - round_down(offset, blksize);
+	offset = round_down(offset, blksize);
+	error = xfs_alloc_file_space(XFS_I(inode), offset, len);
+	if (error)
+		return error;
+	return xfs_falloc_setsize(file, new_size);
+}
+
+static int
+xfs_falloc_unshare_range(
+	struct file		*file,
+	int			mode,
+	loff_t			offset,
+	loff_t			len)
+{
+	struct inode		*inode = file_inode(file);
+	loff_t			new_size = 0;
+	int			error;
+
+	error = xfs_falloc_newsize(file, mode, offset, len, &new_size);
+	if (error)
+		return error;
+
+	error = xfs_reflink_unshare(XFS_I(inode), offset, len);
+	if (error)
+		return error;
+
+	return xfs_falloc_setsize(file, new_size);
+}
+
+static int
+xfs_falloc_allocate_range(
+	struct file		*file,
+	int			mode,
+	loff_t			offset,
+	loff_t			len)
+{
+	struct inode		*inode = file_inode(file);
+	loff_t			new_size = 0;
+	int			error;
+
+	/*
+	 * If always_cow mode we can't use preallocations and thus should not
+	 * create them.
+	 */
+	if (xfs_is_always_cow_inode(XFS_I(inode)))
+		return -EOPNOTSUPP;
+
+	error = xfs_falloc_newsize(file, mode, offset, len, &new_size);
+	if (error)
+		return error;
+
+	error = xfs_alloc_file_space(XFS_I(inode), offset, len);
+	if (error)
+		return error;
+	return xfs_falloc_setsize(file, new_size);
+}
+
 #define	XFS_FALLOC_FL_SUPPORTED						\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
 		 FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |	\
@@ -868,8 +1051,6 @@ xfs_file_fallocate(
 	struct xfs_inode	*ip = XFS_I(inode);
 	long			error;
 	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
-	loff_t			new_size = 0;
-	bool			do_file_insert = false;
 
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
@@ -894,129 +1075,31 @@ xfs_file_fallocate(
 	if (error)
 		goto out_unlock;
 
-	if (mode & FALLOC_FL_PUNCH_HOLE) {
+	switch (mode & FALLOC_FL_MODE_MASK) {
+	case FALLOC_FL_PUNCH_HOLE:
 		error = xfs_free_file_space(ip, offset, len);
-		if (error)
-			goto out_unlock;
-	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
-		if (!xfs_is_falloc_aligned(ip, offset, len)) {
-			error = -EINVAL;
-			goto out_unlock;
-		}
-
-		/*
-		 * There is no need to overlap collapse range with EOF,
-		 * in which case it is effectively a truncate operation
-		 */
-		if (offset + len >= i_size_read(inode)) {
-			error = -EINVAL;
-			goto out_unlock;
-		}
-
-		new_size = i_size_read(inode) - len;
-
-		error = xfs_collapse_file_space(ip, offset, len);
-		if (error)
-			goto out_unlock;
-	} else if (mode & FALLOC_FL_INSERT_RANGE) {
-		loff_t		isize = i_size_read(inode);
-
-		if (!xfs_is_falloc_aligned(ip, offset, len)) {
-			error = -EINVAL;
-			goto out_unlock;
-		}
-
-		/*
-		 * New inode size must not exceed ->s_maxbytes, accounting for
-		 * possible signed overflow.
-		 */
-		if (inode->i_sb->s_maxbytes - isize < len) {
-			error = -EFBIG;
-			goto out_unlock;
-		}
-		new_size = isize + len;
-
-		/* Offset should be less than i_size */
-		if (offset >= isize) {
-			error = -EINVAL;
-			goto out_unlock;
-		}
-		do_file_insert = true;
-	} else {
-		if (!(mode & FALLOC_FL_KEEP_SIZE) &&
-		    offset + len > i_size_read(inode)) {
-			new_size = offset + len;
-			error = inode_newsize_ok(inode, new_size);
-			if (error)
-				goto out_unlock;
-		}
-
-		if (mode & FALLOC_FL_ZERO_RANGE) {
-			/*
-			 * Punch a hole and prealloc the range.  We use a hole
-			 * punch rather than unwritten extent conversion for two
-			 * reasons:
-			 *
-			 *   1.) Hole punch handles partial block zeroing for us.
-			 *   2.) If prealloc returns ENOSPC, the file range is
-			 *       still zero-valued by virtue of the hole punch.
-			 */
-			unsigned int blksize = i_blocksize(inode);
-
-			trace_xfs_zero_file_space(ip);
-
-			error = xfs_free_file_space(ip, offset, len);
-			if (error)
-				goto out_unlock;
-
-			len = round_up(offset + len, blksize) -
-			      round_down(offset, blksize);
-			offset = round_down(offset, blksize);
-		} else if (mode & FALLOC_FL_UNSHARE_RANGE) {
-			error = xfs_reflink_unshare(ip, offset, len);
-			if (error)
-				goto out_unlock;
-		} else {
-			/*
-			 * If always_cow mode we can't use preallocations and
-			 * thus should not create them.
-			 */
-			if (xfs_is_always_cow_inode(ip)) {
-				error = -EOPNOTSUPP;
-				goto out_unlock;
-			}
-		}
-
-		error = xfs_alloc_file_space(ip, offset, len);
-		if (error)
-			goto out_unlock;
-	}
-
-	/* Change file size if needed */
-	if (new_size) {
-		struct iattr iattr;
-
-		iattr.ia_valid = ATTR_SIZE;
-		iattr.ia_size = new_size;
-		error = xfs_vn_setattr_size(file_mnt_idmap(file),
-					    file_dentry(file), &iattr);
-		if (error)
-			goto out_unlock;
-	}
-
-	/*
-	 * Perform hole insertion now that the file size has been
-	 * updated so that if we crash during the operation we don't
-	 * leave shifted extents past EOF and hence losing access to
-	 * the data that is contained within them.
-	 */
-	if (do_file_insert) {
-		error = xfs_insert_file_space(ip, offset, len);
-		if (error)
-			goto out_unlock;
+		break;
+	case FALLOC_FL_COLLAPSE_RANGE:
+		error = xfs_falloc_collapse_range(file, offset, len);
+		break;
+	case FALLOC_FL_INSERT_RANGE:
+		error = xfs_falloc_insert_range(file, offset, len);
+		break;
+	case FALLOC_FL_ZERO_RANGE:
+		error = xfs_falloc_zero_range(file, mode, offset, len);
+		break;
+	case FALLOC_FL_UNSHARE_RANGE:
+		error = xfs_falloc_unshare_range(file, mode, offset, len);
+		break;
+	case FALLOC_FL_ALLOCATE_RANGE:
+		error = xfs_falloc_allocate_range(file, mode, offset, len);
+		break;
+	default:
+		error = -EOPNOTSUPP;
+		break;
 	}
 
-	if (xfs_file_sync_writes(file))
+	if (!error && xfs_file_sync_writes(file))
 		error = xfs_log_force_inode(ip);
 
 out_unlock:
-- 
2.43.0


