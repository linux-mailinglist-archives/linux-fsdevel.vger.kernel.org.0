Return-Path: <linux-fsdevel+bounces-66029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ACCC17A78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDD8D4F57A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B822D6630;
	Wed, 29 Oct 2025 00:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkQMMiZL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602492773E9;
	Wed, 29 Oct 2025 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699120; cv=none; b=E8mJSySm4fbsaJNIzls7YIPlyzrYB84O2m+pQETLm1+wAEWOR7ehQs2eY39lGkNrKdplraKsoZCyJpDOyFcacPGuD+bSWnXuGiCjVryzOkOwh2IglYZgxy4g2iQN980PpfJ5PrzHR8deAKagpmeP1Y/oQiBTIy5Hf8AUNSY6xW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699120; c=relaxed/simple;
	bh=FpCfQG/VffBcfSwhsNzAUDrbMS88rAs1/P0QfcjwbKI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDEYxCCooCx0DqzcpSwYTWVLsCMVlIJyZXbSQCdlT3YHTz/Nz4nGC+yKquJJ36Fp/yjCkSda4iqkSzHdzibvDsw2+fMSOKVLTRzIFiiJAK6WIf4C4N5RNlPBZa1L/dH4YIF96809P2lpmYy0uzlwAKLKMSH257sYvXkqKppdByw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkQMMiZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37569C4CEE7;
	Wed, 29 Oct 2025 00:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699120;
	bh=FpCfQG/VffBcfSwhsNzAUDrbMS88rAs1/P0QfcjwbKI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XkQMMiZLncB0AR4Tm3LIh7D/PlHw6hHLVPb8Wr+PUyxGcMdB5F2w7It2U0DJdym8X
	 PpcOnNxXrSnaLgV8P4EAA4D+7vkUD/In/F60UY9Jkpv8N7/KSVyH2y9mLbXn+eWaI9
	 5Wzi2C36nNN/gjSmGzptP2klL+Cu4lC1vwHD7Y9Z0ofyeStfbs/aQO0TM4bcU3pwS2
	 Tthw0NAEt0+onzpHU6/FqAoxdfVSc2bI6q/bq1cDWe8p3UYarR5YKY1QW3j/5RxfjJ
	 t5Wqd+LgfbQ8PCc13nE63EcqDwfVzUSbl1MEDCZGnmnrvNBz+xyJllvIDi+Jf1JD0L
	 pxWUHjBPsqxEQ==
Date: Tue, 28 Oct 2025 17:51:59 -0700
Subject: [PATCH 27/31] fuse: support atomic writes with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810937.1424854.17545235254390180266.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Enable untorn writes of up to a single fsblock, if iomap is enabled.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    9 +++++++++
 include/uapi/linux/fuse.h |    5 +++++
 fs/fuse/file_iomap.c      |   46 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 59 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f6b6944fad553c..9ab1de8063c05e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -266,6 +266,8 @@ enum {
 	FUSE_I_EXCLUSIVE,
 	/* Use iomap for this inode */
 	FUSE_I_IOMAP,
+	/* Enable untorn writes */
+	FUSE_I_ATOMIC,
 };
 
 struct fuse_conn;
@@ -1768,6 +1770,13 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
 	return test_bit(FUSE_I_IOMAP, &fi->state);
 }
 
+static inline bool fuse_inode_has_atomic(const struct inode *inode)
+{
+	const struct fuse_inode *fi = get_fuse_inode(inode);
+
+	return test_bit(FUSE_I_ATOMIC, &fi->state);
+}
+
 int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		      u64 start, u64 length);
 loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 838d925d2947e0..99ad2367d1dc20 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -246,6 +246,7 @@
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
+ *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -600,10 +601,12 @@ struct fuse_file_lock {
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
@@ -1171,6 +1174,8 @@ struct fuse_backing_map {
 
 /* basic file I/O functionality through iomap */
 #define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 0)
+/* untorn writes through iomap */
+#define FUSE_IOMAP_SUPPORT_ATOMIC	(1ULL << 1)
 struct fuse_iomap_support {
 	uint64_t	flags;
 	uint64_t	padding;
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 06d1834e43f698..f4cb9dcde445ef 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1099,6 +1099,20 @@ static inline void fuse_inode_clear_iomap(struct inode *inode)
 	clear_bit(FUSE_I_IOMAP, &fi->state);
 }
 
+static inline void fuse_inode_set_atomic(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	set_bit(FUSE_I_ATOMIC, &fi->state);
+}
+
+static inline void fuse_inode_clear_atomic(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	clear_bit(FUSE_I_ATOMIC, &fi->state);
+}
+
 void fuse_iomap_init_nonreg_inode(struct inode *inode, unsigned attr_flags)
 {
 	struct fuse_conn *conn = get_fuse_conn(inode);
@@ -1122,6 +1136,8 @@ void fuse_iomap_init_reg_inode(struct inode *inode, unsigned attr_flags)
 	if (conn->iomap && (attr_flags & FUSE_ATTR_IOMAP)) {
 		set_bit(FUSE_I_EXCLUSIVE, &fi->state);
 		fuse_inode_set_iomap(inode);
+		if (attr_flags & FUSE_ATTR_ATOMIC)
+			fuse_inode_set_atomic(inode);
 	}
 
 	trace_fuse_iomap_init_inode(inode);
@@ -1134,6 +1150,8 @@ void fuse_iomap_evict_inode(struct inode *inode)
 
 	trace_fuse_iomap_evict_inode(inode);
 
+	if (fuse_inode_has_atomic(inode))
+		fuse_inode_clear_atomic(inode);
 	if (fuse_inode_has_iomap(inode))
 		fuse_inode_clear_iomap(inode);
 	if (conn->iomap && fuse_inode_is_exclusive(inode))
@@ -1214,6 +1232,8 @@ void fuse_iomap_open(struct inode *inode, struct file *file)
 	ASSERT(fuse_inode_has_iomap(inode));
 
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+	if (fuse_inode_has_atomic(inode))
+		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 }
 
 enum fuse_ilock_type {
@@ -1420,6 +1440,17 @@ fuse_iomap_write_checks(
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
@@ -1435,6 +1466,12 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (!count)
 		return 0;
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		ret = fuse_iomap_atomic_write_valid(iocb, from);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * Unaligned direct writes require zeroing of unwritten head and tail
 	 * blocks.  Extending writes require zeroing of post-EOF tail blocks.
@@ -1840,6 +1877,12 @@ ssize_t fuse_iomap_buffered_write(struct kiocb *iocb, struct iov_iter *from)
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
@@ -2063,7 +2106,8 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 	struct fuse_iomap_support ios = { };
 
 	if (fuse_iomap_enabled())
-		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO;
+		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO |
+			    FUSE_IOMAP_SUPPORT_ATOMIC;
 
 	if (copy_to_user(argp, &ios, sizeof(ios)))
 		return -EFAULT;


