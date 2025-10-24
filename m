Return-Path: <linux-fsdevel+bounces-65482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09715C05E0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 258A1501598
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC2D34DB54;
	Fri, 24 Oct 2025 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB11ZvRM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242AE315767;
	Fri, 24 Oct 2025 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303394; cv=none; b=cRFiizSw2kI7xug5tjfJRi/0r4PYVwEY6BKmJeFBBGeTFCufKUH9BBz13zSvHQSO5SQQuKw8BQhaEfto5pezqM2a1nHU2PiZ7id+GsveCrLIMlPHlsI10eCtCJ+MPFpFWhdtWOSKF0RyaZ52JdfobPbjJIQdTEu+bgRcOmi6db0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303394; c=relaxed/simple;
	bh=KSlU7UvLSHSGPJJgTeCWtnFjFzuANwkcv8D+4cZnjGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FqsF5CklcR+EhMlZHCPcp56iJ+xPiQvJslnXKm1uuo6wqOgQPIs9GVb+JcKToVqdUfvqfzBCW1+YyJF5qE8d1tbwxm44m/yHK4hI+TUjJipj++yZbaOYTJjiCnUPp667zY+YeCEBTwFyZH/cLEeOAeqGhO3/fZrw1VcI/akEv4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB11ZvRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC03C4CEF5;
	Fri, 24 Oct 2025 10:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303393;
	bh=KSlU7UvLSHSGPJJgTeCWtnFjFzuANwkcv8D+4cZnjGE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YB11ZvRMvYVJwEuw+oWADvI56G09uqmppB8eLypjYvCoPmhg16fTH+eFODMGlHkix
	 95uf4LQEuzG0fGkEV4tFl3joRZpqyRyr1UfeZXgh34+xXieBkkjoKEcEzDmmrKS4TZ
	 cgTBK6kbyTGK6uyJRSw7g5RKSLicD62wSg0ePuYQmJxb+mxrvWtgq8n9JnE9QnIz3T
	 rBwVbjdW8xrCpfV7h4Jb8YO/TOQ524yxhgLXHXgFA33IJ4d1kSc7f7NOHAR6G9OnqE
	 mommNkgTUeSYPiG2auT70/58PYfY5SpAs0DLmOdTlGMkKaUZkFdokWMAVZCt2evA6P
	 sEV3rYbzHM4QQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:11 +0200
Subject: [PATCH v3 42/70] selftests/namespaces: sixth listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-42-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3583; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KSlU7UvLSHSGPJJgTeCWtnFjFzuANwkcv8D+4cZnjGE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmpzEgtufH8nN2LrDL9Px6U2BU1PnnTscLzP5RsHX
 /isNtlo21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARx0hGhntxnKt0ONiO+v19
 OuvPHlvRF1XXmfc9Mqs7/Y7jfvOzbBuG/64VHQ3vim75nZxzoeicxuEGmSfdadwugXO/fK1sOV/
 ryQMA
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


