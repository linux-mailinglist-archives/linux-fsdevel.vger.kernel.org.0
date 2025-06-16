Return-Path: <linux-fsdevel+bounces-51722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F294ADAB94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 11:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA6837A73C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F51273812;
	Mon, 16 Jun 2025 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0s57Of2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E9273810
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 09:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750065256; cv=none; b=HdMxW5Tjvkjz0hCFoalSgwxc6fLK3IEkHuI9lR0ekA3jvsvac61ilYMO5wYniHhp2Hz0ep20kW308H15bE9vY7+FRQgy/LnZr21rIfC+CSDkhZaf94SVWca4yBCwAbSIGHl5p8Wrbqu+Kj3bRS3dq/72ZkT4FhE3wgLnf3YzyCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750065256; c=relaxed/simple;
	bh=aHvslj4u0YmVjl6caLmXcxjAEu5IMNlDH3uwp1kYvck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXIiRWZgv7e7blZbuy8e25VC9Yxs9J5+vV55ijZDS8Z4sdwlJJo6L9+fFTr1g+ga1yOeFX0M43XFWRhNkj/57CR+aEDaCyYmBfRMcdPEtgZpkC15qOFCLTSPPH1X0OMGLUybeVgU7NI0vHLbSTXg1sbtYYmXDgNpm/sjNQ4TUfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0s57Of2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750065253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wuv2mA62fcjoUn35N/C8umkBOU3qJG3E1wudHQl3vVY=;
	b=K0s57Of2TEEBxM2VMJ+kz4AadYSVfFRKe8ZQZG4mZTYWDFN4bkCRFnu1C6roorSp0MJD9M
	SCB8c526SkvkxFLFrrqTOw+c8O+SmmUuV/9b18NB5bIL1pkaB2Y2MXDRvqaXzS1wrFGhNN
	RY1aqALBkuP2kfuxt7ANGvI4gdbiTP4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-PCVZhf2iMNyq_ufwb9d-bw-1; Mon, 16 Jun 2025 05:14:12 -0400
X-MC-Unique: PCVZhf2iMNyq_ufwb9d-bw-1
X-Mimecast-MFC-AGG-ID: PCVZhf2iMNyq_ufwb9d-bw_1750065251
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso1503309f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 02:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750065251; x=1750670051;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wuv2mA62fcjoUn35N/C8umkBOU3qJG3E1wudHQl3vVY=;
        b=o0wljjlwY8gm9pQNMyRfBblL6uUTtn1QAZF2Wj6Mwx6g04a+luRNWtSjjPXEP2mWZM
         QQvC54NXN2bMm2x8XqZxxAX7UwLYsAc7GKXbXP/TybVSXMXnMXvVJ9l5O0e27xUk9Ban
         FOwXXOBCrjMKlMRy4YaLEtmgyw4pkw7CzIJzHE9XE1HLJLM3V9KZLM41kWVT7ZtXsnEO
         UjpokpTgcsST0YqQra/DbwY7XHf7hnIpBiVurztfTmlNw5xA0fSjoCIQ3eL/B/NRd8yZ
         +I64Dd892OsySGwA4MHcuXIJi5nFTx59sVd/MifgHhYgjI9EJqU0UF5m4yj7+KST/n5Z
         6q6g==
X-Forwarded-Encrypted: i=1; AJvYcCU3dElqs7dOol49/ItlcmFqF+fYf0qegsuRiLvMouuT/gh8xNDzo6gDbSgrBFj0qBM/052bBastxxXgy7Uw@vger.kernel.org
X-Gm-Message-State: AOJu0YyeL18jArf+v5Vl5lKQ4Vs0/xpipZmVDCcXYh38FuI4bb7m8cFx
	k5wy+65wWtcZKrp80vxqx71NCdmvn457Wc0o/Ep5SgYHacmFdQpq9fNWCy2kpFptlW24ZDokR0d
	DfM0V6bq6KATobaW+t/a0kT1Y4s9AM7U2Qyonk8ED1OZTPN8jnttXVY5yTPY/DuF1C5I=
X-Gm-Gg: ASbGncvRiAPTRMMmwcfksWCYUWysuIezIOZcgpBMHPyLgyQwuvuV5Dd8faPq9CrXKJs
	D7Xrrsc748ogtWNXMJCVDPoJjScIiyrnzIM7mEkuKua6KV9Bl864U5lZC63LRfUg0vXXhePYzpf
	48xrfsBulXxXnaEPmvaA/jPY1DUi56ea27tf/DBtzKzauj2FoPYe+1v6cPyaXlrdEdGTlIQvDJX
	KLDli17u+aqfUC13tefO0izMuD6TwzEL+aAYua03G5B0JDrBQP8C5S+CQOPn8EE433R8OKYhZyE
	ZCMnpOlQ86uaz0sskSw26X1TayCWAUCJCor40A606mDp67JVrC+2piDX6dnwshFrs7Yat42qUL9
	Zbg1tXkJEEbhTVdCvwGl4IrQV9KoicgevvZDHUMQ0+3mfRIA=
