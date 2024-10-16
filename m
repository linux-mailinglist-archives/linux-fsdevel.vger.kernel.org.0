Return-Path: <linux-fsdevel+bounces-32068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8269A022E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 09:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A36B2484B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 07:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEFB1C07E6;
	Wed, 16 Oct 2024 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs1JD7F3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5D433CE;
	Wed, 16 Oct 2024 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729062612; cv=none; b=pgYRiR+C8g7rqvpMLJCxKziXrxpi8a9hXmQwCjDlpleEkC/w5Ae67zn6j/O8QLFffYdnalHR4bzgVTTDyDEWejOqDhW8RMOv5Mgro66NzTsD+/VNIPGsoWl09RUzbiGREyaIQMsWlUi5+6SqeKJuJ7PzV6BZSXnX3mmmlIprr1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729062612; c=relaxed/simple;
	bh=qjkUQnj7X1HSIZmhhRqEIfNPxQwTNUIMw0n/JwW80xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxXJ+1JeMpOaNvlxtyaJ+r6/Fmb67FSoOPpD7tZw1zCL6VXMsDAoiCSyP/j25/K4/fasgEGyEr81OXSe1hwAJv3uOXvYqAlJgVdz9fJtIe9v3BEfbnX1Ra2KZiVvvp7qm0ppu/SXLgB9Bfwhy5MWNVMv720b79AWNPxRo+9zyHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs1JD7F3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F7FC4CEC5;
	Wed, 16 Oct 2024 07:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729062611;
	bh=qjkUQnj7X1HSIZmhhRqEIfNPxQwTNUIMw0n/JwW80xA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cs1JD7F3Ya0WX27sQO00tIeWSoSSVq2+1upGoN9hEAxGW+57HboIXbHAs0l/u8jSV
	 xS4+Lv42AXmH3SK13nRJSLOeQPUJSyGIctZ6uYYgR6yu8w8y2Xf440NehS4AQyH+XR
	 0dCWS9Prgf3IGUOagl1rwO/Jag5/EvevvaD4IlM6oIZUE0SpK/Zo/AWujxPfbckeup
	 phn9+0yxNdhpmfwFtWTroAM9TfVz63BB10c8fzEfEBhw5hUz5aonFdWBx1ZM4cb2v8
	 omGqXZY2XtHiQP0U/vJ/A4gcSq2aaEPEE51e92nymdPLZi4Qo2XjtmAvd0n3lrYgz6
	 IPxDa5QzCypOw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 1/2] fs/xattr: bpf: Introduce security.bpf xattr name prefix
Date: Wed, 16 Oct 2024 00:09:54 -0700
Message-ID: <20241016070955.375923-2-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241016070955.375923-1-song@kernel.org>
References: <20241016070955.375923-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduct new xattr name prefix security.bpf, and enable reading these
xattrs from bpf kfuncs bpf_get_[file|dentry]_xattr(). Note that
"security.bpf" could be the name of the xattr or the prefix of the
name. For example, both "security.bpf" and "security.bpf.xxx" are
valid xattr name; while "security.bpfxxx" is not valid.

As we are on it, correct the comments for return value of
bpf_get_[file|dentry]_xattr(), i.e. return length the xattr value on
successl.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 fs/bpf_fs_kfuncs.c         | 29 ++++++++++++++++++++++++-----
 include/uapi/linux/xattr.h |  4 ++++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 3fe9f59ef867..be78a13f1d82 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -93,6 +93,23 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
 	return len;
 }
 
+static bool bpf_xattr_name_allowed(const char *name__str)
+{
+	/* Allow xattr names with user. prefix */
+	if (!strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+		return true;
+
+	/* Allow security.bpf. prefix or just security.bpf */
+	if (!strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN) &&
+	    (name__str[XATTR_NAME_BPF_LSM_LEN] == '\0' ||
+	     name__str[XATTR_NAME_BPF_LSM_LEN] == '.')) {
+		return true;
+	}
+
+	/* Disallow anything else */
+	return false;
+}
+
 /**
  * bpf_get_dentry_xattr - get xattr of a dentry
  * @dentry: dentry to get xattr from
@@ -101,9 +118,10 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
  *
  * Get xattr *name__str* of *dentry* and store the output in *value_ptr*.
  *
- * For security reasons, only *name__str* with prefix "user." is allowed.
+ * For security reasons, only *name__str* with prefix "user." or
+ * "security.bpf" is allowed.
  *
- * Return: 0 on success, a negative value on error.
+ * Return: length of the xattr value on success, a negative value on error.
  */
 __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__str,
 				     struct bpf_dynptr *value_p)
@@ -117,7 +135,7 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
 	if (WARN_ON(!inode))
 		return -EINVAL;
 
-	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+	if (!bpf_xattr_name_allowed(name__str))
 		return -EPERM;
 
 	value_len = __bpf_dynptr_size(value_ptr);
@@ -139,9 +157,10 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
  *
  * Get xattr *name__str* of *file* and store the output in *value_ptr*.
  *
- * For security reasons, only *name__str* with prefix "user." is allowed.
+ * For security reasons, only *name__str* with prefix "user." or
+ * "security.bpf" is allowed.
  *
- * Return: 0 on success, a negative value on error.
+ * Return: length of the xattr value on success, a negative value on error.
  */
 __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 				   struct bpf_dynptr *value_p)
diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index 9463db2dfa9d..166ef2f1f1b3 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -76,6 +76,10 @@
 #define XATTR_CAPS_SUFFIX "capability"
 #define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
 
+#define XATTR_BPF_LSM_SUFFIX "bpf"
+#define XATTR_NAME_BPF_LSM (XATTR_SECURITY_PREFIX XATTR_BPF_LSM_SUFFIX)
+#define XATTR_NAME_BPF_LSM_LEN (sizeof(XATTR_NAME_BPF_LSM) - 1)
+
 #define XATTR_POSIX_ACL_ACCESS  "posix_acl_access"
 #define XATTR_NAME_POSIX_ACL_ACCESS XATTR_SYSTEM_PREFIX XATTR_POSIX_ACL_ACCESS
 #define XATTR_POSIX_ACL_DEFAULT  "posix_acl_default"
-- 
2.43.5


