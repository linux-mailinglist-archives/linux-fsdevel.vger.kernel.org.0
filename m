Return-Path: <linux-fsdevel+bounces-70590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B96CCA16F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 20:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 741E6301E18A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 19:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA44733508D;
	Wed,  3 Dec 2025 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SETysWOA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6730B52B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790899; cv=none; b=oU/tp6jU+9xMf4GV3fbd5FzMLEyGms2WBJLteBXwyIoJy7lmqq3Y1p5ShH8TeLVhO+HSrx39k0QNaC/OSmjP5dnN4l5jdlkmulgpXmK1miBY7A+uVSoo30qeIuTlaNJYP/tVbXdpX7dzjFW6QpgFwWLa2R+LmtpPXjXMOJZv5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790899; c=relaxed/simple;
	bh=s6K1RIyDnjHwEp8AhYzUg37uKwn6FJ/2r45je3CiZH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dY1GXRnV1OXlRMjgvSJ3K7Dwha7f6jrJzK61aqeHfYv1f8X5dHElD6veh6Gf48Y1tdHZVVtapHDLNJ6DwaxBrRfAVAe2wgc/pXRx8by9zzMTwdWv+7VPB4qSTiuLaydKDELM3ZdQWehvPHvDutAaNxpTggMLDcXSNdhA6d4s9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SETysWOA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779a4fb9bfso9815e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 11:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764790894; x=1765395694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyPoY0C6YT0XJBAp/sjT2rETGClfPwKOvPKccsKgBTs=;
        b=SETysWOAsSHk3TFBvW3mlhEGaqsVuNjlOIt5Bc63pysP3SD/Pz3JBjmqVq/afavLPZ
         y/ycubJj1JPo9oWxkL/cjwBsy50WNI6PLsXdawcVPWP6q3Kho1dnJENp2ywVRL8X1hBv
         ZcdgZ4gmnEIyBnWiuZJ2irm2pe2FS7a3q87+MUeGT44OEK6EU3T24blKKwPXHYdGJbvH
         fKu9TlyJYe/xoLHgszXAaBT6H9vZSJDg2KkjrSQul7/PrQ4cHIXtmG7GWqTp9UX4Ys9e
         +sen68P0c6U4JCtxBhH21R/sRI0/xOtoSD/5ZAAkjs6IB3Gm1zlTl+QU2UnhlYi+/3/H
         Rjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764790894; x=1765395694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pyPoY0C6YT0XJBAp/sjT2rETGClfPwKOvPKccsKgBTs=;
        b=TZ9QQ3lEavWuJLygr/ZFbuZc6CVk7LQOyOHAOg859QD/RattVbNmbv2BSCZsdIH2lC
         jCEbtHY6MoPa7ULYUpHN84m5vyYxX5TcbJiy83XZoGTZuPbWstSK2aj2Eb+PXemeW/op
         gOXEtiD9Lr6N71BEiEEC1ynyoIg9ngjF+Qz5h7677BUTU6woNdxtSUUDfGTdLLVO6I31
         6HazinFD8/AYxhDNVP+9EhbISnf1uvrEJALXCK2ANaJDiC5Wv4i8ZHIrRBH8BvQHRIr5
         uE8oatxMdyNdoTAOhG2EhO6fVLS3O45XrYmzxDwhTEI47Ad58zBIeE6F9LTdMVql0jPA
         ODGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVUNZQQ4qON4Oy22lC5McQtAcas72FtkLlMpL51aOec1oKY7FRuSiKUi/y7eZx9x9wT0qgu+2AaBi4GDuK@vger.kernel.org
X-Gm-Message-State: AOJu0YxkOpNOzrYXew1mGsxZesa9jcCDmHQm29UXDdO0gq5PrWE8F0lG
	B1+dJ+ILsLTglean3giRou4Q9onn9bIu1QQGun9qpPKBXnpej5pAhjECrl7gZ/09AzZxGCvnHdp
	droH/1VoifAyXMkwPYdmXkVrqYSGmflIezDLswV3i
