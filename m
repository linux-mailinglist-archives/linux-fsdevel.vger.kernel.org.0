Return-Path: <linux-fsdevel+bounces-62716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17076B9EDA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2CC1B24509
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8208F2F658A;
	Thu, 25 Sep 2025 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agBtVbfR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237991D63D3
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758798181; cv=none; b=pNsFVh+1BoeqH9P8pPJTZ5e3TmpsyivbmtDdm4lLpfOiXStZzmGMN+g6MXyke1B/IZ87x+WSvQ9mFG9Y3wCD8h8eIXnhAF7wSuZ0Ojk6VxTTG67S25jS2s9SLmkTg9MNTFKCInsguksdT3+rabV6gUJSMYY4YoQHuJtJNc58loI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758798181; c=relaxed/simple;
	bh=SPatiG92lX3auhrm3NKSVGGSWaunSoiZhUXuxVMKexQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5IskWWTALPgeHXznhM/IJQkyM/8ycdoeWtyZWxMI9tZ2LUsNMQbVkD/zm1bsdmdv+UYYk3AJLo4du89MvRQg1zNPj+It4qesqmRawWeRHtiGhyO2Ow4oHUCYGdOm60BtQZwNA8G73Te6f1DdHnVNSL+WWzmY6rSgUvCgd8ARVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agBtVbfR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758798178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=r/0to4OyeGm89Kw4M6wzRihwRzmpUZBpw2U3yaSo+SQ=;
	b=agBtVbfR/CDX62ZoTjQe3JL2DvpN2tvcwRsuc9yztOA828Br8uHlzDG56G03045wsv/U/8
	Typ9Sex658vDfJ509O5ol2e8YOCFIWXlwaGBxwOeXsdvKVJZpSuZ53LsjBKm7ehK8Mgi+4
	qtg1lZOXLuEQoq+WBusxCzLO0WBEEk0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-GIMXdYa1NyOC1t5Z5ZPtMA-1; Thu, 25 Sep 2025 07:02:57 -0400
X-MC-Unique: GIMXdYa1NyOC1t5Z5ZPtMA-1
X-Mimecast-MFC-AGG-ID: GIMXdYa1NyOC1t5Z5ZPtMA_1758798176
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-40fd1b17d2bso256522f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 04:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758798176; x=1759402976;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/0to4OyeGm89Kw4M6wzRihwRzmpUZBpw2U3yaSo+SQ=;
        b=LW4GNGJkFCkUW7RRJiRLd/kf80SYI/1p1qJOgqFHJAZo7EV3qByB3PFlSoFICCXPx9
         5k2j0KCG1slTBcEN3m20NOHCwGDVsW4QkS5kNAHELN7Gdks9PjKcsZlhR9iwPbnseOug
         JItHxMrYC2WceW2Uy5hj4SmPIq9YajyS7Cb9lqHTkhzsngV+TO2P9jgZYVxpjyIVNB6X
         0D9B4c01ALJDJju1zXRICLrxBr24bpwAs6zCqO18WdD/18l+FRrUNerBWVmENu/XW0zU
         p1+/XJb+wEHPHLcTli714DNV17/kRUk9xtIH36FRP4BB3ahbBi800/Mzom7oquCywOCJ
         DYog==
X-Forwarded-Encrypted: i=1; AJvYcCX/U5x7RNMnasb2N8T7ny1eP9MWNLxDZOFmXoL6Dr2SAupH42VhqPUujfoL6JS/IUkuu8JS3lmRZ4TTtRqr@vger.kernel.org
X-Gm-Message-State: AOJu0Yym4xQ/c0A9q8vJZWVh1ovUVjx8ZYdSzX2wKpLGpLTudJx8lnH1
	cQea8tvHXMqeyjrX2R0qbk3wgxD21nrgOXLJuziywVnfYSMB/KEsN4aOkQ4ujVDt2I96ZbNvbTj
	rLqI45ZIHgjxfxznE7XEXddKLv1r+55r7dgNVoH3qsKDA1PSRsRCPKL99HT78Wa0ICCE=
X-Gm-Gg: ASbGnctIGdophgrbK+oaLTsZDWSOoTOdV5tvJmsTYgJPwLOfxhwmpu5RMcQjRqSIngY
	ROnN3W7C9fnB9Rw8HdU/0kWkg56i4RtUz/DyLMGB1QiscCqcqIpbRrhhm6q2/VKlrbG5yT6Iw/x
	bY5zzDL8pmlhcZ5we6RMDxlxev42ss20aRpE8ezLyljTLFa9c/ygNbA8XRGVlRGj5xXTqND8gz1
	daSeNPQbr8CXWQtGRnPGfgAAGqcw9nW7sjC9sIRoPJRkcqAwHQDP4ddBslWYpXxJprV+bbCiWDT
	pm03sZvlMOJNDtD7AToKCafiv6lw8/e8pr0FjdGlNJV3teWUhjSNRlwDU3NloGFP4Ddpjj4zreX
	fkHWdNMT3J9ooKH1b9nqW4Y4OLkdEJ5YtWCOCovCmSwYe4h/p0zSaVhlPDG+CvXTLzjnd
