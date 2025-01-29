Return-Path: <linux-fsdevel+bounces-40340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E15A2255A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 22:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B121887630
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 21:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD731E5714;
	Wed, 29 Jan 2025 21:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUm8tpNH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7061E2845;
	Wed, 29 Jan 2025 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738184435; cv=none; b=Vy+hlfSUU2FuWsU7V1RZqP/ZNZV/ZJS1DUTUSJG7M7uSlcsxTSpijznZ3jFCaNN4Js6uw3BXHommvF+xqmSz2oMV/ZmglblbY2t1jRLvKKfZDlmtgsCjhl6KO8zvrXRQVT8u1/riYkhjXO5ZXVr3XZDM6Z4uJVJDoPlMUiLHv+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738184435; c=relaxed/simple;
	bh=OBPQ5SKmmy0ZOEOGw96BY8LT51fU4Blsyn80lC+xbLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVIn8ikYLZOcS3AC7kmAKfb8nsUBp+JATAwnDgdCcBoBGVjFJEajnmM4z9ga+QBQqzPRnrva/P66C35d8vZ9SuqoyRbiUP1yOs0eknvkzKLtLOKOp/S13paFvh1XT7j3DWjVrtm8pF50D/E8lQX60RaHSuQoXUpMj0k9wgqpy7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUm8tpNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7814FC4CED1;
	Wed, 29 Jan 2025 21:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738184435;
	bh=OBPQ5SKmmy0ZOEOGw96BY8LT51fU4Blsyn80lC+xbLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jUm8tpNHVH2Qb9PgeygaTl8kIGwzxBVVDy0JEQntdYJPpM7p97Fi4bReiurCf5BUl
	 ZIGKC8U4nGYaibeSf9U6np01zjacrsnuL5vElt8TA6GjZ0N1X6noTBzN50+gP19pix
	 U35tAZmPFMv7gFJcNkZdnsg3dOSX/nITu+tQ9wN6UpMIkl5dn+njoXLc2bgDvavssa
	 z/48VzH6GKNB+h2wQYDFd7wS7YwLgWkiGXyDQ9iVa2ZsTjhP88/mCKJoNX2u7e0WcB
	 U9MT2vAm+MDqoKGOuCAiP8tnEqqgAxH3inlrjtGCVTrdm/2GyoY10iOWKCCktPhBaA
	 TjK1zKXo9iGKQ==
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
	liamwisehart@meta.com,
	shankaran@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v11 bpf-next 4/7] bpf: Extend btf_kfunc_id_set to handle kfunc polymorphism
Date: Wed, 29 Jan 2025 12:59:54 -0800
Message-ID: <20250129205957.2457655-5-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250129205957.2457655-1-song@kernel.org>
References: <20250129205957.2457655-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Polymorphism exists in kernel functions, BPF helpers, as well as kfuncs.
When called from different contexts, it is necessary to pick the right
version of a kfunc. One of such example is bpf_dynptr_from_skb vs.
bpf_dynptr_from_skb_rdonly.

To avoid the burden on the users, the verifier can inspect the calling
context and select the right version of kfunc. However, with more kfuncs
being added to the kernel, it is not scalable to push all these logic
to the verifiler.

Extend btf_kfunc_id_set to handle kfunc polymorphism. Specifically,
a list of kfuncs, "hidden_set", and a new method "remap" is added to
btf_kfunc_id_set. kfuncs in hidden_set do not have BTF_SET8_KFUNCS flag,
and are not exposed in vmlinux.h. The remap method is used to inspect
the calling context, and when necessary, remap the user visible kfuncs
(for example, bpf_dynptr_from_skb), to its hidden version (for example,
bpf_dynptr_from_skb_rdonly).

The verifier calls in these remap logic via the new btf_kfunc_id_remap()
API, and picks the right kfuncs for the context.

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/btf.h     |  20 +++++++
 include/linux/btf_ids.h |   4 ++
 kernel/bpf/btf.c        | 117 ++++++++++++++++++++++++++++++++++------
 kernel/bpf/verifier.c   |   6 ++-
 4 files changed, 128 insertions(+), 19 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 2a08a2b55592..065c374c4372 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -114,11 +114,23 @@ struct btf_id_set;
 struct bpf_prog;
 
 typedef int (*btf_kfunc_filter_t)(const struct bpf_prog *prog, u32 kfunc_id);
