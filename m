Return-Path: <linux-fsdevel+bounces-8662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7A2839F06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA27C28BC9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954C017BAD;
	Wed, 24 Jan 2024 02:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofXFU8Uc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED64FBE73;
	Wed, 24 Jan 2024 02:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062980; cv=none; b=OkdQdtRfkM0Zi9ar8UhehJHaUtrs+wAc+2BUb5cTATk1ostp57Gr9+02OWfrzaGPyX9opqA89uRHS1YZkxSUnx4UXBu8FYECmckAZwhE0wl01NtDhvPq0+HECgpC8R8OGqeNHWZNo4PjKM9xb8k26kNqQ5n58bcTTK++s+RA7aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062980; c=relaxed/simple;
	bh=+B5J8GnmFkp6X6CbqHJP15xfQ41+UNN/ipt74a9Kbx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3GX8d1eDUuySopDpkIoWIeoT9pHocE+/D6uSbRc1ZZXSdO+LS8nhVoXBsUIowEfnV47Z+UM3t9acMjsFd66Fo2emhiEXUtrLAUyUdZBsoRSO/D121ZKbFMPIEc7hUnEUzp94nMrk7PanUQdZMOU3/Tb2RQkKuBXHzhnRbu3ng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofXFU8Uc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0A2C433C7;
	Wed, 24 Jan 2024 02:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062979;
	bh=+B5J8GnmFkp6X6CbqHJP15xfQ41+UNN/ipt74a9Kbx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ofXFU8UcwsCjPJUADybOj8UUxisHW6vw4mhy0MIL//olySZSXTpseAdGsrJFylYGi
	 SS3rFrvFpd+BoPUm2EZ8Vjguquf7p3rMjms/DX4J2ulm+HBNdt0tNqEkABUvPuELBc
	 p3HboqeFycM86/mPWvGQa12zr9koGFSkn0hQiwxaQYWq4y5+fIKo9XBDExQEEK3Z2D
	 S3fU5XQqvegRSHut/irdKOLi1LMCRhT16rAGxd9zAU1LY521aj4hCJCGJtAI+U/BP+
	 82HgmJSqu44LJSPDGj9R4N0LYDOANIvqGderGium39mPw6HmaO/YOaHAZYwP1ElpAq
	 Bo4No2cNL0j9w==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 24/30] libbpf: wire up token_fd into feature probing logic
Date: Tue, 23 Jan 2024 18:21:21 -0800
Message-Id: <20240124022127.2379740-25-andrii@kernel.org>
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

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c             |   5 +-
 tools/lib/bpf/features.c        | 116 +++++++++++++++++++++-----------
 tools/lib/bpf/libbpf.c          |   4 +-
 tools/lib/bpf/libbpf_internal.h |   8 ++-
 tools/lib/bpf/libbpf_probes.c   |  11 ++-
 5 files changed, 97 insertions(+), 47 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 10bf11a758bf..cc3888c3c914 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -103,7 +103,7 @@ int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts)
  *   [0] https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.com/
  *   [1] d05512618056 ("bpf: Add bpf_ktime_get_coarse_ns helper")
  */
-int probe_memcg_account(void)
+int probe_memcg_account(int token_fd)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, attach_btf_obj_fd);
 	struct bpf_insn insns[] = {
@@ -120,6 +120,9 @@ int probe_memcg_account(void)
 	attr.insns = ptr_to_u64(insns);
 	attr.insn_cnt = insn_cnt;
 	attr.license = ptr_to_u64("GPL");
+	attr.prog_token_fd = token_fd;
+	if (token_fd)
+		attr.prog_flags |= BPF_F_TOKEN_FD;
 
 	prog_fd = sys_bpf_fd(BPF_PROG_LOAD, &attr, attr_sz);
 	if (prog_fd >= 0) {
diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index a4664526ab7f..5a5c766bf615 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -20,7 +20,7 @@ int probe_fd(int fd)
 	return fd >= 0;
 }
 
-static int probe_kern_prog_name(void)
+static int probe_kern_prog_name(int token_fd)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, prog_name);
 	struct bpf_insn insns[] = {
@@ -35,6 +35,9 @@ static int probe_kern_prog_name(void)
 	attr.license = ptr_to_u64("GPL");
 	attr.insns = ptr_to_u64(insns);
 	attr.insn_cnt = (__u32)ARRAY_SIZE(insns);
+	attr.prog_token_fd = token_fd;
+	if (token_fd)
+		attr.prog_flags |= BPF_F_TOKEN_FD;
 	libbpf_strlcpy(attr.prog_name, "libbpf_nametest", sizeof(attr.prog_name));
 
 	/* make sure loading with name works */
@@ -42,7 +45,7 @@ static int probe_kern_prog_name(void)
 	return probe_fd(ret);
 }
 
