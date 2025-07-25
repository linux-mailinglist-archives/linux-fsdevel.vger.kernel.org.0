Return-Path: <linux-fsdevel+bounces-56045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8CBB121F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 18:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7608217BD28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26C42F0021;
	Fri, 25 Jul 2025 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH4sfpqZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C712EFD99;
	Fri, 25 Jul 2025 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460590; cv=none; b=ltYG6WW2Y2XBPGNcNbymWWVl0g56919Oi0IOdrwfFoVXQu7o45jwBc62/gbNru8rRKFT61Fq56AbJH3B2kGuyzeOqjhLZzshzmWWGPnfnSfXKRixWNhil5JAc00/9zTHDOJD0q9Ypzh7VCV1/bCHNkYESGGf21go6RoB3vGN9e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460590; c=relaxed/simple;
	bh=LkB88lWIbkM8o0a2fZPfu3489tAdfyFV07pwUyZ9Z0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFOkBDrV5nnNkPbAWDwUpnVzgN5OSEj73LeZx6EcnADL2Bqf6/9zh5ab6rWMyIbbrlptS49DmExmTngb9SponnBTjasO+vP8hcu2GK3Co2ZRktiLhLlIGW9lbEek4GHop6qKM05b+7DySrV7YaMwg821MUvyzSaWmiEftb1Uawc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HH4sfpqZ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ab81d0169cso29277111cf.2;
        Fri, 25 Jul 2025 09:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753460586; x=1754065386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2nMfW+8EG0yHdd/y9pp9Ykp4/bgoGWX5aUFmAoHq2k=;
        b=HH4sfpqZl54F0KoL0ccU32DeF235n+JQF607FyDRzumLVnGKopXawOVrsncpUbq0vi
         dDyQjJEzic9dQHM9UK6iJbqzSpfdIyA4dNxCLJ2e4oldOQsPvOzq7ysGgxMo4Z+wuHCN
         BgJOA49fmefS3zrj20BsZKVTjopEtznwrn/drAKucmE02XKWqYNzTwiuRTTOydm9ZdAZ
         kfSAxm9oCpZIkIA+Mou7fhABPo6h1yqZ1JVIi+XmE988mS+g6Rw2b2N68JypwnwwXKZ7
         5jdlMODs3sPExBUEOX6KzU1w+Lfhmxiva6oPZOjDMpPvoa2dzUaGyJQRrt6UvdSMMBmJ
         N+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460586; x=1754065386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2nMfW+8EG0yHdd/y9pp9Ykp4/bgoGWX5aUFmAoHq2k=;
        b=csD+f2E6LVjun+Gz+aCNnWMnlul/C2m7XDHhPKeRelWML+zG7NW69TAKTj3kCojqWQ
         aaLJOcbkENwuqUIQkFvO20TniODXZNedC+wAwIQ1PmrHPB0obuy9gWDQzXZKTFoQHO3f
         ov7ztPF0mmhYrx47TYCNuehw+Cjsvmk5+MX5jHnDTFXjc6tTDHkhGHDD3TpiaAeHrzxZ
         oAnhGJlySD4r35MACpAcdDhFe7SUGnAZu/wfLxlwc+NsYL9MCHcMd+e5cLKoqk9MRHZt
         LNGnFFe+YRgjGQ2ZvCboFyyJShEe8AKqkScsMIfmjpqDPIpfcY1OIxWuhqkrCsNOwuDA
         htgg==
X-Forwarded-Encrypted: i=1; AJvYcCWa9gDy5pwLfg6YuseLHweYtlKSN8kjyvSx52seHd/QNSf/xQLwAiq03WiigTJwc7zdaZwJAEYCq3W595go@vger.kernel.org, AJvYcCX0pwnnRBJuRWA3A7V/rF9Qm2tQcAsAXqHb62Eqbm9gpDkE2jWhpcE3zMy6efZD/Kl15MbjvZWDOYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHx3kXHA/IjFhQ2KoKWl6eJ8U0G6kbLk9BXZfuNhwJA2cQ6eDN
	NCo3CSB4qWTeRl7INvXIZ2qHRp6m3BDSl4PJbttaijzGKmzKZFrx3GRv+SRsCaS1
X-Gm-Gg: ASbGncsuBT8qtwOSOpsuiCdgML/7dDODivRiaLkg0O6cJC8XW8HSTu76HAUSwjFHZrk
	duz6KZk+5XEth7TzzOch5EMOzHbFk10Jt36jTkhoh8s5WrQCKk2Z5tYgi4hGpuhO9tA9ML018ae
	vlyc3CLgYWSWAgbvycPEZBXOTj9q9kYK85j0YSBl45U7V/g2Y8rKhMpa9gO65irrPhlH2wkfQQY
	tTRdUVszxf10+SUbYzOQzfnaFIlBpPOkqytpMJqm9eg4nPvGvXh5S1OIdnUtc16Vqdm5opoaDYB
	kmDI2zL+tBafl+5RtoXaS0c8XAFXdar1gQskT0+8lI8wBOl1ZmpaSvhog3YvGmsq+ArpOjPqmzm
	1kjgHSYg2hfWIZjTgQusWYmFhIli5Ww==
X-Google-Smtp-Source: AGHT+IGhB0ODduWZoA0stvQcbydiYz6AaKK3E3SHNDplUWRJe9PTwU9UCJc3fawE6uOksSdsUztLVA==
X-Received: by 2002:a05:622a:1348:b0:4ab:6a1e:ea51 with SMTP id d75a77b69052e-4ae8edcdf0bmr33885121cf.11.1753460586010;
        Fri, 25 Jul 2025 09:23:06 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:6::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae99516fcesm1906231cf.9.2025.07.25.09.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:23:05 -0700 (PDT)
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
Date: Fri, 25 Jul 2025 17:22:43 +0100
Message-ID: <20250725162258.1043176-5-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250725162258.1043176-1-usamaarif642@gmail.com>
References: <20250725162258.1043176-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test will set the global system THP setting to madvise and
the 2M setting to inherit before it starts (and reset to original
at teardown)

