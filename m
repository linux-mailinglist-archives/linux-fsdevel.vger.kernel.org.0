Return-Path: <linux-fsdevel+bounces-37943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 583D69F9557
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F106188ED9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C2021A45C;
	Fri, 20 Dec 2024 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vq4XQT8E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7017D2C182
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734708008; cv=none; b=VqKj18IN7JBqLmIfZTmELhDTOK5Au4hj8tzoVUpTo2JSuTt+PaiF3HjIy9SmuXZVfHXcSaeNY/v8AhGGL3UIeWV8JVJFaLCaEW9fRCYVkbJYQwGtcW8gDWFdNIVnGGDal5r8YA/ZFs26rxUoD2iI40PCk5Te9CC+l675dmUwRiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734708008; c=relaxed/simple;
	bh=RZEPWgLYDjiHN3vx58NrJVMH7U4OowqBjurZVfJ+3to=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIEDLGtYTHHmILU84T+zNdp4CeDfoy91UYDjzl3kFobr+HAtgF/zNqk9BecIrzJMF3DElHPQJZrvhxy2RTYDzRuCE9dJvF+gvo2ouoaQ5Ghz3fgwbDxZrq5UnGqdOKaonI619ghPsyt/WQ5eUFp3XZKu06dfxLp1+9TYSI7oEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vq4XQT8E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734708005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GSLhLAF27Dus1djWbXuEQF2P4ueNwx/IWO+wl4w6Zb0=;
	b=Vq4XQT8Etal4YtTTHfMk3r0aZNjSqU3Om4Y/dcqkCOKyMewLcdAT1PBub//zOErh2W4Qjt
	QFe2xD5MllZgHfoRi+9QGI6EBJY2Q6La4i+6zQ5uco9aefem/I6dlEa7es/vA34B3UK8Xu
	dKUNAOET/v4b7awl6AKeaQT6Lo2SS3g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-WmBQfO2PMmaXLM95v9uaVw-1; Fri, 20 Dec 2024 10:20:03 -0500
X-MC-Unique: WmBQfO2PMmaXLM95v9uaVw-1
X-Mimecast-MFC-AGG-ID: WmBQfO2PMmaXLM95v9uaVw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361c040ba8so11916035e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 07:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734708002; x=1735312802;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GSLhLAF27Dus1djWbXuEQF2P4ueNwx/IWO+wl4w6Zb0=;
        b=MlQChvLgNIU21Zu20hp5GCL5XKd4CzmEMxYaUM6DnvTE4QsaeLpR/9ThzJt6HdTrB5
         8slLMJ0zXixiNYXByYhjyVv+jS5FIQbCK24J5E1azznAsDui+AjgL5bo7OIw/4set6Co
         aDWQZD2nHi+o+p/YSxiDWMyhAc+yOyl0mWOf1EM9mbh3ylhcciqWHfU11WJ20S1TZ4/+
         giBY+skx+139kJUn7OyfdkdkshKtbEDB5UluTr9VBGfQzSyRVe/4yxicWm080ziI49Om
         hnmf8Sut+wG28LwjeiM+9owOPCuu+05A887P2Y+25JkHreRRlv6wGjc5D1EDfqCoSDvH
         SB6A==
X-Forwarded-Encrypted: i=1; AJvYcCVwCO+6OKtVKIkGjCxHZAZJvBm932kIHmZB2KXRTrETVKunAQSYVPhWK5mBkPxIX1TZmkmdqnM7w8IRDDNH@vger.kernel.org
X-Gm-Message-State: AOJu0YyDufDW1sSINnWW7yhu1U74gm+CM9bGFcL0PDbb3K5aDQ9Ad2c/
	irGzmezymsqSEMYXdJjv6wWRNN+fqL6PsIewFhBz93Rwmo4SA3LWXSsWrFw1/yYNAYsETkcgyLG
	norZYcFnJaUo/2wEyg7aeFjoE7A+mQrLghd9Z+IWntHS8Oeq3EEmIfFWa+/5cFv7h7a+CA1yXww
	==