X-Gm-Gg: ASbGnctZQlcv7Dj+u63APtgNQo5oLUA9UNaZFYak1FNPhKX8Hs67GLWAGVes40kLglX
	AT7vc3lk6cPJ8cJdQa8/P6n++4nq7PZ6KjWvGbfbNwzKXzkHMg5P03QWNbHQwcT0393MCQfT4Xt
	aF56k9Wi4liitd+9rh3k+JOfKjrhIrqaR1nDaV+29hCVE8/W6d/y8h7guuKAg/HpWjbIo/2rzMF
	yCKDzDZEJyf/iydYJqxgSpYvSkZcnQ6tOLIzYWW3W8GRI78jcjX9jBA5ENlb8UdkXhYlIzC/wnz
	D/loR1/f+JUsOJWlV+r3SWjI
X-Google-Smtp-Source: AGHT+IHtDCV0vW277tKfqY0h57vjdp/K2RrhJGb3m3OEj+KNHrgeA2WFWP9Ceu6/i4toOpR78sBoznB0aAt2bTOmn5k=
X-Received: by 2002:a05:600c:a407:b0:477:b358:c0cc with SMTP id
 5b1f17b1804b1-4792f266f24mr69055e9.17.1764790893817; Wed, 03 Dec 2025
 11:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116013223.1557158-1-jiaqiyan@google.com> <20251116013223.1557158-2-jiaqiyan@google.com>
 <7aac28a9-e2d3-454d-bb6a-2110565f0907@oracle.com>
In-Reply-To: <7aac28a9-e2d3-454d-bb6a-2110565f0907@oracle.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Wed, 3 Dec 2025 11:41:21 -0800
X-Gm-Features: AWmQ_bnkwoQVASQwtsW5nkNLKCU2sqC5uYYC7VnAXq86KQpj4yFmn674pl-cG-o
Message-ID: <CACw3F53YAPggsFgqeTvETh_xBWeDZ5kmKpNdCcWMDXhcN=mZww@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm: memfd/hugetlb: introduce memfd-based userspace
 MFR policy
To: jane.chu@oracle.com, william.roche@oracle.com
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, harry.yoo@oracle.com, 
	tony.luck@intel.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	akpm@linux-foundation.org, osalvador@suse.de, rientjes@google.com, 
	duenwen@google.com, jthoughton@google.com, jgg@nvidia.com, ankita@nvidia.com, 
	peterx@redhat.com, sidhartha.kumar@oracle.com, ziy@nvidia.com, 
	david@redhat.com, dave.hansen@linux.intel.com, muchun.song@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 8:11=E2=80=AFPM <jane.chu@oracle.com> wrote:
>
> Hi, Jiaqi,
>
> Thanks for the work, my comments inline.

Thank you both for the thorough and helpful reviews, Jane and William!

I plan to first rework "[PATCH v1 0/2] Only free healthy pages in
high-order HWPoison folio", given it is the key to concerns you have
in this patch. Then I will address your comments on code
quality/readability for this patch.

