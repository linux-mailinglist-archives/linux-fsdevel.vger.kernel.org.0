Return-Path: <linux-fsdevel+bounces-9472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E4F841743
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 01:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598F91C2361E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 00:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77C3FBF0;
	Tue, 30 Jan 2024 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xcqssHLh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD15C2F2D
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 00:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706573076; cv=none; b=AstK7zPBp6HGc0PfueTZvREbLey3F3ilXaVJaDzB/X/L05wBHWjfjjAJk2Pm+8t6j/PzzMajPnQXe805JrPXRdmvR59AdujXBcidnCd9RPlk7qwrBOWQA9J8dipHGI65YycM9Hue2F975IsGDMkQEdOzQlGPqm+ggLq3xplBXW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706573076; c=relaxed/simple;
	bh=TqWtnt6/GVERFbO+52DdIFitQ3QyZb4sW4J+YHA9sv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIOxSna4P9ODyxIRQ4pPtQUW+TdqqYZE8KUtR66oFJVuv2hJqDuRf1r6TL6JQcWPuUsT06/PJUXz7VLs0+7zVieUoXE4gXkJrU9n2MUouqlpeuC1d2uAjfX5MqRE7qlh8i8dbUHIyRNyRv8yVekofHqKBDNrg0eYdKBiY9Uj5ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xcqssHLh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d5ce88b51cso83165ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 16:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706573072; x=1707177872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsMqf9pWxijCVSf9NKW4Fy1rCmOsTFbCNLYH99qokC8=;
        b=xcqssHLhmnbJGoE3pXpUtivUhpYNAi29OXwVrlVXpueyW/Xftdx2v5v/DszWlzQN8y
         7ulpVJ87ewZUaGahxDJL+WxgiysJo8LHU8JBs6ndG/g0EmOGRyV5II/crDndsIDUdx52
         GcYxW7mEY2k0HF1ALuvqwzKBci+V1JpwdjmLzCDbmwGkzXq+BMrPrlf+GIJoG202PVn4
         Z2ZWGxuS/vsdkyCtZ4opRpEmuLr9JQfSkGqPYMa6k6kAggYTlP9oDaGlqArlXa57Oz4n
         P7xNZsM+14Ny+AF6MDgQAKjOz4x57sYgWpGmp6kSTHyGvKmu/okXu8XfErbH+K5sF/h9
         KfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706573072; x=1707177872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsMqf9pWxijCVSf9NKW4Fy1rCmOsTFbCNLYH99qokC8=;
        b=pEGkMGA6vWMIOapTEneoPr2F2GvmaRZusbKSv4piJJDTzAGCXtBRdecOmBbEsHyOVe
         /uGJIouh6mB5BF6enaCNjbU6RKlU1Oyo+4jRi3LNpPlfx6cdkIqYnpWXLty45ZHlTMI6
         3swyhdkTu/xmMgrYjK0dOYH4+dlRBnJrLigT6hCOi7XxXQX4+Q7FshPnSMY+a+jCUzPZ
         fJs70j9vUMWIhzulibbko9sCnOPC3ms+HLa0hIMGtACpstvKOWweJNVjvNYSjWVTYQWn
         EERLK3N9mOqJILZLeLvtroi/xe9IDGxiGrJOaWUBLBZy7Hf0ri9dFiCCAbBTH4Gcvi5g
         FKZQ==
X-Gm-Message-State: AOJu0YyF9Ev90GrHq9yE4/N8pA9AHZQB6dpALA8wAWpucMxJrLnvHXIe
	SqfYoBhpzs6sMV6SDVD6AOars3KPk5JS/m79OsU3o1sk7cIojegcHpIXamSFkRVekeYD3O6h4nS
	ABP49WOPxcZpKpXwrjX8fkiuct2ctq6WNZhLO
X-Google-Smtp-Source: AGHT+IFyM5oCFBirmOpOeGwpkpTYbv6MnkTqUfPBLo5XRceX1ihVflhMS0aXC9nYBTQv8DrmkqFPshTcxb3N5LOfyxY=
X-Received: by 2002:a17:902:e547:b0:1d7:806a:a13e with SMTP id
 n7-20020a170902e54700b001d7806aa13emr100755plf.28.1706573071712; Mon, 29 Jan
 2024 16:04:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125164256.4147-1-alexandru.elisei@arm.com> <20240125164256.4147-24-alexandru.elisei@arm.com>
