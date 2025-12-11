Return-Path: <linux-fsdevel+bounces-71127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAF7CB650A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 16:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6EDF30210C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70F730ACF1;
	Thu, 11 Dec 2025 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mehz8o2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E001305045;
	Thu, 11 Dec 2025 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765466513; cv=none; b=B4Hdg4w2Jjnr6gxideFTnV2QzGvuLlP+nigrzS0MT90oDGBt5r0OV8BZE3tG/Ze0DwWioIko8QS6gPwleZo6meWucEnP4JQPhDyORs36fOEYDgwkX79jYxb+o8I7+3/YoJ3pLtxsE5MLxFPbLuCg994AMX2vhb6drJESjuhbers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765466513; c=relaxed/simple;
	bh=ft1yumL/UkaBBj1cS/NCcXPiVJR2SF6VLxtN7WaKeTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bnp3gY5KknIJVwaim6BOtRq4tJdA7ysUqaG72OE7OusRuuWi7gnsM5RifmPe8zZhTWBiWD03BBhGgOH0CzUQNn24agg7RaIirwlc1DO4AP3vZs286AhcAwu+YIhptOpcrkL/lr3T3C/7svRITsWMfHqrUzITvPidbisTyQgpLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mehz8o2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4213EC19421;
	Thu, 11 Dec 2025 15:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765466513;
	bh=ft1yumL/UkaBBj1cS/NCcXPiVJR2SF6VLxtN7WaKeTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mehz8o2kBU6vMgGJuuHn+eGoQQS90Rfjka5NEBL1VX1BkBl5C6TPvCN6eJ8ZpZN9Q
	 uRHTagEO0pQg8mHAzi4nGA7RxCvdLIh3nkgwNxpmBdiGX1zzg9wDzO/935sPZamssa
	 1X3GhUBLxEAf38kWrGLMGdtLyAyrc+4MVYJB06k9chBivfCf/YjImcjflNf1RpuXOf
	 UqcEHKB8Ms0oMlNlHDsugtCh/YYSwaFDjh3XVCXmAkTqb79CDJ3QnDdBrx4IVhERct
	 S21JK2gaqq+5JEARBHJaPzmGN3/pSTzLcgP4y1nvo/JpCEy+Z8iKizA3YoKGRMMkUc
	 b/okq6Wrm6Xeg==
From: Chuck Lever <cel@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	linux-ext4@vger.kernel.org,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	hirofumi@mail.parknet.co.jp,
	almaz.alexandrovich@paragon-software.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	Volker.Lendecke@sernet.de,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 1/6] fs: Add case sensitivity info to file_kattr
Date: Thu, 11 Dec 2025 10:21:11 -0500
Message-ID: <20251211152116.480799-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211152116.480799-1-cel@kernel.org>
References: <20251211152116.480799-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Enable upper layers such as NFSD to retrieve case sensitivity
information from file systems by adding a case_info field to struct
file_kattr.

Add vfs_get_case_info() as a convenience helper for kernel
consumers. If a filesystem does not provide a fileattr_get hook, it
returns the default POSIX behavior (case-sensitive,
case-preserving), which is correct for the majority of Linux
file systems implementations.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/file_attr.c           | 31 +++++++++++++++++++++++++++++++
 include/linux/fileattr.h | 23 +++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 1dcec88c0680..609e890b5101 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -94,6 +94,37 @@ int vfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 }
 EXPORT_SYMBOL(vfs_fileattr_get);
 
+/**
+ * vfs_get_case_info - retrieve case sensitivity info for a filesystem
+ * @dentry:	the object to retrieve from
+ * @case_info:	pointer to store result
+ *
+ * Call i_op->fileattr_get() to retrieve case sensitivity information.
+ * If the filesystem does not provide a fileattr_get hook, return
+ * the default POSIX behavior (case-sensitive, case-preserving).
+ *
+ * Return: 0 on success, or a negative error on failure.
+ */
+int vfs_get_case_info(struct dentry *dentry, u32 *case_info)
+{
+	struct file_kattr fa = {};
+	int error;
+
+	/* Default: POSIX semantics (case-sensitive, case-preserving) */
+	*case_info = FILEATTR_CASEFOLD_NONE | FILEATTR_CASE_PRESERVING;
+
+	error = vfs_fileattr_get(dentry, &fa);
+	if (error == -ENOIOCTLCMD)
+		return 0;
+	if (error)
+		return error;
+
+	if (fa.case_info)
+		*case_info = fa.case_info;
+	return 0;
+}
+EXPORT_SYMBOL(vfs_get_case_info);
+
 static void fileattr_to_file_attr(const struct file_kattr *fa,
 				  struct file_attr *fattr)
 {
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index f89dcfad3f8f..55674d14f697 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -48,11 +48,33 @@ struct file_kattr {
 	u32	fsx_nextents;	/* nextents field value (get)	*/
 	u32	fsx_projid;	/* project identifier (get/set) */
 	u32	fsx_cowextsize;	/* CoW extsize field value (get/set)*/
+	u32	case_info;	/* case sensitivity behavior */
 	/* selectors: */
 	bool	flags_valid:1;
 	bool	fsx_valid:1;
 };
 
+/*
+ * Values for file_kattr.case_info.
+ */
+
+/* File name case is preserved at rest. */
+#define FILEATTR_CASE_PRESERVING	0x80000000
+
+/* Values stored in the low-order byte */
+enum fileattr_case_folding {
+	/* Code points are compared directly with no case folding. */
+	FILEATTR_CASEFOLD_NONE = 0,
+
+	/* ASCII case-insensitive: A-Z are treated as a-z. */
+	FILEATTR_CASEFOLD_ASCII,
+
+	/* Unicode case-insensitive matching. */
+	FILEATTR_CASEFOLD_UNICODE,
+};
+
+#define FILEATTR_CASEFOLD_TYPE		0x000000ff
+
 int copy_fsxattr_to_user(const struct file_kattr *fa, struct fsxattr __user *ufa);
 
 void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags);
@@ -75,6 +97,7 @@ static inline bool fileattr_has_fsx(const struct file_kattr *fa)
 int vfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 		     struct file_kattr *fa);
+int vfs_get_case_info(struct dentry *dentry, u32 *case_info);
 int ioctl_getflags(struct file *file, unsigned int __user *argp);
 int ioctl_setflags(struct file *file, unsigned int __user *argp);
 int ioctl_fsgetxattr(struct file *file, void __user *argp);
-- 
2.52.0


