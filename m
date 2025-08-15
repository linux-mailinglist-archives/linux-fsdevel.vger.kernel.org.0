Return-Path: <linux-fsdevel+bounces-58019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1B0B28104
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 15:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638361D00EDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 13:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89309307AC7;
	Fri, 15 Aug 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aatNFmZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A0306D55;
	Fri, 15 Aug 2025 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266168; cv=none; b=VHkYdzLpC428yJU5UnkHHIHGfUxFiMLmOqc5K7aoi7PAn4RYJE1pIdie+KOngPZIZzOamjE/TpVGUxeDsbsiYxhuuxJSeJwIpNGf3aiAYyrnDMrD9ScbACBew2hFX7phIvv78vBn1a7SogHOehnJEQnlIte5+7mKwyFfkpBzSoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266168; c=relaxed/simple;
	bh=gqKG3x2482aPgHHgIqYYA6kaxCzewtm+iS09hO7miPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwgfOK7DaUP9DSp3vIzDlmNsCjWHHpZHkioHsT+8r053XE3CGLoNdXRYp54fTih/qwJvJgs8hckxCnfS9u73pu4pGy/72dOJHNOto70nufO/YuJvojoyHtgx1THA4MEwKtD8aZOkht0mWyZ+sQgRfHHZEB1WVkcjkqGC/wu5CVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aatNFmZV; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b109bcceb9so22867251cf.2;
        Fri, 15 Aug 2025 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755266165; x=1755870965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDJg+8VWkXRRI01/m0uJH2Q2Hi8ld8jM3wHbWmjFcUE=;
        b=aatNFmZVLMu/SxZaJxS5VeMDAOvc+h5I1xChcu6qwDd7GI+r+UCstIvr/+EJ58Eych
         qtIOSs4U3Thd9chI8ujK+MI4o7zswsy5/5qtPWKZE/qJJf3+xeKfcLivfJzQhG3QSA/V
         3ARXu853YCyfMyh2rg3q3sQjL3JqZIRdQpFHd6Bo3SXMvvCISk8hTIlbvlZcWm3bh+lu
         go0wqCbRtcxW2rYLr2NHcmoXn861z/dKamataj6C3pHR0VI+2dJzJGQflcs91Q+HNWFm
         G2pYc8gKISJ3295X6syfJR+e9GXP769oc6ZeJWuEpSq7WNix1rKGe1tR3+ejXty2A5rW
         Vrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755266165; x=1755870965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDJg+8VWkXRRI01/m0uJH2Q2Hi8ld8jM3wHbWmjFcUE=;
        b=YFywOiYBiiq6VToF9MtVL8kzXojDceLOVMiRm4BQM+pDE56cWTtyXHIHySnedzOtQi
         CBuQ8NhPDt/13JtOdKnwJiBPBnzVl/6WqGOusmiMzfLrrKCkp0ynO+YSELtJQyZDNlAm
         Wk224zvD4BvVkAoFQVJ5dxY+Hat4tSjIeeH16vyJ6DwWb8239KiPH1cWcjv6wFRR0p0X
         c7IjJIyFxiNCrdZ3aZORDYYS8bJ3MZuHAkjBPMmTY+TePwTGUFH/fzhXZiUUpaRt4yje
         clpTwDaVnFGFpjbi+KGymzT/CNqhZwoKiFAhgExIyzN8dF/W4+xg5jiHBNdkW6wAUXBA
         yXCA==
X-Forwarded-Encrypted: i=1; AJvYcCVfSlg7PNP8/84xrGQWuJPgBLx6AjFn0vYUZhLuQTG9oaiwZ83cNsVTm+KX7+HJcUZMcbekf2qn3KHCKpqZ@vger.kernel.org, AJvYcCWprdRIVR07X/43d+We9rcIb1yVpBKqc4Y6catwjH2tTk4iffqLN928B1XqcH6K29NWksCtRdQ+E7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAtSbSRbUB/6W4oYB7YAEeqSFK3TJglOdI6we5JAsFehodp05c
	m/zX3dI6oYbdULY3+JItp+FWn8WaRMdDOmjGSYlYZHIPC/ZwNnc/263r
