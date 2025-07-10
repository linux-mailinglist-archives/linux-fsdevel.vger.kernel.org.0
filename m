Return-Path: <linux-fsdevel+bounces-54410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75543AFF7A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 05:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4670C7B6EEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 03:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A84283CA2;
	Thu, 10 Jul 2025 03:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PK4EnXIu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE822820B7
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 03:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118792; cv=none; b=AZcQh7IsWTi79iWmhqeLWigde81QMxWapZYTPeFUtEfcN9h3LXqoBlsjqkxHsv2c6WtIaF4sZ2HTtQcy2gRhmaFXmAQUWUhtSBTjr+CHYWKse7nxZzyyeCJbvsEy+fJME7XxEKKe98oAXWEDyyjP04GrtJve+bl7r5mDn8Vonfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118792; c=relaxed/simple;
	bh=ltuIyEGsYKAVkUC8bI6NbuIrfZ6n2CS6dG1w/GUIO1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ij4QuHQbpiwVm9cOjtyi+UXLvsfRYeQwwmljoKzWtavs0HNLuX/5PDFydrPYfZ9DpqoocHWOTmJR9WRaTlS9psB2crvT5I4RUmPQjheddyooLbfptPoxRJmEVvxcazB5yCXteR6ZZowT2lj324bcwOH+tkHISmftnJu7ElNfMY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PK4EnXIu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235e389599fso118725ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 20:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752118790; x=1752723590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRlQ79ljXXr6mSwltdgFEe59EkK6pS6NPipORQRa7q4=;
        b=PK4EnXIugTaCkLILbQR23ljaZ70cbRK7yDJLqBV25pv2DGAsklGLRirjxi/b96naEm
         zVck4NAy1lbGXakYhfKMgW9KGPXBrXtw3Qv3/kQ8S2m05KPj6UNQ65Tc6rexKkUrqvvg
         cK/VkeoOM2z8g2NnDhH1YM2HvvOMbged0AJf+0BudW6Ysfs2+Cj1BhzZ47J+JbuuAu/w
         8DstFQdjcFsU/SAoZ5YI4NdWXohacMYH3v+jz9PSPd/+odSN+jgolOKNXewAcZf0vJ8h
         o6IFgrZ/T2xOoi9wA+qDO2etf9fpuVdT26kBKrW24nQotsSsu6t6br89CjYF/om/ThGI
         NeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752118790; x=1752723590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRlQ79ljXXr6mSwltdgFEe59EkK6pS6NPipORQRa7q4=;
        b=XYfQd1OZqlDSFBe5d4hitw3x2nkux01SpsddMtcx/S0/m5UTqr/pvbs1NmJEPHg8D7
         Q0y5/fSrB2S5UEDVSFSyRE4NmO7jXVYPSDXBlr1/KEmZKPToQhi/ShhJxnTNeJCDbJHi
         m7cpi87lNBeUN14bSli2K+LaCx2ZgIe9QUFurqtMp5eRwaUUSdJSPkBjI16Ma9knTSoc
         aEONzqi6CKIEwix8mQoXxYEAbFm9x4hiUfJIHMe4cTk6WFH11fLbVz6ydyUy329K2aKM
         kTvOIHEuun6L6WtLe923txZN2DS6u6kPLTgIzh0T2f4LFeizFT7FTTPx9lgbDKg14//Y
         DS0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWe4fA2RlX1/MTQFzf0QKrkhNpOM/9iOBq1eJtlnNsU9xKIqzHhf9IlrBsIVy3bqg1e6hcrznE9vfzr+Fd@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/8LKrq1BHj1RQzzEfYxSp7bjQze1nKipD6BY0/7YFhfAa0A7
	x7urzNQlzNuya0Cd6BCKRCsmW/B7TiQg5ut70pJtpc3MOmEDRiHv28y7fVu4ck+aMlreD8rUh3M
	NwWuuZgdp+/30g+IjFvjoPB2FxMlAiNjDq/qB9YfU
X-Gm-Gg: ASbGncts0MhQLVCCSb/mi0g+Vuam23mFb80tmymoSlWrICDId2/pQ65QZATfuSOa3nW
	+dG090oSd4QUhy2IQjL2gpB6ARVB/glWY7+awXHxH8zzMHWNKqntcRreVmDCvxUfTeX1tfysugA
	gc6kaeUFDLryek23jm5y4HK84egh06sTrVOnGirtw7KZw+2ZJgzz2zWMFo24FnNMct0Mg+DNmLI
	A==
