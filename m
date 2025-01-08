Return-Path: <linux-fsdevel+bounces-38651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7A0A05981
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 12:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D443A54A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 11:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894DF1F8661;
	Wed,  8 Jan 2025 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3+g8hsd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF0F1A9B25
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jan 2025 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736335127; cv=none; b=i+VdnvFYiNa0EUFvORH6vAPfv+mWsWa9TnArSE6uKJErUSzU83mex/Waz5yf19/tfmWDkz5MPulB8MMyhk3P87TboARMrSkCECA1vd/XShM2obd1+44xdcqV8a541LGulcKgNGJvw43WYIMN058jVodnCPFTVCpFUElAJ0ban7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736335127; c=relaxed/simple;
	bh=6aMcPmpow+jUuAyYrywbX6lRjPak9MC1+xj/7XaPQTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ER/1Ml1qGrh/fzcM6mucp25QSupeyIf4THG+pxVepJM6Q47mqD70gW3Oe0jyH0vRanhl1yP06cGaG0fVfmLaz0UVL3RXgfbHo3SRKAamCrrRzXKxEdHzyc2bZoTaGNRT+D3HwikY7fBVGjtcrSVXO4GR9LObzuOW4dRiLMfB91Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A3+g8hsd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736335124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iP6DJLlFxBkXqREbDTn9k0FxT685l4fWlzaKHTa1mN4=;
	b=A3+g8hsdWF0etmbrATLFjPpitMWZbMXhgi3uMoAZH0fsSZNT0eHZP8Ipx0wqGLS0uQ84R4
	BJBMHo/0pMB141bDVX9htf/aG+Dr8SZZaNWhL9MroI+4XO6mU+XbqKZl8KrDKJ6v2yS6uQ
	iVc5nak1aiLaXogORikUIc9koCmt//8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-mNsZjWC_OW2hJGUMo_P1ug-1; Wed, 08 Jan 2025 06:18:42 -0500
X-MC-Unique: mNsZjWC_OW2hJGUMo_P1ug-1
X-Mimecast-MFC-AGG-ID: mNsZjWC_OW2hJGUMo_P1ug
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4362153dcd6so48670305e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2025 03:18:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736335121; x=1736939921;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iP6DJLlFxBkXqREbDTn9k0FxT685l4fWlzaKHTa1mN4=;
        b=rp8GRWLafGn14jjjTJsRf2pBk22vo2wO2Z2ZqXTYZke52XAREJOgPUFNoU6oP9Kfax
         CP6AVuGCERcv4Yk2B/NQtu74LJObjPCOcaLXv/Wm8w2YhBgSiX+aqovhD7pIA2PRLLts
         uBXf3J315RCLK7SrwdrcSoEFfZSelrtVVwNjOTeqIokPIJ33saPqZZsniPqhVea2rweO
         /82yrFB6R32XF8vydd2OXnffrrGtKNThNcPun1bnj3RmzFqZHCc7x3DDRTB4HYmcBRCu
         Ur2uGFMeOccIT2QhkkmhK/3yFVT+bcV2nwBLifndxfib1+PwkxRg3enta/vqqIaG1wHV
         8TfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd8xXrcXhvVQXZ7/FGIN+M7+p0GQtikxZ7oSGBO48NwmOSSbbhQ2XQ2AVnTCQ+yhpF1QUNf11aa2o+B7iI@vger.kernel.org
X-Gm-Message-State: AOJu0YxLwppt/l++FvBr+2xufXtxocK3zCauyWLC79oWGDAjCjlSakEF
	NbNWpa4V1dp6evL61gfGTAbyTspAG98S2Qxoh9R692GlwLFMUsNfDXr/enZxDCYzp00mfqoJ+7A
	wGkcRxKwYPkUg/3qdlgsekzQ3pA8iJnvxXJWl9Yni4FkcEbetOZNESAuFJa/yXNs=
X-Gm-Gg: ASbGnctYY1j6dTsOLLJDQd0CjUGW3UBMBssqe+Ktjsw6qb8A1JM/Jh20hxeJ+B5o7TR
	KtuX02c6HsAUD3HznSvY1Te9yNvrVQf3A6/ZJqCT214SFqFAbVCCuT/NGZ8uM4YRleSjzwhAMIY
	Q9TfnzcH+LWIpybUoo+HvcMFR2Ya7efPmUacyHkBlbrq9lRbWG/L+DvDkEmJ3/Je7VseDmve631
	sxxBAaKtTelzY1MUhZR2UqfaMwUQxnOzH9/Of1JGtLp/9axCKPN9ZSB+4vCBmd65xmqwkRgo8UY
	H9nAzmbyfp9+g3oVd1E8yTrnWoenQx7qnJ5BBrmE08+mZSn0niiMsSe1ZbpCTw+DNlVtchXrCKy
	V9utzSg==
