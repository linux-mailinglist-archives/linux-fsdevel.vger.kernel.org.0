Return-Path: <linux-fsdevel+bounces-5280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8736680960A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6851F212B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4945730A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:58:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65649171F
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 14:28:20 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7GsOs6024915
	for <linux-fsdevel@vger.kernel.org>; Thu, 7 Dec 2023 14:28:20 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uu4htqkav-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 14:28:19 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 7 Dec 2023 14:28:10 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 9EF3F3CC5457C; Thu,  7 Dec 2023 14:27:57 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH RFC bpf-next 1/3] bpf: add mapper macro for bpf_cmd enum
Date: Thu, 7 Dec 2023 14:27:53 -0800
Message-ID: <20231207222755.3920286-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207222755.3920286-1-andrii@kernel.org>
References: <20231207222755.3920286-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: qrMukRAFv4Jd_ON_QuOfxlySKGCQqHMS
X-Proofpoint-ORIG-GUID: qrMukRAFv4Jd_ON_QuOfxlySKGCQqHMS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_17,2023-12-07_01,2023-05-22_02

Use similar approach to enum bpf_func_id and generate enumerators using
a macro with macro callback. This approach allows to generate derivative
tables for string-based lookups and whatnot. In this particular case,
this mapper macro will be used for parsing BPF FS delegate_cmds mount
option and their human-readable output format in mount info.