-static int probe_kern_global_data(void)
+static int probe_kern_global_data(int token_fd)
 {
 	char *cp, errmsg[STRERR_BUFSIZE];
 	struct bpf_insn insns[] = {
@@ -51,9 +54,17 @@ static int probe_kern_global_data(void)
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
+		.token_fd = token_fd,
+		.map_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
+		.token_fd = token_fd,
+		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
 	int ret, map, insn_cnt = ARRAY_SIZE(insns);
 
-	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_global", sizeof(int), 32, 1, NULL);
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_global", sizeof(int), 32, 1, &map_opts);
 	if (map < 0) {
 		ret = -errno;
 		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
@@ -64,12 +75,12 @@ static int probe_kern_global_data(void)
 
 	insns[0].imm = map;
 
-	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, NULL);
+	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &prog_opts);
 	close(map);
 	return probe_fd(ret);
 }
 
-static int probe_kern_btf(void)
+static int probe_kern_btf(int token_fd)
 {
 	static const char strs[] = "\0int";
 	__u32 types[] = {
@@ -78,10 +89,10 @@ static int probe_kern_btf(void)
 	};
 
 	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
+					     strs, sizeof(strs), token_fd));
 }
 
-static int probe_kern_btf_func(void)
+static int probe_kern_btf_func(int token_fd)
 {
 	static const char strs[] = "\0int\0x\0a";
 	/* void x(int a) {} */
@@ -96,10 +107,10 @@ static int probe_kern_btf_func(void)
 	};
 
 	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
+					     strs, sizeof(strs), token_fd));
 }
 
-static int probe_kern_btf_func_global(void)
+static int probe_kern_btf_func_global(int token_fd)
 {
 	static const char strs[] = "\0int\0x\0a";
 	/* static void x(int a) {} */
@@ -114,10 +125,10 @@ static int probe_kern_btf_func_global(void)
 	};
 
 	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
+					     strs, sizeof(strs), token_fd));
 }
 
-static int probe_kern_btf_datasec(void)
+static int probe_kern_btf_datasec(int token_fd)
 {
 	static const char strs[] = "\0x\0.data";
 	/* static int a; */
@@ -133,10 +144,10 @@ static int probe_kern_btf_datasec(void)
 	};
 
 	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
+					     strs, sizeof(strs), token_fd));
 }
 
-static int probe_kern_btf_float(void)
+static int probe_kern_btf_float(int token_fd)
 {
 	static const char strs[] = "\0float";
 	__u32 types[] = {
@@ -145,10 +156,10 @@ static int probe_kern_btf_float(void)
 	};
 
 	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
+					     strs, sizeof(strs), token_fd));
 }
 
-static int probe_kern_btf_decl_tag(void)
+static int probe_kern_btf_decl_tag(int token_fd)
 {
 	static const char strs[] = "\0tag";
 	__u32 types[] = {
@@ -162,10 +173,10 @@ static int probe_kern_btf_decl_tag(void)
 	};
 
 	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
+					     strs, sizeof(strs), token_fd));
 }
 
-static int probe_kern_btf_type_tag(void)
+static int probe_kern_btf_type_tag(int token_fd)
 {
 	static const char strs[] = "\0tag";
 	__u32 types[] = {
@@ -178,21 +189,28 @@ static int probe_kern_btf_type_tag(void)
 	};
 
 	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
+					     strs, sizeof(strs), token_fd));
 }
 
