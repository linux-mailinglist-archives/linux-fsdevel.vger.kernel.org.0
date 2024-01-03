Return-Path: <linux-fsdevel+bounces-7300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E29823813
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928931F26DEE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0113521355;
	Wed,  3 Jan 2024 22:24:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943CF21347
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403GiJDc027429
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Jan 2024 14:24:04 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vcxn2ppcw-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:24:01 -0800
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 14:23:40 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id DE8533DF9EBB0; Wed,  3 Jan 2024 14:21:27 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>, <torvalds@linuxfoundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next 23/29] libbpf: move feature detection code into its own file
Date: Wed, 3 Jan 2024 14:20:28 -0800
Message-ID: <20240103222034.2582628-24-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103222034.2582628-1-andrii@kernel.org>
References: <20240103222034.2582628-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5hAAIMqXZliNruT3uZonCKq0PWtPdaXo
X-Proofpoint-GUID: 5hAAIMqXZliNruT3uZonCKq0PWtPdaXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02

It's quite a lot of well isolated code, so it seems like a good
candidate to move it out of libbpf.c to reduce its size.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/Build             |   2 +-
 tools/lib/bpf/elf.c             |   2 -
 tools/lib/bpf/features.c        | 463 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          | 463 +-------------------------------
 tools/lib/bpf/libbpf_internal.h |  12 +-
 tools/lib/bpf/str_error.h       |   3 +
 6 files changed, 479 insertions(+), 466 deletions(-)
 create mode 100644 tools/lib/bpf/features.c

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index 2d0c282c8588..b6619199a706 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1,4 +1,4 @@
 libbpf-y :=3D libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
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
=20
-#define STRERR_BUFSIZE  128
-
 /* A SHT_GNU_versym section holds 16-bit words. This bit is set if
  * the symbol is hidden and can only be seen when referenced using an
  * explicit version number. This is a GNU extension.
diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
new file mode 100644
index 000000000000..338fd0dcd3bd
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
+static int probe_fd(int fd)
+{
+	if (fd >=3D 0)
+		close(fd);
+	return fd >=3D 0;
+}
+
+static int probe_kern_prog_name(void)
+{
+	const size_t attr_sz =3D offsetofend(union bpf_attr, prog_name);
+	struct bpf_insn insns[] =3D {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	union bpf_attr attr;
+	int ret;
+
+	memset(&attr, 0, attr_sz);
+	attr.prog_type =3D BPF_PROG_TYPE_SOCKET_FILTER;
+	attr.license =3D ptr_to_u64("GPL");
+	attr.insns =3D ptr_to_u64(insns);
+	attr.insn_cnt =3D (__u32)ARRAY_SIZE(insns);
+	libbpf_strlcpy(attr.prog_name, "libbpf_nametest", sizeof(attr.prog_name=
));
+
+	/* make sure loading with name works */
+	ret =3D sys_bpf_prog_load(&attr, attr_sz, PROG_LOAD_ATTEMPTS);
+	return probe_fd(ret);
+}
+
+static int probe_kern_global_data(void)
+{
+	char *cp, errmsg[STRERR_BUFSIZE];
+	struct bpf_insn insns[] =3D {
+		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 16),
+		BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 42),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int ret, map, insn_cnt =3D ARRAY_SIZE(insns);
+
+	map =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_global", sizeof(int)=
, 32, 1, NULL);
+	if (map < 0) {
+		ret =3D -errno;
+		cp =3D libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
+		pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
+			__func__, cp, -ret);
+		return ret;
+	}
+
+	insns[0].imm =3D map;
+
+	ret =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, =
insn_cnt, NULL);
+	close(map);
+	return probe_fd(ret);
+}
+
+static int probe_kern_btf(void)
+{
+	static const char strs[] =3D "\0int";
+	__u32 types[] =3D {
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
+	static const char strs[] =3D "\0int\0x\0a";
+	/* void x(int a) {} */
+	__u32 types[] =3D {
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
+	static const char strs[] =3D "\0int\0x\0a";
+	/* static void x(int a) {} */
+	__u32 types[] =3D {
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
+	static const char strs[] =3D "\0x\0.data";
+	/* static int a; */
+	__u32 types[] =3D {
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
+	static const char strs[] =3D "\0float";
+	__u32 types[] =3D {
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
+	static const char strs[] =3D "\0tag";
+	__u32 types[] =3D {
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
+	static const char strs[] =3D "\0tag";
+	__u32 types[] =3D {
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
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags =3D BPF_F_MMAPABLE);
+	int fd;
+
+	fd =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_mmap", sizeof(int), s=
izeof(int), 1, &opts);
+	return probe_fd(fd);
+}
+
+static int probe_kern_exp_attach_type(void)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts, .expected_attach_type =3D BPF_CGR=
OUP_INET_SOCK_CREATE);
+	struct bpf_insn insns[] =3D {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int fd, insn_cnt =3D ARRAY_SIZE(insns);
+
+	/* use any valid combination of program type and (optional)
+	 * non-zero expected attach type (i.e., not a BPF_CGROUP_INET_INGRESS)
+	 * to see if kernel supports expected_attach_type field for
+	 * BPF_PROG_LOAD command
+	 */
+	fd =3D bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCK, NULL, "GPL", insns, ins=
n_cnt, &opts);
+	return probe_fd(fd);
+}
+
+static int probe_kern_probe_read_kernel(void)
+{
+	struct bpf_insn insns[] =3D {
+		BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),	/* r1 =3D r10 (fp) */
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),	/* r1 +=3D -8 */
+		BPF_MOV64_IMM(BPF_REG_2, 8),		/* r2 =3D 8 */
+		BPF_MOV64_IMM(BPF_REG_3, 0),		/* r3 =3D 0 */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_probe_read_kernel),
+		BPF_EXIT_INSN(),
+	};
+	int fd, insn_cnt =3D ARRAY_SIZE(insns);
+
+	fd =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn=
_cnt, NULL);
+	return probe_fd(fd);
+}
+
+static int probe_prog_bind_map(void)
+{
+	char *cp, errmsg[STRERR_BUFSIZE];
+	struct bpf_insn insns[] =3D {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int ret, map, prog, insn_cnt =3D ARRAY_SIZE(insns);
+
+	map =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_det_bind", sizeof(in=
t), 32, 1, NULL);
+	if (map < 0) {
+		ret =3D -errno;
+		cp =3D libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
+		pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
+			__func__, cp, -ret);
+		return ret;
+	}
+
+	prog =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns,=
 insn_cnt, NULL);
