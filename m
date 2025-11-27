Return-Path: <linux-fsdevel+bounces-69944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EB1C8C793
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 01:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00EBE4E5AF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 00:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78B3262D27;
	Thu, 27 Nov 2025 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5aPT/dE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833825785D;
	Thu, 27 Nov 2025 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764204625; cv=none; b=WFj2IZ166zClrtUA/6ckyvb0Tj2MdlbjAj32LF6xuhv4qpv1p4TA+ArJAn8daWdugMJ0k29svOqLo92dNH90fCj8J+CqgfobKwZDSsd+K8cuOeBWMONn1p9Jdg68rG4GsS/kOvDo9G2Amkd+uI6GZfE5djAHUx+w0L5Hg56VIX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764204625; c=relaxed/simple;
	bh=Rs25IkeaJ02cCocPW5Nc5wNYX/B+vdaIK/g8ZFs5ta8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwXOs77oR27eN12UyswCczXfXrRS61quRMhsfMemBn2vKVROM0urK1mFBr4k82AAH0RyPspEj3ZAOdgG2rAJS4F+G3CPbQB3Fsk+/aXttW9EltaBY8912Ga9Trux68o14rPbK1N01KAYPoquPKq3wnpED6gcSoiJs0g752z5i2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5aPT/dE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DC8C4CEF7;
	Thu, 27 Nov 2025 00:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764204624;
	bh=Rs25IkeaJ02cCocPW5Nc5wNYX/B+vdaIK/g8ZFs5ta8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R5aPT/dEc+1UJvvCc0c+h5PD3262/758HMIzNxKz+O9dWVqlDU5wIWonj9Y99pX1N
	 9k4qy5iOHv+AupT1lwaBG/EycVcq2sLOKbeZi4QHMcpBwdSYogsRzeL1+7/hME3x+p
	 GFbOXNmayCHccxVWbcNuH7uxuYg6LT21e9XSCmDonxFPUpjKTmvQCTSpaQ+Au5JL0s
	 Bx12Pn9gLO+EUjxrM4/PUfG0uZa8LrS+SBOV2aMFGjy8WG7p2K5gdqfYUpZeQKLZWL
	 MlCcQgRtjsSZtO42BcBpfZrPPbUipaGR0hgX21r1YjrDtItfx2PpWJvkUc/ppxZn5p
	 tuJqv8rkGUVRA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kernel-team@meta.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 1/3] bpf: Allow const char * from LSM hooks as kfunc const string arguments
Date: Wed, 26 Nov 2025 16:50:05 -0800
Message-ID: <20251127005011.1872209-2-song@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251127005011.1872209-1-song@kernel.org>
References: <20251127005011.1872209-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let the BPF verifier to recognize const char * arguments from LSM hooks
(and other BPF program types) as valid const string pointers that can be
passed to kfuncs expecting KF_ARG_PTR_TO_CONST_STR.

Previously, kfuncs with KF_ARG_PTR_TO_CONST_STR only accepted
PTR_TO_MAP_VALUE from readonly maps. This was limiting for LSM programs
that receive const char * arguments from hooks like sb_mount's dev_name.

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/btf.h   |  1 +
 kernel/bpf/btf.c      | 33 ++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 51 +++++++++++++++++++++++++++++++++----------
 3 files changed, 73 insertions(+), 12 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f06976ffb63f..bd5a32d33254 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -224,6 +224,7 @@ struct btf *btf_base_btf(const struct btf *btf);
 bool btf_type_is_i32(const struct btf_type *t);
 bool btf_type_is_i64(const struct btf_type *t);
 bool btf_type_is_primitive(const struct btf_type *t);
+bool btf_type_is_const_char_ptr(const struct btf *btf, const struct btf_type *t);
 bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   const struct btf_member *m,
 			   u32 expected_offset, u32 expected_size);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..94a272585b97 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -897,6 +897,25 @@ bool btf_type_is_primitive(const struct btf_type *t)
 	       btf_is_any_enum(t);
 }
 
