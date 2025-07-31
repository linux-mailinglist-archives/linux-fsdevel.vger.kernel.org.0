Return-Path: <linux-fsdevel+bounces-56406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4C5B17144
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2D0170CD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CC02D12E2;
	Thu, 31 Jul 2025 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYVt4S29"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7015A2C3276;
	Thu, 31 Jul 2025 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964920; cv=none; b=nBUucWWf4652CqscDg6Pv2qaCpF4evRbL6zAd0g8Gt0oC7KfsULGUnOiTzBm2v5UMF9qPofQWe3/D0gWZt3q/qprhMHdo2ewoOpV6+K/P2ESsHKaHfzN7/Csm4BQN+BhdaZgG/cFf9AbMZr4GmZntbyuJKvOfTwdGrCmlqovTKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964920; c=relaxed/simple;
	bh=Xo2axdleKQKFm0NOSldkhQ8qF+6YtByFGwnagPvP6uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcDhp5gtMcabH+JvsqOPVISGEjQlkR9eskGBXRhzx05yGpkNRq3oJhrL4L3tiDnC1ntyyyWNVbOByIcA89rR/8lls+Y3AQX1ZRHTTffDQlV+i1P2QiSCRWhm/R7/70OE722k5O2DuXNJdHdxp27xlLKEgnMt8thZC59X7vkgYWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYVt4S29; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e6817653d0so55747585a.2;
        Thu, 31 Jul 2025 05:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753964917; x=1754569717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayWZPS7L38ZOhjcOnH9WSUS7UcJth2Mxw9Vr7h3Jt6g=;
        b=mYVt4S29VjTPQMr0r+iPvsPY5huy4h+5oBFoH2F7H1Sx6ynx20MAJZVNeH4ZO0tfBJ
         Ro6BmVrzC+LMz9rOCvvXGkuGmn1/ENiXhXYGM6xlODFKpnmhuaZA1Wo7b2rWUDxy8ISd
         TY4bMNdaXeWXw5fujZUfDC8wOs2XVvTH3M/ppKfPpVmaMj5pPpK7+8ZgSxdM6X/cOX3O
         EBXSBkbPw1uoYQGobWk6mzmxMtbu9wAeJYXsKDlLLm6vI8wpaaI+dDzxeLbjbyuAewb5
         Wlt+q93ZrhYfefwGU+2YPzrmgLp8RTxLn/mcIe6YzGN5564QFO/iWAY7s1yyC4FCFMf9
         MQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964917; x=1754569717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayWZPS7L38ZOhjcOnH9WSUS7UcJth2Mxw9Vr7h3Jt6g=;
        b=wk6k5skPWayReXzylZxdIujC/Zw0OI6eUlDn0Jhd0xd6vdH6xVDcMMYp7fIjpuK+bV
         vch0h7m8X++mGtNotMQkzYdhyjsY47HYYTdakEB6sbgV8UZyL4DpPHfUNZ/vsvkC4iCx
         KJ/E9cAF+Zi1yVfG808GcJX68PSEd5tl0ySLUxve0uplBAG+Gyn3Quy/rdag5M76R4SR
         6rCsr0Fx1qb1DdwcLdGn1UgSPdYahHgWKGsYr9l1GPZLrJpm18WG9K+lz9qyRsYgA2Fe
         D4bp9YzBMDFAvLZ01MxegwZUQCzBJqnTOc3tsOLDNnSfqRuyaSngtAKkCXfPkJ3esWmb
         //Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUqzwtUUV5zCgVUi9LaVwTJyrwJfGyRu4Pzsez6KYzaS/1HQEvF2B17b60/Dv/kWj+IRpFYwaFfRxA=@vger.kernel.org, AJvYcCWnRaEn6zZcruNeA21yjYkITs3LZtJV/6ihlwFdcC8n9nC5SAmdKciyRTUYdnNwDpb6BeLK6WyCVupE6nI6@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw4fr7bEjK3SNp2kte1HcTI2agSzNMzt4a/D94hMQnLC6mvD5a
	L4TN1+i1IhCNF8JtJK0fjAShrHxaJ0VifmDVowApoOVDLU33JVRrwJRq
X-Gm-Gg: ASbGncstGUYy2r6+i1//7LoHaVFuxu7qsL+OPQW/Z5Svd41vWIukjSEgpBzC0AImpED
	VZUZP1gK6BP1gJ27ppXzcQiyuxlQ6UkMuQY58NbQrcGWaeGA4ZgU5Bnm96X8tHee+/PEV+5w91Y
	7lt8U9nF3hPfyQ/lVYSC2NT0iqqNM/kDPmpDX15yBlHj+3ad08MB8U1gLvJj7BQJbGRp6ntczs1
	c+RjHxBnTi4C1O34IIlLG8W2skWq1T2hxVD5vKx1iMRZBM0kw6WNo8xuT5qoomtMgrSuCMJndLW
	LyO76Q7yqY1wS4FyQ/ZYx1GgXZbySw0XkHxFiogw7qMTxDlKEY+oekknlk0eFQCdt+2Z4kYzzHb
	VkNhDxp/x1VksmJ0M5zM=
