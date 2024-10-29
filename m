Return-Path: <linux-fsdevel+bounces-33173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BB99B5692
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 00:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358F01F23EDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 23:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06B820C314;
	Tue, 29 Oct 2024 23:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNzXRFxt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2287E20B1EF;
	Tue, 29 Oct 2024 23:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243599; cv=none; b=S+YDCEHzgJsgJAKNOJ8pZgL9DvrDudSzbHF59KR0VdtN5mEwZmv0fyx7AP+gwSDNaqNDGMnlH9E0KbpJN43jOlzmoVKKJroFoItMiULEXWIF60K8cZEabdkiQSzjpbIdddaHCmx40hrU94wHC4/oX7ciAWDG5MrxYVwbKpRr1Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243599; c=relaxed/simple;
	bh=/24NpyvuU2fmjvy+HEqjRAqlIX/chnBPTcfm+1cdY1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaHM1oHdvLAvNnqzd4vf2/OVA3obepNysQVmOSnChr1aOJIl+Z24ImvEZCSEdD23Cg//pkf5mOAywJWeJsgp4C1vegSTNr0DCpcFGi3cUxSRrkWOr/OUm59mg0OXavj4wx9s/I6Ki0J5UPZxfSzV1aIYe5an3rWhvC4MG1CT9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNzXRFxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF51C4CEE7;
	Tue, 29 Oct 2024 23:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730243599;
	bh=/24NpyvuU2fmjvy+HEqjRAqlIX/chnBPTcfm+1cdY1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PNzXRFxt4yXttP6b4iz5oGZoIE6sBS06OryRHZmgrvrLUKg5ILthY9/XhvG5nCHDw
	 lmBEiS2VBBTBl9uohfIuV0Gpf5o1CeWNw5NpLJHNUePJe0W0cIFFZCSYhBqiteeTcP
	 P2HfKwvf6t9KX6VuNnGsvS0N7WzpIM2ZhqmEcqpkqmVwJBuVokqkuKqiQkoXzaYe4/
	 MZJba5goflySf3s+uyusIMFJcmH6+C2XmBiG8hsAIQs6QLYm6wIfPsqqLF8csC7Fi6
	 vdYM38+mItHnuPxVJRF1lxo3DErYUm05DFP8KS48cN73p6RWNx6SxIhHKfWz/Btc/N
	 k2pZzGsB7zVpg==
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
Subject: [RFC bpf-next fanotify 3/5] bpf: Make bpf inode storage available to tracing programs
Date: Tue, 29 Oct 2024 16:12:42 -0700
Message-ID: <20241029231244.2834368-4-song@kernel.org>
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

Use the same recursion voidance mechanism as task local storage.

TODO: Better testing, add selftests.

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/bpf.h            |   9 ++
 include/linux/bpf_lsm.h        |  29 ------
 include/linux/fs.h             |   4 +
 kernel/bpf/Makefile            |   3 +-
 kernel/bpf/bpf_inode_storage.c | 174 +++++++++++++++++++++++++--------
 kernel/bpf/bpf_lsm.c           |   4 -
 kernel/trace/bpf_trace.c       |   8 ++
 security/bpf/hooks.c           |   5 -
 8 files changed, 156 insertions(+), 80 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 19d8ca8ac960..863cb972d1fa 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2630,6 +2630,7 @@ struct bpf_link *bpf_link_by_id(u32 id);
 const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id,
 						 const struct bpf_prog *prog);
 void bpf_task_storage_free(struct task_struct *task);
+void bpf_inode_storage_free(struct inode *inode);
 void bpf_cgrp_storage_free(struct cgroup *cgroup);
 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
 const struct btf_func_model *
@@ -2900,6 +2901,10 @@ static inline void bpf_task_storage_free(struct task_struct *task)
 {
 }
 
+static inline void bpf_inode_storage_free(struct inode *inode)
+{
+}
+
 static inline bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
 {
 	return false;
@@ -3263,6 +3268,10 @@ extern const struct bpf_func_proto bpf_task_storage_get_recur_proto;
 extern const struct bpf_func_proto bpf_task_storage_get_proto;
 extern const struct bpf_func_proto bpf_task_storage_delete_recur_proto;
 extern const struct bpf_func_proto bpf_task_storage_delete_proto;
+extern const struct bpf_func_proto bpf_inode_storage_get_proto;
+extern const struct bpf_func_proto bpf_inode_storage_get_recur_proto;
+extern const struct bpf_func_proto bpf_inode_storage_delete_proto;
+extern const struct bpf_func_proto bpf_inode_storage_delete_recur_proto;
 extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
 extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
 extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index aefcd6564251..a819c2f0a062 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -19,31 +19,12 @@
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
 
-struct bpf_storage_blob {
-	struct bpf_local_storage __rcu *storage;
-};
-
-extern struct lsm_blob_sizes bpf_lsm_blob_sizes;
-
 int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 			const struct bpf_prog *prog);
 
 bool bpf_lsm_is_sleepable_hook(u32 btf_id);
 bool bpf_lsm_is_trusted(const struct bpf_prog *prog);
 
