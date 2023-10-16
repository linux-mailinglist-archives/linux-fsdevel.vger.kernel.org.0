Return-Path: <linux-fsdevel+bounces-448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CFF7CB1D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B8B281775
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FECC339B2;
	Mon, 16 Oct 2023 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA7633983
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 18:02:41 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E85F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:02:39 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GFHFw5029629
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:02:39 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ts6qp9wy6-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:02:38 -0700
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 16 Oct 2023 11:02:33 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 90BBB39D9C277; Mon, 16 Oct 2023 11:02:29 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <brauner@kernel.org>,
        <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v8 bpf-next 04/18] bpf: add BPF token support to BPF_MAP_CREATE command
Date: Mon, 16 Oct 2023 11:02:06 -0700
Message-ID: <20231016180220.3866105-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016180220.3866105-1-andrii@kernel.org>
References: <20231016180220.3866105-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: USooAaqoNT8772wsTk8GpKrInXigv_JW
X-Proofpoint-ORIG-GUID: USooAaqoNT8772wsTk8GpKrInXigv_JW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Allow providing token_fd for BPF_MAP_CREATE command to allow controlled
BPF map creation from unprivileged process through delegated BPF token.

Wire through a set of allowed BPF map types to BPF token, derived from
BPF FS at BPF token creation time. This, in combination with allowed_cmds
allows to create a narrowly-focused BPF token (controlled by privileged
agent) with a restrictive set of BPF maps that application can attempt
to create.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h                           |  2 +
 include/uapi/linux/bpf.h                      |  2 +
 kernel/bpf/inode.c                            |  3 +-
 kernel/bpf/syscall.c                          | 52 ++++++++++++++-----
 kernel/bpf/token.c                            | 16 ++++++
 tools/include/uapi/linux/bpf.h                |  2 +
 .../selftests/bpf/prog_tests/libbpf_probes.c  |  2 +
 .../selftests/bpf/prog_tests/libbpf_str.c     |  3 ++
 8 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c5726c4de1a2..ce5f6d6feb09 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1581,6 +1581,7 @@ struct bpf_token {
 	atomic64_t refcnt;
 	struct user_namespace *userns;
 	u64 allowed_cmds;
+	u64 allowed_maps;
 };
=20
 struct bpf_struct_ops_value;
@@ -2216,6 +2217,7 @@ int bpf_token_create(union bpf_attr *attr);
 struct bpf_token *bpf_token_get_from_fd(u32 ufd);
=20
 bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd=
);
+bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_ma=
p_type type);
=20
 int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
 int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags=
);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 12d6c3b755e6..78deb9f74379 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -984,6 +984,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
+	__MAX_BPF_MAP_TYPE
 };
=20
 /* Note that tracing related programs such as
@@ -1428,6 +1429,7 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+		__u32	map_token_fd;
 	};
=20
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 1dcd00c7f782..e30f0821a35e 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -614,7 +614,8 @@ static int bpf_show_options(struct seq_file *m, struc=
t dentry *root)
 	else if (opts->delegate_cmds)
 		seq_printf(m, ",delegate_cmds=3D0x%llx", opts->delegate_cmds);
=20
-	if (opts->delegate_maps =3D=3D ~0ULL)
+	mask =3D (1ULL << __MAX_BPF_MAP_TYPE) - 1;
+	if ((opts->delegate_maps & mask) =3D=3D mask)
 		seq_printf(m, ",delegate_maps=3Dany");
 	else if (opts->delegate_maps)
 		seq_printf(m, ",delegate_maps=3D0x%llx", opts->delegate_maps);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6d51d83b1406..e63e4280c43c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -985,8 +985,8 @@ int map_check_no_btf(const struct bpf_map *map,
 	return -ENOTSUPP;
 }
=20
-static int map_check_btf(struct bpf_map *map, const struct btf *btf,
-			 u32 btf_key_id, u32 btf_value_id)
+static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
+			 const struct btf *btf, u32 btf_key_id, u32 btf_value_id)
 {
 	const struct btf_type *key_type, *value_type;
 	u32 key_size, value_size;
@@ -1014,7 +1014,7 @@ static int map_check_btf(struct bpf_map *map, const=
 struct btf *btf,
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
=20
-		if (!bpf_capable()) {
+		if (!bpf_token_capable(token, CAP_BPF)) {
 			ret =3D -EPERM;
 			goto free_map_tab;
 		}
@@ -1102,11 +1102,12 @@ static bool bpf_net_capable(void)
 	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
 }
=20
-#define BPF_MAP_CREATE_LAST_FIELD map_extra
+#define BPF_MAP_CREATE_LAST_FIELD map_token_fd
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
 	const struct bpf_map_ops *ops;
+	struct bpf_token *token =3D NULL;
 	int numa_node =3D bpf_map_attr_numa_node(attr);
 	u32 map_type =3D attr->map_type;
 	struct bpf_map *map;
@@ -1157,14 +1158,32 @@ static int map_create(union bpf_attr *attr)
 	if (!ops->map_mem_usage)
 		return -EINVAL;
=20
+	if (attr->map_token_fd) {
+		token =3D bpf_token_get_from_fd(attr->map_token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+
+		/* if current token doesn't grant map creation permissions,
+		 * then we can't use this token, so ignore it and rely on
+		 * system-wide capabilities checks
+		 */
+		if (!bpf_token_allow_cmd(token, BPF_MAP_CREATE) ||
+		    !bpf_token_allow_map_type(token, attr->map_type)) {
+			bpf_token_put(token);
+			token =3D NULL;
+		}
+	}
+
+	err =3D -EPERM;
+
 	/* Intent here is for unprivileged_bpf_disabled to block BPF map
 	 * creation for unprivileged users; other actions depend
 	 * on fd availability and access to bpffs, so are dependent on
 	 * object creation success. Even with unprivileged BPF disabled,
 	 * capability checks are still carried out.
 	 */
