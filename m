Return-Path: <linux-fsdevel+bounces-56396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88405B1710D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A903ADF10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606C02C3770;
	Thu, 31 Jul 2025 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ytan2deu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52AB2C15B5;
	Thu, 31 Jul 2025 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964522; cv=none; b=gD9G3gXP7+qDTeQJy6ZThynDKzj9yRT+ifNJwns1QUt6UI2+065bDLYGzh/LP4PuxTckw9QV0/xjdJkEW08rc+kBEfk7pBBVOoWJ29RlEMbpKmWAyZFoh8ZXzBx5YDxuqF6c31yCeSok2X7RN23ax6G7x0LznSFDRUAXPn1kr8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964522; c=relaxed/simple;
	bh=4ViueuDQjGl4HtttbzkwOuvd6U2q2wk2yvZbY78dZqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9N+YBBWIOrAKjRP1viXHAseN/resDGlnjmLsXnxmdSawGgMLsIC8SpsnMAoktqxcI2Khw4Znc/hLuemrR4TUzlLrTghPTJOnMqVZ+/LvK0z1qY7luW4nFQuhJGVRnfSGUzbbG9flUmLPFi8su8vKpijpXJ8jv1MlzPnEyEYxts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ytan2deu; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-707365f4d47so9040346d6.1;
        Thu, 31 Jul 2025 05:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753964520; x=1754569320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdseCjeXglmAeSVo3jNDX9M0lKkfFlPBpOaLA9628VE=;
        b=Ytan2deu7JjJq7PC+6Gx9UMZPU/9mk9jEge2aEEmvs2BsqMW3WchOmKrI0L7Ky1Ij0
         MnHdyTfbYb0JmRbAwG8OpTt9HQf2Mf51aDKFU5lYGITqQgffQxXtv2Z8D+OsrS78kcie
         7Vds0oHjeozKnrfwUNOf1cqKvy1CvGLkT50Vj+mCdrfWEUYcbl51PE+K9Ffmu3Hyi+NG
         i61KArx4BvDsjOvrQqODRD2LAPIBWRm8AY/I+0GXKpeyaDEdo1+PZMOIgCfpeMvUGZMH
         jiolfQAaPY0M35S26UCuz/+WgELuS2oGyaAA5tvLVBAV2pcUdzXJORUwhgKSaC0KG7m/
         FdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964520; x=1754569320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdseCjeXglmAeSVo3jNDX9M0lKkfFlPBpOaLA9628VE=;
        b=Ga9h1NW+8yePSVZbJe7VCwuPcUsUxGhmVKQJeG1k+LzgwoixBuLlA2dD0EfVapzSfW
         UTqW9ue9qxBcW3Afl6e419iE57qC901nwxtZre8XjCOXHMiXffEUhZ6y6rHjwtqUN+aI
         0uWSRmV5+ttIEG/hcqa+JTii33OaQaQ62ck+P6DDExLpXxAAAAUm+FSLmAtlOfIugrK8
         WxFKMUoW8XEv02oovLoag4VzvdXWeeS/D4uSHelBT8zGgP31kQ9eXByT4UJkYP4LlC8k
         QXSH5ifONOaC9C84eGKD1NNIL8ZhgBSl7+CUTWpq6MO5b7D2581RTcPil9qEV8nyT1jm
         quRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFgRpS4jVvqIHWiW5Hk29WGcGGzyz5wC0i6x/vJ9J6MlLp8n9wLS7Olfl3rkbqgClPeXaOtJoal94=@vger.kernel.org, AJvYcCWKuiZY/YaQHFlx3cSj0yriXfLf0gvXxfbhzv24qmAruvVLxwoLty9Fz2uPh6rmnCmULVfKwrI5sodywtkf@vger.kernel.org
X-Gm-Message-State: AOJu0YzWdFtJTz/v2n4S7co9P+Gx3OHYLMOncLEvpLo4n0B1WiYyTzDV
	QquoYucbDEiTYttv/2W90sgwhIz2BnPsHcjeX0fsQz8ba8LNhRulvIB3
