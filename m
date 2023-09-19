Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EF47A6D2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 23:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjISVss convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 17:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjISVsr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:48:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34495CE
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 14:48:38 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JL5GHU021184
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 14:48:37 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t76krcyc7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 14:48:37 -0700
Received: from twshared27355.37.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 19 Sep 2023 14:48:16 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 9944F385A5F56; Tue, 19 Sep 2023 14:48:13 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v5 bpf-next 06/13] bpf: add BPF token support to BPF_PROG_LOAD command
Date:   Tue, 19 Sep 2023 14:47:53 -0700
Message-ID: <20230919214800.3803828-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919214800.3803828-1-andrii@kernel.org>
References: <20230919214800.3803828-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SEqb2kJ7XuLRZeSol28zAThole-oIWDf
X-Proofpoint-GUID: SEqb2kJ7XuLRZeSol28zAThole-oIWDf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_12,2023-09-19_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add basic support of BPF token to BPF_PROG_LOAD. Wire through a set of
allowed BPF program types and attach types, derived from BPF FS at BPF
token creation time. Then make sure we perform bpf_token_capable()
checks everywhere where it's relevant.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h                           |  6 ++
 include/uapi/linux/bpf.h                      |  2 +
 kernel/bpf/core.c                             |  1 +
 kernel/bpf/inode.c                            |  6 +-
 kernel/bpf/syscall.c                          | 87 ++++++++++++++-----
 kernel/bpf/token.c                            | 25 ++++++
 tools/include/uapi/linux/bpf.h                |  2 +
 .../selftests/bpf/prog_tests/libbpf_probes.c  |  2 +
 .../selftests/bpf/prog_tests/libbpf_str.c     |  3 +
 9 files changed, 108 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a4aea5b34290..303be48d0309 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1441,6 +1441,7 @@ struct bpf_prog_aux {
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
+	struct bpf_token *token;
 	struct bpf_prog_offload *offload;
 	struct btf *btf;
 	struct bpf_func_info *func_info;
@@ -1581,6 +1582,8 @@ struct bpf_token {
 	struct user_namespace *userns;
 	u64 allowed_cmds;
 	u64 allowed_maps;
+	u64 allowed_progs;
+	u64 allowed_attachs;
 };
 
 struct bpf_struct_ops_value;
@@ -2217,6 +2220,9 @@ struct bpf_token *bpf_token_get_from_fd(u32 ufd);
 
 bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
 bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type type);
+bool bpf_token_allow_prog_type(const struct bpf_token *token,
+			       enum bpf_prog_type prog_type,
+			       enum bpf_attach_type attach_type);
 
 int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
 int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1527d861f408..2fec43a56170 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1029,6 +1029,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	__MAX_BPF_PROG_TYPE
 };
 
 enum bpf_attach_type {
@@ -1494,6 +1495,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		log_true_size;
+		__u32		prog_token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 08626b519ce2..fc8de25b7948 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2747,6 +2747,7 @@ void bpf_prog_free(struct bpf_prog *fp)
 
 	if (aux->dst_prog)
 		bpf_prog_put(aux->dst_prog);
+	bpf_token_put(aux->token);
 	INIT_WORK(&aux->work, bpf_prog_free_deferred);
 	schedule_work(&aux->work);
 }
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 6e8b4e2bda97..fa39797f7076 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -620,12 +620,14 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
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
index 019b41273318..2954df07dad2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2587,13 +2587,15 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
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
 
@@ -2609,10 +2611,31 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 				 BPF_F_XDP_DEV_BOUND_ONLY))
 		return -EINVAL;
 
+	bpf_prog_load_fixup_attach_type(attr);
+
+	if (attr->prog_token_fd) {
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
@@ -2621,21 +2644,23 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
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
@@ -2645,27 +2670,33 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
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
@@ -2673,7 +2704,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 			bpf_prog_put(dst_prog);
 		if (attach_btf)
 			btf_put(attach_btf);
-		return -EINVAL;
+		err = -EINVAL;
+		goto put_token;
 	}
 
 	/* plain bpf_prog allocation */
@@ -2683,7 +2715,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 			bpf_prog_put(dst_prog);
 		if (attach_btf)
 			btf_put(attach_btf);
-		return -ENOMEM;
+		err = -EINVAL;
+		goto put_token;
 	}
 
 	prog->expected_attach_type = attr->expected_attach_type;
@@ -2694,6 +2727,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	prog->aux->sleepable = attr->prog_flags & BPF_F_SLEEPABLE;
 	prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
 
+	/* move token into prog->aux, reuse taken refcnt */
+	prog->aux->token = token;
+	token = NULL;
+
 	err = security_bpf_prog_alloc(prog->aux);
 	if (err)
 		goto free_prog;
@@ -2795,6 +2832,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
 	bpf_prog_free(prog);
+put_token:
+	bpf_token_put(token);
 	return err;
 }
 
@@ -3775,7 +3814,7 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
 	case BPF_PROG_TYPE_CGROUP_SKB:
-		if (!bpf_net_capable())
+		if (!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
 			/* cg-skb progs can be loaded by unpriv user.
 			 * check permissions at attach time.
 			 */
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index bcc170fcf341..b28589e8875e 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -94,6 +94,18 @@ static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
 		seq_printf(m, "allowed_maps:\tany\n");
 	else
 		seq_printf(m, "allowed_maps:\t0x%llx\n", token->allowed_maps);
+
+	mask = (1ULL << __MAX_BPF_PROG_TYPE) - 1;
+	if ((token->allowed_progs & mask) == mask)
+		seq_printf(m, "allowed_progs:\tany\n");
+	else
+		seq_printf(m, "allowed_progs:\t0x%llx\n", token->allowed_progs);
+
+	mask = (1ULL << __MAX_BPF_ATTACH_TYPE) - 1;
+	if ((token->allowed_attachs & mask) == mask)
+		seq_printf(m, "allowed_attachs:\tany\n");
+	else
+		seq_printf(m, "allowed_attachs:\t0x%llx\n", token->allowed_attachs);
 }
 
 static const struct file_operations bpf_token_fops = {
@@ -149,6 +161,8 @@ int bpf_token_create(union bpf_attr *attr)
 	mnt_opts = path.dentry->d_sb->s_fs_info;
 	token->allowed_cmds = mnt_opts->delegate_cmds;
 	token->allowed_maps = mnt_opts->delegate_maps;
+	token->allowed_progs = mnt_opts->delegate_progs;
+	token->allowed_attachs = mnt_opts->delegate_attachs;
 
 	ret = bpf_token_new_fd(token);
 	if (ret < 0)
@@ -202,3 +216,14 @@ bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type t
 
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
index 1527d861f408..2fec43a56170 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1029,6 +1029,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	__MAX_BPF_PROG_TYPE
 };
 
 enum bpf_attach_type {
@@ -1494,6 +1495,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		log_true_size;
+		__u32		prog_token_fd;
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
index 2a0633f43c73..384bc1f7a65e 100644
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

