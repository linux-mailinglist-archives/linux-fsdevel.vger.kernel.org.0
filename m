Return-Path: <linux-fsdevel+bounces-4495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9517FFCD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 21:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB1B20B8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 20:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90325A101
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 20:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEEE10EF
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 10:53:13 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUIQNCm017331
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 10:53:13 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uparnr8w2-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 10:53:12 -0800
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 10:53:10 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 52D2C3C602980; Thu, 30 Nov 2023 10:53:00 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v12 bpf-next 14/17] libbpf: add BPF token support to bpf_btf_load() API
Date: Thu, 30 Nov 2023 10:52:26 -0800
Message-ID: <20231130185229.2688956-15-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130185229.2688956-1-andrii@kernel.org>
References: <20231130185229.2688956-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: wtWXT_DNHLqjTjS-J4IOFzSSr8eRdGvt
X-Proofpoint-ORIG-GUID: wtWXT_DNHLqjTjS-J4IOFzSSr8eRdGvt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_18,2023-11-30_01,2023-05-22_02

Allow user to specify token_fd for bpf_btf_load() API that wraps
kernel's BPF_BTF_LOAD command. This allows loading BTF from unprivileged
process as long as it has BPF token allowing BPF_BTF_LOAD command, which
can be created and delegated by privileged process.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 4 +++-
 tools/lib/bpf/bpf.h | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 1653b64b7015..544ae2376b6b 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1184,7 +1184,7 @@ int bpf_raw_tracepoint_open(const char *name, int p=
rog_fd)
=20
 int bpf_btf_load(const void *btf_data, size_t btf_size, struct bpf_btf_l=
oad_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, btf_log_true_size)=
;
+	const size_t attr_sz =3D offsetofend(union bpf_attr, btf_token_fd);
 	union bpf_attr attr;
 	char *log_buf;
 	size_t log_size;
@@ -1209,6 +1209,8 @@ int bpf_btf_load(const void *btf_data, size_t btf_s=
ize, struct bpf_btf_load_opts
=20
 	attr.btf =3D ptr_to_u64(btf_data);
 	attr.btf_size =3D btf_size;
+	attr.btf_token_fd =3D OPTS_GET(opts, token_fd, 0);
+
 	/* log_level =3D=3D 0 and log_buf !=3D NULL means "try loading without
 	 * log_buf, but retry with log_buf and log_level=3D1 on error", which i=
s
 	 * consistent across low-level and high-level BTF and program loading
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index ae2136f596b4..4b0f25e97b0d 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -133,9 +133,10 @@ struct bpf_btf_load_opts {
 	 * If kernel doesn't support this feature, log_size is left unchanged.
 	 */
 	__u32 log_true_size;
+	__u32 token_fd;
 	size_t :0;
 };
-#define bpf_btf_load_opts__last_field log_true_size
+#define bpf_btf_load_opts__last_field token_fd
=20
 LIBBPF_API int bpf_btf_load(const void *btf_data, size_t btf_size,
 			    struct bpf_btf_load_opts *opts);
--=20
2.34.1


