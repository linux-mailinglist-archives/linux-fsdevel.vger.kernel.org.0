Return-Path: <linux-fsdevel+bounces-65875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495C8C12D8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 05:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9713401E32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 04:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2299C29B8E5;
	Tue, 28 Oct 2025 04:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMCKcqFZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825D429B20D
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 04:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761625066; cv=none; b=bzySvz4dQKvq0dvM98CfwUu//hi8k8xcd2orNUPmU4vVfSD2KMNJrZ6UdHuh6QhBnRksiAkBljYXt9JVGwyIxi3q6Qlexq89jDbZFlns3bBMW0f+s8in5LWWrshnmIGSy/yeTqvvS6PGZQbpmx5aws8vYVaQJ7xK6FNatNJbZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761625066; c=relaxed/simple;
	bh=5Vq7u3nGd6Do3JsO9eJRTz/nrsOJguWIs6I8jqHn41o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNWUc5jKnHd/T+B8CI9gW4pQEh29lSWkKZDg0tL+Bv/zlz2LN/WK4cM6Ia2lLInigAM7wdugEWi1Kxxzd0ueLncZDqslv32y42xIjd/t3e7pWMoIwAQEv9lppwxmFIPc+141K3pIANVbt+P3dSD4cp13XuVXfB3AkDUHgmJpHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CMCKcqFZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47105bbb8d9so27085e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 21:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761625063; x=1762229863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EafH425e5ZdVyi0FV+yegWkfn9dVJGmMSMrvuISBCM4=;
        b=CMCKcqFZhIhN9GrHzMt22pfSBpt3n53umu4a2LYUg/tvVWruM7FfnDckvCePB79NcV
         alCzGSqG+eZwdByWYPBw3sKUB6WN+zryHc4v7XTsogFm2MY3u5qmIBMknkMnEFwdZ8GR
         anDfpq3mRoktXpOBn8DJJNBmYHDqkzbruxcXVLyoTK3EvOQQ+6fY0S0wXALQ82uRGTsX
         Wvwu2btXwMi10P4vBUjoS1Ie8eS3XO2qc5IyFl8O+ikmEJ0Focl+6ARzgO5JaNTS6sOj
         x854GtrsNfY2euuqxztCC989l1ozRusb0k4mM4jN6r3TiVuZp52uyvOfAHZt0AlcL94N
         Yx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761625063; x=1762229863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EafH425e5ZdVyi0FV+yegWkfn9dVJGmMSMrvuISBCM4=;
        b=nK8KQY5QYYXLaiR0xFdk5aFjDmLld0rnIdkeu4mBMBw5iPoYY57eDXwvLS6Gacz8MA
         ciPlPIrGDSiz1q49ELvXLBS2oqPIL7ovyDbeyhO9nbC2Eld1e21U0QykDLZlN/t6g83D
         p0jmlhl2JEkZx5osmMDg6FEtBchGAc/wqsm85eN3P6Ko2MSw7AShXf/mlMf7kz8CdK4k
         HLVseeBQSio2K82aLrOUpK0orRpWtm2yw6tZluuvd/rcwgA6eZ66ftfDLu8qXdOCJZCF
         fZ6mbs2PR4JppiOoPISJJwUpVv+ix7D7ThcMAJKMcrERFeDnHcidGJISmlSJEh66aaEB
         jkwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKbp0qLPz44E/YEkO2i9Agf7Iz1AUgIT9qqqIzwNa7MYwE3+ahsd2PiG9iE8PkTYW6RrXTt2+gmqCVvDHT@vger.kernel.org
X-Gm-Message-State: AOJu0YzzUt7Lbd4vCo1qcXdVfR8mzsjqcB6fhX5ECQNTzxK8y8y9GUd7
	X9vpJhsUE1LSJAr1+K9vrTrYyUNNs+M8Ed3xxT/tucRS7xe1y1JQdGkz3okz73Z7YYmzz3uTjCt
	w2TCtds9RsDoKKcfj8iSKkOTXGEJ5BYnXn7Db7iCM
X-Gm-Gg: ASbGnctDo9v6LH0OLD3X/1ZxczLVMu+TwY+Ozyff3f7ShTiFV8xU9ykeW57TM1PgxyI
	Kmc4bOnTit2pIBxeiX7Y7i0Siy0eQQ7eQ8yuokMiCizqi8ZHgkDpN0OUBGNW/Kyaw/TcmbooGl1
	24Ww7ZKj/vi7UjXwtAwPp9CM0dbeiIy4xk1xd58aATUsYbwjAtIXZFH+HnbWVX8hayJKpe7Q+qq
	TPdpIz5BoFahRu4HmX6bh/7CjXzdx1ssVoWIMCJbPd7PdQlWDiCtARbZAaK+hX83lPpEvTlWNfB
	vq18UUJ/brMZZiA8tQ==