-static int probe_kern_array_mmap(void)
+static int probe_kern_array_mmap(int token_fd)
 {
-	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		.map_flags = BPF_F_MMAPABLE | (token_fd ? BPF_F_TOKEN_FD : 0),
+		.token_fd = token_fd,
+	);
 	int fd;
 
 	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_mmap", sizeof(int), sizeof(int), 1, &opts);
 	return probe_fd(fd);
 }
 
-static int probe_kern_exp_attach_type(void)
+static int probe_kern_exp_attach_type(int token_fd)
 {
-	LIBBPF_OPTS(bpf_prog_load_opts, opts, .expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE);
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+		.token_fd = token_fd,
+		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
 	struct bpf_insn insns[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -208,8 +226,12 @@ static int probe_kern_exp_attach_type(void)
 	return probe_fd(fd);
 }
 
-static int probe_kern_probe_read_kernel(void)
+static int probe_kern_probe_read_kernel(int token_fd)
 {
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.token_fd = token_fd,
+		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
 	struct bpf_insn insns[] = {
 		BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),	/* r1 = r10 (fp) */
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),	/* r1 += -8 */
@@ -220,20 +242,28 @@ static int probe_kern_probe_read_kernel(void)
 	};
 	int fd, insn_cnt = ARRAY_SIZE(insns);
 
-	fd = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, NULL);
+	fd = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, &opts);
 	return probe_fd(fd);
 }
 
-static int probe_prog_bind_map(void)
+static int probe_prog_bind_map(int token_fd)
 {
 	char *cp, errmsg[STRERR_BUFSIZE];
 	struct bpf_insn insns[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
+		.token_fd = token_fd,
+		.map_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
+		.token_fd = token_fd,
+		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
 	int ret, map, prog, insn_cnt = ARRAY_SIZE(insns);
 
-	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_det_bind", sizeof(int), 32, 1, NULL);
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_det_bind", sizeof(int), 32, 1, &map_opts);
 	if (map < 0) {
 		ret = -errno;
 		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
@@ -242,7 +272,7 @@ static int probe_prog_bind_map(void)
 		return ret;
 	}
 
-	prog = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, NULL);
+	prog = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &prog_opts);
 	if (prog < 0) {
 		close(map);
 		return 0;
@@ -256,7 +286,7 @@ static int probe_prog_bind_map(void)
 	return ret >= 0;
 }
 
-static int probe_module_btf(void)
+static int probe_module_btf(int token_fd)
 {
 	static const char strs[] = "\0int";
 	__u32 types[] = {
@@ -268,7 +298,7 @@ static int probe_module_btf(void)
 	char name[16];
 	int fd, err;
 
-	fd = libbpf__load_raw_btf((char *)types, sizeof(types), strs, sizeof(strs));
+	fd = libbpf__load_raw_btf((char *)types, sizeof(types), strs, sizeof(strs), token_fd);
 	if (fd < 0)
 		return 0; /* BTF not supported at all */
 
@@ -285,16 +315,20 @@ static int probe_module_btf(void)
 	return !err;
 }
 
-static int probe_perf_link(void)
+static int probe_perf_link(int token_fd)
 {
 	struct bpf_insn insns[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.token_fd = token_fd,
+		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
 	int prog_fd, link_fd, err;
 
 	prog_fd = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL",
-				insns, ARRAY_SIZE(insns), NULL);
+				insns, ARRAY_SIZE(insns), &opts);
 	if (prog_fd < 0)
 		return -errno;
 
@@ -311,10 +345,12 @@ static int probe_perf_link(void)
 	return link_fd < 0 && err == -EBADF;
 }
 
-static int probe_uprobe_multi_link(void)
+static int probe_uprobe_multi_link(int token_fd)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
 		.expected_attach_type = BPF_TRACE_UPROBE_MULTI,
+		.token_fd = token_fd,
+		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
 	);
 	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
 	struct bpf_insn insns[] = {
@@ -344,19 +380,23 @@ static int probe_uprobe_multi_link(void)
 	return link_fd < 0 && err == -EBADF;
 }
 
-static int probe_kern_bpf_cookie(void)
+static int probe_kern_bpf_cookie(int token_fd)
 {
 	struct bpf_insn insns[] = {
 		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_attach_cookie),
 		BPF_EXIT_INSN(),
 	};
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.token_fd = token_fd,
+		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
 	int ret, insn_cnt = ARRAY_SIZE(insns);
 
