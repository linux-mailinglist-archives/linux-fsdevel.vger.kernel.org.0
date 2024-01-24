Return-Path: <linux-fsdevel+bounces-8644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA0A839EBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6645A1F255B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA523C8D2;
	Wed, 24 Jan 2024 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qj1ulHLt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4FCC2C4;
	Wed, 24 Jan 2024 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062914; cv=none; b=H/CXst2+UAmj6F5xENGcU9EsFFQIPNfDvFONgzJcY1ZVAO7Bn3LHtp+sM4CgMWeBfcQy8jioVGqyjMQ31Jr7DY39qXareQAUOhzyxqLHOxMJMt/wk7SJ0R/ITWwuIQL7c6xE/2fsk7LOFlTNvZbsuwAS2W/wDjeBQ8YyAYtPKHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062914; c=relaxed/simple;
	bh=c8W+6Z/dDyDIBsNURk8eiRCwM0bUytLHv756E762e9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RGFdxbpYWicNwIknGGjhchQwGVnkamMVJ/SdHVLnvxWfQW8aDdsn/oRw+rVe1w70VDNsreunoX5eyM1/MJg0T2zhak6z4tZn6RywBn4nSw2fByUhidSsIx61jt83srfYt993QV6gm/71/bzq2LrKa8eT+TvSwWU4nvW/TlA98Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qj1ulHLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAFFC433C7;
	Wed, 24 Jan 2024 02:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062914;
	bh=c8W+6Z/dDyDIBsNURk8eiRCwM0bUytLHv756E762e9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qj1ulHLtzFl8m9uy1RPM+1b7ZfInR23j9Bl1gKsL/bxogxWDL1Q3a7T/znOoZrPEr
	 FK+He/eUVG5GbI3mVRMy4mhaXmBnvFamOfo9tHUe5ij5M7i8GwnIQ67wNE6nzwQCND
	 pgGD82F+uko070gZeP3cjDIs8XnI+Jr7BWF/w9WiU5uRKiTxkao4kEZBBSLRHp7Tb/
	 j8clDgo9pEaEPsdwbZMuzQhq1qz8kFsq4gqm4uiLOuareNe10UffxDGgxq+q6tNLFW
	 QJpattbTnSWcFzmpO5Js5nwqJ6nKZJml1jcx3CLiAcGVO4QpMLaG/tg/VomnPL0tvs
	 XJP6VOpqm/Paw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 06/30] bpf: add BPF token support to BPF_PROG_LOAD command
Date: Tue, 23 Jan 2024 18:21:03 -0800
Message-Id: <20240124022127.2379740-7-andrii@kernel.org>
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

Add basic support of BPF token to BPF_PROG_LOAD. BPF_F_TOKEN_FD flag
should be set in prog_flags field when providing prog_token_fd.

Wire through a set of allowed BPF program types and attach types,
derived from BPF FS at BPF token creation time. Then make sure we
perform bpf_token_capable() checks everywhere where it's relevant.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h                           |  6 ++
 include/uapi/linux/bpf.h                      |  5 ++
 kernel/bpf/core.c                             |  1 +
 kernel/bpf/inode.c                            |  6 +-
 kernel/bpf/syscall.c                          | 90 +++++++++++++------
 kernel/bpf/token.c                            | 27 ++++++
 tools/include/uapi/linux/bpf.h                |  5 ++
 .../selftests/bpf/prog_tests/libbpf_probes.c  |  2 +
 .../selftests/bpf/prog_tests/libbpf_str.c     |  3 +
 9 files changed, 118 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3afcb6435566..069737238460 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1489,6 +1489,7 @@ struct bpf_prog_aux {
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
+	struct bpf_token *token;
 	struct bpf_prog_offload *offload;
 	struct btf *btf;
 	struct bpf_func_info *func_info;
@@ -1631,6 +1632,8 @@ struct bpf_token {
 	struct user_namespace *userns;
 	u64 allowed_cmds;
 	u64 allowed_maps;
+	u64 allowed_progs;
+	u64 allowed_attachs;
 };
 
 struct bpf_struct_ops_value;
@@ -2270,6 +2273,9 @@ struct bpf_token *bpf_token_get_from_fd(u32 ufd);
 
 bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
 bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type type);
