Return-Path: <linux-fsdevel+bounces-68899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B23FC67B88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED8C64E1D85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FFE2E62A9;
	Tue, 18 Nov 2025 06:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HTZXh48y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA2C29E10F
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 06:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763447082; cv=none; b=YwIOnQv3aa5BqfD7oUeroBe5TH5U1G4I0d+iw2kU9mlvPrXPm7So3C/QIhEf+mYqB1vC76DRBjvN+aR09aqJ86mNxPejBz6uRuOjGpfvUr3/l55UGuVuc1DWSaS5r2DdAMPXYA6T69X8JSvwb2GgTaWQCyG5UButwjaxQ1b4r4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763447082; c=relaxed/simple;
	bh=KEniiT5ZH+CjU7O9bfckXLKM/uCgytrdWVhbzu0XPkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUAQM+3+lAVbLMOM5RpldV1F2qHP/x1627pdL3xreJmx/655dbQW2XXjN0xpli1SI677JwUomdpNelxwew1ck5eU792f3sWcmJasqATBM1wvACb/i4lHPaGYuJkFWSAz6nB99yKtagHnGW9q+kQdQOoYrWcJLRapfcvZg0e3FV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HTZXh48y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779a4fb9bfso35215e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 22:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763447079; x=1764051879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLvAPfrkI/zYgSNVGp/8sP/HrwQJdzRKS9oKpDwAHUc=;
        b=HTZXh48yjLKlpgFb53EUKqqxfa78mWwXU7Tic7AhDiIE0yU0cZcqeSt/kzPyu8ZKwp
         PkU4sh1OZh1VEBqxmX6FRE/6gGrCVeNPfg2fU9RjZh+A0AoGcQFa3OFFVIhyInqF4+BN
         w6W4uJ5fDLShjymp8B1zrNUvE4U5GYJtmnItwu5Swb8sqIIbrMhS3k67DBFqNJs3MG/r
         0YQNoowRNQRl6ly0DO/rB+eRVKECebzLtV+plRvUNduNJsDuBvk2aC5ZbTOyOgHg15j0
         Rv2qEuVUmCjbn3LF8Thgy+W6YaxRJmUGOnztxfpn3SEttSVUCNXYAfiTPNL5ZEialP/U
         nQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763447079; x=1764051879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TLvAPfrkI/zYgSNVGp/8sP/HrwQJdzRKS9oKpDwAHUc=;
        b=mV0Mx7tokGcY1Tk+Y6btXdi0Udtf1ENbY4LgSRZL1FKubjzCVjafVMzmQb7IUvI4Vb
         dxsNfNhxlYKKbK1wieaTYP9mZJ92EPS3Ybql/d9334STTik40gNq+dBXzat8o/Pn2HOc
         7KWRz2TQ0B+pknWZ5lO+T0LfLOYcBy8EpyReTRnfL/+59lq4asWfQLB/X5jGH2mpOaVG
         Jmfn2l4Mdyo8r1fZ8s+6Y4pZZlhlLv/2tdpGSgPuEYcZ6KhqdqSUhijsUuvxOZbd6hsI
         iZb6VywUhdiz0WFp+V2xcpTOjDlSOHn7CzICWwkiY29e9DC7Uf40r7D47LK64tPlt7hi
         Viaw==
X-Forwarded-Encrypted: i=1; AJvYcCUGx8Sw3qTbkOkQ0YX0nX2vx5+gmaNSdp5Rwn2+nsEBC9roZXphr489NfyT0a9SKFSI7PWCunTk7rBiulC2@vger.kernel.org
X-Gm-Message-State: AOJu0YxegQ4XMlmS5yRICFQjBE+gsNf8x1l2gENHd68GkqyY/TS2cBj7
	IND1KuY8iRZ26rESHVu2MEYOhv+F84Z2X22vfLGLaHx1q5jBENr1I6ecBAX4II0GTG0E7Mx+AGq
	wz4WEdpnhn76tUTYL80pVJ5OtX104s9MRgm0LFHuc
X-Gm-Gg: ASbGncu8BgCmo22iFGalhcJLNByBGYxPEXdFKOLVDXWEYjqwLxxHllPsNdQ+3MAZe6q
	2m37Ig3hwpTsXQimHS9Aj4JsTdj+EiO/LrLNTVsIFBXEQXcm0veSSAOlgNZUzyFwVhjmFYBEsN/
	AK3862zZJIzAhRixdQt7IBfR0w+1qQRUexHDOVxmh3LTSICrXi3DGq8W2lnsSmG+fQaMTxpyGpv
	TEOXdfmyVrSE6p20nyse5uWAxeiwL9cKzCUCDpVbVNrIIGPV4vazldOrxea6WsedQtOiEM6XX67
	TDURpDvD4y1zYIW97mPt8UHfUFIY
X-Google-Smtp-Source: AGHT+IGUrL8vb1I+w3aQwLjf+9ccRyeGCNs9+TZ7n9gxUlnGLthm8mqk5SxO7W68VRy8YDjsnkdfmM2JXkmraVH+nPU=
X-Received: by 2002:a05:600c:c0d9:b0:477:76cb:18e2 with SMTP id
 5b1f17b1804b1-477aca5a719mr89855e9.0.1763447078727; Mon, 17 Nov 2025 22:24:38
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116014721.1561456-1-jiaqiyan@google.com> <20251116014721.1561456-2-jiaqiyan@google.com>
 <aRm6shtKizyrq_TA@casper.infradead.org> <aRqTLmJBuvBcLYMx@hyeyoo> <aRsmaIfCAGy-DRcx@casper.infradead.org>
