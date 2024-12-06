Return-Path: <linux-fsdevel+bounces-36619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1959E6C4A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 11:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D595018825B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009A01FA254;
	Fri,  6 Dec 2024 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWhUa8qW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7131BD4E5
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480986; cv=none; b=EhISJybRVKxCHw0/S+CCOcjA1KdJFz78+YlSoyArsePiSbTBXEDl0EdcsuHtp7h5TFUh1QQmhzTDpwC5PTXGEeJvoDx5xPbcowzJNJ9JEeXLhAiHSEO1l0PNzViiP4WZ2YgUkZu6t6pACLB5T51AjbcBXZwW6CwRN0GOunu9Vu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480986; c=relaxed/simple;
	bh=BfxBvifZQCyX7xwNcJVjx+TU4Bcyv0z19YZBs621YVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yh7EWuLn46aIEtaL+PQXH+2KL1zXeHUE++G1GPMG7VzLZcPL6UBMt/bcgIFuhErXKz6hAWe5nK4Xy8//oRgQX8XtBEtrNkEhxNiZWo58lF8lRXLroWugnP5j9Zj77dkYkA7b10HhBqksm1DQZYFT1c7T8PydPYH2AGzgg5sycPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWhUa8qW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733480983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=crTYWyzn/Re/2TqoIVaf4Q+WwdJ5ddEgtTEzXUyKEso=;
	b=SWhUa8qWDX+d4MBNJkmX8XZaRmgQbciWCQokmwms52WF61h6wq2bPnEc+wZKj080uJsWdE
	mKFQXsBQ017XK4Akda89C37cTPRiXH1nKRcc/fOOVQPoSqbpSJHDceWU5lRbNHX+YArpMN
	G3zWZnUhUmcLI+W+2PJZUOL6aG4uTaM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-da6vuEPaNc2sPa58XysaOA-1; Fri, 06 Dec 2024 05:29:42 -0500
X-MC-Unique: da6vuEPaNc2sPa58XysaOA-1
X-Mimecast-MFC-AGG-ID: da6vuEPaNc2sPa58XysaOA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385df115288so872237f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 02:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733480981; x=1734085781;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=crTYWyzn/Re/2TqoIVaf4Q+WwdJ5ddEgtTEzXUyKEso=;
        b=pWOqdffsltsBLgkIpgSiCWuUuj4uOsWtwDtKwJHZA6J/8Rlqx6rfNU+Jb4CufCAdfh
         0kYVdlWSMzqNRUkjUxquMvePRyInOaQcyrEOEVR2ldFZtiVXi0mFTMPXOugk7kLD5nCX
         AFYb4gO8Zl0PExb4HmFnZRtDCh6d1kGk235vsk5jhZxtViCR+glqDisbhUHaTfJc1Zvp
         tkiWDddjRZorj0lZCMaCAfJsDJC8QBieb5btqEYAsQZeyI81T0nH3Cj82hCOcASEBaY1
         oIcJbN8UJVoSc48BnlaeOXYSfHroXiXOw9nd+8YY/BdFOttQsOoBdn7BmBign4bIMh7x
         qMhw==
X-Forwarded-Encrypted: i=1; AJvYcCV0WpWsqdOfGkT6r5Y2zQ+9KsmfHBru4Eekr+TZZ14+3KgSSTJL2FYLwo0GQW8FmMK6hFCMZKrl/6oDIevT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ifTps478Vl1sfrJ/jEvfPku/tSrjq6QxslC4RS5+JmGFF3D/
	bG/MLNB9ImV4CoysA29FmDbf1fTrNrKH7XrkfdL5yc66/UeHopWgPlC4jpvp2PbA1AZ2U7r51BG
	WBYTP+ea1s3k+x314F2WcIeiuSSaUcAQmsqCWD+NF/+Pfzj4nKSroxBVkXlv/OEU=
