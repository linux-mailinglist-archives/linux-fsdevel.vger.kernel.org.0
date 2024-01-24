Return-Path: <linux-fsdevel+bounces-8661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746CA839F02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997C71C21BBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8A0179B8;
	Wed, 24 Jan 2024 02:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCHDrCNw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E08E17988;
	Wed, 24 Jan 2024 02:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062976; cv=none; b=o924j5Yjoxa5bLQjyQEe0s/MyeuuoRzcQRFJmMVdGdi1WE5wtrl4VsuakGnv6tDZ2H6TBymqJyePtvfo2pGy3vj543fgBbDJWJnli0XJvDeMUT3eu1ihSNEGcHGeq+98OUrb9SmcIZX86drc5wMjuMw+pTVSwakYus9sShvhZ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062976; c=relaxed/simple;
	bh=81+jgn+Em1nKeDTSLxsH5gu3wAwHV8xGvkPAzAO1pPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X3B36Pd7aoqBsuFR5QFONJZJXl1mDrV+9ywiX+3P0A1FqMDy+sW5QIIipedyV+YRvXQVIIynk7kEB8MrdchET5MPGJxdLsZ7KIYhdYrCOND04SLSCSecPD4DEUYfSI+ETxAXyxqw1aUNYJ8Z1MQeWg+U6khFB7xj7YpwW638fys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCHDrCNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D226C43390;
	Wed, 24 Jan 2024 02:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062975;
	bh=81+jgn+Em1nKeDTSLxsH5gu3wAwHV8xGvkPAzAO1pPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCHDrCNwhrByp+eoST0TYWgnyy8EIHaLSplm5rF2m/eCAIaLz5o16XzqXnbEYeOI1
	 hypp6zr0N5W0HmeLlgU/7DT1irIdcxGS8sNRyRksUZAjRBd6P4SlqBb7eoOjM/zWn1
	 fk0s2VcplOSyREX+kl/pbteJtkV6WYlKw2yXt50+9O0/FdXKBWJNujUnO2FV/PtnRg
	 nEg6fSSAGv2TsMnTLofv+oNV4dgMt0cUxNMh16O9vT/kte2WiuxnNTti0ohS4OtPKY
	 M06wX/vMaU2q7fYaN7wa+Ur7Y0u4cqAwqaUmv3ZDM12pZ2ilIk73KSmsRQNjiBux2L
	 edpBt0gzpr6/A==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 23/30] libbpf: move feature detection code into its own file
Date: Tue, 23 Jan 2024 18:21:20 -0800
Message-Id: <20240124022127.2379740-24-andrii@kernel.org>
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

It's quite a lot of well isolated code, so it seems like a good
candidate to move it out of libbpf.c to reduce its size.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/Build             |   2 +-
 tools/lib/bpf/elf.c             |   2 -
 tools/lib/bpf/features.c        | 463 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          | 463 +-------------------------------
 tools/lib/bpf/libbpf_internal.h |  14 +-
 tools/lib/bpf/str_error.h       |   3 +
 6 files changed, 481 insertions(+), 466 deletions(-)
 create mode 100644 tools/lib/bpf/features.c

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index 2d0c282c8588..b6619199a706 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1,4 +1,4 @@
 libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
 	    netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
 	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
-	    usdt.o zip.o elf.o
+	    usdt.o zip.o elf.o features.o
diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index b02faec748a5..c92e02394159 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -11,8 +11,6 @@
 #include "libbpf_internal.h"
 #include "str_error.h"
 
