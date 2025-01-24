Return-Path: <linux-fsdevel+bounces-40077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D887BA1BD6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 21:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29192167B1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605B922576C;
	Fri, 24 Jan 2025 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2YZn8G/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD383224B1C;
	Fri, 24 Jan 2025 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737750574; cv=none; b=PBSgHmM+Do0y38SpTNcutFdYU8RZL9Z8tj826sJyqyyI2No/nrTiogMiUl55bvpDXlFYc2wlL806yMWJv0gXlLMoZouMexNvExRqCoTaiSnHg/vfIXryqVHolZ6qcEPvml4tA6rTGt5kapd1CnU7eRNuXLkEuPtKPbiK54yT/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737750574; c=relaxed/simple;
	bh=5LaYnZ+gbcvsP52hIhnW1K3ketWNyG+MdzJx0uYzW8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uT6CApQW2ZP3QkY504NGMU0dhwnp7tgsBp7aXmBV9nSANACb44e6JPl3PN4QQForKkqrT6+6SliPsfWhBFJCkRLp6Qc24u/FIhX3Y92Urk96qS52wDa5ZxhXrbaEfO8tzA9T3n57SFeaFOvjRIKP5a/MSmXI3oM09tlvqaWpbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2YZn8G/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60347C4CED2;
	Fri, 24 Jan 2025 20:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737750574;
	bh=5LaYnZ+gbcvsP52hIhnW1K3ketWNyG+MdzJx0uYzW8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b2YZn8G/yryXY5hbb5fA/ugPjKBspN894mWv88Mw5WfP8lvLH+T2xuXKtrE2oYCqk
	 yj5xvjhK4H5SNi6sNpiRlbvj9KmO3SQAD5mpqFrz1OAeQ34jepkQ682GT10rVjxe2P
	 45U0iUlzskGilpRkcJxBUg5eoQzuqRpDeWOKu713zU9Fi6ZDFzEnOnbkc4eEavT+vO
	 58ylaKF14dm13YpRMDzgmSaiSfLL9pHRz7onSqYxrdtcS7I4SHVOVbYpvDuzRdAYlj
	 j6CF2Go4oCCfhiRIWlySFYsux8TdCKm6mpXkSQq9XI7SjdrTvc716YjdeVT6Y2988q
	 OVDLuLWP5bz+A==
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
Subject: [PATCH v10 bpf-next 1/7] fs/xattr: bpf: Introduce security.bpf. xattr name prefix
Date: Fri, 24 Jan 2025 12:29:05 -0800
Message-ID: <20250124202911.3264715-2-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250124202911.3264715-1-song@kernel.org>
References: <20250124202911.3264715-1-song@kernel.org>
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