X-Received: by 2002:a05:6000:22c1:b0:3a5:276b:1ec0 with SMTP id ffacd0b85a97d-3a572e8c5dbmr6274590f8f.45.1750065250794;
        Mon, 16 Jun 2025 02:14:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1eku5C1wKEWMA/zLh1Kb+dGj72gg4ERn3ZZ3O6rewQsnKxfuyXv1A1iI5gYDDemL/53xxLg==
X-Received: by 2002:a05:6000:22c1:b0:3a5:276b:1ec0 with SMTP id ffacd0b85a97d-3a572e8c5dbmr6274538f8f.45.1750065250350;
        Mon, 16 Jun 2025 02:14:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:bd00:949:b5a9:e02a:f265? (p200300d82f25bd000949b5a9e02af265.dip0.t-ipconnect.de. [2003:d8:2f25:bd00:949:b5a9:e02a:f265])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a7f8f9sm10462943f8f.42.2025.06.16.02.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 02:14:09 -0700 (PDT)
Message-ID: <a65ee315-23b7-4058-895a-69045829bd01@redhat.com>
Date: Mon, 16 Jun 2025 11:14:07 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mm: add mm_get_static_huge_zero_folio() routine
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Dave Hansen <dave.hansen@intel.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de
References: <20250612105100.59144-1-p.raghav@samsung.com>
 <20250612105100.59144-5-p.raghav@samsung.com>
 <e3075e27-93d2-4a11-a174-f05a7497870e@intel.com>
 <cglmujb275faqkpqmb75mz4tt5dtruvhntpe5t4qyzjr363qyr@vluzyx4hukap>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cglmujb275faqkpqmb75mz4tt5dtruvhntpe5t4qyzjr363qyr@vluzyx4hukap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.06.25 22:54, Pankaj Raghav (Samsung) wrote:
> On Thu, Jun 12, 2025 at 07:09:34AM -0700, Dave Hansen wrote:
>> On 6/12/25 03:50, Pankaj Raghav wrote:
>>> +/*
>>> + * mm_get_static_huge_zero_folio - Get a PMD sized zero folio
>>
>> Isn't that a rather inaccurate function name and comment?
> I agree. I also felt it was not a good name for the function.
> 
>>
>> The third line of the function literally returns a non-PMD-sized zero folio.
>>
>>> + * This function will return a PMD sized zero folio if CONFIG_STATIC_PMD_ZERO_PAGE
>>> + * is enabled. Otherwise, a ZERO_PAGE folio is returned.
>>> + *
>>> + * Deduce the size of the folio with folio_size instead of assuming the
>>> + * folio size.
>>> + */
>>> +static inline struct folio *mm_get_static_huge_zero_folio(void)
>>> +{
>>> +	if(IS_ENABLED(CONFIG_STATIC_PMD_ZERO_PAGE))
>>> +		return READ_ONCE(huge_zero_folio);
>>> +	return page_folio(ZERO_PAGE(0));
>>> +}
>>
>> This doesn't tell us very much about when I should use:
>>
>> 	mm_get_static_huge_zero_folio()
>> vs.
>> 	mm_get_huge_zero_folio(mm)
>> vs.
>> 	page_folio(ZERO_PAGE(0))
>>
>> What's with the "mm_" in the name? Usually "mm" means "mm_struct" not
>> Memory Management. It's really weird to prefix something that doesn't
>> take an "mm_struct" with "mm_"
> 
> Got it. Actually, I was not aware of this one.
> 
>>
>> Isn't the "get_" also a bad idea since mm_get_huge_zero_folio() does its
>> own refcounting but this interface does not?
>>
> 
> Agree.
> 
>> Shouldn't this be something more along the lines of:
>>
>> /*
>>   * pick_zero_folio() - Pick and return the largest available zero folio
>>   *
>>   * mm_get_huge_zero_folio() is preferred over this function. It is more
>>   * flexible and can provide a larger zero page under wider
>>   * circumstances.
>>   *
>>   * Only use this when there is no mm available.
>>   *
>>   * ... then other comments
>>   */
>> static inline struct folio *pick_zero_folio(void)
>> {
>> 	if (IS_ENABLED(CONFIG_STATIC_PMD_ZERO_PAGE))
>> 		return READ_ONCE(huge_zero_folio);
>> 	return page_folio(ZERO_PAGE(0));
>> }
>>
>> Or, maybe even name it _just_: zero_folio()
> 
> I think zero_folio() sounds like a good and straightforward name. In
> most cases it will return a ZERO_PAGE() folio. If
> CONFIG_STATIC_PMD_ZERO_PAGE is enabled, then we return a PMD page.

"zero_folio" would be confusing I'm afraid.

At least with current "is_zero_folio" etc.

"largest_zero_folio" or sth. like that might make it clearer that the 
size we are getting back might actually differ.

-- 
Cheers,

David / dhildenb


