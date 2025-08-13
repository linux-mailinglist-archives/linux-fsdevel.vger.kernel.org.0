Return-Path: <linux-fsdevel+bounces-57720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B251DB24B85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97EF1788DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4247C2FDC30;
	Wed, 13 Aug 2025 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka1S2BUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80922EBBBC;
	Wed, 13 Aug 2025 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093459; cv=none; b=X5+123ayfABh29PTxLYsuh0qnkgK2owhHI50x90b6Raz+U00WYecvPtACf4GWKDKLFKsMeuem1ftzQMFobxZC9ElG4tDaK3ZYv1VaQkl/qpa39KG01AbOZWsCA7hqyz1X2Zx3EVjz/kFjzvZW8GH9Bg8gmoeR5CBl6dfw1DsHck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093459; c=relaxed/simple;
	bh=XrQVjrzS7Y+xHfkwGwu3hl5N1E3oa6cqtB76fgZSn/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCl6qCK92ErXAll4jzZF7fhm++Z9xzUvbf8OCyBey3XZtf1je8ywRoU/im7tJZorAOGQwMmFLXgRQOP8rnF736msVTa1V90VwM9zUPTzSfRgbMmYnEDEdy3ZXByYRCz7M4D0Zk0TxVT4/9g3v/OrEbGJECc8VRRiycil5aZyUMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ka1S2BUA; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b0db8ce2ceso48967621cf.1;
        Wed, 13 Aug 2025 06:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755093455; x=1755698255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl1ogA2t0/rhzsz3n+9Cp7M2nFKkgZbECfidIuzz//w=;
        b=ka1S2BUAwQAn0RcO0EZWCPkWqn2rL4yvV13LQ3i0+06RIX+bRia9/EuFElNqjgTHcW
         NgE0F2jlyWHbpx59RnRqxA7dQIIgL9OSL1P69ei18N6VUBQqJWH4cGmdVAutYiO9/lKK
         5igcUYmdL9sl0OHyQPGiqWBLKIV/1zCbEsTyXx4q6YtCbHvpHzy5+VFu7VMx6Hoyquej
         K8VPdtREy4Y6zlgxHGkbtDenIUMqbTw5SVcoSpWMAzltxxbrk+ib4K1oU37O70KOJ8Ko
         g2iNFE0RLaRufJwv0Efmo5wGCGFLPxirLdO85PUFrUTo6uWcqb0EFs0uFECXo2+dB3jx
         2ARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093455; x=1755698255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dl1ogA2t0/rhzsz3n+9Cp7M2nFKkgZbECfidIuzz//w=;
        b=QQ8cQkWOHXqMsLSXV7nqIuGKjuqrfuJGH66rKSdwzBwhBS4zNfMbP8NuUsDtd7l0Yg
         OmOArql0G9z6u+4cPybpCUJBlJS0vryCRtW7IP2wHcnbpAA6gU9DnX6U7tG5yv25I16n
         Xbrsv75Ro/fzAqecwKf6Ll9aGriTXkANBmFGEM1+8sssZulSnigwTLquI+Ct3by6oFHA
         zvqalcX6ChsCD4QXmP4+StAJnd3dT2iek7fW/7Wv4aC/LWuhdc0UsP+CBuIZA3Se3zDK
         Fd91n5uNac20zr9Tk8AhtwxP0koeook9CDm57/yNv1SC3M27D1o2s7ND1uct3ShxTr4+
         pGyA==
X-Forwarded-Encrypted: i=1; AJvYcCUoix22SR7bdkwLwc+2uLkSeTbxyFyixggLdn8W4Z4WGH610A2RFvCqCb5uoHqeRHGsJOCFh8hrjh4=@vger.kernel.org, AJvYcCW104EQIfo50gMQo0VIVAA8QDuN1S+2rIRAjilxfA7ZirvXUlHcouIAxJ5RAQK7d0SrJerqDY6LceqhdGRA@vger.kernel.org
X-Gm-Message-State: AOJu0YwISu+mlsnJ0otaNdqFPdJe6c2UbsKSe5vyskN2VE8j/aG394iA
	EpVty/rDkrAZoQIJ5txD60S2kJXywcfhQYhIaHzXH/Gezvm1CjdYDvmU
