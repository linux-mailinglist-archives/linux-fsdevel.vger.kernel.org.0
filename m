Return-Path: <linux-fsdevel+bounces-24577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9B89408CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 08:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C0D284FBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 06:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07429190074;
	Tue, 30 Jul 2024 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU5gA41f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4630818E741;
	Tue, 30 Jul 2024 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321892; cv=none; b=MXKvlZeeJma8SVQjQgPJWjYbrpPaZ4v6MvBhrTxQou0I+3KdJ1ib8Q+cerQ9toIDxddc+IZh1vozsJCdVZZQVq65t7qbItZ3Va7Z5/Nw55r2QIhB/nGRHhrYreFokfsVhyv1LOo4U5WbLoGrlL/fbx1fQRXykYdng+Fm/qm/h9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321892; c=relaxed/simple;
	bh=DVj1dF/3LIG4QvumgddsFqj1lx0SQkF4MqPzNl7vGkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLBxRjRRSIabzDQiJmMVTg2NAiv0bF7pCb+bX6SQyYFW1bk6YTPUNBxuTtupCJeDelHkPz/0fNjwOpMUsqKsNoBmUcbVrwlbc36ny7p1WzHsGb2GoNtjLKtxXnCkt4jaTvIjBU2/83OHev3KjaMTa0IkRG0txp0NfvUXWJZo5kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU5gA41f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03182C32782;
	Tue, 30 Jul 2024 06:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722321891;
	bh=DVj1dF/3LIG4QvumgddsFqj1lx0SQkF4MqPzNl7vGkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XU5gA41fGeeGuG84jrc0u9UbdT/1OsrKiK6gQ3j2Dsfzspr/VFoGGY+9jRktUTxPK
	 eCGcueThv1EkrEWTBCdEOfYYfg98cNkh9aL9IF5PQmYQLJsXHenG6BTEDfpnx4HRTt
	 TG8HbzuCVQ0Yi4yCrfqsrt0bVyQPCbBoH3u3b1xRrZCKzGXrJd+WVkan/f/ggLnn2L
	 OAxW9p4eTi5ixJZtACGTpHef4YO3O2bTkOma9P1V+YtTDRQRofXG8ycaO2YYLPUoLA
	 G8KSSn7XyBfjWFhT9lu+2dLE6tceUhkIIcFz3EtYj5naYaEqlGB/vOaIaJXYdxgv9q
	 dGnAH3je2sPvA==
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
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	sparclinux@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Chris Zankel <chris@zankel.net>,
	"David S . Miller" <davem@davemloft.net>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [RFC PATCH 09/18] mm/pgtable: fully use ptdesc in pte_alloc_one series functions
Date: Tue, 30 Jul 2024 14:47:03 +0800
Message-ID: <20240730064712.3714387-10-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730064712.3714387-1-alexs@kernel.org>
References: <20240730064712.3714387-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Replace pgtable_t and struct page by ptdesc in pte_alloc_one series
functions.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: nvdimm@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Dawei Li <dawei.li@shingroup.cn>
Cc: Vishal Moola  <vishal.moola@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Breno Leitao <leitao@debian.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mike Rapoport  <rppt@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
---
 arch/arm/include/asm/pgalloc.h      |  9 ++++-----
 arch/powerpc/include/asm/pgalloc.h  |  4 ++--
 arch/s390/include/asm/pgalloc.h     |  2 +-
 arch/sparc/include/asm/pgalloc_32.h |  2 +-
 arch/sparc/include/asm/pgalloc_64.h |  2 +-
 arch/sparc/mm/init_64.c             |  2 +-
 arch/sparc/mm/srmmu.c               |  4 ++--
 arch/x86/include/asm/pgalloc.h      |  2 +-
 arch/x86/mm/pgtable.c               |  2 +-
 arch/xtensa/include/asm/pgalloc.h   | 12 ++++++------
 fs/dax.c                            |  2 +-
 include/asm-generic/pgalloc.h       |  6 +++---
 mm/huge_memory.c                    |  8 ++++----
 mm/memory.c                         |  8 ++++----
 14 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index a17f01235c29..e8501a6c3336 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -91,16 +91,15 @@ pte_alloc_one_kernel(struct mm_struct *mm)
 #define PGTABLE_HIGHMEM 0
 #endif
 
-static inline pgtable_t
-pte_alloc_one(struct mm_struct *mm)
+static inline struct ptdesc *pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *pte;
+	struct ptdesc *pte;
 
 	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM);
 	if (!pte)
 		return NULL;
-	if (!PageHighMem(pte))
-		clean_pte_table(page_address(pte));
+	if (!PageHighMem(ptdesc_page(pte)))
+		clean_pte_table(ptdesc_address(pte));
 	return pte;
 }
 
diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index 3a971e2a8c73..37512f344b37 100644
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -27,9 +27,9 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 	return (pte_t *)pte_fragment_alloc(mm, 1);
 }
 
