Return-Path: <linux-fsdevel+bounces-65187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 610E7BFD359
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E53734BE5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1ED37ECDA;
	Wed, 22 Oct 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rT6uLl14"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD52F34B18F;
	Wed, 22 Oct 2025 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149479; cv=none; b=P5HSNRnphRXmTrPIc+hoFrr/QHiHTuRY1FIThQW/mRDt+ZIkndnduzb3ECwBpO6DH8njAIT4qw3jlhQQTgRjiRpkpvaVuZFUg80QdO0shf24OTziUW5I3Xyjd0jFiJNBXuFncQ8u4D5HXBRm5LUvt12WzRbPpLD71ChgKY52/Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149479; c=relaxed/simple;
	bh=pqDbtFvmIISrOx6K7KWbVnqojUaOo6VRP9RWZVJYLQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OKd6y+LZs/t5eAbA1dv+LQf4qRVkN5P+Mac8YWvGqNO7XCjHoCfdbjZpADUvOjBfBdVQfE7zs0w88fSkihtOWu1m6JGAU9pMKcvbTVDOIq93GiLgm6X5ABgSNlo20R9FVJb1Lmi9Nj8OSjb1dET8Kxqe0KDsHbTlwE4TmSYR4LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rT6uLl14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C53C4CEF7;
	Wed, 22 Oct 2025 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149479;
	bh=pqDbtFvmIISrOx6K7KWbVnqojUaOo6VRP9RWZVJYLQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rT6uLl14V1T/r2lFY23lNT4HxYTQTpV70Zw+fxSD8XbzRDb1hgoHvt3qR4m+yVC4w
	 MchbmBqsoQsEuwMSMh4WhvLqgF5Gq1TS6EiJDRu+Sbr2ZHbYXwntyLOsjZKOdFyMD2
	 D7G8/ikVLlHJg2jYZs/THddDx9Nh9gvf+0p6vj01r5ETxfOtoDkSHkqVw2DgKofTHM
	 fWNPQv1uKEtKuqgMlYJCGV0UEebEhFBrOZyBkCALXN2GFns+wjSv22JK5LBb58CTwt
	 MP/DhnSg9mOZXr1KAKnBRi9KxlJMY9EfvgRMrVFyZT+sJZHRRZSDdWhANrASnPOisd
	 ebs+nCMb7Yozg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:37 +0200
Subject: [PATCH v2 59/63] selftests/namespaces: eigth inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-59-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1467; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pqDbtFvmIISrOx6K7KWbVnqojUaOo6VRP9RWZVJYLQI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHievFVr2qJre5ZrSSSbFuj4KL/S0Vj+4gzXc5G7C
 RF/nXYXdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkwZ3hn6roy4XV+QnLLk+w
 FeZU0n3xfpo8z5xQfR/LrpodeT0p5xn+ykg5XjLO/O9tpcXiYWjRduDIl6OPm5t+3FWaqWx1X3U
 SOwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test IPv6 sockets also work with SIOCGSKNS.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index 17f2cafb75a7..1c40c7772ad4 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -543,4 +543,38 @@ TEST(siocgskns_netns_lifecycle)
 	close(sock_fd);
 }
 
+/*
+ * Test IPv6 sockets also work with SIOCGSKNS.
+ */
+TEST(siocgskns_ipv6)
+{
+	int sock_fd, netns_fd, current_netns_fd;
+	struct stat st1, st2;
+
+	/* Create an IPv6 TCP socket */
+	sock_fd = socket(AF_INET6, SOCK_STREAM, 0);
+	ASSERT_GE(sock_fd, 0);
+
+	/* Use SIOCGSKNS */
+	netns_fd = ioctl(sock_fd, SIOCGSKNS);
+	if (netns_fd < 0) {
+		close(sock_fd);
+		if (errno == ENOTTY || errno == EINVAL)
+			SKIP(return, "SIOCGSKNS not supported");
+		ASSERT_GE(netns_fd, 0);
+	}
+
+	/* Verify it matches current namespace */
+	current_netns_fd = open("/proc/self/ns/net", O_RDONLY);
+	ASSERT_GE(current_netns_fd, 0);
+
+	ASSERT_EQ(fstat(netns_fd, &st1), 0);
+	ASSERT_EQ(fstat(current_netns_fd, &st2), 0);
+	ASSERT_EQ(st1.st_ino, st2.st_ino);
+
+	close(sock_fd);
+	close(netns_fd);
+	close(current_netns_fd);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


