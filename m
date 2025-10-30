Return-Path: <linux-fsdevel+bounces-66525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B7DC226B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 22:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216581A625B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 21:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A10B330B1E;
	Thu, 30 Oct 2025 21:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lag0UXiB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E272D2E1F1F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761859745; cv=none; b=jtKmbHP6JYXGRPkYqvwdtDxC8oZ3hzXv+QyFvGdwmlpgJAkC50XiAghuLrrPMEYI1Zmcq4oLFlcb0LcFBmkI0FNkOIpu6XdBqBkt0bhJvLcrFvpFB+9cF7qQL264471b5JV1Xyy7xuFBRU+aFQpbIunZo8cMHhvAqHH2Sjd9bxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761859745; c=relaxed/simple;
	bh=PSOHkWvOs2RLty6XntP1iEGA8UeaMB+k4uMEjmhYNCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wfb9q0fTRTKY6cCMLiXdf1if6NmGY1YcWyhvSaEA7kDHy2JKZv5vH7C1JpJ0D0NKxtNOG+r3C31TA4j+zwibH3cpx1u38mGZ4VgeLo9KcgV8BkFu9bIuFsqa01M5VpB+llz/mAnelFHYrF4QMcWiaoDNxF33LRTK7ztZ2gzfym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lag0UXiB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-470ff2f6e56so20595e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 14:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761859742; x=1762464542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sc9LTmQ0OPF7AQNspYRAtEgFt0JZnJtSWDRnSHOv73Y=;
        b=lag0UXiBZnoB3BVY+KeHWR3SiWADfY7WxHZD5qp3z5tSS5oTKGII2euGrNQzYfKO1m
         U0C6RGX8hFJILaTIh7+zlt90smX9Dr/gOpFwn87JWeklCCDghih2qkF/Os65oZroDL0N
         rN2hdlGpPKFE/jWqs2iJz4VPEgM7mEs2eivsOn23rs4DeLBWKihoq42COtEjnCwQn7hR
         MslLpUbSlLvyZS34HkdTcVqJR3vziXVXl42hjQDtCqBZFsKi9LjsPB5qpLMQxx6dgMtS
         NHmbHcUxnQL1QoZkTv8l+k+GACr7GjgMeNYw9K3L+La8acr72jl3+0b6MlPTVdhzO7EL
         wHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761859742; x=1762464542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sc9LTmQ0OPF7AQNspYRAtEgFt0JZnJtSWDRnSHOv73Y=;
        b=vQJ4NGOZLB8Jc3mF69WacwchV+KKuKiQDk4OFBNsnlCS40Ncttzlo4yai21v7Qt846
         LNB/FvztO5gOh6hnBcPQGmAiievvn1OC2Cp06w3Jp91uSs9cfTkPamyoYI6tpzRXsDaK
         AALLxFfYWkI9eR/5P684TROS8nJgQfKC1eZq/FYKLaRuZNsn+NsTQy1k7zihtYZ4u0H7
         zC8oEL1dwXkobP+qqW0Ns71aOJwyvSgEw+y6hDPUT6iRDV4AwhPOTdXyJ0RksuZxptTq
         IPxLeR5JPMc1Zy8w4KxB8UIyPorULiw4HARSluAXlglQsQPCvOxgdFtSCafFOo4TGFJt
         VUgA==
X-Forwarded-Encrypted: i=1; AJvYcCWBMUNIPAD82Cvl6zjJxHPRwr6R3dUnsFiQ5h9DNX+mWF8Gyf7MxWtRoWJ8s8Z2/KWpFgsjbndZNvHpiak3@vger.kernel.org
X-Gm-Message-State: AOJu0YyNxuCMMfbKowLgJWhjBd7m1xYpoFo84Xf3Pn8bxCyGWwoBWhLs
	haVLvZUrUckOXKXmLxFKQNCTqujTlGxSVX2GoytQspmYnPiOaa7X9Ai6UK8fDkd9FKuj/wDFa8I
	OAX3C4YfGBI6Sg27sDUb7Rven8sbTDYjFNAacu78K