-static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
+static inline struct ptdesc *pte_alloc_one(struct mm_struct *mm)
 {
-	return (pgtable_t)pte_fragment_alloc(mm, 0);
+	return (struct ptdesc *)pte_fragment_alloc(mm, 0);
 }
 
 void pte_frag_destroy(void *pte_frag);
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 7b84ef6dc4b6..771494526f6e 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -137,7 +137,7 @@ static inline void pmd_populate(struct mm_struct *mm,
  * page table entry allocation/free routines.
  */
 #define pte_alloc_one_kernel(mm) ((pte_t *)page_table_alloc(mm))
-#define pte_alloc_one(mm) ((pte_t *)page_table_alloc(mm))
+#define pte_alloc_one(mm) ((struct ptdesc *)page_table_alloc(mm))
 
 #define pte_free_kernel(mm, pte) page_table_free(mm, (unsigned long *) pte)
 #define pte_free(mm, pte) page_table_free(mm, (unsigned long *) pte)
diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
index 4f73e87b22a3..bc3ef54d9564 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -55,7 +55,7 @@ static inline void free_pmd_fast(pmd_t * pmd)
 void pmd_set(pmd_t *pmdp, pte_t *ptep);
 #define pmd_populate_kernel		pmd_populate
 
-pgtable_t pte_alloc_one(struct mm_struct *mm);
+struct ptdesc *pte_alloc_one(struct mm_struct *mm);
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
diff --git a/arch/sparc/include/asm/pgalloc_64.h b/arch/sparc/include/asm/pgalloc_64.h
index caa7632be4c2..285aa7958912 100644
--- a/arch/sparc/include/asm/pgalloc_64.h
+++ b/arch/sparc/include/asm/pgalloc_64.h
@@ -61,7 +61,7 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 }
 
 pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
-pgtable_t pte_alloc_one(struct mm_struct *mm);
+struct ptdesc *pte_alloc_one(struct mm_struct *mm);
 void pte_free_kernel(struct mm_struct *mm, pte_t *pte);
 void pte_free(struct mm_struct *mm, pgtable_t ptepage);
 
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 53d7cb5bbffe..e1b33f996469 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2900,7 +2900,7 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 	return pte;
 }
 
-pgtable_t pte_alloc_one(struct mm_struct *mm)
+struct ptdesc *pte_alloc_one(struct mm_struct *mm)
 {
 	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL | __GFP_ZERO, 0);
 
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 9df51a62333d..60bb8628bb1f 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -346,7 +346,7 @@ pgd_t *get_pgd_fast(void)
  * Alignments up to the page size are the same for physical and virtual
  * addresses of the nocache area.
  */
-pgtable_t pte_alloc_one(struct mm_struct *mm)
+struct ptdesc *pte_alloc_one(struct mm_struct *mm)
 {
 	pte_t *ptep;
 	struct page *page;
@@ -362,7 +362,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 	}
 	spin_unlock(&mm->page_table_lock);
 
-	return ptep;
+	return (struct ptdesc *)ptep;
 }
 
 void pte_free(struct mm_struct *mm, pgtable_t ptep)
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index dcd836b59beb..497c757b5b98 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -51,7 +51,7 @@ extern gfp_t __userpte_alloc_gfp;
 extern pgd_t *pgd_alloc(struct mm_struct *);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 
-extern pgtable_t pte_alloc_one(struct mm_struct *);
+extern struct ptdesc *pte_alloc_one(struct mm_struct *);
 
 extern void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte);
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 93e54ba91fbf..c27d15cd01b9 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -28,7 +28,7 @@ void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
 
 gfp_t __userpte_alloc_gfp = GFP_PGTABLE_USER | PGTABLE_HIGHMEM;
 
-pgtable_t pte_alloc_one(struct mm_struct *mm)
+struct ptdesc *pte_alloc_one(struct mm_struct *mm)
 {
 	return __pte_alloc_one(mm, __userpte_alloc_gfp);
 }
diff --git a/arch/xtensa/include/asm/pgalloc.h b/arch/xtensa/include/asm/pgalloc.h
index 7fc0f9126dd3..a9206c02956e 100644
--- a/arch/xtensa/include/asm/pgalloc.h
+++ b/arch/xtensa/include/asm/pgalloc.h
@@ -51,15 +51,15 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 	return ptep;
 }
 
-static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
+static inline struct ptdesc *pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 
-	page = __pte_alloc_one(mm, GFP_PGTABLE_USER);
-	if (!page)
+	ptdesc = __pte_alloc_one(mm, GFP_PGTABLE_USER);
+	if (!ptdesc)
 		return NULL;
-	ptes_clear(page_address(page));
-	return page;
+	ptes_clear(ptdesc_address(ptdesc));
+	return ptdesc;
 }
 
 #endif /* CONFIG_MMU */
