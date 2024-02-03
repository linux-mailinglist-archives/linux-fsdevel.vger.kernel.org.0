Return-Path: <linux-fsdevel+bounces-10114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1B4847E45
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 02:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FE31C2221B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 01:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705F45396;
	Sat,  3 Feb 2024 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IeFepvAY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AFD53AC
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Feb 2024 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706925179; cv=none; b=owMKtpYXP0ffOCuJKIRX/bGXMJSvWx7FyvV2+F2nLrbqJNUuSFUdQbGWgWYj/cZi0KyEq6hprKNpYpLjzTO0nFLtnHNYyp23VBQzna8y11oo6bttinEpVvtdd6GvoSA2MvYEvTOnwyGmAxVGn7+NJML3ml9v3qsyLQpoL3LNkVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706925179; c=relaxed/simple;
	bh=RYrVK0Xsga3mJrFF6r9v4P5u7C5IlYcrgGXk0OMY6xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9chHLOGTpoVD5iWaMiUqX199icF6DUW5ZhvC885NA/AVIgryIvvFOXB8Gv2QK8H2KFlpmGAnEukXJ3VGYo+OJmw4yv9q7UahKyLrx5agL04LfhOiLmdN+g2PKlIYHf2bwjz43Hr+Ms+qi4K4zcncMVBkoUlQTtLbgEm6hKyZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IeFepvAY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d89f0ab02bso31855ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 17:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706925177; x=1707529977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YVUYItchskiPiFVr3towSzyXMqcpKnO7KFVbDujDv0=;
        b=IeFepvAYWpzuiTT5EJKCxrVUTVWBsS0uU5H6OR/q98DH1Q05k6vNdQ7vRz3HFZTMO+
         FFDFXaHN5JRT+1+X3LXGYiVMhZ5SbNcadSlgszO9YgCjESBssJKinBPMSOh3PRnv/gE3
         dj7q+9yejQSMzNJM7WlIfGjj7buBikacv5QTUNEgT8dw9xWWYfYRaqTA+qh0jDbxA4l3
         wBIt42J+ll1pBLFveyV5guw6LWgzY7BadWqZOTzjObwgEOx4ebCHV4fndr6wLZPY9P3g
         KtwHqDiA3oA307KcTeRKnqL7DzdCNh8+Or2liN/GDuWfHERbibB2/7+DCwMdYUGwpHt0
         IBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706925177; x=1707529977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YVUYItchskiPiFVr3towSzyXMqcpKnO7KFVbDujDv0=;
        b=SOM4LW+05gKr6ZXOj/HcDr4jK0Sk7PnPxWP8R+cdzpKykSnybf/G/vZ+mhaZ52NyFW
         ZjG6IU258vpM//iFysnXDlaNWJSjiHUYHrOOi82eWgLWP/mitnak22TjBBorApfhuad9
         3oXFIwLzYqg0YV3uv4cBxbTJQFcVRLjh1W7Vb1lmgFekig22QhzjlVBnuLpD1+Sdogcy
         H700HQZsPdRo7K6nXjaaCoc6dg9NMZOoA/Fxjq8gPcLC0Jm0DAbbLEjnJFQiPbGMNI92
         +fGrM5IbOOjiWvzaMQirNpg5yUBuiTsbFLUPeNfaYmASf7cGrfky631X7YH+XEy1nyek
         mG+Q==
X-Gm-Message-State: AOJu0Yw+My6FGu6Pb7Czow0YqUuuIY57h8aaYFFl3t5O57onP/hZ++J7
	UAhzPdNhWxIE+o+DD+UTArDUVH0IVsaOgiXPTV9LTIqhDxTOcOha2TRbFqjJ6A8gPYPs6wK3Y6b
	A7vdJHDC9UR/0nX0afrOc1f8OjrwxGkUGj8cy
