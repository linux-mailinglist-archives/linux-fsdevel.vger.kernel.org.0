Return-Path: <linux-fsdevel+bounces-56044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF18B121F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 18:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F2156074B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 16:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5832EFD95;
	Fri, 25 Jul 2025 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQTXq0SX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125972EF9B2;
	Fri, 25 Jul 2025 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460587; cv=none; b=T8YIqjSYT0cA7Yx7r3pFZxxW+Hck579sT8WOd2oONNt1jeLeX0URoK12bV9bIHTBUGojSsKlkTsTt4ClR+xpCHriqad7nRbZw/TOhidwSYoT39872vhB51rE5y+iTZ/SNdFy3Hjby5KD56v3p1A1yYOzWZxrr8zWDxsZ01e2b4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460587; c=relaxed/simple;
	bh=lmwS2ogqw4bPnaA/NfmN2fdPCVXyC/N6/6t61sTZVlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMspOcD6A2AXG2oP9cqwCne4Ia7rbI/Mm/AZ6cAzUy8DCKVeQ8LoIzHK0AmypMdWDrPdWb86pkp3PZQO5oYF6RUZNRNmWJL9W8SGaBXgfIfJiluA6Pvbbv2PFrsog1spiz9uv+QdTuXzANs+UTsWu0LT3apxn5LvJIVqJJxbgy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQTXq0SX; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fd1b2a57a0so23596746d6.1;
        Fri, 25 Jul 2025 09:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753460585; x=1754065385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JREE5x0ARz2QqEVTan/K1w654MwTZ7Hc0OH3aFNqbBE=;
        b=WQTXq0SXSooxrx8kN39IbwOTb8kAoeAbT6ti7g34UM+4EmqOoVM8Emc6B1spIP5E6P
         Hhi/ZBKjqBn2Lxr1MTXe/fPbWptgdaJi4FfVlqg5ggordKxZ/jXAeiKfDjruy8qEDF7j
         Jnl27+ZCxT/uPiQNxFxHJGJfBvY5ypBm1h/OztB4Imofjm/sGaxVufIU5hY1cUgkhlgW
         4dQw9hy/V0CFcW8ycRVZ30hKvIVI3kuEjcF+yOSGFHgPPLByUC+n3d0hRsQ7y5KXEAmI
         rRp0C6kBJVsTR6IkRPs8kYEh1sfNwkMuZdm5qRqN7YmzWLjPbJt238Hh0LuwxQvEkaTt
         OJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460585; x=1754065385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JREE5x0ARz2QqEVTan/K1w654MwTZ7Hc0OH3aFNqbBE=;
        b=NdOPMFrKgZfIC0ctxRNoh9766GDD9a4YTwC2uY82gPFGxIENX00aI7uc3Iz7H+eE16
         1zKWVv9xX8vxZcm+talUtGVXbzia6lSvmfDLSaIIvhwtHhwRjPn7MjYkpfOxJ9xmMwoA
         r8gSbhsPp2MIuvEYafxej5UIZ66DilgApLgIlgI24F2vSpATEoAteS5d+j+Lv5tuql9k
         AZSElXvVJ8Ef7VT3gnnizKR68wTrjamxSNskeJ2sO6iu9Y/O09lFhmBUKjDkekB9yP0Q
         T5M7zAjzSA9vskN43ps3YVFruXJ5A6K8XHbL+opf+DYY4GUkKKjwxEeCwhHi7Yokvou/
         C1gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuEpgGDmhxtYupgwtvp1gQniyTPEGn28frllXMjmDM7JRFmVJP81Du8H/ql0e/xqJjvYQNob8zgGgJdy3I@vger.kernel.org, AJvYcCWnO/nJl8qb+IDcGF18NDBdJBiKCjjhrGFZtc9gdpdRcIm38/UgeQWOxUloQKhlNG+1k3xJyJmr9uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRyVH2P8o1a3qVCd0qJWmR1Hmhl87lZErQ8OW++yD09gAD4ISl
	ltjq3qot4q0RO5b/YNo+ZNRgeWp/3PI6GsMNpB+nFYJWhzKQtq8yDGRM
X-Gm-Gg: ASbGncvpHH1JLb3Qi3GzYlX/bXHjupYouKyC0YPcgjlBhK4zwlysErRqMJtPvBh275S
	Ny5kCcgHPhu83gHkKO6XJ+P5i4GvKo1ccv7SXxOm8IR81D/Klz8w9e5YgshN65jcCk9EORivdF7
	CJ3gaeNOJUNPDiLy5fqfSMjMwKnSgdgVUggKxS1mCtEfiD/ZUuIx2GLBbM7yRgSfy4tMcOPRml2
	7HPfXDYreBVWYJtLYUc+yDtTzjdLcoEChiDON+mHRWBdGEojATDVV9zX1LZa+48k9RVdczUjwNl
	DV5J7Hl/gVySs8tlHx1bBUXpWH1Zt6K1b0W5REDruN8MUN1APJop0BJbGwkRufGHf2Xf+SK1Kom
	zrxRns1NUYrBpLTuge4Q=
X-Google-Smtp-Source: AGHT+IEN5w1m+WG8vUhOdUow2NKovnyWHknbSVQl8xiAB4hL6Q385HGbdTJbSA2QKHuAKvjV5mQMkw==
X-Received: by 2002:a05:6214:29c6:b0:704:a583:d98 with SMTP id 6a1803df08f44-707205304f3mr36859976d6.18.1753460584541;
        Fri, 25 Jul 2025 09:23:04 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:5::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729c6f5d9sm1807706d6.83.2025.07.25.09.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:23:04 -0700 (PDT)
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
Date: Fri, 25 Jul 2025 17:22:42 +0100
Message-ID: <20250725162258.1043176-4-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250725162258.1043176-1-usamaarif642@gmail.com>
References: <20250725162258.1043176-1-usamaarif642@gmail.com>
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


