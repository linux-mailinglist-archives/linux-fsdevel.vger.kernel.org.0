Return-Path: <linux-fsdevel+bounces-64796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE3DBF40BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 01:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4480E3BA87E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 23:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323C42FB984;
	Mon, 20 Oct 2025 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2czWeAJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EDE219E0
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 23:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761003678; cv=none; b=skaR8+JdKjHls/DSrM1Mxn7pJEKGm8U0r014heS5fxFN8dCysw2C6kLARP2qEX2Gb+kFR4snGQ4oSPvhPz2TDlykiQHOjtK23xD5Muvf/+8Dha0R0O+OZouVpx3jG0ZKqA444AASLdU15VtIzXMP/kwHxzCU3mB7oxCj9ZU87ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761003678; c=relaxed/simple;
	bh=MTD4dc+PGOJMw+DdPShTWHR5accsoid+l2mGwXpShow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JujBSIxVsh9UsheSCrzjv0jHFKiR/ibmg5NHPbKwxzPALyLJsHJQxg7Yyf9pZrpIMx/eNeDb3JyadaSTjBEkwLjuZPCyi8ct40shABkgaIOYg6iqMcaww+HD34+ucOYZl3c3fxRJtQ0j7L23u8DoO7OcpRr66vdj+ADBtNCdDCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2czWeAJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c11011e01so7926102a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 16:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761003675; x=1761608475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVHGg12fLQlilE+T8MY9DYY29gRCesjGg0Rsi3pSnR8=;
        b=P2czWeAJusPrGjv+kVHr8yKU46xPx4d59akfRHuUOBXheQ0gSawldrQF7j2tHT5L2L
         HQckwI+MyIZh/VwJ8ZqRghHzNhJg+fsLzgnTwUtrTtLB+Nb0RYlM0d2IN6nwF/sTCqrq
         h/117VeNm2hlxiqCxWgGeU5xryVv0P7xnkHgzM/MDeqJKkobaVQ1zIWJmKL+BMy6QeBw
         qmLedQ/S1VRJ1j9TZ/oiVKjnfEnvhRhitoPapuczXSNZ+rUjdRoHE11PwXEEAt4H+eGO
         R9crgKq2stguL6rx0BpHFROF5gWL/lDYLoIiluRru28K0YC7Pl58DdcpBw64iZC4AOcN
         RefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761003675; x=1761608475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVHGg12fLQlilE+T8MY9DYY29gRCesjGg0Rsi3pSnR8=;
        b=F68SW4QF2b59OK44Wmwj2fQ6Oq3MYfovizmg1bBuq4Zokt4g51rO3OU+awa8t0IIwc
         lSDhTYAm3adqCMN7GD329PuNx2UZuSaWTMWe3so939cZMXTALNnPTE6uurv0gG34Pvke
         iBuZdx4HBcctQfEPciWKA262is2Ar60+60eIRPOYt6IzX42FHGYixYywaTq0qiKHlM4M
         u/kPl0aPRJSRop/qVs0z+WinKJAFLRPFz3POVKmdlOZUNELaUMwp2FPEhcl9fL16PufE
         DBanHveJic9rTxEDr264anRPjBkPUxZ884DfXA7UlgA/5Idj4jEngzYDOuWcecXX0VMr
         WJ7g==
X-Forwarded-Encrypted: i=1; AJvYcCWJXbz52E71UTmuAIg9lJ0XiwGGfMBvjvtX/aYKL3ugfknC3k/+tYVfTBnhNOT2sJAyfa1PLnhhx4AUnOp8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1jEAQYyX6HQaV1firfL904CNopc2xm3A5MCz7yuLrelU4bvut
	5LaZaRVvumfb5EDlqC4AAp2jd/eRvy5EXQho1YVkE5BVs9j99h5GGzVNJO+gxUj6D6emoc8Azys
	S26RZCrJ28UW2Ip49C5NhtBUCiRY8GBY=
