Return-Path: <linux-fsdevel+bounces-58015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA69B28109
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 15:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72ED6068CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4048F304995;
	Fri, 15 Aug 2025 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTyFuRX/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAB304968;
	Fri, 15 Aug 2025 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266162; cv=none; b=TFD8mfZ7S3+PwTmo9Z8bMiLgTcYbXuLmY57jQKZcv8e5nM4NCBzlCwTKEqO4bLjCZ74drGYg0xU4w5ieAtIxzMRvwDY1oIKr7KIjg2zf4qAHvLybrMLp07lm1w0CKLXJnbhlSkMCxUkNDVl9Vri2+uhADqbESPg1b33IQAUYILA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266162; c=relaxed/simple;
	bh=f7Q1hmAYhKiSLYKCGrqxDUw/31jE44vHvKD+blKxRWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iu4PfaF+WacbWlg1CkJlNWUVCIGEQmqQ/ZD5IqVhIpiDnmNrGI1cuEKIbLDLUttwCCF5PDwkR5v7TYVouRY+9n0p6D1+CRCKqWIDx7UvFGA2L90LQIxXnuA7X4vSmb7iyIsTE6mtxBKxiyTBhmi8V2AXrKlD/vhKqTpV0FsIr04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTyFuRX/; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e87031ce70so120583585a.0;
        Fri, 15 Aug 2025 06:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755266160; x=1755870960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjAM2kVPg7HSAJDIq3Fm+b8P0QFUYqeRJ1MrMImZHTY=;
        b=MTyFuRX/zpZtR8CN+63Syl41R+HI0TlKTOmUp2XmjV3EqnZ+NJLtmPpcumCK9dXIDF
         sNZlPC3yqLaPQ+zFuXtfEOWOFlYi8knw/nz9C96cACjrW+Ho8ILaVQHmAC2DfjiYn2QT
         hbkmcvBaSEEm4Y4APNDQHrcSAXUFp5Fh0BdYf2PmoWy+JnxXjipqmoVxCzqKJlOKlYG/
         POsBTIEsSPzdX/8+BdlDisiZ2T8DYeu9mjE2OknyGQhZZ2LhcS50tzteiFDkRg4SxCE8
         8tf/ZxiHC+R0et9CDpHxvgnW5to5p/6YvzroM7m11bcaascqXrGOE5ysawfY+D8ZHPY+
         KQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755266160; x=1755870960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjAM2kVPg7HSAJDIq3Fm+b8P0QFUYqeRJ1MrMImZHTY=;
        b=aRhNnGqCOyD7Kt/0DNkNM8FvFfo7rmXBdbBMG2IHim7H/o9T/jXHO/95zqPnYGY03G
         m5tULPC2hCWLpAVtk+3fHIi88fOoTnjgEimz8YJdUGlhfnCAWNtsUBSYnJyBXagzm8Xc
         4413Xjv/TXofQPVLlJaHTzWiHHb23RQV5l9VPnRpYNp5wr6CPieg9DQBCC/wd0wnpTjZ
         bomuRtZlA4dluvK1zJiDXZxjC34DaXM6yzAZkVLHZ6SXMKmg2cKjV0IfmMezIzd+x2Gs
         A8ioGoQeC57JQ6lHmOGlgHSiDSrqgI5M2mfHqJBecEsLn+bjX0KR2znmBGXjqmRgVoC4
         PPDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtaXCawSr1p3VNvDiHDCDuHxWeD78DPbQWrqBbMd+B6sL8W+f9fYqS77Z1gBkTGKOkIsYy79d1ZXXH8TUm@vger.kernel.org, AJvYcCX/ThuXvW5omdixt7UX2JRHtxNxP3pxI+6tLHYAfXSSuG0nvxoDf1sZVgQ0nU/ZsuEriicHoWAplSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrKfnhKFfvBBzLm8/5FNJeTGL4DZhBZcG0cRhsTlPnVugFL43a
	DmuKOEHZXq0W+iwT2oxFLDJSvFEmS5qd2ojhzjLpK5goz6bgW9JEsgze
X-Gm-Gg: ASbGnctJXkksmi1ncbX5IEoA+ePIGg0Br499C/dLOH5yU5QVoFCdvA1bjGJEPxg/cku
	uuO2vqk3R6tRD7OiXDalfeZQF1qWGkIvlzABL7Aw8vM6f5xhDv3L01LiV7ZHi5xo5bMbhdPTr2r
	x7znoXWpcyEth3BeAIHn5kP7EAzG921Zx4G4Z7VM9g4fmIkpN+BP6GeSVqU7/9FvgzLbjlXAdMi
	aLQn+G0GksFisbbTRm1Y1RCu06Miv58Z9opC4vy0H+ooUTGhIh/kY1EuIaJnbwMxTu3q5EmLmJT
	Z1appK0zqZAiWFkdbq8Ofq2mBebSMCuPwaEQeXlf0eP7n8kyylmszocXowNHopbfvhRwfZ+pkUP
	O1eBhl0L8OZH/0Sw3Al9S
