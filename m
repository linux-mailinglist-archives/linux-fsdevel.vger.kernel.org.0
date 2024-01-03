Return-Path: <linux-fsdevel+bounces-7296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B992823802
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5762840E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65402210F4;
	Wed,  3 Jan 2024 22:23:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7D420DFE
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403MFFqO001650
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Jan 2024 14:23:54 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vdg7401jh-20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:23:53 -0800
Received: from twshared10507.42.prn1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 14:23:37 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id A0E173DF9EBA1; Wed,  3 Jan 2024 14:21:23 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>, <torvalds@linuxfoundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next 21/29] libbpf: split feature detectors definitions from cached results
Date: Wed, 3 Jan 2024 14:20:26 -0800
Message-ID: <20240103222034.2582628-22-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: ZJEonE_Mxnhb_gva77gJTkf13vJY-rGP
X-Proofpoint-GUID: ZJEonE_Mxnhb_gva77gJTkf13vJY-rGP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02

Split a list of supported feature detectors with their corresponding
callbacks from actual cached supported/missing values. This will allow
to have more flexible per-token or per-object feature detectors in
subsequent refactorings.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ebcfb2147fbd..95a7d459b842 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5001,12 +5001,17 @@ enum kern_feature_result {
 	FEAT_MISSING =3D 2,
 };
=20
+struct kern_feature_cache {
+	enum kern_feature_result res[__FEAT_CNT];
+};
+
 typedef int (*feature_probe_fn)(void);
=20
+static struct kern_feature_cache feature_cache;
+
 static struct kern_feature_desc {
 	const char *desc;
 	feature_probe_fn probe;
-	enum kern_feature_result res;
 } feature_probes[__FEAT_CNT] =3D {
 	[FEAT_PROG_NAME] =3D {
 		"BPF program name", probe_kern_prog_name,
@@ -5074,6 +5079,7 @@ static struct kern_feature_desc {
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id =
feat_id)
 {
 	struct kern_feature_desc *feat =3D &feature_probes[feat_id];
+	struct kern_feature_cache *cache =3D &feature_cache;
 	int ret;
=20
 	if (obj && obj->gen_loader)
@@ -5082,19 +5088,19 @@ bool kernel_supports(const struct bpf_object *obj=
, enum kern_feature_id feat_id)
 		 */
 		return true;
=20
-	if (READ_ONCE(feat->res) =3D=3D FEAT_UNKNOWN) {
+	if (READ_ONCE(cache->res[feat_id]) =3D=3D FEAT_UNKNOWN) {
 		ret =3D feat->probe();
 		if (ret > 0) {
-			WRITE_ONCE(feat->res, FEAT_SUPPORTED);
+			WRITE_ONCE(cache->res[feat_id], FEAT_SUPPORTED);
 		} else if (ret =3D=3D 0) {
-			WRITE_ONCE(feat->res, FEAT_MISSING);
+			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
 		} else {
 			pr_warn("Detection of kernel %s support failed: %d\n", feat->desc, re=
t);
-			WRITE_ONCE(feat->res, FEAT_MISSING);
+			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
 		}
 	}
=20
-	return READ_ONCE(feat->res) =3D=3D FEAT_SUPPORTED;
+	return READ_ONCE(cache->res[feat_id]) =3D=3D FEAT_SUPPORTED;
 }
=20
 static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
--=20
2.34.1


