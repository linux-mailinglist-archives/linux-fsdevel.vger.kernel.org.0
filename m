Return-Path: <linux-fsdevel+bounces-55190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7641EB08071
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 00:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9470517D61F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 22:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4C22EE5E7;
	Wed, 16 Jul 2025 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SheUR8hb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1046828D823
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752704531; cv=none; b=OlMVM4+HH82BvoIH1YBXkwEthCh40JzKe9cjF5AsHZ2bcAMWIB5UFPWmWDOGmbuOzo1uBleMOPZhMWWcHDmkNeVKW+yYyVp6j/5cHstdMo+o5JidrlT1sjlBhl3LXqH7MfoOC16mI7IvWpDgeQFE5++Xsrdct5p7duzoqXmwAeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752704531; c=relaxed/simple;
	bh=yf3Y8defNvqata8qiCkZ8jV2NsjanhzbT+BLQRoUDQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R2wTgnx+RBM19UpStJz3yr+YT7oOE/K3dx07DY6rblHVQhYjFd3yJ9ZBN0YDmt4ZWP62vuh7wPoVZ9+IoPL/698lHi0AvFw47mKu9f7KLBJwIbPhjzOuLAkgGffEvdqyRPSlH7DaPPkND7bPBUSU3/zGa5UxzKz6yWX/EZK3EjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SheUR8hb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7494999de28so390391b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 15:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752704528; x=1753309328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHYx0oKJKOX+LIQdUAr0yKPkS6Z6eF8ywIsSJu/uw4Y=;
        b=SheUR8hbBheBNjso+80ZBfos+HSkWFK6u5Nxtf++voxinXuTlZdYTSq/4qhMNkH9y+
         mz+JOT6nbhPKC+5cSUUY29tJbWaGKYKQz1wu0V/rvnpYT2gKhTPPZe6MiCEYfGmwpkI+
         vKVjWO3G5ajtXa0xQU03hENaYgMoEuhpKaRm2YQyt4vfRorS9+tN9AwUhHfkD1cZMLze
         /SgVe7ABYg4R3NYUK+XPNndHTLO0l/814To1sEY/d+qmLZjqWFXVLj7bTaFaSXP5028Z
         Q+d0jaqp1E0SycDSO4/VopTHY4npSPK/vChtgvMBBZHisEM8c8N5WneyCRIuJVyWrh1T
         TvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752704528; x=1753309328;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kHYx0oKJKOX+LIQdUAr0yKPkS6Z6eF8ywIsSJu/uw4Y=;
        b=omNPhL6l7Ehue3kD5BJk3qcglFcsnzVJVKpjITUvgSN8SGuBbAU3mftDTa+T81o4kX
         qWUHUOme+RY8NyClHPKpVO+G8Qrulpd/fW4jcX+sg9C7a/27A5mRERT/ysNwom/ywZCE
         gmnQWLHXNC1jfegCOFiaLaMO+om0IBCLh75X2oI1olhNL14IftgcANZBGGAPEGrcfgpK
         DgxVQ+02VJu/N9P001wRIGI7IB0OxnSEYtZR+G5i9oS08wtgQZ1YJXC7gi7EXO4WSi9B
         +nZF6Vtb1xE3zqpiIRdQFDyarAp7xBP3c52PVPghvwF6EfKqOafYpkwEeXe8OllTxr3A
         CNfA==
X-Forwarded-Encrypted: i=1; AJvYcCW9oeUmlJkxvH4fOL1VWtHvqfUwc3QgGiRoL6GvOtjL0qs0zN7g+mtO1h0E0Jc73ZQK48PTnu0Mb3pleNGw@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb+St1iz885I1klnPiFIrXkrZmuImecwtncaBTvQicPjarOR0F
	1JXb8QM7NlSZwLccl75FxQDjDLo36isC0XcaLf78bsfYvY4h4AwN9Fob8PD8/kG1vFy7XB1WJyI
	AFXf0XvNp0Ef6FtJZRlPvuufp8w==