In-Reply-To: <20240125164256.4147-24-alexandru.elisei@arm.com>
From: Peter Collingbourne <pcc@google.com>
Date: Mon, 29 Jan 2024 16:04:18 -0800
Message-ID: <CAMn1gO5pGVRCErVF+Ca-4JgHRKEcq9sDGyEe--gEjj5ZLrB8sA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 23/35] arm64: mte: Try to reserve tag storage in arch_alloc_page()
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, 
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	mhiramat@kernel.org, rppt@kernel.org, hughd@google.com, steven.price@arm.com, 
	anshuman.khandual@arm.com, vincenzo.frascino@arm.com, david@redhat.com, 
	eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 8:45=E2=80=AFAM Alexandru Elisei
<alexandru.elisei@arm.com> wrote:
>
> Reserve tag storage for a page that is being allocated as tagged. This
> is a best effort approach, and failing to reserve tag storage is
> allowed.
>
> When all the associated tagged pages have been freed, return the tag
> storage pages back to the page allocator, where they can be used again fo=
r
> data allocations.
>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>
> Changes since rfc v2:
>
> * Based on rfc v2 patch #16 ("arm64: mte: Manage tag storage on page
> allocation").
> * Fixed calculation of the number of associated tag storage blocks (Hyeso=
o
> Yu).
> * Tag storage is reserved in arch_alloc_page() instead of
> arch_prep_new_page().
>
>  arch/arm64/include/asm/mte.h             |  16 +-
>  arch/arm64/include/asm/mte_tag_storage.h |  31 +++
>  arch/arm64/include/asm/page.h            |   5 +
>  arch/arm64/include/asm/pgtable.h         |  19 ++
>  arch/arm64/kernel/mte_tag_storage.c      | 234 +++++++++++++++++++++++
>  arch/arm64/mm/fault.c                    |   7 +
>  fs/proc/page.c                           |   1 +
>  include/linux/kernel-page-flags.h        |   1 +
>  include/linux/page-flags.h               |   1 +
>  include/trace/events/mmflags.h           |   3 +-
>  mm/huge_memory.c                         |   1 +
>  11 files changed, 316 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 8034695b3dd7..6457b7899207 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -40,12 +40,24 @@ void mte_free_tag_buf(void *buf);
>  #ifdef CONFIG_ARM64_MTE
>
>  /* track which pages have valid allocation tags */
> -#define PG_mte_tagged  PG_arch_2
> +#define PG_mte_tagged          PG_arch_2
>  /* simple lock to avoid multiple threads tagging the same page */
> -#define PG_mte_lock    PG_arch_3
> +#define PG_mte_lock            PG_arch_3
> +/* Track if a tagged page has tag storage reserved */
> +#define PG_tag_storage_reserved        PG_arch_4
> +
> +#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> +DECLARE_STATIC_KEY_FALSE(tag_storage_enabled_key);
> +extern bool page_tag_storage_reserved(struct page *page);
> +#endif
>
>  static inline void set_page_mte_tagged(struct page *page)
>  {
> +#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> +       /* Open code mte_tag_storage_enabled() */
> +       WARN_ON_ONCE(static_branch_likely(&tag_storage_enabled_key) &&
> +                    !page_tag_storage_reserved(page));
> +#endif
>         /*
>          * Ensure that the tags written prior to this function are visibl=
e
>          * before the page flags update.
> diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/includ=
e/asm/mte_tag_storage.h
> index 7b3f6bff8e6f..09f1318d924e 100644
> --- a/arch/arm64/include/asm/mte_tag_storage.h
> +++ b/arch/arm64/include/asm/mte_tag_storage.h
> @@ -5,6 +5,12 @@
>  #ifndef __ASM_MTE_TAG_STORAGE_H
>  #define __ASM_MTE_TAG_STORAGE_H
>
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/mm_types.h>
> +
> +#include <asm/mte.h>
> +
>  #ifdef CONFIG_ARM64_MTE_TAG_STORAGE
>
>  DECLARE_STATIC_KEY_FALSE(tag_storage_enabled_key);
> @@ -15,6 +21,15 @@ static inline bool tag_storage_enabled(void)
>  }
>
>  void mte_init_tag_storage(void);
> +
> +static inline bool alloc_requires_tag_storage(gfp_t gfp)
> +{
> +       return gfp & __GFP_TAGGED;
> +}
> +int reserve_tag_storage(struct page *page, int order, gfp_t gfp);
> +void free_tag_storage(struct page *page, int order);
> +
> +bool page_tag_storage_reserved(struct page *page);
>  #else
>  static inline bool tag_storage_enabled(void)
>  {
> @@ -23,6 +38,22 @@ static inline bool tag_storage_enabled(void)
>  static inline void mte_init_tag_storage(void)
>  {
>  }
> +static inline bool alloc_requires_tag_storage(struct page *page)

This function should take a gfp_t to match the
CONFIG_ARM64_MTE_TAG_STORAGE case.

Peter

> +{
> +       return false;
> +}
> +static inline int reserve_tag_storage(struct page *page, int order, gfp_=
t gfp)
> +{
> +       return 0;
> +}
> +static inline void free_tag_storage(struct page *page, int order)
> +{
> +}
> +static inline bool page_tag_storage_reserved(struct page *page)
> +{
> +       return true;
> +}
>  #endif /* CONFIG_ARM64_MTE_TAG_STORAGE */
>
> +#endif /* !__ASSEMBLY__ */
>  #endif /* __ASM_MTE_TAG_STORAGE_H  */
> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.=
h
> index 88bab032a493..3a656492f34a 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -35,6 +35,11 @@ void copy_highpage(struct page *to, struct page *from)=
;
>  void tag_clear_highpage(struct page *to);
>  #define __HAVE_ARCH_TAG_CLEAR_HIGHPAGE
>
> +#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> +void arch_alloc_page(struct page *, int order, gfp_t gfp);
> +#define HAVE_ARCH_ALLOC_PAGE
> +#endif
> +
>  #define clear_user_page(page, vaddr, pg)       clear_page(page)
>  #define copy_user_page(to, from, vaddr, pg)    copy_page(to, from)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
> index 2499cc4fa4f2..f30466199a9b 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -10,6 +10,7 @@
>
>  #include <asm/memory.h>
>  #include <asm/mte.h>
> +#include <asm/mte_tag_storage.h>
>  #include <asm/pgtable-hwdef.h>
>  #include <asm/pgtable-prot.h>
>  #include <asm/tlbflush.h>
> @@ -1069,6 +1070,24 @@ static inline void arch_swap_restore(swp_entry_t e=
ntry, struct folio *folio)
>                 mte_restore_page_tags_by_swp_entry(entry, &folio->page);
>  }
>
> +#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> +
> +#define __HAVE_ARCH_FREE_PAGES_PREPARE
> +static inline void arch_free_pages_prepare(struct page *page, int order)
> +{
> +       if (tag_storage_enabled() && page_mte_tagged(page))
> +               free_tag_storage(page, order);
> +}
> +
> +#define __HAVE_ARCH_ALLOC_CMA
> +static inline bool arch_alloc_cma(gfp_t gfp_mask)
> +{
> +       if (tag_storage_enabled() && alloc_requires_tag_storage(gfp_mask)=
)
> +               return false;
> +       return true;
> +}
> +
> +#endif /* CONFIG_ARM64_MTE_TAG_STORAGE */
>  #endif /* CONFIG_ARM64_MTE */
>
>  #define __HAVE_ARCH_CALC_VMA_GFP
> diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_=
tag_storage.c
> index d58c68b4a849..762c7c803a70 100644
> --- a/arch/arm64/kernel/mte_tag_storage.c
> +++ b/arch/arm64/kernel/mte_tag_storage.c
> @@ -34,6 +34,31 @@ struct tag_region {
>  static struct tag_region tag_regions[MAX_TAG_REGIONS];
>  static int num_tag_regions;
>
> +/*
> + * A note on locking. Reserving tag storage takes the tag_blocks_lock mu=
tex,
> + * because alloc_contig_range() might sleep.
> + *
> + * Freeing tag storage takes the xa_lock spinlock with interrupts disabl=
ed
> + * because pages can be freed from non-preemptible contexts, including f=
rom an
> + * interrupt handler.
> + *
> + * Because tag storage can be freed from interrupt contexts, the xarray =
is
> + * defined with the XA_FLAGS_LOCK_IRQ flag to disable interrupts when ca=
lling
> + * xa_store(). This is done to prevent a deadlock with free_tag_storage(=
) being
> + * called from an interrupt raised before xa_store() releases the xa_loc=
k.
> + *
> + * All of the above means that reserve_tag_storage() cannot run concurre=
ntly
> + * with itself (no concurrent insertions), but it can run at the same ti=
me as
> + * free_tag_storage(). The first thing that reserve_tag_storage() does a=
fter
> + * taking the mutex is increase the refcount on all present tag storage =
blocks
> + * with the xa_lock held, to serialize against freeing the blocks. This =
is an
> + * optimization to avoid taking and releasing the xa_lock after each ite=
ration
> + * if the refcount operation was moved inside the loop, where it would h=
ave had
> + * to be executed for each block.
> + */
> +static DEFINE_XARRAY_FLAGS(tag_blocks_reserved, XA_FLAGS_LOCK_IRQ);
> +static DEFINE_MUTEX(tag_blocks_lock);
> +
>  static u32 __init get_block_size_pages(u32 block_size_bytes)
>  {
>         u32 a =3D PAGE_SIZE;
> @@ -364,3 +389,212 @@ static int __init mte_enable_tag_storage(void)
>         return -EINVAL;
>  }
>  arch_initcall(mte_enable_tag_storage);
> +
> +static void page_set_tag_storage_reserved(struct page *page, int order)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < (1 << order); i++)
> +               set_bit(PG_tag_storage_reserved, &(page + i)->flags);
> +}
> +
> +static void block_ref_add(unsigned long block, struct tag_region *region=
, int order)
> +{
> +       int count;
> +
> +       count =3D min(1u << order, 32 * region->block_size_pages);
> +       page_ref_add(pfn_to_page(block), count);
> +}
> +
> +static int block_ref_sub_return(unsigned long block, struct tag_region *=
region, int order)
> +{
> +       int count;
> +
> +       count =3D min(1u << order, 32 * region->block_size_pages);
> +       return page_ref_sub_return(pfn_to_page(block), count);
> +}
> +
> +static bool tag_storage_block_is_reserved(unsigned long block)
> +{
> +       return xa_load(&tag_blocks_reserved, block) !=3D NULL;
> +}
> +
> +static int tag_storage_reserve_block(unsigned long block, struct tag_reg=
ion *region, int order)
> +{
> +       int ret;
> +
> +       ret =3D xa_err(xa_store(&tag_blocks_reserved, block, pfn_to_page(=
block), GFP_KERNEL));
> +       if (!ret)
> +               block_ref_add(block, region, order);
> +
> +       return ret;
> +}
> +
> +static int order_to_num_blocks(int order, u32 block_size_pages)
> +{
> +       int num_tag_storage_pages =3D max((1 << order) / 32, 1);
> +
> +       return DIV_ROUND_UP(num_tag_storage_pages, block_size_pages);
> +}
> +
> +static int tag_storage_find_block_in_region(struct page *page, unsigned =
long *blockp,
> +                                           struct tag_region *region)
> +{
> +       struct range *tag_range =3D &region->tag_range;
> +       struct range *mem_range =3D &region->mem_range;
> +       u64 page_pfn =3D page_to_pfn(page);
> +       u64 block, block_offset;
> +
> +       if (!(mem_range->start <=3D page_pfn && page_pfn <=3D mem_range->=
end))
> +               return -ERANGE;
> +
> +       block_offset =3D (page_pfn - mem_range->start) / 32;
> +       block =3D tag_range->start + rounddown(block_offset, region->bloc=
k_size_pages);
> +
> +       if (block + region->block_size_pages - 1 > tag_range->end) {
> +               pr_err("Block 0x%llx-0x%llx is outside tag region 0x%llx-=
0x%llx\n",
> +                       PFN_PHYS(block), PFN_PHYS(block + region->block_s=
ize_pages + 1) - 1,
> +                       PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->e=
nd + 1) - 1);
> +               return -ERANGE;
> +       }
> +       *blockp =3D block;
> +
> +       return 0;
> +
> +}
> +
> +static int tag_storage_find_block(struct page *page, unsigned long *bloc=
k,
> +                                 struct tag_region **region)
> +{
> +       int i, ret;
> +
> +       for (i =3D 0; i < num_tag_regions; i++) {
> +               ret =3D tag_storage_find_block_in_region(page, block, &ta=
g_regions[i]);
> +               if (ret =3D=3D 0) {
> +                       *region =3D &tag_regions[i];
> +                       return 0;
> +               }
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +bool page_tag_storage_reserved(struct page *page)
> +{
> +       return test_bit(PG_tag_storage_reserved, &page->flags);
> +}
> +
> +int reserve_tag_storage(struct page *page, int order, gfp_t gfp)
> +{
> +       unsigned long start_block, end_block;
> +       struct tag_region *region;
> +       unsigned long block;
> +       unsigned long flags;
> +       int ret =3D 0;
> +
> +       VM_WARN_ON_ONCE(!preemptible());
> +
> +       if (page_tag_storage_reserved(page))
> +               return 0;
> +
> +       /*
> +        * __alloc_contig_migrate_range() ignores gfp when allocating the
> +        * destination page for migration. Regardless, massage gfp flags =
and
> +        * remove __GFP_TAGGED to avoid recursion in case gfp stops being
> +        * ignored.
> +        */
> +       gfp &=3D ~__GFP_TAGGED;
> +       if (!(gfp & __GFP_NORETRY))
> +               gfp |=3D __GFP_RETRY_MAYFAIL;
> +
> +       ret =3D tag_storage_find_block(page, &start_block, &region);
> +       if (WARN_ONCE(ret, "Missing tag storage block for pfn 0x%lx", pag=
e_to_pfn(page)))
> +               return -EINVAL;
> +       end_block =3D start_block + order_to_num_blocks(order, region->bl=
ock_size_pages);
> +
> +       mutex_lock(&tag_blocks_lock);
> +
> +       /* Check again, this time with the lock held. */
> +       if (page_tag_storage_reserved(page))
> +               goto out_unlock;
> +
> +       /* Make sure existing entries are not freed from out under out fe=
et. */
> +       xa_lock_irqsave(&tag_blocks_reserved, flags);
> +       for (block =3D start_block; block < end_block; block +=3D region-=
>block_size_pages) {
> +               if (tag_storage_block_is_reserved(block))
> +                       block_ref_add(block, region, order);
> +       }
> +       xa_unlock_irqrestore(&tag_blocks_reserved, flags);
> +
> +       for (block =3D start_block; block < end_block; block +=3D region-=
>block_size_pages) {
> +               /* Refcount incremented above. */
> +               if (tag_storage_block_is_reserved(block))
> +                       continue;
> +
> +               ret =3D cma_alloc_range(region->cma, block, region->block=
_size_pages, 3, gfp);
> +               /* Should never happen. */
> +               VM_WARN_ON_ONCE(ret =3D=3D -EEXIST);
> +               if (ret)
> +                       goto out_error;
> +
> +               ret =3D tag_storage_reserve_block(block, region, order);
> +               if (ret) {
> +                       cma_release(region->cma, pfn_to_page(block), regi=
on->block_size_pages);
> +                       goto out_error;
> +               }
> +       }
> +
> +       page_set_tag_storage_reserved(page, order);
> +out_unlock:
> +       mutex_unlock(&tag_blocks_lock);
> +
> +       return 0;
> +
> +out_error:
> +       xa_lock_irqsave(&tag_blocks_reserved, flags);
> +       for (block =3D start_block; block < end_block; block +=3D region-=
>block_size_pages) {
> +               if (tag_storage_block_is_reserved(block) &&
> +                   block_ref_sub_return(block, region, order) =3D=3D 1) =
{
> +                       __xa_erase(&tag_blocks_reserved, block);
> +                       cma_release(region->cma, pfn_to_page(block), regi=
on->block_size_pages);
> +               }
> +       }
> +       xa_unlock_irqrestore(&tag_blocks_reserved, flags);
> +
> +       mutex_unlock(&tag_blocks_lock);
> +
> +       return ret;
> +}
> +
> +void free_tag_storage(struct page *page, int order)
> +{
> +       unsigned long block, start_block, end_block;
> +       struct tag_region *region;
> +       unsigned long flags;
> +       int ret;
> +
> +       ret =3D tag_storage_find_block(page, &start_block, &region);
> +       if (WARN_ONCE(ret, "Missing tag storage block for pfn 0x%lx", pag=
e_to_pfn(page)))
> +               return;
> +
> +       end_block =3D start_block + order_to_num_blocks(order, region->bl=
ock_size_pages);
> +
> +       xa_lock_irqsave(&tag_blocks_reserved, flags);
> +       for (block =3D start_block; block < end_block; block +=3D region-=
>block_size_pages) {
> +               if (WARN_ONCE(!tag_storage_block_is_reserved(block),
> +                   "Block 0x%lx is not reserved for pfn 0x%lx", block, p=
age_to_pfn(page)))
> +                       continue;
> +
> +               if (block_ref_sub_return(block, region, order) =3D=3D 1) =
{
> +                       __xa_erase(&tag_blocks_reserved, block);
> +                       cma_release(region->cma, pfn_to_page(block), regi=
on->block_size_pages);
> +               }
> +       }
> +       xa_unlock_irqrestore(&tag_blocks_reserved, flags);
> +}
> +
> +void arch_alloc_page(struct page *page, int order, gfp_t gfp)
> +{
> +       if (tag_storage_enabled() && alloc_requires_tag_storage(gfp))
> +               reserve_tag_storage(page, order, gfp);
> +}
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index c022e473c17c..1ffaeccecda2 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -37,6 +37,7 @@
>  #include <asm/esr.h>
>  #include <asm/kprobes.h>
>  #include <asm/mte.h>
> +#include <asm/mte_tag_storage.h>
>  #include <asm/processor.h>
>  #include <asm/sysreg.h>
>  #include <asm/system_misc.h>
> @@ -950,6 +951,12 @@ gfp_t arch_calc_vma_gfp(struct vm_area_struct *vma, =
gfp_t gfp)
>
>  void tag_clear_highpage(struct page *page)
>  {
> +       if (tag_storage_enabled() && !page_tag_storage_reserved(page)) {
> +               /* Don't zero the tags if tag storage is not reserved */
> +               clear_page(page_address(page));
> +               return;
> +       }
> +
>         /* Newly allocated page, shouldn't have been tagged yet */
>         WARN_ON_ONCE(!try_page_mte_tagging(page));
>         mte_zero_clear_page_tags(page_address(page));
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 195b077c0fac..e7eb584a9234 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -221,6 +221,7 @@ u64 stable_page_flags(struct page *page)
>  #ifdef CONFIG_ARCH_USES_PG_ARCH_X
>         u |=3D kpf_copy_bit(k, KPF_ARCH_2,        PG_arch_2);
>         u |=3D kpf_copy_bit(k, KPF_ARCH_3,        PG_arch_3);
> +       u |=3D kpf_copy_bit(k, KPF_ARCH_4,        PG_arch_4);
>  #endif
>
>         return u;
> diff --git a/include/linux/kernel-page-flags.h b/include/linux/kernel-pag=
e-flags.h
> index 859f4b0c1b2b..4a0d719ffdd4 100644
> --- a/include/linux/kernel-page-flags.h
> +++ b/include/linux/kernel-page-flags.h
> @@ -19,5 +19,6 @@
>  #define KPF_SOFTDIRTY          40
>  #define KPF_ARCH_2             41
>  #define KPF_ARCH_3             42
> +#define KPF_ARCH_4             43
>
>  #endif /* LINUX_KERNEL_PAGE_FLAGS_H */
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index b7237bce7446..03f03e6d735e 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -135,6 +135,7 @@ enum pageflags {
>  #ifdef CONFIG_ARCH_USES_PG_ARCH_X
>         PG_arch_2,
>         PG_arch_3,
> +       PG_arch_4,
>  #endif
>         __NR_PAGEFLAGS,
>
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflag=
s.h
> index 6ca0d5ed46c0..ba962fd10a2c 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -125,7 +125,8 @@ IF_HAVE_PG_HWPOISON(hwpoison)                        =
                       \
>  IF_HAVE_PG_IDLE(idle)                                                  \
>  IF_HAVE_PG_IDLE(young)                                                 \
>  IF_HAVE_PG_ARCH_X(arch_2)                                              \
> -IF_HAVE_PG_ARCH_X(arch_3)
> +IF_HAVE_PG_ARCH_X(arch_3)                                              \
> +IF_HAVE_PG_ARCH_X(arch_4)
>
>  #define show_page_flags(flags)                                         \
>         (flags) ? __print_flags(flags, "|",                             \
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2bad63a7ec16..47932539cc50 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2804,6 +2804,7 @@ static void __split_huge_page_tail(struct folio *fo=
lio, int tail,
>  #ifdef CONFIG_ARCH_USES_PG_ARCH_X
>                          (1L << PG_arch_2) |
>                          (1L << PG_arch_3) |
> +                        (1L << PG_arch_4) |
>  #endif
>                          (1L << PG_dirty) |
>                          LRU_GEN_MASK | LRU_REFS_MASK));
> --
> 2.43.0
>

