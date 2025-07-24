Return-Path: <linux-fsdevel+bounces-55980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABD6B113DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 00:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C535F7B74DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 22:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FDB23CEF9;
	Thu, 24 Jul 2025 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQEw3K2Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979314A4F9;
	Thu, 24 Jul 2025 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396055; cv=none; b=khkJghqUiPpxtSRi6ghQgCPspSuDdd8jCwbAseUfdKrQaPYddHYvmAi+JkoVb6hIED8E9LNAwEqWlMEE2JucbBsK0rXnsFo1W9u367Y2akoLY+tBW4T0mnWoaVu2+HyVkoghmiCZxEqph9vQygkOK75yNKrQ4w+fP/vCxEh32ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396055; c=relaxed/simple;
	bh=dUgLK7f26TmOglvv3lWp1gcUZCQsO1PmzUBt+2c2A1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ig833xN4RjcUOALPIDfECVRPNpJpmos9V2pAWY/3aNJyZXoyitFkU14ZR16xGVeqiJVrpCasGtzZPYagv7ElPNEB3tqqJVRZdOadmwIbqt11RTS4N36BfoMHR6dadMZgXiXjbbGGMYmc7lpjhUUG5ez9bmAP0FZeddIZkL5CgJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQEw3K2Y; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so1016631f8f.0;
        Thu, 24 Jul 2025 15:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753396051; x=1754000851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kdkxvXYV1D1MezZXWXKeg8AUG+QiWG5386VJ0uuWpn4=;
        b=CQEw3K2YxUrqGU2V8Ak0HErlZA1y1fvHS1GQc5PaY1hcjcyTXMgKCSQduXaiMDQdMd
         6NCXEYuIcW93hwVKRgMyaiWHjurrRwyUcfWiyFKJJTZCDgDJe5j7kluStblqqrTuIHZT
         24+6malFWaW0WllLx/xfwqEU9bjc/4CWgtx22sRPeB7LVYPemgIIvq0oDvHjSVG4zILW
         rdartKFaHAki892L+N1AqrVXezmkEk5kFE16Ien/L7H3NcP9Yd4NjUEwGRr/ggaVed3u
         pS8UrzIk9RKyUiWRhEKkdV4C1iK67aLwy/XJfOrOGOiUjJiJFd4eqEZWLyvkjeB3t5Q2
         oMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753396051; x=1754000851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdkxvXYV1D1MezZXWXKeg8AUG+QiWG5386VJ0uuWpn4=;
        b=h3WHH2zwDURImyOw2KQrD/eqA22Zf21kSQxeP40Gp3ixlCeRZhv51DNP7Mt1ZBDjIg
         kgSluLOvMEF85hnGMBLbJQYgBJzIVdcy6LIgkkTAxngXDBl7K8frk4mtWEXIFWUX3ERB
         biVmfgZdWoIzsH8pFBq8McaUB9hyhrQx5Dn7d0t/LQJ4o/0JNe8gmEfYMjV0IgjolC/o
         OCF13e1U4EynGp32etJcewKAgeANFiGdR22OXtQhNjhOT8woJq7dZ5CdQNqLuhIcEOsl
         nIaxLjKQAMUGRREv7s4e6CsTasWNQDHd+G3HdVcWXX3PK2caXOOfcz8rBrCKLEJeikQW
         VbdA==
X-Forwarded-Encrypted: i=1; AJvYcCV7rYxtMCCQHOQM8SjBhsAgES628vn3Bm0Sz1m//eG8C1tyaXH2yzpc4+5KbIt1KYpN1rTCpEtf6bFpa2wyRA==@vger.kernel.org, AJvYcCVwNYfyAuH7YKtXz4Wm04F2ghPuTprQOhZN+lTy+z/fzYLOVG0TxZWK12nSTfgH807WMTmILJYcDLp5IjsE@vger.kernel.org, AJvYcCXesdybhY9ISMpAhpuSgpycUk+ck/poGYkRGtSi7Ihit1eHW9h1AezMOl2r2zKPbMT1/BxBv9dpBRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDWE+Ch2S1/RJwjN7zzguFHsnwzrBc9yeOjQNC3dgl3XuQOe5a
	PKL/KgdxZbYqkkikejuPv7gP64v+aCm6MU3cwBDZybsDGZr6kZaXgGTr