X-Google-Smtp-Source: AGHT+IG0OvScUbujc+i6/1IIn8ARXzZvFQD59bptEMA3mXCmCDkH6zU0DKQx5NAHGSoU+3a0uG4wqBjqoX5XM1g8tA==
X-Received: from pfoo10.prod.google.com ([2002:a05:6a00:1a0a:b0:746:3321:3880])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:882:b0:748:ff39:a0ed with SMTP id d2e1a72fcca58-7584b43a0acmr949334b3a.20.1752704527892;
 Wed, 16 Jul 2025 15:22:07 -0700 (PDT)
Date: Wed, 16 Jul 2025 15:22:06 -0700
In-Reply-To: <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
 <CA+EHjTxtHOgichL=UvAzczoqS1608RSUNn5HbmBw2NceO941ng@mail.gmail.com>
 <CAGtprH8eR_S50xDnnMLHNCuXrN2Lv_0mBRzA_pcTtNbnVvdv2A@mail.gmail.com>
 <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com>
 <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com> <20250624130811.GB72557@ziepe.ca>
 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com> <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com>
Message-ID: <diqz8qknhj3l.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
From: Ackerley Tng <ackerleytng@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>, Vishal Annapurve <vannapurve@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-fsdevel@vger.kernel.org, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgowans@amazon.com, jhubbard@nvidia.com, jroedel@suse.de, 
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com, 
	keirf@google.com, kent.overstreet@linux.dev, kirill.shutemov@intel.com, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, 
	mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net, 
	michael.roth@amd.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, 
	qperret@google.com, quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org, 
	willy@infradead.org, xiaoyao.li@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Tue, Jun 24, 2025 at 07:10:38AM -0700, Vishal Annapurve wrote:
>> On Tue, Jun 24, 2025 at 6:08=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> w=
rote:
>> >
>> > On Tue, Jun 24, 2025 at 06:23:54PM +1000, Alexey Kardashevskiy wrote:
>> >
>> > > Now, I am rebasing my RFC on top of this patchset and it fails in
>> > > kvm_gmem_has_safe_refcount() as IOMMU holds references to all these
>> > > folios in my RFC.
>> > >
>> > > So what is the expected sequence here? The userspace unmaps a DMA
>> > > page and maps it back right away, all from the userspace? The end
>> > > result will be the exactly same which seems useless. And IOMMU TLB
>>=20
>>  As Jason described, ideally IOMMU just like KVM, should just:
>> 1) Directly rely on guest_memfd for pinning -> no page refcounts taken
>> by IOMMU stack
> In TDX connect, TDX module and TDs do not trust VMM. So, it's the TDs to =
inform
> TDX module about which pages are used by it for DMAs purposes.
> So, if a page is regarded as pinned by TDs for DMA, the TDX module will f=
ail the
> unmap of the pages from S-EPT.
>
> If IOMMU side does not increase refcount, IMHO, some way to indicate that
> certain PFNs are used by TDs for DMA is still required, so guest_memfd ca=
n
> reject the request before attempting the actual unmap.
> Otherwise, the unmap of TD-DMA-pinned pages will fail.
>
> Upon this kind of unmapping failure, it also doesn't help for host to ret=
ry
> unmapping without unpinning from TD.
>
>

Yan, Yilun, would it work if, on conversion,

1. guest_memfd notifies IOMMU that a conversion is about to happen for a
   PFN range
2. IOMMU forwards the notification to TDX code in the kernel
3. TDX code in kernel tells TDX module to stop thinking of any PFNs in
   the range as pinned for DMA?

If the above is possible then by the time we get to unmapping from
S-EPTs, TDX module would already consider the PFNs in the range "not
pinned for DMA".

