Return-Path: <linux-fsdevel+bounces-37604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AECD49F43D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 07:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F2C16CBC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C506718D63A;
	Tue, 17 Dec 2024 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDJfcl6b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4C0170A15;
	Tue, 17 Dec 2024 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417517; cv=none; b=AE6I9DZPnXFwX058goU78omD7Ge+vI9RrCC5SJY6UViNdDpVGIYqaCQFWQChnz8bv92qMZgaRSygLOr+oXSbf9n1px3d2roM76c9Yzrp6Kfg79nyvaY1u5q0rnhArlSp3+HdwJQxBzxWzl7+CNKfr9dnLw9Rez9hpzjZ+AAArOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417517; c=relaxed/simple;
	bh=IJFC1v25WWLbFn6yORvMGUMUMr97ljm73SJMJjYoIY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rb0s5G57xtZwISfU9kaPiv4ZSF5HZkhTx24nXGmUtfEt1kWv5X3lBQpS/xEJ1+8c67T6buIdqnNianK2Al25QEacdR4fZdiUfIxunmoUCsLx4Z6bLI7RG8askBgb10CkSQz37nr7ybhi/qQF6PzBAgaIAuL+bFqBZaNkAiMnuHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDJfcl6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C5CC4CED3;
	Tue, 17 Dec 2024 06:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734417516;
	bh=IJFC1v25WWLbFn6yORvMGUMUMr97ljm73SJMJjYoIY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CDJfcl6bN2kNVWI+Oe/hwMPpWdXpZY0aBaYN4yQaItZBTcET49f34Kp2wkxQCNpp6
	 riFdsHTyvr6ENWfWJBe38Y5QIZ1+sV23sTelvrxOvI63Kv62tjHPOIV7tNaj/iPesr
	 rVrmmT1TWzMihd65bmP2YOHZzEskJEMEDCpS4u5hYXZUY3MRnWtOJY8ZVT+peSD6H3
	 4pysgRfXKKhDFH7OyuVuFMqilWr3xnCLh4KSyL3FrT6FLx9+a7b9TBY5P9bPtk7cW4
	 jjSDHo48J/VzuqijMlcbGU/MBhLVF7iGfzh9mPg8JSbLFPKBbiFdZT6zJwexVeL2l9
	 mbUPPG660Xr1A==
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
Subject: [PATCH v4 bpf-next 1/6] fs/xattr: bpf: Introduce security.bpf. xattr name prefix
Date: Mon, 16 Dec 2024 22:38:16 -0800
Message-ID: <20241217063821.482857-2-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241217063821.482857-1-song@kernel.org>
References: <20241217063821.482857-1-song@kernel.org>
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
---
 fs/bpf_fs_kfuncs.c         | 19 ++++++++++++++-----
 include/uapi/linux/xattr.h |  4 ++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 3fe9f59ef867..8a65184c8c2c 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -93,6 +93,11 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
 	return len;
 }
 
+static bool match_security_bpf_prefix(const char *name__str)
+{
+	return !strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN);
+}
+
 /**
  * bpf_get_dentry_xattr - get xattr of a dentry
  * @dentry: dentry to get xattr from
@@ -101,9 +106,10 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
  *
  * Get xattr *name__str* of *dentry* and store the output in *value_ptr*.
  *
- * For security reasons, only *name__str* with prefix "user." is allowed.
+ * For security reasons, only *name__str* with prefix "user." or
+ * "security.bpf." is allowed.
  *
- * Return: 0 on success, a negative value on error.
+ * Return: length of the xattr value on success, a negative value on error.
  */
 __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__str,
 				     struct bpf_dynptr *value_p)
@@ -117,7 +123,9 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
 	if (WARN_ON(!inode))
 		return -EINVAL;
 
-	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+	/* Allow reading xattr with user. and security.bpf. prefix */
+	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
+	    !match_security_bpf_prefix(name__str))
 		return -EPERM;
 
 	value_len = __bpf_dynptr_size(value_ptr);
@@ -139,9 +147,10 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
  *
  * Get xattr *name__str* of *file* and store the output in *value_ptr*.
  *
- * For security reasons, only *name__str* with prefix "user." is allowed.
+ * For security reasons, only *name__str* with prefix "user." or
+ * "security.bpf." is allowed.
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


