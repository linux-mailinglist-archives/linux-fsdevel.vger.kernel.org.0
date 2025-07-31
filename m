Return-Path: <linux-fsdevel+bounces-56397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA98B17110
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63816172654
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635D62D0C97;
	Thu, 31 Jul 2025 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAbfVVr+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C99C2C3254;
	Thu, 31 Jul 2025 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964523; cv=none; b=H9b0z8MXQ27yXEwr4+PNBmSwjpM6Uuius4ouwF/dnfuFD5DP0oVx1NRUzn+TMrWLphpZacC9n/gEqKV7V4IiGxlrPDADde5Nr5NA1/+cGT3aLvQyfb61fQses2P+BxpeM6Xtsjved+PW8iPR1DpaqMXCGHhm3zdN/TGvq7UBuZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964523; c=relaxed/simple;
	bh=Xo2axdleKQKFm0NOSldkhQ8qF+6YtByFGwnagPvP6uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0IOAdUUD7eUDjnooW2wGHNNAtTO6nkTIUvf8TtbgFpmlN4tgtzLRLnvMJgumLmVvkhMKkt5fvgGClDTDIe0J36sMUa0lKJAoAw/bvvuSnyPn22aJqiDkg/dFbmilI42Rcq+p8l0tGIz8NIQPk7bpL5O5Mv9FzAYEUMz5epMWcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAbfVVr+; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-707389a2fe3so8190406d6.2;
        Thu, 31 Jul 2025 05:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753964521; x=1754569321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayWZPS7L38ZOhjcOnH9WSUS7UcJth2Mxw9Vr7h3Jt6g=;
        b=kAbfVVr+1pWH4wHZy8PgxPxrSfOgN+XdCRcPqz4v2eAK4YjH3ZU7LSmmtEnfovvrN0
         egamOQpuYvuiGOWW9AG+UlxY51CzCclGU0DFl+DVpxYgsHG/tXUfehsWIHKqOuPAaabM
         x2Y+e1VFYneRN1I/nyqrUOp4LFK8smIFqqPj+YBTy6uJMPxwjJPnV1lLQXup/53PUbTw
         uVgMXzrfyJ40XXGCOe9h7dZWUhJcSaxDsqhtEhrMLbJuxTXtcbFBUxucodrt48NKgnPX
         cjzAS6CzAjNr8UMbkkRCLUTB6Dpe92AZYeKRRc8uzxXFV1eF2/sLXkg82wyKwA6oV7V7
         urUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964521; x=1754569321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayWZPS7L38ZOhjcOnH9WSUS7UcJth2Mxw9Vr7h3Jt6g=;
        b=cpYDJbTUQ27acXcMRDTGo3Yg+o2liu3MJlm/UNOBKc6sW4RVjO0mug+7x/zikeTvn5
         ElN/kpBX2UKDuhiQzWGTs1H2EUYzioTOOEEBXD+idcGnajkHp9sj5IpiKMxTRdPoSNOV
         thExol7xSLvxjv9tEN2xP2owTqV5S8W32FGeDY+DjDDEWw05cCCHv3Fvfx+eKM71+bOf
         ++lpD3MuDtAU1Bh6REI9GALlpWV5mVAkx3jZ9+G2qcBCm1uF5LN8/cSCh4/poRXxCre6
         50jQYQs6r9iXdRHTLS4h7cqOlUGFnY7B6d7coJ/ybWuSMKE/DuQ3ZjF3V033c77qBw4K
         f1mw==
X-Forwarded-Encrypted: i=1; AJvYcCW37q036s1VBL4LhPIzPGULeh8A4RueYMxKIPMCiymy7r9Tj3qJLYwvZG8Vo7eUnNG112Ll2p6uSdY=@vger.kernel.org, AJvYcCXRwbS5BjN2TeLbSrBQgzBDq80qxAhpiqjIZk/lZ6MnIo2i544cr82qPSY2/TjO2gH1oME5+IMIJc3zG9d2@vger.kernel.org
X-Gm-Message-State: AOJu0YwRH7wczk6YvID8BE6atY7hPVnnnw1vSRfFRUYViuLetmLpKyeY
	7ub6LqQ0myVOGZg8x8KeIKiYtYdj+6eedeW1xUj8D9NTorALLk+YfxgB
X-Gm-Gg: ASbGncvBqumVabQ4f0gMZWFZ6zP2jU/VLpA9PrIlab08T1Ed8Fu4V6cBn3I4hXunszC
	aB61W8zI6hkjmtT8EI29lEdx1EtQ1IlJP9QgO1fpvGWwTZDx8DrBwKYem1HDV+FvRm/3G8dbk9Z
	PqJYIzFmlJ66mD+NBuBFDxoY8M0PWuLkUJn5BAxyGt5+gq2hYJ3oB3ve9BA0D0LJVffpWC3Dsk8
	ovMD0bMY9OjXshVZ4km9s7YjQWgtyNTHIQcZvnZa8f1qd7LKVeUbAQEoHcaddvnI3v9gAEtFerN
	LMQyaPrIdHW354wesJVqV1RxRyh0iGVRBckAzaFNv9mb7dlGQduEUmZl1SMf0GdCtJ3d7CNwzZS
	yJ5C/Spdhae6Ihgv5fZuMkI+6WQzM8g==
X-Google-Smtp-Source: AGHT+IEG8qEX092BNX445pCTiZvfAk/8cPS6Yyb/65Po+og4Y3N0gHtq/q6lu9fesOTaaOoDzml9lA==
X-Received: by 2002:ad4:5aaf:0:b0:707:5ff2:aea5 with SMTP id 6a1803df08f44-7076726bf32mr94934336d6.47.1753964520748;
        Thu, 31 Jul 2025 05:22:00 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:8::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cddc290sm6477556d6.63.2025.07.31.05.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:21:59 -0700 (PDT)
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
Subject: [PATCH 5/5] selftests: prctl: introduce tests for disabling THPs except for madvise
Date: Thu, 31 Jul 2025 13:18:16 +0100
Message-ID: <20250731122150.2039342-6-usamaarif642@gmail.com>
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


