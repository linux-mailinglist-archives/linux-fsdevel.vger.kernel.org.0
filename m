Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D2C625127
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 03:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiKKCvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 21:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiKKCu7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:50:59 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A0F532DF
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 18:50:17 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 6so3333087pgm.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 18:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DlM9jt3oq9rUO54MRZZJtyFo9f4eKY5Dlupb73aeGvs=;
        b=Jdd14s24R2RXDKxZRxUneSZI6Oig+Wlkatf40pmja95zzOXlbqrNb9BRPxLcxMHJzU
         O1LYHh5c1Pdbl7TEdqY+/z4WKvlviF/Ar67CyCw5ckNh6/L0J1MisNiDm3ji1ETNxLBt
         dCBqls08UQrtRgAo4M7k4/koC0FWazYWD7Qcgy56fdSHmxd/UU3/eCbwlggzGuyeR6cS
         iPVNqkYHPZQNU0/IicN0qQnbzRK/iAMDMkgQsk9oI0vtVDwuNU54W+D54LTb24j1H3QJ
         Dtxup5tiWQCO5LdsrDjpCz1MxWPEcH9tCCfCZx9R3W4fLRVWitEJuCIio8alk01kJQBq
         zSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlM9jt3oq9rUO54MRZZJtyFo9f4eKY5Dlupb73aeGvs=;
        b=o+UdsM8RTq09rw6D/a6daM56HOwCN4RyFbSZ/bpVGUJQwU2UPNh1n4Mq1Oc9hGcAla
         xuOnGcOCZiuGCq+sbwr0Lb60UWAKGP4h1FE57xHUwwjQmoGZkM9SaSTHrSxhsJxSHTlo
         Gm1TOmo6rv6LA501qwKdpFPKCQBzh8ngpuf+Qsy2k5Ko4DUno0QPd+u60ycjIl1g3RnV
         KOWG3UWUjC0l6rOHpS+L8YpS/XOxFdRnMErP4Om6SFWJqPXKjZSJH9d7p9CiLtnQgddu
         DU5ZrQdt0w6QwFP7RFb2USNme4iIlFBYthPugIAD2y50H/jRdAgO4UuFGR7K62YNJ8GK
         wF4w==
X-Gm-Message-State: ANoB5pmrwmEIs4jbaHHKQbQrwJ3ZQUPPA+O8EJd8azYgo5rSBPIXnaPN
        dI3xgH34fM9sZIWBhn4avWoNAg==
X-Google-Smtp-Source: AA0mqf646foeZYLjRBETnW3xknDdl0IpdbTH31c6T87NIpbXQ8RRqKx1FDvg2rvCz465iAesmvZfDg==
X-Received: by 2002:a05:6a00:4199:b0:56b:bb06:7dd5 with SMTP id ca25-20020a056a00419900b0056bbb067dd5mr656354pfb.3.1668135016385;
        Thu, 10 Nov 2022 18:50:16 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id k25-20020a634b59000000b0046f7b0f504esm324268pgl.58.2022.11.10.18.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 18:50:15 -0800 (PST)
Date:   Thu, 10 Nov 2022 18:50:15 -0800 (PST)
X-Google-Original-Date: Thu, 10 Nov 2022 18:50:12 PST (-0800)
Subject:     Re: [PATCH] mm: remove kern_addr_valid() completely
In-Reply-To: <20221018074014.185687-1-wangkefeng.wang@huawei.com>
CC:     akpm@linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-fsdevel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will@kernel.org>, guoren@kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org,
        gerg@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
        dinguyen@kernel.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, chris@zankel.net,
        jcmvbkbc@gmail.com, wangkefeng.wang@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     wangkefeng.wang@huawei.com
