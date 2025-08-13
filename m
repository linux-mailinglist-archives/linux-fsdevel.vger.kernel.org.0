Return-Path: <linux-fsdevel+bounces-57719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA28B24B89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C812F1C20F13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852082F90C9;
	Wed, 13 Aug 2025 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPPPnVI9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5701B2F5338;
	Wed, 13 Aug 2025 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093456; cv=none; b=kwL2IEROdNVrsuwaeG32aiDIYDSiCdtmxZ7s25EZnncYxeC/TI6H4MwgsRuPhXNsaVFB6nSEfhv5EOWIYGyNG94H+JST1wou3DzxVnBMttbHBDDbR+Jys6mSRlvI5nk9jR8tlLLFSsxNbhi5d5PlKVdTsuz+LMjvXKwgGfH1AYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093456; c=relaxed/simple;
	bh=chnfJUlMDNPBEn5ziIy7iVMv3BNRrnho2G4kJbbZ6iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSpWloMfimhCPbeglMXRZje/Yrnii5FDccOFQTpDL84R5JmFKDcHZXGsA94eY0kDJLvwFMGkSxP22MOaf5zN/FCa8g9bmHLhVlDNEgYQL4e84OF+cvGnOpn5Y1rk6Pz1GzUl11fcvCQF8JRaOoGFYHlyhNZHaxASjQrb5r6K/PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPPPnVI9; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70884da4b55so68059326d6.3;
        Wed, 13 Aug 2025 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755093454; x=1755698254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1kmHl9ou54J+I7Bwx5/90tmVmkUsMDP6I8Z0yPOlyc=;
        b=TPPPnVI9gTuRKs7GViJ5lRA/KeYwUJjvUhRDWKXWxiD+s9F+gjORuSY76zdTG7BwdN
         l+aCtvkdYfEAgo9dWJQQt1AGPyE+bqJNOk+vVlP165tb1tirjvTvhUxzxbX0u8H8swb3
         2gV7dKlg6I2VJZAeRMkS1XG1oCia7tL5aIQ3LO/Nqp+2swEcIwNYZxkZ2JDJSiTJ1o7W
         wbqoWhiDfJCTGXdisVsTqOXEq3FzuHLBYAjYYsdymvSD4Hw01IOB4RW+qk2qDdYFa9jB
         WmoUd+fh4znafbWTt+XziHCQKb8LnQ+NT0Monkh3ivic4GYYpKa2zkgA/zI3zvBhuRhf
         PoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093454; x=1755698254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1kmHl9ou54J+I7Bwx5/90tmVmkUsMDP6I8Z0yPOlyc=;
        b=wTOcjnpTnFzyKdRY/TwY2y2lacRi/bF8LgSXceb1cZPhj+tZUIoqHG/Ota8DLBjUjZ
         an4gX+JZ4Bhc0fOhOW4AyO76oSoztSa+x/J5LzO3xZvlW0dRXzH9u866ImQWeeNMojZU
         BGw07OUl9uZQ/T1hbkOj1ihQ501KGepwZHCd8fHLcwaAz9JaFsj7Fj+PU1hOZXgtCCLe
         +3w6ozE9D9NSCl/RUsxF2WZfbwgvpWIsrYNBR9pKeE/nTJVBIEWzSZEcH4nBXlO0L2Z5
         a6I8L+jZKMxglQeHRjmmQxQPd32YxGUugpnNmS0t74cD3ASEl5CM6QIfSgsffx/uHerl
         pZoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV11h3s4GtvIYE/rVRFhHIxWAUeX+LZIz+6FsnKwnCj7FtXLdJwsRu3C+MzFDDuQGcH0hpRfYqM7W1ntC/M@vger.kernel.org, AJvYcCX6q1afTfOKhR/QEdUf7Q62O/R76IyuRD8vrkjyIU5u6sWRC7TpttbRrrtgnWeMe71yVcUmS9pu/q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJgWalWR+K5L5ddwiR+xwLPlLVA5LRScwghlmX1D75pfD3Ndrr
	jIziCXvIEwh4xOhf8jLTsEZthTjYoJEHneLrVLSvt7QbrmZfps8r4GV8
X-Gm-Gg: ASbGncvxJka7EuYhSwQyTJIyrbnpEU0K6r1GcGUi7t5hLzshGaywHmOute5AqvsypQI
	1umrFQ3pZLZqCboG5HWUD0fP8/9CHTyjXDJq4dCUPYKMI+RhBwX2cpmdUFsj581HZwlR8jfWAXn
	4rRZOeXi7iCbV36Q7Q6IjYDSVBFM2gtklKN1yH9rTUOvtm0LOo3FPJPL8ZbHNpZV2fxpQbZdSHL
	AnO98soXbnbL1xFkR/033jyAQSGlN8LaKA3oRCAXMD2bUmd6i9Wvly8wD1ZoaQx7Xd8L39R/s1W
	B11zd+GJc4t92M9O9fVXpssVvYmnAMNNM3LfjVN8E4o1ZHnY427f9YJ1RW/8XkDmsq8/XKkZumX
	4Nyjy8g+NWH2fr9v2WJznQUbx3KEM0w==
