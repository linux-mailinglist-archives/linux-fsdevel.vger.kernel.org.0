Return-Path: <linux-fsdevel+bounces-44515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F69A69FEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 07:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87593B9AD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 06:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A921EEA5E;
	Thu, 20 Mar 2025 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZJE6ZuI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB31EF394
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742452793; cv=none; b=tJUM9AeAI0b49UbYPvfe/PhHYHRy17vBn2LaG+i+AgNMVRuU+tMRvLlP7LPMT+Jmm9apMvZA+dA+CXxGgX5QHb02mWHXHkFfbhSr5FaMtdTtLJFFORSVQmfEzOcnTT6v92q6/g3j9v0Cm5TWGd11IxDxLJwxqYMv0gnbZrN6rx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742452793; c=relaxed/simple;
	bh=0nPyEUxMVYuWQBfOoZDrSnqSSdM+17gpqIPK/gAVNHM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LxScOkXVp9VEhP9ejSDvMxDVoZ4+gg9BCm/odctqO/47qYAfm9rnz5iAEDvJosVMfxpVu5OeCLaMmHBs0Pm/p/xXSH1or8OJYbUSprg+4DaawHtc7akDUv/qeim74uf0zPl9ruBGWplkyn1c4VsBzQkmAMTV1INKbtmgI/2ahlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZJE6ZuI; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-85db3356bafso109835939f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 23:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742452791; x=1743057591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AdzZEb8zIh2bnUEQF7HSdB5UkIAPD4MWW1lq1fR+Ug0=;
        b=QZJE6ZuIim85ftM+Ou5jkI9eOONUT/ijJQKEyGjBnO9KmUKmNVO+WshRmfitp+3bCY
         P+lbtgHJE2uoNokucBO7fd8U0ev4sfntXnUVCFWSZdx68nytBVr0prR/6IH2JFPAjL+t
         HlSQaQLTl8FuDfLex9yEkJ649BsUT18vXBhrKNDmWD40tMbJtVTilkvZkNQtv/zeSTR0
         VKUVVYko1ov6QG9VwqSKhsp3+aLlbJCkmM8m0VfeOG5+1Wm36vyyDsRtLmt23X1sM51W
         s4F0ppdr2XodtTI51PsO9gAlK8Wx2QSsz1jWQBpRkQkQh2BCy5GlwWXh2vb4tSzmEwSk
         6w9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742452791; x=1743057591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdzZEb8zIh2bnUEQF7HSdB5UkIAPD4MWW1lq1fR+Ug0=;
        b=LTalPovNjTyMNKSIUVh0fHyKNCqmpc7vqeyb/DDp6sPzHSe9yVgThYrhAxJhss5oKd
         6FP4Wpeb4tK9AsPylRLEgL4UU/gx2whJcBTYpv+oqqOZXmXCJn/vFP5Rt8jQdO/72ixd
         1UsPi3nd++J0d4zerwzkJoNRJEuGGFvKHmSKp9xXMft23Qy71wX5qotavKxR4rYa53RQ
         tW7JxcZywWBEtvH202vei94YfX+Z1BMAzgG2pHcxCZGoQG+k1+w0mMxjyvy11u4F6FTL
         vm/XKQISq2Lap10fXn/Ac7hZYqDwJZZdGEodpNuJBF3KhjMOknC6PeLl7k2ksHwmBYIY
         +UBg==
X-Forwarded-Encrypted: i=1; AJvYcCWE6VGorbv02AeTPOrI8BQmDBxLTzrUm4nru7FeYWmHRWFg0E7FHVFNyna9nNvhoJry8XLeQK0/Q9RGX3cy@vger.kernel.org
X-Gm-Message-State: AOJu0YwmT/TarmS6xKaiKnKDDxK+o/R3ZsEtBCUVewfPJVz4ALGYmqmU
	dDHQLNIVvguWZyjGsuz8DToKqxs/jMVjqOae7hvL6Td3NNd9vqGeFXC0/nQufQDp7elNMLxM7Ck
	Fiw==
