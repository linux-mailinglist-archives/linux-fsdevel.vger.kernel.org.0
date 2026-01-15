Return-Path: <linux-fsdevel+bounces-74001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B2D2830E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 20:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAD593088872
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE8831AF3D;
	Thu, 15 Jan 2026 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2xDa2ZDe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3EF31A068
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505992; cv=pass; b=S5AyE8wff2nOjo6uJMFmCR9A9ajdkw5lvZqm6tXSmb8nKeltb0/+dq6GjMBZNmQLrBcbwU9/hvXWvsnOLw/3DIXRlo0zAY6iwVahik2wH466KrC+iqD7ukbo+JFjsxiMTZHsfI5cu911DzHfNPH4qpOiGOP5wJZ1jv8Fv3gmUwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505992; c=relaxed/simple;
	bh=8lDpvZLaR4z8lIctcEKx9lDd0Hg9OXd26QzQJA3m9FE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDZULJ817RA4nC66YI5WVfswhKyviF3cugUDi30JmsaR1ymwJlCFCMAZESYCjIdMGkcbrcT073mUTMk8LMDcLI2OBv60N4XYUMAwo5eedW0L/QquPdIPAt58ZMWki4C+gjd0XHOFFJHBVJV8RyiR1RcLzqlkYRTub26tjYky3BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2xDa2ZDe; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5eeaae0289bso851260137.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 11:39:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768505989; cv=none;
        d=google.com; s=arc-20240605;
        b=ekKsGI3aTTFSIH6pw443rvrhbC4oXuNRhp1EjP9o0j9q6T6t4gfsBMnRO5dCm305V4
         HclWDWQQLF9YKg7ruGrSrejs3vozxct2MM+MZ+bGEFsmeh6W+tIM2DxLRY7IfI5QgjdC
         uCl8vg1L9LOewtW90iopYqg1t+yovbJL8Smjx3MhizRKt84FEoJ9JL80nNRJr1uXSlzI
         oreD3zTONCytE3cBXqRvlgU/YqD0wpR9AVTOIw9sW9D2C0kmgCnYpz0h7S153JLyML8D
         TUyYHKsGjQuLdOUqDFQhyTJ8JpQtaC/glPFvajMepL37Xos7X67CSwOYpAiHsNYkeWSb
         7YnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8OTackPsw2h0c8jYnXMkXzgJ/rIyJhkclZPRusTP9Ac=;
        fh=2649481ZpFNvTMlKgXcFzch9h8N5Vi8PT4jUW900ivY=;
        b=E82tVNc7KnGVZrNqspHDZA2R9q5d8H08t9wwycqjgWjua436A1C82oCTFthtidQ6U8
         2RKjXa2+y+W2lp8T5fMnK0MBsaWG6n8Il2xGfKuVAMOa3/FqK8Xv/SWnqdskr4xaLxQz
         yeEWI28rDkPVX4m6H54zspvvjl3NA1HusL5QQiWe2oxcOhFuMWu+thsiPlmiVlQnSooW
         MihEh7qmubl1auc4C97a/4Pw5k+axXTDIz8X4RKy9f0vodd6wIJCw5RXRf9EQYwG1kzU
         tPDinQ5yHPUBhd6QETy4LSjcAINDhwcojuB8kcGT8dzJqJP6bmHG9YhLfCk2N7KjSj3m
         7Ggw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768505989; x=1769110789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8OTackPsw2h0c8jYnXMkXzgJ/rIyJhkclZPRusTP9Ac=;
        b=2xDa2ZDe6fWga3o9iQ/y68a2kotTMM+5GC5yibxJ1c8aadzFiQ3GNqo1zV6Sx9LEpr
         40WIBz8oKTx87gYkb47xR/rQhXQ0xVaRDugYxlBT2qdaU93joS46RiL1QMoIUrebP5+p
         zknWxMhKAlJ65pvxXJyhV+Y+RjxLsxDcOARl0NpNgG35pJa+VRpWAicnxFyk7cIpEvBm
         YKsParmFsYYWH3HI5gtB/V0vikHKCV/F10+uyO5qeDRcZMddXvxtKwl+/HvLV4CeY9db
         nNuRSUL6TuHpKcYngiOWmRKOu80+ttYncZZwb7oycm+yh9wH8lwNFhihElXn23+CHKFG
         0BOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505989; x=1769110789;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OTackPsw2h0c8jYnXMkXzgJ/rIyJhkclZPRusTP9Ac=;
        b=JuS1GtwAh64dpWJp9YFZlHJXF2Uiy8bb+QejIiaBC7LRoNkAi+E1hehi4pXQCNV2bK
         BRiPqYqlNymnzqxKkptduVZptqafrVlc7K411fYQb2mfzcwZ5tTMz5x8QD8WNoLApoMH
         NZLKi4+ELU5X6I4/yECtQUBaUmIOrIcx35Sh/qO6ZaTsR+PlUhs/KKYlrTZIr3FGbZg4
         RychMkgPB8AXWWVHQFkCN45zk8sDYjO8M8wNidDYlGNQq/7P73fPgr2Zz7j3qYCXXFwo
         rZ+EgUfWVQ5l9RoeW167XR0u3zVg565tUsxIrGJ8XuXh+nP12csX/5z9VDJvmwpvkRWn
         lvLw==
