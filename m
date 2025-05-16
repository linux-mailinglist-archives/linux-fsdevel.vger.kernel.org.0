Return-Path: <linux-fsdevel+bounces-49206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 330A8AB9359
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 02:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283D6A06C4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 00:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F42B1D9346;
	Fri, 16 May 2025 00:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2ARgRjP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CCC1D63C0
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747357081; cv=none; b=Am1zwLr07oWAd36UrpfcEL0NMrnHKD+56sxulH9VTqCoHL9EdF9ULTyk6k+1HyQ0tCGHehLDSfQdYKN6q4ifyVBzk1NwAeOw0YXvCTMeXntN0Sm76bUnVVBhKFzkfqDnImbnz7f4Wo+CoO9BfGZ5MlYJle2vaegcB6uyt2LL3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747357081; c=relaxed/simple;
	bh=3ppwua9bFjJRrFYv+cawYE6r12fDV36bQr383ebS5Xo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DsLtgDhqTUBYJUcYfMEADnYYyg3n5y23cQLkbQzVBEfEJ2n64mRPwS43ABjDecA+erZ3v5bPGXWlRJ8pW4946PWN6bXMU0pzQbOAF6cq5t+zwC/rv8MItK9En6Z5dj75at1y+cnYJHDAxP8mRddbAQqW3Bqv1oIRfSuRCSuGdNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2ARgRjP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e86c46eadso49578a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 17:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747357079; x=1747961879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8/qY0LTEjs6FgRExW+zZPRu+s+HGdicfzCVV2cwKQ8=;
        b=E2ARgRjP9AExbmXZhlwAwh1qYyikRxlRMIZNb7lxNbrwOvSn2Dk0L7/s7IZdMhm5Cl
         WAr10vyJ6i5FWywUOzT84+RF1sBj2CcrRfCRiqfEPFVu/bKhxxOBIpU0GULyqUvPXfdg
         8ZLSnA01QFdmk9Gye4/urS7zfDPGOXH1s26kMN+4ozuAw2UWH2Vp9oeKenlrG0KfJ3Yi
         GJKGP5rJhxkiFY1rHiJYUX6yx7Nmu39JGXMF8nhGLL+p5qXlBSPkISxMnB1mqkcZp4rf
         C6fJE6lIBq/woOQtKmNRAtHCHKtJuEqZFmfS8Mnw44ajN2Cq1y1MBxZMn2o49kNU5KkZ
         sHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747357079; x=1747961879;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T8/qY0LTEjs6FgRExW+zZPRu+s+HGdicfzCVV2cwKQ8=;
        b=UGhdvirxKFh4Z3JKTgX+s7paa4b602Yoht+pcWNdRMu1XyRUOR81Ck3+nRghYdJm7N
         A9QAlMwJ03HGUhprTtEcjxL60RldTDwdrL8Hc5RjI2DwL8Qqxwi5xJISEOyylGmZMVC7
         TM2GlPK2nbchAyY+e8oA5/iRk3NSFElO4ggKvMEK5XL9heH7JuGCsW/Ba3ox0z8NbsCN
         mCv4CTQ07Ii3ouedhxbm2u/DNGv05PRzi9IO7KvPOlHxPVWhNHT7F6UN74Jqnh5DhYD7
         F7l3UmV3do6dcYEPFUL7am2PU0zalh1hMK/HXTBPEt+YUjgz6nPJhDEgvj1uM8O4yOL4
         xJow==
X-Forwarded-Encrypted: i=1; AJvYcCUiPvDU4onDyshY8L35uO6jzwM7o+enssfacTR974TIRz/tdl0Sipr67EhpvdlQyzUaOKEZ2bmbGMcHZRLP@vger.kernel.org
X-Gm-Message-State: AOJu0YzDNpUnjI2AUWsxPXECaV3g77gxE5sPzReHPXo4QHa3i2C0r/Yd
	+PqqfhZS1maNBEGsbb3iypSY8G3EzsXpa9evZvx2pJAtZGjzfmqeNFjvZsWraqfY21KHRVAjPZD
	PUI2KZw==
