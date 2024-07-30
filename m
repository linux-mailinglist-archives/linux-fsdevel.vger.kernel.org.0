Return-Path: <linux-fsdevel+bounces-24549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7069C94071C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36041F227A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CC6194A64;
	Tue, 30 Jul 2024 05:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1vlCHOv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A6E1946DB;
	Tue, 30 Jul 2024 05:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316503; cv=none; b=ipfK/95QyJPOGHDGqei7OLymAjdXcP7eHPqbeNl5+PovOUOOfgu3C7lV1oVYr1y5ZLisII4n/aQB9Y+cCHDjyn1QH2CZiJPEJcP5dqmx76zsJMtBh/HKU29cOMb046hVV7mNvkppptZcJEr5DU7GidS3nQCA5FOEWtnc3mjDKWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316503; c=relaxed/simple;
	bh=WpkeiWiz+/k5zB+dRm3nS9mBDKgcs0ndyeoTjfkjPuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rwHkS2F9yxwVdVHrS+V0tfTFUbMm296LW0qHUMY7U45tqplTpvawPMPAUYWWEX18sV+86xjpatBWWc0E/Y/Nv3X2/Q1LqSF2XxBu72uV0XzIVd4BzhtLli0akeUUU2Hg1Kt7l2Cq1fX0AOouDN6M5/rhfnqUq9DEiVSFOs3T8/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1vlCHOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E25BC4AF10;
	Tue, 30 Jul 2024 05:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316502;
	bh=WpkeiWiz+/k5zB+dRm3nS9mBDKgcs0ndyeoTjfkjPuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b1vlCHOvpKuH2DkaGBYdmjE8UaYXjdtmkPYXoZSllWU/z+DTc6XPo6v4SUOsxBhdq
	 2oWrLjgx53F4eXMp1PbW/otsjinSahEaaVurt4ZfTHCNi2naTj9bmh5PGx5Jr5a5S9
	 ExeRAZmII6snp5xoMPQxIDVAvoS9zfj4yWu4eTSSjH9oHIy41wCf8xvy2/j+sPYlUR
	 ivRiq6hPIjzxgZo+3ZUczmFXic+z7+ZLikjFKnXi3kAG/DQFm1FwkDj5A7t6cmrcNd
	 iRZnF1SqMH204ECFWke96/jycBEUt8Cc5HfL5XxTsIk8DBQUcbNQn/I42ljsxpMsiA
	 7JtPlUqOCgXTQ==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 17/39] bpf: resolve_pseudo_ldimm64(): take handling of a single ldimm64 insn into helper
Date: Tue, 30 Jul 2024 01:16:03 -0400
Message-Id: <20240730051625.14349-17-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

Equivalent transformation.  For one thing, it's easier to follow that way.
For another, that simplifies the control flow in the vicinity of struct fd
handling in there, which will allow a switch to CLASS(fd) and make the
thing much easier to verify wrt leaks.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/bpf/verifier.c | 342 +++++++++++++++++++++---------------------
 1 file changed, 172 insertions(+), 170 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4cb5441ad75f..d54f61e12062 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18414,11 +18414,180 @@ static bool bpf_map_is_cgroup_storage(struct bpf_map *map)
  *
  * NOTE: btf_vmlinux is required for converting pseudo btf_id.
  */
