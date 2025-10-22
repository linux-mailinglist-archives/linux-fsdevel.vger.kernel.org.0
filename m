Return-Path: <linux-fsdevel+bounces-65185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D38BFD599
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE8A3BEF83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CE635A158;
	Wed, 22 Oct 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxxZxfWW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB7A35A122;
	Wed, 22 Oct 2025 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149469; cv=none; b=YSSMQaxXS03osGKJx2nulReY/536rC/XJ1VkyyVHJe9LnM5mMpkJGxpTgVMDYDzpHBwK0P9Ei+UlmrkoFhO/cd8pObn0/Uaz/tXcic7ZeukPNuispR8y0lgsERKKbcN5Tz2TcW3yC1mWjbwfzmukQBnYZTvoHjov2w7BKLlx71g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149469; c=relaxed/simple;
	bh=udWXbE5GIXnpNt82C6OUf1abPXO2lL6zpT/iVGrkFOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f7x1bpe73t9fmzNBg67wdJVvE6wmojYp4fJ2Zjzce+3yUuRuIp017moFUq2BKP1I0A+3nhGJsj0eAuTB+4HUZG8h2uVeNRd23bkUzi+cpdgyoSoaQWy31M8K+UatAEwNheKsi0uBdk9hAMmDHVsuD8jJ/7azhxxU4AAzkbW+P1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxxZxfWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676E6C4CEF7;
	Wed, 22 Oct 2025 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149469;
	bh=udWXbE5GIXnpNt82C6OUf1abPXO2lL6zpT/iVGrkFOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hxxZxfWWABrUFXrO/bZG0jmsm/Cx6NWBnP3oaWY9gDoYKBGY01W1AA1u5cmhY8aLI
	 K6LGQ+SA4RSZzTfGA6CaHz/2AA7R0mxXpD9RGPC0RrFH6KSnxBnXkFWWcnT1Bc5+ym
	 444k3iKuG6ZB030Rw0u8GZnac/pdCx03H5VfnarcwJl0kmkWxloBnNECT9xInwcpqf
	 sccmq8R1po/dbc3mgcnA0eUzxf6xMu+9JcijcwNWTrPfUGqj4TWUZDn3OVESy4LlvM
	 lriv3h4KIB+ig/nmusMCXx3y6zCEKVq2mPEMnxWafwgYg3YEpFNJTJivI/k9vYxNti
	 RTXJ6/gnw+Wog==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:35 +0200
Subject: [PATCH v2 57/63] selftests/namespaces: sixth inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-57-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2328; i=brauner@kernel.org;
 h=from:subject:message-id; bh=udWXbE5GIXnpNt82C6OUf1abPXO2lL6zpT/iVGrkFOU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHie7zDhYp3Dqp7nC3f/k1h/mlP3XfRW028z3trPf
 P3ru5vclo5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJSJ5lZHi9UUjmz/zFC2Wf
 rIsJrnp1f9vGd9fmbXW9e6Wsjaun7bs/wz9DwSxF10tWRy6+ij/4qKi3+eDTXAOBT9ffZHbdaFG
 X3MsOAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test multiple sockets keep the same network namespace active. Create
multiple sockets, verify closing some doesn't affect others.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index 4134a13c2f74..d11b3a9c4cfd 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -334,4 +334,72 @@ TEST(siocgskns_non_socket)
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


