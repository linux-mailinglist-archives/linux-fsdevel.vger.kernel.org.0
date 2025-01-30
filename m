Return-Path: <linux-fsdevel+bounces-40443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17571A236C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E4D7A1519
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9A41F193C;
	Thu, 30 Jan 2025 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSq0tlZc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC0814A099;
	Thu, 30 Jan 2025 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738272972; cv=none; b=rbnbRA8MWpuTx7R+niCbVIWVUNil5huk/7coxSmiKTQu7hqJ/D7PQyfBKyhc9dxbucGbZc1i2DH3nKaITZCNYZQ0asxCXfTd/mvTgvzqzDLQ2RhHDUW/okUpP4EMuMuaqv+2CEuMWUxCQ1cO6DwBW18RiPXFL7lhUjJqOhvHryM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738272972; c=relaxed/simple;
	bh=H5GEx+worDd8tB0hkG/tnGIycbOtMqFJiMcNHVGYbAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5gBdH4kUOUJeRbNje7tMQGDQCPnO5A80rVKT6epmCJ5IEWxjICemz2TEE1nTUoLxp9VI6RXJWE0aRI38gKysSrToDdIaZpuAO5b8JPBA3f7HjaPyzwnSVvn7b4gsLpMJ/4BxygyjJTB9Fngf4GXon/Hy8B6ajEVXuSRd89G0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSq0tlZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C76C4CED2;
	Thu, 30 Jan 2025 21:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738272972;
	bh=H5GEx+worDd8tB0hkG/tnGIycbOtMqFJiMcNHVGYbAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSq0tlZcFjt0M1rEcgtaYubNvkS1fwJbfOyx7yn+uzpX9pkEtRUKeLpPx7WuCu12P
	 h0LflgONVcvUNQ16N24hgPJCX7t7v/sOLBmFen7juLG5SLNrZa6l/bjOnVWgnS6Vq5
	 MIp1EmCtxw74o7Ch0Ya24YuO6G/JaOgacM/NG/ezbJADWj98lNlK6Ud5dQ0tYrNEg4
	 8SYke/ZaaD9nxdK+yWGBZ5R0RQOQ5rH067isKl86vrH9uG+RBLvo0zWeDCp4SgY/3e
	 TbGABph9a/v5Isw5Y+vw/4UeBz8LI99GCja4CEbXxIrWPF5oYqbH954oFS/XTQgIAF
	 GwjCPfOvelpEg==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
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
	liamwisehart@meta.com,
	shankaran@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v12 bpf-next 1/5] fs/xattr: bpf: Introduce security.bpf. xattr name prefix
Date: Thu, 30 Jan 2025 13:35:45 -0800
Message-ID: <20250130213549.3353349-2-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250130213549.3353349-1-song@kernel.org>
References: <20250130213549.3353349-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduct new xattr name prefix security.bpf., and enable reading these
xattrs from bpf kfuncs bpf_get_[file|dentry]_xattr().

As we are on it, correct the comments for return value of
bpf_get_[file|dentry]_xattr(), i.e. return length the xattr value on
success.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
---
 fs/bpf_fs_kfuncs.c         | 36 +++++++++++++++++++++++++-----------
 include/uapi/linux/xattr.h |  4 ++++
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 3fe9f59ef867..db5c8e855517 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -93,6 +93,24 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
 	return len;
 }
 
+static bool match_security_bpf_prefix(const char *name__str)
+{
+	return !strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN);
+}
+
+static int bpf_xattr_read_permission(const char *name, struct inode *inode)
+{
+	if (WARN_ON(!inode))
+		return -EINVAL;
+
+	/* Allow reading xattr with user. and security.bpf. prefix */
+	if (strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
+	    !match_security_bpf_prefix(name))
+		return -EPERM;
+
+	return inode_permission(&nop_mnt_idmap, inode, MAY_READ);
+}
+
 /**
  * bpf_get_dentry_xattr - get xattr of a dentry
  * @dentry: dentry to get xattr from
@@ -101,9 +119,10 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
  *
  * Get xattr *name__str* of *dentry* and store the output in *value_ptr*.
  *
- * For security reasons, only *name__str* with prefix "user." is allowed.
+ * For security reasons, only *name__str* with prefixes "user." or
+ * "security.bpf." are allowed.
  *
- * Return: 0 on success, a negative value on error.
+ * Return: length of the xattr value on success, a negative value on error.
  */
 __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__str,
 				     struct bpf_dynptr *value_p)
@@ -114,18 +133,12 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
 	void *value;
 	int ret;
 
-	if (WARN_ON(!inode))
-		return -EINVAL;
-
-	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
-		return -EPERM;
-
 	value_len = __bpf_dynptr_size(value_ptr);
 	value = __bpf_dynptr_data_rw(value_ptr, value_len);
 	if (!value)
 		return -EINVAL;
 
-	ret = inode_permission(&nop_mnt_idmap, inode, MAY_READ);
+	ret = bpf_xattr_read_permission(name__str, inode);
 	if (ret)
 		return ret;
 	return __vfs_getxattr(dentry, inode, name__str, value, value_len);
@@ -139,9 +152,10 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
  *
  * Get xattr *name__str* of *file* and store the output in *value_ptr*.
  *
- * For security reasons, only *name__str* with prefix "user." is allowed.
+ * For security reasons, only *name__str* with prefixes "user." or
+ * "security.bpf." are allowed.
  *
- * Return: 0 on success, a negative value on error.
+ * Return: length of the xattr value on success, a negative value on error.
  */
 __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 				   struct bpf_dynptr *value_p)
diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index 9854f9cff3c6..c7c85bb504ba 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -83,6 +83,10 @@ struct xattr_args {
 #define XATTR_CAPS_SUFFIX "capability"
 #define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
 
+#define XATTR_BPF_LSM_SUFFIX "bpf."
+#define XATTR_NAME_BPF_LSM (XATTR_SECURITY_PREFIX XATTR_BPF_LSM_SUFFIX)
+#define XATTR_NAME_BPF_LSM_LEN (sizeof(XATTR_NAME_BPF_LSM) - 1)
+
 #define XATTR_POSIX_ACL_ACCESS  "posix_acl_access"
 #define XATTR_NAME_POSIX_ACL_ACCESS XATTR_SYSTEM_PREFIX XATTR_POSIX_ACL_ACCESS
 #define XATTR_POSIX_ACL_DEFAULT  "posix_acl_default"
-- 
2.43.5


