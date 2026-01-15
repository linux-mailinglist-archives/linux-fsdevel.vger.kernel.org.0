Return-Path: <linux-fsdevel+bounces-74018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DCCD28C70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 22:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05FDC3014D7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 21:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B20A31D371;
	Thu, 15 Jan 2026 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lf0IKR0g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A031A7F7
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513233; cv=none; b=hG7akJgQwf/epvuqfoMeMKZ/ethcYgjQh80BHLbK90CMRnzplxp/XD2wMl3c9MGjtO5702WnSpehW2VxsdRVA93vzwr5xtla9oIX7hj7C9nb/pkwIsW5G93ly1cSxDVQS6LEJddnmvDl/KEl44aXbHWKThKQtaZiUy7FA5k6j94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513233; c=relaxed/simple;
	bh=YLVgLT4dUXUIoNeLlkn8NPNLP7+k5vVkNVKFyec+BfQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwMSN9lymQ3TPrWWLpVCGjRU5vt3c7HeBgtycaICUrvsn5Npx0TTJzZ+JbxbcRtNUj+DhhhULA74rCCnm3VGX+cf+JSC87lZdae+v9QLod5N72NmokGqnkL9tVJ6QOQKJWupEkxlju5Q7o9Xjo6/8J4+FHBtJntZb4mnb/4euY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lf0IKR0g; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5ec8781f5c9so684687137.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 13:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768513230; x=1769118030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4NEsY4l4MT9Q6cBqefYtZtOy3s+dR+V7JNDYTBav7MA=;
        b=lf0IKR0gDEJm+zUkDVWEQnyz02mUC38xJjNWbxZSufD5XA2asUWXVijSwCfiKBPOEo
         PWN0zwI9sbPy850jxDVGg3EN1phjW/RLkghF6vpgkgT1eMMOq+IVHCAkG8t7iYLBGiOE
         2OQJ8Kkwp1PkAL21akSXUHTuAQZYWtIjKjOFMCceevZ4tbWRG2lu9qaLd0igq4PRS2Oq
         5C9Ws5/HnJ/M7rLBCJlfM2cq/whe6jHVp4dGrx++x1Icu8+oXFrSjrCjM8PGG6OH8etg
         9G/QMJ8xqIdsHm44z702O6VasJ7Wmk3KV1SKqu5ZlOO86RoG83E0DFzJadJAts6MtxKr
         vxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768513230; x=1769118030;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NEsY4l4MT9Q6cBqefYtZtOy3s+dR+V7JNDYTBav7MA=;
        b=CUOG+EHZ4VNvfmtnCTgs/IaHtT9XseeIwH/L0ypY2PCLj79/tX4EUYj4qTJZij6gr8
         Lfygs7vla2+wJczZiZoHZSra448u0WvCfsGfYxK1jzra8XPlpp4/vJWUAmWt8n1dsxRU
         pDLMFY22VpJHvLAegQrcWLPRg5Zsw37CwmmbA4gVnO64LkxDKkoot4OGjNvfsBhCaqYe
         Roxm5G/nupJSOQgZCaTGrFAr63YEWTSEtI5rkNcqKYS4KlXF+U3LTnUSuodX6lABK83i
         1TBHTuogh1Sq+HzrW6Gn10R5ZHY/NuU1/P7ONa+1kYj6NgFSnVGogpH/m7YP//RHWCT2
         e5rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjn135mWfQuy/UQr1dcyECr9AhPPuoujrrCoLCaNG3H8Ol69tt1Bu34cOJgCwubd11noBBJtBWJT41TO0P@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs9cTxITuWWSI+N1hrATb+qit5sKvZMiicJmWMgI3IPe/4ALOQ
	3qBVdl5s5/zb1bZ8K+iVC+jzfconEdchBEYHap9YVzaOC3T5gKzYZB9mA0X1Ji9tlBZRQ1toiIj
	VNhesCuq+TVCVRuR+hEnsJ616j1iRjZoGASLy9rJt
