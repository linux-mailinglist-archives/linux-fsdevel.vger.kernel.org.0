Return-Path: <linux-fsdevel+bounces-221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C7F7C79B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 00:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C247B20C9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 22:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73872C842;
	Thu, 12 Oct 2023 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD172B5EC
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 22:32:28 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678A2DE
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:32:27 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CLuEBb010348
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:32:26 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tpjt7b0rp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:32:26 -0700
Received: from twshared11278.41.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 12 Oct 2023 15:32:24 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 971AF39A3A5CF; Thu, 12 Oct 2023 15:29:29 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <brauner@kernel.org>,
        <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v7 bpf-next 13/18] selftests/bpf: fix test_maps' use of bpf_map_create_opts
Date: Thu, 12 Oct 2023 15:28:05 -0700
Message-ID: <20231012222810.4120312-14-andrii@kernel.org>
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
X-Proofpoint-GUID: hqPsvuqSW1s2YGWWXieQqUdMduLSciMz
X-Proofpoint-ORIG-GUID: hqPsvuqSW1s2YGWWXieQqUdMduLSciMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
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


