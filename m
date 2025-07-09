Return-Path: <linux-fsdevel+bounces-54361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33021AFEBFE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 16:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AE41615DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AE22E5417;
	Wed,  9 Jul 2025 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jkl2KRat"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0B62E2658
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071343; cv=none; b=eX0aPEk48WPANteNjgKtnLyT+d3d46AlKREdYg4O28Sz8vehioW7BBTJ0OjSEgXBhcp74QlT5EH56dgS3fek1Fgj8WZvSoFJCOUw/h9B/kmE1a/4EEhxS+WzpTdwnJJGSxV+88d8L4K0bAAejkFP1Dmwnr0CvriLhz9S+lcinNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071343; c=relaxed/simple;
	bh=W7s40s+PfnHkEfrZ9uqQOxuCwAKK3oCV4Tf1biTsg8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbSkSQly/xMFVPheKw2Nc9XgaWL3ZostS9zOuVQcZe1DE0TxkFFvXY6AzV7sGyTSpqRSHP+SXuJz/Vsr1RxzgxVSbofM//8rV43GaHRHE/JvPRhoj+gD0ovVWpeCYLjQ24rV4NWcix3+c0bwpyeFY9YXyZTT6sRp8tCLa8MCZWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jkl2KRat; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235e389599fso216105ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 07:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752071341; x=1752676141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otqsPDt5osEXqjc5euk3u1KgCdwLcQ8YUxZOr7B7LAY=;
        b=Jkl2KRatCfbuD0/wXDThvA/ceDPQMsmpJlCa5Zabksrp+egx9Hh6fbixeqUP8PYA8o
         A7gHnZVnyyCHWiXR/toyRNLk0FVYn6mxwfaQ4J1u0VxiA3fufwIWoQeFBgCxsh+LGUEp
         PVKbuzVAnTMQzMwVgctEV8l/0nDfsAG7YRZV4702tmRgGfvvN6doNaYUt6sFkc5Q6uc6
         bLQO3h7X883lCkX+Cs4nV40QNi5iBL+cF597lwy/n3Rxh79e3JCwhDUo6ei0ROqn7AG3
         xtNpQaXq9aq/AVK5TdlKsKLDKQiQMk0OMCPy0iegIVJyzZen5ZTUErO4uOj1kbqX/MNs
         eRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071341; x=1752676141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otqsPDt5osEXqjc5euk3u1KgCdwLcQ8YUxZOr7B7LAY=;
        b=KbhEC0Kpn8r4eyCqZofvMOjjclFaXl5tTLjyplk/U8Y3Tim7TdlW2xG6NE3GsG2n2B
         XZeAcG7P/fI4G7TeqW4b1viXUlsRyaPVB6Cusg3FGGS7LxfMMEef8noqEZorrkM9GDWn
         TSH3POLyMGKE3AS/s+b5L5Wn1FLEoxerRMH/8XTHPQ2nMosZmZfe/deuT65b9MfAjaVF
         iqQ0hs1EnnfhxARdX+BbjD1/HgSXP3vxS+KM7x3N/5lJJ+wEtR2Hp2pwdKBvHGCsghTR
         2XevXIw3CGHbz8ZY+gHy3Rn9ZYxYF4olrlq72o0d3pJuCZ0LCWuv1n3cYymYPpAaIuJP
         Bdyw==
X-Forwarded-Encrypted: i=1; AJvYcCXuYkXtFIGJEYm/6sYJ4kMd5KklXBPgZqkQKLWMMun4ZRwuxvL88xJSqVeBatX/9k/h2AROCi3I2iIpfbB3@vger.kernel.org
X-Gm-Message-State: AOJu0YyCcXnHNYspr1i44bE3iy9o3/yRGhItJbpTxl7frtjNrRE/zymQ
	JSgVKrAp9HR0gl/R2m7lXIpV8rDeohBO0YTxkv6Qg+zerstxHFvWh7SwWBjttwE6t3elaguDGne
	FHO9caZ7wbKyOtU/z5blwvX24Du+uo3cVTUS/5b5t
X-Gm-Gg: ASbGncsZtYpu6In/7aQQw1hoRdsiKa3IysNan50I6NixrwSTGyR5SyweJPcY0elpFBP
	1iCHQEjTprnZkXSeM8Q7eBwjSqVc29NTQyijHzmRYgkeflntRKF2cer804/GnnsMW8WdOCHYVZg
	lWACowdgbkpxY4UJqeFci9QIj8Eu5sqdU0fZeBux7MMyu1mcTabI06wPS+UisWrn9OFP2shC3Fx
	yhL