X-Google-Smtp-Source: AGHT+IERC5pdHUOjk0sdXzYQIgHtEgfci2NbTryKwg65YkKqVaH9pjKs6GAU0hV+Ubl7fWQznML7tY3Dh7lY8X5xTXw=
X-Received: by 2002:a17:902:e750:b0:1d7:6ebd:3867 with SMTP id
 p16-20020a170902e75000b001d76ebd3867mr61710plf.1.1706925176905; Fri, 02 Feb
 2024 17:52:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-29-alexandru.elisei@arm.com> <CAMn1gO7M51QtxPxkRO3ogH1zasd2-vErWqoPTqGoPiEvr8Pvcw@mail.gmail.com>
 <Zb0CRYSmQxJ_N4Sr@raptor>
In-Reply-To: <Zb0CRYSmQxJ_N4Sr@raptor>
From: Peter Collingbourne <pcc@google.com>
Date: Fri, 2 Feb 2024 17:52:45 -0800
Message-ID: <CAMn1gO5H6A71zEHLzPyuDfF5xaeej_Q2eCb54jeJ8eAG=yVgiA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 28/35] arm64: mte: swap: Handle tag restoring when
 missing tag storage
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

On Fri, Feb 2, 2024 at 6:56=E2=80=AFAM Alexandru Elisei
<alexandru.elisei@arm.com> wrote:
>
> Hi Peter,
>
> On Thu, Feb 01, 2024 at 08:02:40PM -0800, Peter Collingbourne wrote:
> > On Thu, Jan 25, 2024 at 8:45=E2=80=AFAM Alexandru Elisei
> > <alexandru.elisei@arm.com> wrote:
> > >
> > > Linux restores tags when a page is swapped in and there are tags asso=
ciated
> > > with the swap entry which the new page will replace. The saved tags a=
re
> > > restored even if the page will not be mapped as tagged, to protect ag=
ainst
> > > cases where the page is shared between different VMAs, and is tagged =
in
> > > some, but untagged in others. By using this approach, the process can=
 still
> > > access the correct tags following an mprotect(PROT_MTE) on the non-MT=
E
> > > enabled VMA.
> > >
> > > But this poses a challenge for managing tag storage: in the scenario =
above,
> > > when a new page is allocated to be swapped in for the process where i=
t will
> > > be mapped as untagged, the corresponding tag storage block is not res=
erved.
> > > mte_restore_page_tags_by_swp_entry(), when it restores the saved tags=
, will
> > > overwrite data in the tag storage block associated with the new page,
> > > leading to data corruption if the block is in use by a process.
> > >
> > > Get around this issue by saving the tags in a new xarray, this time i=
ndexed
> > > by the page pfn, and then restoring them when tag storage is reserved=
 for
> > > the page.
> > >
> > > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > > ---
> > >
> > > Changes since rfc v2:
> > >
> > > * Restore saved tags **before** setting the PG_tag_storage_reserved b=
it to
> > > eliminate a brief window of opportunity where userspace can access un=
initialized
> > > tags (Peter Collingbourne).
> > >
> > >  arch/arm64/include/asm/mte_tag_storage.h |   8 ++
> > >  arch/arm64/include/asm/pgtable.h         |  11 +++
> > >  arch/arm64/kernel/mte_tag_storage.c      |  12 ++-
> > >  arch/arm64/mm/mteswap.c                  | 110 +++++++++++++++++++++=
++
> > >  4 files changed, 140 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/in=
clude/asm/mte_tag_storage.h
> > > index 50bdae94cf71..40590a8c3748 100644
> > > --- a/arch/arm64/include/asm/mte_tag_storage.h
> > > +++ b/arch/arm64/include/asm/mte_tag_storage.h
> > > @@ -36,6 +36,14 @@ bool page_is_tag_storage(struct page *page);
> > >
> > >  vm_fault_t handle_folio_missing_tag_storage(struct folio *folio, str=
uct vm_fault *vmf,
> > >                                             bool *map_pte);
> > > +vm_fault_t mte_try_transfer_swap_tags(swp_entry_t entry, struct page=
 *page);