+bool bpf_token_allow_prog_type(const struct bpf_token *token,
+			       enum bpf_prog_type prog_type,
+			       enum bpf_attach_type attach_type);
 
 int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
 int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9745521f0aad..9ed478db4203 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1028,6 +1028,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	__MAX_BPF_PROG_TYPE
 };
 
 enum bpf_attach_type {
@@ -1511,6 +1512,10 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		log_true_size;
+		/* BPF token FD to use with BPF_PROG_LOAD operation.
+		 * If provided, prog_flags should have BPF_F_TOKEN_FD flag set.
+		 */
+		__s32		prog_token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index fbb1d95a9b44..00dccba29769 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2779,6 +2779,7 @@ void bpf_prog_free(struct bpf_prog *fp)
 
 	if (aux->dst_prog)
 		bpf_prog_put(aux->dst_prog);
+	bpf_token_put(aux->token);
 	INIT_WORK(&aux->work, bpf_prog_free_deferred);
 	schedule_work(&aux->work);
 }
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 034b7e4d8f19..5fb10da5717f 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -626,12 +626,14 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 	else if (opts->delegate_maps)
 		seq_printf(m, ",delegate_maps=0x%llx", opts->delegate_maps);
 
-	if (opts->delegate_progs == ~0ULL)
+	mask = (1ULL << __MAX_BPF_PROG_TYPE) - 1;
+	if ((opts->delegate_progs & mask) == mask)
 		seq_printf(m, ",delegate_progs=any");
 	else if (opts->delegate_progs)
 		seq_printf(m, ",delegate_progs=0x%llx", opts->delegate_progs);
 
-	if (opts->delegate_attachs == ~0ULL)
+	mask = (1ULL << __MAX_BPF_ATTACH_TYPE) - 1;
+	if ((opts->delegate_attachs & mask) == mask)
 		seq_printf(m, ",delegate_attachs=any");
 	else if (opts->delegate_attachs)
 		seq_printf(m, ",delegate_attachs=0x%llx", opts->delegate_attachs);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 39b20436306f..7b3ef7d680c0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2626,13 +2626,15 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define	BPF_PROG_LOAD_LAST_FIELD log_true_size
+#define BPF_PROG_LOAD_LAST_FIELD prog_token_fd
 
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog, *dst_prog = NULL;
 	struct btf *attach_btf = NULL;
+	struct bpf_token *token = NULL;
+	bool bpf_cap;
 	int err;
 	char license[128];
 
@@ -2646,13 +2648,35 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 				 BPF_F_TEST_RND_HI32 |
 				 BPF_F_XDP_HAS_FRAGS |
 				 BPF_F_XDP_DEV_BOUND_ONLY |
-				 BPF_F_TEST_REG_INVARIANTS))
+				 BPF_F_TEST_REG_INVARIANTS |
+				 BPF_F_TOKEN_FD))
 		return -EINVAL;
 
+	bpf_prog_load_fixup_attach_type(attr);
+
+	if (attr->prog_flags & BPF_F_TOKEN_FD) {
+		token = bpf_token_get_from_fd(attr->prog_token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+		/* if current token doesn't grant prog loading permissions,
+		 * then we can't use this token, so ignore it and rely on
+		 * system-wide capabilities checks
+		 */
+		if (!bpf_token_allow_cmd(token, BPF_PROG_LOAD) ||
+		    !bpf_token_allow_prog_type(token, attr->prog_type,
+					       attr->expected_attach_type)) {
+			bpf_token_put(token);
+			token = NULL;
+		}
+	}
+
+	bpf_cap = bpf_token_capable(token, CAP_BPF);
+	err = -EPERM;
+
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
 	    (attr->prog_flags & BPF_F_ANY_ALIGNMENT) &&
-	    !bpf_capable())
-		return -EPERM;
+	    !bpf_cap)
+		goto put_token;
 
 	/* Intent here is for unprivileged_bpf_disabled to block BPF program
 	 * creation for unprivileged users; other actions depend
@@ -2661,21 +2685,23 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	 * capability checks are still carried out for these
 	 * and other operations.
 	 */
