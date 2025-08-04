Return-Path: <linux-fsdevel+bounces-56660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C08B3B1A64E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 17:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF7E94E18F8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F1D2741DA;
	Mon,  4 Aug 2025 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3q4UwZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E141B271A7C;
	Mon,  4 Aug 2025 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322227; cv=none; b=TSTXcDQ10Q+8gtgL/nudFg6w7Dv+KQTbVWfO6aSBs0/DZV6mLZTHX03IXoll1qzWjimNOlsFFAKiTjUq6jSTXjxDJVeP26g0deUgZhhDXbEgpaEvWduG0HNrM2qULucvwxNgH0N2qUsTfaG5kTwKNljRkHkarrBhiLV0WdMWQYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322227; c=relaxed/simple;
	bh=39dOP4aQOQqerHfe7ciUdLNqEQ6vEMPhn2zVtu3rvY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaFm5C3vsnWawF+0yfH+Mhn2Vj84Bbr9p2tBT6I1biB4vMP1wPr0//6Yo1jv9e03o299K0i8XzzbDtMMnxUhDr7ISRxUldWlO7gV0xgefI6KkJIkrfmWgS7vu7OG9lnAJwPJJe8g5fXAMt2qF76CgjEvJsiE7x0Yw2hp9oP5TO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3q4UwZi; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab61ecc1e8so21296791cf.1;
        Mon, 04 Aug 2025 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754322224; x=1754927024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ev6ABJetleEJTk7asnC+VOI2GS3gzwPELlTq9+6FP9k=;
        b=P3q4UwZipYbBqSYPWlVMZFPHKlqgna+1kpNJi4FjtedMIDz57D/SpsTsdzyoZJBp/Q
         QclWuh7W8yqOuW6g90QeXhxUrAIcP6kk6Sf8zg6K3KZlR4Z27YriDA56/grqtmhp+R/n
         EyLPzD7DG11AJKE9zxXIL3kv32GS2UCWHKsLPyQSR6xyt/un28Aa0SMSVWLVaPjWhy2S
         rc55las5Pwug6/rgfdnAeYBzbLUpTeqn7u2qfN58+YkU0qFqEDGkQx9D45yJsAEEQaSw
         Z0M0Ef9H/Qp1+mA0yZq5/65qa/JdSLETuZLrQBaVCwKFKNgX5/XSdxwH8KqXIEc9JX3J
         Z3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322224; x=1754927024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ev6ABJetleEJTk7asnC+VOI2GS3gzwPELlTq9+6FP9k=;
        b=xDGjtYLV9Wv1Iu/tvOORxh7q1RZFAFHXextfdHtlkRfos5ZkXlioPJxfagY1XKvGvE
         x3ohkYbBYM4gvQkos4MVKiyQcxwyJSaNKysLnMDc7Gmi8zpxBNPCrBsZSfmh/0JWL+Yv
         Z72R68IfeSSMj6SbvyQYlAPuxc3z9Zc7caF9AVEzLM+0rmjnAuDC/GxMiW32JmLdP/de
         nB6tFc/J4dZpcZRpa+OxF9LuNx6qi3cA/Eu7N8f3skzkD3LL0xssW8iHl+0DYhxbZWut
         6snX/AhucGqe7Qu57XvyoG+aa5u1mFMF6Kv+wWwsKaxKqwR+WDzvFbTcWx12godYCcrh
         Ee0g==
X-Forwarded-Encrypted: i=1; AJvYcCUzxGplY4rvELHk7FQ8Io0xm+KKuSYBEqtqgvrhMC6KJ3i4w3Dt7XeOyVwkZntMECJiSZviixEI15wn457E@vger.kernel.org, AJvYcCVgKMrueYmswB83BHyl9fH8Ot6nlOOEl6mi0XnULVQm4YDOTOHubmdzvLxO+CbCre4bBvXxA1WAPuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCd8rGmo1cOgZ5ZARXkigfMsRa0+uOPE7j+g9s3f1CbDHl5c+V
	mqzPu+rjE/GuNRaYnfdCaVLZYOYBFTaVN0Kn0Mq1S07TQ3PH1ONu/jEl