>
> On 11/15/2025 5:32 PM, Jiaqi Yan wrote:
> > Sometimes immediately hard offlining a large chunk of contigous memory
> > having uncorrected memory errors (UE) may not be the best option.
> > Cloud providers usually serve capacity- and performance-critical guest
> > memory with 1G HugeTLB hugepages, as this significantly reduces the
> > overhead associated with managing page tables and TLB misses. However,
> > for today's HugeTLB system, once a byte of memory in a hugepage is
> > hardware corrupted, the kernel discards the whole hugepage, including
> > the healthy portion. Customer workload running in the VM can hardly
> > recover from such a great loss of memory.
> >
> > Therefore keeping or discarding a large chunk of contiguous memory
> > owned by userspace (particularly to serve guest memory) due to
> > recoverable UE may better be controlled by userspace process
> > that owns the memory, e.g. VMM in Cloud environment.
> >
> > Introduce a memfd-based userspace memory failure (MFR) policy,
> > MFD_MF_KEEP_UE_MAPPED. It is intended to be supported for other memfd,
> > but the current implementation only covers HugeTLB.
> >
> > For any hugepage associated with the MFD_MF_KEEP_UE_MAPPED enabled memf=
d,
> > whenever it runs into a UE, MFR doesn't hard offline the HWPoison-ed
> > huge folio. IOW the HWPoison-ed memory remains accessible via the memor=
y
> > mapping created with that memfd. MFR still sends SIGBUS to the process
> > as required. MFR also still maintains HWPoison metadata for the hugepag=
e
> > having the UE.
> >
> > A HWPoison-ed hugepage will be immediately isolated and prevented from
> > future allocation once userspace truncates it via the memfd, or the
> > owning memfd is closed.
> >
> > By default MFD_MF_KEEP_UE_MAPPED is not set, and MFR hard offlines
> > hugepages having UEs.
> >
> > Tested with selftest in the follow-up commit.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > Tested-by: William Roche <william.roche@oracle.com>
> > ---
> >   fs/hugetlbfs/inode.c       |  25 +++++++-
> >   include/linux/hugetlb.h    |   7 +++
> >   include/linux/pagemap.h    |  24 +++++++
> >   include/uapi/linux/memfd.h |   6 ++
> >   mm/hugetlb.c               |  20 +++++-
> >   mm/memfd.c                 |  15 ++++-
> >   mm/memory-failure.c        | 124 +++++++++++++++++++++++++++++++++---=
-
> >   7 files changed, 202 insertions(+), 19 deletions(-)
> >
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index f42548ee9083c..f8a5aa091d51d 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -532,6 +532,18 @@ static bool remove_inode_single_folio(struct hstat=
e *h, struct inode *inode,
> >       }
> >
> >       folio_unlock(folio);
> > +
> > +     /*
> > +      * There may be pending HWPoison-ed folios when a memfd is being
> > +      * removed or part of it is being truncated.
> > +      *
> > +      * HugeTLBFS' error_remove_folio keeps the HWPoison-ed folios in
> > +      * page cache until mm wants to drop the folio at the end of the
> > +      * of the filemap. At this point, if memory failure was delayed
> > +      * by MFD_MF_KEEP_UE_MAPPED in the past, we can now deal with it.
> > +      */
> > +     filemap_offline_hwpoison_folio(mapping, folio);
> > +
> >       return ret;
> >   }
>
> Looks okay.
>
> >
> > @@ -563,13 +575,13 @@ static void remove_inode_hugepages(struct inode *=
inode, loff_t lstart,
> >       const pgoff_t end =3D lend >> PAGE_SHIFT;
> >       struct folio_batch fbatch;
> >       pgoff_t next, index;
> > -     int i, freed =3D 0;
> > +     int i, j, freed =3D 0;
> >       bool truncate_op =3D (lend =3D=3D LLONG_MAX);
> >
> >       folio_batch_init(&fbatch);
> >       next =3D lstart >> PAGE_SHIFT;
> >       while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
> > -             for (i =3D 0; i < folio_batch_count(&fbatch); ++i) {
> > +             for (i =3D 0, j =3D 0; i < folio_batch_count(&fbatch); ++=
i) {
> >                       struct folio *folio =3D fbatch.folios[i];
> >                       u32 hash =3D 0;
> >
> > @@ -584,8 +596,17 @@ static void remove_inode_hugepages(struct inode *i=
node, loff_t lstart,
> >                                                       index, truncate_o=
p))
> >                               freed++;
> >
> > +                     /*
> > +                      * Skip HWPoison-ed hugepages, which should no
> > +                      * longer be hugetlb if successfully dissolved.
> > +                      */
> > +                     if (folio_test_hugetlb(folio))
> > +                             fbatch.folios[j++] =3D folio;
> > +
> >                       mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> >               }
> > +             fbatch.nr =3D j;
> > +
> >               folio_batch_release(&fbatch);
> >               cond_resched();
> >       }
>
> Looks okay.
>
> But this reminds me that for now remove_inode_single_folio() has no path
> to return 'false' anyway, and if it does, remove_inode_hugepages() will
> be broken since it has no logic to account for failed to be
> removed folios.  Do you mind to make remove_inode_single_folio() a void
> function in order to avoid the confusion?
>
>
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 8e63e46b8e1f0..b7733ef5ee917 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -871,10 +871,17 @@ int dissolve_free_hugetlb_folios(unsigned long st=
art_pfn,
> >
> >   #ifdef CONFIG_MEMORY_FAILURE
> >   extern void folio_clear_hugetlb_hwpoison(struct folio *folio);
> > +extern bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio,
> > +                                             struct address_space *map=
ping);
> >   #else
> >   static inline void folio_clear_hugetlb_hwpoison(struct folio *folio)
> >   {
> >   }
> > +static inline bool hugetlb_should_keep_hwpoison_mapped(struct folio *f=
olio
> > +                                                    struct address_spa=
ce *mapping)
> > +{
> > +     return false;
> > +}
> >   #endif
>
> It appears that hugetlb_should_keep_hwpoison_mapped() is only called
> within mm/memory-failure.c.  How about moving it there ?
>
> >
> >   #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 09b581c1d878d..9ad511aacde7c 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -213,6 +213,8 @@ enum mapping_flags {
> >       AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM =3D 9,
> >       AS_KERNEL_FILE =3D 10,    /* mapping for a fake kernel file that =
shouldn't
> >                                  account usage to user cgroups */
> > +     /* For MFD_MF_KEEP_UE_MAPPED. */
> > +     AS_MF_KEEP_UE_MAPPED =3D 11,
> >       /* Bits 16-25 are used for FOLIO_ORDER */
> >       AS_FOLIO_ORDER_BITS =3D 5,
> >       AS_FOLIO_ORDER_MIN =3D 16,
> > @@ -348,6 +350,16 @@ static inline bool mapping_writeback_may_deadlock_=
on_reclaim(const struct addres
> >       return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->f=
lags);
> >   }
> >
> Okay.
>
> > +static inline bool mapping_mf_keep_ue_mapped(const struct address_spac=
e *mapping)
> > +{
> > +     return test_bit(AS_MF_KEEP_UE_MAPPED, &mapping->flags);
> > +}
> > +
> > +static inline void mapping_set_mf_keep_ue_mapped(struct address_space =
*mapping)
> > +{
> > +     set_bit(AS_MF_KEEP_UE_MAPPED, &mapping->flags);
> > +}
> > +
> >   static inline gfp_t mapping_gfp_mask(const struct address_space *mapp=
ing)
> >   {
> >       return mapping->gfp_mask;
> > @@ -1274,6 +1286,18 @@ void replace_page_cache_folio(struct folio *old,=
 struct folio *new);
> >   void delete_from_page_cache_batch(struct address_space *mapping,
> >                                 struct folio_batch *fbatch);
> >   bool filemap_release_folio(struct folio *folio, gfp_t gfp);
> > +#ifdef CONFIG_MEMORY_FAILURE
> > +/*
> > + * Provided by memory failure to offline HWPoison-ed folio managed by =
memfd.
> > + */
> > +void filemap_offline_hwpoison_folio(struct address_space *mapping,
> > +                                 struct folio *folio);
> > +#else
> > +void filemap_offline_hwpoison_folio(struct address_space *mapping,
> > +                                 struct folio *folio)
> > +{
> > +}
> > +#endif
>
> Okay.
>
> >   loff_t mapping_seek_hole_data(struct address_space *, loff_t start, l=
off_t end,
> >               int whence);
> >
> > diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
> > index 273a4e15dfcff..d9875da551b7f 100644
> > --- a/include/uapi/linux/memfd.h
> > +++ b/include/uapi/linux/memfd.h
> > @@ -12,6 +12,12 @@
> >   #define MFD_NOEXEC_SEAL             0x0008U
> >   /* executable */
> >   #define MFD_EXEC            0x0010U
> > +/*
> > + * Keep owned folios mapped when uncorrectable memory errors (UE) caus=
es
> > + * memory failure (MF) within the folio. Only at the end of the mappin=
g
> > + * will its HWPoison-ed folios be dealt with.
> > + */
> > +#define MFD_MF_KEEP_UE_MAPPED        0x0020U
> >
> >   /*
> >    * Huge page size encoding when MFD_HUGETLB is specified, and a huge =
page
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 0455119716ec0..dd3bc0b75e059 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6415,6 +6415,18 @@ static bool hugetlb_pte_stable(struct hstate *h,=
 struct mm_struct *mm, unsigned
> >       return same;
> >   }
> >
> > +bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio,
> > +                                      struct address_space *mapping)
> > +{
> > +     if (WARN_ON_ONCE(!folio_test_hugetlb(folio)))
> > +             return false;
> > +
> > +     if (!mapping)
> > +             return false;
> > +
> > +     return mapping_mf_keep_ue_mapped(mapping);
> > +}
> > +
>
> Okay.
>
> >   static vm_fault_t hugetlb_no_page(struct address_space *mapping,
> >                       struct vm_fault *vmf)
> >   {
> > @@ -6537,9 +6549,11 @@ static vm_fault_t hugetlb_no_page(struct address=
_space *mapping,
> >                * So we need to block hugepage fault by PG_hwpoison bit =
check.
> >                */
> >               if (unlikely(folio_test_hwpoison(folio))) {
> > -                     ret =3D VM_FAULT_HWPOISON_LARGE |
> > -                             VM_FAULT_SET_HINDEX(hstate_index(h));
> > -                     goto backout_unlocked;
> > +                     if (!mapping_mf_keep_ue_mapped(mapping)) {
> > +                             ret =3D VM_FAULT_HWPOISON_LARGE |
> > +                                   VM_FAULT_SET_HINDEX(hstate_index(h)=
);
> > +                             goto backout_unlocked;
> > +                     }
> >               }
> >
>
> Looks okay, but am curious at Miaohe and others' take.
>
> To allow a known poisoned hugetlb page to be faulted in is for the sake
> of capacity, so this, versus a SIGBUS from the MF handler indicating a
> disruption and loss of both data and capacity.
> No strong opinion here, just wondering if there is any merit to limit
> the scope to the MF handler only.
>
> >               /* Check for page in userfault range. */
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index 1d109c1acf211..bfdde4cf90500 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -313,7 +313,8 @@ long memfd_fcntl(struct file *file, unsigned int cm=
d, unsigned int arg)
> >   #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
> >   #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
> >
> > -#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB |=
 MFD_NOEXEC_SEAL | MFD_EXEC)
