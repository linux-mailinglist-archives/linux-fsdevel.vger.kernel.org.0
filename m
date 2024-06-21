Return-Path: <linux-fsdevel+bounces-22161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E61A912ED4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 22:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184561F23DEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 20:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A691217C200;
	Fri, 21 Jun 2024 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAkDBFKV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C277155329;
	Fri, 21 Jun 2024 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003047; cv=none; b=I53SOEJ5ZSQWaUZZrdOzfv0p9tEEAEgbqFwM477LmQMxQzHpq7DwnrEXCPk3FqA6jqD6ss/HZvMBYF1L41Uz6wsSbDCiTVa1Fd89MLaAT+2Mf++34uMcWZ6cFetGwYjl0aw0gJm9/Nzm9/DcFyjW8zvAp6mWkiwaA4bvlEWCOHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003047; c=relaxed/simple;
	bh=HGKiztfmnXGwe57zj0+vTZfhNT7KQZ5JNN+BGrOb5Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aJhaQ1glf+X67j0PVfyP9JfMIJfAPlY3sr3Q3quEzR66u4mGqIC59xbudE2CTSr0ocejMs+egNSUyfJqalOU7bl3G5ke18SLecQxFVKnXxG55BU49qFksf/3KefZPaq0ajAXt/d2hL5iun8gHL9HYhtjZEf+AC0HH8x9KEvkGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAkDBFKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F68DC4AF09;
	Fri, 21 Jun 2024 20:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719003046;
	bh=HGKiztfmnXGwe57zj0+vTZfhNT7KQZ5JNN+BGrOb5Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RAkDBFKVl8xmtb2DHIPOV2tWg9gbzOL1odQSCGDEXJNPgM0WUxIxBe87GtqqWJ+4A
	 1Ere96aP9tXLhWixhIZSvQheDU5VDOtlYZ7/DpmebD/f4Tp0apl4GBwQ0utpvwApMh
	 KAeYFQUGf8tbr+xiQDD/fo3hDTyV18sQydUOi+eZsvrNA+K2MSdVQdGwKJLzt7ejma
	 e3onkPPrABfNag37HD3ojtklzAwWmw5WQ/6vezXvCejKws996+3d20U3Ir7nxeBm4w
	 kXP35UpmP8mmSxdjYJpGQhw+KveCa+Jz9gCAWSOsOHo7XrHNY/Nb/jhTL1PYPx5LyR
	 LdVoE6OLcFbCg==
From: Kees Cook <kees@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Kees Cook <kees@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Justin Stitt <justinstitt@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/2] exec: Avoid pathological argc, envc, and bprm->p values
Date: Fri, 21 Jun 2024 13:50:44 -0700
Message-Id: <20240621205046.4001362-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621204729.it.434-kees@kernel.org>
References: <20240621204729.it.434-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4831; i=kees@kernel.org; h=from:subject; bh=HGKiztfmnXGwe57zj0+vTZfhNT7KQZ5JNN+BGrOb5Qw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmdeekLPmeDCyHBRB+FOlnbPUxLBpaNJ4ss73+0 bFmZEGvDfSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZnXnpAAKCRCJcvTf3G3A JrHpEACwK/KoxBiuYpyBhT1faCVPtic/WRxA+xyHpVQqTf6/yL7eoyTCaiJk58mIoXAOB1tXoq1 89j9SqoxNE/uRUHLli/HOj4QYrwLyzyr6XqxRj2hwij6HLNf9poM46hOJ/Zz5tgjL9EPkZDam3/ 7aK6+OHKWEWWqqlzQhmmla+vhcKlA8MMZ2t1InXPiiXw/htTp52e2IHC0W0q4rubg+6sihRa36e Ov/Pa6O58b1fG2Ik8GcjDXlBSTj3uaTNcSZOxvZg10WpPs5r2y01iBcT+N3IHSJUFmFWpiksvKT btcLB7+7FHVBvjMKcTSA9+5TytPgMiyVMN78mKTyEfkJEjWE7GRAbeVWYTPGR0giV+lV4WJ/JJK ovljU3VUetF/2fEn8Dpr8cXSNetg15795IqzDIgO0A6FDrGGHkkXF/+q0yk3Q3JMGliylAZitXC 40+5rkqqddWDwsVg+qkKqsJrx5ttQXSi+EpAhDb62nFUtbmuznNzMEwVJgfykpWhhHMsuad13G9 DKiPCY7OeiiKNbXjfgkXID2BkHtEj1kJRD6fEVkiFuDBzqD6qWDhwLCS/mv4q5u9hLpGs68pywr ivAMmlI7v7KA3pttOS+oPQea7JkKuqHV096jHTtskEhpy9PH9bGkfGeC2PLQuBjKAZ2VF2FT6Wx jsCjqkqW7b/2erQ==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Make sure nothing goes wrong with the string counters or the bprm's
belief about the stack pointer. Add checks and matching self-tests.

Take special care for !CONFIG_MMU, since argmin is not exposed there.