X-Google-Smtp-Source: AGHT+IF7Bc+1kpTJUwa8ygptmPhSCVf8jmwAYEk8NLvIetBZg+2JsVv2O2B8rcUMCbgag6GZIPMPzybYoNI=
X-Received: from pjbpt6.prod.google.com ([2002:a17:90b:3d06:b0:30a:7da4:f075])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e42:b0:2fe:85f0:e115
 with SMTP id 98e67ed59e1d1-30e7d5acb46mr1591612a91.26.1747357078925; Thu, 15
 May 2025 17:57:58 -0700 (PDT)
Date: Thu, 15 May 2025 17:57:57 -0700
In-Reply-To: <24e8ae7483d0fada8d5042f9cd5598573ca8f1c5.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <ada87be8b9c06bc0678174b810e441ca79d67980.camel@intel.com>
 <CAGtprH9CTsVvaS8g62gTuQub4aLL97S7Um66q12_MqTFoRNMxA@mail.gmail.com> <24e8ae7483d0fada8d5042f9cd5598573ca8f1c5.camel@intel.com>
Message-ID: <aCaM7LS7Z0L3FoC8@google.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Vishal Annapurve <vannapurve@google.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	Jun Miao <jun.miao@intel.com>, "nsaenz@amazon.es" <nsaenz@amazon.es>, 
	"pdurrant@amazon.co.uk" <pdurrant@amazon.co.uk>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"tabba@google.com" <tabba@google.com>, "keirf@google.com" <keirf@google.com>, 
	"quic_svaddagi@quicinc.com" <quic_svaddagi@quicinc.com>, "amoorthy@google.com" <amoorthy@google.com>, 
	"pvorel@suse.cz" <pvorel@suse.cz>, "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, 
	"mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, Wei W Wang <wei.w.wang@intel.com>, 
	"jack@suse.cz" <jack@suse.cz>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Yan Y Zhao <yan.y.zhao@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, 
	"quic_mnalajal@quicinc.com" <quic_mnalajal@quicinc.com>, "aik@amd.com" <aik@amd.com>, 
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>, "willy@infradead.org" <willy@infradead.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "bfoster@redhat.com" <bfoster@redhat.com>, 
	"quic_cvanscha@quicinc.com" <quic_cvanscha@quicinc.com>, Fan Du <fan.du@intel.com>, 
	"fvdl@google.com" <fvdl@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "mic@digikod.net" <mic@digikod.net>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "steven.price@arm.com" <steven.price@arm.com>, 
	"muchun.song@linux.dev" <muchun.song@linux.dev>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, Zhiquan1 Li <zhiquan1.li@intel.com>, 
	"rientjes@google.com" <rientjes@google.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, 
	Erdem Aktas <erdemaktas@google.com>, "david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"hughd@google.com" <hughd@google.com>, Haibo1 Xu <haibo1.xu@intel.com>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "anup@brainfault.org" <anup@brainfault.org>, 
	"maz@kernel.org" <maz@kernel.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, 
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>, "jarkko@kernel.org" <jarkko@kernel.org>, 
	"quic_pheragu@quicinc.com" <quic_pheragu@quicinc.com>, Kirill Shutemov <kirill.shutemov@intel.com>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, 
	"pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, Chao Peng <chao.p.peng@intel.com>, 
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
	"roypat@amazon.co.uk" <roypat@amazon.co.uk>, "ackerleytng@google.com" <ackerleytng@google.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "pgonda@google.com" <pgonda@google.com>, 
	"quic_pderrin@quicinc.com" <quic_pderrin@quicinc.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"will@kernel.org" <will@kernel.org>, "hch@infradead.org" <hch@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025, Rick P Edgecombe wrote:
