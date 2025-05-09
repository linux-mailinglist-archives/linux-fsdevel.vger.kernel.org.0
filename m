Return-Path: <linux-fsdevel+bounces-48548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F044BAB0F79
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 11:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AF75033CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD4326FDBA;
	Fri,  9 May 2025 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KprdP5Td"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FBE28D831
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746783924; cv=none; b=E1Esm6S/SHNmj4y/hJ9L8HiBrEVrc8YgQltHUvgfJMrwi46ne7G8QjrZ0uEhHbUiBvhFEQBaRCvs/jtVhUMc5TqtzApQuylK5hr7CxDfC8IHZaTF0z3WUp/jXpgqR8LUh6aWsw8EZVATM1EhqzQfasvXk1VC4YpvC24tyozItJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746783924; c=relaxed/simple;
	bh=SuhC9jBT+2frBsE7+oqdlk+rEtLnsAZTJgt9lQXECqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhL88ESsb45jzjWSWt1vXAoo0vm+qNSb5vA0P2lR6qNJ6xrrhNRwui513JOdh/wiqs24J4PKYCRHfgEW+4J6fCJK3fR5c9OHTyiJaS7Um3kz4j1uTHeYnxd4JTFkacD/sORYYEk/qRPhIieMtFmCUX6APxHZLLUsy8EI4zQ3BkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KprdP5Td; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746783921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YOAa0bozgxCI+CKgyYl1eiLYjIKKrO+Xq6cJ11SS5lc=;
	b=KprdP5TdTIo7MgCAcHuemxeWEAXst41kldEgLFCDoEHXGbafX4bIMMAozWctbNDLJE2lZ2
	TuAMQlt8FujdCxW9PviqrJ6GXvSRdAMDddFwTnK/KIbIKTVP8AVrEIJuZzUMmSFgT1VplC
	gGEXj8TYqAEzeSNm9zYAETbnRXukVfU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-zKAl2oi5M0CMjrzwsGutpw-1; Fri, 09 May 2025 05:45:19 -0400
X-MC-Unique: zKAl2oi5M0CMjrzwsGutpw-1
X-Mimecast-MFC-AGG-ID: zKAl2oi5M0CMjrzwsGutpw_1746783919
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-442ccf0eb4eso14726335e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 02:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783918; x=1747388718;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YOAa0bozgxCI+CKgyYl1eiLYjIKKrO+Xq6cJ11SS5lc=;
        b=aGNs0UinopGSUoHC9co+sdPzprDaNLzMLpq5/gUgm5YvmD2b32/vMwjUSv5MBMbT+3
         uNmgNin/tbFFOEhOfv3TXt5c1+xdW/QDtA9BzJQvbkIbHfTQMZwAY7vOC/QoSP2yJCgX
         LvlrPwHNllRacb5nPAJG7v4khIA6TZVQJEtFet6Gb3yiQoaoW1xr4RBIuU8a/RkRldq+
         3yJJ4yrFvFoqlYkoHzZgbSx/92ux3OqykNXH53MI09snamaO2ZpP3X39WYEB+RzuoCPL
         oe4usChQL2BdQr7P6i/zgLipfdvHrKp9E9UMuSon7wjiwHMGSlwsNmVxcHoJ3yaLIVXi
         Ez3A==
X-Forwarded-Encrypted: i=1; AJvYcCXGgUpCTXAbgiymxdzJ9PXT5A8XSdZO/e3noE+5WMoRZKAteBmWtmgBmYKYX8n9pY6FK2FVs/Q4PJ3hb9L2@vger.kernel.org
X-Gm-Message-State: AOJu0YylNCEKdi5wWJHrqGnWQdfJrasaLeZcZHaiy6+ywO6mSOET0xds
	vNadytYtWeSQY2N3UKtqSlhB+HZF7Px16zsVbFwjNBo1cxovF98t6WcWvmCx8xEKpUorWILvUY/
	fuN8pBYfFXoz8LYJ7ZQdmGzBTeHMcrwtASDl2xZMNhfSzY+82TutNf/U56x0rYVo=