+	if (prog < 0) {
+		close(map);
+		return 0;
+	}
+
+	ret =3D bpf_prog_bind_map(prog, map, NULL);
+
+	close(map);
+	close(prog);
+
+	return ret >=3D 0;
+}
+
+static int probe_module_btf(void)
+{
+	static const char strs[] =3D "\0int";
+	__u32 types[] =3D {
+		/* int */
+		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
+	};
+	struct bpf_btf_info info;
+	__u32 len =3D sizeof(info);
+	char name[16];
+	int fd, err;
+
+	fd =3D libbpf__load_raw_btf((char *)types, sizeof(types), strs, sizeof(=
strs));
+	if (fd < 0)
+		return 0; /* BTF not supported at all */
+
+	memset(&info, 0, sizeof(info));
+	info.name =3D ptr_to_u64(name);
+	info.name_len =3D sizeof(name);
+
+	/* check that BPF_OBJ_GET_INFO_BY_FD supports specifying name pointer;
+	 * kernel's module BTF support coincides with support for
+	 * name/name_len fields in struct bpf_btf_info.
+	 */
+	err =3D bpf_btf_get_info_by_fd(fd, &info, &len);
+	close(fd);
+	return !err;
+}
+
+static int probe_perf_link(void)
+{
+	struct bpf_insn insns[] =3D {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd, link_fd, err;
+
+	prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL",
+				insns, ARRAY_SIZE(insns), NULL);
+	if (prog_fd < 0)
+		return -errno;
+
+	/* use invalid perf_event FD to get EBADF, if link is supported;
+	 * otherwise EINVAL should be returned
+	 */
+	link_fd =3D bpf_link_create(prog_fd, -1, BPF_PERF_EVENT, NULL);
+	err =3D -errno; /* close() can clobber errno */
+
+	if (link_fd >=3D 0)
+		close(link_fd);
+	close(prog_fd);
+
+	return link_fd < 0 && err =3D=3D -EBADF;
+}
+
+static int probe_uprobe_multi_link(void)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
+		.expected_attach_type =3D BPF_TRACE_UPROBE_MULTI,
+	);
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
+	struct bpf_insn insns[] =3D {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd, link_fd, err;
+	unsigned long offset =3D 0;
+
+	prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
+				insns, ARRAY_SIZE(insns), &load_opts);
+	if (prog_fd < 0)
+		return -errno;
+
+	/* Creating uprobe in '/' binary should fail with -EBADF. */
+	link_opts.uprobe_multi.path =3D "/";
+	link_opts.uprobe_multi.offsets =3D &offset;
+	link_opts.uprobe_multi.cnt =3D 1;
+
+	link_fd =3D bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, &link_=
opts);
+	err =3D -errno; /* close() can clobber errno */
+
+	if (link_fd >=3D 0)
+		close(link_fd);
+	close(prog_fd);
+
+	return link_fd < 0 && err =3D=3D -EBADF;
+}
+
+static int probe_kern_bpf_cookie(void)
+{
+	struct bpf_insn insns[] =3D {
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_attach_cookie),
+		BPF_EXIT_INSN(),
+	};
+	int ret, insn_cnt =3D ARRAY_SIZE(insns);
+
+	ret =3D bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL", insns, insn_cn=
t, NULL);
+	return probe_fd(ret);
+}
+
+static int probe_kern_btf_enum64(void)
+{
+	static const char strs[] =3D "\0enum64";
+	__u32 types[] =3D {
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
+} feature_probes[__FEAT_CNT] =3D {
+	[FEAT_PROG_NAME] =3D {
+		"BPF program name", probe_kern_prog_name,
+	},
+	[FEAT_GLOBAL_DATA] =3D {
+		"global variables", probe_kern_global_data,
+	},
+	[FEAT_BTF] =3D {
+		"minimal BTF", probe_kern_btf,
+	},
+	[FEAT_BTF_FUNC] =3D {
+		"BTF functions", probe_kern_btf_func,
+	},
+	[FEAT_BTF_GLOBAL_FUNC] =3D {
+		"BTF global function", probe_kern_btf_func_global,
+	},
+	[FEAT_BTF_DATASEC] =3D {
+		"BTF data section and variable", probe_kern_btf_datasec,
+	},
+	[FEAT_ARRAY_MMAP] =3D {
+		"ARRAY map mmap()", probe_kern_array_mmap,
+	},
+	[FEAT_EXP_ATTACH_TYPE] =3D {
+		"BPF_PROG_LOAD expected_attach_type attribute",
+		probe_kern_exp_attach_type,
+	},
+	[FEAT_PROBE_READ_KERN] =3D {
+		"bpf_probe_read_kernel() helper", probe_kern_probe_read_kernel,
+	},
+	[FEAT_PROG_BIND_MAP] =3D {
+		"BPF_PROG_BIND_MAP support", probe_prog_bind_map,
+	},
+	[FEAT_MODULE_BTF] =3D {
+		"module BTF support", probe_module_btf,
+	},
+	[FEAT_BTF_FLOAT] =3D {
+		"BTF_KIND_FLOAT support", probe_kern_btf_float,
+	},
+	[FEAT_PERF_LINK] =3D {
+		"BPF perf link support", probe_perf_link,
+	},
+	[FEAT_BTF_DECL_TAG] =3D {
+		"BTF_KIND_DECL_TAG support", probe_kern_btf_decl_tag,
+	},
+	[FEAT_BTF_TYPE_TAG] =3D {
+		"BTF_KIND_TYPE_TAG support", probe_kern_btf_type_tag,
+	},
+	[FEAT_MEMCG_ACCOUNT] =3D {
+		"memcg-based memory accounting", probe_memcg_account,
+	},
+	[FEAT_BPF_COOKIE] =3D {
+		"BPF cookie support", probe_kern_bpf_cookie,
+	},
+	[FEAT_BTF_ENUM64] =3D {
+		"BTF_KIND_ENUM64 support", probe_kern_btf_enum64,
+	},
+	[FEAT_SYSCALL_WRAPPER] =3D {
+		"Kernel using syscall wrapper", probe_kern_syscall_wrapper,
+	},
+	[FEAT_UPROBE_MULTI_LINK] =3D {
+		"BPF multi-uprobe link support", probe_uprobe_multi_link,
+	},
+};
+
+bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id)
+{
+	struct kern_feature_desc *feat =3D &feature_probes[feat_id];
+	int ret;
+
+	/* assume global feature cache, unless custom one is provided */
+	if (!cache)
+		cache =3D &feature_cache;
+
+	if (READ_ONCE(cache->res[feat_id]) =3D=3D FEAT_UNKNOWN) {
+		ret =3D feat->probe();
+		if (ret > 0) {
+			WRITE_ONCE(cache->res[feat_id], FEAT_SUPPORTED);
+		} else if (ret =3D=3D 0) {
+			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
+		} else {
+			pr_warn("Detection of kernel %s support failed: %d\n", feat->desc, re=
t);
+			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
+		}
+	}
+
+	return READ_ONCE(cache->res[feat_id]) =3D=3D FEAT_SUPPORTED;
+}
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index aea40c42b90e..8e70532420a3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4639,467 +4639,6 @@ bpf_object__probe_loading(struct bpf_object *obj)
 	return 0;
 }
