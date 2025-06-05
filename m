Return-Path: <linux-fsdevel+bounces-50760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9BEACF531
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B59F7A2C33
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 17:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE2327CCC8;
	Thu,  5 Jun 2025 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dL/3PIqS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B3327C179
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143768; cv=none; b=pidQxmWWpCUMOUXvQ55YnJS+CVgipH8WipcEVGuAvamwThO+l7cHxYfGVIuLBloFP/q0okkE/KdG1l78Oi1XB8qlHu7ez/OdksSjz/OLzQXaFjMBjPFyTBnpYIM6bQ+KMcnO322h9GB/dKaxePq3IAyToOndVf18CKkzeFaHya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143768; c=relaxed/simple;
	bh=owWI8WAYAlFsjJvXIyvYSUNXCshP/5FGhM730a1ama8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qo/wc/9MR7vq71QU7yhQBuSQPor5vT7+lTUuQiSr5myJ+8RjB5KGpYHquKDQHhINqXDTcxMdquGjrWur4GQiwNHsYhbFB6zzaOP+zTi7LkkQZeIqg5Lr/2xlb+FIr2OB4x3ZUK+yOTEOMjjBu+5KNcVPrXXowj60pNNF1RrYLXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dL/3PIqS; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b26db9af463so1080124a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749143766; x=1749748566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BvVogHbLCy3WniKJnzNXayCUjBrxVyVRH9sGv66360=;
        b=dL/3PIqS/LcT5xEja2gOSKz45+3pl6PTAcgladq/PaBn6+YApS8bb5TG6cHRfQUdTf
         tIhJ/QtoGTgeEMOQ/5LGueackJd4QLMucExXOP5xn2JjBQSLUSK1D6cw2vi40wNuslRb
         GKPrSXM3yobnqV5Fyr+TmiEP/14AZKtqW/vzsfSWEqmkEMc/qf+dll6rmTIXqVPxdkV5
         UnDPYc5v4Fz7momO5m4KYHemq8LINM2Uo/64gtNXkG79VnFYacW07iuKOG+iRYFnUb8D
         cEu6VOh+izSgkUzrMWLCZLluQiv4Ep1zVzgZQjrvoGFtcfE/0vxDHwTtKjqViNP9ozhQ
         5HMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749143766; x=1749748566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BvVogHbLCy3WniKJnzNXayCUjBrxVyVRH9sGv66360=;
        b=tbIh6skmRG7kfANO31uj6uJw7oiSPTe+kIQcYeMmjLYh1RYFGyYrpMySJiAKq9VZJA
         jezSVwQmlzeK6GWYtchtWUSRVpvYK8zHDl/88bLBrzFrKeQe1D9L35POhpHO4ADsirMG
         IBNV7kLCKdmeDSP+tUOVxOS6yM07V7iG1og8NDG+fEtWb1UCMFbA88SVnjlW8JT5gL4X
         gavgwnx9R74WdhRm/RPPPANaINajkCQ0d2fmSPm7KY4jk/D64tbOqRoZ3BWAiJck1Z4C
         JLeh6xYcxPfesIemXqLFl8VxFfzUXFq3K1SJIX332681RNW+jBNv8LsTEFlXD8URMP9M
         SQQw==
X-Forwarded-Encrypted: i=1; AJvYcCUPGrdYtczqqd8X5whAMvIsv7jiVwR/3NdCrq7NiGY/dkNO2tN/5r1vJIya4V4cL6TRiFCtO/FVkRHPNirh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6WWn2U5TzVMDJ9U5fJFWRe2QTwmYZTEKIs9yBzbqFo8d1p1hl
	ZLzO+gcY6fghyZ7I3ZBx0CXhWkOXlDK2urW3maB1MtG8zGdTBBAFNaUWqs2aqrlkIvMrExrkVua
	vrvKO/ggMfI0yF1Ppm4BMZQqYQg==
X-Google-Smtp-Source: AGHT+IEvH4pPOhC5swS9Ac1ft02M4o++P2gdgLCIEBYmzEPlGyI5fIrpImE4csjfyMJNGLfVLTN7N+dzmJ3OxtE7CA==
X-Received: from pfrg4.prod.google.com ([2002:aa7:9f04:0:b0:746:2ae9:24a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9149:b0:216:1ea0:a51a with SMTP id adf61e73a8af0-21d22c44192mr11686682637.38.1749143766157;
 Thu, 05 Jun 2025 10:16:06 -0700 (PDT)
Date: Thu, 05 Jun 2025 10:16:04 -0700
In-Reply-To: <85ae7dc691c86a1ae78d56d413a1b13b444b57cd.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
 <85ae7dc691c86a1ae78d56d413a1b13b444b57cd.camel@intel.com>
Message-ID: <diqz4iwujei3.fsf@ackerleytng-ctop.c.googlers.com>
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

