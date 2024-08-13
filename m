Return-Path: <linux-fsdevel+bounces-25833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F6995102D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 01:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4D51C2265F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDF21AC434;
	Tue, 13 Aug 2024 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dj8UIw/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4C0183CAD;
	Tue, 13 Aug 2024 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590205; cv=none; b=fRKe4f9KQmIW560LV0ZSvEIsEkdhOYSmVrliLc+hYKAW8SpBywd5YtiBGWQbss34Mclx0JjMt1tCVlEuDmpwSUQXUCxQwWXHlgwiCVLdYYhc784Yl16B0pry9xUOiyK5gn6FUqz58qmfgwv3ozW/r4FIMAHBKqNh2aGqyHEERUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590205; c=relaxed/simple;
	bh=NeUoxEqpb7RO0TujT+JXKZO3CYi5Yb07K3mzhzAfO5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eD+OFGVQiNaid3bQ5E03LoKmbSm4JlWjUs2vsTQfnOJPj8JXJ0kWdfa9Vc6pHbktij26IFznexZok5oxpAwst6Byyw+cBEIafy/mlImUOaHzJVs5Qc/8o92U0JnsKQN3IlWd6UN0RQlazMtOxevwhp3smNf4egXrmCFPtlnUwW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dj8UIw/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B155C4AF10;
	Tue, 13 Aug 2024 23:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723590205;
	bh=NeUoxEqpb7RO0TujT+JXKZO3CYi5Yb07K3mzhzAfO5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dj8UIw/FjsDxinKPZCjtbtiAcpXJBleZ1ORrsiNyRl+5aF5jWKuEhXeD0KKk6Wb9J
	 gR8mMSClfEO3QBGBIjNwJN1BOalgubN2Tv418cV47OSeumWvyux5DLZPp4YqMRXB9R
	 4AcPsCtZCXnKE7ebla4XqROI6dynxflKX0Iij9wHoXub/JHiv4VS6r6NCepuhE54aE
	 xbUIx4+D/t1XADsumTjY9fH1dfJ1KgXRlMW8s+vMJ0+fB6vAMpqyX9kjfTL4u5ZSj6
	 C+YrHjPRtaZCnk4Ojg2DvNGrWE5xHMU7uu9aXcKdplKX93aObthtRb4fp+aDMvzaiB
	 wdCLeorSmjQ4g==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: viro@kernel.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 3/8] bpf: factor out fetching bpf_map from FD and adding it to used_maps list
Date: Tue, 13 Aug 2024 16:02:55 -0700
Message-ID: <20240813230300.915127-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813230300.915127-1-andrii@kernel.org>
References: <20240813230300.915127-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out the logic to extract bpf_map instances from FD embedded in
bpf_insns, adding it to the list of used_maps (unless it's already
there, in which case we just reuse map's index). This simplifies the
logic in resolve_pseudo_ldimm64(), especially around `struct fd`
handling, as all that is now neatly contained in the helper and doesn't
leak into a dozen error handling paths.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 115 ++++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 49 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index df3be12096cf..14e4ef687a59 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18865,6 +18865,58 @@ static bool bpf_map_is_cgroup_storage(struct bpf_map *map)
 		map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
 }
 
