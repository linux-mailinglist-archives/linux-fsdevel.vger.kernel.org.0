Return-Path: <linux-fsdevel+bounces-67715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBFCC477A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BC8189453D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA7331A055;
	Mon, 10 Nov 2025 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9zyvTrq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5221D31961B;
	Mon, 10 Nov 2025 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787411; cv=none; b=K0qQooWdOxmYZzckixfJK8ueaBXZ6ZvDEl7gwIAb7HdmKEUtwg3Vwoe83GzNBD6/EvVTM6ROBsqDcdL96D83VVBYl+b8JTqfKY+wXuboaUxTSpCpltM3pds+hWjPxpOm+3r84esUgKPdRFaI29cOq5tfXgBWD5sMUWPa3RLLm9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787411; c=relaxed/simple;
	bh=vStTifAnsGYOUzCE5jCoRuplSOsVaGyUhlN49sEMm2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t9IwyMpiS9vZHk9nVAFXdQAVhGmGhZZFW/HljyKVRGUTU1RkRFy8qDtuWo9wfDd6EE7f5jSxn8WVLBCMZgqLiIWGLKc9gtrQvrjV0IjTDpIzAT83ZO2+u0RLmgRMBP8MsWdRkg4mswmUnh7vS8WHCjZEHaCtXhMh0bewu2bSHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9zyvTrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0319CC4CEFB;
	Mon, 10 Nov 2025 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787409;
	bh=vStTifAnsGYOUzCE5jCoRuplSOsVaGyUhlN49sEMm2I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M9zyvTrqvmM8kjq8pEZKJPOx0fn8q7QrrK+TkN/NZwC4xR2j7IsdkzIhY0SURqFzl
	 LKS0KF0Db23IVtgxk0r0HgR9UACZFqGCtDPMyfhAPN2ecd4x06aCnGEhMrlLyeiNkL
	 YePOwT92iRCBHke6TkYNRxNVr4Joo3Sk7RU5i/D41prAM7nJoAlDAi7PTmS/ZsHghD
	 xARoPvZmkRKuvOKdQlDCIR42WFnGz21/ThKSGGJ9lRqHy/nQb93rFl2Ba0atr4FAxn
	 rScsrHGufD5mjlDV3PW20Ja2k99udPDEIU5h4LSURIddlmLrWK0QzI1HI7z4x6meU+
	 NG3+OKurWiRkA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Nov 2025 16:08:29 +0100
Subject: [PATCH 17/17] selftests/namespaces: fix nsid tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-work-namespace-nstree-fixes-v1-17-e8a9264e0fb9@kernel.org>
References: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
In-Reply-To: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
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
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8375; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vStTifAnsGYOUzCE5jCoRuplSOsVaGyUhlN49sEMm2I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v+ycde+3E+K7pMO9zvv1Ul5vDRS5uOpjaFcFYdWx
 O0SEDZc21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARUXlGhkuHy/ds+vmk5OXc
 JLVtzucLtKWsxG8lvsmKWfkuWfjS9xmMDFNX2fuu/8/G8/hzlcgNJ9FH3rNZNgtklG46OIdD7fu
 PYxwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Ensure that we always kill and cleanup all processes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/nsid_test.c | 107 ++++++++++++-------------
 1 file changed, 51 insertions(+), 56 deletions(-)

diff --git a/tools/testing/selftests/namespaces/nsid_test.c b/tools/testing/selftests/namespaces/nsid_test.c
index e28accd74a57..527ade0a8673 100644
--- a/tools/testing/selftests/namespaces/nsid_test.c
+++ b/tools/testing/selftests/namespaces/nsid_test.c
@@ -6,6 +6,7 @@
 #include <libgen.h>
 #include <limits.h>
 #include <pthread.h>
+#include <signal.h>
 #include <string.h>
 #include <sys/mount.h>
 #include <poll.h>
@@ -14,12 +15,30 @@
 #include <sys/stat.h>
 #include <sys/socket.h>
 #include <sys/un.h>
+#include <sys/wait.h>
 #include <unistd.h>
 #include <linux/fs.h>
 #include <linux/limits.h>
 #include <linux/nsfs.h>
 #include "../kselftest_harness.h"
 
+/* Fixture for tests that create child processes */
+FIXTURE(nsid) {
+	pid_t child_pid;
+};
+
+FIXTURE_SETUP(nsid) {
+	self->child_pid = 0;
+}
+
+FIXTURE_TEARDOWN(nsid) {
+	/* Clean up any child process that may still be running */
+	if (self->child_pid > 0) {
+		kill(self->child_pid, SIGKILL);
+		waitpid(self->child_pid, NULL, 0);
+	}
+}
+
 TEST(nsid_mntns_basic)
 {
 	__u64 mnt_ns_id = 0;
@@ -44,7 +63,7 @@ TEST(nsid_mntns_basic)
 	close(fd_mntns);
 }
 