X-Gm-Gg: ASbGncsSAfbyVEMYdgaM3TvaQnTk/93hFtacZphzNjfGjCwjAWPwy2lD1VAos4hloJA
	CAA2ZaT0hqX7KjejCdpYcgup2UXGVEMtYkpH1kVsQN10YLtL5p5M10SL0qhHnYuNIuZy9bjZp9R
	l41brxFeaDYIBKfbKWcYRaePnn4/jxayNAMx1udLALaaJ2OA9Q7HZ8qm7XIcTErZG1JlYEqkHCB
	0aT0hYajy7xJzR+N64gE0mgDPke0v09vEAxvnXR0hXPtXm6wBQ72rRpHgLwyPZOVigeGh+hNPOr
	9EXMZOiMq6W2pLp/53Soa3UuB7u3FH3Q6BjdHztovkHg+mkGI75k+BYJFM/xG1IMqvHpLuUMpwW
	p9A==
X-Received: by 2002:a5d:64e7:0:b0:386:1cd3:8a09 with SMTP id ffacd0b85a97d-3862b33baa6mr1707703f8f.1.1733480981148;
        Fri, 06 Dec 2024 02:29:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxOqpTSxmUtQDodZFCKj1wweUhXSgZ97O5uRZxNOaG1Z6sAnCn3dDJG4gngRrYSA9cesnwGw==
X-Received: by 2002:a5d:64e7:0:b0:386:1cd3:8a09 with SMTP id ffacd0b85a97d-3862b33baa6mr1707674f8f.1.1733480980787;
        Fri, 06 Dec 2024 02:29:40 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:d000:1d1f:238e:aeaf:dbf7? (p200300cbc71bd0001d1f238eaeafdbf7.dip0.t-ipconnect.de. [2003:cb:c71b:d000:1d1f:238e:aeaf:dbf7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46cdesm4239800f8f.57.2024.12.06.02.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 02:29:39 -0800 (PST)
Message-ID: <393a1314-79b4-421a-ae45-f33c1bb600f8@redhat.com>
Date: Fri, 6 Dec 2024 11:29:37 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/17] mm: factor out large folio handling from
 folio_nr_pages() into folio_large_nr_pages()
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
References: <20240829165627.2256514-1-david@redhat.com>
 <20240829165627.2256514-3-david@redhat.com>
 <u3mwngmik3i2qgj3ymjx26chbabsjzrtf42dtvh3ejara2opa7@osasxccmufb7>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <u3mwngmik3i2qgj3ymjx26chbabsjzrtf42dtvh3ejara2opa7@osasxccmufb7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.24 13:18, Kirill A. Shutemov wrote:
> On Thu, Aug 29, 2024 at 06:56:05PM +0200, David Hildenbrand wrote:
>> Let's factor it out into a simple helper function. This helper will
>> also come in handy when working with code where we know that our
>> folio is large.
>>
>> Make use of it in internal.h and mm.h, where applicable.
>>
>> While at it, let's consistently return a "long" value from all these
>> similar functions. Note that we cannot use "unsigned int" (even though
>> _folio_nr_pages is of that type), because it would break some callers
>> that do stuff like "-folio_nr_pages()". Both "int" or "unsigned long"
>> would work as well.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/linux/mm.h | 27 ++++++++++++++-------------
>>   mm/internal.h      |  2 +-
>>   2 files changed, 15 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 3c6270f87bdc3..fa8b6ce54235c 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1076,6 +1076,15 @@ static inline unsigned int folio_large_order(const struct folio *folio)
>>   	return folio->_flags_1 & 0xff;
>>   }
>>   
>> +static inline long folio_large_nr_pages(const struct folio *folio)
>> +{
>> +#ifdef CONFIG_64BIT
>> +	return folio->_folio_nr_pages;
>> +#else
>> +	return 1L << folio_large_order(folio);
>> +#endif
>> +}
>> +
> 
> Maybe it would be cleaner to move #ifdef outside of the function?

Yes, can do that.

-- 
Cheers,

David / dhildenb


