Return-Path: <linux-fsdevel+bounces-69136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE962C70C80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 20:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAEEA4E0F0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 19:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDF630E0EC;
	Wed, 19 Nov 2025 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zNGVh4Dm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AFC327C01
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580136; cv=none; b=GbHIEGcU0o/ktTtTIgayZeYA6/J++ywEFPeoDJBV8SMEhc0aYioohX8Dh9ZyywVRNpS/r3YD023EigmfnkLyHlesjCznScovHvf0JjDkyOlqSh/pn3s6dEI5hNH2uAqn9SF6WYuBvi1sVKUvlhRvviRhgrDOZgXswPOhEp4OHwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580136; c=relaxed/simple;
	bh=H/lPkox/xKCJ+JwzK2oRJrdLZ//56s0bMoGu0TtlxdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXH61Pu+0dFhZOtPZToBJR6vHzVoEyf0bWlsiTgw+AV/P7h3AOIW+CGnFH3MX7IO73jEyxU7WridSb88GwRNzFR58GPnXcwmrX+WIBKQbc02dmd9MTXDIV1dFBDH/Tmq0VamtMvpARfPYv5RYByfig68ZnkDHbI4bhegZvZXTnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zNGVh4Dm; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed67a143c5so32671cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 11:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763580126; x=1764184926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29aKy7Zpte2m3nxAAyvYo2cSpgE57NiENRIGV6SZof4=;
        b=zNGVh4DmwqgjZ8kj33n3R9pcLiGf5MNdih3QS/mPRmmEPZDIHjhoAQsaEMA2lbH5tV
         1+nqRF6QNzaSP/UiHxZKVCfTRxpebNDQnfSxh0gecAQs5JouyVp41is+LBQEtBb+gamy
         jFEbe4S9jPkFPv867v6xS1TBW9PlJ+63i1c8AwGtXLIIDHQ67vagB/yCkaFLCNFdnBhI
         BKR+A2xpVS7E/txDfge/uj36kx+LXMgzWv/fi8/71W4W9lIN1yw+JgdQHZD0Uhaisbpv
         7nTWPqIGuwBiA/Gvom6VxTj9ONBjRvxtSzHAEkPLwCovhPmYUtMawX0BcfDOJ9ta5b5V
         LEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763580126; x=1764184926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=29aKy7Zpte2m3nxAAyvYo2cSpgE57NiENRIGV6SZof4=;
        b=Wr2h0xcmCaCsRR8ksEmMAdSZSEjvifGo9UwRQ5Sw8Xe4GJWdA3Bp8gOXMED4J3V2vs
         xHH0qZLBA4joutCeVtMawQCUZvFROS1EQ4fHhXxi7APjeqzgiaGD3r2gZA5xAyT1LsW8
         /Mnc8Nx34ekGAhyYT4t9mKZYLiwuOddyx/GNcho0LqJ3GxyyeZqCMzP66Q4C71VjAnkv
         jQ+j0OPnIISMHBdVKlAMN+tCzKjHrToR4MQb1//3zhgmsOTn8dkWqzVXGvHE8JJcLtP6
         XWZgHDAZ+hEyGqKtBD/I5tTkRJ+vSws1w+xVhFX3QzMsbnV7QYvGFHqvpWrjEsH7lTDl
         g/jw==
X-Forwarded-Encrypted: i=1; AJvYcCXA7dQ0PGDsF+pUI20AnHaKqhHN0Ux5B/nhow/QCik0mMHy1HKPOTgQezyvSothaEOdYE3xyi/TyRWt2NPE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0xhfVa61SFgczcyU1MEo3fcpCoiBqgz3j/Ksu9X/UAjQXvjAF
	SaS9lB5vh0ZcU0q2bEuMlCDzwIWYEoFbYrtnKIJz+NGWl/FQuDEe7uN38ACsKHM2qlU4OoBehu+
	q+4LymwFD9KSApDcoedTvq92Qq7Q5qHCiPe4qQp+B
