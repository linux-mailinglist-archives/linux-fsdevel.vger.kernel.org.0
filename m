Return-Path: <linux-fsdevel+bounces-60873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC21AB526AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 04:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F1F1B2659B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 02:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7FF221FAC;
	Thu, 11 Sep 2025 02:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II+tdFEI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8026A18EFD1;
	Thu, 11 Sep 2025 02:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757559153; cv=none; b=ZsozGdNB1rPLnhn4tMfFdYiT+ptPrSt795QhZzmstK2VW9i9VvZzlmD1jYGiE2+A5Oy4UsSdzx/Q8rQyq1eLyP2MFu1jDp4a4w/+rNC3fThSkryHCZJG/ZT1lmVASWG9ABHCG6Qw0qTKdh+EXx2g069Fz9xfZ15osBxom8glJgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757559153; c=relaxed/simple;
	bh=wBdHXnDdAAnQuJHkeV8C1uQMDmdRFSU3OZaPFPd7cM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhTV2qnDQjXzMmsdG+RCbTvlvRGP4UgsY8Xp5lzWFlzBrV+EJhT4ouD3VsI/fRC5/3plBoRxHpzcI4mXVacMMldCAvOsOtRXA4P6ojf3Quv9xK/2hwoS27b2TMHoHSRuFWf5of1v5qW/h3Xk417hDzdx59AG+/7RfoaOzm4h/XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=II+tdFEI; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-31d6b8be249so249949fac.0;
        Wed, 10 Sep 2025 19:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757559150; x=1758163950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bpMjHp2LWdB4AWDkPscdVaO0VRTcuWiIT22FTu9B1MU=;
        b=II+tdFEI1amfhHAHE4c5mPvKbGBmlxi2I0kOBDyu3BgOf3MMgMYTSebu9F9756tRdy
         OfdvFESNtPJx/g/JF44zDQP/avEv6kiQmkG5IZxsAEKm9FG06vWPXajr+U0uxpT1PZwX
         k74t1Ng3nvIH1I7OEfw+Va1kXlWm3O08/yxtrArsc8dF0HgFNij56CP4eqa0koibl/am
         U9DyeBA6U2LpEIBvYoShhcBNCsWiOeA3x2Ic9A/r61FCWCL4rV3o06UrQ9ZORqt80njB
         In9BkEWDmD/TAw1j6AGNq/gXI2l6wGIiguAwd+LTBNOnNpsYkGYPXogJXrg8gohyHPX+
         tmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757559150; x=1758163950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpMjHp2LWdB4AWDkPscdVaO0VRTcuWiIT22FTu9B1MU=;
        b=B2U8wLVRi/26Px5kXVQZP4WU/db3ph7KTfKlsvq3TZ+iDQpNhNzqQZuQzz/M5h3jjp
         OfwML9X90eXqCkOXRnPbOuI+9CmAi5UAZJX599CpOhDTmCPyOZpr6OZCv7IIbvrN2cwb
         oqMTKttIBTCJvXWV3ScSITvL5DxntAlenYlx2ofaw8Int5mRS/x7X6lPWBWfAuTEESGc
         gcNq58rF1wELxL5TPrL1/V8H2NYrEfq4Q9Z0ilqUnvUv4tieFExAJZbksRyyMNghknrX
         CCeLQL3rmUUgadvtlQxilwsjCP4kXVZ+aA+LS3Y3MHwXI7uVM/puF4fk7s6J7QaEWqsw
         zbdA==
X-Forwarded-Encrypted: i=1; AJvYcCUHlZ0IewAt7RwXaZfr/hlQ9xa15C2c8WpHfQPc9lrQSdmWx4gXw5t9FqtgCSPXG9XIZi3O5RTLt4ndhRy0@vger.kernel.org, AJvYcCXbx+SLS2OfJQHKPy38GhTF3XqgknHK+UjGHAAX6GX3OQWFUgzX6gNo4SF8d/EVV15beJHQQ4XLDNGaCh92@vger.kernel.org
X-Gm-Message-State: AOJu0YzkVEHI/lEojjdJTf5fxyIsHOs/5pY1AmX54E+LfMo5XdY8X6fM
	4/LlT+YJRixzJ+o6IQmCWjktYRUeJjbA1IIirYODC8gln8+IcBVG9uAR5iw1OGjIkkntXaVlHHp
	u3LjU5lEWb5UAYAoKj+OfCuZ9E97PWVg=