X-Forwarded-Encrypted: i=1; AJvYcCWeE7X7AVqxKJMj6U5MN5D9HRdSsksFugUp+8RVDl8Awe8BgHJyk5o2tHcJuGbqwWnQlJ3EBm03KDfMMQqF@vger.kernel.org
X-Gm-Message-State: AOJu0YxuLidRvmpvADdF379CLkIcc9IHZbw2rOGa5uod6G7wgR8vNgA8
	Y6pudMcw0iLHUvJRZol8oe6r2p7fixFdRtLcYmo1OszWt7sl/RGUIcliqJ3a50SBcit0uOl3gCg
	AQPjAPMNIrwN9LQOetoC36akdjhkSR/8FOLRqSEr4
X-Gm-Gg: AY/fxX7fG3QWCMm3eC31FC6l3lD2Qr6BdBGnAdIjmfo+I17tUTjI/Eec9Ay4Roj3RDl
	phb2NkqgD75anjjS8ARy/IEGx8vNXKGJ2LiBmHGSAc61jVhBye/0P7lxXfU4OMby0r233bWXznK
	k6TpLLme0BLRUyfoKujP16BRsG9H0ixlWixhvRWUIklMkofaHN/lb7PC1+6xBL9knC1EIWClFf9
	voR6UKeA8xLZZDA9zpYsKiIVZQ/l7XRaWtbSSslWpHXGvSrbgYcagKA1MvLa9uNmFFx/7YLgLF4
	8ebPFp2aekPDAMnGqE8zjxoRkLy9T8GIscci
X-Received: by 2002:a05:6102:3708:b0:5ef:ab71:cbcd with SMTP id
 ada2fe7eead31-5f1a4d8ce85mr377168137.7.1768505988665; Thu, 15 Jan 2026
 11:39:48 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 11:39:47 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 11:39:47 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260114134510.1835-10-kalyazin@amazon.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-10-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 11:39:47 -0800
X-Gm-Features: AZwV_Qiu_D8foB8Z5ZjGyCrmwdkqsKcMaz5fdNTkl-JawXW8yxxzsPZp7V4tbiI
Message-ID: <CAEvNRgGz2gRu2i+OSxasuyZudqsRGXijbDES8uXVe_hH6QCK4g@mail.gmail.com>
Subject: Re: [PATCH v9 09/13] KVM: selftests: set KVM_MEM_GUEST_MEMFD in
 vm_mem_add() if guest_memfd != -1
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"shuah@kernel.org" <shuah@kernel.org>, "riel@surriel.com" <riel@surriel.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>, 
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"coxu@redhat.com" <coxu@redhat.com>, "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, 
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "prsampat@amd.com" <prsampat@amd.com>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, 
	"alex@ghiti.fr" <alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pjw@kernel.org" <pjw@kernel.org>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"thuth@redhat.com" <thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, 
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>, 
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	"Thomson, Jack" <jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>, 
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

"Kalyazin, Nikita" <kalyazin@amazon.co.uk> writes:

> From: Patrick Roy <patrick.roy@linux.dev>
>
> Have vm_mem_add() always set KVM_MEM_GUEST_MEMFD in the memslot flags if
> a guest_memfd is passed in as an argument. This eliminates the
> possibility where a guest_memfd instance is passed to vm_mem_add(), but
> it ends up being ignored because the flags argument does not specify
> KVM_MEM_GUEST_MEMFD at the same time.
>
> This makes it easy to support more scenarios in which no vm_mem_add() is
> not passed a guest_memfd instance, but is expected to allocate one.
> Currently, this only happens if guest_memfd == -1 but flags &
> KVM_MEM_GUEST_MEMFD != 0, but later vm_mem_add() will gain support for
> loading the test code itself into guest_memfd (via
> GUEST_MEMFD_FLAG_MMAP) if requested via a special
> vm_mem_backing_src_type, at which point having to make sure the src_type
> and flags are in-sync becomes cumbersome.
>
> Signed-off-by: Patrick Roy <patrick.roy@linux.dev>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 24 +++++++++++++---------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 8279b6ced8d2..56ddbca91850 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1057,21 +1057,25 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>
>  	region->backing_src_type = src_type;
>
> -	if (flags & KVM_MEM_GUEST_MEMFD) {
> -		if (guest_memfd < 0) {
> +	if (guest_memfd < 0) {
> +		if (flags & KVM_MEM_GUEST_MEMFD) {
>  			uint32_t guest_memfd_flags = 0;
>  			TEST_ASSERT(!guest_memfd_offset,
>  				    "Offset must be zero when creating new guest_memfd");
>  			guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
> -		} else {
> -			/*
> -			 * Install a unique fd for each memslot so that the fd
> -			 * can be closed when the region is deleted without
> -			 * needing to track if the fd is owned by the framework
> -			 * or by the caller.
> -			 */
> -			guest_memfd = kvm_dup(guest_memfd);
>  		}
> +	} else {
> +		/*
> +		 * Install a unique fd for each memslot so that the fd
> +		 * can be closed when the region is deleted without
> +		 * needing to track if the fd is owned by the framework
> +		 * or by the caller.
> +		 */
> +		guest_memfd = kvm_dup(guest_memfd);
> +	}
> +
> +	if (guest_memfd > 0) {

Might 0 turn out to be a valid return from dup() for a guest_memfd?

> +		flags |= KVM_MEM_GUEST_MEMFD;
>
>  		region->region.guest_memfd = guest_memfd;
>  		region->region.guest_memfd_offset = guest_memfd_offset;

Refactoring vm_mem_add() (/* FIXME: This thing needs to be ripped apart
and rewritten. */) should probably be a separate patch series, but I'd
like to take this opportunity to ask: Sean, what do you have in mind for
the rewritten version?

Would it be something like struct vm_shape, where there are default
mem_shapes, and the shapes get validated and then passed to
vm_mem_add()?

> --
> 2.50.1

