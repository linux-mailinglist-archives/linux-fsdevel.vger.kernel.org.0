Return-Path: <linux-fsdevel+bounces-74020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 045ECD28D44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 22:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B76A300E43C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 21:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A60432C92E;
	Thu, 15 Jan 2026 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ow6+L3Jv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B730F539
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513653; cv=none; b=h1zwMGz2ISKZ0EXrAeGLpZMGbHgojk342FXGPfsflCfcWFwHlYt5Clzcnia4hF1LcYL6KS6dFpAIr2hEV/3mf6KBHms5CYajtq9/ruoxQ6+v7JS08RQRrHztkKunPXh1g3eOQ2LYaQKyWIFORdsyKwg7XTeXYvMrppGvKdzC5eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513653; c=relaxed/simple;
	bh=v118hUkz4tlXR7MqYZI3xl/4gAf6dCbuf95gCRXXIrU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoF4d1y8S6lltXQhZidpDp/5LMrj269lSfBGVr0NbQzkQIzfY1pj/rZvAu1dKJGXhYIZ4yQCIuhgB8Ngxrn0hrdnbM6xx2SPYQllButNDJgetBKiDrg95hUi7OAel4hnI8bmZM3HsMyJrqTRvEbGxC+Z+xavOeoa8/GALW4r39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ow6+L3Jv; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-55b219b2242so901597e0c.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 13:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768513650; x=1769118450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YBmCHfpLlL8iGEYc8icjykZfZHQFfzihdrkSCqexEsw=;
        b=ow6+L3Jv9a/FkO+DpFkWjzwxsnboP7BDQZScRUf4BezPwQCrkSMSMdYf1Eqf6BvGoH
         pGP7EH9rXmLpU7QEe2PXrWahO7DW6ZE8yy0GGGakUxCd2ObgGyBsCvBtqGIgZMwrBkJU
         m5Lr3KT/UxOUCiTfJ5fdryYau02usZAzhAxSq7cnbduQBogZc2JrNCex9HxiBKdhrOE4
         x6jn5u3DMpCyqlToH6Kata50cPEWXrWlmfoXz2Abj74/usGSAMd5Bs5RWA7YRrG/LSCU
         mPSUTpEsrng87GMRSWr+bQ4IiCpqJ0CRkyzc94YAR3798ZRpFEM+pzCznojcUZvgjqsL
         bIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768513650; x=1769118450;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBmCHfpLlL8iGEYc8icjykZfZHQFfzihdrkSCqexEsw=;
        b=YelFXoxnFFGLyzMI5EOTsyCDw6e9OsBmazooth6xFJ4YvEAcSgGPjuPtOxvRHgF6Fv
         MhEsHv6Fqv6nCUhd30uGKfixz2xb24491jdnkPSPUfp6BHY/tjQXrt/8IY06f0k4uZIs
         2MKxqxBjJWh5rfJTLnlDdS0ly4TfN2+CjySbS+WEyyz4gh2M7wf0aejOs/vkjOfOoMeK
         g60WAoS7yVvGDSPdniAXMjA/vup22AbktDZu6DTc5HdVGg5xAu6l6gzFFr7URFz9jI0d
         XL0hP9COkXGSRnULmv7hQ+I7E0wbN88FNkexD6kXftbW1TL8UYcw/1eGbbroi0QzE2mE
         lv+A==
X-Forwarded-Encrypted: i=1; AJvYcCUqdDgeIKN0lWLmJ9jd5RH2DAxN6y8l+yAB8pJ3SPsN+b8olcOy4MSJT0zSX7Gj6/IuxqZR70ISvpRlgQvC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6q2RplLn9yldUXEwKI5muw9VD0nNYrqLupoU3dvJlolo4Y6tv
	kd7uhNeyPHXh81zThYPJk4OSQFuIOYbkwO8973E4YC3HB9I1nPdSDbmkpY240lskVYQSQcoEQi3
	39yB34JGZnaf2OHQqLnJM1v3gni4Noa/i1ithynOG
X-Gm-Gg: AY/fxX5qXiKxX6OgwDdxh1YL8VnYcjLZtHFV29fq5MztgTxjlqhI0yWTMMvTRzNa8mH
	gwCK+p6vhe+QRDzhj1JiRXcu8sj565RTFMaYEqe96p2Ees3JzJZwgvRJa0CUm4O83x0qx2UBD4W
	K8T+fD74mkbnCMyQ22SfOwHRWeDxaoXvEoOQRgWSbNi4M+yIx29LlVBRJkmB+MlS4js+HsQj8kB
	fAbbafF3dF8ZkfXxMbZRjPGzFXW3nv6zkx0DXtP/XWVR1z3H6Bf35s+sUKkeDhlGPoEGjYHgH26
	C63E6idqCbSOP9U2OxpACCdDQQ==
X-Received: by 2002:a05:6122:500a:b0:563:466c:2 with SMTP id
 71dfb90a1353d-563aa9aae66mr1528951e0c.5.1768513649399; Thu, 15 Jan 2026
 13:47:29 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 13:47:28 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 13:47:28 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260114134510.1835-5-kalyazin@amazon.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-5-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 13:47:28 -0800
X-Gm-Features: AZwV_QiX95-0WFEZIhu3a0jzKlg7ft8DnUjTu2uxi7sdZ3xYcaUb3m6pe5q87wE
Message-ID: <CAEvNRgFihTZg_-R8yEytDLVxbiF34nFgTEsghMp6tzBvazVqoA@mail.gmail.com>
Subject: Re: [PATCH v9 04/13] KVM: guest_memfd: Add stub for kvm_arch_gmem_invalidate
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
> Add a no-op stub for kvm_arch_gmem_invalidate if
> CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE=n. This allows defining
> kvm_gmem_free_folio without ifdef-ery, which allows more cleanly using
> guest_memfd's free_folio callback for non-arch-invalidation related
> code.
>
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Patrick Roy <patrick.roy@linux.dev>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  include/linux/kvm_host.h | 2 ++
>  virt/kvm/guest_memfd.c   | 4 ----
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index d93f75b05ae2..27796a09d29b 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2589,6 +2589,8 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, long npages
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
> +#else
> +static inline void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end) { }
>  #endif
>
>  #ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index fdaea3422c30..92e7f8c1f303 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -527,7 +527,6 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>  	return MF_DELAYED;
>  }
>
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  static void kvm_gmem_free_folio(struct folio *folio)
>  {
>  	struct page *page = folio_page(folio, 0);
> @@ -536,15 +535,12 @@ static void kvm_gmem_free_folio(struct folio *folio)
>
>  	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
>  }
> -#endif
>
>  static const struct address_space_operations kvm_gmem_aops = {
>  	.dirty_folio = noop_dirty_folio,
>  	.migrate_folio	= kvm_gmem_migrate_folio,
>  	.error_remove_folio = kvm_gmem_error_folio,
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  	.free_folio = kvm_gmem_free_folio,
> -#endif
>  };
>
>  static int kvm_gmem_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> --
> 2.50.1

Like this change, thanks!

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

