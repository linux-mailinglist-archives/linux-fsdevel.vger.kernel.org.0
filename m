Return-Path: <linux-fsdevel+bounces-58017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF70FB2810E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 15:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D43621A65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 13:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ABF306D4A;
	Fri, 15 Aug 2025 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9co7TLv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9795730499E;
	Fri, 15 Aug 2025 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266165; cv=none; b=GBzIBvmVZrm1vmSGOqaMA0BkmeW2Klrt7lxa03Kvm9GjFYYSH8N+GyFe0BtMIwmqunEkdJuvzwy5CDKlc91SP781qrU7czLWpJCCg+QL9+YNZLcM1a5H0B/ssNfNUz0pONI3YawTpwuovq9JmDZ12tJ1AGGdThxkX5mtwruNO4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266165; c=relaxed/simple;
	bh=QO39INygjINebWP8oHh/0VwVoIxsdAq/h6+u4bYW3Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ke7fQLduDI80Gi7kARkouypPKOjjzX3SiKG91qQxdGR1zZaPkydOTMzjnkMq16WaoSfFKaj30C/1aVN/P6d05jFrxI9ij/MGBDQOu/6nXRlDqUTQq6/p5Spu24nNIfHOfrTbOlZOtt3TZsvKgdbLHPR6O+Iscl630M1YOLjtGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9co7TLv; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70a88daec47so11518586d6.0;
        Fri, 15 Aug 2025 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755266162; x=1755870962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKLbQqBppRJDcJgKqWsD8LPR5qN9TJ+cj2ycCND4QA8=;
        b=i9co7TLvwSqCKkwJ2Xh+rN2BtLC9z5zu6rQFp5JIVGAtj7PcfNY6YSayVbGpEbgipF
         wzqrcV5hqyiN8KCl+w/iwpxYLdRX4wug+AOZ2zi4/ErEXSiPcfx+SkR5zd0Yp14QalHT
         ja+LCpNToKPOFDHoJ/Cy9BJUQINs3A8vCdPoIMuM5FhBTNPzsO6QLFmBMQmLvVp0Z/44
         L7/oR7AlHlnxHBHl5Vs2t1/fhhX5n17hroHyjNIlvqmIY8PELuPdHqpZ9InZseOCFrXD
         DbffaukHQhnvM2KOmXXKRyP4WzoTCUelTWKha8gpMuC69YHTthr8mMMyr4CqqJFUVxNR
         TjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755266162; x=1755870962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKLbQqBppRJDcJgKqWsD8LPR5qN9TJ+cj2ycCND4QA8=;
        b=QaAqBkiodQwhu7lj/Me2aBz62V6216snHHVZ2ai3zBlVksuoK+WxcPmBnMn+Fv1NmM
         S6o4Z/UedU4dFYms8xpMzQ2lQu1iLlkz9fs5M0gON+A9mKP6Lo+mzw7dlU5NuSqybVGd
         4gNKYcx3RJdJAGnZ9XDBR04qIc96ZDKqGXVPOtog84fD4V94vmiw+6NLS9ejggvO5o9x
         BTH/g+1q4Ib/ahMCkYIY1FEa9PQAmMvXXkW+zG4/YYWLo6qe06ypRsDpl7shGniolChV
         X6k6byGBP7vch6JWONPbmCf9FwZsVMxbhPT6eA5aQP5/vYnHeNoPq/AZWtp7jyd/WpaP
         OV5w==
X-Forwarded-Encrypted: i=1; AJvYcCWP/Ctcx8MrCx5p03P/AlqUkt2C2QbSlRdPsuGrqOKWcobLJKZZro1X1nLKtMkdG0fIlFXwINznxliYLHKy@vger.kernel.org, AJvYcCWXolaNwVQznarkZDnJwEBBrwLjF2M5qc2R9q8qaw5lUp5d1AOFm856OmDW2JDebsmm0/gIYZtEIM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuXIHwdi3lamocvFTiOyVo5QWzQTlC5+gusYHbyLSdF9soD+jf
	ixd8pwr7VipyUuX9InuWiYhcdWthT+O1cszAN957eaLdX0YQtSGZksfg
X-Gm-Gg: ASbGncuaFMedzKnYEwQgxTDXwcm9lUAveiWQVtarFZ7Qk/7PNfyZJmXhIa4HJhyJ05S
	rPAYIHUbz+B6UZRuQC0X7aIZ+mTCe17LsRh5uVV/rhu9rJ3QwSEZUKiZaIrJSGzZ0McBnoEemjM
	N7N3XHhpBiRJ63aJMmqQFAXwcDHFFROWrCPhmkJjYuOpa2fCI+6cCW5zBlewyYiZ+hJwP0EBxnb
	7lcF4rHdrIj1vZY5bOIgF/nl2zn61Nkgj/RwZJaltjtsdryEYyugJ1b1ytUna9W/6NYSDRe0aTd
	5gKqKwAitPBkNwrHSNkV8mTqO4c/0VktDsM4oHD2FGKrd6p1x/JB7eg0byiiMG30C4pSlni+EON
	n5NWpYH0TI8R1+Rjo46Y=
X-Google-Smtp-Source: AGHT+IFRUMVXwq9t9zoppX3jUjPgp5npqXSGShrgHAx927648lNHSf66xRhiQlIDhKL6ceNqK3JUkQ==
X-Received: by 2002:a05:6214:c43:b0:707:3cb1:3fac with SMTP id 6a1803df08f44-70ba7af6bfbmr21560886d6.15.1755266162144;
        Fri, 15 Aug 2025 06:56:02 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:3::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba92f8c73sm8074566d6.44.2025.08.15.06.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 06:56:01 -0700 (PDT)
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
Subject: [PATCH v5 5/7] selftest/mm: Extract sz2ord function into vm_util.h
Date: Fri, 15 Aug 2025 14:54:57 +0100
Message-ID: <20250815135549.130506-6-usamaarif642@gmail.com>
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

The function already has 2 uses and will have a 3rd one
in prctl selftests. The pagesize argument is added into
the function, as it's not a global variable anymore.
No functional change intended with this patch.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
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


