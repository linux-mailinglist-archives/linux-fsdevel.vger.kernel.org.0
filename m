Return-Path: <linux-fsdevel+bounces-5188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC5B809273
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 21:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098CD1C20969
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 20:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7737E50242
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 20:37:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F8B10F9
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 10:55:02 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7EKMcO031322
	for <linux-fsdevel@vger.kernel.org>; Thu, 7 Dec 2023 10:55:02 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uufqft7hf-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 10:55:01 -0800
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 7 Dec 2023 10:54:55 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 549633CC1CA6F; Thu,  7 Dec 2023 10:54:54 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH bpf-next 5/8] libbpf: wire up token_fd into feature probing logic
Date: Thu, 7 Dec 2023 10:54:40 -0800
Message-ID: <20231207185443.2297160-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207185443.2297160-1-andrii@kernel.org>
References: <20231207185443.2297160-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: R_spBFyT3Pq2v_E5ZMaspto3iL5nxxpU
X-Proofpoint-GUID: R_spBFyT3Pq2v_E5ZMaspto3iL5nxxpU
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_15,2023-12-07_01,2023-05-22_02

Adjust feature probing callbacks to take into account optional token_fd.
In unprivileged contexts, some feature detectors would fail to detect
kernel support just because BPF program, BPF map, or BTF object can't be
loaded due to privileged nature of those operations. So when BPF object
is loaded with BPF token, this token should be used for feature probing.

This patch is setting support for this scenario, but we don't yet pass
non-zero token FD. This will be added in the next patch.

We also switched BPF cookie detector from using kprobe program to
tracepoint one, as tracepoint is somewhat less dangerous BPF program
type and has higher likelihood of being allowed through BPF token in the
future. This change has no effect on detection behavior.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c             |   3 +-
 tools/lib/bpf/features.c        | 101 +++++++++++++++++---------------
 tools/lib/bpf/libbpf.c          |   2 +-
 tools/lib/bpf/libbpf_internal.h |  20 +++++--
 tools/lib/bpf/libbpf_probes.c   |   8 ++-
 5 files changed, 76 insertions(+), 58 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 120855ac6859..0ad8e532b3cf 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -103,7 +103,7 @@ int sys_bpf_prog_load(union bpf_attr *attr, unsigned in=
t size, int attempts)
  *   [0] https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.com/
  *   [1] d05512618056 ("bpf: Add bpf_ktime_get_coarse_ns helper")
  */
-int probe_memcg_account(void)
+int probe_memcg_account(int token_fd)
 {
 	const size_t attr_sz =3D offsetofend(union bpf_attr, attach_btf_obj_fd);
 	struct bpf_insn insns[] =3D {
@@ -120,6 +120,7 @@ int probe_memcg_account(void)
 	attr.insns =3D ptr_to_u64(insns);
 	attr.insn_cnt =3D insn_cnt;
 	attr.license =3D ptr_to_u64("GPL");
+	attr.prog_token_fd =3D token_fd;
=20
 	prog_fd =3D sys_bpf_fd(BPF_PROG_LOAD, &attr, attr_sz);
 	if (prog_fd >=3D 0) {
diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 12361b5ae5a5..ce98a334be21 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -20,7 +20,7 @@ static int probe_fd(int fd)
 	return fd >=3D 0;
 }
=20
-static int probe_kern_prog_name(void)
+static int probe_kern_prog_name(int token_fd)
 {
 	const size_t attr_sz =3D offsetofend(union bpf_attr, prog_name);
 	struct bpf_insn insns[] =3D {
@@ -35,6 +35,7 @@ static int probe_kern_prog_name(void)
 	attr.license =3D ptr_to_u64("GPL");
 	attr.insns =3D ptr_to_u64(insns);
 	attr.insn_cnt =3D (__u32)ARRAY_SIZE(insns);
+	attr.prog_token_fd =3D token_fd;
 	libbpf_strlcpy(attr.prog_name, "libbpf_nametest", sizeof(attr.prog_name));
=20
 	/* make sure loading with name works */
@@ -42,7 +43,7 @@ static int probe_kern_prog_name(void)
 	return probe_fd(ret);
 }
=20
-static int probe_kern_global_data(void)
+static int probe_kern_global_data(int token_fd)
 {
 	char *cp, errmsg[STRERR_BUFSIZE];
 	struct bpf_insn insns[] =3D {
@@ -51,9 +52,11 @@ static int probe_kern_global_data(void)
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts, .token_fd =3D token_fd);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts, .token_fd =3D token_fd);
 	int ret, map, insn_cnt =3D ARRAY_SIZE(insns);
=20
-	map =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_global", sizeof(int), =
32, 1, NULL);
+	map =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_global", sizeof(int), =
32, 1, &map_opts);
 	if (map < 0) {
 		ret =3D -errno;
 		cp =3D libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
@@ -64,12 +67,12 @@ static int probe_kern_global_data(void)
=20
 	insns[0].imm =3D map;
=20
-	ret =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, in=
sn_cnt, NULL);
+	ret =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, in=
sn_cnt, &prog_opts);
 	close(map);
 	return probe_fd(ret);
 }
