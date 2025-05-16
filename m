Return-Path: <linux-fsdevel+bounces-49287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1AFABA22C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 19:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC52A02D1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 17:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D913B277022;
	Fri, 16 May 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="20Whvgl+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC772220F50
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417511; cv=none; b=fcMtFYgn3VMo4oqnNcsDlVtZobnfVz5crzbvXeHElX97+iBnYG3oKE/3b8o4e7uL+PhSB26JWxq3XkmjW9HEZVemAKYSB6p4tvt8PbwXHPRW75v5SBOGJ1XeHAvxrV0ncXvoxbV61jA0Z8BgXMty0w5snKA10gtGKicDs3W25N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417511; c=relaxed/simple;
	bh=SElR/wgeiqhNU2PLvcnH4xPVCpxXR17vAM5o54bgRPY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AeL9F9E6MzM0+u5SB5kp9RRwIcYmaMm+jbv7q+x3+NvrCbBMRwrUZtzl75JJt5oblp6hl2OpLsM+Lx6L2ijSTiBDZ1xKdffSl+qU8W0wb+AtIhZk0OHVj7asTh+vVNpgUS9VCvxURiV2RFpljc6TL2WbZpgIHMyfW3nGyBbDP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=20Whvgl+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30c54b40096so2695646a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 10:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747417509; x=1748022309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmpgPqdPibQ4HZg5sdzMeXt+/PpG65nXkSoggikM9ks=;
        b=20Whvgl+p8Wfn7Q/66MnARgGKgOXFaL+voQyeJ1+YKBGykK2WGLuuLNp8rBykhyHGZ
         oB2R0IQ2ozSuXolxVFBrm+1lwhEbTMNycThSz4bG+rKGpC37T1imqeMgpUiqqA1rFm7+
         yJLouX7rl9PHs7Ft03IHNcL1e7pmnP8TrXutk6fEj9RXoYVXW3FG04f3oiszW418Yecu
         Fp+Qmk1w6IkS6e4tlOZok5ZrwQ6E+ksFBEAvDJo5o9muutudgZiCV3Iwdx1ldj8kh3ya
         QRZvv0jK9IjOumdYyx4duNBaPJxVapTSMGtVx4KvNm+5Az0OZpw4Z64AP64+VGvywYJR
         dNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747417509; x=1748022309;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RmpgPqdPibQ4HZg5sdzMeXt+/PpG65nXkSoggikM9ks=;
        b=rRbTO2Y+EmfogZ3LZrbQNizYw7fYrDxlc1Q8w6IQ3Ec1Vla8bbs1q3YtoExyiBaHdy
         lqTmVXkPHPXWImQyPGOJza6+ICmg+kyt17pvZr2HXQoWAVq+/kiLuwby4AMN6z93/ABD
         3vBO2wCZFfvGNAkFvhXpC+92G5muNnDVDxbzxCNmARIrViZ8oMULWqOAVZwc8MoAZpRK
         K8gMvlcHYLjDc06zk28F67PpKGCNHRxtIt/Rzp5xkOEhB57VvPccpHSrusY6+kSalkvT
         IjgBLFUDnbZik71qAGo+3EORMPYkryoiYiKloAEHHDFGN5C7iN3v5fftlpEXw+AtEeR+
         K8AA==
X-Forwarded-Encrypted: i=1; AJvYcCWhyWLBACRc975hO5tp2M1cUO0EaRT25FjF4yjVGkPe8NtkR4Dim5teF18pkfs65CG6rKsN5Lh3ZgaVuPSh@vger.kernel.org
X-Gm-Message-State: AOJu0YwBoG57OEPkn4GY+nFI0jSFMgCZgGe2ifdqE7KKP3OU3/aaOD83
	As3lPn5qhz7vEEFud5VzR9xkHt9JRsdiH/GNKzrCuf8ZFjPLReGjzG4/w/kr3HqekJjBr8EVClN
	Gj6xwEw==
X-Google-Smtp-Source: AGHT+IE5q1d8Vhf45B58FtB+DPajsRh9WD6SiM5jWunemSpWwoZ702eFXBFahwA7/IbgQCUG1fK7U0brYiw=
X-Received: from pjbrs11.prod.google.com ([2002:a17:90b:2b8b:b0:308:867e:1ced])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e706:b0:2f9:c144:9d13
 with SMTP id 98e67ed59e1d1-30e7d5a8af4mr6412464a91.24.1747417508805; Fri, 16
 May 2025 10:45:08 -0700 (PDT)
Date: Fri, 16 May 2025 10:45:07 -0700
In-Reply-To: <CAGtprH8EMnmvvVir6_U+L5S3SEvrU1OzLrvkL58fXgfg59bjoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <ada87be8b9c06bc0678174b810e441ca79d67980.camel@intel.com>
 <CAGtprH9CTsVvaS8g62gTuQub4aLL97S7Um66q12_MqTFoRNMxA@mail.gmail.com>
 <24e8ae7483d0fada8d5042f9cd5598573ca8f1c5.camel@intel.com>
 <aCaM7LS7Z0L3FoC8@google.com> <7d3b391f3a31396bd9abe641259392fd94b5e72f.camel@intel.com>
 <CAGtprH8EMnmvvVir6_U+L5S3SEvrU1OzLrvkL58fXgfg59bjoA@mail.gmail.com>
