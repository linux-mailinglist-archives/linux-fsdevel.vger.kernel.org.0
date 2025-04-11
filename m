Return-Path: <linux-fsdevel+bounces-46241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2538EA856B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 10:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BBB4C71DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 08:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E933293B56;
	Fri, 11 Apr 2025 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezYBy5GS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8828F936
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744360645; cv=none; b=PGDdGWanAPb1xFJNVkOZ+kUXxg2ul+7FYmIwoNOTYYZydQ7tYVacw9Q9IHn22IFVn5HtBpEv7D6fy+bsqFZ/O3esdeSLCSellxzefvgYM/dABU3AZdEtHQeM2KChFGExS4VXbtV/U78f3t5zKBiBviZDkWzuDU++Y9QqDGchkAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744360645; c=relaxed/simple;
	bh=c0SN2cmlSRibJUhXnObd7lG8PnIaNfQ8ttuK6ETBMRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=cIJlETxQlv99SDJuyp73vWr7T5TQj88ilR8x0oZLbgpSm/JH+hr6En5+HSnua8FbrLMO7bDXhSA2U66BGlZZVkvHoVtcLsHOAvarfdFYQBIz7d5TZDLfXzoYODthAh26UQUaZu6Wvv5kSrdWqmMSrsn27mY0bWqVw0uyFTyzJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ezYBy5GS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744360642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JLslcSIDe5LlgtBN6zquly6cspPZPxoniRKKH+HI3wY=;
	b=ezYBy5GSwwPhmhlwbS+49FIzVAz7yFv2J0UXQt/DUWW8q6sSwzzdiFNIoG06cNfY7VY6NI
	T4nXtxxfTf8lRHSG4XW2o9rtB5axRVoh2XQZIXzSEfMSHpdww9lbhb8Q1pxQdIm357poVK
	zBG/Bsuh2/AK4bS06pnO844hvRPBKOE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-VCRMF2_sNK-NOKezez_UgQ-1; Fri, 11 Apr 2025 04:37:20 -0400
X-MC-Unique: VCRMF2_sNK-NOKezez_UgQ-1
X-Mimecast-MFC-AGG-ID: VCRMF2_sNK-NOKezez_UgQ_1744360640
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39c2da64df9so929760f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 01:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744360639; x=1744965439;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:cc
         :from:content-language:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLslcSIDe5LlgtBN6zquly6cspPZPxoniRKKH+HI3wY=;
        b=exKpZpR+KgWaiuGG9qNSrjJPmJu/R1LvO5NYNKaxZxq06p+S0+NhLyZw/ubgrTJYy7
         3Z+oNJp/zBONes/jJYSprXDyWqrNIckGDFrl3bSL/+2TKAIsgsR2zX3t4FmUnuGe/iRH
         vaDXFcnlmLU8kNBoSqE4z5AP5pUg9Vkz5jaP73NML6/abp0sEFNHYGLtOFh2PQNDgV72
         O1poZ5OCsqgeZouzPUZUdcI5OL9vKl03n3DUdH9Z5rrjvxrMec34sPDFjbIcUy8CAmBP
         BVJ7gcNcq2vqy5skVPmmsjpw53vYghIViHw82AlQxB1aViPCq/STV4cVjfHHi250w3D1
         NWXw==
X-Forwarded-Encrypted: i=1; AJvYcCUTjyxKacXfl/zsQ1M/UNdlOvUPkwrb4DkRlBEsm5j4pL7C75kp2RJSlFTuLP95UeUuxJeo6ZvnpiMYwjJc@vger.kernel.org
X-Gm-Message-State: AOJu0YwZZtRCnuKYbImPRXD394hHCiZquOvA/n2pTLj0NLJwkc4LUPct
	SGTMscZlsgEkZiE9H5DnF5G4yrIgWlB5b+ItIf4nB68U/JVmIbGMlM9Xa6wNxfKzniPFHnbJeJD
	94Y5AnveBGE5fPh9r0sVHpxYOeBydzLYwaP6X46xs2G8dgI8G31u+7ljAdsinxGI=
X-Gm-Gg: ASbGncsBkXvtLkz8QMvUr51jva7f540vgsQl2tQl1sfPpq+9hL9+Ht2neGJ8nv08qwE
	AVh6IdtNNTS+c0szPTUtCt1I9fIVRdGM+b3xcMOMN5m3uahXuuRspXTwt9U2/EFfGYDN9Dooyp8
	c4AlqsQGMukmUCPSJmSFUHMxrBO8JWAXtNApwbFSn011IIWRspH6XmgWP/Di9AjKsrpQ80u+Tla
	7+4FL3/+pXRC54UfMl8d3s8e0BA/6nLDhbw1s382fFfWO1LilLXGs9YEaXc2MSxbFIdYB0yChwV
	faQJ7WikQl7vlKDXWJUIF7SMHB9d2qbXQ3gLtMZ51r8TqBGSjIOHTLERw/OoKaSg2MZPmEz26h+
	pplNmyv+RMza4z2Xds72FLnUUl7WCBDM8V69+