=20
-static int probe_kern_btf(void)
+static int probe_kern_btf(int token_fd)
 {
 	static const char strs[] =3D "\0int";
 	__u32 types[] =3D {
@@ -78,10 +81,10 @@ static int probe_kern_btf(void)
 	};
=20
 	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
+					     strs, sizeof(strs), token_fd));
 }
=20
-static int probe_kern_btf_func(void)
+static int probe_kern_btf_func(int token_fd)
 {
 	static const char strs[] =3D "\0int\0x\0a";
 	/* void x(int a) {} */
@@ -96,10 +99,10 @@ static int probe_kern_btf_func(void)
 	};
=20
 	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
+					     strs, sizeof(strs), token_fd));
 }
=20
-static int probe_kern_btf_func_global(void)
+static int probe_kern_btf_func_global(int token_fd)
 {
 	static const char strs[] =3D "\0int\0x\0a";
 	/* static void x(int a) {} */
@@ -114,10 +117,10 @@ static int probe_kern_btf_func_global(void)
 	};
=20
 	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
+					     strs, sizeof(strs), token_fd));
 }
=20
-static int probe_kern_btf_datasec(void)
+static int probe_kern_btf_datasec(int token_fd)
 {
 	static const char strs[] =3D "\0x\0.data";
 	/* static int a; */
@@ -133,10 +136,10 @@ static int probe_kern_btf_datasec(void)
 	};
=20
 	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
+					     strs, sizeof(strs), token_fd));
 }
=20
-static int probe_kern_btf_float(void)
+static int probe_kern_btf_float(int token_fd)
 {
 	static const char strs[] =3D "\0float";
 	__u32 types[] =3D {
@@ -145,10 +148,10 @@ static int probe_kern_btf_float(void)
 	};
=20
 	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
+					     strs, sizeof(strs), token_fd));
 }
=20
-static int probe_kern_btf_decl_tag(void)
+static int probe_kern_btf_decl_tag(int token_fd)
 {
 	static const char strs[] =3D "\0tag";
 	__u32 types[] =3D {
@@ -162,10 +165,10 @@ static int probe_kern_btf_decl_tag(void)
 	};
=20
 	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
+					     strs, sizeof(strs), token_fd));
 }
=20
-static int probe_kern_btf_type_tag(void)
+static int probe_kern_btf_type_tag(int token_fd)
 {
 	static const char strs[] =3D "\0tag";
 	__u32 types[] =3D {
@@ -178,21 +181,27 @@ static int probe_kern_btf_type_tag(void)
 	};
=20
 	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
+					     strs, sizeof(strs), token_fd));
 }
=20
-static int probe_kern_array_mmap(void)
+static int probe_kern_array_mmap(int token_fd)
 {
-	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags =3D BPF_F_MMAPABLE);
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		.map_flags =3D BPF_F_MMAPABLE,
+		.token_fd =3D token_fd,
+	);
 	int fd;
=20
 	fd =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_mmap", sizeof(int), siz=
eof(int), 1, &opts);
 	return probe_fd(fd);
 }
=20
-static int probe_kern_exp_attach_type(void)
+static int probe_kern_exp_attach_type(int token_fd)
 {
-	LIBBPF_OPTS(bpf_prog_load_opts, opts, .expected_attach_type =3D BPF_CGROU=
P_INET_SOCK_CREATE);
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.expected_attach_type =3D BPF_CGROUP_INET_SOCK_CREATE,
+		.token_fd =3D token_fd,
+	);
 	struct bpf_insn insns[] =3D {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -208,8 +217,9 @@ static int probe_kern_exp_attach_type(void)
 	return probe_fd(fd);
 }