X-Google-Smtp-Source: AGHT+IFNdXMLLMHzYyYMCLYInTnZ0FqKDLOyiXEeczMGTqoYZAimdGifr5hKh7FXeaefcn7hZsZlz0Q2uZ9bsaSqKBg=
X-Received: by 2002:a17:902:cec8:b0:231:d0ef:e8ff with SMTP id
 d9443c01a7336-23de372b919mr1790925ad.8.1752118789639; Wed, 09 Jul 2025
 20:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
 <006899ccedf93f45082390460620753090c01914.camel@intel.com>
 <aG0pNijVpl0czqXu@google.com> <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
 <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
 <eeb8f4b8308b5160f913294c4373290a64e736b8.camel@intel.com>
 <CAGtprH8cg1HwuYG0mrkTbpnZfHoKJDd63CAQGEScCDA-9Qbsqw@mail.gmail.com>
 <b1348c229c67e2bad24e273ec9a7fc29771e18c5.camel@intel.com>
 <aG1dbD2Xnpi_Cqf_@google.com> <5decd42b3239d665d5e6c5c23e58c16c86488ca8.camel@intel.com>
 <aG1ps4uC4jyr8ED1@google.com> <CAGtprH86N7XgEXq0UyOexjVRXYV1KdOguURVOYXTnQzsTHPrJQ@mail.gmail.com>
 <c9bf0d3eca32026fae58c6d0ce3298ec01629d33.camel@intel.com>
In-Reply-To: <c9bf0d3eca32026fae58c6d0ce3298ec01629d33.camel@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 9 Jul 2025 20:39:36 -0700
X-Gm-Features: Ac12FXzLm-0HLY-D-VuCf-_kpUdqDwZmo7Dl0JNusIPodOTsjQNE_6ODLGzw0B4
Message-ID: <CAGtprH9v=bw2q7ogo0Z46icsVWMUhm1ryyxdRFuiMkcGgxrw2w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "pvorel@suse.cz" <pvorel@suse.cz>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"Miao, Jun" <jun.miao@intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"amoorthy@google.com" <amoorthy@google.com>, "tabba@google.com" <tabba@google.com>, 
	"maz@kernel.org" <maz@kernel.org>, "quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, "jack@suse.cz" <jack@suse.cz>, 
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, 
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, "Wang, Wei W" <wei.w.wang@intel.com>, 
	"keirf@google.com" <keirf@google.com>, 
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "willy@infradead.org" <willy@infradead.org>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"aik@amd.com" <aik@amd.com>, "usama.arif@bytedance.com" <usama.arif@bytedance.com>, 
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "fvdl@google.com" <fvdl@google.com>, 
	"rppt@kernel.org" <rppt@kernel.org>, "quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, 
	"nsaenz@amazon.es" <nsaenz@amazon.es>, "anup@brainfault.org" <anup@brainfault.org>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mic@digikod.net" <mic@digikod.net>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "Du, Fan" <fan.du@intel.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "steven.price@arm.com" <steven.price@arm.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>, 
	"Li, Zhiquan1" <zhiquan1.li@intel.com>, "rientjes@google.com" <rientjes@google.com>, 
	"Aktas, Erdem" <erdemaktas@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, 
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "hughd@google.com" <hughd@google.com>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "Xu, Haibo1" <haibo1.xu@intel.com>, 
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>, 
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, "jarkko@kernel.org" <jarkko@kernel.org>, 
	"Shutemov, Kirill" <kirill.shutemov@intel.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"Huang, Kai" <kai.huang@intel.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"bfoster@redhat.com" <bfoster@redhat.com>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, 
	"Peng, Chao P" <chao.p.peng@intel.com>, "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, 
	"Graf, Alexander" <graf@amazon.com>, "nikunj@amd.com" <nikunj@amd.com>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "jroedel@suse.de" <jroedel@suse.de>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "jgowans@amazon.com" <jgowans@amazon.com>, 
	"Xu, Yilun" <yilun.xu@intel.com>, "liam.merwick@oracle.com" <liam.merwick@oracle.com>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, "quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>, 
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"Weiny, Ira" <ira.weiny@intel.com>, 
	"richard.weiyang@gmail.com" <richard.weiyang@gmail.com>, 
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>, "qperret@google.com" <qperret@google.com>, 
	"dmatlack@google.com" <dmatlack@google.com>, "james.morse@arm.com" <james.morse@arm.com>, 
	"brauner@kernel.org" <brauner@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "pgonda@google.com" <pgonda@google.com>, 
	"quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>, "roypat@amazon.co.uk" <roypat@amazon.co.uk>, 
	"hch@infradead.org" <hch@infradead.org>, "will@kernel.org" <will@kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 8:17=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Wed, 2025-07-09 at 07:28 -0700, Vishal Annapurve wrote:
> > I think we can simplify the role of guest_memfd in line with discussion=
 [1]:
> > 1) guest_memfd is a memory provider for userspace, KVM, IOMMU.
> >          - It allows fallocate to populate/deallocate memory
> > 2) guest_memfd supports the notion of private/shared faults.
> > 3) guest_memfd supports memory access control:
> >          - It allows shared faults from userspace, KVM, IOMMU
> >          - It allows private faults from KVM, IOMMU
> > 4) guest_memfd supports changing access control on its ranges between
> > shared/private.
> >          - It notifies the users to invalidate their mappings for the
> > ranges getting converted/truncated.
>
> KVM needs to know if a GFN is private/shared. I think it is also intended=
 to now
> be a repository for this information, right? Besides invalidations, it ne=
eds to
> be queryable.

Yeah, that interface can be added as well. Though, if possible KVM can
just directly pass the fault type to guest_memfd and it can return an
error if the fault type doesn't match the permission. Additionally KVM
does query the mapping order for a certain pfn/gfn which will need to
be supported as well.

>
> >
> > Responsibilities that ideally should not be taken up by guest_memfd:
> > 1) guest_memfd can not initiate pre-faulting on behalf of it's users.
> > 2) guest_memfd should not be directly communicating with the
> > underlying architecture layers.
> >          - All communication should go via KVM/IOMMU.
>
> Maybe stronger, there should be generic gmem behaviors. Not any special
> if (vm_type =3D=3D tdx) type logic.
>
> > 3) KVM should ideally associate the lifetime of backing
> > pagetables/protection tables/RMP tables with the lifetime of the
> > binding of memslots with guest_memfd.
> >          - Today KVM SNP logic ties RMP table entry lifetimes with how
> > long the folios are mapped in guest_memfd, which I think should be
> > revisited.
>
> I don't understand the problem. KVM needs to respond to user accessible
> invalidations, but how long it keeps other resources around could be usef=
ul for
> various optimizations. Like deferring work to a work queue or something.

I don't think it could be deferred to a work queue as the RMP table
entries will need to be removed synchronously once the last reference
on the guest_memfd drops, unless memory itself is kept around after
filemap eviction. I can see benefits of this approach for handling
scenarios like intrahost-migration.

>
> I think it would help to just target the ackerly series goals. We should =
get
> that code into shape and this kind of stuff will fall out of it.
>
> >
> > Some very early thoughts on how guest_memfd could be laid out for the l=
ong term:
> > 1) guest_memfd code ideally should be built-in to the kernel.
> > 2) guest_memfd instances should still be created using KVM IOCTLs that
> > carry specific capabilities/restrictions for its users based on the
> > backing VM/arch.
> > 3) Any outgoing communication from guest_memfd to it's users like
> > userspace/KVM/IOMMU should be via notifiers to invalidate similar to
> > how MMU notifiers work.
> > 4) KVM and IOMMU can implement intermediate layers to handle
> > interaction with guest_memfd.
> >      - e.g. there could be a layer within kvm that handles:
> >              - creating guest_memfd files and associating a
> > kvm_gmem_context with those files.
> >              - memslot binding
> >                        - kvm_gmem_context will be used to bind kvm
> > memslots with the context ranges.
> >              - invalidate notifier handling
> >                         - kvm_gmem_context will be used to intercept
> > guest_memfd callbacks and
> >                           translate them to the right GPA ranges.
> >              - linking
> >                         - kvm_gmem_context can be linked to different
> > KVM instances.
>
> We can probably look at the code to decide these.
>

Agree.

