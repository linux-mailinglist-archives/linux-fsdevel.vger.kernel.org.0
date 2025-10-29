Return-Path: <linux-fsdevel+bounces-66253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D052C1A633
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2381F560DFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4A037EE1E;
	Wed, 29 Oct 2025 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQPU+Gsv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7BF33C50C;
	Wed, 29 Oct 2025 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740642; cv=none; b=g+WaCCrhGRg2150jQhB2zliTSkKG97JVx/aXJa3PaUnAxCvDxJTEASzSOehiiLaHChVx64LISEjBZ+qWqICOC098O2iHJW03O67ZhgNdVqLhi350P1uVaaG1BKzT3eesTCYb72phG5C+WXxyQgDL99+9TIIM9f99YM3xXqDzbHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740642; c=relaxed/simple;
	bh=gPBGu8BceJ6oHRtyp7iwBf16DUj5zY+HNikOeiNBVYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GMnGmrN89mMFFl8/z9+3vZ+uQhtlPu6tZKurbXJwztzJ5HGNEGBcwlzdFpiTY7VpU/sBemUpdae3hp3CYXGHjNpAix1TQOuGqEe2ttbv04wB8tS3wXa/zZKzW41SEKTjirDDtOlhjEZfxT3zx9SFIbq2L1EIR+xrBeXq+nbffvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQPU+Gsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16FAC4CEF7;
	Wed, 29 Oct 2025 12:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740641;
	bh=gPBGu8BceJ6oHRtyp7iwBf16DUj5zY+HNikOeiNBVYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dQPU+Gsvufwu341xamTTrJWl6xKFYg1RTRTfJMLs47uvVcFnQAuq6aoG1szvkopRC
	 rFIQKQmmDQ8Zn0HQDIDmAcYdKXn03DwEkQjV/eDmvzgCXR/i3B6usv4ogKlTwtCcBJ
	 pCNEADyjbvsb+wLtGwPom9iev9hbkMygc1v55cR5hhpw1XpLej+r5fzpN/8dquTZTG
	 k7B34RtU/pLoyah7uv0oRaolsAov04QczpQs2mQeptMpqRKWRqRq0OshMubgon7C5d
	 zBGGdT9D8CYInZV1yFtO3sTszvZhzV6Xqs2hbWNYOUGbYmUelr1c/0m/zYAqt9HuYM
	 w2VCCBHJBbi5A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:53 +0100
Subject: [PATCH v4 40/72] selftests/namespaces: second listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-40-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2143; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gPBGu8BceJ6oHRtyp7iwBf16DUj5zY+HNikOeiNBVYw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfWdU35S+0F14ik/0ZiLnVbPcub/vObFVuNzdLKOZ
 9UKgd//OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyj4ORYUnfvU9vblvPFGmI
 yuV5kuJ05apK1G+jiu9e+iKyTgz3WxkZzt5Z1b5oXXkdT+S0PSEsfTq77y1WP8Q7rWL7icYM7Y0
 XWQA=
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


