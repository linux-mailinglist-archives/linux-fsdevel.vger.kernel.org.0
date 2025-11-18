Return-Path: <linux-fsdevel+bounces-69013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DF1C6B6E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 20:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47E4A4EABF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 19:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1932E6100;
	Tue, 18 Nov 2025 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXshOyI/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C782E542C
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494003; cv=none; b=IXnEKMbyfwOyCxf3kjMv2eg4LzvbX9WpFDkKey+lhBGTthiguk3TEArSNHhJ4HqQYpLm5Kz18rTpy54tkhoqOT8w8zrhFw19cmLMlW2v8b1IrCLgB+E5OzB/0tT5wBzEIlJEDosZMlBe8UiiLA1uXUYhy/XOEdNsYyPX1iY4Pyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494003; c=relaxed/simple;
	bh=5HJNZkO1w4ukoBUBq/KeRhfOtkoOFO2L/SuDcKH2d7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmAmTUpAAQw5afyVGptZZ+Td1P3itmkP5Tf3DhIYF3i/OlqDPf8ktja48gP4Da4I27tgeqROIRIk0LjJaES4YnA7uHTJ6S2qc8qTpuHLGlMtmPmcvx7fkY/Eczz/HkwwSRMPDWYExFsLva9afKn3LUAUM15UuOB8Yj1OkzO7YTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXshOyI/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477a1c8cc47so9305e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 11:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763493999; x=1764098799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GA+zLGNQzKnu3qorDuQDpitiUTXEO0YlCfq5W/VFuZU=;
        b=JXshOyI/8DN5tpzlSiQgYukW+8e9FkGJLbbqxOfRjCzljp5RqEFt5+J+ex/P65ARWS
         EpSDHYMuw1kfqS+NjBZtqBDmSszyGNE6ZNA0CuQXeb/sbZtAbNpLjVyCsb1Kv3g0SAOW
         Z8eoUmZ9XnnLFM5wJZMsBRo49cHMmPdOGbGxAuO5ZPildsZXQ1dt16qE74DOMUJcmNxg
         zq9DpxMRV0bGRn8S4xYacBv+ZSv9H1rUFhAMTh9Z/U20hK+K9wp9TYA8CwsAepPgw7ap
         6zTMvZZguQnvHo1S9Y+6zAPobSzIQcxCjDfldECiI+p8Lg7HTyxhpkbsJm/EgR0bwt61
         bWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763493999; x=1764098799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GA+zLGNQzKnu3qorDuQDpitiUTXEO0YlCfq5W/VFuZU=;
        b=Q+3s7/nQjebaB2ueqwmxbF4HyzMPImoJAiLGRife73bQwjbpp1L/3ce0jOWxuGeNEX
         VSr1QazJaKtVQt2tg3eBPoFeOfQV5UANTkisHY7OQTUJwEkRrAIK8Ps/EIu6qLg+NI1j
         T5a7LnXgJDDrg4/chwRbaXGShRsjacrymEXTTQu1aEi8JjkFkBXqMu5kBOZZZEkXxRWi
         ZPZqaVAfw9kGya+EoED/brl2Ulr99jQuEiWpSfJitH4RvTVRiBtFkv3H0nS4deOfzGV6
         ZS8fwWkhXSgYCJTcn+gcrKr4bJsdL4yMnvhJK0UuFLUJqFsJYRhaXwZS3V15Tfnr+M26
         Ohow==
X-Forwarded-Encrypted: i=1; AJvYcCXmomOzqgG2IvvPUzNSpbST6ju7srjrE3oHTmxYSjeFvo3X2pNFb0rPyKc0W/3F4Lu0l686m/9xv5DMrhVS@vger.kernel.org
X-Gm-Message-State: AOJu0YzqlCGjy/HaU75ZHfugu9s5gMojqJwSdbVUdk9F570NqtxYkvnO
	E0MDYLqwM/npPXudw8q7g8nBHNGORIw25wAZo1W6ChbUKS7RG8heUpQm7brrwYElm7XQd71QIHf
	MBF+ZpOGD3Svln+uD+ofZfST46QHZHi55jH4xUbVT
X-Gm-Gg: ASbGncv0EQq0Goy5nwlBHxHcqfPVFBa41bTj7Kp/YMgrm0J+WN0nXqFIaZr+M0ilDkV
	Atihh0Nm+CSWr3QLPr3oHa6kvX8kNkZ2ZanpiPawn36dTvm9YpNjP80LH/rb8abSlRHQYprTSgI
	q01NU0MCOjTCU80lokShXMba29EYpx05oCRSLmFc6DFiB47nSF7dZUCGBY83EvRobtspASakc68
	JOY+8K8XJLfcukQRS2s6x6HjijSDjmG+dErX2q1l0vkwUdYz10STnritCugbz5zB2UjbbZwwowU
	1oz6SZ5dooS1oW9bY8ptgT+nfw==