X-Google-Smtp-Source: AGHT+IFF9RW9CTYz5caN0M6+lm/SBlFq7E34PjjRXGEeqVn4nYoCKB9rubR5z1M4MA3PdwlDkbJAVw==
X-Received: by 2002:a05:620a:370d:b0:7e6:28d3:c4df with SMTP id af79cd13be357-7e87df87270mr299191685a.14.1755266159571;
        Fri, 15 Aug 2025 06:55:59 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:74::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1ddd9fsm108971485a.71.2025.08.15.06.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 06:55:58 -0700 (PDT)
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
Subject: [PATCH v5 3/7] mm/huge_memory: respect MADV_COLLAPSE with PR_THP_DISABLE_EXCEPT_ADVISED
Date: Fri, 15 Aug 2025 14:54:55 +0100
Message-ID: <20250815135549.130506-4-usamaarif642@gmail.com>
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

From: David Hildenbrand <david@redhat.com>

Let's allow for making MADV_COLLAPSE succeed on areas that neither have
VM_HUGEPAGE nor VM_NOHUGEPAGE when we have THP disabled
unless explicitly advised (PR_THP_DISABLE_EXCEPT_ADVISED).

MADV_COLLAPSE is a clear advice that we want to collapse.

Note that we still respect the VM_NOHUGEPAGE flag, just like
MADV_COLLAPSE always does. So consequently, MADV_COLLAPSE is now only
refused on VM_NOHUGEPAGE with PR_THP_DISABLE_EXCEPT_ADVISED,
including for shmem.

Co-developed-by: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h    | 8 +++++++-
 include/uapi/linux/prctl.h | 2 +-
 mm/huge_memory.c           | 5 +++--
 mm/memory.c                | 6 ++++--
 mm/shmem.c                 | 2 +-
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 92ea0b9771fae..1ac0d06fb3c1d 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -329,7 +329,7 @@ struct thpsize {
  * through madvise or prctl.
  */
 static inline bool vma_thp_disabled(struct vm_area_struct *vma,
-		vm_flags_t vm_flags)
+		vm_flags_t vm_flags, bool forced_collapse)
 {
 	/* Are THPs disabled for this VMA? */
 	if (vm_flags & VM_NOHUGEPAGE)
@@ -343,6 +343,12 @@ static inline bool vma_thp_disabled(struct vm_area_struct *vma,
 	 */
 	if (vm_flags & VM_HUGEPAGE)
 		return false;
+	/*
+	 * Forcing a collapse (e.g., madv_collapse), is a clear advice to
+	 * use THPs.
+	 */
+	if (forced_collapse)
+		return false;
 	return mm_flags_test(MMF_DISABLE_THP_EXCEPT_ADVISED, vma->vm_mm);
 }
 
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 150b6deebfb1e..51c4e8c82b1e9 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -185,7 +185,7 @@ struct prctl_mm_map {
 #define PR_SET_THP_DISABLE	41
 /*
  * Don't disable THPs when explicitly advised (e.g., MADV_HUGEPAGE /
- * VM_HUGEPAGE).
+ * VM_HUGEPAGE, MADV_COLLAPSE).
  */
 # define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)
 #define PR_GET_THP_DISABLE	42
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9c716be949cbf..1eca2d543449c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -104,7 +104,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 {
 	const bool smaps = type == TVA_SMAPS;
 	const bool in_pf = type == TVA_PAGEFAULT;
-	const bool enforce_sysfs = type != TVA_FORCED_COLLAPSE;
+	const bool forced_collapse = type == TVA_FORCED_COLLAPSE;
+	const bool enforce_sysfs = !forced_collapse;
 	unsigned long supported_orders;
 
 	/* Check the intersection of requested and supported orders. */
@@ -122,7 +123,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	if (!vma->vm_mm)		/* vdso */
 		return 0;
 
-	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags))
+	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags, forced_collapse))
 		return 0;
 
 	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
diff --git a/mm/memory.c b/mm/memory.c
index 7b1e8f137fa3f..d9de6c0561794 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5332,9 +5332,11 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 	 * It is too late to allocate a small folio, we already have a large
 	 * folio in the pagecache: especially s390 KVM cannot tolerate any
 	 * PMD mappings, but PTE-mapped THP are fine. So let's simply refuse any
-	 * PMD mappings if THPs are disabled.
+	 * PMD mappings if THPs are disabled. As we already have a THP,
+	 * behave as if we are forcing a collapse.
 	 */
-	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags))
+	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags,
+						     /* forced_collapse=*/ true))
 		return ret;
 
 	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
diff --git a/mm/shmem.c b/mm/shmem.c
index e2c76a30802b6..d945de3a7f0e7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1817,7 +1817,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	vm_flags_t vm_flags = vma ? vma->vm_flags : 0;
 	unsigned int global_orders;
 
-	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags)))
+	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags, shmem_huge_force)))
 		return 0;
 
 	global_orders = shmem_huge_global_enabled(inode, index, write_end,
-- 
2.47.3


