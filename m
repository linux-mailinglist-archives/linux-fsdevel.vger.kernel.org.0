Return-Path: <linux-fsdevel+bounces-49260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40331AB9D03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 15:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DE13BF2EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7341E4B2;
	Fri, 16 May 2025 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TGx+AlKw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1C242D8C
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401131; cv=none; b=lvzm7bxqalEt2S/6eVQ7N7WbwpWUFy+NsZcEpsxGzDgZo58s5c4H3Yr0ZIxNLGBbozOeXt24bkNEM8ZkVz4cB5/LSVNpZRmefM4h7WQp3VLgio2nuvLauMVZ+146i91PmXbrIwRG/rkCcLYPsUB11y3ZN/H8Hmz0OkX6Gu7c9Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401131; c=relaxed/simple;
	bh=NiiFqWZZg0iu28D3kw6sHBbg2+Jj2+n51oesFaRNgac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaGoMehW9GmHIo7dUCkFVV+8K01axQKX5L3d7jBG5HMMeit10JMScuR6dsvT+oalGr5+nS0AqiyWCWWHXQWKFSj7qtyxQNLyztAqqlf/SX2kJb7JHXTj1uLhGRcNBTqlsOMDLyiMnEWoap83+hMmeq6vgbVG4sN15A0qwKrVblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TGx+AlKw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-231f6c0b692so14985ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 06:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747401129; x=1748005929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRZigz65utFUqAMmPQfonu5ixQiHldB3hpjMC8Trs54=;
        b=TGx+AlKwJ6gbZZEmFAXDxe5HPuo19khYCyz1xRT1A1Q7OKjGPgkn30nMumeH1/w3Q9
         ukicbC8TP8lHNl0A/6DAegQpD7ev0WU2x7G8t9WL5UUS99r6DVv4r/D4vBZQKeHuc+tw
         89D7P3RBR3VNj6N5X9TZiqA5nrU3NvdTFN1cTJ9k3l166XTRB2TGKxnHp421NqwDh25W
         5FF5ro8Y4QzJfTwrLNGRgFbZmL8bvaeSdFsOg0jZZKrjQy4RUMzdaEwvSKLACbGACNId
         gFpr73ChCRM08u7ZAUiMa7eeibvNlGsYRcYh+2mICeg1U9IPWruE245lF+ylszjDfTJ+
         +n7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747401129; x=1748005929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRZigz65utFUqAMmPQfonu5ixQiHldB3hpjMC8Trs54=;
        b=OaQstztVqsThV6GoOmLx45rFvsuwO2Pu7755WdzBGJ0bmitfg7XujtHy2S7AqH18dZ
         pO62P74PlUct1T8AqX3i6v1cufkxe7vQk6MNbI6ZqsL+n7UXUOEHJfN1rz9jtX5XYbxA
         dtM12MTY9SjCZfCyGBVu0yPEOzpd4nOYZGU4UzGkJ9879CLSfBMvF/jxcDsGv4e7Dkku
         jbmIMD+8pjJIEQPeT6K/ExGQHBhnJal1yAhYpmeE1iXsMDlU8t4vq7/opDUbaklnAvDE
         MHMn13FpQ2+VdVjdGzEny3oz7dfNB7BS2YNnPOrBzEt9rAiq12wEXGsNultB/Hy4OEsW
         KBxw==
X-Forwarded-Encrypted: i=1; AJvYcCVLR3wPaQvV/kE57BDodzXyR6g2fVznqkOdlGfSGGJSSSlV/w38sH5k5jqXpqvu2if8KoK8QCCrn5CR27q8@vger.kernel.org
X-Gm-Message-State: AOJu0YxAUFdWx9mA37zMoTeo+xjDdWKjrJ71jyXt82Oq/V+o0ZMP4QIs
	RGCcUskZ/81kwaCLSNWY7ebSvicWzeH4z6K/ykG4LmLHQuR1DLHrvio8i8oONlFpKWa/dP4LV1Q
	R8vjQYpHIFTeQ+hQsCs4dH3TQxf67G2f5r4iWJ6Pw
X-Gm-Gg: ASbGncvMn8MheSDU25Kr+yVuXB73Rxiy0tZEP4sjVpERUlgEzKs6bg6Ko/abeQDUu5i
	9szven1d8od5YuAJ2onELJQ+Kwd9/JwycmtcHro/EX0x5DzxfdN6R6zm4OXtcVh8pZO2Wv6YF5q
	CGF2KZrDHFHAsJEdDa+DPp/Ribx42m7kgbmmwymodxguAa625yKJXCXlrrmP2msQCI
