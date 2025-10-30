Return-Path: <linux-fsdevel+bounces-66507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7EBC21810
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 18:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3B13B26B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 17:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A66368F57;
	Thu, 30 Oct 2025 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZcDMu0A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5C63678BC
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845344; cv=none; b=Ijxx2mvg91U1CPkXZzfavBn78muaLZlzB3Q7VbCMQwDz+/ZvS0tXnhgqZ8+zujR7N1lNJ6Enzq0IuUmTuT0atcFJiNJIjJPSs7jxzgxuIBaMV++g+ZYHQZbjx7bndt1NxOjNMotcL7GXHc0J7aTAoZZAysTrLkESdbl8XS1QZ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845344; c=relaxed/simple;
	bh=9B4FKjvIHeWwZ+HKKf/2rxO9qlq4Uj//B3HDuNLqvBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnAb2dS5BM3C8El9Zr3RbpI+NBSYSujiXeCXx109OinasowuasRNKLv/xgnJ+1eG6AJvHUPqiasAPDtX4DSfgjAzvxvnKWhFHQr1eXP6vQUmBXn2BQ6C04mP1WA7L7lCGlhz9Gt8I6aB/bSYaduDbaLH2LwGlbcDhlGceCtRyB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZcDMu0A; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-475df55f484so4945e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 10:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761845340; x=1762450140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duKu/8Ky/t6prpCzomheaKrWsLhN82XKAnG9GJbzgTM=;
        b=QZcDMu0AYP+Mta3yu/d5/3/9ij9BxBU2qHWPiEKjsL2fuK31d0bVJ0j4lb+eldBhE/
         hhscKx8dXjtrqJZ7x6hpaOv9HNWEaH+Iq3K/mjGbEo2sTnbyTbnnLFhEtSY9FV0XFWLB
         HQykI9HeQMxN6WSYlWTMdEcwfVVEreM2Ju3gkioshZzhua1bvyUPa98WiRirfQTE2IQ/
         K960ohiWVjA4Qp4Oyqw5sNL4yJFf0tO254QU/3emZTpl8sVA4q+ng8cJSGoVedrzPUA8
         oRCEShDhUiCN1/zcUBEWT8+cI3SzVo2nxRTzMsGUW6KzxtyChBl3oUm37ZjGlCbc1+NX
         qcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761845340; x=1762450140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duKu/8Ky/t6prpCzomheaKrWsLhN82XKAnG9GJbzgTM=;
        b=HJxcro1vsnds8zX7/Xz2efd2OdXTY1VDXk/tptgMnb06Gh1OD3CdObi97SL5Huu0GY
         Vb9Y6P1NkAU0PPDoKXpXj/mbsUGgfLN2ManX0dReFB9NAV1za764vb45iXE1B1psnjs+
         LB8Ou7rL4gf0PqHTpUOZfbeJIe3LO65zN7tlpZv5KGEuqIQWY0zI9gbs8FCdamIq0jR7
         I/utfY9ZrqLuiz+WV3raVb+CAgf3GrCE4yl1dIneCXvYWn7pALxvBtb8I8GC6Q16xznT
         Y8jZS0q7NPsJZf2lb2BA3N3XiieOVzf+MdaPUa/LD8WPf6/Hp35dKE5YrO3qBXOMB8nk
         WI7A==
X-Forwarded-Encrypted: i=1; AJvYcCWLTEaSCtz2pdiXBhh2J3u1IW/R28mqzClgjy3M00FmLKKe+bCOkJlgcSOUB29+5Qm3FQQI2R9zMPC75sZX@vger.kernel.org
X-Gm-Message-State: AOJu0YxoifTn7mLUY/+UjKsD+Xuc8Q9MKO4gipbWCTbiyngPXOF+EZFx
	SkUakZsauVV+fqKnBpP1Sh0CcnorCH5jLp3FskR8QxgM75GcfNLvM1HYpN1IiZeN2X5dZac5Oe5
	6T5iwXW6nP76u3PrW1knlaZ7+fexogQ2NZ8d1L5AX
X-Gm-Gg: ASbGncudPXBmATgg8XKkOb8w3Xi/nl78fLa9oKVq/6zIEl2sWI+Ybxe2EeFW4G8L76N
	OKD8e3FqxvlY3aYsz+A/cqMhpfBmLu73lHB1xbRcX91Fq3XRqrSrzyOZacDcyk+uUoAE9cAIzxW
	TtCsz1knhH2f9oObuzbCOlrCZvSHlvuPNhTFHhsiLYUW7NOxf5XXoUsptBayx+UPM7FwxOgv7KC
	T72huI//H0M3ce7VaZ9g4NagypoHulbsDMZi4onvQICp8B5tk1uluXFow9gLY6AjqNSQBnG96fX
	ZAhO/4h5PJOEoVY=
