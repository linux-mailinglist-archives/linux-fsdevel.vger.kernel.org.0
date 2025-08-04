Return-Path: <linux-fsdevel+bounces-56661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9F6B1A64F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 17:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44C3A7A35BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 15:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881FD2737E6;
	Mon,  4 Aug 2025 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlH2w6zi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6C4272818;
	Mon,  4 Aug 2025 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322227; cv=none; b=DgsWfoCbetOZI624/wgl6q7BD4Mds92ps8RT9n+fqTsxEvp3cJJnT5ibRMkcAPOSddkcxFiVa8mxT6piyWtYou+0VXR5tMsXPmOkmEaD394o3ck6h+tFMjrAqdDM398iPV9z2CJgfkmfgyO1c/EpkHTTvRRetk0NPDFELalPTtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322227; c=relaxed/simple;
	bh=W/RN0pdaGq4mUFpyV0SdEM87yeK/4AdSOPwrEzTi49g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGvQgCnlZaHJOgUESHvPQIP83Eys8U2HNsOLxMSRNBX2GNusgQeIiR0TyCDoVl9BfJPwepklu/isBEORYVqjdv+WzpDqTxG0MoJYlh7bVLQkBPeodD53LqUrily9FQTOCdQ7osiBok9Sm+O84mHBM6pdPqkDQUtRrbVAR4HPEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlH2w6zi; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e62a1cbf82so201428185a.2;
        Mon, 04 Aug 2025 08:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754322225; x=1754927025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlmQ4lQBL2kHeox9ZT3orgIvobThtulJfDV9upDXFUM=;
        b=TlH2w6ziduk8zwFGGS3AOXo8C30g3HXTbHjpIZsxK3iTff2AFKLoiSS7+4txA2sU5s
         ZTP9J+OiErWnAfXd7+8hGue98Sof3n3hMYSdxKy6Xu/fQKeJ4VJ5Oo2DoB1KG5VGWKxx
         pagWLKOf52xvNvXOD1hTpEm6gdLzemRayD242nFlQmdhNdKVEr0oTcUvnyrMEond5Wbk
         uv0sBl8RhJyJE7oQqc6Dwk6iTwO0nTIAlB3HzH5Mo+6ytzy5Ti4dfKWxLg9Gnu0XdSpO
         BBEl5utz58wx39WkQlasWPIKRyB03Q8Vp9MmS+XYiGBMaLIcrUczuMFjc+6DFMWj9RP8
         p9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322225; x=1754927025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlmQ4lQBL2kHeox9ZT3orgIvobThtulJfDV9upDXFUM=;
        b=S67hpzlge7ZmfBJEJW9FqFXDl7cSvHxhMqnbOfw+MKFHoHmzZyNTLjv8R/FeHmnDRd
         13oQIEd0pHVhfnkQonEtoSmHruLJ0VWhy0t2i/XHwzxsZj1oEXS+HW71SWskzfXAA4KD
         JvV1JoT9PC1BK4NoaUqiwOa/cG8sMeeSIAqoBVNbqdgjI2yNGpfp8m0PA2u47KAUbc64
         HQTXfMgLiGrFN3MT1jyG1BMFHC1C/VNPCi71HO6dif+AVnb64nFbYKCae5344hd6AyAJ
         3IOUT8JtGIJVBWtZ8xP3oeEtDu0AyOA4Fy7xGS63W86NXKGcbC6dHEsopHgQRfJ81d8d
         ZFbg==
X-Forwarded-Encrypted: i=1; AJvYcCUrpNqKwU08uR9vSE23NnRhOwKZTbnG+mrH0RoVJxE1Ht+fgchidigjrVaFVTUnOtx8NfMF6LGjlgchLh74@vger.kernel.org, AJvYcCVn3m5zJryvNSk4ZP4KG1cEP18cmwJfKuJvVTcH++3YkuNVUJRpc89zNQHGMy1/HtrymbrdhXga2gU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAiuArmSzpzSILWTp/k+TNXfsC4qZoqEfQfVP8htQk3wcSTrqO
	nA6YEoVYJbPdZsGehrKksFeZrxmS3w/IDpUQ3rwb54oDSHcIaDwojhda
X-Gm-Gg: ASbGnctiLEMOvTWjH9JeX7dQ6RlITGkd+EablwxZTB9lz2Px+1WpRRSVr3S47VoZAxa
	DpA9qJcqiIMKSq86OzlMwuWAmSLssnPpkF0tpN1gcAx4r1FQqe+Gzjt0chw/sBpedT0372W5Zd3
	GTYeEwtr68vI98tNNk6f0rRtvp5WVnXyRKfAk/aL9inHWw/w7SdwvbhWrOGh00XegL6L8Ddb5d3
	S98AcJAHoi41fuQgoB8mTWgJB5ZSbr94x+9bqBF466mRJ2Xvc+tYXgAmDccjsYckV+pMFdd9nWs
	a8Y1gAIhOSJ2x+cD/Ka6RSt55JNq0kOhje9tMJkWLFt3W+VqYLhAbm0WwkudccMwU4q6x7PDFmD
	0Ze1WGNmpqwNOoq/izwY=
X-Google-Smtp-Source: AGHT+IGJQDqEPSNpcfXCQ0ziPzID1H18Arno2+qWA4NTYcPCKy8chybDSbutvMVp+JOvqicFgo31Nw==
X-Received: by 2002:a05:620a:458c:b0:7e7:faaa:e7c9 with SMTP id af79cd13be357-7e7faaae8eamr591769285a.12.1754322224787;
        Mon, 04 Aug 2025 08:43:44 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:5::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e695e69ed5sm335521985a.46.2025.08.04.08.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:43:43 -0700 (PDT)
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
Subject: [PATCH v3 6/6] selftests: prctl: introduce tests for disabling THPs except for madvise
Date: Mon,  4 Aug 2025 16:40:49 +0100
Message-ID: <20250804154317.1648084-7-usamaarif642@gmail.com>
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
 .../testing/selftests/mm/prctl_thp_disable.c  | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
index ef150180daf4..93cedaa59854 100644
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
@@ -170,4 +174,107 @@ TEST_F(prctl_thp_disable_completely, fork)
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
+	ASSERT_EQ(prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL), 0);
+	prctl_thp_disable_except_madvise_test(_metadata, self->pmdsize, variant->thp_policy);
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


