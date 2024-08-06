Return-Path: <linux-fsdevel+bounces-25198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43319949BD2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 01:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DC51C220AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 23:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470E1176AAF;
	Tue,  6 Aug 2024 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/122gSf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5618D644;
	Tue,  6 Aug 2024 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722985758; cv=none; b=lRzKA2IaTtxRzKvzArF9xkD+JMCvUvJjgM2kkSVi/O9txf+0CWCCBHTfcS5yV/L0iqCE6g2JfMhYNYB0JurToduEmC4YX5wdc7Sc9171bY9QW1A2YMjjsKwlu3DSWp/edf4zfxVSZu6P881fZEJD4ec0KdhOjCFGXSXn5RRXV6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722985758; c=relaxed/simple;
	bh=jwYZyFVonBCcgA3xtSOFJjNT72e2XtxQf3pPEQ4zm6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPvGDtIY1Rmlf2SeTUjlIz/317wBdYP2VTq4VMGSY4sRI+mZsRjA9ApzZo+ANiMV+Rzo0evdHPPxoCEjshGGxeUZpVjRIKrNxJZgRl8rOL1R+MvbWLNx1QN+QoLqK6eV16X0Q0CRQHSf79OpsrTg4KpAJ3thuCz6hAfggrpQX1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/122gSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D5FC32786;
	Tue,  6 Aug 2024 23:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722985758;
	bh=jwYZyFVonBCcgA3xtSOFJjNT72e2XtxQf3pPEQ4zm6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/122gSfrsK8hCyPm8DiZLtD8Kp6wU196iVCdFZvq0HUoCrLAS8LwHLG6J60wMRgA
	 cZYXhBdZOpK/Xt5Ygy0/5N/8ei0GUx7GyRoQWV4Qrn1MdSeuqR/uis5Kw9Dn/WjEae
	 nHERAoDiShKoG5+caJRWKgXRalV5yDpdX0WiRmNrPBHeU/ZVN+P67jLRaWbkPuY3hv
	 CRqBqrBprRDRFU7pFvsfTejxjN2xZpySsrtakyINj1DzdOhb6itfjDIugpBY6kyi2a
	 JKKCbCmJmYn9LlzDc/Bl2bRc7WQVpFdlh9lPskCgB6E3w7+aEd0t2sb+6KZlTeHh6u
	 Jn81JbybRI5MA==
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
Subject: [PATCH v4 bpf-next 1/3] bpf: Move bpf_get_file_xattr to fs/bpf_fs_kfuncs.c
Date: Tue,  6 Aug 2024 16:09:02 -0700
Message-ID: <20240806230904.71194-2-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240806230904.71194-1-song@kernel.org>
References: <20240806230904.71194-1-song@kernel.org>
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


