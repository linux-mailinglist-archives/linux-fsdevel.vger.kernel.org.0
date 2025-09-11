Return-Path: <linux-fsdevel+bounces-60918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 420CBB52DCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C5524E1698
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 09:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4FE2EF648;
	Thu, 11 Sep 2025 09:57:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655412EC0B6;
	Thu, 11 Sep 2025 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757584632; cv=none; b=uiTWqeDYqaacV0mvJ/2Ib7q9/v9TfmzWOoBA+QHmwavaFuBk3dLiW/jQdJK9C0MY1eDvo43/GWPTbDsmGHpYN+4QS49sZsrpAbT11ItS/D9GCtMcOsuoaLQv8XcaoR4OcOd5YmgUJNmGUZnzRIgGjw0saKl/A/WwAl/4h+7+pyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757584632; c=relaxed/simple;
	bh=EwCOHc4Id0yhA/OXn/9H5Pdj6UpNl8iIaXZplKxGyAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ml/RW+Tlqc2oP2G0R+1/iOCFFsoSrXciMr/11BHasZRMMI8M5HmLNuEXqmKNmh/ys3T2A/ZRQRqILrgwdf5hgMas8HdH13mcP0h3dwUZDfhgPg8hZov0erMw7NVTeoiNU7rNAkMjVz5vpbhBO+aHd0fgvJN8tRCqKY49+qM2BMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowACH2IK5nMJoo6pCAg--.44660S4;
	Thu, 11 Sep 2025 17:56:12 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Deepak Gupta <debug@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v11 2/5] mm: userfaultfd: Add pgtable_uffd_wp_supported()
Date: Thu, 11 Sep 2025 17:55:59 +0800
Message-Id: <20250911095602.1130290-3-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911095602.1130290-1-zhangchunyan@iscas.ac.cn>
References: <20250911095602.1130290-1-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACH2IK5nMJoo6pCAg--.44660S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr1DGFWrJry3KryfWF17ZFb_yoWxuFyfpF
	47Gw45Xrs7JF97Ga93Aa10k3s8Zw4fKrykWryF93W8A3W3t390vryFkFWFyF93Jr4kWryx
	tF17trWkur42vwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmmb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7
	CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	YxBIdaVFxhVjvjDU0xZFpf9x07jPID7UUUUU=
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiDAgCB2jCjVc9QgAAsO

Some platforms can customize the PTE/PMD entry uffd-wp bit making
it unavailable even if the architecture provides the resource.
This patch adds a macro API that allows architectures to define their
specific implementations to check if the uffd-wp bit is available
on which device the kernel is running.

Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
---
 fs/userfaultfd.c                   | 23 ++++++++--------
 include/asm-generic/pgtable_uffd.h | 11 ++++++++
 include/linux/mm_inline.h          |  7 +++++
 include/linux/userfaultfd_k.h      | 44 +++++++++++++++++++-----------
 mm/memory.c                        |  6 ++--
 5 files changed, 62 insertions(+), 29 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 54c6cc7fe9c6..b549c327d7ad 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1270,9 +1270,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MISSING)
 		vm_flags |= VM_UFFD_MISSING;
 	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_WP) {
-#ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
-		goto out;
-#endif
+		if (!pgtable_uffd_wp_supported())
+			goto out;
+
 		vm_flags |= VM_UFFD_WP;
 	}
 	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MINOR) {
@@ -1980,14 +1980,15 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	uffdio_api.features &=
 		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
 #endif
-#ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
-	uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
-#endif
-#ifndef CONFIG_PTE_MARKER_UFFD_WP
-	uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
-	uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
-	uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
-#endif
+	if (!pgtable_uffd_wp_supported())
+		uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+
+	if (!IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP) ||
+	    !pgtable_uffd_wp_supported()) {
+		uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
+		uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
+		uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
+	}
 
 	ret = -EINVAL;
 	if (features & ~uffdio_api.features)
diff --git a/include/asm-generic/pgtable_uffd.h b/include/asm-generic/pgtable_uffd.h
index 828966d4c281..895d68ece0e7 100644
--- a/include/asm-generic/pgtable_uffd.h
+++ b/include/asm-generic/pgtable_uffd.h
@@ -1,6 +1,17 @@
 #ifndef _ASM_GENERIC_PGTABLE_UFFD_H
 #define _ASM_GENERIC_PGTABLE_UFFD_H
 
