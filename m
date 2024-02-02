Return-Path: <linux-fsdevel+bounces-9956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 280C88466B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 05:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08FD8B21D2B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 04:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1399DF41;
	Fri,  2 Feb 2024 04:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jK5oTfmi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A23AF50D
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706846576; cv=none; b=mf+9f8y5LB76neKYbQPjt63MOz0U/zFgrvqRVzfBpJn96z6o66UCtaSKISjsOAxqleRPTl6rbbjsv1/3mbT9sdPpyuK+G8g/hNIEADJG+EoOVwgC5YyoYY8QoQo38U8M/DYHm1HlM+ell0KjcU9ZJTJm8QhVAXm2MsHwmvkmmMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706846576; c=relaxed/simple;
	bh=KikoRp16kk3HUQ3cz6e+KSBIyTpcvef+zDkRtLkKw4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGbyc8eABVTE6BNDGcgsSO5h0+1zS7j+VqovbO+ckJU3fcWJG7EMd7aLLeOaP/WlhreECrMeq9Haib9SbkN7sv8JdLSwaS82h5HDNVupBNevN1MYono6ziEZx+B0KjYsH2u9KPLgwhC32Nt5LPeR0G+pZdYmGEJBsTXTZ8KK29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jK5oTfmi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d5ce88b51cso112325ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 20:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706846574; x=1707451374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFJqfnpRCM1VqQTQw/nonDO6j9S3/xW4X7YVXfU/LVQ=;
        b=jK5oTfmi7SWu6CP2Wwiin2qgatH/MRXJExWPlOPUmN20d2v566a1mvF6zV19gLM8Lw
         1xIyRKakQSLJKbjbmxT45ibAH7C2mHJVvQ7XBLtBFJJHf1tBGdG3QxyWIjhNO8ltD/AI
         dpl9q0IVvjKF+L56yZLEeeQLgF2syuWm2U4Oz8MSjbTbLMd+m2zgT+hmQD7fNMSb0/IG
         4x6rPUuGiAaGa/EBejiPqOxVTKVzjQB5RcOnf6/++HRA++iJQq0xDbOOcHAMQHl221vY
         Z7HOA5ag+dGET5johDCIKCwn3tiKa8V01ytHV9mkkthyI9Sy7gnd6INDoZuHON4TwTC6
         dpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706846574; x=1707451374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFJqfnpRCM1VqQTQw/nonDO6j9S3/xW4X7YVXfU/LVQ=;
        b=B2Sr3QPmsvZg9LPiewtFuji6G5n+Nloe+NLiPPwcdQC2Nb9Oty1pMj/XV4jAmfK1se
         dZwKLs+IMc9mtRBZ/sG/KM7SHCYNLDOKJYX8rqZd/L3CHFdZC6274nOU4zUQ42+lW+Jv
         UQIUOv3yRnVd9AOQ6Xmy+C5Za4KH8VKSiiM65FVwecdBp/dkuv/rTtg4KkIUMS8Fkm96
         kkdpfd0mmwJcXDPQ+NHk6Qwd8iTbz4YC4Ge/bKfTg3+jVNIoHKRMeKis103yzL+rXiJ9
         9tehN0AfWykFm0/E3Jl4dP6vnZQAfxrSg/y+zdKuaWWLNfE9KJW+JRrffZGxDkC9rcH0
         Q0/Q==
X-Gm-Message-State: AOJu0YxILGB8f6Nbyz4TWwznAVJqrRH7cSFg6TqIDiIoYTvyH2L4FiAS
	FKAixR6SrLJyzj4A8cZbxCMOBF8e4F5JbwsAs8JSgOxx9qsfgfE0Dy6CGT6uZpTs24+K7gpe68+
	sNG/vf8oNB20iXmSgoYRVSzZf71VcKpHPKMe+
X-Google-Smtp-Source: AGHT+IHNdARZNWgrLAHaHq/bbR2IKOvaETBe+RFLk+CFfCXPML9rH0oDYlYlP9TWnJMBqc7eyBYwkFLTKF4GMzsdKDQ=
X-Received: by 2002:a17:903:32d2:b0:1d8:d6bf:145b with SMTP id
 i18-20020a17090332d200b001d8d6bf145bmr62172plr.15.1706846573457; Thu, 01 Feb
 2024 20:02:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125164256.4147-1-alexandru.elisei@arm.com> <20240125164256.4147-29-alexandru.elisei@arm.com>
In-Reply-To: <20240125164256.4147-29-alexandru.elisei@arm.com>
From: Peter Collingbourne <pcc@google.com>
Date: Thu, 1 Feb 2024 20:02:40 -0800
Message-ID: <CAMn1gO7M51QtxPxkRO3ogH1zasd2-vErWqoPTqGoPiEvr8Pvcw@mail.gmail.com>
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

