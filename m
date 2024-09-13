Return-Path: <linux-fsdevel+bounces-29290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E029F977B7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 10:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E3728A85C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 08:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D36E1D7E30;
	Fri, 13 Sep 2024 08:44:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9C11D6DB4;
	Fri, 13 Sep 2024 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217096; cv=none; b=qfRgOxt1xbvBcAEg2s37ZHgDS1wSuIto325A9atNeB7ZwTqT5wZ6nRU6hv+5m5N5LUFIjI+Kuk7ywuxg2WmuxpAQ+cljbMRSwbw3EDDXHTHqIJHeZwIpk0PAgOhQN5ZMpdgkZbXXYSOG6S9OJVSDogIp1jBzLicRN90EzhSAbyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217096; c=relaxed/simple;
	bh=R70eryLf1TUoD8re4x1PRoP7RMn72AEMvdnymyac7CQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WnzO5JrdpyZyBDa0co2nz+Q05U3VhBwo1ahuau8p6HpeVRLXVmkMepwzD874vlQfX7hFrWPfBmF2aUL0VRew7iP/LvLc9vB/tRtOPluWVxAKwtKowCj+rRGL3YgYcWJx4HOtErC2m9NipK+KUb1t2XSB7z/vKdO/Z8Z00mIvuhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F22991477;
	Fri, 13 Sep 2024 01:45:23 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA6A33F73B;
	Fri, 13 Sep 2024 01:44:49 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	x86@kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-fsdevel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 2/7] x86/mm: Drop page table entry address output from pxd_ERROR()
Date: Fri, 13 Sep 2024 14:14:28 +0530
Message-Id: <20240913084433.1016256-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913084433.1016256-1-anshuman.khandual@arm.com>
References: <20240913084433.1016256-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This drops page table entry address output from all pxd_ERROR() definitions
which now matches with other architectures. This also prevents build issues
while transitioning into pxdp_get() based page table entry accesses.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/x86/include/asm/pgtable-3level.h | 12 ++++++------
 arch/x86/include/asm/pgtable_64.h     | 20 ++++++++++----------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index dabafba957ea..e1fa4dd87753 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -10,14 +10,14 @@
  */
 
 #define pte_ERROR(e)							\
-	pr_err("%s:%d: bad pte %p(%08lx%08lx)\n",			\
-	       __FILE__, __LINE__, &(e), (e).pte_high, (e).pte_low)
+	pr_err("%s:%d: bad pte (%08lx%08lx)\n",			\
+	       __FILE__, __LINE__, (e).pte_high, (e).pte_low)
 #define pmd_ERROR(e)							\
-	pr_err("%s:%d: bad pmd %p(%016Lx)\n",				\
-	       __FILE__, __LINE__, &(e), pmd_val(e))
+	pr_err("%s:%d: bad pmd (%016Lx)\n",				\
+	       __FILE__, __LINE__, pmd_val(e))
 #define pgd_ERROR(e)							\
-	pr_err("%s:%d: bad pgd %p(%016Lx)\n",				\
-	       __FILE__, __LINE__, &(e), pgd_val(e))
+	pr_err("%s:%d: bad pgd (%016Lx)\n",				\
+	       __FILE__, __LINE__, pgd_val(e))
 
 #define pxx_xchg64(_pxx, _ptr, _val) ({					\
 	_pxx##val_t *_p = (_pxx##val_t *)_ptr;				\
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 3c4407271d08..4e462c825cab 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -32,24 +32,24 @@ extern void paging_init(void);
 static inline void sync_initial_page_table(void) { }
 
 #define pte_ERROR(e)					\
-	pr_err("%s:%d: bad pte %p(%016lx)\n",		\
-	       __FILE__, __LINE__, &(e), pte_val(e))
+	pr_err("%s:%d: bad pte (%016lx)\n",		\
+	       __FILE__, __LINE__, pte_val(e))
 #define pmd_ERROR(e)					\
-	pr_err("%s:%d: bad pmd %p(%016lx)\n",		\
-	       __FILE__, __LINE__, &(e), pmd_val(e))
+	pr_err("%s:%d: bad pmd (%016lx)\n",		\
+	       __FILE__, __LINE__, pmd_val(e))
 #define pud_ERROR(e)					\
-	pr_err("%s:%d: bad pud %p(%016lx)\n",		\
-	       __FILE__, __LINE__, &(e), pud_val(e))
+	pr_err("%s:%d: bad pud (%016lx)\n",		\
+	       __FILE__, __LINE__, pud_val(e))
 
 #if CONFIG_PGTABLE_LEVELS >= 5
 #define p4d_ERROR(e)					\
-	pr_err("%s:%d: bad p4d %p(%016lx)\n",		\
-	       __FILE__, __LINE__, &(e), p4d_val(e))
+	pr_err("%s:%d: bad p4d (%016lx)\n",		\
+	       __FILE__, __LINE__, p4d_val(e))
 #endif
 
 #define pgd_ERROR(e)					\
-	pr_err("%s:%d: bad pgd %p(%016lx)\n",		\
-	       __FILE__, __LINE__, &(e), pgd_val(e))
+	pr_err("%s:%d: bad pgd (%016lx)\n",		\
+	       __FILE__, __LINE__, pgd_val(e))
 
 struct mm_struct;
 
-- 
2.25.1


