Return-Path: <linux-fsdevel+bounces-34402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CBF9C508A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F061F22F2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 08:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6BB20DD51;
	Tue, 12 Nov 2024 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZmXNgNa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FD579C4;
	Tue, 12 Nov 2024 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400003; cv=none; b=lHP+LQC34YQVfeY4PPE1EXyCqfe0e79sYruFSftWiu3tHwoC+Pz1cOOlDGgK6YIsoOADg2J0+Y1joWorP0HgN0GTadD6pnH/wzRdSdCuSZ7Ypasujy8OQem6kRN1nc++n8zXdicD4cCJCK+i+U8Hejm/ef0Z8ayQCWeTJUDuNII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400003; c=relaxed/simple;
	bh=b9ty9QVi0FdLwT9dydl2t4X5i3nc9IOhUfyVHSCcObk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+bWR7ZXO45Gt7i2Xw4CR9btkcZ9YjtnjpaslFKwgxMOQCXnUE7F7bJjbVk+tomM5xbhZqwiL0lv2cxA8JrDvJxSz3/6k3woM2rLoaoyzAwhQpcOYhWDbgdKzOC904fxeWKmWLwZPNwZz7q2ig0EH8+Wil8JBV5IhXjv3T38Whw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZmXNgNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9D8C4CECD;
	Tue, 12 Nov 2024 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731400002;
	bh=b9ty9QVi0FdLwT9dydl2t4X5i3nc9IOhUfyVHSCcObk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZmXNgNaHPoS7Cbk270RzGLoiaJMDcx4ZbYyapTKpf0p7xF+iEpmRZlbbSYcR3HzI
	 kw4JmA+XG+1m9DyYRozu+yXy5Zed37w36TTmgNexZF2DqvA/5eMELtQAQbcZlGF+Dr
	 QnctU2kDZmH9sHzpHm19jN1LKcy5fXusXHDTGewJEleIFr5LzY7oepHeloBoioSUE3
	 6121EAI8V25WlFuqfm/Esgn1agzNCivaVHeulZ2XJ49eKX2ZYFmYxNCuqQ2zkkcOZW
	 kbEt0VEEbQtuEClrfVRUJ8Ihn+BEOUTAis0Mikg484o1Fo7QeX6lh1+rvXFy/8rsRu
	 Y9/hbPcxcMhfw==
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
Subject: [PATCH bpf-next 3/4] bpf: Add recursion avoid logic for inode storage
Date: Tue, 12 Nov 2024 00:25:57 -0800
Message-ID: <20241112082600.298035-4-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112082600.298035-1-song@kernel.org>
References: <20241112082600.298035-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic is same as task local storage.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/bpf_inode_storage.c | 156 +++++++++++++++++++++++++++------
 kernel/trace/bpf_trace.c       |   4 +
 2 files changed, 135 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index cd4dc266ebff..ef539f4fe583 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -21,6 +21,31 @@
 
 DEFINE_BPF_STORAGE_CACHE(inode_cache);
 
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
 static struct bpf_local_storage __rcu **inode_storage_ptr(void *owner)
 {
 	struct inode *inode = owner;
@@ -56,7 +81,9 @@ void bpf_inode_storage_free(struct inode *inode)
 		return;
 	}
 
+	bpf_inode_storage_lock();
 	bpf_local_storage_destroy(local_storage);
+	bpf_inode_storage_unlock();
 	rcu_read_unlock();
 }
 
@@ -68,7 +95,9 @@ static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
 	if (fd_empty(f))
 		return ERR_PTR(-EBADF);
 
+	bpf_inode_storage_lock();
 	sdata = inode_storage_lookup(file_inode(fd_file(f)), map, true);
+	bpf_inode_storage_unlock();
 	return sdata ? sdata->data : NULL;
 }
 
@@ -81,13 +110,16 @@ static long bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
 	if (fd_empty(f))
 		return -EBADF;
 
+	bpf_inode_storage_lock();
 	sdata = bpf_local_storage_update(file_inode(fd_file(f)),
 					 (struct bpf_local_storage_map *)map,
 					 value, map_flags, false, GFP_ATOMIC);
+	bpf_inode_storage_unlock();
 	return PTR_ERR_OR_ZERO(sdata);
 }
 
