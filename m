Return-Path: <linux-fsdevel+bounces-66255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B829C1A48C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB249357032
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9388380840;
	Wed, 29 Oct 2025 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftoIVkHd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19F34BA52;
	Wed, 29 Oct 2025 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740652; cv=none; b=Vzq77ssWxtqLmtsVGs7/NCoLujjltpUb7wXt+3X8hNuHw6Gwk4LRvafZh/ojRBMqHQwCUlRglh0OzkLDpkVq/odlUAg2M3pPzAkPnBJSGzrFCMgZgpJRjhaRgmB4tCILumsNL9YOOz/FhHDrXyyFsZ/hkttyJhBqJsoZEemWLWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740652; c=relaxed/simple;
	bh=UxNNzwwfXU08oQlPAvQ0Gj3cx0fWVzo9FwN6OUP3IWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khKvmfK0uSlo63L3gsALq35uhSmaujLGl7qSRuuap/F9loO6FOugIS/zjdyAz96X4lv50dXSjgM5S7OjRMpCGdR0kiTw4bBDDPTIDfaNTQAlsnj+opdpF6mF+vBpg8JHmivLl85TJHBcelN/bjEHeQVhKc63kNsKaNqhVqSadjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftoIVkHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CF2C4CEF7;
	Wed, 29 Oct 2025 12:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740651;
	bh=UxNNzwwfXU08oQlPAvQ0Gj3cx0fWVzo9FwN6OUP3IWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ftoIVkHdaHfvZvDFqD5bJCyr/vQKZVvfkxYmmXsO45DF7XhPQ9TspaV2/6Wrocxg3
	 Wb62lGG2CoAyPPpCUDbo1drl0TYoj1Lcc/mH5W01CNhP4CzJHTvkaytd40jas8ZQTQ
	 0DaxXSLBU5TmU3K3qEgJ2/PBubJh+gpZSn4nE1j9q5QAVDZgzadNg1f0vwOrj3WA/n
	 e5lUNA8MKwPzdb0aEcaR501Pr0vb5rhc3NbDvhvI7/WESioLxNxJnDll3I80ie81ng
	 3U9XxnKm5xQQNc7L2SAg9e3Nr3Wt+Ux0hPXTkHwQhsH2wGLtcTOuEe/tiaV3GA5Opg
	 RG33PJpsTZI/w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:55 +0100
Subject: [PATCH v4 42/72] selftests/namespaces: fourth listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-42-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UxNNzwwfXU08oQlPAvQ0Gj3cx0fWVzo9FwN6OUP3IWE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfWtj/Ll/T6XfW9MvsXJh290nPwb7wTcfz2Dd2tjx
 Z2Xp10OdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk5DXDXxmVaXeyV3Y/Mvmb
 sHHeB8O2wvKFV2y+20lUPrxmOy0w0Inhn0bbI8WeA1vPP99objXpYXyxzEuJlU39sS9Ws2294TN
 bgA8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test listns() with LISTNS_CURRENT_USER.
List namespaces owned by current user namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/listns_test.c | 33 ++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index 7dff63a00263..457298cb4c64 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -168,4 +168,37 @@ TEST(listns_pagination)
 	}
 }
 
+/*
+ * Test listns() with LISTNS_CURRENT_USER.
+ * List namespaces owned by current user namespace.
+ */
+TEST(listns_current_user)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = 0,
+		.spare2 = 0,
+		.user_ns_id = LISTNS_CURRENT_USER,
+	};
+	__u64 ns_ids[100];
+	ssize_t ret;
+
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		TH_LOG("listns failed: %s (errno=%d)", strerror(errno), errno);
+		ASSERT_TRUE(false);
+	}
+	ASSERT_GE(ret, 0);
+
+	/* Should find at least the initial namespaces if we're in init_user_ns */
+	TH_LOG("Found %zd namespaces owned by current user namespace", ret);
+
+	for (ssize_t i = 0; i < ret; i++)
+		TH_LOG("  [%zd] ns_id: %llu", i, (unsigned long long)ns_ids[i]);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


