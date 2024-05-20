Return-Path: <linux-fsdevel+bounces-19733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9EC8C97C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 04:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2B21F21DF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 02:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53692125C0;
	Mon, 20 May 2024 02:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="noh1Rrwx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6498F5C
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 02:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171381; cv=none; b=RtmHfi6IgKmTowe92pSUq73kieIZiKmMH2vtFqY3m5Y4oMkPx+hpcgDscX2PbbeI6eZ+Z7JxCNEkILfULIuvpbyGB4kKiOnyOTcyn37dYsqQplkwqgwXLXlLrWdal/mTFp+pthyQBkPj+yn0Zis6PVPtyp08iNbF5lVJBvgv5Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171381; c=relaxed/simple;
	bh=emBZah1nJM7hX2hwqXj1bD4HWPpBnlv8ewVWm+AeRdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rAuOapHIisahPfdAbn8Lbxu1yvxfJti0kp/Qvd6uzBw+3u5li/p+ThHQoS8m1X1D9tUgvn/LwseNwBrZqj+gQiyv6LCy88hoEy4y6YC2L9kN6fHnL8I5snZalOXOoxhgBxxiaCbc8wXsU5c8GzhKJ3Ywwj4BbP3WYyejU1mn6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=noh1Rrwx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e651a9f3ffso56829405ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 May 2024 19:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716171378; x=1716776178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7+oCeV5s8SnWCifHQ1nG7jot6TA5mZOIRM4l7lIpDY=;
        b=noh1RrwxzhxFlv6BvYCB2L9DxeLiHJgoyra2uRscyPuhmXF9vTaTipUn/TSvxDkt/9
         Xz+J+bWIoXw1kiVng/yk++LKNxE44BWqeAi34n8PsHMTX1Uwf7ryYLYh5VPnV1NFnxrv
         tu3mz/x+3Y5hk/I3IjLACOXGpyXLWFRzMosfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716171378; x=1716776178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7+oCeV5s8SnWCifHQ1nG7jot6TA5mZOIRM4l7lIpDY=;
        b=jGagQVDrGS4cRe/vBrU3q+P3NS0BfDpjUGbazgma7pAMJZyB+lWOkKVQP795y4x4F0
         HLSVJsQ/FKgPQfuZw1ysCz3bED/799aAewx9qHWkGmJ4lc8tsYNeJcW+ZHMmTlxX1ah4
         n2o8AAmLhglzu3u/QIod8ReWgG9CsRJ9tixgM8wpqhspiaAkRVgP7A8XQ9DsU4lhQJft
         bUjO8xa9p+jcPkcKarjEsqXUJw5IlNsCC+poZ3eRGLp3dXBQpl65KZXKFoMqhIUt/mTL
         xkIHr2N4JJUyQIPlB6OMaeXvKtcG6WkUGKnf1jNsDzjaCYNcAGNlDTcEftHte9sEFq4O
         Q/pw==
X-Forwarded-Encrypted: i=1; AJvYcCXnES4C1qOLXWr3UHu3qwV8479GUN42lhJq0XuebDCFSVia69hcBtXMVO8AIbRQmi/S7jQVD66EfoFQbtpfW+3gHwQ/J0fh4rx6t04bnA==
X-Gm-Message-State: AOJu0YzkIkUxt6vQNkpM0Eyw15OoSOg2AlDAVjnBSKxCfDxUSfyx9wgp
	OAzrpC8T9b2c6BJeQ/kt2gSN7yaDBeih8lv0w1JJXVBrglEHu5saRFWzB8XWpw==
X-Google-Smtp-Source: AGHT+IHRnGNUav1xrKAItbibrjklhMFmAti4JfbJK6woGd6RFU76uzId3Xy5ieOxiN069HAexO85vQ==
X-Received: by 2002:a05:6a20:6a04:b0:1af:d40a:7692 with SMTP id adf61e73a8af0-1afde1c4d31mr30237407637.42.1716171378409;
        Sun, 19 May 2024 19:16:18 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67158c3b4sm19014586a91.45.2024.05.19.19.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 19:16:16 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] exec: Add KUnit test for bprm_stack_limits()