X-Google-Smtp-Source: AGHT+IHZnJT8IPYNYYlq8IZWbrFrKSERazCCUgk/PYCXPT2eafZj+EWruKSZR2KdLOBmcVX/Dr9qFLZcvU+hjVe4mck=
X-Received: by 2002:a17:903:234a:b0:22e:4509:cb86 with SMTP id
 d9443c01a7336-23ddae070d9mr2349035ad.19.1752071340735; Wed, 09 Jul 2025
 07:29:00 -0700 (PDT)
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
 <aG1ps4uC4jyr8ED1@google.com>
In-Reply-To: <aG1ps4uC4jyr8ED1@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 9 Jul 2025 07:28:48 -0700
X-Gm-Features: Ac12FXzvLP7atWaiCB-cuaA1xwFEC8dxkhwp1kDPwptSswG_7FLCPsdSJrQ6QBQ
Message-ID: <CAGtprH86N7XgEXq0UyOexjVRXYV1KdOguURVOYXTnQzsTHPrJQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "pvorel@suse.cz" <pvorel@suse.cz>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	Jun Miao <jun.miao@intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"amoorthy@google.com" <amoorthy@google.com>, "tabba@google.com" <tabba@google.com>, 
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "maz@kernel.org" <maz@kernel.org>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, 
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, 
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, Wei W Wang <wei.w.wang@intel.com>, 
	Fan Du <fan.du@intel.com>, 
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, Dave Hansen <dave.hansen@intel.com>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "aik@amd.com" <aik@amd.com>, 
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>, "fvdl@google.com" <fvdl@google.com>, 
	"jack@suse.cz" <jack@suse.cz>, "quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, 
	Kirill Shutemov <kirill.shutemov@intel.com>, "willy@infradead.org" <willy@infradead.org>, 
	"steven.price@arm.com" <steven.price@arm.com>, "anup@brainfault.org" <anup@brainfault.org>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "keirf@google.com" <keirf@google.com>, 
	"mic@digikod.net" <mic@digikod.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nsaenz@amazon.es" <nsaenz@amazon.es>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>, 
	Zhiquan1 Li <zhiquan1.li@intel.com>, "rientjes@google.com" <rientjes@google.com>, 
	Erdem Aktas <erdemaktas@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, 
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "hughd@google.com" <hughd@google.com>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, Haibo1 Xu <haibo1.xu@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"rppt@kernel.org" <rppt@kernel.org>, "steven.sistare@oracle.com" <steven.sistare@oracle.com>, 
	"jarkko@kernel.org" <jarkko@kernel.org>, "quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "bfoster@redhat.com" <bfoster@redhat.com>, 
	"dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, Chao P Peng <chao.p.peng@intel.com>, 
	"pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, Alexander Graf <graf@amazon.com>, 
	"nikunj@amd.com" <nikunj@amd.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"jroedel@suse.de" <jroedel@suse.de>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"jgowans@amazon.com" <jgowans@amazon.com>, Yilun Xu <yilun.xu@intel.com>, 
	"liam.merwick@oracle.com" <liam.merwick@oracle.com>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, Ira Weiny <ira.weiny@intel.com>, 
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

On Tue, Jul 8, 2025 at 11:55=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Jul 08, 2025, Rick P Edgecombe wrote:
> > On Tue, 2025-07-08 at 11:03 -0700, Sean Christopherson wrote:
> > > > I think there is interest in de-coupling it?
> > >
> > > No?
> >
> > I'm talking about the intra-host migration/reboot optimization stuff. A=
nd not
> > doing a good job, sorry.
> >
> > >   Even if we get to a point where multiple distinct VMs can bind to a=
 single