X-Gm-Gg: ASbGnctXFreddx2zY7o0Y8hiOEZxVWZ/SphRKa6t8c5eNJdkYebmWngqs4KFJ0Z+kL0
	BaPVciXlDDdW6ulWf/8h88whQMcjl3AznATwxMycuHwCdWMoqQG1+K/KKBG2FTloxa+fV5D3IIe
	hY9yJmb+s6Vynnge5FiavJxb+p18+DBGOZgZ9WGe7lU2PE40vnLBC5INJQKfs4WjGeOzIaWpg4W
	mmhmRpnBA5obshoIQEsuUt4flG7hC9OZ5EP5vsPaRyqhbYoQCHUrK12pcAVX25f7sRMo4i+BlNF
	zFI1fwlm6CUYB9k=
X-Google-Smtp-Source: AGHT+IHHa+mxe2nHccFbFaghuaSDYkwuMWhzYSMqf2OY1KgkmzZBGYlY/xWgIovTrxMUjwhSNsP4FKGpKcuCVCJhuNE=
X-Received: by 2002:a05:600c:a49:b0:472:ce95:eb44 with SMTP id
 5b1f17b1804b1-477324a6ed3mr247635e9.3.1761859742031; Thu, 30 Oct 2025
 14:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250118231549.1652825-1-jiaqiyan@google.com> <20250919155832.1084091-1-william.roche@oracle.com>
 <CACw3F521fi5HWhCKi_KrkNLXkw668HO4h8+DjkP2+vBuK-=org@mail.gmail.com>
 <aPjXdP63T1yYtvkq@hyeyoo> <CACw3F50As2jPzy1rRjzpm3uKOALjX_9WmKxMPGnQcok96OfQkA@mail.gmail.com>
 <aQBqGupCN_v8ysMX@hyeyoo> <d3d35586-c63f-c1be-c95e-fbd7aafd43f3@huawei.com> <CACw3F51qaug5aWFNcjB54dVEc8yH+_A7zrkGcQyKXKJs6uVvgA@mail.gmail.com>
In-Reply-To: <CACw3F51qaug5aWFNcjB54dVEc8yH+_A7zrkGcQyKXKJs6uVvgA@mail.gmail.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 30 Oct 2025 14:28:50 -0700
X-Gm-Features: AWmQ_bnzs5sTXcmQM7upX8IRDlkxcYWM8GOFkUz1vs-zu-EDjQkmvbs_aong1qA
Message-ID: <CACw3F50K7w2WuCoRZxDFiosBr_GSb62z1sVGEHQKC2QHGBAP9A@mail.gmail.com>
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

On Thu, Oct 30, 2025 at 10:28=E2=80=AFAM Jiaqi Yan <jiaqiyan@google.com> wr=
ote:
>
> On Thu, Oct 30, 2025 at 4:51=E2=80=AFAM Miaohe Lin <linmiaohe@huawei.com>=
 wrote:
> >
> > On 2025/10/28 15:00, Harry Yoo wrote:
> > > On Mon, Oct 27, 2025 at 09:17:31PM -0700, Jiaqi Yan wrote:
> > >> On Wed, Oct 22, 2025 at 6:09=E2=80=AFAM Harry Yoo <harry.yoo@oracle.=
com> wrote:
> > >>>
> > >>> On Mon, Oct 13, 2025 at 03:14:32PM -0700, Jiaqi Yan wrote:
> > >>>> On Fri, Sep 19, 2025 at 8:58=E2=80=AFAM =E2=80=9CWilliam Roche <wi=
lliam.roche@oracle.com> wrote:
> > >>>>>
> > >>>>> From: William Roche <william.roche@oracle.com>
> > >>>>>
> > >>>>> Hello,
> > >>>>>
> > >>>>> The possibility to keep a VM using large hugetlbfs pages running =
after a memory
> > >>>>> error is very important, and the possibility described here could=
 be a good
