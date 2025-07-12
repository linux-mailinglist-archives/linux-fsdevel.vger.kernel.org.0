Return-Path: <linux-fsdevel+bounces-54761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E01B02C22
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 19:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEAC4E29BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 17:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957A8288C92;
	Sat, 12 Jul 2025 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uv9yqfdP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFAF6F073
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752341610; cv=none; b=hr9ASuDWDg08B1BbenV/lrGGFKT+cu0vZLnSa0zjN64+xK0SJnRQtOeEhXpjgHluLtOkSfmaPaqc9y3Zllp9+PDIuipTymgMr99Ea0D1fKeWP2pGCSwrxGcMaBPoeFAWvhu+AO3ZZ7Ql5B6GeFK3FNcVkygiPAGO0czsHNGMSPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752341610; c=relaxed/simple;
	bh=D/+sxTwjJgwlHE5NC/YiqbecaXDt11k/7Z+0KkMnR8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOE0J10jNiW+eyPA3DPN1EK3R7YK/mfgO07r2V67pGqsCCLfaZrg1zwQKLepaHsB2E8ee2tWY+a3cgtlnNRT5Zilxw8TGWzhVfftF/Huh5C19oFUjm8tO0kCfCttZHuK79nnN4fQn62vMxkxzY8/Q2ZLxuUUtGgJcFTyitPhFS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uv9yqfdP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-237f18108d2so132365ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752341608; x=1752946408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7msmF5PY7ib+4ZMdkz9ddSo3sJ/jTEzwKLjkgSY+Dg=;
        b=Uv9yqfdP8ITh2CQoi3FYXJy0y1scZFYv1cMyteLZbXdJWbLoRxu0aXHwStBtPryV7E
         8u+tEadVtTA1k+EHsL8l41gGfjgPKuwjVljQtZpZGHyCp4bWSGysj1mjHc7sBOUR6mkZ
         w0iZJjphlAA5M+A/Uh2u5nlZeHGkKMxhRBJ1HKDT79RAWQKHWcq55w/xHQP1O+525TiO
         2Lm/yCyQPP7MiycfHxw+n6S5D7mXreP6qmBUlXtvFRqoIWZBUXZScXVFS0bg6B1s2r1M
         tyhQQ57SIOqnbRWEs/517e9YCCiaoSoWUaSvQsI41pc6hv6xfHUeipmnXaD6D5G0QRTZ
         yr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752341608; x=1752946408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7msmF5PY7ib+4ZMdkz9ddSo3sJ/jTEzwKLjkgSY+Dg=;
        b=kL+kgL2XL5IJEfEyB9lIkNFQ+FcsP/1unPGLEE0hr70EUYy6JaeI543gArXWP6xk1W
         LjEBnMoJgyp63lTDs7nhptrE8qE5PQqDPWhcLxl1kRXmstFpgvtFY9ahm7hFYWTiRlMz
         NC6Vxmi7qxLB8qiUHN8jIOKSXArpNeSeQrbGCLfIf2nwM9JyERh62FWuftUZLuqKm1A2
         kqWY4jR+FusKnU2MF3DqGDKUCBt4d0jSeyMwvzCivZDxovwD9BlQvo8vQ15x61Zbw+Mc
         TfBP6ZtwKnVZp0I3siZQmwanKhrvm4VcVepPkpX192wpq7wzZtcRvFEkGi9CFxoCtijU
         4I1g==
X-Forwarded-Encrypted: i=1; AJvYcCVVov6nrUe+V7erYY1bKbWDKQ4PNilfiWOWyHzW2jcVjFH/a7zNNHAwQzdwtUDAUYar6l/tgkwbGpeUmD+q@vger.kernel.org
X-Gm-Message-State: AOJu0YzrkApvg4GivO94SDimRABoJkWEdJXQ7B3KfOjoYG1FfEPyvkF7
	MnTdSn78LnNsai3nbUOKUC2AGKm9rjgSgiKPLqdL/h5/aKliFlUME1j3KPDEq3HFaVllrKdltal
	h6QCeHs/TcHaYF9wmLUc/+NrapNkmWaZOBUryFkJc
X-Gm-Gg: ASbGnctyWtX50mH8D/B7xju7ArolPn/qOcYOEPM7UpGfBI1rhaj9CGiBqJZElFM3ssi
	Mbsbks/xP20rs47ojPmkf6nn+QJM4qFh4s3ZZ0+TypiKRgk34kWu2Z+M8jVSLN9qbc1fk1Nw8V2
	Tzucbb+6elLj9V6K4RkBHtqv6zr3grJqatiZu+CzGHcwJua29HnMuR0NHIqUssZWiIcJRnJMhW6
	o/mrAyhjABZ1OCqDBQQq9An+70E5sUm3vXXRfxS
