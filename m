Return-Path: <linux-fsdevel+bounces-50758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B46E6ACF523
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F70D16B2B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 17:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DBE27A133;
	Thu,  5 Jun 2025 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3EKTus+i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E216279910
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143756; cv=none; b=P3s/HufyPiOXl3+QE0r7Z72gw37QsIoA0X9Q2/AwsurUvwqLvXbtgYH8kZsgZPkHh5/r/X1qYma3Iei+0knvaqOtxxar5/g/JPwEseZJbdXeczvDQCwedVa518H4egKHtIgsARXoTKoXZ4Lxz3/AZaXfz4PqzxtrrXF4DV6nk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143756; c=relaxed/simple;
	bh=owWI8WAYAlFsjJvXIyvYSUNXCshP/5FGhM730a1ama8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k1ztKct3FegC5HQ+hdUFZ2wVShjxejK6yHtKIs6EY7CL8tMBfvjWpIXF9WgLPXV2n076u6pUoZu/fzzkEAE37qbQn5yTxbdnRysyD2TzOah9itIHEGK4iv8V+eRleLRdQ6xL4C1Pfc/XHEUMqdTiBq6fUcqwbw0qcPrUTm0a8J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3EKTus+i; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235c897d378so11415415ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749143754; x=1749748554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BvVogHbLCy3WniKJnzNXayCUjBrxVyVRH9sGv66360=;
        b=3EKTus+i1JnDucVaMhuTSgXD7YTZOibnmejXlIOOreTNijnvHMFMpLZ+QXQaKgmOlb
         Aa1iZLcPCb9NYfLfPBS5n1j1kWSoNJeZ+YNqT2aQPyLMQWTMtdKSdSAxFZ69ikGqGwfO
         QWmYh2jfBFZ8XHJI3l/kGLIrkanWDsGj3lcQHgqbBX6pygK1DlD7M7k6cEZNI3EylxkJ
         1y8N14mzr4i2tZZ3S5uIjesIE5o53ivwxnNX5dFuVo/L44iM5qiPEIvIYA2poMjsYr0r
         D81tlq6B+xcUmFB497C5RFSw7cC8sBNlvDo2tCqCGAT+cLT/jSSF6yRAgA2QAltRvq8h
         4E7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749143754; x=1749748554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BvVogHbLCy3WniKJnzNXayCUjBrxVyVRH9sGv66360=;
        b=oqebsFiC31JV2MNf8jNUQtaECTVhUO/tAoJvdDza/6M5GQnMfufk2N2dFEitRqRQB4
         k+ZVH3G4kP3q/hyL5V/i+C2Tc6jUq1lYIPXKPjKHq9C76sfUe+JE3xeIyfCvEGt0/CdR
         /h/vjDiW9tgAP4QWewiDheV2H0hNDZqqFcVZQeBWcQYcPjFMW3k4XW7Q1BhdMzNPD5JN
         7rZ5kK8f/0V5CaOVMw/G7xJtz4E2vGb+OnpqgnwALVNVP6eTQ5ttoPUw02iMT9DgUetW
         kYlmG6MWI72rn+c14Xq8yHAQKrO3hOyD/zEWfH1+fx62Pwvze/S/Rz8/vYTBV20z+BZ4
         njjg==
X-Forwarded-Encrypted: i=1; AJvYcCWkNSF8O4VDPwKUNkxqLol8GDRYjUGR+ZOJWiC4BvofYNhxAwP43NlFmOl6EoHYg4Cml5SHXxlZaE8BKO7R@vger.kernel.org
X-Gm-Message-State: AOJu0YxLmiResFeaySZfSDqmLBKyTS24nlaPb1sW0gk/NuO9fkNl7AbQ
	LfP7ibwX03iILm5Ustn1OZ+dY6NnqJSLk7uNNaNy7UIA3oT8EUn23SrW0dKFDSK7ltGrLRv5nWY
	glRfGCFDdPpT7YCs4rtuVevQQfg==
X-Google-Smtp-Source: AGHT+IEW234xG8sWokLR9Rty6k1AIBgtp49T5P85K9mc9H7ZjXy7xEQDhgc08MioADyUz2CbmUlZakt/hY882gqV/g==
X-Received: from plsh2.prod.google.com ([2002:a17:902:b942:b0:234:f137:75cf])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dad0:b0:234:c5c1:9b73 with SMTP id d9443c01a7336-23601ec356fmr1418295ad.36.1749143754410;
 Thu, 05 Jun 2025 10:15:54 -0700 (PDT)
Date: Thu, 05 Jun 2025 10:15:53 -0700
In-Reply-To: <85ae7dc691c86a1ae78d56d413a1b13b444b57cd.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
 <85ae7dc691c86a1ae78d56d413a1b13b444b57cd.camel@intel.com>
Message-ID: <diqz7c1qjeie.fsf@ackerleytng-ctop.c.googlers.com>
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

