Return-Path: <linux-fsdevel+bounces-50762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3D8ACF539
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A511883036
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 17:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EE727F182;
	Thu,  5 Jun 2025 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HXhGNoaM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51394275861
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143783; cv=none; b=XJqa96ogg5P0ow97dKm8C93CqvNqERb6JW9SiZAFz1AVOMLe0wc1r3LMAb9D4AMlqGgyTxreFW3xXXkHsw1JgJDsc2y74nLFCRUjl52JBePH9nD0cMDajECmmJF1i4RYoLr+nfZ5ERzOX/wxKdsvLbAAscYzLkkYFBAfOEp8pgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143783; c=relaxed/simple;
	bh=owWI8WAYAlFsjJvXIyvYSUNXCshP/5FGhM730a1ama8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RW4XJiTgticMM9W71vf8Iw0gJAfnXdTSyAwEa3bH7nFmoxEUSI/OfpZa//lnNEtfnsrkqFQT8xKP+gvlJ+9SkYWqerw/3N8NPdLu16BPuH4cWNM92/ik6WCO/2Nq8M1Ic+Rzgs+CLDG6PYleS0dm4CBY1f/RjZtjLbDzPpK5Nt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HXhGNoaM; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7462aff55bfso1170296b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749143780; x=1749748580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BvVogHbLCy3WniKJnzNXayCUjBrxVyVRH9sGv66360=;
        b=HXhGNoaMCx/06PTy7ZzJ94h1q3GbAMqkz3lxdB9Pz9xY08lx/J9fImFQiAfE2xC0g7
         hTqJ41j3sYEEvTCTGhLxCfBhBvMKzZQmUSbfmH0xHwRTLCkznus6fAci8fe09zAZPmH2
         wWTazphl7n115ZpmYrBaIHYJKgX9kBmF208OIVxxFKu0ifTNSNHL87EsNhkfWfy3hu2K
         hDAaLI47s3ONRyXOQkmyID4AgNL8ntqfAz8p5nU/U+3TrcZZIigzMk1a/XW76QPwX1bM
         b0tJIasRcmileJ56MFKPBoZ91h3KEApX4aUWew3eR0UYynEYAe6J7Rcae8M2/bvwQ9PW
         m7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749143780; x=1749748580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BvVogHbLCy3WniKJnzNXayCUjBrxVyVRH9sGv66360=;
        b=Id00bvmKHellJ41XchTNqBfMlwFESQ0wLPVOFDoKR/QoZCqaoD4/Y1GD5glc3ttLT1
         Aw/3+0OsQcdpdfetgBWSUs0/N2gdHjFEnwr+7sTl9VF6F1QeRw+j36CcyKKZ6DGZP00M
         00yFXubciCoaY2W6ca5HIOYOQUEFJH7eDWBikKThwUuW3UO5R9Mb4kRffCD6WGyxzXvX
         1rM3xeaYkAJicum8YpEElexklHLqsQgbuBqZy1Z57WfQSQLYadusEdEXsL/Cgf1Q98ht
         GULXAJ+s7nczh7ZGh+Tgm4GrMD1wGd6Ti62aku3mzNPgxtXaSAPPqGwLwzNsKC6mztoR
         fksg==
X-Forwarded-Encrypted: i=1; AJvYcCVkM1/+T3s06PZkHxomzmR6vrRrWVJaPT6ogVwpQUIZtpdYzto0A8H3fL9B4TJWA5MPq3+TVgfv1nVdvYXn@vger.kernel.org
X-Gm-Message-State: AOJu0YzVoVxU6zl9Sc/xKiEy/5F1C82dlrjQNQPV+9Afwv5/dxmhoioD
	S1Gc/c1zXbWUPmOt81joWB0XGQSYHpogyJep2wfhQ1qUYFRUR5uPyx5uQ0eH+ysyOMC96jKAl2b
	whzmQkmKGpF0/UmXODBElKfTB+A==
X-Google-Smtp-Source: AGHT+IHrHrufhfOgqsSZMYYGmnf8by8Ce09NkloD1+JcTL5IynPrkehej7WsZeM9qeq9p5D9AWLP4i2IXr0GIs1k+Q==
X-Received: from pfko22.prod.google.com ([2002:a05:6a00:2156:b0:746:30f0:9b33])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:218e:b0:73e:30af:f479 with SMTP id d2e1a72fcca58-74828067b30mr550569b3a.19.1749143780316;
 Thu, 05 Jun 2025 10:16:20 -0700 (PDT)
Date: Thu, 05 Jun 2025 10:16:18 -0700
In-Reply-To: <85ae7dc691c86a1ae78d56d413a1b13b444b57cd.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
 <85ae7dc691c86a1ae78d56d413a1b13b444b57cd.camel@intel.com>
Message-ID: <diqz1pryjehp.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 38/51] KVM: guest_memfd: Split allocator pages for
 guest_memfd use
From: Ackerley Tng <ackerleytng@google.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Cc: "palmer@dabbelt.com" <palmer@dabbelt.com>, "pvorel@suse.cz" <pvorel@suse.cz>, 
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
	"david@redhat.com" <david@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"Annapurve, Vishal" <vannapurve@google.com>, "Xu, Haibo1" <haibo1.xu@intel.com>, 
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

"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:

> On Wed, 2025-05-14 at 16:42 -0700, Ackerley Tng wrote:
>> +
>> +static pgoff_t kvm_gmem_compute_invalidate_bound(struct inode *inode,
>> +						 pgoff_t bound, bool start)
>> +{
>> +	size_t nr_pages;
>> +	void *priv;
>> +
>> +	if (!kvm_gmem_has_custom_allocator(inode))
>
> General comment - It's a bit unfortunate how kvm_gmem_has_custom_allocator() is
> checked all over the place across this series. There are only two allocators
> after this, right? So one is implemented with callbacks presumably designed to
> fit other allocators, and one has special case logic in guest_memfd.c.
>
> Did you consider designing struct guestmem_allocator_operations so that it could
> encapsulate the special logic for both the existing and new
> allocators?

I did, yes. I believe it is definitely possible to make standard 4K
pages become another allocator too.

I would love to clean this up. Not sure if that will be a new series
after this one, or part of this one though.

> If it
> didn't work well, could we expect that a next allocator would actually fit
> struct guestmem_allocator_operations?
>

This was definitely designed to support allocators beyond
guestmem_hugetlb, though I won't promise that it will be a perfect fit
for future allocators. This is internal to the kernel and this interface
can be updated for future allocators though.

>> +		return bound;
>> +
>> +	priv = kvm_gmem_allocator_private(inode);
>> +	nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(priv);
>> +
>> +	if (start)
>> +		return round_down(bound, nr_pages);
>> +	else
>> +		return round_up(bound, nr_pages);
>> +}
>> +
>> +static pgoff_t kvm_gmem_compute_invalidate_start(struct inode *inode,
>> +						 pgoff_t bound)
>> +{
>> +	return kvm_gmem_compute_invalidate_bound(inode, bound, true);
>> +}
>> +
>> +static pgoff_t kvm_gmem_compute_invalidate_end(struct inode *inode,
>> +					       pgoff_t bound)
>> +{
>> +	return kvm_gmem_compute_invalidate_bound(inode, bound, false);
>> +}
>> +