For 32-bit validation, 32-bit UML was used:
$ tools/testing/kunit/kunit.py run \
	--make_options CROSS_COMPILE=i686-linux-gnu- \
	--make_options SUBARCH=i386 \
	exec

For !MMU validation, m68k was used:
$ tools/testing/kunit/kunit.py run \
	--arch m68k --make_option CROSS_COMPILE=m68k-linux-gnu- \
	exec

Link: https://lore.kernel.org/r/20240520021615.741800-2-keescook@chromium.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 fs/exec.c      | 10 +++++++++-
 fs/exec_test.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index b7bc63bfb907..5b580ff8d955 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -490,6 +490,9 @@ static inline int bprm_set_stack_limit(struct linux_binprm *bprm,
 				       unsigned long limit)
 {
 #ifdef CONFIG_MMU
+	/* Avoid a pathological bprm->p. */
+	if (bprm->p < limit)
+		return -E2BIG;
 	bprm->argmin = bprm->p - limit;
 #endif
 	return 0;
@@ -531,6 +534,9 @@ static int bprm_stack_limits(struct linux_binprm *bprm)
 	 * of argument strings even with small stacks
 	 */
 	limit = max_t(unsigned long, limit, ARG_MAX);
+	/* Reject totally pathological counts. */
+	if (bprm->argc < 0 || bprm->envc < 0)
+		return -E2BIG;
 	/*
 	 * We must account for the size of all the argv and envp pointers to
 	 * the argv and envp strings, since they will also take up space in
@@ -544,7 +550,9 @@ static int bprm_stack_limits(struct linux_binprm *bprm)
 	 * argc can never be 0, to keep them from walking envp by accident.
 	 * See do_execveat_common().
 	 */
-	ptr_size = (max(bprm->argc, 1) + bprm->envc) * sizeof(void *);
+	if (check_add_overflow(max(bprm->argc, 1), bprm->envc, &ptr_size) ||
+	    check_mul_overflow(ptr_size, sizeof(void *), &ptr_size))
+		return -E2BIG;
 	if (limit <= ptr_size)
 		return -E2BIG;
 	limit -= ptr_size;
diff --git a/fs/exec_test.c b/fs/exec_test.c
index 8fea0bf0b7f5..7c77d039680b 100644
--- a/fs/exec_test.c
+++ b/fs/exec_test.c
@@ -8,9 +8,34 @@ struct bprm_stack_limits_result {
 };
 
 static const struct bprm_stack_limits_result bprm_stack_limits_results[] = {
-	/* Giant values produce -E2BIG */
+	/* Negative argc/envc counts produce -E2BIG */
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ULONG_MAX,
+	    .argc = INT_MIN, .envc = INT_MIN }, .expected_rc = -E2BIG },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ULONG_MAX,
+	    .argc = 5, .envc = -1 }, .expected_rc = -E2BIG },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ULONG_MAX,
+	    .argc = -1, .envc = 10 }, .expected_rc = -E2BIG },
+	/* The max value of argc or envc is MAX_ARG_STRINGS. */
 	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ULONG_MAX,
 	    .argc = INT_MAX, .envc = INT_MAX }, .expected_rc = -E2BIG },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ULONG_MAX,
+	    .argc = MAX_ARG_STRINGS, .envc = MAX_ARG_STRINGS }, .expected_rc = -E2BIG },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ULONG_MAX,
+	    .argc = 0, .envc = MAX_ARG_STRINGS }, .expected_rc = -E2BIG },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ULONG_MAX,
+	    .argc = MAX_ARG_STRINGS, .envc = 0 }, .expected_rc = -E2BIG },
+	/*
+	 * On 32-bit system these argc and envc counts, while likely impossible
+	 * to represent within the associated TASK_SIZE, could overflow the
+	 * limit calculation, and bypass the ptr_size <= limit check.
+	 */
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ULONG_MAX,
+	    .argc = 0x20000001, .envc = 0x20000001 }, .expected_rc = -E2BIG },
+#ifdef CONFIG_MMU
+	/* Make sure a pathological bprm->p doesn't cause an overflow. */
+	{ { .p = sizeof(void *), .rlim_stack.rlim_cur = ULONG_MAX,
+	    .argc = 10, .envc = 10 }, .expected_rc = -E2BIG },
+#endif
 	/*
 	 * 0 rlim_stack will get raised to ARG_MAX. With 1 string pointer,
 	 * we should see p - ARG_MAX + sizeof(void *).
@@ -88,6 +113,7 @@ static void exec_test_bprm_stack_limits(struct kunit *test)
 	/* Double-check the constants. */
 	KUNIT_EXPECT_EQ(test, _STK_LIM, SZ_8M);
 	KUNIT_EXPECT_EQ(test, ARG_MAX, 32 * SZ_4K);
+	KUNIT_EXPECT_EQ(test, MAX_ARG_STRINGS, 0x7FFFFFFF);
 
 	for (int i = 0; i < ARRAY_SIZE(bprm_stack_limits_results); i++) {
 		const struct bprm_stack_limits_result *result = &bprm_stack_limits_results[i];
-- 
2.34.1


