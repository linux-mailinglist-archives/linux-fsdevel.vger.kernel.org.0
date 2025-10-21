Return-Path: <linux-fsdevel+bounces-64887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86111BF6401
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32AB319A2363
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF7334B40E;
	Tue, 21 Oct 2025 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfSG10s5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C28532F764;
	Tue, 21 Oct 2025 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047221; cv=none; b=rARYKeZAlSzPZ/EmcBFk/sxNlyFbpM3LOaUOdO/CpN2Ia11oOQvw4ufFNmo/1tgAufpL78WDyXGakromYtQGuPYqJGlV0z9NLvtNhcc2UmMWkpmLP0LoUrjh2IJnElN945nlzQucMHC3woiXxZxc5HCMJdxuf+2Q1YXzjL1SgtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047221; c=relaxed/simple;
	bh=gPBGu8BceJ6oHRtyp7iwBf16DUj5zY+HNikOeiNBVYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tgXMQwmFkKod0km5XAUmpQbRuE7MyplmC7VHz84/Bier62aV9Xj8qfrwaZS+UCQeU0MJMPJwRiStjcOw6+jwa7nWTkTxEI/Rzibox0gudYG7QMlsIcovuSXmmB4+q1wQ7+WKqPzGqMRDoOL0OEi82lXatqFQuVUzz83Cr/BADeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfSG10s5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDB9C4CEFD;
	Tue, 21 Oct 2025 11:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047221;
	bh=gPBGu8BceJ6oHRtyp7iwBf16DUj5zY+HNikOeiNBVYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YfSG10s54jEggowkAvAe3GoaDOF7OpbN00+tcxBwbAj48co3u766V2hu9wwiUsXxe
	 KZI/CNLq6D8/78/60R/XWk8V9WMyKWSvPzve7+y3e7cEFMOn9MNHds3UkntZmm5CwB
	 81R+3CbtXqTVOJuYM37zqm/pTfehZeMlOMMK+tsjDCcJl+pivKolSu5oEJLaw60Zrf
	 pq1y0ArUeNO3Q0ButOz4uTmJCU7LzRYQP58uIZGkKNIQWJANlwzdRtBgKlrwByzpTz
	 EykmZxb4TKaSNrZSeJ9+FJoCHZTliY7ghD1hn8c81Y8E3VFtVa69ulVlKQsE05zL+u
	 Dwl0pbflP2aYA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:42 +0200
Subject: [PATCH RFC DRAFT 36/50] selftests/namespaces: second listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-36-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2143; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gPBGu8BceJ6oHRtyp7iwBf16DUj5zY+HNikOeiNBVYw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3xXI3dvV9KpCbzKy9l+zJtwTs307szbGm1X14v/q
 9vc5zTzckcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEqg8y/A9PSv/y7mLeg+BX
 SWqLEgW65Cb/mGzr/vH4+ZjvZ87MthNgZNgncH/iYWXe4ohG1lnNj+Zrf21VdysUvL1GeJH3+2t
 talwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

test listns() with type filtering.
List only network namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/listns_test.c | 61 ++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index cb42827d3dfe..64249502ac49 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -54,4 +54,65 @@ TEST(listns_basic_unified)
 	}
 }
 
+/*
+ * Test listns() with type filtering.
+ * List only network namespaces.
+ */
+TEST(listns_filter_by_type)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWNET,  /* Only network namespaces */
+		.spare2 = 0,
+		.user_ns_id = 0,
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
+	/* Should find at least init_net */
+	ASSERT_GT(ret, 0);
+	TH_LOG("Found %zd active network namespaces", ret);
+
+	/* Verify we can open each namespace and it's actually a network namespace */
+	for (ssize_t i = 0; i < ret && i < 5; i++) {
+		struct nsfs_file_handle nsfh = {
+			.ns_id = ns_ids[i],
+			.ns_type = CLONE_NEWNET,
+			.ns_inum = 0,
+		};
+		struct file_handle *fh;
+		int fd;
+
+		fh = (struct file_handle *)malloc(sizeof(*fh) + sizeof(nsfh));
+		ASSERT_NE(fh, NULL);
+		fh->handle_bytes = sizeof(nsfh);
+		fh->handle_type = 0;
+		memcpy(fh->f_handle, &nsfh, sizeof(nsfh));
+
+		fd = open_by_handle_at(-10003, fh, O_RDONLY);
+		free(fh);
+
+		if (fd >= 0) {
+			int ns_type;
+			/* Verify it's a network namespace via ioctl */
+			ns_type = ioctl(fd, NS_GET_NSTYPE);
+			if (ns_type >= 0) {
+				ASSERT_EQ(ns_type, CLONE_NEWNET);
+			}
+			close(fd);
+		}
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


