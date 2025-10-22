Return-Path: <linux-fsdevel+bounces-65165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C7DBFD33B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A573B31B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1718357A2B;
	Wed, 22 Oct 2025 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwpeLoQw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130922C0294;
	Wed, 22 Oct 2025 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149363; cv=none; b=efTIpoZzWuRtngLEWpYaLgwWo1/tkJRrpvxVsc6xIHXgT0p5zf9DWnwHrJPcKAynvR26dxMOm9YEARPRw6CrvcoawIS7tnJm3t8/yOIoNuIaqDtwpH60axHsDrN7aPWqGzvORAFhctv37Pl2aWUCWfOdoYbS0lJ4jugb1f//Mac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149363; c=relaxed/simple;
	bh=gPBGu8BceJ6oHRtyp7iwBf16DUj5zY+HNikOeiNBVYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=muqCJbh7jPH92qP06wHC0FUENfvsOnyE1i88BAc86Ll1FVVqmzeUkOZLXe3xmNq9OrXNDCyT6Rzo9iMKPLZcXhXJZLoen3QqrJ97G0rICwh6vWK8m0BPxi6sFFKt6H5uryrURbfkpb1Vi0Ckx5o5CXRSU39q0+6eaBv7ApC2V/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwpeLoQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD33C4CEE7;
	Wed, 22 Oct 2025 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149362;
	bh=gPBGu8BceJ6oHRtyp7iwBf16DUj5zY+HNikOeiNBVYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qwpeLoQwHUP+jIbSHho17fazbBhdWrnY8PGq+1hRylkJ62nGHDyDISgaU3DzgVtB2
	 Mu45jdUNVK/3HfDWYjiuXw5so1XA/mt8y20HxGf871d03AaV4rOY7VVPvqP+UDcEY0
	 C1vC4L1FWSWkn0Y8zmSgTVU/Rf/ZM6F4aXNjPFxuZn9qdLM/F5UlLaWdiYqusdgV5j
	 HLHiOfMQL5zvgYv43xcIFxBFt57pSsK91yjGULpP9x5Wivvm3xzpQF+ThpNavugtYY
	 UCt1xNgt3dam4l//GaQ5FxWeK+cIUjKwRRO/TAZoksgxr3e0fwGgaFak4t2CvyE0PQ
	 jHpLLi2u5bRUA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:15 +0200
Subject: [PATCH v2 37/63] selftests/namespaces: second listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-37-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2143; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gPBGu8BceJ6oHRtyp7iwBf16DUj5zY+HNikOeiNBVYw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHjW+LXlaP1l/9aAv5zu5RFF7ou+VXKfPbJFa+fsx
 T1eR+L3dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk00RGhqVsy1W5JHcekp/e
 NqvuidKDt38WO8drbZQ7cTnyUJNNnRkjw5pgM7bJ0wo2+7KKHnTPltxu/eas9ow3Qao6DYumTXq
 8lwsA
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


