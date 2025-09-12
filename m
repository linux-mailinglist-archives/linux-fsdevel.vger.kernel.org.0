Return-Path: <linux-fsdevel+bounces-61026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A0CB54790
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25E9AC3C11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 09:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE20C2C21FA;
	Fri, 12 Sep 2025 09:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKc9St9q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A842C0297
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668911; cv=none; b=sNefUOioKZt6IXdQjtimXxjSEHnxniZchz5QwI5eRgiOrokljvvjxcHhmNVirC9t53r7aKFCSYqd2KH5p1yHO1yhvK7YATMCYKYH3RZY4UGb6UAS8N5oGoHqA2qRMQq7X3NIMjhVpGCwxD6wfZ5mULGOTtI9Zm6PdLHWQ2Fg3IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668911; c=relaxed/simple;
	bh=4ja9oQCqcRHmgjRUTjFsiDAGirB++R/PpaGwVbfLLOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUCh6wU67j5bGtD24CyTjO4wPJ2qwLOndkNC4cgwgCvMLHLOiHPTyWIkcicaYaruSWjtyrIw7pPxHGuTfsCTF+tsGqq+fXWseSHW0eb0TKXH+ew6GeVkcf/KjgvsROdX9xh+R1v+2OUifTvGZim4/w7A3/PhCxvBlfpb1WKShM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKc9St9q; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74c1251df00so927724a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 02:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757668908; x=1758273708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WUZ7obya3Sr5RFpCVfRbeOTL3de87o7Xbr0uUEJlIJc=;
        b=mKc9St9qwoI0LTaHPUCOiDjRQkWvN0F2by1bN8b6mD4YlPzGBeu1OeluJ8fhHrskHR
         NxvDhs+CDarY41wgTgqSU38vFHQxf8789xXqIDaBaEheZUyXTet+N+aGiVPtLkASfPns
         FzpLTDoWhMAW5EooV2J33kDn02MXkEvG+LrZ3oUxiRsaW12Cw3E+O6hJ7AHBuiNzChQf
         MBNa90+kcXW4qRmxpGVUcon7IK4Gsvpf3hM4tGlpZtE4zgwyzD/PBQr+IZGMCBkdkRUJ
         oGVUyhfLeputYxCrAv17LtItPZ/s1Qt2BB9mL9hi49CIi5WOV7WZVaB5C3vbQYgAVHjo
         zJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668908; x=1758273708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUZ7obya3Sr5RFpCVfRbeOTL3de87o7Xbr0uUEJlIJc=;
        b=bxWUOBXUQ+mEOdNIjppjcopo0v+itWdgLXsZXKrGWjmUHMkcRZacZGz+Iu0A1acelh
         jHtIqPuevHV6BZWWgS9reTFiISAvgsz4ZSdS38tet2IyBPpjFmbrOUipI6d/unHhglXX
         D9kSVWClhEeJs5z30crT5WrziN8zFhdMRxITdIRJAoZxDAgYExtsrR5wGERsiQCJ12Nc
         bXqkWmurOfnLHVVprL6y69Rox70Ca4gKR+m8ADgU4+bRpcmzBiHQBT4QUvpP0cWpFdY8
         RNgZ96JaS/tCsOldgPoclPl0ih88LpL+b0NMZDyaDSBxJaUyyU5buSFEaqOzn4N64HBS
         /sHA==
X-Forwarded-Encrypted: i=1; AJvYcCW7Qa9zx0yZV47arYEFjf9y5PpFUYRmg/2SkingSinXOTCeAkGAMW45ZxpP5w+C0ke5tMqXWyHaoQCo6pg1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx2NxSQ8US2hYAnFBd+tMTBgNJyrl7log/4Uyb8dwuvQz1sRkN
	XSu89HB5Q2XFLPdZlBJFxzHnzk1Blqe2Cc/zLWBvvXvBYRU6bwlmYhL7HUMwIjWabs1aAwXF5cM
	L44q+a11bPifIyWk1j/3N13CpqArFM38=