X-Gm-Gg: ASbGncuEwIMmrgiFXS69Sc6YQfq7/ybPJFbdZEx6GxOPWmZXGRmdHYrZ4O56wiYyR3a
	Y8/sEQPo7fDiQust5JHhx5lp3lmEp3MFzITTCXpCr5d8rEsEFZflmeTfO0Ohvye2wmvHUdq/Tyc
	1YvGsWLXDoTgtRuzUCzyE7cwgJfFPviAdbWahmMUf2xsZjeEy7bnXKiMePcRKd2BLSGDDEmXDPk
	DiDw7t1zcw3p9eTkadX/zN2b6I2ZbmVR131KjbGVITUe7rg7ni4f5Qe/hB7z5S3ZEE/i0MisxHz
	a6ZXvBoRMN7nFDB5ZVtFtUBTGFmNzB1tohQZl/ba2+XejCe348iRoucenq1G1Yx15ZRHPDOnryT
	POzE4gu24KzLnkTSSua8cER+yP4aVBj0=
X-Google-Smtp-Source: AGHT+IF8j9BREOrCOYFL8FBPYdBxvd9a652kkY2yOpEvJ04WOo/DTulcAIF/mKex8B+hYmrvM0KmOw==
X-Received: by 2002:a05:622a:207:b0:4a9:ae5a:e8a6 with SMTP id d75a77b69052e-4af10d8de1cmr145731371cf.47.1754322223162;
        Mon, 04 Aug 2025 08:43:43 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:73::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0785d13a2sm5486211cf.39.2025.08.04.08.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:43:42 -0700 (PDT)
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
Subject: [PATCH v3 5/6] selftests: prctl: introduce tests for disabling THPs completely
Date: Mon,  4 Aug 2025 16:40:48 +0100
Message-ID: <20250804154317.1648084-6-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250804154317.1648084-1-usamaarif642@gmail.com>
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
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
 .../testing/selftests/mm/prctl_thp_disable.c  | 173 ++++++++++++++++++
 tools/testing/selftests/mm/thp_settings.c     |   9 +-
 tools/testing/selftests/mm/thp_settings.h     |   1 +
 5 files changed, 184 insertions(+), 1 deletion(-)
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
index 000000000000..ef150180daf4
--- /dev/null
+++ b/tools/testing/selftests/mm/prctl_thp_disable.c
@@ -0,0 +1,173 @@
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
+	/* HACK: make sure we have a separate VMA that we can check reliably. */
+	mprotect(mem, pmdsize, PROT_READ);
+
+	ret = check_huge_anon(mem, 1, pmdsize);
+	munmap(mmap_mem, mmap_size);
+	return ret;
+}
+
+static void prctl_thp_disable_completely_test(struct __test_metadata *const _metadata,
+					      size_t pmdsize,
+					      enum thp_enabled thp_policy)
+{
+	ASSERT_EQ(prctl(PR_GET_THP_DISABLE, NULL, NULL, NULL, NULL), 1);
+
+	/* tests after prctl overrides global policy */
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_NONE, pmdsize), 0);
+
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_HUGEPAGE, pmdsize), 0);
+
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_COLLAPSE, pmdsize), 0);
+
+	/* Reset to global policy */
+	ASSERT_EQ(prctl(PR_SET_THP_DISABLE, 0, NULL, NULL, NULL), 0);
+
+	/* tests after prctl is cleared, and only global policy is effective */
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_NONE, pmdsize),
+		  thp_policy == THP_ALWAYS ? 1 : 0);
+
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_HUGEPAGE, pmdsize),
+		  thp_policy == THP_NEVER ? 0 : 1);
+
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_COLLAPSE, pmdsize), 1);
+}
+
+FIXTURE(prctl_thp_disable_completely)
+{
+	struct thp_settings settings;
+	size_t pmdsize;
+};
+
+FIXTURE_VARIANT(prctl_thp_disable_completely)
+{
+	enum thp_enabled thp_policy;
+};
+
+FIXTURE_VARIANT_ADD(prctl_thp_disable_completely, never)
+{
+	.thp_policy = THP_NEVER,
+};
+
+FIXTURE_VARIANT_ADD(prctl_thp_disable_completely, madvise)
+{
+	.thp_policy = THP_MADVISE,
+};
+
+FIXTURE_VARIANT_ADD(prctl_thp_disable_completely, always)
+{
+	.thp_policy = THP_ALWAYS,
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
+	self->settings.thp_enabled = variant->thp_policy;
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
+	prctl_thp_disable_completely_test(_metadata, self->pmdsize, variant->thp_policy);
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
+		prctl_thp_disable_completely_test(_metadata, self->pmdsize, variant->thp_policy);
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


