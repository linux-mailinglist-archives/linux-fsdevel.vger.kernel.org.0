Return-Path: <linux-fsdevel+bounces-461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A076A7CB209
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FF63B21463
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2536338FA2;
	Mon, 16 Oct 2023 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A6434188
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 18:03:08 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F42BEE
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:03:07 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GFe0J4003017
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:03:07 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ts80ph7j6-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:03:06 -0700
Received: from twshared32169.15.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 16 Oct 2023 11:02:53 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 1800139D9C30F; Mon, 16 Oct 2023 11:02:48 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <brauner@kernel.org>,
        <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v8 bpf-next 13/18] selftests/bpf: fix test_maps' use of bpf_map_create_opts
Date: Mon, 16 Oct 2023 11:02:15 -0700
Message-ID: <20231016180220.3866105-14-andrii@kernel.org>
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
X-Proofpoint-GUID: bJSiTLlVIck4wpW7soNP08KvXCHFz5nZ
X-Proofpoint-ORIG-GUID: bJSiTLlVIck4wpW7soNP08KvXCHFz5nZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use LIBBPF_OPTS() macro to properly initialize bpf_map_create_opts in
test_maps' tests.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/map_tests/map_percpu_stats.c          | 20 +++++--------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c b/t=
ools/testing/selftests/bpf/map_tests/map_percpu_stats.c
index 1a9eeefda9a8..8bf497a9843e 100644
--- a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
+++ b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
@@ -326,20 +326,14 @@ static int map_create(__u32 type, const char *name,=
 struct bpf_map_create_opts *
=20
 static int create_hash(void)
 {
-	struct bpf_map_create_opts map_opts =3D {
-		.sz =3D sizeof(map_opts),
-		.map_flags =3D BPF_F_NO_PREALLOC,
-	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts, .map_flags =3D BPF_F_NO_PREA=
LLOC);
=20
 	return map_create(BPF_MAP_TYPE_HASH, "hash", &map_opts);
 }
=20
 static int create_percpu_hash(void)
 {
-	struct bpf_map_create_opts map_opts =3D {
-		.sz =3D sizeof(map_opts),
-		.map_flags =3D BPF_F_NO_PREALLOC,
-	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts, .map_flags =3D BPF_F_NO_PREA=
LLOC);
=20
 	return map_create(BPF_MAP_TYPE_PERCPU_HASH, "percpu_hash", &map_opts);
 }
@@ -356,21 +350,17 @@ static int create_percpu_hash_prealloc(void)
=20
 static int create_lru_hash(__u32 type, __u32 map_flags)
 {
-	struct bpf_map_create_opts map_opts =3D {
-		.sz =3D sizeof(map_opts),
-		.map_flags =3D map_flags,
-	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts, .map_flags =3D map_flags);
=20
 	return map_create(type, "lru_hash", &map_opts);
 }
=20
 static int create_hash_of_maps(void)
 {
-	struct bpf_map_create_opts map_opts =3D {
-		.sz =3D sizeof(map_opts),
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
 		.map_flags =3D BPF_F_NO_PREALLOC,
 		.inner_map_fd =3D create_small_hash(),
-	};
+	);
 	int ret;
=20
 	ret =3D map_create_opts(BPF_MAP_TYPE_HASH_OF_MAPS, "hash_of_maps",
--=20
2.34.1


