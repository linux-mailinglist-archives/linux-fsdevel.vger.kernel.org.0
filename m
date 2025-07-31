Return-Path: <linux-fsdevel+bounces-56404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DDDB17135
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B8AF7A4C36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E8C2C326A;
	Thu, 31 Jul 2025 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUWJoKRM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D404F2C1597;
	Thu, 31 Jul 2025 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964917; cv=none; b=YyY3EYQNWzvIN3q4CEW2ZPItmxNgB2sZaME5oOoaRyVnd7AZFTxGqdZgJFZ3I9xtYgDUB6fWXdFbTma8a6Pb88+uuz+oLt9zUcVFe+T8YqS16zUhQv6aeQQYQGNsYz4QSJsolHiYmnXQHFlRKC0c9pfguCCSLqikVeSVgr+czD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964917; c=relaxed/simple;
	bh=lmwS2ogqw4bPnaA/NfmN2fdPCVXyC/N6/6t61sTZVlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcR7JRge9Qpbqam2kV6Ut8FmuvR9RwT+RyS4cz1bu9gX73HdRtrMH8uFZvC9/mlc8giuT549Z83Iu53/HnuQOVf0FYbDMvflzdpjJAU0CIypdG6wzHLzEVatwKT6yAKELXDtuG3xQuHxwKpiDMf3haQiVGiNqjWnA/Zz2E9I3FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUWJoKRM; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70749d4c5b5so7277836d6.1;
        Thu, 31 Jul 2025 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753964915; x=1754569715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JREE5x0ARz2QqEVTan/K1w654MwTZ7Hc0OH3aFNqbBE=;
        b=kUWJoKRMClORAAw9UaCfoA+bD0ROIuDF94XT7C9KimNx7DIYccKxvnTDkwVMfrce7I
         z5xBZeKvUh0rowFMlrhPiZ472BnkdsW/rHmlgoIs+jfYh4EG8bs36GmDQg+j2fqj1iWI
         UXkY+F+znd435Sct8qsVfTD3gd9c+vDIHAIqsGPmOEshuJF1M2Vjjivt0AqW6cwTzRZd
         Lukdusi/mAsUNj5yaiSin/UFmBXpaNEIAD+koAKtOFTLaZar2/MMjTYFFVXRuK5843Eu
         IH8P/Fx3Mm79f6QxdGBXTazQ3NcCP8w3UmqfF7rrXHRCGgrz1IUtH8ZGVc1DBEQ+WAM3
         H4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964915; x=1754569715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JREE5x0ARz2QqEVTan/K1w654MwTZ7Hc0OH3aFNqbBE=;
        b=nBzb8xU6Ztx0nZV992ZASmX4/cvslWMTM9XBU14JXTmlWlaNPvCTezJxaR+bAeG+TE
         1In/kHCIqMLTNxURb1YYpVjDmarEjhNzvR5nhaAOCfsH66cQJbWx7REbJjiDMa1y9fvS
         gFm6iXeW5sJvoUU69m8IGxOYsUfmtGubB4lThTOzmqijkbPx4WYny+4QwH+BUWkmGtOQ
         E9lt3Tfps6180k1zyXIL59Hq9gXRqLrIcxMxrRYHY5/9B39gf/rbvoMX0qe2/KGf2Ivn
         0S4U7j9YzXDFQPVsiBjCtAn1LKz45dz43P9SIpO/oQQPPaSQeW2PwB8FjDmFvmDcxYH3
         mw8A==
X-Forwarded-Encrypted: i=1; AJvYcCVhXvnEMCNRtvbJWSbc/EOxmXMeeK2QPrpWVg39CfD+xWfSmx/Un8EXNXoskdlMrqeGxIj/nWyXS/z0vx5D@vger.kernel.org, AJvYcCWxUbi73O714FpKxv8Oov0BWjRFcEaNJxa1M4HXne6bDSdCOaFCvQ8RwO2iXN/AmKNfP/nsh+JnvXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvyICtKIFfxLveFX4G3nML9eQdi3FDfD0rka+e/vMQ3uHalhKl
	hlBHz47rsno81KbuVUZYtTOX5bJhNTjMMtI+AfqFJYQDpkf7JwkFO6Pz
X-Gm-Gg: ASbGnctk+t/RtqplmlIuVOt8/kF7QKhNCz/XY9O7H5AmZKENeiUaRoIPFrbQCe7kWn6
	1m+LApTfdVP8KyNbvoUCbbOBkmZOHZFYpILlA5fRuoN7Zx3NKxesHw8iHaWSuHyexCCm6OdTRCV
	Dbi55ju7oQ+y3N8I0JQdJyTmRg8aED8uBd/4GsAWw/3z95AQYQK6xsJQZ1v9kcrn0MckhUlwuv6
	H+Pccfuc3jZEgg6ByOof1T+jQCs5tIpqDJWa//uCK6BJ9MA+X+dGHteGGC9bqGxyERpesB9Ul3w
	yh87kTAxz7feHCmei3+Pg6LSgMbVDk33BlNdJb36YYgYp5Xo9ou7BhLBHOBBWLd/+pARnrC27mS
	PLpbbde9vvmUeuzXBDTaYncbFgawQgA==
X-Google-Smtp-Source: AGHT+IHnTo622/0F8XtAvaFAhVW0Cfz3Ak4EUz5CdKszTNMI3rpFIV38QgSvVNtOqU/62lqxWSWeSQ==
X-Received: by 2002:a05:6214:cc6:b0:707:4d17:e280 with SMTP id 6a1803df08f44-707671e8f20mr109836866d6.28.1753964914446;
        Thu, 31 Jul 2025 05:28:34 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:1::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce24cd9sm6503666d6.76.2025.07.31.05.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:28:33 -0700 (PDT)
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
Subject: [PATCH v2 3/5] mm/huge_memory: treat MADV_COLLAPSE as an advise with PR_THP_DISABLE_EXCEPT_ADVISED
Date: Thu, 31 Jul 2025 13:27:20 +0100
Message-ID: <20250731122825.2102184-4-usamaarif642@gmail.com>
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

From: David Hildenbrand <david@redhat.com>

Let's allow for making MADV_COLLAPSE succeed on areas that neither have
VM_HUGEPAGE nor VM_NOHUGEPAGE when we have THP disabled
unless explicitly advised (PR_THP_DISABLE_EXCEPT_ADVISED).

MADV_COLLAPSE is a clear advise that we want to collapse.

Note that we still respect the VM_NOHUGEPAGE flag, just like
MADV_COLLAPSE always does. So consequently, MADV_COLLAPSE is now only
refused on VM_NOHUGEPAGE with PR_THP_DISABLE_EXCEPT_ADVISED.

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
index b0ff54eee81c..aeaf93f8ac2e 100644
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
+	 * Forcing a collapse (e.g., madv_collapse), is a clear advise to
+	 * use THPs.
+	 */
+	if (forced_collapse)
+		return false;
 	return test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, &vma->vm_mm->flags);
 }
 
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 9c1d6e49b8a9..ee4165738779 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -185,7 +185,7 @@ struct prctl_mm_map {
 #define PR_SET_THP_DISABLE	41
 /*
  * Don't disable THPs when explicitly advised (e.g., MADV_HUGEPAGE /
- * VM_HUGEPAGE).
+ * VM_HUGEPAGE / MADV_COLLAPSE).
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


