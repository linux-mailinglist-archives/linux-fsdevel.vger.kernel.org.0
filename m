Return-Path: <linux-fsdevel+bounces-8659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015FA839EFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F141C2293A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAB11775C;
	Wed, 24 Jan 2024 02:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXpXM8E5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050B1774E;
	Wed, 24 Jan 2024 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062968; cv=none; b=lEIwWWNaLsJ9cu1mqelO/XZWiv9tFLD/CIkn+jw7Z2EMSYmUL2xIK06pGQQ8yiJzIdRN9QaAAWAOzf20E1YvrJoHNzoOMtCYL2TUsjmbtpl/P56a7xl6FzEQBYsCRw5Md3vQNSud0JhyB0KQmTC+rm8xg6vo58nqHLTZyrbZgGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062968; c=relaxed/simple;
	bh=y3pUuQBVW98ypG/drn9fCLTGqekiYVpWE5d/7A4fYyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BskKqnTY5uFfHGlS9KXJxEbjJR34Gu+WFc4n9VVD8eSg9fIrawEqZ4RU+pkdFbNwvU4JGR++6NQYPPsMzZ9PU/jQ6oeWVyJvA396n1znP2q69yD2PX+4Nlnzd/fpITG6a4CtiKRl6znfOQyhuVTkA/69XisPca796bEJS7ybZ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXpXM8E5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBBDC433F1;
	Wed, 24 Jan 2024 02:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062968;
	bh=y3pUuQBVW98ypG/drn9fCLTGqekiYVpWE5d/7A4fYyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXpXM8E5E/LG7Zg8jsW8mKpMW3o/ag97+ZGjAUw/WR/LdpdWaVKnw4eWd78lRWUqQ
	 sbsOVip+10hvpLYDl36dpsUWqiDlmlSbkT9CPdbigSVTqtkwbDl0vI5f4QH4Xo1JPG
	 uXq+K/9hg16t1l3PzTZJOikz3YEaEi33xCXlt5eWVFp/SBmgPynTb3K3P0Nl/lGhCj
	 AA/fiHW4DLYBNElbTUcynAQ95eZCnKl+247ThlvNTpEHNwQ3tUjXPscB+heiZ7+qpC
	 p5CtziMZyQoIonAHqx6EQebx+wWX8/XXd005xwHLT9Zz1zOOUgXdI2fYkBRYKeH2/X
	 LpP3MZ2LWWiGQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 21/30] libbpf: split feature detectors definitions from cached results
Date: Tue, 23 Jan 2024 18:21:18 -0800
Message-Id: <20240124022127.2379740-22-andrii@kernel.org>
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
index b8b00da62907..4fc9dfd28f61 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4944,12 +4944,17 @@ enum kern_feature_result {
 	FEAT_MISSING = 2,
 };
 
+struct kern_feature_cache {
+	enum kern_feature_result res[__FEAT_CNT];
+};
+
 typedef int (*feature_probe_fn)(void);
 
+static struct kern_feature_cache feature_cache;
+
 static struct kern_feature_desc {
 	const char *desc;
 	feature_probe_fn probe;
-	enum kern_feature_result res;
 } feature_probes[__FEAT_CNT] = {
 	[FEAT_PROG_NAME] = {
 		"BPF program name", probe_kern_prog_name,
@@ -5017,6 +5022,7 @@ static struct kern_feature_desc {
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
 {
 	struct kern_feature_desc *feat = &feature_probes[feat_id];
+	struct kern_feature_cache *cache = &feature_cache;
 	int ret;
 
 	if (obj && obj->gen_loader)
@@ -5025,19 +5031,19 @@ bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
 		 */
 		return true;
 
-	if (READ_ONCE(feat->res) == FEAT_UNKNOWN) {
+	if (READ_ONCE(cache->res[feat_id]) == FEAT_UNKNOWN) {
 		ret = feat->probe();
 		if (ret > 0) {
-			WRITE_ONCE(feat->res, FEAT_SUPPORTED);
+			WRITE_ONCE(cache->res[feat_id], FEAT_SUPPORTED);
 		} else if (ret == 0) {
-			WRITE_ONCE(feat->res, FEAT_MISSING);
+			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
 		} else {
 			pr_warn("Detection of kernel %s support failed: %d\n", feat->desc, ret);
-			WRITE_ONCE(feat->res, FEAT_MISSING);
+			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
 		}
 	}
 
-	return READ_ONCE(feat->res) == FEAT_SUPPORTED;
+	return READ_ONCE(cache->res[feat_id]) == FEAT_SUPPORTED;
 }
 
 static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
-- 
2.34.1


