Return-Path: <linux-fsdevel+bounces-49513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 689D8ABDBF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 16:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 466877B1E62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0742472AB;
	Tue, 20 May 2025 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="192zBdId"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780741CCEE7
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750293; cv=none; b=WOB60L7inq1Dt8qreeUEaMhpcY8W+j4XMH6CfIorDgsW2JTjyVj5wg3LFaWyctKXQDosS5kvE1YnfuWv2Qqm6Vlin4GfvoT0PGnZsZmFL3wYYWr9M/8ZjVKmP3L3LbvWuRH6hlxAmvZ8K6cNk+/7CiE+H8RayEPsZVh71j0iyI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750293; c=relaxed/simple;
	bh=IwGc2NrI2G4RtTLHpTIRCtdhQkLKhhGOiCGwGPHrVpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVTU/K1lQfzdneemZ6FjPAlD7svIV58Fet6sx66brsiJi/gIJSH5yMVZ4LjbOTq/WFRBNnH5N0U3tDgvcmjLVfCkTbnO1X9MjOaHd1o16OrGcPIhFypwN5BBrzX5rGC5Rk4Ow2oLwxlflMRTCB5ANdbcXBAY4vVg5bfIrNNlESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=192zBdId; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-231ba6da557so532965ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747750291; x=1748355091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0V2ESEDZyNB2h5dvIwZaMO3TFNNthEGeGHcq7PS6fo=;
        b=192zBdIdgKxXO2r+y9SsVACeQHKrmHf5fZBcD8sXXtxreRIbAf/kg21Vq/gyyTfIPE
         lKy6b5FEbIS4bbcPjVqmIWdF5M/9uR7EK0DkILKRmbXRlQ2mGrm8Rbz4tRqx3IaWtX5n
         h3ooCFON/Fh4P+fw1OLzO39fZEHAYrlhFIi5qL4WVYqRrVq3bMH8H9z5Uetuffg6UaMi
         OCteukQQJSqJEUbgw7tDXMBdr+1YpXGGdIgmPkr9Bu5JSGFJv8td8ruY/09/vfsPnWSa
         +0pjeaWYAGfNHLNG3m17UOo4LYWNGXTXuHA07+Bpe4R1xJ6vDF3lMBkP++MoNex+z+Xt
         1s8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747750291; x=1748355091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0V2ESEDZyNB2h5dvIwZaMO3TFNNthEGeGHcq7PS6fo=;
        b=fdoz8IPOc4t0V9J86AxxexAkXf7k6d4QTYca4oBWudsbvxTYmVWjLhLpdIDL4MYhAn
         knWF9hqos3tTwVdMeZKDJ4GqhPngf46PsMHnWNgafqSIlolv3uogTMQ4UPI5kJQ6BbKd
         +8ehvo5AEn2kTUHLyyO3nps10q9QT8dW1aPZrH3YHq9Ge8ZWd1Po0aWiwbrrQhgv/fIV
         wheK5F8zWRPysjLhSGI0lSBTaNbGF4TIkHS6PYiAlLX873PR2/cttDy/IomHaqq5YHo/
         tre0FKqZP74hEPWZzi8nLjLWLzxIFjwOm+6M8RkyCdXbqEoCUrdsqbWrL6XHARigYdwt
         /57g==
X-Forwarded-Encrypted: i=1; AJvYcCWKM5Q5ookTmznzXmbQgQjOyrX6EMSXF8gbTTLgm0EapqJU2MlTtF5v3nu5a79Cyevk3XlyUH8IgD2VJNcA@vger.kernel.org
X-Gm-Message-State: AOJu0YyvFjM4R3lyTJCfwjQQkGKFApxc5hfT4DaQMb7L9ItJBlq4dkLp
	s3MdlfXljPjZpQK/1m8pTc9pA8ONXvAmBcqAeRkJFB4c1LqkYV6c6fwHMGgUpip5iV7RBAuo1n7
	TGbSGp/aFuiD3dSehGLxpOveBrsVLUcL7eGRQNmAd
