Return-Path: <linux-fsdevel+bounces-37674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756819F5995
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 23:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B5816B21C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 22:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091881F8ADD;
	Tue, 17 Dec 2024 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9r+psXA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34831D7986
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734474797; cv=none; b=jXTTsEAS8F1Q5x/lobVGM/tkEndwCqHC01KHByZRJveam9Xsdq2n8qEHdqztRdPjwM9xsHcGlu6Rw8aMxwDO5thpBbhuuDIoSs1+oisCEzUQ3LAl7B6sAF9kAUFtA5ROzhVsGsShAxW0tW97htgzhza18y5/KzR4ppiR05iDeRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734474797; c=relaxed/simple;
	bh=MBDsfeVpZYYIxL21t6Nf1RWI9Ay/NC4iydLktnvMq5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HF2E6P6INy3PUgYG+R2LYbwfvC3MeTe9SwRliRqEva+Yll7ZA0ISw0rKOTQlbQOX5+qYUa/AbdaJY7YGRr9Bt9+/AK7IEwz6WNYgHhUsocGUTvMZfqbBYa7vHJIJGB3c0PYqWsTurWFTMglGcbFLQlBP84G7BnfARrVI0EtCE2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9r+psXA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734474794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oasFH9YS/5nOK6GsM6YHhbVvy+xnvzjUtw4Gpik0lY0=;
	b=M9r+psXAW9Vn1tW0jD44KqM4BshPlvEpkEiuvrIC5uqoFVpUf2bZgidDEaCK+igjZ9TcLP
	GcZxIIWRmrMYSUs9tAna3WcfCYXidVUy+hMJ+EzceTA+vQG0sVgT723viK2nEIge6HCLed
	dKvbKMgwPgP1T2d4qalBvye3JusLCQQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-E1P5eZh9PRKzSdPeFmh4YA-1; Tue, 17 Dec 2024 17:33:13 -0500
X-MC-Unique: E1P5eZh9PRKzSdPeFmh4YA-1
X-Mimecast-MFC-AGG-ID: E1P5eZh9PRKzSdPeFmh4YA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361d4e8359so29097725e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 14:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734474792; x=1735079592;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oasFH9YS/5nOK6GsM6YHhbVvy+xnvzjUtw4Gpik0lY0=;
        b=fJgNrFX4DAjEXM4sTmO+qrV34I4h1G0iLfvHKwnJXZyyoC9f99ZDkUZgkVyorA8UZa
         zTutXRtobcJYA0+N7Xj+xylW3gC32QgEw/jL8Cll/Pyz/t4wGgVFLWVHhHhx5np49BLC
         XMoZDdimJ/SjKIpb+m+uSE4mIyS7o7dRFupDbix7M8FrgGEQYa1goQfkvFaZT515hmpZ
         Ep0AaC7I8/GoL7RQap9vUowCwZRvz7z+R0o6qm2hLHsoonEX3C9RK8DyPTR0ar/Vhyx/
         1smfI5QSymmdesbM4ENOS8Aox6ZUhRAD1FT9JcdiIVfgqtwI+doNuPsVxhqTtd+W3uE+
         Ej7A==
X-Forwarded-Encrypted: i=1; AJvYcCWe+N/e75rKqneBhP+8kiebKz/1qqauEHdDWqDo1zelgYHdiuYp5gkI6YEhqW7D8TDqouCyIl5w3ZrQOQRW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0V6+thlb9cEk7NyDHsXbDGOYBCZc3XNvofLumzYcXjhKTmNKR
	3Za9GmG/ASKnZXb+5s7UFi/x4XQdDtTPapUhULn3YFopYss3ZUjguDGNCPmKbCbO+RmcFu6YYik
	voNayVYhJByQItH3nJvFCtQJKtJ34PwxaQbTA+vKUBZ1F5tg/G59ETzI79e+o1WA=
X-Gm-Gg: ASbGncvneU6YcK19xfec58UtPVRhNryMNbhI7XW6RGjwzvkeJQC5y3rDTlAxL8lIMUF
	OgjLmrdMYvu3sEKhphGOzuNbCjQilCUf22Lv2WNkcm+XQYT9f7dGf46tJ9825caXZaeN1vUXdDt
	g8lQY4I0LxHZ43GSXcMjGTbKcJsgHDxm6o6FcaIfxxaA+omFsnqD6DXITq3VWZesfgv0dEThhHY
	CbGIgEHKHaeS/dYBar21pRBJrCJz4eWqnbIsgDU7MOOObt9vws9EUbdFJ17E41eEFzlS0gJqzRL
	84c+Ns4RYkOk2d0OGgG8NjINrpse/uGorlr3/AMSaUHq1CVs8ljZeGOTyUespa4MWb6fe+cvKYW
	F1jH6BYZC
X-Received: by 2002:a05:600c:4448:b0:434:a90b:94fe with SMTP id 5b1f17b1804b1-4365535b4e6mr4138175e9.10.1734474792410;
        Tue, 17 Dec 2024 14:33:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHu5Rpx/75DKHPvdCspqV2eTg6oVqu83uuIMN0kGm64YISiw1ESXOe+JcsaDrCGOH1qe5B+Gg==
X-Received: by 2002:a05:600c:4448:b0:434:a90b:94fe with SMTP id 5b1f17b1804b1-4365535b4e6mr4137665e9.10.1734474792038;
        Tue, 17 Dec 2024 14:33:12 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:5600:c716:d8e0:609d:ae92? (p200300cbc73b5600c716d8e0609dae92.dip0.t-ipconnect.de. [2003:cb:c73b:5600:c716:d8e0:609d:ae92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b1a195sm190205e9.36.2024.12.17.14.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 14:33:10 -0800 (PST)
Message-ID: <e7f9433e-bd4b-4284-990b-9ea074064f0a@redhat.com>
Date: Tue, 17 Dec 2024 23:33:09 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/25] gup: Don't allow FOLL_LONGTERM pinning of FS DAX
 pages
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
 dan.j.williams@intel.com, linux-mm@kvack.org
Cc: lina@asahilina.net, zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
 <f315b61169d0671301e4a793ecbb1a6c46b69bef.1734407924.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f315b61169d0671301e4a793ecbb1a6c46b69bef.1734407924.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.12.24 06:13, Alistair Popple wrote:
> Longterm pinning of FS DAX pages should already be disallowed by
> various pXX_devmap checks. However a future change will cause these
> checks to be invalid for FS DAX pages so make
> folio_is_longterm_pinnable() return false for FS DAX pages.

Nit: I'd consistently use "mm/gup:" as prefix for GUP-related patches. 
(similarly, mm/huge_memory and mm/rmap in the other patches)

> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   include/linux/mm.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f267b06..01edca9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2078,6 +2078,10 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
>   	if (folio_is_device_coherent(folio))
>   		return false;
>   
> +	/* DAX must also always allow eviction. */
> +	if (folio_is_fsdax(folio))
> +		return false;
> +
>   	/* Otherwise, non-movable zone folios can be pinned. */
>   	return !folio_is_zone_movable(folio);
>   

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