+bool btf_type_is_const_char_ptr(const struct btf *btf, const struct btf_type *t)
+{
+	const char *tname;
+
+	/* The type chain has to be PTR->CONST->CHAR */
+	if (BTF_INFO_KIND(t->info) != BTF_KIND_PTR)
+		return false;
+
+	t = btf_type_by_id(btf, t->type);
+	if (BTF_INFO_KIND(t->info) != BTF_KIND_CONST)
+		return false;
+
+	t = btf_type_by_id(btf, t->type);
+	tname = btf_name_by_offset(btf, t->name_off);
+	if (tname && strcmp(tname, "char") == 0)
+		return true;
+	return false;
+}
+
 /*
  * Check that given struct member is a regular int with expected
  * offset and size.
@@ -6746,6 +6765,20 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			/* Default prog with MAX_BPF_FUNC_REG_ARGS args */
 			return true;
 		t = btf_type_by_id(btf, args[arg].type);
+
+		/*
+		 * For const string, we need to match "const char *"
+		 * exactly. Therefore, do the check before the skipping
+		 * modifiers.
+		 */
+		if (btf_type_is_const_char_ptr(btf, t)) {
+			info->reg_type = PTR_TO_BTF_ID;
+			if (prog_args_trusted(prog))
+				info->reg_type |= PTR_TRUSTED;
+			info->btf = btf;
+			info->btf_id = args[arg].type;
+			return true;
+		}
 	}
 
 	/* skip modifiers */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 766695491bc5..a9757c056d4b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9598,8 +9598,12 @@ static enum bpf_dynptr_type dynptr_get_type(struct bpf_verifier_env *env,
 	return state->stack[spi].spilled_ptr.dynptr.type;
 }
 
-static int check_reg_const_str(struct bpf_verifier_env *env,
-			       struct bpf_reg_state *reg, u32 regno)
+/*
+ * Check for const string saved in a bpf map. The caller is responsible
+ * to check reg->type == PTR_TO_MAP_VALUE.
+ */
+static int check_reg_const_str_in_map(struct bpf_verifier_env *env,
+				      struct bpf_reg_state *reg, u32 regno)
 {
 	struct bpf_map *map = reg->map_ptr;
 	int err;
@@ -9607,9 +9611,6 @@ static int check_reg_const_str(struct bpf_verifier_env *env,
 	u64 map_addr;
 	char *str_ptr;
 
-	if (reg->type != PTR_TO_MAP_VALUE)
-		return -EINVAL;
-
 	if (!bpf_map_is_rdonly(map)) {
 		verbose(env, "R%d does not point to a readonly map'\n", regno);
 		return -EACCES;
@@ -9646,6 +9647,26 @@ static int check_reg_const_str(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* Check for const string passed in as input to the bpf program. */
+static int check_reg_const_str_arg(struct bpf_reg_state *reg)
+{
+	const struct btf *btf;
+	const struct btf_type *t;
+	const char *tname;
+
+	if (base_type(reg->type) != PTR_TO_BTF_ID)
+		return -EINVAL;
+
+	btf = reg->btf;
+	t = btf_type_by_id(btf, reg->btf_id);
+	if (!t)
+		return -EINVAL;
+
+	if (btf_type_is_const_char_ptr(btf, t))
+		return 0;
+	return -EINVAL;
+}
+
 /* Returns constant key value in `value` if possible, else negative error */
 static int get_constant_map_key(struct bpf_verifier_env *env,
 				struct bpf_reg_state *key,
@@ -9964,7 +9985,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		break;
 	case ARG_PTR_TO_CONST_STR:
 	{
-		err = check_reg_const_str(env, reg, regno);
+		if (reg->type != PTR_TO_MAP_VALUE)
+			return -EINVAL;
+		err = check_reg_const_str_in_map(env, reg, regno);
 		if (err)
 			return err;
 		break;
@@ -13626,13 +13649,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			meta->arg_btf_id = reg->btf_id;
 			break;
 		case KF_ARG_PTR_TO_CONST_STR:
-			if (reg->type != PTR_TO_MAP_VALUE) {
-				verbose(env, "arg#%d doesn't point to a const string\n", i);
-				return -EINVAL;
+			if (reg->type == PTR_TO_MAP_VALUE) {
+				ret = check_reg_const_str_in_map(env, reg, regno);
+				if (ret)
+					return ret;
+			} else {
+				ret = check_reg_const_str_arg(reg);
+				if (ret) {
+					verbose(env, "arg#%d doesn't point to a const string\n", i);
+					return ret;
+				}
 			}
-			ret = check_reg_const_str(env, reg, regno);
-			if (ret)
-				return ret;
 			break;
 		case KF_ARG_PTR_TO_WORKQUEUE:
 			if (reg->type != PTR_TO_MAP_VALUE) {
-- 
2.47.3