X-Google-Smtp-Source: AGHT+IEhtd6FMoBD9oW9VTHPjTNuAKD4LI9Bm+L8vr/ZIvRemEu0gME+w1twwea2P3HAp+5Fi55N6fK3//NhVxDsmnM=
X-Received: by 2002:a05:600c:1791:b0:45b:74f7:9d30 with SMTP id
 5b1f17b1804b1-477191e0eabmr589665e9.1.1761625062640; Mon, 27 Oct 2025
 21:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250118231549.1652825-1-jiaqiyan@google.com> <20250919155832.1084091-1-william.roche@oracle.com>
 <CACw3F521fi5HWhCKi_KrkNLXkw668HO4h8+DjkP2+vBuK-=org@mail.gmail.com> <aPjXdP63T1yYtvkq@hyeyoo>
In-Reply-To: <aPjXdP63T1yYtvkq@hyeyoo>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 27 Oct 2025 21:17:31 -0700
X-Gm-Features: AWmQ_bm9R7TnoGST5GcqG6bwJmlJM5TYefCTLaciqwqQYwwTV1Gje_wcNqRiI_k
Message-ID: <CACw3F50As2jPzy1rRjzpm3uKOALjX_9WmKxMPGnQcok96OfQkA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
To: Harry Yoo <harry.yoo@oracle.com>, =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>
Cc: Ackerley Tng <ackerleytng@google.com>, jgg@nvidia.com, akpm@linux-foundation.org, 
	ankita@nvidia.com, dave.hansen@linux.intel.com, david@redhat.com, 
	duenwen@google.com, jane.chu@oracle.com, jthoughton@google.com, 
	linmiaohe@huawei.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev, 
	nao.horiguchi@gmail.com, osalvador@suse.de, peterx@redhat.com, 
	rientjes@google.com, sidhartha.kumar@oracle.com, tony.luck@intel.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 6:09=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Mon, Oct 13, 2025 at 03:14:32PM -0700, Jiaqi Yan wrote:
> > On Fri, Sep 19, 2025 at 8:58=E2=80=AFAM =E2=80=9CWilliam Roche <william=
.roche@oracle.com> wrote:
> > >
> > > From: William Roche <william.roche@oracle.com>
> > >
> > > Hello,
> > >
> > > The possibility to keep a VM using large hugetlbfs pages running afte=
r a memory
> > > error is very important, and the possibility described here could be =
a good
> > > candidate to address this issue.
> >
> > Thanks for expressing interest, William, and sorry for getting back to
> > you so late.
> >
> > >
> > > So I would like to provide my feedback after testing this code with t=
he
> > > introduction of persistent errors in the address space: My tests used=
 a VM
> > > running a kernel able to provide MFD_MF_KEEP_UE_MAPPED memfd segments=
 to the
> > > test program provided with this project. But instead of injecting the=
 errors
> > > with madvise calls from this program, I get the guest physical addres=
s of a
> > > location and inject the error from the hypervisor into the VM, so tha=
t any
> > > subsequent access to the location is prevented directly from the hype=
rvisor
> > > level.
> >
> > This is exactly what VMM should do: when it owns or manages the VM
> > memory with MFD_MF_KEEP_UE_MAPPED, it is then VMM's responsibility to
> > isolate guest/VCPUs from poisoned memory pages, e.g. by intercepting
> > such memory accesses.
> >
> > >
> > > Using this framework, I realized that the code provided here has a pr=
oblem:
> > > When the error impacts a large folio, the release of this folio doesn=
't isolate
> > > the sub-page(s) actually impacted by the poison. __rmqueue_pcplist() =
can return
> > > a known poisoned page to get_page_from_freelist().
> >
> > Just curious, how exactly you can repro this leaking of a known poison
> > page? It may help me debug my patch.
> >
> > >
> > > This revealed some mm limitations, as I would have expected that the
> > > check_new_pages() mechanism used by the __rmqueue functions would fil=
ter these
> > > pages out, but I noticed that this has been disabled by default in 20=
23 with:
> > > [PATCH] mm, page_alloc: reduce page alloc/free sanity checks
> > > https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
> >
> > Thanks for the reference. I did turned on CONFIG_DEBUG_VM=3Dy during de=
v
> > and testing but didn't notice any WARNING on "bad page"; It is very
> > likely I was just lucky.
> >
> > >
> > >
> > > This problem seems to be avoided if we call take_page_off_buddy(page)=
 in the
