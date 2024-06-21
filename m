Return-Path: <linux-fsdevel+bounces-22163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A00912ED6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 22:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FCA1F24E39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 20:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C6E17C202;
	Fri, 21 Jun 2024 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLrlDt0+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3031607B3;
	Fri, 21 Jun 2024 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003047; cv=none; b=IrsYBXhtK7BjKN3mgwGof5Seib5vGtd7MVpsrfNCd4+TPpnZXz8gy3h7afE/nJxcrZcDLOAm13rd9unlrrGR5WJB/ixYftxbBpzVa98NfMSAfMTscQAnDrk5gWvyI5igddQ+xJoROMx6dDYH9DAAJH13faZPx8dDF1OXQH0UXYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003047; c=relaxed/simple;
	bh=08nbucMThJ3PA9ERR1mzxp2dFYTwOJzapfx7t7pEvKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YgfL03UBUVxD5kDY/OTDx9Cly3V7/OgrN2Sc/alrrnsokwCSsC4IwoOoSRckme+YrP0rCP0wllqP1Lyvli0Yd7Y/xi3QbJib2VHH6A1E79j86gY74nqbFIF2w6EJiFOeQitUv5KsKpz1xelJaxqUtURUg49DMmuxB5GmTu71v3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLrlDt0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5D2C2BBFC;
	Fri, 21 Jun 2024 20:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719003046;
	bh=08nbucMThJ3PA9ERR1mzxp2dFYTwOJzapfx7t7pEvKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TLrlDt0+nOx1CCG90R/6CZa8aFePcr7Fh/AeYwaCqHSxu5FfsfEojI7ZgaeGgtqtI
	 5XCG39Hh1W6x1coVzwHlQBQD6E7g+lgJfkSmFWJyyL5J33bhPIxoawQN6jHhSJI6Hv
	 QBI0xRNJZLfAQc2iyBaGfKih6Dstk/bIcXw+cUHPQfTnnkm3tHEI0HEmstimhUuwOk
	 o45jBz6xPL57QIXS9IXaN6Ysv7asvRwsPO9ZDLDq01zdzCogmhi2dD2Eneob3Svr/w
	 Ao2EL1yAr4eLyMJTaqqeFfduG05K03dovRWo9UKw9U2mjglj9ZUtJEmECDfzZGC+2c
	 E+yOfeRVfM69w==
From: Kees Cook <kees@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Kees Cook <kees@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/2] execve: Keep bprm->argmin behind CONFIG_MMU
Date: Fri, 21 Jun 2024 13:50:43 -0700
Message-Id: <20240621205046.4001362-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621204729.it.434-kees@kernel.org>
References: <20240621204729.it.434-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3893; i=kees@kernel.org; h=from:subject; bh=08nbucMThJ3PA9ERR1mzxp2dFYTwOJzapfx7t7pEvKw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmdeekFSbBk2O2iHqrCrSBFtyRjbOTF4Orfwi4G NzijvpupVKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZnXnpAAKCRCJcvTf3G3A JhSOEACWWK0PtH8YUUh7IL6RFGs61JDtltA65r7YwqGHW9pAb9Ei2/Pm9tSrkRjjCQJJzSUlijZ sIJL7ggzsjCbCl1l/PFkcuvC6PFmLFZ9YeyqUF0a8srpivUSLRkm7rVqiJuQ+xSRJVHc29A/ugS FS6t1mFxeikcvz9vHMaqpgenvD4Mgl14Rb4oedV0SP3ZB15v8eABGMoY4cTC3Bw0mLltSXzHm0I 1gn7FNVNhFnNJFD2t/fVw/u8uwmeGIUaAEE6J33lGvlvMJbxBFp8umKg6a6w/+98mE8jSksVIoE Pok5N1XYsTDENcddKk0ZHkY6W0ux+c967CH87wD17w2K8rgr2sFGddRYxCUSU0KG7LZFu6OR9vZ /OZKQfAZCoPw0rTZrZc1H62h7goz0vPuTsovL9Z7Y9AxFyW5AcEsqI2HNvtBhqndK3yc1myJpdP 3hJY0DDp4lEyk5qjqG1/wgir84UVSO9TISyB7t0CfX8LNOXI7cJiHUd89R/UyiAhtm02dF1QHAI 8/+q/y2dgHXVv4esZytTnXmkwtm2oZU8jjiTNfSfO9/LZElw3wMeoze4TGuAhM6wwQA7n7pQDZn tRgSx5v0//uEVarmd41/WOez36Qxoaxs5W8UfR+zanBm4abpwbd21c9B+5sxEHAOmRSxj6FmFVF k5BWD3WJLC17tDg==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When argmin was added in commit 655c16a8ce9c ("exec: separate
MM_ANONPAGES and RLIMIT_STACK accounting"), it was intended only for
validating stack limits on CONFIG_MMU[1]. All checking for reaching the
limit (argmin) is wrapped in CONFIG_MMU ifdef checks, though setting
argmin was not. That argmin is only supposed to be used under CONFIG_MMU
was rediscovered recently[2], and I don't want to trip over this again.