On Thu, Jan 25, 2024 at 8:45=E2=80=AFAM Alexandru Elisei
<alexandru.elisei@arm.com> wrote:
>
> Linux restores tags when a page is swapped in and there are tags associat=
ed
> with the swap entry which the new page will replace. The saved tags are
> restored even if the page will not be mapped as tagged, to protect agains=
t
> cases where the page is shared between different VMAs, and is tagged in
> some, but untagged in others. By using this approach, the process can sti=
ll
> access the correct tags following an mprotect(PROT_MTE) on the non-MTE
> enabled VMA.
>
> But this poses a challenge for managing tag storage: in the scenario abov=
e,
> when a new page is allocated to be swapped in for the process where it wi=
ll
> be mapped as untagged, the corresponding tag storage block is not reserve=
d.
> mte_restore_page_tags_by_swp_entry(), when it restores the saved tags, wi=
ll
> overwrite data in the tag storage block associated with the new page,
> leading to data corruption if the block is in use by a process.
>
> Get around this issue by saving the tags in a new xarray, this time index=
ed
> by the page pfn, and then restoring them when tag storage is reserved for
> the page.
>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>
> Changes since rfc v2:
>
> * Restore saved tags **before** setting the PG_tag_storage_reserved bit t=
o
> eliminate a brief window of opportunity where userspace can access uninit=
ialized
> tags (Peter Collingbourne).
>
>  arch/arm64/include/asm/mte_tag_storage.h |   8 ++
>  arch/arm64/include/asm/pgtable.h         |  11 +++
>  arch/arm64/kernel/mte_tag_storage.c      |  12 ++-
>  arch/arm64/mm/mteswap.c                  | 110 +++++++++++++++++++++++
>  4 files changed, 140 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/includ=
e/asm/mte_tag_storage.h
> index 50bdae94cf71..40590a8c3748 100644
> --- a/arch/arm64/include/asm/mte_tag_storage.h
> +++ b/arch/arm64/include/asm/mte_tag_storage.h
> @@ -36,6 +36,14 @@ bool page_is_tag_storage(struct page *page);
>
>  vm_fault_t handle_folio_missing_tag_storage(struct folio *folio, struct =
vm_fault *vmf,
>                                             bool *map_pte);
> +vm_fault_t mte_try_transfer_swap_tags(swp_entry_t entry, struct page *pa=
ge);
> +
> +void tags_by_pfn_lock(void);
> +void tags_by_pfn_unlock(void);
> +
> +void *mte_erase_tags_for_pfn(unsigned long pfn);
> +bool mte_save_tags_for_pfn(void *tags, unsigned long pfn);
> +void mte_restore_tags_for_pfn(unsigned long start_pfn, int order);
>  #else
>  static inline bool tag_storage_enabled(void)
>  {
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
> index 0174e292f890..87ae59436162 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1085,6 +1085,17 @@ static inline void arch_swap_invalidate_area(int t=
ype)
>                 mte_invalidate_tags_area_by_swp_entry(type);
>  }
>
> +#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> +#define __HAVE_ARCH_SWAP_PREPARE_TO_RESTORE
> +static inline vm_fault_t arch_swap_prepare_to_restore(swp_entry_t entry,
> +                                                     struct folio *folio=
)
> +{
> +       if (tag_storage_enabled())
> +               return mte_try_transfer_swap_tags(entry, &folio->page);
> +       return 0;
> +}
> +#endif
> +
>  #define __HAVE_ARCH_SWAP_RESTORE
>  static inline void arch_swap_restore(swp_entry_t entry, struct folio *fo=
lio)
>  {
> diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_=
tag_storage.c
> index afe2bb754879..ac7b9c9c585c 100644
> --- a/arch/arm64/kernel/mte_tag_storage.c
> +++ b/arch/arm64/kernel/mte_tag_storage.c
> @@ -567,6 +567,7 @@ int reserve_tag_storage(struct page *page, int order,=
 gfp_t gfp)
>                 }
>         }
>
> +       mte_restore_tags_for_pfn(page_to_pfn(page), order);
>         page_set_tag_storage_reserved(page, order);
>  out_unlock:
>         mutex_unlock(&tag_blocks_lock);
> @@ -595,7 +596,8 @@ void free_tag_storage(struct page *page, int order)
>         struct tag_region *region;
>         unsigned long page_va;
>         unsigned long flags;
> -       int ret;
> +       void *tags;
> +       int i, ret;
>
>         ret =3D tag_storage_find_block(page, &start_block, &region);
>         if (WARN_ONCE(ret, "Missing tag storage block for pfn 0x%lx", pag=
e_to_pfn(page)))
> @@ -605,6 +607,14 @@ void free_tag_storage(struct page *page, int order)
>         /* Avoid writeback of dirty tag cache lines corrupting data. */
>         dcache_inval_tags_poc(page_va, page_va + (PAGE_SIZE << order));
>
> +       tags_by_pfn_lock();
> +       for (i =3D 0; i < (1 << order); i++) {
> +               tags =3D mte_erase_tags_for_pfn(page_to_pfn(page + i));
> +               if (unlikely(tags))
> +                       mte_free_tag_buf(tags);
> +       }
> +       tags_by_pfn_unlock();
> +
>         end_block =3D start_block + order_to_num_blocks(order, region->bl=
ock_size_pages);
>
>         xa_lock_irqsave(&tag_blocks_reserved, flags);
> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> index 2a43746b803f..e11495fa3c18 100644
> --- a/arch/arm64/mm/mteswap.c
> +++ b/arch/arm64/mm/mteswap.c
> @@ -20,6 +20,112 @@ void mte_free_tag_buf(void *buf)
>         kfree(buf);
>  }
>
> +#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
> +static DEFINE_XARRAY(tags_by_pfn);
> +
> +void tags_by_pfn_lock(void)
> +{
> +       xa_lock(&tags_by_pfn);
> +}
> +
> +void tags_by_pfn_unlock(void)
> +{
> +       xa_unlock(&tags_by_pfn);
> +}
> +
> +void *mte_erase_tags_for_pfn(unsigned long pfn)
> +{
> +       return __xa_erase(&tags_by_pfn, pfn);
> +}
> +
> +bool mte_save_tags_for_pfn(void *tags, unsigned long pfn)
> +{
> +       void *entry;
> +       int ret;
> +
> +       ret =3D xa_reserve(&tags_by_pfn, pfn, GFP_KERNEL);

copy_highpage can be called from an atomic context, so it isn't
currently valid to pass GFP_KERNEL here.

To give one example of a possible atomic context call, copy_pte_range
will take a PTE spinlock and can call copy_present_pte, which can call
copy_present_page, which will call copy_user_highpage.

To give another example, __buffer_migrate_folio can call
spin_lock(&mapping->private_lock), then call folio_migrate_copy, which
will call folio_copy.

Peter

> +       if (ret)
> +               return true;
> +
> +       tags_by_pfn_lock();
> +
> +       if (page_tag_storage_reserved(pfn_to_page(pfn))) {
> +               xa_release(&tags_by_pfn, pfn);
> +               tags_by_pfn_unlock();
> +               return false;
> +       }
> +
> +       entry =3D __xa_store(&tags_by_pfn, pfn, tags, GFP_ATOMIC);
> +       if (xa_is_err(entry)) {
> +               xa_release(&tags_by_pfn, pfn);
> +               goto out_unlock;
> +       } else if (entry) {
> +               mte_free_tag_buf(entry);
> +       }
> +
> +out_unlock:
> +       tags_by_pfn_unlock();
> +       return true;
> +}
> +
> +void mte_restore_tags_for_pfn(unsigned long start_pfn, int order)
> +{
> +       struct page *page =3D pfn_to_page(start_pfn);
> +       unsigned long pfn;
> +       void *tags;
> +
> +       tags_by_pfn_lock();
> +
> +       for (pfn =3D start_pfn; pfn < start_pfn + (1 << order); pfn++, pa=
ge++) {
> +               tags =3D mte_erase_tags_for_pfn(pfn);
> +               if (unlikely(tags)) {
> +                       /*
> +                        * Mark the page as tagged so mte_sync_tags() doe=
sn't
> +                        * clear the tags.
> +                        */
> +                       WARN_ON_ONCE(!try_page_mte_tagging(page));
> +                       mte_copy_page_tags_from_buf(page_address(page), t=
ags);
> +                       set_page_mte_tagged(page);
> +                       mte_free_tag_buf(tags);
> +               }
> +       }
> +
> +       tags_by_pfn_unlock();
> +}
> +
> +/*
> + * Note on locking: swap in/out is done with the folio locked, which eli=
minates
> + * races with mte_save/restore_page_tags_by_swp_entry.
> + */
> +vm_fault_t mte_try_transfer_swap_tags(swp_entry_t entry, struct page *pa=
ge)
> +{
> +       void *swap_tags, *pfn_tags;
> +       bool saved;
> +
> +       /*
> +        * mte_restore_page_tags_by_swp_entry() will take care of copying=
 the
> +        * tags over.
> +        */
> +       if (likely(page_mte_tagged(page) || page_tag_storage_reserved(pag=
e)))
> +               return 0;
> +
> +       swap_tags =3D xa_load(&tags_by_swp_entry, entry.val);
> +       if (!swap_tags)
> +               return 0;
> +
> +       pfn_tags =3D mte_allocate_tag_buf();
> +       if (!pfn_tags)
> +               return VM_FAULT_OOM;
> +
> +       memcpy(pfn_tags, swap_tags, MTE_PAGE_TAG_STORAGE_SIZE);
> +       saved =3D mte_save_tags_for_pfn(pfn_tags, page_to_pfn(page));
> +       if (!saved)
> +               mte_free_tag_buf(pfn_tags);
> +
> +       return 0;
> +}
> +#endif
> +
>  int mte_save_page_tags_by_swp_entry(struct page *page)
>  {
>         void *tags, *ret;
> @@ -54,6 +160,10 @@ void mte_restore_page_tags_by_swp_entry(swp_entry_t e=
ntry, struct page *page)
>         if (!tags)
>                 return;
>
> +       /* Tags will be restored when tag storage is reserved. */
> +       if (tag_storage_enabled() && unlikely(!page_tag_storage_reserved(=
page)))
> +               return;
> +
>         if (try_page_mte_tagging(page)) {
>                 mte_copy_page_tags_from_buf(page_address(page), tags);
>                 set_page_mte_tagged(page);
> --
> 2.43.0
>