> > > +
> > > +void tags_by_pfn_lock(void);
> > > +void tags_by_pfn_unlock(void);
> > > +
> > > +void *mte_erase_tags_for_pfn(unsigned long pfn);
> > > +bool mte_save_tags_for_pfn(void *tags, unsigned long pfn);
> > > +void mte_restore_tags_for_pfn(unsigned long start_pfn, int order);
> > >  #else
> > >  static inline bool tag_storage_enabled(void)
> > >  {
> > > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/as=
m/pgtable.h
> > > index 0174e292f890..87ae59436162 100644
> > > --- a/arch/arm64/include/asm/pgtable.h
> > > +++ b/arch/arm64/include/asm/pgtable.h
> > > @@ -1085,6 +1085,17 @@ static inline void arch_swap_invalidate_area(i=
nt type)
> > >                 mte_invalidate_tags_area_by_swp_entry(type);
> > >  }
> > >
> > > +#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> > > +#define __HAVE_ARCH_SWAP_PREPARE_TO_RESTORE
> > > +static inline vm_fault_t arch_swap_prepare_to_restore(swp_entry_t en=
try,
> > > +                                                     struct folio *f=
olio)
> > > +{
> > > +       if (tag_storage_enabled())
> > > +               return mte_try_transfer_swap_tags(entry, &folio->page=
);
> > > +       return 0;
> > > +}
> > > +#endif
> > > +
> > >  #define __HAVE_ARCH_SWAP_RESTORE
> > >  static inline void arch_swap_restore(swp_entry_t entry, struct folio=
 *folio)
> > >  {
> > > diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/=
mte_tag_storage.c
> > > index afe2bb754879..ac7b9c9c585c 100644
> > > --- a/arch/arm64/kernel/mte_tag_storage.c
> > > +++ b/arch/arm64/kernel/mte_tag_storage.c
> > > @@ -567,6 +567,7 @@ int reserve_tag_storage(struct page *page, int or=
der, gfp_t gfp)
> > >                 }
> > >         }
> > >
> > > +       mte_restore_tags_for_pfn(page_to_pfn(page), order);
> > >         page_set_tag_storage_reserved(page, order);
> > >  out_unlock:
> > >         mutex_unlock(&tag_blocks_lock);
> > > @@ -595,7 +596,8 @@ void free_tag_storage(struct page *page, int orde=
r)
> > >         struct tag_region *region;
> > >         unsigned long page_va;
> > >         unsigned long flags;
> > > -       int ret;
> > > +       void *tags;
> > > +       int i, ret;
> > >
> > >         ret =3D tag_storage_find_block(page, &start_block, &region);
> > >         if (WARN_ONCE(ret, "Missing tag storage block for pfn 0x%lx",=
 page_to_pfn(page)))
