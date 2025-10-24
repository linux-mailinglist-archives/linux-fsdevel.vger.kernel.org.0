Return-Path: <linux-fsdevel+bounces-65500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4587C05EE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9756B19A0116
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026BF368F5B;
	Fri, 24 Oct 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bT3nUuPq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD03128BF;
	Fri, 24 Oct 2025 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303515; cv=none; b=lP3eOkGs3vTYfrgi//n6KBwYh1kxifXvUSYF7j2WefM9SEuRtmchAPcxtRbcP9iMiFm1t7yRq4f+p3bshu3y9t+5UiwhKJpPWGiFDgqQmgrVZIa8KiYGshkfB5qf1JTym1PzN4Vv7pQlWtn/SmpFtXUxGgdmOCi9bnlRi8NH0HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303515; c=relaxed/simple;
	bh=VBORRP+h0KErK54FHs98ti+2CEgWK2XfNgSQLs2e/YU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nm+4MzCLaod8VsNoNOzn59CDc5vDrJWu5r4m7OLy0eu5lKgg0erIt3WWSqlEf4mlY5ad1N5CD6JnXvaTECNm4e2BNVMRgWn9TFdBGg5YuX2SGkojqrO8+w3Vkj2BntfehjmVDgTJn4wF9wDVBpG8kqH6W0orSW23xvnhsFy3Luo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bT3nUuPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490AEC4CEF1;
	Fri, 24 Oct 2025 10:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303514;
	bh=VBORRP+h0KErK54FHs98ti+2CEgWK2XfNgSQLs2e/YU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bT3nUuPqXS1+u2dJ5mTpEXg04aERyEjv4wHuQBxsv4ZM5g8pASQx50dfey6Dbv6Y8
	 ycW5FeU5zfvKyjZrEQh60f4otwVIvH3fdpbjyQN7FsT1Gaoi0V+MKIOZpJYd5xyaGD
	 T/UZLiL9I8MEUlZ23KugN4uc4ZNYaUuxAPZGX8zAKT2+X0bx/jV0vL0nfUV4YRUWYI
	 /g0L5WYK83FlhbdrYtyQzV9PlNrwdRBdtwPNM3qp1FkWB7dC1KvsKvM+dsBy+da2mi
	 OumSIHXRNY+q6xqRfgVESYm0FdavGVAfe81eP0EaxSs0IWolIiPEEcgQcPY65nNm0j
	 L4WvIcT7e6vPQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:29 +0200
Subject: [PATCH v3 60/70] selftests/namespaces: eigth inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-60-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1467; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VBORRP+h0KErK54FHs98ti+2CEgWK2XfNgSQLs2e/YU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmp3+C++dPJhg8MCa9LifQ//i1/13+Vyjnh8UIqO9
 c+kQ27PO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyV5bhf9AX8VxrMcM5/HuZ
 Kw8ffcn+O9K9+Ym+r+W2W0u5RZ4tjGD4p1v/zcnm7g636/eKq5rmtuVOk3AOs359viRKRCN6rrs
 oJwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test IPv6 sockets also work with SIOCGSKNS.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/namespaces/siocgskns_test.c  | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/namespaces/siocgskns_test.c b/tools/testing/selftests/namespaces/siocgskns_test.c
index 60028eeecde0..47c1524a8648 100644
--- a/tools/testing/selftests/namespaces/siocgskns_test.c
+++ b/tools/testing/selftests/namespaces/siocgskns_test.c
@@ -542,4 +542,38 @@ TEST(siocgskns_netns_lifecycle)
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