Move argmin's declaration into the existing CONFIG_MMU area, and add
helpers functions so the MMU tests can be consolidated.

Link: https://lore.kernel.org/all/20181126122307.GA1660@redhat.com [1]
Link: https://lore.kernel.org/all/202406211253.7037F69@keescook/ [2]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 fs/exec.c               | 26 ++++++++++++++++++++------
 fs/exec_test.c          |  2 ++
 include/linux/binfmts.h |  2 +-
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index c3bec126505b..b7bc63bfb907 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -486,6 +486,23 @@ static int count_strings_kernel(const char *const *argv)
 	return i;
 }
 
+static inline int bprm_set_stack_limit(struct linux_binprm *bprm,
+				       unsigned long limit)
+{
+#ifdef CONFIG_MMU
+	bprm->argmin = bprm->p - limit;
+#endif
+	return 0;
+}
+static inline bool bprm_hit_stack_limit(struct linux_binprm *bprm)
+{
+#ifdef CONFIG_MMU
+	return bprm->p < bprm->argmin;
+#else
+	return false;
+#endif
+}
+
 /*
  * Calculate bprm->argmin from:
  * - _STK_LIM
@@ -532,8 +549,7 @@ static int bprm_stack_limits(struct linux_binprm *bprm)
 		return -E2BIG;
 	limit -= ptr_size;
 
-	bprm->argmin = bprm->p - limit;
-	return 0;
+	return bprm_set_stack_limit(bprm, limit);
 }
 
 /*
@@ -571,10 +587,8 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
 		pos = bprm->p;
 		str += len;
 		bprm->p -= len;
-#ifdef CONFIG_MMU
-		if (bprm->p < bprm->argmin)
+		if (bprm_hit_stack_limit(bprm))
 			goto out;
-#endif
 
 		while (len > 0) {
 			int offset, bytes_to_copy;
@@ -649,7 +663,7 @@ int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
 	/* We're going to work our way backwards. */
 	arg += len;
 	bprm->p -= len;
-	if (IS_ENABLED(CONFIG_MMU) && bprm->p < bprm->argmin)
+	if (bprm_hit_stack_limit(bprm))
 		return -E2BIG;
 
 	while (len > 0) {
diff --git a/fs/exec_test.c b/fs/exec_test.c
index 32a90c6f47e7..8fea0bf0b7f5 100644
--- a/fs/exec_test.c
+++ b/fs/exec_test.c
@@ -96,7 +96,9 @@ static void exec_test_bprm_stack_limits(struct kunit *test)
 
 		rc = bprm_stack_limits(&bprm);
 		KUNIT_EXPECT_EQ_MSG(test, rc, result->expected_rc, "on loop %d", i);
+#ifdef CONFIG_MMU
 		KUNIT_EXPECT_EQ_MSG(test, bprm.argmin, result->expected_argmin, "on loop %d", i);
+#endif
 	}
 }
 
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 70f97f685bff..e6c00e860951 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -19,13 +19,13 @@ struct linux_binprm {
 #ifdef CONFIG_MMU
 	struct vm_area_struct *vma;
 	unsigned long vma_pages;
+	unsigned long argmin; /* rlimit marker for copy_strings() */
 #else
 # define MAX_ARG_PAGES	32
 	struct page *page[MAX_ARG_PAGES];
 #endif
 	struct mm_struct *mm;
 	unsigned long p; /* current top of mem */
-	unsigned long argmin; /* rlimit marker for copy_strings() */
 	unsigned int
 		/* Should an execfd be passed to userspace? */
 		have_execfd:1,
-- 
2.34.1


