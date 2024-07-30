Return-Path: <linux-fsdevel+bounces-24581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF9B9409A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 09:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2921C22DFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5370818FDD2;
	Tue, 30 Jul 2024 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHL0szqj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A66E18F2CA;
	Tue, 30 Jul 2024 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324192; cv=none; b=Vc14RansOuL9tjHtWhxts6vh4l9nJE0oZsNRAXXt4+F8c0XjEp8lVzfivexYf6flDGqaB5DWliQRwCkqEer4Wb2obpXpdwD7tuHSSGprslhrRQOROFcTqwmetsXceLDuNjBG4QcTjds3M4uzUg0J7StQkSZq7v3ihF7SaWeAcg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324192; c=relaxed/simple;
	bh=+91Y+/MLNk1WBxXTysrg77L3vkr/WGy2+/WN+U1aHfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7NgAqCdW+xjr9lTpovLN68h/AaP1z7xjRYbvN/p8ILy9OCQ1FlMj+x+WnkaolQJkOns2T+bCp88waXSp0qSFY4Zn1dP/z7aZUloqnSpFUxzMH9ZZr4HWQ9BLDTIr2NLecsl8CP2AjQkM4vDk47k8x1JoHqIcyjUI8Znf0FnHp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHL0szqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21F9C4AF16;
	Tue, 30 Jul 2024 07:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722324192;
	bh=+91Y+/MLNk1WBxXTysrg77L3vkr/WGy2+/WN+U1aHfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HHL0szqjb9e2c7ISow55+gL3zMTJ7Hi70dgqGvtn04IgFlKSoCDbSjvq5pKd3SALU
	 BNdZFk3RcqpWHqICH7MEB7lMmy5GUPrdSGvEDrygCOQcEoLTdfx6YJDQCsmkTky0Ql
	 Dd6ra4zjUVvYJyB9u9IbpBdyrSpsi7fah8Mpxsshed3fhBinvJRbysQV62PvMQ39yN
	 malm4RfG9bAhGyLJJu3pI2OdmRtcqaC1PB2x/qfzEDiHAkmrq0gPhjyLfii9l1DWIZ
	 wHmNuR5GcmhGyMxkdgUgoHi1zrgdIL924cLjlxVp5VoiwZM31oi9eGVEUa4eTSyk8D
	 bxsp/h7xWID4w==
From: alexs@kernel.org
To: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Brian Cain <bcain@quicinc.com>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Lance Yang <ioworker0@gmail.com>,
	Peter Xu <peterx@redhat.com>,
	Barry Song <baohua@kernel.org>,
	linux-s390@vger.kernel.org
Cc: Guo Ren <guoren@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alex Shi <alexs@kernel.org>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	sparclinux@vger.kernel.org,
	Kinsey Ho <kinseyho@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [RFC PATCH 14/18] mm/pgtable: use ptdesc in pgtable_trans_huge_deposit
Date: Tue, 30 Jul 2024 15:27:15 +0800
Message-ID: <20240730072719.3715016-4-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730072719.3715016-1-alexs@kernel.org>
References: <20240730064712.3714387-1-alexs@kernel.org>
 <20240730072719.3715016-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