X-Gm-Gg: ASbGncs2P7I8NjbivklealBEBb4CeZhqEcL/rVxJvCCzkuXVy8ESuymzjCH/9eawWkJ
	EsP6GcjuyPxGxrl93kH3dPOC4M/Mp3oJgjX9vr/kI024p6OsC8VT8YUmTFSuFhJWQ0/xLqfXI4O
	F5adP+yahVG84sgmDUwG7UUJybEZgTVsyYTJgee0qUJatQafO1YcfxP2ise8D0KCXpUUKLHXgnV
	DhaVjOh962gfe3nNkjoosdXHtcV3PyJjQYVXuraPkZuYX8Pb922JhYQ1gR1mKn7tCLsf5HB/suo
	5HJ3MSWjSyyT2uz6LiXslXTk3D8Ihtw2c1fs5WjK1EOmpfYppy8kt8CBfmfT/AWY/Jbq28i+FdT
	OY0hdIT+J5hj6v3lg
X-Google-Smtp-Source: AGHT+IE3NUx60T3Uu+LLxZcNnNSoL99GfNvHrmsdXpcXcGYhBL0SlbNyWV0ClKfn+88SoUddsaqGFQ==
X-Received: by 2002:a05:6214:20c3:b0:709:9ebe:a5b1 with SMTP id 6a1803df08f44-709e881f8b0mr40314116d6.13.1755093455474;
        Wed, 13 Aug 2025 06:57:35 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-709a0d74acfsm85017666d6.58.2025.08.13.06.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:57:34 -0700 (PDT)
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
Subject: [PATCH v4 6/7] selftests: prctl: introduce tests for disabling THPs completely
Date: Wed, 13 Aug 2025 14:55:41 +0100
Message-ID: <20250813135642.1986480-7-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813135642.1986480-1-usamaarif642@gmail.com>
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
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
The fixture setup will also test if PR_SET_THP_DISABLE prctl call can
be made to disable all THPs and skip if it fails.

This tests if the process can:
- successfully get the policy to disable THPs completely.
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
Acked-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../testing/selftests/mm/prctl_thp_disable.c  | 168 ++++++++++++++++++
 tools/testing/selftests/mm/thp_settings.c     |   9 +-
 tools/testing/selftests/mm/thp_settings.h     |   1 +
 5 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/mm/prctl_thp_disable.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index e7b23a8a05fe2..eb023ea857b31 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -58,3 +58,4 @@ pkey_sighandler_tests_32
 pkey_sighandler_tests_64
 guard-regions
 merge
+prctl_thp_disable
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index d75f1effcb791..bd5d17beafa64 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -87,6 +87,7 @@ TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += pagemap_ioctl
 TEST_GEN_FILES += pfnmap
 TEST_GEN_FILES += process_madv
+TEST_GEN_FILES += prctl_thp_disable
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += uffd-stress
diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
new file mode 100644
index 0000000000000..8845e9f414560
--- /dev/null
+++ b/tools/testing/selftests/mm/prctl_thp_disable.c
@@ -0,0 +1,168 @@
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
+	if (prctl(PR_SET_THP_DISABLE, 1, NULL, NULL, NULL))
+		SKIP(return, "Unable to disable THPs completely for the process\n");
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
+	prctl_thp_disable_completely_test(_metadata, self->pmdsize, variant->thp_policy);
+}
+
+TEST_F(prctl_thp_disable_completely, fork)
+{
+	int ret = 0;
+	pid_t pid;
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
index bad60ac52874a..574bd0f8ae480 100644
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
index 6c07f70beee97..76eeb712e5f10 100644
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