=20
-static int probe_kern_probe_read_kernel(void)
+static int probe_kern_probe_read_kernel(int token_fd)
 {
+	LIBBPF_OPTS(bpf_prog_load_opts, opts, .token_fd =3D token_fd);
 	struct bpf_insn insns[] =3D {
 		BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),	/* r1 =3D r10 (fp) */
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),	/* r1 +=3D -8 */
@@ -220,20 +230,22 @@ static int probe_kern_probe_read_kernel(void)
 	};
 	int fd, insn_cnt =3D ARRAY_SIZE(insns);
=20
-	fd =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_c=
nt, NULL);
+	fd =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_c=
nt, &opts);
 	return probe_fd(fd);
 }
=20
-static int probe_prog_bind_map(void)
+static int probe_prog_bind_map(int token_fd)
 {
 	char *cp, errmsg[STRERR_BUFSIZE];
 	struct bpf_insn insns[] =3D {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts, .token_fd =3D token_fd);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts, .token_fd =3D token_fd);
 	int ret, map, prog, insn_cnt =3D ARRAY_SIZE(insns);
=20
-	map =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_det_bind", sizeof(int)=
, 32, 1, NULL);
+	map =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_det_bind", sizeof(int)=
, 32, 1, &map_opts);
 	if (map < 0) {
 		ret =3D -errno;
 		cp =3D libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
@@ -242,7 +254,7 @@ static int probe_prog_bind_map(void)
 		return ret;
 	}
=20
-	prog =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, i=
nsn_cnt, NULL);
+	prog =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, i=
nsn_cnt, &prog_opts);
 	if (prog < 0) {
 		close(map);
 		return 0;
@@ -256,7 +268,7 @@ static int probe_prog_bind_map(void)
 	return ret >=3D 0;
 }
=20
-static int probe_module_btf(void)
+static int probe_module_btf(int token_fd)
 {
 	static const char strs[] =3D "\0int";
 	__u32 types[] =3D {
@@ -268,7 +280,7 @@ static int probe_module_btf(void)
 	char name[16];
 	int fd, err;
=20
-	fd =3D libbpf__load_raw_btf((char *)types, sizeof(types), strs, sizeof(st=
rs));
+	fd =3D libbpf__load_raw_btf((char *)types, sizeof(types), strs, sizeof(st=
rs), token_fd);
 	if (fd < 0)
 		return 0; /* BTF not supported at all */
=20
@@ -285,16 +297,17 @@ static int probe_module_btf(void)
 	return !err;
 }
=20
-static int probe_perf_link(void)
+static int probe_perf_link(int token_fd)
 {
 	struct bpf_insn insns[] =3D {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
+	LIBBPF_OPTS(bpf_prog_load_opts, opts, .token_fd =3D token_fd);
 	int prog_fd, link_fd, err;
=20
 	prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL",
-				insns, ARRAY_SIZE(insns), NULL);
+				insns, ARRAY_SIZE(insns), &opts);
 	if (prog_fd < 0)
 		return -errno;
=20
@@ -311,10 +324,11 @@ static int probe_perf_link(void)
 	return link_fd < 0 && err =3D=3D -EBADF;
 }
=20
-static int probe_uprobe_multi_link(void)
+static int probe_uprobe_multi_link(int token_fd)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
 		.expected_attach_type =3D BPF_TRACE_UPROBE_MULTI,
+		.token_fd =3D token_fd,
 	);
 	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
 	struct bpf_insn insns[] =3D {
@@ -344,19 +358,20 @@ static int probe_uprobe_multi_link(void)
 	return link_fd < 0 && err =3D=3D -EBADF;
 }
=20
-static int probe_kern_bpf_cookie(void)
+static int probe_kern_bpf_cookie(int token_fd)
 {
 	struct bpf_insn insns[] =3D {
 		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_attach_cookie),
 		BPF_EXIT_INSN(),
 	};
+	LIBBPF_OPTS(bpf_prog_load_opts, opts, .token_fd =3D token_fd);
 	int ret, insn_cnt =3D ARRAY_SIZE(insns);
=20
-	ret =3D bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL", insns, insn_cnt,=
 NULL);
+	ret =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_=
cnt, &opts);
 	return probe_fd(ret);
 }
=20
-static int probe_kern_btf_enum64(void)
+static int probe_kern_btf_enum64(int token_fd)
 {
 	static const char strs[] =3D "\0enum64";
 	__u32 types[] =3D {
@@ -364,20 +379,10 @@ static int probe_kern_btf_enum64(void)
 	};
=20
 	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
+					     strs, sizeof(strs), token_fd));
 }
