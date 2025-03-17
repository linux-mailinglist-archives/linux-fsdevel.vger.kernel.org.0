Return-Path: <linux-fsdevel+bounces-44180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C486FA6465F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 09:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7778D7A5DA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 08:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A19B221727;
	Mon, 17 Mar 2025 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fK+jftjz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C6121ABD7
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201815; cv=none; b=D842hi44Lqf5ibZ6UiK6jVoMkmkRUPLIR6ZcZUa2cccyAIofOStrG2hM3teXbK0nQ/RfFXX+0Sw/TaAbhkN8029GTnVxRn7xVW38JUNmri5Gdn87c/0nFMxOBL/PyBhvlq+PtWAEjXWmoZDkrUEvnO/sUXOeB48KTOBx3VCFnCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201815; c=relaxed/simple;
	bh=ZYj8b8y8QX9Pm1xmNBK6oGANO3/04Ws0gCnKVRGngMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSnx9FaUQNpVCh7VXzRDqlxNeC+BcECtn/nJmOTvK0PYolVmqvAj6abGIfOp8yL2FpsOMYBwxaiudHSw6Ng5bioPG5y8KnJpUuVGqa0zEuZ+WwmvtCjZanXlZGu74rC+ZpZEBREN0MLONnMdSEdYXLQOsaap9qavgDJKxbqxN4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fK+jftjz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742201813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jM/mmsLHCA3hsf5yRrO/MVwhGD8w1bWurA3e+6TGTHM=;
	b=fK+jftjzEBS8Se6gbWXXTNB+9KudEuxEnuefPSPj7BXIGoJcrjvLGCB9fUuDSkodYUNgMh
	Qntki9VYMWIb0OCt/jTZi/zLwBEYHyka61rRTAjJ8Ow3FfcCZktsSsjOWS95VBbqhvBhkb
	CfWbWMYhG26C/HkcxNVdELpfjvhzj1w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-4KMAY24MMomjQHuPEmo18g-1; Mon, 17 Mar 2025 04:56:51 -0400
X-MC-Unique: 4KMAY24MMomjQHuPEmo18g-1
X-Mimecast-MFC-AGG-ID: 4KMAY24MMomjQHuPEmo18g_1742201810
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-391492acb59so2611459f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 01:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742201810; x=1742806610;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jM/mmsLHCA3hsf5yRrO/MVwhGD8w1bWurA3e+6TGTHM=;
        b=f20kxiBdpp8BTZFgUGtyjZLOIyZC81ak0ZioU+9a/5Ic77u20nwCtwpksaxlcQ60yp
         IuJe8UdY63Rted2tgVq96OM8pRD8Huqnyv42M0hAWXXfniTn3jc5qD4nrbbibpIQnOIY
         /xiGyXTyArlpMH06X7I19b6UYTS6X4e+MsgiHtZwC/DevnYUataQu2bBlOBkwioGI6v+
         5rDk4htvHYuNjaGkNcr6MYuJMEiLW3+wYKZ2yQ3em4sv03INVomfotROb9jmVbCay62B
         wqf6dWFl7V+YfGXUdOprool7kNhLY7fsOp/E+2sxzBeT5SPdff/8XvJJd3sPpROM+PGf
         W1dA==
X-Forwarded-Encrypted: i=1; AJvYcCWbdqe/LjvFN8QBUFty1BtcZKeJlpfknBPds5zqUEXVImJcK4m3GaSx8oGQ6ruPFq23RhR5M/zJ7iYoHaHK@vger.kernel.org
X-Gm-Message-State: AOJu0YwvFUgQwFzajPyUHO6ozqzwPjiIqzw5asS92ts0mXDuxmF3tur6
	N5L2O5DiddfHI/aXGlwC7PKWdTxDdMkO5s9y0tzR9qNCYlCbYnmv2A3peeluYmFbXbVs7E4gl0r
	SjsBe8bFm+7dSCk0KscY7YyBEvKcBmnfc3saBA6zYEQanGK0Bn8Ofu2PHfcCeB94=