-	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
-		return -EPERM;
+	if (sysctl_unprivileged_bpf_disabled && !bpf_cap)
+		goto put_token;
 
 	if (attr->insn_cnt == 0 ||
-	    attr->insn_cnt > (bpf_capable() ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS))
-		return -E2BIG;
+	    attr->insn_cnt > (bpf_cap ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS)) {
+		err = -E2BIG;
+		goto put_token;
+	}
 	if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
 	    type != BPF_PROG_TYPE_CGROUP_SKB &&
-	    !bpf_capable())
-		return -EPERM;
+	    !bpf_cap)
+		goto put_token;
 
-	if (is_net_admin_prog_type(type) && !bpf_net_capable())
-		return -EPERM;
-	if (is_perfmon_prog_type(type) && !perfmon_capable())
-		return -EPERM;
+	if (is_net_admin_prog_type(type) && !bpf_token_capable(token, CAP_NET_ADMIN))
+		goto put_token;
+	if (is_perfmon_prog_type(type) && !bpf_token_capable(token, CAP_PERFMON))
+		goto put_token;
 
 	/* attach_prog_fd/attach_btf_obj_fd can specify fd of either bpf_prog
 	 * or btf, we need to check which one it is
@@ -2685,27 +2711,33 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 		if (IS_ERR(dst_prog)) {
 			dst_prog = NULL;
 			attach_btf = btf_get_by_fd(attr->attach_btf_obj_fd);
-			if (IS_ERR(attach_btf))
-				return -EINVAL;
+			if (IS_ERR(attach_btf)) {
+				err = -EINVAL;
+				goto put_token;
+			}
 			if (!btf_is_kernel(attach_btf)) {
 				/* attaching through specifying bpf_prog's BTF
 				 * objects directly might be supported eventually
 				 */
 				btf_put(attach_btf);
-				return -ENOTSUPP;
+				err = -ENOTSUPP;
+				goto put_token;
 			}
 		}
 	} else if (attr->attach_btf_id) {
 		/* fall back to vmlinux BTF, if BTF type ID is specified */
 		attach_btf = bpf_get_btf_vmlinux();
-		if (IS_ERR(attach_btf))
-			return PTR_ERR(attach_btf);
-		if (!attach_btf)
-			return -EINVAL;
+		if (IS_ERR(attach_btf)) {
+			err = PTR_ERR(attach_btf);
+			goto put_token;
+		}
+		if (!attach_btf) {
+			err = -EINVAL;
+			goto put_token;
+		}
 		btf_get(attach_btf);
 	}
 
-	bpf_prog_load_fixup_attach_type(attr);
 	if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
 				       attach_btf, attr->attach_btf_id,
 				       dst_prog)) {
@@ -2713,7 +2745,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 			bpf_prog_put(dst_prog);
 		if (attach_btf)
 			btf_put(attach_btf);
-		return -EINVAL;
+		err = -EINVAL;
+		goto put_token;
 	}
 
 	/* plain bpf_prog allocation */
@@ -2723,7 +2756,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 			bpf_prog_put(dst_prog);
 		if (attach_btf)
 			btf_put(attach_btf);
-		return -ENOMEM;
+		err = -EINVAL;
+		goto put_token;
 	}
 
 	prog->expected_attach_type = attr->expected_attach_type;
@@ -2734,6 +2768,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	prog->aux->sleepable = attr->prog_flags & BPF_F_SLEEPABLE;
 	prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
 
+	/* move token into prog->aux, reuse taken refcnt */
+	prog->aux->token = token;
+	token = NULL;
+
 	err = security_bpf_prog_alloc(prog->aux);
 	if (err)
 		goto free_prog;
@@ -2851,6 +2889,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
 	bpf_prog_free(prog);
