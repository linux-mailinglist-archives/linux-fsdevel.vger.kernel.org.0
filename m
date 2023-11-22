Return-Path: <linux-fsdevel+bounces-3358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95537F4181
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 10:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17EB61C208C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD26922EE8;
	Wed, 22 Nov 2023 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBE6FF4;
	Wed, 22 Nov 2023 01:22:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42BE01595;
	Wed, 22 Nov 2023 01:23:32 -0800 (PST)
Received: from arm.com (e121798.cambridge.arm.com [10.1.197.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C2073F73F;
	Wed, 22 Nov 2023 01:22:41 -0800 (PST)
Date: Wed, 22 Nov 2023 09:22:38 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Peter Collingbourne <pcc@google.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, steven.price@arm.com,
	anshuman.khandual@arm.com, vincenzo.frascino@arm.com,
	david@redhat.com, eugenis@google.com, kcc@google.com,
	hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 20/27] mm: hugepage: Handle huge page fault on
 access
Message-ID: <ZV3IXlxKcyOphMgb@arm.com>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-21-alexandru.elisei@arm.com>
 <CAMn1gO7_UG-T9Vf_7oVOhLD1DFVPc1ceSxdJFsFqkem_vCopog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMn1gO7_UG-T9Vf_7oVOhLD1DFVPc1ceSxdJFsFqkem_vCopog@mail.gmail.com>

Hi Peter,

On Tue, Nov 21, 2023 at 05:28:49PM -0800, Peter Collingbourne wrote:
> On Sun, Nov 19, 2023 at 8:59 AM Alexandru Elisei
> <alexandru.elisei@arm.com> wrote:
> >
> > Handle PAGE_FAULT_ON_ACCESS faults for huge pages in a similar way to
> > regular pages.
> >
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >  arch/arm64/include/asm/mte_tag_storage.h |  1 +
> >  arch/arm64/include/asm/pgtable.h         |  7 ++
> >  arch/arm64/mm/fault.c                    | 81 ++++++++++++++++++++++++
> >  include/linux/huge_mm.h                  |  2 +
> >  include/linux/pgtable.h                  |  5 ++
> >  mm/huge_memory.c                         |  4 +-
> >  mm/memory.c                              |  3 +
> >  7 files changed, 101 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
> > index c70ced60a0cd..b97406d369ce 100644
> > --- a/arch/arm64/include/asm/mte_tag_storage.h
> > +++ b/arch/arm64/include/asm/mte_tag_storage.h
> > @@ -35,6 +35,7 @@ void free_tag_storage(struct page *page, int order);
> >  bool page_tag_storage_reserved(struct page *page);
> >
> >  vm_fault_t handle_page_missing_tag_storage(struct vm_fault *vmf);
> > +vm_fault_t handle_huge_page_missing_tag_storage(struct vm_fault *vmf);
> >  #else
> >  static inline bool tag_storage_enabled(void)
> >  {
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index 8cc135f1c112..1704411c096d 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -477,6 +477,13 @@ static inline vm_fault_t arch_do_page_fault_on_access(struct vm_fault *vmf)
> >                 return handle_page_missing_tag_storage(vmf);
> >         return VM_FAULT_SIGBUS;
> >  }
> > +
> > +static inline vm_fault_t arch_do_huge_page_fault_on_access(struct vm_fault *vmf)
> > +{
> > +       if (tag_storage_enabled())
> > +               return handle_huge_page_missing_tag_storage(vmf);
> > +       return VM_FAULT_SIGBUS;
> > +}
> >  #endif /* CONFIG_ARCH_HAS_FAULT_ON_ACCESS */
> >
> >  #define pmd_present_invalid(pmd)     (!!(pmd_val(pmd) & PMD_PRESENT_INVALID))
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index f5fa583acf18..6730a0812a24 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -1041,6 +1041,87 @@ vm_fault_t handle_page_missing_tag_storage(struct vm_fault *vmf)
> >
> >         return 0;
> >
> > +out_retry:
> > +       put_page(page);
> > +       if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> > +               vma_end_read(vma);
> > +       if (fault_flag_allow_retry_first(vmf->flags)) {
> > +               err = VM_FAULT_RETRY;
> > +       } else {
> > +               /* Replay the fault. */
> > +               err = 0;
> > +       }
> > +       return err;
> > +}
> > +
> > +vm_fault_t handle_huge_page_missing_tag_storage(struct vm_fault *vmf)
> > +{
> > +       unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> > +       struct vm_area_struct *vma = vmf->vma;
> > +       pmd_t old_pmd, new_pmd;
> > +       bool writable = false;
> > +       struct page *page;
> > +       vm_fault_t err;
> > +       int ret;
> > +
> > +       vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> > +       if (unlikely(!pmd_same(vmf->orig_pmd, *vmf->pmd))) {
> > +               spin_unlock(vmf->ptl);
> > +               return 0;
> > +       }
> > +
> > +       old_pmd = vmf->orig_pmd;
> > +       new_pmd = pmd_modify(old_pmd, vma->vm_page_prot);
> > +
> > +       /*
> > +        * Detect now whether the PMD could be writable; this information
> > +        * is only valid while holding the PT lock.
> > +        */
> > +       writable = pmd_write(new_pmd);
> > +       if (!writable && vma_wants_manual_pte_write_upgrade(vma) &&
> > +           can_change_pmd_writable(vma, vmf->address, new_pmd))
> > +               writable = true;
> > +
> > +       page = vm_normal_page_pmd(vma, haddr, new_pmd);
> > +       if (!page)
> > +               goto out_map;
> > +
> > +       if (!(vma->vm_flags & VM_MTE))
> > +               goto out_map;
> > +
> > +       get_page(page);
> > +       vma_set_access_pid_bit(vma);
> > +
> > +       spin_unlock(vmf->ptl);
> > +       writable = false;
> > +
> > +       if (unlikely(is_migrate_isolate_page(page)))
> > +               goto out_retry;
> > +
> > +       ret = reserve_tag_storage(page, HPAGE_PMD_ORDER, GFP_HIGHUSER_MOVABLE);
> > +       if (ret)
> > +               goto out_retry;
> > +
> > +       put_page(page);
> > +
> > +       vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> > +       if (unlikely(!pmd_same(old_pmd, *vmf->pmd))) {
> > +               spin_unlock(vmf->ptl);
> > +               return 0;
> > +       }
> > +
> > +out_map:
> > +       /* Restore the PMD */
> > +       new_pmd = pmd_modify(old_pmd, vma->vm_page_prot);
> > +       new_pmd = pmd_mkyoung(new_pmd);
> > +       if (writable)
> > +               new_pmd = pmd_mkwrite(new_pmd, vma);
> > +       set_pmd_at(vma->vm_mm, haddr, vmf->pmd, new_pmd);
> > +       update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
> > +       spin_unlock(vmf->ptl);
> > +
> > +       return 0;
> > +
> >  out_retry:
> >         put_page(page);
> >         if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index fa0350b0812a..bb84291f9231 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -36,6 +36,8 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> >  int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >                     pmd_t *pmd, unsigned long addr, pgprot_t newprot,
> >                     unsigned long cp_flags);
> > +bool can_change_pmd_writable(struct vm_area_struct *vma, unsigned long addr,
> > +                            pmd_t pmd);
> >
> >  vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
> >  vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index e2c761dd6c41..de45f475bf8d 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -1473,6 +1473,11 @@ static inline vm_fault_t arch_do_page_fault_on_access(struct vm_fault *vmf)
> >  {
> >         return VM_FAULT_SIGBUS;
> >  }
> > +
> > +static inline vm_fault_t arch_do_huge_page_fault_on_access(struct vm_fault *vmf)
> > +{
> > +       return VM_FAULT_SIGBUS;
> > +}
> >  #endif
> >
> >  #endif /* CONFIG_MMU */
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 9beead961a65..d1402b43ea39 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1406,8 +1406,8 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
> >         return VM_FAULT_FALLBACK;
> >  }
> >
> > -static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
> > -                                          unsigned long addr, pmd_t pmd)
> > +inline bool can_change_pmd_writable(struct vm_area_struct *vma,
> 
> Remove inline keyword here.

Indeed, as it does nothing now that the function is not static.

Thanks,
Alex

> 
> Peter
> 
> > +                                   unsigned long addr, pmd_t pmd)
> >  {
> >         struct page *page;
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index a04a971200b9..46b926625503 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5168,6 +5168,9 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
> >                         return 0;
> >                 }
> >                 if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
> > +                       if (fault_on_access_pmd(vmf.orig_pmd) && vma_is_accessible(vma))
> > +                               return arch_do_huge_page_fault_on_access(&vmf);
> > +
> >                         if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
> >                                 return do_huge_pmd_numa_page(&vmf);
> >
> > --
> > 2.42.1
> >