X-Gm-Gg: ASbGnctoFeo+ixlcuoKe8W7F+oi92ktcXb9Sgc3oZ32J8oYAXZm3+rMRsHFh0Dmn2Vy
	afj4a66TNylAOnBzJfhiJ0twtn/AeRA22mO1uiA+azTcEPK51DsyaXKPxfxrmvCOMkpnf4eZLD8
	+N/onXuHN5GbXUwLSayZZPYUepPQwH99LFo5LLTwK+XK8ZlpJnHe81xklYjAJ3EUbhgXHLS29nx
	++QjzREwGlp0s1setaKWBtUB6bRVXe9a+MsK8elsm9kZm58ochjsfDMWjdU2o0SI7fWPtjg2fzc
	I6wlGI/cgnBDg0O6WzC/VZlRlSOidbZUYmAV6uY=
X-Google-Smtp-Source: AGHT+IGQFg/Mn0AwTx6uUfhJLAvIvZhv0JODOijUlxmdaIIq33TpSvbn/5A8w9CJAXsG+V1v7+5CpUv0MNn0aard99Q=
X-Received: by 2002:ac8:7d94:0:b0:4e6:eaee:a944 with SMTP id
 d75a77b69052e-4ee49b80621mr516821cf.4.1763580126001; Wed, 19 Nov 2025
 11:22:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116014721.1561456-1-jiaqiyan@google.com> <20251116014721.1561456-2-jiaqiyan@google.com>
 <aRm6shtKizyrq_TA@casper.infradead.org> <aRqTLmJBuvBcLYMx@hyeyoo>
 <aRsmaIfCAGy-DRcx@casper.infradead.org> <CACw3F50E=AZtgfoExCA-nwS6=NYdFFWpf6+GBUYrWiJOz4xwaw@mail.gmail.com>
 <aRxIP7StvLCh-dc2@hyeyoo> <CACw3F53Rck2Bf_C45Uk=A1NJ4zB1B0R1+GqvkNxsz3h3mDx-pQ@mail.gmail.com>
 <5D76156D-A84F-493B-BD59-A57375C7A6AF@nvidia.com> <aR257PivQXpEGbKb@hyeyoo>
In-Reply-To: <aR257PivQXpEGbKb@hyeyoo>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Wed, 19 Nov 2025 11:21:51 -0800
X-Gm-Features: AWmQ_bnflews9k8QsmDjYEsLyhMJn14T6IKgw8Lhx7j6d_4tUtCoPhCKHosxQqs
Message-ID: <CACw3F50OzEuVco762kNS1ONyzFU1M6MQUjYd1ybtHCMcg6pmdA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm/huge_memory: introduce uniform_split_unmapped_folio_to_zero_order
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>, david@redhat.com, 
	Vlastimil Babka <vbabka@suse.cz>, nao.horiguchi@gmail.com, linmiaohe@huawei.com, 
	lorenzo.stoakes@oracle.com, william.roche@oracle.com, tony.luck@intel.com, 
	wangkefeng.wang@huawei.com, jane.chu@oracle.com, akpm@linux-foundation.org, 
	osalvador@suse.de, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 4:37=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Tue, Nov 18, 2025 at 04:54:31PM -0500, Zi Yan wrote:
> > On 18 Nov 2025, at 14:26, Jiaqi Yan wrote:
> >
> > > On Tue, Nov 18, 2025 at 2:20=E2=80=AFAM Harry Yoo <harry.yoo@oracle.c=
om> wrote:
> > >>
> > >> On Mon, Nov 17, 2025 at 10:24:27PM -0800, Jiaqi Yan wrote:
> > >>> On Mon, Nov 17, 2025 at 5:43=E2=80=AFAM Matthew Wilcox <willy@infra=
dead.org> wrote:
> > >>>>
> > >>>> On Mon, Nov 17, 2025 at 12:15:23PM +0900, Harry Yoo wrote:
> > >>>>> On Sun, Nov 16, 2025 at 11:51:14AM +0000, Matthew Wilcox wrote:
> > >>>>>> But since we're only doing this on free, we won't need to do fol=
io
> > >>>>>> allocations at all; we'll just be able to release the good pages=
 to the