X-Google-Smtp-Source: AGHT+IH9m1sXlXKSr5bFdga9g4GN9qYyPPkoNzV3YUg0gItepaGaNcNSkWbPl4Pwf3Aa3OGUQddoqzehlLk=
X-Received: from iobbk13.prod.google.com ([2002:a05:6602:400d:b0:85d:ac99:6c85])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:4744:b0:85d:9a7a:8169
 with SMTP id ca18e2360f4ac-85e13647c3dmr667556939f.0.1742452790845; Wed, 19
 Mar 2025 23:39:50 -0700 (PDT)
Date: Thu, 20 Mar 2025 06:39:03 +0000
In-Reply-To: <20250320063903.2685882-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320063903.2685882-1-avagin@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320063903.2685882-3-avagin@google.com>
Subject: [PATCH 2/2] selftests/mm: add PAGEMAP_SCAN guard region test
From: Andrei Vagin <avagin@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Andrei Vagin <avagin@gmail.com>

Add a selftest to verify the PAGEMAP_SCAN ioctl correctly reports guard
regions using the newly introduced PAGE_IS_GUARD flag.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/mm/guard-regions.c | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index 0c7183e8b661..24e09092fda5 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -8,6 +8,7 @@
 #include <fcntl.h>
 #include <linux/limits.h>
 #include <linux/userfaultfd.h>
+#include <linux/fs.h>
 #include <setjmp.h>
 #include <signal.h>
 #include <stdbool.h>
@@ -2079,4 +2080,56 @@ TEST_F(guard_regions, pagemap)
 	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
 }
 
+/*
+ * Assert that PAGEMAP_SCAN correctly reports guard region ranges.
+ */
+TEST_F(guard_regions, pagemap_scan)
+{
+	const unsigned long page_size = self->page_size;
+	struct page_region pm_regs[10];
+	struct pm_scan_arg pm_scan_args = {
+		.size = sizeof(struct pm_scan_arg),
+		.category_anyof_mask = PAGE_IS_GUARD,
+		.return_mask = PAGE_IS_GUARD,
+		.vec = (long)&pm_regs,
+		.vec_len = ARRAY_SIZE(pm_regs),
+	};
+	int proc_fd, i;
+	char *ptr;
+
+	proc_fd = open("/proc/self/pagemap", O_RDONLY);
+	ASSERT_NE(proc_fd, -1);
+
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	pm_scan_args.start = (long)ptr;
+	pm_scan_args.end = (long)ptr + 10 * page_size;
+	ASSERT_EQ(ioctl(proc_fd, PAGEMAP_SCAN, &pm_scan_args), 0);
+	ASSERT_EQ(pm_scan_args.walk_end, (long)ptr + 10 * page_size);
+
+	/* Install a guard region in every other page. */
+	for (i = 0; i < 10; i += 2) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_EQ(syscall(__NR_madvise, ptr_p, page_size, MADV_GUARD_INSTALL), 0);
+	}
+
+	ASSERT_EQ(ioctl(proc_fd, PAGEMAP_SCAN, &pm_scan_args), 5);
+	ASSERT_EQ(pm_scan_args.walk_end, (long)ptr + 10 * page_size);
+
+	/* Re-read from pagemap, and assert guard regions are detected. */
+	for (i = 0; i < 5; i++) {
+		long ptr_p = (long)&ptr[2 * i * page_size];
+
+		ASSERT_EQ(pm_regs[i].start, ptr_p);
+		ASSERT_EQ(pm_regs[i].end, ptr_p + page_size);
+		ASSERT_EQ(pm_regs[i].categories, PAGE_IS_GUARD);
+	}
+
+	ASSERT_EQ(close(proc_fd), 0);
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.49.0.rc1.451.g8f38331e32-goog