A step to replace pgtable_t to struct ptdesc.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: linux-mm@kvack.org
Cc: nvdimm@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Barry Song <baohua@kernel.org>
Cc: Lance Yang <ioworker0@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kinsey Ho <kinseyho@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Aneesh Kumar K.V  <aneesh.kumar@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Mike Rapoport  <rppt@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  6 +++---
 arch/powerpc/mm/book3s64/hash_pgtable.c      |  6 +++---
 arch/powerpc/mm/book3s64/radix_pgtable.c     |  6 +++---
 arch/s390/include/asm/pgtable.h              |  2 +-
 arch/s390/mm/pgtable.c                       |  6 +++---
 arch/sparc/include/asm/pgtable_64.h          |  2 +-
 arch/sparc/mm/tlb.c                          |  6 +++---
 fs/dax.c                                     |  2 +-
 include/linux/pgtable.h                      |  2 +-
 mm/debug_vm_pgtable.c                        |  2 +-
 mm/huge_memory.c                             | 14 +++++++-------
 mm/khugepaged.c                              |  2 +-
 mm/memory.c                                  |  2 +-
 mm/pgtable-generic.c                         |  8 ++++----
 14 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 0ee440b819d7..cf44e2440825 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1365,11 +1365,11 @@ pud_t pudp_huge_get_and_clear_full(struct vm_area_struct *vma,
 
 #define __HAVE_ARCH_PGTABLE_DEPOSIT
 static inline void pgtable_trans_huge_deposit(struct mm_struct *mm,
-					      pmd_t *pmdp, pgtable_t pgtable)
+					      pmd_t *pmdp, struct ptdesc *ptdesc)
 {
 	if (radix_enabled())
-		return radix__pgtable_trans_huge_deposit(mm, pmdp, pgtable);
-	return hash__pgtable_trans_huge_deposit(mm, pmdp, pgtable);
+		return radix__pgtable_trans_huge_deposit(mm, pmdp, ptdesc);
+	return hash__pgtable_trans_huge_deposit(mm, pmdp, ptdesc);
 }
 
 #define __HAVE_ARCH_PGTABLE_WITHDRAW
diff --git a/arch/powerpc/mm/book3s64/hash_pgtable.c b/arch/powerpc/mm/book3s64/hash_pgtable.c
index 35562d1f4267..8fd2c833dc3d 100644
--- a/arch/powerpc/mm/book3s64/hash_pgtable.c
+++ b/arch/powerpc/mm/book3s64/hash_pgtable.c
@@ -265,16 +265,16 @@ pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addres
  * the base page size hptes
  */
 void hash__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				  pgtable_t pgtable)
+				      struct ptdesc *ptdesc)
 {
-	pgtable_t *pgtable_slot;
+	pte_t **pgtable_slot;
 
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 	/*
 	 * we store the pgtable in the second half of PMD
 	 */
 	pgtable_slot = (pgtable_t *)pmdp + PTRS_PER_PMD;
-	*pgtable_slot = pgtable;
+	*pgtable_slot = (pte_t)ptdesc;
 	/*
 	 * expose the deposited pgtable to other cpus.
 	 * before we set the hugepage PTE at pmd level
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 3b9bb19510e3..c33e860966ad 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1478,9 +1478,9 @@ pmd_t radix__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addre
  * list_head memory area.
  */
 void radix__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				 pgtable_t pgtable)
+				       struct ptdesc *ptdesc)
 {
-	struct list_head *lh = (struct list_head *) pgtable;
+	struct list_head *lh = (struct list_head *)ptdesc;
 
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 
@@ -1489,7 +1489,7 @@ void radix__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 		INIT_LIST_HEAD(lh);
 	else
 		list_add(lh, (struct list_head *) pmd_huge_pte(mm, pmdp));
-	pmd_huge_pte(mm, pmdp) = pgtable;
+	pmd_huge_pte(mm, pmdp) = ptdesc_page(ptdesc);
 }
 
 struct ptdesc *radix__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index cf0baf4bfe5c..d7b635f5e1e7 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1735,7 +1735,7 @@ pud_t pudp_xchg_direct(struct mm_struct *, unsigned long, pud_t *, pud_t);
 
 #define __HAVE_ARCH_PGTABLE_DEPOSIT
 void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				pgtable_t pgtable);