X-Received: by 2002:a5d:64e6:0:b0:3ea:6680:8fb5 with SMTP id ffacd0b85a97d-40e458a939fmr2659865f8f.2.1758798175613;
        Thu, 25 Sep 2025 04:02:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaRjs0B05ZyXvh1d6jlu1Ktfb++k8xqGa0tdnYe8v/SeU1yGa2CE1nYchZ3/8IlcM8uOiw9Q==
X-Received: by 2002:a5d:64e6:0:b0:3ea:6680:8fb5 with SMTP id ffacd0b85a97d-40e458a939fmr2659768f8f.2.1758798174621;
        Thu, 25 Sep 2025 04:02:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72facf9sm2650164f8f.13.2025.09.25.04.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:02:53 -0700 (PDT)
Message-ID: <cf57bdec-6a2d-4d6a-b27c-991a7e2833ab@redhat.com>
Date: Thu, 25 Sep 2025 13:02:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/12] KVM: guest_memfd: add module param for disabling
 TLB flushing
To: "Roy, Patrick" <roypat@amazon.co.uk>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "joey.gouly@arm.com" <joey.gouly@arm.com>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>,
 "surenb@google.com" <surenb@google.com>, "mhocko@suse.com"
 <mhocko@suse.com>, "song@kernel.org" <song@kernel.org>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "andrii@kernel.org" <andrii@kernel.org>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>,
 "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@fomichev.me"
 <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>,
 "jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jannh@google.com"
 <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>,
 "shuah@kernel.org" <shuah@kernel.org>, "seanjc@google.com"
 <seanjc@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "Cali, Marco" <xmarcalx@amazon.co.uk>,
 "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
 "Thomson, Jack" <jackabt@amazon.co.uk>,
 "derekmn@amazon.co.uk" <derekmn@amazon.co.uk>,
 "tabba@google.com" <tabba@google.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>
References: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
 <20250924152214.7292-1-roypat@amazon.co.uk>
 <20250924152214.7292-3-roypat@amazon.co.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250924152214.7292-3-roypat@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.25 17:22, Roy, Patrick wrote:
> Add an option to not perform TLB flushes after direct map manipulations.
> TLB flushes result in a up to 40x elongation of page faults in
> guest_memfd (scaling with the number of CPU cores), or a 5x elongation
> of memory population, which is inacceptable when wanting to use direct
> map removed guest_memfd as a drop-in replacement for existing workloads.
> 
> TLB flushes are not needed for functional correctness (the virt->phys
> mapping technically stays "correct", the kernel should simply not use it
> for a while), so we can skip them to keep performance in-line with
> "traditional" VMs.
> 
> Enabling this option means that the desired protection from
> Spectre-style attacks is not perfect, as an attacker could try to
> prevent a stale TLB entry from getting evicted, keeping it alive until
> the page it refers to is used by the guest for some sensitive data, and
> then targeting it using a spectre-gadget.
> 
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
> ---
>   include/linux/kvm_host.h | 1 +
>   virt/kvm/guest_memfd.c   | 3 ++-
>   virt/kvm/kvm_main.c      | 3 +++
>   3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 73a15cade54a..4d2bc18860fc 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2298,6 +2298,7 @@ extern unsigned int halt_poll_ns;
>   extern unsigned int halt_poll_ns_grow;
>   extern unsigned int halt_poll_ns_grow_start;
>   extern unsigned int halt_poll_ns_shrink;
> +extern bool guest_memfd_tlb_flush;
>   
>   struct kvm_device {
>   	const struct kvm_device_ops *ops;
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b7129c4868c5..d8dd24459f0d 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -63,7 +63,8 @@ static int kvm_gmem_folio_zap_direct_map(struct folio *folio)
>   	if (!r) {
>   		unsigned long addr = (unsigned long) folio_address(folio);
>   		folio->private = (void *) ((u64) folio->private & KVM_GMEM_FOLIO_NO_DIRECT_MAP);
> -		flush_tlb_kernel_range(addr, addr + folio_size(folio));
> +		if (guest_memfd_tlb_flush)
> +			flush_tlb_kernel_range(addr, addr + folio_size(folio));
>   	}
>   
>   	return r;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index b5e702d95230..753c06ebba7f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -95,6 +95,9 @@ unsigned int halt_poll_ns_shrink = 2;
>   module_param(halt_poll_ns_shrink, uint, 0644);
>   EXPORT_SYMBOL_GPL(halt_poll_ns_shrink);
>   
> +bool guest_memfd_tlb_flush = true;
> +module_param(guest_memfd_tlb_flush, bool, 0444);

The parameter name is a bit too generic. I think you somehow have to 
incorporate the "direct_map" aspects.

Also, I wonder if this could be a capability per vm/guest_memfd?

Then, you could also nicely document the semantics, considerations, 
impact etc :)

-- 
Cheers

David / dhildenb


