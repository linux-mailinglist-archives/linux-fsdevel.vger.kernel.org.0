Return-Path: <linux-fsdevel+bounces-24582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58879409B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 09:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1328B1C22826
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F70E190676;
	Tue, 30 Jul 2024 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VS2i0h4S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E787418EFED;
	Tue, 30 Jul 2024 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324224; cv=none; b=BXROWGHAhVbROJel9ppvCkQSyMotaO2Z4LAPZpYg99ZEKBugjpS7/mxkO+MjZJgTp3xjQbhfHKEx45spqEm2FVxftp1dImoVjFKjXj+TM6HEg9xyCE+1msh3mFfME4MUlhIAaTncb4Ez+7+41I4un7w+X3AiLgNOA0qA3HPsxjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324224; c=relaxed/simple;
	bh=MBumahwIovMrLM2xijUGbqbzC8eqefcbVCDPjO9VQdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjAKY8i79sf0En+WJMeDjQibaIR9e5LyqrADt9JJQS47JUkvXwrO02oX7r2OiE/6LCsfQQKRU2PN7+kM9f/L5sunGq15WQm1kxfY6rUjbKMsuP/3xFmS3bR/e5DmXSZSBN9+XDbPu99jh6+y0kaqaQB9Lwn130dsj6vuqsMTZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VS2i0h4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8986AC32782;
	Tue, 30 Jul 2024 07:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722324223;
	bh=MBumahwIovMrLM2xijUGbqbzC8eqefcbVCDPjO9VQdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VS2i0h4StkfC64c/JDyScKsNP0M1q1w3AGB7FpchDWYE3z1M10NJVKgdKsS8NCbiy
	 d2uHvMiSRGm1FVHaBK8eFwUvEtY7QsciTEUxncVwivItvrAAyaZKX/UrzKXDsx80fB
	 hdVzmcvfXZq0cq838KL/IIOuw5o6htAm35hjuefbFnaeXbpXlVepWunB9D2y1XoH/P
	 DOr/E3Jc/8HLWb1qhmvVZLFWhR2A9Ugp62gjlZlG+ibYdl1NrFjQKylKux8BJ7W6+i
	 nRKNxS68jjsmSHjYUvwPjztBhfwuSyjjuZuFnGp5UzkRLxjYlH9kVNt7n3/xt5EXtO
	 i4Za4M6sm1W+Q==
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
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH 16/18] mm/pgtable: pass ptdesc to pmd_install
Date: Tue, 30 Jul 2024 15:27:17 +0800
Message-ID: <20240730072719.3715016-6-alexs@kernel.org>
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

A new step to replace pgtable_t by ptdesc, also a preparation to change
vmf.prealloc_pte to ptdesc too.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox  <willy@infradead.org>
---
 mm/filemap.c  | 2 +-
 mm/internal.h | 2 +-
 mm/memory.c   | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..3708ef71182e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3453,7 +3453,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct folio *folio,
 	}
 
 	if (pmd_none(*vmf->pmd) && vmf->prealloc_pte)
-		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
+		pmd_install(mm, vmf->pmd, (struct ptdesc **)&vmf->prealloc_pte);
 
 	return false;
 }
diff --git a/mm/internal.h b/mm/internal.h
index 7a3bcc6d95e7..e4bc64d5176a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -320,7 +320,7 @@ void folio_activate(struct folio *folio);
 void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *start_vma, unsigned long floor,
 		   unsigned long ceiling, bool mm_wr_locked);
-void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
+void pmd_install(struct mm_struct *mm, pmd_t *pmd, struct ptdesc **pte);
 
 struct zap_details;
 void unmap_page_range(struct mmu_gather *tlb,
diff --git a/mm/memory.c b/mm/memory.c
index cbed8824059f..79685600d23f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -418,7 +418,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 	} while (vma);
 }
 
-void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
+void pmd_install(struct mm_struct *mm, pmd_t *pmd, struct ptdesc **pte)
 {
 	spinlock_t *ptl = pmd_lock(mm, pmd);
 
@@ -438,7 +438,7 @@ void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
 		 * smp_rmb() barriers in page table walking code.
 		 */
 		smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
-		pmd_populate(mm, pmd, (struct ptdesc *)(*pte));
+		pmd_populate(mm, pmd, *pte);
 		*pte = NULL;
 	}
 	spin_unlock(ptl);
@@ -450,7 +450,7 @@ int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
 	if (!ptdesc)
 		return -ENOMEM;
 
-	pmd_install(mm, pmd, (pgtable_t *)&ptdesc);
+	pmd_install(mm, pmd, &ptdesc);
 	if (ptdesc)
 		pte_free(mm, ptdesc);
 	return 0;
@@ -4868,7 +4868,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		}
 
 		if (vmf->prealloc_pte)
-			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
+			pmd_install(vma->vm_mm, vmf->pmd, (struct ptdesc **)&vmf->prealloc_pte);
 		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
 			return VM_FAULT_OOM;
 	}
-- 
2.43.0


