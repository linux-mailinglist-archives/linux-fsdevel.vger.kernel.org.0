Return-Path: <linux-fsdevel+bounces-40341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E2AA22562
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 22:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3326E3A49AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE4C1E7C23;
	Wed, 29 Jan 2025 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tF5TUuxE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8FA1E32BB;
	Wed, 29 Jan 2025 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738184443; cv=none; b=doQOrzW+nPCW3kGoPwc7bqFB6D9rL/iJ2st5lO8Pj4jDiGKvRqY00qo3Kc1dfQP/2M7QH95YOCClagvWnTLszUIkCjqV3w+Kzpmmo13F632xAECmp1cGxj70LHWV8DOmrsmxWkXLlE7gsrbjPpMOtMKQCaaZBf85zbde9+UIZf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738184443; c=relaxed/simple;
	bh=bnZrm3/Hb1nIJZ7r0LF83ktCbGI3OtlCz4w9SdkVqrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ay8gwDAwW8W+hbpFQA4G0gtH/gZvqvLS8FPk+qUFFlY1fI1jW6Osub2+ow1xLliY6v4jMANpMEcsBzoJtWQw6lLPoQs58DtymAEsJ7WerRSF4/11mQXqewGCK6gr/JbKZ1cm3uvLYD11B5t4nfHt7NP05JEHDduxez3i6aGKeqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tF5TUuxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D09EC4CEE0;
	Wed, 29 Jan 2025 21:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738184442;
	bh=bnZrm3/Hb1nIJZ7r0LF83ktCbGI3OtlCz4w9SdkVqrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tF5TUuxEJpGV9YAkjJssE8h979y3vXhZuunQdMTwiRgRX9mHxQzvYOmvz4bjzgiae
	 FgjQxLTVwmVjMW2+VkxD8Tn2Ss5ImmbWyaqMkVcHjGaKxBPBAZ7XqfTSbaWDmJ55dp
	 dyO04w2TQXDC7Bg0hdWeVeDbrUzemH8cFT1f7aCyvRMYkLiQsYwoQx8anXpf1lbjPN
	 qAOsAVDCtywmljgTUY7LdPtw8Pjb1G28dMRYIBKO99LONh5MrBi/ulNGEjSsgEGd2S
	 Xq2m3Ry/F5qoce7i62hMQySR47m1zSIjSBjAsfg7GK3VtfuAc5xqHwNuOinbW89jFn
	 fsTWZ7CDcKm+Q==
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
Subject: [PATCH v11 bpf-next 5/7] bpf: Use btf_kfunc_id_set.remap logic for bpf_dynptr_from_skb
Date: Wed, 29 Jan 2025 12:59:55 -0800
Message-ID: <20250129205957.2457655-6-song@kernel.org>
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

btf_kfunc_id_set.remap can pick proper version of a kfunc for the calling
context. Use this logic to select bpf_dynptr_from_skb or
bpf_dynptr_from_skb_rdonly. This will make the verifier simpler.