+				struct ptdesc *ptdesc);
 
 #define __HAVE_ARCH_PGTABLE_WITHDRAW
 struct ptdesc *pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index b9016ee145cb..cf1a6aeb66d4 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -563,9 +563,9 @@ EXPORT_SYMBOL(pudp_xchg_direct);
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				pgtable_t pgtable)
+				struct ptdesc *ptdesc)
 {
-	struct list_head *lh = (struct list_head *) pgtable;
+	struct list_head *lh = (struct list_head *)ptdesc;
 
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 
@@ -574,7 +574,7 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 		INIT_LIST_HEAD(lh);
 	else
 		list_add(lh, (struct list_head *) pmd_huge_pte(mm, pmdp));
-	pmd_huge_pte(mm, pmdp) = (struct ptdesc *)pgtable;
+	pmd_huge_pte(mm, pmdp) = ptdesc;
 }
 
 struct ptdesc *pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index bfefd678e220..c71be5ef8b06 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -995,7 +995,7 @@ extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 
 #define __HAVE_ARCH_PGTABLE_DEPOSIT
 void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				pgtable_t pgtable);
+				struct ptdesc *ptdesc);
 
 #define __HAVE_ARCH_PGTABLE_WITHDRAW
 struct ptdesc *pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index bd2d3b1f6ba3..eeed4427f524 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -267,9 +267,9 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 }
 
 void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				pgtable_t pgtable)
+				struct ptdesc *ptdesc)
 {
-	struct list_head *lh = (struct list_head *) pgtable;
+	struct list_head *lh = (struct list_head *)ptdesc;
 
 	assert_spin_locked(&mm->page_table_lock);
 
@@ -278,7 +278,7 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 		INIT_LIST_HEAD(lh);
 	else
 		list_add(lh, (struct list_head *) pmd_huge_pte(mm, pmdp));
-	pmd_huge_pte(mm, pmdp) = (struct ptdesc *)pgtable;
+	pmd_huge_pte(mm, pmdp) = ptdesc;
 }
 
 struct ptdesc *pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
diff --git a/fs/dax.c b/fs/dax.c
index 61b9bd5200da..4b4e6acb0efc 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1234,7 +1234,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	}
 
 	if (ptdesc) {
-		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, ptdesc_page(ptdesc));
+		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, ptdesc);
 		mm_inc_nr_ptes(vma->vm_mm);
 	}
 	pmd_entry = mk_pmd(&zero_folio->page, vmf->vma->vm_page_prot);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 3fa7b93580a3..9d256c548f5e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -925,7 +925,7 @@ static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 
 #ifndef __HAVE_ARCH_PGTABLE_DEPOSIT
 extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				       pgtable_t pgtable);
+				       struct ptdesc *ptdesc);
 #endif
 
 #ifndef __HAVE_ARCH_PGTABLE_WITHDRAW
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index f256bc816744..8550eec32aba 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -225,7 +225,7 @@ static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
 	/* Align the address wrt HPAGE_PMD_SIZE */
 	vaddr &= HPAGE_PMD_MASK;
 
-	pgtable_trans_huge_deposit(args->mm, args->pmdp, args->start_ptep);
+	pgtable_trans_huge_deposit(args->mm, args->pmdp, page_ptdesc(args->start_ptep));
 
 	pmd = pfn_pmd(args->pmd_pfn, args->page_prot);
 	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4dc36910c8aa..aac67e8a8cc8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -997,7 +997,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 		folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, vma);
-		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, ptdesc_page(ptdesc));
+		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, ptdesc);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
@@ -1064,7 +1064,7 @@ static void set_huge_zero_folio(struct ptdesc *ptdesc, struct mm_struct *mm,
 		return;
 	entry = mk_pmd(&zero_folio->page, vma->vm_page_prot);
 	entry = pmd_mkhuge(entry);
-	pgtable_trans_huge_deposit(mm, pmd, ptdesc_page(ptdesc));
+	pgtable_trans_huge_deposit(mm, pmd, ptdesc);
 	set_pmd_at(mm, haddr, pmd, entry);
 	mm_inc_nr_ptes(mm);
 }
@@ -1167,7 +1167,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	if (ptdesc) {
-		pgtable_trans_huge_deposit(mm, pmd, ptdesc_page(ptdesc));
+		pgtable_trans_huge_deposit(mm, pmd, ptdesc);
 		mm_inc_nr_ptes(mm);
 		ptdesc = NULL;
 	}
