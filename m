Return-Path: <linux-fsdevel+bounces-22430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D784D917082
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 20:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928A228CBE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 18:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2AF17C9F0;
	Tue, 25 Jun 2024 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCqiuLXC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CFD144306
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341133; cv=none; b=bK0HVMG/Mv4PzP/f1Atu6xO3PWKE5fCKJdJHea+r21l/g8TTJR0EPSmP+e15IVo8RzF3Uq2uVbHsHCT/Q17ykW8GErynfTmaXxSA49zU4QRYVA80NAOCxYtDZp08edxdnkqrO3Hwuz85eLJ+fzBOj9gyZDZM4QY7/k/ANfQlMgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341133; c=relaxed/simple;
	bh=f6wEjdMroIWa2KudBybywiojNtD/TF3hmz+cZhCHmmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkF34iv19+QvAlAejlDF4KvOYE9bml49wGOt+dADHvB8KuB2ImuQl1s87SqWP2yYUCpXJ+bp2COfU0rchTzNh9Rp9CKEUrUQsKFRihBUBTRT2zyuJz63Pa0tKdlz3c3DaDZOrQLM07JtRGmk7QvEQhU43Kc8AgUjrOgUy7jf8iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eCqiuLXC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719341130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zA1sfCnwaI00JLsryL4EWJ4v/kiLawL4YnZiavHAE0w=;
	b=eCqiuLXCthSXFhUOlEeXyeWzVKWVz5cGl4yoNwA6O3EbChg8KG/utQOAZt1XPbckYq4IDK
	0xgJJblqcKImiBKFxJfs3xOYBQHgNeM5hWfUuVriBlP380MqOO/qhvtbfUNfQhanrKC8ES
	4UkjhBHd2hoaZFZDVof3hnH5FUyLAWM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-tDh6BzGnOjilRwW3LKjpTg-1; Tue, 25 Jun 2024 14:45:29 -0400
X-MC-Unique: tDh6BzGnOjilRwW3LKjpTg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3625b8355b5so3633836f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 11:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719341128; x=1719945928;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zA1sfCnwaI00JLsryL4EWJ4v/kiLawL4YnZiavHAE0w=;
        b=etza52PIt4FUputbcSxWEXCZdOddzgB2scrjfxa3m88rieeMSbESvXVGgzVJ0BlPlI
         NVxQxAe6AY8sBBgLIGaF3oXpqP9FwbYnGJbBCyQiOuzuJfBL32CLe9Je6VwWDiLXvWp1
         Ox+1iTKmsFPuqx+AG70ODtdLL+wGOgGFY3uNdqjB22RZAeyZvsRqMlTbBmXKRYfOA/JE
         iKJjF7LCFUJyZ1J/QivfZeNi+iVFzkkRmFBz+D4coz9QnXY+siYAwySh0KLFI4t7yZUY
         1sQCToFIy2iQ1tM0zxCkRvMO4BMDxgMlXTDleD6Py+Hj0Nm3wGXijk4m/XXkPdYX/j7m
         ataw==
X-Gm-Message-State: AOJu0YzycsSvxhXVNjIcF2pMM06c4v65QSojkQDSZ97O6761UQ1r6GlO
	qBnfXYsHeqcUo45DKVtCNcXqUKTWAb2thTWSO+tP+QBvjhsNVgq8gk+uXPE5Eeli1LK8j5NiNBt
	qDOBaZqwEJX3DQcrankPrfgaQs3SeuAxi8hDk/o0tNJyzlxqb9xMaOLrcr3YZ3ZE=
X-Received: by 2002:a05:6000:1f82:b0:366:ef00:2b9e with SMTP id ffacd0b85a97d-366ef002c27mr7101972f8f.6.1719341127854;
        Tue, 25 Jun 2024 11:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfdpJoLVZJdorlDSVeSg4JxRw4gw+nAELC2PBUzZAhFg0tnRx6/7grD3rrau3obFYrS/TqAg==
X-Received: by 2002:a05:6000:1f82:b0:366:ef00:2b9e with SMTP id ffacd0b85a97d-366ef002c27mr7101954f8f.6.1719341127423;
        Tue, 25 Jun 2024 11:45:27 -0700 (PDT)
Received: from [192.168.1.34] (p548825e3.dip0.t-ipconnect.de. [84.136.37.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638f858fbsm13642539f8f.65.2024.06.25.11.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 11:45:27 -0700 (PDT)
Message-ID: <6a8fa8aa-fb6f-485b-92b6-868a522bd7fc@redhat.com>
Date: Tue, 25 Jun 2024 20:45:26 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm/readahead: Limit page cache size in
 page_cache_ra_order()
To: Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 djwong@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
 hughd@google.com, torvalds@linux-foundation.org, zhenyzha@redhat.com,
 shan.gavin@gmail.com
References: <20240625090646.1194644-1-gshan@redhat.com>
 <20240625090646.1194644-4-gshan@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240625090646.1194644-4-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.24 11:06, Gavin Shan wrote:
> In page_cache_ra_order(), the maximal order of the page cache to be
> allocated shouldn't be larger than MAX_PAGECACHE_ORDER. Otherwise,
> it's possible the large page cache can't be supported by xarray when
> the corresponding xarray entry is split.
> 
> For example, HPAGE_PMD_ORDER is 13 on ARM64 when the base page size
> is 64KB. The PMD-sized page cache can't be supported by xarray.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>

Heh, you came up with this yourself concurrently :) so feel free to drop 
that.

Acked-by: David Hildenbrand <david@redhat.com>

> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   mm/readahead.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index c1b23989d9ca..817b2a352d78 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -503,11 +503,11 @@ void page_cache_ra_order(struct readahead_control *ractl,
>   
>   	limit = min(limit, index + ra->size - 1);
>   
> -	if (new_order < MAX_PAGECACHE_ORDER) {
> +	if (new_order < MAX_PAGECACHE_ORDER)
>   		new_order += 2;
> -		new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
> -		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
> -	}
> +
> +	new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
> +	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>   
>   	/* See comment in page_cache_ra_unbounded() */
>   	nofs = memalloc_nofs_save();

-- 
Cheers,

David / dhildenb