This tests if the process can:
- successfully set and get the policy to disable THPs completely.
- never get a hugepage when the THPs are completely disabled,
  including with MADV_HUGE and MADV_COLLAPSE.
- successfully reset the policy of the process.
- get hugepages only on MADV_HUGE and MADV_COLLAPSE after reset.
- repeat the above tests in a forked process to make sure
  the policy is carried across forks.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../testing/selftests/mm/prctl_thp_disable.c  | 162 ++++++++++++++++++
 3 files changed, 164 insertions(+)
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
index 000000000000..52f7e6659b1f
--- /dev/null
+++ b/tools/testing/selftests/mm/prctl_thp_disable.c
@@ -0,0 +1,162 @@
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
+#ifndef PR_THP_DISABLE_EXCEPT_ADVISED
+#define PR_THP_DISABLE_EXCEPT_ADVISED (1 << 1)
+#endif
+
+#define NR_HUGEPAGES 6
+
+static int sz2ord(size_t size, size_t pagesize)
+{
+	return __builtin_ctzll(size / pagesize);
+}
+
+enum madvise_buffer {
+	NONE,
+	HUGE,
+	COLLAPSE
+};
+
+/*
+ * Function to mmap a buffer, fault it in, madvise it appropriately (before
+ * page fault for MADV_HUGE, and after for MADV_COLLAPSE), and check if the
+ * mmap region is huge.
+ * returns:
+ * 0 if test doesn't give hugepage
+ * 1 if test gives a hugepage
+ * -1 if mmap fails
+ */
+static int test_mmap_thp(enum madvise_buffer madvise_buf, size_t pmdsize)
+{
+	int ret;
+	int buf_size = NR_HUGEPAGES * pmdsize;
+
+	char *buffer = (char *)mmap(NULL, buf_size, PROT_READ | PROT_WRITE,
+				    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (buffer == MAP_FAILED)
+		return -1;
+
+	if (madvise_buf == HUGE)
+		madvise(buffer, buf_size, MADV_HUGEPAGE);
+
+	/* Ensure memory is allocated */
+	memset(buffer, 1, buf_size);
+
+	if (madvise_buf == COLLAPSE)
+		madvise(buffer, buf_size, MADV_COLLAPSE);
+
+	ret = check_huge_anon(buffer, NR_HUGEPAGES, pmdsize);
+	munmap(buffer, buf_size);
+	return ret;
+}
+FIXTURE(prctl_thp_disable_completely)
+{
+	struct thp_settings settings;
+	size_t pmdsize;
+};
+
+FIXTURE_SETUP(prctl_thp_disable_completely)
+{
+	if (!thp_is_enabled())
+		SKIP(return, "Transparent Hugepages not available\n");
+
+	self->pmdsize = read_pmd_pagesize();
+	if (!self->pmdsize)
+		SKIP(return, "Unable to read PMD size\n");
+
+	thp_read_settings(&self->settings);
+	self->settings.thp_enabled = THP_MADVISE;
+	self->settings.hugepages[sz2ord(self->pmdsize, getpagesize())].enabled = THP_INHERIT;
+	thp_save_settings();
+	thp_push_settings(&self->settings);
+}
+
+FIXTURE_TEARDOWN(prctl_thp_disable_completely)
+{
+	thp_restore_settings();
+}
+
+/* prctl_thp_disable_except_madvise fixture sets system THP setting to madvise */
+static void prctl_thp_disable_completely(struct __test_metadata *const _metadata,
+					 size_t pmdsize)
+{
+	int res = 0;
+
+	res = prctl(PR_GET_THP_DISABLE, NULL, NULL, NULL, NULL);
+	ASSERT_EQ(res, 1);
+
+	/* global = madvise, process = never, we shouldn't get HPs even with madvise */
+	res = test_mmap_thp(NONE, pmdsize);
+	ASSERT_EQ(res, 0);
+
+	res = test_mmap_thp(HUGE, pmdsize);
+	ASSERT_EQ(res, 0);
+
+	res = test_mmap_thp(COLLAPSE, pmdsize);
+	ASSERT_EQ(res, 0);
+
+	/* Reset to system policy */
+	res =  prctl(PR_SET_THP_DISABLE, 0, NULL, NULL, NULL);
+	ASSERT_EQ(res, 0);
+
+	/* global = madvise */
+	res = test_mmap_thp(NONE, pmdsize);
+	ASSERT_EQ(res, 0);
+
+	res = test_mmap_thp(HUGE, pmdsize);
+	ASSERT_EQ(res, 1);
+
+	res = test_mmap_thp(COLLAPSE, pmdsize);
+	ASSERT_EQ(res, 1);
+}
+
+TEST_F(prctl_thp_disable_completely, nofork)
+{
+	int res = 0;
+
+	res = prctl(PR_SET_THP_DISABLE, 1, NULL, NULL, NULL);
+	ASSERT_EQ(res, 0);
+
+	prctl_thp_disable_completely(_metadata, self->pmdsize);
+}
+
+TEST_F(prctl_thp_disable_completely, fork)
+{
+	int res = 0, ret = 0;
+	pid_t pid;
+
+	res = prctl(PR_SET_THP_DISABLE, 1, NULL, NULL, NULL);
+	ASSERT_EQ(res, 0);
+
+	/* Make sure prctl changes are carried across fork */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (!pid)
+		prctl_thp_disable_completely(_metadata, self->pmdsize);
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
-- 
2.47.3