X-Gm-Gg: ASbGncsR2bMEGEUw7ixsl1zgQPoZettl0xCz6bvwBZ5HiDcAKrdVTRJl2Yudqo1NRP/
	G8ZrncqFjy2XUVZwBCbaimGRIvYPmjSpsXiOAwsOLV5a7PikAZyJCW51c0MdHdIMvCzHSE7AT7g
	ObzE/GhOG1SOruRySgthBWDnSxNtHhMv/+BfrI2val3+V+Q5PrNbRHCGxq3+dOuCJ1m50ixXDPT
	c3IGQqvefmg1QepB9uzxFW5GQUiih9Om+EDE2irW5sPqeScp0931JQOKekAvwELXQ189OYlBWd7
	QdRFsX7f0xtFOVE6omC+HkMZc/Vjs11kf5Ee6PsHqJz1f2mLTfvu9zScR24a/AmxHucrywyOLmp
	HFo/+HtduxfBZLkJTs4x2hlPrReA=
X-Google-Smtp-Source: AGHT+IF8iazBUFYe2x7VXYujKRin85eKX5b7vBwpJMRoG6sK82a3fYUAJplnBuLpAonzOd8lfcMtXw==
X-Received: by 2002:ad4:5d63:0:b0:704:f7d8:7032 with SMTP id 6a1803df08f44-7077ced886cmr23408926d6.23.1753964519324;
        Thu, 31 Jul 2025 05:21:59 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-709205d12d9sm1635766d6.65.2025.07.31.05.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:21:58 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@redhat.com,
	linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	corbet@lwn.net,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	baohua@kernel.org,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	ziy@nvidia.com,
	laoar.shao@gmail.com,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	vbabka@suse.cz,
	jannh@google.com,
	Arnd Bergmann <arnd@arndb.de>,
	sj@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH 4/5] selftests: prctl: introduce tests for disabling THPs completely
Date: Thu, 31 Jul 2025 13:18:15 +0100
Message-ID: <20250731122150.2039342-5-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250731122150.2039342-1-usamaarif642@gmail.com>
References: <20250731122150.2039342-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test will set the global system THP setting to never, madvise
or always depending on the fixture variant and the 2M setting to
inherit before it starts (and reset to original at teardown).

This tests if the process can:
- successfully set and get the policy to disable THPs completely.
- never get a hugepage when the THPs are completely disabled
  with the prctl, including with MADV_HUGE and MADV_COLLAPSE.
- successfully reset the policy of the process.
- after reset, only get hugepages with:
  - MADV_COLLAPSE when policy is set to never.
  - MADV_HUGE and MADV_COLLAPSE when policy is set to madvise.
  - always when policy is set to "always".
- repeat the above tests in a forked process to make sure
  the policy is carried across forks.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../testing/selftests/mm/prctl_thp_disable.c  | 241 ++++++++++++++++++
 tools/testing/selftests/mm/thp_settings.c     |   9 +-
 tools/testing/selftests/mm/thp_settings.h     |   1 +
 5 files changed, 252 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/mm/prctl_thp_disable.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index e7b23a8a05fe..eb023ea857b3 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -58,3 +58,4 @@ pkey_sighandler_tests_32
 pkey_sighandler_tests_64
 guard-regions
 merge
+prctl_thp_disable
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index d13b3cef2a2b..2bb8d3ebc17c 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -86,6 +86,7 @@ TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += pagemap_ioctl
 TEST_GEN_FILES += pfnmap
 TEST_GEN_FILES += process_madv
