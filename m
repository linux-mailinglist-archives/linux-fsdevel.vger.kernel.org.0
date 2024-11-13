Return-Path: <linux-fsdevel+bounces-34580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DB09C664B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 01:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E66284F80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FFA481C4;
	Wed, 13 Nov 2024 00:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVtThniw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2663D18651;
	Wed, 13 Nov 2024 00:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459278; cv=none; b=LvL3PU7v2dUydCxCoJMZ/ZTFY1x/FJ6n+S4jGsOXDD+/daCpTM6iQR3fcg+k3f03RZwOvv3Dp07EUCEY7+ui33ZjXvMyOlUpBA3b9sB7MEZukh1RpG87tSz7kh3mdb/8Oi5D6RZSG6fAO09SHgQILOSi4Q6h1K6/736XIecPAms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459278; c=relaxed/simple;
	bh=7GtgdyCbei+7d3E/OgOIZPfXvpFQvUunLLOxDsqS4Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRAfdNcZOL4H9dU8pA+vuzBcYEZfX8bIBz/SWYbItT7XJxcGh/yGKYWaKAom4vfPCfZg1PBAHzGCV8H8BzwN/PEzzPYTt79oRcAZhJIQPFPjzcQ0s23/Z4yTN7h7CJhzPp+OSOi2HMGp0VJ2S2v4tD2PqbWsGQRn6P+x2GDw9IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVtThniw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE1EC4CECD;
	Wed, 13 Nov 2024 00:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731459278;
	bh=7GtgdyCbei+7d3E/OgOIZPfXvpFQvUunLLOxDsqS4Gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qVtThniwCJxmsmxGxeMntyu5ZbHcdm4PTY1t5HP4Jyb+bygi7GgymDVYlnWEpJ+W6
	 VNg+w0mctjWJvG3Wu6364Bo0GrRIK3QGvYaK3oLIIVJ1l9JSviGeMYcAf0RkKp3GJO
	 x+ShNfRUgk9gKdq1ZPTPkHej67gh301bOKdGhlTFi7BJD83gynbh2+WOL+CiOrfl10
	 EUy2tcRkdQuJ88Iv4Jw/qqORzZAmr9AUPFzY5z3nIDHnQl03cdZX14wnovYD5oBDf9
	 qZD6iC/Hs21fz8s8CrFUPq6lRA3vvGD0jCEWKLSYBHPwCtV9wLfqaocQ+kOwUVL24k
	 3ROt3g7WtOkmQ==
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
Subject: [PATCH v3 bpf-next 3/4] bpf: Add recursion prevention logic for inode storage
Date: Tue, 12 Nov 2024 16:53:50 -0800
Message-ID: <20241113005351.2197340-4-song@kernel.org>
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

This logic is similar to the recursion prevention logic for task local
storage: bpf programs on LSM hooks lock bpf_inode_storage_busy; bpf
tracing program will try to lock bpf_inode_storage_busy, and may return
-EBUSY if something else already lock bpf_inode_storage_busy on the same
CPU.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/bpf_inode_storage.c | 155 +++++++++++++++++++++++++++------
 kernel/trace/bpf_trace.c       |   4 +
 2 files changed, 134 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 8d5a9bfe6643..e98a0fc4fb70 100644
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
@@ -102,55 +137,105 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 
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
+	/* explicitly check that the inode not NULL */
 	if (!inode)
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
 			BPF_NOEXIST, false, gfp_flags);
-		return IS_ERR(sdata) ? (unsigned long)NULL :
-					     (unsigned long)sdata->data;
+		return IS_ERR(sdata) ? NULL : sdata->data;
 	}
 
-	return (unsigned long)NULL;
+	return NULL;
+}
+
+/* *gfp_flags* is a hidden argument provided by the verifier */
+BPF_CALL_5(bpf_inode_storage_get_recur, struct bpf_map *, map, struct inode *, inode,
+	   void *, value, u64, flags, gfp_t, gfp_flags)
+{
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
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+	if (!inode)
+		return -EINVAL;
+
+	nobusy = bpf_inode_storage_trylock();
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
 
-	/* This helper must only called from where the inode is guaranteed
-	 * to have a refcount and cannot be freed.
-	 */
-	return inode_storage_delete(inode, map);
+	bpf_inode_storage_lock();
+	ret = inode_storage_delete(inode, map, true);
+	bpf_inode_storage_unlock();
+	return ret;
 }
 
 static int notsupp_get_next_key(struct bpf_map *map, void *key,
@@ -186,6 +271,17 @@ const struct bpf_map_ops inode_storage_map_ops = {
 
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
@@ -197,6 +293,15 @@ const struct bpf_func_proto bpf_inode_storage_get_proto = {
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


