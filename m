Return-Path: <linux-fsdevel+bounces-28016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08513966133
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E51288D62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 11:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F73E199934;
	Fri, 30 Aug 2024 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bco1LBrB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3A91917C8
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019151; cv=none; b=TFXicvFbFdpFzLsN2xhAiwjcJUKhF+i71ZeJJbKm7Waz0WCy1dFcUWEKjXFqWyaU/xsL5ssYoU4N1xKYmXgRf9CiRnmt3yWFgLnapZSK8ZQwduUuyj0a2x9pAJ20YuPf37sQV6zOCAABeBd1fUmirwlYqrJHi4IMIOzJHGZbLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019151; c=relaxed/simple;
	bh=Do/dKTgzKyjKV3wG/nTXEGEsup4OPV6FVk1d8aqBgs0=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=EGCyiwzt0CFCqHj1+RFGiM2vp7qhCdD3xnnEWCaHE+mxFJ2pjQOcZzBipEVqHvzyoQwTz5ZppbK8mPNQoosA/gV93oPggtOepBP/IxaBoGG+n+qpPMZdPLRxsT6C+K7oxzNa3Fe1EtKSV9xtNgD6zcTiXFITDSGWNq3GaNu7J+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bco1LBrB; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240830115901euoutp02deb8fe275fca7fd9beab0755789f7e34~wf8TuM0gb2915529155euoutp02g
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 11:59:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240830115901euoutp02deb8fe275fca7fd9beab0755789f7e34~wf8TuM0gb2915529155euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725019141;
	bh=8HWjlCk36MrIJSrgWwx1NmtEBTy4vjMaSH0kx3VdLd0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bco1LBrBZupyWRz52Pcm5M6dAIAykk31d/RkDfQNKXJ7uayVO6zP95i/US3ZvPNGI
	 UGcD3Hb7EtaAZ61gBAczrPe3HG1lme8djLaUgcpFQbjGc1kc3m6p8fCgY8VdxPAd5F
	 uWasUKsIotVxKNri48tHnu8pTSjE7jEwXA92xc4A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240830115900eucas1p1904693aec6c26d37328f2ce5ba0b66ee~wf8TPibCT2191621916eucas1p1Q;
	Fri, 30 Aug 2024 11:59:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 5C.35.09624.404B1D66; Fri, 30
	Aug 2024 12:59:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240830115859eucas1p2e384f48594d104a5fc9fb24e87c6fd24~wf8SlIV_t0820908209eucas1p2L;
	Fri, 30 Aug 2024 11:58:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240830115859eusmtrp18799b0ad847be3279ca20891fbd4c7ad~wf8SkCqRi2130721307eusmtrp1n;
	Fri, 30 Aug 2024 11:58:59 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-d3-66d1b404249a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D2.B8.19096.304B1D66; Fri, 30
	Aug 2024 12:58:59 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240830115859eusmtip155b93040a53676de393ba4eb081c20f4~wf8SPiRhu1205512055eusmtip1b;
	Fri, 30 Aug 2024 11:58:59 +0000 (GMT)
Received: from localhost (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 30 Aug 2024 12:58:58 +0100
Date: Fri, 30 Aug 2024 13:58:58 +0200
From: Daniel Gomez <da.gomez@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>, "Sven
 Schnelle" <svens@linux.ibm.com>, "Pankaj Raghav (Samsung)"
	<kernel@pankajraghav.com>, <brauner@kernel.org>,
	<akpm@linux-foundation.org>, <chandan.babu@oracle.com>,
	<linux-fsdevel@vger.kernel.org>, <djwong@kernel.org>, <hare@suse.de>,
	<gost.dev@samsung.com>, <linux-xfs@vger.kernel.org>, <hch@lst.de>,
	<david@fromorbit.com>, <yang@os.amperecomputing.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<john.g.garry@oracle.com>, <cl@os.amperecomputing.com>,
	<p.raghav@samsung.com>, <ryan.roberts@arm.com>, David Howells
	<dhowells@redhat.com>, <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v13 04/10] mm: split a folio in minimum folio order
 chunks
