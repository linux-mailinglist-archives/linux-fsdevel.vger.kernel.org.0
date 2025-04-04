Return-Path: <linux-fsdevel+bounces-45802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2431CA7C53B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 23:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16DC3B6179
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 21:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C458190462;
	Fri,  4 Apr 2025 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXNI77Dt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC2E13CA9C
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743800488; cv=none; b=r3JW2NRDOU4w4DM+tySdXWgjz2BKnsDgMHhqD/IIMQadRJX3ua/vTjWbNdBkpe4BTXLUAJokXzGSKNURXrGf5HvtHObUcFw45CkPbyNfnpKkc438pfv64H0H2a4uj3JqZmv7WNTfK9GMU/Pu8RYwwyOYUiZtHWg/B8dwsLymf28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743800488; c=relaxed/simple;
	bh=Nek71vLokEOmdRHIVnip3VNmUezFiwIYpYuhmkSSkhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fD52N6NFctkfwwgWROou5LUwPQB0dQ3cuAHDPZrc1RCD+wUVr1ugHUExY2SIrut0tH7BAB5VdAYuBRIpGneDCiUzBQi+NaKL4Qh+3GOZzY1Xbkpsg+HguRMkJv99VI5x33ToK4uDiPcekG+u02rM8HmW7VHFRfzDlmJewV+stsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LXNI77Dt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743800486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=udYcQgKEbbzfHuChUfzo8OJ0dY/ckU64VmidcUJ4QWA=;
	b=LXNI77DtpXWLUGBqlMfY0TmsEmlCxu4KNUuwQgXTGL6sOxbcQk65YmNsTVBWk8GhzPW1em
	bwxrSbwlKXq9UiBF1G2gkIHbNjBspTnYzOp9LQfB5jberF0BVcDSl4D+wBqYMyVHCT1Yxz
	TSyvVgkmOtw2awoKLQEKkZPoBtt8WTw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-4O2BY61BNxSDc1XekAIRJQ-1; Fri, 04 Apr 2025 17:00:25 -0400
X-MC-Unique: 4O2BY61BNxSDc1XekAIRJQ-1
X-Mimecast-MFC-AGG-ID: 4O2BY61BNxSDc1XekAIRJQ_1743800424
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3913b2d355fso1140963f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 14:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743800424; x=1744405224;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=udYcQgKEbbzfHuChUfzo8OJ0dY/ckU64VmidcUJ4QWA=;
        b=jfi3DD2UOKVDO11WtEBCYqrkCRNReezKdENNK6sy34JJaMSLE+Ki7jp910TnA4aGc+
         ghmH7O/F8wRMxY1ww+iAPq8VXiyJR989jf/wcxCuGWP8TF2SZ8RCHjL6erJpjLEMMlCI
         oDFK4K1+KsAD4y83CLiTww413fnCNjzA07W1h2OQNKZMbkYrhP0jmuA/K4M/G6YD5BNl
         nRCdG9jZY8CP/ZHtLojL5kyvUNSMBQYWNnbldio/EVFvGK3bwGWhZumm9XAv/bBmlVM5
         OVC8dhLv7PIh3xwTTtVLDDHUPRTOlqBegUeX82BaWaSp15ETE1aYFGTjzOX4cEO5gbGT
         Dtlg==
X-Forwarded-Encrypted: i=1; AJvYcCXz6i6ckB4AgvDg8I6zvE2Ccwyv5wlllrm+3U3Uxosusn7cy/UaGpiGbXvUqBpg2PB8a/krI9LtNIp5f/he@vger.kernel.org
X-Gm-Message-State: AOJu0YwEOOrOuW+zJBkaY5AZ6Eqd7FfFz9GTa5BVrTpKUUvFqIxDhd9i
	Awa1gx36mqc9Jw8pRwqm4IuKpbIkkIUjbp4te05lfoUmaYL50vVwEZk/Sfs7PoDS5uUKWhY8lmw
	gSh+6CSS+jsAjbBiL3PGuadd6glfNnnKnjPrzUkwO3UKA8b/wpUlArXd3pnNv4Til42WgTpzWW2
	j6
X-Gm-Gg: ASbGnctZZARydJe8h3as5VWfHYJCvreZPqfKIBfWWWwXeE7xysViJ/HZPc2fZgvLOWq
	T8fbhZ8wla3rKvvprHgxlORuDRj/aRwEfAs7aLVasL6526FPLsbH6Wq0cLf0QneH8AMXogugbi/
	k1QnqVXGfIo4LIiJcN4Q/xtige1s8nYhbUP24Ryod4VUExuLb+NQ3+WCoYYTUNI7a0JDkyKuzMN
	/+Q3CR6IetI5g/+Cr4wB7tg31BmcnzGJavPTqsxeZNNhuYsBoBY6uF0z6/XyfgFw5O7KM/4FkxQ
	Z/QR3//5CYNxzFCf6S6MBkB7zlYW1Iwpn2LYOzXWLMYlb0GeV7TfUZPSKYLz6YaFFMm7UiH3OqF
	AYb6CNDH6zUKD0VQl++5gF9eZ5XXlfcIYBRoh+RnQ+Xw=
X-Received: by 2002:a05:6000:40da:b0:39c:3122:ad55 with SMTP id ffacd0b85a97d-39cb359703fmr4168042f8f.18.1743800424172;
        Fri, 04 Apr 2025 14:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk+zMu12pmJdAi1owYMdxBPyemxQV9RoRBxMd9QcPDdSd4mLekVmDq5mhlLfEk/F9gFVm2/w==
X-Received: by 2002:a05:6000:40da:b0:39c:3122:ad55 with SMTP id ffacd0b85a97d-39cb359703fmr4168026f8f.18.1743800423830;
        Fri, 04 Apr 2025 14:00:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7900:8752:fae3:f9c9:a07e? (p200300cbc71b79008752fae3f9c9a07e.dip0.t-ipconnect.de. [2003:cb:c71b:7900:8752:fae3:f9c9:a07e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a79bfsm5357904f8f.36.2025.04.04.14.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 14:00:23 -0700 (PDT)
Message-ID: <63b49a3f-ea39-4fe6-9bce-482d55c173e9@redhat.com>
Date: Fri, 4 Apr 2025 23:00:22 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] mm: Delete thp_nr_pages()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20250402210612.2444135-1-willy@infradead.org>
 <20250402210612.2444135-9-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250402210612.2444135-9-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.04.25 23:06, Matthew Wilcox (Oracle) wrote:
> All callers now use folio_nr_pages().  Delete this wrapper.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/mm.h | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 99e9addec5cf..0481e30f563e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2206,15 +2206,6 @@ static inline long compound_nr(struct page *page)
>   	return folio_large_nr_pages(folio);
>   }
>   
> -/**
> - * thp_nr_pages - The number of regular pages in this huge page.
> - * @page: The head page of a huge page.
> - */
> -static inline long thp_nr_pages(struct page *page)
> -{
> -	return folio_nr_pages((struct folio *)page);
> -}
> -
>   /**
>    * folio_next - Move to the next physical folio.
>    * @folio: The folio we're currently operating on.

Hurray!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