X-Google-Smtp-Source: AGHT+IEysZiub5Ivc8ctKaVMpHOPlPVzbnxwgaM/P+IFAtMIvhAI17rSqBiFsAeJl5PaeklqKb5lCjoXEtjGGtmWDSc=
X-Received: by 2002:a05:600d:112:b0:477:255c:bea8 with SMTP id
 5b1f17b1804b1-477b1243673mr111675e9.7.1763493998762; Tue, 18 Nov 2025
 11:26:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116014721.1561456-1-jiaqiyan@google.com> <20251116014721.1561456-2-jiaqiyan@google.com>
 <aRm6shtKizyrq_TA@casper.infradead.org> <aRqTLmJBuvBcLYMx@hyeyoo>
 <aRsmaIfCAGy-DRcx@casper.infradead.org> <CACw3F50E=AZtgfoExCA-nwS6=NYdFFWpf6+GBUYrWiJOz4xwaw@mail.gmail.com>
 <aRxIP7StvLCh-dc2@hyeyoo>
In-Reply-To: <aRxIP7StvLCh-dc2@hyeyoo>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 18 Nov 2025 11:26:27 -0800
X-Gm-Features: AWmQ_bkGjatHcvMvfv8N94vNdxa0KML4Ogn8iSmfd4AKJOPSCC92qeDqRDaPVwg
Message-ID: <CACw3F53Rck2Bf_C45Uk=A1NJ4zB1B0R1+GqvkNxsz3h3mDx-pQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm/huge_memory: introduce uniform_split_unmapped_folio_to_zero_order
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, ziy@nvidia.com, david@redhat.com, 
	Vlastimil Babka <vbabka@suse.cz>, nao.horiguchi@gmail.com, linmiaohe@huawei.com, 
	lorenzo.stoakes@oracle.com, william.roche@oracle.com, tony.luck@intel.com, 
	wangkefeng.wang@huawei.com, jane.chu@oracle.com, akpm@linux-foundation.org, 
	osalvador@suse.de, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 2:20=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Mon, Nov 17, 2025 at 10:24:27PM -0800, Jiaqi Yan wrote:
> > On Mon, Nov 17, 2025 at 5:43=E2=80=AFAM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Mon, Nov 17, 2025 at 12:15:23PM +0900, Harry Yoo wrote:
> > > > On Sun, Nov 16, 2025 at 11:51:14AM +0000, Matthew Wilcox wrote:
> > > > > But since we're only doing this on free, we won't need to do foli=
o
> > > > > allocations at all; we'll just be able to release the good pages =
to the
> > > > > page allocator and sequester the hwpoison pages.
> > > >
> > > > [+Cc PAGE ALLOCATOR folks]
> > > >
> > > > So we need an interface to free only healthy portion of a hwpoison =
folio.
> >
> > +1, with some of my own thoughts below.
> >
> > > >
> > > > I think a proper approach to this should be to "free a hwpoison fol=
io
> > > > just like freeing a normal folio via folio_put() or free_frozen_pag=
es(),
> > > > then the page allocator will add only healthy pages to the freelist=
 and
> > > > isolate the hwpoison pages". Oherwise we'll end up open coding a lo=
t,
> > > > which is too fragile.
> > >
> > > Yes, I think it should be handled by the page allocator.  There may b=
e
> >
> > I agree with Matthew, Harry, and David. The page allocator seems best
> > suited to handle HWPoison subpages without any new folio allocations.
>
> Sorry I should have been clearer. I don't think adding an **explicit**
> interface to free an hwpoison folio is worth; instead implicitly
> handling during freeing of a folio seems more feasible.

That's fine with me, just more to be taken care of by page allocator.