> > > @@ -605,6 +607,14 @@ void free_tag_storage(struct page *page, int ord=
er)
> > >         /* Avoid writeback of dirty tag cache lines corrupting data. =
*/
> > >         dcache_inval_tags_poc(page_va, page_va + (PAGE_SIZE << order)=
);
> > >
> > > +       tags_by_pfn_lock();
> > > +       for (i =3D 0; i < (1 << order); i++) {
> > > +               tags =3D mte_erase_tags_for_pfn(page_to_pfn(page + i)=
);
> > > +               if (unlikely(tags))
> > > +                       mte_free_tag_buf(tags);
> > > +       }
> > > +       tags_by_pfn_unlock();
> > > +
> > >         end_block =3D start_block + order_to_num_blocks(order, region=
->block_size_pages);
> > >
> > >         xa_lock_irqsave(&tag_blocks_reserved, flags);
> > > diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> > > index 2a43746b803f..e11495fa3c18 100644
> > > --- a/arch/arm64/mm/mteswap.c
> > > +++ b/arch/arm64/mm/mteswap.c
> > > @@ -20,6 +20,112 @@ void mte_free_tag_buf(void *buf)
> > >         kfree(buf);
> > >  }
> > >
> > > +#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> > > +static DEFINE_XARRAY(tags_by_pfn);
> > > +
> > > +void tags_by_pfn_lock(void)
> > > +{
> > > +       xa_lock(&tags_by_pfn);
> > > +}
> > > +
> > > +void tags_by_pfn_unlock(void)
> > > +{
> > > +       xa_unlock(&tags_by_pfn);
> > > +}
> > > +
> > > +void *mte_erase_tags_for_pfn(unsigned long pfn)
> > > +{
> > > +       return __xa_erase(&tags_by_pfn, pfn);
> > > +}
> > > +
> > > +bool mte_save_tags_for_pfn(void *tags, unsigned long pfn)
> > > +{
> > > +       void *entry;
> > > +       int ret;
> > > +
> > > +       ret =3D xa_reserve(&tags_by_pfn, pfn, GFP_KERNEL);
> >
> > copy_highpage can be called from an atomic context, so it isn't
> > currently valid to pass GFP_KERNEL here.
> >
> > To give one example of a possible atomic context call, copy_pte_range
> > will take a PTE spinlock and can call copy_present_pte, which can call
> > copy_present_page, which will call copy_user_highpage.
> >
> > To give another example, __buffer_migrate_folio can call
> > spin_lock(&mapping->private_lock), then call folio_migrate_copy, which
> > will call folio_copy.
>
> That is very unfortunate from my part. I distinctly remember looking
> precisely at copy_page_range() to double check that it doesn't call
> copy_*highpage() from an atomic context, I can only assume that I missed
> that it's called with the ptl lock held.
>
> With your two examples, and the khugepaged case in patch #31 ("khugepaged=
:
> arm64: Don't collapse MTE enabled VMAs"), it's crystal clear that the
> convention for copy_*highpage() is that the function cannot sleep.
>
> There are two issues here: allocating the buffer in memory where the tags
> will be copied, and xarray allocating memory for a new entry.
>
> One fix would be to allocate an entire page with __GFP_ATOMIC, and use th=
at
> as a cache for tag buffers (storing the tags for a page uses 1/32th of a
> page). From what little I know about xarray, xarray stores would still ha=
ve
> to be GFP_ATOMIC. This should fix the sleeping in atomic context bug. But
> the issue I see with this is that a memory allocation can fail, while
> copy_*highpage() cannot. Send a fatal signal to the process if memory
> allocation fails?

Right, I think I'd have stability concerns about an approach like this.

> Another approach would be to preallocate memory in a preemptible context,
> something like copy_*highpage_prepare(), but that would mean a lot more
> work: finding all the places where copy_*highpage is used and add
> copy_*highpage_prepare() outside the critical section, releasing the memo=
ry
> in case of failure (like in the copy_pte_range() case - maybe
> copy_*highpage_end()?). That's a pretty big maintenance burden for the MM
> code. Although maybe other architectures can find a use for it?

This one might not be too bad. There are only a handful of calls to
this function, so it might not be a major ongoing burden. We can
implement copy_highpage() like this:

copy_highpage() {
  might_sleep();
  copy_highpage_atomic();
}

rename the existing implementations to copy_highpage_atomic() and
change atomic context callers to call copy_highpage_atomic(). That
way, kernels with CONFIG_DEBUG_ATOMIC_SLEEP will detect errors on all
architectures. Then in a later patch, introduce
copy_highpage_prepare() (or whatever) and update the
copy_highpage_atomic() callers.

Peter

> And yet another approach is reserve the needed memory (for the buffer and
> in the xarray) when the page is allocated, if it doesn't have tag storage
> reserved, regardless of the page being allocated as tagged or not. Then i=
n
> set_pte_at() free this memory if it's unused. But this would mean reservi=
ng
> memory for possibly all memory allocations in the system (including for t=
ag
> storage pages) if userspace doesn't use tags at all, though not all pages
> in the system will have this memory reserved at the same time. Pretty big
> downside.
>
> Out of the three, I prefer the first, but it's definitely not perfect. I'=
ll
> try to think of something else, maybe I can come up with something better=
.
>
> What are your thoughts?
>
> Thanks,
> Alex
>
> >
> > Peter
> >
> > > +       if (ret)
> > > +               return true;
> > > +
> > > +       tags_by_pfn_lock();
> > > +
> > > +       if (page_tag_storage_reserved(pfn_to_page(pfn))) {
> > > +               xa_release(&tags_by_pfn, pfn);
> > > +               tags_by_pfn_unlock();
> > > +               return false;
> > > +       }
> > > +
> > > +       entry =3D __xa_store(&tags_by_pfn, pfn, tags, GFP_ATOMIC);
> > > +       if (xa_is_err(entry)) {
> > > +               xa_release(&tags_by_pfn, pfn);
> > > +               goto out_unlock;
> > > +       } else if (entry) {
> > > +               mte_free_tag_buf(entry);
> > > +       }
> > > +
> > > +out_unlock:
> > > +       tags_by_pfn_unlock();
> > > +       return true;
> > > +}
> > > +
> > > +void mte_restore_tags_for_pfn(unsigned long start_pfn, int order)
> > > +{
> > > +       struct page *page =3D pfn_to_page(start_pfn);
> > > +       unsigned long pfn;
> > > +       void *tags;
> > > +
> > > +       tags_by_pfn_lock();
> > > +
> > > +       for (pfn =3D start_pfn; pfn < start_pfn + (1 << order); pfn++=
, page++) {
> > > +               tags =3D mte_erase_tags_for_pfn(pfn);
> > > +               if (unlikely(tags)) {
> > > +                       /*
> > > +                        * Mark the page as tagged so mte_sync_tags()=
 doesn't
> > > +                        * clear the tags.
> > > +                        */
> > > +                       WARN_ON_ONCE(!try_page_mte_tagging(page));
> > > +                       mte_copy_page_tags_from_buf(page_address(page=
), tags);
> > > +                       set_page_mte_tagged(page);
> > > +                       mte_free_tag_buf(tags);
> > > +               }
> > > +       }
> > > +
> > > +       tags_by_pfn_unlock();
> > > +}
> > > +
> > > +/*
> > > + * Note on locking: swap in/out is done with the folio locked, which=
 eliminates
> > > + * races with mte_save/restore_page_tags_by_swp_entry.
> > > + */
> > > +vm_fault_t mte_try_transfer_swap_tags(swp_entry_t entry, struct page=
 *page)
