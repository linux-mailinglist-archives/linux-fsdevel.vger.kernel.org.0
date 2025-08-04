Return-Path: <linux-fsdevel+bounces-56658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D9CB1A646
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 17:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4807A7A1C18
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 15:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D841D26B2A5;
	Mon,  4 Aug 2025 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSzYVCsS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD94221544;
	Mon,  4 Aug 2025 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322223; cv=none; b=G0LLK/v4svxSbAKRU/ZaC9Je9cWdI7HDgIbyZf2jrDVOvLAsDDq1jBEFkwN3PfPuNvidqFhZpatQq/sRTLCyQc01wTxDUm2HdfrLTaDRjHec8gIfm9KeAwVmkDxb4aL0zvqBhk1ILrtBfOQ/5hUHvL9bdvy7yAbeJMtq4PrGBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322223; c=relaxed/simple;
	bh=4ByzGLLZrVyaD4dM/PYmq9r2OO1L7E+S1WLjflW3lLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLjiOdKSEsfsrGp4Yf4zvLFup1CtmRW7tGDIO6MzeB2nIC7LQoeOp69OYkhBAsFYd5mugoB96jHTWWss08lQjoH9mrEL2x3zkBYadwgKkmdcU7FDu4Wd9vgsKACd5FJ7hFukBJPQ8ioWfehGfyKBXVYHIQazKfJGNMR2f5VeJMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSzYVCsS; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-707389a2fe3so45228766d6.2;
        Mon, 04 Aug 2025 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754322220; x=1754927020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pff95T0ROqWNaJZZaJoS7Iz2EIBASIhdqYvDClX4pOE=;
        b=mSzYVCsSLLnMGizHLZYy9Q9efolKgle2M3Vpt+V6624iU1a5yLhqZB2QVMVSZkxk5Z
         Ge88WMdxaS6r7p5KszCYtjoWhGPjfYUAIcuxrfT5KCxbLzCW7f6y1OID9Yv0vxeMYksg
         To+yOpS1iJXlMaahI+mY+jXSHA0Gnc40tcliwHPfJZL036lEt49Uft7m0u/Xn61tbksU
         cYBw9d+j1xUhjoF//w3S1pAWmtDr29FmjdR1DcTIwB6tiYGsS4WEqp9NTJUYJDpngvJB
         BUSYPf7RrTKokvg/lTxfT/N/Bc3FmgowbB6ea4msAUJDNRudyLcroUhZMZVdcgKc4xMY
         ekkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322220; x=1754927020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pff95T0ROqWNaJZZaJoS7Iz2EIBASIhdqYvDClX4pOE=;
        b=UEkrxjHqQrIzSY3CT/M7+gRbzdVT87SK2G4H92id5b+Sb9ibSNSGnuVuQUBRb7pyOM
         tervoVwQlvZFttIuxBl8XVuPXW/73yoiDFy/DsJTCUZErjya1t75twL2LSWVH4y7AZ5j
         F8lIkp0pLcQd4c4s3eR+/oZXjfLxfRoRpXQi9gD4+jL8xUSEz6evngHDN70In4kHWxFc
         0i1o4GxkLVu0T5I/WkQHrIl5ALaZxgCY19vFWRDo7VkbY7gtlCjYKZ/R7lDoE46bxcc/
         +T3aWU4+Fx7Mxo20OH/rWHP93npWB7I/dl3Smrcvmw7b2uHebDA8aOuRJLBE9F3DYcjh
         k1zg==
X-Forwarded-Encrypted: i=1; AJvYcCVU+kxlocJWU8u6SozZWUXc67F2DJ85M5z6V3o0TzZtYs/ZTTLIg617k9OUaenj9SHdr87LOt3R7TSOu+eV@vger.kernel.org, AJvYcCX6uqLr6qlgYwoAJGo9ovad/OQBQROelwNjlO1ZybqeR1WMix0haDyUx9VXm4QNSgbLj2qA5DLX+/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrZ0TdUBV1Db2xEdo8LMBOfpJGJNWyE8oaNgUZTDBfne2uLv2/
	AMgsWs4ZPhR/SIpRsgU9wHpliD6pXvcapRPdkiGUhlVXw6IWJhzCdacd
X-Gm-Gg: ASbGnctkNEZUjTTb3mz+w2dnQCEYCza0D2pf3JsWrT58v1xlajnXHp29i/R0M10Z1KL
	zOujDF0HIMCNUNbyIWnUFTQUq4OCHCDueTeieTgFMR5nwdVX7Hw2pok6gnX4V/BXgU2Tih/2zE8
	7w7uLDXiGQwYI9Y+YTe0mEH9UIKfHtjOwxQumZEYbkU43/KAxj6UyEZrVCW9O0K4nTKnMS8cNGW
	eymQfIin90ggqS0zXLpUXCvoozJtl4UNREpWTDD9Ds9Hu8LK46ccoQ2TMt/JnyOvylxK70MMSSe
	RPkzkwVnaN/MR8PCVVG6hJO6/KnIy/PiTcbkdT7i3tWAn7jy6SUkxpyDQCqZOoyVS5AfHtn1y7w
	0FyuZAwftWVi3nPIRj86j
X-Google-Smtp-Source: AGHT+IFFPNIK5VdY0I2gSxLRd5i4uf04sMnarqPFp/nGE7a6EQybziuhh4dTs+npkQ5k1dzF3wyK5w==
X-Received: by 2002:a05:6214:e4c:b0:6fa:d956:243b with SMTP id 6a1803df08f44-709363080damr139490616d6.37.1754322220184;
        Mon, 04 Aug 2025 08:43:40 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:72::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cea1782sm58271266d6.93.2025.08.04.08.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:43:39 -0700 (PDT)
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
Subject: [PATCH v3 3/6] mm/huge_memory: respect MADV_COLLAPSE with PR_THP_DISABLE_EXCEPT_ADVISED
Date: Mon,  4 Aug 2025 16:40:46 +0100
Message-ID: <20250804154317.1648084-4-usamaarif642@gmail.com>
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
---
 include/linux/huge_mm.h    | 8 +++++++-
 include/uapi/linux/prctl.h | 2 +-
 mm/huge_memory.c           | 5 +++--
 mm/memory.c                | 6 ++++--
 mm/shmem.c                 | 2 +-
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index bd4f9e6327e0..1fd06ecbde72 100644
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
 	return test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, &vma->vm_mm->flags);
 }
 
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 9c1d6e49b8a9..cdda963a039a 100644
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
index 85252b468f80..ef5ccb0ec5d5 100644
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
index be761753f240..bd04212d6f79 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5186,9 +5186,11 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 	 * It is too late to allocate a small folio, we already have a large
 	 * folio in the pagecache: especially s390 KVM cannot tolerate any
 	 * PMD mappings, but PTE-mapped THP are fine. So let's simply refuse any
-	 * PMD mappings if THPs are disabled.
+	 * PMD mappings if THPs are disabled. As we already have a THP ...
+	 * behave as if we are forcing a collapse.
 	 */
-	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags))
+	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags,
+						     /* forced_collapse=*/ true))
 		return ret;
 
 	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
diff --git a/mm/shmem.c b/mm/shmem.c
index e6cdfda08aed..30609197a266 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1816,7 +1816,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	vm_flags_t vm_flags = vma ? vma->vm_flags : 0;
 	unsigned int global_orders;
 
-	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags)))
+	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags, shmem_huge_force)))
 		return 0;
 
 	global_orders = shmem_huge_global_enabled(inode, index, write_end,
-- 
2.47.3


