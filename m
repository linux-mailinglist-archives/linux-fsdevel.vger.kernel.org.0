Return-Path: <linux-fsdevel+bounces-61534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5256B589AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA34188DE09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FF213D521;
	Tue, 16 Sep 2025 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWC6YPR2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828F7483;
	Tue, 16 Sep 2025 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982901; cv=none; b=YKxj3aBuFokcRkj0HgVd3IAoqbTLCKJBenqnfupjR+lmw/rWMGJkVsLaYJA16w9qLkp55VbvnB1v4F5ktBcpob1VwE7tmcZwCbRBJN/jXhmG4uCONAv+fOvseilvIul6ulykrGX7KcPzd+m0FhuPPDhOw1GeP6E7zEwuJ4L/agQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982901; c=relaxed/simple;
	bh=W1MmX3L1D4wX5nZmIvMfWWnYJf7kDuJqMweOYu8eOnk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2p4U+2em/ZLomaGZSDBxZa/W2JmemMpjOOfnxIaQJgb4yOJeYsDiz+QQXls+iQZ3oOHIYAtsJx6jvFVwGa/yItczUTkYnWDv3LeUtVexVcmYfh3cy5uRY5HAdozNXN1646yko2MLPPWOnrArp3YhTUvJfv2qofyU7Ndq0r5ULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWC6YPR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AD5C4CEF1;
	Tue, 16 Sep 2025 00:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982901;
	bh=W1MmX3L1D4wX5nZmIvMfWWnYJf7kDuJqMweOYu8eOnk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bWC6YPR2zYAiTyNWV1WXdGQS1dm3s3TPjzl59kP0rRsFCbQh800+y+UmgGcTxUXa6
	 pPp0oJqhb+fwVLmHfah8zYVdqE9rBuXLiVrNWTbBPxABrEFW8ss9ztFnh+vGNH9UWQ
	 JNN+UvXF2iFaIQhKDp6SvhXRMJxeElexzVPkAmlQ9Ms774wfNWAeWdpEhZ5YUuNUvu
	 EFpLwveOAhKYP6oxRllHiVqKbcOaunY7oMiMnZfAkj+kz0m3Gp8FD8VZ9WFUvLPoL7
	 sTx4RidX10J/HCxA0Bg7X34p6OpLq1R+XbFz46wbT+yv2cVOizxkjJ1Sl88bgivhgt
	 ri67WiM9906pw==
Date: Mon, 15 Sep 2025 17:35:00 -0700
Subject: [PATCH 27/28] fuse: support atomic writes with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151844.382724.3412141189356675838.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
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
 include/uapi/linux/fuse.h |    5 +++++
 fs/fuse/file_iomap.c      |   50 ++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 66 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 02af28f49cdfe5..777826115d3e80 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -259,6 +259,8 @@ enum {
 	FUSE_I_CACHE_IO_MODE,
 	/* Use iomap for this inode */
 	FUSE_I_IOMAP,
+	/* Enable untorn writes */
+	FUSE_I_ATOMIC,
 };
 
 struct fuse_conn;
@@ -1765,6 +1767,13 @@ static inline bool fuse_inode_has_iomap(const struct inode *inode)
 	return test_bit(FUSE_I_IOMAP, &fi->state);
 }
 
+static inline bool fuse_inode_has_atomic(const struct inode *inode)
+{
+	const struct fuse_inode *fi = get_fuse_inode_c(inode);
+
+	return test_bit(FUSE_I_ATOMIC, &fi->state);
+}
+
 int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		      u64 start, u64 length);
 loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index b1c45abe40b440..1befea65d4b15c 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -326,6 +326,7 @@ TRACE_DEFINE_ENUM(FUSE_I_BAD);
 TRACE_DEFINE_ENUM(FUSE_I_BTIME);
 TRACE_DEFINE_ENUM(FUSE_I_CACHE_IO_MODE);
 TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
