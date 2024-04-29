Return-Path: <linux-fsdevel+bounces-18100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0494F8B5872
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 14:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280E01C232D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 12:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DDC757E7;
	Mon, 29 Apr 2024 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1lHspMV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFB353E1E
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393407; cv=none; b=IcVB32d/2mAFFacwjzvtqpN7h5O9QVlSZPJg85saqHC09RUIkC+JoYQ3gZpdljDrmLv5LJubjuUkkQzWPayUfaD2C83TN0nMYu9HwNbGG9+9onfXMXQdyoWu6UgyRwnp1xs6NWmPcXXjVufZzr5TB5aCTHUNTCEEFe+ccDyL2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393407; c=relaxed/simple;
	bh=Z11k8++LcGb5FZVQGAoiBUuCtHQz8uhD/JgOtvZbpyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jhwix1FOLCR/WxY6t6CpeJL5jfrBLUbssCUrSoXPuzzJcjvBKUtGO7SbeLZ14shmPTO8mmIFHFVWjImjtowkomRCnNO69t2C45qOli7VotCp+Of1GSDksgiBVz2X52uUt/+MTIThDN2Epro+hKNzRDZ6zX3x3YfkCrn98keQQbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1lHspMV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714393405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HFJwtbOsrVlZSBAb+kxbkBrkCqjtIwC2/r1vdMSpca8=;
	b=G1lHspMVC7tURK8S1HT98LePeDlURAfF1/dzUImIYPzwHDBtGDG9fEvITtG2yulLpA1TWA
	arLOT9ijJPzujOCHrvlIZDstGs2arPnxibxeGTGj2X504rgKEwcI09tf7nSqZ6J7CHBxnV
	NwQ4GR9IY5XwxRXrHACRpkv7/uWDA5U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-E6MX30maOOi1rXpZh3YXtg-1; Mon, 29 Apr 2024 08:23:23 -0400
X-MC-Unique: E6MX30maOOi1rXpZh3YXtg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41ab7cdccd2so18818665e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 05:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714393402; x=1714998202;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFJwtbOsrVlZSBAb+kxbkBrkCqjtIwC2/r1vdMSpca8=;
        b=HrbK2LTKoKzihbpuWFP2YF3yz2xrvFNl7hvEPsZT4PkynkeHbC0/ykKZnHGrAJpZy0
         wkUUCUny03afpVqqchL28tY+BahaGvN8hg94aIE2wZbetYCdpcJc2DPQs7jD4WgKJfAt
         Yp1EXx8HmsstuZV7d6WgAhSpbq5idUusy/OMNmQRwS8QifH4AOsb1K5csmWFEGEeN6fq
         UPG7PjMdEerNcw4kIwzdNN1pC1LuJhh36brAxQAtJ99lNVuuM80x7fG32A4yuzt8Akj5
         SekJMOQFo1oaHq7bHPLdYcsvxcyEvxKYpsNuHRCHVRfQ7UNRJX+eqT5XiOsIFEDPkZ1z
         u1TA==
X-Forwarded-Encrypted: i=1; AJvYcCXjExKyGRcHNmy7LoCpIeHQ8lSAEvC9uYqaowMXeXSR1iC1VOV3KnkMi/OoMLQ5h1py3ZRwdrvAS4TBzpDyLlNJ29eT22DGQNVVqXeWnw==
X-Gm-Message-State: AOJu0YyhEvGtuP3bqyXOtZNZxKyGkBP/s4hSBkYatV/WeM/Gqv7dqA3O
	dPcAurjtI5ZHKI5dZTenu3Ri0rdZnPl0tboqnAqGcj28hy8MZa/yogeDIV4dCZNXsVjLjroYNi3
	VlzCa4A34EW7/obBdWqQPwwZErS1qSAWVInwQ1U8XcjBP5k363QwGlLBJElBWa0Q=
X-Received: by 2002:a05:600c:4708:b0:419:678e:64ce with SMTP id v8-20020a05600c470800b00419678e64cemr6323048wmo.36.1714393402601;
        Mon, 29 Apr 2024 05:23:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcDzQgGXR3mEXILj2H94FpN7cXTfzl+t+bQIG9r87AMuFTG/maoh2J1QSVyK/8Pe08gQbHqA==
X-Received: by 2002:a05:600c:4708:b0:419:678e:64ce with SMTP id v8-20020a05600c470800b00419678e64cemr6323033wmo.36.1714393402265;
        Mon, 29 Apr 2024 05:23:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f26:e700:f1c5:285b:72a5:d8c8? (p200300d82f26e700f1c5285b72a5d8c8.dip0.t-ipconnect.de. [2003:d8:2f26:e700:f1c5:285b:72a5:d8c8])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c4f9200b004169836bf9asm45084972wmq.23.2024.04.29.05.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 05:23:21 -0700 (PDT)
Message-ID: <01b0e462-6966-4a56-b101-c7e5ebcdddd3@redhat.com>
Date: Mon, 29 Apr 2024 14:23:21 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fs/proc/task_mmu: Fix loss of young/dirty bits during
 pagemap scan
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20240429114017.182570-1-ryan.roberts@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240429114017.182570-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.04.24 13:40, Ryan Roberts wrote:
> make_uffd_wp_pte() was previously doing:
> 
>    pte = ptep_get(ptep);
>    ptep_modify_prot_start(ptep);
>    pte = pte_mkuffd_wp(pte);
>    ptep_modify_prot_commit(ptep, pte);
> 
> But if another thread accessed or dirtied the pte between the first 2
> calls, this could lead to loss of that information. Since
> ptep_modify_prot_start() gets and clears atomically, the following is
> the correct pattern and prevents any possible race. Any access after the
> first call would see an invalid pte and cause a fault:
> 
>    pte = ptep_modify_prot_start(ptep);
>    pte = pte_mkuffd_wp(pte);
>    ptep_modify_prot_commit(ptep, pte);
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   fs/proc/task_mmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 23fbab954c20..af4bc1da0c01 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1825,7 +1825,7 @@ static void make_uffd_wp_pte(struct vm_area_struct *vma,
>   		pte_t old_pte;
> 
>   		old_pte = ptep_modify_prot_start(vma, addr, pte);
> -		ptent = pte_mkuffd_wp(ptent);
> +		ptent = pte_mkuffd_wp(old_pte);
>   		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