X-Gm-Gg: ASbGncvLtEulGKV6177JmkZtxp8OZk9xEHCCEJBIl3+ySoXDImXU1uJYe6zqmJLWmpN
	Wd8R1GH2J8YBKDOXLfPrdxiRv8Q3vw+cK/wm1n9tbqTg6FjP4MKmcNkIvMC0y36foxjMrCt50PH
	7dNhs7lbs4y04PSfY5bdo86YHhCRISS88YrDR6iYPx18b05/VEmaimP+bbDf5B8wV4ElVpE/jlV
	KVFPJehs24xooIJUf01a2uu9cckbyjlbBkFJ6r/7RwAUhVbZTNIs60XgXL9a2qJ6pODP9523S78
	8NOF6sOvGN6kDXqQHKukAsvucTFhtm1vfwQJ1U7wU92EpXEkGCWovFxMUYLEQ8dGOWOttecGe2e
	H6HPBJI3Ac4CJ7KEOkQEuJoHLk6o30E0ZaoZ1Pp7q7w0EWt++TBaBc4nqQp4Ay1PGzaKr8gKlJ1
	RClXjX4RjPBTFkotIateB6
X-Google-Smtp-Source: AGHT+IFyHNIR9eZnX6927KLgXv8HWbQyVdZCWFZ8/hlhXiyIO1E9ae/3HuNltJ/DO2eKAukxzmYnPg==
X-Received: by 2002:adf:a2c7:0:b0:3a4:e231:8632 with SMTP id ffacd0b85a97d-3b771355208mr2526117f8f.12.1753396050739;
        Thu, 24 Jul 2025 15:27:30 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4? ([2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc605a4sm3285674f8f.14.2025.07.24.15.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 15:27:29 -0700 (PDT)
Message-ID: <99e25828-641b-490b-baab-35df860760b4@gmail.com>
Date: Thu, 24 Jul 2025 23:27:29 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH POC] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, SeongJae Park <sj@kernel.org>,
 Jann Horn <jannh@google.com>, Yafang Shao <laoar.shao@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250721090942.274650-1-david@redhat.com>
 <3ec01250-0ff3-4d04-9009-7b85b6058e41@gmail.com>
 <601e015b-1f61-45e8-9db8-4e0d2bc1505e@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <601e015b-1f61-45e8-9db8-4e0d2bc1505e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> Hi!
> 
>>
>> Over here, with MMF_DISABLE_THP_EXCEPT_ADVISED, MADV_HUGEPAGE will succeed as vm_flags has
>> VM_HUGEPAGE set, but MADV_COLLAPSE will fail to give a hugepage (as VM_HUGEPAGE is not set
>> and MMF_DISABLE_THP_EXCEPT_ADVISED is set) which I feel might not be the right behaviour
>> as MADV_COLLAPSE is "advise" and the prctl flag is PR_THP_DISABLE_EXCEPT_ADVISED?
> 
> THPs are disabled for these regions, so it's at least consistent with the "disable all", but ...
> 
>>
>> This will be checked in multiple places in madvise_collapse: thp_vma_allowable_order,
>> hugepage_vma_revalidate which calls thp_vma_allowable_order and hpage_collapse_scan_pmd
>> which also ends up calling hugepage_vma_revalidate.
>> > A hacky way would be to save and overwrite vma->vm_flags with VM_HUGEPAGE at the start of madvise_collapse
>> if VM_NOHUGEPAGE is not set, and reset vma->vm_flags to its original value at the end of madvise_collapse
>> (Not something I am recommending, just throwing it out there).
> 
> Gah.
> 
>>
>> Another possibility is to pass the fact that you are in madvise_collapse to these functions
>> as an argument, this might look ugly, although maybe not as ugly as hugepage_vma_revalidate
>> already has collapse control arg, so just need to take care of thp_vma_allowable_orders.
> 
> Likely this.
> 
>>
>> Any preference or better suggestions?
> 
> What you are asking for is not MMF_DISABLE_THP_EXCEPT_ADVISED as I planned it, but MMF_DISABLE_THP_EXCEPT_ADVISED_OR_MADV_COLLAPSE.
> 
> Now, one could consider MADV_COLLAPSE an "advise". (I am not opposed to that change)
> 

lol yeah I always think of MADV_COLLAPSE as an extreme version of MADV_HUGE (more of a demand
than an advice :)), eventhough its not persistant.
Which is why I think might be unexpected if MADV_HUGE gives hugepages but MADV_COLLAPSE doesn't
(But could just be my opinion).