-TEST(nsid_mntns_separate)
+TEST_F(nsid, mntns_separate)
 {
 	__u64 parent_mnt_ns_id = 0;
 	__u64 child_mnt_ns_id = 0;
@@ -90,6 +109,9 @@ TEST(nsid_mntns_separate)
 		_exit(0);
 	}
 
+	/* Track child for cleanup */
+	self->child_pid = pid;
+
 	/* Parent process */
 	close(pipefd[1]);
 
@@ -99,8 +121,6 @@ TEST(nsid_mntns_separate)
 
 	if (buf == 'S') {
 		/* Child couldn't create namespace, skip test */
-		kill(pid, SIGTERM);
-		waitpid(pid, NULL, 0);
 		close(fd_parent_mntns);
 		SKIP(return, "No permission to create mount namespace");
 	}
@@ -123,10 +143,6 @@ TEST(nsid_mntns_separate)
 
 	close(fd_parent_mntns);
 	close(fd_child_mntns);
-
-	/* Clean up child process */
-	kill(pid, SIGTERM);
-	waitpid(pid, NULL, 0);
 }
 
 TEST(nsid_cgroupns_basic)
@@ -153,7 +169,7 @@ TEST(nsid_cgroupns_basic)
 	close(fd_cgroupns);
 }
 
-TEST(nsid_cgroupns_separate)
+TEST_F(nsid, cgroupns_separate)
 {
 	__u64 parent_cgroup_ns_id = 0;
 	__u64 child_cgroup_ns_id = 0;
@@ -199,6 +215,9 @@ TEST(nsid_cgroupns_separate)
 		_exit(0);
 	}
 
+	/* Track child for cleanup */
+	self->child_pid = pid;
+
 	/* Parent process */
 	close(pipefd[1]);
 
@@ -208,8 +227,6 @@ TEST(nsid_cgroupns_separate)
 
 	if (buf == 'S') {
 		/* Child couldn't create namespace, skip test */
-		kill(pid, SIGTERM);
-		waitpid(pid, NULL, 0);
 		close(fd_parent_cgroupns);
 		SKIP(return, "No permission to create cgroup namespace");
 	}
@@ -232,10 +249,6 @@ TEST(nsid_cgroupns_separate)
 
 	close(fd_parent_cgroupns);
 	close(fd_child_cgroupns);
-
-	/* Clean up child process */
-	kill(pid, SIGTERM);
-	waitpid(pid, NULL, 0);
 }
 
 TEST(nsid_ipcns_basic)
@@ -262,7 +275,7 @@ TEST(nsid_ipcns_basic)
 	close(fd_ipcns);
 }
 
-TEST(nsid_ipcns_separate)
+TEST_F(nsid, ipcns_separate)
 {
 	__u64 parent_ipc_ns_id = 0;
 	__u64 child_ipc_ns_id = 0;
@@ -308,6 +321,9 @@ TEST(nsid_ipcns_separate)
 		_exit(0);
 	}
 
+	/* Track child for cleanup */
+	self->child_pid = pid;
+
 	/* Parent process */
 	close(pipefd[1]);
 
@@ -317,8 +333,6 @@ TEST(nsid_ipcns_separate)
 
 	if (buf == 'S') {
 		/* Child couldn't create namespace, skip test */
-		kill(pid, SIGTERM);
-		waitpid(pid, NULL, 0);
 		close(fd_parent_ipcns);
 		SKIP(return, "No permission to create IPC namespace");
 	}
@@ -341,10 +355,6 @@ TEST(nsid_ipcns_separate)
 
 	close(fd_parent_ipcns);
 	close(fd_child_ipcns);
-
-	/* Clean up child process */
-	kill(pid, SIGTERM);
-	waitpid(pid, NULL, 0);
 }
 
 TEST(nsid_utsns_basic)
@@ -371,7 +381,7 @@ TEST(nsid_utsns_basic)
 	close(fd_utsns);
 }
 
-TEST(nsid_utsns_separate)
+TEST_F(nsid, utsns_separate)
 {
 	__u64 parent_uts_ns_id = 0;
 	__u64 child_uts_ns_id = 0;
@@ -417,6 +427,9 @@ TEST(nsid_utsns_separate)
 		_exit(0);
 	}
 
+	/* Track child for cleanup */
+	self->child_pid = pid;
+
 	/* Parent process */
 	close(pipefd[1]);
 
@@ -426,8 +439,6 @@ TEST(nsid_utsns_separate)
 
 	if (buf == 'S') {
 		/* Child couldn't create namespace, skip test */
-		kill(pid, SIGTERM);
-		waitpid(pid, NULL, 0);
 		close(fd_parent_utsns);
 		SKIP(return, "No permission to create UTS namespace");
 	}
@@ -450,10 +461,6 @@ TEST(nsid_utsns_separate)
 
 	close(fd_parent_utsns);
 	close(fd_child_utsns);
-
-	/* Clean up child process */
-	kill(pid, SIGTERM);
-	waitpid(pid, NULL, 0);
 }
 
 TEST(nsid_userns_basic)