diff --git a/fs/dax.c b/fs/dax.c
index 6f7cea248206..51cbc08b22e7 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1222,7 +1222,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 				  DAX_PMD | DAX_ZERO_PAGE);
 
 	if (arch_needs_pgtable_deposit()) {
-		ptdesc = page_ptdesc(pte_alloc_one(vma->vm_mm));
+		ptdesc = pte_alloc_one(vma->vm_mm);
 		if (!ptdesc)
 			return VM_FAULT_OOM;
 	}
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 7c48f5fbf8aa..1a4070f8d5dd 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -63,7 +63,7 @@ static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
  *
  * Return: `struct page` referencing the ptdesc or %NULL on error
  */
-static inline pgtable_t __pte_alloc_one_noprof(struct mm_struct *mm, gfp_t gfp)
+static inline struct ptdesc *__pte_alloc_one_noprof(struct mm_struct *mm, gfp_t gfp)
 {
 	struct ptdesc *ptdesc;
 
@@ -75,7 +75,7 @@ static inline pgtable_t __pte_alloc_one_noprof(struct mm_struct *mm, gfp_t gfp)
 		return NULL;
 	}
 
-	return ptdesc_page(ptdesc);
+	return ptdesc;
 }
 #define __pte_alloc_one(...)	alloc_hooks(__pte_alloc_one_noprof(__VA_ARGS__))
 
@@ -88,7 +88,7 @@ static inline pgtable_t __pte_alloc_one_noprof(struct mm_struct *mm, gfp_t gfp)
  *
  * Return: `struct page` referencing the ptdesc or %NULL on error
  */
-static inline pgtable_t pte_alloc_one_noprof(struct mm_struct *mm)
+static inline struct ptdesc *pte_alloc_one_noprof(struct mm_struct *mm)
 {
 	return __pte_alloc_one_noprof(mm, GFP_PGTABLE_USER);
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 236e1582d97e..6274eb7559ac 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -959,7 +959,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 	}
 	folio_throttle_swaprate(folio, gfp);
 
-	ptdesc = page_ptdesc(pte_alloc_one(vma->vm_mm));
+	ptdesc = pte_alloc_one(vma->vm_mm);
 	if (unlikely(!ptdesc)) {
 		ret = VM_FAULT_OOM;
 		goto release;
@@ -1091,7 +1091,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 		struct folio *zero_folio;
 		vm_fault_t ret;
 
-		ptdesc = page_ptdesc(pte_alloc_one(vma->vm_mm));
+		ptdesc = pte_alloc_one(vma->vm_mm);
 		if (unlikely(!ptdesc))
 			return VM_FAULT_OOM;
 		zero_folio = mm_get_huge_zero_folio(vma->vm_mm);
@@ -1213,7 +1213,7 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 		return VM_FAULT_SIGBUS;
 
 	if (arch_needs_pgtable_deposit()) {
-		ptdesc = page_ptdesc(pte_alloc_one(vma->vm_mm));
+		ptdesc = pte_alloc_one(vma->vm_mm);
 		if (!ptdesc)
 			return VM_FAULT_OOM;
 	}
@@ -1376,7 +1376,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	if (!vma_is_anonymous(dst_vma))
 		return 0;
 
-	ptdesc = page_ptdesc(pte_alloc_one(dst_mm));
+	ptdesc = pte_alloc_one(dst_mm);
 	if (unlikely(!ptdesc))
 		goto out;
 
diff --git a/mm/memory.c b/mm/memory.c
index 5b01d94a0b5f..37529e0a9ce2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -445,7 +445,7 @@ void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
 
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
 {
-	struct ptdesc *ptdesc = page_ptdesc(pte_alloc_one(mm));
+	struct ptdesc *ptdesc = pte_alloc_one(mm);
 	if (!ptdesc)
 		return -ENOMEM;
 
@@ -4647,7 +4647,7 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 	 *				# flush A, B to clear the writeback
 	 */
 	if (pmd_none(*vmf->pmd) && !vmf->prealloc_pte) {
-		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
+		vmf->prealloc_pte = ptdesc_page(pte_alloc_one(vma->vm_mm));
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
 	}
@@ -4725,7 +4725,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	 * related to pte entry. Use the preallocated table for that.
 	 */
 	if (arch_needs_pgtable_deposit() && !vmf->prealloc_pte) {
-		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
+		vmf->prealloc_pte = ptdesc_page(pte_alloc_one(vma->vm_mm));
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
 	}
@@ -5010,7 +5010,7 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 		      pte_off + vma_pages(vmf->vma) - vma_off) - 1;
 
 	if (pmd_none(*vmf->pmd)) {
-		vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm_mm);
+		vmf->prealloc_pte = ptdesc_page(pte_alloc_one(vmf->vma->vm_mm));
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
 	}
-- 
2.43.0


