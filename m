Return-Path: <linux-fsdevel+bounces-68828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F47C67530
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 943034EBA31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361242C3258;
	Tue, 18 Nov 2025 05:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="puTicYA/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB5A28853E
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 05:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442788; cv=none; b=fD+jD38UGzY9696oxfMbCz944ER/tHQKuRqWITSmvkpFlN6hDVoLyAaYqrORVxaTRA2HszVfetxKfWvBl1SAmiShv3Oez23pAUpPSc/fWJjK1LF/y0mCQu1KiWhHepGysSZpqaDzfKLdcPyJWBPKZp4w/1s1TALKzvx/Wr47xuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442788; c=relaxed/simple;
	bh=j68mKMCsYqhqI4AyHR4HtbKmy1liu/5iNgYA++fAeJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwqFd6xLCxoJQPksj9zUHtp2DSaPr1xiNC9aJ+ylF8pVHdXEky3RyGDQ9I/dqySHXngyGDUC/r1nYqsCd7O99fTSp8dbDmtfZkh+yFv5qzAJ9Wj5x/l0fPKngydinQa66lD4NdFhdZbvuNaUA6RURm6HCFPEs2U1Dk1xy7+67Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=puTicYA/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779e2ac121so30445e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 21:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763442785; x=1764047585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3WlC2F/ZYjE5MyciXjRSRLSaVo0EtUipR3IBE4sFQo=;
        b=puTicYA/fSf5bIrCLcafNRMLU0oumVglHHHdFWxfegyPUg4z5ok9MqurZ670Zc9pQC
         w+30lDqBXs0K6mFwhBvVaO45JLr4c01AKpUHj0DzHn3AmcfE3MIJ11dv4770v9t+zG74
         3QzO5QGzAQjUEQRtLW9RW/8+v2jtzhNopFNADc6wBsxXuSUTZXMN1Wc1Pj2u5GA+Em84
         +WGtGVFbAGKz+42csaYsMkTp5EAdVyumy9TDLhCrF68Kip7eMj1nADkWiKcvmhZr375G
         8TtKxocMH4krYRl3NwxywIjwD47+GRCwcjiKF2EatacD3JLejnqhPCpGlKAxbJmogPl7
         NKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763442785; x=1764047585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L3WlC2F/ZYjE5MyciXjRSRLSaVo0EtUipR3IBE4sFQo=;
        b=EHhiCVxbAlcd6DnDewr0M4jU41Effbn6qYAvv9M0ef6F5NNgMzcZWsGBRWRNguKaZ4
         g5Y0iGfG8uYXcySJ7pobGvL63ycrtii2Kpducw1WZk3Ljlxi3ooSEPXmftdOqmoF1T/H
         ye8b8k9gaeSM48LBshfJoEEu34tioFeiJ8Wg2+l5aquhic8/kCxLMmtLbMShAxvHXX78
         8Og7AxwAgHAM6riPDbJDTl3XOg6Oawxpz7XJhJIrw9PCSB40wCYA8ZwOPvN9WNg3ByIs
         JB9GdnH/x9vJa/cTilnR6BsE9faWNCpR7o5fcHze6K2k1AiETGWK5r4gQl9962u/hbaj
         3B5w==
X-Forwarded-Encrypted: i=1; AJvYcCXmwoGKuw69G9Zp2bHF1IMxvdwbZKB/Iz/+uCz/ExEwnWO0GmZNFgVSDGzoJRJuJxKyVB4I3vJemB81jFSF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0IjPolzlROAhEn9mBAPNWHcULrnWzxHadSvi25/g636DwGfRq
	NaTOBu3ANAHk0HBHhK00FjmgyyXcBNzGQ9c5Daz7cYlZa6f9+rmwsQJy9b3Clar59ClF/LaobxS
	qJ0M43KNiBHkY8O5WtXY3FMCKe0d4lfcbNIW9/IU9
X-Gm-Gg: ASbGncuku6m9xRPRnNDg9/XntknWz3qOxD9kB/iUeRWjN7ZjUGF5UtmLPVUyebjftaU
	yizvJIDIzLv/a7lOOyuxUsrVJiLJaRE6IlszTDZlX85g/XeZ7GhFb5V4+pJ+nCZNbvF/BuXQhbr
	jWrvTQ5pd/4yzpzYUhJwLkjV+/zWpPFyudOyD5WLjg5CsQAuoLxlfMBphE7c7TTEWm5YY0r6wc1
	de8uYV4f9X76LqbKcZzNxH9aNGgq+FQDYof+ztztjJLF5iXkF2BKJksGw6WJhDKqbMw7WYsoLgl
	xRzaidvyNgGXbrLsgD7cDezjY/ja