> Indeed, the right way might be telling vma_thp_disabled() whether we are in collapse.
> 
> Can you try implementing that on top of my patch to see how it looks?
> 

My reasoning is that a process that is running with system policy always but with
PR_THP_DISABLE_EXCEPT_ADVISED gets THPs in exactly the same behaviour as a process that is running
with system policy madvise. This will help us achieve (3) that you mentioned in the
commit message:
(3) Switch from THP=madvise to THP=always, but keep the old behavior
     (THP only when advised) for selected workloads.


I have written quite a few selftests now for prctl SET_THP_DISABLE, both with and without
PR_THP_DISABLE_EXCEPT_ADVISED set incorporating your feedback on it. I have all of them passing
with the below diff. The diff is slightly ugly, but very simple and hopefully acceptable. If it
looks good, I can send a series with everything. Probably make the below diff as a separate patch
on top of this patch as its mostly adding an extra arg to functions and would keep the review easier?
I can squash it with this patch as well if thats better.

Thanks!


diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3d6d8a9f13fc..bb5f1dedbd2c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1294,7 +1294,7 @@ static int show_smap(struct seq_file *m, void *v)
 
 	seq_printf(m, "THPeligible:    %8u\n",
 		   !!thp_vma_allowable_orders(vma, vma->vm_flags,
-			   TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
+			   TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL, 0));
 
 	if (arch_pkeys_enabled())
 		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 71db243a002e..82066721b161 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -98,8 +98,8 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 #define TVA_IN_PF		(1 << 1)	/* Page fault handler */
 #define TVA_ENFORCE_SYSFS	(1 << 2)	/* Obey sysfs configuration */
 
-#define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
-	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
+#define thp_vma_allowable_order(vma, vm_flags, tva_flags, order, in_collapse) \
+	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order), in_collapse))
 
 #define split_folio(f) split_folio_to_list(f, NULL)
 
@@ -265,7 +265,8 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 vm_flags_t vm_flags,
 					 unsigned long tva_flags,
-					 unsigned long orders);
+					 unsigned long orders,
+					 bool in_collapse);
 
 /**
  * thp_vma_allowable_orders - determine hugepage orders that are allowed for vma
@@ -273,6 +274,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
  * @vm_flags: use these vm_flags instead of vma->vm_flags
  * @tva_flags: Which TVA flags to honour
  * @orders: bitfield of all orders to consider
+ * @in_collapse: whether we are being called from MADV_COLLAPSE
  *
  * Calculates the intersection of the requested hugepage orders and the allowed
  * hugepage orders for the provided vma. Permitted orders are encoded as a set
@@ -286,7 +288,8 @@ static inline
 unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 				       vm_flags_t vm_flags,
 				       unsigned long tva_flags,
-				       unsigned long orders)
+				       unsigned long orders,
+				       bool in_collapse)
 {
 	/* Optimization to check if required orders are enabled early. */
 	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
@@ -303,7 +306,7 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 			return 0;
 	}
 
-	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
+	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders, in_collapse);
 }
 
 struct thpsize {
@@ -323,7 +326,7 @@ struct thpsize {
  * through madvise or prctl.
  */
 static inline bool vma_thp_disabled(struct vm_area_struct *vma,
-		vm_flags_t vm_flags)
+		vm_flags_t vm_flags, bool in_collapse)
 {
 	/* Are THPs disabled for this VMA? */
 	if (vm_flags & VM_NOHUGEPAGE)
@@ -331,6 +334,9 @@ static inline bool vma_thp_disabled(struct vm_area_struct *vma,
 	/* Are THPs disabled for all VMAs in the whole process? */
 	if (test_bit(MMF_DISABLE_THP_COMPLETELY, &vma->vm_mm->flags))
 		return true;
+	/* Are we being called from madvise_collapse? */
+	if (in_collapse)
+		return false;
 	/*
 	 * Are THPs disabled only for VMAs where we didn't get an explicit
 	 * advise to use them?
@@ -537,7 +543,8 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
 static inline unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 					vm_flags_t vm_flags,
 					unsigned long tva_flags,
-					unsigned long orders)
+					unsigned long orders,
+					bool in_collapse)
 {
 	return 0;
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2b4ea5a2ce7d..ecf48a922530 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -100,7 +100,8 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 vm_flags_t vm_flags,
 					 unsigned long tva_flags,
-					 unsigned long orders)
+					 unsigned long orders,
+					 bool in_collapse)
 {
 	bool smaps = tva_flags & TVA_SMAPS;
 	bool in_pf = tva_flags & TVA_IN_PF;
@@ -122,7 +123,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	if (!vma->vm_mm)		/* vdso */
 		return 0;
 
-	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags))
+	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags, in_collapse))
 		return 0;
 
 	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2c9008246785..ba707ce5a00a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -475,7 +475,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
 	    hugepage_pmd_enabled()) {
 		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
-					    PMD_ORDER))
+					    PMD_ORDER, 0))
 			__khugepaged_enter(vma->vm_mm);
 	}
 }