+TEST_GEN_FILES += prctl_thp_disable
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += uffd-stress
diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
new file mode 100644
index 000000000000..2f54e5e52274
--- /dev/null
+++ b/tools/testing/selftests/mm/prctl_thp_disable.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Basic tests for PR_GET/SET_THP_DISABLE prctl calls
+ *
+ * Author(s): Usama Arif <usamaarif642@gmail.com>
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+
+#include "../kselftest_harness.h"
+#include "thp_settings.h"
+#include "vm_util.h"
+
+static int sz2ord(size_t size, size_t pagesize)
+{
+	return __builtin_ctzll(size / pagesize);
+}
+
+enum thp_collapse_type {
+	THP_COLLAPSE_NONE,
+	THP_COLLAPSE_MADV_HUGEPAGE,	/* MADV_HUGEPAGE before access */
+	THP_COLLAPSE_MADV_COLLAPSE,	/* MADV_COLLAPSE after access */
+};
+
+enum thp_policy {
+	THP_POLICY_NEVER,
+	THP_POLICY_MADVISE,
+	THP_POLICY_ALWAYS,
+};
+
+struct test_results {
+	int prctl_get_thp_disable;
+	int prctl_applied_collapse_none;
+	int prctl_applied_collapse_madv_huge;
+	int prctl_applied_collapse_madv_collapse;
+	int prctl_removed_collapse_none;
+	int prctl_removed_collapse_madv_huge;
+	int prctl_removed_collapse_madv_collapse;
+};
+
+/*
+ * Function to mmap a buffer, fault it in, madvise it appropriately (before
+ * page fault for MADV_HUGE, and after for MADV_COLLAPSE), and check if the
+ * mmap region is huge.
+ * Returns:
+ * 0 if test doesn't give hugepage
+ * 1 if test gives a hugepage
+ * -errno if mmap fails
+ */
+static int test_mmap_thp(enum thp_collapse_type madvise_buf, size_t pmdsize)
+{
+	char *mem, *mmap_mem;
+	size_t mmap_size;
+	int ret;
+
+	/* For alignment purposes, we need twice the THP size. */
+	mmap_size = 2 * pmdsize;
+	mmap_mem = (char *)mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
+				    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (mmap_mem == MAP_FAILED)
+		return -errno;
+
+	/* We need a THP-aligned memory area. */
+	mem = (char *)(((uintptr_t)mmap_mem + pmdsize) & ~(pmdsize - 1));
+
+	if (madvise_buf == THP_COLLAPSE_MADV_HUGEPAGE)
+		madvise(mem, pmdsize, MADV_HUGEPAGE);
+
+	/* Ensure memory is allocated */
+	memset(mem, 1, pmdsize);
+
+	if (madvise_buf == THP_COLLAPSE_MADV_COLLAPSE)
+		madvise(mem, pmdsize, MADV_COLLAPSE);
+
+	/*
+	 * MADV_HUGEPAGE will create a new VMA at "mem", which is the address
+	 * pattern we want to check for to detect the presence of hugepage in
+	 * smaps.
+	 * MADV_COLLAPSE will not create a new VMA, therefore we need to check
+	 * for hugepage at "mmap_mem" in smaps.
+	 * Check for hugepage at both locations to ensure that
+	 * THP_COLLAPSE_NONE, THP_COLLAPSE_MADV_HUGEPAGE and
+	 * THP_COLLAPSE_MADV_COLLAPSE only gives a THP when expected
+	 * in the range [mmap_mem, mmap_mem + 2 * pmdsize].
+	 */
+	ret = check_huge_anon(mem, 1, pmdsize) ||
+	      check_huge_anon(mmap_mem, 1, pmdsize);
+	munmap(mmap_mem, mmap_size);
+	return ret;
+}
+
+static void prctl_thp_disable_test(struct __test_metadata *const _metadata,
+				   size_t pmdsize, struct test_results *results)
+{
+
+	ASSERT_EQ(prctl(PR_GET_THP_DISABLE, NULL, NULL, NULL, NULL),
+		  results->prctl_get_thp_disable);
+
+	/* tests after prctl overrides global policy */
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_NONE, pmdsize),
+		  results->prctl_applied_collapse_none);
+
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_HUGEPAGE, pmdsize),
+		  results->prctl_applied_collapse_madv_huge);
+
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_COLLAPSE, pmdsize),
+		  results->prctl_applied_collapse_madv_collapse);
+
+	/* Reset to global policy */
+	ASSERT_EQ(prctl(PR_SET_THP_DISABLE, 0, NULL, NULL, NULL), 0);
+
+	/* tests after prctl is cleared, and only global policy is effective */
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_NONE, pmdsize),
+		  results->prctl_removed_collapse_none);
+
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_HUGEPAGE, pmdsize),
+		  results->prctl_removed_collapse_madv_huge);
+
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_COLLAPSE, pmdsize),
+		  results->prctl_removed_collapse_madv_collapse);
+}
+
+FIXTURE(prctl_thp_disable_completely)
+{
+	struct thp_settings settings;
+	struct test_results results;
+	size_t pmdsize;
+};
+
+FIXTURE_VARIANT(prctl_thp_disable_completely)
+{
+	enum thp_policy thp_global_policy;
+};
+
+FIXTURE_VARIANT_ADD(prctl_thp_disable_completely, never)
+{
+	.thp_global_policy = THP_POLICY_NEVER,
+};
+
+FIXTURE_VARIANT_ADD(prctl_thp_disable_completely, madvise)
+{
+	.thp_global_policy = THP_POLICY_MADVISE,
+};
+
+FIXTURE_VARIANT_ADD(prctl_thp_disable_completely, always)
+{
+	.thp_global_policy = THP_POLICY_ALWAYS,
+};
+
+FIXTURE_SETUP(prctl_thp_disable_completely)
+{
+	if (!thp_available())
+		SKIP(return, "Transparent Hugepages not available\n");
+
+	self->pmdsize = read_pmd_pagesize();
+	if (!self->pmdsize)
+		SKIP(return, "Unable to read PMD size\n");
+
+	thp_save_settings();
+	thp_read_settings(&self->settings);
+	switch (variant->thp_global_policy) {
+	case THP_POLICY_NEVER:
+		self->settings.thp_enabled = THP_NEVER;
+		self->results = (struct test_results) {
+			.prctl_get_thp_disable = 1,
+			.prctl_applied_collapse_none = 0,
+			.prctl_applied_collapse_madv_huge = 0,
+			.prctl_applied_collapse_madv_collapse = 0,
+			.prctl_removed_collapse_none = 0,
+			.prctl_removed_collapse_madv_huge = 0,
+			.prctl_removed_collapse_madv_collapse = 1,
+		};
+		break;
+	case THP_POLICY_MADVISE:
+		self->settings.thp_enabled = THP_MADVISE;
+		self->results = (struct test_results) {
+			.prctl_get_thp_disable = 1,
+			.prctl_applied_collapse_none = 0,
+			.prctl_applied_collapse_madv_huge = 0,
+			.prctl_applied_collapse_madv_collapse = 0,
+			.prctl_removed_collapse_none = 0,
+			.prctl_removed_collapse_madv_huge = 1,
+			.prctl_removed_collapse_madv_collapse = 1,
+		};
+		break;
+	case THP_POLICY_ALWAYS:
+		self->settings.thp_enabled = THP_ALWAYS;
+		self->results = (struct test_results) {
+			.prctl_get_thp_disable = 1,
+			.prctl_applied_collapse_none = 0,
+			.prctl_applied_collapse_madv_huge = 0,
+			.prctl_applied_collapse_madv_collapse = 0,
+			.prctl_removed_collapse_none = 1,
+			.prctl_removed_collapse_madv_huge = 1,
+			.prctl_removed_collapse_madv_collapse = 1,
+		};
+		break;
+	}
+	self->settings.hugepages[sz2ord(self->pmdsize, getpagesize())].enabled = THP_INHERIT;
+	thp_write_settings(&self->settings);
+}
+
+FIXTURE_TEARDOWN(prctl_thp_disable_completely)
+{
+	thp_restore_settings();
+}
+
+TEST_F(prctl_thp_disable_completely, nofork)
+{
+	ASSERT_EQ(prctl(PR_SET_THP_DISABLE, 1, NULL, NULL, NULL), 0);
+	prctl_thp_disable_test(_metadata, self->pmdsize, &self->results);
+}
+
+TEST_F(prctl_thp_disable_completely, fork)
+{
+	int ret = 0;
+	pid_t pid;
+
+	ASSERT_EQ(prctl(PR_SET_THP_DISABLE, 1, NULL, NULL, NULL), 0);
+
+	/* Make sure prctl changes are carried across fork */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (!pid)
+		prctl_thp_disable_test(_metadata, self->pmdsize, &self->results);
+
+	wait(&ret);
+	if (WIFEXITED(ret))
+		ret = WEXITSTATUS(ret);
+	else
+		ret = -EINVAL;
+	ASSERT_EQ(ret, 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/mm/thp_settings.c b/tools/testing/selftests/mm/thp_settings.c
index bad60ac52874..574bd0f8ae48 100644
--- a/tools/testing/selftests/mm/thp_settings.c
+++ b/tools/testing/selftests/mm/thp_settings.c
@@ -382,10 +382,17 @@ unsigned long thp_shmem_supported_orders(void)
 	return __thp_supported_orders(true);
 }
 
-bool thp_is_enabled(void)
+bool thp_available(void)
 {
 	if (access(THP_SYSFS, F_OK) != 0)
 		return false;
+	return true;
+}
+
+bool thp_is_enabled(void)
+{
+	if (!thp_available())
+		return false;
 
 	int mode = thp_read_string("enabled", thp_enabled_strings);
 
diff --git a/tools/testing/selftests/mm/thp_settings.h b/tools/testing/selftests/mm/thp_settings.h
index 6c07f70beee9..76eeb712e5f1 100644
--- a/tools/testing/selftests/mm/thp_settings.h
+++ b/tools/testing/selftests/mm/thp_settings.h
@@ -84,6 +84,7 @@ void thp_set_read_ahead_path(char *path);
 unsigned long thp_supported_orders(void);
 unsigned long thp_shmem_supported_orders(void);
 
+bool thp_available(void);
 bool thp_is_enabled(void);
 
 #endif /* __THP_SETTINGS_H__ */
-- 
2.47.3


