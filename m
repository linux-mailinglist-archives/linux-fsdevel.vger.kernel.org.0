Return-Path: <linux-fsdevel+bounces-61009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21C2B5452C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 10:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33E63B1B7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 08:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5544F2BD034;
	Fri, 12 Sep 2025 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzo3qeEw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148878F4B
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665382; cv=none; b=gZ3eOig4U2AmjSHeSubieKHEwDP/GKGxAleBEZzTIK3fZ4OFtze5xl/af2O4u8xblUPB+QpBRgYdTUNTmRyjD27UZgW1o1SJYYmTHIG2x2ElirQWjPQu/F5S7XfGmakqWxB64aJEa4Zi64r2/xxmB/GrZGfc10rZAGMxz7sdDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665382; c=relaxed/simple;
	bh=C5IqdBkHyvPRcADa39m1fUcH5iX23Tm0UaXWH0jDLs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8CRmMxgquLp8MfpNWKysJ84ETZDob6BNWq2ZZC8P0bLuGwVCLKByLMjGg0keH1Gdgy98lRhNnUehki3MnRdBd4df9NUcqITkMbrkL6vIP7j03OT6WWasSPbhDGRR1aumHn1TArtWQSL/EV/2NvBDx0dQ3/yGkGznAzM6Zy+TqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzo3qeEw; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-746d5474a53so543124a34.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 01:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757665379; x=1758270179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E5OA4HGL1bZCBXlCcQNNT1fh5jmZSp0K7o8ch/qdvnc=;
        b=gzo3qeEwlx/i4mf4xyWHS88VBAjDG2Yw1heIZORYOBf/ja+YccGVgAI0cUtGcGmHy0
         YhmhYUJ5qzKC9XvbHd+neVZuxsZR1tr4tWLDkvNTupqb4iBLqS9/GOFGHwyaV1pFfzZB
         DFd621AQG0Gr/SR1OmIw7kgj/mRioc8v/HvRRDe/WoAzXWNps/4TkqdrzA9TWUs0hV9v
         IohAn6a/NKH4yeoQuqy0+S0R/J5fiL7bUPmCWzy7EB2cXpa1m+sOdHydXlH//ltOAzJ5
         m15ry/BvWPpf/EZF36vqP5wohDEOWG1czl3QYiCAhiRz5Q7o0+OEH9so0S83+lkhGc3w
         mlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757665379; x=1758270179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5OA4HGL1bZCBXlCcQNNT1fh5jmZSp0K7o8ch/qdvnc=;
        b=o3YDJJ7rnL2SKmm4JKiNZAfIPbhjzusw0xiTSjnscKVHY9I4K2qdx6ADJo057ldzaB
         QRyUpjFvjYZHfoQMvnkF5TLGrpdYxE/qraJvFXdXYWzNOLjYJhqYR3wafXig2mxTSzfB
         DPdDsYKdrjoBtJZqTeF+UXRklOowFcsavxjArSJEwu62GcQBMXD55Q8V6mySO5DmmJW1
         o00V2dC8bBypJWoevjPeGMSykLVmF/UeMLABj9lDoW2xw7EaBbfrRJm889It+G5Qrlwm
         uYnyhed9bIDNLS6qLNn0za/UDqrWTQDHo9zMksbSDbX+IfiQVXNQ6zrIroYMJcv7t/OX
         SdPA==
X-Forwarded-Encrypted: i=1; AJvYcCWMWnhqJG3iaEqHc4xQYDCPhw1lQYlzbG4dK2T72kMPOyuSHOMd9XIxvQTafZk10Svws/km78jL3kwotgkF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8LXGiw0G0Y8kMLGrT3irArp99q6fue1+jyvcvH6Y84nMi1l+8
	cB4Hs+fxyOv+fvhPyyORCJCQCb4MCusIrZpznqle6bsJCKy+I5Ne1itssPIk+/j0fC+uoWBnpfK
	ppWXa2KD2w4Xyn1qeyGUdT11bFx8pPm0=
X-Gm-Gg: ASbGnct8Z35XKxnmYrUU2crUuv1xBwXA6yi0w6nx4EI9EtG32Yc4gljbOtfJUJmMEDP
	unuS+CrkFGuY3QUEH9+tzO+ht9oJO+GCGTvQs8kLs08FctNG7n8BrxvF7fKUp9QYzq+zjgtYER4
	+fVP8OlYbFT7HnhukXbDzhLR59dR+eyx0cht5OXUb0fd2ivS3vKjleoHsyABFqJiiyFf5wXf8KL
	qBNqpxEnfCgictVy6YkJCTFTXs=
