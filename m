Return-Path: <linux-fsdevel+bounces-66271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFA5C1A639
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFF61A66B51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6360033F362;
	Wed, 29 Oct 2025 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr0R3nwM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE1354716;
	Wed, 29 Oct 2025 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740732; cv=none; b=YTE6nR0PHC8M8D3SizEuR/2MaBEi7VxZ42dTWMDfni6rxg+NMPbu/SrQA0Pf6ZnNCes7opJArHKJHf8ILf36gs1OQx9Y4WXfKPmlZM71cqGRf9vyu/0e689uAiscnk1vHXnqSw42V0HEU8t1LUunTxfkWQrxPIKJ4v5TrwVr6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740732; c=relaxed/simple;
	bh=BCihYefUNETnf9SgrifE/6AmFo1JxPKscMdQ4tQ9EDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTtYliKeNNhunEPHlojFWSfASnHeYrWhMGJvPFcG/c9FITcFUeuQsFg8eaiwlFMz4HgN8vtmWT02iLv8CSr5M73v5ZBI2Ep4CA0i9+8ib29RqUFqTT1Z52xPpltsBnJ6wJDxbDMI9HpiXShStJBeu6yhmvZhWfdb4flenXvFP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sr0R3nwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882C1C4CEFF;
	Wed, 29 Oct 2025 12:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740732;
	bh=BCihYefUNETnf9SgrifE/6AmFo1JxPKscMdQ4tQ9EDw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sr0R3nwM5NELIOUxeHFV5+E4EBYvw2gEiBldk/HJs9GAV5J7av2zSZrrOMFkSc+6B
	 rKEqRxqpgZpwGPuOy/hsUWyJsjI0tZGNyLnQGyXrjgzJ5sELCDZlItHUlGpBvQtGhq
	 Yx8sO9daT50YbyWJoUrM8PnUPY4MxvO6nTh160C/fXbpHPRzt1n9OGyqA3PeeBTsw4
	 dUbqo9suklAUEQXtVQPuTjOfHWJEskK7B83n+AfqsHzavuD/3EyAR2YHuqBl/CcdcB
	 8n12rlBg/J8Y7PEh+j9i0Ror/prXwk6UOQ/1BKU+qaUOo3x4gVTGJwAZDGQcoscBJ1
	 u/g+8z/JuT3ow==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:11 +0100
Subject: [PATCH v4 58/72] selftests/namespaces: fourth inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-58-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BCihYefUNETnf9SgrifE/6AmFo1JxPKscMdQ4tQ9EDw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfU/Dskrzf3c4/LL1mTHfo1p52W8zvlltWyQud3Uw
 SpSsOtfRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ0hBgZzu2d8ON8/WeNG91l
 GxZfzootELJ60LVggUW1r3JE9f4LTIwME9i2asyMXtxtN82j/cWTjKAA7pbZ4jYlsx++3HrqvtB
 9BgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test SIOCGSKNS across setns. Create a socket in netns A, switch to netns
B, verify SIOCGSKNS still returns netns A.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index 02798e59fc11..28e45954c4fa 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -256,4 +256,55 @@ TEST(siocgskns_socket_types)
 	close(sock_udp);
 }
 
+/*
+ * Test SIOCGSKNS across setns.
+ * Create a socket in netns A, switch to netns B, verify SIOCGSKNS still
+ * returns netns A.
+ */
+TEST(siocgskns_across_setns)
+{
+	int sock_fd, netns_a_fd, netns_b_fd, result_fd;
+	struct stat st_a;
+
+	/* Get current netns (A) */
+	netns_a_fd = open("/proc/self/ns/net", O_RDONLY);
+	ASSERT_GE(netns_a_fd, 0);
+	ASSERT_EQ(fstat(netns_a_fd, &st_a), 0);
+
+	/* Create socket in netns A */
+	sock_fd = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(sock_fd, 0);
+
+	/* Create new netns (B) */
+	ASSERT_EQ(unshare(CLONE_NEWNET), 0);
+
+	netns_b_fd = open("/proc/self/ns/net", O_RDONLY);
+	ASSERT_GE(netns_b_fd, 0);
+
+	/* Get netns from socket created in A */
+	result_fd = ioctl(sock_fd, SIOCGSKNS);
+	if (result_fd < 0) {
+		close(sock_fd);
+		setns(netns_a_fd, CLONE_NEWNET);
+		close(netns_a_fd);
+		close(netns_b_fd);
+		if (errno == ENOTTY || errno == EINVAL)
+			SKIP(return, "SIOCGSKNS not supported");
+		ASSERT_GE(result_fd, 0);
+	}
+
+	/* Verify it still points to netns A */
+	struct stat st_result_stat;
+	ASSERT_EQ(fstat(result_fd, &st_result_stat), 0);
+	ASSERT_EQ(st_a.st_ino, st_result_stat.st_ino);
+
+	close(result_fd);
+	close(sock_fd);
+	close(netns_b_fd);
+
+	/* Restore original netns */
+	ASSERT_EQ(setns(netns_a_fd, CLONE_NEWNET), 0);
+	close(netns_a_fd);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


