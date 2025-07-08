Return-Path: <linux-fsdevel+bounces-54291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E52DAFD5ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 20:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C93F5852F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 18:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75632E5432;
	Tue,  8 Jul 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ux6carKz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A051721C19F
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997809; cv=none; b=JHTTFm4DGTVtttQbHMoJxTMfgDmZl2KkFgeLZIJKJ8d2xCq1OdERIepEjpfs1o2lFnIB8W3+m/CUQ6+JiMsv3V46jkjlHgpFDwCwoaaG5dR6fT6OmJmbesNf1G0Nlo7tRuQZR2BOiTY0wJ/wUf2BEXfIckA9EzwflsHctsPm/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997809; c=relaxed/simple;
	bh=s4RZ8nQJieFScy8n8qpYU1+xTprPbswQodWfgBTVO6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OIvzot2/5iwmGKX8AVxYBPCtWZtFb+H4lv8MWoe5HdJSEGTWFZxjHuPW0wItAqk31DiK+9D8rOrNguxssopBp/M1YAKdjLLytDW8IR251Lbh12RypQy0OjdKVKY9GT9wzMLYADgyKLBJoA/i8H155A4dH3FUSVLtudjbBItL0TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ux6carKz; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7398d70abbfso6574452b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 11:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751997807; x=1752602607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x10LXm7PeGMN7MOtWLfXfbWmNGz9S10d7VYiV0yVtCU=;
        b=Ux6carKzEVXp2mCssYyO7weq0585vmPNpUsnYFGzybJ/wowAHWNcLxUgnkKYz2ENB9
         ypypBSeZSMxOsSegDpKOQsPo5PkFc/MvwoGgFU+dxlHoygIhjPODiCGpaETdVNmNcwMh
         Lzq60vumwNC4RRZVRCWfdnHK+AzOy9h7mC0WEJ54lYIG3SiUIvLWvLsVczuK/9nlWCZF
         toXcYjYu1vWUOVOSOOyiuZNaxrVyzm7fUt31WElXqPds/9/R18ckh+tD5X6XvyDT23BR
         KR5O0+LqJfAksBDJu+NzPqm8tqJEHnsuRuIV/QqAEn/hLTG7ZfbEOvP56EYHBcKUKkIf
         osDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997807; x=1752602607;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x10LXm7PeGMN7MOtWLfXfbWmNGz9S10d7VYiV0yVtCU=;
        b=M3WIO1ai15uw0EYS4lTpOBEwh+dizJctu8i8TSViVA3n+DoJZeL7KEcgeuF+hoLk0Y
         iEx/YsfBaB5ykkfKiuJfAlL93KfLQjec9fSj9xxE839toJmmhDVbdbiIQSTn/kbLBBaN
         0oowaHoE9TtXAi+oUT/nJitzkj58ISH1nsINIhgkhLg/5jqZcEaGZn4Mz8rGza9aduZV
         B0dF09Ntj6AcBWh2a9r6YFSqPTA22JOhLlkMaLdDnogGmOQwx0mdqdlTl8XAnH8EiShY
         jFtFRNztEVIhuGVtNCius0+P0/JpH109FeFUEvfydz8Ku1qRlEWwmHnnb9t4c4/xBGm0
         sh+g==
X-Forwarded-Encrypted: i=1; AJvYcCVSI+2kWqvBp6wblFZWqnHZF8i/b71y/zBsitBvJmMR5YucUDLPB2XwvNMyixprzgKEiNrj0pbIZvW6SvuX@vger.kernel.org
X-Gm-Message-State: AOJu0YyTxO6v3/Lqize49sFENGugDlpFPat/wsAyOrFX6gf9M0OInMHt
	rUvDj2Q0wXQVLE00stA+UAfruYJnUH7V7z/DF8HgMmGnR/u9ruLHfqITDP/M5vjYL6tkOxQpaRt
	w4ggE2A==
