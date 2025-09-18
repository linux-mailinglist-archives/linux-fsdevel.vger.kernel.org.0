Return-Path: <linux-fsdevel+bounces-62077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4249B838E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C905F7AEE78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 08:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170B32F9D92;
	Thu, 18 Sep 2025 08:38:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D2A2E9ED5;
	Thu, 18 Sep 2025 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184714; cv=none; b=na6zS7TjI/UQx1mxRww/9c5SBhBuuCFY7jznkia2UUEgbs5Dtzy6jxwbEeN94hsaz2wxmMHC8Be6mSM7GzE929sjwPFtusFRCMl6CcPBLCkoQucttXfO0pdijFrzXzEgtfjjbwFHyTEXm9dzs8A+PBBlNY+IS4kzxknyQop3MOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184714; c=relaxed/simple;
	bh=0BUoboB5jNdzlvfgucDIWNl8jQZbBqNaph+drDCblGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfsKzh5J655YXNcyr1NI5UXiBkAvL+p7/wDv8tb+Qqo+HmGJ05pTKUInnv7HCKPJZB5pYC8Y2lwi4TfJ7J+c0VTNpMvqenxaYI2mZin8mP22nzX8wCdTUL3rw4SLFlMZdixydX0vnxcI81K2Urmpyn8jdxgI7InMRA7adR/S++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowACnu4XjxMtolHKCAw--.43062S4;
	Thu, 18 Sep 2025 16:38:00 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
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
Subject: [PATCH V14 2/6] mm: userfaultfd: Add pgtable_supports_uffd_wp()
Date: Thu, 18 Sep 2025 16:37:27 +0800
Message-Id: <20250918083731.1820327-3-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918083731.1820327-1-zhangchunyan@iscas.ac.cn>
References: <20250918083731.1820327-1-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnu4XjxMtolHKCAw--.43062S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr1DGFWDXr1kZF4UuFy7trb_yoWftryfpa
	1rGw47Xr4ktFy8Ja97AF48A3s5Zw4SgryDGryF93WkAa13t390vFyFkF4rKr93Jr48Wry7
	tF4UtrZ5ur4jyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPKb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280
	aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mx
	kF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
	MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
	AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
	A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU
	0xZFpf9x07b3xRDUUUUU=
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiDAUJB2jLv34ZFQAAsp

Some platforms can customize the PTE/PMD entry uffd-wp bit making
it unavailable even if the architecture provides the resource.
This patch adds a macro API pgtable_supports_uffd_wp() that allows
architectures to define their specific implementations to check if
the uffd-wp bit is available on which device the kernel is running.

Also this patch is removing "ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP" and
"ifdef CONFIG_PTE_MARKER_UFFD_WP" in favor of pgtable_supports_uffd_wp()
and uffd_supports_wp_marker() checks respectively that default to
IS_ENABLED(CONFIG_HAVE_ARCH_USERFAULTFD_WP) and
"IS_ENABLED(CONFIG_HAVE_ARCH_USERFAULTFD_WP) && IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP)"
if not overridden by the architecture, no change in behavior is expected.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
---
 fs/userfaultfd.c                   |  22 +++---
 include/asm-generic/pgtable_uffd.h |  17 +++++
 include/linux/mm_inline.h          |   8 +-
 include/linux/userfaultfd_k.h      | 114 ++++++++++++++++-------------
 mm/memory.c                        |   6 +-
 5 files changed, 102 insertions(+), 65 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 54c6cc7fe9c6..e41736ffa202 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1270,9 +1270,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MISSING)
 		vm_flags |= VM_UFFD_MISSING;
 	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_WP) {
-#ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
-		goto out;
-#endif
+		if (!pgtable_supports_uffd_wp())
+			goto out;
+
 		vm_flags |= VM_UFFD_WP;
 	}
 	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MINOR) {
@@ -1980,14 +1980,14 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
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
+	if (!pgtable_supports_uffd_wp())
+		uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+
+	if (!uffd_supports_wp_marker()) {
+		uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
+		uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
+		uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
+	}
 
 	ret = -EINVAL;
 	if (features & ~uffdio_api.features)
diff --git a/include/asm-generic/pgtable_uffd.h b/include/asm-generic/pgtable_uffd.h
index 828966d4c281..0d85791efdf7 100644
--- a/include/asm-generic/pgtable_uffd.h
+++ b/include/asm-generic/pgtable_uffd.h
@@ -1,6 +1,23 @@
 #ifndef _ASM_GENERIC_PGTABLE_UFFD_H
 #define _ASM_GENERIC_PGTABLE_UFFD_H
 
+/*
+ * Some platforms can customize the uffd-wp bit, making it unavailable
+ * even if the architecture provides the resource.
+ * Adding this API allows architectures to add their own checks for the
+ * devices on which the kernel is running.
+ * Note: When overriding it, please make sure the
+ * CONFIG_HAVE_ARCH_USERFAULTFD_WP is part of this macro.
+ */
+#ifndef pgtable_supports_uffd_wp
+#define pgtable_supports_uffd_wp()	IS_ENABLED(CONFIG_HAVE_ARCH_USERFAULTFD_WP)
+#endif
+
+static inline bool uffd_supports_wp_marker(void)
+{
+	return pgtable_supports_uffd_wp() && IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP);
+}
+
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static __always_inline int pte_uffd_wp(pte_t pte)
 {
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index d6c1011b38f2..b438715a908e 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -553,7 +553,6 @@ static inline pte_marker copy_pte_marker(
 
 	return dstm;
 }
-#endif
 
 /*
  * If this pte is wr-protected by uffd-wp in any form, arm the special pte to
@@ -571,9 +570,11 @@ static inline bool
 pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 			      pte_t *pte, pte_t pteval)
 {
-#ifdef CONFIG_PTE_MARKER_UFFD_WP
 	bool arm_uffd_pte = false;
 
+	if (!uffd_supports_wp_marker())
+		return false;
+
 	/* The current status of the pte should be "cleared" before calling */
 	WARN_ON_ONCE(!pte_none(ptep_get(pte)));
 
@@ -602,7 +603,7 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 			   make_pte_marker(PTE_MARKER_UFFD_WP));
 		return true;
 	}
