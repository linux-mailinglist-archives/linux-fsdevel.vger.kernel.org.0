Return-Path: <linux-fsdevel+bounces-73732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1847D1F704
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C52A33025115
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402212F6184;
	Wed, 14 Jan 2026 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEor/8DU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACBC280331;
	Wed, 14 Jan 2026 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400947; cv=none; b=ms1oafNzNUa+a+gN18uPtnbdX9E3bGU4Nr5fwLlSZTFDvamXg8kSv5H74SYcmFaq8c9QGZY1ptJaz3caBFN5xsAANgz4aDO3cJTwLthdD3niroKv+5VRfF0GxqtWMLWMINcTySkSdGj9GxgeF4xDxBOm4gAsnwRyDASHeWGgyuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400947; c=relaxed/simple;
	bh=JM+3cMG6B8NA0iuUXm4oGZhY/McI+7luuVb2gvnc7FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gquJ5BnTXOu3F8hmi2gEujJy3yI4lK6J4oD4giSsftPdf0rAWSgb6V34ABr4rfUphNsqgRJWromT2lO+Cqn2crPiQ/Ex8hsgcyQ7vLWGDyJ1FPJ7uJ/j8gKRIaJd4H8uq+odVEHjSXxnyuuPHu/eoms2+jgpu3z7PPMwMf4OTlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEor/8DU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1129C19422;
	Wed, 14 Jan 2026 14:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768400947;
	bh=JM+3cMG6B8NA0iuUXm4oGZhY/McI+7luuVb2gvnc7FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WEor/8DU2qfPmoPVltEIdCnBhluYfw+cSbQL7sCPTr16T4ETQWQ7Fx3CYq1X6EYVd
	 P8O+h2p0rSGsu9vxPge/0c6iX2PqlCaeORxOfpnIhlIxHytFbPNcixdDatzopJAYOs
	 olQYhTFbtJg4etm+0+UYcflUqdrI4y9mMLqN8pfRoS5LVzFDC0lsxb6DgcoV8ZtyCE
	 bueAXkc4YTpinlDAysDL1daUqJVYl7jkUq4ZG80k4w7p7SUS6sdgqkpehKkgZ2GPGy
	 OHHaQFI+fA8g+H5NdW+lUoj3GzqqI4ShrJbYLRoJUzpIi70kVrw7Bobe8xCm+caqZs
	 GXXyDo3wJ1A/A==
From: Chuck Lever <cel@kernel.org>
To: vira@web.codeaurora.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: <linux-fsdevel@vger.kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	<linux-nfs@vger.kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	cem@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	trondmy@kernel.org,
	anna@kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	hansg@kernel.org,
	senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 01/16] fs: Add case sensitivity info to file_kattr
Date: Wed, 14 Jan 2026 09:28:44 -0500
Message-ID: <20260114142900.3945054-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114142900.3945054-1-cel@kernel.org>
References: <20260114142900.3945054-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Enable upper layers such as NFSD to retrieve case sensitivity
information from file systems by adding case_insensitive and
case_nonpreserving boolean fields to struct file_kattr.

These fields default to false (POSIX semantics: case-sensitive and
case-preserving), allowing filesystems to set them only when
behavior differs from the default.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/file_attr.c           | 14 ++++++++++++++
 include/linux/fileattr.h |  3 +++
 include/uapi/linux/fs.h  | 12 +++++++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 13cdb31a3e94..df4b2fc68532 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -84,6 +84,8 @@ int vfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	struct inode *inode = d_inode(dentry);
 	int error;
 
+	memset(fa, 0, sizeof(*fa));
+
 	if (!inode->i_op->fileattr_get)
 		return -ENOIOCTLCMD;
 
@@ -106,6 +108,10 @@ static void fileattr_to_file_attr(const struct file_kattr *fa,
 	fattr->fa_nextents = fa->fsx_nextents;
 	fattr->fa_projid = fa->fsx_projid;
 	fattr->fa_cowextsize = fa->fsx_cowextsize;
+	if (fa->case_insensitive)
+		fattr->fa_case_behavior |= FS_CASE_INSENSITIVE;
+	if (fa->case_nonpreserving)
+		fattr->fa_case_behavior |= FS_CASE_NONPRESERVING;
 }
 
 /**
@@ -382,6 +388,10 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 
 	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
 	BUILD_BUG_ON(sizeof(struct file_attr) != FILE_ATTR_SIZE_LATEST);
+	BUILD_BUG_ON(offsetofend(struct file_attr, fa_cowextsize) !=
+		     FILE_ATTR_SIZE_VER0);
+	BUILD_BUG_ON(offsetofend(struct file_attr, fa_reserved) !=
+		     FILE_ATTR_SIZE_VER1);
 
 	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
 		return -EINVAL;
@@ -439,6 +449,10 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
 
 	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
 	BUILD_BUG_ON(sizeof(struct file_attr) != FILE_ATTR_SIZE_LATEST);
+	BUILD_BUG_ON(offsetofend(struct file_attr, fa_cowextsize) !=
+		     FILE_ATTR_SIZE_VER0);
+	BUILD_BUG_ON(offsetofend(struct file_attr, fa_reserved) !=
+		     FILE_ATTR_SIZE_VER1);
 
 	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
 		return -EINVAL;
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index f89dcfad3f8f..086f28b90734 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -51,6 +51,9 @@ struct file_kattr {
 	/* selectors: */
 	bool	flags_valid:1;
 	bool	fsx_valid:1;
+	/* case sensitivity behavior: */
+	bool	case_insensitive:1;
+	bool	case_nonpreserving:1;
 };
 
 int copy_fsxattr_to_user(const struct file_kattr *fa, struct fsxattr __user *ufa);
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 66ca526cf786..07286d34b48b 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -229,10 +229,20 @@ struct file_attr {
 	__u32 fa_nextents;	/* nextents field value (get)   */
 	__u32 fa_projid;	/* project identifier (get/set) */
 	__u32 fa_cowextsize;	/* CoW extsize field value (get/set) */
+	/* VER1 additions: */
+	__u32 fa_case_behavior;	/* case sensitivity (get) */
+	__u32 fa_reserved;
 };
 
 #define FILE_ATTR_SIZE_VER0 24
-#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER0
+#define FILE_ATTR_SIZE_VER1 32
+#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER1
+
+/*
+ * Case sensitivity flags for fa_case_behavior
+ */
+#define FS_CASE_INSENSITIVE	0x00000001	/* case-insensitive lookups */
+#define FS_CASE_NONPRESERVING	0x00000002	/* case not preserved */
 
 /*
  * Flags for the fsx_xflags field
-- 
2.52.0


