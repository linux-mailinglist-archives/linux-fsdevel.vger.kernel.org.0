Return-Path: <linux-fsdevel+bounces-38554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39921A03AED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 10:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18BC3A2C5C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 09:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EB11C3C07;
	Tue,  7 Jan 2025 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwU0Cpw1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FAB647
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736241646; cv=none; b=P0GFvW32NNJiGXVgoLORzJ8SazmfFLjCm9c7nefhpK7sI8jDC//B3yX9EHMHLVoAp6SLEJ5jDAs7kilbC0mfkueqo3sQPrzkW7/1X1SKmtI6OZo2PJ42XWU/BeTZHjvlqB3EHhbOu/EEOl+bYxkNqDXv9sYTeiPWk7USBuSxhbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736241646; c=relaxed/simple;
	bh=0mFvhuwCYsn1LRt7mvSNtqD132vJrQBsUGW51sbujGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TZD77ZDD6KIVKOhptdCozr/MqPeCCwv4eqOSiYSekzXIkH79XNSLiNe1rNM13aQoKwPxuV2hvzYgTjQkqthCSrtDvEozf3uDzb12jRg3VFTCTD8yjRmIWuXLIgIVAwJc/JD6ppzXhawXfHJYsvxWskraGXjVwZjLkreyk93gkCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwU0Cpw1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736241641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K1nMt3BRRhob2ey5NC1EfSizkcNvgYcWgxcizL6Msqo=;
	b=cwU0Cpw1FOBYh9WcVfjVcDxx9kYiLV/O+DMXXLDIXpqUi7vaGyjRH91nYDmGmYhXXH+AGZ
	UpCtyrRioAttttU7JtJsf52FaRq3X7J+ZzdQ2t1YtNrPylxLDiM+G395HZj8wQzxXzB9pC
	vcQoVM8Hg1SB4/2zO6CZjDHcJwWNvYY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-Shxu9tZaOrmOgr2ohHTv4Q-1; Tue, 07 Jan 2025 04:20:40 -0500
X-MC-Unique: Shxu9tZaOrmOgr2ohHTv4Q-1
X-Mimecast-MFC-AGG-ID: Shxu9tZaOrmOgr2ohHTv4Q
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d80576abso9637250f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2025 01:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736241639; x=1736846439;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1nMt3BRRhob2ey5NC1EfSizkcNvgYcWgxcizL6Msqo=;
        b=MNcvsJYxV73LllTll75RPrTfW2nWoqXWK7ki/BoADBmFysDqfUqlxS/5alKoALHSsY
         Q+5yhqjnv6ShW5sVKFtUpDJuSBdhqp6Kw9YXqwi/fZkDp61mIKefyNgYOS+70zjyLTh/
         LqrvQxqq0WoHVnhQTXw6CmLCD533VHmsQi7mkWXDUznCBp4zWAZSYpD6HaGpQxT/6reg
         Zgtyby5LCLWNlsIJ8DGk6Bjzrp3ZavowO0hK5dfCY3PXvFHJVc8gFlx4k9YCqAAkhBUw
         djKZVpyTNSX1HiIVMleYuIv30jvVlqeyj2UMKN0Zp47TIWpArtO0/BAVZ6TbYQ06HB3B
         qnLw==
X-Forwarded-Encrypted: i=1; AJvYcCUXF8+pE3flRakUfdg8wIbvAWmK/LHOP9gH8A03RASnftA9MZMNe1rpvtVJadLQHMhi9Hzp+eHJ5nJ+0qeX@vger.kernel.org
X-Gm-Message-State: AOJu0YymU4gy3umMgC7GJfSsWC1KJ4C0mhyTr8YeRpGk3c+ya3l1K87i
	hzrNaI8x3/Yh4285LI+njolPuv4E35g2YGNlpmXr+HcxNkK8TJq35U4ll51bgYNaBc1EwOPQ5eV
	E4oKfgRJ43GRwr/Ej8kUM9eV/FNCNmNAMXWnoh1kJ8MGX5pAnsuGLcmukYJLMfh8=