Message-ID: <20240830115858.fzsmindasycwphkv@AALNPWDAGOMEZ1.aal.scsc.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtEHPAsIHKxUHBZX@bombadil.infradead.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7djP87osWy6mGbx9ImExZ/0aNovXhz8x
	Wlw6Kmexbu1DJostx+4xWrxr+s1icfkJn8WeRZOYLFauPspkceHXDkaLMy8/s1js2XsSKLlr
	DpvFvTX/WS0mLGxmttj1Zwe7xY0JTxktenZPZbRYtn4tu8XvH0AlvUtOslvMPnqP3UHMY828
	NYwepxZJeGxeoeWxaVUnm8emT5PYPU7M+M3iMWHRAUaP3Tcb2Dx6m9+xeXx8eovFo/vyDXaP
	sysdPd7vu8rmsfl0tcfnTXIB/FFcNimpOZllqUX6dglcGRuutzIVdGpVbLj2iLWB8YxiFyMn
	h4SAicS/iz9Yuxi5OIQEVjBK3G5+yQ7hfGGU+HPvDCOE85lR4nrTUjaYlqdf30MlljNK9B17
	jlB1qG0h1LDNjBI3Nj4Ga2ERUJWYuGAXM4jNJqApse/kJnYQW0RAQ2LfhF4mkAZmgfmsElPX
	nQdLCAsESOx6+5ERxOYV8Ja4PfcYC4QtKHFy5hMgmwOoQVNi/S59CFNaYvk/DpAKZgF5ieat
	s8FWcQqYSXzceZ8R4mpFiRkTV7JA2LUSp7bcAlsrIbCSS+LEvw4miISLxN/V16EahCVeHd/C
	DmHLSJye3APVnC6xZN0sKLtAYs/tWawgN0gIWEv0ncmBCDtK7HqzlRkizCdx460gxGl8EpO2
	TYcK80p0tAlNYFSZheStWQhvzUJ4axaStxYwsqxiFE8tLc5NTy02zEst1ytOzC0uzUvXS87P
	3cQITLen/x3/tINx7quPeocYmTgYDzFKcDArifCeOH42TYg3JbGyKrUoP76oNCe1+BCjNAeL
	kjivaop8qpBAemJJanZqakFqEUyWiYNTqoFpaqeqgMClu6Eugf+M4xhXf5myljlTZ6ehL7v9
	Ut8ptisPvuCyncrcsTB/8eSmml3p27tePVx55NNyu0MNB+Tq2R1vexgHuxYuVvHfL8V1LF96
	nfEDXpmfguWTsnKdT0Uk6WcmV7v1xUe1lTI07JAt2X3lyPqqwtWN+Syx332MVvJJxN1x2GdX
	VlC5oMg+2O+U1Pf2Pl97Tm13FVad7S35MbUnK90zdjz60v6r9nVM9Lxc61M7FP+6WXgcPXd1
	s/YVEdljLz/OUdXjvLg291lyDpfA+eKvy3b4e+lMTpAWmHuZ3+DuZx/VCW95+s+KzOybV2Cq
	X+h81m0+t2iHP3eG0fvVx33CRO5dOxRyWomlOCPRUIu5qDgRAJcpHyAmBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsVy+t/xu7rMWy6mGbzboGoxZ/0aNovXhz8x
	Wlw6Kmexbu1DJostx+4xWrxr+s1icfkJn8WeRZOYLFauPspkceHXDkaLMy8/s1js2XsSKLlr
	DpvFvTX/WS0mLGxmttj1Zwe7xY0JTxktenZPZbRYtn4tu8XvH0AlvUtOslvMPnqP3UHMY828
	NYwepxZJeGxeoeWxaVUnm8emT5PYPU7M+M3iMWHRAUaP3Tcb2Dx6m9+xeXx8eovFo/vyDXaP
	sysdPd7vu8rmsfl0tcfnTXIB/FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkam
	Svp2NimpOZllqUX6dgl6GRuutzIVdGpVbLj2iLWB8YxiFyMnh4SAicTTr+8Zuxi5OIQEljJK
	XLi/kgkiISOx8ctVVghbWOLPtS42iKKPjBK9s/8yQzibGSX2bf/DDlLFIqAqMXHBLmYQm01A
	U2LfyU1gcREBDYl9E3qZQBqYBeayShz8OQFshbCAn8TC1dvZQGxeAW+J23OPsUBMXcAs8fX0
	HUaIhKDEyZlPgBIcQN2aEut36UOY0hLL/3GAVDALyEs0b50NtpdTwEzi4877jBBXK0rMmLiS
	BcKulfj89xnjBEaRWUiGzkIYOgth6CwkQxcwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQI
	TEjbjv3csoNx5auPeocYmTgYDzFKcDArifCeOH42TYg3JbGyKrUoP76oNCe1+BCjKTCEJjJL
	iSbnA1NiXkm8oZmBqaGJmaWBqaWZsZI4L9uV82lCAumJJanZqakFqUUwfUwcnFINTEWW07fe
	CSyVS+H43la/5eLmTg9/k0keUiuVs60YCl3Fr/rMc9uzqP51+vq+gp/NXx+YTeP5/ds9za3d
	q3Img+La86F3lle8uLliwcXNcX7ab9ktmeIOLF70+l26bVrzeSfNYpWqNS86+/dafp1su7Ph
	qvdV61TTVTs1GG5a1yU8Eny47Y6rUt+NBdsiZ1vv41rx9GLYx9+Rew3XiOckCF4oWnfnHNuf
	tvMqj36aLNr+/fG2iD0XlHXV/zJNlCqzvbhQSkfuGoMy/7JMh7kWK10Tlb7f187ZFbzyoouk
	peb91uMqsnwLsu7td2k5Lreia+WPZbtPcm00vOR/hWH201kHf27sXZX3bPqCisMnH3srsRRn
	JBpqMRcVJwIAFUFGDdEDAAA=