X-Gm-Gg: ASbGncu/MilHwO44VmTXKASrX8LQf1Nq3PvJd/LQP9y+fdqgYXKVx2J5rYbazVJjy0l
	sihOw5jyQWdeVe6OFdd546i+ACSVNuOVfMDNnDbM6sLDQa4fHNbbKJrUv+B0bacnrNJglI3Nras
	6TMqjzsMOw70Fq6pLFZ2GLrl1tv100aZwUYwlRAVxr8KfejRZH3vt+Z3LH6KnwWRkpPKgGIZurf
	Uxdn/h6pbmIigV8bT+LHX7bdHPTy6ShhXdJWCJ3rO3wdbP6TTcTQqmj4npTqdSctxVErFONOPAQ
	KWK40redap3S5Z4bK65XmnI3ZFh5GhJ1JBZpFpbERNNBxOaW6tja+VZV9tDW7OzZEWJYSMg7+LA
	nMZACU4qdPbusw/CMfns=
X-Google-Smtp-Source: AGHT+IGiowQqpHScj8TmKBlVlJNsOwsO0+vsYR/6GIDeAkEcuuhXzeHkMw4QTi8JVjdMqvbPaYNdmw==
X-Received: by 2002:a05:622a:8ca:b0:4b1:103b:bb6b with SMTP id d75a77b69052e-4b11e315af2mr26902261cf.61.1755266165043;
        Fri, 15 Aug 2025 06:56:05 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:7::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dddb0f4sm9436461cf.38.2025.08.15.06.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 06:56:04 -0700 (PDT)
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
Subject: [PATCH v5 7/7] selftests: prctl: introduce tests for disabling THPs except for madvise
Date: Fri, 15 Aug 2025 14:54:59 +0100
Message-ID: <20250815135549.130506-8-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250815135549.130506-1-usamaarif642@gmail.com>
References: <20250815135549.130506-1-usamaarif642@gmail.com>
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
be made with PR_THP_DISABLE_EXCEPT_ADVISED and skip if it fails.

This tests if the process can:
- successfully get the policy to disable THPs expect for madvise.
- get hugepages only on MADV_HUGE and MADV_COLLAPSE if the global policy
  is madvise/always and only with MADV_COLLAPSE if the global policy is
  never.
- successfully reset the policy of the process.
- after reset, only get hugepages with:
  - MADV_COLLAPSE when policy is set to never.
  - MADV_HUGE and MADV_COLLAPSE when policy is set to madvise.
  - always when policy is set to "always".
- never get a THP with MADV_NOHUGEPAGE.
- repeat the above tests in a forked process to make sure  the policy is
  carried across forks.

Test results:
./prctl_thp_disable
TAP version 13
1..12
ok 1 prctl_thp_disable_completely.never.nofork
ok 2 prctl_thp_disable_completely.never.fork
ok 3 prctl_thp_disable_completely.madvise.nofork
ok 4 prctl_thp_disable_completely.madvise.fork
ok 5 prctl_thp_disable_completely.always.nofork
ok 6 prctl_thp_disable_completely.always.fork
ok 7 prctl_thp_disable_except_madvise.never.nofork
ok 8 prctl_thp_disable_except_madvise.never.fork
ok 9 prctl_thp_disable_except_madvise.madvise.nofork
ok 10 prctl_thp_disable_except_madvise.madvise.fork
ok 11 prctl_thp_disable_except_madvise.always.nofork
ok 12 prctl_thp_disable_except_madvise.always.fork

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 .../testing/selftests/mm/prctl_thp_disable.c  | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
index e9e519c85224c..77c53a91124f1 100644
--- a/tools/testing/selftests/mm/prctl_thp_disable.c
+++ b/tools/testing/selftests/mm/prctl_thp_disable.c
@@ -16,6 +16,10 @@
 #include "thp_settings.h"
 #include "vm_util.h"
 
