Return-Path: <linux-fsdevel+bounces-24641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDD1942344
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 01:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C0AB25458
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 23:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94201194149;
	Tue, 30 Jul 2024 23:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOpaoZG6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E870318DF62;
	Tue, 30 Jul 2024 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722380923; cv=none; b=sgu6XLpAlOExXIr8DI9+64jpm0i0Em6flk099gE708eu2dvcJgmSID8fXP76q3ORWyVyq7s95VH7cBUt0js8FRCwN1xtKJz6h4BkESBbRGxwAQtRlV9Iiq4fee6Jqu0STknrffu5+STykizRuDn+8Sr6iyp7bVmd5V0NRI3P+tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722380923; c=relaxed/simple;
	bh=0mco/AwJ18clzdrzQJjd8uBMHcSAGTc3tSetHaJYDWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRuh6qAxDipKPkYt28gP5W6Vtc2UwpCjzPp2GN8DO4OcxzZaT1yaZ723ubsC57sklPJ4gGqEL/7Lab7GamTdVJWMUuNBKWGmf5ZgofP+uf7wDTNkKZjQDEGDa1NiHxWwpYpUzrUfa16NeXdQmAwA4DmjD6/rLea/2lTmJP10jXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOpaoZG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87C5C32782;
	Tue, 30 Jul 2024 23:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722380922;
	bh=0mco/AwJ18clzdrzQJjd8uBMHcSAGTc3tSetHaJYDWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOpaoZG6ktUUZRgJEL9fPuauF/E7H+Ac1Sc7gYN6/Vc6W5DAFHpbvHIDmVvx9DPFL
	 0gM541sMw3GfdWXjIM5yYvuUNjZwWtUt0zmVP4n+GZ/YC63LttLLN0qMTOKcfc8KSS
	 mJaP7adF5s7vXqo7Fm4y3olsdoSMFKdrYA3U+rAuVJ1+ZAvFuG+wTalaedEbdr+JKQ
	 QUfo/grz3mz2V6JmN72fbu92PObfh5sWsh8b80L0pOXKh9v4ez2B/uWnNUF+Q+uQFY
	 xqqxk/YU7nA/yQ6EVxe3xu35OTIVIWDLrU5zUloR68RgNLSG6eTI3gUTqXl6H5ks0E
	 t6LjBq1GgCkPg==
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
	liamwisehart@meta.com,
	lltang@meta.com,
	shankaran@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 1/2] bpf: Add kfunc bpf_get_dentry_xattr() to read xattr from dentry
Date: Tue, 30 Jul 2024 16:08:04 -0700
Message-ID: <20240730230805.42205-2-song@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730230805.42205-1-song@kernel.org>
References: <20240730230805.42205-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This kfunc can be used in LSM hooks with dentry, such as:

  security_inode_listxattr
  security_inode_permission

and many more.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/trace/bpf_trace.c | 46 ++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cd098846e251..c62a00975f92 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1443,26 +1443,29 @@ late_initcall(bpf_key_sig_kfuncs_init);
 __bpf_kfunc_start_defs();
 
 /**
- * bpf_get_file_xattr - get xattr of a file
- * @file: file to get xattr from
+ * bpf_get_dentry_xattr - get xattr of a dentry
+ * @dentry: dentry to get xattr from
  * @name__str: name of the xattr
  * @value_p: output buffer of the xattr value
  *
- * Get xattr *name__str* of *file* and store the output in *value_ptr*.
+ * Get xattr *name__str* of *dentry* and store the output in *value_ptr*.
  *
  * For security reasons, only *name__str* with prefix "user." is allowed.
  *
  * Return: 0 on success, a negative value on error.
  */
-__bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
-				   struct bpf_dynptr *value_p)
+__bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__str,
+				     struct bpf_dynptr *value_p)
 {
 	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
-	struct dentry *dentry;
+	struct inode *inode = d_inode(dentry);
 	u32 value_len;
 	void *value;
 	int ret;
 
+	if (WARN_ON(!inode))
+		return -EINVAL;
+
 	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
 		return -EPERM;
 
@@ -1471,20 +1474,41 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 	if (!value)
 		return -EINVAL;
 
-	dentry = file_dentry(file);
-	ret = inode_permission(&nop_mnt_idmap, dentry->d_inode, MAY_READ);
+	ret = inode_permission(&nop_mnt_idmap, inode, MAY_READ);
 	if (ret)
 		return ret;
-	return __vfs_getxattr(dentry, dentry->d_inode, name__str, value, value_len);
+	return __vfs_getxattr(dentry, inode, name__str, value, value_len);
+}
+
+/**
+ * bpf_get_file_xattr - get xattr of a file
+ * @file: file to get xattr from
+ * @name__str: name of the xattr
+ * @value_p: output buffer of the xattr value
+ *
+ * Get xattr *name__str* of *file* and store the output in *value_ptr*.
+ *
+ * For security reasons, only *name__str* with prefix "user." is allowed.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
+				   struct bpf_dynptr *value_p)
+{
+	struct dentry *dentry;
+
+	dentry = file_dentry(file);
+	return bpf_get_dentry_xattr(dentry, name__str, value_p);
 }
 
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(fs_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(fs_kfunc_set_ids)
 
-static int bpf_get_file_xattr_filter(const struct bpf_prog *prog, u32 kfunc_id)
+static int fs_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
 	if (!btf_id_set8_contains(&fs_kfunc_set_ids, kfunc_id))
 		return 0;
@@ -1496,7 +1520,7 @@ static int bpf_get_file_xattr_filter(const struct bpf_prog *prog, u32 kfunc_id)
 static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set = &fs_kfunc_set_ids,
-	.filter = bpf_get_file_xattr_filter,
+	.filter = fs_kfunc_filter,
 };
 
 static int __init bpf_fs_kfuncs_init(void)
-- 
2.43.0