X-Google-Smtp-Source: AGHT+IFCRKDiV45j8nfSSPazMv37IGqBBffmdRw3pH4dGClMUS1sq6qT4CcfZSHTWT3SkuCeES6cEwuqbx88QSTv3rE=
X-Received: by 2002:a05:600c:6207:b0:46f:a42d:41f0 with SMTP id
 5b1f17b1804b1-477310e383cmr86755e9.0.1761845339767; Thu, 30 Oct 2025 10:28:59
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250118231549.1652825-1-jiaqiyan@google.com> <20250919155832.1084091-1-william.roche@oracle.com>
 <CACw3F521fi5HWhCKi_KrkNLXkw668HO4h8+DjkP2+vBuK-=org@mail.gmail.com>
 <aPjXdP63T1yYtvkq@hyeyoo> <CACw3F50As2jPzy1rRjzpm3uKOALjX_9WmKxMPGnQcok96OfQkA@mail.gmail.com>
 <aQBqGupCN_v8ysMX@hyeyoo> <d3d35586-c63f-c1be-c95e-fbd7aafd43f3@huawei.com>
In-Reply-To: <d3d35586-c63f-c1be-c95e-fbd7aafd43f3@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 30 Oct 2025 10:28:48 -0700
X-Gm-Features: AWmQ_bmYKY6ggj7beaUai29I-PXUvJIYK1duVN36KusJtjmgIEZDYv_nIrP-5Lg
Message-ID: <CACw3F51qaug5aWFNcjB54dVEc8yH+_A7zrkGcQyKXKJs6uVvgA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>, 
	Ackerley Tng <ackerleytng@google.com>, jgg@nvidia.com, akpm@linux-foundation.org, 
	ankita@nvidia.com, dave.hansen@linux.intel.com, david@redhat.com, 
	duenwen@google.com, jane.chu@oracle.com, jthoughton@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, nao.horiguchi@gmail.com, 
	osalvador@suse.de, peterx@redhat.com, rientjes@google.com, 
	sidhartha.kumar@oracle.com, tony.luck@intel.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 4:51=E2=80=AFAM Miaohe Lin <linmiaohe@huawei.com> w=
rote:
>
> On 2025/10/28 15:00, Harry Yoo wrote:
> > On Mon, Oct 27, 2025 at 09:17:31PM -0700, Jiaqi Yan wrote:
> >> On Wed, Oct 22, 2025 at 6:09=E2=80=AFAM Harry Yoo <harry.yoo@oracle.co=
m> wrote:
> >>>
> >>> On Mon, Oct 13, 2025 at 03:14:32PM -0700, Jiaqi Yan wrote:
> >>>> On Fri, Sep 19, 2025 at 8:58=E2=80=AFAM =E2=80=9CWilliam Roche <will=
iam.roche@oracle.com> wrote:
> >>>>>
> >>>>> From: William Roche <william.roche@oracle.com>
> >>>>>
> >>>>> Hello,
> >>>>>
> >>>>> The possibility to keep a VM using large hugetlbfs pages running af=
ter a memory
> >>>>> error is very important, and the possibility described here could b=
e a good
> >>>>> candidate to address this issue.
> >>>>
> >>>> Thanks for expressing interest, William, and sorry for getting back =
to
> >>>> you so late.
> >>>>
> >>>>>
> >>>>> So I would like to provide my feedback after testing this code with=
 the
> >>>>> introduction of persistent errors in the address space: My tests us=
ed a VM
> >>>>> running a kernel able to provide MFD_MF_KEEP_UE_MAPPED memfd segmen=
ts to the
> >>>>> test program provided with this project. But instead of injecting t=
he errors
> >>>>> with madvise calls from this program, I get the guest physical addr=
ess of a
> >>>>> location and inject the error from the hypervisor into the VM, so t=
hat any
> >>>>> subsequent access to the location is prevented directly from the hy=
pervisor
> >>>>> level.
> >>>>
> >>>> This is exactly what VMM should do: when it owns or manages the VM
> >>>> memory with MFD_MF_KEEP_UE_MAPPED, it is then VMM's responsibility t=
o
> >>>> isolate guest/VCPUs from poisoned memory pages, e.g. by intercepting
> >>>> such memory accesses.
> >>>>
> >>>>>
> >>>>> Using this framework, I realized that the code provided here has a =
problem:
> >>>>> When the error impacts a large folio, the release of this folio doe=
sn't isolate
> >>>>> the sub-page(s) actually impacted by the poison. __rmqueue_pcplist(=
) can return
> >>>>> a known poisoned page to get_page_from_freelist().
> >>>>
> >>>> Just curious, how exactly you can repro this leaking of a known pois=
on
> >>>> page? It may help me debug my patch.
> >>>>
> >>>>>
> >>>>> This revealed some mm limitations, as I would have expected that th=
e
> >>>>> check_new_pages() mechanism used by the __rmqueue functions would f=
ilter these
> >>>>> pages out, but I noticed that this has been disabled by default in =
2023 with:
> >>>>> [PATCH] mm, page_alloc: reduce page alloc/free sanity checks
> >>>>> https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
> >>>>
> >>>> Thanks for the reference. I did turned on CONFIG_DEBUG_VM=3Dy during=
 dev
