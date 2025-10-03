Return-Path: <linux-fsdevel+bounces-63383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C84C2BB7736
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 18:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DC194ED995
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB1E2BE05E;
	Fri,  3 Oct 2025 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GGbVIeJ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7396729D26D
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507561; cv=none; b=dr/6Nqkgg2SUhxkokyl/vtiTN9xPpJgC1BvPhGi/8ng6zkmUSsBD0aA7dbRgq8RQjFUGlzjVwSaBKCdd+4sdBiP9BwsuF3Q1YUdSBkRsgaRbIKF/CnPv7NxY0UU7v2Nr5nd6UNTa2DUq51GWW8pGZVspSbGFBXeqKnrw0PmvPZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507561; c=relaxed/simple;
	bh=DTBd9BA1usFwsidcGi2Him6mYDP+NXsirmy/wzo3TNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YgxO1M4cmH12rSOAfmqNKau2RITe2YQ3tfqOX743wC9oCBOviHuoBVzYzdEvo0IrxYvjuJHZW9HyecCXbA3+tbO5KR+/DE5KBbKPr588nUANq1n0xb3aAZSapjKhdPW2irfXiedoAWkKjnOV/V59N2MWSieBAA6LlxEMV9fbcMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GGbVIeJ+; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7810af03a63so4175414b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 09:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759507558; x=1760112358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr9Zgpsr/95Zre8MDjbJaLg4HUOz/eRCvS4su6KFtWM=;
        b=GGbVIeJ+vE7oLl3nM4aFJxtZeiVigNAZo5SXEoASC2hi2+6uG9rQ5rju9ctEBKh1CP
         8WqwNT3ZVB6kJQJIZ997bsx3axb35sQ+KqY6Ck2DE4z/MJOtm2fD53gA5R3mtvUnRh7x
         Uw03A+o7JHCyGhiD/9yCKXSDiWbpVyd9hNjjim5UAEJvVoSU5g+dBtQk0niU8SwxgRhL
         P9md2oCHp/CYJLykveHKZsESBxjAyWlWW8IuXIRibPaUyI1L1A5njME3qfADIkKQw9sh
         3Ej8ChselCtkl/LX7bYr2LzhORKWJiWwSQudvWPg6WtN22azb1Mh7rf4TATxNpNIp/j3
         YDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759507558; x=1760112358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr9Zgpsr/95Zre8MDjbJaLg4HUOz/eRCvS4su6KFtWM=;
        b=QC6RcdmQCPyen3hOYiJwqdf1bB8wiyd+FUplS7Cv/HHxozpaXVBkqkWFmB1MN+EbEo
         Mv3CfqE6PX46DjorJx96J+AT3a0FGTpG7+gVhCOt613w0J1OgbJL+ashqR4UaeZkrogW
         BUbf6DeUtrNR1G14d8Xha1lyQLnQNiZEhoYFHj1JmunUqbcmrOh04g67jKq1Dt7eUc3S
         Tv5ryfuazhIfAdlJc+XE2Tf8rrqaeP9VYqwSducvIaJUcyE2skuqGyMkR3yRaH5Jv3Wb
         /dC+uc71JbHKRVvJ2b97Sx/14aJv/Y+xKpiPrKq9gdhduLqJpcrH/yrQBxNUqhbi3JTs
         rg8w==
X-Forwarded-Encrypted: i=1; AJvYcCXq2w6RtxUHSRm6m9kc59im9sltF4hUhpzz7psbgMjt8oNaQgZ98kuN+tqfUjeg+7Mbby4+BMUg+wNd5xo+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/0p/cb2BkUHcrJzCySfs0/Sw9SLEk71BskULNtt/TTznGiZcD
	oFdmWB0TTEpeyRVfrmKrkJgynZ2YvCHRXe6p/D5+8DbJeOYBDcijGPUuGRzT74b/ivUrhn952x8
	BcgFQ6Q==
