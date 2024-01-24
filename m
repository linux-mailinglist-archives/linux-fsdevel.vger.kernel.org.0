Return-Path: <linux-fsdevel+bounces-8646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D00839EC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3341C2197F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5460AF4EF;
	Wed, 24 Jan 2024 02:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4uXpFa+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C35CE563;
	Wed, 24 Jan 2024 02:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062921; cv=none; b=ow+uvKcZBz7NBy4Y0+x8Y6EowBJtJol35o76cGO3B24yLrI21nLvRljOjOCJbXQN/Plo7sYabiO1yfZmpsn4m9Vn7KaJUBU9nPa1TkVyB8Tn+qUU6x1+zA6vfKXrFxDnJ+WwW6npgsA7CA6xRseCEzmcthZVrD3jtS51tRBGMwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062921; c=relaxed/simple;
	bh=3SX7jkD5rtK0+bN7R5P0N/s/Ix9yOhKSRZiUDtbp6FU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LecRcUZgXCxyq3JBxZ9MVVyWIjJ7ArmARH3/15U81ALE63QbQVgPfafRxTjBNDvkBvIRUV3AhunSvzJuAimKWVikaUNG6xL4bIO+k+skoepYGjd4GaS+l7NlH/hu1Ljdy5ZULpu3qW6QWwoWjX9TVcL6b32TMVhlX2mOXatKN0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4uXpFa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA10C43390;
	Wed, 24 Jan 2024 02:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062921;
	bh=3SX7jkD5rtK0+bN7R5P0N/s/Ix9yOhKSRZiUDtbp6FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4uXpFa+cR4cOuIwliM4t3MGWb8CiYqy2dPTGBYIpgQwXfty9qTyeuRIaOR2pFbni
	 hJIFvpKp95o0LTMfO37YGIdSIFZynC5W1MsFwNJ0fQNtWlUueBKOPO1zCZ0Dtyg+Gx
	 4jjjJC9c6tQXZxDyRVhmi0BD3sKK4zY7qHYQME90G1YxIxhyawFNoYeke7YJX3OSOL
	 itAS6QyGe5xGqh/mBuclrkh+SJf9bYMCjjZrll9m/ycVt134527v+ZfDD+HnSPVX41
	 B9hGQTNwcuqLVDdTCuOuNNtAiRFS08is2STjt/cXbWLZGMAfVgmZdzqPO6PeQvFvRd
	 q5zdnHyMX1S5Q==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 08/30] bpf: consistently use BPF token throughout BPF verifier logic
Date: Tue, 23 Jan 2024 18:21:05 -0800
Message-Id: <20240124022127.2379740-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124022127.2379740-1-andrii@kernel.org>
References: <20240124022127.2379740-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove remaining direct queries to perfmon_capable() and bpf_capable()
in BPF verifier logic and instead use BPF token (if available) to make
decisions about privileges.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h    | 16 ++++++++--------
 include/linux/filter.h |  2 +-
 kernel/bpf/arraymap.c  |  2 +-
 kernel/bpf/core.c      |  2 +-
 kernel/bpf/verifier.c  | 13 ++++++-------
 net/core/filter.c      |  4 ++--
 6 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 87694115fac0..1b556c74f43f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2232,24 +2232,24 @@ extern int sysctl_unprivileged_bpf_disabled;
 
 bool bpf_token_capable(const struct bpf_token *token, int cap);
 
-static inline bool bpf_allow_ptr_leaks(void)
+static inline bool bpf_allow_ptr_leaks(const struct bpf_token *token)
 {
-	return perfmon_capable();
+	return bpf_token_capable(token, CAP_PERFMON);
 }
 
-static inline bool bpf_allow_uninit_stack(void)
+static inline bool bpf_allow_uninit_stack(const struct bpf_token *token)
 {
-	return perfmon_capable();
+	return bpf_token_capable(token, CAP_PERFMON);
 }
 
-static inline bool bpf_bypass_spec_v1(void)
+static inline bool bpf_bypass_spec_v1(const struct bpf_token *token)
 {
-	return cpu_mitigations_off() || perfmon_capable();
+	return cpu_mitigations_off() || bpf_token_capable(token, CAP_PERFMON);
 }
 