X-Google-Smtp-Source: AGHT+IHWzQxgLF5GinQQAT7heQR9B/bnByY6NVpp33fJcRw7lCpA5vIJ/aZyc6R8k4XwPwfMJ4BqgdEyoxgbu+RiAgI=
X-Received: by 2002:a17:902:d2c6:b0:223:37ec:63be with SMTP id
 d9443c01a7336-231b497f774mr6867365ad.4.1747401128820; Fri, 16 May 2025
 06:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <ada87be8b9c06bc0678174b810e441ca79d67980.camel@intel.com>
 <CAGtprH9CTsVvaS8g62gTuQub4aLL97S7Um66q12_MqTFoRNMxA@mail.gmail.com>
 <24e8ae7483d0fada8d5042f9cd5598573ca8f1c5.camel@intel.com>
 <aCaM7LS7Z0L3FoC8@google.com> <7d3b391f3a31396bd9abe641259392fd94b5e72f.camel@intel.com>
In-Reply-To: <7d3b391f3a31396bd9abe641259392fd94b5e72f.camel@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 16 May 2025 06:11:56 -0700
X-Gm-Features: AX0GCFs6I9TXzPWCzzMaQ_r47X6z5Mtwr_vfS-VvWPoNm6giHe9GgjB_h50xjcU
Message-ID: <CAGtprH8EMnmvvVir6_U+L5S3SEvrU1OzLrvkL58fXgfg59bjoA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "pvorel@suse.cz" <pvorel@suse.cz>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"Miao, Jun" <jun.miao@intel.com>, "Shutemov, Kirill" <kirill.shutemov@intel.com>, 
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "steven.price@arm.com" <steven.price@arm.com>, 
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"amoorthy@google.com" <amoorthy@google.com>, "tabba@google.com" <tabba@google.com>, 
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "maz@kernel.org" <maz@kernel.org>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, 
	"keirf@google.com" <keirf@google.com>, "hughd@google.com" <hughd@google.com>, 
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "willy@infradead.org" <willy@infradead.org>, 
	"jack@suse.cz" <jack@suse.cz>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "aik@amd.com" <aik@amd.com>, 
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>, 
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "fvdl@google.com" <fvdl@google.com>, 
	"rppt@kernel.org" <rppt@kernel.org>, "quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, 
	"nsaenz@amazon.es" <nsaenz@amazon.es>, "vbabka@suse.cz" <vbabka@suse.cz>, "Du, Fan" <fan.du@intel.com>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "mic@digikod.net" <mic@digikod.net>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "bfoster@redhat.com" <bfoster@redhat.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>, 
	"Li, Zhiquan1" <zhiquan1.li@intel.com>, "rientjes@google.com" <rientjes@google.com>, 
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "Xu, Haibo1" <haibo1.xu@intel.com>, 
	"anup@brainfault.org" <anup@brainfault.org>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"Wang, Wei W" <wei.w.wang@intel.com>, 
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>, "jarkko@kernel.org" <jarkko@kernel.org>, 
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"Huang, Kai" <kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, 
	"Peng, Chao P" <chao.p.peng@intel.com>, "nikunj@amd.com" <nikunj@amd.com>, 
	"Graf, Alexander" <graf@amazon.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"jroedel@suse.de" <jroedel@suse.de>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"jgowans@amazon.com" <jgowans@amazon.com>, "Xu, Yilun" <yilun.xu@intel.com>, 
	"liam.merwick@oracle.com" <liam.merwick@oracle.com>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>, 
	"richard.weiyang@gmail.com" <richard.weiyang@gmail.com>, "Weiny, Ira" <ira.weiny@intel.com>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
	"qperret@google.com" <qperret@google.com>, 
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>, "dmatlack@google.com" <dmatlack@google.com>, 
	"james.morse@arm.com" <james.morse@arm.com>, "brauner@kernel.org" <brauner@kernel.org>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "pgonda@google.com" <pgonda@google.com>, 
	"quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>, "roypat@amazon.co.uk" <roypat@amazon.co.uk>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "will@kernel.org" <will@kernel.org>, 
	"hch@infradead.org" <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 7:12=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Thu, 2025-05-15 at 17:57 -0700, Sean Christopherson wrote:
> > > > > Thinking from the TDX perspective, we might have bigger fish to f=
ry than
> > > > > 1.6% memory savings (for example dynamic PAMT), and the rest of t=
he
> > > > > benefits don't have numbers. How much are we getting for all the
> > > > > complexity, over say buddy allocated 2MB pages?
> >
> > TDX may have bigger fish to fry, but some of us have bigger fish to fry=
 than