=20
-static int probe_fd(int fd)
-{
-	if (fd >=3D 0)
-		close(fd);
-	return fd >=3D 0;
-}
-
-static int probe_kern_prog_name(void)
-{
-	const size_t attr_sz =3D offsetofend(union bpf_attr, prog_name);
-	struct bpf_insn insns[] =3D {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	};
-	union bpf_attr attr;
-	int ret;
-
-	memset(&attr, 0, attr_sz);
-	attr.prog_type =3D BPF_PROG_TYPE_SOCKET_FILTER;
-	attr.license =3D ptr_to_u64("GPL");
-	attr.insns =3D ptr_to_u64(insns);
-	attr.insn_cnt =3D (__u32)ARRAY_SIZE(insns);
-	libbpf_strlcpy(attr.prog_name, "libbpf_nametest", sizeof(attr.prog_name=
));
-
-	/* make sure loading with name works */
-	ret =3D sys_bpf_prog_load(&attr, attr_sz, PROG_LOAD_ATTEMPTS);
-	return probe_fd(ret);
-}
-
-static int probe_kern_global_data(void)
-{
-	char *cp, errmsg[STRERR_BUFSIZE];
-	struct bpf_insn insns[] =3D {
-		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 16),
-		BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 42),
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	};
-	int ret, map, insn_cnt =3D ARRAY_SIZE(insns);
-
-	map =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_global", sizeof(int)=
, 32, 1, NULL);
-	if (map < 0) {
-		ret =3D -errno;
-		cp =3D libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
-		pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
-			__func__, cp, -ret);
-		return ret;
-	}
-
-	insns[0].imm =3D map;
-
-	ret =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, =
insn_cnt, NULL);
-	close(map);
-	return probe_fd(ret);
-}
-
-static int probe_kern_btf(void)
-{
-	static const char strs[] =3D "\0int";
-	__u32 types[] =3D {
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
-	static const char strs[] =3D "\0int\0x\0a";
-	/* void x(int a) {} */
-	__u32 types[] =3D {
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
-	static const char strs[] =3D "\0int\0x\0a";
-	/* static void x(int a) {} */
-	__u32 types[] =3D {
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
-	static const char strs[] =3D "\0x\0.data";
-	/* static int a; */
-	__u32 types[] =3D {
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
-	static const char strs[] =3D "\0float";
-	__u32 types[] =3D {
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
-	static const char strs[] =3D "\0tag";
-	__u32 types[] =3D {
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
-	static const char strs[] =3D "\0tag";
-	__u32 types[] =3D {
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
-	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags =3D BPF_F_MMAPABLE);
-	int fd;
-
-	fd =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_mmap", sizeof(int), s=
izeof(int), 1, &opts);
-	return probe_fd(fd);
-}
-
-static int probe_kern_exp_attach_type(void)
-{
-	LIBBPF_OPTS(bpf_prog_load_opts, opts, .expected_attach_type =3D BPF_CGR=
OUP_INET_SOCK_CREATE);
-	struct bpf_insn insns[] =3D {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	};
-	int fd, insn_cnt =3D ARRAY_SIZE(insns);
-
-	/* use any valid combination of program type and (optional)
-	 * non-zero expected attach type (i.e., not a BPF_CGROUP_INET_INGRESS)
-	 * to see if kernel supports expected_attach_type field for
-	 * BPF_PROG_LOAD command
-	 */
-	fd =3D bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCK, NULL, "GPL", insns, ins=
n_cnt, &opts);
-	return probe_fd(fd);
-}
-
-static int probe_kern_probe_read_kernel(void)
-{
-	struct bpf_insn insns[] =3D {
-		BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),	/* r1 =3D r10 (fp) */
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),	/* r1 +=3D -8 */
-		BPF_MOV64_IMM(BPF_REG_2, 8),		/* r2 =3D 8 */
-		BPF_MOV64_IMM(BPF_REG_3, 0),		/* r3 =3D 0 */
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_probe_read_kernel),
-		BPF_EXIT_INSN(),
-	};
-	int fd, insn_cnt =3D ARRAY_SIZE(insns);
-
-	fd =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn=
_cnt, NULL);
-	return probe_fd(fd);
-}
-
-static int probe_prog_bind_map(void)
-{
-	char *cp, errmsg[STRERR_BUFSIZE];
-	struct bpf_insn insns[] =3D {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	};
-	int ret, map, prog, insn_cnt =3D ARRAY_SIZE(insns);
-
-	map =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_det_bind", sizeof(in=
t), 32, 1, NULL);
-	if (map < 0) {
-		ret =3D -errno;
-		cp =3D libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
-		pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
-			__func__, cp, -ret);
-		return ret;
-	}
-
-	prog =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns,=
 insn_cnt, NULL);
