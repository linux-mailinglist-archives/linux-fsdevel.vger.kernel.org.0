Return-Path: <linux-fsdevel+bounces-66256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A83C1A4F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1E91A20D9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCAA380871;
	Wed, 29 Oct 2025 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slCZZcg8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC534C822;
	Wed, 29 Oct 2025 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740656; cv=none; b=fAeWvlLdZ2IUGXGsjFugOVeQHTdsxtyDUFH4teMVFZHQlr8UEvHkslAYeTSZHGlf34aONXNw5KtAhEO1LxfFqWKykB9uZ3MUH4G10JrMUeuDADJnE9QEy3Vz9BUscqpx4qSfgS2y8WgF+ItcGP0t7MYWtDYJhoRIxJycsdPuoGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740656; c=relaxed/simple;
	bh=6a8oUuByWnFcgaLPQi4hm9sjsEH0DS834LqCnnYNmeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TubYsJU+Rb3Zgqc6j3CRL/Q1QNEBTwYpfA4VuFJWTXFTtsn4qdTNPEEAyXnFFQ+GmgGXl2WfsbEn6lYvl425/zBn4uExaoOyPcJ5egSzb44h5zvrYiTsTnrOkMVMciIfNLH/ZgZs5IVa8CyjjhSVnDzJSCjPBQmxPHbagUbRlD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slCZZcg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10077C4CEFD;
	Wed, 29 Oct 2025 12:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740656;
	bh=6a8oUuByWnFcgaLPQi4hm9sjsEH0DS834LqCnnYNmeo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=slCZZcg8XwEvE+/l0vzNRsiCWIzKPvKAF4ksafYjkd1ulpQVZYOz17It4u8v8YlAf
	 9iYHstnopG4jTSBvhSKRrXwZtQ9uuU1nfaadn8LDWT3aSdIL4k/H8R1Qz+xJGJm7tS
	 YLf/Y1R7kyMTgFgPBkBBCW7akrX4+RVxiBJJtbCXiShwj6644T10uaig8p/1xXtYb7
	 tZtQqhsy5QVPXN0d3onkqxRNT1gEL8Xf+YUYJQHqUlhw3cmUw8IW7skkRK+Bww9/3k
	 tGIAlY4wqgstTznh62ICGCBWXe9/H4AnyjBYGoAhB+DJvV6ss8nrbe9iKgjazNhONw
	 MEqDmXM5Q0qAw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:56 +0100
Subject: [PATCH v4 43/72] selftests/namespaces: fifth listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-43-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3753; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6a8oUuByWnFcgaLPQi4hm9sjsEH0DS834LqCnnYNmeo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfXdO+ay7VTiD9PAEG4n9tdtajqF301Z5nanMUZXP
 OEK2juno5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKn6xgZ9gTO/cF8dMtT3cWp
 ofVzbmdNFGx3rdsQ7/H5R1l/aY95NCPDPPM6juIpzY8lO+o1jr4UnPyodbUF689t5rcUt/BUNte
 xAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that listns() only returns active namespaces.
Create a namespace, let it become inactive, verify it's not listed.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/listns_test.c | 123 +++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index 457298cb4c64..a04ebe11ce2c 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -201,4 +201,127 @@ TEST(listns_current_user)
 		TH_LOG("  [%zd] ns_id: %llu", i, (unsigned long long)ns_ids[i]);
 }
 
+/*
+ * Test that listns() only returns active namespaces.
+ * Create a namespace, let it become inactive, verify it's not listed.
+ */
+TEST(listns_only_active)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWNET,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids_before[100], ns_ids_after[100];
+	ssize_t ret_before, ret_after;
+	int pipefd[2];
+	pid_t pid;
+	__u64 new_ns_id = 0;
+	int status;
+
+	/* Get initial list */
+	ret_before = sys_listns(&req, ns_ids_before, ARRAY_SIZE(ns_ids_before), 0);
+	if (ret_before < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		TH_LOG("listns failed: %s (errno=%d)", strerror(errno), errno);
+		ASSERT_TRUE(false);
+	}
+	ASSERT_GE(ret_before, 0);
+
+	TH_LOG("Before: %zd active network namespaces", ret_before);
+
+	/* Create a new namespace in a child process and get its ID */
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int fd;
+		__u64 ns_id;
+
+		close(pipefd[0]);
+
+		/* Create new network namespace */
+		if (unshare(CLONE_NEWNET) < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Get its ID */
+		fd = open("/proc/self/ns/net", O_RDONLY);
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
+		close(pipefd[1]);
+
+		/* Keep namespace active briefly */
+		usleep(100000);
+		exit(0);
+	}
+
+	/* Parent reads the new namespace ID */
+	{
+		int bytes;
+
+		close(pipefd[1]);
+		bytes = read(pipefd[0], &new_ns_id, sizeof(new_ns_id));
+		close(pipefd[0]);
+
+		if (bytes == sizeof(new_ns_id)) {
+			__u64 ns_ids_during[100];
+			int ret_during;
+
+			TH_LOG("Child created namespace with ID %llu", (unsigned long long)new_ns_id);
+
+			/* List namespaces while child is still alive - should see new one */
+			ret_during = sys_listns(&req, ns_ids_during, ARRAY_SIZE(ns_ids_during), 0);
+			ASSERT_GE(ret_during, 0);
+			TH_LOG("During: %d active network namespaces", ret_during);
+
+			/* Should have more namespaces than before */
+			ASSERT_GE(ret_during, ret_before);
+		}
+	}
+
+	/* Wait for child to exit */
+	waitpid(pid, &status, 0);
+
+	/* Give time for namespace to become inactive */
+	usleep(100000);
+
+	/* List namespaces after child exits - should not see new one */
+	ret_after = sys_listns(&req, ns_ids_after, ARRAY_SIZE(ns_ids_after), 0);
+	ASSERT_GE(ret_after, 0);
+	TH_LOG("After: %zd active network namespaces", ret_after);
+
+	/* Verify the new namespace ID is not in the after list */
+	if (new_ns_id != 0) {
+		bool found = false;
+
+		for (ssize_t i = 0; i < ret_after; i++) {
+			if (ns_ids_after[i] == new_ns_id) {
+				found = true;
+				break;
+			}
+		}
+		ASSERT_FALSE(found);
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


