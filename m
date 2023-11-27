Return-Path: <linux-fsdevel+bounces-3975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA88A7FA9A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 20:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64BDC28182E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 19:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2DB3FB32;
	Mon, 27 Nov 2023 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24199D59
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 11:04:32 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3ARICJCl003351
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 11:04:31 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3umf0n5e4s-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 11:04:31 -0800
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 11:04:28 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 5D3673C35FBBE; Mon, 27 Nov 2023 11:04:20 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v11 bpf-next 05/17] bpf: add BPF token support to BPF_BTF_LOAD command
Date: Mon, 27 Nov 2023 11:03:57 -0800
Message-ID: <20231127190409.2344550-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127190409.2344550-1-andrii@kernel.org>
References: <20231127190409.2344550-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Nip4OR7SaLfOZlPkSpdRvROOXQ1kpKD2
X-Proofpoint-GUID: Nip4OR7SaLfOZlPkSpdRvROOXQ1kpKD2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_17,2023-11-27_01,2023-05-22_02

Accept BPF token FD in BPF_BTF_LOAD command to allow BTF data loading
through delegated BPF token. BTF loading is a pretty straightforward
operation, so as long as BPF token is created with allow_cmds granting
BPF_BTF_LOAD command, kernel proceeds to parsing BTF data and creating
BTF object.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           | 20 ++++++++++++++++++--
 tools/include/uapi/linux/bpf.h |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 5edc3c863519..d870f594c37b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1616,6 +1616,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		btf_log_true_size;
+		__u32		btf_token_fd;
 	};
=20
 	struct {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e004786290dc..a31b19c9a3c8 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4752,15 +4752,31 @@ static int bpf_obj_get_info_by_fd(const union bpf=
_attr *attr,
 	return err;
 }
=20
-#define BPF_BTF_LOAD_LAST_FIELD btf_log_true_size
+#define BPF_BTF_LOAD_LAST_FIELD btf_token_fd
=20
 static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u3=
2 uattr_size)
 {
+	struct bpf_token *token =3D NULL;
+
 	if (CHECK_ATTR(BPF_BTF_LOAD))
 		return -EINVAL;
=20
-	if (!bpf_capable())
+	if (attr->btf_token_fd) {
+		token =3D bpf_token_get_from_fd(attr->btf_token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+		if (!bpf_token_allow_cmd(token, BPF_BTF_LOAD)) {
+			bpf_token_put(token);
+			token =3D NULL;
+		}
+	}
+
+	if (!bpf_token_capable(token, CAP_BPF)) {
+		bpf_token_put(token);
 		return -EPERM;
+	}
+
+	bpf_token_put(token);
=20
 	return btf_new_fd(attr, uattr, uattr_size);
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 5edc3c863519..d870f594c37b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1616,6 +1616,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		btf_log_true_size;
+		__u32		btf_token_fd;
 	};
=20
 	struct {
--=20
2.34.1