-static inline bool bpf_bypass_spec_v4(void)
+static inline bool bpf_bypass_spec_v4(const struct bpf_token *token)
 {
-	return cpu_mitigations_off() || perfmon_capable();
+	return cpu_mitigations_off() || bpf_token_capable(token, CAP_PERFMON);
 }
 
 int bpf_map_new_fd(struct bpf_map *map, int flags);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 35f067fd3840..fee070b9826e 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1140,7 +1140,7 @@ static inline bool bpf_jit_blinding_enabled(struct bpf_prog *prog)
 		return false;
 	if (!bpf_jit_harden)
 		return false;
-	if (bpf_jit_harden == 1 && bpf_capable())
+	if (bpf_jit_harden == 1 && bpf_token_capable(prog->aux->token, CAP_BPF))
 		return false;
 
 	return true;
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 0bdbbbeab155..13358675ff2e 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -82,7 +82,7 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 	bool percpu = attr->map_type == BPF_MAP_TYPE_PERCPU_ARRAY;
 	int numa_node = bpf_map_attr_numa_node(attr);
 	u32 elem_size, index_mask, max_entries;
-	bool bypass_spec_v1 = bpf_bypass_spec_v1();
+	bool bypass_spec_v1 = bpf_bypass_spec_v1(NULL);
 	u64 array_size, mask64;
 	struct bpf_array *array;
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 00dccba29769..71c459a51d9e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -682,7 +682,7 @@ static bool bpf_prog_kallsyms_candidate(const struct bpf_prog *fp)
 void bpf_prog_kallsyms_add(struct bpf_prog *fp)
 {
 	if (!bpf_prog_kallsyms_candidate(fp) ||
-	    !bpf_capable())
+	    !bpf_token_capable(fp->aux->token, CAP_BPF))
 		return;
 
 	bpf_prog_ksym_set_addr(fp);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e9cc132dd02..73ae8b45b641 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20816,7 +20816,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
 	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
-	is_priv = bpf_capable();
+
+	env->allow_ptr_leaks = bpf_allow_ptr_leaks(env->prog->aux->token);
+	env->allow_uninit_stack = bpf_allow_uninit_stack(env->prog->aux->token);
+	env->bypass_spec_v1 = bpf_bypass_spec_v1(env->prog->aux->token);
+	env->bypass_spec_v4 = bpf_bypass_spec_v4(env->prog->aux->token);
+	env->bpf_capable = is_priv = bpf_token_capable(env->prog->aux->token, CAP_BPF);
 
 	bpf_get_btf_vmlinux();
 
@@ -20848,12 +20853,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (attr->prog_flags & BPF_F_ANY_ALIGNMENT)
 		env->strict_alignment = false;
 
-	env->allow_ptr_leaks = bpf_allow_ptr_leaks();
-	env->allow_uninit_stack = bpf_allow_uninit_stack();
-	env->bypass_spec_v1 = bpf_bypass_spec_v1();
-	env->bypass_spec_v4 = bpf_bypass_spec_v4();
-	env->bpf_capable = bpf_capable();
-
 	if (is_priv)
 		env->test_state_freq = attr->prog_flags & BPF_F_TEST_STATE_FREQ;
 	env->test_reg_invariants = attr->prog_flags & BPF_F_TEST_REG_INVARIANTS;
diff --git a/net/core/filter.c b/net/core/filter.c
index 521bcd0f5e4d..40121475e8d1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8580,7 +8580,7 @@ static bool cg_skb_is_valid_access(int off, int size,
 		return false;
 	case bpf_ctx_range(struct __sk_buff, data):
 	case bpf_ctx_range(struct __sk_buff, data_end):
-		if (!bpf_capable())
+		if (!bpf_token_capable(prog->aux->token, CAP_BPF))
 			return false;
 		break;
 	}
@@ -8592,7 +8592,7 @@ static bool cg_skb_is_valid_access(int off, int size,
 		case bpf_ctx_range_till(struct __sk_buff, cb[0], cb[4]):
 			break;
 		case bpf_ctx_range(struct __sk_buff, tstamp):
-			if (!bpf_capable())
+			if (!bpf_token_capable(prog->aux->token, CAP_BPF))
 				return false;
 			break;
 		default:
-- 
2.34.1