+static int do_one_ldimm64(struct bpf_verifier_env *env,
+			  struct bpf_insn *insn,
+			  struct bpf_insn_aux_data *aux)
+{
+	struct bpf_map *map;
+	struct fd f;
+	u64 addr;
+	u32 fd;
+	int err;
+
+	if (insn[0].src_reg == 0)
+		/* valid generic load 64-bit imm */
+		return 0;
+
+	if (insn[0].src_reg == BPF_PSEUDO_BTF_ID)
+		return check_pseudo_btf_id(env, insn, aux);
+
+	if (insn[0].src_reg == BPF_PSEUDO_FUNC) {
+		aux->ptr_type = PTR_TO_FUNC;
+		return 0;
+	}
+
+	/* In final convert_pseudo_ld_imm64() step, this is
+	 * converted into regular 64-bit imm load insn.
+	 */
+	switch (insn[0].src_reg) {
+	case BPF_PSEUDO_MAP_VALUE:
+	case BPF_PSEUDO_MAP_IDX_VALUE:
+		break;
+	case BPF_PSEUDO_MAP_FD:
+	case BPF_PSEUDO_MAP_IDX:
+		if (insn[1].imm == 0)
+			break;
+		fallthrough;
+	default:
+		verbose(env, "unrecognized bpf_ld_imm64 insn\n");
+		return -EINVAL;
+	}
+
+	switch (insn[0].src_reg) {
+	case BPF_PSEUDO_MAP_IDX_VALUE:
+	case BPF_PSEUDO_MAP_IDX:
+		if (bpfptr_is_null(env->fd_array)) {
+			verbose(env, "fd_idx without fd_array is invalid\n");
+			return -EPROTO;
+		}
+		if (copy_from_bpfptr_offset(&fd, env->fd_array,
+					    insn[0].imm * sizeof(fd),
+					    sizeof(fd)))
+			return -EFAULT;
+		break;
+	default:
+		fd = insn[0].imm;
+		break;
+	}
+
+	f = fdget(fd);
+	map = __bpf_map_get(f);
+	if (IS_ERR(map)) {
+		verbose(env, "fd %d is not pointing to valid bpf_map\n", fd);
+		return PTR_ERR(map);
+	}
+
+	err = check_map_prog_compatibility(env, map, env->prog);
+	if (err) {
+		fdput(f);
+		return err;
+	}
+
+	if (insn[0].src_reg == BPF_PSEUDO_MAP_FD ||
+	    insn[0].src_reg == BPF_PSEUDO_MAP_IDX) {
+		addr = (unsigned long)map;
+	} else {
+		u32 off = insn[1].imm;
+
+		if (off >= BPF_MAX_VAR_OFF) {
+			verbose(env, "direct value offset of %u is not allowed\n", off);
+			fdput(f);
+			return -EINVAL;
+		}
+
+		if (!map->ops->map_direct_value_addr) {
+			verbose(env, "no direct value access support for this map type\n");
+			fdput(f);
+			return -EINVAL;
+		}
+
+		err = map->ops->map_direct_value_addr(map, &addr, off);
+		if (err) {
+			verbose(env, "invalid access to map value pointer, value_size=%u off=%u\n",
+				map->value_size, off);
+			fdput(f);
+			return err;
+		}
+
+		aux->map_off = off;
+		addr += off;
+	}
+
+	insn[0].imm = (u32)addr;
+	insn[1].imm = addr >> 32;
+
+	/* check whether we recorded this map already */
+	for (int i = 0; i < env->used_map_cnt; i++) {
+		if (env->used_maps[i] == map) {
+			aux->map_index = i;
+			fdput(f);
+			return 0;
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
+	/* hold the map. If the program is rejected by verifier,
+	 * the map will be released by release_maps() or it
+	 * will be used by the valid program until it's unloaded
+	 * and all maps are released in bpf_free_used_maps()
+	 */
+	bpf_map_inc(map);
+
+	aux->map_index = env->used_map_cnt;
+	env->used_maps[env->used_map_cnt++] = map;
+
+	if (bpf_map_is_cgroup_storage(map) &&
+	    bpf_cgroup_storage_assign(env->prog->aux, map)) {
+		verbose(env, "only one cgroup storage of each type is allowed\n");
+		fdput(f);
+		return -EBUSY;
+	}
+	if (map->map_type == BPF_MAP_TYPE_ARENA) {
+		if (env->prog->aux->arena) {
+			verbose(env, "Only one arena per program\n");
+			fdput(f);
+			return -EBUSY;
+		}
+		if (!env->allow_ptr_leaks || !env->bpf_capable) {
+			verbose(env, "CAP_BPF and CAP_PERFMON are required to use arena\n");
+			fdput(f);
+			return -EPERM;
+		}
+		if (!env->prog->jit_requested) {
+			verbose(env, "JIT is required to use arena\n");
+			fdput(f);
+			return -EOPNOTSUPP;
+		}
+		if (!bpf_jit_supports_arena()) {
+			verbose(env, "JIT doesn't support arena\n");
+			fdput(f);
+			return -EOPNOTSUPP;
+		}
+		env->prog->aux->arena = (void *)map;
+		if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
+			verbose(env, "arena's user address must be set via map_extra or mmap()\n");
+			fdput(f);
+			return -EINVAL;
+		}
+	}
+
+	fdput(f);
+	return 0;
+}
+
 static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 {
 	struct bpf_insn *insn = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
-	int i, j, err;
+	int i, err;
 
 	err = bpf_prog_calc_tag(env->prog);
 	if (err)
@@ -18433,12 +18602,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 		}
 
 		if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
-			struct bpf_insn_aux_data *aux;
-			struct bpf_map *map;
-			struct fd f;
-			u64 addr;
-			u32 fd;
-
 			if (i == insn_cnt - 1 || insn[1].code != 0 ||
 			    insn[1].dst_reg != 0 || insn[1].src_reg != 0 ||
 			    insn[1].off != 0) {
@@ -18446,170 +18609,9 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				return -EINVAL;
 			}
 
-			if (insn[0].src_reg == 0)
-				/* valid generic load 64-bit imm */
-				goto next_insn;
-
-			if (insn[0].src_reg == BPF_PSEUDO_BTF_ID) {
-				aux = &env->insn_aux_data[i];
-				err = check_pseudo_btf_id(env, insn, aux);
-				if (err)
-					return err;
-				goto next_insn;
-			}
-
-			if (insn[0].src_reg == BPF_PSEUDO_FUNC) {
-				aux = &env->insn_aux_data[i];
-				aux->ptr_type = PTR_TO_FUNC;
-				goto next_insn;
-			}
-
-			/* In final convert_pseudo_ld_imm64() step, this is
-			 * converted into regular 64-bit imm load insn.
-			 */
-			switch (insn[0].src_reg) {
-			case BPF_PSEUDO_MAP_VALUE:
-			case BPF_PSEUDO_MAP_IDX_VALUE:
-				break;
-			case BPF_PSEUDO_MAP_FD:
-			case BPF_PSEUDO_MAP_IDX:
-				if (insn[1].imm == 0)
-					break;
-				fallthrough;
-			default:
-				verbose(env, "unrecognized bpf_ld_imm64 insn\n");
-				return -EINVAL;
-			}
-
-			switch (insn[0].src_reg) {
-			case BPF_PSEUDO_MAP_IDX_VALUE:
-			case BPF_PSEUDO_MAP_IDX:
-				if (bpfptr_is_null(env->fd_array)) {
-					verbose(env, "fd_idx without fd_array is invalid\n");
-					return -EPROTO;
-				}
-				if (copy_from_bpfptr_offset(&fd, env->fd_array,
-							    insn[0].imm * sizeof(fd),
-							    sizeof(fd)))
-					return -EFAULT;
-				break;
-			default:
-				fd = insn[0].imm;
-				break;
-			}
-
-			f = fdget(fd);
-			map = __bpf_map_get(f);
-			if (IS_ERR(map)) {
-				verbose(env, "fd %d is not pointing to valid bpf_map\n", fd);
-				return PTR_ERR(map);
-			}
-
-			err = check_map_prog_compatibility(env, map, env->prog);
-			if (err) {
-				fdput(f);
+			err = do_one_ldimm64(env, insn, &env->insn_aux_data[i]);
+			if (err)
 				return err;
-			}
-
-			aux = &env->insn_aux_data[i];
-			if (insn[0].src_reg == BPF_PSEUDO_MAP_FD ||
-			    insn[0].src_reg == BPF_PSEUDO_MAP_IDX) {
-				addr = (unsigned long)map;
-			} else {
-				u32 off = insn[1].imm;
-
-				if (off >= BPF_MAX_VAR_OFF) {
-					verbose(env, "direct value offset of %u is not allowed\n", off);
-					fdput(f);
-					return -EINVAL;
-				}
-
-				if (!map->ops->map_direct_value_addr) {
-					verbose(env, "no direct value access support for this map type\n");
-					fdput(f);
-					return -EINVAL;
-				}
-
-				err = map->ops->map_direct_value_addr(map, &addr, off);
-				if (err) {
-					verbose(env, "invalid access to map value pointer, value_size=%u off=%u\n",
-						map->value_size, off);
-					fdput(f);
-					return err;
-				}
-
-				aux->map_off = off;
-				addr += off;
-			}
-
-			insn[0].imm = (u32)addr;
-			insn[1].imm = addr >> 32;
-
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
-
-			if (bpf_map_is_cgroup_storage(map) &&
-			    bpf_cgroup_storage_assign(env->prog->aux, map)) {
-				verbose(env, "only one cgroup storage of each type is allowed\n");
-				fdput(f);
-				return -EBUSY;
-			}
-			if (map->map_type == BPF_MAP_TYPE_ARENA) {
-				if (env->prog->aux->arena) {
-					verbose(env, "Only one arena per program\n");
-					fdput(f);
-					return -EBUSY;
-				}
-				if (!env->allow_ptr_leaks || !env->bpf_capable) {
-					verbose(env, "CAP_BPF and CAP_PERFMON are required to use arena\n");
-					fdput(f);
-					return -EPERM;
-				}
-				if (!env->prog->jit_requested) {
-					verbose(env, "JIT is required to use arena\n");
-					fdput(f);
-					return -EOPNOTSUPP;
-				}
-				if (!bpf_jit_supports_arena()) {
-					verbose(env, "JIT doesn't support arena\n");
-					fdput(f);
-					return -EOPNOTSUPP;
-				}
-				env->prog->aux->arena = (void *)map;
-				if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
-					verbose(env, "arena's user address must be set via map_extra or mmap()\n");
-					fdput(f);
-					return -EINVAL;
-				}
-			}
-
-			fdput(f);
-next_insn:
 			insn++;
 			i++;
 			continue;
-- 
2.39.2


