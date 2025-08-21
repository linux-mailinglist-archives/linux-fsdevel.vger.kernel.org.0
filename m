Return-Path: <linux-fsdevel+bounces-58463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F07B2E9DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B92017FAAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738AB1E7C23;
	Thu, 21 Aug 2025 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udcmYvKg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CCB190685
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737895; cv=none; b=L0BrgZFh1HDjPzt0ePQLPhpiOzgfq7nFDr3QoPwtAvrQC8tGSJkbIKdRAK6MZ3I6r8O6Vjicb2LhDpqXeLU49B8m+DATFnc5s6XxzWahXuyIN3ax6lh0r1wpwrVADcVnSzf/4pRcvuse059WBAUrhNj0ZU6HvdC3KaaFkr478DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737895; c=relaxed/simple;
	bh=pwvDs+/y89paFzTIZZZFeCE5bB10FdPflcdW2v+piAM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfnXEJAEHQbjAiXbw3K8shBuGyNo/HzRoSSgqjVepY1UzmxC3LfWohqYOIkG3JdYzNmk6g+c+eIDrn0f+pUz5cYncHK0e/+Gq5Ro5PolOmUQ2GsOfC9Cz6ntepPKb+n2DJqqfVKgibs0NWXBXnMsoSHl9sxHDRgwpQUs3876YMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udcmYvKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72457C4CEE7;
	Thu, 21 Aug 2025 00:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737894;
	bh=pwvDs+/y89paFzTIZZZFeCE5bB10FdPflcdW2v+piAM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=udcmYvKg6UL5jpv5lEsANu8A7wpRAqhCXKt9Rp0CIWZC4f/TRQdrdAXyKKE6ORl3y
	 TjW3DIWDNgEzowAnwoqm4Zl5MxDK8MmKvqbHxwY/bAaIyR5J2HfSYuFjpDBgn1uIC2
	 JrW2YXvZsoF3ixw0pfEYxq9kMJflyoci88DhA2jUyvlSptuMvNL3cNhJhRuwHgG7FX
	 YUPDfZ9Uws4Wrdeo+gmz+UYwlGdWcBNgX3y9OmAYXRfsoKhwTjqmj2xZHv+yhFuuub
	 u3B6g0lC9YLbLTDdcS83sctPW7OX6dZ7tHyxZcFEUhcJe0GZ50L7+JRYsg6CH1+dRD
	 tuiMn/hRz81gA==
Date: Wed, 20 Aug 2025 17:58:14 -0700
Subject: [PATCH 22/23] fuse: support atomic writes with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709589.17510.39796452794247878.stgit@frogsfrogsfrogs>
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

One whole block!

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    9 ++++++++
 fs/fuse/fuse_trace.h      |    4 +++-
 include/uapi/linux/fuse.h |    5 ++++
 fs/fuse/file_iomap.c      |   51 ++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 67 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 4ca29315b2a434..e72cc25c564048 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -243,6 +243,8 @@ enum {
 	FUSE_I_CACHE_IO_MODE,
 	/* Use iomap for this inode */
 	FUSE_I_IOMAP,
+	/* Enable untorn writes */
+	FUSE_I_ATOMIC,
 };
 
 struct fuse_conn;
@@ -1718,6 +1720,13 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
 	return test_bit(FUSE_I_IOMAP, &fi->state);
 }
 
