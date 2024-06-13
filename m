Return-Path: <linux-fsdevel+bounces-21649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A33907592
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 16:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37EA285926
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DDA145FEA;
	Thu, 13 Jun 2024 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtMHqspW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE0F146A83
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290031; cv=none; b=TzJj0IgJ2A6OaQQKBAzhZ0ibCHOvNSrzo04HjDBX6ikZBAdPDn8jw48MLvZpP3MvzMeiY09xAhU7z5II51yS3rXLLFyrmSe8Nk9xKgNv9Mo9O1Ho46qWoJnWqvSEn/liR/dsKlm/ND00kp9kgst7Fasmr+sahrwB3kkv7m1OCiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290031; c=relaxed/simple;
	bh=KzF5Tbzpbw9twuZ0/Ci/fvBAp4/uWzauqXXdFMVgGjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLYGohm+KCWcZr0/YpjzniROgh+okvMRuuVVfP2HbuVVJbfwn6Oq1UP0GU2DU7IYrEdGOqqBp6Sesa0GsMTKFdZG0pRMZQrUhiLGSmQQZGRxeWc5VfVW7WYbz9XuGo4x0XwiPC84beOBLshZ9ztiiLU7o0l4LlNLKPG8pCaS4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtMHqspW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718290029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XFy9yOTK/NUjd05V0pDMeaunxYzPoKIX/9kty4IIa04=;
	b=QtMHqspWM1j0hYUmlHKQIUZi+rFT0umynIC0F5/Iin+XC1kdOTs9MgYuYevpg1xVqLYIYq
	wES871f2pkZpJfjZMDyXQ5rvT0URZxlFLse9CrwZag2UemXMa0XW7GeQAk7xsckq8E+7T4
	bReto4ymjqNlXwH9NHwybvnGWDNZ5uQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-oHS0X8-ZOsiYOMfjziMqSw-1; Thu, 13 Jun 2024 10:47:08 -0400
X-MC-Unique: oHS0X8-ZOsiYOMfjziMqSw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4213441aa8cso7660065e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 07:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718290026; x=1718894826;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XFy9yOTK/NUjd05V0pDMeaunxYzPoKIX/9kty4IIa04=;
        b=Hucm8PRSzmiQw78YhRdrkwe0BIYAIL+dma1EpPANA85WAAmjrxQ6rNlWo/9YLVsN2L
         vhqN3E2isWTFOnXAIQE0E+LtA7SrniAJbQjsnEuikQW5kd967duuu15N/OkZr3SjNiyR
         /Vw4FhFlTzQEE3Btd9FxkGAkKzPPQDK0Q3VYX3l/AzhgUCNFr5wA/Rf8BEOdzd2UAD94
         rDOcZ7UIEP75mz0nopy7lUGMPldezYH8fygpMI31QhtEZH/8EQEwFBr49IcrJDCebE1E
         p9kb8PhQP0ydg8M2GpocyQrzONXjRa8mitg16eeWs3wNgOs32DIGBx3/n2mvc8b0DMQH
         3DQg==
X-Forwarded-Encrypted: i=1; AJvYcCWJMJ4HNtRm+zqzNpbQ4YXxWn4NeectVjesk7Y3U1dq8HffCmhm+Fe6TkQmlFrE7oeKehJCuFXzmlsWbkI85+WBMaZ8zZ7OTIYvKd1t/A==
X-Gm-Message-State: AOJu0YzxQrYNnglHQomnWDdRdgKIAq1BaXV6CU2ucGkemTW7oz6yKpLJ
	5BI/MqlZMAG+5rZENgJ/mQJzuqB3NCySOVe7XtJig5T+4k2VX6MbU03lnlkjL2oP5BLAgJtHuDH
	KpMbY9+y7HiEYyMU0E5v5wHI+rysD4ns5mM/u+hSyuv1cbqIBb5CHts4WIS7ahPA=
X-Received: by 2002:a05:600c:3ba2:b0:422:7dc7:fc23 with SMTP id 5b1f17b1804b1-42304860becmr170575e9.41.1718290026628;
        Thu, 13 Jun 2024 07:47:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMftS0z8N6fHpAeOmiSiaUIphWPLN0PZ4Yyz2ER7qbYbx1O2WcSNSoAqQ0CvzHXVh0Ws7zhQ==
X-Received: by 2002:a05:600c:3ba2:b0:422:7dc7:fc23 with SMTP id 5b1f17b1804b1-42304860becmr170425e9.41.1718290026195;
        Thu, 13 Jun 2024 07:47:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:fe00:10fe:298:6bf1:d163? (p200300cbc703fe0010fe02986bf1d163.dip0.t-ipconnect.de. [2003:cb:c703:fe00:10fe:298:6bf1:d163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e74c7sm65109465e9.47.2024.06.13.07.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 07:47:05 -0700 (PDT)
Message-ID: <895c6ff2-9b8c-4d35-b75c-8d0287d12233@redhat.com>
Date: Thu, 13 Jun 2024 16:47:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc/task_mmu: fix uninitialized variable in
 pagemap_pmd_range()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrei Vagin <avagin@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Hugh Dickins <hughd@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <9d6eaba7-92f8-4a70-8765-38a519680a87@moroto.mountain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9d6eaba7-92f8-4a70-8765-38a519680a87@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.06.24 16:34, Dan Carpenter wrote:
> The "folio" pointer is tested for NULL, but it's either valid or
> uninitialized.  Initialize it to NULL.
> 
> Fixes: 84f57f8b8914 ("fs/proc: move page_mapcount() to fs/proc/internal.h")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   fs/proc/task_mmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 631371cb80a0..6ed1f56b32b4 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1492,7 +1492,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>   		u64 flags = 0, frame = 0;
>   		pmd_t pmd = *pmdp;
>   		struct page *page = NULL;
> -		struct folio *folio;
> +		struct folio *folio = NULL;
>   
>   		if (vma->vm_flags & VM_SOFTDIRTY)
>   			flags |= PM_SOFT_DIRTY;

Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Cheers,

David / dhildenb


