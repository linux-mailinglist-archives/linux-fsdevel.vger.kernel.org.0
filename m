Return-Path: <linux-fsdevel+bounces-8660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A78839EFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8662B28401
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD1D1799A;
	Wed, 24 Jan 2024 02:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oz5ML2st"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749B17988;
	Wed, 24 Jan 2024 02:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062972; cv=none; b=FFnOYogASsnzgSBvrI3HRVg3L838sUaVwnUvY4xa7f8Q/e9JdabbJsdA6ABtOlCMdegYaGqISX2yeh++Bp5IRc2IwcE9SQN5y5rpQSFdbr7gGUh8Woxt+dFgff1KvXmvhtIGRYlIQ5Q0ZfQ8gLwGBi/nnT3jnXu4ZCEaPmG0PKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062972; c=relaxed/simple;
	bh=pJx50yIhysHqQeApMLc3gwc/InM12I7RbYNRwzPuBkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gNWCRcySUXHbGA3sPvHnZjVjfyKTit61fDUDkBsAH2jy7az1ZxYyu3DdtdEuKRyDonBqeRMraMDebmR4+jIxh9miB+yqeAnc+TB9zIgxec3yoyQDDdl1eJea9HyueiI++pGRMU2L4et/u8fH3IlpbTxfAYBaFkGM18sBUbEgLD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oz5ML2st; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D25C433F1;
	Wed, 24 Jan 2024 02:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062972;
	bh=pJx50yIhysHqQeApMLc3gwc/InM12I7RbYNRwzPuBkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oz5ML2stiQTZ84qLHdcXx/Xe4PRPOYjnZtodPwgnWJ8MTSpge5Kd1DaRfncTSm3wY
	 3cpLoTaJeRsoTN9/68BrBTDMbvyQuVJnY+NsZSvQx0z+Wvc58IEsCwiZwv4INeMYnu
	 kFJOE5RoNowuPvnCp3yf+L4TiiZmCjq0DI4e7j8RMq0hNV47aoW47VoQDdVgmc+5x2
	 B/5Lo6WB5bcHml27i8DWQReSB+nLOmyTGBEA4HxuLciKfJTahP/GHzTXExtez0NAX8
	 MurlDs7YJGC0jpRTBtSuWXZNIBqx7mdn6ZYnaLoh4Kc1k3HAKK7KTPg3OJU4Zmya9q
	 e83lXAXmYA5nA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 22/30] libbpf: further decouple feature checking logic from bpf_object
Date: Tue, 23 Jan 2024 18:21:19 -0800
Message-Id: <20240124022127.2379740-23-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124022127.2379740-1-andrii@kernel.org>
References: <20240124022127.2379740-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add feat_supported() helper that accepts feature cache instead of
bpf_object. This allows low-level code in bpf.c to not know or care
about higher-level concept of bpf_object, yet it will be able to utilize
custom feature checking in cases where BPF token might influence the
outcome.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c             |  6 +++---
 tools/lib/bpf/libbpf.c          | 22 +++++++++++++++-------
 tools/lib/bpf/libbpf_internal.h |  5 ++++-
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index d69137459abf..10bf11a758bf 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -146,7 +146,7 @@ int bump_rlimit_memlock(void)
 	struct rlimit rlim;
 
 	/* if kernel supports memcg-based accounting, skip bumping RLIMIT_MEMLOCK */
-	if (memlock_bumped || kernel_supports(NULL, FEAT_MEMCG_ACCOUNT))
+	if (memlock_bumped || feat_supported(NULL, FEAT_MEMCG_ACCOUNT))
 		return 0;
 
 	memlock_bumped = true;
@@ -181,7 +181,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 		return libbpf_err(-EINVAL);
 
 	attr.map_type = map_type;
-	if (map_name && kernel_supports(NULL, FEAT_PROG_NAME))
+	if (map_name && feat_supported(NULL, FEAT_PROG_NAME))
 		libbpf_strlcpy(attr.map_name, map_name, sizeof(attr.map_name));
 	attr.key_size = key_size;
 	attr.value_size = value_size;
@@ -265,7 +265,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 	attr.kern_version = OPTS_GET(opts, kern_version, 0);
 	attr.prog_token_fd = OPTS_GET(opts, token_fd, 0);
 
-	if (prog_name && kernel_supports(NULL, FEAT_PROG_NAME))
+	if (prog_name && feat_supported(NULL, FEAT_PROG_NAME))
 		libbpf_strlcpy(attr.prog_name, prog_name, sizeof(attr.prog_name));
 	attr.license = ptr_to_u64(license);
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4fc9dfd28f61..4bfc504815d5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5019,17 +5019,14 @@ static struct kern_feature_desc {
 	},
 };
 
-bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
+bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
 {
 	struct kern_feature_desc *feat = &feature_probes[feat_id];
-	struct kern_feature_cache *cache = &feature_cache;
 	int ret;
 
-	if (obj && obj->gen_loader)
-		/* To generate loader program assume the latest kernel
-		 * to avoid doing extra prog_load, map_create syscalls.
-		 */
-		return true;
+	/* assume global feature cache, unless custom one is provided */
+	if (!cache)
+		cache = &feature_cache;
 
 	if (READ_ONCE(cache->res[feat_id]) == FEAT_UNKNOWN) {
 		ret = feat->probe();
@@ -5046,6 +5043,17 @@ bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
 	return READ_ONCE(cache->res[feat_id]) == FEAT_SUPPORTED;
 }
 
+bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
+{
+	if (obj && obj->gen_loader)
+		/* To generate loader program assume the latest kernel
+		 * to avoid doing extra prog_load, map_create syscalls.
+		 */
+		return true;
+
+	return feat_supported(NULL, feat_id);
+}
+
 static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 {
 	struct bpf_map_info map_info;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 58c547d473e0..622892fc841d 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -361,8 +361,11 @@ enum kern_feature_id {
 	__FEAT_CNT,
 };
 
-int probe_memcg_account(void);
+struct kern_feature_cache;
+bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id);
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id);
+
+int probe_memcg_account(void);
 int bump_rlimit_memlock(void);
 
 int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz);
-- 
2.34.1