X-Google-Smtp-Source: AGHT+IFe4SBpWGzwWywsUZpN2vnR08oPkVmXJnGtvFDNSO2RDy7ZqC2nSucMyoDDGRjNc9DXvg6wKac3oiE=
X-Received: from pfbna28.prod.google.com ([2002:a05:6a00:3e1c:b0:748:f98a:d97b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:549d:b0:1f5:717b:46dc
 with SMTP id adf61e73a8af0-22c7f545df3mr622282637.27.1751997806375; Tue, 08
 Jul 2025 11:03:26 -0700 (PDT)
Date: Tue, 8 Jul 2025 11:03:24 -0700
In-Reply-To: <b1348c229c67e2bad24e273ec9a7fc29771e18c5.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAGtprH-Je5OL-djtsZ9nLbruuOqAJb0RCPAnPipC1CXr2XeTzQ@mail.gmail.com>
 <aGxXWvZCfhNaWISY@google.com> <CAGtprH_57HN4Psxr5MzAZ6k+mLEON2jVzrLH4Tk+Ws29JJuL4Q@mail.gmail.com>
 <006899ccedf93f45082390460620753090c01914.camel@intel.com>
 <aG0pNijVpl0czqXu@google.com> <a0129a912e21c5f3219b382f2f51571ab2709460.camel@intel.com>
 <CAGtprH8ozWpFLa2TSRLci-SgXRfJxcW7BsJSYOxa4Lgud+76qQ@mail.gmail.com>
 <eeb8f4b8308b5160f913294c4373290a64e736b8.camel@intel.com>
 <CAGtprH8cg1HwuYG0mrkTbpnZfHoKJDd63CAQGEScCDA-9Qbsqw@mail.gmail.com> <b1348c229c67e2bad24e273ec9a7fc29771e18c5.camel@intel.com>
Message-ID: <aG1dbD2Xnpi_Cqf_@google.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Vishal Annapurve <vannapurve@google.com>, "pvorel@suse.cz" <pvorel@suse.cz>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	Jun Miao <jun.miao@intel.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>, 
	Kirill Shutemov <kirill.shutemov@intel.com>, "pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, 
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"tabba@google.com" <tabba@google.com>, "amoorthy@google.com" <amoorthy@google.com>, 
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "jack@suse.cz" <jack@suse.cz>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, 
	"keirf@google.com" <keirf@google.com>, 
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, Wei W Wang <wei.w.wang@intel.com>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "willy@infradead.org" <willy@infradead.org>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, Dave Hansen <dave.hansen@intel.com>, 
	"aik@amd.com" <aik@amd.com>, "usama.arif@bytedance.com" <usama.arif@bytedance.com>, 
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "fvdl@google.com" <fvdl@google.com>, 
	"rppt@kernel.org" <rppt@kernel.org>, "quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, 
	"maz@kernel.org" <maz@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"anup@brainfault.org" <anup@brainfault.org>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mic@digikod.net" <mic@digikod.net>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, Fan Du <fan.du@intel.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "steven.price@arm.com" <steven.price@arm.com>, 
	"muchun.song@linux.dev" <muchun.song@linux.dev>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, Zhiquan1 Li <zhiquan1.li@intel.com>, 
	"rientjes@google.com" <rientjes@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, 
	Erdem Aktas <erdemaktas@google.com>, "david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"hughd@google.com" <hughd@google.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, Haibo1 Xu <haibo1.xu@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>, 
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, "jarkko@kernel.org" <jarkko@kernel.org>, 
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
	"brauner@kernel.org" <brauner@kernel.org>, "roypat@amazon.co.uk" <roypat@amazon.co.uk>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "pgonda@google.com" <pgonda@google.com>, 
	"quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>, "hch@infradead.org" <hch@infradead.org>, 
	"will@kernel.org" <will@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 08, 2025, Rick P Edgecombe wrote:
> On Tue, 2025-07-08 at 10:16 -0700, Vishal Annapurve wrote:
> > > Right, I read that. I still don't see why pKVM needs to do normal
> > > private/shared
> > > conversion for data provisioning. Vs a dedicated operation/flag to ma=
ke it a
> > > special case.
> >=20
> > It's dictated by pKVM usecases, memory contents need to be preserved
> > for every conversion not just for initial payload population.
>=20
> We are weighing pros/cons between:
>  - Unifying this uABI across all gmemfd VM types
>  - Userspace for one VM type passing a flag for it's special non-shared u=
se case
>=20
> I don't see how passing a flag or not is dictated by pKVM use case.

Yep.  Baking the behavior of a single usecase into the kernel's ABI is rare=
ly a
good idea.  Just because pKVM's current usecases always wants contents to b=
e
preserved doesn't mean that pKVM will never change.

As a general rule, KVM should push policy to userspace whenever possible.

> P.S. This doesn't really impact TDX I think. Except that TDX development =
needs
> to work in the code without bumping anything. So just wishing to work in =
code
> with less conditionals.
>=20
> >=20
> > >=20
> > > I'm trying to suggest there could be a benefit to making all gmem VM =
types
> > > behave the same. If conversions are always content preserving for pKV=
M, why
> > > can't userspace=C2=A0 always use the operation that says preserve con=
tent? Vs
> > > changing the behavior of the common operations?
> >=20
> > I don't see a benefit of userspace passing a flag that's kind of
> > default for the VM type (assuming pKVM will use a special VM type).
>=20
> The benefit is that we don't need to have special VM default behavior for
> gmemfd. Think about if some day (very hypothetical and made up) we want t=
o add a
> mode for TDX that adds new private data to a running guest (with special =
accept
> on the guest side or something). Then we might want to add a flag to over=
ride
> the default destructive behavior. Then maybe pKVM wants to add a "don't
> preserve" operation and it adds a second flag to not destroy. Now gmemfd =
has
> lots of VM specific flags. The point of this example is to show how unifi=
ed uABI
> can he helpful.

Yep again. Pivoting on the VM type would be completely inflexible.  If pKVM=
 gains
a usecase that wants to zero memory on conversions, we're hosed.  If SNP or=
 TDX
gains the ability to preserve data on conversions, we're hosed.

The VM type may restrict what is possible, but (a) that should be abstracte=
d,
e.g. by defining the allowed flags during guest_memfd creation, and (b) the
capabilities of the guest_memfd instance need to be communicated to userspa=
ce.
=20
> > Common operations in guest_memfd will need to either check for the
> > userspace passed flag or the VM type, so no major change in
> > guest_memfd implementation for either mechanism.
>=20
> While we discuss ABI, we should allow ourselves to think ahead. So, is a =
gmemfd
> fd tied to a VM?

Yes.

> I think there is interest in de-coupling it?

No?  Even if we get to a point where multiple distinct VMs can bind to a si=
ngle
guest_memfd, e.g. for inter-VM shared memory, there will still need to be a=
 sole
owner of the memory.  AFAICT, fully decoupling guest_memfd from a VM would =
add
non-trivial complexity for zero practical benefit.

> Is the VM type sticky?
>=20
> It seems the more they are separate, the better it will be to not have VM=
-aware
> behavior living in gmem.

Ya.  A guest_memfd instance may have capabilities/features that are restric=
ted
and/or defined based on the properties of the owning VM, but we should do o=
ur
best to make guest_memfd itself blissly unaware of the VM type.

