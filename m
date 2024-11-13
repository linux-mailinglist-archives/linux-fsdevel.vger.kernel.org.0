Return-Path: <linux-fsdevel+bounces-34579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C87AE9C6648
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 01:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A852817A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451F52E40B;
	Wed, 13 Nov 2024 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLkqb6cZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963892C9A;
	Wed, 13 Nov 2024 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459270; cv=none; b=T6eZsZdoWMBBylkVmI09fnAPgpnpNyp266Wvi+TWNFFCBF/1nV+b468h34VQHyOjxkJM7Yu+3CMtONFya9CohDjv30GbRWEWnNLi0fbrYjMoe0ErP30UhfHlWB9uRRGvTfochxqJtAvltIT0c/rvi689ECweiImtab8emQCZTyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459270; c=relaxed/simple;
	bh=1zk7zUySkABxV8ZMTkh8Eb7XvT0NtTRLUmkBd3HtUX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WC6iNmyrEQe+lOhf2DyHMA/FerG+H99TnI0rLJwWBt55TelrxYatuWUvgLIKdHMzdhn3L8iiSNpL+bnbjzAWtsEx9AuEIpGbyh0fF1a3eioDGFHqOI7gn3F96hza8wtoRw63Kss/l2GZJV68oJLljAL9CMMWBqBJI8R4QADFAQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLkqb6cZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A82C4CECD;
	Wed, 13 Nov 2024 00:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731459270;
	bh=1zk7zUySkABxV8ZMTkh8Eb7XvT0NtTRLUmkBd3HtUX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fLkqb6cZf1s9bXji/pdSv6A59w/Y5qdwk3QC/3LP6LlMNReeDcYcnnE9ZNiA82niM
	 CxwOPO9sW834QQAE41fygQg3HDiv0GBKJlEWTmLoWqO8qe++66ao1HCAzD+75hTl3J
	 5IZaDZe3XWvZppsy/7eIUG+F9IaKdT60ibXV+HEeuKE2GMvAnZ7MqRIfV7PmHYzEEo
	 T45lbnFi+2FRfDGQqnDx04jbJQ8KOdDjoyOyvlPIr7gg+Zgnal1WS727znHecojShf
	 TatWs9Lrxyu+2u2y8TxoDKObuc7V80xdR+OmYL1FoDZeRCWcKXKAptev2FQAgmKtgF
	 H1wzNPUxluw6A==
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
Subject: [PATCH v3 bpf-next 2/4] bpf: Make bpf inode storage available to tracing program
Date: Tue, 12 Nov 2024 16:53:49 -0800
Message-ID: <20241113005351.2197340-3-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241113005351.2197340-1-song@kernel.org>
References: <20241113005351.2197340-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inode storage can be useful for non-LSM program. For example, file* tools
from bcc/libbpf-tools can use inode storage instead of hash map; fanotify
fastpath [1] can also use inode storage to store useful data.

Make inode storage available for tracing program. Move bpf inode storage
from a security blob to inode->i_bpf_storage, and adjust related code
accordingly.

[1] https://lore.kernel.org/linux-fsdevel/20241029231244.2834368-1-song@kernel.org/
Signed-off-by: Song Liu <song@kernel.org>
---
 fs/inode.c                     |  2 ++
 include/linux/bpf.h            |  9 +++++++++
 include/linux/bpf_lsm.h        | 29 -----------------------------
 include/linux/fs.h             |  4 ++++
 kernel/bpf/Makefile            |  3 +--
 kernel/bpf/bpf_inode_storage.c | 32 +++++---------------------------
 kernel/bpf/bpf_lsm.c           |  4 ----
 kernel/trace/bpf_trace.c       |  4 ++++
 security/bpf/hooks.c           |  6 ------
 9 files changed, 25 insertions(+), 68 deletions(-)

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
index 7da41ae2eac8..9da120140327 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2672,6 +2672,7 @@ struct bpf_link *bpf_link_by_id(u32 id);
 const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id,
 						 const struct bpf_prog *prog);
 void bpf_task_storage_free(struct task_struct *task);
+void bpf_inode_storage_free(struct inode *inode);
 void bpf_cgrp_storage_free(struct cgroup *cgroup);
 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
 const struct btf_func_model *
@@ -2942,6 +2943,10 @@ static inline void bpf_task_storage_free(struct task_struct *task)
 {
 }
 
+static inline void bpf_inode_storage_free(struct inode *inode)
+{
+}
+
 static inline bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
 {
 	return false;
@@ -3305,6 +3310,10 @@ extern const struct bpf_func_proto bpf_task_storage_get_recur_proto;
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
index 105328f0b9c0..73604c7130f1 100644
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
index 44ccebc745e5..8d5a9bfe6643 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -21,16 +21,11 @@
 
 DEFINE_BPF_STORAGE_CACHE(inode_cache);
 
-static struct bpf_local_storage __rcu **
-inode_storage_ptr(void *owner)
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
@@ -39,14 +34,9 @@ static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
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
 
@@ -57,15 +47,10 @@ static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
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
@@ -95,8 +80,6 @@ static long bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
 
 	if (fd_empty(f))
 		return -EBADF;
-	if (!inode_storage_ptr(file_inode(fd_file(f))))
-		return -EBADF;
 
 	sdata = bpf_local_storage_update(file_inode(fd_file(f)),
 					 (struct bpf_local_storage_map *)map,
@@ -136,12 +119,7 @@ BPF_CALL_5(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
 	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
 		return (unsigned long)NULL;
 
-	/* explicitly check that the inode_storage_ptr is not
-	 * NULL as inode_storage_lookup returns NULL in this case and
-	 * bpf_local_storage_update expects the owner to have a
-	 * valid storage pointer.
-	 */
-	if (!inode || !inode_storage_ptr(inode))
+	if (!inode)
 		return (unsigned long)NULL;
 
 	sdata = inode_storage_lookup(inode, map, true);
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 3bc61628ab25..6b6e0730e515 100644
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
index 949a3870946c..262bd101ea0b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1553,6 +1553,10 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		if (bpf_prog_check_recur(prog))
 			return &bpf_task_storage_delete_recur_proto;
 		return &bpf_task_storage_delete_proto;
+	case BPF_FUNC_inode_storage_get:
+		return &bpf_inode_storage_get_proto;
+	case BPF_FUNC_inode_storage_delete:
+		return &bpf_inode_storage_delete_proto;
 	case BPF_FUNC_for_each_map_elem:
 		return &bpf_for_each_map_elem_proto;
 	case BPF_FUNC_snprintf:
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index db759025abe1..67719a04bb0b 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -12,7 +12,6 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
 	#include <linux/lsm_hook_defs.h>
 	#undef LSM_HOOK
-	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
 };
 
 static const struct lsm_id bpf_lsmid = {
@@ -28,12 +27,7 @@ static int __init bpf_lsm_init(void)
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


