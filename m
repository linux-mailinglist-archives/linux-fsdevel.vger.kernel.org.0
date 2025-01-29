Return-Path: <linux-fsdevel+bounces-40337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3E1A2254F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 22:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA180188661E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 21:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021491E2838;
	Wed, 29 Jan 2025 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bf5QbhAI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F00042A92;
	Wed, 29 Jan 2025 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738184417; cv=none; b=C2sIXHvJ0BJEHTCcY/beZcEbNwFxd5GNDFnI12nhlpPa7FCWsfWPm7eVdMnxUP90F3nUTggS8C11EvVil7UZK/gOvFNCkASvQtANcULtHEi2yNlBy6o1yTbIg6KJ8MNFvFulJxOA3xQbAIo4F8perCpDYJRAAumCMfDH2BFAxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738184417; c=relaxed/simple;
	bh=5LaYnZ+gbcvsP52hIhnW1K3ketWNyG+MdzJx0uYzW8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGZb3xAXGUW4IfNzHKC9amzUd89eSqGL5Xvs5U7D+ewm0rUmgGj5ObIbRb3kZB2pi/DBFwc3xhfdRvrl0NmY+VuZ1egWTjmqKjGDqNsOS6vmID7LdgcXlYjbiiSPi6z852kMCJYyaM2oWUC6XTehZ7XkZPEzvygu0FSASzq7C5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bf5QbhAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C7FC4CED1;
	Wed, 29 Jan 2025 21:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738184413;
	bh=5LaYnZ+gbcvsP52hIhnW1K3ketWNyG+MdzJx0uYzW8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bf5QbhAIJaxl+OX1MIqQlqnjPVDuEEoLWVSqwRB6eQ1mZfiPpBdQLPCASO2U2w5qp
	 MtrpJrzVFybXpuk7hgmlQDWOvaIEJfMq/3BPFr8lfNVXSHYQvNeJCkSrRAAUaLQuP+
	 4sS6ax/OeXD/0+QpxRKK6hywCThxAo/93zeBBEM62JfjSLrwqWLUstdOunitKqp269
	 Lk/y7RDai72Bq+6hm+x/xdfjrZVeC0jk1WOp50JBc2B3dJt5Bwh5l3gjLd4Ue0QkXC
	 TY9aOkQ34atUdwEf4jI3+blbz012RMpQK8fOHOsdfdeOPsraVfjeEmaOBuVkDMGHrk
	 HWkEGQ+SiUMBg==
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
Subject: [PATCH v11 bpf-next 1/7] fs/xattr: bpf: Introduce security.bpf. xattr name prefix
Date: Wed, 29 Jan 2025 12:59:51 -0800
Message-ID: <20250129205957.2457655-2-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250129205957.2457655-1-song@kernel.org>
References: <20250129205957.2457655-1-song@kernel.org>
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


