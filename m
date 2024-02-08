Return-Path: <linux-fsdevel+bounces-10784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9194084E562
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 17:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D27281B98
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 16:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1A77EF14;
	Thu,  8 Feb 2024 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fx6YbHlA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6877CF3C
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410916; cv=none; b=edvy5zRd6OB/D1/ds5NDxbOUt3lo4QMiWLMo5fQQHSEKGNcgIVlMio80LRZ4FJtQro6zcDBysQwqPA/BtFBKYieYFRJJvI7JtWWYb33opEJKNnJc3MA8JWq1AXeVgHH6Eb64mjPYIlcira1lEIyfEMDye4j9crUio08QRgPjtDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410916; c=relaxed/simple;
	bh=BFcvq1pSoLqkZ4+KU1jfRH/aX9JOKK1BM22ppbYtUt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqrRs0SE5QIay1ol1Wsl7x1nGBdJrL0QEvnugF2a4L6U+cCXtuBMEu59En/bOSLI9EjhAOUmmLJBALKbwxoo1DimC5D65e3i1RHnD4A5Z5/4dyMyjUM2vAX3iPXun8sQUS58iDiHMPcRhH9pQfioY4NpkenCz1w1RUO95OWxAn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fx6YbHlA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707410912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q7iRmNGt3W93UVFfKwOcrmKhnYBPVT8Fkk7ZIGORewo=;
	b=fx6YbHlATU0BZm758JXbsxfsYc2XDAMYaUe0aPME8+rSKKn6foV4BQdAfdQnQVcKK5oxkt
	OQCvQMDQs1TZTvRziF2xcNy5QJxpeBYq0rAk9WVGKDh63uMr7DlhM7j2krrkQiQIuQT+T3
	UjBFkmc/i/21KU9AwYFIoeqdFfcxLRs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-zOnzMmKzMd2G8a4-43KejA-1; Thu, 08 Feb 2024 11:48:29 -0500
X-MC-Unique: zOnzMmKzMd2G8a4-43KejA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40d62d3ae0cso246805e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 08:48:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707410908; x=1708015708;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7iRmNGt3W93UVFfKwOcrmKhnYBPVT8Fkk7ZIGORewo=;
        b=o4PUQ1/uIR2USWqQMl8F2VB4ZWL5zF/5tdFJxSMPZ0BNQV9qwsEgHeoKFh82+noyTE
         +TdefB/JK3LujFXyfa8++rzBHfaz1agAcb1Z55w5cH51wt/MzNi6Zk0r2FlWXs1oGmZJ
         AyHsOrbNkTQe58nSA26Mt0tin/DgNwrjaSNvhCXc7ZwxzNp6vXpuGRvZy2WlZ1XH/I9S
         Va4rkEvXZG93XF/8rL1wQBHvqtOF1t0FfD4lZEqdY0c8LD+KnJp0i/zYWdfovN5AKk4B
         KWu/7NsOBXRC8tHg+LMqkfqU36GXyrSpbkEaW01k7iwwLhLx2+KABPxKuj+7XPAcbb1q
         gROg==
X-Forwarded-Encrypted: i=1; AJvYcCWvS72xvGJd7k9q9+6xoOoK0N77E9JEfDaC/Mbx9tVnv4iwSE4Uq7lwY1RsS+EgqCKzBUxstGtq8xBy/JnXs71OKWEHSPdQtucSnkcWmw==
X-Gm-Message-State: AOJu0Yw3YoUVxbCrQPp3ZsY5DjSVLeTqjor9TeYyChktd3XiQSruGh7P
	6dq5+5Q0Ia/2Ypj/L0kPa2+oka42VnVikSrVrY1iEp/061/xU+Jkj9qyPB48+eZRU9BQZDjpaa2
	J6MAx9dkPu1rUQ8ZA3dD8XWiiLfvxD4UNbELWG6NdBZ2cHPLo6pyjFPa9HkvK3tU=
X-Received: by 2002:a05:600c:35ce:b0:40e:a3b8:a2b8 with SMTP id r14-20020a05600c35ce00b0040ea3b8a2b8mr7191203wmq.26.1707410908509;
        Thu, 08 Feb 2024 08:48:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYKTY1MxUtxzZJ1d4/PLs9cvlxjVLZL0kL6HVGEfXDgqgqqFif8BFLfC0Nh2g7pj8L22pL9w==
X-Received: by 2002:a05:600c:35ce:b0:40e:a3b8:a2b8 with SMTP id r14-20020a05600c35ce00b0040ea3b8a2b8mr7191188wmq.26.1707410908118;
        Thu, 08 Feb 2024 08:48:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzDrKKFXBLqur477CGccDaqml2yYqHxzEvTTB/RcdMzy/PD5OHYVykEkCAkgQbXW2wpzvnf+3gfKLTBKERw+9eUX41iPuBeuH9HeERquQyC/48oni6USvh0TSbhrX/9d9gT45ycc3pa2iumy+/GaDHpLZd3pQUwovsMXF8qCl0
Received: from [10.3.13.39] ([212.140.138.205])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c4f9100b0040fc56712e8sm2133907wmq.17.2024.02.08.08.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 08:48:27 -0800 (PST)
Message-ID: <fb157154-5661-4925-b2c5-7952188b28f5@redhat.com>
Date: Thu, 8 Feb 2024 17:48:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc/task_mmu: Add display flag for VM_MAYOVERLAY
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20240208084805.1252337-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240208084805.1252337-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.02.24 09:48, Anshuman Khandual wrote:
> VM_UFFD_MISSING flag is mutually exclussive with VM_MAYOVERLAY flag as they
> both use the same bit position i.e 0x00000200 in the vm_flags. Let's update
> show_smap_vma_flags() to display the correct flags depending on CONFIG_MMU.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.8-rc3
> 
>   fs/proc/task_mmu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 3f78ebbb795f..1c4eb25cfc17 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -681,7 +681,11 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>   		[ilog2(VM_HUGEPAGE)]	= "hg",
>   		[ilog2(VM_NOHUGEPAGE)]	= "nh",
>   		[ilog2(VM_MERGEABLE)]	= "mg",
> +#ifdef CONFIG_MMU
>   		[ilog2(VM_UFFD_MISSING)]= "um",
> +#else
> +		[ilog2(VM_MAYOVERLAY)]	= "ov",
> +#endif /* CONFIG_MMU */
>   		[ilog2(VM_UFFD_WP)]	= "uw",
>   #ifdef CONFIG_ARM64_MTE
>   		[ilog2(VM_MTE)]		= "mt",

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