=20
-enum kern_feature_result {
-	FEAT_UNKNOWN =3D 0,
-	FEAT_SUPPORTED =3D 1,
-	FEAT_MISSING =3D 2,
-};
-
-typedef int (*feature_probe_fn)(void);
-
-struct kern_feature_cache {
-	enum kern_feature_result res[__FEAT_CNT];
-};
+typedef int (*feature_probe_fn)(int /* token_fd */);
=20
 static struct kern_feature_cache feature_cache;
=20
@@ -458,7 +463,7 @@ bool feat_supported(struct kern_feature_cache *cache, e=
num kern_feature_id feat_
 		cache =3D &feature_cache;
=20
 	if (READ_ONCE(cache->res[feat_id]) =3D=3D FEAT_UNKNOWN) {
-		ret =3D feat->probe();
+		ret =3D feat->probe(cache->token_fd);
 		if (ret > 0) {
 			WRITE_ONCE(cache->res[feat_id], FEAT_SUPPORTED);
 		} else if (ret =3D=3D 0) {
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7cf1b96d4472..1a9fe08179ee 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10155,7 +10155,7 @@ static const char *arch_specific_syscall_pfx(void)
 #endif
 }
=20
-int probe_kern_syscall_wrapper(void)
+int probe_kern_syscall_wrapper(int token_fd)
 {
 	char syscall_name[64];
 	const char *ksys_pfx;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_interna=
l.h
index 4497b99e6a06..b45566e428d7 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -360,17 +360,29 @@ enum kern_feature_id {
 	__FEAT_CNT,
 };
=20
-struct kern_feature_cache;
+enum kern_feature_result {
+	FEAT_UNKNOWN =3D 0,
+	FEAT_SUPPORTED =3D 1,
+	FEAT_MISSING =3D 2,
+};
+
+struct kern_feature_cache {
+	enum kern_feature_result res[__FEAT_CNT];
+	int token_fd;
+};
+
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id=
 feat_id);
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id fe=
at_id);
=20
-int probe_memcg_account(void);
+int probe_kern_syscall_wrapper(int token_fd);
+int probe_memcg_account(int token_fd);
 int bump_rlimit_memlock(void);
=20
 int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz);
 int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz);
 int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
-			 const char *str_sec, size_t str_len);
+			 const char *str_sec, size_t str_len,
+			 int token_fd);
 int btf_load_into_kernel(struct btf *btf, char *log_buf, size_t log_sz, __=
u32 log_level);
=20
 struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
@@ -602,6 +614,4 @@ int elf_resolve_syms_offsets(const char *binary_path, i=
nt cnt,
 int elf_resolve_pattern_offsets(const char *binary_path, const char *patte=
rn,
 				 unsigned long **poffsets, size_t *pcnt);
=20
-int probe_kern_syscall_wrapper(void);
-
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9c4db90b92b6..8e7437006639 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -219,7 +219,8 @@ int libbpf_probe_bpf_prog_type(enum bpf_prog_type prog_=
type, const void *opts)
 }
=20
 int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
-			 const char *str_sec, size_t str_len)
+			 const char *str_sec, size_t str_len,
+			 int token_fd)
 {
 	struct btf_header hdr =3D {
 		.magic =3D BTF_MAGIC,
@@ -229,6 +230,7 @@ int libbpf__load_raw_btf(const char *raw_types, size_t =
types_len,
 		.str_off =3D types_len,
 		.str_len =3D str_len,
 	};
+	LIBBPF_OPTS(bpf_btf_load_opts, opts, .token_fd =3D token_fd);
 	int btf_fd, btf_len;
 	__u8 *raw_btf;
=20
@@ -241,7 +243,7 @@ int libbpf__load_raw_btf(const char *raw_types, size_t =
types_len,
 	memcpy(raw_btf + hdr.hdr_len, raw_types, hdr.type_len);
 	memcpy(raw_btf + hdr.hdr_len + hdr.type_len, str_sec, hdr.str_len);
=20
-	btf_fd =3D bpf_btf_load(raw_btf, btf_len, NULL);
+	btf_fd =3D bpf_btf_load(raw_btf, btf_len, &opts);
=20
 	free(raw_btf);
 	return btf_fd;
@@ -271,7 +273,7 @@ static int load_local_storage_btf(void)
 	};
=20
 	return libbpf__load_raw_btf((char *)types, sizeof(types),
-				     strs, sizeof(strs));
+				     strs, sizeof(strs), 0);
 }
=20
 static int probe_map_create(enum bpf_map_type map_type)
--=20
2.34.1