> > >>>>>> page allocator and sequester the hwpoison pages.
> > >>>>>
> > >>>>> [+Cc PAGE ALLOCATOR folks]
> > >>>>>
> > >>>>> So we need an interface to free only healthy portion of a hwpoiso=
n folio.
> > >>>
> > >>> +1, with some of my own thoughts below.
> > >>>
> > >>>>>
> > >>>>> I think a proper approach to this should be to "free a hwpoison f=
olio
> > >>>>> just like freeing a normal folio via folio_put() or free_frozen_p=
ages(),
> > >>>>> then the page allocator will add only healthy pages to the freeli=
st and
> > >>>>> isolate the hwpoison pages". Oherwise we'll end up open coding a =
lot,
> > >>>>> which is too fragile.
> > >>>>
> > >>>> Yes, I think it should be handled by the page allocator.  There ma=
y be
> > >>>
> > >>> I agree with Matthew, Harry, and David. The page allocator seems be=
st
> > >>> suited to handle HWPoison subpages without any new folio allocation=
s.
> > >>
> > >> Sorry I should have been clearer. I don't think adding an **explicit=
**
> > >> interface to free an hwpoison folio is worth; instead implicitly
> > >> handling during freeing of a folio seems more feasible.
> > >
> > > That's fine with me, just more to be taken care of by page allocator.
> > >
> > >>
> > >>>> some complexity to this that I've missed, eg if hugetlb wants to r=
etain
> > >>>> the good 2MB chunks of a 1GB allocation.  I'm not sure that's a us=
eful
> > >>>> thing to do or not.
> > >>>>
> > >>>>> In fact, that can be done by teaching free_pages_prepare() how to=
 handle
