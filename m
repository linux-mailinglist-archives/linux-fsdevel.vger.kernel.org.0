Return-Path: <linux-fsdevel+bounces-56405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A854B1713F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D59586B1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30712D0C6B;
	Thu, 31 Jul 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5OJR/Sx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235BC2C17A3;
	Thu, 31 Jul 2025 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964919; cv=none; b=BnajT0tLk9en+0l/pXr2DidPb1OEZn9YzUvzgN2bYKxqdVP+W2Gl34UimVDRjOMxE8tqZdryDGaGYQE+HP3VsJmhpBmvoB+udnkpGid/9KyjITPxWK/BVURUmSOOvsrjLbCDiZ8bbPoAmnVag4sdZ665YE/rq5s9TBRIlEVh56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964919; c=relaxed/simple;
	bh=4ViueuDQjGl4HtttbzkwOuvd6U2q2wk2yvZbY78dZqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tE93eUStRxZwDezPMAK4UxbjzplXMIXkKO/+FAImVpddaYVsEJu2OAMRYLnTv2xdH4Dl117+EHksIGiwHHPMRxJMWje1hJ5ngIGa6y8kUvuG0jwOfd1cOq8nw7V0NdZlQ31R/UwZjNsJc5qnxUyP4ACXVPzhRvB0SAfcfINKve8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5OJR/Sx; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70756dc2c00so4180726d6.1;
        Thu, 31 Jul 2025 05:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753964916; x=1754569716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdseCjeXglmAeSVo3jNDX9M0lKkfFlPBpOaLA9628VE=;
        b=c5OJR/SxTfbCmPl7kddDSw7NBBBgDsYfDG9BXyR4SR1B2TbeEqapA+LrgqQvxvxRZv
         SFxpd7pykVi6Ocm+7097VbSTS5WNT9Jzk27fda8a4bT3Nh1EbnLaO0DTYQMmT5T3KfYC
         jl6PnTi4D++m7qbtNw8w/3+XtRNN4KDZ2JD13fRC4SNxX5teHaJglV7EteztbFjFbPb8
         ri45vtL88X92NTyRR9B/vopmZU2YrmRL70eVyEUutUvK0I6QYyf35pWriBLA0UrKJrRR
         YMzRCHLNlvo1mQQYv81HlykQA29nFLgR/HD2lU4VJXl9i6mYNQIIOfO6L9wzXgCPRvTl
         HS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964916; x=1754569716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdseCjeXglmAeSVo3jNDX9M0lKkfFlPBpOaLA9628VE=;
        b=Cs9jdMkfaXoY4G7FNndBOE3tq52BG6C2t+pU/vPa/Y5k7UY6dtFp3eGvka6OFNH605
         rOIXuuQPx+jjNMXq2wGTkuEnCEJBc8QNDZWxK6N3nkTnpgKhSOKNaplrPZ9zAcgNWfL2
         v2bLnVfedUHvjXU4SUw/mdf4rXmXlqUbLMEvpWaE8RQCOdZms5nanu77mGVUi7Sv1hBc
         03ERLfXA9M7/QVmfnJIkFykXOQFLegdT+Gc3hEst2EgNvDYx+IRPfVeBlG5oGtWArNjy
         cksqKzP+H3po2bIs1msdyEU0ZgutVwRYlW8WJ9NPNPXPRgt8KhEgtSMMJrDxM5MzjUFe
         0w+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmdrZpqM13skOnK0qoOOs9dMWhsxxGGZkCM7bZqQPosO45ipeRhctZbFeTcwc77Bwhd8+m+OMCcFNiM3Y1@vger.kernel.org, AJvYcCUq8wmKApSZ2pXePGbEhUGCbGg+uzS2MvlaWyX4rTJPZLoBwzCXJ9j45BQDnG8uQ4h4WtgCOeXx9FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCgBYs1ROFzaRCjHhX3Jmf8gyMEYqyo7mlY0cwBCjt3KxvaBKA
	vP8F7RB3IMzvALlNxWfQ4iFWTLo3I4WfB2A3mHanEA3YhxPh0o4eoqb2
X-Gm-Gg: ASbGncteAmQk6Kxtwxb1GnWfw1Ght8U/GRvHxJJX0nHlZZVTgeVP7p9QCUov2niLOVX
	ei7utS17mXZs8d/gwGzQPOwoyC48EzrlY6xpCfAvuw883vR5NVyJuM8LO/9fucwAewn7T2NIKto
	y1r/vHfVXtSlw5i2wv+ANWejRjrNdA1mYEmNRMAPKESzFUW+yX10Dh7zYkVQQX8yQUsyWjsK3AP
	/andBdQW3fjDMQUV8rDK07hYhKCbAD9xXeQqydCuThxtmG/cF4ImJwP7H0p8BzqUVdWeeSrwz+j
	epBPLfZ09HCMs2G63zIk25o9lniMYT9fKcLttQBgpt6UPjiHYUdY8TlQz2a9TZdYOQq7Ir8gwDw
	6dbssVfVkURqut6AyXSfQFuHxdfB2Qm8=
X-Google-Smtp-Source: AGHT+IENkVw8ynAfGXw4WuZqiIpcMKUMSu/EtMQV//+NQ4yDeACqLq0qMosxKHrbCo/7QDKjW7aI3w==
X-Received: by 2002:a05:6214:cab:b0:707:5694:89e4 with SMTP id 6a1803df08f44-70767482bd0mr105266576d6.47.1753964915867;
        Thu, 31 Jul 2025 05:28:35 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:72::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca5897bsm6678386d6.39.2025.07.31.05.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:28:35 -0700 (PDT)
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
Subject: [PATCH v2 4/5] selftests: prctl: introduce tests for disabling THPs completely
Date: Thu, 31 Jul 2025 13:27:21 +0100
Message-ID: <20250731122825.2102184-5-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250731122825.2102184-1-usamaarif642@gmail.com>
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
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