X-Google-Smtp-Source: AGHT+IGkAn/LwerysZuGwJxYNVKUT2Gz4Ib8pIhMx4SKsJOPx+xTCSenhBS2G7GLP8kza9/oaz73nVHnf4c=
X-Received: from pgct2.prod.google.com ([2002:a05:6a02:5282:b0:b55:135:7cb9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3ca8:b0:245:fb85:ef69
 with SMTP id adf61e73a8af0-32b620cbda2mr5197670637.40.1759507558303; Fri, 03
 Oct 2025 09:05:58 -0700 (PDT)
Date: Fri, 3 Oct 2025 09:05:56 -0700
In-Reply-To: <aN_fJEZXo6wkcHOh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <b3c2da681c5bf139e2eaf0ea82c7422f972f6288.1747264138.git.ackerleytng@google.com>
 <aN_fJEZXo6wkcHOh@google.com>
Message-ID: <aN_0ZMduyGlX0QwU@google.com>
Subject: Re: [RFC PATCH v2 29/51] mm: guestmem_hugetlb: Wrap HugeTLB as an
 allocator for guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, kirill.shutemov@intel.com, liam.merwick@oracle.com, 
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
	rppt@kernel.org, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 03, 2025, Sean Christopherson wrote:
> On Wed, May 14, 2025, Ackerley Tng wrote:
> > guestmem_hugetlb is an allocator for guest_memfd. It wraps HugeTLB to
> > provide huge folios for guest_memfd.
> > 
> > This patch also introduces guestmem_allocator_operations as a set of
> > operations that allocators for guest_memfd can provide. In a later
> > patch, guest_memfd will use these operations to manage pages from an
> > allocator.
> > 
> > The allocator operations are memory-management specific and are placed
> > in mm/ so key mm-specific functions do not have to be exposed
> > unnecessarily.
> 
> This code doesn't have to be put in mm/, all of the #includes are to <linux/xxx.h>.
> Unless I'm missing something, what you actually want to avoid is _exporting_ mm/
> APIs, and for that all that is needed is ensure the code is built-in to the kernel
> binary, not to kvm.ko.
> 
> diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
> index d047d4cf58c9..c18c77e8a638 100644
> --- a/virt/kvm/Makefile.kvm
> +++ b/virt/kvm/Makefile.kvm
> @@ -13,3 +13,5 @@ kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
>  kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
>  kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
>  kvm-$(CONFIG_KVM_GUEST_MEMFD) += $(KVM)/guest_memfd.o
> +
> +obj-$(subst m,y,$(CONFIG_KVM_GUEST_MEMFD)) += $(KVM)/guest_memfd_hugepages.o
> \ No newline at end of file
> 
> People may want the code to live in mm/ for maintenance and ownership reasons
> (or not, I haven't followed the discussions on hugepage support), but that's a
> very different justification than what's described in the changelog.
> 
> And if the _only_ user is guest_memfd, putting this in mm/ feels quite weird.
> And if we anticipate other users, the name guestmem_hugetlb is weird, because
> AFAICT there's nothing in here that is in any way guest specific, it's just a
> few APIs for allocating and accounting hugepages.
> 
> Personally, I don't see much point in trying to make this a "generic" library,
> in quotes because the whole guestmem_xxx namespace makes it anything but generic.
> I don't see anything in mm/guestmem_hugetlb.c that makes me go "ooh, that's nasty,
> I'm glad this is handled by a library".  But if we want to go straight to a
> library, it should be something that is really truly generic, i.e. not "guest"
> specific in any way.

Ah, the complexity and the mm-internal dependencies come along in the splitting
and merging patch.  Putting that code in mm/ makes perfect sense, but I'm still
not convinced that putting _all_ of this code in mm/ is the correct split.

As proposed, this is a weird combination of being an extension of guest_memfd, a
somewhat generic library, _and_ a subsystem (e.g. the global workqueue and stash).

_If_ we need a library, then IMO it should be a truly generic library.  Any pieces
that are guest_memfd specific belong in KVM.  And any subsystem-like things should
should probably be implemented as an extension to HugeTLB itself, which is already
it's own subsytem.  Emphasis on "if", because it's not clear to me that that a
library is warranted.

AFAICT, the novelty here is the splitting and re-merging of hugetlb folios, and
that seems like it should be explicitly an extension of the hugetlb subsystem.
E.g. that behavior needs to take hugetlb_lock, interact with global vmemmap state
like hugetlb_optimize_vmemmap_key, etc.  If that's implemented as something like
hugetlb_splittable.c or whatever, and wired up to be explicitly configured via
hugetlb_init(), then there may not be much left for a library.