> > >>>>> the case where one or more subpages of a folio are hwpoison pages=
.
> > >>>>>
> > >>>>> How this should be implemented in the page allocator in memdescs =
world?
> > >>>>> Hmm, we'll want to do some kind of non-uniform split, without act=
ually
> > >>>>> splitting the folio but allocating struct buddy?
> > >>>>
> > >>>> Let me sketch that out, realising that it's subject to change.
> > >>>>
> > >>>> A page in buddy state can't need a memdesc allocated.  Otherwise w=
e're
> > >>>> allocating memory to free memory, and that way lies madness.  We c=
an't
> > >>>> do the hack of "embed struct buddy in the page that we're freeing"
> > >>>> because HIGHMEM.  So we'll never shrink struct page smaller than s=
truct
> > >>>> buddy (which is fine because I've laid out how to get to a 64 bit =
struct
> > >>>> buddy, and we're probably two years from getting there anyway).
> > >>>>
> > >>>> My design for handling hwpoison is that we do allocate a struct hw=
poison
> > >>>> for a page.  It looks like this (for now, in my head):
> > >>>>
> > >>>> struct hwpoison {
> > >>>>         memdesc_t original;
> > >>>>         ... other things ...
> > >>>> };
> > >>>>
> > >>>> So we can replace the memdesc in a page with a hwpoison memdesc wh=
en we
> > >>>> encounter the error.  We still need a folio flag to indicate that =
"this
> > >>>> folio contains a page with hwpoison".  I haven't put much thought =
yet
> > >>>> into interaction with HUGETLB_PAGE_OPTIMIZE_VMEMMAP; maybe "other =
things"
> > >>>> includes an index of where the actually poisoned page is in the fo=
lio,
> > >>>> so it doesn't matter if the pages alias with each other as we can =
recover
> > >>>> the information when it becomes useful to do so.
> > >>>>
> > >>>>> But... for now I think hiding this complexity inside the page all=
ocator
> > >>>>> is good enough. For now this would just mean splitting a frozen p=
age
> > >>>
> > >>> I want to add one more thing. For HugeTLB, kernel clears the HWPois=
on
> > >>> flag on the folio and move it to every raw pages in raw_hwp_page li=
st
> > >>> (see folio_clear_hugetlb_hwpoison). So page allocator has no hint t=
hat
> > >>> some pages passed into free_frozen_pages has HWPoison. It has to
> > >>> traverse 2^order pages to tell, if I am not mistaken, which goes
> > >>> against the past effort to reduce sanity checks. I believe this is =
one
> > >>> reason I choosed to handle the problem in hugetlb / memory-failure.
> > >>
> > >> I think we can skip calling folio_clear_hugetlb_hwpoison() and teach=
 the
> > >
> > > Nit: also skip folio_free_raw_hwp so the hugetlb-specific llist
> > > containing the raw pages and owned by memory-failure is preserved? An=
d
> > > expect the page allocator to use it for whatever purpose then free th=
e
> > > llist? Doesn't seem to follow the correct ownership rule.
> > >
> > >> buddy allocator to handle this. free_pages_prepare() already handles
> > >> (PageHWPoison(page) && !order) case, we just need to extend that to
> > >> support hugetlb folios as well.
> > >>
> > >>> For the new interface Harry requested, is it the caller's
> > >>> responsibility to ensure that the folio contains HWPoison pages (to=
 be
> > >>> even better, maybe point out the exact ones?), so that page allocat=
or
> > >>> at least doesn't waste cycles to search non-exist HWPoison in the s=
et
> > >>> of pages?
> > >>
> > >> With implicit handling it would be the page allocator's responsibili=
ty
> > >> to check and handle hwpoison hugetlb folios.
> > >
> > > Does this mean we must bake hugetlb-specific logic in the page
> > > allocator's freeing path? AFAICT today the contract in
> > > free_frozen_page doesn't contain much hugetlb info.
> > >
> > > I saw there is already some hugetlb-specific logic in page_alloc.c,
> > > but perhaps not valid for adding more.
> > >
> > >>
> > >>> Or caller and page allocator need to agree on some contract? Say
> > >>> caller has to set has_hwpoisoned flag in non-zero order folio to fr=
ee.
> > >>> This allows the old interface free_frozen_pages an easy way using t=
he
> > >>> has_hwpoison flag from the second page. I know has_hwpoison is "#if
> > >>> defined" on THP and using it for hugetlb probably is not very clean=
,
> > >>> but are there other concerns?
> > >>
> > >> As you mentioned has_hwpoisoned is used for THPs and for a hugetlb
> > >> folio. But for a hugetlb folio folio_test_hwpoison() returns true
> > >> if it has at least one hwpoison pages (assuming that we don't clear =
it
> > >> before freeing).
> > >>
> > >> So in free_pages_prepare():
> > >>
> > >> if (folio_test_hugetlb(folio) && folio_test_hwpoison(folio)) {
> > >>   /*
> > >>    * Handle hwpoison hugetlb folios; transfer the error information
> > >>    * to individual pages, clear hwpoison flag of the folio,
> > >>    * perform non-uniform split on the frozen folio.
> > >>    */
> > >> } else if (PageHWPoison(page) && !order) {
> > >>   /* We already handle this in the allocator. */
> > >> }
> > >>
> > >> This would be sufficient?
> > >
> > > Wouldn't this confuse the page allocator into thinking the healthy
> > > head page is HWPoison (when it actually isn't)? I thought that was on=
e
> > > of the reasons has_hwpoison exists.
>
> AFAICT in the current code we don't set PG_hwpoison on individual
> pages for hugetlb folios, so it won't confuse the page allocator.
>
> > Is there a reason why hugetlb does not use has_hwpoison flag?
>
> But yeah sounds like hugetlb is quite special here :)
>
> I don't see why we should not use has_hwpoisoned and I think it's fine
> to set has_hwpoisoned on hwpoison hugetlb folios in
> folio_clear_hugetlb_hwpoison() and check the flag in the page allocator!
>
> And since the split code has to scan base pages to check if there
> is an hwpoison page in the new folio created by split (as Zi Yan mentione=
d),
> I think it's fine to not skip calling folio_free_raw_hwp() in
> folio_clear_hugetlb_hwpoison() and set has_hwpoisoned instead, and then
> scan pages in free_pages_prepare() when we know has_hwpoisoned is set.
>
> That should address Jiaqi's concern on adding hugetlb-specific code
> in the page allocator.
>
> So summing up:
>
> 1. Transfer raw hwp list to individual pages by setting PG_hwpoison
>    (that's done in folio_clear_hugetlb_hwpoison()->folio_free_raw_hwp()!)
>
> 2. Set has_hwpoisoned in folio_clear_hugetlb_hwpoison()

IIUC, #1 and #2 are exactly what I considered: no change in
folio_clear_hugetlb_hwpoison, but set the has_hwpoisoned flag (instead
of HWPoison flag) to the folio as the hint to page allocator.

>
> 3. Check has_hwpoisoned in free_pages_prepare() and if it's set,
>    iterate over all base pages and do non-uniform split by calling
>    __split_unmapped_folio() at each hwpoisoned pages.

IIUC, directly re-use __split_unmapped_folio still need some memory
overhead. But I believe that's log(n) and much better than the current
uniform split version. So if that's acceptable, I can give this
solution a try.

>
>    I think it's fine to iterate over base pages and check hwpoison flag
>    as long as we do that only when we know there's an hwpoison page.
>
>    But maybe we need to dispatch the job to a workqueue as Zi Yan said,
>    because it'll take a while to iterate 512 * 512 pages when we're freei=
ng
>    1GB hugetlb folios.
>
> 4. Optimize __split_unmapped_folio() as suggested by Zi Yan below.
>
> BTW I think we have to discard folios that has hwpoison pages
> when we fail to split some parts? (we don't have to discard all of them,
> but we may have managed to split some parts while other parts failed)
>

Maybe we can fail in other places, but at least __split_unmapped_folio
can't fail when mapping is NULL, which is the case for us.

> --
> Cheers,
> Harry / Hyeonggon
>
> > BTW, __split_unmapped_folio() currently sets has_hwpoison to the after-=
split
> > folios by scanning every single page in the to-be-split folio.
> >
> > The related code is in __split_folio_to_order(). But the code is not
> > efficient for non-uniform split, since it calls __split_folio_to_order(=
)
> > multiple time, meaning when non-uniform split order-N to order-0,
> > 2^(N-1) pages are scanned once, 2^(N-2) pages are scanned twice,
> > 2^(N-3) pages are scanned 3 times, ..., 4 pages are scanned N-4 times.
> > It can be optimized with some additional code in __split_folio_to_order=
().
> >
> > Something like the patch below, it assumes PageHWPoison(split_at) =3D=
=3D true:
> >
> > From 219466f5d5edc4e8bf0e5402c5deffb584c6a2a0 Mon Sep 17 00:00:00 2001
> > From: Zi Yan <ziy@nvidia.com>
> > Date: Tue, 18 Nov 2025 14:55:36 -0500
> > Subject: [PATCH] mm/huge_memory: optimize hwpoison page scan
> >
> > Signed-off-by: Zi Yan <ziy@nvidia.com>
> > ---
> >  mm/huge_memory.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index d716c6965e27..54a933a20f1b 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3233,8 +3233,11 @@ bool can_split_folio(struct folio *folio, int ca=
ller_pins, int *pextra_pins)
> >                                       caller_pins;
> >  }
> >
> > -static bool page_range_has_hwpoisoned(struct page *page, long nr_pages=
)
> > +static bool page_range_has_hwpoisoned(struct page *page, long nr_pages=
, struct page *donot_scan)
> >  {
> > +     if (donot_scan && donot_scan >=3D page && donot_scan < page + nr_=
pages)
> > +             return false;
> > +
> >       for (; nr_pages; page++, nr_pages--)
> >               if (PageHWPoison(page))
> >                       return true;
> > @@ -3246,7 +3249,7 @@ static bool page_range_has_hwpoisoned(struct page=
 *page, long nr_pages)
> >   * all the resulting folios.
> >   */
> >  static void __split_folio_to_order(struct folio *folio, int old_order,
> > -             int new_order)
> > +             int new_order, struct page *donot_scan)
> >  {
> >       /* Scan poisoned pages when split a poisoned folio to large folio=
s */
> >       const bool handle_hwpoison =3D folio_test_has_hwpoisoned(folio) &=
& new_order;
> > @@ -3258,7 +3261,7 @@ static void __split_folio_to_order(struct folio *=
folio, int old_order,
> >
> >       /* Check first new_nr_pages since the loop below skips them */
> >       if (handle_hwpoison &&
> > -         page_range_has_hwpoisoned(folio_page(folio, 0), new_nr_pages)=
)
> > +         page_range_has_hwpoisoned(folio_page(folio, 0), new_nr_pages,=
 donot_scan))
> >               folio_set_has_hwpoisoned(folio);
> >       /*
> >        * Skip the first new_nr_pages, since the new folio from them hav=
e all
> > @@ -3308,7 +3311,7 @@ static void __split_folio_to_order(struct folio *=
folio, int old_order,
> >                                LRU_GEN_MASK | LRU_REFS_MASK));
> >
> >               if (handle_hwpoison &&
> > -                 page_range_has_hwpoisoned(new_head, new_nr_pages))
> > +                 page_range_has_hwpoisoned(new_head, new_nr_pages, don=
ot_scan))
> >                       folio_set_has_hwpoisoned(new_folio);
> >
> >               new_folio->mapping =3D folio->mapping;
> > @@ -3438,7 +3441,7 @@ static int __split_unmapped_folio(struct folio *f=
olio, int new_order,
> >               folio_split_memcg_refs(folio, old_order, split_order);
> >               split_page_owner(&folio->page, old_order, split_order);
> >               pgalloc_tag_split(folio, old_order, split_order);
> > -             __split_folio_to_order(folio, old_order, split_order);
> > +             __split_folio_to_order(folio, old_order, split_order, uni=
form_split ? NULL : split_at);
> >
> >               if (is_anon) {
> >                       mod_mthp_stat(old_order, MTHP_STAT_NR_ANON, -1);
> > --
> > 2.51.0
> >
> > >> Or do we want to handle THPs as well, in case of split failure in
> > >> memory_failure()? if so we need to handle folio_test_has_hwpoisoned(=
)
> > >> case as well...
> > >
> > > Yeah, I think this is another good use case for our request to page a=
llocator.
> > >
> > >>
> > >>>>> inside the page allocator (probably non-uniform?). We can later r=
e-implement
> > >>>>> this to provide better support for memdescs.
> > >>>>
> > >>>> Yes, I like this approach.  But then I'm not the page allocator
> > >>>> maintainer ;-)
> > >>>
> > >>> If page allocator maintainers can weigh in here, that will be very =
helpful!
> > >>
> > >> Yeah, I'm not a maintainer either ;) it'll be great to get opinions
> > >> from page allocator folks!
> >
> > I think this is a good approach as long as it does not add too much ove=
rhead
> > on the page freeing path. Otherwise dispatch the job to a workqueue?
> >
> > Best Regards,
> > Yan, Zi