X-Gm-Gg: ASbGncsnMGoF8qKSoA7JjD+Na9TKjYBhn4f2Cv0QmDyC9PJd+hQoYqwvXpj5X+lfZAQ
	4IcCxWjO+2e965z0OFzow6yVdYbVQFnW5iaohfDt5GyhxuvmK1+lHniuBeImrAG+/Iwiwd9jJKL
	/llU+nlY19cDFFN37pYH7p8BaT4vHso0BmVA1Lxk0OGgOTjYywkyavhEKjFOZcyOwLVsxeBvM2Z
	yReFM7MS6ug5EX4DEkBcMpjrsIT+vekYQ7jF4N/3bDiJ42m9XI+MiM9rZjfktcRavsXvhi/Ijyu
	0PWHDRNAenYJ+y8q02rAm/hq/LDa/nQXHnLiYRk1N46nvwkIKwY3V4zSRBLLBALhhcXwkWusSg2
	z5QcNSuMr
X-Received: by 2002:a5d:47c8:0:b0:386:33e3:853c with SMTP id ffacd0b85a97d-38a221e2394mr48892028f8f.12.1736241638901;
        Tue, 07 Jan 2025 01:20:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/DK+Yn/sBel1PFWXGWLzGVWYVwTPd1S6mOg4SNWmnaLh4E+gVHKM3m8pXz6fnyHB9JV5rxA==
X-Received: by 2002:a5d:47c8:0:b0:386:33e3:853c with SMTP id ffacd0b85a97d-38a221e2394mr48891994f8f.12.1736241638468;
        Tue, 07 Jan 2025 01:20:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c719:1700:56dc:6a88:b509:d3f3? (p200300cbc719170056dc6a88b509d3f3.dip0.t-ipconnect.de. [2003:cb:c719:1700:56dc:6a88:b509:d3f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b41904sm624530315e9.37.2025.01.07.01.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 01:20:37 -0800 (PST)
Message-ID: <2339600b-ebd5-49f3-a0be-414bc400a858@redhat.com>
Date: Tue, 7 Jan 2025 10:20:31 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: fix div by zero in bdi_ratio_from_pages
To: Stefan Roesch <shr@devkernel.io>, willy@infradead.org,
 zzqq0103.hey@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20250104012037.159386-1-shr@devkernel.io>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250104012037.159386-1-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.01.25 02:20, Stefan Roesch wrote:
> During testing it has been detected, that it is possible to get div by
> zero error in bdi_set_min_bytes. The error is caused by the function
> bdi_ratio_from_pages(). bdi_ratio_from_pages() calls
> global_dirty_limits. If the dirty threshold is 0, the div by zero is
> raised. This can happen if the root user is setting:
> 
> echo 0 > /proc/sys/vm/dirty_ration.
> 
> The following is a test case:
> 
> echo 0 > /proc/sys/vm/dirty_ratio
> cd /sys/class/bdi/<device>
> echo 1 > strict_limit
> echo 8192 > min_bytes
> 
> ==> error is raised.
> 
> The problem is addressed by returning -EINVAL if dirty_ratio or
> dirty_bytes is set to 0.
> 
> Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> Closes: https://lore.kernel.org/linux-mm/87pll35yd0.fsf@devkernel.io/T/#t
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>   mm/page-writeback.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index d213ead95675..91aa7a5c0078 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -692,6 +692,8 @@ static unsigned long bdi_ratio_from_pages(unsigned long pages)
>   	unsigned long ratio;
>   
>   	global_dirty_limits(&background_thresh, &dirty_thresh);
> +	if (!dirty_thresh)
> +		return -EINVAL;
>   	ratio = div64_u64(pages * 100ULL * BDI_RATIO_SCALE, dirty_thresh);
>   
>   	return ratio;

bdi_set_min_bytes() calls bdi_ratio_from_pages() and passes the result 
to __bdi_set_min_ratio().

__bdi_set_min_ratio() expects an "unsigned int min_ratio". I assume this 
will work because "max_ratio > 100 * BDI_RATIO_SCALE", but it is rather 
confusing ...

Maybe we want something like:

/* Use 101% to indicate "invalid" */
#define BDI_RATIO_INVALID (101 * BDI_RATIO_SCALE)

Or alternatively, just handle it in the callers of 
bdi_ratio_from_pages(), checking for -EINVAL manually.

-- 
Cheers,

David / dhildenb