>
> > > some complexity to this that I've missed, eg if hugetlb wants to reta=
in
> > > the good 2MB chunks of a 1GB allocation.  I'm not sure that's a usefu=
l
> > > thing to do or not.
> > >
> > > > In fact, that can be done by teaching free_pages_prepare() how to h=
andle
> > > > the case where one or more subpages of a folio are hwpoison pages.
> > > >
> > > > How this should be implemented in the page allocator in memdescs wo=
rld?
> > > > Hmm, we'll want to do some kind of non-uniform split, without actua=
lly
> > > > splitting the folio but allocating struct buddy?
> > >
> > > Let me sketch that out, realising that it's subject to change.
> > >
> > > A page in buddy state can't need a memdesc allocated.  Otherwise we'r=
e
> > > allocating memory to free memory, and that way lies madness.  We can'=
t
> > > do the hack of "embed struct buddy in the page that we're freeing"
> > > because HIGHMEM.  So we'll never shrink struct page smaller than stru=
ct
> > > buddy (which is fine because I've laid out how to get to a 64 bit str=
uct
> > > buddy, and we're probably two years from getting there anyway).
> > >
> > > My design for handling hwpoison is that we do allocate a struct hwpoi=
son
> > > for a page.  It looks like this (for now, in my head):
> > >
> > > struct hwpoison {
> > >         memdesc_t original;
> > >         ... other things ...
> > > };
> > >
> > > So we can replace the memdesc in a page with a hwpoison memdesc when =
we
> > > encounter the error.  We still need a folio flag to indicate that "th=
is
> > > folio contains a page with hwpoison".  I haven't put much thought yet
> > > into interaction with HUGETLB_PAGE_OPTIMIZE_VMEMMAP; maybe "other thi=
ngs"
> > > includes an index of where the actually poisoned page is in the folio=
,
> > > so it doesn't matter if the pages alias with each other as we can rec=
over
> > > the information when it becomes useful to do so.
> > >
> > > > But... for now I think hiding this complexity inside the page alloc=
ator
> > > > is good enough. For now this would just mean splitting a frozen pag=
e
> >
> > I want to add one more thing. For HugeTLB, kernel clears the HWPoison
> > flag on the folio and move it to every raw pages in raw_hwp_page list
> > (see folio_clear_hugetlb_hwpoison). So page allocator has no hint that
> > some pages passed into free_frozen_pages has HWPoison. It has to
> > traverse 2^order pages to tell, if I am not mistaken, which goes
> > against the past effort to reduce sanity checks. I believe this is one
> > reason I choosed to handle the problem in hugetlb / memory-failure.
>
> I think we can skip calling folio_clear_hugetlb_hwpoison() and teach the

Nit: also skip folio_free_raw_hwp so the hugetlb-specific llist
containing the raw pages and owned by memory-failure is preserved? And
expect the page allocator to use it for whatever purpose then free the
llist? Doesn't seem to follow the correct ownership rule.

> buddy allocator to handle this. free_pages_prepare() already handles
> (PageHWPoison(page) && !order) case, we just need to extend that to
> support hugetlb folios as well.
>
> > For the new interface Harry requested, is it the caller's
> > responsibility to ensure that the folio contains HWPoison pages (to be
> > even better, maybe point out the exact ones?), so that page allocator
> > at least doesn't waste cycles to search non-exist HWPoison in the set
> > of pages?
>
> With implicit handling it would be the page allocator's responsibility
> to check and handle hwpoison hugetlb folios.

Does this mean we must bake hugetlb-specific logic in the page
allocator's freeing path? AFAICT today the contract in
free_frozen_page doesn't contain much hugetlb info.

I saw there is already some hugetlb-specific logic in page_alloc.c,
but perhaps not valid for adding more.

>
> > Or caller and page allocator need to agree on some contract? Say
> > caller has to set has_hwpoisoned flag in non-zero order folio to free.
> > This allows the old interface free_frozen_pages an easy way using the
> > has_hwpoison flag from the second page. I know has_hwpoison is "#if
> > defined" on THP and using it for hugetlb probably is not very clean,
> > but are there other concerns?
>
> As you mentioned has_hwpoisoned is used for THPs and for a hugetlb
> folio. But for a hugetlb folio folio_test_hwpoison() returns true
> if it has at least one hwpoison pages (assuming that we don't clear it
> before freeing).
>
> So in free_pages_prepare():
>
> if (folio_test_hugetlb(folio) && folio_test_hwpoison(folio)) {
>   /*
>    * Handle hwpoison hugetlb folios; transfer the error information
>    * to individual pages, clear hwpoison flag of the folio,
>    * perform non-uniform split on the frozen folio.
>    */
> } else if (PageHWPoison(page) && !order) {
>   /* We already handle this in the allocator. */
> }
>
> This would be sufficient?

Wouldn't this confuse the page allocator into thinking the healthy
head page is HWPoison (when it actually isn't)? I thought that was one
of the reasons has_hwpoison exists.

>
> Or do we want to handle THPs as well, in case of split failure in
> memory_failure()? if so we need to handle folio_test_has_hwpoisoned()
> case as well...

Yeah, I think this is another good use case for our request to page allocat=
or.

>
> > > > inside the page allocator (probably non-uniform?). We can later re-=
implement
> > > > this to provide better support for memdescs.
> > >
> > > Yes, I like this approach.  But then I'm not the page allocator
> > > maintainer ;-)
> >
> > If page allocator maintainers can weigh in here, that will be very help=
ful!
>
> Yeah, I'm not a maintainer either ;) it'll be great to get opinions
> from page allocator folks!
>
> --
> Cheers,
> Harry / Hyeonggon