> > > filemap_offline_hwpoison_folio_hugetlb() function without testing if
> > > PageBuddy(page) is true first.
> >
> > Oh, I think you are right, filemap_offline_hwpoison_folio_hugetlb
> > shouldn't call take_page_off_buddy(page) depend on PageBuddy(page) or
> > not. take_page_off_buddy will check PageBuddy or not, on the page_head
> > of different page orders. So maybe somehow a known poisoned page is
> > not taken off from buddy allocator due to this?
>
> Maybe it's the case where the poisoned page is merged to a larger page,
> and the PGTY_buddy flag is set on its buddy of the poisoned page, so
> PageBuddy() returns false?:
>
>   [ free page A ][ free page B (poisoned) ]
>
> When these two are merged, then we set PGTY_buddy on page A but not on B.

Thanks Harry!

It is indeed this case. I validate by adding some debug prints in
take_page_off_buddy:

[ 193.029423] Memory failure: 0x2800200: [yjq] PageBuddy=3D0 after drain_al=
l_pages
[ 193.029426] 0x2800200: [yjq] order=3D0, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029428] 0x2800200: [yjq] order=3D1, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029429] 0x2800200: [yjq] order=3D2, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029430] 0x2800200: [yjq] order=3D3, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029431] 0x2800200: [yjq] order=3D4, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029432] 0x2800200: [yjq] order=3D5, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029434] 0x2800200: [yjq] order=3D6, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029435] 0x2800200: [yjq] order=3D7, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029436] 0x2800200: [yjq] order=3D8, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029437] 0x2800200: [yjq] order=3D9, page_order=3D0, PageBuddy(page_he=
ad)=3D0
[ 193.029438] 0x2800200: [yjq] order=3D10, page_order=3D10, PageBuddy(page_=
head)=3D1

In this case, page for 0x2800200 is hwpoisoned, and its buddy page is
0x2800000 with order 10.

>
> But even after fixing that we need to fix the race condition.

What exactly is the race condition you are referring to?

>
> > Let me try to fix it in v2, by the end of the week. If you could test
> > with your way of repro as well, that will be very helpful!
> >
> > > But according to me it leaves a (small) race condition where a new pa=
ge
> > > allocation could get a poisoned sub-page between the dissolve phase a=
nd the
> > > attempt to remove it from the buddy allocator.
> > >
> > > I do have the impression that a correct behavior (isolating an impact=
ed
> > > sub-page and remapping the valid memory content) using large pages is
> > > currently only achieved with Transparent Huge Pages.
> > > If performance requires using Hugetlb pages, than maybe we could acce=
pt to
> > > loose a huge page after a memory impacted MFD_MF_KEEP_UE_MAPPED memfd=
 segment
> > > is released ? If it can easily avoid some other corruption.
> > >
> > > I'm very interested in finding an appropriate way to deal with memory=
 errors on
> > > hugetlbfs pages, and willing to help to build a valid solution. This =
project
> > > showed a real possibility to do so, even in cases where pinned memory=
 is used -
> > > with VFIO for example.
> > >
> > > I would really be interested in knowing your feedback about this proj=
ect, and
> > > if another solution is considered more adapted to deal with errors on=
 hugetlbfs
> > > pages, please let us know.
> >
> > There is also another possible path if VMM can change to back VM
> > memory with *1G guest_memfd*, which wraps 1G hugetlbfs. In Ackerley's
> > work [1], guest_memfd can split the 1G page for conversions. If we
> > re-use the splitting for memory failure recovery, we can probably
> > achieve something generally similar to THP's memory failure recovery:
> > split 1G to 2M and 4k chunks, then unmap only 4k of poisoned page. We
> > still lose the 1G TLB size so VM may be subject to some performance
> > sacrifice.
> > [1] https://lore.kernel.org/linux-mm/2ae41e0d80339da2b57011622ac2288fed=
65cd01.1747264138.git.ackerleytng@google.com
>
> I want to take a closer look at the actual patches but either way sounds
> good to me.
>
> By the way, please Cc me in future revisions :)

For sure!

>
> Thanks!
>
> --
> Cheers,
> Harry / Hyeonggon

