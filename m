Return-Path: <linux-fsdevel+bounces-45795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36F7A7C52C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 22:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B334C189AEF4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 20:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E38519F101;
	Fri,  4 Apr 2025 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ym4iAH1A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0F634
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743799970; cv=none; b=Yz6XnG7RqDFvL8fz4mTdgpa4JnZpFEGxRJz8x6sY3PVV/MyIgVzAelb05SscMlqgMwS8Stvl4tKdfzQNMhfNMgZhrDQDM8/IuleYIM55xph2uVnszSiGNbPTJeWtgWoNW2r/bVZIsx/e5bd7VwWnh/MurVoU4ICtSCioihp0F30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743799970; c=relaxed/simple;
	bh=cqiwUMNv06mHMXUHe3F/Y4NIrgp1a/k38O7u9lcvcWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7N8QpOcgRp9EEARdTx+4ZNm1BGxNKmnCaaMSIADWAfm6SIW06iZ3uLHjelaqxBt3CEVhmf8rIp6qf2L3N+mv4Cx9mYzVrAk7bOGEX9LwEdQnBl18qi2WixfM99Tn0HTXCROcaBdV83rs1T0+gwzWW3jsbFiJWWjNZEspxcfwb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ym4iAH1A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743799967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bsUh0wvfi4se49z7kUlZqkv4Z+LM4wGz11GPajlP1yU=;
	b=Ym4iAH1Ab1sco2XfxKlBLSh8E++NQmURuFPr/nV75NK2nCsPPTZffuxpsguBzrxne0UlK8
	5ZB7IVKP456+SIfdFPTe/HthjaZ+ylKpF3Ntz1KCSCfiA0zNDWbwK7cHlzke/fa1G1xXkQ
	lzDROWtd6735KZOzBHALdYxx8hhIsEg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-hmAXnxxjOdyiKVvXosXPog-1; Fri, 04 Apr 2025 16:52:45 -0400
X-MC-Unique: hmAXnxxjOdyiKVvXosXPog-1
X-Mimecast-MFC-AGG-ID: hmAXnxxjOdyiKVvXosXPog_1743799964
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39ac9b0cb6aso1723086f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 13:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743799964; x=1744404764;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bsUh0wvfi4se49z7kUlZqkv4Z+LM4wGz11GPajlP1yU=;
        b=g+kvdq2dCps+jO21dV/3ZjhnUmFO84SOhufwZJEn91GJxms2i3OoO3mdpYIDSgC5U4
         dxNlMZj55iWNvFa2shwaGgTlTgO0o82ATlVnAF1XshYMtvR+PHIZwY4HPkw/ZPvzmIHb
         CaP+1Yek/x4IHHLtP5ZfMNOtoZUh9/XMl+iIeqJ9UqFgVOQ+pGUFdxE2Pd62aaOa8Ihg
         2nBXrHHxR4nU23uvCaLBK71q2eID/nK1fL1uVgLT/ewjtZjL+fdg3cKB/XlJ8E/IyRtC
         p2KplFzytUNpvduiQJll/9eaFypFkfF7wq7Wa6ZJsBBiBv+dr4NW/O4ecG0P6rQqkrJw
         xp3w==
X-Forwarded-Encrypted: i=1; AJvYcCVabprrvHwHGwBAYeFpSWooaJZv2b54MyBwBP5r5mWq7lO55NDq7PPqdeK2KPtvCqfGgD7AIc8OOOec6af2@vger.kernel.org
X-Gm-Message-State: AOJu0YzlXbcxvg0sKXYfgq7ue4BwhwQk5OPitzN3x5IYCXh4Mg8ZJdF0
	QJyD0HvMROgWeC5HLCxRiOV4ZS4eMBv2yIKTINNOaO+o8pZ2kpNbZBwWjVQPSDfx7Z9cs+EsPTr
	ygWlZ2eIwapOMJKe8OBvpERJKkxHP3fItXQzQyVGpDowb20Sr9BaVvmje91JQU/U=
