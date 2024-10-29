Return-Path: <linux-fsdevel+bounces-33174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 125FD9B5695
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 00:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89CF31F233F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 23:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CA820C472;
	Tue, 29 Oct 2024 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6twaFWo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1A920B1EF;
	Tue, 29 Oct 2024 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243608; cv=none; b=fNPGryrOe5/lma2uGJOc/qYYBrjhHj0Z0h5BTkfK5m0ISe48V1/yp4iqwIJ4Sj2JKbVAiGbm8puIsoTsaBOv6/AdgLrJz4Mp0k8y0EWRLaru/IcrXNvLe6PMS4gkknLH6rwkd8PO27R3yqmJV0Myn6ObKOGjPjdMRU1KY8nwehU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243608; c=relaxed/simple;
	bh=PnPQ4TtK0Ou43FdXx0o3MrwJnIIGcK5+VZMftzGIYHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bj9iV7vy3NscM7Xs7cCHZvl4OrvZXxkyD2UjpqWuWhb+/8Y3j8aC90WjwettxFdxFZ0W18A+ULxcKlOhpUn37Sd7d7HaVeFsHc4mchpLX+wA/ihYeIW+js9yUTvOx+g3OdPiQprD9GzY8aui0plv1FVqLJn0jlJaEPMwR2Dvin8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6twaFWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67325C4CEE6;
	Tue, 29 Oct 2024 23:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730243607;
	bh=PnPQ4TtK0Ou43FdXx0o3MrwJnIIGcK5+VZMftzGIYHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6twaFWoteunqCRxuHIGwiRC+31y/dcKvfOQEnLZXhCfFY0cvj9QqIYOY3ODx3G7U
	 C+vmtwbFMYagKnyBZ7p0b6gTvR4/TqdGGTWpoUiDNhXBY6XcqLsHLDu9/HQJoB+wOE
	 mchtwHW/HbZaLWAXO0eel8ZS1aJAb7us32qzfE2LQSDBWVB75NPydMsgDQ3s2K6Re3
	 XbyjaYMW0reVUtZ3WKFy/t1dt4CMT0KR80nVT/HAA6tfXtnXxImqut6RpkW9LEDxTf
	 w8qIHQrrQb/raShSZetQmJqXMbTtjDot2NQDL9Ug5I7+K4kzeulCiD7QebwObIIekU
	 5RM3uPODA9zUQ==
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
	amir73il@gmail.com,
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	Song Liu <song@kernel.org>
Subject: [RFC bpf-next fanotify 4/5] fanotify: Enable bpf based fanotify fastpath handler
Date: Tue, 29 Oct 2024 16:12:43 -0700
Message-ID: <20241029231244.2834368-5-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029231244.2834368-1-song@kernel.org>
References: <20241029231244.2834368-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow user to write fanotify fastpath handlers with bpf programs.

Major changes:
1. Make kfuncs in fs/bpf_fs_kfuncs.c available to STRUCT_OPS programs.
2. Add kfunc bpf_iput;
3. Add kfunc bpf_fanotify_data_inode;
4. Add struct_ops bpf_fanotify_fastpath_ops.

TODO:
1. Maybe split this into multiple patches.
2. With current logic, the bpf based fastpath handler is added to the
   global list, and thus available to all users. This is similar to
   bpf based tcp congestion algorithms. It is possible to add an API
   so that the bpf based handler is not added to global list, which is
   similar to hid-bpf. I plan to add that API later.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/Makefile                            |   2 +-
 fs/bpf_fs_kfuncs.c                     |  23 +++-
 fs/notify/fanotify/fanotify_fastpath.c | 153 ++++++++++++++++++++++++-
 kernel/bpf/verifier.c                  |   5 +
 4 files changed, 177 insertions(+), 6 deletions(-)

diff --git a/fs/Makefile b/fs/Makefile
index 61679fd587b7..1043d999262d 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -129,4 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
-obj-$(CONFIG_BPF_LSM)		+= bpf_fs_kfuncs.o
+obj-$(CONFIG_BPF_SYSCALL)	+= bpf_fs_kfuncs.o
diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 3fe9f59ef867..8110276faff9 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -152,6 +152,18 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 	return bpf_get_dentry_xattr(dentry, name__str, value_p);
 }
 