-static inline struct bpf_storage_blob *bpf_inode(
-	const struct inode *inode)
-{
-	if (unlikely(!inode->i_security))
-		return NULL;
-
-	return inode->i_security + bpf_lsm_blob_sizes.lbs_inode;
-}
-
-extern const struct bpf_func_proto bpf_inode_storage_get_proto;
-extern const struct bpf_func_proto bpf_inode_storage_delete_proto;
-void bpf_inode_storage_free(struct inode *inode);
-
 void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func);
 
 int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
@@ -66,16 +47,6 @@ static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 	return -EOPNOTSUPP;
 }
 
-static inline struct bpf_storage_blob *bpf_inode(
-	const struct inode *inode)
-{
-	return NULL;
-}
-
-static inline void bpf_inode_storage_free(struct inode *inode)
-{
-}
-
 static inline void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 					   bpf_func_t *bpf_func)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c1..479097e4dd5b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -79,6 +79,7 @@ struct fs_context;
 struct fs_parameter_spec;
 struct fileattr;
 struct iomap_ops;
+struct bpf_local_storage;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -648,6 +649,9 @@ struct inode {
 #ifdef CONFIG_SECURITY
 	void			*i_security;
 #endif
+#ifdef CONFIG_BPF_SYSCALL
+	struct bpf_local_storage __rcu *i_bpf_storage;
+#endif
 
 	/* Stat data, not accessed from path walking */
 	unsigned long		i_ino;
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 9b9c151b5c82..a5b7136b4884 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -10,8 +10,7 @@ obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
-obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
-obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
+obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 29da6d3838f6..79bf7ebb329c 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -21,16 +21,36 @@
 
 DEFINE_BPF_STORAGE_CACHE(inode_cache);
 
-static struct bpf_local_storage __rcu **
-inode_storage_ptr(void *owner)
+static DEFINE_PER_CPU(int, bpf_inode_storage_busy);
+
+static void bpf_inode_storage_lock(void)
+{
+	migrate_disable();
+	this_cpu_inc(bpf_inode_storage_busy);
+}
+
+static void bpf_inode_storage_unlock(void)
+{
+	this_cpu_dec(bpf_inode_storage_busy);
+	migrate_enable();
+}
+
+static bool bpf_inode_storage_trylock(void)
+{
+	migrate_disable();
+	if (unlikely(this_cpu_inc_return(bpf_inode_storage_busy) != 1)) {
+		this_cpu_dec(bpf_inode_storage_busy);
+		migrate_enable();
+		return false;
+	}
+	return true;
+}
+
+static struct bpf_local_storage __rcu **inode_storage_ptr(void *owner)
 {
 	struct inode *inode = owner;
-	struct bpf_storage_blob *bsb;
 
-	bsb = bpf_inode(inode);
-	if (!bsb)
-		return NULL;
-	return &bsb->storage;
+	return &inode->i_bpf_storage;
 }
 
 static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
@@ -39,14 +59,9 @@ static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
 {
 	struct bpf_local_storage *inode_storage;
 	struct bpf_local_storage_map *smap;
-	struct bpf_storage_blob *bsb;
-
-	bsb = bpf_inode(inode);
-	if (!bsb)
-		return NULL;
 
 	inode_storage =
-		rcu_dereference_check(bsb->storage, bpf_rcu_lock_held());
+		rcu_dereference_check(inode->i_bpf_storage, bpf_rcu_lock_held());
 	if (!inode_storage)
 		return NULL;
 
@@ -57,21 +72,18 @@ static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
 void bpf_inode_storage_free(struct inode *inode)
 {
 	struct bpf_local_storage *local_storage;
-	struct bpf_storage_blob *bsb;
-
-	bsb = bpf_inode(inode);
-	if (!bsb)
-		return;
 
 	rcu_read_lock();
 
-	local_storage = rcu_dereference(bsb->storage);
+	local_storage = rcu_dereference(inode->i_bpf_storage);
 	if (!local_storage) {
 		rcu_read_unlock();
 		return;
 	}
 
+	bpf_inode_storage_lock();
 	bpf_local_storage_destroy(local_storage);
+	bpf_inode_storage_unlock();
 	rcu_read_unlock();
 }
 
@@ -83,7 +95,9 @@ static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
 	if (fd_empty(f))
 		return ERR_PTR(-EBADF);
 
+	bpf_inode_storage_lock();
 	sdata = inode_storage_lookup(file_inode(fd_file(f)), map, true);
+	bpf_inode_storage_unlock();
 	return sdata ? sdata->data : NULL;
 }
 
@@ -98,13 +112,16 @@ static long bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
 	if (!inode_storage_ptr(file_inode(fd_file(f))))
 		return -EBADF;
 
+	bpf_inode_storage_lock();
 	sdata = bpf_local_storage_update(file_inode(fd_file(f)),
 					 (struct bpf_local_storage_map *)map,
 					 value, map_flags, GFP_ATOMIC);
+	bpf_inode_storage_unlock();
 	return PTR_ERR_OR_ZERO(sdata);
 }
 
