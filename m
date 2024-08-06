Return-Path: <linux-fsdevel+bounces-25181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F8594992B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 22:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04D81F23EA7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B1D16D9A3;
	Tue,  6 Aug 2024 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M19/5gMf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339EC16BE12;
	Tue,  6 Aug 2024 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976441; cv=none; b=YfwBxGDVGD9PePwuYhZ0ITVJtcvsU0+Unon2JucAkiTANnw+7R7HGWrDvFlkbomUuJqHEf1qpQK5vpQ34N7Fx4D5EGDZbRHJ+CWcOVX+VU3EIrzPDVaz0AYJgrocuXGL7buLyibTLAkB4VMZj9hKsvT1ON+MfFmMVjSTKWSHvsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976441; c=relaxed/simple;
	bh=jwYZyFVonBCcgA3xtSOFJjNT72e2XtxQf3pPEQ4zm6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tO7nsZBtGe9GCX1P28X53duRiZRZO4N1Oga0dATdmf7JEDhk1usFja9FlvvmAblohY4Pcwb2RaBFtfh7QgYocG6bv77ZSNWV8p7+aQwcm+8d5hpLuli6B2BIPGHknZHXnofBjX20CYK26esV2lRndmDNm6lP2b8u6adBSvTh1z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M19/5gMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FE4C4AF0E;
	Tue,  6 Aug 2024 20:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976441;
	bh=jwYZyFVonBCcgA3xtSOFJjNT72e2XtxQf3pPEQ4zm6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M19/5gMfmV7XKI8usn60hwWuTzUO1R/T9ocCs+aur8pTQsxBNd1tMInOGolgY0Q+o
	 /Cwc8Ck9tkcej5Fu8hHeUA7LqKjNum8sVBCR7LXEYdODt58U025aYjzW9EqCtTvIko
	 CYOy0qV+Zf+vx3ViDgS0QF6UuS2yB6O38zPsCn4jxL0Ai4wgKDy2tzPTm8WlTN9tpl
	 puLXQ5bqtC9S9yVo6dTyx0+6ny6/Xg22+siw1yD2OHktvJQysvUvC3CQqWD+e5J2UB
	 nhQF49Cwi8bcYqFt0m7mVZWlG1AHrB0lpSfqOhGdtF0WVMLo3uOYFlSS7O1tOChK/B
	 jquZWRwg4lauw==
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
Subject: [PATCH v3 bpf-next 1/3] bpf: Move bpf_get_file_xattr to fs/bpf_fs_kfuncs.c
Date: Tue,  6 Aug 2024 13:33:38 -0700
Message-ID: <20240806203340.3503805-2-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240806203340.3503805-1-song@kernel.org>
References: <20240806203340.3503805-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are putting all fs kfuncs in fs/bpf_fs_kfuncs.c. Move existing
bpf_get_file_xattr to it.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/bpf_fs_kfuncs.c       | 38 ++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 68 ----------------------------------------
 2 files changed, 38 insertions(+), 68 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 1e6e08667758..b13d00f7ad2b 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/mm.h>
+#include <linux/xattr.h>
 
 __bpf_kfunc_start_defs();
 
@@ -92,6 +93,42 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
 	return len;
 }
 
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
+	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
+	struct dentry *dentry;
+	u32 value_len;
+	void *value;
+	int ret;
+
+	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+		return -EPERM;
+
+	value_len = __bpf_dynptr_size(value_ptr);
+	value = __bpf_dynptr_data_rw(value_ptr, value_len);
+	if (!value)
+		return -EINVAL;
+
+	dentry = file_dentry(file);
+	ret = inode_permission(&nop_mnt_idmap, dentry->d_inode, MAY_READ);
+	if (ret)
+		return ret;
+	return __vfs_getxattr(dentry, dentry->d_inode, name__str, value, value_len);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -99,6 +136,7 @@ BTF_ID_FLAGS(func, bpf_get_task_exe_file,
 	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cd098846e251..d557bb11e0ff 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -24,7 +24,6 @@
 #include <linux/key.h>
 #include <linux/verification.h>
 #include <linux/namei.h>
-#include <linux/fileattr.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1439,73 +1438,6 @@ static int __init bpf_key_sig_kfuncs_init(void)
 late_initcall(bpf_key_sig_kfuncs_init);
 #endif /* CONFIG_KEYS */
 
-/* filesystem kfuncs */
-__bpf_kfunc_start_defs();
-
-/**
- * bpf_get_file_xattr - get xattr of a file
- * @file: file to get xattr from
- * @name__str: name of the xattr
- * @value_p: output buffer of the xattr value
- *
- * Get xattr *name__str* of *file* and store the output in *value_ptr*.
- *
- * For security reasons, only *name__str* with prefix "user." is allowed.
- *
- * Return: 0 on success, a negative value on error.
- */
-__bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
-				   struct bpf_dynptr *value_p)
-{
-	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
-	struct dentry *dentry;
-	u32 value_len;
-	void *value;
-	int ret;
-
-	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
-		return -EPERM;
-
-	value_len = __bpf_dynptr_size(value_ptr);
-	value = __bpf_dynptr_data_rw(value_ptr, value_len);
-	if (!value)
-		return -EINVAL;
-
-	dentry = file_dentry(file);
-	ret = inode_permission(&nop_mnt_idmap, dentry->d_inode, MAY_READ);
-	if (ret)
-		return ret;
-	return __vfs_getxattr(dentry, dentry->d_inode, name__str, value, value_len);
-}
-
-__bpf_kfunc_end_defs();
-
-BTF_KFUNCS_START(fs_kfunc_set_ids)
-BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
-BTF_KFUNCS_END(fs_kfunc_set_ids)
-
-static int bpf_get_file_xattr_filter(const struct bpf_prog *prog, u32 kfunc_id)
-{
-	if (!btf_id_set8_contains(&fs_kfunc_set_ids, kfunc_id))
-		return 0;
-
-	/* Only allow to attach from LSM hooks, to avoid recursion */
-	return prog->type != BPF_PROG_TYPE_LSM ? -EACCES : 0;
-}
-
-static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
-	.owner = THIS_MODULE,
-	.set = &fs_kfunc_set_ids,
-	.filter = bpf_get_file_xattr_filter,
-};
-
-static int __init bpf_fs_kfuncs_init(void)
-{
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
-}
-
-late_initcall(bpf_fs_kfuncs_init);
-
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
-- 
2.43.5