Date: Sun, 19 May 2024 19:16:11 -0700
Message-Id: <20240520021615.741800-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520021337.work.198-kees@kernel.org>
References: <20240520021337.work.198-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8160; i=keescook@chromium.org;
 h=from:subject; bh=emBZah1nJM7hX2hwqXj1bD4HWPpBnlv8ewVWm+AeRdU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmSrJr1E0juzDEuXc+NCFvv+X5LxxCes4KOV4R8
 c2T/ikWuoCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZkqyawAKCRCJcvTf3G3A
 JpZMD/90Wembb3QiAeI2/lgYkDLrvjCANGGt0wlkf6F7D0Cv2Xx4H+Yg8dzjNFB2f+Pk5FxgQpa
 JVXfOYEsq2aYbEHjV5oW19f7lxUXC0J9/2c0zIyX+hu10so69Ff5ZlmUoPMl2Awu7oot1pztAmK
 Nnu18J6N40YMPeN6U6N6YGHf2kGySvRAS9prEhT5/DOKec47GQkZrZdl80Br26nga/tRCKReBos
 xbktxpVu0OqDaVgCACoRCMohKw356sYr6C2UOUtKlGuJgRoYZTvgjQLJxkL5NaPg2LOYS5tg7QC
 qk7/H3L7TEn2jpZqmqMiowISQ+POF2Qz0QmMCmJEkSE8GWQlEZ5sQumg5g4cVOUwTlVxsh3+W24
 0C0/q4OK8h8qG9VRQpfxlL1Lq8EWj1EdfQgB0JkstXdeUto2ikkXtMKAT23ms3Ac8BDbyibe9Qu
 DvIQAFmTZtiXzuO4/chaVOTMnqtarJYvQA1DLNfFQHsLeJYUf5T4cersgMtNhkfLyapJ6WyFC44
 g5HKZbmwjIYV3tEoHnFS87eNmn4Xt1BULsQYihMTtI6CeTOdQljVZEoOOLa2kT1tNwHGVQ1j+j/
 4wiHrZky3jrRjFfMVJ7HkZ2eEgkteF46GLaEOWytXTdRDeLf5rS/AyrGEcHA1ThJAwdHwaiPnnv K0/rUIpqBm+XkxA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Since bprm_stack_limits() operates with very limited side-effects, add
it as the first exec.c KUnit test. Add to Kconfig and adjust MAINTAINERS
file to include it.