+#ifndef PR_THP_DISABLE_EXCEPT_ADVISED
+#define PR_THP_DISABLE_EXCEPT_ADVISED (1 << 1)
+#endif
+
 enum thp_collapse_type {
 	THP_COLLAPSE_NONE,
 	THP_COLLAPSE_MADV_NOHUGEPAGE,
@@ -172,4 +176,111 @@ TEST_F(prctl_thp_disable_completely, fork)
 	ASSERT_EQ(ret, 0);
 }
 
+static void prctl_thp_disable_except_madvise_test(struct __test_metadata *const _metadata,
+						  size_t pmdsize,
+						  enum thp_enabled thp_policy)
+{
+	ASSERT_EQ(prctl(PR_GET_THP_DISABLE, NULL, NULL, NULL, NULL), 3);
+
+	/* tests after prctl overrides global policy */
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_NONE, pmdsize), 0);
+
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_NOHUGEPAGE, pmdsize), 0);
+
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_HUGEPAGE, pmdsize),
+		  thp_policy == THP_NEVER ? 0 : 1);
+
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_COLLAPSE, pmdsize), 1);
+
+	/* Reset to global policy */
+	ASSERT_EQ(prctl(PR_SET_THP_DISABLE, 0, NULL, NULL, NULL), 0);
+
+	/* tests after prctl is cleared, and only global policy is effective */
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_NONE, pmdsize),
+		  thp_policy == THP_ALWAYS ? 1 : 0);
+
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_NOHUGEPAGE, pmdsize), 0);
+
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_HUGEPAGE, pmdsize),
+		  thp_policy == THP_NEVER ? 0 : 1);
+
+	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_COLLAPSE, pmdsize), 1);
+}
+
+FIXTURE(prctl_thp_disable_except_madvise)
+{
+	struct thp_settings settings;
+	size_t pmdsize;
+};
+
+FIXTURE_VARIANT(prctl_thp_disable_except_madvise)
+{
+	enum thp_enabled thp_policy;
+};
+
+FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, never)
+{
+	.thp_policy = THP_NEVER,
+};
+
+FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, madvise)
+{
+	.thp_policy = THP_MADVISE,
+};
+
+FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, always)
+{
+	.thp_policy = THP_ALWAYS,
+};
+
+FIXTURE_SETUP(prctl_thp_disable_except_madvise)
+{
+	if (!thp_available())
+		SKIP(return, "Transparent Hugepages not available\n");
+
+	self->pmdsize = read_pmd_pagesize();
+	if (!self->pmdsize)
+		SKIP(return, "Unable to read PMD size\n");
+
+	if (prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL))
+		SKIP(return, "Unable to set PR_THP_DISABLE_EXCEPT_ADVISED\n");
+
+	thp_save_settings();
+	thp_read_settings(&self->settings);
+	self->settings.thp_enabled = variant->thp_policy;
+	self->settings.hugepages[sz2ord(self->pmdsize, getpagesize())].enabled = THP_INHERIT;
+	thp_write_settings(&self->settings);
+}
+
+FIXTURE_TEARDOWN(prctl_thp_disable_except_madvise)
+{
+	thp_restore_settings();
+}
+
+TEST_F(prctl_thp_disable_except_madvise, nofork)
+{
+	prctl_thp_disable_except_madvise_test(_metadata, self->pmdsize, variant->thp_policy);
+}
+
+TEST_F(prctl_thp_disable_except_madvise, fork)
+{
+	int ret = 0;
+	pid_t pid;
+
+	/* Make sure prctl changes are carried across fork */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (!pid)
+		prctl_thp_disable_except_madvise_test(_metadata, self->pmdsize,
+						      variant->thp_policy);
+
+	wait(&ret);
+	if (WIFEXITED(ret))
+		ret = WEXITSTATUS(ret);
+	else
+		ret = -EINVAL;
+	ASSERT_EQ(ret, 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.47.3