>> 2) Directly query pfns from guest_memfd for both shared/private ranges
>> 3) Implement an invalidation callback that guest_memfd can invoke on
>> conversions.
>>=20
>> Current flow:
>> Private to Shared conversion via kvm_gmem_convert_range() -
>>     1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
>> on each bound memslot overlapping with the range
>>          -> KVM has the concept of invalidation_begin() and end(),
>> which effectively ensures that between these function calls, no new
>> EPT/NPT entries can be added for the range.
>>      2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
>> actually unmaps the KVM SEPT/NPT entries.
>>      3) guest_memfd invokes kvm_gmem_execute_work() which updates the
>> shareability and then splits the folios if needed
>>=20
>> Shared to private conversion via kvm_gmem_convert_range() -
>>     1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
>> on each bound memslot overlapping with the range
>>      2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
>> actually unmaps the host mappings which will unmap the KVM non-seucure
>> EPT/NPT entries.
>>      3) guest_memfd invokes kvm_gmem_execute_work() which updates the
>> shareability and then merges the folios if needed.
>>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>=20
>> For IOMMU, could something like below work?
>>=20
>> * A new UAPI to bind IOMMU FDs with guest_memfd ranges
>> * VFIO_DMA_MAP/UNMAP operations modified to directly fetch pfns from
>> guest_memfd ranges using kvm_gmem_get_pfn()
>>     -> kvm invokes kvm_gmem_is_private() to check for the range
>> shareability, IOMMU could use the same or we could add an API in gmem
>> that takes in access type and checks the shareability before returning
>> the pfn.
>> * IOMMU stack exposes an invalidation callback that can be invoked by
>> guest_memfd.
>>=20
>> Private to Shared conversion via kvm_gmem_convert_range() -
>>     1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
>> on each bound memslot overlapping with the range
>>      2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
>> actually unmaps the KVM SEPT/NPT entries.
>>            -> guest_memfd invokes IOMMU invalidation callback to zap
>> the secure IOMMU entries.
> If guest_memfd could determine if a page is used by DMA purposes before
> attempting the actual unmaps, it could reject and fail the conversion ear=
lier,
> thereby keeping IOMMU/S-EPT mappings intact.
>
> This could prevent the conversion from partially failing.
>

If the above suggestion works, then instead of checking if pages are
allowed to be unmapped, guest_memfd will just force everyone to unmap.

>>      3) guest_memfd invokes kvm_gmem_execute_work() which updates the
>> shareability and then splits the folios if needed
>>      4) Userspace invokes IOMMU map operation to map the ranges in
>> non-secure IOMMU.
>>=20
>> Shared to private conversion via kvm_gmem_convert_range() -
>>     1) guest_memfd invokes kvm_gmem_invalidate_begin() for the ranges
>> on each bound memslot overlapping with the range
>>      2) guest_memfd invokes kvm_gmem_convert_should_proceed() which
>> actually unmaps the host mappings which will unmap the KVM non-seucure
>> EPT/NPT entries.
>>          -> guest_memfd invokes IOMMU invalidation callback to zap the
>> non-secure IOMMU entries.
>>      3) guest_memfd invokes kvm_gmem_execute_work() which updates the
>> shareability and then merges the folios if needed.
>>      4) Userspace invokes IOMMU map operation to map the ranges in secur=
e IOMMU.
>>=20
>> There should be a way to block external IOMMU pagetable updates while
>> guest_memfd is performing conversion e.g. something like
>> kvm_invalidate_begin()/end().
>>=20
>> > > is going to be flushed on a page conversion anyway (the RMPUPDATE
>> > > instruction does that). All this is about AMD's x86 though.
>> >
>> > The iommu should not be using the VMA to manage the mapping. It should
>>=20
>> +1.
>>=20
>> > be directly linked to the guestmemfd in some way that does not disturb
>> > its operations. I imagine there would be some kind of invalidation
>> > callback directly to the iommu.
>> >
>> > Presumably that invalidation call back can include a reason for the
>> > invalidation (addr change, shared/private conversion, etc)
>> >
>> > I'm not sure how we will figure out which case is which but guestmemfd
>> > should allow the iommu to plug in either invalidation scheme..
>> >
>> > Probably invalidation should be a global to the FD thing, I imagine
>> > that once invalidation is established the iommu will not be
>> > incrementing page refcounts.
>>=20
>> +1.
>>=20
>> >
>> > Jason
>>=20

