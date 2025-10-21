Return-Path: <linux-fsdevel+bounces-64898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9533BBF6525
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA95B3BC03D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1958E36CDF4;
	Tue, 21 Oct 2025 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDgbSmwq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698543385A5;
	Tue, 21 Oct 2025 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047277; cv=none; b=nMjZNFPHnFrPzlpwP8N832LP27uatWGO21FO2bRSrgQxIqwRBtRNpeQ++ir1QNIoj4r990BTsnBJspgeecJxkLvgUjrLKOwXXhC66hqtfOBMyDCwKo7/qFT/A62TNrCWGuSBEYuFyzr+5tRgAE4kfzxEANVx36rATEidB7M8d6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047277; c=relaxed/simple;
	bh=+NPTtaVGIJjtOfL6a6/pXZ3Jnd+MAnJdtzTqZX7/Ujw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I5et0nRdARzrmT7W2qxWaw8IUyc0XqAz218WXbn2xU8caHQjECZlSLXPVu+W95gxZCWsO2VoEvjKp84fn5dEHK+uERqhKUZdFRT0sW+2AhJ4seGv+1Xb3EPNcNgB/iMNh2689ErBoBf76lhnqqAqadKSb27XFwiqHMGmMsG7O3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDgbSmwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2173C4CEFF;
	Tue, 21 Oct 2025 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047277;
	bh=+NPTtaVGIJjtOfL6a6/pXZ3Jnd+MAnJdtzTqZX7/Ujw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sDgbSmwq898kGjkUjUwVIwoEkgrf7TcaAc55pOq4cCKu3wKjPA1gdS4QJ7T8EXg5Q
	 Rtn7VCQHzcNgDlGdTwOv2P7wCmujE65XhP3tlW5ViHy7EN4qee0hV42d1XPXOTDwRs
	 YTelbwE79ucRHxmV2qGKTm8VrfvKeK5CgKUGl4pEvEi8Yy1+ucW4ZAk+R6GHOcprnO
	 dpNerNU7R2jbZ0DVRKymzrKOwWPMHPL/GqAfMQ91RONRIpzpqAhZ2VFnTq8m3m1fme
	 vEOpMX7nUny83mVla4JT6CagyVHkvb8T5ECepC1bbXkHzDTzXsvLAIOo1goVh17P3x
	 HSoNDJJ3gKSlQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:53 +0200
Subject: [PATCH RFC DRAFT 47/50] selftests/namespaces: fourth listns()
 permission test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-47-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2557; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+NPTtaVGIJjtOfL6a6/pXZ3Jnd+MAnJdtzTqZX7/Ujw=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGj3ce+grmB2YsNoDeIhC/++jqy+s2ytfxIZeAqtBH+rpl649
 Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmj3ce8ACgkQkcYbwGV43KLLJgD/SwaS
 xBs0dYddjUyS2N3tRkV+AmeLq+Zm2hikXtm7duIA+wU7pfQwovCuoj28FprhidsfVOsBQoWQ1yv
 cn0eMYJMO
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test permission checking with LISTNS_CURRENT_USER.
Verify that listing with LISTNS_CURRENT_USER respects permissions.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/listns_permissions_test.c | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_permissions_test.c b/tools/testing/selftests/namespaces/listns_permissions_test.c
index 4e47b4c82c56..ff42109779ca 100644
--- a/tools/testing/selftests/namespaces/listns_permissions_test.c
+++ b/tools/testing/selftests/namespaces/listns_permissions_test.c
@@ -372,4 +372,83 @@ TEST(listns_cannot_see_sibling_userns_namespaces)
 	TH_LOG("User namespace B correctly could not see sibling namespace A's network namespace");
 }
 
+/*
+ * Test permission checking with LISTNS_CURRENT_USER.
+ * Verify that listing with LISTNS_CURRENT_USER respects permissions.
+ */
+TEST(listns_current_user_permissions)
+{
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
+		struct ns_id_req req = {
+			.size = sizeof(req),
+			.spare = 0,
+			.ns_id = 0,
+			.ns_type = 0,
+			.spare2 = 0,
+			.user_ns_id = LISTNS_CURRENT_USER,
+		};
+		__u64 ns_ids[100];
+		ssize_t ret;
+		bool success;
+
+		close(pipefd[0]);
+
+		/* Create user namespace */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Create some namespaces owned by this user namespace */
+		if (unshare(CLONE_NEWNET) < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (unshare(CLONE_NEWUTS) < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* List with LISTNS_CURRENT_USER - should see our owned namespaces */
+		ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+
+		success = (ret >= 3);  /* At least user, net, uts */
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
+
+	if (WEXITSTATUS(status) != 0) {
+		SKIP(return, "Child failed to setup namespaces");
+	}
+
+	ASSERT_TRUE(success);
+	TH_LOG("LISTNS_CURRENT_USER returned %zd namespaces", count);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


