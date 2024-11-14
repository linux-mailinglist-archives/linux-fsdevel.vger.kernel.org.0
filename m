Return-Path: <linux-fsdevel+bounces-34743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8C89C8508
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 09:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5AE1F21FCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3185F1F76C5;
	Thu, 14 Nov 2024 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGRjNOqW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825D61F76A8;
	Thu, 14 Nov 2024 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731573868; cv=none; b=TN3/OptGyJ4Bsl2sZoR5QLM0akWyDl4cBI4pq4U75BnkRbX55hHIiiViQJ/sH3h5z34m/xdNu6dOIpCWAFJSFnCfp3c98AVcjlxvsZooH/M4E1bIL77J/eULxV/AK0166M5LB4jmIZQdZlGoHmn+4662M5LytlerxUv+AglQPtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731573868; c=relaxed/simple;
	bh=S7xDbIph8VcpsMfUCa0ILfHb706b9RjGxs+MZvWRZXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9mA1xFM2cmfSSYytxpu4Z3jTpymjSADeQofDxW1KaXsC2DLJ/zb1hDdUD6VoMMXGZqpB0wVHfJ4cNPnzoHve5wzD6qWZ6yNGZXBgVzxV2adhI4WRxKRvz1SVlgdUIzO/eX3zpTv+XNcr4+3/yY0HNzTxNK5yjTB3i4P8f2o9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGRjNOqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606C9C4CECD;
	Thu, 14 Nov 2024 08:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731573866;
	bh=S7xDbIph8VcpsMfUCa0ILfHb706b9RjGxs+MZvWRZXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bGRjNOqWB9zGl8VzoPYtqpDMNWzk4/it4beKpBtApasjKJ01uQj9/yQCJHAcYPJA7
	 SX+qk4SPHHCz2Nseu2D6up8m0gsYet/SDcApOjWq87+9f84OUQ+uU2fTm/IIkbk59P
	 J5wsD1HK/vMcxtTftwJsualVLrELT6yCFWrZfG6LgUOziEKds0mIZEthzITPIjGZQk
	 a5QDnyxAbw3NoxMEhf+vVx3BWRp8QNOn89+545bqdbDOReFWCdUX86Mdtg/a3JwQU+
	 xypoz6FzFb7ZnC09MvzQg11hOd1tBVzPS2upZyPiNBmjP+ganjR5tus0jY4XITgUyF
	 Ewhe5wNn2OXcg==
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
Subject: [RFC/PATCH v2 bpf-next fanotify 3/7] bpf: Make bpf inode storage available to tracing programs
Date: Thu, 14 Nov 2024 00:43:41 -0800
Message-ID: <20241114084345.1564165-4-song@kernel.org>
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

Use the same recursion voidance mechanism as task local storage.

Signed-off-by: Song Liu <song@kernel.org>
---

Do not apply this. Another version of this with selftest is submitted
separately, with proper selftests.
---
 fs/inode.c                     |   2 +
 include/linux/bpf.h            |   9 ++
 include/linux/bpf_lsm.h        |  29 ------
 include/linux/fs.h             |   4 +
 kernel/bpf/Makefile            |   3 +-
 kernel/bpf/bpf_inode_storage.c | 176 +++++++++++++++++++++++++--------
 kernel/bpf/bpf_lsm.c           |   4 -
 kernel/trace/bpf_trace.c       |   8 ++
 security/bpf/hooks.c           |   7 --
 9 files changed, 159 insertions(+), 83 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 8dabb224f941..c196a62bd48f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -250,6 +250,8 @@ EXPORT_SYMBOL(free_inode_nonrcu);
 static void i_callback(struct rcu_head *head)
 {
 	struct inode *inode = container_of(head, struct inode, i_rcu);
+
+	bpf_inode_storage_free(inode);
 	if (inode->free_inode)
 		inode->free_inode(inode);
 	else
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
index 29da6d3838f6..50c082da8dc5 100644
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
 
-	sdata = inode_storage_lookup(inode, map, true);
+	sdata = inode_storage_lookup(inode, map, nobusy);
 	if (sdata)
-		return (unsigned long)sdata->data;
+		return sdata->data;
 
-	/* This helper must only called from where the inode is guaranteed
-	 * to have a refcount and cannot be freed.
-	 */
-	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
+	/* only allocate new storage, when the inode is refcounted */
+	if (atomic_read(&inode->i_count) &&
+	    flags & BPF_LOCAL_STORAGE_GET_F_CREATE && nobusy) {
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
index 3663aec7bcbd..67719a04bb0b 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -12,8 +12,6 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
 	#include <linux/lsm_hook_defs.h>
 	#undef LSM_HOOK
-	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
-	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
 };
 
 static const struct lsm_id bpf_lsmid = {
@@ -29,12 +27,7 @@ static int __init bpf_lsm_init(void)
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