-static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
+static int inode_storage_delete(struct inode *inode, struct bpf_map *map,
+				bool nobusy)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -112,6 +129,9 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
+	if (!nobusy)
+		return -EBUSY;
+
 	bpf_selem_unlink(SELEM(sdata), false);
 
 	return 0;
@@ -119,60 +139,114 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 
 static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
 {
+	int err;
+
 	CLASS(fd_raw, f)(*(int *)key);
 
 	if (fd_empty(f))
 		return -EBADF;
-	return inode_storage_delete(file_inode(fd_file(f)), map);
+	bpf_inode_storage_lock();
+	err = inode_storage_delete(file_inode(fd_file(f)), map, true);
+	bpf_inode_storage_unlock();
+	return err;
 }
 
-/* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
-	   void *, value, u64, flags, gfp_t, gfp_flags)
+static void *__bpf_inode_storage_get(struct bpf_map *map, struct inode *inode,
+				     void *value, u64 flags, gfp_t gfp_flags, bool nobusy)
 {
 	struct bpf_local_storage_data *sdata;
 
-	WARN_ON_ONCE(!bpf_rcu_lock_held());
-	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
-		return (unsigned long)NULL;
-
 	/* explicitly check that the inode_storage_ptr is not
 	 * NULL as inode_storage_lookup returns NULL in this case and
 	 * bpf_local_storage_update expects the owner to have a
 	 * valid storage pointer.
 	 */
 	if (!inode || !inode_storage_ptr(inode))
-		return (unsigned long)NULL;
+		return NULL;
 
 	sdata = inode_storage_lookup(inode, map, true);
 	if (sdata)
-		return (unsigned long)sdata->data;
+		return sdata->data;
 
-	/* This helper must only called from where the inode is guaranteed
-	 * to have a refcount and cannot be freed.
-	 */
-	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
+	/* only allocate new storage, when the inode is refcounted */
+	if (atomic_read(&inode->i_count) &&
+	    flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
 		sdata = bpf_local_storage_update(
 			inode, (struct bpf_local_storage_map *)map, value,
 			BPF_NOEXIST, gfp_flags);
-		return IS_ERR(sdata) ? (unsigned long)NULL :
-					     (unsigned long)sdata->data;
+		return IS_ERR(sdata) ? NULL : sdata->data;
 	}
 
-	return (unsigned long)NULL;
+	return NULL;
 }
 
