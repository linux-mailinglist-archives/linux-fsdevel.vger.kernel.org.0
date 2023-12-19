Return-Path: <linux-fsdevel+bounces-6476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 597F481810B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 06:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0708285F55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 05:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB4D7472;
	Tue, 19 Dec 2023 05:34:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516557479
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIMLREO013077
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Dec 2023 21:34:33 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3v2xt1t6bu-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Dec 2023 21:34:33 -0800
Received: from twshared20528.39.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 18 Dec 2023 21:34:30 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 469243D698443; Mon, 18 Dec 2023 21:31:50 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <brauner@kernel.org>,
        <torvalds@linuxfoundation.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>
CC: <linux-fsdevel@vger.kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next] bpf: add BPF_F_TOKEN_FD flag to pass with BPF token FD
Date: Mon, 18 Dec 2023 21:31:50 -0800
Message-ID: <20231219053150.336991-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: hDK5KjVgPGtM3UGqn8t6LesUgKig5vAs
X-Proofpoint-ORIG-GUID: hDK5KjVgPGtM3UGqn8t6LesUgKig5vAs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_02,2023-12-14_01,2023-05-22_02

Add BPF_F_TOKEN_FD flag to be used across bpf() syscall commands
that accept BPF token FD: BPF_PROG_LOAD, BPF_MAP_CREATE, and
BPF_BTF_LOAD. This flag has to be set whenever token FD is provided.

BPF_BTF_LOAD command didn't have a flags field, so add it as well.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/uapi/linux/bpf.h       | 10 +++++++---
 kernel/bpf/syscall.c           | 19 +++++++++++++++----
 tools/include/uapi/linux/bpf.h | 10 +++++++---
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e0545201b55f..539dc19d8d11 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1364,6 +1364,9 @@ enum {
=20
 /* Get path from provided FD in BPF_OBJ_PIN/BPF_OBJ_GET commands */
 	BPF_F_PATH_FD		=3D (1U << 14),
+
+/* BPF token FD is passed in a corresponding command's token_fd field */
+	BPF_F_TOKEN_FD		=3D (1U << 15),
 };
=20
 /* Flags for BPF_PROG_QUERY. */
@@ -1437,7 +1440,7 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
-		__u32	map_token_fd;
+		__s32	map_token_fd;
 	};
=20
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
@@ -1507,7 +1510,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		log_true_size;
-		__u32		prog_token_fd;
+		__s32		prog_token_fd;
 	};
=20
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
@@ -1620,7 +1623,8 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		btf_log_true_size;
-		__u32		btf_token_fd;
+		__u32		btf_flags;
+		__s32		btf_token_fd;
 	};
=20
 	struct {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8faa1a20edf8..d6337842006d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1137,6 +1137,7 @@ static int map_create(union bpf_attr *attr)
 	int numa_node =3D bpf_map_attr_numa_node(attr);
 	u32 map_type =3D attr->map_type;
 	struct bpf_map *map;
+	bool token_flag;
 	int f_flags;
 	int err;
=20
@@ -1144,6 +1145,12 @@ static int map_create(union bpf_attr *attr)
 	if (err)
 		return -EINVAL;
=20
+	/* check BPF_F_TOKEN_FD flag, remember if it's set, and then clear it
+	 * to avoid per-map type checks tripping on unknown flag
+	 */
+	token_flag =3D attr->map_flags & BPF_F_TOKEN_FD;
+	attr->map_flags &=3D ~BPF_F_TOKEN_FD;
+
 	if (attr->btf_vmlinux_value_type_id) {
 		if (attr->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS ||
 		    attr->btf_key_type_id || attr->btf_value_type_id)
@@ -1184,7 +1191,7 @@ static int map_create(union bpf_attr *attr)
 	if (!ops->map_mem_usage)
 		return -EINVAL;
=20
-	if (attr->map_token_fd) {
+	if (token_flag) {
 		token =3D bpf_token_get_from_fd(attr->map_token_fd);
 		if (IS_ERR(token))
 			return PTR_ERR(token);
@@ -2641,12 +2648,13 @@ static int bpf_prog_load(union bpf_attr *attr, bp=
fptr_t uattr, u32 uattr_size)
 				 BPF_F_TEST_RND_HI32 |
 				 BPF_F_XDP_HAS_FRAGS |
 				 BPF_F_XDP_DEV_BOUND_ONLY |
-				 BPF_F_TEST_REG_INVARIANTS))
+				 BPF_F_TEST_REG_INVARIANTS |
+				 BPF_F_TOKEN_FD))
 		return -EINVAL;
=20
 	bpf_prog_load_fixup_attach_type(attr);
=20
-	if (attr->prog_token_fd) {
+	if (attr->prog_flags & BPF_F_TOKEN_FD) {
 		token =3D bpf_token_get_from_fd(attr->prog_token_fd);
 		if (IS_ERR(token))
 			return PTR_ERR(token);
@@ -4837,7 +4845,10 @@ static int bpf_btf_load(const union bpf_attr *attr=
, bpfptr_t uattr, __u32 uattr_
 	if (CHECK_ATTR(BPF_BTF_LOAD))
 		return -EINVAL;
=20
-	if (attr->btf_token_fd) {
+	if (attr->btf_flags & ~BPF_F_TOKEN_FD)
+		return -EINVAL;
+
+	if (attr->btf_flags & BPF_F_TOKEN_FD) {
 		token =3D bpf_token_get_from_fd(attr->btf_token_fd);
 		if (IS_ERR(token))
 			return PTR_ERR(token);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index e0545201b55f..539dc19d8d11 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1364,6 +1364,9 @@ enum {
=20
 /* Get path from provided FD in BPF_OBJ_PIN/BPF_OBJ_GET commands */
 	BPF_F_PATH_FD		=3D (1U << 14),
+
+/* BPF token FD is passed in a corresponding command's token_fd field */
+	BPF_F_TOKEN_FD		=3D (1U << 15),
 };
=20
 /* Flags for BPF_PROG_QUERY. */
@@ -1437,7 +1440,7 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
-		__u32	map_token_fd;
+		__s32	map_token_fd;
 	};
=20
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
@@ -1507,7 +1510,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		log_true_size;
-		__u32		prog_token_fd;
+		__s32		prog_token_fd;
 	};
=20
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
@@ -1620,7 +1623,8 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		btf_log_true_size;
-		__u32		btf_token_fd;
+		__u32		btf_flags;
+		__s32		btf_token_fd;
 	};
=20
 	struct {
--=20
2.34.1