Validated no regressions using before/after BTF through
`bpftool btf dump <file> format c` command.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/uapi/linux/bpf.h       | 81 ++++++++++++++++++----------------
 tools/include/uapi/linux/bpf.h | 81 ++++++++++++++++++----------------
 2 files changed, 86 insertions(+), 76 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e0545201b55f..d05ea24ace3f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -893,47 +893,52 @@ union bpf_iter_link_info {
  *	to the object have been closed and no references remain pinned to the
  *	filesystem or attached (for example, bound to a program or device).
  */
+#define __BPF_CMD_MAPPER(FN, ctx...)					\
+	FN(BPF_MAP_CREATE, 0)						\
+	FN(BPF_MAP_LOOKUP_ELEM, 1)					\
+	FN(BPF_MAP_UPDATE_ELEM, 2)					\
+	FN(BPF_MAP_DELETE_ELEM, 3)					\
+	FN(BPF_MAP_GET_NEXT_KEY, 4)					\
+	FN(BPF_PROG_LOAD, 5)						\
+	FN(BPF_OBJ_PIN, 6)						\
+	FN(BPF_OBJ_GET, 7)						\
+	FN(BPF_PROG_ATTACH, 8)						\
+	FN(BPF_PROG_DETACH, 9)						\
+	FN(BPF_PROG_TEST_RUN, 10)					\
+	FN(BPF_PROG_RUN, 10) /* alias for BPF_PROG_TEST_RUN */		\
+	FN(BPF_PROG_GET_NEXT_ID, 11)					\
+	FN(BPF_MAP_GET_NEXT_ID, 12)					\
+	FN(BPF_PROG_GET_FD_BY_ID, 13)					\
+	FN(BPF_MAP_GET_FD_BY_ID, 14)					\
+	FN(BPF_OBJ_GET_INFO_BY_FD, 15)					\
+	FN(BPF_PROG_QUERY, 16)						\
+	FN(BPF_RAW_TRACEPOINT_OPEN, 17)					\
+	FN(BPF_BTF_LOAD, 18)						\
+	FN(BPF_BTF_GET_FD_BY_ID, 19)					\
+	FN(BPF_TASK_FD_QUERY, 20)					\
+	FN(BPF_MAP_LOOKUP_AND_DELETE_ELEM, 21)				\
+	FN(BPF_MAP_FREEZE, 22)						\
+	FN(BPF_BTF_GET_NEXT_ID, 23)					\
+	FN(BPF_MAP_LOOKUP_BATCH, 24)					\
+	FN(BPF_MAP_LOOKUP_AND_DELETE_BATCH, 25)				\
+	FN(BPF_MAP_UPDATE_BATCH, 26)					\
+	FN(BPF_MAP_DELETE_BATCH, 27)					\
+	FN(BPF_LINK_CREATE, 28)						\
+	FN(BPF_LINK_UPDATE, 29)						\
+	FN(BPF_LINK_GET_FD_BY_ID, 30)					\
+	FN(BPF_LINK_GET_NEXT_ID, 31)					\
+	FN(BPF_ENABLE_STATS, 32)					\
+	FN(BPF_ITER_CREATE, 33)						\
+	FN(BPF_LINK_DETACH, 34)						\
+	FN(BPF_PROG_BIND_MAP, 35)					\
+	FN(BPF_TOKEN_CREATE, 36)					\
+	/* */
+#define __BPF_CMD_FN(x, y) x =3D y,
 enum bpf_cmd {
-	BPF_MAP_CREATE,
-	BPF_MAP_LOOKUP_ELEM,
-	BPF_MAP_UPDATE_ELEM,
-	BPF_MAP_DELETE_ELEM,
-	BPF_MAP_GET_NEXT_KEY,
-	BPF_PROG_LOAD,
-	BPF_OBJ_PIN,
-	BPF_OBJ_GET,
-	BPF_PROG_ATTACH,
-	BPF_PROG_DETACH,
-	BPF_PROG_TEST_RUN,
-	BPF_PROG_RUN =3D BPF_PROG_TEST_RUN,
-	BPF_PROG_GET_NEXT_ID,
-	BPF_MAP_GET_NEXT_ID,
-	BPF_PROG_GET_FD_BY_ID,
-	BPF_MAP_GET_FD_BY_ID,
-	BPF_OBJ_GET_INFO_BY_FD,
-	BPF_PROG_QUERY,
-	BPF_RAW_TRACEPOINT_OPEN,
-	BPF_BTF_LOAD,
-	BPF_BTF_GET_FD_BY_ID,
-	BPF_TASK_FD_QUERY,
-	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
-	BPF_MAP_FREEZE,
-	BPF_BTF_GET_NEXT_ID,
-	BPF_MAP_LOOKUP_BATCH,
-	BPF_MAP_LOOKUP_AND_DELETE_BATCH,
-	BPF_MAP_UPDATE_BATCH,
-	BPF_MAP_DELETE_BATCH,
-	BPF_LINK_CREATE,
-	BPF_LINK_UPDATE,
-	BPF_LINK_GET_FD_BY_ID,
-	BPF_LINK_GET_NEXT_ID,
-	BPF_ENABLE_STATS,
-	BPF_ITER_CREATE,
-	BPF_LINK_DETACH,
-	BPF_PROG_BIND_MAP,
-	BPF_TOKEN_CREATE,
+	__BPF_CMD_MAPPER(__BPF_CMD_FN)
 	__MAX_BPF_CMD,
 };
+#undef __BPF_CMD_FN
=20
 enum bpf_map_type {
 	BPF_MAP_TYPE_UNSPEC,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index e0545201b55f..d05ea24ace3f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -893,47 +893,52 @@ union bpf_iter_link_info {
  *	to the object have been closed and no references remain pinned to the
  *	filesystem or attached (for example, bound to a program or device).
  */
+#define __BPF_CMD_MAPPER(FN, ctx...)					\
+	FN(BPF_MAP_CREATE, 0)						\
+	FN(BPF_MAP_LOOKUP_ELEM, 1)					\
+	FN(BPF_MAP_UPDATE_ELEM, 2)					\
+	FN(BPF_MAP_DELETE_ELEM, 3)					\
+	FN(BPF_MAP_GET_NEXT_KEY, 4)					\
+	FN(BPF_PROG_LOAD, 5)						\
+	FN(BPF_OBJ_PIN, 6)						\
+	FN(BPF_OBJ_GET, 7)						\
+	FN(BPF_PROG_ATTACH, 8)						\
+	FN(BPF_PROG_DETACH, 9)						\
+	FN(BPF_PROG_TEST_RUN, 10)					\
+	FN(BPF_PROG_RUN, 10) /* alias for BPF_PROG_TEST_RUN */		\
+	FN(BPF_PROG_GET_NEXT_ID, 11)					\
+	FN(BPF_MAP_GET_NEXT_ID, 12)					\
+	FN(BPF_PROG_GET_FD_BY_ID, 13)					\
+	FN(BPF_MAP_GET_FD_BY_ID, 14)					\
+	FN(BPF_OBJ_GET_INFO_BY_FD, 15)					\
+	FN(BPF_PROG_QUERY, 16)						\
+	FN(BPF_RAW_TRACEPOINT_OPEN, 17)					\
+	FN(BPF_BTF_LOAD, 18)						\
+	FN(BPF_BTF_GET_FD_BY_ID, 19)					\
+	FN(BPF_TASK_FD_QUERY, 20)					\
+	FN(BPF_MAP_LOOKUP_AND_DELETE_ELEM, 21)				\
+	FN(BPF_MAP_FREEZE, 22)						\
+	FN(BPF_BTF_GET_NEXT_ID, 23)					\
+	FN(BPF_MAP_LOOKUP_BATCH, 24)					\
+	FN(BPF_MAP_LOOKUP_AND_DELETE_BATCH, 25)				\
+	FN(BPF_MAP_UPDATE_BATCH, 26)					\
+	FN(BPF_MAP_DELETE_BATCH, 27)					\
+	FN(BPF_LINK_CREATE, 28)						\
+	FN(BPF_LINK_UPDATE, 29)						\
+	FN(BPF_LINK_GET_FD_BY_ID, 30)					\
+	FN(BPF_LINK_GET_NEXT_ID, 31)					\
+	FN(BPF_ENABLE_STATS, 32)					\
+	FN(BPF_ITER_CREATE, 33)						\
+	FN(BPF_LINK_DETACH, 34)						\
+	FN(BPF_PROG_BIND_MAP, 35)					\
+	FN(BPF_TOKEN_CREATE, 36)					\
+	/* */
+#define __BPF_CMD_FN(x, y) x =3D y,
 enum bpf_cmd {
-	BPF_MAP_CREATE,
-	BPF_MAP_LOOKUP_ELEM,
-	BPF_MAP_UPDATE_ELEM,
-	BPF_MAP_DELETE_ELEM,
-	BPF_MAP_GET_NEXT_KEY,
-	BPF_PROG_LOAD,
-	BPF_OBJ_PIN,
-	BPF_OBJ_GET,
-	BPF_PROG_ATTACH,
-	BPF_PROG_DETACH,
-	BPF_PROG_TEST_RUN,
-	BPF_PROG_RUN =3D BPF_PROG_TEST_RUN,
-	BPF_PROG_GET_NEXT_ID,
-	BPF_MAP_GET_NEXT_ID,
-	BPF_PROG_GET_FD_BY_ID,
-	BPF_MAP_GET_FD_BY_ID,
-	BPF_OBJ_GET_INFO_BY_FD,
-	BPF_PROG_QUERY,
-	BPF_RAW_TRACEPOINT_OPEN,
-	BPF_BTF_LOAD,
-	BPF_BTF_GET_FD_BY_ID,
-	BPF_TASK_FD_QUERY,
-	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
-	BPF_MAP_FREEZE,
-	BPF_BTF_GET_NEXT_ID,
-	BPF_MAP_LOOKUP_BATCH,
-	BPF_MAP_LOOKUP_AND_DELETE_BATCH,
-	BPF_MAP_UPDATE_BATCH,
-	BPF_MAP_DELETE_BATCH,
-	BPF_LINK_CREATE,
-	BPF_LINK_UPDATE,
-	BPF_LINK_GET_FD_BY_ID,
-	BPF_LINK_GET_NEXT_ID,
-	BPF_ENABLE_STATS,
-	BPF_ITER_CREATE,
-	BPF_LINK_DETACH,
-	BPF_PROG_BIND_MAP,
-	BPF_TOKEN_CREATE,
+	__BPF_CMD_MAPPER(__BPF_CMD_FN)
 	__MAX_BPF_CMD,
 };
+#undef __BPF_CMD_FN
=20
 enum bpf_map_type {
 	BPF_MAP_TYPE_UNSPEC,
--=20
2.34.1