Tested on 64-bit UML:
$ tools/testing/kunit/kunit.py run exec

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 MAINTAINERS       |   2 +
 fs/Kconfig.binfmt |   8 ++++
 fs/exec.c         |  13 ++++++
 fs/exec_test.c    | 113 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+)
 create mode 100644 fs/exec_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c121493f43d..845165dbb756 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8039,7 +8039,9 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
 F:	Documentation/userspace-api/ELF.rst
 F:	fs/*binfmt_*.c
+F:	fs/Kconfig.binfmt
 F:	fs/exec.c
+F:	fs/exec_test.c
 F:	include/linux/binfmts.h
 F:	include/linux/elf.h
 F:	include/uapi/linux/binfmts.h
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index f5693164ca9a..58657f2d9719 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -176,4 +176,12 @@ config COREDUMP
 	  certainly want to say Y here. Not necessary on systems that never
 	  need debugging or only ever run flawless code.
 
+config EXEC_KUNIT_TEST
+	bool "Build execve tests" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the exec KUnit tests, which tests boundary conditions
+	  of various aspects of the exec internals.
+
 endmenu
diff --git a/fs/exec.c b/fs/exec.c
index b3c40fbb325f..1d45e1a2d620 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -475,6 +475,15 @@ static int count_strings_kernel(const char *const *argv)
 	return i;
 }
 
+/*
+ * Calculate bprm->argmin from:
+ * - _STK_LIM
+ * - ARG_MAX
+ * - bprm->rlim_stack.rlim_cur
+ * - bprm->argc
+ * - bprm->envc
+ * - bprm->p
+ */
 static int bprm_stack_limits(struct linux_binprm *bprm)
 {
 	unsigned long limit, ptr_size;
@@ -2200,3 +2209,7 @@ static int __init init_fs_exec_sysctls(void)
 
 fs_initcall(init_fs_exec_sysctls);
 #endif /* CONFIG_SYSCTL */
+
+#ifdef CONFIG_EXEC_KUNIT_TEST
+#include "exec_test.c"
+#endif
diff --git a/fs/exec_test.c b/fs/exec_test.c
new file mode 100644
index 000000000000..32a90c6f47e7
--- /dev/null
+++ b/fs/exec_test.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <kunit/test.h>
+
+struct bprm_stack_limits_result {
+	struct linux_binprm bprm;
+	int expected_rc;
+	unsigned long expected_argmin;
+};
+
+static const struct bprm_stack_limits_result bprm_stack_limits_results[] = {
+	/* Giant values produce -E2BIG */
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ULONG_MAX,
+	    .argc = INT_MAX, .envc = INT_MAX }, .expected_rc = -E2BIG },
+	/*
+	 * 0 rlim_stack will get raised to ARG_MAX. With 1 string pointer,
+	 * we should see p - ARG_MAX + sizeof(void *).
+	 */
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 0,
+	    .argc = 1, .envc = 0 }, .expected_argmin = ULONG_MAX - ARG_MAX + sizeof(void *)},
+	/* Validate that argc is always raised to a minimum of 1. */
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 0,
+	    .argc = 0, .envc = 0 }, .expected_argmin = ULONG_MAX - ARG_MAX + sizeof(void *)},
+	/*
+	 * 0 rlim_stack will get raised to ARG_MAX. With pointers filling ARG_MAX,
+	 * we should see -E2BIG. (Note argc is always raised to at least 1.)
+	 */
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 0,
+	    .argc = ARG_MAX / sizeof(void *), .envc = 0 }, .expected_rc = -E2BIG },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 0,
+	    .argc = 0, .envc = ARG_MAX / sizeof(void *) - 1 }, .expected_rc = -E2BIG },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 0,
+	    .argc = ARG_MAX / sizeof(void *) + 1, .envc = 0 }, .expected_rc = -E2BIG },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 0,
+	    .argc = 0, .envc = ARG_MAX / sizeof(void *) }, .expected_rc = -E2BIG },
+	/* And with one less, we see space for exactly 1 pointer. */
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 0,
+	    .argc = (ARG_MAX / sizeof(void *)) - 1, .envc = 0 },
+	  .expected_argmin = ULONG_MAX - sizeof(void *) },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 0,
+	    .argc = 0, .envc = (ARG_MAX / sizeof(void *)) - 2, },
+	  .expected_argmin = ULONG_MAX - sizeof(void *) },
+	/* If we raise rlim_stack / 4 to exactly ARG_MAX, nothing changes. */
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ARG_MAX * 4,
+	    .argc = ARG_MAX / sizeof(void *), .envc = 0 }, .expected_rc = -E2BIG },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ARG_MAX * 4,
+	    .argc = 0, .envc = ARG_MAX / sizeof(void *) - 1 }, .expected_rc = -E2BIG },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ARG_MAX * 4,
+	    .argc = ARG_MAX / sizeof(void *) + 1, .envc = 0 }, .expected_rc = -E2BIG },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ARG_MAX * 4,
+	    .argc = 0, .envc = ARG_MAX / sizeof(void *) }, .expected_rc = -E2BIG },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ARG_MAX * 4,
+	    .argc = (ARG_MAX / sizeof(void *)) - 1, .envc = 0 },
+	  .expected_argmin = ULONG_MAX - sizeof(void *) },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = ARG_MAX * 4,
+	    .argc = 0, .envc = (ARG_MAX / sizeof(void *)) - 2, },
+	  .expected_argmin = ULONG_MAX - sizeof(void *) },
+	/* But raising it another pointer * 4 will provide space for 1 more pointer. */
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = (ARG_MAX + sizeof(void *)) * 4,
+	    .argc = ARG_MAX / sizeof(void *), .envc = 0 },
+	  .expected_argmin = ULONG_MAX - sizeof(void *) },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = (ARG_MAX + sizeof(void *)) * 4,
+	    .argc = 0, .envc = ARG_MAX / sizeof(void *) - 1 },
+	  .expected_argmin = ULONG_MAX - sizeof(void *) },
+	/* Raising rlim_stack / 4 to _STK_LIM / 4 * 3 will see more space. */
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 4 * (_STK_LIM / 4 * 3),
+	    .argc = 0, .envc = 0 },
+	  .expected_argmin = ULONG_MAX - (_STK_LIM / 4 * 3) + sizeof(void *) },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 4 * (_STK_LIM / 4 * 3),
+	    .argc = 0, .envc = 0 },
+	  .expected_argmin = ULONG_MAX - (_STK_LIM / 4 * 3) + sizeof(void *) },
+	/* But raising it any further will see no increase. */
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 4 * (_STK_LIM / 4 * 3 + sizeof(void *)),
+	    .argc = 0, .envc = 0 },
+	  .expected_argmin = ULONG_MAX - (_STK_LIM / 4 * 3) + sizeof(void *) },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 4 * (_STK_LIM / 4 *  + sizeof(void *)),
+	    .argc = 0, .envc = 0 },
+	  .expected_argmin = ULONG_MAX - (_STK_LIM / 4 * 3) + sizeof(void *) },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 4 * _STK_LIM,
+	    .argc = 0, .envc = 0 },
+	  .expected_argmin = ULONG_MAX - (_STK_LIM / 4 * 3) + sizeof(void *) },
+	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 4 * _STK_LIM,
+	    .argc = 0, .envc = 0 },
+	  .expected_argmin = ULONG_MAX - (_STK_LIM / 4 * 3) + sizeof(void *) },
+};
+
+static void exec_test_bprm_stack_limits(struct kunit *test)
+{
+	/* Double-check the constants. */
+	KUNIT_EXPECT_EQ(test, _STK_LIM, SZ_8M);
+	KUNIT_EXPECT_EQ(test, ARG_MAX, 32 * SZ_4K);
+
+	for (int i = 0; i < ARRAY_SIZE(bprm_stack_limits_results); i++) {
+		const struct bprm_stack_limits_result *result = &bprm_stack_limits_results[i];
+		struct linux_binprm bprm = result->bprm;
+		int rc;
+
+		rc = bprm_stack_limits(&bprm);
+		KUNIT_EXPECT_EQ_MSG(test, rc, result->expected_rc, "on loop %d", i);
+		KUNIT_EXPECT_EQ_MSG(test, bprm.argmin, result->expected_argmin, "on loop %d", i);
+	}
+}
+
+static struct kunit_case exec_test_cases[] = {
+	KUNIT_CASE(exec_test_bprm_stack_limits),
+	{},
+};
+
+static struct kunit_suite exec_test_suite = {
+	.name = "exec",
+	.test_cases = exec_test_cases,
+};
+
+kunit_test_suite(exec_test_suite);
-- 
2.34.1


