Return-Path: <linux-fsdevel+bounces-64889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69BABF6470
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661443A6E29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B64A337118;
	Tue, 21 Oct 2025 11:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huPX/l79"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645A2331A59;
	Tue, 21 Oct 2025 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047231; cv=none; b=WdMehTkC/AuG2YUEgvaaBEycrCILhPMXT0y4aVUWEhPkc1ylCOiu+bC3jhgWqNDlAPQdTtHqgn4XrQBJqLjdsJ7jIURugkT/9OMwW5IZJGwbniaMq5+eShGBhpdXp+xcBC7rqXVI6LgMaah2FKh9UyrQ0ygmhnv5g7uAO2Vx7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047231; c=relaxed/simple;
	bh=UxNNzwwfXU08oQlPAvQ0Gj3cx0fWVzo9FwN6OUP3IWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fNoaZs7jacJ8Pfh/eahib9k4UHyUtJrCyj4M2Yjpp5hTNzpY3bCFra19KlkTQR5JxwBgZWKutmMI0s9UmcKRlY1ThWmNieFYuDH0CuLP7bGbgllO1jB9OjNyBUsO7Ft6BCE5XukIubhhQrdYOJ5Hl4VEUv1LUj8LqzMOBUORuso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huPX/l79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A163DC4CEFF;
	Tue, 21 Oct 2025 11:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047231;
	bh=UxNNzwwfXU08oQlPAvQ0Gj3cx0fWVzo9FwN6OUP3IWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=huPX/l79ayGnTtDzvAud738L4wVGg+6mVX9/DetwXihJUZ4DkDyjYB7ROwaHcdBhJ
	 WV/TmFbpjn1R9KFzURg1nrj7tTLTaSxrX0T68sf//euWfdqNkJLmXHwxKNsYBlApEo
	 CDUDp8vgU4BbdZQ/CUYzKIAQ+Hi+tT/OwUcGR2gAFP2j9IqjpZrZUXPtTm9JtOgOAw
	 L7r2Yg+OWFdhLSHgNcwzG9dUIxVaVtVmunQxTojM4+RAFQNVWmmj55DwxJgCg8EnTh
	 vZsG3uoUuEg+bo7wDjVXb4a5QPOPsQDGE6UW237Rr+mdxq4Vuj0HZoraTD7/dKwzH6
	 JyYwT6Ju9V9zA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:44 +0200
Subject: [PATCH RFC DRAFT 38/50] selftests/namespaces: fourth listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-38-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UxNNzwwfXU08oQlPAvQ0Gj3cx0fWVzo9FwN6OUP3IWE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3wnaXlD92mP4Ku3ueFz0+7V9DKvdp79gL1v7wbb3
 BtHumbv6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIKVOG/7VGc18oFAZ9fTdv
 w+2zBs/kAyJYOOocbBmqbzX6vT5g/JeRofN8sqXt3kqtrIIu1ksWh6YLuNzfdKb50BH/LruWsPS
 rLAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test listns() with LISTNS_CURRENT_USER.
List namespaces owned by current user namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/listns_test.c | 33 ++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index 7dff63a00263..457298cb4c64 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -168,4 +168,37 @@ TEST(listns_pagination)
 	}
 }
 
+/*
+ * Test listns() with LISTNS_CURRENT_USER.
+ * List namespaces owned by current user namespace.
+ */
+TEST(listns_current_user)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = 0,
+		.spare2 = 0,
+		.user_ns_id = LISTNS_CURRENT_USER,
+	};
+	__u64 ns_ids[100];
+	ssize_t ret;
+
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		TH_LOG("listns failed: %s (errno=%d)", strerror(errno), errno);
+		ASSERT_TRUE(false);
+	}
+	ASSERT_GE(ret, 0);
+
+	/* Should find at least the initial namespaces if we're in init_user_ns */
+	TH_LOG("Found %zd namespaces owned by current user namespace", ret);
+
+	for (ssize_t i = 0; i < ret; i++)
+		TH_LOG("  [%zd] ns_id: %llu", i, (unsigned long long)ns_ids[i]);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