> > > +{
> > > +       void *swap_tags, *pfn_tags;
> > > +       bool saved;
> > > +
> > > +       /*
> > > +        * mte_restore_page_tags_by_swp_entry() will take care of cop=
ying the
> > > +        * tags over.
> > > +        */
> > > +       if (likely(page_mte_tagged(page) || page_tag_storage_reserved=
(page)))
> > > +               return 0;
> > > +
> > > +       swap_tags =3D xa_load(&tags_by_swp_entry, entry.val);
> > > +       if (!swap_tags)
> > > +               return 0;
> > > +
> > > +       pfn_tags =3D mte_allocate_tag_buf();
> > > +       if (!pfn_tags)
> > > +               return VM_FAULT_OOM;
> > > +
> > > +       memcpy(pfn_tags, swap_tags, MTE_PAGE_TAG_STORAGE_SIZE);
> > > +       saved =3D mte_save_tags_for_pfn(pfn_tags, page_to_pfn(page));
> > > +       if (!saved)
> > > +               mte_free_tag_buf(pfn_tags);
> > > +
> > > +       return 0;
> > > +}
> > > +#endif
> > > +
> > >  int mte_save_page_tags_by_swp_entry(struct page *page)
> > >  {
> > >         void *tags, *ret;
> > > @@ -54,6 +160,10 @@ void mte_restore_page_tags_by_swp_entry(swp_entry=
_t entry, struct page *page)
> > >         if (!tags)
> > >                 return;
> > >
> > > +       /* Tags will be restored when tag storage is reserved. */
> > > +       if (tag_storage_enabled() && unlikely(!page_tag_storage_reser=
ved(page)))
> > > +               return;
> > > +
> > >         if (try_page_mte_tagging(page)) {
> > >                 mte_copy_page_tags_from_buf(page_address(page), tags)=
;
> > >                 set_page_mte_tagged(page);
> > > --
> > > 2.43.0
> > >

