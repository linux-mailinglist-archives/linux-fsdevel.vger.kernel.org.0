Return-Path: <linux-fsdevel+bounces-54164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 510FCAFBAA5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D543B1CC3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 18:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2F226463A;
	Mon,  7 Jul 2025 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kq2C6f9n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ECB262FD5
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912887; cv=none; b=DonD7NUUKnykAMrbDnqTUiBk+JUFN6JnD1CIPuYcJeUlXxyuR0EnIfLd0EdxwayYLpqNZO+TYvqsQz1OL9u74dSG9TVCOf1aVYks6iiNi34cW+Ng2hdQ863zZlmiYOLaSRSSsIKSdXPRzDl1pUBWXvskAuIRnfIRCCXETN9EEMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912887; c=relaxed/simple;
	bh=S9kEKj1+iXu7ajcvT5kRaKFBGmOU+As9xblZjGoEOIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeV4FynhoZfREsGVSK5bGJIESM08tJ+CZfZ08XyCglZ31U+T8RMAHcJTEq6+63KyUNnSC5rs9l+urvZQvxvj4/6GUzA6q5IyCH8ewQa4ybDWcKH8zDpRd5ZTNYoreWFeFNFFe8LJqrN7/EBPVMAkf8D5OxopqQSeYIZgsvATR94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kq2C6f9n; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7176c66e99cso21178297b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751912885; x=1752517685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owDFJen4YTDNma7AUk9STl34vl+r82F90HPmi/p/5YA=;
        b=kq2C6f9nruYK5wyeHuaOOIuRZ6dzl9peIokrlyXBlVlFq1UBUVtmIKl2dADSEWhaVr
         qcGjUqH+zuEwJ96AGPUq6dCM4LQp7DH6UnYE+6pwEtYSDbQym9gYqHMC4cDypOD/n7hU
         6HGrBS/N2kE1//jDeutAplge27QLLdN6fCsNn707x531twz8EN0ai3mIAo/iM0ILfZUZ
         8lKIWXhv9aUuB4N1rDxl7CHTLmtGUls8UdPHXoSXDq5gvsmuHx+WOqiJ/xRQKW2FFiVG
         igLnjEh3eqU+Zu5FUTR+jVwbvNgtXirmHwTaI0MuhYugW+JKV1KyAV04hZcrBKCww7Tw
         n74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751912885; x=1752517685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owDFJen4YTDNma7AUk9STl34vl+r82F90HPmi/p/5YA=;
        b=de7knJCk45BWJqf0d4Vzz/epdqzFSIt0QokhKCh64cwI4G/JPubKi2eod18T4xGVQe
         XLvFDDWUx767w7tyR0NOqj7iIby3P3EXnlKbYOkJ0DfCzjuEdKiEaAZ6O5sArH1F0lqh
         yqOTgVzAu4eNr8cpg4b7tQ1bn4yf+tZIjus8Uu0r58TzZ7B8Jt7lKPHXgUTUNB7aGICi
         V8daqE4vVs8MgVqxlvFkoiTvTxfbhX5JSr4+XdJ7e6FaBziw9U2RqqSYKAKUHsaUpdm4
         Mm0ysTFxnCGk1M+ysi4bKikr62pV19GkrRVyM1fMbaxsOHLsGVR8oXPBQM5p3ZeHIyvQ
         wP5A==
X-Forwarded-Encrypted: i=1; AJvYcCUtYFegbxZxpBOP7Jkcdq15O+X9Y2au/5C5/gjhMlmtV1rmfyOU9fPo0KqH0iZznUvpv2//TFIxCeSHegDL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc5DMapLkfJK5wRyRFFnFUX7ZldywfFn/xTAtjdvFRSN4rpWrA
	lpfDI6tl6JPPs1zYDcsBd0F1gyok7lIs+SirnwjTWZUo0DPQlJIrPcH7zmgGTDkMXMW7LrnZqWN
	byXdEZ8/c67HeTRopET0ru/qr0/ZCqlhskTjGAszQW0RIeXhqR+buwdkl6XInFA==
X-Gm-Gg: ASbGncs1XTPoa3TfnlQsuRBkr2a7enu3xfU7n5HXFwKhE36cgS0NRuFyduFxtRF8wJc
	FWQxuD+fBxCDVnZw/vRe7DxJpBwClVwE9bcB6CKh9RY3NuHHCbC+rIkYpjSFf1wdfIRWOvIXN/k
	JjxjMd3TctgXsA3PJe2IW7nZmtqyeOjJzCpAzE6fd0cYcibaaMeNTwQfCpox9wP8Ih/U1NfeOe/
	w==
X-Google-Smtp-Source: AGHT+IGALxRhMgh7BE91T+jJhyG+rEGC8sNFThaOOtDHVthOVl+i2kZqlVjxvI4H8+dEE+6nS2sYRpdFrW0Z4Ws+/BQ=
X-Received: by 2002:a05:690c:6f02:b0:713:f7dd:5d7c with SMTP id
 00721157ae682-71668ded91cmr174799297b3.19.1751912884636; Mon, 07 Jul 2025
 11:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <8548af334e01401a776aae37a0e9f30f9ffbba8c.1747264138.git.ackerleytng@google.com>