> > +#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB |=
 \
> > +                    MFD_NOEXEC_SEAL | MFD_EXEC | MFD_MF_KEEP_UE_MAPPED=
)
> >
> >   static int check_sysctl_memfd_noexec(unsigned int *flags)
> >   {
> > @@ -387,6 +388,8 @@ static int sanitize_flags(unsigned int *flags_ptr)
> >       if (!(flags & MFD_HUGETLB)) {
> >               if (flags & ~MFD_ALL_FLAGS)
> >                       return -EINVAL;
> > +             if (flags & MFD_MF_KEEP_UE_MAPPED)
> > +                     return -EINVAL;
> >       } else {
> >               /* Allow huge page size encoding in flags. */
> >               if (flags & ~(MFD_ALL_FLAGS |
> > @@ -447,6 +450,16 @@ static struct file *alloc_file(const char *name, u=
nsigned int flags)
> >       file->f_mode |=3D FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
> >       file->f_flags |=3D O_LARGEFILE;
> >
> > +     /*
> > +      * MFD_MF_KEEP_UE_MAPPED can only be specified in memfd_create; n=
o API
> > +      * to update it once memfd is created. MFD_MF_KEEP_UE_MAPPED is n=
ot
> > +      * seal-able.
> > +      *
> > +      * For now MFD_MF_KEEP_UE_MAPPED is only supported by HugeTLBFS.
> > +      */
> > +     if (flags & (MFD_HUGETLB | MFD_MF_KEEP_UE_MAPPED))
> > +             mapping_set_mf_keep_ue_mapped(file->f_mapping);
> > +
> >       if (flags & MFD_NOEXEC_SEAL) {
> >               struct inode *inode =3D file_inode(file);
> >
>
> Okay.
>
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 3edebb0cda30b..c5e3e28872797 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -373,11 +373,13 @@ static unsigned long dev_pagemap_mapping_shift(st=
ruct vm_area_struct *vma,
> >    * Schedule a process for later kill.
> >    * Uses GFP_ATOMIC allocations to avoid potential recursions in the V=
M.
> >    */
> > -static void __add_to_kill(struct task_struct *tsk, const struct page *=
p,
> > +static void __add_to_kill(struct task_struct *tsk, struct page *p,
> >                         struct vm_area_struct *vma, struct list_head *t=
o_kill,
> >                         unsigned long addr)
> >   {
> >       struct to_kill *tk;
> > +     struct folio *folio;
> > +     struct address_space *mapping;
> >
> >       tk =3D kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
> >       if (!tk) {
> > @@ -388,8 +390,19 @@ static void __add_to_kill(struct task_struct *tsk,=
 const struct page *p,
> >       tk->addr =3D addr;
> >       if (is_zone_device_page(p))
> >               tk->size_shift =3D dev_pagemap_mapping_shift(vma, tk->add=
r);
> > -     else
> > -             tk->size_shift =3D folio_shift(page_folio(p));
> > +     else {
> > +             folio =3D page_folio(p);
> > +             mapping =3D folio_mapping(folio);
> > +             if (mapping && mapping_mf_keep_ue_mapped(mapping))
> > +                     /*
> > +                      * Let userspace know the radius of HWPoison is
> > +                      * the size of raw page; accessing other pages
> > +                      * inside the folio is still ok.
> > +                      */
> > +                     tk->size_shift =3D PAGE_SHIFT;
> > +             else
> > +                     tk->size_shift =3D folio_shift(folio);
> > +     }
> >
> >       /*
> >        * Send SIGKILL if "tk->addr =3D=3D -EFAULT". Also, as
> > @@ -414,7 +427,7 @@ static void __add_to_kill(struct task_struct *tsk, =
const struct page *p,
> >       list_add_tail(&tk->nd, to_kill);
> >   }
> >
> > -static void add_to_kill_anon_file(struct task_struct *tsk, const struc=
t page *p,
> > +static void add_to_kill_anon_file(struct task_struct *tsk, struct page=
 *p,
> >               struct vm_area_struct *vma, struct list_head *to_kill,
> >               unsigned long addr)
> >   {
> > @@ -535,7 +548,7 @@ struct task_struct *task_early_kill(struct task_str=
uct *tsk, int force_early)
> >    * Collect processes when the error hit an anonymous page.
> >    */
> >   static void collect_procs_anon(const struct folio *folio,
> > -             const struct page *page, struct list_head *to_kill,
> > +             struct page *page, struct list_head *to_kill,
> >               int force_early)
> >   {
> >       struct task_struct *tsk;
> > @@ -573,7 +586,7 @@ static void collect_procs_anon(const struct folio *=
folio,
> >    * Collect processes when the error hit a file mapped page.
> >    */
> >   static void collect_procs_file(const struct folio *folio,
> > -             const struct page *page, struct list_head *to_kill,
> > +             struct page *page, struct list_head *to_kill,
> >               int force_early)
> >   {
> >       struct vm_area_struct *vma;
> > @@ -655,7 +668,7 @@ static void collect_procs_fsdax(const struct page *=
page,
> >   /*
> >    * Collect the processes who have the corrupted page mapped to kill.
> >    */
> > -static void collect_procs(const struct folio *folio, const struct page=
 *page,
> > +static void collect_procs(const struct folio *folio, struct page *page=
,
> >               struct list_head *tokill, int force_early)
> >   {
> >       if (!folio->mapping)
> > @@ -1173,6 +1186,13 @@ static int me_huge_page(struct page_state *ps, s=
truct page *p)
> >               }
> >       }
> >
> > +     /*
> > +      * MF still needs to holds a refcount for the deferred actions in
> > +      * filemap_offline_hwpoison_folio.
> > +      */
> > +     if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
> > +             return res;
> > +
>
> Okay.
>
> >       if (has_extra_refcount(ps, p, extra_pins))
> >               res =3D MF_FAILED;
> >
> > @@ -1569,6 +1589,7 @@ static bool hwpoison_user_mappings(struct folio *=
folio, struct page *p,
> >   {
> >       LIST_HEAD(tokill);
> >       bool unmap_success;
> > +     bool keep_mapped;
> >       int forcekill;
> >       bool mlocked =3D folio_test_mlocked(folio);
> >
> > @@ -1596,8 +1617,12 @@ static bool hwpoison_user_mappings(struct folio =
*folio, struct page *p,
> >        */
> >       collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
> >
> > -     unmap_success =3D !unmap_poisoned_folio(folio, pfn, flags & MF_MU=
ST_KILL);
> > -     if (!unmap_success)
> > +     keep_mapped =3D hugetlb_should_keep_hwpoison_mapped(folio, folio-=
>mapping);
> > +     if (!keep_mapped)
> > +             unmap_poisoned_folio(folio, pfn, flags & MF_MUST_KILL);
> > +
> > +     unmap_success =3D !folio_mapped(folio);
> > +     if (!keep_mapped && !unmap_success)
> >               pr_err("%#lx: failed to unmap page (folio mapcount=3D%d)\=
n",
> >                      pfn, folio_mapcount(folio));
> >
> > @@ -1622,7 +1647,7 @@ static bool hwpoison_user_mappings(struct folio *=
folio, struct page *p,
> >                   !unmap_success;
> >       kill_procs(&tokill, forcekill, pfn, flags);
> >
> > -     return unmap_success;
> > +     return unmap_success || keep_mapped;
> >   }
>
> Okay.
>
> >
> >   static int identify_page_state(unsigned long pfn, struct page *p,
> > @@ -1862,6 +1887,13 @@ static unsigned long __folio_free_raw_hwp(struct=
 folio *folio, bool move_flag)
> >       unsigned long count =3D 0;
> >
> >       head =3D llist_del_all(raw_hwp_list_head(folio));
> > +     /*
> > +      * If filemap_offline_hwpoison_folio_hugetlb is handling this fol=
io,
> > +      * it has already taken off the head of the llist.
> > +      */
> > +     if (head =3D=3D NULL)
> > +             return 0;
> > +
> >       llist_for_each_entry_safe(p, next, head, node) {
> >               if (move_flag)
> >                       SetPageHWPoison(p->page);
> > @@ -1878,7 +1910,8 @@ static int folio_set_hugetlb_hwpoison(struct foli=
o *folio, struct page *page)
> >       struct llist_head *head;
> >       struct raw_hwp_page *raw_hwp;
> >       struct raw_hwp_page *p;
> > -     int ret =3D folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
> > +     struct address_space *mapping =3D folio->mapping;
> > +     bool has_hwpoison =3D folio_test_set_hwpoison(folio);
> >
> >       /*
> >        * Once the hwpoison hugepage has lost reliable raw error info,
> > @@ -1897,8 +1930,15 @@ static int folio_set_hugetlb_hwpoison(struct fol=
io *folio, struct page *page)
> >       if (raw_hwp) {
> >               raw_hwp->page =3D page;
> >               llist_add(&raw_hwp->node, head);
> > +             if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
> > +                     /*
> > +                      * A new raw HWPoison page. Don't return HWPOISON=
.
> > +                      * Error event will be counted in action_result()=
.
> > +                      */
> > +                     return 0;
> > +
> >               /* the first error event will be counted in action_result=
(). */
> > -             if (ret)
> > +             if (has_hwpoison)
> >                       num_poisoned_pages_inc(page_to_pfn(page));
> >       } else {
> >               /*
> > @@ -1913,7 +1953,8 @@ static int folio_set_hugetlb_hwpoison(struct foli=
o *folio, struct page *page)
> >                */
> >               __folio_free_raw_hwp(folio, false);
> >       }
> > -     return ret;
> > +
> > +     return has_hwpoison ? -EHWPOISON : 0;
> >   }
>
> Okay.
>
> >
> >   static unsigned long folio_free_raw_hwp(struct folio *folio, bool mov=
e_flag)
> > @@ -2002,6 +2043,63 @@ int __get_huge_page_for_hwpoison(unsigned long p=
fn, int flags,
> >       return ret;
> >   }
> >
> > +static void filemap_offline_hwpoison_folio_hugetlb(struct folio *folio=
)
> > +{
> > +     int ret;
> > +     struct llist_node *head;
> > +     struct raw_hwp_page *curr, *next;
> > +     struct page *page;
> > +     unsigned long pfn;
> > +
> > +     /*
> > +      * Since folio is still in the folio_batch, drop the refcount
> > +      * elevated by filemap_get_folios.
> > +      */
> > +     folio_put_refs(folio, 1);
> > +     head =3D llist_del_all(raw_hwp_list_head(folio));
> > +
> > +     /*
> > +      * Release refcounts held by try_memory_failure_hugetlb, one per
> > +      * HWPoison-ed page in the raw hwp list.
> > +      */
> > +     llist_for_each_entry(curr, head, node) {
> > +             SetPageHWPoison(curr->page);
> > +             folio_put(folio);
> > +     }
> > +
> > +     /* Refcount now should be zero and ready to dissolve folio. */
> > +     ret =3D dissolve_free_hugetlb_folio(folio);
> > +     if (ret) {
> > +             pr_err("failed to dissolve hugetlb folio: %d\n", ret);
> > +             return;
> > +     }
> > +
> > +     llist_for_each_entry_safe(curr, next, head, node) {
> > +             page =3D curr->page;
> > +             pfn =3D page_to_pfn(page);
> > +             drain_all_pages(page_zone(page));
> > +             if (!take_page_off_buddy(page))
> > +                     pr_err("%#lx: unable to take off buddy allocator\=
n", pfn);
> > +
> > +             page_ref_inc(page);
> > +             kfree(curr);
> > +             pr_info("%#lx: pending hard offline completed\n", pfn);
> > +     }
> > +}
> > +
> > +void filemap_offline_hwpoison_folio(struct address_space *mapping,
> > +                                 struct folio *folio)
> > +{
> > +     WARN_ON_ONCE(!mapping);
> > +
> > +     if (!folio_test_hwpoison(folio))
> > +             return;
> > +
> > +     /* Pending MFR currently only exist for hugetlb. */
> > +     if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
> > +             filemap_offline_hwpoison_folio_hugetlb(folio);
> > +}
> > +
> >   /*
> >    * Taking refcount of hugetlb pages needs extra care about race condi=
tions
> >    * with basic operations like hugepage allocation/free/demotion.
>
>
> Looks good.
>
> thanks,
> -jane

