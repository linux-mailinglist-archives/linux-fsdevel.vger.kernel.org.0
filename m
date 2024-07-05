Return-Path: <linux-fsdevel+bounces-23205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE3D928A59
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818721C227A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 14:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2F51684A3;
	Fri,  5 Jul 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MycqSrtm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DC114A0BC
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jul 2024 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720188202; cv=none; b=ua45Pf3nZ0eODE6njfZw1tA7+ZnKYgSJmAnv6eQ4/Y7lcXlXjiuUL7Xifhh2OzHuqWMUxQp2FjympFt9D6ctWx1itO3bEunangJewhwkDBMkRF9A3GrfnkVkx7HwuS17d45htGEfVgNVjejICFYUnumtd/HnlvpftQJP8/mQrmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720188202; c=relaxed/simple;
	bh=l4a1ERMOuqXBaLFWS+gfiLgokGjRYBYVwSGMCa+ialE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBF0Oer723gQieNoB0r2gb5f+vr3VOU53ROGonu45nV5E7S6qKMz06P71gwgdL1zH9pncagKeHlKqeBc9y+SzAfyoViP00W/g38lzZP7F5XwjgFvbzB2zYzjpeBlh3l0DnmuW/q+S/G9JIx8gXkUsrLyCXAq1r7DudnUgNbABgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MycqSrtm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720188200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tcFyaq/x3BT52iyZhmpXyGxuAICYLbboWOWxjG0cb0I=;
	b=MycqSrtmgPi7Qqg4KUxVtv02mSheSArpVUlJAPwDRfSB5EWhTf+qkB6gHGeYg4HS43/gR0
	sWojRHcwBA7Atw3okJfzxdW44Z2OXi6SaI90pFBq95tuVfh4s6imSgS9pAcGGa4B/NTkpB
	8eHt1Y2sqblkRyfdVdEf3c+zv66lxf0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-_tbOznk0NPK0U0OWP_11fg-1; Fri, 05 Jul 2024 10:03:18 -0400
X-MC-Unique: _tbOznk0NPK0U0OWP_11fg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4256718144dso17552825e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jul 2024 07:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720188197; x=1720792997;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcFyaq/x3BT52iyZhmpXyGxuAICYLbboWOWxjG0cb0I=;
        b=iEwDS95qTgw31z/H8xDsa7At8S7+Dj5jNMQ2oWOdG+AE1xqqjmGKms7dGDeB4B9YBI
         4sE+eehzmlb5SdQvONXqEe1TabIoyed51yzrSKtvC98SXoO0E+Xu4w31+E0sslbbd2jJ
         bmkYMpZSUS9DzsiThM3/3ocxgGmml62WRsO9P1Q5S0AQUMGpuI0kqyZ1L3pDEIwiqfue
         UhQLhSHl7masxZo/w3/GC6WC+wSvIFi6AJs8l+B5z5O0dW8GXKzzbtHhe7B17u/zkRnd
         VSnKAqr/DyWz9lv6+jIhn+0UEbP73lNxp5Z7gYN+VVUvr+vjnOaEKk5Ikt/neI87gYRU
         AbAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcyZJRqlZxjGbGiaJSQmVgsYjwt4uBNk+LF/JwqtdsCReqzuN8lBTcJWO4sit1I7lv9u55uwl0OAgLF+OquHEwIM9oP/ZmDHmsJA6nvg==
X-Gm-Message-State: AOJu0YyWnyBmV6kZqAXWNIreIuDk1/EZzVrqVn8eLJbTV4qYFZZCVU2h
	2pTZRzGL+sKCRWRClb5O10K84xm6m73rSIKthSV7fLBjJhmQ9FvpYH+J294nXDR+Oop0ErA2jFj
	cl5EMVCCup4GMGMKhGlPV22/7Kt2lrDfbJGEP1iqRt4DlDUWVNihYy65zmZKNLmc=
X-Received: by 2002:a05:600c:3b0f:b0:425:63b9:ae2c with SMTP id 5b1f17b1804b1-4264a3f3080mr39699995e9.27.1720188197480;
        Fri, 05 Jul 2024 07:03:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLP0Y16Pr3AIIKxriH+7I8UOU7YRcbiBw1n4dgPEZPtVME9hnXFSCpZehbQPgJaJAlIq4dFQ==
X-Received: by 2002:a05:600c:3b0f:b0:425:63b9:ae2c with SMTP id 5b1f17b1804b1-4264a3f3080mr39699685e9.27.1720188197060;
        Fri, 05 Jul 2024 07:03:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:b500:3ed7:a1c7:447e:2279? (p200300cbc702b5003ed7a1c7447e2279.dip0.t-ipconnect.de. [2003:cb:c702:b500:3ed7:a1c7:447e:2279])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2ca5casm64150655e9.32.2024.07.05.07.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 07:03:16 -0700 (PDT)
Message-ID: <8e9da8da-20f5-4316-a449-5544d9883c1e@redhat.com>
Date: Fri, 5 Jul 2024 16:03:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kpageflags: detect isolated KPF_THP folios
To: ran xiaokai <ranxiaokai627@163.com>, akpm@linux-foundation.org,
 corbet@lwn.net, usama.anjum@collabora.com, avagin@google.com
Cc: linux-mm@kvack.org, vbabka@suse.cz, svetly.todorov@memverge.com,
 ran.xiaokai@zte.com.cn, ryan.roberts@arm.com, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 yangge1116 <yangge1116@126.com>
References: <20240705104343.112680-1-ranxiaokai627@163.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240705104343.112680-1-ranxiaokai627@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> -	} else if (is_zero_pfn(page_to_pfn(page)))
> +	else if (folio_test_large(folio) &&
> +	         folio_test_large_rmappable(folio)) {
> +		/* Note: we indicate any THPs here, not just PMD-sized ones */
> +		u |= 1 << KPF_THP;
> +	} else if (is_huge_zero_folio(folio)) {
>   		u |= 1 << KPF_ZERO_PAGE;
> +		u |= 1 << KPF_THP;
> +	} else if (is_zero_pfn(page_to_pfn(page))) {

We should also directly switch to "is_zero_folio(folio)" here

> +		u |= 1 << KPF_ZERO_PAGE;
> +	}
>   
>   	/*
>   	 * Caveats on high order pages: PG_buddy and PG_slab will only be set

Especially relevant in context of:

https://lkml.kernel.org/r/1720075944-27201-1-git-send-email-yangge1116@126.com

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