In-Reply-To: <8548af334e01401a776aae37a0e9f30f9ffbba8c.1747264138.git.ackerleytng@google.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 7 Jul 2025 11:27:28 -0700
X-Gm-Features: Ac12FXwfXFYyW7dt7flmw9fdJeBgsdRSXtn9Ce_9e810HW9a_XvXDOUG_TQfUZU
Message-ID: <CADrL8HXczKJnrCA0wD2qMHPtV1+VCW+mgJC2LSa5DsEuX4++Uw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 16/51] mm: hugetlb: Consolidate interpretation of
 gbl_chg within alloc_hugetlb_folio()
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jun.miao@intel.com, kai.huang@intel.com, 
	keirf@google.com, kent.overstreet@linux.dev, kirill.shutemov@intel.com, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, 
	mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net, 
	michael.roth@amd.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, 
	qperret@google.com, quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 4:43=E2=80=AFPM Ackerley Tng <ackerleytng@google.co=
m> wrote:
>
> Previously, gbl_chg was passed from alloc_hugetlb_folio() into
> dequeue_hugetlb_folio_vma(), leaking the concept of gbl_chg into
> dequeue_hugetlb_folio_vma().
>
> This patch consolidates the interpretation of gbl_chg into
> alloc_hugetlb_folio(), also renaming dequeue_hugetlb_folio_vma() to
> dequeue_hugetlb_folio() so dequeue_hugetlb_folio() can just focus on
> dequeuing a folio.
>
> Change-Id: I31bf48af2400b6e13b44d03c8be22ce1a9092a9c
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

I think I agree with Binbin[1] to either put the rename of
dequeue_hugetlb_folio{_vma =3D> }() in its own patch or drop it
entirely.

I think the rename would 100% make sense if all of the
dequeue_hugetlb_folio*() functions were called from
dequeue_hugetlb_folio_vma() (i.e., after this patch,
dequeue_hugetlb_folio() was always the entry point to dequeue a
folio), but in fact dequeue_hugetlb_folio_nodemask() is not always
called from dequeue_hugetlb_folio_vma().

I don't feel strongly at all, either way the name is not confusing. So
feel free to add:

Reviewed-by: James Houghton <jthoughton@google.com>

[1]: https://lore.kernel.org/all/ad77da83-0e6e-47a1-abe7-8cfdfce8b254@linux=
.intel.com/

> ---
>  mm/hugetlb.c | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6ea1be71aa42..b843e869496f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1364,9 +1364,9 @@ static unsigned long available_huge_pages(struct hs=
tate *h)
>         return h->free_huge_pages - h->resv_huge_pages;
>  }
>
> -static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
> -                               struct vm_area_struct *vma,
> -                               unsigned long address, long gbl_chg)
> +static struct folio *dequeue_hugetlb_folio(struct hstate *h,
> +                                          struct vm_area_struct *vma,
> +                                          unsigned long address)
>  {
>         struct folio *folio =3D NULL;
>         struct mempolicy *mpol;
> @@ -1374,13 +1374,6 @@ static struct folio *dequeue_hugetlb_folio_vma(str=
uct hstate *h,
>         nodemask_t *nodemask;
>         int nid;
>
> -       /*
> -        * gbl_chg=3D=3D1 means the allocation requires a new page that w=
as not
> -        * reserved before.  Making sure there's at least one free page.
> -        */
> -       if (gbl_chg && !available_huge_pages(h))
> -               goto err;
> -
>         gfp_mask =3D htlb_alloc_mask(h);
>         nid =3D huge_node(vma, address, gfp_mask, &mpol, &nodemask);
>
> @@ -1398,9 +1391,6 @@ static struct folio *dequeue_hugetlb_folio_vma(stru=
ct hstate *h,
>
>         mpol_cond_put(mpol);
>         return folio;
> -
> -err:
> -       return NULL;
>  }
>
>  /*
> @@ -3074,12 +3064,16 @@ struct folio *alloc_hugetlb_folio(struct vm_area_=
struct *vma,
>                 goto out_uncharge_cgroup_reservation;
>
>         spin_lock_irq(&hugetlb_lock);
> +
>         /*
> -        * glb_chg is passed to indicate whether or not a page must be ta=
ken
> -        * from the global free pool (global change).  gbl_chg =3D=3D 0 i=
ndicates
> -        * a reservation exists for the allocation.
> +        * gbl_chg =3D=3D 0 indicates a reservation exists for the alloca=
tion - so
> +        * try dequeuing a page. If there are available_huge_pages(), try=
 using
> +        * them!
>          */
> -       folio =3D dequeue_hugetlb_folio_vma(h, vma, addr, gbl_chg);
> +       folio =3D NULL;
> +       if (!gbl_chg || available_huge_pages(h))
> +               folio =3D dequeue_hugetlb_folio(h, vma, addr);
> +
>         if (!folio) {
>                 spin_unlock_irq(&hugetlb_lock);
>                 folio =3D alloc_buddy_hugetlb_folio_with_mpol(h, vma, add=
r);
> --
> 2.49.0.1045.g170613ef41-goog
>

