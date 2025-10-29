Return-Path: <linux-fsdevel+bounces-66273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D6FC1A676
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E251B188C8C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D763363B90;
	Wed, 29 Oct 2025 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOgTSrqz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AC536337B;
	Wed, 29 Oct 2025 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740742; cv=none; b=aSyRHiD78MI6RLio3oD4IyV7xzHiinMf6cU4PnWXe7C3BT3SJLoncFmXv9IeQ5OMZF/8KKtBQT2xv4m/pI2vKZqFJ/T+fz27ko4FP3WKWtkCgXnqycgBM/aHCRmQz0ZMAay+fNloLYLm6v1SHh7HHHBxi+cCfhxKF1p5qU2y8uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740742; c=relaxed/simple;
	bh=m+pfjG9qzc5y9QbnPIMpZwGVfopUom8AcMnRPDQcZaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KOSTrCOUnZpyxPW4tdOuYrlYvDU4O1woER/JrNA0OHJkS3CU4JeIzVolTldFZwPE7JcjIQVnl4Z68ESsm9mYxOEVtdMkXnttP+Hj4/Rd2sIRWiZqKSiPlOtFwCesK2TgBY09jdU4PHr8phzqdGTJes9j5D3Pg84Ld+Qgbm5RU+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOgTSrqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AACC4CEF7;
	Wed, 29 Oct 2025 12:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740742;
	bh=m+pfjG9qzc5y9QbnPIMpZwGVfopUom8AcMnRPDQcZaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iOgTSrqz7/qOSk+tcKgcnXQ20nFBnVlZ9MDWFvdtXDs3elcqIwyCPzxGHYDmUOl87
	 oc1DbAZfyzsAp/8IUMCQv2T09/Op7KRFBBFu4ESzkhTIfRcc6O72JqEEF0sEIbo9Y5
	 +8g78hhDrimEFi6GuAnJvXGZJjIL8O8hE7UbsmSrWkitXCUMGjHF0xsGzEtFyTz+/+
	 ebb2/AmVR65TlpgeFmEttPhFVB00uVsbMiXpvYKzcqQ0FsqFMyxgQZtyHw6MqVfFgl
	 iskqyvQIgHTSR/kA8k+f/wjcP669KXzrRV5dusiHPYZCcKNoJCB1/DbWG0C6Pg5SDd
	 cCGN6zPbp8lnA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:13 +0100
Subject: [PATCH v4 60/72] selftests/namespaces: sixth inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-60-2e6f823ebdc0@kernel.org>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2328; i=brauner@kernel.org;
 h=from:subject:message-id; bh=m+pfjG9qzc5y9QbnPIMpZwGVfopUom8AcMnRPDQcZaU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfWHHwn/tEnhvbVdc9nU27XX+Zm6pAKC067oCf/+4
 HnQI3xFRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETKtRkZds1rU9Vrmq5qfSJV
 SsC5uvaA1ysh+dg5O4KzuRilWBueMvwVD/trurSJ88nqQ1zGN68FPo400/Dg3tFc7rntHWPgs1J
 OAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test multiple sockets keep the same network namespace active. Create
multiple sockets, verify closing some doesn't affect others.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index bbfef3c51ac1..231830daf5dc 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -333,4 +333,72 @@ TEST(siocgskns_non_socket)
 	close(pipefd[1]);
 }
 
+/*
+ * Test multiple sockets keep the same network namespace active.
+ * Create multiple sockets, verify closing some doesn't affect others.
+ */
+TEST(siocgskns_multiple_sockets)
+{
+	int socks[5];
+	int netns_fds[5];
+	int i;
+	struct stat st;
+	ino_t netns_ino;
+
+	/* Create new network namespace */
+	ASSERT_EQ(unshare(CLONE_NEWNET), 0);
+
+	/* Create multiple sockets */
+	for (i = 0; i < 5; i++) {
+		socks[i] = socket(AF_INET, SOCK_STREAM, 0);
+		ASSERT_GE(socks[i], 0);
+	}
+
+	/* Get netns from all sockets */
+	for (i = 0; i < 5; i++) {
+		netns_fds[i] = ioctl(socks[i], SIOCGSKNS);
+		if (netns_fds[i] < 0) {
+			int j;
+			for (j = 0; j <= i; j++) {
+				close(socks[j]);
+				if (j < i && netns_fds[j] >= 0)
+					close(netns_fds[j]);
+			}
+			if (errno == ENOTTY || errno == EINVAL)
+				SKIP(return, "SIOCGSKNS not supported");
+			ASSERT_GE(netns_fds[i], 0);
+		}
+	}
+
+	/* Verify all point to same netns */
+	ASSERT_EQ(fstat(netns_fds[0], &st), 0);
+	netns_ino = st.st_ino;
+
+	for (i = 1; i < 5; i++) {
+		ASSERT_EQ(fstat(netns_fds[i], &st), 0);
+		ASSERT_EQ(st.st_ino, netns_ino);
+	}
+
+	/* Close some sockets */
+	for (i = 0; i < 3; i++) {
+		close(socks[i]);
+	}
+
+	/* Remaining netns FDs should still be valid */
+	for (i = 3; i < 5; i++) {
+		char path[64];
+		snprintf(path, sizeof(path), "/proc/self/fd/%d", netns_fds[i]);
+		int test_fd = open(path, O_RDONLY);
+		ASSERT_GE(test_fd, 0);
+		close(test_fd);
+	}
+
+	/* Cleanup */
+	for (i = 0; i < 5; i++) {
+		if (i >= 3)
+			close(socks[i]);
+		close(netns_fds[i]);
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