X-Gm-Gg: ASbGnctiR+vFFywBwb9zVoI+ibflngFfX32znwChx1+XLYLG87O1BhXdVSp/QjBRO/b
	etntjCMwrQuOlljONwgsYmTKdV4P1uSf738D4tsG/p4fzDRMWi/RKJbKXUrCFdCpPzSW5UmDWAT
	qQq0+psUeY0/l1xNfYTz5BU08v87wnB4Nz9OiHq2b6szJfIe1qLxuxFvx20MPc22cPLQR/Ew++7
	NxQW6WQZ9EJoVhRZ1NpJxodJ6DuxOvZm3wOHCq+TFRc+elz+i2Ua4/e2PU3Z40F/2gCGG8zDiLs
	tClf1mk0JmKqFzeU/b0U9HOL4J2fpJJ/8ywtOEylNqY2nQjUOrhRos43CeGi65zgyRTrhX58w1n
	gSReMWPaferGDWXcaQaLR+IDNMLQ+9FK7Xf1dAvE=
X-Received: by 2002:a05:600c:46c7:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-442d6d3e373mr24938145e9.10.1746783918615;
        Fri, 09 May 2025 02:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7MVL7mZihpcEEvitceu+2xXiJhCmERZKrpRflwNsBVodW0DJCdrtEiUUSzs5CTgr1OXV/hA==
X-Received: by 2002:a05:600c:46c7:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-442d6d3e373mr24937855e9.10.1746783918180;
        Fri, 09 May 2025 02:45:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f45:5500:8267:647f:4209:dedd? (p200300d82f4555008267647f4209dedd.dip0.t-ipconnect.de. [2003:d8:2f45:5500:8267:647f:4209:dedd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4d21esm2725998f8f.99.2025.05.09.02.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 02:45:17 -0700 (PDT)
Message-ID: <708b6b1b-54a0-43b8-b6ec-a2dbb089d432@redhat.com>
Date: Fri, 9 May 2025 11:45:16 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm: secretmem: convert to .mmap_prepare() hook
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>
References: <cover.1746615512.git.lorenzo.stoakes@oracle.com>
 <a196a08a52039ee159c8333d0c6547e78112acb7.1746615512.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a196a08a52039ee159c8333d0c6547e78112acb7.1746615512.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.05.25 13:03, Lorenzo Stoakes wrote:
> Secretmem has a simple .mmap() hook which is easily converted to the new
> .mmap_prepare() callback.
> 
> Importantly, it's a rare instance of an driver that manipulates a VMA which
> is mergeable (that is, not a VM_SPECIAL mapping) while also adjusting VMA
> flags which may adjust mergeability, meaning the retry merge logic might
> impact whether or not the VMA is merged.
> 
> By using .mmap_prepare() there's no longer any need to retry the merge
> later as we can simply set the correct flags from the start.
> 
> This change therefore allows us to remove the retry merge logic in a
> subsequent commit.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   mm/secretmem.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 1b0a214ee558..f98cf3654974 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -120,18 +120,18 @@ static int secretmem_release(struct inode *inode, struct file *file)
>   	return 0;
>   }
>   
> -static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
> +static int secretmem_mmap_prepare(struct vm_area_desc *desc)
>   {
> -	unsigned long len = vma->vm_end - vma->vm_start;
> +	unsigned long len = desc->end - desc->start;

I'd have marked that const while touching it.

>   
> -	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
> +	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
>   		return -EINVAL;
>   
> -	if (!mlock_future_ok(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
> +	if (!mlock_future_ok(desc->mm, desc->vm_flags | VM_LOCKED, len))
>   		return -EAGAIN;
>   
> -	vm_flags_set(vma, VM_LOCKED | VM_DONTDUMP);
> -	vma->vm_ops = &secretmem_vm_ops;
> +	desc->vm_flags |= VM_LOCKED | VM_DONTDUMP;
> +	desc->vm_ops = &secretmem_vm_ops;

Yeah, that looks much better.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