+/*
+ * Some platforms can customize the uffd-wp bit, making it unavailable
+ * even if the architecture provides the resource.
+ * Adding this API allows architectures to add their own checks for the
+ * devices on which the kernel is running.
+ * Note: When overiding it, please make sure the
+ * CONFIG_HAVE_ARCH_USERFAULTFD_WP is part of this macro.
+ */
+#ifndef pgtable_uffd_wp_supported
+#define pgtable_uffd_wp_supported()	IS_ENABLED(CONFIG_HAVE_ARCH_USERFAULTFD_WP)
+#endif
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static __always_inline int pte_uffd_wp(pte_t pte)
 {
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 89b518ff097e..38845b8b79ff 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -571,6 +571,13 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 			      pte_t *pte, pte_t pteval)
 {
 #ifdef CONFIG_PTE_MARKER_UFFD_WP
+	/*
+	 * Some platforms can customize the PTE uffd-wp bit, making it unavailable
+	 * even if the architecture allows providing the PTE resource.
+	 */
+	if (!pgtable_uffd_wp_supported())
+		return false;
+
 	bool arm_uffd_pte = false;
 
 	/* The current status of the pte should be "cleared" before calling */
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index c0e716aec26a..6264b56ae961 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -228,15 +228,15 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 	if (wp_async && (vm_flags == VM_UFFD_WP))
 		return true;
 
-#ifndef CONFIG_PTE_MARKER_UFFD_WP
 	/*
 	 * If user requested uffd-wp but not enabled pte markers for
 	 * uffd-wp, then shmem & hugetlbfs are not supported but only
 	 * anonymous.
 	 */
-	if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
+	if ((!IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP) ||
+	     !pgtable_uffd_wp_supported()) &&
+	    (vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
 		return false;
-#endif
 
 	/* By default, allow any of anon|shmem|hugetlb */
 	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
@@ -437,8 +437,11 @@ static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
 static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
 {
 #ifdef CONFIG_PTE_MARKER_UFFD_WP
-	return is_pte_marker_entry(entry) &&
-	    (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
+	if (pgtable_uffd_wp_supported())
+		return is_pte_marker_entry(entry) &&
+			(pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
+	else
+		return false;
 #else
 	return false;
 #endif
@@ -447,14 +450,19 @@ static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
 static inline bool pte_marker_uffd_wp(pte_t pte)
 {
 #ifdef CONFIG_PTE_MARKER_UFFD_WP
-	swp_entry_t entry;
+	if (pgtable_uffd_wp_supported()) {
+		swp_entry_t entry;
 
-	if (!is_swap_pte(pte))
-		return false;
+		if (!is_swap_pte(pte))
+			return false;
 
-	entry = pte_to_swp_entry(pte);
+		entry = pte_to_swp_entry(pte);
+
+		return pte_marker_entry_uffd_wp(entry);
+	} else {
+		return false;
+	}
 
-	return pte_marker_entry_uffd_wp(entry);
 #else
 	return false;
 #endif
@@ -467,14 +475,18 @@ static inline bool pte_marker_uffd_wp(pte_t pte)
 static inline bool pte_swp_uffd_wp_any(pte_t pte)
 {
 #ifdef CONFIG_PTE_MARKER_UFFD_WP
-	if (!is_swap_pte(pte))
-		return false;
+	if (pgtable_uffd_wp_supported()) {
+		if (!is_swap_pte(pte))
+			return false;
 
-	if (pte_swp_uffd_wp(pte))
-		return true;
+		if (pte_swp_uffd_wp(pte))
+			return true;
 
-	if (pte_marker_uffd_wp(pte))
-		return true;
+		if (pte_marker_uffd_wp(pte))
+			return true;
+	} else {
+		return false;
+	}
 #endif
 	return false;
 }
diff --git a/mm/memory.c b/mm/memory.c
index 0ba4f6b71847..4eb05c5f487b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1465,7 +1465,9 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 {
 	bool was_installed = false;
 
-#ifdef CONFIG_PTE_MARKER_UFFD_WP
+	if (!IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP) || !pgtable_uffd_wp_supported())
+		return false;
+
 	/* Zap on anonymous always means dropping everything */
 	if (vma_is_anonymous(vma))
 		return false;
@@ -1482,7 +1484,7 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 		pte++;
 		addr += PAGE_SIZE;
 	}
-#endif
+
 	return was_installed;
 }
 
-- 
2.34.1


