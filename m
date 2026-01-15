Return-Path: <linux-fsdevel+bounces-74011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20514D28A29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 22:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03C983015818
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 21:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9D2320A1A;
	Thu, 15 Jan 2026 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4XJgfLQP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394FC322B90
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511230; cv=pass; b=OsSJZNnYRv8PAoU/UE4lKhk4brQEIMcf8O1kg84IVPBWuYAQfdFn/cP+A1L/KlW8fVY+kWn6dYXYSg1xVIhplCBeDCSfFtMLr1kOY6p7sI8LxUmHUMeglRf1TUdYlCDeUN2FqFw4cDSDer4CVQgBODPyCV5kTse3E+kS1zIk2UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511230; c=relaxed/simple;
	bh=Yj5Px6CBHG4dfhDnY0aiL+o/Xd3AGh3M1dNNpc7+Hj0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIcSzXahC9405z+EfPz+iuZNsR8TyXV+FLmNcjQry1pVppmelTiw1ScFmUolRFynLlX76wfxjElMlHJ+LhZAZAuzUKSCvDVEIXH3vphtH7zx4xnEKc0Q6j6kZVLmpuYgP5jiGdUrVAe0RmNNZxECjJ5z//VoJjRxfDQ4BtzyPqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4XJgfLQP; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5ebb6392f58so456502137.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 13:07:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768511227; cv=none;
        d=google.com; s=arc-20240605;
        b=Ae9CDJsnmQi0dYo54ES3ey9z4/RJC1egerQAd7LzMMHnAytHZKkcSWBRKypYELkxeV
         MjA4H10G2ssH7uJa28jS7HBhkt18foQuAL7KpPDNNdfHAF0u6BcJlGLnkoNydZe60Ejw
         Z11beYxL7kykl7pBGiLgbHANZE5Mx0WMzehG5SCLWCoY0XrFxtsNE9O0117y1TWJ19uU
         ViD9YK10ehH6vC6iq5Z+WcYxiqOnIi6RYN/5n9uAbN/IQ8XboEOi8EyIycjjZJZCs9yv
         ta1uRBfT/JqMuV9r1FC0RRDok5LE6brFdu+Xl5zShjwWNdB6TcvKumuQuZauZcw3bgXf
         CQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=y4BwArZ5FLhyM5BEN34gjuDvwbvdpN2Nxoskvco/5nM=;
        fh=UHNpbxQvFZE+9oYCDP6Fs7svNugHmAVrplAFvCL4Nq4=;
        b=CM19sv61IPcQ6f/w8oj7u481V22TPTj8PyLso0fDhxG+44nfqTcigDn4glPpI3noZG
         BbmpUHju8z1ydcJqOcn5ACl2yVZjanYDVnDZYIG2JnbFUwR5/NIMyt1/2LS+AXEGZj7+
         QXNBKxCckfqd5KsN0CAZEuuMdlJCQUeByWQZC42/wPg1+DuGs9njIlTCOGMzpi20yL+1
         +efiN50Alnu1dfjyEfy6TTH856dvbucDlpqWS+b6p9kpiL6vyBM8Ii9VvnZFvuxetMfk
         PLfHdq/g7P0fkwHR1thhhEab2hdoyEFEdVkx3FNtMSxoMzsBLhVtMLFvzmhfNJpk1xQJ
         +9hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768511227; x=1769116027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y4BwArZ5FLhyM5BEN34gjuDvwbvdpN2Nxoskvco/5nM=;
        b=4XJgfLQPzxM5FXWJkEQS/kXTzEqlaoNNsykVgVssx9ILv7rH2f0RPJB0Dsm8qrAms2
         ca1bhsEOHx0BFLwVRFmof0lTpYymrpbdRKK/1/bgNnjBFJ1AA+33K9xdNQSiAbvhG8Vy
         kL1ZSO+dansx6NIyFH+a86drC/+BMsplkmTtJSR9nFM0y3dL3IKx8KoAfTFU2xpZZJqf
         kXdl+n+ILpES0C/0nzoY1zoUXovu+P1soJ4YMJl215plLGiz7WqYtLuFdstWhf3zf/0K
         vN6yKSUSFWHjiVS56FlbC+Rx9vxZCxMtufdgDE6UWoEzY472DLjt5vOicDkHTSjO/ErR
         NXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768511227; x=1769116027;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4BwArZ5FLhyM5BEN34gjuDvwbvdpN2Nxoskvco/5nM=;
        b=ax33mgqfS/OVgm2jAUCp3c+kabSEafhVYKh94wIxKSXcRoHnuH6tFJsuM55pg2Ep4V
         gZjBnmII2zVYetgVde6cKZmiP5AsqHfLRK/8BYmjd2EY1LMiU3YLsDOGAwjgFHQqzX5I
         zJBq8PQWn37vWPI0oRQUwrYvsTbhwQypeoF4wN29T6AgpFPpfAQP6zf+pYDGpsv+z1kS
         mIM9D6OwZeZ3XI31Uuhis8/z2q1KQrVtZGuLV2NgSt5m5tCY1GYYpIHPGw1mwYflOmTi
         gG1K3xt/fh+ATV+ethT0W7GMJ0/UF6ySuMpkC4ky0p0epL8/tFfYvr00L4uo1M838Kzy
         t1Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUs+u+1EG0sFtbTu8POzrx/Hxggfhx6y5j7CL74+i03rIjroFbpWbHOjlpRmpY7BUPPCmfXOJKSnaG8FxfZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cjSaJZeKrm0WccsZwqpamcCjxXv6Wel4gl2GRY5jw7pwEsqm
	8c02RebTYvHdjkHc2BNM+f6mqnj3epv/4uNZkMQ5XBG0E0St79+J2meiohNrHUzqFkrptVL8UIV
	LMv60GQqhx6zrSKuGFkhtMTGEOZ4r5Q0fRf/PTu9H