X-Gm-Gg: ASbGnctezU4iJEVp/4iOxb3JbUWXpqRoDLTWouni1wcYPtw+Tanu8RzYTI2hzMmAT5m
	MUaO6EzABExMq4ebbpUPWlyTUhe9wKhtc+6gG2O2GHtRbqd0ALy77sRF+AEZ9uoVcburPGM9NBP
	LzLZ8/tt/DfwE3iPgOE5qWVn+zbG2rKtyrHRtMHyS9eXAU5Rreo9MMNajs9f0Fa23cxidZTDUdw
	obw8dgZgEsct4I=
X-Google-Smtp-Source: AGHT+IHZOvULWQMabZ1/iUJRuXlrpoOaAagjIY7TcYaquuzrKcD3XGch+6LvlFv8i9o0JrVmoU1rYJj46EvyHPibmqA=
X-Received: by 2002:a17:903:1b6c:b0:223:f479:3860 with SMTP id
 d9443c01a7336-231ffdc5bb1mr8356255ad.18.1747750290129; Tue, 20 May 2025
 07:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
 <CA+EHjTxtHOgichL=UvAzczoqS1608RSUNn5HbmBw2NceO941ng@mail.gmail.com>
 <CAGtprH8eR_S50xDnnMLHNCuXrN2Lv_0mBRzA_pcTtNbnVvdv2A@mail.gmail.com> <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com>
In-Reply-To: <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 20 May 2025 07:11:17 -0700
X-Gm-Features: AX0GCFsMvcqcyDCpl08egts_Rk9tmZhsChEdmC9Tx1PSj0Hg70TFTxOoW40ga_M
Message-ID: <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
To: Fuad Tabba <tabba@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org, 
	aik@amd.com, ajones@ventanamicro.com, akpm@linux-foundation.org, 
	amoorthy@google.com, anthony.yznaga@oracle.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, bfoster@redhat.com, binbin.wu@linux.intel.com, 
	brauner@kernel.org, catalin.marinas@arm.com, chao.p.peng@intel.com, 
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com, 
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, graf@amazon.com, haibo1.xu@intel.com, 
	hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org, 
	willy@infradead.org, xiaoyao.li@intel.com, yan.y.zhao@intel.com, 
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 6:44=E2=80=AFAM Fuad Tabba <tabba@google.com> wrote=
:
>
> Hi Vishal,
>
> On Tue, 20 May 2025 at 14:02, Vishal Annapurve <vannapurve@google.com> wr=
ote:
> >
> > On Tue, May 20, 2025 at 2:23=E2=80=AFAM Fuad Tabba <tabba@google.com> w=
rote:
> > >
> > > Hi Ackerley,
> > >
> > > On Thu, 15 May 2025 at 00:43, Ackerley Tng <ackerleytng@google.com> w=
rote:
> > > >
> > > > The two new guest_memfd ioctls KVM_GMEM_CONVERT_SHARED and
> > > > KVM_GMEM_CONVERT_PRIVATE convert the requested memory ranges to sha=
red
> > > > and private respectively.
> > >
> > > I have a high level question about this particular patch and this
> > > approach for conversion: why do we need IOCTLs to manage conversion
> > > between private and shared?
> > >
> > > In the presentations I gave at LPC [1, 2], and in my latest patch
> > > series that performs in-place conversion [3] and the associated (by
> > > now outdated) state diagram [4], I didn't see the need to have a
> > > userspace-facing interface to manage that. KVM has all the informatio=
n
> > > it needs to handle conversions, which are triggered by the guest. To
> > > me this seems like it adds additional complexity, as well as a user
> > > facing interface that we would need to maintain.
> > >
> > > There are various ways we could handle conversion without explicit
> > > interference from userspace. What I had in mind is the following (as
> > > an example, details can vary according to VM type). I will use use th=
e
> > > case of conversion from shared to private because that is the more
> > > complicated (interesting) case:
> > >
> > > - Guest issues a hypercall to request that a shared folio become priv=
ate.
> > >
> > > - The hypervisor receives the call, and passes it to KVM.
> > >
> > > - KVM unmaps the folio from the guest stage-2 (EPT I think in x86
> > > parlance), and unmaps it from the host. The host however, could still
> > > have references (e.g., GUP).
> > >
> > > - KVM exits to the host (hypervisor call exit), with the information
> > > that the folio has been unshared from it.
> > >
> > > - A well behaving host would now get rid of all of its references
> > > (e.g., release GUPs), perform a VCPU run, and the guest continues
> > > running as normal. I expect this to be the common case.
> > >
> > > But to handle the more interesting situation, let's say that the host
> > > doesn't do it immediately, and for some reason it holds on to some
> > > references to that folio.
> > >
> > > - Even if that's the case, the guest can still run *. If the guest
> > > tries to access the folio, KVM detects that access when it tries to
> > > fault it into the guest, sees that the host still has references to
> > > that folio, and exits back to the host with a memory fault exit. At
> > > this point, the VCPU that has tried to fault in that particular folio
> > > cannot continue running as long as it cannot fault in that folio.
> >
> > Are you talking about the following scheme?
> > 1) guest_memfd checks shareability on each get pfn and if there is a
> > mismatch exit to the host.
>
> I think we are not really on the same page here (no pun intended :) ).
> I'll try to answer your questions anyway...
>
> Which get_pfn? Are you referring to get_pfn when faulting the page
> into the guest or into the host?