X-Received: by 2002:a5d:584b:0:b0:390:de33:b0ef with SMTP id ffacd0b85a97d-39ea644020dmr1231844f8f.30.1744360639561;
        Fri, 11 Apr 2025 01:37:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy/nxOARvXAgp07ONVwaKQG7V6q2L0VxkCLDReSCXO28buDSxhWR/BAmHdCLtwrV6dKAUbOg==
X-Received: by 2002:a5d:584b:0:b0:390:de33:b0ef with SMTP id ffacd0b85a97d-39ea644020dmr1231822f8f.30.1744360639093;
        Fri, 11 Apr 2025 01:37:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:6800:7ddf:5fc:2ee5:f08a? (p200300cbc72668007ddf05fc2ee5f08a.dip0.t-ipconnect.de. [2003:cb:c726:6800:7ddf:5fc:2ee5:f08a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43cb29sm1309748f8f.76.2025.04.11.01.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 01:37:18 -0700 (PDT)
Message-ID: <6e1a9ad5-c1e1-4f04-af67-cfc05246acbc@redhat.com>
Date: Fri, 11 Apr 2025 10:37:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fs/dax: fix folio splitting issue by resetting old
 folio order + _nr_pages
To: Alistair Popple <apopple@nvidia.com>
References: <20250410091020.119116-1-david@redhat.com>
 <qpfgzrstgtyus3jkzrdpwxg2ex7aounhwca65bxwlqxws2drhk@op362gbaestm>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, Alison Schofield <alison.schofield@intel.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>,
 Alistair Popple <apopple@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <qpfgzrstgtyus3jkzrdpwxg2ex7aounhwca65bxwlqxws2drhk@op362gbaestm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(adding CC list again, because I assume it was dropped by accident)

>> diff --git a/fs/dax.c b/fs/dax.c
>> index af5045b0f476e..676303419e9e8 100644
>> --- a/fs/dax.c
>> +++ b/fs/dax.c
>> @@ -396,6 +396,7 @@ static inline unsigned long dax_folio_put(struct folio *folio)
>>   	order = folio_order(folio);
>>   	if (!order)
>>   		return 0;
>> +	folio_reset_order(folio);
> 
> Wouldn't it be better to also move the loop below into this function? The intent
> of this loop was to reinitialise the small folios after splitting which is what
> I think this helper should be doing.

As the function does nothing on small folios (as documented), I think 
this is good enough for now.

Once we decouple folio from page, this code will likely have to change 
either way ...

The first large folio will become a small folio (so resetting kind-of 
makes sense), but the other small folios would have to allocate a new 
"struct folio" for small folios.

> 
>>   	for (i = 0; i < (1UL << order); i++) {
>>   		struct dev_pagemap *pgmap = page_pgmap(&folio->page);
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index b7f13f087954b..bf55206935c46 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1218,6 +1218,23 @@ static inline unsigned int folio_order(const struct folio *folio)
>>   	return folio_large_order(folio);
>>   }
>>   
>> +/**
>> + * folio_reset_order - Reset the folio order and derived _nr_pages
>> + * @folio: The folio.
>> + *
>> + * Reset the order and derived _nr_pages to 0. Must only be used in the
>> + * process of splitting large folios.
>> + */
>> +static inline void folio_reset_order(struct folio *folio)
>> +{
>> +	if (WARN_ON_ONCE(!folio_test_large(folio)))
>> +		return;
>> +	folio->_flags_1 &= ~0xffUL;
>> +#ifdef NR_PAGES_IN_LARGE_FOLIO
>> +	folio->_nr_pages = 0;
>> +#endif
>> +}
>> +


I'm still not sure if this splitting code in fs/dax.c is more similar to 
THP splitting or to "splitting when freeing in the buddy". I think it's 
something in between: we want small folios, but the new folios are 
essentially free.

Likely, to be future-proof, we should also look into doing

folio->_flags_1 &= ~PAGE_FLAGS_SECOND;

Or alternatively (better?)

new_folio->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;


... but that problem will go away once we decouple page from folio (see 
above), so I'm not sure if we should really do that at this point unless 
there is an issue.

-- 
Cheers,

David / dhildenb