X-Gm-Gg: ASbGnctU4EFaFBSl51QcGrP3QobekaVmaTtoagP9InHmfmJ/gRHOLJodRWsNqsLmkue
	k+fecxsCnJ5aB8eIYotOLd4GqP9YxN/Tw3WvwJZJz+x/UaR1ih7iepEf2CY1d9HrOzuR9iLauAj
	Hu+cqqcPJ+U1yn41i+MaSj4R/2/JALPogYGccRBEl3DYVseJM7usT5QQpVgpRpnkPwhN9Qb55nn
	PwbwkOQCViO2upINWvJuI1EjDnK5xDJ/S2Y3+q/kTNQzds/CwB9fWJZwge8nx8HBWHiGaGu2Q==
X-Google-Smtp-Source: AGHT+IGCVi7HkPALGAh50zQQO6fGSMOaI+jhXkh2/BsTg7hBG14q/tm4iEaZSqUMR+1QulKNUnpwT7IfU7bfzg9SJp0=
X-Received: by 2002:a05:6402:84d:b0:63c:4537:75c0 with SMTP id
 4fb4d7f45d1cf-63c45377875mr9609309a12.38.1761003674815; Mon, 20 Oct 2025
 16:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016033452.125479-1-ziy@nvidia.com> <20251016033452.125479-3-ziy@nvidia.com>
 <CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com> <5EE26793-2CD4-4776-B13C-AA5984D53C04@nvidia.com>
In-Reply-To: <5EE26793-2CD4-4776-B13C-AA5984D53C04@nvidia.com>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 20 Oct 2025 16:41:02 -0700
X-Gm-Features: AS18NWDW-oprtmdqoGZJo4Z4YsO1liFomysWIh3Edtsp-B4vhH9CkUZKlFk_O8w
Message-ID: <CAHbLzkp8ob1_pxczeQnwinSL=DS=kByyL+yuTRFuQ0O=Eio0oA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm/memory-failure: improve large block size folio handling.
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, jane.chu@oracle.com, david@redhat.com, 
	kernel@pankajraghav.com, 
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org, mcgrof@kernel.org, 
	nao.horiguchi@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Wei Yang <richard.weiyang@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 12:46=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 17 Oct 2025, at 15:11, Yang Shi wrote:
>
> > On Wed, Oct 15, 2025 at 8:38=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> Large block size (LBS) folios cannot be split to order-0 folios but
> >> min_order_for_folio(). Current split fails directly, but that is not
> >> optimal. Split the folio to min_order_for_folio(), so that, after spli=
t,
> >> only the folio containing the poisoned page becomes unusable instead.
> >>
> >> For soft offline, do not split the large folio if it cannot be split t=
o
> >> order-0. Since the folio is still accessible from userspace and premat=
ure
> >> split might lead to potential performance loss.
> >>
> >> Suggested-by: Jane Chu <jane.chu@oracle.com>
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> >> ---
> >>  mm/memory-failure.c | 25 +++++++++++++++++++++----
> >>  1 file changed, 21 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >> index f698df156bf8..443df9581c24 100644
> >> --- a/mm/memory-failure.c
> >> +++ b/mm/memory-failure.c
> >> @@ -1656,12 +1656,13 @@ static int identify_page_state(unsigned long p=
fn, struct page *p,
> >>   * there is still more to do, hence the page refcount we took earlier
> >>   * is still needed.
> >>   */
> >> -static int try_to_split_thp_page(struct page *page, bool release)
> >> +static int try_to_split_thp_page(struct page *page, unsigned int new_=
order,
> >> +               bool release)
> >>  {
> >>         int ret;
> >>
> >>         lock_page(page);
> >> -       ret =3D split_huge_page(page);
> >> +       ret =3D split_huge_page_to_list_to_order(page, NULL, new_order=
);
> >>         unlock_page(page);
> >>
> >>         if (ret && release)
> >> @@ -2280,6 +2281,7 @@ int memory_failure(unsigned long pfn, int flags)
> >>         folio_unlock(folio);
> >>
> >>         if (folio_test_large(folio)) {
> >> +               int new_order =3D min_order_for_split(folio);
> >>                 /*
> >>                  * The flag must be set after the refcount is bumped
> >>                  * otherwise it may race with THP split.
> >> @@ -2294,7 +2296,14 @@ int memory_failure(unsigned long pfn, int flags=
)
> >>                  * page is a valid handlable page.
> >>                  */
> >>                 folio_set_has_hwpoisoned(folio);
> >> -               if (try_to_split_thp_page(p, false) < 0) {
> >> +               /*
> >> +                * If the folio cannot be split to order-0, kill the p=
rocess,
> >> +                * but split the folio anyway to minimize the amount o=
f unusable
> >> +                * pages.
> >> +                */
> >> +               if (try_to_split_thp_page(p, new_order, false) || new_=
order) {
> >
> > folio split will clear PG_has_hwpoisoned flag. It is ok for splitting
> > to order-0 folios because the PG_hwpoisoned flag is set on the
> > poisoned page. But if you split the folio to some smaller order large
> > folios, it seems you need to keep PG_has_hwpoisoned flag on the
> > poisoned folio.
>
> OK, this means all pages in a folio with folio_test_has_hwpoisoned() shou=
ld be
> checked to be able to set after-split folio's flag properly. Current foli=
o
> split code does not do that. I am thinking about whether that causes any
> issue. Probably not, because:
>
> 1. before Patch 1 is applied, large after-split folios are already causin=
g
> a warning in memory_failure(). That kinda masks this issue.
> 2. after Patch 1 is applied, no large after-split folios will appear,
> since the split will fail.

I'm a little bit confused. Didn't this patch split large folio to
new-order-large-folio (new order is min order)? So this patch had
code:
if (try_to_split_thp_page(p, new_order, false) || new_order) {

Thanks,
Yang

>
> @Miaohe and @Jane, please let me know if my above reasoning makes sense o=
r not.
>
> To make this patch right, folio's has_hwpoisoned flag needs to be preserv=
ed
> like what Yang described above. My current plan is to move
> folio_clear_has_hwpoisoned(folio) into __split_folio_to_order() and
> scan every page in the folio if the folio's has_hwpoisoned is set.
> There will be redundant scans in non uniform split case, since a has_hwpo=
isoned
> folio can be split multiple times (leading to multiple page scans), unles=
s
> the scan result is stored.
>
> @Miaohe and @Jane, is it possible to have multiple HW poisoned pages in
> a folio? Is the memory failure process like 1) page access causing MCE,
> 2) memory_failure() is used to handle it and split the large folio contai=
ning
> it? Or multiple MCEs can be received and multiple pages in a folio are ma=
rked
> then a split would happen?
>
> >
> > Yang
> >
> >
> >> +                       /* get folio again in case the original one is=
 split */
> >> +                       folio =3D page_folio(p);
> >>                         res =3D -EHWPOISON;
> >>                         kill_procs_now(p, pfn, flags, folio);
> >>                         put_page(p);
> >> @@ -2621,7 +2630,15 @@ static int soft_offline_in_use_page(struct page=
 *page)
> >>         };
> >>
> >>         if (!huge && folio_test_large(folio)) {
> >> -               if (try_to_split_thp_page(page, true)) {
> >> +               int new_order =3D min_order_for_split(folio);
> >> +
> >> +               /*
> >> +                * If the folio cannot be split to order-0, do not spl=
it it at
> >> +                * all to retain the still accessible large folio.
> >> +                * NOTE: if getting free memory is perferred, split it=
 like it
> >> +                * is done in memory_failure().
> >> +                */
> >> +               if (new_order || try_to_split_thp_page(page, new_order=
, true)) {
> >>                         pr_info("%#lx: thp split failed\n", pfn);
> >>                         return -EBUSY;
> >>                 }
> >> --
> >> 2.51.0
> >>
> >>
>
>
> --
> Best Regards,
> Yan, Zi

