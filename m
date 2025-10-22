Return-Path: <linux-fsdevel+bounces-65172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F11F1BFD3F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBAE3B9870
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F44037EE2A;
	Wed, 22 Oct 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4eKSwkQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6195337EE08;
	Wed, 22 Oct 2025 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149400; cv=none; b=icMn9qeXt38zkGsDJ/gpa3kY/GOYeq2CPX8HPzdzdrZQXDhN6RBBYYI5Mi39ZWZvhJuGdAH4fMfPC26fbMoPAUfMll+kSX1yTZ2fZmBoNatdZRf1xKR+XDIYyQJdNGtB/o3HWEuVJl6lYp6Q8KIm0eMarZ+lQhUr3CQmwgAlzi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149400; c=relaxed/simple;
	bh=77H7R88MI0EUUkshwD3/5/W86ZbXu7/L538OO/0/fLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NXQlJByz3VVHrDV151GX6659fj2FNmTEUi77Z3p73bTIrrULKLF+BQsodObhPE15cXKy9alJRdcodIMK+dHXzfHpYGwPEd5YzTPg6lkl+4oLlybgjVF85072g+h4BfYGyQpEfVHRVtmLe8XpEx+m4+We0kY5wGIrGK2uAz/h0E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4eKSwkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8371FC4CEE7;
	Wed, 22 Oct 2025 16:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149400;
	bh=77H7R88MI0EUUkshwD3/5/W86ZbXu7/L538OO/0/fLQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R4eKSwkQDqZaCtIWAOSE7NRGorNZP/AGowKJHORKcQmyMDbgfuDjGDTXtniVh/zlE
	 1mMt4IbNhlg7hgorI+r2cxBimnLQkrRbTAJMElftDLuTeuR2XtX1Bf+pOMsuraGjSh
	 5wFJ5qyg2X79Z5MfKojOIPQDt0sYhchD/XmmufoUzT9OlGO/ObNBqAQrpZsfBidSrQ
	 wo1utPJ0ZV0E61p4Q0lw10Lc4Z0TN4FGIBTn4gGXpqKED0yhonSMPN8AyZ6zEJp2q8
	 0/NDpvH9y+DY07OQ2J1ga/kgSIXXd4KFv5o/eXh65aBoBNtrPEzeLGRGwRvI/7Ie1q
	 dWXvO0ksr9RTg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:22 +0200
Subject: [PATCH v2 44/63] selftests/namespaces: ninth listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-44-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1852; i=brauner@kernel.org;
 h=from:subject:message-id; bh=77H7R88MI0EUUkshwD3/5/W86ZbXu7/L538OO/0/fLQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHjmFPlIsIl7adLlO+t4Z4RPfOLg+f18ttJ2lfU3a
 5+smT3rQkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEzp1lZPiwMHry6veHIldw
 dToH8bM+dn98VvHsGtH7/2WNrrxYN+cTI8PBOfY/KhuurhK5/OTU6RKby7vjJz1ql2V0WMTAvj1
 bz58LAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test error cases for listns().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/listns_test.c | 51 ++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index ddf4509d5cd6..eb44f50ab77a 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -602,4 +602,55 @@ TEST(listns_hierarchical_visibility)
 	waitpid(pid, &status, 0);
 }
 
+/*
+ * Test error cases for listns().
+ */
+TEST(listns_error_cases)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = 0,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids[10];
+	int ret;
+
+	/* Test with invalid flags */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0xFFFF);
+	if (ret >= 0 || errno == ENOSYS) {
+		if (errno != ENOSYS) {
+			TH_LOG("Warning: Expected EINVAL for invalid flags, got success");
+		}
+	} else {
+		ASSERT_EQ(errno, EINVAL);
+	}
+
+	/* Test with NULL ns_ids array */
+	ret = sys_listns(&req, NULL, 10, 0);
+	if (ret >= 0) {
+		TH_LOG("Warning: Expected EFAULT for NULL array, got success");
+	}
+
+	/* Test with invalid spare field */
+	req.spare = 1;
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret >= 0 || errno == ENOSYS) {
+		if (errno != ENOSYS) {
+			TH_LOG("Warning: Expected EINVAL for non-zero spare, got success");
+		}
+	}
+	req.spare = 0;
+
+	/* Test with huge nr_ns_ids */
+	ret = sys_listns(&req, ns_ids, 2000000, 0);
+	if (ret >= 0 || errno == ENOSYS) {
+		if (errno != ENOSYS) {
+			TH_LOG("Warning: Expected EOVERFLOW for huge count, got success");
+		}
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