X-Received: by 2002:a05:600c:4455:b0:434:fbcd:1382 with SMTP id 5b1f17b1804b1-436e26a80b6mr17290385e9.11.1736335121519;
        Wed, 08 Jan 2025 03:18:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFv7FVsRbp0xIlLDzPPJiv7vkWW8Ad5jA4CWxejyn9qdC8mY1Mm9bdPsdN00rRMO6T28SjnKg==
X-Received: by 2002:a05:600c:4455:b0:434:fbcd:1382 with SMTP id 5b1f17b1804b1-436e26a80b6mr17290095e9.11.1736335121084;
        Wed, 08 Jan 2025 03:18:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7? (p200300cbc70d3a00d73c06a8ca9f1df7.dip0.t-ipconnect.de. [2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8b874asm52645893f8f.109.2025.01.08.03.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 03:18:39 -0800 (PST)
Message-ID: <f85f46ac-9893-4b6b-89a4-f5b0d435886e@redhat.com>
Date: Wed, 8 Jan 2025 12:18:38 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: fix div by zero in bdi_ratio_from_pages
To: Stefan Roesch <shr@devkernel.io>, willy@infradead.org,
 zzqq0103.hey@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20250108014723.166637-1-shr@devkernel.io>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250108014723.166637-1-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.01.25 02:47, Stefan Roesch wrote:
> During testing it has been detected, that it is possible to get div by
> zero error in bdi_set_min_bytes. The error is caused by the function
> bdi_ratio_from_pages(). bdi_ratio_from_pages() calls
> global_dirty_limits. If the dirty threshold is 0, the div by zero is
> raised. This can happen if the root user is setting:
> 
> echo 0 > /proc/sys/vm/dirty_ratio
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
> 
> ---
> Changes in V2:
> - check for -EINVAL in bdi_set_min_bytes()
> - check for -EINVAL in bdi_set_max_bytes()
> ---
>   mm/page-writeback.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index d213ead95675..fcc486e0d5c2 100644
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
> @@ -797,6 +799,8 @@ int bdi_set_min_bytes(struct backing_dev_info *bdi, u64 min_bytes)
>   		return ret;
>   
>   	min_ratio = bdi_ratio_from_pages(pages);
> +	if (min_ratio == -EINVAL)
> +		return -EINVAL;
>   	return __bdi_set_min_ratio(bdi, min_ratio);
>   }
>   
> @@ -816,6 +820,8 @@ int bdi_set_max_bytes(struct backing_dev_info *bdi, u64 max_bytes)
>   		return ret;
>   
>   	max_ratio = bdi_ratio_from_pages(pages);
> +	if (max_ratio == -EINVAL)
> +		return -EINVAL;

I would have done it slightly differently, something like:


diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d213ead956750..4b02f18f7d01f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -685,13 +685,15 @@ static int bdi_check_pages_limit(unsigned long pages)
         return 0;
  }
  
-static unsigned long bdi_ratio_from_pages(unsigned long pages)
+static long bdi_ratio_from_pages(unsigned long pages)
  {
         unsigned long background_thresh;
         unsigned long dirty_thresh;
         unsigned long ratio;
  
         global_dirty_limits(&background_thresh, &dirty_thresh);
+       if (!dirty_thresh)
+               return -EINVAL;
         ratio = div64_u64(pages * 100ULL * BDI_RATIO_SCALE, dirty_thresh);
  
         return ratio;
@@ -790,13 +792,15 @@ int bdi_set_min_bytes(struct backing_dev_info *bdi, u64 min_bytes)
  {
         int ret;
         unsigned long pages = min_bytes >> PAGE_SHIFT;
-       unsigned long min_ratio;
+       long min_ratio;
  
         ret = bdi_check_pages_limit(pages);
         if (ret)
                 return ret;
  
         min_ratio = bdi_ratio_from_pages(pages);
+       if (min_ratio < 0)
+               return min_ratio;
         return __bdi_set_min_ratio(bdi, min_ratio);
  }
  
@@ -809,13 +813,15 @@ int bdi_set_max_bytes(struct backing_dev_info *bdi, u64 max_bytes)
  {
         int ret;
         unsigned long pages = max_bytes >> PAGE_SHIFT;
-       unsigned long max_ratio;
+       long max_ratio;
  
         ret = bdi_check_pages_limit(pages);
         if (ret)
                 return ret;
  
         max_ratio = bdi_ratio_from_pages(pages);
+       if (min_ratio < 0)
+               return min_ratio;
         return __bdi_set_max_ratio(bdi, max_ratio);
  }
  


-- 
Cheers,

David / dhildenb