+TRACE_DEFINE_ENUM(FUSE_I_ATOMIC);
 
 #define FUSE_IFLAG_STRINGS \
 	{ 1 << FUSE_I_ADVISE_RDPLUS,		"advise_rdplus" }, \
@@ -334,7 +335,8 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
 	{ 1 << FUSE_I_BAD,			"bad" }, \
 	{ 1 << FUSE_I_BTIME,			"btime" }, \
 	{ 1 << FUSE_I_CACHE_IO_MODE,		"cacheio" }, \
-	{ 1 << FUSE_I_IOMAP,			"iomap" }
+	{ 1 << FUSE_I_IOMAP,			"iomap" }, \
+	{ 1 << FUSE_I_ATOMIC,			"atomic" }
 
 #define IOMAP_IOEND_STRINGS \
 	{ IOMAP_IOEND_SHARED,			"shared" }, \
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e0139fb43f82ea..472605d7ff6a2f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -241,6 +241,7 @@
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
+ *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -595,10 +596,12 @@ struct fuse_file_lock {
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
@@ -1158,6 +1161,8 @@ struct fuse_backing_map {
 
 /* basic file I/O functionality through iomap */
 #define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 0)
+/* untorn writes through iomap */
+#define FUSE_IOMAP_SUPPORT_ATOMIC	(1ULL << 1)
 struct fuse_iomap_support {
 	uint64_t	flags;
 	uint64_t	padding;
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index a71de4ea5eb32d..30db4079ab8a55 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1099,12 +1099,32 @@ static inline void fuse_inode_clear_iomap(struct inode *inode)
 	clear_bit(FUSE_I_IOMAP, &fi->state);
 }
 
+static inline void fuse_inode_set_atomic(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	set_bit(FUSE_I_ATOMIC, &fi->state);
+}
+
+static inline void fuse_inode_clear_atomic(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(fuse_inode_has_iomap(inode));
+
+	clear_bit(FUSE_I_ATOMIC, &fi->state);
+}
+
 void fuse_iomap_init_inode(struct inode *inode, unsigned attr_flags)
 {
 	struct fuse_conn *conn = get_fuse_conn(inode);
 
 	if (conn->iomap && (attr_flags & FUSE_ATTR_IOMAP))
 		fuse_inode_set_iomap(inode);
+	if (fuse_inode_has_iomap(inode) && (attr_flags & FUSE_ATTR_ATOMIC))
+		fuse_inode_set_atomic(inode);
 
 	trace_fuse_iomap_init_inode(inode);
 }
@@ -1113,6 +1133,8 @@ void fuse_iomap_evict_inode(struct inode *inode)
 {
 	trace_fuse_iomap_evict_inode(inode);
 
+	if (fuse_inode_has_atomic(inode))
+		fuse_inode_clear_atomic(inode);
 	if (fuse_inode_has_iomap(inode))
 		fuse_inode_clear_iomap(inode);
 }
@@ -1191,6 +1213,8 @@ void fuse_iomap_open(struct inode *inode, struct file *file)
 	ASSERT(fuse_inode_has_iomap(inode));
 
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+	if (fuse_inode_has_atomic(inode))
+		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 }
 
 enum fuse_ilock_type {
@@ -1397,6 +1421,17 @@ fuse_iomap_write_checks(
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
@@ -1412,6 +1447,12 @@ ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *from)
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
@@ -1819,6 +1860,12 @@ ssize_t fuse_iomap_buffered_write(struct kiocb *iocb, struct iov_iter *from)
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
@@ -2042,7 +2089,8 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 	struct fuse_iomap_support ios = { };
 
 	if (fuse_iomap_enabled())
-		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO;
+		ios.flags = FUSE_IOMAP_SUPPORT_FILEIO |
+			    FUSE_IOMAP_SUPPORT_ATOMIC;
 
 	if (copy_to_user(argp, &ios, sizeof(ios)))
 		return -EFAULT;


