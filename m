Return-Path: <linux-fsdevel+bounces-66575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C3AC248F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 11:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9441887988
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 10:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1C9342169;
	Fri, 31 Oct 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nf7zFkvO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFFD341AB0
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907226; cv=none; b=QvNkvdr4+1Z55SZev1iELuXk8D1YE1Ze4Ta/1zgftdE+Najxz6i1niq/ndv2riq6B7xncjgsF1lIlg6OWR7qcGVypY5bMbi1fOzqq0ze2qaxi827iIlZ1NnPykQ9dAsFvIo5xRxyosXS44LDmwmoJBmVYJB/fJ8OJ3vzVJ0ov4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907226; c=relaxed/simple;
	bh=rf2hC38h6tIXRHeYGfS1qsZW2ADTB4sWMt1yf2Izvus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZcsGZbW4HaVPw860cTy8QakNcWUnmK0xZjl3guM5WHULdJfeefJqjqvkvxxOFz7s7QyfZkPOMai2RSQRD3hsTFyn0ehPn5FsVEubAp8ce1aQ5i1A02HuwJ88zBTxOEeYgntWss8EQpcqf9TxHO5lM0XeTtOK+VtpI+mGdQ0rSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nf7zFkvO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761907223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oJIKzzXv1KPAKlEWKXjXEzGX44uW5fHNqueLO5sqP5s=;
	b=Nf7zFkvOKw07e1Okx4V1JKBfBwhkj+v9c7prG1KwNGPu6I0lSdMGLMejuAgymZTjmMgpUZ
	e9UH8hALbKQfsKi/bGy3F1M9sGYU2TcpFQqM8idFOReTv3hclAPM2Vx/o8yWaPWNkzl3tk
	91YmC22Nz4CykvVaTi6I/HRL4gRh03Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-p3mo7pbiNQm4bJHQLlT1aA-1; Fri, 31 Oct 2025 06:40:22 -0400
X-MC-Unique: p3mo7pbiNQm4bJHQLlT1aA-1
X-Mimecast-MFC-AGG-ID: p3mo7pbiNQm4bJHQLlT1aA_1761907220
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4770eded72cso11692765e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 03:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907220; x=1762512020;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJIKzzXv1KPAKlEWKXjXEzGX44uW5fHNqueLO5sqP5s=;
        b=BgvZSQggws3rCYkPTkclTKh2ym1VBawcuLv14AO0fACM8hJdSrmJQ09rHDf/vlgbHl
         M9vnMbQ2uoWSj0q6rItX/YHj37pjdJKbNH3qId5DbkSdgTldknh+ISgyvPlF90A/0qeF
         XI1tYN2uOwBnezyTxwM56JYErZB+jkJne+owW4JmKMUNx5G3cXvrQb+wGMvB33ksvXTU
         +gQYqVzlbd8MLAEJp+RYlQ2MRLGjtup+1M5WfYGPrQNsY/bxoEZKP21K4qFfYjqSlznj
         XYRpC2OKDBkD3t6VXHQD0s597a85V0gpGkwpXzOIttBCjqsuYd5HdNk3K0WMREDRw3Ot
         zyeg==
X-Forwarded-Encrypted: i=1; AJvYcCV32pFy5+O5GnlL4f48cSYcAIHV3KwcZ30YJHZGKn8LCsCPwzxdzpgLDikOAkjxecuJkeMHs2fKud/uMzkF@vger.kernel.org
X-Gm-Message-State: AOJu0YzxDsTWBZues9ch5hpvo1GfUGJ3nR9uniMdxqygD5z3wZl1u9sY
	zBNGaetYzF+6FhL9SUAZGoo+Z0Iq6bwLRC+ZJcwKsVD0RBnEatMAbtt15/Pmn1RuHVaePuv4v2U
	JMQT9uMkcRtE9HYvqjrKFwlV5+VA4/fu3QEhukWIfmTXfICvfGMCVHbmK6fyn4bbbwWU=