-#define STRERR_BUFSIZE  128
-
 /* A SHT_GNU_versym section holds 16-bit words. This bit is set if
  * the symbol is hidden and can only be seen when referenced using an
  * explicit version number. This is a GNU extension.
diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
new file mode 100644
index 000000000000..a4664526ab7f
--- /dev/null
+++ b/tools/lib/bpf/features.c
@@ -0,0 +1,463 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include <linux/kernel.h>
+#include <linux/filter.h>
+#include "bpf.h"
+#include "libbpf.h"
+#include "libbpf_common.h"
+#include "libbpf_internal.h"
+#include "str_error.h"
+
+static inline __u64 ptr_to_u64(const void *ptr)
+{
+	return (__u64)(unsigned long)ptr;
+}
+
+int probe_fd(int fd)
+{
+	if (fd >= 0)
+		close(fd);
+	return fd >= 0;
+}
+
+static int probe_kern_prog_name(void)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_name);
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	union bpf_attr attr;
+	int ret;
+
+	memset(&attr, 0, attr_sz);
+	attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
+	attr.license = ptr_to_u64("GPL");
+	attr.insns = ptr_to_u64(insns);
+	attr.insn_cnt = (__u32)ARRAY_SIZE(insns);
+	libbpf_strlcpy(attr.prog_name, "libbpf_nametest", sizeof(attr.prog_name));
+
+	/* make sure loading with name works */
+	ret = sys_bpf_prog_load(&attr, attr_sz, PROG_LOAD_ATTEMPTS);
+	return probe_fd(ret);
+}
+
+static int probe_kern_global_data(void)
+{
+	char *cp, errmsg[STRERR_BUFSIZE];
+	struct bpf_insn insns[] = {
+		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 16),
+		BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 42),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int ret, map, insn_cnt = ARRAY_SIZE(insns);
+
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_global", sizeof(int), 32, 1, NULL);
+	if (map < 0) {
+		ret = -errno;
+		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
+		pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
+			__func__, cp, -ret);
+		return ret;
+	}
+
+	insns[0].imm = map;
+
+	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, NULL);
+	close(map);
+	return probe_fd(ret);
+}
+
+static int probe_kern_btf(void)
+{
+	static const char strs[] = "\0int";
+	__u32 types[] = {
+		/* int */
+		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
+	};
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+					     strs, sizeof(strs)));
+}
+
+static int probe_kern_btf_func(void)
+{
+	static const char strs[] = "\0int\0x\0a";
+	/* void x(int a) {} */
+	__u32 types[] = {
+		/* int */
+		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
+		/* FUNC_PROTO */                                /* [2] */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 1), 0),
+		BTF_PARAM_ENC(7, 1),
+		/* FUNC x */                                    /* [3] */
+		BTF_TYPE_ENC(5, BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0), 2),
+	};
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+					     strs, sizeof(strs)));
+}
+
+static int probe_kern_btf_func_global(void)
+{
+	static const char strs[] = "\0int\0x\0a";
+	/* static void x(int a) {} */
+	__u32 types[] = {
+		/* int */
+		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
+		/* FUNC_PROTO */                                /* [2] */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 1), 0),
+		BTF_PARAM_ENC(7, 1),
+		/* FUNC x BTF_FUNC_GLOBAL */                    /* [3] */
+		BTF_TYPE_ENC(5, BTF_INFO_ENC(BTF_KIND_FUNC, 0, BTF_FUNC_GLOBAL), 2),
+	};
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+					     strs, sizeof(strs)));
+}
+
+static int probe_kern_btf_datasec(void)
+{
+	static const char strs[] = "\0x\0.data";
+	/* static int a; */
+	__u32 types[] = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
+		/* VAR x */                                     /* [2] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
+		BTF_VAR_STATIC,
+		/* DATASEC val */                               /* [3] */
+		BTF_TYPE_ENC(3, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(2, 0, 4),
+	};
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+					     strs, sizeof(strs)));
+}
+
+static int probe_kern_btf_float(void)
+{
+	static const char strs[] = "\0float";
+	__u32 types[] = {
+		/* float */
+		BTF_TYPE_FLOAT_ENC(1, 4),
+	};
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+					     strs, sizeof(strs)));
+}
+
+static int probe_kern_btf_decl_tag(void)
+{
+	static const char strs[] = "\0tag";
+	__u32 types[] = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
+		/* VAR x */                                     /* [2] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
+		BTF_VAR_STATIC,
+		/* attr */
+		BTF_TYPE_DECL_TAG_ENC(1, 2, -1),
+	};
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+					     strs, sizeof(strs)));
+}
+
+static int probe_kern_btf_type_tag(void)
+{
+	static const char strs[] = "\0tag";
+	__u32 types[] = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
+		/* attr */
+		BTF_TYPE_TYPE_TAG_ENC(1, 1),				/* [2] */
+		/* ptr */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 2),	/* [3] */
+	};
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+					     strs, sizeof(strs)));
+}
+
+static int probe_kern_array_mmap(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
+	int fd;
+
+	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_mmap", sizeof(int), sizeof(int), 1, &opts);
+	return probe_fd(fd);
+}
+
+static int probe_kern_exp_attach_type(void)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts, .expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE);
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int fd, insn_cnt = ARRAY_SIZE(insns);
+
+	/* use any valid combination of program type and (optional)
+	 * non-zero expected attach type (i.e., not a BPF_CGROUP_INET_INGRESS)
+	 * to see if kernel supports expected_attach_type field for
+	 * BPF_PROG_LOAD command
+	 */
+	fd = bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCK, NULL, "GPL", insns, insn_cnt, &opts);
+	return probe_fd(fd);
+}
+
+static int probe_kern_probe_read_kernel(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),	/* r1 = r10 (fp) */
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),	/* r1 += -8 */
+		BPF_MOV64_IMM(BPF_REG_2, 8),		/* r2 = 8 */
+		BPF_MOV64_IMM(BPF_REG_3, 0),		/* r3 = 0 */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_probe_read_kernel),
+		BPF_EXIT_INSN(),
+	};
+	int fd, insn_cnt = ARRAY_SIZE(insns);
+
+	fd = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, NULL);
+	return probe_fd(fd);
+}
+
+static int probe_prog_bind_map(void)
+{
+	char *cp, errmsg[STRERR_BUFSIZE];
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int ret, map, prog, insn_cnt = ARRAY_SIZE(insns);
+
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_det_bind", sizeof(int), 32, 1, NULL);
+	if (map < 0) {
+		ret = -errno;
+		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
+		pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
+			__func__, cp, -ret);
+		return ret;
+	}
+
+	prog = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, NULL);
+	if (prog < 0) {
+		close(map);
+		return 0;
+	}
+
+	ret = bpf_prog_bind_map(prog, map, NULL);
+
+	close(map);
+	close(prog);
+
+	return ret >= 0;
+}
+
+static int probe_module_btf(void)
+{
+	static const char strs[] = "\0int";
+	__u32 types[] = {
+		/* int */
+		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
+	};
+	struct bpf_btf_info info;
+	__u32 len = sizeof(info);
+	char name[16];
+	int fd, err;
+
+	fd = libbpf__load_raw_btf((char *)types, sizeof(types), strs, sizeof(strs));
+	if (fd < 0)
+		return 0; /* BTF not supported at all */
+
+	memset(&info, 0, sizeof(info));
+	info.name = ptr_to_u64(name);
+	info.name_len = sizeof(name);
+
+	/* check that BPF_OBJ_GET_INFO_BY_FD supports specifying name pointer;
+	 * kernel's module BTF support coincides with support for
+	 * name/name_len fields in struct bpf_btf_info.
+	 */
+	err = bpf_btf_get_info_by_fd(fd, &info, &len);
+	close(fd);
+	return !err;
+}
+
+static int probe_perf_link(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd, link_fd, err;
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL",
+				insns, ARRAY_SIZE(insns), NULL);
+	if (prog_fd < 0)
+		return -errno;
+
+	/* use invalid perf_event FD to get EBADF, if link is supported;
+	 * otherwise EINVAL should be returned
+	 */
+	link_fd = bpf_link_create(prog_fd, -1, BPF_PERF_EVENT, NULL);
+	err = -errno; /* close() can clobber errno */
+
+	if (link_fd >= 0)
+		close(link_fd);
+	close(prog_fd);
+
+	return link_fd < 0 && err == -EBADF;
+}
+
+static int probe_uprobe_multi_link(void)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
+		.expected_attach_type = BPF_TRACE_UPROBE_MULTI,
+	);
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd, link_fd, err;
+	unsigned long offset = 0;
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
+				insns, ARRAY_SIZE(insns), &load_opts);
+	if (prog_fd < 0)
+		return -errno;
+
+	/* Creating uprobe in '/' binary should fail with -EBADF. */
+	link_opts.uprobe_multi.path = "/";
+	link_opts.uprobe_multi.offsets = &offset;
+	link_opts.uprobe_multi.cnt = 1;
+
+	link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, &link_opts);
+	err = -errno; /* close() can clobber errno */
+
+	if (link_fd >= 0)
+		close(link_fd);
+	close(prog_fd);
+
+	return link_fd < 0 && err == -EBADF;
+}
+
+static int probe_kern_bpf_cookie(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_attach_cookie),
+		BPF_EXIT_INSN(),
+	};
+	int ret, insn_cnt = ARRAY_SIZE(insns);
+
+	ret = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL", insns, insn_cnt, NULL);
+	return probe_fd(ret);
+}
+
+static int probe_kern_btf_enum64(void)
+{
+	static const char strs[] = "\0enum64";
+	__u32 types[] = {
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 0), 8),
+	};
+
+	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
+					     strs, sizeof(strs)));
+}
+
+typedef int (*feature_probe_fn)(void);
+
+static struct kern_feature_cache feature_cache;
+
+static struct kern_feature_desc {
+	const char *desc;
+	feature_probe_fn probe;
+} feature_probes[__FEAT_CNT] = {
+	[FEAT_PROG_NAME] = {
+		"BPF program name", probe_kern_prog_name,
+	},
+	[FEAT_GLOBAL_DATA] = {
+		"global variables", probe_kern_global_data,
+	},
+	[FEAT_BTF] = {
+		"minimal BTF", probe_kern_btf,
+	},
+	[FEAT_BTF_FUNC] = {
+		"BTF functions", probe_kern_btf_func,
+	},
+	[FEAT_BTF_GLOBAL_FUNC] = {
+		"BTF global function", probe_kern_btf_func_global,
+	},
+	[FEAT_BTF_DATASEC] = {
+		"BTF data section and variable", probe_kern_btf_datasec,
+	},
+	[FEAT_ARRAY_MMAP] = {
+		"ARRAY map mmap()", probe_kern_array_mmap,
+	},
+	[FEAT_EXP_ATTACH_TYPE] = {
+		"BPF_PROG_LOAD expected_attach_type attribute",
+		probe_kern_exp_attach_type,
+	},
+	[FEAT_PROBE_READ_KERN] = {
+		"bpf_probe_read_kernel() helper", probe_kern_probe_read_kernel,
+	},
+	[FEAT_PROG_BIND_MAP] = {
+		"BPF_PROG_BIND_MAP support", probe_prog_bind_map,
+	},
+	[FEAT_MODULE_BTF] = {
+		"module BTF support", probe_module_btf,
+	},
+	[FEAT_BTF_FLOAT] = {
+		"BTF_KIND_FLOAT support", probe_kern_btf_float,
+	},
+	[FEAT_PERF_LINK] = {
+		"BPF perf link support", probe_perf_link,
+	},
+	[FEAT_BTF_DECL_TAG] = {
+		"BTF_KIND_DECL_TAG support", probe_kern_btf_decl_tag,
+	},
+	[FEAT_BTF_TYPE_TAG] = {
+		"BTF_KIND_TYPE_TAG support", probe_kern_btf_type_tag,
+	},
+	[FEAT_MEMCG_ACCOUNT] = {
+		"memcg-based memory accounting", probe_memcg_account,
+	},
+	[FEAT_BPF_COOKIE] = {
+		"BPF cookie support", probe_kern_bpf_cookie,
+	},
+	[FEAT_BTF_ENUM64] = {
+		"BTF_KIND_ENUM64 support", probe_kern_btf_enum64,
+	},
+	[FEAT_SYSCALL_WRAPPER] = {
+		"Kernel using syscall wrapper", probe_kern_syscall_wrapper,
+	},
+	[FEAT_UPROBE_MULTI_LINK] = {
+		"BPF multi-uprobe link support", probe_uprobe_multi_link,
+	},
+};
+
+bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
+{
+	struct kern_feature_desc *feat = &feature_probes[feat_id];
+	int ret;
+
+	/* assume global feature cache, unless custom one is provided */
+	if (!cache)
+		cache = &feature_cache;
+
+	if (READ_ONCE(cache->res[feat_id]) == FEAT_UNKNOWN) {
+		ret = feat->probe();
+		if (ret > 0) {
+			WRITE_ONCE(cache->res[feat_id], FEAT_SUPPORTED);
+		} else if (ret == 0) {
+			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
+		} else {
+			pr_warn("Detection of kernel %s support failed: %d\n", feat->desc, ret);
+			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
+		}
+	}
+
+	return READ_ONCE(cache->res[feat_id]) == FEAT_SUPPORTED;
+}
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4bfc504815d5..5c441737db98 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4582,467 +4582,6 @@ bpf_object__probe_loading(struct bpf_object *obj)
 	return 0;
 }
 
