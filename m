Return-Path: <linux-fsdevel+bounces-65167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4A2BFD2E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38019565B28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8D437DBF3;
	Wed, 22 Oct 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbPziWur"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C4C37DBD1;
	Wed, 22 Oct 2025 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149373; cv=none; b=Nj1b4jdhht1iv7ttIkjqmjrpHYhaYKdc7Me8y9ihPyY3WQ8EtuU7F79bhNA2yeWJx7uFJqb9Lu+2pI6M8jgBqPcW4Nvtr/Z7b3xZEQxU+5ioMztnKJ5386vaP9kwbN8GWaB4dBb5UODClFQa9Q9UP1WeJaWXJYVZWCjG4Y3xz7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149373; c=relaxed/simple;
	bh=UxNNzwwfXU08oQlPAvQ0Gj3cx0fWVzo9FwN6OUP3IWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sPwwzxgnY7IdWUITlfF4FisNd2QJ1kHrsjb0Ww5pUloHx/VzVwnQbX50GWPTkjBQ2D/WLWVkihg007flEXgzoPEy73Y39xrPx2yvRYMtE7HYYPZVNTeK2UF/ijHuwFPtk6Fk2pu6J5TCjquBaDQxd0qXi4QCQyXSQ5ytbjY3vTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbPziWur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDE9C4CEE7;
	Wed, 22 Oct 2025 16:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149373;
	bh=UxNNzwwfXU08oQlPAvQ0Gj3cx0fWVzo9FwN6OUP3IWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pbPziWurzZXsIhxuB+HDNzhxnMAdP+UkGsueFIkOGWKkNIS2oPe2dn1qyYb5LEDWT
	 Jw6uje+s9hTZf9vqdbrRcOWa2eqMwLljmM+wRDxEmsWDV0Msug9IXjWcrB7dpGGuGc
	 7MPHvwM/EuhokGIVvEvLEGdoLax+ujvxANqNvqx8MBIJ6n4lB1lYAVp7JzRc37hv8V
	 2Ht0KDPbLgo+YO0WTdR3faDP9Y+cb8nG3fVkApMa7So/ScmWXkouYjQloL4bH3ZnvL
	 c9DFXh9KG5KwaMoU+903V5IVWnsiDhrqEX/YjJPByyJaW3AiBryx6LPPLfDtSbo8y3
	 /8l7TgG80RlgQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:17 +0200
Subject: [PATCH v2 39/63] selftests/namespaces: fourth listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-39-71a588572371@kernel.org>
References: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
In-Reply-To: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHj2corZm0rB+u7KDz/2BH3t+5/J47IofP2zhbf2T
 jWzM/v8rqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAikosZGV7HXuri0FOWuvBa
 VOlHtfkVqa7Ez1fFD5Xqq+0TO+Mt58bwh2fqP/3dJ7e9Pn/4b7OJlSvz9w+/lA8f3FMq8ij2hHV
 BIR8A
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


