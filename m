Return-Path: <linux-fsdevel+bounces-56395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC875B17109
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A522A1C219BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902EE2C3245;
	Thu, 31 Jul 2025 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XA38il1z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5D02C159B;
	Thu, 31 Jul 2025 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964520; cv=none; b=KWiy6lEmNaAeMA3Hahxbwh8Trjy0RaQnt21yDha1qvAMZCCGV8LrpcCDt9NYK5m5/ksq8qtZ/5jPybe5EPanBLGHcJrTj5v7yePfcxue/iYuyu8NFW5PjxqfXo6CNPTHHa0DYCJxgEmrZGGRIS5OrSWk3k0eRZwDJ7AzsiCSxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964520; c=relaxed/simple;
	bh=lmwS2ogqw4bPnaA/NfmN2fdPCVXyC/N6/6t61sTZVlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mx1tRf89IN3f9i9I7mzZGOwis6Zo6UKYdonOXssAFPiR6Yf4zaQRsckR0Eixiy2mQK+buYohByhVlHgZJIiciT/IS7JWISfjoASKjCsKyc+q77pKAG8nAf3ykYvUkRWxwn0Yr+64kqWVyt6C7fjcNVpLAMqa1rwa+aLE+YRuHAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XA38il1z; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso10482746d6.3;
        Thu, 31 Jul 2025 05:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753964518; x=1754569318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JREE5x0ARz2QqEVTan/K1w654MwTZ7Hc0OH3aFNqbBE=;
        b=XA38il1zaPQ0YOrCcNXZwhaLypoD02qEFDnTGRyT55iFh8TmO/G+brU8sjZNrkv7bb
         RzoUIiVdBLrt22xkyAq3+8hmrhbn/9ijbc9Z/NwJ4Gy/vH3RnOvR06RbSLAdncxsbNyY
         4MQ1zf59KlsH9iKFLIZW6tYt54+bZYfSsB++yNq7qvUw7lDSwFdz3Zha6Yg7ENOL7FFl
         jnZ/1pJ9D7we1EfXQ0LqHa5lb0dko6TunBgJhPYdFkY6LV3VhaK0uGnZQShZLdNuz10p
         fkUGow5GO6Gnu4h4sAMMaH8yDjcaKGFA+vwZ7Mas0OEVk94i0RSUA0lMgv9MQWIulLDV
         KkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964518; x=1754569318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JREE5x0ARz2QqEVTan/K1w654MwTZ7Hc0OH3aFNqbBE=;
        b=fYl7JouLbbMM7RHo+mKgnUDSc6fSmJWsNEHxxY4xiluTSSBqNcQH2vILgw53iORljq
         ChSO/jazcZLKSHPdUow1nc+rezVDrPXUBMI14V8arOP9IoEcCBHMifyWmMYM2PflNtbS
         woLSz5rEiBD22y0VDdWDo3+rkOzbVTQ9rIzuOYzV6J3unSQE5lks+0xYfBLngSvtdjP/
         Nl46Yt+6Pu8CfZvfjsDLRH1iSfYbb4rG38fKwQPV+uk8uxJgEqMQubgYy9WSw8LKr5Ic
         WBkhybYYhubEIIvu4aL5pH09fIcEzGBlV4zwMVlxvL44kea4MtBZy6odxyMttLuIMv/7
         cNRw==
X-Forwarded-Encrypted: i=1; AJvYcCV3SGvT/tb6AUBaYW/sTC1Y195EmgDiJhzUk2C6lXqXXAbKSu/kj6CsUfrF3ynmnT8SO7JxdSRSItw=@vger.kernel.org, AJvYcCWZ/kfxTGH101VBoyNPP1JKGxARsx7c+qUx9b29T6Vl8aJWQpzSfFd80KZNNj2ncBfCsggNs0T+0b5tgLWr@vger.kernel.org
X-Gm-Message-State: AOJu0YxWDKlSrfhsybx2nly7FPJvZ+ZTJ15SnohC21LLA/GtUKBZ5p7G
	DqAmI1/JJMoCwvDnt9E1U5C0xw8ziwZIv/CWjB+XHFr94IcNkowkVFr9lrDOzO5R
X-Gm-Gg: ASbGncugMJ6BxbjEXbCabP2WqnJm0uDp0L9QHNJCu2xqefKu7eVMip9TubWx2navmwS
	euVqeobqolm5qyNo+Q5mKx6xWy7/TWvbGeab80xjd+SLlJnmr17DIyIkr6diEVMXc9r86cWL8Fg
	OH7j/EzUsLJJogOdEnHjBplNu+F67JJHWZYl3PDVpCdz4EHMzPSbhrNbr8ItkgvO9GIkpTOTtWH
	2GTJ8O0PuIirx7md6CFPAjCbLNECfpjacMrdGCsggEhH5K9Y71Jldcd5G5BpMCWNblOmcdUGlrb
	yrp0rbUEzSuX5UGI6u88Pz9oGsdxniNU5Flp7elBkHnNDvXEv/jihpXt9EtP0HXn4idvGOxObup
	AKJNSOPIng/KYbAdbL2vs
X-Google-Smtp-Source: AGHT+IHsIKxLwFEluODV0vbsvFrMCl5SsgfWsi5T715aWZqjhTTayiRwPtiQzpPMq3PXVQ+C8nEB/g==
X-Received: by 2002:a05:6214:5283:b0:707:4fef:468c with SMTP id 6a1803df08f44-70766d85cbfmr109037656d6.5.1753964517952;
        Thu, 31 Jul 2025 05:21:57 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:73::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9d8affsm6650646d6.5.2025.07.31.05.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:21:57 -0700 (PDT)
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
Subject: [PATCH 3/5] mm/huge_memory: treat MADV_COLLAPSE as an advise with PR_THP_DISABLE_EXCEPT_ADVISED
Date: Thu, 31 Jul 2025 13:18:14 +0100
Message-ID: <20250731122150.2039342-4-usamaarif642@gmail.com>
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