+/**
+ * bpf_iput - Drop a reference on the inode
+ *
+ * @inode: inode to drop reference.
+ *
+ * Drop a refcount on inode.
+ */
+__bpf_kfunc void bpf_iput(struct inode *inode)
+{
+	iput(inode);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -161,12 +173,14 @@ BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iput, KF_RELEASE)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
 	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
-	    prog->type == BPF_PROG_TYPE_LSM)
+	    prog->type == BPF_PROG_TYPE_LSM ||
+	    prog->type == BPF_PROG_TYPE_STRUCT_OPS)
 		return 0;
 	return -EACCES;
 }
@@ -179,7 +193,12 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 
 static int __init bpf_fs_kfuncs_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_fs_kfunc_set);
+
+	return ret;
 }
 
 late_initcall(bpf_fs_kfuncs_init);
diff --git a/fs/notify/fanotify/fanotify_fastpath.c b/fs/notify/fanotify/fanotify_fastpath.c
index 0453a1ac25b1..4781270e7b6a 100644
--- a/fs/notify/fanotify/fanotify_fastpath.c
+++ b/fs/notify/fanotify/fanotify_fastpath.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/fanotify.h>
 #include <linux/module.h>
+#include <linux/bpf.h>
 
 #include "fanotify.h"
 
@@ -107,7 +108,7 @@ int fanotify_fastpath_add(struct fsnotify_group *group,
 
 	spin_lock(&fp_list_lock);
 	fp_ops = fanotify_fastpath_find(args.name);
-	if (!fp_ops || !try_module_get(fp_ops->owner)) {
+	if (!fp_ops || !bpf_try_module_get(fp_ops, fp_ops->owner)) {
 		spin_unlock(&fp_list_lock);
 		ret = -ENOENT;
 		goto err_free_hook;
@@ -140,7 +141,7 @@ int fanotify_fastpath_add(struct fsnotify_group *group,
 	return ret;
 
 err_module_put:
-	module_put(fp_ops->owner);
+	bpf_module_put(fp_ops, fp_ops->owner);
 err_free_hook:
 	kfree(fp_hook);
 	goto out;
@@ -151,7 +152,7 @@ void fanotify_fastpath_hook_free(struct fanotify_fastpath_hook *fp_hook)
 	if (fp_hook->ops->fp_free)
 		fp_hook->ops->fp_free(fp_hook);
 
-	module_put(fp_hook->ops->owner);
+	bpf_module_put(fp_hook->ops, fp_hook->ops->owner);
 }
 
 void fanotify_fastpath_del(struct fsnotify_group *group)
@@ -169,3 +170,149 @@ void fanotify_fastpath_del(struct fsnotify_group *group)
 out:
 	fsnotify_group_unlock(group);
 }
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_fanotify_data_inode - get inode from fanotify_fastpath_event
+ *
+ * @event: fanotify_fastpath_event to get inode from
+ *
+ * Get referenced inode from fanotify_fastpath_event.
+ *
+ * Return: A refcounted inode or NULL.
+ *
+ */
+__bpf_kfunc struct inode *bpf_fanotify_data_inode(struct fanotify_fastpath_event *event)
+{
+	struct inode *inode = fsnotify_data_inode(event->data, event->data_type);
+
+	return inode ? igrab(inode) : NULL;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_fanotify_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_fanotify_data_inode,
+	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_KFUNCS_END(bpf_fanotify_kfunc_set_ids)
+
+static const struct btf_kfunc_id_set bpf_fanotify_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_fanotify_kfunc_set_ids,
+};
+
+static const struct bpf_func_proto *
+bpf_fanotify_fastpath_get_func_proto(enum bpf_func_id func_id,
+				     const struct bpf_prog *prog)
+{
+	return tracing_prog_func_proto(func_id, prog);
+}
+
+static bool bpf_fanotify_fastpath_is_valid_access(int off, int size,
+						  enum bpf_access_type type,
+						  const struct bpf_prog *prog,
+						  struct bpf_insn_access_aux *info)
+{
+	if (!bpf_tracing_btf_ctx_access(off, size, type, prog, info))
+		return false;
+
+	return true;
+}
+
+static int bpf_fanotify_fastpath_btf_struct_access(struct bpf_verifier_log *log,
+						   const struct bpf_reg_state *reg,
+						   int off, int size)
+{
+	return 0;
+}
+
+static const struct bpf_verifier_ops bpf_fanotify_fastpath_verifier_ops = {
+	.get_func_proto		= bpf_fanotify_fastpath_get_func_proto,
+	.is_valid_access	= bpf_fanotify_fastpath_is_valid_access,
+	.btf_struct_access	= bpf_fanotify_fastpath_btf_struct_access,
+};
+
+static int bpf_fanotify_fastpath_reg(void *kdata, struct bpf_link *link)
+{
+	return fanotify_fastpath_register(kdata);
+}
+
+static void bpf_fanotify_fastpath_unreg(void *kdata, struct bpf_link *link)
+{
+	fanotify_fastpath_unregister(kdata);
+}
+
+static int bpf_fanotify_fastpath_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int bpf_fanotify_fastpath_init_member(const struct btf_type *t,
+					     const struct btf_member *member,
+					     void *kdata, const void *udata)
+{
+	const struct fanotify_fastpath_ops *uops;
+	struct fanotify_fastpath_ops *ops;
+	u32 moff;
+	int ret;
+
+	uops = (const struct fanotify_fastpath_ops *)udata;
+	ops = (struct fanotify_fastpath_ops *)kdata;
+
+	moff = __btf_member_bit_offset(t, member) / 8;
+	switch (moff) {
+	case offsetof(struct fanotify_fastpath_ops, name):
+		ret = bpf_obj_name_cpy(ops->name, uops->name,
+				       sizeof(ops->name));
+		if (ret <= 0)
+			return -EINVAL;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int __bpf_fan_fp_handler(struct fsnotify_group *group,
+				struct fanotify_fastpath_hook *fp_hook,
+				struct fanotify_fastpath_event *fp_event)
+{
+	return 0;
+}
+
+static int __bpf_fan_fp_init(struct fanotify_fastpath_hook *hook, const char *args)
+{
+	return 0;
+}
+
+static void __bpf_fan_fp_free(struct fanotify_fastpath_hook *hook)
+{
+}
+
+/* For bpf_struct_ops->cfi_stubs */
+static struct fanotify_fastpath_ops __bpf_fanotify_fastpath_ops = {
+	.fp_handler = __bpf_fan_fp_handler,
+	.fp_init = __bpf_fan_fp_init,
+	.fp_free = __bpf_fan_fp_free,
+};
+
+static struct bpf_struct_ops bpf_fanotify_fastpath_ops = {
+	.verifier_ops = &bpf_fanotify_fastpath_verifier_ops,
+	.reg = bpf_fanotify_fastpath_reg,
+	.unreg = bpf_fanotify_fastpath_unreg,
+	.init = bpf_fanotify_fastpath_init,
+	.init_member = bpf_fanotify_fastpath_init_member,
+	.name = "fanotify_fastpath_ops",
+	.cfi_stubs = &__bpf_fanotify_fastpath_ops,
+	.owner = THIS_MODULE,
+};
+
+static int __init bpf_fanotify_fastpath_struct_ops_init(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_fanotify_kfunc_set);
+	ret = ret ?: register_bpf_struct_ops(&bpf_fanotify_fastpath_ops, fanotify_fastpath_ops);
+	return ret;
+}
+late_initcall(bpf_fanotify_fastpath_struct_ops_init);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9a7ed527e47e..cbca27d24ae5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6528,6 +6528,10 @@ BTF_TYPE_SAFE_TRUSTED(struct dentry) {
 	struct inode *d_inode;
 };
 
+BTF_TYPE_SAFE_TRUSTED(struct fanotify_fastpath_event) {
+	struct inode *dir;
+};
+
 BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
@@ -6563,6 +6567,7 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct dentry));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct fanotify_fastpath_event));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
 }
-- 
2.43.5


