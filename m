Return-Path: <linux-fsdevel+bounces-65178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CF3BFD3F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C598508E4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F132338087B;
	Wed, 22 Oct 2025 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx/8vL6f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A4138084F;
	Wed, 22 Oct 2025 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149432; cv=none; b=CS1rckqs7hilA3IzINE/T8VmADwveQYrGouUXGtrw6p+/wwwJZs1M78mOSfcw9CP/29t0uUQMdsxwZCVMZtOY4znCr/8LxQkPK1iVM3TeSO5Gv5+COCowgFj13r1Ej2Sq1CVUdyAO0OdFXM37iRp9U65ZpkuK0FaEZ8XI82wcoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149432; c=relaxed/simple;
	bh=zyvSyEvHN08sO6ilDq1bp8H9I2nWZ5I4e4dJ8kwOeEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pqnbsd3bRq9Yitr5suEpeWOFjGw+SZvpAdpd2ICLpxHjsEqISrLzq5Fdx7vW/MmfETXws2du9lFIMKGyzOmx10/6eNlT/SN68Tbk+usQ1/tTzdS+qxjd5y0G8hV6AONrVS8Aysajtw0+JFOno6+Sbb+VFYseP4R6C6UPvRiw/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx/8vL6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31559C4CEE7;
	Wed, 22 Oct 2025 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149431;
	bh=zyvSyEvHN08sO6ilDq1bp8H9I2nWZ5I4e4dJ8kwOeEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yx/8vL6fbS2LQX0vxugkE9sEUoAY1yOkiPImm4ADxTm9aFcGAVM9hJ9vsOFBD46eI
	 gL+/R95gRhkoAbGrTnMXmdTZuX8EvWb4VaEshScjzwNhFhwCRCRdiZPvyZbHOVUSYi
	 YlMfIbRg5bNwMgeuIdh79Jjte8DAJFTjTVPy9uENz29faVRbLggEeX7hKfTIic0zon
	 f94ZAXjbKuCFR/QpEPxWMoY12r6R6rNPBHalwgZYOMp98PHqpWz93/hH4wPKBRxXpl
	 l2goOHuJXJpCX54xU8nZrmPHewbuiIg/ymVcNIlDd435BE8/kshORJiGqxrfydwBKN
	 X1ZPat1SoKMxg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:28 +0200
Subject: [PATCH v2 50/63] selftests/namespaces: sixth listns() permission
 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-50-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2704; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zyvSyEvHN08sO6ilDq1bp8H9I2nWZ5I4e4dJ8kwOeEM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHg+y/j+8oNrTL7dcLNuDnyTdlq3euPkw7wRUse4T
 +5zSPwS21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRa3MY/sfycbmtznLfdern
 qbyaZwJt62LF1S9UqjZwmH65ceff7yxGhsWS7/Y8zdeYxma6m+uh2o5YSwc5zZZNJ4QMGu0kNwv
 k8AIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that we can see user namespaces we have CAP_SYS_ADMIN inside of.
This is different from seeing namespaces owned by a user namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/listns_permissions_test.c | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_permissions_test.c b/tools/testing/selftests/namespaces/listns_permissions_test.c
index 07c0c2be0aa5..709250ce1542 100644
--- a/tools/testing/selftests/namespaces/listns_permissions_test.c
+++ b/tools/testing/selftests/namespaces/listns_permissions_test.c
@@ -573,4 +573,94 @@ TEST(listns_parent_userns_cap_sys_admin)
 			count);
 }
 
+/*
+ * Test that we can see user namespaces we have CAP_SYS_ADMIN inside of.
+ * This is different from seeing namespaces owned by a user namespace.
+ */
+TEST(listns_cap_sys_admin_inside_userns)
+{
+	int pipefd[2];
+	pid_t pid;
+	int status;
+	bool found_ours;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int fd;
+		__u64 our_userns_id;
+		struct ns_id_req req;
+		__u64 ns_ids[100];
+		ssize_t ret;
+		bool found_ours;
+
+		close(pipefd[0]);
+
+		/* Create user namespace - we have CAP_SYS_ADMIN inside it */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Get our user namespace ID */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &our_userns_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* List all user namespaces globally */
+		req.size = sizeof(req);
+		req.spare = 0;
+		req.ns_id = 0;
+		req.ns_type = CLONE_NEWUSER;
+		req.spare2 = 0;
+		req.user_ns_id = 0;
+
+		ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+
+		/* We should be able to see our own user namespace */
+		found_ours = false;
+		if (ret > 0) {
+			for (ssize_t i = 0; i < ret; i++) {
+				if (ns_ids[i] == our_userns_id) {
+					found_ours = true;
+					break;
+				}
+			}
+		}
+
+		write(pipefd[1], &found_ours, sizeof(found_ours));
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent */
+	close(pipefd[1]);
+
+	found_ours = false;
+	read(pipefd[0], &found_ours, sizeof(found_ours));
+	close(pipefd[0]);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+
+	if (WEXITSTATUS(status) != 0) {
+		SKIP(return, "Child failed to setup namespace");
+	}
+
+	ASSERT_TRUE(found_ours);
+	TH_LOG("Process can see user namespace it has CAP_SYS_ADMIN inside of");
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