X-Gm-Gg: ASbGnctXr6qN85TdJapv7pkPE8WWbOfnAuzW8xAeYZD94d5aFOwkLLuZzcdsIiuEZq5
	BAo2A3HYCXjA92rhxsX0tQpZ3wcBXrRHHHhz+Xg7TOJMcJOXvCPTzOTGd5Eb0k0VIjlet6/rnUu
	qBzh894BNFWgEI7EwGta4Sb4EKms65tVCI2STHRW/zi5nTXWVsR/gdpUOuElJQ7O7FsesKuD637
	cbGtJqv9Td1VAY6cX2hyRDzPZW+qkTjSHRRMyDh+s1RB+F4+sIomBtBQwGuJZUvRqdOnq7wQJ44
	XSafoVp1mWZ++Aj6NcaUPCvJ3hxbRvUo9LPFshQ9kYIbXWeUv5blCduOkVyQqSoO2d841K6G4JR
	dg3lYc0IwZVNrK8vw4mZV5B4BtpY4suxWy8f6t+12Ih0=
X-Received: by 2002:a05:6000:1888:b0:39a:c80b:8288 with SMTP id ffacd0b85a97d-39d6fc83ac7mr495232f8f.33.1743799964242;
        Fri, 04 Apr 2025 13:52:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErR3GwvekSsj/vbvBk/LnHjlLSjzQzt3WU+jP0oHkYFZ/wK1VTKzJLRlzbfUX/6LhsI+rb2A==
X-Received: by 2002:a05:6000:1888:b0:39a:c80b:8288 with SMTP id ffacd0b85a97d-39d6fc83ac7mr495227f8f.33.1743799963920;
        Fri, 04 Apr 2025 13:52:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7900:8752:fae3:f9c9:a07e? (p200300cbc71b79008752fae3f9c9a07e.dip0.t-ipconnect.de. [2003:cb:c71b:7900:8752:fae3:f9c9:a07e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226dfesm5264287f8f.97.2025.04.04.13.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 13:52:42 -0700 (PDT)
Message-ID: <17a7dee4-ed2f-4b09-b020-1cff3be69ad7@redhat.com>
Date: Fri, 4 Apr 2025 22:52:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] filemap: Remove readahead_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20250402210612.2444135-1-willy@infradead.org>
 <20250402210612.2444135-2-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250402210612.2444135-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.04.25 23:06, Matthew Wilcox (Oracle) wrote:
> All filesystems have now been converted to call readahead_folio()
> so we can delete this wrapper.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/pagemap.h | 22 +++-------------------
>   1 file changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 26baa78f1ca7..cd4bd0f8e5f6 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1308,9 +1308,9 @@ static inline bool filemap_range_needs_writeback(struct address_space *mapping,
>    * struct readahead_control - Describes a readahead request.
>    *
>    * A readahead request is for consecutive pages.  Filesystems which
> - * implement the ->readahead method should call readahead_page() or
> - * readahead_page_batch() in a loop and attempt to start I/O against
> - * each page in the request.
> + * implement the ->readahead method should call readahead_folio() or
> + * __readahead_batch() in a loop and attempt to start reads into each
> + * folio in the request.
>    *
>    * Most of the fields in this struct are private and should be accessed
>    * by the functions below.
> @@ -1415,22 +1415,6 @@ static inline struct folio *__readahead_folio(struct readahead_control *ractl)
>   	return folio;
>   }
>   
> -/**
> - * readahead_page - Get the next page to read.
> - * @ractl: The current readahead request.
> - *
> - * Context: The page is locked and has an elevated refcount.  The caller
> - * should decreases the refcount once the page has been submitted for I/O
> - * and unlock the page once all I/O to that page has completed.
> - * Return: A pointer to the next page, or %NULL if we are done.
> - */
> -static inline struct page *readahead_page(struct readahead_control *ractl)
> -{
> -	struct folio *folio = __readahead_folio(ractl);
> -
> -	return &folio->page;
> -}
> -
>   /**
>    * readahead_folio - Get the next folio to read.
>    * @ractl: The current readahead request.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