X-Gm-Gg: ASbGncvBy5zrQ2aErGwhpx/x4jL86EeKQ0v28vCSrV0GygP24K8GW3tJSWg9lvzwnHQ
	Brx5bJ3daej20BGVN4/lS0PBw2SilHt/0UGxCQSr6oCUTguDrJB2Z4IXz277Gm2Fjlpk4oLLiBX
	danQY4QKWIh59QV94Hp+Yl56eI6GK2I2PkBQpk+3x2Y+bkgK/Ji9YHPa1M6mOSNFG15brb2mPWi
	3Mikw==
X-Google-Smtp-Source: AGHT+IHKdOD0sav1pzLGsvexIHlR11xBcySbkJsNI1i4E1d/USdK7pecHfX7/WogNjy7HJPcnksQEcW2rH2s9qtPrgk=
X-Received: by 2002:a05:6871:204:b0:31d:8a1e:78ce with SMTP id
 586e51a60fabf-32e554a2f38mr945748fac.16.1757668908198; Fri, 12 Sep 2025
 02:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911095602.1130290-1-zhangchunyan@iscas.ac.cn>
 <20250911095602.1130290-2-zhangchunyan@iscas.ac.cn> <9bcaf3ec-c0a1-4ca5-87aa-f84e297d1e42@redhat.com>
 <CAAfSe-sAru+FuhVWRa+i5_sj6m4318pLFrgP0Gsd0DVWzjE-hg@mail.gmail.com> <04d2d781-fd5e-4778-b042-d4dbeb8c5d49@redhat.com>
In-Reply-To: <04d2d781-fd5e-4778-b042-d4dbeb8c5d49@redhat.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Fri, 12 Sep 2025 17:21:11 +0800
X-Gm-Features: Ac12FXyFflHnf_JBI4i9hH9jqdgSKY4ieN6Zsx6mGzkigco15IPWhOrDoEo2gdw
Message-ID: <CAAfSe-tQgmBm=RS2gCi7VaRW1XZhS_sJ9rHbvqJ0w=KwTf+m3g@mail.gmail.com>
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

On Fri, 12 Sept 2025 at 16:41, David Hildenbrand <david@redhat.com> wrote:
>
> [...]
>
> >>> +/*
> >>> + * We should remove the VM_SOFTDIRTY flag if the soft-dirty bit is
> >>> + * unavailable on which the kernel is running, even if the architecture
> >>> + * provides the resource and soft-dirty is compiled in.
> >>> + */
> >>> +#ifdef CONFIG_MEM_SOFT_DIRTY
> >>> +     if (!pgtable_soft_dirty_supported())
> >>> +             mnemonics[ilog2(VM_SOFTDIRTY)][0] = 0;
> >>> +#endif
> >>
> >> You can now drop the ifdef.
> >
> > Ok, you mean define VM_SOFTDIRTY 0x08000000 no matter if
> > MEM_SOFT_DIRTY is compiled in, right?
> >
> > Then I need memcpy() to set mnemonics[ilog2(VM_SOFTDIRTY)] here.
>
> The whole hunk will not be required when we make sure VM_SOFTDIRTY never
> gets set, correct?

Oh no, this hunk code does not set vmflag.
The mnemonics[ilog2(VM_SOFTDIRTY)] is for show_smap_vma_flags(),
something like below:
# cat /proc/1/smaps
5555605c7000-555560680000 r-xp 00000000 fe:00 19
  /bin/busybox
...
VmFlags: rd ex mr mw me sd

'sd' is for soft-dirty

I think this is still needed, right?