-	if (prog < 0) {
-		close(map);
-		return 0;
-	}
-
-	ret =3D bpf_prog_bind_map(prog, map, NULL);
-
-	close(map);
-	close(prog);
-
-	return ret >=3D 0;
-}
-
-static int probe_module_btf(void)
-{
-	static const char strs[] =3D "\0int";
-	__u32 types[] =3D {
-		/* int */
-		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
-	};
-	struct bpf_btf_info info;
-	__u32 len =3D sizeof(info);
-	char name[16];
-	int fd, err;
-
-	fd =3D libbpf__load_raw_btf((char *)types, sizeof(types), strs, sizeof(=
strs));
-	if (fd < 0)
-		return 0; /* BTF not supported at all */
-
-	memset(&info, 0, sizeof(info));
-	info.name =3D ptr_to_u64(name);
-	info.name_len =3D sizeof(name);
-
-	/* check that BPF_OBJ_GET_INFO_BY_FD supports specifying name pointer;
-	 * kernel's module BTF support coincides with support for
-	 * name/name_len fields in struct bpf_btf_info.
-	 */
-	err =3D bpf_btf_get_info_by_fd(fd, &info, &len);
-	close(fd);
-	return !err;
-}
-
-static int probe_perf_link(void)
-{
-	struct bpf_insn insns[] =3D {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	};
-	int prog_fd, link_fd, err;
-
-	prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL",
-				insns, ARRAY_SIZE(insns), NULL);
-	if (prog_fd < 0)
-		return -errno;
-
-	/* use invalid perf_event FD to get EBADF, if link is supported;
-	 * otherwise EINVAL should be returned
-	 */
-	link_fd =3D bpf_link_create(prog_fd, -1, BPF_PERF_EVENT, NULL);
-	err =3D -errno; /* close() can clobber errno */
-
-	if (link_fd >=3D 0)
-		close(link_fd);
-	close(prog_fd);
-
-	return link_fd < 0 && err =3D=3D -EBADF;
-}
-
-static int probe_uprobe_multi_link(void)
-{
-	LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
-		.expected_attach_type =3D BPF_TRACE_UPROBE_MULTI,
-	);
-	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
-	struct bpf_insn insns[] =3D {
-		BPF_MOV64_IMM(BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	};
-	int prog_fd, link_fd, err;
-	unsigned long offset =3D 0;
-
-	prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
-				insns, ARRAY_SIZE(insns), &load_opts);
-	if (prog_fd < 0)
-		return -errno;
-
-	/* Creating uprobe in '/' binary should fail with -EBADF. */
-	link_opts.uprobe_multi.path =3D "/";
-	link_opts.uprobe_multi.offsets =3D &offset;
-	link_opts.uprobe_multi.cnt =3D 1;
-
-	link_fd =3D bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, &link_=
opts);
-	err =3D -errno; /* close() can clobber errno */
-
-	if (link_fd >=3D 0)
-		close(link_fd);
-	close(prog_fd);
-
-	return link_fd < 0 && err =3D=3D -EBADF;
-}
-
-static int probe_kern_bpf_cookie(void)
-{
-	struct bpf_insn insns[] =3D {
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_attach_cookie),
-		BPF_EXIT_INSN(),
-	};
-	int ret, insn_cnt =3D ARRAY_SIZE(insns);
-
-	ret =3D bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL", insns, insn_cn=
t, NULL);
-	return probe_fd(ret);
-}
-
-static int probe_kern_btf_enum64(void)
-{
-	static const char strs[] =3D "\0enum64";
-	__u32 types[] =3D {
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
-	FEAT_UNKNOWN =3D 0,
-	FEAT_SUPPORTED =3D 1,
-	FEAT_MISSING =3D 2,
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
-} feature_probes[__FEAT_CNT] =3D {
-	[FEAT_PROG_NAME] =3D {
-		"BPF program name", probe_kern_prog_name,
-	},
-	[FEAT_GLOBAL_DATA] =3D {
-		"global variables", probe_kern_global_data,
-	},
-	[FEAT_BTF] =3D {
-		"minimal BTF", probe_kern_btf,
-	},
-	[FEAT_BTF_FUNC] =3D {
-		"BTF functions", probe_kern_btf_func,
-	},
-	[FEAT_BTF_GLOBAL_FUNC] =3D {
-		"BTF global function", probe_kern_btf_func_global,
-	},
-	[FEAT_BTF_DATASEC] =3D {
-		"BTF data section and variable", probe_kern_btf_datasec,
-	},
-	[FEAT_ARRAY_MMAP] =3D {
-		"ARRAY map mmap()", probe_kern_array_mmap,
-	},
-	[FEAT_EXP_ATTACH_TYPE] =3D {
-		"BPF_PROG_LOAD expected_attach_type attribute",
-		probe_kern_exp_attach_type,
-	},
-	[FEAT_PROBE_READ_KERN] =3D {
-		"bpf_probe_read_kernel() helper", probe_kern_probe_read_kernel,
-	},
-	[FEAT_PROG_BIND_MAP] =3D {
-		"BPF_PROG_BIND_MAP support", probe_prog_bind_map,
-	},
-	[FEAT_MODULE_BTF] =3D {
-		"module BTF support", probe_module_btf,
-	},
-	[FEAT_BTF_FLOAT] =3D {
-		"BTF_KIND_FLOAT support", probe_kern_btf_float,
-	},
-	[FEAT_PERF_LINK] =3D {
-		"BPF perf link support", probe_perf_link,
-	},
-	[FEAT_BTF_DECL_TAG] =3D {
-		"BTF_KIND_DECL_TAG support", probe_kern_btf_decl_tag,
-	},
-	[FEAT_BTF_TYPE_TAG] =3D {
-		"BTF_KIND_TYPE_TAG support", probe_kern_btf_type_tag,
-	},
-	[FEAT_MEMCG_ACCOUNT] =3D {
-		"memcg-based memory accounting", probe_memcg_account,
-	},
-	[FEAT_BPF_COOKIE] =3D {
-		"BPF cookie support", probe_kern_bpf_cookie,
-	},
-	[FEAT_BTF_ENUM64] =3D {
-		"BTF_KIND_ENUM64 support", probe_kern_btf_enum64,
-	},
-	[FEAT_SYSCALL_WRAPPER] =3D {
-		"Kernel using syscall wrapper", probe_kern_syscall_wrapper,
-	},
-	[FEAT_UPROBE_MULTI_LINK] =3D {
-		"BPF multi-uprobe link support", probe_uprobe_multi_link,
-	},
-};
-
-bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id)
-{
-	struct kern_feature_desc *feat =3D &feature_probes[feat_id];
-	int ret;
-
-	/* assume global feature cache, unless custom one is provided */
-	if (!cache)
-		cache =3D &feature_cache;
-
-	if (READ_ONCE(cache->res[feat_id]) =3D=3D FEAT_UNKNOWN) {
-		ret =3D feat->probe();
-		if (ret > 0) {
-			WRITE_ONCE(cache->res[feat_id], FEAT_SUPPORTED);
-		} else if (ret =3D=3D 0) {
-			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
-		} else {
-			pr_warn("Detection of kernel %s support failed: %d\n", feat->desc, re=
t);
-			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
-		}
-	}
-
-	return READ_ONCE(cache->res[feat_id]) =3D=3D FEAT_SUPPORTED;
-}
-
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id =
feat_id)
 {
 	if (obj && obj->gen_loader)
@@ -10628,7 +10167,7 @@ static const char *arch_specific_syscall_pfx(void=
)
 #endif
 }
=20
-static int probe_kern_syscall_wrapper(void)
+int probe_kern_syscall_wrapper(void)
 {
 	char syscall_name[64];
 	const char *ksys_pfx;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index 754a432335e4..db4a499c0ec5 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -360,10 +360,20 @@ enum kern_feature_id {
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
+};
+
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id);
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id =
feat_id);
=20
+int probe_kern_syscall_wrapper(void);
 int probe_memcg_account(void);
 int bump_rlimit_memlock(void);
=20
diff --git a/tools/lib/bpf/str_error.h b/tools/lib/bpf/str_error.h
index a139334d57b6..626d7ffb03d6 100644
--- a/tools/lib/bpf/str_error.h
+++ b/tools/lib/bpf/str_error.h
@@ -2,5 +2,8 @@
 #ifndef __LIBBPF_STR_ERROR_H
 #define __LIBBPF_STR_ERROR_H
=20
+#define STRERR_BUFSIZE  128
+
 char *libbpf_strerror_r(int err, char *dst, int len);
+
 #endif /* __LIBBPF_STR_ERROR_H */
--=20
2.34.1


