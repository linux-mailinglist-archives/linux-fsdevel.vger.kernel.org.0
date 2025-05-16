Return-Path: <linux-fsdevel+bounces-49288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB62EABA238
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 19:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B544E3331
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5541227467D;
	Fri, 16 May 2025 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2MxE7jt3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCA221D584
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417914; cv=none; b=tq98nIx70KhMt/DqeVmokizy/JIXf7ZUXVgW5D5MDEwg0Q+IcpkbSpZ8aj3doNjEbZtUD3PiP70EEUaUHZKx/YYSs+BwypxHOgJvFt95DeA6KNm3VFP7qz6dsTAnQR5bHUXUP7fGPJ3YZfqLss8wkuIjQIs40kcmutsy/GZ4m5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417914; c=relaxed/simple;
	bh=2Q3t7q7zXPiO9TUpc46lPD0ZwFpz2ZIFeKkfnFOyL64=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oCiDOq6isLCWUn0v/RTvCCDa6b2e/ji0uYoGAxhtm8yGcCG875iOFr5EwdF2sUPJuQ+NCzv1E0lp/2UxI7JZB1KpcuMZqhkaL9qTX4aHSWL+7+m0NFLpMGs2jfeZWoSlyBh7p96ESTZwzPyMYYG6By40p4koN3bnQdySdO5VbJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2MxE7jt3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e2bd11716so2486620a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 10:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747417913; x=1748022713; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V5HQp6kq+X9VHvMiTR+cwYmP5qs8g8pvYOQWqNMSHLc=;
        b=2MxE7jt3/l2kPcTP99300XQsP3CrdPcI/lIcQ8VXQFCJnghl6uhgJwoWPyX2ZX49Uu
         4Jf8ioEs4tGJurSTVzj2OZPUv4kReaU7QdBm+x3isBLStQxUK/kuyBYQsXPEgcmwpxtz
         XdBQgQ02jGSVqmgZPiMCPfiNPMR1Bw9SGtN/mjly+uRw4IlBHNTD5ZYty5ZtNjQS8KPk
         W9NvQ60UA20+2YRzyPx/ynDdZfjNYl2I1FUJluMfJvdrr8OPI5HhGwPTA2q08MZa5B1o
         DJBHzz0SahkXQ7nUgZX08HA7guAxJtMfnLNbaHa/TgkrAUeZFzCZj8mA/maAQ+dBoxpH
         WaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747417913; x=1748022713;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5HQp6kq+X9VHvMiTR+cwYmP5qs8g8pvYOQWqNMSHLc=;
        b=Vgs5Ze+9BFPihdoXYnvOuw0CtMWCoZIJg/diPH/fdfv0Zg5zSFgHF6yE6Bmb22SK0Q
         5pKdf4jnviuFVa3mwSnitHXcFHGzwJZdGfflBLZvYMVqJtCLYR8dgfdTjqs+PfhzY0ki
         ZqSuvkob/CB/Q7M+gzIdo9QxhPjqKgY2xW1mWJtWJEVP26VBIls/ikNIPXM0EwEHUDiK
         b16ezdZUUcbVfp94AxIYBGYrHIWyzQm9b19kYvQCjMNJiYYnrWm5uoiwJsmUAmmrmz+h
         AQK5wc6OZsqK/lCGjobNeO+T+etYAQUp1eT+WU7jTYwFHze+UilmYtkjM74frpZKgHEP
         Tm1g==
X-Forwarded-Encrypted: i=1; AJvYcCUsPe48QNAZvYykid/uQpCVO1JfOALSArTGQXFp5MphwEBFEAr7TELj4Xi52IUrDtPXYi/WHfpKWgXVQelW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlk8T51cJ0M+Q/7iu9GJ86seP1oqUgJTevZOo1L3TkZZCx48bU
	fkWBjh9sNTcnljWwwTeq8iYGi9pXl0e14uUY+BSsTOFoMOJ07Kuo3OJddfX3ZWhzFv8lJtpwJDP
	pUlvctg==