@@ -932,7 +932,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 
 	if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
 		return SCAN_ADDRESS_RANGE;
-	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, PMD_ORDER))
+	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, PMD_ORDER, 1))
 		return SCAN_VMA_CHECK;
 	/*
 	 * Anon VMA expected, the address may be unmapped then
@@ -1534,7 +1534,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	 * and map it by a PMD, regardless of sysfs THP settings. As such, let's
 	 * analogously elide sysfs THP settings here.
 	 */
-	if (!thp_vma_allowable_order(vma, vma->vm_flags, 0, PMD_ORDER))
+	if (!thp_vma_allowable_order(vma, vma->vm_flags, 0, PMD_ORDER, 1))
 		return SCAN_VMA_CHECK;
 
 	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
@@ -2432,7 +2432,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 			break;
 		}
 		if (!thp_vma_allowable_order(vma, vma->vm_flags,
-					TVA_ENFORCE_SYSFS, PMD_ORDER)) {
+					TVA_ENFORCE_SYSFS, PMD_ORDER, 0)) {
 skip:
 			progress++;
 			continue;
@@ -2766,7 +2766,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 	BUG_ON(vma->vm_start > start);
 	BUG_ON(vma->vm_end < end);
 
-	if (!thp_vma_allowable_order(vma, vma->vm_flags, 0, PMD_ORDER))
+	if (!thp_vma_allowable_order(vma, vma->vm_flags, 0, PMD_ORDER, 1))
 		return -EINVAL;
 
 	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
diff --git a/mm/memory.c b/mm/memory.c
index 92fd18a5d8d1..da5ab2dc1797 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4370,7 +4370,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	 * and suitable for swapping THP.
 	 */
 	orders = thp_vma_allowable_orders(vma, vma->vm_flags,
-			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
+			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1, 0);
 	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
 	orders = thp_swap_suitable_orders(swp_offset(entry),
 					  vmf->address, orders);
@@ -4918,7 +4918,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	 * the faulting address and still be fully contained in the vma.
 	 */
 	orders = thp_vma_allowable_orders(vma, vma->vm_flags,
-			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
+			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1, 0);
 	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
 
 	if (!orders)
@@ -5188,7 +5188,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 	 * PMD mappings, but PTE-mapped THP are fine. So let's simply refuse any
 	 * PMD mappings if THPs are disabled.
 	 */
-	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags))
+	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags, 0))
 		return ret;
 
 	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
@@ -6109,7 +6109,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 retry_pud:
 	if (pud_none(*vmf.pud) &&
 	    thp_vma_allowable_order(vma, vm_flags,
-				TVA_IN_PF | TVA_ENFORCE_SYSFS, PUD_ORDER)) {
+				TVA_IN_PF | TVA_ENFORCE_SYSFS, PUD_ORDER, 0)) {
 		ret = create_huge_pud(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
@@ -6144,7 +6144,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 
 	if (pmd_none(*vmf.pmd) &&
 	    thp_vma_allowable_order(vma, vm_flags,
-				TVA_IN_PF | TVA_ENFORCE_SYSFS, PMD_ORDER)) {
+				TVA_IN_PF | TVA_ENFORCE_SYSFS, PMD_ORDER, 0)) {
 		ret = create_huge_pmd(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
diff --git a/mm/shmem.c b/mm/shmem.c
index e6cdfda08aed..1960cf87b077 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1816,7 +1816,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	vm_flags_t vm_flags = vma ? vma->vm_flags : 0;
 	unsigned int global_orders;
 
-	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags)))
+	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags, 0)))
 		return 0;
 
 	global_orders = shmem_huge_global_enabled(inode, index, write_end,