> > > guest_memfd, e.g. for inter-VM shared memory, there will still need t=
o be a
> > > sole
> > > owner of the memory.  AFAICT, fully decoupling guest_memfd from a VM =
would add
> > > non-trivial complexity for zero practical benefit.
> >
> > I'm talking about moving a gmem fd between different VMs or something u=
sing
> > KVM_LINK_GUEST_MEMFD [0]. Not advocating to try to support it. But tryi=
ng to
> > feel out where the concepts are headed. It kind of allows gmem fds (or =
just
> > their source memory?) to live beyond a VM lifecycle.
>
> I think the answer is that we want to let guest_memfd live beyond the "st=
ruct kvm"
> instance, but not beyond the Virtual Machine.  From a past discussion on =
this topic[*].
>
>  : No go.  Because again, the inode (physical memory) is coupled to the v=
irtual machine
>  : as a thing, not to a "struct kvm".  Or more concretely, the inode is c=
oupled to an
>  : ASID or an HKID, and there can be multiple "struct kvm" objects associ=
ated with a
>  : single ASID.  And at some point in the future, I suspect we'll have mu=
ltiple KVM
>  : objects per HKID too.
>  :
>  : The current SEV use case is for the migration helper, where two KVM ob=
jects share
>  : a single ASID (the "real" VM and the helper).  I suspect TDX will end =
up with
>  : similar behavior where helper "VMs" can use the HKID of the "real" VM.=
  For KVM,
>  : that means multiple struct kvm objects being associated with a single =
HKID.
>  :
>  : To prevent use-after-free, KVM "just" needs to ensure the helper insta=
nces can't
>  : outlive the real instance, i.e. can't use the HKID/ASID after the owni=
ng virtual
>  : machine has been destroyed.
>  :
>  : To put it differently, "struct kvm" is a KVM software construct that _=
usually_,
>  : but not always, is associated 1:1 with a virtual machine.
>  :
>  : And FWIW, stashing the pointer without holding a reference would not b=
e a complete
>  : solution, because it couldn't guard against KVM reusing a pointer.  E.=
g. if a
>  : struct kvm was unbound and then freed, KVM could reuse the same memory=
 for a new
>  : struct kvm, with a different ASID/HKID, and get a false negative on th=
e rebinding
>  : check.
>
> Exactly what that will look like in code is TBD, but the concept/logic ho=
lds up.

I think we can simplify the role of guest_memfd in line with discussion [1]=
:
1) guest_memfd is a memory provider for userspace, KVM, IOMMU.
         - It allows fallocate to populate/deallocate memory
2) guest_memfd supports the notion of private/shared faults.
3) guest_memfd supports memory access control:
         - It allows shared faults from userspace, KVM, IOMMU
         - It allows private faults from KVM, IOMMU
4) guest_memfd supports changing access control on its ranges between
shared/private.
         - It notifies the users to invalidate their mappings for the
ranges getting converted/truncated.

Responsibilities that ideally should not be taken up by guest_memfd:
1) guest_memfd can not initiate pre-faulting on behalf of it's users.
2) guest_memfd should not be directly communicating with the
underlying architecture layers.
         - All communication should go via KVM/IOMMU.
3) KVM should ideally associate the lifetime of backing
pagetables/protection tables/RMP tables with the lifetime of the
binding of memslots with guest_memfd.
         - Today KVM SNP logic ties RMP table entry lifetimes with how
long the folios are mapped in guest_memfd, which I think should be
revisited.

Some very early thoughts on how guest_memfd could be laid out for the long =
term:
1) guest_memfd code ideally should be built-in to the kernel.
2) guest_memfd instances should still be created using KVM IOCTLs that
carry specific capabilities/restrictions for its users based on the
backing VM/arch.
3) Any outgoing communication from guest_memfd to it's users like
userspace/KVM/IOMMU should be via notifiers to invalidate similar to
how MMU notifiers work.
4) KVM and IOMMU can implement intermediate layers to handle
interaction with guest_memfd.
     - e.g. there could be a layer within kvm that handles:
             - creating guest_memfd files and associating a
kvm_gmem_context with those files.
             - memslot binding
                       - kvm_gmem_context will be used to bind kvm
memslots with the context ranges.
             - invalidate notifier handling
                        - kvm_gmem_context will be used to intercept
guest_memfd callbacks and
                          translate them to the right GPA ranges.
             - linking
                        - kvm_gmem_context can be linked to different
KVM instances.

This line of thinking can allow cleaner separation between
guest_memfd/KVM/IOMMU [2].

[1] https://lore.kernel.org/lkml/CAGtprH-+gPN8J_RaEit=3DM_ErHWTmFHeCipC6viT=
6PHhG3ELg6A@mail.gmail.com/#t
[2] https://lore.kernel.org/lkml/31beeed3-b1be-439b-8a5b-db8c06dadc30@amd.c=
om/



>
> [*] https://lore.kernel.org/all/ZOO782YGRY0YMuPu@google.com
>
> > [0] https://lore.kernel.org/all/cover.1747368092.git.afranji@google.com=
/
> > https://lore.kernel.org/kvm/cover.1749672978.git.afranji@google.com/

