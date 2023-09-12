Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DE979DAFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 23:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbjILVcU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 17:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjILVcU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:32:20 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B87810CA
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 14:32:16 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CKkLpq025424
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 14:32:15 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t2yak0e3q-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 14:32:15 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 12 Sep 2023 14:32:13 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 97A0037F4072A; Tue, 12 Sep 2023 14:29:25 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v4 bpf-next 08/12] libbpf: add bpf_token_create() API
Date:   Tue, 12 Sep 2023 14:29:02 -0700
Message-ID: <20230912212906.3975866-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912212906.3975866-1-andrii@kernel.org>
References: <20230912212906.3975866-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KdUXjMWp88BpDlPQJXsRSXjVS3qUz4LJ
X-Proofpoint-GUID: KdUXjMWp88BpDlPQJXsRSXjVS3qUz4LJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_20,2023-09-05_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add low-level wrapper API for BPF_TOKEN_CREATE command in bpf() syscall.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
 tools/lib/bpf/bpf.h      | 29 +++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 49 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index b0f1913763a3..593ff9ea120d 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1271,3 +1271,22 @@ int bpf_prog_bind_map(int prog_fd, int map_fd,
 	ret = sys_bpf(BPF_PROG_BIND_MAP, &attr, attr_sz);
 	return libbpf_err_errno(ret);
 }
+
+int bpf_token_create(int bpffs_path_fd, const char *bpffs_pathname,
+		     struct bpf_token_create_opts *opts)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, token_create);
+	union bpf_attr attr;
+	int fd;
+
+	if (!OPTS_VALID(opts, bpf_token_create_opts))
+		return libbpf_err(-EINVAL);
+
+	memset(&attr, 0, attr_sz);
+	attr.token_create.bpffs_path_fd = bpffs_path_fd;
+	attr.token_create.bpffs_pathname = ptr_to_u64(bpffs_pathname);
+	attr.token_create.flags = OPTS_GET(opts, flags, 0);
+
+	fd = sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);
+	return libbpf_err_errno(fd);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 74c2887cfd24..16d5c257066c 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -635,6 +635,35 @@ struct bpf_test_run_opts {
 LIBBPF_API int bpf_prog_test_run_opts(int prog_fd,
 				      struct bpf_test_run_opts *opts);
 
+struct bpf_token_create_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u32 flags;
+	size_t :0;
+};
+#define bpf_token_create_opts__last_field flags
+
+/**
+ * @brief **bpf_token_create()** creates a new instance of BPF token, pinning
+ * it at the specified location in BPF FS.
+ *
+ * BPF token created and pinned with this API can be subsequently opened using
+ * bpf_obj_get() API to obtain FD that can be passed to bpf() syscall for
+ * commands like BPF_PROG_LOAD, BPF_MAP_CREATE, etc.
+ *
+ * @param pin_path_fd O_PATH FD (see man 2 openat() for semantics) specifying,
+ * in combination with *pin_pathname*, target location in BPF FS at which to
+ * create and pin BPF token.
+ * @param pin_pathname absolute or relative path specifying, in combination
+ * with *pin_path_fd*, specifying in combination with *pin_path_fd*, target
+ * location in BPF FS at which to create and pin BPF token.
+ * @param opts optional BPF token creation options, can be NULL
+ *
+ * @return 0, on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_token_create(int bpffs_path_fd, const char *bpffs_pathname,
+				struct bpf_token_create_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 57712321490f..c45c28a5e14c 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -400,4 +400,5 @@ LIBBPF_1.3.0 {
 		bpf_program__attach_netfilter;
 		bpf_program__attach_tcx;
 		bpf_program__attach_uprobe_multi;
+		bpf_token_create;
 } LIBBPF_1.2.0;
-- 
2.34.1

