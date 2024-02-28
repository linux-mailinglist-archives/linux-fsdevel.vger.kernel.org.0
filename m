Return-Path: <linux-fsdevel+bounces-13062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA7C86AC34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 11:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00316285616
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 10:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F542626AF;
	Wed, 28 Feb 2024 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itDSc0H9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3AF61698
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 10:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709116248; cv=none; b=cbGwVmpSohqe/VTuMp5Ij0zDupHijUwBEzOLZmh/LLyZBWXLT3+scgu/9VfeBp4hVkS7/syqYxATcivKu6ru1ozQnaS7oVJlnRV21UiK0EJ2G7M0BwuWbVsM+ZDZQG8Gpi3nf9BLciQ1KnEzY+qM2+lUSgGxHnzq83Yd5oKH1rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709116248; c=relaxed/simple;
	bh=zqeGvIqPrjm/7glxleVaoyA+ZT8/NJX16mspwlJkRn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLdIixn9rCfy6iG0K5ZMMDoz//OwpB9aQ41agXbjHK1a1e57ZZCgvv9tua6tY+hZ6nrUgVj8ba/2kwlpw7qSdkRjhZwSEzg9GVn828rrPiVX2+lXJEe5E82XW/mwiQOxfQvNpx6HPN1yviryIrdbvbHpUBYYgIfBoZgebA8bCAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itDSc0H9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709116245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jdbkSk0LjVq2u7NIA4ONGJrWqYHxBGfhrpQIAAn5klQ=;
	b=itDSc0H9FejrufNu611JfQu3PAWOp++Demun20RW+0eDOhmyjE8r/3oggVUN6dZS/Rw6+Q
	D6oXC+Dcg2sCZtrQ4P8zTzvIHOcMaLU4tMxchwWMrNBSf37geccyf0A5cQ/qYx8pS2/TK/
	1m6h/SN6WvTUoyqWFH5xMq8MAW/xtSo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-N0RuIyS2PjyO2cODgqBJ1w-1; Wed, 28 Feb 2024 05:30:43 -0500
X-MC-Unique: N0RuIyS2PjyO2cODgqBJ1w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33dbbe709ffso1458045f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 02:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709116242; x=1709721042;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdbkSk0LjVq2u7NIA4ONGJrWqYHxBGfhrpQIAAn5klQ=;
        b=dbaW3h12n413bgc/bLV4ocWQy6G1JPAR6jfmX/k71OeekizL1E/nGIGJz4Y4DFFvS4
         +pPndxbmwsxjqEd97tHYYyPGSDPvpcHwgek97I5qfWBjdHOo8ajrxI3xosS4U8aYivev
         uf9tby0oQ2RAVNA3BiPGkK9Vo/3P7VbUqki0KxLZaV6fARLI+PIZC47qQEMUgXRo4KaH
         A/9msADavtUQAqfyEKScmbEjK/uZF2cpE+mbfnTyDjuJzEfJ2KTzJnJVjp5htF/VrsJ8
         gwrYWZ/U4Yhb6CwbVuEr64r+boy0tcn+J9d7uzY35lEVv5jT4xmTtyCzaWg+CtP5zUv4
         JG5A==
X-Forwarded-Encrypted: i=1; AJvYcCVjUaUP+P0pbeGFms2+XcoTH0OGVMzKAdYZUDP4h9/62CNRre0IojgJe8bj4CwdwONA9v95XyUNToA1jLiY6FyGwzlV1PTaCbDHhHWPMg==
X-Gm-Message-State: AOJu0YxO3zDiGYcDRBv0RpoZhmRe7MGS/RwOvUjWlZTFnxvjqMb1qTVP
	Hi56VG4EoJraS4luXhq6cbR6mcQ1OEdJpExGCxq5rQRAXEvHxRfJGLi78togqNcA0Z2SowKaNkI
	nDb4uazCL70KvDcZjAxVP+CB4cDmAEre64A2nyGaj9n9odasqr19U8MTuuw59Kcg=
X-Received: by 2002:a5d:6d85:0:b0:33d:da6e:b7db with SMTP id l5-20020a5d6d85000000b0033dda6eb7dbmr6532076wrs.62.1709116242546;
        Wed, 28 Feb 2024 02:30:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEc2EAWuWyfnxVEgc8Ht7N8N6Ye/ajb25XECbyU6LWrKiciqqDbMVixvLU8CVyV9UAyeB6Wrg==
X-Received: by 2002:a5d:6d85:0:b0:33d:da6e:b7db with SMTP id l5-20020a5d6d85000000b0033dda6eb7dbmr6532043wrs.62.1709116242084;
        Wed, 28 Feb 2024 02:30:42 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d4142000000b0033cf453f2bbsm14023061wrq.35.2024.02.28.02.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 02:30:41 -0800 (PST)
Message-ID: <99334898-0f5d-4ba1-af38-a510fae473a5@redhat.com>
Date: Wed, 28 Feb 2024 11:30:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] mm/huge_memory: only split PMD mapping when
 necessary in unmap_folio()
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>, linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Zach O'Keefe <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-2-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240226205534.1603748-2-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.24 21:55, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> As multi-size THP support is added, not all THPs are PMD-mapped, thus
> during a huge page split, there is no need to always split PMD mapping
> in unmap_folio(). Make it conditional.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/huge_memory.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 28341a5067fb..b20e535e874c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2727,11 +2727,14 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
>   
>   static void unmap_folio(struct folio *folio)
>   {
> -	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
> -		TTU_SYNC | TTU_BATCH_FLUSH;
> +	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SYNC |
> +		TTU_BATCH_FLUSH;
>   
>   	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>   
> +	if (folio_test_pmd_mappable(folio))
> +		ttu_flags |= TTU_SPLIT_HUGE_PMD;
> +
>   	/*
>   	 * Anon pages need migration entries to preserve them, but file
>   	 * pages can simply be left unmapped, then faulted back on demand.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


