Return-Path: <linux-fsdevel+bounces-34746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266049C8516
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 09:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC4B1F216B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 08:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DC91F8EF5;
	Thu, 14 Nov 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+VV6NpJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D5B1F757F;
	Thu, 14 Nov 2024 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731573890; cv=none; b=liGVbZyZV8FXLn1V3E5qza1+Z7Qov1ULcdjbxOE5S95WJweQyms1QpxD2ApZgbMLj7AAZqyFXv8AE0DzQoIFS9Afm95zelcHad99g3zfJJ/+c1EWUVEJLKYEouzEkZGpMg2WrEQzyNMRs02jHdT01+hYlMiEzhouQIaiQ39aBWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731573890; c=relaxed/simple;
	bh=M4IAn4WGrIBdCXICRh4T7eOrsB4F7fqrCuH6SgxNCdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPddGnAbhCc9vfatJzZBknCH8T/5TbGYsjFwW8RIWM8RfIXMNOQqmSYOLK6yN8p4zVvDYap+D3ArShu8niU6B739TaoWXWf9pCoyiYfIuiG48ndgIQ+GjYTFptBh8Wl5bcVHWmY5gXRh/ZqGklihXxGI45OGpmA1XP/kdysjpfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+VV6NpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A498AC4CECD;
	Thu, 14 Nov 2024 08:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731573890;
	bh=M4IAn4WGrIBdCXICRh4T7eOrsB4F7fqrCuH6SgxNCdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l+VV6NpJ+BTuYHnCogP9sQWd9zYhmFh2cCuj+nqxFuqMT2YSRz8fk7kGU9kTRPsWI
	 i3KpUWdgRKewQekyWMu3PN0KAVnk8ETvoacXtJ8bi9FXUoHMI8NClO7ZXsCvtJ1nsB
	 rXtHcmJz0eTErRdpFAGGJ6bUaNDLQZu2gHDvVLTuGCY34TF1NUO/wr/y19/Rtbu61i
	 3uILEgfAnEwm5bcUZd/DcnXGSnnqsn4HQCuDVMhYpMAjDoF5+z9lmlNeoSTGHb/Que
	 6Pin2DnOjjG72kkp4lppQ8ftWQKutcn3+7nET2EyFUc6mpNL+CuaBJtGrL3Wv4DTYK
	 mHwrZDkDsx/BA==
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
	amir73il@gmail.com,
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	mic@digikod.net,
	gnoack@google.com,
	Song Liu <song@kernel.org>
Subject: [RFC/PATCH v2 bpf-next fanotify 6/7] fanotify: Enable bpf based fanotify fastpath handler
Date: Thu, 14 Nov 2024 00:43:44 -0800
Message-ID: <20241114084345.1564165-7-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241114084345.1564165-1-song@kernel.org>
References: <20241114084345.1564165-1-song@kernel.org>
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
2. Add kfunc bpf_fanotify_data_inode, bpf_fanotify_data_dentry.
e. Add struct_ops bpf_fanotify_fastpath_ops.

TODO:
1. With current logic, the bpf based fastpath handler is added to the
   global list, and thus available to all users. This is similar to
   bpf based tcp congestion algorithms. It is possible to add an API
   so that the bpf based handler is not added to global list, which is
   similar to hid-bpf. I plan to add that API later.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/Makefile                            |   2 +-
 fs/bpf_fs_kfuncs.c                     |  10 +-
 fs/notify/fanotify/fanotify_fastpath.c | 172 ++++++++++++++++++++++++-
 kernel/bpf/verifier.c                  |   5 +
 4 files changed, 183 insertions(+), 6 deletions(-)

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
index 03ad3a2faec8..2f7b91f10175 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -207,7 +207,8 @@ BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
 	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
-	    prog->type == BPF_PROG_TYPE_LSM)
+	    prog->type == BPF_PROG_TYPE_LSM ||
+	    prog->type == BPF_PROG_TYPE_STRUCT_OPS)
 		return 0;
 	return -EACCES;
 }
@@ -220,7 +221,12 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 
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
index f2aefcf0ca6a..ec7a1143d687 100644
--- a/fs/notify/fanotify/fanotify_fastpath.c
+++ b/fs/notify/fanotify/fanotify_fastpath.c
@@ -2,6 +2,7 @@
 #include <linux/fanotify.h>
 #include <linux/kobject.h>
 #include <linux/module.h>
+#include <linux/bpf.h>
 
 #include "fanotify.h"
 
@@ -197,7 +198,7 @@ int fanotify_fastpath_add(struct fsnotify_group *group,
 
 	spin_lock(&fp_list_lock);
 	fp_ops = fanotify_fastpath_find(args.name);
-	if (!fp_ops || !try_module_get(fp_ops->owner)) {
+	if (!fp_ops || !bpf_try_module_get(fp_ops, fp_ops->owner)) {
 		spin_unlock(&fp_list_lock);
 		ret = -ENOENT;
 		goto err_free_hook;
@@ -238,7 +239,7 @@ int fanotify_fastpath_add(struct fsnotify_group *group,
 err_free_args:
 	kfree(init_args);
 err_module_put:
-	module_put(fp_ops->owner);
+	bpf_module_put(fp_ops, fp_ops->owner);
 err_free_hook:
 	kfree(fp_hook);
 	goto out;
@@ -249,7 +250,7 @@ void fanotify_fastpath_hook_free(struct fanotify_fastpath_hook *fp_hook)
 	if (fp_hook->ops->fp_free)
 		fp_hook->ops->fp_free(fp_hook);
 
-	module_put(fp_hook->ops->owner);
+	bpf_module_put(fp_hook->ops, fp_hook->ops->owner);
 	kfree(fp_hook);
 }
 
@@ -280,3 +281,168 @@ static int __init fanotify_fastpath_init(void)
 	return 0;
 }
 device_initcall(fanotify_fastpath_init);
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
+/**
+ * bpf_fanotify_data_dentry - get dentry from fanotify_fastpath_event
+ *
+ * @event: fanotify_fastpath_event to get dentry from
+ *
+ * Get referenced dentry from fanotify_fastpath_event.
+ *
+ * Return: A refcounted inode or NULL.
+ *
+ */
+__bpf_kfunc struct dentry *bpf_fanotify_data_dentry(struct fanotify_fastpath_event *event)
+{
+	struct dentry *dentry = fsnotify_data_dentry(event->data, event->data_type);
+
+	return dget(dentry);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_fanotify_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_fanotify_data_inode,
+	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_fanotify_data_dentry,
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
+static int __bpf_fan_fp_init(struct fanotify_fastpath_hook *hook, void *args)
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
index 65abb2d74ee5..cf7af86118fe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6529,6 +6529,10 @@ BTF_TYPE_SAFE_TRUSTED(struct dentry) {
 	struct inode *d_inode;
 };
 
+BTF_TYPE_SAFE_TRUSTED(struct fanotify_fastpath_event) {
+	struct inode *dir;
+};
+
 BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
@@ -6564,6 +6568,7 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct dentry));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct fanotify_fastpath_event));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
 }
-- 
2.43.5


