Return-Path: <linux-fsdevel+bounces-458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF587CB1FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9D6281858
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8CC381C7;
	Mon, 16 Oct 2023 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD2339B3
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 18:03:04 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA03F5
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:03:02 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39GFHDVr009966
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:03:02 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3trsm9dsmt-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:03:02 -0700
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 16 Oct 2023 11:02:59 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 4D56D39D9C358; Mon, 16 Oct 2023 11:02:54 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <brauner@kernel.org>,
        <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v8 bpf-next 16/18] libbpf: add BPF token support to bpf_prog_load() API
Date: Mon, 16 Oct 2023 11:02:18 -0700
Message-ID: <20231016180220.3866105-17-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016180220.3866105-1-andrii@kernel.org>
References: <20231016180220.3866105-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0iRYUeAgHXb-MUH736CDvSGKNuP8dBbd
X-Proofpoint-GUID: 0iRYUeAgHXb-MUH736CDvSGKNuP8dBbd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wire through token_fd into bpf_prog_load().

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 3 ++-
 tools/lib/bpf/bpf.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 4547ae1037af..5a238831b4ff 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -234,7 +234,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 		  const struct bpf_insn *insns, size_t insn_cnt,
 		  struct bpf_prog_load_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, log_true_size);
+	const size_t attr_sz =3D offsetofend(union bpf_attr, prog_token_fd);
 	void *finfo =3D NULL, *linfo =3D NULL;
 	const char *func_info, *line_info;
 	__u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
@@ -263,6 +263,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 	attr.prog_flags =3D OPTS_GET(opts, prog_flags, 0);
 	attr.prog_ifindex =3D OPTS_GET(opts, prog_ifindex, 0);
 	attr.kern_version =3D OPTS_GET(opts, kern_version, 0);
+	attr.prog_token_fd =3D OPTS_GET(opts, token_fd, 0);
=20
 	if (prog_name && kernel_supports(NULL, FEAT_PROG_NAME))
 		libbpf_strlcpy(attr.prog_name, prog_name, sizeof(attr.prog_name));
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index d7df5543f402..edc0cab465d6 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -105,9 +105,10 @@ struct bpf_prog_load_opts {
 	 * If kernel doesn't support this feature, log_size is left unchanged.
 	 */
 	__u32 log_true_size;
+	__u32 token_fd;
 	size_t :0;
 };
-#define bpf_prog_load_opts__last_field log_true_size
+#define bpf_prog_load_opts__last_field token_fd
=20
 LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
 			     const char *prog_name, const char *license,
--=20
2.34.1


