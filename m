Return-Path: <linux-fsdevel+bounces-34410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA3C9C50EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9A91F2152C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 08:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C43D212F1C;
	Tue, 12 Nov 2024 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4rwrC/5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF1212658;
	Tue, 12 Nov 2024 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400654; cv=none; b=buKD8sUoUriTPalCUVgmfZVt4l0EphpwxYhcIbdAHBRrGd0jqNgYZC26dangjlU43buNwjN7nwsdAPVej/hqqT3WaYBzfRPZdauryAR4VQy6R6VpxQya82m2Z1PQg3CAyY37U8M5b7pXTRXsbudITWLnb77652+Qksi/5Yx5AVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400654; c=relaxed/simple;
	bh=7qHU74+MNYBGP8sYVtRKKuwogTmc+20yK7a+Qh3ESSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aq2LCtEYaPimggiPDQX38QFRbQ59HkUkRhW43sRq3PZov5iR9pC4lPgrLw9AiVT3qasBT/yYuAQ3VhuynsIm6Qr3w7d0C0Jwtbktqf8DTlOBCskAMhAzCM9PjXuIFgdsMYU8vsnnRzGP+/I1HB8YxqbFhPSgQm+xGuG2u3rkz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4rwrC/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02167C4CECD;
	Tue, 12 Nov 2024 08:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731400654;
	bh=7qHU74+MNYBGP8sYVtRKKuwogTmc+20yK7a+Qh3ESSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4rwrC/5MVtl+CM6qoBFHQbt3SAJG+TNBJtU2jJZZ6maJ0GLoK3sxhG2IWzN4EGmQ
	 cUnzxtrMXwkpWh6WCRSa0INxGIJW7cJrojioXZSIbxWR2d5z6NahaNh3A1BFR/TVZ3
	 7tSCg6jjKeCEDKCP1uDhVPOk9BbkKb5CibWHtlmGz3lEwBpsuFXct3Wp4RYgoDBbtx
	 gvI3h1FAtkGDMHSz6pw9XcvUSLlE+TIeBoRnxkfV+uefrk4Va38CCau7/JboLlSz7u
	 CdPrLzkjAXfDairv55Ud15yR6hJZ/OBSxZ8tduE2bkY9goV6/F3dyS0Iy1+4DJf8fF
	 KBfyHM+hf2Reg==
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
Subject: [PATCH v2 bpf-next 3/4] bpf: Add recursion prevention logic for inode storage
Date: Tue, 12 Nov 2024 00:36:59 -0800
Message-ID: <20241112083700.356299-4-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112083700.356299-1-song@kernel.org>
References: <20241112083700.356299-1-song@kernel.org>
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
 kernel/bpf/bpf_inode_storage.c | 153 +++++++++++++++++++++++++++------
 kernel/trace/bpf_trace.c       |   4 +
 2 files changed, 133 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 8d5a9bfe6643..3a94a38e24f0 100644
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


