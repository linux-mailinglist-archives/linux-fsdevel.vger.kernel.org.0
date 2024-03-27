Return-Path: <linux-fsdevel+bounces-15461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2CB88EC71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 18:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62BA4B23D63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 17:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E8F14D44C;
	Wed, 27 Mar 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIP3EpAP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CF814D458
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559990; cv=none; b=pnDNSm+LaD+wBaCfDhN2L4LLSYPHhmtvV+s0s5Jf5AQ0Xvd0BN4sWN2/Fsyy0Az7c3kP0ygJlblMpLsvVfd7+Qg3IhPdoF0NhxHq5yRYVlBwU2js4N5YpGL8qtNgxUlgkaf+JQGmvxkJmEE/bIlU1jlDulCwt8s6cdWKXgoSIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559990; c=relaxed/simple;
	bh=Cw+l7JDBrjKlLK2MPjuHtjTFwn6JGAf7SYJSc/a/zYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xu1bEDqdOmlMTF8HQiWR/Tz5nSfW05EyT3cQP8V0w90ja9+DrDmeeUa5vKi5KwoSvk7GLJ3U9gGBjUe2VNN7TBpzEq5NYfCiiHAYaOiFECHxYYIlgPglxclIkrQeK1aVw1DD58XFqmvgcJ4wzutj3xmOKmqRc2b9oQif0xhbujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIP3EpAP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711559987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f3LUSV0WrTPP7Oh2fTh2G4x4M6HWsmFiL1ZS7siT0r8=;
	b=JIP3EpAPM9IPfoyyx752W+R2624iiWj++29msydfWeySCj75YRTyYEOzPlsJM7VU5o9b2u
	RJTuIFHRPVPlsSgcFP9isd86+G3twJd+NWGoK/T+XDbUz9cwYAhcyCMkSRTNbODeuvlwPI
	ejr2WIYzR3N3XgJBs5qvGe9LQLBcYIg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-1nXAw28yO2S94dUPW6kPcA-1; Wed, 27 Mar 2024 13:19:46 -0400
X-MC-Unique: 1nXAw28yO2S94dUPW6kPcA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ed8677d16so4360310f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 10:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711559985; x=1712164785;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3LUSV0WrTPP7Oh2fTh2G4x4M6HWsmFiL1ZS7siT0r8=;
        b=TIAvCZhth8gQ79k0YY9RM+sPVmC0jdzWA1GqprhOZFDQrgDGCxeq81meAfvwXdCF68
         xcOlY4vF1PQgGxvKr2cqzHYbOoTiMvSaudO5iqGU5UGDwB3Af/hsyjQHgot8QFk3Nrvq
         UwKHD8YVpbzb5avLNB4212veHyo0SLAGS7C0iJkuUGuKFZlR2O8BmQu0pL1JFJHBaE6V
         vnsDncjp2taui5L0PjoV6S6fIh6HvadAUMQ6OZeEfzB+cIet0bGM0NK0IsZaANvWs0Tw
         HtD5omdnU0yy/jiRV9fjw5K2nZgUghk96PaI0EbQ+I5T9tvk4aOUJhAJHZGLV13yMQKb
         y5Hw==
X-Gm-Message-State: AOJu0YxkMjX/XgYUD2j2Ul7nBhRzNzErs8EPj9KFiO7WXoEak4VGLez7
	UeAH8Dn25+tp77ke1KsYf97NIQPmGZvIwyk8CmbksmhgWuhGbYh5CGFuIFcD5rsjhQq4MgZhQsb
	G8yF+6i6TTpLTZn10wHIp2dTZbvBOt2/p0NR9BhTI0IIpX0VTafHx1uQlnMfYCxI=
X-Received: by 2002:a05:6000:92d:b0:341:a63b:3121 with SMTP id cx13-20020a056000092d00b00341a63b3121mr486442wrb.29.1711559984983;
        Wed, 27 Mar 2024 10:19:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVagcFwUvqXP3qTTTCKIh57OVQ4BNYtg1bsA2M+LlHMgRLI+0X/bsq3lc1g8N1HsPoAgbzdA==
X-Received: by 2002:a05:6000:92d:b0:341:a63b:3121 with SMTP id cx13-20020a056000092d00b00341a63b3121mr486428wrb.29.1711559984603;
        Wed, 27 Mar 2024 10:19:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:8a00:362b:7e34:a3bc:9ddf? (p200300cbc7088a00362b7e34a3bc9ddf.dip0.t-ipconnect.de. [2003:cb:c708:8a00:362b:7e34:a3bc:9ddf])
        by smtp.gmail.com with ESMTPSA id df4-20020a5d5b84000000b0033e7b433498sm15352042wrb.111.2024.03.27.10.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 10:19:44 -0700 (PDT)
Message-ID: <90ebe320-bbe9-4dbc-9324-9dd12291b211@redhat.com>
Date: Wed, 27 Mar 2024 18:19:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove __set_page_dirty_nobuffers()
Content-Language: en-US
To: Kefeng Wang <wangkefeng.wang@huawei.com>, willy@infradead.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20240327143008.3739435-1-wangkefeng.wang@huawei.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240327143008.3739435-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.03.24 15:30, Kefeng Wang wrote:
> There are no more callers of __set_page_dirty_nobuffers(), remove it.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   include/linux/pagemap.h | 1 -
>   mm/folio-compat.c       | 6 ------
>   2 files changed, 7 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 35636e67e2e1..9e988f6f0bb0 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1163,7 +1163,6 @@ static inline void folio_cancel_dirty(struct folio *folio)
>   bool folio_clear_dirty_for_io(struct folio *folio);
>   bool clear_page_dirty_for_io(struct page *page);
>   void folio_invalidate(struct folio *folio, size_t offset, size_t length);
> -int __set_page_dirty_nobuffers(struct page *page);
>   bool noop_dirty_folio(struct address_space *mapping, struct folio *folio);
>   
>   #ifdef CONFIG_MIGRATION
> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index 50412014f16f..f31e0ce65b11 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -58,12 +58,6 @@ bool set_page_dirty(struct page *page)
>   }
>   EXPORT_SYMBOL(set_page_dirty);
>   
> -int __set_page_dirty_nobuffers(struct page *page)
> -{
> -	return filemap_dirty_folio(page_mapping(page), page_folio(page));
> -}
> -EXPORT_SYMBOL(__set_page_dirty_nobuffers);
> -
>   bool clear_page_dirty_for_io(struct page *page)
>   {
>   	return folio_clear_dirty_for_io(page_folio(page));

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