X-Gm-Gg: AY/fxX6N+1icc1RHH+0hFP6R8+UMHYIzmdtccsu9Gus0BKmovpHGlCXB66QSyOSO615
	hXaBm6ZYtPnVo9xp7lXSppuGX4FxbGfpDVEpdUkOyPhcXEj8nxiDu3sLswGjAlCXKmtihpo7ASc
	9sGcbsRuLhBXpeiPDc3Hql9LcOA9fpLC1vZ5dDm9yvGtJGzBTdiXimG5UQUzQzICA17y4ilnrDb
	85Mhk6ipzzjoQDGX31DvC09pN5TSYFHTTfdEPwNHYxMjaH9DzLPgNp6nSsN1NtPA2lxWVlQ5HLH
	L6hPl8dHpqZkdZmkZOw8OUR63l7uF3Iv+DFZ
X-Received: by 2002:a05:6102:947:b0:5db:cec7:810b with SMTP id
 ada2fe7eead31-5f1a556dabcmr465899137.29.1768513229577; Thu, 15 Jan 2026
 13:40:29 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 13:40:28 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 13:40:28 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260114134510.1835-3-kalyazin@amazon.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-3-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 13:40:28 -0800
X-Gm-Features: AZwV_Qj-0gm6vYHJJ3iH96aBpuGEWZXgwnMiQkeNvlZWuDVc-Nc0GygCth2Cvyc
Message-ID: <CAEvNRgGrpv5h04s+btubhUFHo=d6mBFbr2BVrMt=bWuWOztdJQ@mail.gmail.com>
Subject: Re: [PATCH v9 02/13] mm/gup: drop secretmem optimization from gup_fast_folio_allowed
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
> This drops an optimization in gup_fast_folio_allowed() where
> secretmem_mapping() was only called if CONFIG_SECRETMEM=y. secretmem is
> enabled by default since commit b758fe6df50d ("mm/secretmem: make it on
> by default"), so the secretmem check did not actually end up elided in
> most cases anymore anyway.
>
> This is in preparation of the generalization of handling mappings where
> direct map entries of folios are set to not present.  Currently,
> mappings that match this description are secretmem mappings
> (memfd_secret()).  Later, some guest_memfd configurations will also fall
> into this category.
>
> Signed-off-by: Patrick Roy <patrick.roy@linux.dev>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  mm/gup.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 95d948c8e86c..9cad53acbc99 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2739,7 +2739,6 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
>  {
>  	bool reject_file_backed = false;
>  	struct address_space *mapping;
> -	bool check_secretmem = false;
>  	unsigned long mapping_flags;
>
>  	/*
> @@ -2751,14 +2750,6 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)

Copying some lines the diff didn't contain:

	/*
	 * If we aren't pinning then no problematic write can occur. A long term
	 * pin is the most egregious case so this is the one we disallow.
	 */
	if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) ==
	    (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))

If we're pinning, can we already return true here? IIUC this function
is passed a folio that is file-backed, and the check if (!mapping) is
just there to catch the case where the mapping got truncated.

Or should we wait for the check where the mapping got truncated? If so,
then maybe we can move this "are we pinning" check to after this check
and remove the reject_file_backed variable?

	/*
	 * The mapping may have been truncated, in any case we cannot determine
	 * if this mapping is safe - fall back to slow path to determine how to
	 * proceed.
	 */
	if (!mapping)
		return false;


>  		reject_file_backed = true;
>
>  	/* We hold a folio reference, so we can safely access folio fields. */
> -
> -	/* secretmem folios are always order-0 folios. */
> -	if (IS_ENABLED(CONFIG_SECRETMEM) && !folio_test_large(folio))
> -		check_secretmem = true;
> -
> -	if (!reject_file_backed && !check_secretmem)
> -		return true;
> -
>  	if (WARN_ON_ONCE(folio_test_slab(folio)))
>  		return false;
>
> @@ -2800,7 +2791,7 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
>  	 * At this point, we know the mapping is non-null and points to an
>  	 * address_space object.
>  	 */
> -	if (check_secretmem && secretmem_mapping(mapping))
> +	if (secretmem_mapping(mapping))
>  		return false;
>  	/* The only remaining allowed file system is shmem. */
>  	return !reject_file_backed || shmem_mapping(mapping);
> --
> 2.50.1

