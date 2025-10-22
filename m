Return-Path: <linux-fsdevel+bounces-65179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0670CBFD3C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6AD5564700
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FFC380F5B;
	Wed, 22 Oct 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKNeh0Es"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194B380F36;
	Wed, 22 Oct 2025 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149437; cv=none; b=mvnXtvTXQmZKYCl/G87EhouSZO/Am9RsDp8/21vPbymRxzIzk4inBjXSPQy+A/wYi9loa5oYpRDm+t6BKpBTxj3V7H502XRz7wkvaxA+InG6SqYNGw27N54a50Ukv5qTHbxgvBWBruzr1yiChjFL2ClUGIK8vmvxeCnVdihX7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149437; c=relaxed/simple;
	bh=Jz2qZpRe8+RR2mHCIjuTDi9/gaS5B8ErVeSfakXzmUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N7F8meEGyiSzRi2b5PztyhinLHEvUdwqMzW06BUzZaub1IY0qyIdtvbV4MoWsC26WMhua39YUMd+Mpu0trQvTGngqkACK2gNT8lz8+cUGR9lXCmiDPZKldKVoS8gl+akgrGYadiWHa88Z1zcGbgM4IbAn0FWS1e18bfQQCZY7NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKNeh0Es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B97C4CEFD;
	Wed, 22 Oct 2025 16:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149437;
	bh=Jz2qZpRe8+RR2mHCIjuTDi9/gaS5B8ErVeSfakXzmUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CKNeh0Esf68YkqbfBA7BnsGES8vnsy3bC4GL/TbxCX+CjBSohB+fqiaCzc2U/gdk/
	 CNBMsnejsaFHJUZeNyT39s4ZJdJAa9UhH2tZdggwBTQJP2ConKKY2dX3R6GfUTFeFx
	 jVLhpSXEGuAsRGgTn8b9vESouduRugivaVMo7C6u9cL4bKO2/pnaD3gi0J3VgdF5GA
	 TWpeNoovW4Zvx3EgvqgkulEimoKLfeoVKM7fHIjXJfHcu65NAQJE6PGJaIyuUxjhO6
	 um+TlRDuP/NdByRfrQToM7G4p+wfiDit3CFveMhP4YcNbg49jzJmSJcDAmafcofdqs
	 7ZpOqzdW9223A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:29 +0200
Subject: [PATCH v2 51/63] selftests/namespaces: seventh listns() permission
 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-51-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3549; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Jz2qZpRe8+RR2mHCIjuTDi9/gaS5B8ErVeSfakXzmUk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHjO9p3XTJtl0rI3+hoLpm1kaLJ9pHl4o953ycu1/
 aY3ZRnedpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE3o7hf4LhhvbAZHvj4w58
 1xJrOOWe5S+TlVr6697LIgd1gayzzAz/HU5IKvj7ehZfWG6YqMruYqFkye5rOn3BK5YEiU2sUnO
 ZAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that dropping CAP_SYS_ADMIN restricts what we can see.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/listns_permissions_test.c | 111 +++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_permissions_test.c b/tools/testing/selftests/namespaces/listns_permissions_test.c
index 709250ce1542..9d1767e8b804 100644
--- a/tools/testing/selftests/namespaces/listns_permissions_test.c
+++ b/tools/testing/selftests/namespaces/listns_permissions_test.c
@@ -663,4 +663,115 @@ TEST(listns_cap_sys_admin_inside_userns)
 	TH_LOG("Process can see user namespace it has CAP_SYS_ADMIN inside of");
 }
 
+/*
+ * Test that dropping CAP_SYS_ADMIN restricts what we can see.
+ */
+TEST(listns_drop_cap_sys_admin)
+{
+	cap_t caps;
+	cap_value_t cap_list[1] = { CAP_SYS_ADMIN };
+
+	/* This test needs to start with CAP_SYS_ADMIN */
+	caps = cap_get_proc();
+	if (!caps) {
+		SKIP(return, "Cannot get capabilities");
+	}
+
+	cap_flag_value_t cap_val;
+	if (cap_get_flag(caps, CAP_SYS_ADMIN, CAP_EFFECTIVE, &cap_val) < 0) {
+		cap_free(caps);
+		SKIP(return, "Cannot check CAP_SYS_ADMIN");
+	}
+
+	if (cap_val != CAP_SET) {
+		cap_free(caps);
+		SKIP(return, "Test needs CAP_SYS_ADMIN to start");
+	}
+	cap_free(caps);
+
+	int pipefd[2];
+	pid_t pid;
+	int status;
+	bool correct;
+	ssize_t count_before, count_after;
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
+			.ns_type = CLONE_NEWNET,
+			.spare2 = 0,
+			.user_ns_id = LISTNS_CURRENT_USER,
+		};
+		__u64 ns_ids_before[100];
+		ssize_t count_before;
+		__u64 ns_ids_after[100];
+		ssize_t count_after;
+		bool correct;
+
+		close(pipefd[0]);
+
+		/* Create user namespace */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Count namespaces with CAP_SYS_ADMIN */
+		count_before = sys_listns(&req, ns_ids_before, ARRAY_SIZE(ns_ids_before), 0);
+
+		/* Drop CAP_SYS_ADMIN */
+		caps = cap_get_proc();
+		if (caps) {
+			cap_set_flag(caps, CAP_EFFECTIVE, 1, cap_list, CAP_CLEAR);
+			cap_set_flag(caps, CAP_PERMITTED, 1, cap_list, CAP_CLEAR);
+			cap_set_proc(caps);
+			cap_free(caps);
+		}
+
+		/* Ensure we can't regain the capability */
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+
+		/* Count namespaces without CAP_SYS_ADMIN */
+		count_after = sys_listns(&req, ns_ids_after, ARRAY_SIZE(ns_ids_after), 0);
+
+		/* Without CAP_SYS_ADMIN, we should see same or fewer namespaces */
+		correct = (count_after <= count_before);
+
+		write(pipefd[1], &correct, sizeof(correct));
+		write(pipefd[1], &count_before, sizeof(count_before));
+		write(pipefd[1], &count_after, sizeof(count_after));
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent */
+	close(pipefd[1]);
+
+	correct = false;
+	count_before = 0;
+	count_after = 0;
+	read(pipefd[0], &correct, sizeof(correct));
+	read(pipefd[0], &count_before, sizeof(count_before));
+	read(pipefd[0], &count_after, sizeof(count_after));
+	close(pipefd[0]);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+
+	if (WEXITSTATUS(status) != 0) {
+		SKIP(return, "Child failed to setup namespace");
+	}
+
+	ASSERT_TRUE(correct);
+	TH_LOG("With CAP_SYS_ADMIN: %zd namespaces, without: %zd namespaces",
+			count_before, count_after);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