> > >>>>> candidate to address this issue.
> > >>>>
> > >>>> Thanks for expressing interest, William, and sorry for getting bac=
k to
> > >>>> you so late.
> > >>>>
> > >>>>>
> > >>>>> So I would like to provide my feedback after testing this code wi=
th the
> > >>>>> introduction of persistent errors in the address space: My tests =
used a VM
> > >>>>> running a kernel able to provide MFD_MF_KEEP_UE_MAPPED memfd segm=
ents to the
> > >>>>> test program provided with this project. But instead of injecting=
 the errors
> > >>>>> with madvise calls from this program, I get the guest physical ad=
dress of a
> > >>>>> location and inject the error from the hypervisor into the VM, so=
 that any
> > >>>>> subsequent access to the location is prevented directly from the =
hypervisor
> > >>>>> level.
> > >>>>
> > >>>> This is exactly what VMM should do: when it owns or manages the VM
> > >>>> memory with MFD_MF_KEEP_UE_MAPPED, it is then VMM's responsibility=
 to
> > >>>> isolate guest/VCPUs from poisoned memory pages, e.g. by intercepti=
ng
> > >>>> such memory accesses.
> > >>>>
> > >>>>>
> > >>>>> Using this framework, I realized that the code provided here has =
a problem:
> > >>>>> When the error impacts a large folio, the release of this folio d=
oesn't isolate
> > >>>>> the sub-page(s) actually impacted by the poison. __rmqueue_pcplis=
t() can return
> > >>>>> a known poisoned page to get_page_from_freelist().
> > >>>>
> > >>>> Just curious, how exactly you can repro this leaking of a known po=
ison
> > >>>> page? It may help me debug my patch.
> > >>>>
> > >>>>>
> > >>>>> This revealed some mm limitations, as I would have expected that =
the
> > >>>>> check_new_pages() mechanism used by the __rmqueue functions would=
 filter these
> > >>>>> pages out, but I noticed that this has been disabled by default i=
n 2023 with:
> > >>>>> [PATCH] mm, page_alloc: reduce page alloc/free sanity checks
> > >>>>> https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
> > >>>>
> > >>>> Thanks for the reference. I did turned on CONFIG_DEBUG_VM=3Dy duri=
ng dev
> > >>>> and testing but didn't notice any WARNING on "bad page"; It is ver=
y
> > >>>> likely I was just lucky.
> > >>>>
> > >>>>>
> > >>>>>
> > >>>>> This problem seems to be avoided if we call take_page_off_buddy(p=
age) in the
> > >>>>> filemap_offline_hwpoison_folio_hugetlb() function without testing=
 if
> > >>>>> PageBuddy(page) is true first.
> > >>>>
> > >>>> Oh, I think you are right, filemap_offline_hwpoison_folio_hugetlb
> > >>>> shouldn't call take_page_off_buddy(page) depend on PageBuddy(page)=
 or
> > >>>> not. take_page_off_buddy will check PageBuddy or not, on the page_=
head
> > >>>> of different page orders. So maybe somehow a known poisoned page i=
s
> > >>>> not taken off from buddy allocator due to this?
> > >>>
> > >>> Maybe it's the case where the poisoned page is merged to a larger p=
age,
> > >>> and the PGTY_buddy flag is set on its buddy of the poisoned page, s=
o
> > >>> PageBuddy() returns false?:
> > >>>
> > >>>   [ free page A ][ free page B (poisoned) ]
> > >>>
> > >>> When these two are merged, then we set PGTY_buddy on page A but not=
 on B.