+put_token:
+	bpf_token_put(token);
 	return err;
 }
 
@@ -3858,7 +3898,7 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
 	case BPF_PROG_TYPE_CGROUP_SKB:
-		if (!bpf_net_capable())
+		if (!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
 			/* cg-skb progs can be loaded by unpriv user.
 			 * check permissions at attach time.
 			 */
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index bc86be4ca567..c13c73788d8c 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -80,6 +80,20 @@ static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
 		seq_printf(m, "allowed_maps:\tany\n");
 	else
 		seq_printf(m, "allowed_maps:\t0x%llx\n", token->allowed_maps);
+
+	BUILD_BUG_ON(__MAX_BPF_PROG_TYPE >= 64);
+	mask = (1ULL << __MAX_BPF_PROG_TYPE) - 1;
+	if ((token->allowed_progs & mask) == mask)
+		seq_printf(m, "allowed_progs:\tany\n");
+	else
+		seq_printf(m, "allowed_progs:\t0x%llx\n", token->allowed_progs);
+
+	BUILD_BUG_ON(__MAX_BPF_ATTACH_TYPE >= 64);
+	mask = (1ULL << __MAX_BPF_ATTACH_TYPE) - 1;
+	if ((token->allowed_attachs & mask) == mask)
+		seq_printf(m, "allowed_attachs:\tany\n");
+	else
+		seq_printf(m, "allowed_attachs:\t0x%llx\n", token->allowed_attachs);
 }
 
 #define BPF_TOKEN_INODE_NAME "bpf-token"
@@ -176,6 +190,8 @@ int bpf_token_create(union bpf_attr *attr)
 	mnt_opts = path.dentry->d_sb->s_fs_info;
 	token->allowed_cmds = mnt_opts->delegate_cmds;
 	token->allowed_maps = mnt_opts->delegate_maps;
+	token->allowed_progs = mnt_opts->delegate_progs;
+	token->allowed_attachs = mnt_opts->delegate_attachs;
 
 	fd = get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0) {
@@ -231,3 +247,14 @@ bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type t
 
 	return token->allowed_maps & (1ULL << type);
 }
+
+bool bpf_token_allow_prog_type(const struct bpf_token *token,
+			       enum bpf_prog_type prog_type,
+			       enum bpf_attach_type attach_type)
+{
+	if (!token || prog_type >= __MAX_BPF_PROG_TYPE || attach_type >= __MAX_BPF_ATTACH_TYPE)
+		return false;
+
+	return (token->allowed_progs & (1ULL << prog_type)) &&
+	       (token->allowed_attachs & (1ULL << attach_type));
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 9745521f0aad..9ed478db4203 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1028,6 +1028,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	__MAX_BPF_PROG_TYPE
 };
 
 enum bpf_attach_type {
@@ -1511,6 +1512,10 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		log_true_size;
+		/* BPF token FD to use with BPF_PROG_LOAD operation.
+		 * If provided, prog_flags should have BPF_F_TOKEN_FD flag set.
+		 */
+		__s32		prog_token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 573249a2814d..4ed46ed58a7b 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -30,6 +30,8 @@ void test_libbpf_probe_prog_types(void)
 
 		if (prog_type == BPF_PROG_TYPE_UNSPEC)
 			continue;
+		if (strcmp(prog_type_name, "__MAX_BPF_PROG_TYPE") == 0)
+			continue;
 
 		if (!test__start_subtest(prog_type_name))
 			continue;
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
index 1f328c0d8aff..62ea855ec4d0 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
@@ -189,6 +189,9 @@ static void test_libbpf_bpf_prog_type_str(void)
 		const char *prog_type_str;
 		char buf[256];
 
+		if (prog_type == __MAX_BPF_PROG_TYPE)
+			continue;
+
 		prog_type_name = btf__str_by_offset(btf, e->name_off);
 		prog_type_str = libbpf_bpf_prog_type_str(prog_type);
 		ASSERT_OK_PTR(prog_type_str, prog_type_name);
-- 
2.34.1