+typedef u32 (*btf_kfunc_remap_t)(const struct bpf_prog *prog, u32 kfunc_id);
 
 struct btf_kfunc_id_set {
 	struct module *owner;
 	struct btf_id_set8 *set;
+
+	/* *hidden_set* contains kfuncs that are not exposed as kfunc in
+	 * vmlinux.h. These kfuncs are usually a variation of a kfunc
+	 * in *set*.
+	 */
+	struct btf_id_set8 *hidden_set;
 	btf_kfunc_filter_t filter;
+
+	/* *remap* method remaps kfuncs in *set* to proper version in
+	 * *hidden_set*.
+	 */
+	btf_kfunc_remap_t remap;
 };
 
 struct btf_id_dtor_kfunc {
@@ -575,6 +587,8 @@ u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 			      const struct btf_kfunc_id_set *s);
 int register_btf_fmodret_id_set(const struct btf_kfunc_id_set *kset);
+u32 btf_kfunc_id_remap(const struct btf *btf, u32 kfunc_btf_id,
+		       const struct bpf_prog *prog);
 s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id);
 int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
 				struct module *owner);
@@ -637,6 +651,12 @@ static inline u32 *btf_kfunc_id_set_contains(const struct btf *btf,
 {
 	return NULL;
 }
+static inline u32 btf_kfunc_id_remap(const struct btf *btf, u32 kfunc_btf_id,
+				     const struct bpf_prog *prog)
+{
+	return kfunc_btf_id;
+}
+
 static inline int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 					    const struct btf_kfunc_id_set *s)
 {
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 139bdececdcf..0744b84e64a9 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -212,6 +212,9 @@ extern struct btf_id_set8 name;
 #define BTF_KFUNCS_START(name)				\
 __BTF_SET8_START(name, local, BTF_SET8_KFUNCS)
 
+#define BTF_HIDDEN_KFUNCS_START(name)			\
+__BTF_SET8_START(name, local, 0)
+
 #define BTF_KFUNCS_END(name)				\
 BTF_SET8_END(name)
 
@@ -230,6 +233,7 @@ BTF_SET8_END(name)
 #define BTF_SET8_START(name) static struct btf_id_set8 __maybe_unused name = { 0 };
 #define BTF_SET8_END(name)
 #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
+#define BTF_HIDDEN_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
 #define BTF_KFUNCS_END(name)
 
 #endif /* CONFIG_DEBUG_INFO_BTF */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8396ce1d0fba..0ffe99205e9c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -226,6 +226,7 @@ enum {
 	BTF_KFUNC_SET_MAX_CNT = 256,
 	BTF_DTOR_KFUNC_MAX_CNT = 256,
 	BTF_KFUNC_FILTER_MAX_CNT = 16,
+	BTF_KFUNC_REMAP_MAX_CNT = 16,
 };
 
 struct btf_kfunc_hook_filter {
@@ -233,9 +234,15 @@ struct btf_kfunc_hook_filter {
 	u32 nr_filters;
 };
 
+struct btf_kfunc_hook_remap {
+	btf_kfunc_remap_t remaps[BTF_KFUNC_REMAP_MAX_CNT];
+	u32 nr_remaps;
+};
+
 struct btf_kfunc_set_tab {
 	struct btf_id_set8 *sets[BTF_KFUNC_HOOK_MAX];
 	struct btf_kfunc_hook_filter hook_filters[BTF_KFUNC_HOOK_MAX];
+	struct btf_kfunc_hook_remap hook_remaps[BTF_KFUNC_HOOK_MAX];
 };
 
 struct btf_id_dtor_kfunc_tab {
@@ -8372,16 +8379,35 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
 
 /* Kernel Function (kfunc) BTF ID set registration API */
 
+static void btf_add_kfunc_to_set(struct btf *btf, struct btf_id_set8 *set,
+				 struct btf_id_set8 *add_set)
+{
+	u32 i;
+
+	if (!add_set)
+		return;
+	/* Concatenate the two sets */
+	memcpy(set->pairs + set->cnt, add_set->pairs, add_set->cnt * sizeof(set->pairs[0]));
+	/* Now that the set is copied, update with relocated BTF ids */
+	for (i = set->cnt; i < set->cnt + add_set->cnt; i++)
+		set->pairs[i].id = btf_relocate_id(btf, set->pairs[i].id);
+
+	set->cnt += add_set->cnt;
+
+	sort(set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func, NULL);
+}
+
 static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 				  const struct btf_kfunc_id_set *kset)
 {
 	struct btf_kfunc_hook_filter *hook_filter;
-	struct btf_id_set8 *add_set = kset->set;
+	struct btf_kfunc_hook_remap *hook_remap;
 	bool vmlinux_set = !btf_is_module(btf);
 	bool add_filter = !!kset->filter;
+	bool add_remap = !!kset->remap;
 	struct btf_kfunc_set_tab *tab;
 	struct btf_id_set8 *set;
-	u32 set_cnt, i;
+	u32 set_cnt, add_cnt, i;
 	int ret;
 
 	if (hook >= BTF_KFUNC_HOOK_MAX) {
@@ -8389,14 +8415,16 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 		goto end;
 	}
 
-	if (!add_set->cnt)
+	add_cnt = kset->set->cnt;
+	if (kset->hidden_set)
+		add_cnt += kset->hidden_set->cnt;
+
+	if (!add_cnt)
 		return 0;
 
 	tab = btf->kfunc_set_tab;
 
 	if (tab && add_filter) {
-		u32 i;
-
 		hook_filter = &tab->hook_filters[hook];
 		for (i = 0; i < hook_filter->nr_filters; i++) {
 			if (hook_filter->filters[i] == kset->filter) {
@@ -8411,6 +8439,21 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 		}
 	}
 
+	if (tab && add_remap) {
+		hook_remap = &tab->hook_remaps[hook];
+		for (i = 0; i < hook_remap->nr_remaps; i++) {
+			if (hook_remap->remaps[i] == kset->remap) {
+				add_remap = false;
+				break;
+			}
+		}
+
+		if (add_remap && hook_remap->nr_remaps == BTF_KFUNC_REMAP_MAX_CNT) {
+			ret = -E2BIG;
+			goto end;
+		}
+	}
+
 	if (!tab) {
 		tab = kzalloc(sizeof(*tab), GFP_KERNEL | __GFP_NOWARN);
 		if (!tab)
@@ -8439,19 +8482,19 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 	 */
 	set_cnt = set ? set->cnt : 0;
 
-	if (set_cnt > U32_MAX - add_set->cnt) {
+	if (set_cnt > U32_MAX - add_cnt) {
 		ret = -EOVERFLOW;
 		goto end;
 	}
 
-	if (set_cnt + add_set->cnt > BTF_KFUNC_SET_MAX_CNT) {
+	if (set_cnt + add_cnt > BTF_KFUNC_SET_MAX_CNT) {
 		ret = -E2BIG;
 		goto end;
 	}
 
 	/* Grow set */
 	set = krealloc(tab->sets[hook],
-		       offsetof(struct btf_id_set8, pairs[set_cnt + add_set->cnt]),
+		       offsetof(struct btf_id_set8, pairs[set_cnt + add_cnt]),
 		       GFP_KERNEL | __GFP_NOWARN);
 	if (!set) {
 		ret = -ENOMEM;
@@ -8463,20 +8506,18 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 		set->cnt = 0;
 	tab->sets[hook] = set;
 
-	/* Concatenate the two sets */
-	memcpy(set->pairs + set->cnt, add_set->pairs, add_set->cnt * sizeof(set->pairs[0]));
-	/* Now that the set is copied, update with relocated BTF ids */
-	for (i = set->cnt; i < set->cnt + add_set->cnt; i++)
-		set->pairs[i].id = btf_relocate_id(btf, set->pairs[i].id);
-
-	set->cnt += add_set->cnt;
-
-	sort(set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func, NULL);
+	btf_add_kfunc_to_set(btf, set, kset->set);
+	btf_add_kfunc_to_set(btf, set, kset->hidden_set);
 
 	if (add_filter) {
 		hook_filter = &tab->hook_filters[hook];
 		hook_filter->filters[hook_filter->nr_filters++] = kset->filter;
 	}
+
+	if (add_remap) {
+		hook_remap = &tab->hook_remaps[hook];
+		hook_remap->remaps[hook_remap->nr_remaps++] = kset->remap;
+	}
 	return 0;
 end:
 	btf_free_kfunc_set_tab(btf);
@@ -8511,6 +8552,28 @@ static u32 *__btf_kfunc_id_set_contains(const struct btf *btf,
 	return id + 1;
 }
 
+static u32 __btf_kfunc_id_remap(const struct btf *btf,
+				enum btf_kfunc_hook hook,
+				u32 kfunc_btf_id,
+				const struct bpf_prog *prog)
+{
+	struct btf_kfunc_hook_remap *hook_remap;
+	u32 i, remap_id = 0;
+
+	if (hook >= BTF_KFUNC_HOOK_MAX)
+		return 0;
+	if (!btf->kfunc_set_tab)
+		return 0;
+	hook_remap = &btf->kfunc_set_tab->hook_remaps[hook];
+
+	for (i = 0; i < hook_remap->nr_remaps; i++) {
+		remap_id = hook_remap->remaps[i](prog, kfunc_btf_id);
+		if (remap_id)
+			break;
+	}
+	return remap_id;
+}
+
 static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 {
 	switch (prog_type) {
@@ -8579,6 +8642,26 @@ u32 *btf_kfunc_id_set_contains(const struct btf *btf,
 	return __btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id, prog);
 }
 
+/* Reference to the module (obtained using btf_try_get_module)
+ * corresponding to the struct btf *MUST* be held when calling this
+ * function from the verifier
+ */
+u32 btf_kfunc_id_remap(const struct btf *btf, u32 kfunc_btf_id,
+		       const struct bpf_prog *prog)
+{
+	enum bpf_prog_type prog_type = resolve_prog_type(prog);
+	enum btf_kfunc_hook hook;
+	u32 remap_id;
+
+	remap_id = __btf_kfunc_id_remap(btf, BTF_KFUNC_HOOK_COMMON, kfunc_btf_id, prog);
+	if (remap_id)
+		return remap_id;
+
+	hook = bpf_prog_type_to_kfunc_hook(prog_type);
+	remap_id = __btf_kfunc_id_remap(btf, hook, kfunc_btf_id, prog);
+	return remap_id ?: kfunc_btf_id;
+}
+
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 				const struct bpf_prog *prog)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..2188b6674266 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3030,13 +3030,14 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
 	return btf_vmlinux ?: ERR_PTR(-ENOENT);
 }
 
-static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
+static int add_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn, s16 offset)
 {
 	const struct btf_type *func, *func_proto;
 	struct bpf_kfunc_btf_tab *btf_tab;
 	struct bpf_kfunc_desc_tab *tab;
 	struct bpf_prog_aux *prog_aux;
 	struct bpf_kfunc_desc *desc;
+	u32 func_id = insn->imm;
 	const char *func_name;
 	struct btf *desc_btf;
 	unsigned long call_imm;
@@ -3095,6 +3096,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 		return PTR_ERR(desc_btf);
 	}
 
+	func_id = insn->imm = btf_kfunc_id_remap(desc_btf, insn->imm, env->prog);
 	if (find_kfunc_desc(env->prog, func_id, offset))
 		return 0;
 
@@ -3228,7 +3230,7 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 		if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn))
 			ret = add_subprog(env, i + insn->imm + 1);
 		else
-			ret = add_kfunc_call(env, insn->imm, insn->off);
+			ret = add_kfunc_call(env, insn, insn->off);
 
 		if (ret < 0)
 			return ret;
-- 
2.43.5