> > TDX :-)
>
> Fair enough. But TDX is on the "roadmap". So it helps to say what the tar=
get of
> this series is.
>
> >
> > > > This series should work for any page sizes backed by hugetlb memory=
.
> > > > Non-CoCo VMs, pKVM and Confidential VMs all need hugepages that are
> > > > essential for certain workloads and will emerge as guest_memfd user=
s.
> > > > Features like KHO/memory persistence in addition also depend on
> > > > hugepage support in guest_memfd.
> > > >
> > > > This series takes strides towards making guest_memfd compatible wit=
h
> > > > usecases where 1G pages are essential and non-confidential VMs are
> > > > already exercising them.
> > > >
> > > > I think the main complexity here lies in supporting in-place
> > > > conversion which applies to any huge page size even for buddy
> > > > allocated 2MB pages or THP.
> > > >
> > > > This complexity arises because page structs work at a fixed
> > > > granularity, future roadmap towards not having page structs for gue=
st
> > > > memory (at least private memory to begin with) should help towards
> > > > greatly reducing this complexity.
> > > >
> > > > That being said, DPAMT and huge page EPT mappings for TDX VMs remai=
n
> > > > essential and complement this series well for better memory footpri=
nt
> > > > and overall performance of TDX VMs.
> > >
> > > Hmm, this didn't really answer my questions about the concrete benefi=
ts.
> > >
> > > I think it would help to include this kind of justification for the 1=
GB
> > > guestmemfd pages. "essential for certain workloads and will emerge" i=
s a bit
> > > hard to review against...
> > >
> > > I think one of the challenges with coco is that it's almost like a sp=
rint to
> > > reimplement virtualization. But enough things are changing at once th=
at not
> > > all of the normal assumptions hold, so it can't copy all the same sol=
utions.
> > > The recent example was that for TDX huge pages we found that normal
> > > promotion paths weren't actually yielding any benefit for surprising =
TDX
> > > specific reasons.
> > >
> > > On the TDX side we are also, at least currently, unmapping private pa=
ges
> > > while they are mapped shared, so any 1GB pages would get split to 2MB=
 if
> > > there are any shared pages in them. I wonder how many 1GB pages there=
 would
> > > be after all the shared pages are converted. At smaller TD sizes, it =
could
> > > be not much.
> >
> > You're conflating two different things.  guest_memfd allocating and man=
aging
> > 1GiB physical pages, and KVM mapping memory into the guest at 1GiB/2MiB
> > granularity.  Allocating memory in 1GiB chunks is useful even if KVM ca=
n only
> > map memory into the guest using 4KiB pages.
>
> I'm aware of the 1.6% vmemmap benefits from the LPC talk. Is there more? =
The
> list quoted there was more about guest performance. Or maybe the clever p=
age
> table walkers that find contiguous small mappings could benefit guest
> performance too? It's the kind of thing I'd like to see at least broadly =
called
> out.

The crux of this series really is hugetlb backing support for
guest_memfd and handling CoCo VMs irrespective of the page size as I
suggested earlier, so 2M page sizes will need to handle similar
complexity of in-place conversion.

Google internally uses 1G hugetlb pages to achieve high bandwidth IO,
lower memory footprint using HVO and lower MMU/IOMMU page table memory
footprint among other improvements. These percentages carry a
substantial impact when working at the scale of large fleets of hosts
each carrying significant memory capacity.

guest_memfd hugepage support + hugepage EPT mapping support for TDX
VMs significantly help:
1) ~70% decrease in TDX VM boot up time
2) ~65% decrease in TDX VM shutdown time
3) ~90% decrease in TDX VM PAMT memory overhead
4) Improvement in TDX SEPT memory overhead

And we believe this combination should also help achieve better
performance with TDX connect in future.

Hugetlb huge pages are preferred as they are statically carved out at
boot and so provide much better guarantees of availability. Once the
pages are carved out, any VMs scheduled on such a host will need to
work with the same hugetlb memory sizes. This series attempts to use
hugetlb pages with in-place conversion, avoiding the double allocation
problem that otherwise results in significant memory overheads for
CoCo VMs.

>
> I'm thinking that Google must have a ridiculous amount of learnings about=
 VM
> memory management. And this is probably designed around those learnings. =
But
> reviewers can't really evaluate it if they don't know the reasons and tra=
deoffs
> taken. If it's going upstream, I think it should have at least the high l=
evel
> reasoning explained.
>
> I don't mean to harp on the point so hard, but I didn't expect it to be
> controversial either.
>
> >
> > > So for TDX in isolation, it seems like jumping out too far ahead to
> > > effectively consider the value. But presumably you guys are testing t=
his on
> > > SEV or something? Have you measured any performance improvement? For =
what
> > > kind of applications? Or is the idea to basically to make guestmemfd =
work
> > > like however Google does guest memory?
> >
> > The longer term goal of guest_memfd is to make it suitable for backing =
all
> > VMs, hence Vishal's "Non-CoCo VMs" comment.
>
> Oh, I actually wasn't aware of this. Or maybe I remember now. I thought h=
e was
> talking about pKVM.
>
> >   Yes, some of this is useful for TDX, but we (and others) want to use
> > guest_memfd for far more than just CoCo VMs.
>
>
> >  And for non-CoCo VMs, 1GiB hugepages are mandatory for various workloa=
ds.
> I've heard this a lot. It must be true, but I've never seen the actual nu=
mbers.
> For a long time people believed 1GB huge pages on the direct map were cri=
tical,
> but then benchmarking on a contemporary CPU couldn't find much difference
> between 2MB and 1GB. I'd expect TDP huge pages to be different than that =
because
> the combined walks are huge, iTLB, etc, but I'd love to see a real number=
.