-static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
+static int inode_storage_delete(struct inode *inode, struct bpf_map *map,
+				bool nobusy)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -95,6 +127,9 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
+	if (!nobusy)
+		return -EBUSY;
+
 	bpf_selem_unlink(SELEM(sdata), false);
 
 	return 0;
@@ -102,60 +137,111 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 
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
+}
+
+static void *__bpf_inode_storage_get(struct bpf_map *map, struct inode *inode,
+				     void *value, u64 flags, gfp_t gfp_flags, bool nobusy)
+{
+	struct bpf_local_storage_data *sdata;
+
+	/* explicitly check that the inode not NULL */
+	if (!inode)
+		return NULL;
+
+	sdata = inode_storage_lookup(inode, map, true);
+	if (sdata)
+		return sdata->data;
+
+	/* only allocate new storage, when the inode is refcounted */
+	if (atomic_read(&inode->i_count) &&
+	    flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
+		sdata = bpf_local_storage_update(
+			inode, (struct bpf_local_storage_map *)map, value,
+			BPF_NOEXIST, false, gfp_flags);
+		return IS_ERR(sdata) ? NULL : sdata->data;
+	}
+
+	return NULL;
 }
 
 /* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
+BPF_CALL_5(bpf_inode_storage_get_recur, struct bpf_map *, map, struct inode *, inode,
 	   void *, value, u64, flags, gfp_t, gfp_flags)
 {
-	struct bpf_local_storage_data *sdata;
+	bool nobusy;
+	void *data;
 
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
 		return (unsigned long)NULL;
 
-	/* explicitly check that the inode_storage_ptr is not
-	 * NULL as inode_storage_lookup returns NULL in this case and
-	 * bpf_local_storage_update expects the owner to have a
-	 * valid storage pointer.
-	 */
-	if (!inode || !inode_storage_ptr(inode))
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
 		return (unsigned long)NULL;
 
-	sdata = inode_storage_lookup(inode, map, true);
-	if (sdata)
-		return (unsigned long)sdata->data;
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
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+	if (!inode)
+		return -EINVAL;
 
+	nobusy = bpf_inode_storage_trylock();
 	/* This helper must only called from where the inode is guaranteed
 	 * to have a refcount and cannot be freed.
 	 */
-	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
-		sdata = bpf_local_storage_update(
-			inode, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST, false, gfp_flags);
-		return IS_ERR(sdata) ? (unsigned long)NULL :
-					     (unsigned long)sdata->data;
-	}
-
-	return (unsigned long)NULL;
+	ret = inode_storage_delete(inode, map, nobusy);
+	if (nobusy)
+		bpf_inode_storage_unlock();
+	return ret;
 }
 
-BPF_CALL_2(bpf_inode_storage_delete,
-	   struct bpf_map *, map, struct inode *, inode)
+BPF_CALL_2(bpf_inode_storage_delete, struct bpf_map *, map, struct inode *, inode)
 {
+	int ret;
+
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (!inode)
 		return -EINVAL;
 
+	bpf_inode_storage_lock();
 	/* This helper must only called from where the inode is guaranteed
 	 * to have a refcount and cannot be freed.
 	 */
-	return inode_storage_delete(inode, map);
+	ret = inode_storage_delete(inode, map, true);
+	bpf_inode_storage_unlock();
+	return ret;
 }
 
 static int notsupp_get_next_key(struct bpf_map *map, void *key,
@@ -191,6 +277,17 @@ const struct bpf_map_ops inode_storage_map_ops = {
 
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
@@ -202,6 +299,15 @@ const struct bpf_func_proto bpf_inode_storage_get_proto = {
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
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 262bd101ea0b..4616f5430a5e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1554,8 +1554,12 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 			return &bpf_task_storage_delete_recur_proto;
 		return &bpf_task_storage_delete_proto;
 	case BPF_FUNC_inode_storage_get:
+		if (bpf_prog_check_recur(prog))
+			return &bpf_inode_storage_get_recur_proto;
 		return &bpf_inode_storage_get_proto;
 	case BPF_FUNC_inode_storage_delete:
+		if (bpf_prog_check_recur(prog))
+			return &bpf_inode_storage_delete_recur_proto;
 		return &bpf_inode_storage_delete_proto;
 	case BPF_FUNC_for_each_map_elem:
 		return &bpf_for_each_map_elem_proto;
-- 
2.43.5