-	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
-		return -EPERM;
+	if (sysctl_unprivileged_bpf_disabled && !bpf_token_capable(token, CAP_B=
PF))
+		goto put_token;
=20
 	/* check privileged map type permissions */
 	switch (map_type) {
@@ -1197,25 +1216,27 @@ static int map_create(union bpf_attr *attr)
 	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
 	case BPF_MAP_TYPE_STRUCT_OPS:
 	case BPF_MAP_TYPE_CPUMAP:
-		if (!bpf_capable())
-			return -EPERM;
+		if (!bpf_token_capable(token, CAP_BPF))
+			goto put_token;
 		break;
 	case BPF_MAP_TYPE_SOCKMAP:
 	case BPF_MAP_TYPE_SOCKHASH:
 	case BPF_MAP_TYPE_DEVMAP:
 	case BPF_MAP_TYPE_DEVMAP_HASH:
 	case BPF_MAP_TYPE_XSKMAP:
-		if (!bpf_net_capable())
-			return -EPERM;
+		if (!bpf_token_capable(token, CAP_NET_ADMIN))
+			goto put_token;
 		break;
 	default:
 		WARN(1, "unsupported map type %d", map_type);
-		return -EPERM;
+		goto put_token;
 	}
=20
 	map =3D ops->map_alloc(attr);
-	if (IS_ERR(map))
-		return PTR_ERR(map);
+	if (IS_ERR(map)) {
+		err =3D PTR_ERR(map);
+		goto put_token;
+	}
 	map->ops =3D ops;
 	map->map_type =3D map_type;
=20
@@ -1252,7 +1273,7 @@ static int map_create(union bpf_attr *attr)
 		map->btf =3D btf;
=20
 		if (attr->btf_value_type_id) {
-			err =3D map_check_btf(map, btf, attr->btf_key_type_id,
+			err =3D map_check_btf(map, token, btf, attr->btf_key_type_id,
 					    attr->btf_value_type_id);
 			if (err)
 				goto free_map;
@@ -1273,6 +1294,7 @@ static int map_create(union bpf_attr *attr)
 		goto free_map_sec;
=20
 	bpf_map_save_memcg(map);
+	bpf_token_put(token);
=20
 	err =3D bpf_map_new_fd(map, f_flags);
 	if (err < 0) {
@@ -1293,6 +1315,8 @@ static int map_create(union bpf_attr *attr)
 free_map:
 	btf_put(map->btf);
 	map->ops->map_free(map);
+put_token:
+	bpf_token_put(token);
 	return err;
 }
=20
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 32fa395f829b..c6eb25fcc308 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -70,6 +70,13 @@ static void bpf_token_show_fdinfo(struct seq_file *m, =
struct file *filp)
 		seq_printf(m, "allowed_cmds:\tany\n");
 	else
 		seq_printf(m, "allowed_cmds:\t0x%llx\n", token->allowed_cmds);
+
+	BUILD_BUG_ON(__MAX_BPF_MAP_TYPE >=3D 64);
+	mask =3D (1ULL << __MAX_BPF_MAP_TYPE) - 1;
+	if ((token->allowed_maps & mask) =3D=3D mask)
+		seq_printf(m, "allowed_maps:\tany\n");
+	else
+		seq_printf(m, "allowed_maps:\t0x%llx\n", token->allowed_maps);
 }
=20
 #define BPF_TOKEN_INODE_NAME "bpf-token"
@@ -147,6 +154,7 @@ int bpf_token_create(union bpf_attr *attr)
=20
 	mnt_opts =3D path.dentry->d_sb->s_fs_info;
 	token->allowed_cmds =3D mnt_opts->delegate_cmds;
+	token->allowed_maps =3D mnt_opts->delegate_maps;
=20
 	fd =3D get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0) {
@@ -195,3 +203,11 @@ bool bpf_token_allow_cmd(const struct bpf_token *tok=
en, enum bpf_cmd cmd)
=20
 	return token->allowed_cmds & (1ULL << cmd);
 }
+
+bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_ma=
p_type type)
+{
+	if (!token || type >=3D __MAX_BPF_MAP_TYPE)
+		return false;
+
+	return token->allowed_maps & (1ULL << type);
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 12d6c3b755e6..78deb9f74379 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -984,6 +984,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
+	__MAX_BPF_MAP_TYPE
 };
=20
 /* Note that tracing related programs such as
@@ -1428,6 +1429,7 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+		__u32	map_token_fd;
 	};
=20
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/too=
ls/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 9f766ddd946a..573249a2814d 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -68,6 +68,8 @@ void test_libbpf_probe_map_types(void)
=20
 		if (map_type =3D=3D BPF_MAP_TYPE_UNSPEC)
 			continue;
+		if (strcmp(map_type_name, "__MAX_BPF_MAP_TYPE") =3D=3D 0)
+			continue;
=20
 		if (!test__start_subtest(map_type_name))
 			continue;
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c b/tools/=
testing/selftests/bpf/prog_tests/libbpf_str.c
index c440ea3311ed..2a0633f43c73 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
@@ -132,6 +132,9 @@ static void test_libbpf_bpf_map_type_str(void)
 		const char *map_type_str;
 		char buf[256];
=20
+		if (map_type =3D=3D __MAX_BPF_MAP_TYPE)
+			continue;
+
 		map_type_name =3D btf__str_by_offset(btf, e->name_off);
 		map_type_str =3D libbpf_bpf_map_type_str(map_type);
 		ASSERT_OK_PTR(map_type_str, map_type_name);
--=20
2.34.1


