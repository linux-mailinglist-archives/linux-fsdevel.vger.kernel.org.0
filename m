Return-Path: <linux-fsdevel+bounces-65487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE89C05D57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD68B35AEB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE3C355027;
	Fri, 24 Oct 2025 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd6JHXJE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322831579F;
	Fri, 24 Oct 2025 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303419; cv=none; b=HOOHFyXJ8r+b29039xGSSYDiUUpIpC5p1UUoJpt5iZgcLEpzd/OGE90VISS8itb6G0DyJ1FzS72yut4VUTyw0X+R0mLijYRUhy7yvO1n3a7UFnaqR7w0Z87gOjI5/+UI/n9I/ufIqFb1A/kHbl+/8nluEstxaKXj81eaNg5fUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303419; c=relaxed/simple;
	bh=/wqqJQoHPy6n2tHb+24Li+Lu21E+HeJSWgV7yWDzDrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HAxaDyDBLQhmcpAjZbKQCMbYS3/ud5sue+uFMsm1RthQ0Lx/q3LiYlCI7/Y/86lnMmaLFJ/+F2Ej19ZOnqNwPREx2yKY1KwI+JkSMnMh2aT22ZycjIv3vLiKKvAU098NNEAf8rXunO8Bs0IWKtnTe1Whnq6pOdcY6xlaE92fZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd6JHXJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6049DC4CEF5;
	Fri, 24 Oct 2025 10:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303419;
	bh=/wqqJQoHPy6n2tHb+24Li+Lu21E+HeJSWgV7yWDzDrk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gd6JHXJEnkuJyVnUutC6WENomRFprtjaxjP5LCr+on0WziCzD1UrD+sV5i8QXKzXP
	 q32vZMuHkj0OBA+TUSaxVMsuTo7jYnu7og9AtNcLBzHLjE7TL7diCjXX7rX+fUwd0C
	 i40Fodwk8fD3Wh+OZG97N6wL2bU+KOU/Bc9XsMOgp8KTiT+ovcZmErPCS6nDa2TxVt
	 MJexFw51p0nbwGnHBqh6WBLM7Rbs4vqrMtqebKf8aUWUHE1Bp2ux2Bl7FWIDz1kNac
	 umB2qbNRevHT+M0d3vgCVLoclxyI0WsNbfLZxaSLC50+1Jdcd6tKIP95oN7DJ4w/9N
	 kdGb+iLOgHE9g==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:16 +0200
Subject: [PATCH v3 47/70] selftests/namespaces: second listns() permission
 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-47-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/wqqJQoHPy6n2tHb+24Li+Lu21E+HeJSWgV7yWDzDrk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmrXXHeaad/Dg8orr5aVVu0u8X85n+0Q6+cAHs7m/
 10Zd33vdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkTQwjw5pwV55zp3QFclVn
 /ux7FH3qlfrRI9euCOqtW2zk+DdL/ibDH67T+6fNzH6ko/xowWTZU7xXinbu9X5VejaHZ2lDvmv
 yUhYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that users with CAP_SYS_ADMIN in a user namespace can see
all namespaces owned by that user namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/listns_permissions_test.c | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_permissions_test.c b/tools/testing/selftests/namespaces/listns_permissions_test.c
index 907fe419ec22..c99c87cca046 100644
--- a/tools/testing/selftests/namespaces/listns_permissions_test.c
+++ b/tools/testing/selftests/namespaces/listns_permissions_test.c
@@ -128,4 +128,104 @@ TEST(listns_unprivileged_current_only)
 			unexpected_count);
 }
 
+/*
+ * Test that users with CAP_SYS_ADMIN in a user namespace can see
+ * all namespaces owned by that user namespace.
+ */
+TEST(listns_cap_sys_admin_in_userns)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = 0,  /* All types */
+		.spare2 = 0,
+		.user_ns_id = 0,  /* Will be set to our created user namespace */
+	};
+	__u64 ns_ids[100];
+	int pipefd[2];
+	pid_t pid;
+	int status;
+	bool success;
+	ssize_t count;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int fd;
+		__u64 userns_id;
+		ssize_t ret;
+		int min_expected;
+		bool success;
+
+		close(pipefd[0]);
+
+		/* Create user namespace - we'll have CAP_SYS_ADMIN in it */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Get the user namespace ID */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &userns_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* Create several namespaces owned by this user namespace */
+		unshare(CLONE_NEWNET);
+		unshare(CLONE_NEWUTS);
+		unshare(CLONE_NEWIPC);
+
+		/* List namespaces owned by our user namespace */
+		req.user_ns_id = userns_id;
+		ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+		if (ret < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/*
+		 * We have CAP_SYS_ADMIN in this user namespace,
+		 * so we should see all namespaces owned by it.
+		 * That includes: net, uts, ipc, and the user namespace itself.
+		 */
+		min_expected = 4;
+		success = (ret >= min_expected);
+
+		write(pipefd[1], &success, sizeof(success));
+		write(pipefd[1], &ret, sizeof(ret));
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent */
+	close(pipefd[1]);
+
+	success = false;
+	count = 0;
+	read(pipefd[0], &success, sizeof(success));
+	read(pipefd[0], &count, sizeof(count));
+	close(pipefd[0]);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	ASSERT_TRUE(success);
+	TH_LOG("User with CAP_SYS_ADMIN saw %zd namespaces owned by their user namespace",
+			count);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


