Return-Path: <linux-fsdevel+bounces-49174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D98AB8F3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 20:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285F99E277F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 18:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B963289373;
	Thu, 15 May 2025 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MN3jb+Dp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B5C26A1B1
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747334577; cv=none; b=biESZYqlkVBwyBcd8FuWwyAR8yqOXymQjzYOGm9JNb7yOUB/2BvXmj2DCDoHL5MKT4X4jj+jarqZD56tWSPaEPHB89cSdIc6uJaErptNMpdmZ7CzN9j02yphVriIP4KnbU0cQO4LmGfLM9LQ54/bKflXGvM1DRSTlHPhege8zOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747334577; c=relaxed/simple;
	bh=OE706X3jddYBbsCzcihcsNrO+b6byFOlN93t1s1rrXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qaG7DIRNzps7DMxPyrtumEvP3wpKgj8kd2DGOTWccCs1hEJl2Ue1wxmVJ2rTPoPmNqlolIZ3+vQXZRPLSw8pmduSBDZ8YFlIsUyPbPvkpjnjCmiKBIr9l+R5N9T7JJ1lAmNklYh6jrk48lBWUX43WT4DQOr+swF4+dKD9sS2W4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MN3jb+Dp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231ba6da557so23335ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 11:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747334575; x=1747939375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OE706X3jddYBbsCzcihcsNrO+b6byFOlN93t1s1rrXY=;
        b=MN3jb+DpQ+CFs3nV8xA7pSHZDs9ezl8ebaNuw7CbKcu2llW+DFVW5mOVA0qNP1h2uu
         q/nxcZdWxhITquO2EHDp8xstq6Aau0JZmoZWY2OQu/wTWPWDUUP+OKTZDDIt2xYS7YXN
         Y6rDslP2LlrpMknORXlRwi18rK/8Xt0tlvdPUq1y2SLO3sBeC5V1ckmORvdq6WvWbPrm
         k/VF6UgSg4ml9oSexk+ICP0xYgGLu4DfhBSUXRfTn51pzB1vkxsFJndmlco0fXUskgGr
         szt5zaNHz1e3Xpl6J/FPkZeJH5lG4o1+7K7YxMeOBplda3hTPRJYpGzASyKXtFd2uMfH
         q3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747334575; x=1747939375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OE706X3jddYBbsCzcihcsNrO+b6byFOlN93t1s1rrXY=;
        b=uGWdTrrI6gzgZiOpNwi+EIeqAgeC2EKeoGD6yukZ5NqgL7pEXMdSjwIbaT+KUKvAhu
         e8J22bXFsKJr9gLBa9OnZbScE852lqpoZVCYf8125Og/6FQnNV90QHTsXyv+o4uqIcEE
         0CAm5AH8Ce03+y8V4g7dg/clB9gyTgeFCNe6IrQTO+SmaS64uwTwJN+pTCnPTvF6nBUP
         dHbwpL3XBsPkCA8oW+Yg0gfxgSXmiQfK168BrzFDMLOzQ3+T13DQr7acXEVUaBL7TWv+
         nBNiooydTNVPPt1Dl6IlzX6tSl/WOpE7KlHWOavbA0MvfrfDCfcqQIxWDy5QYkU3PWrt
         ECrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdX8+ycdJU70Zb84cKYNZIbrs1co06QOCgp/jXBtv3ZHcOx/fyL07FPIurFZjg8sa2bczHp6L1Bpp9y75F@vger.kernel.org
X-Gm-Message-State: AOJu0YxzFr7xValtuHpSbQ3K2/3CMna9WhGq6hDDHcGwI4DiiuFmBMq9
	yXNMnGszMHUylchud86+D+T/uXw12vg2vhx0v30JMAs4NZ/lkGyl8wN12a4VuupfWXHVuor6UZJ
	t8y1q9EiCip3R1szp/DgHq1wUr4Zn252wwRK4Y6rF
X-Gm-Gg: ASbGncuOh64y2cnxSNLTDdIC+LUwh33p9giGPJQXrB7YSrwboPGsZ+JQaLsyFy7Tedu
	FL+t27aroCU5XERH/mc2cGFe3ASGHKJh9nPK24tYfWRVj8I7Bp/bkUwmE0g8edk3+Yt+TE3TvRv
	NcuMVUk3EtIm+ko7qI4twHZLloTNfYQ8T9goD7TlJP9j3+HoD5tZJeKfI5l4mlMCU=