+static inline bool fuse_inode_has_atomic(const struct inode *inode)
+{
+	const struct fuse_inode *fi = get_fuse_inode_c(inode);
+
+	return test_bit(FUSE_I_ATOMIC, &fi->state);
+}
+
 static inline bool fuse_want_iomap_directio(const struct kiocb *iocb)
 {
 	return (iocb->ki_flags & IOCB_DIRECT) &&
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 4ebd9a9e697ce2..79de0e65608360 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -331,6 +331,7 @@ TRACE_DEFINE_ENUM(FUSE_I_BAD);
 TRACE_DEFINE_ENUM(FUSE_I_BTIME);
 TRACE_DEFINE_ENUM(FUSE_I_CACHE_IO_MODE);
 TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
+TRACE_DEFINE_ENUM(FUSE_I_ATOMIC);
 
 #define FUSE_IFLAG_STRINGS \
 	{ 1 << FUSE_I_ADVISE_RDPLUS,		"advise_rdplus" }, \
@@ -339,7 +340,8 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
 	{ 1 << FUSE_I_BAD,			"bad" }, \
 	{ 1 << FUSE_I_BTIME,			"btime" }, \
 	{ 1 << FUSE_I_CACHE_IO_MODE,		"cacheio" }, \
-	{ 1 << FUSE_I_IOMAP,			"iomap" }
+	{ 1 << FUSE_I_IOMAP,			"iomap" }, \
+	{ 1 << FUSE_I_ATOMIC,			"atomic" }
 
 #define IOMAP_IOEND_STRINGS \
 	{ IOMAP_IOEND_SHARED,			"shared" }, \
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index cfeee8a280896a..70b5530e587d48 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -242,6 +242,7 @@
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
+ *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -597,10 +598,12 @@ struct fuse_file_lock {
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
  * FUSE_ATTR_IOMAP: Use iomap for this inode
+ * FUSE_ATTR_ATOMIC: Enable untorn writes
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_IOMAP		(1 << 2)
+#define FUSE_ATTR_ATOMIC	(1 << 3)
 
 /**
  * Open flags
@@ -1153,6 +1156,8 @@ struct fuse_backing_map {
 
 /* basic file I/O functionality through iomap */
 #define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 0)
+/* untorn writes through iomap */
+#define FUSE_IOMAP_SUPPORT_ATOMIC	(1ULL << 1)
 struct fuse_iomap_support {
 	uint64_t	flags;
 	uint64_t	padding;
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 4c8fef25b0749b..ee199c1fd27b1f 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1122,6 +1122,8 @@ void fuse_iomap_open(struct inode *inode, struct file *file)
 {
 	if (fuse_inode_has_iomap(inode))
 		file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+	if (fuse_inode_has_atomic(inode))
+		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 }
 
 enum fuse_ilock_type {
@@ -1173,12 +1175,33 @@ static inline void fuse_inode_clear_iomap(struct inode *inode)
 	clear_bit(FUSE_I_IOMAP, &fi->state);
 }
 
+static inline void fuse_inode_set_atomic(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(fuse_has_iomap(inode));
+
+	set_bit(FUSE_I_ATOMIC, &fi->state);
+}
+
+static inline void fuse_inode_clear_atomic(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(fuse_has_iomap(inode));
+
+	clear_bit(FUSE_I_ATOMIC, &fi->state);
+}
+
 void fuse_iomap_init_inode(struct inode *inode, unsigned attr_flags)
 {
 	struct fuse_conn *conn = get_fuse_conn(inode);
 
 	if (conn->iomap && (attr_flags & FUSE_ATTR_IOMAP))
 		fuse_inode_set_iomap(inode);
+	if (fuse_inode_has_iomap(inode) &&
+	    (attr_flags & FUSE_ATTR_ATOMIC))
+		fuse_inode_set_atomic(inode);
 
 	trace_fuse_iomap_init_inode(inode);
 }
@@ -1189,6 +1212,8 @@ void fuse_iomap_evict_inode(struct inode *inode)
 
 	if (fuse_inode_has_iomap(inode))
 		fuse_inode_clear_iomap(inode);
+	if (fuse_inode_has_atomic(inode))
+		fuse_inode_clear_atomic(inode);
 }
 
 ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to)
@@ -1383,6 +1408,17 @@ fuse_iomap_write_checks(
 	return kiocb_modified(iocb);
 }
 
+static inline ssize_t fuse_iomap_atomic_write_valid(struct kiocb *iocb,
+						    struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (iov_iter_count(from) != i_blocksize(inode))
+		return -EINVAL;
+
+	return generic_atomic_write_valid(iocb, from);
+}
+
 ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
@@ -1399,6 +1435,12 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (!count)
 		return 0;
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		ret = fuse_iomap_atomic_write_valid(iocb, from);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * direct I/O must be aligned to the fsblock size or we fall back to
 	 * the old paths
@@ -1814,6 +1856,12 @@ ssize_t fuse_iomap_buffered_write(struct kiocb *iocb, struct iov_iter *from)
 	if (!iov_iter_count(from))
 		return 0;
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		ret = fuse_iomap_atomic_write_valid(iocb, from);
+		if (ret)
+			return ret;
+	}
+
 	ret = fuse_iomap_ilock_iocb(iocb, EXCL);
 	if (ret)
 		return ret;
@@ -2063,7 +2111,8 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 	struct fuse_iomap_support ios = { };
 
 	if (fuse_iomap_enabled())
-		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO;
+		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO |
+			    FUSE_IOMAP_SUPPORT_ATOMIC;
 
 	if (copy_to_user(argp, &ios, sizeof(ios)))
 		return -EFAULT;


