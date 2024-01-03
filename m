Return-Path: <linux-fsdevel+bounces-7285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D2C8237CD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D321C24192
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB104208B0;
	Wed,  3 Jan 2024 22:21:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7F82033F
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403GiT7h026621
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Jan 2024 14:21:12 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vd5324sc7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:21:11 -0800
Received: from twshared38604.02.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 14:20:50 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id DD7D33DF9EA87; Wed,  3 Jan 2024 14:20:45 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>, <torvalds@linuxfoundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next 05/29] bpf: add BPF token support to BPF_BTF_LOAD command
Date: Wed, 3 Jan 2024 14:20:10 -0800
Message-ID: <20240103222034.2582628-6-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: _uKfheN4fvivHPXZqgVQ-XB6ucOR4ARi
X-Proofpoint-GUID: _uKfheN4fvivHPXZqgVQ-XB6ucOR4ARi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02

Accept BPF token FD in BPF_BTF_LOAD command to allow BTF data loading
through delegated BPF token. BPF_F_TOKEN_FD flag has to be specified
when passing BPF token FD. Given BPF_BTF_LOAD command didn't have flags
field before, we also add btf_flags field.

BTF loading is a pretty straightforward operation, so as long as BPF
token is created with allow_cmds granting BPF_BTF_LOAD command, kernel
proceeds to parsing BTF data and creating BTF object.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/bpf/syscall.c           | 23 +++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f493f14ce6ef..71fb04a3fe00 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1623,6 +1623,11 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		btf_log_true_size;
+		__u32		btf_flags;
+		/* BPF token FD to use with BPF_BTF_LOAD operation.
+		 * If provided, btf_flags should have BPF_F_TOKEN_FD flag set.
+		 */
+		__s32		btf_token_fd;
 	};
=20
 	struct {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 65c9feafb02f..59b8e754c42d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4795,15 +4795,34 @@ static int bpf_obj_get_info_by_fd(const union bpf=
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
+	if (attr->btf_flags & ~BPF_F_TOKEN_FD)
+		return -EINVAL;
+
+	if (attr->btf_flags & BPF_F_TOKEN_FD) {
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
index f493f14ce6ef..71fb04a3fe00 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1623,6 +1623,11 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		btf_log_true_size;
+		__u32		btf_flags;
+		/* BPF token FD to use with BPF_BTF_LOAD operation.
+		 * If provided, btf_flags should have BPF_F_TOKEN_FD flag set.
+		 */
+		__s32		btf_token_fd;
 	};
=20
 	struct {
--=20
2.34.1