> >>>> and testing but didn't notice any WARNING on "bad page"; It is very
> >>>> likely I was just lucky.
> >>>>
> >>>>>
> >>>>>
> >>>>> This problem seems to be avoided if we call take_page_off_buddy(pag=
e) in the
> >>>>> filemap_offline_hwpoison_folio_hugetlb() function without testing i=
f
> >>>>> PageBuddy(page) is true first.
> >>>>
> >>>> Oh, I think you are right, filemap_offline_hwpoison_folio_hugetlb
> >>>> shouldn't call take_page_off_buddy(page) depend on PageBuddy(page) o=
r
> >>>> not. take_page_off_buddy will check PageBuddy or not, on the page_he=
ad
> >>>> of different page orders. So maybe somehow a known poisoned page is
> >>>> not taken off from buddy allocator due to this?
> >>>
> >>> Maybe it's the case where the poisoned page is merged to a larger pag=
e,
> >>> and the PGTY_buddy flag is set on its buddy of the poisoned page, so
> >>> PageBuddy() returns false?:
> >>>
> >>>   [ free page A ][ free page B (poisoned) ]
> >>>
> >>> When these two are merged, then we set PGTY_buddy on page A but not o=
n B.
> >>
> >> Thanks Harry!
> >>
> >> It is indeed this case. I validate by adding some debug prints in
> >> take_page_off_buddy:
> >>
> >> [ 193.029423] Memory failure: 0x2800200: [yjq] PageBuddy=3D0 after dra=
in_all_pages
> >> [ 193.029426] 0x2800200: [yjq] order=3D0, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029428] 0x2800200: [yjq] order=3D1, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029429] 0x2800200: [yjq] order=3D2, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029430] 0x2800200: [yjq] order=3D3, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029431] 0x2800200: [yjq] order=3D4, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029432] 0x2800200: [yjq] order=3D5, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029434] 0x2800200: [yjq] order=3D6, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029435] 0x2800200: [yjq] order=3D7, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029436] 0x2800200: [yjq] order=3D8, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029437] 0x2800200: [yjq] order=3D9, page_order=3D0, PageBuddy(pa=
ge_head)=3D0
> >> [ 193.029438] 0x2800200: [yjq] order=3D10, page_order=3D10, PageBuddy(=
page_head)=3D1
> >>
> >> In this case, page for 0x2800200 is hwpoisoned, and its buddy page is
> >> 0x2800000 with order 10.
> >
> > Woohoo, I got it right!
> >
> >>> But even after fixing that we need to fix the race condition.
> >>
> >> What exactly is the race condition you are referring to?
> >
> > When you free a high-order page, the buddy allocator doesn't not check
> > PageHWPoison() on the page and its subpages. It checks PageHWPoison()
> > only when you free a base (order-0) page, see free_pages_prepare().
>
> I think we might could check PageHWPoison() for subpages as what free_pag=
e_is_bad()
> does. If any subpage has HWPoisoned flag set, simply drop the folio. Even=
 we could

Agree, I think as a starter I could try to, for example, let
free_pages_prepare scan HWPoison-ed subpages if the base page is high
order. In the optimal case, HugeTLB does move PageHWPoison flag from
head page to the raw error pages.

> do it better -- Split the folio and let healthy subpages join the buddy w=
hile reject
> the hwpoisoned one.
>
> >
> > AFAICT there is nothing that prevents the poisoned page to be
> > allocated back to users because the buddy doesn't check PageHWPoison()
> > on allocation as well (by default).
> >
> > So rather than freeing the high-order page as-is in
> > dissolve_free_hugetlb_folio(), I think we have to split it to base page=
s
> > and then free them one by one.
>
> It might not be worth to do that as this would significantly increase the=
 overhead
> of the function while memory failure event is really rare.

IIUC, Harry's idea is to do the split in dissolve_free_hugetlb_folio
only if folio is HWPoison-ed, similar to what Miaohe suggested
earlier.

BTW, I believe this race condition already exists today when
memory_failure handles HWPoison-ed free hugetlb page; it is not
something introduced via this patchset. I will fix or improve this in
a separate patchset.

>
> Thanks both.

Thanks Harry and Miaohe!


> .
>
> >
> > That way, free_pages_prepare() will catch that it's poisoned and won't
> > add it back to the freelist. Otherwise there will always be a window
> > where the poisoned page can be allocated to users - before it's taken
> > off from the buddy.
> >
>