@@ -480,7 +487,7 @@ TEST(nsid_userns_basic)
 	close(fd_userns);
 }
 
-TEST(nsid_userns_separate)
+TEST_F(nsid, userns_separate)
 {
 	__u64 parent_user_ns_id = 0;
 	__u64 child_user_ns_id = 0;
@@ -526,6 +533,9 @@ TEST(nsid_userns_separate)
 		_exit(0);
 	}
 
+	/* Track child for cleanup */
+	self->child_pid = pid;
+
 	/* Parent process */
 	close(pipefd[1]);
 
@@ -535,8 +545,6 @@ TEST(nsid_userns_separate)
 
 	if (buf == 'S') {
 		/* Child couldn't create namespace, skip test */
-		kill(pid, SIGTERM);
-		waitpid(pid, NULL, 0);
 		close(fd_parent_userns);
 		SKIP(return, "No permission to create user namespace");
 	}
@@ -559,10 +567,6 @@ TEST(nsid_userns_separate)
 
 	close(fd_parent_userns);
 	close(fd_child_userns);
-
-	/* Clean up child process */
-	kill(pid, SIGTERM);
-	waitpid(pid, NULL, 0);
 }
 
 TEST(nsid_timens_basic)
@@ -591,7 +595,7 @@ TEST(nsid_timens_basic)
 	close(fd_timens);
 }
 
-TEST(nsid_timens_separate)
+TEST_F(nsid, timens_separate)
 {
 	__u64 parent_time_ns_id = 0;
 	__u64 child_time_ns_id = 0;
@@ -652,6 +656,9 @@ TEST(nsid_timens_separate)
 		}
 	}
 
+	/* Track child for cleanup */
+	self->child_pid = pid;
+
 	/* Parent process */
 	close(pipefd[1]);
 
@@ -660,8 +667,6 @@ TEST(nsid_timens_separate)
 
 	if (buf == 'S') {
 		/* Child couldn't create namespace, skip test */
-		kill(pid, SIGTERM);
-		waitpid(pid, NULL, 0);
 		close(fd_parent_timens);
 		close(pipefd[0]);
 		SKIP(return, "Cannot create time namespace");
@@ -689,10 +694,6 @@ TEST(nsid_timens_separate)
 
 	close(fd_parent_timens);
 	close(fd_child_timens);
-
-	/* Clean up child process */
-	kill(pid, SIGTERM);
-	waitpid(pid, NULL, 0);
 }
 
 TEST(nsid_pidns_basic)
@@ -719,7 +720,7 @@ TEST(nsid_pidns_basic)
 	close(fd_pidns);
 }
 
-TEST(nsid_pidns_separate)
+TEST_F(nsid, pidns_separate)
 {
 	__u64 parent_pid_ns_id = 0;
 	__u64 child_pid_ns_id = 0;
@@ -776,6 +777,9 @@ TEST(nsid_pidns_separate)
 		}
 	}
 
+	/* Track child for cleanup */
+	self->child_pid = pid;
+
 	/* Parent process */
 	close(pipefd[1]);
 
@@ -784,8 +788,6 @@ TEST(nsid_pidns_separate)
 
 	if (buf == 'S') {
 		/* Child couldn't create namespace, skip test */
-		kill(pid, SIGTERM);
-		waitpid(pid, NULL, 0);
 		close(fd_parent_pidns);
 		close(pipefd[0]);
 		SKIP(return, "No permission to create PID namespace");
@@ -813,10 +815,6 @@ TEST(nsid_pidns_separate)
 
 	close(fd_parent_pidns);
 	close(fd_child_pidns);
-
-	/* Clean up child process */
-	kill(pid, SIGTERM);
-	waitpid(pid, NULL, 0);
 }
 
 TEST(nsid_netns_basic)
@@ -860,7 +858,7 @@ TEST(nsid_netns_basic)
 	close(fd_netns);
 }
 
-TEST(nsid_netns_separate)
+TEST_F(nsid, netns_separate)
 {
 	__u64 parent_net_ns_id = 0;
 	__u64 parent_netns_cookie = 0;
@@ -920,6 +918,9 @@ TEST(nsid_netns_separate)
 		_exit(0);
 	}
 
+	/* Track child for cleanup */
+	self->child_pid = pid;
+
 	/* Parent process */
 	close(pipefd[1]);
 
@@ -929,8 +930,6 @@ TEST(nsid_netns_separate)
 
 	if (buf == 'S') {
 		/* Child couldn't create namespace, skip test */
-		kill(pid, SIGTERM);
-		waitpid(pid, NULL, 0);
 		close(fd_parent_netns);
 		close(parent_sock);
 		SKIP(return, "No permission to create network namespace");
@@ -977,10 +976,6 @@ TEST(nsid_netns_separate)
 	close(fd_parent_netns);
 	close(fd_child_netns);
 	close(parent_sock);
-
-	/* Clean up child process */
-	kill(pid, SIGTERM);
-	waitpid(pid, NULL, 0);
 }
 
 TEST_HARNESS_MAIN

-- 
2.47.3