X-Google-Smtp-Source: AGHT+IETKIO2cxrT1cZ3eXzUyHUKDprszoyaGoaKc1HytP/YMuHzMaLVDM6g+PqCuavNsU3xtLqWMg==
X-Received: by 2002:a05:6214:5006:b0:707:bba:40d4 with SMTP id 6a1803df08f44-709e88349e5mr37039936d6.11.1755093454166;
        Wed, 13 Aug 2025 06:57:34 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:4::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cd56e1csm196270946d6.45.2025.08.13.06.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:57:33 -0700 (PDT)
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
Subject: [PATCH v4 5/7] selftest/mm: Extract sz2ord function into vm_util.h
Date: Wed, 13 Aug 2025 14:55:40 +0100
Message-ID: <20250813135642.1986480-6-usamaarif642@gmail.com>
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

The function already has 2 uses and will have a 3rd one
in prctl selftests. The pagesize argument is added into
the function, as it's not a global variable anymore.
No functional change intended with this patch.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 tools/testing/selftests/mm/cow.c            | 12 ++++--------
 tools/testing/selftests/mm/uffd-wp-mremap.c |  9 ++-------
 tools/testing/selftests/mm/vm_util.h        |  5 +++++
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 90ee5779662f3..a568fe629b094 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -41,10 +41,6 @@ static size_t hugetlbsizes[10];
 static int gup_fd;
 static bool has_huge_zeropage;
 
-static int sz2ord(size_t size)
-{
-	return __builtin_ctzll(size / pagesize);
-}
 
 static int detect_thp_sizes(size_t sizes[], int max)
 {
@@ -57,7 +53,7 @@ static int detect_thp_sizes(size_t sizes[], int max)
 	if (!pmdsize)
 		return 0;
 
-	orders = 1UL << sz2ord(pmdsize);
+	orders = 1UL << sz2ord(pmdsize, pagesize);
 	orders |= thp_supported_orders();
 
 	for (i = 0; orders && count < max; i++) {
@@ -1216,8 +1212,8 @@ static void run_anon_test_case(struct test_case const *test_case)
 		size_t size = thpsizes[i];
 		struct thp_settings settings = *thp_current_settings();
 
-		settings.hugepages[sz2ord(pmdsize)].enabled = THP_NEVER;
-		settings.hugepages[sz2ord(size)].enabled = THP_ALWAYS;
+		settings.hugepages[sz2ord(pmdsize, pagesize)].enabled = THP_NEVER;
+		settings.hugepages[sz2ord(size, pagesize)].enabled = THP_ALWAYS;
 		thp_push_settings(&settings);
 
 		if (size == pmdsize) {
@@ -1868,7 +1864,7 @@ int main(void)
 	if (pmdsize) {
 		/* Only if THP is supported. */
 		thp_read_settings(&default_settings);
-		default_settings.hugepages[sz2ord(pmdsize)].enabled = THP_INHERIT;
+		default_settings.hugepages[sz2ord(pmdsize, pagesize)].enabled = THP_INHERIT;
 		thp_save_settings();
 		thp_push_settings(&default_settings);
 
diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
index 13ceb56289701..b2b6116e65808 100644
--- a/tools/testing/selftests/mm/uffd-wp-mremap.c
+++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
@@ -19,11 +19,6 @@ static size_t thpsizes[20];
 static int nr_hugetlbsizes;
 static size_t hugetlbsizes[10];
 
-static int sz2ord(size_t size)
-{
-	return __builtin_ctzll(size / pagesize);
-}
-
 static int detect_thp_sizes(size_t sizes[], int max)
 {
 	int count = 0;
@@ -87,9 +82,9 @@ static void *alloc_one_folio(size_t size, bool private, bool hugetlb)
 		struct thp_settings settings = *thp_current_settings();
 
 		if (private)
-			settings.hugepages[sz2ord(size)].enabled = THP_ALWAYS;
+			settings.hugepages[sz2ord(size, pagesize)].enabled = THP_ALWAYS;
 		else
-			settings.shmem_hugepages[sz2ord(size)].enabled = SHMEM_ALWAYS;
+			settings.shmem_hugepages[sz2ord(size, pagesize)].enabled = SHMEM_ALWAYS;
 
 		thp_push_settings(&settings);
 
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 148b792cff0fc..e5cb72bf3a2ab 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -135,6 +135,11 @@ static inline void log_test_result(int result)
 	ksft_test_result_report(result, "%s\n", test_name);
 }
 
+static inline int sz2ord(size_t size, size_t pagesize)
+{
+	return __builtin_ctzll(size / pagesize);
+}
+
 void *sys_mremap(void *old_address, unsigned long old_size,
 		 unsigned long new_size, int flags, void *new_address);
 
-- 
2.47.3