> > >>
> > >> Thanks Harry!
> > >>
> > >> It is indeed this case. I validate by adding some debug prints in
> > >> take_page_off_buddy:
> > >>
> > >> [ 193.029423] Memory failure: 0x2800200: [yjq] PageBuddy=3D0 after d=
rain_all_pages
> > >> [ 193.029426] 0x2800200: [yjq] order=3D0, page_order=3D0, PageBuddy(=
page_head)=3D0
> > >> [ 193.029428] 0x2800200: [yjq] order=3D1, page_order=3D0, PageBuddy(=
page_head)=3D0
> > >> [ 193.029429] 0x2800200: [yjq] order=3D2, page_order=3D0, PageBuddy(=
page_head)=3D0
> > >> [ 193.029430] 0x2800200: [yjq] order=3D3, page_order=3D0, PageBuddy(=
page_head)=3D0
> > >> [ 193.029431] 0x2800200: [yjq] order=3D4, page_order=3D0, PageBuddy(=
page_head)=3D0
> > >> [ 193.029432] 0x2800200: [yjq] order=3D5, page_order=3D0, PageBuddy(=
page_head)=3D0
> > >> [ 193.029434] 0x2800200: [yjq] order=3D6, page_order=3D0, PageBuddy(=
page_head)=3D0
> > >> [ 193.029435] 0x2800200: [yjq] order=3D7, page_order=3D0, PageBuddy(=
page_head)=3D0
> > >> [ 193.029436] 0x2800200: [yjq] order=3D8, page_order=3D0, PageBuddy(=
page_head)=3D0
> > >> [ 193.029437] 0x2800200: [yjq] order=3D9, page_order=3D0, PageBuddy(=
page_head)=3D0
> > >> [ 193.029438] 0x2800200: [yjq] order=3D10, page_order=3D10, PageBudd=
y(page_head)=3D1
> > >>
> > >> In this case, page for 0x2800200 is hwpoisoned, and its buddy page i=
s
> > >> 0x2800000 with order 10.
> > >
> > > Woohoo, I got it right!
> > >
> > >>> But even after fixing that we need to fix the race condition.
> > >>
> > >> What exactly is the race condition you are referring to?
> > >
> > > When you free a high-order page, the buddy allocator doesn't not chec=
k
> > > PageHWPoison() on the page and its subpages. It checks PageHWPoison()
> > > only when you free a base (order-0) page, see free_pages_prepare().
> >
> > I think we might could check PageHWPoison() for subpages as what free_p=
age_is_bad()
> > does. If any subpage has HWPoisoned flag set, simply drop the folio. Ev=
en we could
>
> Agree, I think as a starter I could try to, for example, let
> free_pages_prepare scan HWPoison-ed subpages if the base page is high
> order. In the optimal case, HugeTLB does move PageHWPoison flag from
> head page to the raw error pages.

Another idea I came up with today and is trying out is:
1. let buddy allocator reject the high order folio first based on the
HWPoison-ed flag
2. memory_failure takes the advantage of break_down_buddy_pages to add
free pages to freelist, but keep target/hwpoison-ed page off the
freelist

>
> > do it better -- Split the folio and let healthy subpages join the buddy=
 while reject
> > the hwpoisoned one.
> >
> > >
> > > AFAICT there is nothing that prevents the poisoned page to be
> > > allocated back to users because the buddy doesn't check PageHWPoison(=
)
> > > on allocation as well (by default).
> > >
> > > So rather than freeing the high-order page as-is in
> > > dissolve_free_hugetlb_folio(), I think we have to split it to base pa=
ges
> > > and then free them one by one.
> >
> > It might not be worth to do that as this would significantly increase t=
he overhead
> > of the function while memory failure event is really rare.
>
> IIUC, Harry's idea is to do the split in dissolve_free_hugetlb_folio
> only if folio is HWPoison-ed, similar to what Miaohe suggested
> earlier.
>
> BTW, I believe this race condition already exists today when
> memory_failure handles HWPoison-ed free hugetlb page; it is not
> something introduced via this patchset. I will fix or improve this in
> a separate patchset.
>
> >
> > Thanks both.
>
> Thanks Harry and Miaohe!
>
>
> > .
> >
> > >
> > > That way, free_pages_prepare() will catch that it's poisoned and won'=
t
> > > add it back to the freelist. Otherwise there will always be a window
> > > where the poisoned page can be allocated to users - before it's taken
> > > off from the buddy.
> > >
> >