X-Gm-Gg: ASbGncvCq9IVCQgY4m+6agVyQg4m+k/6CCxoKGuy/3Uw79NAinhbSyLebYemwa+UJx4
	0fZ0Ljk17D8lZ1qWOYF/ZcnIYTnUnJ6LqyNCbhSPpxp8Olp4M5gSDCNqy4EslWxaDtcSFebNf8o
	yUKfYyrPHEb0wpkB8S3Bs2CgLamLCq6GsBB/U6zpVrqkgrVNs7AB89eKDjgEKxZJdDdqFUWncDh
	o45ZskqOri2KD9YoJh/vkoC6YtJdz+VJc0d/rk=
X-Google-Smtp-Source: AGHT+IFv2XibXXypOlqv0RILHKkLaMk/1jc9mR92t82jtZp+Vm0vVDQ6eAhrLbih1UZ+0wzcwt9/oVQRFlYGSifHFZw=
X-Received: by 2002:a05:6870:524d:b0:321:2680:2f84 with SMTP id
 586e51a60fabf-3226284cc7bmr8304474fac.3.1757559150312; Wed, 10 Sep 2025
 19:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909095611.803898-1-zhangchunyan@iscas.ac.cn>
 <20250909095611.803898-2-zhangchunyan@iscas.ac.cn> <6b2f12aa-8ed9-476d-a69d-f05ea526f16a@redhat.com>
 <CAAfSe-vbvGQy9JozQY3vsqrrPrTaWYMcNw+NaDf3nReWz8ynZg@mail.gmail.com> <8f9a4a13-2881-4baf-ab62-3d0d79e0cd3c@redhat.com>
In-Reply-To: <8f9a4a13-2881-4baf-ab62-3d0d79e0cd3c@redhat.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Thu, 11 Sep 2025 10:51:54 +0800
X-Gm-Features: Ac12FXw931KhRWiAwZHuKU_RVXZ29toqGSbWPbkJSujEUI17HyVR0UbdKmmlFK4
Message-ID: <CAAfSe-snV-XZ3xGmK6gXNXw-D3ECWbyQgG+WG3c5gAsREz4ccQ@mail.gmail.com>
Subject: Re: [PATCH V10 1/5] mm: softdirty: Add pte_soft_dirty_available()
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