X-Google-Smtp-Source: AGHT+IGOwmmOvHU5TdyUaaF7aTYL0i8GNBXrrhGyi3z4BA4euoatDzGCE8dL+1tDQ9wYfDVbsYBeS729UYvOHJmxrWU=
X-Received: by 2002:a17:902:ec85:b0:22e:766f:d66e with SMTP id
 d9443c01a7336-23df6afcdb8mr1791365ad.12.1752341607051; Sat, 12 Jul 2025
 10:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aG0pNijVpl0czqXu@google.com> <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
 <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
 <eeb8f4b8308b5160f913294c4373290a64e736b8.camel@intel.com>
 <CAGtprH8cg1HwuYG0mrkTbpnZfHoKJDd63CAQGEScCDA-9Qbsqw@mail.gmail.com>
 <b1348c229c67e2bad24e273ec9a7fc29771e18c5.camel@intel.com>
 <aG1dbD2Xnpi_Cqf_@google.com> <5decd42b3239d665d5e6c5c23e58c16c86488ca8.camel@intel.com>
 <aG1ps4uC4jyr8ED1@google.com> <CAGtprH86N7XgEXq0UyOexjVRXYV1KdOguURVOYXTnQzsTHPrJQ@mail.gmail.com>
 <aG6D9NqG0r6iKPL0@google.com> <CAGtprH_DY=Sjeh32NCc7Y3t2Vug8LKz+-=df4oSw09cRbb6QZw@mail.gmail.com>
 <CAGtprH9NbCPSwZrQAUzFw=4rZPA60QBM2G8opYo9CZxRiYihzg@mail.gmail.com>
In-Reply-To: <CAGtprH9NbCPSwZrQAUzFw=4rZPA60QBM2G8opYo9CZxRiYihzg@mail.gmail.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Sat, 12 Jul 2025 10:33:12 -0700
X-Gm-Features: Ac12FXyZj5IyRrPeX-4vUKfdJIwXEzSvUSNEtsk0ttD7VXz_GmBFr4rl6viPRO0
Message-ID: <CAGtprH_cy1pLWQ572zUfxf_Y0XbW5-kX6j4XE2qjvF9YnxHjfw@mail.gmail.com>
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

On Fri, Jul 11, 2025 at 2:18=E2=80=AFPM Vishal Annapurve <vannapurve@google=
.com> wrote:
>
> On Wed, Jul 9, 2025 at 6:30=E2=80=AFPM Vishal Annapurve <vannapurve@googl=
e.com> wrote:
> > > > 3) KVM should ideally associate the lifetime of backing
> > > > pagetables/protection tables/RMP tables with the lifetime of the
> > > > binding of memslots with guest_memfd.
> > >
> > > Again, please align your indentation.
> > >
> > > >          - Today KVM SNP logic ties RMP table entry lifetimes with =
how
> > > >            long the folios are mapped in guest_memfd, which I think=
 should be
> > > >            revisited.
> > >
> > > Why?  Memslots are ephemeral per-"struct kvm" mappings.  RMP entries =
and guest_memfd
> > > inodes are tied to the Virtual Machine, not to the "struct kvm" insta=
nce.
> >
> > IIUC guest_memfd can only be accessed through the window of memslots
> > and if there are no memslots I don't see the reason for memory still
> > being associated with "virtual machine". Likely because I am yet to
> > completely wrap my head around 'guest_memfd inodes are tied to the
> > Virtual Machine, not to the "struct kvm" instance', I need to spend
> > more time on this one.
> >
>
> I see the benefits of tying inodes to the virtual machine and
> different guest_memfd files to different KVM instances. This allows us
> to exercise intra-host migration usecases for TDX/SNP. But I think
> this model doesn't allow us to reuse guest_memfd files for SNP VMs
> during reboot.
>
> Reboot scenario assuming reuse of existing guest_memfd inode for the
> next instance:
> 1) Create a VM
> 2) Create guest_memfd files that pin KVM instance
> 3) Create memslots
> 4) Start the VM
> 5) For reboot/shutdown, Execute VM specific Termination (e.g.
> KVM_TDX_TERMINATE_VM)
> 6) if allowed, delete the memslots
> 7) Create a new VM instance
> 8) Link the existing guest_memfd files to the new VM -> which creates
> new files for the same inode.
> 9) Close the existing guest_memfd files and the existing VM
> 10) Jump to step 3
>
> The difference between SNP and TDX is that TDX memory ownership is
> limited to the duration the pages are mapped in the second stage
> secure EPT tables, whereas SNP/RMP memory ownership lasts beyond
> memslots and effectively remains till folios are punched out from
> guest_memfd filemap. IIUC CCA might follow the suite of SNP in this
> regard with the pfns populated in GPT entries.
>
> I don't have a sense of how critical this problem could be, but this
> would mean for every reboot all large memory allocations will have to
> let go and need to be reallocated. For 1G support, we will be freeing
> guest_memfd pages using a background thread which may add some delays
> in being able to free up the memory in time.
>
> Instead if we did this:
> 1) Support creating guest_memfd files for a certain VM type that
> allows KVM to dictate the behavior of the guest_memfd.
> 2) Tie lifetime of KVM SNP/TDX memory ownership with guest_memfd and
> memslot bindings
>     - Each binding will increase a refcount on both guest_memfd file
> and KVM, so both can't go away while the binding exists.

I think if we can ensure that any guest_memfd initiated interaction
with KVM is only for invalidation and is based on binding and under
filemap_invalidate_lock then there is no need to pin KVM on each
binding, as binding/unbinding should be protected using
filemap_invalidate_lock and so KVM can't go away during invalidation.



> 3) For SNP/CCA, pfns are invalidated from RMP/GPT tables during unbind
> operations while for TDX, KVM will invalidate secure EPT entries.
>
> This can allow us to decouple memory lifecycle from VM lifecycle and
> match the behavior with non-confidential VMs where memory can outlast
> VMs. Though this approach will mean change in intrahost migration
> implementation as we don't need to differentiate guest_memfd files and
> inodes.
>
> That being said, I might be missing something here and I don't have
> any data to back the criticality of this usecase for SNP and possibly
> CCA VMs.