X-Gm-Gg: ASbGnctZ6Bet1ptXq9Ja6j/cBh9F6QoxNFYi7U1aI8ST+GnGBX3t8uETpUBG/M1woti
	9yS+p423cOZQsa1zrOVG2hL7dync1b4JS8QE1+nCYm9PcXm0QebOzQVJbm/Y38TSbkfVGstF7X+
	UFaybDe357fSkHWRiOs7ihYeJPW6s4Lr9d10Z9BI68L4EYpUm+xEkoDqerpk6254NjpYPxgjoEj
	7QhCPc6nPsxaziEzK3ISRXCBIqWJShewaQv7J3aOluNQm+ModFX7Xi8AeW8DOiqQdJN7ScYUb7D
	uJuwOCJZG32j9JuLFca9Eov35Oza1hT1uVC90UKeTTSLSfoWPbcFTOFgDPtqDjyQ7L7AZ9CQgOo
	uhiEQ8Z+7
X-Received: by 2002:a05:600c:5488:b0:436:5165:f21f with SMTP id 5b1f17b1804b1-43668b498ddmr26296555e9.26.1734708002603;
        Fri, 20 Dec 2024 07:20:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW1Oqhfdpc6oK9Vd1HWU9G3K1S0GmvUViZlC6eqIxnVLitf33vN/LN4J02Qp4R9fzoO9abEw==
X-Received: by 2002:a05:600c:5488:b0:436:5165:f21f with SMTP id 5b1f17b1804b1-43668b498ddmr26296315e9.26.1734708002277;
        Fri, 20 Dec 2024 07:20:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:9d00:edd9:835b:4bfb:2ce3? (p200300cbc7089d00edd9835b4bfb2ce3.dip0.t-ipconnect.de. [2003:cb:c708:9d00:edd9:835b:4bfb:2ce3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e53sm4265574f8f.27.2024.12.20.07.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 07:20:01 -0800 (PST)
Message-ID: <2dde1a51-f4c2-4e0b-8ac6-b9859e194304@redhat.com>
Date: Fri, 20 Dec 2024 16:20:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] mm: add PG_dropbehind folio flag
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
 linux-kernel@vger.kernel.org, willy@infradead.org, bfoster@redhat.com,
 Vlastimil Babka <vbabka@suse.cz>
References: <20241213155557.105419-1-axboe@kernel.dk>
 <20241213155557.105419-5-axboe@kernel.dk>
 <wi3n3k26uizgm3hhbz4qxi6k342e5gxprtvqpzdqftekutfy65@3usaz63baobt>
 <042d3631-e3ab-437a-b628-4004ca3ddb45@redhat.com>
 <o4muibdbkbbgwpxgepzc2cwmtavovjathzn5zonxcjjkajyv57@xkfbtkef73ss>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <o4muibdbkbbgwpxgepzc2cwmtavovjathzn5zonxcjjkajyv57@xkfbtkef73ss>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.12.24 16:12, Kirill A. Shutemov wrote:
> On Fri, Dec 20, 2024 at 04:03:44PM +0100, David Hildenbrand wrote:
>> On 20.12.24 12:08, Kirill A. Shutemov wrote:
>>> On Fri, Dec 13, 2024 at 08:55:18AM -0700, Jens Axboe wrote:
>>>> Add a folio flag that file IO can use to indicate that the cached IO
>>>> being done should be dropped from the page cache upon completion.
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>
>>> + David, Vlastimil.
>>>
>>> I think we should consider converting existing folio_set_reclaim() /
>>> SetPageReclaim() users to the new flag. From a quick scan, all of them
>>> would benefit from dropping the page after writeback is complete instead
>>> of leaving the folio on the LRU.
>>
>> I wonder of there are some use cases where we write a lot of data to then
>> only consume it read-only from that point on (databases? fancy AI stuff? no
>> idea :) ).
> 
> Do we use PG_reclaim for such cases?

Good point, I looked at the pageout() case, but there we really want to 
pageout that thing and not just write it back, so makes sense to me.

-- 
Cheers,

David / dhildenb