I am referring to guest fault handling in KVM.

>
> > 2) host user space has to guess whether it's a pending refcount or
> > whether it's an actual mismatch.
>
> No need to guess. VCPU run will let it know exactly why it's exiting.
>
> > 3) guest_memfd will maintain a third state
> > "pending_private_conversion" or equivalent which will transition to
> > private upon the last refcount drop of each page.
> >
> > If conversion is triggered by userspace (in case of pKVM, it will be
> > triggered from within the KVM (?)):
>
> Why would conversion be triggered by userspace? As far as I know, it's
> the guest that triggers the conversion.
>
> > * Conversion will just fail if there are extra refcounts and userspace
> > can try to get rid of extra refcounts on the range while it has enough
> > context without hitting any ambiguity with memory fault exit.
> > * guest_memfd will not have to deal with this extra state from 3 above
> > and overall guest_memfd conversion handling becomes relatively
> > simpler.
>
> That's not really related. The extra state isn't necessary any more
> once we agreed in the previous discussion that we will retry instead.

Who is *we* here? Which entity will retry conversion?

>
> > Note that for x86 CoCo cases, memory conversion is already triggered
> > by userspace using KVM ioctl, this series is proposing to use
> > guest_memfd ioctl to do the same.
>
> The reason why for x86 CoCo cases conversion is already triggered by
> userspace using KVM ioctl is that it has to, since shared memory and
> private memory are two separate pages, and userspace needs to manage
> that. Sharing memory in place removes the need for that.

Userspace still needs to clean up memory usage before conversion is
successful. e.g. remove IOMMU mappings for shared to private
conversion. I would think that memory conversion should not succeed
before all existing users let go of the guest_memfd pages for the
range being converted.

In x86 CoCo usecases, userspace can also decide to not allow
conversion for scenarios where ranges are still under active use by
the host and guest is erroneously trying to take away memory. Both
SNP/TDX spec allow failure of conversion due to in use memory.

>
> This series isn't using the same ioctl, it's introducing new ones to
> perform a task that as far as I can tell so far, KVM can handle by
> itself.

I would like to understand this better. How will KVM handle the
conversion process for guest_memfd pages? Can you help walk an example
sequence for shared to private conversion specifically around
guest_memfd offset states?

>
> >  - Allows not having to keep track of separate shared/private range
> > information in KVM.
>
> This patch series is already tracking shared/private range information in=
 KVM.
>
> >  - Simpler handling of the conversion process done per guest_memfd
> > rather than for full range.
> >      - Userspace can handle the rollback as needed, simplifying error
> > handling in guest_memfd.
> >  - guest_memfd is single source of truth and notifies the users of
> > shareability change.
> >      - e.g. IOMMU, userspace, KVM MMU all can be registered for
> > getting notifications from guest_memfd directly and will get notified
> > for invalidation upon shareability attribute updates.
>
> All of these can still be done without introducing a new ioctl.
>
> Cheers,
> /fuad