X-Google-Smtp-Source: AGHT+IG7a+W56pa5px8Ke5ySaRypEp+/UIHTLNYMdTRbHZTR0wZ3pySD5fRRpgk4iVmEKxs03t0cwIuHrLmqaNeLZKE=
X-Received: by 2002:a7b:ca53:0:b0:477:86fd:fb19 with SMTP id
 5b1f17b1804b1-477ad06fc15mr5655e9.9.1763442784600; Mon, 17 Nov 2025 21:13:04
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116014721.1561456-1-jiaqiyan@google.com> <20251116014721.1561456-3-jiaqiyan@google.com>
 <CD886E34-9126-4B34-93B2-3DFBDAC4C454@nvidia.com>
In-Reply-To: <CD886E34-9126-4B34-93B2-3DFBDAC4C454@nvidia.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 17 Nov 2025 21:12:53 -0800
X-Gm-Features: AWmQ_bn4yLVuQDw4Ux8NVwahCGaKHuF98rPNAY5nKN0RpM3KQoxIzo5zKkLBmPk
Message-ID: <CACw3F50aVFoeaEnTptvq+qjVibupM1e8XJUeU2W_y-JMzJx1iw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm/memory-failure: avoid free HWPoison high-order folio
To: Zi Yan <ziy@nvidia.com>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, william.roche@oracle.com, harry.yoo@oracle.com, 
	tony.luck@intel.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	jane.chu@oracle.com, akpm@linux-foundation.org, osalvador@suse.de, 
	muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 6:10=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 15 Nov 2025, at 20:47, Jiaqi Yan wrote:
