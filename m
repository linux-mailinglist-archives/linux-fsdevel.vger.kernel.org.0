Return-Path: <linux-fsdevel+bounces-4125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF127FCBAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 01:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0DC1C20ECB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9171851
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFkodXLG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997571867;
	Wed, 29 Nov 2023 00:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BCBC433CB;
	Wed, 29 Nov 2023 00:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701218230;
	bh=xAQsFltWRuY31M8abBvgPt5UXdvlJMPnKwLRTvp2cCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFkodXLGNGJ7Ih/glEWR++c8k2oslzyuNDsxa6QiNFrx4DLe0XOjTM39z6cQEzyeV
	 d67DEcNRH704yU3W4ukUAY0iwtmvPxNxWZm4TaRsYGC0mtwmI9hegbicY0iimBeEd0
	 LFnKvH4vvBmpkS6016eIrrNY41w1JXatEEJdqM9TuKhLpkXSn00kHcPPqLSLwAWi7z
	 KAxBg32wq2i4l9PxYu0UjYdnIseXnHmLEUV2B44ZJZrjs06ym1FOSs3qVfl1xy7CVw
	 ve3AXo4GPNQFOJDGcH5T/OZXvebA308EK8jz5ANR5L1DnSTwUeT/+o7/wLEeZdbOXg
	 umSOAqS8AtnxQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: ebiggers@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	casey@schaufler-ca.com,
	amir73il@gmail.com,
	kpsingh@kernel.org,
	roberto.sassu@huawei.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v14 bpf-next 1/6] bpf: Add kfunc bpf_get_file_xattr
Date: Tue, 28 Nov 2023 16:36:51 -0800
Message-Id: <20231129003656.1165061-2-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129003656.1165061-1-song@kernel.org>
References: <20231129003656.1165061-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is common practice for security solutions to store tags/labels in
xattrs. To implement similar functionalities in BPF LSM, add new kfunc
bpf_get_file_xattr().

The first use case of bpf_get_file_xattr() is to implement file
verifications with asymmetric keys. Specificially, security applications
could use fsverity for file hashes and use xattr to store file signatures.
(kfunc for fsverity hash will be added in a separate commit.)

Currently, only xattrs with "user." prefix can be read with kfunc
bpf_get_file_xattr(). As use cases evolve, we may add a dedicated prefix
for bpf_get_file_xattr().

To avoid recursion, bpf_get_file_xattr can be only called from LSM hooks.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 kernel/trace/bpf_trace.c | 67 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f0b8b7c29126..62fc51bc57af 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -24,6 +24,7 @@
 #include <linux/key.h>
 #include <linux/verification.h>
 #include <linux/namei.h>
+#include <linux/fileattr.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1431,6 +1432,72 @@ static int __init bpf_key_sig_kfuncs_init(void)
 late_initcall(bpf_key_sig_kfuncs_init);
 #endif /* CONFIG_KEYS */
 
+/* filesystem kfuncs */
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_get_file_xattr - get xattr of a file
+ * @file: file to get xattr from
+ * @name__str: name of the xattr
+ * @value_ptr: output buffer of the xattr value
+ *
+ * Get xattr *name__str* of *file* and store the output in *value_ptr*.
+ *
+ * For security reasons, only *name__str* with prefix "user." is allowed.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
+				   struct bpf_dynptr_kern *value_ptr)
+{
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
+__bpf_kfunc_end_defs();
+
+BTF_SET8_START(fs_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_SET8_END(fs_kfunc_set_ids)
+
+static int bpf_get_file_xattr_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&fs_kfunc_set_ids, kfunc_id))
+		return 0;
+
+	/* Only allow to attach from LSM hooks, to avoid recursion */
+	return prog->type != BPF_PROG_TYPE_LSM ? -EACCES : 0;
+}
+
+static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &fs_kfunc_set_ids,
+	.filter = bpf_get_file_xattr_filter,
+};
+
+static int __init bpf_fs_kfuncs_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+}
+
+late_initcall(bpf_fs_kfuncs_init);
+
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
-- 
2.34.1