X-Gm-Gg: ASbGnctbTTQJ32e8lDymOUuskjsfBCg2yKGVzPQxJuaAIxTj8r14tP/7MA+8CyLotuu
	L+BPrnu+SvkmQA5nU3gB+h7OF3Lo3Cq86Gg5x7eZ3roZ6kAUL7h8qmiPctrHhiQr9BIj9NIxKOd
	X/S6f1HJptzGzlkscjWAkUI9sqwXA4Cx11Y3k32RXt/UqSljlGwj55CGRN3AfGge58h6hJIH0NE
	A6uZlyNMvmqlyw0szwyYo9b6V0kkhv1D4xDNQ4nQ+MrW6mV4CktPss6uPTiQt2RzBwJv+t7b6tu
	5qWW7V15J3ClC29a2gY06G+MvW/fyxdHpxdpHp5BQc2hSo9UByXvNLsXXmycJq5chpseQ47kOA+
	Q/Mx5am8CbrkxkFifKTxWHUzicQnlGxkYQpYLPElZZ8I=
X-Received: by 2002:a5d:588c:0:b0:38d:d371:e04d with SMTP id ffacd0b85a97d-3971ee44380mr10292294f8f.34.1742201809885;
        Mon, 17 Mar 2025 01:56:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6sFzpIy3f/Pv2Gq78PQtI2i6sVUEa7ZSCENPZGFwK1C9x3Bmdp/wdYGN+6WX2vOInODK0Xw==
X-Received: by 2002:a5d:588c:0:b0:38d:d371:e04d with SMTP id ffacd0b85a97d-3971ee44380mr10292276f8f.34.1742201809441;
        Mon, 17 Mar 2025 01:56:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73c:aa00:ab00:6415:bbb7:f3a1? (p200300cbc73caa00ab006415bbb7f3a1.dip0.t-ipconnect.de. [2003:cb:c73c:aa00:ab00:6415:bbb7:f3a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6e4esm14163659f8f.29.2025.03.17.01.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 01:56:48 -0700 (PDT)
Message-ID: <1c7018f1-fdc5-4fc6-adc7-fae592851710@redhat.com>
Date: Mon, 17 Mar 2025 09:56:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc/page: Refactoring to reduce code duplication.
To: Liu Ye <liuyerd@163.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, ran.xiaokai@zte.com.cn, dan.carpenter@linaro.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Liu Ye <liuye@kylinos.cn>
References: <20250317080118.95696-1-liuyerd@163.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250317080118.95696-1-liuyerd@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.03.25 09:01, Liu Ye wrote:
> From: Liu Ye <liuye@kylinos.cn>
> 
> The function kpageflags_read and kpagecgroup_read is quite similar
> to kpagecount_read. Consider refactoring common code into a helper
> function to reduce code duplication.
> 
> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> ---
>   fs/proc/page.c | 158 ++++++++++++++++---------------------------------
>   1 file changed, 50 insertions(+), 108 deletions(-)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index a55f5acefa97..f413016ebe67 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -37,19 +37,17 @@ static inline unsigned long get_max_dump_pfn(void)
>   #endif
>   }
>   
> -/* /proc/kpagecount - an array exposing page mapcounts
> - *
> - * Each entry is a u64 representing the corresponding
> - * physical page mapcount.
> - */
> -static ssize_t kpagecount_read(struct file *file, char __user *buf,
> -			     size_t count, loff_t *ppos)
> +static ssize_t kpage_read(struct file *file, char __user *buf,
> +		size_t count, loff_t *ppos,
> +		u64 (*get_page_info)(struct page *))

Can we just indicate using an enum which operation to perform, so we can 
avoid having+passing these functions?

-- 
Cheers,

David / dhildenb