@@ -1404,7 +1404,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		}
 		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
 		mm_inc_nr_ptes(dst_mm);
-		pgtable_trans_huge_deposit(dst_mm, dst_pmd, ptdesc_page(ptdesc));
+		pgtable_trans_huge_deposit(dst_mm, dst_pmd, ptdesc);
 		if (!userfaultfd_wp(dst_vma))
 			pmd = pmd_swp_clear_uffd_wp(pmd);
 		set_pmd_at(dst_mm, addr, dst_pmd, pmd);
@@ -1449,7 +1449,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
 out_zero_page:
 	mm_inc_nr_ptes(dst_mm);
-	pgtable_trans_huge_deposit(dst_mm, dst_pmd, ptdesc_page(ptdesc));
+	pgtable_trans_huge_deposit(dst_mm, dst_pmd, ptdesc);
 	pmdp_set_wrprotect(src_mm, addr, src_pmd);
 	if (!userfaultfd_wp(dst_vma))
 		pmd = pmd_clear_uffd_wp(pmd);
@@ -1962,7 +1962,7 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 			struct ptdesc *ptdesc;
 
 			ptdesc = pgtable_trans_huge_withdraw(mm, old_pmd);
-			pgtable_trans_huge_deposit(mm, new_pmd, ptdesc_page(ptdesc));
+			pgtable_trans_huge_deposit(mm, new_pmd, ptdesc);
 		}
 		pmd = move_soft_dirty_pmd(pmd);
 		set_pmd_at(mm, new_addr, new_pmd, pmd);
@@ -2236,7 +2236,7 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 	set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
 
 	src_ptdesc = pgtable_trans_huge_withdraw(mm, src_pmd);
-	pgtable_trans_huge_deposit(mm, dst_pmd, ptdesc_page(src_ptdesc));
+	pgtable_trans_huge_deposit(mm, dst_pmd, src_ptdesc);
 unlock_ptls:
 	double_pt_unlock(src_ptl, dst_ptl);
 	if (src_anon_vma) {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f3b3db104615..48a54269472e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1232,7 +1232,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	BUG_ON(!pmd_none(*pmd));
 	folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
 	folio_add_lru_vma(folio, vma);
-	pgtable_trans_huge_deposit(mm, pmd, pgtable);
+	pgtable_trans_huge_deposit(mm, pmd, page_ptdesc(pgtable));
 	set_pmd_at(mm, address, pmd, _pmd);
 	update_mmu_cache_pmd(vma, address, pmd);
 	spin_unlock(pmd_ptl);
diff --git a/mm/memory.c b/mm/memory.c
index 27c2f63b7487..956cfe5f644d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4687,7 +4687,7 @@ static void deposit_prealloc_pte(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
-	pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, vmf->prealloc_pte);
+	pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, page_ptdesc(vmf->prealloc_pte));
 	/*
 	 * We are going to consume the prealloc table,
 	 * count that as nr_ptes.
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index de1ed30fea16..5e763682941d 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -163,16 +163,16 @@ pud_t pudp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 
 #ifndef __HAVE_ARCH_PGTABLE_DEPOSIT
 void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				pgtable_t pgtable)
+				struct ptdesc *ptdesc)
 {
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 
 	/* FIFO */
 	if (!pmd_huge_pte(mm, pmdp))
-		INIT_LIST_HEAD(&pgtable->lru);
+		INIT_LIST_HEAD(&ptdesc->pt_list);
 	else
-		list_add(&pgtable->lru, &pmd_huge_pte(mm, pmdp)->pt_list);
-	pmd_huge_pte(mm, pmdp) = page_ptdesc(pgtable);
+		list_add(&ptdesc->pt_list, &pmd_huge_pte(mm, pmdp)->pt_list);
+	pmd_huge_pte(mm, pmdp) = ptdesc;
 }
 #endif
 
-- 
2.43.0


