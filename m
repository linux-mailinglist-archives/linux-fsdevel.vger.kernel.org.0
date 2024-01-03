Return-Path: <linux-fsdevel+bounces-7303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D771823823
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089921F2758A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5C5200B7;
	Wed,  3 Jan 2024 22:24:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F94A1DA56
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403GiMJw020349
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Jan 2024 14:24:37 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vda7m2yym-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:24:37 -0800
Received: from twshared24631.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 14:24:36 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 263ED3DF9EC0F; Wed,  3 Jan 2024 14:21:40 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>, <torvalds@linuxfoundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next 28/29] libbpf: support BPF token path setting through LIBBPF_BPF_TOKEN_PATH envvar
Date: Wed, 3 Jan 2024 14:20:33 -0800
Message-ID: <20240103222034.2582628-29-andrii@kernel.org>
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
X-Proofpoint-GUID: G6XrLQIUPU0Zndssl7Ky-4XnNlLmPy1f
X-Proofpoint-ORIG-GUID: G6XrLQIUPU0Zndssl7Ky-4XnNlLmPy1f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02

To allow external admin authority to override default BPF FS location
(/sys/fs/bpf) for implicit BPF token creation, teach libbpf to recognize
LIBBPF_BPF_TOKEN_PATH envvar. If it is specified and user application
didn't explicitly specify bpf_token_path option, it will be treated
exactly like bpf_token_path option, overriding default /sys/fs/bpf
location and making BPF token mandatory.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 6 ++++++
 tools/lib/bpf/libbpf.h | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 69d87d743557..85d6ac99ce01 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7172,6 +7172,12 @@ static struct bpf_object *bpf_object_open(const ch=
ar *path, const void *obj_buf,
 		return ERR_PTR(-EINVAL);
=20
 	token_path =3D OPTS_GET(opts, bpf_token_path, NULL);
+	/* if user didn't specify bpf_token_path explicitly, check if
+	 * LIBBPF_BPF_TOKEN_PATH envvar was set and treat it as bpf_token_path
+	 * option
+	 */
+	if (!token_path)
+		token_path =3D getenv("LIBBPF_BPF_TOKEN_PATH");
 	if (token_path && strlen(token_path) >=3D PATH_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
=20
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 535ae15ed493..5723cbbfcc41 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -183,6 +183,14 @@ struct bpf_object_open_opts {
 	 * that accept BPF token (e.g., map creation, BTF and program loads,
 	 * etc) automatically within instantiated BPF object.
 	 *
+	 * If bpf_token_path is not specified, libbpf will consult
+	 * LIBBPF_BPF_TOKEN_PATH environment variable. If set, it will be
+	 * taken as a value of bpf_token_path option and will force libbpf to
+	 * either create BPF token from provided custom BPF FS path, or will
+	 * disable implicit BPF token creation, if envvar value is an empty
+	 * string. bpf_token_path overrides LIBBPF_BPF_TOKEN_PATH, if both are
+	 * set at the same time.
+	 *
 	 * Setting bpf_token_path option to empty string disables libbpf's
 	 * automatic attempt to create BPF token from default BPF FS mount
 	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
--=20
2.34.1


