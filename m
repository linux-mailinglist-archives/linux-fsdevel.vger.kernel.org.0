Return-Path: <linux-fsdevel+bounces-1955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1637E08F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 20:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C825B21673
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0044B250FE;
	Fri,  3 Nov 2023 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8EB24A06
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 19:06:06 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F7ED67
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 12:06:04 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3A3FJpBd013501
	for <linux-fsdevel@vger.kernel.org>; Fri, 3 Nov 2023 12:06:03 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3u51bjjv6f-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 03 Nov 2023 12:06:03 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 12:05:56 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id DEACC3AE38474; Fri,  3 Nov 2023 12:05:51 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v9 bpf-next 13/17] libbpf: add BPF token support to bpf_map_create() API
Date: Fri, 3 Nov 2023 12:05:19 -0700
Message-ID: <20231103190523.6353-14-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103190523.6353-1-andrii@kernel.org>
References: <20231103190523.6353-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: hR6RGvWKrBKcu9v1w4siJ-d1GfWWmWy0
X-Proofpoint-ORIG-GUID: hR6RGvWKrBKcu9v1w4siJ-d1GfWWmWy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_18,2023-11-02_03,2023-05-22_02

Add ability to provide token_fd for BPF_MAP_CREATE command through
bpf_map_create() API.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 4 +++-
 tools/lib/bpf/bpf.h | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 6064fe90af19..91d45af3e9cd 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -169,7 +169,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   __u32 max_entries,
 		   const struct bpf_map_create_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, map_extra);
+	const size_t attr_sz =3D offsetofend(union bpf_attr, map_token_fd);
 	union bpf_attr attr;
 	int fd;
=20
@@ -198,6 +198,8 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.numa_node =3D OPTS_GET(opts, numa_node, 0);
 	attr.map_ifindex =3D OPTS_GET(opts, map_ifindex, 0);
=20
+	attr.map_token_fd =3D OPTS_GET(opts, token_fd, 0);
+
 	fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(fd);
 }
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 0c558550a3f2..26018aab839c 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -51,8 +51,11 @@ struct bpf_map_create_opts {
=20
 	__u32 numa_node;
 	__u32 map_ifindex;
+
+	__u32 token_fd;
+	size_t :0;
 };
-#define bpf_map_create_opts__last_field map_ifindex
+#define bpf_map_create_opts__last_field token_fd
=20
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
--=20
2.34.1