-#endif
+
 	return false;
 }
 
@@ -616,5 +617,6 @@ static inline bool vma_has_recency(const struct vm_area_struct *vma)
 
 	return true;
 }
+#endif
 
 #endif
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index c0e716aec26a..f2beb46d87e0 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -228,15 +228,14 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 	if (wp_async && (vm_flags == VM_UFFD_WP))
 		return true;
 
-#ifndef CONFIG_PTE_MARKER_UFFD_WP
 	/*
 	 * If user requested uffd-wp but not enabled pte markers for
 	 * uffd-wp, then shmem & hugetlbfs are not supported but only
 	 * anonymous.
 	 */
-	if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
+	if (!uffd_supports_wp_marker() && (vm_flags & VM_UFFD_WP) &&
+	    !vma_is_anonymous(vma))
 		return false;
-#endif
 
 	/* By default, allow any of anon|shmem|hugetlb */
 	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
@@ -291,6 +290,67 @@ void userfaultfd_release_new(struct userfaultfd_ctx *ctx);
 void userfaultfd_release_all(struct mm_struct *mm,
 			     struct userfaultfd_ctx *ctx);
 
+static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
+{
+	/* Only wr-protect mode uses pte markers */
+	if (!userfaultfd_wp(vma))
+		return false;
+
+	/* File-based uffd-wp always need markers */
+	if (!vma_is_anonymous(vma))
+		return true;
+
+	/*
+	 * Anonymous uffd-wp only needs the markers if WP_UNPOPULATED
+	 * enabled (to apply markers on zero pages).
+	 */
+	return userfaultfd_wp_unpopulated(vma);
+}
+
+static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
+{
+	if (!uffd_supports_wp_marker())
+		return false;
+
+	return is_pte_marker_entry(entry) &&
+	       (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
+}
+
+static inline bool pte_marker_uffd_wp(pte_t pte)
+{
+	swp_entry_t entry;
+
+	if (!uffd_supports_wp_marker())
+		return false;
+
+	if (!is_swap_pte(pte))
+		return false;
+
+	entry = pte_to_swp_entry(pte);
+
+	return pte_marker_entry_uffd_wp(entry);
+}
+
+/*
+ * Returns true if this is a swap pte and was uffd-wp wr-protected in either
+ * forms (pte marker or a normal swap pte), false otherwise.
+ */
+static inline bool pte_swp_uffd_wp_any(pte_t pte)
+{
+	if (!uffd_supports_wp_marker())
+		return false;
+
+	if (!is_swap_pte(pte))
+		return false;
+
+	if (pte_swp_uffd_wp(pte))
+		return true;
+
+	if (pte_marker_uffd_wp(pte))
+		return true;
+
+	return false;
+}
 #else /* CONFIG_USERFAULTFD */
 
 /* mm helpers */
@@ -415,68 +475,24 @@ static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
 	return false;
 }
 
-#endif /* CONFIG_USERFAULTFD */
-
 static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
 {
-	/* Only wr-protect mode uses pte markers */
-	if (!userfaultfd_wp(vma))
-		return false;
-
-	/* File-based uffd-wp always need markers */
-	if (!vma_is_anonymous(vma))
-		return true;
-
-	/*
-	 * Anonymous uffd-wp only needs the markers if WP_UNPOPULATED
-	 * enabled (to apply markers on zero pages).
-	 */
-	return userfaultfd_wp_unpopulated(vma);
+	return false;
 }
 
 static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
 {
-#ifdef CONFIG_PTE_MARKER_UFFD_WP
-	return is_pte_marker_entry(entry) &&
-	    (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
-#else
 	return false;
-#endif
 }
 
 static inline bool pte_marker_uffd_wp(pte_t pte)
 {
-#ifdef CONFIG_PTE_MARKER_UFFD_WP
-	swp_entry_t entry;
-
-	if (!is_swap_pte(pte))
-		return false;
-
-	entry = pte_to_swp_entry(pte);
-
-	return pte_marker_entry_uffd_wp(entry);
-#else
 	return false;
-#endif
 }
 
-/*
- * Returns true if this is a swap pte and was uffd-wp wr-protected in either
- * forms (pte marker or a normal swap pte), false otherwise.
- */
 static inline bool pte_swp_uffd_wp_any(pte_t pte)
 {
-#ifdef CONFIG_PTE_MARKER_UFFD_WP
-	if (!is_swap_pte(pte))
-		return false;
-
-	if (pte_swp_uffd_wp(pte))
-		return true;
-
-	if (pte_marker_uffd_wp(pte))
-		return true;
-#endif
 	return false;
 }
-
+#endif /* CONFIG_USERFAULTFD */
 #endif /* _LINUX_USERFAULTFD_K_H */
diff --git a/mm/memory.c b/mm/memory.c
index 7b875666ff43..4eb4672b1587 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1593,7 +1593,9 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 {
 	bool was_installed = false;
 
-#ifdef CONFIG_PTE_MARKER_UFFD_WP
+	if (!uffd_supports_wp_marker())
+		return false;
+
 	/* Zap on anonymous always means dropping everything */
 	if (vma_is_anonymous(vma))
 		return false;
@@ -1610,7 +1612,7 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 		pte++;
 		addr += PAGE_SIZE;
 	}
-#endif
+
 	return was_installed;
 }
 
-- 
2.34.1


