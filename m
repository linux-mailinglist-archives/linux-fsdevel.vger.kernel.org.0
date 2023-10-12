Return-Path: <linux-fsdevel+bounces-211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EAA7C7984
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 00:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 261D3B209D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 22:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFB5405D1;
	Thu, 12 Oct 2023 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A528D405E1
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 22:31:25 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77976BB
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:31:24 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39CLuAQ0015866
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:31:23 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3tpbsne34c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:31:23 -0700
Received: from twshared15247.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 12 Oct 2023 15:31:22 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 2A0FC39A3A4B9; Thu, 12 Oct 2023 15:29:13 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <brauner@kernel.org>,
        <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v7 bpf-next 05/18] bpf: add BPF token support to BPF_BTF_LOAD command
Date: Thu, 12 Oct 2023 15:27:57 -0700
Message-ID: <20231012222810.4120312-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012222810.4120312-1-andrii@kernel.org>
References: <20231012222810.4120312-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5kjBVPU8CXgCoybM_RPZ6bIvheTYEpBo
X-Proofpoint-ORIG-GUID: 5kjBVPU8CXgCoybM_RPZ6bIvheTYEpBo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 78deb9f74379..e6d35086152b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1611,6 +1611,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		btf_log_true_size;
+		__u32		btf_token_fd;
 	};
=20
 	struct {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e63e4280c43c..a2c9edcbcd77 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4728,15 +4728,31 @@ static int bpf_obj_get_info_by_fd(const union bpf=
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
index 78deb9f74379..e6d35086152b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1611,6 +1611,7 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		btf_log_true_size;
+		__u32		btf_token_fd;
 	};
=20
 	struct {
--=20
2.34.1