X-Google-Smtp-Source: AGHT+IE6BW4SDa30IuP4QhZLFrJkcl9wTyzJR0mdkv6O4rHte+RpwPOH5khsoAqI/rBgCbRpwrMO0w==
X-Received: by 2002:a05:6214:5010:b0:707:5319:d3cd with SMTP id 6a1803df08f44-70767456d88mr92125636d6.26.1753964917125;
        Thu, 31 Jul 2025 05:28:37 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:7::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cea87b7sm6577436d6.87.2025.07.31.05.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:28:36 -0700 (PDT)
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
Subject: [PATCH v2 5/5] selftests: prctl: introduce tests for disabling THPs except for madvise
Date: Thu, 31 Jul 2025 13:27:22 +0100
Message-ID: <20250731122825.2102184-6-usamaarif642@gmail.com>
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
inherit before it starts (and reset to original at teardown)

This tests if the process can:
- successfully set and get the policy to disable THPs expect for madvise.
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

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 .../testing/selftests/mm/prctl_thp_disable.c  | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
index 2f54e5e52274..3c34ac7e11f1 100644
--- a/tools/testing/selftests/mm/prctl_thp_disable.c
+++ b/tools/testing/selftests/mm/prctl_thp_disable.c
@@ -16,6 +16,10 @@
 #include "thp_settings.h"
 #include "vm_util.h"
 
+#ifndef PR_THP_DISABLE_EXCEPT_ADVISED
+#define PR_THP_DISABLE_EXCEPT_ADVISED (1 << 1)
+#endif
+
 static int sz2ord(size_t size, size_t pagesize)
 {
 	return __builtin_ctzll(size / pagesize);
@@ -238,4 +242,117 @@ TEST_F(prctl_thp_disable_completely, fork)
 	ASSERT_EQ(ret, 0);
 }
 
+FIXTURE(prctl_thp_disable_except_madvise)
+{
+	struct thp_settings settings;
+	struct test_results results;
+	size_t pmdsize;
+};
+
+FIXTURE_VARIANT(prctl_thp_disable_except_madvise)
+{
+	enum thp_policy thp_global_policy;
+};
+
+FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, never)
+{
+	.thp_global_policy = THP_POLICY_NEVER,
+};
+
+FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, madvise)
+{
+	.thp_global_policy = THP_POLICY_MADVISE,
+};
+
+FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, always)
+{
+	.thp_global_policy = THP_POLICY_ALWAYS,
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
+	thp_save_settings();
+	thp_read_settings(&self->settings);
+	switch (variant->thp_global_policy) {
+	case THP_POLICY_NEVER:
+		self->settings.thp_enabled = THP_NEVER;
+		self->results = (struct test_results) {
+			.prctl_get_thp_disable = 3,
+			.prctl_applied_collapse_none = 0,
+			.prctl_applied_collapse_madv_huge = 0,
+			.prctl_applied_collapse_madv_collapse = 1,
+			.prctl_removed_collapse_none = 0,
+			.prctl_removed_collapse_madv_huge = 0,
+			.prctl_removed_collapse_madv_collapse = 1,
+		};
+		break;
+	case THP_POLICY_MADVISE:
+		self->settings.thp_enabled = THP_MADVISE;
+		self->results = (struct test_results) {
+			.prctl_get_thp_disable = 3,
+			.prctl_applied_collapse_none = 0,
+			.prctl_applied_collapse_madv_huge = 1,
+			.prctl_applied_collapse_madv_collapse = 1,
+			.prctl_removed_collapse_none = 0,
+			.prctl_removed_collapse_madv_huge = 1,
+			.prctl_removed_collapse_madv_collapse = 1,
+		};
+		break;
+	case THP_POLICY_ALWAYS:
+		self->settings.thp_enabled = THP_ALWAYS;
+		self->results = (struct test_results) {
+			.prctl_get_thp_disable = 3,
+			.prctl_applied_collapse_none = 0,
+			.prctl_applied_collapse_madv_huge = 1,
+			.prctl_applied_collapse_madv_collapse = 1,
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
+FIXTURE_TEARDOWN(prctl_thp_disable_except_madvise)
+{
+	thp_restore_settings();
+}
+
+TEST_F(prctl_thp_disable_except_madvise, nofork)
+{
+	ASSERT_EQ(prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL), 0);
+	prctl_thp_disable_test(_metadata, self->pmdsize, &self->results);
+}
+
+TEST_F(prctl_thp_disable_except_madvise, fork)
+{
+	int ret = 0;
+	pid_t pid;
+
+	ASSERT_EQ(prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL), 0);
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
 TEST_HARNESS_MAIN
-- 
2.47.3