Unfortunately, btf_kfunc_id_set.remap cannot cover the DYNPTR_TYPE_SKB
logic in check_kfunc_args(). This can be addressed later.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/verifier.c | 25 ++++++----------------
 net/core/filter.c     | 49 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2188b6674266..55e710e318e5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11750,6 +11750,7 @@ enum special_kfunc_type {
 	KF_bpf_rbtree_add_impl,
 	KF_bpf_rbtree_first,
 	KF_bpf_dynptr_from_skb,
+	KF_bpf_dynptr_from_skb_rdonly,
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
@@ -11785,6 +11786,7 @@ BTF_ID(func, bpf_rbtree_add_impl)
 BTF_ID(func, bpf_rbtree_first)
 #ifdef CONFIG_NET
 BTF_ID(func, bpf_dynptr_from_skb)
+BTF_ID(func, bpf_dynptr_from_skb_rdonly)
 BTF_ID(func, bpf_dynptr_from_xdp)
 #endif
 BTF_ID(func, bpf_dynptr_slice)
@@ -11816,10 +11818,12 @@ BTF_ID(func, bpf_rbtree_add_impl)
 BTF_ID(func, bpf_rbtree_first)
 #ifdef CONFIG_NET
 BTF_ID(func, bpf_dynptr_from_skb)
+BTF_ID(func, bpf_dynptr_from_skb_rdonly)
 BTF_ID(func, bpf_dynptr_from_xdp)
 #else
 BTF_ID_UNUSED
 BTF_ID_UNUSED
+BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
@@ -12741,7 +12745,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (is_kfunc_arg_uninit(btf, &args[i]))
 				dynptr_arg_type |= MEM_UNINIT;
 
-			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
+			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb] ||
+			    meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_rdonly]) {
 				dynptr_arg_type |= DYNPTR_TYPE_SKB;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_xdp]) {
 				dynptr_arg_type |= DYNPTR_TYPE_XDP;
@@ -20898,9 +20903,7 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
 			     u32 func_id, u16 offset, unsigned long *addr)
 {
 	struct bpf_prog *prog = env->prog;
-	bool seen_direct_write;
 	void *xdp_kfunc;
-	bool is_rdonly;
 
 	if (bpf_dev_bound_kfunc_id(func_id)) {
 		xdp_kfunc = bpf_dev_bound_resolve_kfunc(prog, func_id);
@@ -20910,22 +20913,6 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
 		}
 		/* fallback to default kfunc when not supported by netdev */
 	}
-
-	if (offset)
-		return;
-
-	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
-		seen_direct_write = env->seen_direct_write;
-		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
-
-		if (is_rdonly)
-			*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
-
-		/* restore env->seen_direct_write to its original value, since
-		 * may_access_direct_pkt_data mutates it
-		 */
-		env->seen_direct_write = seen_direct_write;
-	}
 }
 
 static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
diff --git a/net/core/filter.c b/net/core/filter.c
index 2ec162dd83c4..6416689e3976 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12062,10 +12062,8 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 #endif
 }
 
-__bpf_kfunc_end_defs();
-
-int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
-			       struct bpf_dynptr *ptr__uninit)
+__bpf_kfunc int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
+					   struct bpf_dynptr *ptr__uninit)
 {
 	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)ptr__uninit;
 	int err;
@@ -12079,10 +12077,16 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 	return 0;
 }
 
+__bpf_kfunc_end_defs();
+
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
 
+BTF_HIDDEN_KFUNCS_START(bpf_kfunc_check_hidden_set_skb)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb_rdonly, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_kfunc_check_hidden_set_skb)
+
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
@@ -12095,9 +12099,46 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
 BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
 
+BTF_ID_LIST(bpf_dynptr_from_skb_list)
+BTF_ID(func, bpf_dynptr_from_skb)
+BTF_ID(func, bpf_dynptr_from_skb_rdonly)
+
+static u32 bpf_kfunc_set_skb_remap(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (kfunc_id != bpf_dynptr_from_skb_list[0])
+		return 0;
+
+	switch (resolve_prog_type(prog)) {
+	/* Program types only with direct read access go here! */
+	case BPF_PROG_TYPE_LWT_IN:
+	case BPF_PROG_TYPE_LWT_OUT:
+	case BPF_PROG_TYPE_LWT_SEG6LOCAL:
+	case BPF_PROG_TYPE_SK_REUSEPORT:
+	case BPF_PROG_TYPE_FLOW_DISSECTOR:
+	case BPF_PROG_TYPE_CGROUP_SKB:
+		return bpf_dynptr_from_skb_list[1];
+
+	/* Program types with direct read + write access go here! */
+	case BPF_PROG_TYPE_SCHED_CLS:
+	case BPF_PROG_TYPE_SCHED_ACT:
+	case BPF_PROG_TYPE_XDP:
+	case BPF_PROG_TYPE_LWT_XMIT:
+	case BPF_PROG_TYPE_SK_SKB:
+	case BPF_PROG_TYPE_SK_MSG:
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+		return kfunc_id;
+
+	default:
+		break;
+	}
+	return bpf_dynptr_from_skb_list[1];
+}
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
+	.hidden_set = &bpf_kfunc_check_hidden_set_skb,
+	.remap = &bpf_kfunc_set_skb_remap,
 };
 
 static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
-- 
2.43.5