>
> > At the end of dissolve_free_hugetlb_folio, when a free HugeTLB
> > folio becomes non-HugeTLB, it is released to buddy allocator
> > as a high-order folio, e.g. a folio that contains 262144 pages
> > if the folio was a 1G HugeTLB hugepage.
> >
> > This is problematic if the HugeTLB hugepage contained HWPoison
> > subpages. In that case, since buddy allocator does not check
> > HWPoison for non-zero-order folio, the raw HWPoison page can
> > be given out with its buddy page and be re-used by either
> > kernel or userspace.
> >
> > Memory failure recovery (MFR) in kernel does attempt to take
> > raw HWPoison page off buddy allocator after
> > dissolve_free_hugetlb_folio. However, there is always a time
> > window between freed to buddy allocator and taken off from
> > buddy allocator.
> >
> > One obvious way to avoid this problem is to add page sanity
> > checks in page allocate or free path. However, it is against
> > the past efforts to reduce sanity check overhead [1,2,3].
> >
> > Introduce hugetlb_free_hwpoison_folio to solve this problem.
> > The idea is, in case a HugeTLB folio for sure contains HWPoison
> > page(s), first split the non-HugeTLB high-order folio uniformly
> > into 0-order folios, then let healthy pages join the buddy
> > allocator while reject the HWPoison ones.
> >
> > [1] https://lore.kernel.org/linux-mm/1460711275-1130-15-git-send-email-=
mgorman@techsingularity.net/
> > [2] https://lore.kernel.org/linux-mm/1460711275-1130-16-git-send-email-=
mgorman@techsingularity.net/
> > [3] https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  include/linux/hugetlb.h |  4 ++++
> >  mm/hugetlb.c            |  8 ++++++--
> >  mm/memory-failure.c     | 43 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 53 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 8e63e46b8e1f0..e1c334a7db2fe 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -870,8 +870,12 @@ int dissolve_free_hugetlb_folios(unsigned long sta=
rt_pfn,
> >                                   unsigned long end_pfn);
> >
> >  #ifdef CONFIG_MEMORY_FAILURE
> > +extern void hugetlb_free_hwpoison_folio(struct folio *folio);
> >  extern void folio_clear_hugetlb_hwpoison(struct folio *folio);
> >  #else
> > +static inline void hugetlb_free_hwpoison_folio(struct folio *folio)
> > +{
> > +}
> >  static inline void folio_clear_hugetlb_hwpoison(struct folio *folio)
> >  {
> >  }
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 0455119716ec0..801ca1a14c0f0 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1596,6 +1596,7 @@ static void __update_and_free_hugetlb_folio(struc=
t hstate *h,
> >                                               struct folio *folio)
> >  {
> >       bool clear_flag =3D folio_test_hugetlb_vmemmap_optimized(folio);
> > +     bool has_hwpoison =3D folio_test_hwpoison(folio);
> >
> >       if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> >               return;
> > @@ -1638,12 +1639,15 @@ static void __update_and_free_hugetlb_folio(str=
uct hstate *h,
> >        * Move PageHWPoison flag from head page to the raw error pages,
> >        * which makes any healthy subpages reusable.
> >        */
> > -     if (unlikely(folio_test_hwpoison(folio)))
> > +     if (unlikely(has_hwpoison))
> >               folio_clear_hugetlb_hwpoison(folio);
> >
> >       folio_ref_unfreeze(folio, 1);
> >
> > -     hugetlb_free_folio(folio);
> > +     if (unlikely(has_hwpoison))
> > +             hugetlb_free_hwpoison_folio(folio);
> > +     else
> > +             hugetlb_free_folio(folio);
> >  }
> >
> >  /*
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 3edebb0cda30b..e6a9deba6292a 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -2002,6 +2002,49 @@ int __get_huge_page_for_hwpoison(unsigned long p=
fn, int flags,
> >       return ret;
> >  }
> >
> > +void hugetlb_free_hwpoison_folio(struct folio *folio)
> > +{
> > +     struct folio *curr, *next;
> > +     struct folio *end_folio =3D folio_next(folio);
> > +     int ret;
> > +
> > +     VM_WARN_ON_FOLIO(folio_ref_count(folio) !=3D 1, folio);
> > +
> > +     ret =3D uniform_split_unmapped_folio_to_zero_order(folio);
>
> I realize that __split_unmapped_folio() is a wrong name and causes confus=
ion.
> It should be __split_frozen_folio(), since when you look at its current
> call site, it is called after the folio is frozen. There probably
> should be a check in __split_unmapped_folio() to make sure the folio is f=
rozen.
>
> Is it possible to change hugetlb_free_hwpoison_folio() so that it
> can be called before folio_ref_unfreeze(folio, 1)? In this way,
> __split_unmapped_folio() is called at frozen folios.
>
> You can add a preparation patch to rename __split_unmapped_folio() to
> __split_frozen_folio() and add
> VM_WARN_ON_ONCE_FOLIO(folio_ref_count(folio) !=3D 0, folio) to the functi=
on.
>

FWIW, I am going to still follow your suggestion to improve code
healthiness or readability :)

> Thanks.

Thanks, Zi!

>
> > +     if (ret) {
> > +             /*
> > +              * In case of split failure, none of the pages in folio
> > +              * will be freed to buddy allocator.
> > +              */
> > +             pr_err("%#lx: failed to split free %d-order folio with HW=
Poison page(s): %d\n",
> > +                    folio_pfn(folio), folio_order(folio), ret);
> > +             return;
> > +     }
> > +
> > +     /* Expect 1st folio's refcount=3D=3D1, and other's refcount=3D=3D=
0. */
> > +     for (curr =3D folio; curr !=3D end_folio; curr =3D next) {
> > +             next =3D folio_next(curr);
> > +
> > +             VM_WARN_ON_FOLIO(folio_order(curr), curr);
> > +
> > +             if (PageHWPoison(&curr->page)) {
> > +                     if (curr !=3D folio)
> > +                             folio_ref_inc(curr);
> > +
> > +                     VM_WARN_ON_FOLIO(folio_ref_count(curr) !=3D 1, cu=
rr);
> > +                     pr_warn("%#lx: prevented freeing HWPoison page\n"=
,
> > +                             folio_pfn(curr));
> > +                     continue;
> > +             }
> > +
> > +             if (curr =3D=3D folio)
> > +                     folio_ref_dec(curr);
> > +
> > +             VM_WARN_ON_FOLIO(folio_ref_count(curr), curr);
> > +             free_frozen_pages(&curr->page, folio_order(curr));
> > +     }
> > +}
> > +
> >  /*
> >   * Taking refcount of hugetlb pages needs extra care about race condit=
ions
> >   * with basic operations like hugepage allocation/free/demotion.
> > --
> > 2.52.0.rc1.455.g30608eb744-goog
>
>
> --
> Best Regards,
> Yan, Zi

