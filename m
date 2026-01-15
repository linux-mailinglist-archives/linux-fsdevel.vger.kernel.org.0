Return-Path: <linux-fsdevel+bounces-74021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48177D28DDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 22:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80E6A30C7BB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 21:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB66C32C316;
	Thu, 15 Jan 2026 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cqSIEd9q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DDA32BF5D
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513693; cv=none; b=q9/yrMEDSi3hDJRJCO2mz2+ANtqeFw+pDVw24KGs8r3bJyAylKcg/dqMP09EY+QCKUqmSTUp1kNVnEp5N1Bf4izwrpQ6/h7ziCAQUSloqgR8mTguHWmC7iM75hG0llQ9R/LrupOhVkx3DXzB1DOvR2hY58xKUphKDkDlQnoYVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513693; c=relaxed/simple;
	bh=MU9UbiYSxwq7GU1nltEpbwVASUYpa31Sn9dlFINSwh0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgR2D4kB4f5y3xRjSwSkFrRYmT+IygeFvsD7cuBjFbr+GsvDplmp1o/UZSW9vbZG8ksfxA1dO/bYa6qlI9INTTA74CHnmZPcBS8ge7XPC8VTwqSsUmpvyVBb8RfAZ3B34bu288PQTPIMfl6pvcl3PyNnvURcw6lcssogJoMPjb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cqSIEd9q; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5ef31a77afbso1723966137.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 13:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768513690; x=1769118490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1tpnpSOuS/Js87YOF2H5fRocDrhGRoFky0mpImVftk=;
        b=cqSIEd9qiHPgHv9gnqDiu3reQxfeO0tkgd+5NyxqoUiXxTTY1xYs5N+D/Yx2VTOgAw
         oZhH50bnPM0uhtaWpNGAtaAjBrF9FHEA6YxnaaZr7riCjv1BNC6qtFmk69RNE7r53SHx
         VKXyzCi9Y0qQdep1iIB8vbfhubd3t1YJARk+m+3+wPLxcE0/tRfVXdnm1ll2ORSvmMwY
         3xsuvbANRR0TTYvFAw4FJATQ4OkmIw7nTyMGisctV+OhlabYE21bB5FivmZSc+CqXZ/B
         vvEqYQtxJl+71+fJSkloq9e0rjHwNgX9T+y+ekloRmiVSCZPQUApt7UCEsBuXHbYG+Qf
         rykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768513690; x=1769118490;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1tpnpSOuS/Js87YOF2H5fRocDrhGRoFky0mpImVftk=;
        b=oY/2VrekMBF1DKU2wIVjYggFO0h9XUnh/jD8xE0OUqssl8lFvby04GUTp1TlVliWJz
         mwomUHa8/OMK7+1BuH3Ifm8Nz1aDCBswmwp+W60FsHDHiXw8DXe/V2OsUSehQQQr8r7I
         R4Fu4iLVKSC32SON7v+kbgzGTsQxG4jFCVs1wga8Gkt1N66XdL55PEOBgQKmJBeorLe9
         ROP5rcQzgoY5IoVN4QeWCyH4PgrZ4Qhn00wMnM42I1+qIAjW+9VIRgK1XZkC6La2fUSk
         YoHOAm7/755t8utWuZ2zkI0McMmUwxmbaO9JX6my2GTxcD1N0QuYenhMypQb9oQ33c7x
         vHLA==
X-Forwarded-Encrypted: i=1; AJvYcCVw0sw9DJdXjNbozbEBjKknr3KZ3VaR2IU2p22m83Gk5TvXgsFaEn45Jufh5nQ0W0x5udx517WtwPmFXckN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4CBZ6DVhbI2b+Z73nEDxMhzTUxDKB6735zXCd7U8J5CgYI2cE
	sfFHjspRmisAd0NRK95TL+loh5fiMvf1g47VUd8MTSzdBafx89HXCSbHxJBwM7ePvNTKL/RdMwQ
	1d1E3k+uvbRYJbA3fBBHx8DriXz+2BwnkBb2ZmxGM
X-Gm-Gg: AY/fxX51rLQz00YccKJJ0UNUg/3WfdE3SnqCwaBo2AIcgxoQOJmuzjHsG40Pk//i6LT
	AYhErnFSpJtzp+VYEqXMW+xlaZ4xfzlvx8fa2p90Rol35UoPABZO0qTarzySTJVTB2WAVYRM2NX
	hJB4a6CGIwqFsTmf8vYntBPlQGvaLLQkQ4YGpOQPFYZEPy/rOIrD9/J4LS3fALLNrXa5a1qb/l1
	tvS0UbxzPvwLW3/WDdX41uyUom5cFzKk0Eo3YOIhfuvqmGeuiBC0rKwJAkHVDb37Nwk9UGpsEqZ
	aWkrX13Kno9P4lLc8JAuhVZzG3VQ9jvKaYgQ
X-Received: by 2002:a05:6102:f13:b0:5ec:3107:6b71 with SMTP id
 ada2fe7eead31-5f192508297mr1821684137.14.1768513689093; Thu, 15 Jan 2026
 13:48:09 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 13:48:08 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 13:48:08 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260114134510.1835-6-kalyazin@amazon.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-6-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 13:48:08 -0800
X-Gm-Features: AZwV_QhGkMBioMKFssSOB50hq7Zm3qSZq1aP9Of9c8wem-vUHGjRo2vWaCWRwKU
Message-ID: <CAEvNRgEhcTE70RLiQo2C_XUdF31qSkQ6yHwpUiXPWb6+6mmA0A@mail.gmail.com>
Subject: Re: [PATCH v9 05/13] KVM: x86: define kvm_arch_gmem_supports_no_direct_map()
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
> x86 supports GUEST_MEMFD_FLAG_NO_DIRECT_MAP whenever direct map
> modifications are possible (which is always the case).
>
> Signed-off-by: Patrick Roy <patrick.roy@linux.dev>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 5a3bfa293e8b..68bd29a52f24 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -28,6 +28,7 @@
>  #include <linux/sched/vhost_task.h>
>  #include <linux/call_once.h>
>  #include <linux/atomic.h>
> +#include <linux/set_memory.h>
>
>  #include <asm/apic.h>
>  #include <asm/pvclock-abi.h>
> @@ -2481,4 +2482,12 @@ static inline bool kvm_arch_has_irq_bypass(void)
>  	return enable_device_posted_irqs;
>  }
>
> +#ifdef CONFIG_KVM_GUEST_MEMFD
> +static inline bool kvm_arch_gmem_supports_no_direct_map(void)
> +{
> +	return can_set_direct_map();
> +}
> +#define kvm_arch_gmem_supports_no_direct_map kvm_arch_gmem_supports_no_direct_map
> +#endif /* CONFIG_KVM_GUEST_MEMFD */
> +
>  #endif /* _ASM_X86_KVM_HOST_H */
> --
> 2.50.1

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