-BPF_CALL_2(bpf_inode_storage_delete,
-	   struct bpf_map *, map, struct inode *, inode)
+/* *gfp_flags* is a hidden argument provided by the verifier */
+BPF_CALL_5(bpf_inode_storage_get_recur, struct bpf_map *, map, struct inode *, inode,
+	   void *, value, u64, flags, gfp_t, gfp_flags)
 {
+	bool nobusy;
+	void *data;
+
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
+		return (unsigned long)NULL;
+
+	nobusy = bpf_inode_storage_trylock();
+	data = __bpf_inode_storage_get(map, inode, value, flags, gfp_flags, nobusy);
+	if (nobusy)
+		bpf_inode_storage_unlock();
+	return (unsigned long)data;
+}
+
+/* *gfp_flags* is a hidden argument provided by the verifier */
+BPF_CALL_5(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
+	   void *, value, u64, flags, gfp_t, gfp_flags)
+{
+	void *data;
+
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
+		return (unsigned long)NULL;
+
+	bpf_inode_storage_lock();
+	data = __bpf_inode_storage_get(map, inode, value, flags, gfp_flags, true);
+	bpf_inode_storage_unlock();
+	return (unsigned long)data;
+}
+
+BPF_CALL_2(bpf_inode_storage_delete_recur, struct bpf_map *, map, struct inode *, inode)
+{
+	bool nobusy;
+	int ret;
+
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (!inode)
 		return -EINVAL;
 
+	nobusy = bpf_inode_storage_trylock();
 	/* This helper must only called from where the inode is guaranteed
 	 * to have a refcount and cannot be freed.
 	 */
-	return inode_storage_delete(inode, map);
+	ret = inode_storage_delete(inode, map, nobusy);
+	bpf_inode_storage_unlock();
+	return ret;
+}
+
+BPF_CALL_2(bpf_inode_storage_delete, struct bpf_map *, map, struct inode *, inode)
+{
+	int ret;
+
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+	if (!inode)
+		return -EINVAL;
+
+	bpf_inode_storage_lock();
+	/* This helper must only called from where the inode is guaranteed
+	 * to have a refcount and cannot be freed.
+	 */
+	ret = inode_storage_delete(inode, map, true);
+	bpf_inode_storage_unlock();
+	return ret;
 }
 
 static int notsupp_get_next_key(struct bpf_map *map, void *key,
@@ -208,6 +282,17 @@ const struct bpf_map_ops inode_storage_map_ops = {
 
 BTF_ID_LIST_SINGLE(bpf_inode_storage_btf_ids, struct, inode)
 
+const struct bpf_func_proto bpf_inode_storage_get_recur_proto = {
+	.func		= bpf_inode_storage_get_recur,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_PTR_TO_BTF_ID_OR_NULL,
+	.arg2_btf_id	= &bpf_inode_storage_btf_ids[0],
+	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg4_type	= ARG_ANYTHING,
+};
+
 const struct bpf_func_proto bpf_inode_storage_get_proto = {
 	.func		= bpf_inode_storage_get,
 	.gpl_only	= false,
@@ -219,6 +304,15 @@ const struct bpf_func_proto bpf_inode_storage_get_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
+const struct bpf_func_proto bpf_inode_storage_delete_recur_proto = {
+	.func		= bpf_inode_storage_delete_recur,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_PTR_TO_BTF_ID_OR_NULL,
+	.arg2_btf_id	= &bpf_inode_storage_btf_ids[0],
+};
+
 const struct bpf_func_proto bpf_inode_storage_delete_proto = {
 	.func		= bpf_inode_storage_delete,
 	.gpl_only	= false,
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 6292ac5f9bd1..51e2de17325a 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -231,10 +231,6 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	}
 
 	switch (func_id) {
-	case BPF_FUNC_inode_storage_get:
-		return &bpf_inode_storage_get_proto;
-	case BPF_FUNC_inode_storage_delete:
-		return &bpf_inode_storage_delete_proto;
 #ifdef CONFIG_NET
 	case BPF_FUNC_sk_storage_get:
 		return &bpf_sk_storage_get_proto;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a582cd25ca87..3ec39e6704e2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1529,6 +1529,14 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		if (bpf_prog_check_recur(prog))
 			return &bpf_task_storage_delete_recur_proto;
 		return &bpf_task_storage_delete_proto;
+	case BPF_FUNC_inode_storage_get:
+		if (bpf_prog_check_recur(prog))
+			return &bpf_inode_storage_get_recur_proto;
+		return &bpf_inode_storage_get_proto;
+	case BPF_FUNC_inode_storage_delete:
+		if (bpf_prog_check_recur(prog))
+			return &bpf_inode_storage_delete_recur_proto;
+		return &bpf_inode_storage_delete_proto;
 	case BPF_FUNC_for_each_map_elem:
 		return &bpf_for_each_map_elem_proto;
 	case BPF_FUNC_snprintf:
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 3663aec7bcbd..625e0cc7027a 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -29,12 +29,7 @@ static int __init bpf_lsm_init(void)
 	return 0;
 }
 
-struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init = {
-	.lbs_inode = sizeof(struct bpf_storage_blob),
-};
-
 DEFINE_LSM(bpf) = {
 	.name = "bpf",
 	.init = bpf_lsm_init,
-	.blobs = &bpf_lsm_blob_sizes
 };
-- 
2.43.5