In-Reply-To: <aRsmaIfCAGy-DRcx@casper.infradead.org>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 17 Nov 2025 22:24:27 -0800
X-Gm-Features: AWmQ_bmQYN1uUL7Hku5AMHcByQa7MIWapAaD7bovPggfmM_Xzv2AdbuM5SMKUMk
Message-ID: <CACw3F50E=AZtgfoExCA-nwS6=NYdFFWpf6+GBUYrWiJOz4xwaw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm/huge_memory: introduce uniform_split_unmapped_folio_to_zero_order
To: Matthew Wilcox <willy@infradead.org>, Harry Yoo <harry.yoo@oracle.com>, ziy@nvidia.com, 
	david@redhat.com, Vlastimil Babka <vbabka@suse.cz>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, lorenzo.stoakes@oracle.com, 
	william.roche@oracle.com, tony.luck@intel.com, wangkefeng.wang@huawei.com, 
	jane.chu@oracle.com, akpm@linux-foundation.org, osalvador@suse.de, 
	muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 5:43=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Nov 17, 2025 at 12:15:23PM +0900, Harry Yoo wrote:
> > On Sun, Nov 16, 2025 at 11:51:14AM +0000, Matthew Wilcox wrote:
> > > But since we're only doing this on free, we won't need to do folio
> > > allocations at all; we'll just be able to release the good pages to t=
he
> > > page allocator and sequester the hwpoison pages.
> >
> > [+Cc PAGE ALLOCATOR folks]
> >
> > So we need an interface to free only healthy portion of a hwpoison foli=
o.

+1, with some of my own thoughts below.

> >
> > I think a proper approach to this should be to "free a hwpoison folio
> > just like freeing a normal folio via folio_put() or free_frozen_pages()=
,
> > then the page allocator will add only healthy pages to the freelist and
> > isolate the hwpoison pages". Oherwise we'll end up open coding a lot,
> > which is too fragile.
>
> Yes, I think it should be handled by the page allocator.  There may be

I agree with Matthew, Harry, and David. The page allocator seems best
suited to handle HWPoison subpages without any new folio allocations.

> some complexity to this that I've missed, eg if hugetlb wants to retain
> the good 2MB chunks of a 1GB allocation.  I'm not sure that's a useful
> thing to do or not.
>
> > In fact, that can be done by teaching free_pages_prepare() how to handl=
e
> > the case where one or more subpages of a folio are hwpoison pages.
> >
> > How this should be implemented in the page allocator in memdescs world?
> > Hmm, we'll want to do some kind of non-uniform split, without actually
> > splitting the folio but allocating struct buddy?
>
> Let me sketch that out, realising that it's subject to change.
>
> A page in buddy state can't need a memdesc allocated.  Otherwise we're
> allocating memory to free memory, and that way lies madness.  We can't
> do the hack of "embed struct buddy in the page that we're freeing"
> because HIGHMEM.  So we'll never shrink struct page smaller than struct
> buddy (which is fine because I've laid out how to get to a 64 bit struct
> buddy, and we're probably two years from getting there anyway).
>
> My design for handling hwpoison is that we do allocate a struct hwpoison
> for a page.  It looks like this (for now, in my head):
>
> struct hwpoison {
>         memdesc_t original;
>         ... other things ...
> };
>
> So we can replace the memdesc in a page with a hwpoison memdesc when we
> encounter the error.  We still need a folio flag to indicate that "this
> folio contains a page with hwpoison".  I haven't put much thought yet
> into interaction with HUGETLB_PAGE_OPTIMIZE_VMEMMAP; maybe "other things"
> includes an index of where the actually poisoned page is in the folio,
> so it doesn't matter if the pages alias with each other as we can recover
> the information when it becomes useful to do so.
>
> > But... for now I think hiding this complexity inside the page allocator
> > is good enough. For now this would just mean splitting a frozen page

I want to add one more thing. For HugeTLB, kernel clears the HWPoison
flag on the folio and move it to every raw pages in raw_hwp_page list
(see folio_clear_hugetlb_hwpoison). So page allocator has no hint that
some pages passed into free_frozen_pages has HWPoison. It has to
traverse 2^order pages to tell, if I am not mistaken, which goes
against the past effort to reduce sanity checks. I believe this is one
reason I choosed to handle the problem in hugetlb / memory-failure.

For the new interface Harry requested, is it the caller's
responsibility to ensure that the folio contains HWPoison pages (to be
even better, maybe point out the exact ones?), so that page allocator
at least doesn't waste cycles to search non-exist HWPoison in the set
of pages?

Or caller and page allocator need to agree on some contract? Say
caller has to set has_hwpoisoned flag in non-zero order folio to free.
This allows the old interface free_frozen_pages an easy way using the
has_hwpoison flag from the second page. I know has_hwpoison is "#if
defined" on THP and using it for hugetlb probably is not very clean,
but are there other concerns?


> > inside the page allocator (probably non-uniform?). We can later re-impl=
ement
> > this to provide better support for memdescs.
>
> Yes, I like this approach.  But then I'm not the page allocator
> maintainer ;-)

If page allocator maintainers can weigh in here, that will be very helpful!