X-Google-Smtp-Source: AGHT+IHhOajMg45qoQKuHFqOphgW1v8C6Y3NGv24TZhjVOQCnYNmKayhLoX2A9i2pe11HP7tejVyO8ZyZRPs6TouXr8=
X-Received: by 2002:a05:6808:80ad:b0:437:d306:3067 with SMTP id
 5614622812f47-43b8d896834mr791446b6e.5.1757665378727; Fri, 12 Sep 2025
 01:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911095602.1130290-1-zhangchunyan@iscas.ac.cn>
 <20250911095602.1130290-2-zhangchunyan@iscas.ac.cn> <9bcaf3ec-c0a1-4ca5-87aa-f84e297d1e42@redhat.com>
In-Reply-To: <9bcaf3ec-c0a1-4ca5-87aa-f84e297d1e42@redhat.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Fri, 12 Sep 2025 16:22:22 +0800
X-Gm-Features: Ac12FXy-cDQ5eFXWwommKSKcCFuy-deRstciVxjZJ-jBtke_I7rVvu7ZtFQQsPg
Message-ID: <CAAfSe-sAru+FuhVWRa+i5_sj6m4318pLFrgP0Gsd0DVWzjE-hg@mail.gmail.com>
Subject: Re: [PATCH v11 1/5] mm: softdirty: Add pgtable_soft_dirty_supported()
To: David Hildenbrand <david@redhat.com>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>, linux-riscv@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Deepak Gupta <debug@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Thu, 11 Sept 2025 at 21:09, David Hildenbrand <david@redhat.com> wrote:
>
> On 11.09.25 11:55, Chunyan Zhang wrote:
> > Some platforms can customize the PTE PMD entry soft-dirty bit making it
> > unavailable even if the architecture provides the resource.
> >
> > Add an API which architectures can define their specific implementations
> > to detect if soft-dirty bit is available on which device the kernel is
> > running.
>
> Thinking to myself: maybe pgtable_supports_soft_dirty() would read better
> Whatever you prefer.

I will use pgtable_supports_* in the next version.