On Wed, 10 Sept 2025 at 16:51, David Hildenbrand <david@redhat.com> wrote:
>
> On 10.09.25 10:25, Chunyan Zhang wrote:
> > Hi David,
> >
> > On Tue, 9 Sept 2025 at 19:42, David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 09.09.25 11:56, Chunyan Zhang wrote:
> >>> Some platforms can customize the PTE soft dirty bit and make it unavailable
> >>> even if the architecture allows providing the PTE resource.
> >>>
> >>> Add an API which architectures can define their specific implementations
> >>> to detect if the PTE soft-dirty bit is available, on which the kernel
> >>> is running.
> >>>
> >>> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> >>> ---
> >>>    fs/proc/task_mmu.c      | 17 ++++++++++++++++-
> >>>    include/linux/pgtable.h | 10 ++++++++++
> >>>    mm/debug_vm_pgtable.c   |  9 +++++----
> >>>    mm/huge_memory.c        | 10 ++++++----
> >>>    mm/internal.h           |  2 +-
> >>>    mm/mremap.c             | 10 ++++++----
> >>>    mm/userfaultfd.c        |  6 ++++--
> >>>    7 files changed, 48 insertions(+), 16 deletions(-)
> >>>
> >>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >>> index 29cca0e6d0ff..20a609ec1ba6 100644
> >>> --- a/fs/proc/task_mmu.c
> >>> +++ b/fs/proc/task_mmu.c
> >>> @@ -1058,7 +1058,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
> >>>         * -Werror=unterminated-string-initialization warning
> >>>         *  with GCC 15
> >>>         */
> >>> -     static const char mnemonics[BITS_PER_LONG][3] = {
> >>> +     static char mnemonics[BITS_PER_LONG][3] = {
> >>>                /*
> >>>                 * In case if we meet a flag we don't know about.
> >>>                 */
> >>> @@ -1129,6 +1129,16 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
> >>>                [ilog2(VM_SEALED)] = "sl",
> >>>    #endif
> >>>        };
> >>> +/*
> >>> + * We should remove the VM_SOFTDIRTY flag if the PTE soft-dirty bit is
> >>> + * unavailable on which the kernel is running, even if the architecture
> >>> + * allows providing the PTE resource and soft-dirty is compiled in.
> >>> + */
> >>> +#ifdef CONFIG_MEM_SOFT_DIRTY
> >>> +     if (!pte_soft_dirty_available())
> >>> +             mnemonics[ilog2(VM_SOFTDIRTY)][0] = 0;
> >>> +#endif
> >>> +
> >>>        size_t i;
> >>>
> >>>        seq_puts(m, "VmFlags: ");
> >>> @@ -1531,6 +1541,8 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
> >>>    static inline void clear_soft_dirty(struct vm_area_struct *vma,
> >>>                unsigned long addr, pte_t *pte)
> >>>    {
> >>> +     if (!pte_soft_dirty_available())
> >>> +             return;
> >>>        /*
> >>>         * The soft-dirty tracker uses #PF-s to catch writes
> >>>         * to pages, so write-protect the pte as well. See the
> >>> @@ -1566,6 +1578,9 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
> >>>    {
> >>>        pmd_t old, pmd = *pmdp;
> >>>
> >>> +     if (!pte_soft_dirty_available())
> >>> +             return;
> >>> +
> >>>        if (pmd_present(pmd)) {
> >>>                /* See comment in change_huge_pmd() */
> >>>                old = pmdp_invalidate(vma, addr, pmdp);
> >>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >>> index 4c035637eeb7..c0e2a6dc69f4 100644
> >>> --- a/include/linux/pgtable.h
> >>> +++ b/include/linux/pgtable.h
> >>> @@ -1538,6 +1538,15 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
> >>>    #endif
> >>>
> >>>    #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
> >>> +
> >>> +/*
> >>> + * Some platforms can customize the PTE soft dirty bit and make it unavailable
> >>> + * even if the architecture allows providing the PTE resource.
> >>> + */
> >>> +#ifndef pte_soft_dirty_available
> >>> +#define pte_soft_dirty_available()   (true)
> >>> +#endif
> >>> +
> >>>    #ifndef CONFIG_ARCH_ENABLE_THP_MIGRATION
> >>>    static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
> >>>    {
> >>> @@ -1555,6 +1564,7 @@ static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
> >>>    }
> >>>    #endif
> >>>    #else /* !CONFIG_HAVE_ARCH_SOFT_DIRTY */
> >>> +#define pte_soft_dirty_available()   (false)
> >>>    static inline int pte_soft_dirty(pte_t pte)
> >>>    {
> >>>        return 0;
> >>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> >>> index 830107b6dd08..98ed7e22ccec 100644
> >>> --- a/mm/debug_vm_pgtable.c
> >>> +++ b/mm/debug_vm_pgtable.c
> >>> @@ -690,7 +690,7 @@ static void __init pte_soft_dirty_tests(struct pgtable_debug_args *args)
> >>>    {
> >>>        pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
> >>>
> >>> -     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> >>> +     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) || !pte_soft_dirty_available())
> >>
> >> I suggest that you instead make pte_soft_dirty_available() be false without CONFIG_MEM_SOFT_DIRTY.
> >>
> >> e.g., for the default implementation
> >>
> >> define pte_soft_dirty_available()       IS_ENABLED(CONFIG_MEM_SOFT_DIRTY)
> >>
> >> That way you can avoid some ifefs and cleanup these checks.
> >
> > Do you mean something like this:
> >
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -1538,6 +1538,16 @@ static inline pgprot_t pgprot_modify(pgprot_t
> > oldprot, pgprot_t newprot)
> >   #endif
> >
> >   #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
> > +#ifndef arch_soft_dirty_available
> > +#define arch_soft_dirty_available()     (true)
> > +#endif
> > +#define pgtable_soft_dirty_supported()
> > (IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) && arch_soft_dirty_available())
> > +
> >   #ifndef CONFIG_ARCH_ENABLE_THP_MIGRATION
> >   static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
> >   {
> > @@ -1555,6 +1565,7 @@ static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
> >   }
> >   #endif
> >   #else /* !CONFIG_HAVE_ARCH_SOFT_DIRTY */
> > +#define pgtable_soft_dirty_supported() (false)
>
> Maybe we can simplify to
>
> #ifndef pgtable_soft_dirty_supported
> #define pgtable_soft_dirty_supported()  IS_ENABLED(CONFIG_MEM_SOFT_DIRTY)
> #endif
>
> And then just let the arch that overrides this function just make it
> respect IS_ENABLED(CONFIG_MEM_SOFT_DIRTY).

Ok, got you, I will address it.

Thanks for your review,
Chunyan


>
> --
> Cheers
>
> David / dhildenb
>