-	ret = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL", insns, insn_cnt, NULL);
+	ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, &opts);
 	return probe_fd(ret);
 }
 
-static int probe_kern_btf_enum64(void)
+static int probe_kern_btf_enum64(int token_fd)
 {
 	static const char strs[] = "\0enum64";
 	__u32 types[] = {
@@ -364,10 +404,10 @@ static int probe_kern_btf_enum64(void)
 	};
 
 	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
+					     strs, sizeof(strs), token_fd));
 }
 
-typedef int (*feature_probe_fn)(void);
+typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
 
@@ -448,7 +488,7 @@ bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_
 		cache = &feature_cache;
 
 	if (READ_ONCE(cache->res[feat_id]) == FEAT_UNKNOWN) {
-		ret = feat->probe();
+		ret = feat->probe(cache->token_fd);
 		if (ret > 0) {
 			WRITE_ONCE(cache->res[feat_id], FEAT_SUPPORTED);
 		} else if (ret == 0) {
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5c441737db98..67f52e371cb2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6421,7 +6421,7 @@ static int probe_kern_arg_ctx_tag(void)
 	if (cached_result >= 0)
 		return cached_result;
 
-	btf_fd = libbpf__load_raw_btf((char *)types, sizeof(types), strs, sizeof(strs));
+	btf_fd = libbpf__load_raw_btf((char *)types, sizeof(types), strs, sizeof(strs), 0);
 	if (btf_fd < 0)
 		return 0;
 
@@ -10585,7 +10585,7 @@ static const char *arch_specific_syscall_pfx(void)
 #endif
 }
 
-int probe_kern_syscall_wrapper(void)
+int probe_kern_syscall_wrapper(int token_fd)
 {
 	char syscall_name[64];
 	const char *ksys_pfx;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index fa25e1232bc8..28fabed1cd8f 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -369,19 +369,21 @@ enum kern_feature_result {
 
 struct kern_feature_cache {
 	enum kern_feature_result res[__FEAT_CNT];
+	int token_fd;
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id);
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id);
 
-int probe_kern_syscall_wrapper(void);
-int probe_memcg_account(void);
+int probe_kern_syscall_wrapper(int token_fd);
+int probe_memcg_account(int token_fd);
 int bump_rlimit_memlock(void);
 
 int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz);
 int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz);
 int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
-			 const char *str_sec, size_t str_len);
+			 const char *str_sec, size_t str_len,
+			 int token_fd);
 int btf_load_into_kernel(struct btf *btf, char *log_buf, size_t log_sz, __u32 log_level);
 
 struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9c4db90b92b6..abd10a02d420 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -219,7 +219,8 @@ int libbpf_probe_bpf_prog_type(enum bpf_prog_type prog_type, const void *opts)
 }
 
 int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
-			 const char *str_sec, size_t str_len)
+			 const char *str_sec, size_t str_len,
+			 int token_fd)
 {
 	struct btf_header hdr = {
 		.magic = BTF_MAGIC,
@@ -229,6 +230,10 @@ int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 		.str_off = types_len,
 		.str_len = str_len,
 	};
+	LIBBPF_OPTS(bpf_btf_load_opts, opts,
+		.token_fd = token_fd,
+		.btf_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
 	int btf_fd, btf_len;
 	__u8 *raw_btf;
 
@@ -241,7 +246,7 @@ int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 	memcpy(raw_btf + hdr.hdr_len, raw_types, hdr.type_len);
 	memcpy(raw_btf + hdr.hdr_len + hdr.type_len, str_sec, hdr.str_len);
 
-	btf_fd = bpf_btf_load(raw_btf, btf_len, NULL);
+	btf_fd = bpf_btf_load(raw_btf, btf_len, &opts);
 
 	free(raw_btf);
 	return btf_fd;
@@ -271,7 +276,7 @@ static int load_local_storage_btf(void)
 	};
 
 	return libbpf__load_raw_btf((char *)types, sizeof(types),
-				     strs, sizeof(strs));
+				     strs, sizeof(strs), 0);
 }
 
 static int probe_map_create(enum bpf_map_type map_type)
-- 
2.34.1