X-Google-Smtp-Source: AGHT+IFwtvvhEW33lcn8I0JC2VzVOUh9GPDEpoRuyJJmzbZM79EJn+UNnUU3HQ0UiE4FGqM+5/rqg3sdCXQ=
X-Received: from pjyd7.prod.google.com ([2002:a17:90a:dfc7:b0:2ff:5752:a78f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b45:b0:30e:823f:ef21
 with SMTP id 98e67ed59e1d1-30e83228e05mr4391414a91.32.1747417912343; Fri, 16
 May 2025 10:51:52 -0700 (PDT)
Date: Fri, 16 May 2025 10:51:50 -0700
In-Reply-To: <ce15353884bd67cc2608d36ef40a178a8d140333.camel@intel.com>
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
 <CAGtprH8EMnmvvVir6_U+L5S3SEvrU1OzLrvkL58fXgfg59bjoA@mail.gmail.com> <ce15353884bd67cc2608d36ef40a178a8d140333.camel@intel.com>
Message-ID: <aCd5wZ_Tp863I6pP@google.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Vishal Annapurve <vannapurve@google.com>, "pvorel@suse.cz" <pvorel@suse.cz>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	Jun Miao <jun.miao@intel.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"amoorthy@google.com" <amoorthy@google.com>, "jack@suse.cz" <jack@suse.cz>, "maz@kernel.org" <maz@kernel.org>, 
	"tabba@google.com" <tabba@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, 
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, "hughd@google.com" <hughd@google.com>, 
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, Wei W Wang <wei.w.wang@intel.com>, 
	"keirf@google.com" <keirf@google.com>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Yan Y Zhao <yan.y.zhao@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "rppt@kernel.org" <rppt@kernel.org>, 
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "aik@amd.com" <aik@amd.com>, 
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>, "fvdl@google.com" <fvdl@google.com>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
	"quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>, 
	"willy@infradead.org" <willy@infradead.org>, Fan Du <fan.du@intel.com>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "mic@digikod.net" <mic@digikod.net>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, Kirill Shutemov <kirill.shutemov@intel.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "steven.price@arm.com" <steven.price@arm.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>, 
	Zhiquan1 Li <zhiquan1.li@intel.com>, "rientjes@google.com" <rientjes@google.com>, 
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, Erdem Aktas <erdemaktas@google.com>, 
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"bfoster@redhat.com" <bfoster@redhat.com>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	Haibo1 Xu <haibo1.xu@intel.com>, "anup@brainfault.org" <anup@brainfault.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, "jthoughton@google.com" <jthoughton@google.com>, 
	"will@kernel.org" <will@kernel.org>, "steven.sistare@oracle.com" <steven.sistare@oracle.com>, 
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, "jarkko@kernel.org" <jarkko@kernel.org>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, 
	"pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, Chao P Peng <chao.p.peng@intel.com>, 
	"nikunj@amd.com" <nikunj@amd.com>, Alexander Graf <graf@amazon.com>, 
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
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hch@infradead.org" <hch@infradead.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 16, 2025, Rick P Edgecombe wrote:
> On Fri, 2025-05-16 at 06:11 -0700, Vishal Annapurve wrote:
> > Google internally uses 1G hugetlb pages to achieve high bandwidth IO,
> > lower memory footprint using HVO and lower MMU/IOMMU page table memory
> > footprint among other improvements. These percentages carry a
> > substantial impact when working at the scale of large fleets of hosts
> > each carrying significant memory capacity.
> 
> There must have been a lot of measuring involved in that. But the numbers I was
> hoping for were how much does *this* series help upstream.

...

> I asked this question assuming there were some measurements for the 1GB part of
> this series. It sounds like the reasoning is instead that this is how Google
> does things, which is backed by way more benchmarking than kernel patches are
> used to getting. So it can just be reasonable assumed to be helpful.
> 
> But for upstream code, I'd expect there to be a bit more concrete than "we
> believe" and "substantial impact". It seems like I'm in the minority here
> though. So if no one else wants to pressure test the thinking in the usual way,
> I guess I'll just have to wonder.

From my perspective, 1GiB hugepage support in guest_memfd isn't about improving
CoCo performance, it's about achieving feature parity on guest_memfd with respect
to existing backing stores so that it's possible to use guest_memfd to back all
VM shapes in a fleet.

Let's assume there is significant value in backing non-CoCo VMs with 1GiB pages,
unless you want to re-litigate the existence of 1GiB support in HugeTLBFS.

If we assume 1GiB support is mandatory for non-CoCo VMs, then it becomes mandatory
for CoCo VMs as well, because it's the only realistic way to run CoCo VMs and
non-CoCo VMs on a single host.  Mixing 1GiB HugeTLBFS with any other backing store
for VMs simply isn't tenable due to the nature of 1GiB allocations.  E.g. grabbing
sub-1GiB chunks of memory for CoCo VMs quickly fragments memory to the point where
HugeTLBFS can't allocate memory for non-CoCo VMs.

Teaching HugeTLBFS to play nice with TDX and SNP isn't happening, which leaves
adding 1GiB support to guest_memfd as the only way forward.

Any boost to TDX (or SNP) performance is purely a bonus.