Message-ID: <mhng-d9c721d8-f193-4bfa-a1ec-1fa616bf9375@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 18 Oct 2022 00:40:14 PDT (-0700), wangkefeng.wang@huawei.com wrote:
> Most architectures(except arm64/x86/sparc) simply return 1 for
> kern_addr_valid(), which is only used in read_kcore(), and it
> calls copy_from_kernel_nofault() which could check whether the
> address is a valid kernel address, so no need kern_addr_valid(),
> let's remove unneeded kern_addr_valid() completely.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/alpha/include/asm/pgtable.h          |  2 -
>  arch/arc/include/asm/pgtable-bits-arcv2.h |  2 -
>  arch/arm/include/asm/pgtable-nommu.h      |  2 -
>  arch/arm/include/asm/pgtable.h            |  4 --
>  arch/arm64/include/asm/pgtable.h          |  2 -
>  arch/arm64/mm/mmu.c                       | 47 -----------------------
>  arch/arm64/mm/pageattr.c                  |  3 +-
>  arch/csky/include/asm/pgtable.h           |  3 --
>  arch/hexagon/include/asm/page.h           |  7 ----
>  arch/ia64/include/asm/pgtable.h           | 16 --------
>  arch/loongarch/include/asm/pgtable.h      |  2 -
>  arch/m68k/include/asm/pgtable_mm.h        |  2 -
>  arch/m68k/include/asm/pgtable_no.h        |  1 -
>  arch/microblaze/include/asm/pgtable.h     |  3 --
>  arch/mips/include/asm/pgtable.h           |  2 -
>  arch/nios2/include/asm/pgtable.h          |  2 -
>  arch/openrisc/include/asm/pgtable.h       |  2 -
>  arch/parisc/include/asm/pgtable.h         | 15 --------
>  arch/powerpc/include/asm/pgtable.h        |  7 ----
>  arch/riscv/include/asm/pgtable.h          |  2 -
>  arch/s390/include/asm/pgtable.h           |  2 -
>  arch/sh/include/asm/pgtable.h             |  2 -
>  arch/sparc/include/asm/pgtable_32.h       |  6 ---
>  arch/sparc/mm/init_32.c                   |  3 +-
>  arch/sparc/mm/init_64.c                   |  1 -
>  arch/um/include/asm/pgtable.h             |  2 -
>  arch/x86/include/asm/pgtable_32.h         |  9 -----
>  arch/x86/include/asm/pgtable_64.h         |  1 -
>  arch/x86/mm/init_64.c                     | 41 --------------------
>  arch/xtensa/include/asm/pgtable.h         |  2 -
>  fs/proc/kcore.c                           | 26 +++++--------
>  31 files changed, 11 insertions(+), 210 deletions(-)
>
> diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
> index 3ea9661c09ff..9e45f6735d5d 100644
> --- a/arch/alpha/include/asm/pgtable.h
> +++ b/arch/alpha/include/asm/pgtable.h
> @@ -313,8 +313,6 @@ extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
>  #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
>  #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
>
> -#define kern_addr_valid(addr)	(1)
> -
>  #define pte_ERROR(e) \
>  	printk("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
>  #define pmd_ERROR(e) \
> diff --git a/arch/arc/include/asm/pgtable-bits-arcv2.h b/arch/arc/include/asm/pgtable-bits-arcv2.h
> index b23be557403e..515e82db519f 100644
> --- a/arch/arc/include/asm/pgtable-bits-arcv2.h
> +++ b/arch/arc/include/asm/pgtable-bits-arcv2.h
> @@ -120,8 +120,6 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
>  #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
>  #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
>
> -#define kern_addr_valid(addr)	(1)
> -
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #include <asm/hugepage.h>
>  #endif
> diff --git a/arch/arm/include/asm/pgtable-nommu.h b/arch/arm/include/asm/pgtable-nommu.h
> index d16aba48fa0a..25d8c7bb07e0 100644
> --- a/arch/arm/include/asm/pgtable-nommu.h
> +++ b/arch/arm/include/asm/pgtable-nommu.h
> @@ -21,8 +21,6 @@
>  #define pgd_none(pgd)		(0)
>  #define pgd_bad(pgd)		(0)
>  #define pgd_clear(pgdp)
> -#define kern_addr_valid(addr)	(1)
> -/* FIXME */
>  /*
>   * PMD_SHIFT determines the size of the area a second-level page table can map
>   * PGDIR_SHIFT determines what a third-level page table entry can map
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 78a532068fec..00954ab1a039 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -298,10 +298,6 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>   */
>  #define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > __SWP_TYPE_BITS)
>
> -/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
> -/* FIXME: this is not correct */
> -#define kern_addr_valid(addr)	(1)
> -
>  /*
>   * We provide our own arch_get_unmapped_area to cope with VIPT caches.
>   */
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 71a1af42f0e8..4873c1d6e7d0 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1021,8 +1021,6 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>   */
>  #define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > __SWP_TYPE_BITS)
>
> -extern int kern_addr_valid(unsigned long addr);
> -
>  #ifdef CONFIG_ARM64_MTE
>
>  #define __HAVE_ARCH_PREPARE_TO_SWAP
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 9a7c38965154..556154d821bf 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -814,53 +814,6 @@ void __init paging_init(void)
>  	create_idmap();
>  }
>
> -/*
> - * Check whether a kernel address is valid (derived from arch/x86/).
> - */
> -int kern_addr_valid(unsigned long addr)
> -{
> -	pgd_t *pgdp;
> -	p4d_t *p4dp;
> -	pud_t *pudp, pud;
> -	pmd_t *pmdp, pmd;
> -	pte_t *ptep, pte;
> -
> -	addr = arch_kasan_reset_tag(addr);
> -	if ((((long)addr) >> VA_BITS) != -1UL)
> -		return 0;
> -
> -	pgdp = pgd_offset_k(addr);
> -	if (pgd_none(READ_ONCE(*pgdp)))
> -		return 0;
> -
> -	p4dp = p4d_offset(pgdp, addr);
> -	if (p4d_none(READ_ONCE(*p4dp)))
> -		return 0;
> -
> -	pudp = pud_offset(p4dp, addr);
> -	pud = READ_ONCE(*pudp);
> -	if (pud_none(pud))
> -		return 0;
> -
> -	if (pud_sect(pud))
> -		return pfn_valid(pud_pfn(pud));
> -
> -	pmdp = pmd_offset(pudp, addr);
> -	pmd = READ_ONCE(*pmdp);
> -	if (pmd_none(pmd))
> -		return 0;
> -
> -	if (pmd_sect(pmd))
> -		return pfn_valid(pmd_pfn(pmd));
> -
> -	ptep = pte_offset_kernel(pmdp, addr);
> -	pte = READ_ONCE(*ptep);
> -	if (pte_none(pte))
> -		return 0;
> -
> -	return pfn_valid(pte_pfn(pte));
> -}
> -
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  static void free_hotplug_page_range(struct page *page, size_t size,
>  				    struct vmem_altmap *altmap)
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index d107c3d434e2..0a741a910a6a 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -201,8 +201,7 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
>
>  /*
>   * This function is used to determine if a linear map page has been marked as
> - * not-valid. Walk the page table and check the PTE_VALID bit. This is based
> - * on kern_addr_valid(), which almost does what we need.
> + * not-valid. Walk the page table and check the PTE_VALID bit.
>   *
>   * Because this is only called on the kernel linear map,  p?d_sect() implies
>   * p?d_present(). When debug_pagealloc is enabled, sections mappings are
> diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
> index c3d9b92cbe61..77bc6caff2d2 100644
> --- a/arch/csky/include/asm/pgtable.h
> +++ b/arch/csky/include/asm/pgtable.h
> @@ -249,9 +249,6 @@ extern void paging_init(void);
>  void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
>  		      pte_t *pte);
>
> -/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
> -#define kern_addr_valid(addr)	(1)
> -
>  #define io_remap_pfn_range(vma, vaddr, pfn, size, prot) \
>  	remap_pfn_range(vma, vaddr, pfn, size, prot)
>
> diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
> index 7cbf719c578e..d7d4f9fca327 100644
> --- a/arch/hexagon/include/asm/page.h
> +++ b/arch/hexagon/include/asm/page.h
> @@ -131,13 +131,6 @@ static inline void clear_page(void *page)
>
>  #define page_to_virt(page)	__va(page_to_phys(page))
>
> -/*
> - * For port to Hexagon Virtual Machine, MAYBE we check for attempts
> - * to reference reserved HVM space, but in any case, the VM will be
> - * protected.
> - */
> -#define kern_addr_valid(addr)   (1)
> -
>  #include <asm/mem-layout.h>
>  #include <asm-generic/memory_model.h>
>  /* XXX Todo: implement assembly-optimized version of getorder. */
> diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
> index 6925e28ae61d..01517a5e6778 100644
> --- a/arch/ia64/include/asm/pgtable.h
> +++ b/arch/ia64/include/asm/pgtable.h
> @@ -181,22 +181,6 @@ ia64_phys_addr_valid (unsigned long addr)
>  	return (addr & (local_cpu_data->unimpl_pa_mask)) == 0;
>  }
>
> -/*
> - * kern_addr_valid(ADDR) tests if ADDR is pointing to valid kernel
> - * memory.  For the return value to be meaningful, ADDR must be >=
> - * PAGE_OFFSET.  This operation can be relatively expensive (e.g.,
> - * require a hash-, or multi-level tree-lookup or something of that
> - * sort) but it guarantees to return TRUE only if accessing the page
> - * at that address does not cause an error.  Note that there may be
> - * addresses for which kern_addr_valid() returns FALSE even though an
> - * access would not cause an error (e.g., this is typically true for
> - * memory mapped I/O regions.
> - *
> - * XXX Need to implement this for IA-64.
> - */
> -#define kern_addr_valid(addr)	(1)
> -
> -
>  /*
>   * Now come the defines and routines to manage and access the three-level
>   * page table.
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
> index 946704bee599..fc70b7041b76 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -421,8 +421,6 @@ static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
>  	__update_tlb(vma, address, (pte_t *)pmdp);
>  }
>
> -#define kern_addr_valid(addr)	(1)
> -
>  static inline unsigned long pmd_pfn(pmd_t pmd)
>  {
>  	return (pmd_val(pmd) & _PFN_MASK) >> _PFN_SHIFT;
> diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
> index 9b4e2fe2ac82..b93c41fe2067 100644
> --- a/arch/m68k/include/asm/pgtable_mm.h
> +++ b/arch/m68k/include/asm/pgtable_mm.h
> @@ -145,8 +145,6 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>
>  #endif /* !__ASSEMBLY__ */
>
> -#define kern_addr_valid(addr)	(1)
> -
>  /* MMU-specific headers */
>
>  #ifdef CONFIG_SUN3
> diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
> index bce5ca56c388..fed58da3a6b6 100644
> --- a/arch/m68k/include/asm/pgtable_no.h
> +++ b/arch/m68k/include/asm/pgtable_no.h
> @@ -20,7 +20,6 @@
>  #define pgd_none(pgd)		(0)
>  #define pgd_bad(pgd)		(0)
>  #define pgd_clear(pgdp)
> -#define kern_addr_valid(addr)	(1)
>  #define	pmd_offset(a, b)	((void *)0)
>
>  #define PAGE_NONE	__pgprot(0)
> diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
> index ba348e997dbb..42f5988e998b 100644
> --- a/arch/microblaze/include/asm/pgtable.h
> +++ b/arch/microblaze/include/asm/pgtable.h
> @@ -416,9 +416,6 @@ extern unsigned long iopa(unsigned long addr);
>  #define	IOMAP_NOCACHE_NONSER	2
>  #define	IOMAP_NO_COPYBACK	3
>
> -/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
> -#define kern_addr_valid(addr)	(1)
> -
>  void do_page_fault(struct pt_regs *regs, unsigned long address,
>  		   unsigned long error_code);
>
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index 6caec386ad2f..364a06033105 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -550,8 +550,6 @@ static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
>  	__update_tlb(vma, address, pte);
>  }
>
> -#define kern_addr_valid(addr)	(1)
> -
>  /*
>   * Allow physical addresses to be fixed up to help 36-bit peripherals.
>   */
> diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
> index b3d45e815295..ab793bc517f5 100644
> --- a/arch/nios2/include/asm/pgtable.h
> +++ b/arch/nios2/include/asm/pgtable.h
> @@ -249,8 +249,6 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>  #define __swp_entry_to_pte(swp)	((pte_t) { (swp).val })
>  #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
>
> -#define kern_addr_valid(addr)		(1)
> -
>  extern void __init paging_init(void);
>  extern void __init mmu_init(void);
>
> diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
> index dcae8aea132f..6477c17b3062 100644
> --- a/arch/openrisc/include/asm/pgtable.h
> +++ b/arch/openrisc/include/asm/pgtable.h
> @@ -395,8 +395,6 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>  #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
>  #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
>
> -#define kern_addr_valid(addr)           (1)
> -
>  typedef pte_t *pte_addr_t;
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
> index ecd028854469..bd09a44cfb2d 100644
> --- a/arch/parisc/include/asm/pgtable.h
> +++ b/arch/parisc/include/asm/pgtable.h
> @@ -23,21 +23,6 @@
>  #include <asm/processor.h>
>  #include <asm/cache.h>
>
> -/*
> - * kern_addr_valid(ADDR) tests if ADDR is pointing to valid kernel
> - * memory.  For the return value to be meaningful, ADDR must be >=
> - * PAGE_OFFSET.  This operation can be relatively expensive (e.g.,
> - * require a hash-, or multi-level tree-lookup or something of that
> - * sort) but it guarantees to return TRUE only if accessing the page
> - * at that address does not cause an error.  Note that there may be
> - * addresses for which kern_addr_valid() returns FALSE even though an
> - * access would not cause an error (e.g., this is typically true for
> - * memory mapped I/O regions.
> - *
> - * XXX Need to implement this for parisc.
> - */
> -#define kern_addr_valid(addr)	(1)
> -
>  /* This is for the serialization of PxTLB broadcasts. At least on the N class
>   * systems, only one PxTLB inter processor broadcast can be active at any one
>   * time on the Merced bus. */
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index 283f40d05a4d..9972626ddaf6 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -81,13 +81,6 @@ void poking_init(void);
>  extern unsigned long ioremap_bot;
>  extern const pgprot_t protection_map[16];
>
> -/*
> - * kern_addr_valid is intended to indicate whether an address is a valid
> - * kernel address.  Most 32-bit archs define it as always true (like this)
> - * but most 64-bit archs actually perform a test.  What should we do here?
> - */
> -#define kern_addr_valid(addr)	(1)
> -
>  #ifndef CONFIG_TRANSPARENT_HUGEPAGE
>  #define pmd_large(pmd)		0
>  #endif
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 7ec936910a96..c7993bdf749f 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -801,8 +801,6 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>
>  #endif /* !CONFIG_MMU */
>
> -#define kern_addr_valid(addr)   (1) /* FIXME */
> -
>  extern char _start[];
>  extern void *_dtb_early_va;
>  extern uintptr_t _dtb_early_pa;
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index f1cb9391190d..e1db07211818 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1773,8 +1773,6 @@ static inline swp_entry_t __swp_entry(unsigned long type, unsigned long offset)
>  #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
>  #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
>
> -#define kern_addr_valid(addr)   (1)
> -
>  extern int vmem_add_mapping(unsigned long start, unsigned long size);
>  extern void vmem_remove_mapping(unsigned long start, unsigned long size);
>  extern int __vmem_map_4k_page(unsigned long addr, unsigned long phys, pgprot_t prot, bool alloc);
> diff --git a/arch/sh/include/asm/pgtable.h b/arch/sh/include/asm/pgtable.h
> index 6fb9ec54cf9b..3ce30becf6df 100644
> --- a/arch/sh/include/asm/pgtable.h
> +++ b/arch/sh/include/asm/pgtable.h
> @@ -92,8 +92,6 @@ static inline unsigned long phys_addr_mask(void)
>
>  typedef pte_t *pte_addr_t;
>
> -#define kern_addr_valid(addr)	(1)
> -
>  #define pte_pfn(x)		((unsigned long)(((x).pte_low >> PAGE_SHIFT)))
>
>  struct vm_area_struct;
> diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
> index 8ff549004fac..5acc05b572e6 100644
> --- a/arch/sparc/include/asm/pgtable_32.h
> +++ b/arch/sparc/include/asm/pgtable_32.h
> @@ -368,12 +368,6 @@ __get_iospace (unsigned long addr)
>  	}
>  }
>
> -extern unsigned long *sparc_valid_addr_bitmap;
> -
> -/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
> -#define kern_addr_valid(addr) \
> -	(test_bit(__pa((unsigned long)(addr))>>20, sparc_valid_addr_bitmap))
> -
>  /*
>   * For sparc32&64, the pfn in io_remap_pfn_range() carries <iospace> in
>   * its high 4 bits.  These macros/functions put it there or get it from there.
> diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
> index d88e774c8eb4..9c0ea457bdf0 100644
> --- a/arch/sparc/mm/init_32.c
> +++ b/arch/sparc/mm/init_32.c
> @@ -37,8 +37,7 @@
>
>  #include "mm_32.h"
>
> -unsigned long *sparc_valid_addr_bitmap;
> -EXPORT_SYMBOL(sparc_valid_addr_bitmap);
> +static unsigned long *sparc_valid_addr_bitmap;
>
>  unsigned long phys_base;
>  EXPORT_SYMBOL(phys_base);
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index d6faee23c77d..04f9db0c3111 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -1667,7 +1667,6 @@ bool kern_addr_valid(unsigned long addr)
>
>  	return pfn_valid(pte_pfn(*pte));
>  }
> -EXPORT_SYMBOL(kern_addr_valid);
>
>  static unsigned long __ref kernel_map_hugepud(unsigned long vstart,
>  					      unsigned long vend,
> diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
> index 66bc3f99d9be..4e3052f2671a 100644
> --- a/arch/um/include/asm/pgtable.h
> +++ b/arch/um/include/asm/pgtable.h
> @@ -298,8 +298,6 @@ extern pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr);
>  	((swp_entry_t) { pte_val(pte_mkuptodate(pte)) })
>  #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
>
> -#define kern_addr_valid(addr) (1)
> -
>  /* Clear a kernel PTE and flush it from the TLB */
>  #define kpte_clear_flush(ptep, vaddr)		\
>  do {						\
> diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
> index 7c9c968a42ef..7d4ad8907297 100644
> --- a/arch/x86/include/asm/pgtable_32.h
> +++ b/arch/x86/include/asm/pgtable_32.h
> @@ -47,15 +47,6 @@ do {						\
>
>  #endif /* !__ASSEMBLY__ */
>
> -/*
> - * kern_addr_valid() is (1) for FLATMEM and (0) for SPARSEMEM
> - */
> -#ifdef CONFIG_FLATMEM
> -#define kern_addr_valid(addr)	(1)
> -#else
> -#define kern_addr_valid(kaddr)	(0)
> -#endif
> -
>  /*
>   * This is used to calculate the .brk reservation for initial pagetables.
>   * Enough space is reserved to allocate pagetables sufficient to cover all
> diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
> index e479491da8d5..7929327abe00 100644
> --- a/arch/x86/include/asm/pgtable_64.h
> +++ b/arch/x86/include/asm/pgtable_64.h
> @@ -240,7 +240,6 @@ static inline void native_pgd_clear(pgd_t *pgd)
>  #define __swp_entry_to_pte(x)		((pte_t) { .pte = (x).val })
>  #define __swp_entry_to_pmd(x)		((pmd_t) { .pmd = (x).val })
>
> -extern int kern_addr_valid(unsigned long addr);
>  extern void cleanup_highmap(void);
>
>  #define HAVE_ARCH_UNMAPPED_AREA
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 3f040c6e5d13..e8db4edd7cc9 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1416,47 +1416,6 @@ void mark_rodata_ro(void)
>  	debug_checkwx();
>  }
>
> -int kern_addr_valid(unsigned long addr)
> -{
> -	unsigned long above = ((long)addr) >> __VIRTUAL_MASK_SHIFT;
> -	pgd_t *pgd;
> -	p4d_t *p4d;
> -	pud_t *pud;
> -	pmd_t *pmd;
> -	pte_t *pte;
> -
> -	if (above != 0 && above != -1UL)
> -		return 0;
> -
> -	pgd = pgd_offset_k(addr);
> -	if (pgd_none(*pgd))
> -		return 0;
> -
> -	p4d = p4d_offset(pgd, addr);
> -	if (!p4d_present(*p4d))
> -		return 0;
> -
> -	pud = pud_offset(p4d, addr);
> -	if (!pud_present(*pud))
> -		return 0;
> -
> -	if (pud_large(*pud))
> -		return pfn_valid(pud_pfn(*pud));
> -
> -	pmd = pmd_offset(pud, addr);
> -	if (!pmd_present(*pmd))
> -		return 0;
> -
> -	if (pmd_large(*pmd))
> -		return pfn_valid(pmd_pfn(*pmd));
> -
> -	pte = pte_offset_kernel(pmd, addr);
> -	if (pte_none(*pte))
> -		return 0;
> -
> -	return pfn_valid(pte_pfn(*pte));
> -}
> -
>  /*
>   * Block size is the minimum amount of memory which can be hotplugged or
>   * hotremoved. It must be power of two and must be equal or larger than
> diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
> index 54f577c13afa..5b5484d707b2 100644
> --- a/arch/xtensa/include/asm/pgtable.h
> +++ b/arch/xtensa/include/asm/pgtable.h
> @@ -386,8 +386,6 @@ ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>
>  #else
>
> -#define kern_addr_valid(addr)	(1)
> -
>  extern  void update_mmu_cache(struct vm_area_struct * vma,
>  			      unsigned long address, pte_t *ptep);
>
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index dff921f7ca33..590ecb79ad8b 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -541,25 +541,17 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  			fallthrough;
>  		case KCORE_VMEMMAP:
>  		case KCORE_TEXT:
> -			if (kern_addr_valid(start)) {
> -				/*
> -				 * Using bounce buffer to bypass the
> -				 * hardened user copy kernel text checks.
> -				 */
> -				if (copy_from_kernel_nofault(buf, (void *)start,
> -						tsz)) {
> -					if (clear_user(buffer, tsz)) {
> -						ret = -EFAULT;
> -						goto out;
> -					}
> -				} else {
> -					if (copy_to_user(buffer, buf, tsz)) {
> -						ret = -EFAULT;
> -						goto out;
> -					}
> +			/*
> +			 * Using bounce buffer to bypass the
> +			 * hardened user copy kernel text checks.
> +			 */
> +			if (copy_from_kernel_nofault(buf, (void *)start, tsz)) {
> +				if (clear_user(buffer, tsz)) {
> +					ret = -EFAULT;
> +					goto out;
>  				}
>  			} else {
> -				if (clear_user(buffer, tsz)) {
> +				if (copy_to_user(buffer, buf, tsz)) {
>  					ret = -EFAULT;
>  					goto out;
>  				}

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks!
