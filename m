Return-Path: <linux-fsdevel+bounces-65174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D088FBFD515
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9554C3BDC7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14812C11FD;
	Wed, 22 Oct 2025 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aynBCV14"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C6B3590C7;
	Wed, 22 Oct 2025 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149411; cv=none; b=kVooqoK9drDwiWylapN/9C5AI0Zi8ARtm8N+Y9Dxh0YkbOpVSU4+D7K6jc7jhNEGZC/vSoWJ22jHRs61UIpS3OwWNsN8BciVaUrAkrvq6bV+JsTx7TwCT4udugab0nv3thuo7EqWJr+s1ewJHWpE4etqxSKi+X8rgtBo8clKSlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149411; c=relaxed/simple;
	bh=rZyevUn6hfyhcE1DB3cv3yJAhND3Rlxt9xlbt7Q4T1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=URu6oZxaOQMLqVi21L6l9BpV89MpdD94BZq4tAZ++o6cY4xbGHm0A86wCh2ySw2+lPWT/I2eWkFHfKYzKioCwUMV1wf5tsP/Cc+wC1p8jCneiL5iTFuz+9SA5SbROOWiieOJGSDY4nsD+R6+KOWoTOkpcXq6b6AeyM9nMU0X2rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aynBCV14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011EDC4CEE7;
	Wed, 22 Oct 2025 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149410;
	bh=rZyevUn6hfyhcE1DB3cv3yJAhND3Rlxt9xlbt7Q4T1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aynBCV14drdvlkI5OVh+cSdoZLeVi/bTdUqgyN7c3RkCKDaZ+vwnfSIPPIZ5v+k2+
	 U0m9fnt0pUN1+J5sDp/hHwVJtveTwMlvZbmdxNNlf4AbkdomL1ZOj8yclNK6y3ZCpr
	 sjAopqmouzgRc3hBKc+iC/rvt3lxB+2Q5H5OR0mqnr8k6cF+lat94pi8zILk/u5Xt4
	 myVVzsbBpPA+oiirsVywgKB0SjPdKabavkb49tjjMvpl9nj5PYsPm53UJ6mxLyXt1q
	 rwvAqf9qLggKfAwlvSDgPu4Vr8r78mq5eeJlznXCYoSSCynlj1n0137RtxiAuW/c1t
	 B3Cf3+iXR/5Bg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:24 +0200
Subject: [PATCH v2 46/63] selftests/namespaces: second listns() permission
 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-46-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3077; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rZyevUn6hfyhcE1DB3cv3yJAhND3Rlxt9xlbt7Q4T1s=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGj5AOfIqo/5x+ugoJC4nLGfrMBsvIibNo7EcJDWtGAtVxRHQ
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmj5AOcACgkQkcYbwGV43KI0nAD/WFlN
 wFDkt6TQIIXbHcevpPbxDm3Lp9gD8OWj6b+YDRwBAN2RrRhb1dUXuKKmdEo0QxmJOc734pdoX8p
 4YABB5ncB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that users with CAP_SYS_ADMIN in a user namespace can see
all namespaces owned by that user namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/listns_permissions_test.c | 103 +++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_permissions_test.c b/tools/testing/selftests/namespaces/listns_permissions_test.c
index 87ec71560d99..803c42fc76ec 100644
--- a/tools/testing/selftests/namespaces/listns_permissions_test.c
+++ b/tools/testing/selftests/namespaces/listns_permissions_test.c
@@ -131,4 +131,107 @@ TEST(listns_unprivileged_current_only)
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
+
+	if (WEXITSTATUS(status) != 0) {
+		SKIP(return, "Child failed to setup namespaces");
+	}
+
+	ASSERT_TRUE(success);
+	TH_LOG("User with CAP_SYS_ADMIN saw %zd namespaces owned by their user namespace",
+			count);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