> On Thu, 2025-05-15 at 11:42 -0700, Vishal Annapurve wrote:
> > On Thu, May 15, 2025 at 11:03=E2=80=AFAM Edgecombe, Rick P
> > <rick.p.edgecombe@intel.com> wrote:
> > >=20
> > > On Wed, 2025-05-14 at 16:41 -0700, Ackerley Tng wrote:
> > > > Hello,
> > > >=20
> > > > This patchset builds upon discussion at LPC 2024 and many guest_mem=
fd
> > > > upstream calls to provide 1G page support for guest_memfd by taking
> > > > pages from HugeTLB.
> > >=20
> > > Do you have any more concrete numbers on benefits of 1GB huge pages f=
or
> > > guestmemfd/coco VMs? I saw in the LPC talk it has the benefits as:
> > > - Increase TLB hit rate and reduce page walks on TLB miss
> > > - Improved IO performance
> > > - Memory savings of ~1.6% from HugeTLB Vmemmap Optimization (HVO)
> > > - Bring guest_memfd to parity with existing VMs that use HugeTLB page=
s for
> > > backing memory
> > >=20
> > > Do you know how often the 1GB TDP mappings get shattered by shared pa=
ges?
> > >=20
> > > Thinking from the TDX perspective, we might have bigger fish to fry t=
han 1.6%
> > > memory savings (for example dynamic PAMT), and the rest of the benefi=
ts don't
> > > have numbers. How much are we getting for all the complexity, over sa=
y buddy
> > > allocated 2MB pages?

TDX may have bigger fish to fry, but some of us have bigger fish to fry tha=
n TDX :-)

> > This series should work for any page sizes backed by hugetlb memory.
> > Non-CoCo VMs, pKVM and Confidential VMs all need hugepages that are
> > essential for certain workloads and will emerge as guest_memfd users.
> > Features like KHO/memory persistence in addition also depend on
> > hugepage support in guest_memfd.
> >=20
> > This series takes strides towards making guest_memfd compatible with
> > usecases where 1G pages are essential and non-confidential VMs are
> > already exercising them.
> >=20
> > I think the main complexity here lies in supporting in-place
> > conversion which applies to any huge page size even for buddy
> > allocated 2MB pages or THP.
> >=20
> > This complexity arises because page structs work at a fixed
> > granularity, future roadmap towards not having page structs for guest
> > memory (at least private memory to begin with) should help towards
> > greatly reducing this complexity.
> >=20
> > That being said, DPAMT and huge page EPT mappings for TDX VMs remain
> > essential and complement this series well for better memory footprint
> > and overall performance of TDX VMs.
>=20
> Hmm, this didn't really answer my questions about the concrete benefits.
>=20
> I think it would help to include this kind of justification for the 1GB
> guestmemfd pages. "essential for certain workloads and will emerge" is a =
bit
> hard to review against...
>=20
> I think one of the challenges with coco is that it's almost like a sprint=
 to
> reimplement virtualization. But enough things are changing at once that n=
ot all
> of the normal assumptions hold, so it can't copy all the same solutions. =
The
> recent example was that for TDX huge pages we found that normal promotion=
 paths
> weren't actually yielding any benefit for surprising TDX specific reasons=
.
>=20
> On the TDX side we are also, at least currently, unmapping private pages =
while
> they are mapped shared, so any 1GB pages would get split to 2MB if there =
are any
> shared pages in them. I wonder how many 1GB pages there would be after al=
l the
> shared pages are converted. At smaller TD sizes, it could be not much.

You're conflating two different things.  guest_memfd allocating and managin=
g
1GiB physical pages, and KVM mapping memory into the guest at 1GiB/2MiB
granularity.  Allocating memory in 1GiB chunks is useful even if KVM can on=
ly
map memory into the guest using 4KiB pages.

> So for TDX in isolation, it seems like jumping out too far ahead to effec=
tively
> consider the value. But presumably you guys are testing this on SEV or
> something? Have you measured any performance improvement? For what kind o=
f
> applications? Or is the idea to basically to make guestmemfd work like ho=
wever
> Google does guest memory?

The longer term goal of guest_memfd is to make it suitable for backing all =
VMs,
hence Vishal's "Non-CoCo VMs" comment.  Yes, some of this is useful for TDX=
, but
we (and others) want to use guest_memfd for far more than just CoCo VMs.  A=
nd
for non-CoCo VMs, 1GiB hugepages are mandatory for various workloads.