> >
> > Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> > ---
> >   fs/proc/task_mmu.c      | 17 ++++++++++++++++-
> >   include/linux/pgtable.h | 12 ++++++++++++
> >   mm/debug_vm_pgtable.c   | 10 +++++-----
> >   mm/huge_memory.c        | 13 +++++++------
> >   mm/internal.h           |  2 +-
> >   mm/mremap.c             | 13 +++++++------
> >   mm/userfaultfd.c        | 10 ++++------
> >   7 files changed, 52 insertions(+), 25 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 29cca0e6d0ff..9e8083b6d4cd 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1058,7 +1058,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
> >        * -Werror=unterminated-string-initialization warning
> >        *  with GCC 15
> >        */
> > -     static const char mnemonics[BITS_PER_LONG][3] = {
> > +     static char mnemonics[BITS_PER_LONG][3] = {
> >               /*
> >                * In case if we meet a flag we don't know about.
> >                */
> > @@ -1129,6 +1129,16 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
> >               [ilog2(VM_SEALED)] = "sl",
> >   #endif
> >       };
> > +/*
> > + * We should remove the VM_SOFTDIRTY flag if the soft-dirty bit is
> > + * unavailable on which the kernel is running, even if the architecture
> > + * provides the resource and soft-dirty is compiled in.
> > + */
> > +#ifdef CONFIG_MEM_SOFT_DIRTY
> > +     if (!pgtable_soft_dirty_supported())
> > +             mnemonics[ilog2(VM_SOFTDIRTY)][0] = 0;
> > +#endif
>
> You can now drop the ifdef.

Ok, you mean define VM_SOFTDIRTY 0x08000000 no matter if
MEM_SOFT_DIRTY is compiled in, right?

Then I need memcpy() to set mnemonics[ilog2(VM_SOFTDIRTY)] here.

>
> But, I wonder if could we instead just stop setting the flag. Then we don't
> have to worry about any VM_SOFTDIRTY checks.
>
> Something like the following
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 892fe5dbf9de0..8b8bf63a32ef7 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -783,6 +783,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>   static inline void vm_flags_init(struct vm_area_struct *vma,
>                                  vm_flags_t flags)
>   {
> +       VM_WARN_ON_ONCE(!pgtable_soft_dirty_supported() && (flags & VM_SOFTDIRTY));
>         ACCESS_PRIVATE(vma, __vm_flags) = flags;
>   }
>
> @@ -801,6 +802,7 @@ static inline void vm_flags_reset(struct vm_area_struct *vma,
>   static inline void vm_flags_reset_once(struct vm_area_struct *vma,
>                                        vm_flags_t flags)
>   {
> +       VM_WARN_ON_ONCE(!pgtable_soft_dirty_supported() && (flags & VM_SOFTDIRTY));
>         vma_assert_write_locked(vma);
>         WRITE_ONCE(ACCESS_PRIVATE(vma, __vm_flags), flags);
>   }
> @@ -808,6 +810,7 @@ static inline void vm_flags_reset_once(struct vm_area_struct *vma,
>   static inline void vm_flags_set(struct vm_area_struct *vma,
>                                 vm_flags_t flags)
>   {
> +       VM_WARN_ON_ONCE(!pgtable_soft_dirty_supported() && (flags & VM_SOFTDIRTY));
>         vma_start_write(vma);
>         ACCESS_PRIVATE(vma, __vm_flags) |= flags;
>   }
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5fd3b80fda1d5..40cb3fbf9a247 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1451,8 +1451,10 @@ static struct vm_area_struct *__install_special_mapping(
>                 return ERR_PTR(-ENOMEM);
>
>         vma_set_range(vma, addr, addr + len, 0);
> -       vm_flags_init(vma, (vm_flags | mm->def_flags |
> -                     VM_DONTEXPAND | VM_SOFTDIRTY) & ~VM_LOCKED_MASK);
> +       vm_flags |= mm->def_flags | VM_DONTEXPAND;

Why use '|=' rather than not directly setting vm_flags which is an
uninitialized variable?

> +       if (pgtable_soft_dirty_supported())
> +               vm_flags |= VM_SOFTDIRTY;
> +       vm_flags_init(vma, vm_flags & ~VM_LOCKED_MASK);
>         vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
>
>         vma->vm_ops = ops;
> diff --git a/mm/vma.c b/mm/vma.c
> index abe0da33c8446..16a1ed2a6199c 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2551,7 +2551,8 @@ static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
>          * then new mapped in-place (which must be aimed as
>          * a completely new data area).
>          */
> -       vm_flags_set(vma, VM_SOFTDIRTY);
> +       if (pgtable_soft_dirty_supported())
> +               vm_flags_set(vma, VM_SOFTDIRTY);
>
>         vma_set_page_prot(vma);
>   }
> @@ -2819,7 +2820,8 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>         mm->data_vm += len >> PAGE_SHIFT;
>         if (vm_flags & VM_LOCKED)
>                 mm->locked_vm += (len >> PAGE_SHIFT);
> -       vm_flags_set(vma, VM_SOFTDIRTY);
> +       if (pgtable_soft_dirty_supported())
> +               vm_flags_set(vma, VM_SOFTDIRTY);
>         return 0;
>
>   mas_store_fail:
> diff --git a/mm/vma_exec.c b/mm/vma_exec.c
> index 922ee51747a68..c06732a5a620a 100644
> --- a/mm/vma_exec.c
> +++ b/mm/vma_exec.c
> @@ -107,6 +107,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
>   int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
>                           unsigned long *top_mem_p)
>   {
> +       unsigned long flags  = VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP;
>         int err;
>         struct vm_area_struct *vma = vm_area_alloc(mm);
>
> @@ -137,7 +138,9 @@ int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
>         BUILD_BUG_ON(VM_STACK_FLAGS & VM_STACK_INCOMPLETE_SETUP);
>         vma->vm_end = STACK_TOP_MAX;
>         vma->vm_start = vma->vm_end - PAGE_SIZE;
> -       vm_flags_init(vma, VM_SOFTDIRTY | VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP);
> +       if (pgtable_soft_dirty_supported())
> +               flags |= VM_SOFTDIRTY;
> +       vm_flags_init(vma, flags);
>         vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
>
>         err = insert_vm_struct(mm, vma);
>
>
> > +
> >       size_t i;
> >
> >       seq_puts(m, "VmFlags: ");
> > @@ -1531,6 +1541,8 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
> >   static inline void clear_soft_dirty(struct vm_area_struct *vma,
> >               unsigned long addr, pte_t *pte)
> >   {
> > +     if (!pgtable_soft_dirty_supported())
> > +             return;
> >       /*
> >        * The soft-dirty tracker uses #PF-s to catch writes
> >        * to pages, so write-protect the pte as well. See the
> > @@ -1566,6 +1578,9 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
> >   {
> >       pmd_t old, pmd = *pmdp;
> >
> > +     if (!pgtable_soft_dirty_supported())
> > +             return;
> > +
> >       if (pmd_present(pmd)) {
> >               /* See comment in change_huge_pmd() */
> >               old = pmdp_invalidate(vma, addr, pmdp);
>
> That would all be handled with the above never-set-VM_SOFTDIRTY.

Sorry I'm not sure I understand here, you mean no longer need #ifdef
CONFIG_MEM_SOFT_DIRTY for these function definitions, right?

>
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 4c035637eeb7..2a3578a4ae4c 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -1537,6 +1537,18 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
> >   #define arch_start_context_switch(prev)     do {} while (0)
> >   #endif
> >
> > +/*
> > + * Some platforms can customize the PTE soft-dirty bit making it unavailable
> > + * even if the architecture provides the resource.
> > + * Adding this API allows architectures to add their own checks for the
> > + * devices on which the kernel is running.
> > + * Note: When overiding it, please make sure the CONFIG_MEM_SOFT_DIRTY
> > + * is part of this macro.
> > + */
> > +#ifndef pgtable_soft_dirty_supported
> > +#define pgtable_soft_dirty_supported()       IS_ENABLED(CONFIG_MEM_SOFT_DIRTY)
> > +#endif
> > +
> >   #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
> >   #ifndef CONFIG_ARCH_ENABLE_THP_MIGRATION
> >   static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
> > diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> > index 830107b6dd08..b32ce2b0b998 100644
> > --- a/mm/debug_vm_pgtable.c
> > +++ b/mm/debug_vm_pgtable.c
> > @@ -690,7 +690,7 @@ static void __init pte_soft_dirty_tests(struct pgtable_debug_args *args)
> >   {
> >       pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
> >
> > -     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> > +     if (!pgtable_soft_dirty_supported())
> >               return;
> >
> >       pr_debug("Validating PTE soft dirty\n");
> > @@ -702,7 +702,7 @@ static void __init pte_swap_soft_dirty_tests(struct pgtable_debug_args *args)
> >   {
> >       pte_t pte;
> >
> > -     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> > +     if (!pgtable_soft_dirty_supported())
> >               return;
> >
> >       pr_debug("Validating PTE swap soft dirty\n");
> > @@ -718,7 +718,7 @@ static void __init pmd_soft_dirty_tests(struct pgtable_debug_args *args)
> >   {
> >       pmd_t pmd;
> >
> > -     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> > +     if (!pgtable_soft_dirty_supported())
> >               return;
> >
> >       if (!has_transparent_hugepage())
> > @@ -734,8 +734,8 @@ static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args)
> >   {
> >       pmd_t pmd;
> >
> > -     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) ||
> > -             !IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION))
> > +     if (!pgtable_soft_dirty_supported() ||
> > +         !IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION))
> >               return;
> >
> >       if (!has_transparent_hugepage())
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 9c38a95e9f09..218d430a2ec6 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2271,12 +2271,13 @@ static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
> >
> >   static pmd_t move_soft_dirty_pmd(pmd_t pmd)
> >   {
> > -#ifdef CONFIG_MEM_SOFT_DIRTY
> > -     if (unlikely(is_pmd_migration_entry(pmd)))
> > -             pmd = pmd_swp_mksoft_dirty(pmd);
> > -     else if (pmd_present(pmd))
> > -             pmd = pmd_mksoft_dirty(pmd);
> > -#endif
> > +     if (pgtable_soft_dirty_supported()) {
> > +             if (unlikely(is_pmd_migration_entry(pmd)))
> > +                     pmd = pmd_swp_mksoft_dirty(pmd);
> > +             else if (pmd_present(pmd))
> > +                     pmd = pmd_mksoft_dirty(pmd);
> > +     }
> > +
>
> Wondering, should simply the arch take care of that and we can just clal
> pmd_swp_mksoft_dirty / pmd_mksoft_dirty?

Ok, I think I can do that in another patchset.

>
> >       return pmd;
> >   }
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 45b725c3dc03..c6ca62f8ecf3 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1538,7 +1538,7 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
> >        * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
> >        * will be constantly true.
> >        */
> > -     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> > +     if (!pgtable_soft_dirty_supported())
> >               return false;
> >
>
> That should be handled with the above never-set-VM_SOFTDIRTY.

We don't need to check if (!pgtable_soft_dirty_supported()) if I
understand correctly.

Thanks for the review,
Chunyan

>
> >       /*
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index e618a706aff5..7beb3114dbf5 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -162,12 +162,13 @@ static pte_t move_soft_dirty_pte(pte_t pte)
> >        * Set soft dirty bit so we can notice
> >        * in userspace the ptes were moved.
> >        */
> > -#ifdef CONFIG_MEM_SOFT_DIRTY
> > -     if (pte_present(pte))
> > -             pte = pte_mksoft_dirty(pte);
> > -     else if (is_swap_pte(pte))
> > -             pte = pte_swp_mksoft_dirty(pte);
> > -#endif
> > +     if (pgtable_soft_dirty_supported()) {
> > +             if (pte_present(pte))
> > +                     pte = pte_mksoft_dirty(pte);
> > +             else if (is_swap_pte(pte))
> > +                     pte = pte_swp_mksoft_dirty(pte);
> > +     }
> > +
> >       return pte;
> >   }
> >
> --
> Cheers
>
> David / dhildenb
>

