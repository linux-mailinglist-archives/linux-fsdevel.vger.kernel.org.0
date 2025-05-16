Return-Path: <linux-fsdevel+bounces-49265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE17AB9E2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 16:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2EA4E7179
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 14:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89571531DB;
	Fri, 16 May 2025 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="idtMLIEf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40661249EB
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747404451; cv=none; b=KTUGFLJlUVVBwZSMq0fVhVHFzhNs2XvJUixkJI2NaZ9A6B3agkUVwnpW3bWecJpp1tmz7z9OOFgxes9z7ekvAVxTKAXKt7IkcIfmmW9LbdpJtFqps/XdO+2tKJibrZB2cYLgN9OzRSRLvi/V2nZTOeEqd7FdcfpnyDcuD4ZH5MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747404451; c=relaxed/simple;
	bh=ZiJQtCrV56w4/Y1W+Sd1A8QY8PZatBWXeocXad9ibgg=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=JgMP0z42itQAYBMUnLbrmGkTeiAS620urh3QLPZgzg4XFGzuDyLdBy93fIqAGorbKTK9yMM4uUouGPxsEFWEu+XTpVmyWEU/VQpjKdt6ClOTXjmXrCUSR+usl5IHWYj6Xl4ju3xV5EjlO5w0DLDDJLiAb8yQ/HYHlBSZnVKc5J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=idtMLIEf; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7395d07a3dcso1706154b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747404448; x=1748009248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I0BEoaGPs7E0lHGHqMtx20JU7Z7mIAdbQ03kowt/oEI=;
        b=idtMLIEfiyQRD6EJjBSQqU6I0nM3t0N49ASuI9AsmxSORZZjg7PTZJe7Pu1/6ljRUo
         JYs1vLhGN8/vXI+0YYJnISfclbcul9ilyjI6gxvwxQ3oNJEbrUtpMCAOj3vpgo2+HYke
         xjsb/zWmHVAut0NPgXLvppVfXSKzckVvffKVJ/zo8SpIklO4huTgSW2Z6VvNtbxXjubP
         HNo08DOadfNYsWP+6tq20NUf6NLSBJRvpIoRLFfuEUjKZoUKFra16T/waDeum5JskYRp
         vr1q1gm9w2T5Oevxx6PxfJXF1OF3lv/+7OD5O2fM4dFcpHZBAFQtQWXU8tX/32xiEf92
         mUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747404448; x=1748009248;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0BEoaGPs7E0lHGHqMtx20JU7Z7mIAdbQ03kowt/oEI=;
        b=HRApnf1y3pQTsbD5xf+7xELtChJmVNLWQT9AeNgfQhXMTCO3v41naspnQYdu5Rrd9n
         fFHqHa+WxCFvkex7OXtufoTcJDN8t+V+O0rAsiNjetOyl0OML5++6kUpRO4LcQBz6jxV
         Jj65Wrf9CfeXPuJZVCNf8nyEZBczZQa7tSesxUnlvEJtIOAc+SO6CU5ddTZMMOmoXrjy
         9MPTW2S/szzLXdXcQ/kz5xTNDnVhg3ufR0G7FtvUIbkS3NOSOZeAS5UE12dzuMutjCu0
         aZ0+wflxrebBel0FmeCOLso8sCw02Kn3UolxaViHMrWFKW845GC8KaUdp9LI2E5bQfrP
         VDyw==
X-Forwarded-Encrypted: i=1; AJvYcCV4qUtGqcs7f2i4J0mBQwdZ7xnH+ED95plaCPzJ7bp+jVhlrgLY1IH/uxkCalTGDK+iTayzL6cCzYB/z38K@vger.kernel.org
X-Gm-Message-State: AOJu0YwUP+93JVK2oBzuwBt3clB7UrQzk6wWX1eNy1lkfD4yTrXTKNVE
	QtR86GBvpEvpZfbUWxGFA4E0uS56OE4jbiKB10QIC/C4TcDZUNuYdNGv7U6SxgdRoIFG7s3/ezj
	0I5SFH8sGXXTSfUrahIdkTTFnsg==
X-Google-Smtp-Source: AGHT+IHjj8hb/RVvZ0IOpTAd6gcfF67ZbXjAX68CTThBkFnrnLTw7dIsH6cNRpPgLu+DDO0Lal4k3FXkbzgyillaoQ==
X-Received: from pffl14.prod.google.com ([2002:a62:be0e:0:b0:73e:1cf2:cd5c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:c8d:b0:740:6f69:f52a with SMTP id d2e1a72fcca58-742a9616b19mr4851938b3a.0.1747404448303;
 Fri, 16 May 2025 07:07:28 -0700 (PDT)
Date: Fri, 16 May 2025 07:07:27 -0700
In-Reply-To: <b3c2da681c5bf139e2eaf0ea82c7422f972f6288.1747264138.git.ackerleytng@google.com>
 (message from Ackerley Tng on Wed, 14 May 2025 16:42:08 -0700)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzzffcfy3k.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 29/51] mm: guestmem_hugetlb: Wrap HugeTLB as an
 allocator for guest_memfd
From: Ackerley Tng <ackerleytng@google.com>
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
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> guestmem_hugetlb is an allocator for guest_memfd. It wraps HugeTLB to
> provide huge folios for guest_memfd.
>
> This patch also introduces guestmem_allocator_operations as a set of
> operations that allocators for guest_memfd can provide. In a later
> patch, guest_memfd will use these operations to manage pages from an
> allocator.
>
> The allocator operations are memory-management specific and are placed
> in mm/ so key mm-specific functions do not have to be exposed
> unnecessarily.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>
> Change-Id: I3cafe111ea7b3c84755d7112ff8f8c541c11136d
> ---
>  include/linux/guestmem.h      |  20 +++++
>  include/uapi/linux/guestmem.h |  29 +++++++
>  mm/Kconfig                    |   5 +-
>  mm/guestmem_hugetlb.c         | 159 ++++++++++++++++++++++++++++++++++
>  4 files changed, 212 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/guestmem.h
>  create mode 100644 include/uapi/linux/guestmem.h
>
> <snip>
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 131adc49f58d..bb6e39e37245 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1218,7 +1218,10 @@ config SECRETMEM
>  
>  config GUESTMEM_HUGETLB
>  	bool "Enable guestmem_hugetlb allocator for guest_memfd"
> -	depends on HUGETLBFS
> +	select GUESTMEM
> +	select HUGETLBFS
> +	select HUGETLB_PAGE
> +	select HUGETLB_PAGE_OPTIMIZE_VMEMMAP

My bad. I left out CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=y in
my testing and just found that when it is set, I hit

  BUG_ON(pte_page(ptep_get(pte)) != walk->reuse_page);

with the basic guest_memfd_test on splitting pages on allocation.

I'll follow up with the fix soon.

Another note about testing: I've been testing in a nested VM for the
development process:

1. Host
2. VM for development
3. Nested VM running kernel being developed
4. Nested nested VMs created during selftests

This series has not yet been tested on a physical host.

>  	help
>  	  Enable this to make HugeTLB folios available to guest_memfd
>  	  (KVM virtualization) as backing memory.
>
> <snip>
>