-static int probe_fd(int fd)
-{
-	if (fd >= 0)
-		close(fd);
-	return fd >= 0;
-}
-
-static int probe_kern_prog_name(void)
-{
-	const size_t attr_sz = offsetofend(union bpf_attr, prog_name);
-	struct bpf_insn insns[] = {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	};
-	union bpf_attr attr;
-	int ret;
-
-	memset(&attr, 0, attr_sz);
-	attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
-	attr.license = ptr_to_u64("GPL");
-	attr.insns = ptr_to_u64(insns);
-	attr.insn_cnt = (__u32)ARRAY_SIZE(insns);
-	libbpf_strlcpy(attr.prog_name, "libbpf_nametest", sizeof(attr.prog_name));
-
-	/* make sure loading with name works */
-	ret = sys_bpf_prog_load(&attr, attr_sz, PROG_LOAD_ATTEMPTS);
-	return probe_fd(ret);
-}
-
-static int probe_kern_global_data(void)
-{
-	char *cp, errmsg[STRERR_BUFSIZE];
-	struct bpf_insn insns[] = {
-		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 16),
-		BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 42),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	};
-	int ret, map, insn_cnt = ARRAY_SIZE(insns);
-
-	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_global", sizeof(int), 32, 1, NULL);
-	if (map < 0) {
-		ret = -errno;
-		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
-		pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
-			__func__, cp, -ret);
-		return ret;
-	}
-
-	insns[0].imm = map;
-
-	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, NULL);
-	close(map);
-	return probe_fd(ret);
-}
-
-static int probe_kern_btf(void)
-{
-	static const char strs[] = "\0int";
-	__u32 types[] = {
-		/* int */
-		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
-	};
-
-	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
-}
-
-static int probe_kern_btf_func(void)
-{
-	static const char strs[] = "\0int\0x\0a";
-	/* void x(int a) {} */
-	__u32 types[] = {
-		/* int */
-		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
-		/* FUNC_PROTO */                                /* [2] */
-		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 1), 0),
-		BTF_PARAM_ENC(7, 1),
-		/* FUNC x */                                    /* [3] */
-		BTF_TYPE_ENC(5, BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0), 2),
-	};
-
-	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
-}
-
-static int probe_kern_btf_func_global(void)
-{
-	static const char strs[] = "\0int\0x\0a";
-	/* static void x(int a) {} */
-	__u32 types[] = {
-		/* int */
-		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
-		/* FUNC_PROTO */                                /* [2] */
-		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 1), 0),
-		BTF_PARAM_ENC(7, 1),
-		/* FUNC x BTF_FUNC_GLOBAL */                    /* [3] */
-		BTF_TYPE_ENC(5, BTF_INFO_ENC(BTF_KIND_FUNC, 0, BTF_FUNC_GLOBAL), 2),
-	};
-
-	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
-}
-
-static int probe_kern_btf_datasec(void)
-{
-	static const char strs[] = "\0x\0.data";
-	/* static int a; */
-	__u32 types[] = {
-		/* int */
-		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
-		/* VAR x */                                     /* [2] */
-		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
-		BTF_VAR_STATIC,
-		/* DATASEC val */                               /* [3] */
-		BTF_TYPE_ENC(3, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
-		BTF_VAR_SECINFO_ENC(2, 0, 4),
-	};
-
-	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
-}
-
-static int probe_kern_btf_float(void)
-{
-	static const char strs[] = "\0float";
-	__u32 types[] = {
-		/* float */
-		BTF_TYPE_FLOAT_ENC(1, 4),
-	};
-
-	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
-}
-
-static int probe_kern_btf_decl_tag(void)
-{
-	static const char strs[] = "\0tag";
-	__u32 types[] = {
-		/* int */
-		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
-		/* VAR x */                                     /* [2] */
-		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
-		BTF_VAR_STATIC,
-		/* attr */
-		BTF_TYPE_DECL_TAG_ENC(1, 2, -1),
-	};
-
-	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
-}
-
-static int probe_kern_btf_type_tag(void)
-{
-	static const char strs[] = "\0tag";
-	__u32 types[] = {
-		/* int */
-		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
-		/* attr */
-		BTF_TYPE_TYPE_TAG_ENC(1, 1),				/* [2] */
-		/* ptr */
-		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 2),	/* [3] */
-	};
-
-	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
-}
-
-static int probe_kern_array_mmap(void)
-{
-	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
-	int fd;
-
-	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_mmap", sizeof(int), sizeof(int), 1, &opts);
-	return probe_fd(fd);
-}
-
-static int probe_kern_exp_attach_type(void)
-{
-	LIBBPF_OPTS(bpf_prog_load_opts, opts, .expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE);
-	struct bpf_insn insns[] = {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	};
-	int fd, insn_cnt = ARRAY_SIZE(insns);
-
-	/* use any valid combination of program type and (optional)
-	 * non-zero expected attach type (i.e., not a BPF_CGROUP_INET_INGRESS)
-	 * to see if kernel supports expected_attach_type field for
-	 * BPF_PROG_LOAD command
-	 */
-	fd = bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCK, NULL, "GPL", insns, insn_cnt, &opts);
-	return probe_fd(fd);
-}
-
-static int probe_kern_probe_read_kernel(void)
-{
-	struct bpf_insn insns[] = {
-		BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),	/* r1 = r10 (fp) */
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),	/* r1 += -8 */
-		BPF_MOV64_IMM(BPF_REG_2, 8),		/* r2 = 8 */
-		BPF_MOV64_IMM(BPF_REG_3, 0),		/* r3 = 0 */
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_probe_read_kernel),
-		BPF_EXIT_INSN(),
-	};
-	int fd, insn_cnt = ARRAY_SIZE(insns);
-
-	fd = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, NULL);
-	return probe_fd(fd);
-}
-
-static int probe_prog_bind_map(void)
-{
-	char *cp, errmsg[STRERR_BUFSIZE];
-	struct bpf_insn insns[] = {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	};
-	int ret, map, prog, insn_cnt = ARRAY_SIZE(insns);
-
-	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_det_bind", sizeof(int), 32, 1, NULL);
-	if (map < 0) {
-		ret = -errno;
-		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
-		pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
-			__func__, cp, -ret);
-		return ret;
-	}
-
-	prog = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, NULL);
-	if (prog < 0) {
-		close(map);
-		return 0;
-	}
-
-	ret = bpf_prog_bind_map(prog, map, NULL);
-
-	close(map);
-	close(prog);
-
-	return ret >= 0;
-}
-
-static int probe_module_btf(void)
-{
-	static const char strs[] = "\0int";
-	__u32 types[] = {
-		/* int */
-		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
-	};
-	struct bpf_btf_info info;
-	__u32 len = sizeof(info);
-	char name[16];
-	int fd, err;
-
-	fd = libbpf__load_raw_btf((char *)types, sizeof(types), strs, sizeof(strs));
-	if (fd < 0)
-		return 0; /* BTF not supported at all */
-
-	memset(&info, 0, sizeof(info));
-	info.name = ptr_to_u64(name);
-	info.name_len = sizeof(name);
-
-	/* check that BPF_OBJ_GET_INFO_BY_FD supports specifying name pointer;
-	 * kernel's module BTF support coincides with support for
-	 * name/name_len fields in struct bpf_btf_info.
-	 */
-	err = bpf_btf_get_info_by_fd(fd, &info, &len);
-	close(fd);
-	return !err;
-}
-
-static int probe_perf_link(void)
-{
-	struct bpf_insn insns[] = {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	};
-	int prog_fd, link_fd, err;
-
-	prog_fd = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL",
-				insns, ARRAY_SIZE(insns), NULL);
-	if (prog_fd < 0)
-		return -errno;
-
-	/* use invalid perf_event FD to get EBADF, if link is supported;
-	 * otherwise EINVAL should be returned
-	 */
-	link_fd = bpf_link_create(prog_fd, -1, BPF_PERF_EVENT, NULL);
-	err = -errno; /* close() can clobber errno */
-
-	if (link_fd >= 0)
-		close(link_fd);
-	close(prog_fd);
-
-	return link_fd < 0 && err == -EBADF;
-}
-
-static int probe_uprobe_multi_link(void)
-{
-	LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
-		.expected_attach_type = BPF_TRACE_UPROBE_MULTI,
-	);
-	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
-	struct bpf_insn insns[] = {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	};
-	int prog_fd, link_fd, err;
-	unsigned long offset = 0;
-
-	prog_fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
-				insns, ARRAY_SIZE(insns), &load_opts);
-	if (prog_fd < 0)
-		return -errno;
-
-	/* Creating uprobe in '/' binary should fail with -EBADF. */
-	link_opts.uprobe_multi.path = "/";
-	link_opts.uprobe_multi.offsets = &offset;
-	link_opts.uprobe_multi.cnt = 1;
-
-	link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, &link_opts);
-	err = -errno; /* close() can clobber errno */
-
-	if (link_fd >= 0)
-		close(link_fd);
-	close(prog_fd);
-
-	return link_fd < 0 && err == -EBADF;
-}
-
-static int probe_kern_bpf_cookie(void)
-{
-	struct bpf_insn insns[] = {
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_attach_cookie),
-		BPF_EXIT_INSN(),
-	};
-	int ret, insn_cnt = ARRAY_SIZE(insns);
-
-	ret = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL", insns, insn_cnt, NULL);
-	return probe_fd(ret);
-}
-
-static int probe_kern_btf_enum64(void)
-{
-	static const char strs[] = "\0enum64";
-	__u32 types[] = {
-		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 0), 8),
-	};
-
-	return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
-					     strs, sizeof(strs)));
-}
-
-static int probe_kern_syscall_wrapper(void);
-
-enum kern_feature_result {
-	FEAT_UNKNOWN = 0,
-	FEAT_SUPPORTED = 1,
-	FEAT_MISSING = 2,
-};
-
-struct kern_feature_cache {
-	enum kern_feature_result res[__FEAT_CNT];
-};
-
-typedef int (*feature_probe_fn)(void);
-
-static struct kern_feature_cache feature_cache;
-
-static struct kern_feature_desc {
-	const char *desc;
-	feature_probe_fn probe;
-} feature_probes[__FEAT_CNT] = {
-	[FEAT_PROG_NAME] = {
-		"BPF program name", probe_kern_prog_name,
-	},
-	[FEAT_GLOBAL_DATA] = {
-		"global variables", probe_kern_global_data,
-	},
-	[FEAT_BTF] = {
-		"minimal BTF", probe_kern_btf,
-	},
-	[FEAT_BTF_FUNC] = {
-		"BTF functions", probe_kern_btf_func,
-	},
-	[FEAT_BTF_GLOBAL_FUNC] = {
-		"BTF global function", probe_kern_btf_func_global,
-	},
-	[FEAT_BTF_DATASEC] = {
-		"BTF data section and variable", probe_kern_btf_datasec,
-	},
-	[FEAT_ARRAY_MMAP] = {
-		"ARRAY map mmap()", probe_kern_array_mmap,
-	},
-	[FEAT_EXP_ATTACH_TYPE] = {
-		"BPF_PROG_LOAD expected_attach_type attribute",
-		probe_kern_exp_attach_type,
-	},
-	[FEAT_PROBE_READ_KERN] = {
-		"bpf_probe_read_kernel() helper", probe_kern_probe_read_kernel,
-	},
-	[FEAT_PROG_BIND_MAP] = {
-		"BPF_PROG_BIND_MAP support", probe_prog_bind_map,
-	},
-	[FEAT_MODULE_BTF] = {
-		"module BTF support", probe_module_btf,
-	},
-	[FEAT_BTF_FLOAT] = {
-		"BTF_KIND_FLOAT support", probe_kern_btf_float,
-	},
-	[FEAT_PERF_LINK] = {
-		"BPF perf link support", probe_perf_link,
-	},
-	[FEAT_BTF_DECL_TAG] = {
-		"BTF_KIND_DECL_TAG support", probe_kern_btf_decl_tag,
-	},
-	[FEAT_BTF_TYPE_TAG] = {
-		"BTF_KIND_TYPE_TAG support", probe_kern_btf_type_tag,
-	},
-	[FEAT_MEMCG_ACCOUNT] = {
-		"memcg-based memory accounting", probe_memcg_account,
-	},
-	[FEAT_BPF_COOKIE] = {
-		"BPF cookie support", probe_kern_bpf_cookie,
-	},
-	[FEAT_BTF_ENUM64] = {
-		"BTF_KIND_ENUM64 support", probe_kern_btf_enum64,
-	},
-	[FEAT_SYSCALL_WRAPPER] = {
-		"Kernel using syscall wrapper", probe_kern_syscall_wrapper,
-	},
-	[FEAT_UPROBE_MULTI_LINK] = {
-		"BPF multi-uprobe link support", probe_uprobe_multi_link,
-	},
-};
-
-bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
-{
-	struct kern_feature_desc *feat = &feature_probes[feat_id];
-	int ret;
-
-	/* assume global feature cache, unless custom one is provided */
-	if (!cache)
-		cache = &feature_cache;
-
-	if (READ_ONCE(cache->res[feat_id]) == FEAT_UNKNOWN) {
-		ret = feat->probe();
-		if (ret > 0) {
-			WRITE_ONCE(cache->res[feat_id], FEAT_SUPPORTED);
-		} else if (ret == 0) {
-			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
-		} else {
-			pr_warn("Detection of kernel %s support failed: %d\n", feat->desc, ret);
-			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
-		}
-	}
-
-	return READ_ONCE(cache->res[feat_id]) == FEAT_SUPPORTED;
-}
-
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
 {
 	if (obj && obj->gen_loader)
@@ -11046,7 +10585,7 @@ static const char *arch_specific_syscall_pfx(void)
 #endif
 }
 
