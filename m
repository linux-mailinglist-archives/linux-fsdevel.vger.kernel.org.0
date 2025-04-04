Return-Path: <linux-fsdevel+bounces-45801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D62A7C53A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 23:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A45C1783EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 21:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A5E19994F;
	Fri,  4 Apr 2025 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHBfZ8mh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1800714831E
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743800408; cv=none; b=YtIXXcDJ5eXGnBG14I2+bHBZjziru17jE74F7O7TBro7vbYHVV8AMO3yogFv5cdxcSn9ZYNGrAh/dLc2LVM5HGx7hEDpcqkQg+VTRrgoSayr/fRbV9nNdFe0c1fxSPww5zGhx7HSXmXZI6jgY6KXYBvUBz0iULn1ap7nvn0UbFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743800408; c=relaxed/simple;
	bh=PWtFnEa5Ro/FyLUCLqP/91Qz0VjZf8lfUdQwS36rjKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfPwmvEibKZ23sBacpcTwep8jl8E4I1lGfv6G8Zp1dj6ZZ6V0jFRFhT3UTaUTUkC0zIxKfVfKQTbPiTmcI/xUXlI+09aDWb6weeXwKflcLrD/fT8t6WEoafh+XF/ogv+fyAAb0vLHJx+vcAFytSeLZoLTbr2P7ztmLeC7NyxQ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHBfZ8mh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743800405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YhsonaFCzIfa4nA3O3+Fv/1AXGJWz31w9SebUkiE5cI=;
	b=BHBfZ8mh9MUchhJ+II8PdkEvNFxofFvz53NaaZ4IWu5I0xW1bby57w0aYl3164Ur8zrsty
	yAHscPRK+K1lDfauWiQIxd69tuuLldCKDq6mV/k37I8rVizBYa/8SIZl5VsjwwxRPVAIWe
	J9FPUHrwUm8bYkwswxaNho+2JKAsz1I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-QTck9gS4McCDhh6tHhYjdA-1; Fri, 04 Apr 2025 17:00:04 -0400
X-MC-Unique: QTck9gS4McCDhh6tHhYjdA-1
X-Mimecast-MFC-AGG-ID: QTck9gS4McCDhh6tHhYjdA_1743800403
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3913f546dfdso1433511f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 14:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743800403; x=1744405203;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YhsonaFCzIfa4nA3O3+Fv/1AXGJWz31w9SebUkiE5cI=;
        b=iD1lZdU68RfoUJGjH07NRHXy9FkXjm/66J8+fD+jMw5s1NpB+xKSvYeAyZq6rU1Ggs
         LEDZwPErCIRL7r4wtLCVrLXR3MT4d4DK3q/DzbRVe3vGvPm2D05MyYo2D8r1o2940d8d
         uUoSLI+7BBRnSjsJJGIy3IHQrXAuMl524EXr0FGpMOGH/YM5RGHUgKWggixgeBuxru5T
         2Wf9XP7wtPILdy3VoXrnGU6vLJBSzNTVsWAffm4aLYol3e5JK+ZoWz95/do7w1JHG7aF
         6rWxc8MRUNxKqU8vXQE8ndBpXmXQM9CY2Q0qW9UuF9oU3PJ95NHFvWRf9lhoImJElhL2
         4dTw==
X-Forwarded-Encrypted: i=1; AJvYcCViyGjJwHPuG0NEeZLiOZ3t8wyvT7oavRdCqT65ywDtTqOOVkxRuWdl6eUEdiRdIUao2T5WJYi2iJ/RVe+K@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3g2tvWm15j3NBn6CCLUWA6uX/3ZbFTt9c6v4yl22P43D2aSM/
	n7NN44WIIaWslTKY/MEXNV9chsLjEO/FfnxlBVjWtgCMeffHjOIXmyixs2b98MU0Dulpz8jt0db
	chlJZGCTp8+pnL933SYCZILFlwHnk9fwj6eDiJNJiF2Pz0DKALTLspLlKFT9KfW0=
X-Gm-Gg: ASbGncsInXSkkY0UYNbnbyf8AI7Z57FxI3kVegOFJkXwEsKo/WbUtr5gLXBucg53TCp
	GPm+I/vYXP2nIi8z+WFi3TKMPFod/q9C8JqqJKWnHRJFfU5gE+j3t408dr1G0lHnb9sf8wnW/Mk
	ccnJvx2JEWrdgf+0t7cnX6ND/uiVIqgB9Q7wBVupqkNBzSJ9ZmHOAVdi9ZLupWblsE9uR52zfjf
	GDHCTLquHonsxxiNIwoY02Dg7jyMnKbPgfdOmXt7XCAM+q78A+T+KTgZrRb0TyJmVg1uWOIUEt6
	+kyslTiuADQh1+p+V9D0HaE50E3d+nNELaEWTuwOzj4oaJMp2p1LKxHZxTlaG48Nr3G9uBxMs4+
	Yb47Jk7OmnKNG7geJik09RDJLYAXZRp2/ghZSMH2AZTs=
X-Received: by 2002:a5d:5f42:0:b0:39c:e0e:bb48 with SMTP id ffacd0b85a97d-39d6fc0c1b2mr535833f8f.8.1743800403453;
        Fri, 04 Apr 2025 14:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNzBLILDl3rt90I0MAcaLgMDWJ4unyzR6xSnv9sHaM/OKHBMCkSlm4xBYV7VcZ5d2IrpmePA==
X-Received: by 2002:a5d:5f42:0:b0:39c:e0e:bb48 with SMTP id ffacd0b85a97d-39d6fc0c1b2mr535827f8f.8.1743800403150;
        Fri, 04 Apr 2025 14:00:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7900:8752:fae3:f9c9:a07e? (p200300cbc71b79008752fae3f9c9a07e.dip0.t-ipconnect.de. [2003:cb:c71b:7900:8752:fae3:f9c9:a07e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c300968c4sm5260127f8f.9.2025.04.04.14.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 14:00:02 -0700 (PDT)
Message-ID: <90309a63-c817-4b60-9b09-ff558a79d5af@redhat.com>
Date: Fri, 4 Apr 2025 23:00:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] filemap: Remove readahead_page_batch()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20250402210612.2444135-1-willy@infradead.org>
 <20250402210612.2444135-8-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250402210612.2444135-8-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.04.25 23:06, Matthew Wilcox (Oracle) wrote:
> This function has no more callers; delete it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/pagemap.h | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index c5c9b3770d75..af25fb640463 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1447,20 +1447,6 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
>   	return i;
>   }
>   
> -/**
> - * readahead_page_batch - Get a batch of pages to read.
> - * @rac: The current readahead request.
> - * @array: An array of pointers to struct page.
> - *
> - * Context: The pages are locked and have an elevated refcount.  The caller
> - * should decreases the refcount once the page has been submitted for I/O
> - * and unlock the page once all I/O to that page has completed.
> - * Return: The number of pages placed in the array.  0 indicates the request
> - * is complete.
> - */
> -#define readahead_page_batch(rac, array)				\
> -	__readahead_batch(rac, array, ARRAY_SIZE(array))
> -
>   /**
>    * readahead_pos - The byte offset into the file of this readahead request.
>    * @rac: The readahead request.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


