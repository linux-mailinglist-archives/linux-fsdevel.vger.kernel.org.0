Return-Path: <linux-fsdevel+bounces-65496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2798C05EA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50413B7F10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8AD359FB9;
	Fri, 24 Oct 2025 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNyb7/5D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A109359F95;
	Fri, 24 Oct 2025 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303464; cv=none; b=tXpn3MKK50CrBSeQCucYJg4uyE71ciPc4XMAT1fYthBWu/YUG/Ct9pLTuo6wooQaE6CgNrmWL+/fmHt25ZIsZTED1jGq7h5TM3IiK9OoPe5x73dYDGkIVeayC7SQobqkFCWdIqp/W5vKhZGUWFRvb4pNol9onDmXDHX3571I4jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303464; c=relaxed/simple;
	bh=BCihYefUNETnf9SgrifE/6AmFo1JxPKscMdQ4tQ9EDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LQRjUHPg0arOnOPidHNNC+K8qrpv/i5rXAcf/Z7eqiLpw+b4iI2DAjOa0esP1BPlCDYM9OC7peubYXaF3a4uR/KDe0lfmhfrmqkK1iNoxxUH+18Sa0k5HQi16opcUbShN0pL3SQeXCJAkD07haPTqoq0jF8MNFoDF130xKN1xkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNyb7/5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E243EC113D0;
	Fri, 24 Oct 2025 10:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303464;
	bh=BCihYefUNETnf9SgrifE/6AmFo1JxPKscMdQ4tQ9EDw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nNyb7/5DUtDexae+j+ZgdLJera/saAvPv6qpaToXs2JbZ49bim7ADeJcqib15NdAj
	 6y03rXzSp1UVNnVftKGUWpA++RGKDhylYo87A0cF47xjsV18KanTQ4SbsJrBR+399y
	 BPHAE2w1wEu1pWei9YYG1gh012LIYP0A2yV54lwSxnb8YjobJcL6g+AokeJdH2Umlj
	 m9yfZj/9WwVemnMP/hlijWj7LZ7VfwRhxs95EiFaHd1mYHBdop2yrgqRPe1bj2c2dO
	 x8L56CXj12Xnt1jLIhKGqSvFHN1BLLR+TfNw4Pa3S8Rephqo2bZUZtfx4XFnQYqFt3
	 Sm6Y8TI3Iv8mw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:25 +0200
Subject: [PATCH v3 56/70] selftests/namespaces: fourth inactive namespace
 resurrection test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-56-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BCihYefUNETnf9SgrifE/6AmFo1JxPKscMdQ4tQ9EDw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmrX9VjosO/Ha9YF8pu+KXleMwgvtX9578f1Y+9+C
 ecq6ZvN6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIgnBGhm/Km7jW7jn9aHtj
 x8EnZTOtJ/QqvAg4Yst25kxOydf9tYaMDL82FV89fd2+7QDD/6ofP8/MnLtgZ+GKZ0Vfn9YmJqU
 vC+UHAA==
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