-static int probe_kern_syscall_wrapper(void)
+int probe_kern_syscall_wrapper(void)
 {
 	char syscall_name[64];
 	const char *ksys_pfx;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 622892fc841d..fa25e1232bc8 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -361,10 +361,20 @@ enum kern_feature_id {
 	__FEAT_CNT,
 };
 
-struct kern_feature_cache;
+enum kern_feature_result {
+	FEAT_UNKNOWN = 0,
+	FEAT_SUPPORTED = 1,
+	FEAT_MISSING = 2,
+};
+
+struct kern_feature_cache {
+	enum kern_feature_result res[__FEAT_CNT];
+};
+
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id);
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id);
 
+int probe_kern_syscall_wrapper(void);
 int probe_memcg_account(void);
 int bump_rlimit_memlock(void);
 
@@ -626,4 +636,6 @@ int elf_resolve_syms_offsets(const char *binary_path, int cnt,
 int elf_resolve_pattern_offsets(const char *binary_path, const char *pattern,
 				 unsigned long **poffsets, size_t *pcnt);
 
+int probe_fd(int fd);
+
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
diff --git a/tools/lib/bpf/str_error.h b/tools/lib/bpf/str_error.h
index a139334d57b6..626d7ffb03d6 100644
--- a/tools/lib/bpf/str_error.h
+++ b/tools/lib/bpf/str_error.h
@@ -2,5 +2,8 @@
 #ifndef __LIBBPF_STR_ERROR_H
 #define __LIBBPF_STR_ERROR_H
 
+#define STRERR_BUFSIZE  128
+
 char *libbpf_strerror_r(int err, char *dst, int len);
+
 #endif /* __LIBBPF_STR_ERROR_H */
-- 
2.34.1