Message-ID: <aCdVXn3ZqFXzQ0e4@google.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Vishal Annapurve <vannapurve@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "pvorel@suse.cz" <pvorel@suse.cz>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	Jun Miao <jun.miao@intel.com>, Kirill Shutemov <kirill.shutemov@intel.com>, 
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "steven.price@arm.com" <steven.price@arm.com>, 
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"amoorthy@google.com" <amoorthy@google.com>, "tabba@google.com" <tabba@google.com>, 
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "maz@kernel.org" <maz@kernel.org>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, 
	"keirf@google.com" <keirf@google.com>, "hughd@google.com" <hughd@google.com>, 
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "willy@infradead.org" <willy@infradead.org>, 
	"jack@suse.cz" <jack@suse.cz>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "aik@amd.com" <aik@amd.com>, 
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>, 
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "fvdl@google.com" <fvdl@google.com>, 
	"rppt@kernel.org" <rppt@kernel.org>, "quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, 
	"nsaenz@amazon.es" <nsaenz@amazon.es>, "vbabka@suse.cz" <vbabka@suse.cz>, Fan Du <fan.du@intel.com>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "mic@digikod.net" <mic@digikod.net>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "bfoster@redhat.com" <bfoster@redhat.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>, 
	Zhiquan1 Li <zhiquan1.li@intel.com>, "rientjes@google.com" <rientjes@google.com>, 
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, Erdem Aktas <erdemaktas@google.com>, 
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, Haibo1 Xu <haibo1.xu@intel.com>, 
	"anup@brainfault.org" <anup@brainfault.org>, Dave Hansen <dave.hansen@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	Wei W Wang <wei.w.wang@intel.com>, 
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>, "jarkko@kernel.org" <jarkko@kernel.org>, 
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	Kai Huang <kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, 
	Chao P Peng <chao.p.peng@intel.com>, "nikunj@amd.com" <nikunj@amd.com>, Alexander Graf <graf@amazon.com>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "jroedel@suse.de" <jroedel@suse.de>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "jgowans@amazon.com" <jgowans@amazon.com>, 
	Yilun Xu <yilun.xu@intel.com>, "liam.merwick@oracle.com" <liam.merwick@oracle.com>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>, 
	"richard.weiyang@gmail.com" <richard.weiyang@gmail.com>, Ira Weiny <ira.weiny@intel.com>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"qperret@google.com" <qperret@google.com>, 
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>, "dmatlack@google.com" <dmatlack@google.com>, 
	"james.morse@arm.com" <james.morse@arm.com>, "brauner@kernel.org" <brauner@kernel.org>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "pgonda@google.com" <pgonda@google.com>, 
	"quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>, "roypat@amazon.co.uk" <roypat@amazon.co.uk>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "will@kernel.org" <will@kernel.org>, 
	"hch@infradead.org" <hch@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025, Vishal Annapurve wrote:
> On Thu, May 15, 2025 at 7:12=E2=80=AFPM Edgecombe, Rick P <rick.p.edgecom=
be@intel.com> wrote:
> > On Thu, 2025-05-15 at 17:57 -0700, Sean Christopherson wrote:
> > > You're conflating two different things.  guest_memfd allocating and m=
anaging
> > > 1GiB physical pages, and KVM mapping memory into the guest at 1GiB/2M=
iB
> > > granularity.  Allocating memory in 1GiB chunks is useful even if KVM =
can only
> > > map memory into the guest using 4KiB pages.
> >
> > I'm aware of the 1.6% vmemmap benefits from the LPC talk. Is there more=
? The
> > list quoted there was more about guest performance. Or maybe the clever=
 page
> > table walkers that find contiguous small mappings could benefit guest
> > performance too? It's the kind of thing I'd like to see at least broadl=
y called
> > out.
>=20
> The crux of this series really is hugetlb backing support for guest_memfd=
 and
> handling CoCo VMs irrespective of the page size as I suggested earlier, s=
o 2M
> page sizes will need to handle similar complexity of in-place conversion.
>=20
> Google internally uses 1G hugetlb pages to achieve high bandwidth IO,

E.g. hitting target networking line rates is only possible with 1GiB mappin=
gs,
otherwise TLB pressure gets in the way.

> lower memory footprint using HVO and lower MMU/IOMMU page table memory
> footprint among other improvements. These percentages carry a substantial
> impact when working at the scale of large fleets of hosts each carrying
> significant memory capacity.

Yeah, 1.6% might sound small, but over however many bytes of RAM there are =
in
the fleet, it's a huge (lol) amount of memory saved.

> > >   Yes, some of this is useful for TDX, but we (and others) want to us=
e
> > > guest_memfd for far more than just CoCo VMs.
> >
> >
> > >  And for non-CoCo VMs, 1GiB hugepages are mandatory for various workl=
oads.
> > I've heard this a lot. It must be true, but I've never seen the actual =
numbers.
> > For a long time people believed 1GB huge pages on the direct map were c=
ritical,
> > but then benchmarking on a contemporary CPU couldn't find much differen=
ce
> > between 2MB and 1GB. I'd expect TDP huge pages to be different than tha=
t because
> > the combined walks are huge, iTLB, etc, but I'd love to see a real numb=
er.

The direct map is very, very different than userspace and thus guest mappin=
gs.
Software (hopefully) isn't using the direct map to index multi-TiB database=
s,
or to transfer GiBs of data over the network.  The amount of memory the ker=
nel
is regularly accessing is an order or two magnitude smaller than single pro=
cess
use cases.

A few examples from a quick search:

http://pvk.ca/Blog/2014/02/18/how-bad-can-1gb-pages-be
https://www.percona.com/blog/benchmark-postgresql-with-linux-hugepages/