X-CMS-MailID: 20240830115859eucas1p2e384f48594d104a5fc9fb24e87c6fd24
X-Msg-Generator: CA
X-RootMTR: 20240829234204eucas1p26c2785f434a9355a4b20ac3499e9c0f2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240829234204eucas1p26c2785f434a9355a4b20ac3499e9c0f2
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
	<20240822135018.1931258-5-kernel@pankajraghav.com>
	<yt9dttf3r49e.fsf@linux.ibm.com> <ZtDCErRjh8bC5Y1r@bombadil.infradead.org>
	<ZtDSJuI2hYniMAzv@casper.infradead.org>
	<221FAE59-097C-4D31-A500-B09EDB07C285@nvidia.com>
	<CGME20240829234204eucas1p26c2785f434a9355a4b20ac3499e9c0f2@eucas1p2.samsung.com>
	<ZtEHPAsIHKxUHBZX@bombadil.infradead.org>

On Thu, Aug 29, 2024 at 04:41:48PM -0700, Luis Chamberlain wrote:
> On Thu, Aug 29, 2024 at 06:12:26PM -0400, Zi Yan wrote:
> > The issue is that the change to split_huge_page() makes split_huge_page_to_list_to_order()
> > unlocks the wrong subpage. split_huge_page() used to pass the “page” pointer
> > to split_huge_page_to_list_to_order(), which keeps that “page” still locked.
> > But this patch changes the “page” passed into split_huge_page_to_list_to_order()
> > always to the head page.
> > 
> > This fixes the crash on my x86 VM, but it can be improved:
> > 
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 7c50aeed0522..eff5d2fb5d4e 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -320,10 +320,7 @@ bool can_split_folio(struct folio *folio, int *pextra_pins);
> >  int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> >                 unsigned int new_order);
> >  int split_folio_to_list(struct folio *folio, struct list_head *list);
> > -static inline int split_huge_page(struct page *page)
> > -{
> > -       return split_folio(page_folio(page));
> > -}
> > +int split_huge_page(struct page *page);
> >  void deferred_split_folio(struct folio *folio);
> > 
> >  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index c29af9451d92..4d723dab4336 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3297,6 +3297,25 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> >         return ret;
> >  }
> > 
> > +int split_huge_page(struct page *page)
> > +{
> > +       unsigned int min_order = 0;
> > +       struct folio *folio = page_folio(page);
> > +
> > +       if (folio_test_anon(folio))
> > +               goto out;
> > +
> > +       if (!folio->mapping) {
> > +               if (folio_test_pmd_mappable(folio))
> > +                       count_vm_event(THP_SPLIT_PAGE_FAILED);
> > +               return -EBUSY;
> > +       }
> > +
> > +       min_order = mapping_min_folio_order(folio->mapping);
> > +out:
> > +       return split_huge_page_to_list_to_order(page, NULL, min_order);
> > +}
> > +
> >  int split_folio_to_list(struct folio *folio, struct list_head *list)
> >  {
> >         unsigned int min_order = 0;
> 
> 
> Confirmed, and also although you suggest it can be improved, I thought
> that we could do that by sharing more code and putting things in the
> headers, the below also fixes this but tries to share more code, but
> I think it is perhaps less easier to understand than your patch.
> 
> So I think your patch is cleaner and easier as a fix.

I reproduced it in arm64 as well. And both fixes provided solved the issue.

> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index c275aa9cc105..99cd9c7bf55b 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -97,6 +97,7 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
>  	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
>  
>  #define split_folio(f) split_folio_to_list(f, NULL)
> +#define split_folio_to_list(f, list) split_page_folio_to_list(&f->page, f, list)
>  
>  #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
>  #define HPAGE_PMD_SHIFT PMD_SHIFT
> @@ -331,10 +332,11 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
>  bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
>  int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  		unsigned int new_order);
> -int split_folio_to_list(struct folio *folio, struct list_head *list);
> +int split_page_folio_to_list(struct page *page, struct folio *folio,
> +			     struct list_head *list);
>  static inline int split_huge_page(struct page *page)
>  {
> -	return split_folio(page_folio(page));
> +	return split_page_folio_to_list(page, page_folio(page), NULL);
>  }
>  void deferred_split_folio(struct folio *folio);
>  
> @@ -511,7 +513,9 @@ static inline int split_huge_page(struct page *page)
>  	return 0;
>  }
>  
> -static inline int split_folio_to_list(struct folio *folio, struct list_head *list)
> +static inline int split_page_folio_to_list(struct page *page,
> +					   struct folio *folio,
> +					   struct list_head *list)
>  {
>  	return 0;
>  }
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 169f1a71c95d..b115bfe63b52 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3529,7 +3529,8 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  	return ret;
>  }
>  
> -int split_folio_to_list(struct folio *folio, struct list_head *list)
> +int split_page_folio_to_list(struct page *page, struct folio *folio,
> +			     struct list_head *list)
>  {
>  	unsigned int min_order = 0;
>  
> @@ -3544,8 +3545,7 @@ int split_folio_to_list(struct folio *folio, struct list_head *list)
>  
>  	min_order = mapping_min_folio_order(folio->mapping);
>  out:
> -	return split_huge_page_to_list_to_order(&folio->page, list,
> -							min_order);
> +	return split_huge_page_to_list_to_order(page, list, min_order);
>  }
>  
>  void __folio_undo_large_rmappable(struct folio *folio)

