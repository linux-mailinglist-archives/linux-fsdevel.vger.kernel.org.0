Return-Path: <linux-fsdevel+bounces-65498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F7DC05EF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9D13BC582
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22B235BDA7;
	Fri, 24 Oct 2025 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBSgbyc9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E80A31691E;
	Fri, 24 Oct 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303505; cv=none; b=QLZsrFVfdQEwmPoV6V8UMmMeNtZasW+mCeixSuwCRxX+jUyMSf4VyOX0tHoBIKANHHChDc3Y+ph3bM8KX18jkpqvIp7aB9/t+f4UM2HWhC9SMMo1+/KBu4ldRy8OjA4onmd7cZxS9foelsZiNJ5KwfACtyhM1DqjnRq6teB6fCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303505; c=relaxed/simple;
	bh=m+pfjG9qzc5y9QbnPIMpZwGVfopUom8AcMnRPDQcZaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sSQyFtw3sXZ54WZVNG9Ypz2K1RcYcZs4+7TSMSpNzzvCx0Kwbe+9OPMk9nKNnfx7d28gDqAe8Ixi4O3HvHCUbLvI1M4BUr2dp9yNNber6AyAUL+DYm0zGdheCR/sI5P22FAWsoaV7y+I5kmo7NW8uGjCUX1ZwAyWMEKlvja+ufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBSgbyc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E09C4CEF1;
	Fri, 24 Oct 2025 10:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303504;
	bh=m+pfjG9qzc5y9QbnPIMpZwGVfopUom8AcMnRPDQcZaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UBSgbyc9LNiC4nk00FHFX+8vYyMCbrKgtFW3rEtRKzB4FO62lN75caEZUdKCyTiyr
	 TN782lYpj4Jo8M7OLYvNUVExX09PcbJo6bUZJFDx4gpdf3q+qd3k7LP3wupEmR0M9l
	 aY7UFb2TmC3cfb8JRRv4JKR1FJ5yWzH+A1AFQI/o89mMWEni/wJ0mza+1Gn5aYOvdc
	 ljO+00xGL6gRSkTbJ3rPcA3iYNcYn7EovBGt1IDbZcJBHBlYegZZ9KL7amuaxqjBPH
	 KEgSaCE83mRPRZwRpXV2IDGVJr9eUqpTUkQe9Dk03cd4Tid42NHQEiQVWaTmy6sBgk
	 u1xsy4i5yxPpw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:27 +0200
Subject: [PATCH v3 58/70] selftests/namespaces: sixth inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-58-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmpfmsC9wugtd4HeA82wlXISnN/X5/hHZEcGJ1reS
 XRln8zWUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBF7LYb/PjtELaZHf/+2Jdh8
 rnGJuH+7x9q09Xd0tusHl1aU+tSvZWR4aL1Oq/RD+d0Ec85jvEbdxo2bJzBcNtcSMF7o9G3SvCB
 2AA==
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