+/* Add map behind fd to used maps list, if it's not already there, and return
+ * its index. Also set *reused to true if this map was already in the list of
+ * used maps.
+ * Returns <0 on error, or >= 0 index, on success.
+ */
+static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd, bool *reused)
+{
+	struct fd f = fdget(fd);
+	struct bpf_map *map;
+	int i;
+
+	map = __bpf_map_get(f);
+	if (IS_ERR(map)) {
+		verbose(env, "fd %d is not pointing to valid bpf_map\n", fd);
+		return PTR_ERR(map);
+	}
+
+	/* check whether we recorded this map already */
+	for (i = 0; i < env->used_map_cnt; i++) {
+		if (env->used_maps[i] == map) {
+			*reused = true;
+			fdput(f);
+			return i;
+		}
+	}
+
+	if (env->used_map_cnt >= MAX_USED_MAPS) {
+		verbose(env, "The total number of maps per program has reached the limit of %u\n",
+			MAX_USED_MAPS);
+		fdput(f);
+		return -E2BIG;
+	}
+
+	if (env->prog->sleepable)
+		atomic64_inc(&map->sleepable_refcnt);
+
+	/* hold the map. If the program is rejected by verifier,
+	 * the map will be released by release_maps() or it
+	 * will be used by the valid program until it's unloaded
+	 * and all maps are released in bpf_free_used_maps()
+	 */
+	bpf_map_inc(map);
+
+	*reused = false;
+	env->used_maps[env->used_map_cnt++] = map;
+
+	fdput(f);
+
+	return env->used_map_cnt - 1;
+
+}
+
 /* find and rewrite pseudo imm in ld_imm64 instructions:
  *
  * 1. if it accesses map FD, replace it with actual map pointer.
@@ -18876,7 +18928,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 {
 	struct bpf_insn *insn = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
-	int i, j, err;
+	int i, err;
 
 	err = bpf_prog_calc_tag(env->prog);
 	if (err)
@@ -18893,9 +18945,10 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 		if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
 			struct bpf_insn_aux_data *aux;
 			struct bpf_map *map;
-			struct fd f;
+			int map_idx;
 			u64 addr;
 			u32 fd;
+			bool reused;
 
 			if (i == insn_cnt - 1 || insn[1].code != 0 ||
 			    insn[1].dst_reg != 0 || insn[1].src_reg != 0 ||
@@ -18956,20 +19009,18 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				break;
 			}
 
-			f = fdget(fd);
-			map = __bpf_map_get(f);
-			if (IS_ERR(map)) {
-				verbose(env, "fd %d is not pointing to valid bpf_map\n", fd);
-				return PTR_ERR(map);
-			}
+			map_idx = add_used_map_from_fd(env, fd, &reused);
+			if (map_idx < 0)
+				return map_idx;
+			map = env->used_maps[map_idx];
+
+			aux = &env->insn_aux_data[i];
+			aux->map_index = map_idx;
 
 			err = check_map_prog_compatibility(env, map, env->prog);
-			if (err) {
-				fdput(f);
+			if (err)
 				return err;
-			}
 
-			aux = &env->insn_aux_data[i];
 			if (insn[0].src_reg == BPF_PSEUDO_MAP_FD ||
 			    insn[0].src_reg == BPF_PSEUDO_MAP_IDX) {
 				addr = (unsigned long)map;
@@ -18978,13 +19029,11 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 
 				if (off >= BPF_MAX_VAR_OFF) {
 					verbose(env, "direct value offset of %u is not allowed\n", off);
-					fdput(f);
 					return -EINVAL;
 				}
 
 				if (!map->ops->map_direct_value_addr) {
 					verbose(env, "no direct value access support for this map type\n");
-					fdput(f);
 					return -EINVAL;
 				}
 
@@ -18992,7 +19041,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				if (err) {
 					verbose(env, "invalid access to map value pointer, value_size=%u off=%u\n",
 						map->value_size, off);
-					fdput(f);
 					return err;
 				}
 
@@ -19003,70 +19051,39 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			insn[0].imm = (u32)addr;
 			insn[1].imm = addr >> 32;
 
-			/* check whether we recorded this map already */
-			for (j = 0; j < env->used_map_cnt; j++) {
-				if (env->used_maps[j] == map) {
-					aux->map_index = j;
-					fdput(f);
-					goto next_insn;
-				}
-			}
-
-			if (env->used_map_cnt >= MAX_USED_MAPS) {
-				verbose(env, "The total number of maps per program has reached the limit of %u\n",
-					MAX_USED_MAPS);
-				fdput(f);
-				return -E2BIG;
-			}
-
-			if (env->prog->sleepable)
-				atomic64_inc(&map->sleepable_refcnt);
-			/* hold the map. If the program is rejected by verifier,
-			 * the map will be released by release_maps() or it
-			 * will be used by the valid program until it's unloaded
-			 * and all maps are released in bpf_free_used_maps()
-			 */
-			bpf_map_inc(map);
-
-			aux->map_index = env->used_map_cnt;
-			env->used_maps[env->used_map_cnt++] = map;
+			/* proceed with extra checks only if its newly added used map */
+			if (reused)
+				goto next_insn;
 
 			if (bpf_map_is_cgroup_storage(map) &&
 			    bpf_cgroup_storage_assign(env->prog->aux, map)) {
 				verbose(env, "only one cgroup storage of each type is allowed\n");
-				fdput(f);
 				return -EBUSY;
 			}
 			if (map->map_type == BPF_MAP_TYPE_ARENA) {
 				if (env->prog->aux->arena) {
 					verbose(env, "Only one arena per program\n");
-					fdput(f);
 					return -EBUSY;
 				}
 				if (!env->allow_ptr_leaks || !env->bpf_capable) {
 					verbose(env, "CAP_BPF and CAP_PERFMON are required to use arena\n");
-					fdput(f);
 					return -EPERM;
 				}
 				if (!env->prog->jit_requested) {
 					verbose(env, "JIT is required to use arena\n");
-					fdput(f);
 					return -EOPNOTSUPP;
 				}
 				if (!bpf_jit_supports_arena()) {
 					verbose(env, "JIT doesn't support arena\n");
-					fdput(f);
 					return -EOPNOTSUPP;
 				}
 				env->prog->aux->arena = (void *)map;
 				if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
 					verbose(env, "arena's user address must be set via map_extra or mmap()\n");
-					fdput(f);
 					return -EINVAL;
 				}
 			}
 
-			fdput(f);
 next_insn:
 			insn++;
 			i++;
-- 
2.43.5


