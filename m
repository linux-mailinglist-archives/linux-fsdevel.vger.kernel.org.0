Return-Path: <linux-fsdevel+bounces-66257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA213C1A501
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23BF418807E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62CA380F40;
	Wed, 29 Oct 2025 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7Z+wMDI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F4E341AC7;
	Wed, 29 Oct 2025 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740662; cv=none; b=egPJ8+TskSp+eyyP8Mj8KVPern/y2DrrvjaDYlzBOhDz7Kzpdn8Pi6Onj33Ithpsl35JITlFImsXIXt5OBmQ4hKjwyFgFsL5nlC8378/qwT6e8vhxk2lJxpraZpV0J77bSPl86ITU5bzXBHmDdUGNs/7bBiVLDB5TYVfe5E/2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740662; c=relaxed/simple;
	bh=KSlU7UvLSHSGPJJgTeCWtnFjFzuANwkcv8D+4cZnjGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CuEfOwMDHInJyI9oyDm6RQ2rEwUzDFRDh5/ePAFVWw318ZKwnoURXa8NVjMhfMzoqILDdVclfynpa0chKIzoQ/B8BrYl7TxTO9KwjywG3Sfk/748XLy846S4ABAX2JlJxtCpk1st4pd0movuIf76VlwqLMk7bsUWzz5gO5Hi7tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7Z+wMDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27056C4CEF7;
	Wed, 29 Oct 2025 12:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740661;
	bh=KSlU7UvLSHSGPJJgTeCWtnFjFzuANwkcv8D+4cZnjGE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C7Z+wMDIKfFZDYKNJYvMlsFszCuIrMyQ1q+TRgcsdo0V68HBPqlgucacwnQEhO3Q1
	 mpRWjw1SFF8RYOHjQ3xQ3vIfuiIDxcbi1yC4ucF+YK3i5GkLHcDqIXNHltuRmCxJR8
	 y7ZT0MAReI/Hm/+XfuQu/LH5rLVxm3Oa66fWLi0bWpOt7ROD3ZImB/P23ICQNFOatV
	 PsTTMuInnkG9gNqfN0874nNhzxmfxZAvCeDg2+v7YB8RGKMgARSlYcPqQfswio2m/L
	 gyknbwQTDCUESweMp8UivBYOGUGxVApSL5pULvmyZGUb/LPuM9LOKTapI8ZkjEiyUe
	 xX0p9TCTYRzJw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:57 +0100
Subject: [PATCH v4 44/72] selftests/namespaces: sixth listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-44-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3583; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KSlU7UvLSHSGPJJgTeCWtnFjFzuANwkcv8D+4cZnjGE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfU1TZSJnXnDq6GjrfxM++wYhX5rhXt1qz3u/Jug+
 u6ChN3qjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIksXMjIcGPV55Xx633d7vJI
 6J7Y/fHB5istyROX1qo8igjflOWU9J6R4dedv5++7qxvtr1f5PfvU7mh4p50r8b3+o0K13y2Jkz
 N4gYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test listns() with specific user namespace ID.
Create a user namespace and list namespaces it owns.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/listns_test.c | 122 +++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index a04ebe11ce2c..f5b8bc5d111f 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <linux/nsfs.h>
 #include <sys/ioctl.h>
+#include <sys/socket.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
@@ -324,4 +325,125 @@ TEST(listns_only_active)
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
+	int sv[2];
+	pid_t pid;
+	int status;
+	__u64 user_ns_id = 0;
+	int bytes;
+	ssize_t ret;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sv), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int fd;
+		__u64 ns_id;
+		char buf;
+
+		close(sv[0]);
+
+		/* Create new user namespace */
+		if (setup_userns() < 0) {
+			close(sv[1]);
+			exit(1);
+		}
+
+		/* Get user namespace ID */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(sv[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &ns_id) < 0) {
+			close(fd);
+			close(sv[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* Send ID to parent */
+		if (write(sv[1], &ns_id, sizeof(ns_id)) != sizeof(ns_id)) {
+			close(sv[1]);
+			exit(1);
+		}
+
+		/* Create some namespaces owned by this user namespace */
+		unshare(CLONE_NEWNET);
+		unshare(CLONE_NEWUTS);
+
+		/* Wait for parent signal */
+		if (read(sv[1], &buf, 1) != 1) {
+			close(sv[1]);
+			exit(1);
+		}
+		close(sv[1]);
+		exit(0);
+	}
+
+	/* Parent */
+	close(sv[1]);
+	bytes = read(sv[0], &user_ns_id, sizeof(user_ns_id));
+
+	if (bytes != sizeof(user_ns_id)) {
+		close(sv[0]);
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
+		close(sv[0]);
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
+	if (write(sv[0], "X", 1) != 1) {
+		close(sv[0]);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		ASSERT_TRUE(false);
+	}
+	close(sv[0]);
+	waitpid(pid, &status, 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


