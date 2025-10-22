Return-Path: <linux-fsdevel+bounces-65169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E28BFD360
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB828500A2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7377E3587AF;
	Wed, 22 Oct 2025 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="segBop61"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2052773D2;
	Wed, 22 Oct 2025 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149384; cv=none; b=LlB3kVqhpcIVuHPrggLivEchkXD23b+3MihBWAUv0LHOsjAYQudPXqupaV+al70DVrpleERTI+xeWQMor9iasUE0+GqDeV4nqJYPW+l35/vivZvE/hKX1YzBG+f8idrgK6B+MvW65ZOmK259JRG4JoopJ2UBGcb1FAE+BGwy03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149384; c=relaxed/simple;
	bh=4vBs0iC1GliO+F4XrLBJxRIywFUw/24vdpBSDdc51/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZDqvT4dtN6YuUTVhCxP8yiBkgFDhWcbMqk3Yek7B2Pe6viz0bHZ8aoAdcRUDiDsE3OfxHWk7vFb7PF3o/vkpEW9X7VFyM8Rk570aYoQgTsiotdMMUnpfyzaTlALhOVN9HqrZJ99wRun3hFNyq79aTi1Y9aEdeCCfQgZy9z664Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=segBop61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487EFC116B1;
	Wed, 22 Oct 2025 16:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149384;
	bh=4vBs0iC1GliO+F4XrLBJxRIywFUw/24vdpBSDdc51/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=segBop61K5CiFuINcw38i+jzw/Ejfd4any0YnKLytyJjAfjWwfjj5bsytutEQzXOH
	 NZ8UK/ak2PNLzajBn3fTTcmW1lOWkae1lcRCFl6L4GcHsTO5kJMyAmOlsMtB0XNGr+
	 vGGF3bv2Vrt8ZUDNZmA9qOJ5rweRGu+vmt/hIZg144J4CiYp1vGUXEhM/wyYzyFJke
	 zDVNmznDs7z7sReoyEoy0V74F2pLhd/Ncrio0CpfCTroeFW4EWtgsVJ5nbRTaIgOMu
	 2grX3+W2pRWCoG7JwY+mGJo+7e8yTGWn1bWu9rKFbC+5B/tZ8qUv5CfIxMRyxhkXDF
	 2GFFzEcc/g8qQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:19 +0200
Subject: [PATCH v2 41/63] selftests/namespaces: sixth listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-41-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3170; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4vBs0iC1GliO+F4XrLBJxRIywFUw/24vdpBSDdc51/s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHgm+EP3RaW4VNXkwo8RsRkOefM1N1h9Wn1w4p8n6
 xoLD5xv7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIkfWMDGe/iu68J+63qmn7
 Wa2Mtw/+cd6ZyBzy4Al/xdy92R/eljAx/E+NvrDqfVfew6Xie0KTrMp+hc63edu27YqF7qke9V1
 bZ7ADAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test listns() with specific user namespace ID.
Create a user namespace and list namespaces it owns.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/listns_test.c | 109 +++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index e854794abe56..e1e90ef933cf 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -327,4 +327,113 @@ TEST(listns_only_active)
 	}
 }
 
+/*
+ * Test listns() with specific user namespace ID.
+ * Create a user namespace and list namespaces it owns.
+ */
+TEST(listns_specific_userns)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = 0,
+		.spare2 = 0,
+		.user_ns_id = 0,  /* Will be filled with created userns ID */
+	};
+	__u64 ns_ids[100];
+	int pipefd[2];
+	pid_t pid;
+	int status;
+	__u64 user_ns_id = 0;
+	int bytes;
+	ssize_t ret;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int fd;
+		__u64 ns_id;
+		char buf;
+
+		close(pipefd[0]);
+
+		/* Create new user namespace */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Get user namespace ID */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &ns_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* Send ID to parent */
+		write(pipefd[1], &ns_id, sizeof(ns_id));
+
+		/* Create some namespaces owned by this user namespace */
+		unshare(CLONE_NEWNET);
+		unshare(CLONE_NEWUTS);
+
+		/* Wait for parent signal */
+		read(pipefd[1], &buf, 1);
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent */
+	close(pipefd[1]);
+	bytes = read(pipefd[0], &user_ns_id, sizeof(user_ns_id));
+
+	if (bytes != sizeof(user_ns_id)) {
+		close(pipefd[0]);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to get user namespace ID from child");
+	}
+
+	TH_LOG("Child created user namespace with ID %llu", (unsigned long long)user_ns_id);
+
+	/* List namespaces owned by this user namespace */
+	req.user_ns_id = user_ns_id;
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+
+	if (ret < 0) {
+		TH_LOG("listns failed: %s (errno=%d)", strerror(errno), errno);
+		close(pipefd[0]);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		if (errno == ENOSYS) {
+			SKIP(return, "listns() not supported");
+		}
+		ASSERT_GE(ret, 0);
+	}
+
+	TH_LOG("Found %zd namespaces owned by user namespace %llu", ret,
+	       (unsigned long long)user_ns_id);
+
+	/* Should find at least the network and UTS namespaces we created */
+	if (ret > 0) {
+		for (ssize_t i = 0; i < ret && i < 10; i++)
+			TH_LOG("  [%zd] ns_id: %llu", i, (unsigned long long)ns_ids[i]);
+	}
+
+	/* Signal child to exit */
+	close(pipefd[0]);
+	waitpid(pid, &status, 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


