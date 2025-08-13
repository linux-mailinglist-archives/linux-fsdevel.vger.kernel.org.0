Return-Path: <linux-fsdevel+bounces-57721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95384B24B88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D558417975D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8782FE583;
	Wed, 13 Aug 2025 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhQCNe7a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145CF2FD1A3;
	Wed, 13 Aug 2025 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093460; cv=none; b=DYfXCbKSQuJ/oAzkMfcI9oLFrLu4p0JhLTin68mTxaPMbxVwtMOKb85HsBlWFn96SJHvI3PH23ha1v4jzQDKZNkjSwo06i0B3K8wnUGswL7whmDWV6PW2bU+8kZyu6tocdylOUvpmPXTiB5zK6OiAXHF6UQoY2xSZnSiO4p2LiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093460; c=relaxed/simple;
	bh=ebdm6ZrZ//K+f8jafymwHQeElqIB/1sE3AxVgO1wS+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJCQXdgTBkqerqKW3ctBSosprYtmwuJevLZ8D7nc4+BAKoml7tGqbvqGNI9ZQ4CGmQJMruCYMEVSkM9i+8U6xdXTdZ3pE6dAoyBTmdgLsij6FDeixPiXWDUmAJTpR3abtxyymrHEed8bPIlg4xn+TRmkC0/gOWj4iqi209rLU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhQCNe7a; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fa980d05a8so64447826d6.2;
        Wed, 13 Aug 2025 06:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755093457; x=1755698257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhYoYaOUMkMJm97VAKTBrfYYMNfg62ONv3OFOKZnE0Q=;
        b=EhQCNe7aJS8B8DxlqG0ZQfSqBOgD6cgXGXyoLhKlI5CKY5/QM5L/oxOMQU+Jut3j+L
         tzWWQd7MCGT4RPLvozVZSBB8lYUwHioTveaM6+/UWw6UzohmwJMQNEafMN7Vqi8ZiMJq
         ZR8lkFKt5cmf8olbJlYifLTghyEuH8PkAMep2EOq2Kva8Jwa9cKI3B+K12cJMW35XNws
         5TF/rD5UZC3pkPLDnEZpcOfx7O+6SHyZ/wa1WmjBufUFHFgNHMHgf+eIfURMi63w1FJM
         8XNpw2GZxRvhjd0A7jtVagNLsdrvMjIgb0Qh6X48xvy3Tx7+3PpJBcKP3HsbbeDEu6so
         k0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093457; x=1755698257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhYoYaOUMkMJm97VAKTBrfYYMNfg62ONv3OFOKZnE0Q=;
        b=rGhk9hyZAqHrYZvFDjjg7JYNP/Ueqf+F3Wrl4KaJdVeMf25syz8SNkSj7YyLyaqwTl
         RjOgcAGAwxQNRCr3h5LTMXQV2djVh0uLMr/I3SYQF49EZre51cmq85JqqJU1udjU3zCr
         pTqfv2xLgHdAfkePhL6m4rTuLcrpIhL9N7q7C8dabRCTi00lSBMA/98bOBA6IhDtPiT3
         8IhAXo9hR4pLI23/tEC1E7m1glrPhg1Okn2QvqBRTvjzIlMBVkgvV7Rpj71h3Kc3OxB0
         ed4FpxzPjD2wl8th/DhO0pzO7ggnvmX5Cc9F2T4oYCebTVc7BS1B9n1rV19jvv76ddDL
         3k+g==
X-Forwarded-Encrypted: i=1; AJvYcCU9QFZ4YX/UtcFglhsIUY5NsF4BD0XuEDBr8LjhZ+tqaBl9yAz43twAPlLv3Anu9I1x/9SvOZJt951dYcgO@vger.kernel.org, AJvYcCVGxUu6bxIkJHyoIOZe3JvP5yT/IuikNCNXj8kJrOVcp2lf+MYBRgDOmccqBnfe1mVliLpNF+U+6Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6teq0IIMyHYx+SAt+4XF4llyR80cxZrykIiSpduuhSMgrRHu1
	KSEj1UZI3OLJULZNHUHau1LcXl4D45cpGQxKw98VAFb5/WJaOwdW4aXg
X-Gm-Gg: ASbGncufEU/k0Co9uRcjJTVJFhbFARAFuhMVO+DINovAs0kuMuRCZfzazZmJt6tYAL0
	O6qjg5eiFq3R+2HJ3MffnDkhaMNfam3vPSiBi8XyQkjSSUQpHjDn1LHMzZ+pGzHpQ+Zez3NCe1d
	Fyd/tuZ9lmFWaNk/AZO8JJDkDyLCeljL4z7IYZtHz74p+PUXO1cSljaz7vgZLd9+4O95xrkYWY5
	Et3tAIeK7/wdTMH/z25/VFdc2K+jA1Zr2P5MqAw2+frSgOx/+9Nx1t0o405uO53swjaM4Oviah6
	GFc8VRAxJw7he7OQbHFUOXmnX7w3NvyisD0K/rb8iERJyEd/U+BkGVkjiSsTYRgNgQq6jIsDPBU
	4t7APQoWB7gefKqFEJtHdP+cRDAfaOA==
X-Google-Smtp-Source: AGHT+IH0aNFGdT37nfMrLCaAZe/cVvkGkftyTgbVTAS04COtTvWgOnAfg0kobetjfsL/1x4PZf63Ag==
X-Received: by 2002:a05:6214:1c82:b0:707:6364:792f with SMTP id 6a1803df08f44-709e87a7fc0mr35875056d6.11.1755093456671;
        Wed, 13 Aug 2025 06:57:36 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:6::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7097398b38csm125600306d6.72.2025.08.13.06.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:57:36 -0700 (PDT)
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
Subject: [PATCH v4 7/7] selftests: prctl: introduce tests for disabling THPs except for madvise
Date: Wed, 13 Aug 2025 14:55:42 +0100
Message-ID: <20250813135642.1986480-8-usamaarif642@gmail.com>
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
 .../testing/selftests/mm/prctl_thp_disable.c  | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
index 8845e9f414560..9bfed4598a1a6 100644
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
 	THP_COLLAPSE_MADV_HUGEPAGE,	/* MADV_HUGEPAGE before access */
@@ -165,4 +169,107 @@ TEST_F(prctl_thp_disable_completely, fork)
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