X-Gm-Gg: ASbGncs2Xh9Zb0opoh4KMysgPSKje+g9fTJPrOYU5okYs5Tc707QdtVLS6HBvv+60+U
	SLrdJNi2eEK3IrXTi356H74nGBYuvprG80hADbE8pO9vNTUIgOXIowTFG1QvDDMGsU1MNGJfT/2
	UIg2V0+kVQbXnuq6/exScrOIxDOvnto/B5Az4rpZbXFs+7hWDx9Mbj5I3YCQzhHIjxw7m+6zh1I
	EheBglk4qleYx45l32mKrzDMitJfu7m1oR79W1aok9hzZXeqw65XScH9D4PpPBNyFFMovcWDfmy
	6+k4xzAO0NgqtWTM0V+jrVsb38vi3XQVeUls70okJzSJLUx131ni2Z+TmpgtvifSaz+WmBPhogy
	7XCjKxUmZg3q5NmjNpn60hpvVkKjFla9M5Z9QrUVk8BH8yy41mEScEdp0pINnrbrgTEuuLBuI13
	gwHfGor9TSM1ebxds7praO1ydSgoY=
X-Received: by 2002:a05:600c:1387:b0:475:dadd:c474 with SMTP id 5b1f17b1804b1-477262a966dmr52601275e9.10.1761907219657;
        Fri, 31 Oct 2025 03:40:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFNypKJqvSxCMoAKYjs9Rl2Q+K34gFvuQORJf5CmJ4AWi1A3ik+7eF/76PZ488GaIPEHvkvg==
X-Received: by 2002:a05:600c:1387:b0:475:dadd:c474 with SMTP id 5b1f17b1804b1-477262a966dmr52600965e9.10.1761907219156;
        Fri, 31 Oct 2025 03:40:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289adaf8sm98599145e9.7.2025.10.31.03.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 03:40:18 -0700 (PDT)
Message-ID: <ca63328b-1c57-478c-b8aa-af0974b7f188@redhat.com>
Date: Fri, 31 Oct 2025 11:40:17 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Hit an assertion within lib/xarray.c from lib/test_xarray.c,
 would like help debugging
To: Ackerley Tng <ackerleytng@google.com>, willy@infradead.org,
 akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: michael.roth@amd.com, vannapurve@google.com
References: <20251028223414.299268-1-ackerleytng@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251028223414.299268-1-ackerleytng@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.25 23:34, Ackerley Tng wrote:
> Hi!
> 

Hi!

> I'm trying to use multi-index xarrays and I was experimenting with
> test_xarray.c.
> 
> I'm trying to use xa_erase() on every index after splitting the entry in the
> xarray. (and I commented out every other test case just to focus on this test)
> 
> Should erasing every index within the xarray after splitting be a supported use
> case?
> 
> Here's the diff:
> 
>    diff --git i/lib/test_xarray.c w/lib/test_xarray.c
>    index 5ca0aefee9aa5..fe74f44bbbd92 100644
>    --- i/lib/test_xarray.c
>    +++ w/lib/test_xarray.c
>    @@ -1868,6 +1868,9 @@ static void check_split_1(struct xarray *xa, unsigned long index,
>     	rcu_read_unlock();
>     	XA_BUG_ON(xa, found != 1 << (order - new_order));
> 
>    +	for (i = 0; i < (1 << order); i++)
>    +		xa_erase(xa, index + i);
>    +
>     	xa_destroy(xa);
>    }
> 
> And made a call to
> 
>    check_split_1(xa, 0, 3, 2);
> 
> Here's the assertion I hit:
> 
>    node 0x7c4de89e01c0x offset 0 parent 0x7c4de89e0100x shift 0 count 4 values 254 array 0x55edd2dd8940x list 0x7c4de89e01d8x 0x7c4de89e01d8x marks 0 10 0
>    xarray: ../shared/../../../lib/xarray.c:764: update_node: Assertion `!(1)' failed.
> 
> 
> I think I've narrowed down the issue to the for (;;) loop in xas_store(), which
> I believe isn't counting the `values` to be updated in update_node() correctly.

I wish i could help, but I'm not an expert on that code and it's not the 
easiest code to read :) But staring at it a bit I assume you are right 
on that one.

> 
> Is `values += !xa_is_value(first) - !value;` intended to compute the increase in
> number of values with replacement of every slot being iterated by the new entry?

Unfortunately that I am also not 100% sure about that one.


-- 
Cheers

David / dhildenb