X-Google-Smtp-Source: AGHT+IGTq3Qv35p4EQDVKyuQpdaEqwPis17PY14p3nnamKgz6JsccKxsXhBauQW2GGY2ychs+aiWiE3WzGrkhDw7670=
X-Received: by 2002:a17:903:3b86:b0:215:65f3:27ef with SMTP id
 d9443c01a7336-231b492239amr3491205ad.12.1747334574890; Thu, 15 May 2025
 11:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <ada87be8b9c06bc0678174b810e441ca79d67980.camel@intel.com>
In-Reply-To: <ada87be8b9c06bc0678174b810e441ca79d67980.camel@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 15 May 2025 11:42:43 -0700
X-Gm-Features: AX0GCFtFPmb6VMVpripLOpX9FHawevhToT7FohCfCgdNjLdWb4V3SRl6QrbKhds
Message-ID: <CAGtprH9CTsVvaS8g62gTuQub4aLL97S7Um66q12_MqTFoRNMxA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "ackerleytng@google.com" <ackerleytng@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "pvorel@suse.cz" <pvorel@suse.cz>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "Miao, Jun" <jun.miao@intel.com>, 
	"Shutemov, Kirill" <kirill.shutemov@intel.com>, "pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, 
	"steven.price@arm.com" <steven.price@arm.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "jack@suse.cz" <jack@suse.cz>, 
	"amoorthy@google.com" <amoorthy@google.com>, "maz@kernel.org" <maz@kernel.org>, 
	"keirf@google.com" <keirf@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, 
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, "hughd@google.com" <hughd@google.com>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, "Wang, Wei W" <wei.w.wang@intel.com>, 
	"Du, Fan" <fan.du@intel.com>, 
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, 
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>, "aik@amd.com" <aik@amd.com>, 
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>, 
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "fvdl@google.com" <fvdl@google.com>, 
	"rppt@kernel.org" <rppt@kernel.org>, "quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, 
	"bfoster@redhat.com" <bfoster@redhat.com>, "willy@infradead.org" <willy@infradead.org>, 
	"anup@brainfault.org" <anup@brainfault.org>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"tabba@google.com" <tabba@google.com>, "mic@digikod.net" <mic@digikod.net>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>, 
	"Li, Zhiquan1" <zhiquan1.li@intel.com>, "rientjes@google.com" <rientjes@google.com>, 
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "Xu, Haibo1" <haibo1.xu@intel.com>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "will@kernel.org" <will@kernel.org>, 
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
	"pgonda@google.com" <pgonda@google.com>, "quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>, 
	"hch@infradead.org" <hch@infradead.org>, "roypat@amazon.co.uk" <roypat@amazon.co.uk>, 
	"seanjc@google.com" <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 11:03=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Wed, 2025-05-14 at 16:41 -0700, Ackerley Tng wrote:
> > Hello,
> >
> > This patchset builds upon discussion at LPC 2024 and many guest_memfd
> > upstream calls to provide 1G page support for guest_memfd by taking
> > pages from HugeTLB.
>
> Do you have any more concrete numbers on benefits of 1GB huge pages for
> guestmemfd/coco VMs? I saw in the LPC talk it has the benefits as:
> - Increase TLB hit rate and reduce page walks on TLB miss
> - Improved IO performance
> - Memory savings of ~1.6% from HugeTLB Vmemmap Optimization (HVO)
> - Bring guest_memfd to parity with existing VMs that use HugeTLB pages fo=
r
> backing memory
>
> Do you know how often the 1GB TDP mappings get shattered by shared pages?
>
> Thinking from the TDX perspective, we might have bigger fish to fry than =
1.6%
> memory savings (for example dynamic PAMT), and the rest of the benefits d=
on't
> have numbers. How much are we getting for all the complexity, over say bu=
ddy
> allocated 2MB pages?

This series should work for any page sizes backed by hugetlb memory.
Non-CoCo VMs, pKVM and Confidential VMs all need hugepages that are
essential for certain workloads and will emerge as guest_memfd users.
Features like KHO/memory persistence in addition also depend on
hugepage support in guest_memfd.

This series takes strides towards making guest_memfd compatible with
usecases where 1G pages are essential and non-confidential VMs are
already exercising them.

I think the main complexity here lies in supporting in-place
conversion which applies to any huge page size even for buddy
allocated 2MB pages or THP.

This complexity arises because page structs work at a fixed
granularity, future roadmap towards not having page structs for guest
memory (at least private memory to begin with) should help towards
greatly reducing this complexity.

That being said, DPAMT and huge page EPT mappings for TDX VMs remain
essential and complement this series well for better memory footprint
and overall performance of TDX VMs.