>
> >
> >>
> >> But, I wonder if could we instead just stop setting the flag. Then we don't
> >> have to worry about any VM_SOFTDIRTY checks.
> >>
> >> Something like the following
> >>
> >> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> index 892fe5dbf9de0..8b8bf63a32ef7 100644
> >> --- a/include/linux/mm.h
> >> +++ b/include/linux/mm.h
> >> @@ -783,6 +783,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
> >>    static inline void vm_flags_init(struct vm_area_struct *vma,
> >>                                   vm_flags_t flags)
> >>    {
> >> +       VM_WARN_ON_ONCE(!pgtable_soft_dirty_supported() && (flags & VM_SOFTDIRTY));
> >>          ACCESS_PRIVATE(vma, __vm_flags) = flags;
> >>    }
> >>
> >> @@ -801,6 +802,7 @@ static inline void vm_flags_reset(struct vm_area_struct *vma,
> >>    static inline void vm_flags_reset_once(struct vm_area_struct *vma,
> >>                                         vm_flags_t flags)
> >>    {
> >> +       VM_WARN_ON_ONCE(!pgtable_soft_dirty_supported() && (flags & VM_SOFTDIRTY));
> >>          vma_assert_write_locked(vma);
> >>          WRITE_ONCE(ACCESS_PRIVATE(vma, __vm_flags), flags);
> >>    }
> >> @@ -808,6 +810,7 @@ static inline void vm_flags_reset_once(struct vm_area_struct *vma,
> >>    static inline void vm_flags_set(struct vm_area_struct *vma,
> >>                                  vm_flags_t flags)
> >>    {
> >> +       VM_WARN_ON_ONCE(!pgtable_soft_dirty_supported() && (flags & VM_SOFTDIRTY));
> >>          vma_start_write(vma);
> >>          ACCESS_PRIVATE(vma, __vm_flags) |= flags;
> >>    }
> >> diff --git a/mm/mmap.c b/mm/mmap.c
> >> index 5fd3b80fda1d5..40cb3fbf9a247 100644
> >> --- a/mm/mmap.c
> >> +++ b/mm/mmap.c
> >> @@ -1451,8 +1451,10 @@ static struct vm_area_struct *__install_special_mapping(
> >>                  return ERR_PTR(-ENOMEM);
> >>
> >>          vma_set_range(vma, addr, addr + len, 0);
> >> -       vm_flags_init(vma, (vm_flags | mm->def_flags |
> >> -                     VM_DONTEXPAND | VM_SOFTDIRTY) & ~VM_LOCKED_MASK);
> >> +       vm_flags |= mm->def_flags | VM_DONTEXPAND;
> >
> > Why use '|=' rather than not directly setting vm_flags which is an
> > uninitialized variable?
>
> vm_flags is passed in by the caller?
>

Then the original code seems wrong.

> But just to clarify: this code was just a quick hack, adjust it as you need.

Got it.

>
> [...]
>
> >>>
> >>> +     if (!pgtable_soft_dirty_supported())
> >>> +             return;
> >>> +
> >>>        if (pmd_present(pmd)) {
> >>>                /* See comment in change_huge_pmd() */
> >>>                old = pmdp_invalidate(vma, addr, pmdp);
> >>
> >> That would all be handled with the above never-set-VM_SOFTDIRTY.
>
> I meant that there is no need to add the pgtable_soft_dirty_supported()
> check.

Ok I will take a look.

>
> >
> > Sorry I'm not sure I understand here, you mean no longer need #ifdef
> > CONFIG_MEM_SOFT_DIRTY for these function definitions, right?
>
> Likely we could drop them. VM_SOFTDIRTY will never be set so the code
> will not be invoked.

The relationship of VM_SOFTDIRTY and clear_soft_dirty_pmd() is not
very direct from the first sight, let me take a further look.

>
> And for architectures where VM_SOFTDIRTY is never even possible
> (!CONFIG_MEM_SOFT_DIRTY) we keep it as 0.

Ok.

>
> That way, the compiler can even optimize out all of that code because
>
> "vma->vm_flags & VM_SOFTDIRTY" -> "vma->vm_flags & 0"
>
> will never be true.
>
> >
> >>
> >>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >>> index 4c035637eeb7..2a3578a4ae4c 100644
> >>> --- a/include/linux/pgtable.h
> >>> +++ b/include/linux/pgtable.h
> >>> @@ -1537,6 +1537,18 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
> >>>    #define arch_start_context_switch(prev)     do {} while (0)
> >>>    #endif
> >>>
> >>> +/*
> >>> + * Some platforms can customize the PTE soft-dirty bit making it unavailable
> >>> + * even if the architecture provides the resource.
> >>> + * Adding this API allows architectures to add their own checks for the
> >>> + * devices on which the kernel is running.
> >>> + * Note: When overiding it, please make sure the CONFIG_MEM_SOFT_DIRTY
> >>> + * is part of this macro.
> >>> + */
> >>> +#ifndef pgtable_soft_dirty_supported
> >>> +#define pgtable_soft_dirty_supported()       IS_ENABLED(CONFIG_MEM_SOFT_DIRTY)
> >>> +#endif
> >>> +
> >>>    #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
> >>>    #ifndef CONFIG_ARCH_ENABLE_THP_MIGRATION
> >>>    static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
> >>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> >>> index 830107b6dd08..b32ce2b0b998 100644
> >>> --- a/mm/debug_vm_pgtable.c
> >>> +++ b/mm/debug_vm_pgtable.c
> >>> @@ -690,7 +690,7 @@ static void __init pte_soft_dirty_tests(struct pgtable_debug_args *args)
> >>>    {
> >>>        pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
> >>>
> >>> -     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> >>> +     if (!pgtable_soft_dirty_supported())
> >>>                return;
> >>>
> >>>        pr_debug("Validating PTE soft dirty\n");
> >>> @@ -702,7 +702,7 @@ static void __init pte_swap_soft_dirty_tests(struct pgtable_debug_args *args)
> >>>    {
> >>>        pte_t pte;
> >>>
> >>> -     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> >>> +     if (!pgtable_soft_dirty_supported())
> >>>                return;
> >>>
> >>>        pr_debug("Validating PTE swap soft dirty\n");
> >>> @@ -718,7 +718,7 @@ static void __init pmd_soft_dirty_tests(struct pgtable_debug_args *args)
> >>>    {
> >>>        pmd_t pmd;
> >>>
> >>> -     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> >>> +     if (!pgtable_soft_dirty_supported())
> >>>                return;
> >>>
> >>>        if (!has_transparent_hugepage())
> >>> @@ -734,8 +734,8 @@ static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args)
> >>>    {
> >>>        pmd_t pmd;
> >>>
> >>> -     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) ||
> >>> -             !IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION))
> >>> +     if (!pgtable_soft_dirty_supported() ||
> >>> +         !IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION))
> >>>                return;
> >>>
> >>>        if (!has_transparent_hugepage())
> >>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>> index 9c38a95e9f09..218d430a2ec6 100644
> >>> --- a/mm/huge_memory.c
> >>> +++ b/mm/huge_memory.c
> >>> @@ -2271,12 +2271,13 @@ static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
> >>>
> >>>    static pmd_t move_soft_dirty_pmd(pmd_t pmd)
> >>>    {
> >>> -#ifdef CONFIG_MEM_SOFT_DIRTY
> >>> -     if (unlikely(is_pmd_migration_entry(pmd)))
> >>> -             pmd = pmd_swp_mksoft_dirty(pmd);
> >>> -     else if (pmd_present(pmd))
> >>> -             pmd = pmd_mksoft_dirty(pmd);
> >>> -#endif
> >>> +     if (pgtable_soft_dirty_supported()) {
> >>> +             if (unlikely(is_pmd_migration_entry(pmd)))
> >>> +                     pmd = pmd_swp_mksoft_dirty(pmd);
> >>> +             else if (pmd_present(pmd))
> >>> +                     pmd = pmd_mksoft_dirty(pmd);
> >>> +     }
> >>> +
> >>
> >> Wondering, should simply the arch take care of that and we can just clal
> >> pmd_swp_mksoft_dirty / pmd_mksoft_dirty?
> >
>
> I think we have that already in include/linux/pgtable.h:
>
> We have stubs that just don't do anything.
>
> For riscv support you would handle runtime-enablement in these helpers.
>
> >
> >>
> >>>        return pmd;
> >>>    }
> >>>
> >>> diff --git a/mm/internal.h b/mm/internal.h
> >>> index 45b725c3dc03..c6ca62f8ecf3 100644
> >>> --- a/mm/internal.h
> >>> +++ b/mm/internal.h
> >>> @@ -1538,7 +1538,7 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
> >>>         * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
> >>>         * will be constantly true.
> >>>         */
> >>> -     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> >>> +     if (!pgtable_soft_dirty_supported())
> >>>                return false;
> >>>
> >>
> >> That should be handled with the above never-set-VM_SOFTDIRTY.
> >
> > We don't need to check if (!pgtable_soft_dirty_supported()) if I
> > understand correctly.
> Hm, let me think about that. No, I think this has to stay as the comment
> says, so this case here is special.

I will cook a new version and then we can discuss further based on the
new patch.

Thanks for your review,
Chunyan