X-Gm-Gg: AY/fxX5XntA4kXgz08NgK4ndHi4ACka2uulhAOPaVQGQPs8wIJqrTOu5RIwMCxWxScK
	xRJ1SLueJLjAD4yN+xYq4mHbe29bEVd89aBG0YXtmpt3O21xKGTg3jMSB6pBZRsQBV1F9UQbDew
	nFhX+E9b4ooUTeKgyGW5UNiSyNtKPT6n4QfOgm7zJvPfyfAqmjjZlLqCvpEDutZAPpMDQ7LIVxD
	zrUya5um8wNMGfsgBHI/Mk5LodUpwY+CxLj66NfAELvpPdj/n4PhQ/fq9HLvEwOvBLFqAVcF4xS
	ydrvlrpoiEBGptZYoviDg/eEDA==
X-Received: by 2002:a05:6102:945:b0:5df:aff3:c41c with SMTP id
 ada2fe7eead31-5f1a719e362mr155618137.30.1768511226367; Thu, 15 Jan 2026
 13:07:06 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 13:07:05 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 13:07:05 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260114134510.1835-2-kalyazin@amazon.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-2-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 13:07:05 -0800
X-Gm-Features: AZwV_QitN6L4bb0XJb_ZZH7nFdRT7CH1pyddv4cbgutSArI7UeCs00Q7KzDEw7c
Message-ID: <CAEvNRgGXeow48BUJYyuAOUp8qK97v1LdF4KdTB=Nbk7pTs9tfw@mail.gmail.com>
Subject: Re: [PATCH v9 01/13] set_memory: add folio_{zap,restore}_direct_map helpers
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

> From: Nikita Kalyazin <kalyazin@amazon.com>
>
> These allow guest_memfd to remove its memory from the direct map.
> Only implement them for architectures that have direct map.
> In folio_zap_direct_map(), flush TLB on architectures where
> set_direct_map_valid_noflush() does not flush it internally.
>
> The new helpers need to be accessible to KVM on architectures that
> support guest_memfd (x86 and arm64).  Since arm64 does not support
> building KVM as a module, only export them on x86.
>
> Direct map removal gives guest_memfd the same protection that
> memfd_secret does, such as hardening against Spectre-like attacks
> through in-kernel gadgets.
>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  arch/arm64/include/asm/set_memory.h     |  2 ++
>  arch/arm64/mm/pageattr.c                | 12 ++++++++++++
>  arch/loongarch/include/asm/set_memory.h |  2 ++
>  arch/loongarch/mm/pageattr.c            | 16 ++++++++++++++++
>  arch/riscv/include/asm/set_memory.h     |  2 ++
>  arch/riscv/mm/pageattr.c                | 16 ++++++++++++++++
>  arch/s390/include/asm/set_memory.h      |  2 ++
>  arch/s390/mm/pageattr.c                 | 18 ++++++++++++++++++
>  arch/x86/include/asm/set_memory.h       |  2 ++
>  arch/x86/mm/pat/set_memory.c            | 20 ++++++++++++++++++++
>  include/linux/set_memory.h              | 10 ++++++++++
>  11 files changed, 102 insertions(+)
>
> diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
> index 90f61b17275e..d949f1deb701 100644
> --- a/arch/arm64/include/asm/set_memory.h
> +++ b/arch/arm64/include/asm/set_memory.h
> @@ -14,6 +14,8 @@ int set_memory_valid(unsigned long addr, int numpages, int enable);
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
>  int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
> +int folio_zap_direct_map(struct folio *folio);
> +int folio_restore_direct_map(struct folio *folio);
>  bool kernel_page_present(struct page *page);
>
>  int set_memory_encrypted(unsigned long addr, int numpages);
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index f0e784b963e6..a94eff324dda 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -357,6 +357,18 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
>  	return set_memory_valid(addr, nr, valid);
>  }
>
> +int folio_zap_direct_map(struct folio *folio)
> +{
> +	return set_direct_map_valid_noflush(folio_page(folio, 0),
> +					    folio_nr_pages(folio), false);
> +}
> +
> +int folio_restore_direct_map(struct folio *folio)
> +{
> +	return set_direct_map_valid_noflush(folio_page(folio, 0),
> +					    folio_nr_pages(folio), true);
> +}
> +

Was going to suggest a _noflush suffix to these functions, but saw
Aneesh's comment that these functions actually do flush_tlb_kernel [1]

[1] https://lore.kernel.org/all/yq5ajz07czvz.fsf@kernel.org/

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  /*
>   * This is - apart from the return value - doing the same
>
> [...snip...]
>

