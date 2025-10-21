Return-Path: <linux-fsdevel+bounces-64894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C58EBF64CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56928485960
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA8534EF04;
	Tue, 21 Oct 2025 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnzjS9pE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658E7337BBB;
	Tue, 21 Oct 2025 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047257; cv=none; b=hRh4Nv66ghqPldkjCcAwM2n7YOZHNZ6SdmmG6tT4fLaIzKxqxLvC47oDlfXyXo2RwOPPu8W37IHRNpW9i/YQl2Vt4MtTh07eQTbkf4Qnw4WINDFzZBU/5VFy+ge/dXGfr36EHeJKdH2xJwDz+5epSya22LxTpdoD/zQkSNgmSHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047257; c=relaxed/simple;
	bh=77H7R88MI0EUUkshwD3/5/W86ZbXu7/L538OO/0/fLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nzb24C1xnhYocOGA21ubxsN0NlUOKnb8jc4FhJ+31LpgKPYSOWlzIwY+QPjNgJHEMUXXg1+4uIzrWUIT5BGhqijsG8HiHhu3c4/IySpLMMCEK1nE7u3D35y82Ax38iSt0R3RpSSgK2HEoUtVugTruv8Oq/LDwLNMUtZkF+7dteI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnzjS9pE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD60BC4CEFF;
	Tue, 21 Oct 2025 11:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047257;
	bh=77H7R88MI0EUUkshwD3/5/W86ZbXu7/L538OO/0/fLQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WnzjS9pEWFOER24ezYjY6jxri9E7sRPgkGGsF9ENWf38HphQRpT7maU4ZZ6+8TvIo
	 iklg56swuw0YwPhFraxbHVHo0UnOGXOEHFyBGKd2qLmPC1Q3wsww59Jj5bwur5457i
	 i5tDWn6rD4TCyywNVPQJ/VMF8WPHm49+/syy8kY7v+pTOz5+PGi29gIj9+541jhpb9
	 ujH4rhsPYZm0y09LCOnZX1PxSRy1rRQroGCGvlg99z7AfpIKWs4hk5oA5VqtZebVqh
	 nWKBsZY2zFxnRpKoJ5DrOsSo9aWjrvmw/mpHiUfLwdEMZdJAWinMbfuoPBP5V8a8lt
	 tIM/sXnkYDeng==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:49 +0200
Subject: [PATCH RFC DRAFT 43/50] selftests/namespaces: ninth listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-43-ad44261a8a5b@kernel.org>
References: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
In-Reply-To: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1852; i=brauner@kernel.org;
 h=from:subject:message-id; bh=77H7R88MI0EUUkshwD3/5/W86ZbXu7/L538OO/0/fLQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3xXHLm6+QXbd2eHip5czkeOV5qXHd2Yev/BrDu+8
 dz9y54f6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIu1pGhqP3d4krrczwYtBI
 PuMW8ZZtWePVTTzVe2NUHh6tYjkYkc3IMNtLO7dm7waPusrEGZXr1SqsHh7qUHymfHPj7N9s7A6
 xfAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test error cases for listns().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/listns_test.c | 51 ++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index ddf4509d5cd6..eb44f50ab77a 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -602,4 +602,55 @@ TEST(listns_hierarchical_visibility)
 	waitpid(pid, &status, 0);
 }
 
+/*
+ * Test error cases for listns().
+ */
+TEST(listns_error_cases)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = 0,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids[10];
+	int ret;
+
+	/* Test with invalid flags */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0xFFFF);
+	if (ret >= 0 || errno == ENOSYS) {
+		if (errno != ENOSYS) {
+			TH_LOG("Warning: Expected EINVAL for invalid flags, got success");
+		}
+	} else {
+		ASSERT_EQ(errno, EINVAL);
+	}
+
+	/* Test with NULL ns_ids array */
+	ret = sys_listns(&req, NULL, 10, 0);
+	if (ret >= 0) {
+		TH_LOG("Warning: Expected EFAULT for NULL array, got success");
+	}
+
+	/* Test with invalid spare field */
+	req.spare = 1;
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret >= 0 || errno == ENOSYS) {
+		if (errno != ENOSYS) {
+			TH_LOG("Warning: Expected EINVAL for non-zero spare, got success");
+		}
+	}
+	req.spare = 0;
+
+	/* Test with huge nr_ns_ids */
+	ret = sys_listns(&req, ns_ids, 2000000, 0);
+	if (ret >= 0 || errno == ENOSYS) {
+		if (errno != ENOSYS) {
+			TH_LOG("Warning: Expected EOVERFLOW for huge count, got success");
+		}
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


