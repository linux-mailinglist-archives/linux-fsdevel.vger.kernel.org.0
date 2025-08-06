Return-Path: <linux-fsdevel+bounces-56832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D4DB1C4EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 13:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B71D5617F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 11:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFAA28B400;
	Wed,  6 Aug 2025 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJi+OBnW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48392273D60
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479746; cv=none; b=boCHsEwPmuO5/93PmEE4cS9ASu1mMm6/s72KcZjdnXWTD0OSsgJM8jpCQ8sRfbCBs+/EwaNGzygDDH8HBiPcfrig/2vCjrWqjMl72erTM6nT7F280WB+MkFXDS9Ll+xDYF0f0Csl2bCRZmLIuWY8C19QFB38dXlj261Q6rJX3h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479746; c=relaxed/simple;
	bh=/wHboQm8ZaxJ5W4iRVbRuIiMgu0p4ODxEcvNNuYlK/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxN5f1tWov3HE6VueBeVJewTFjTbB3Z3yEtMlSxlF6vbJQdWSA5yDJb++kzxPOMO6MZ05yTLT3SQsAf6e2axQgF94qK7J74mWAZJpfJiQ5cGoV6D96D2wVqziJvECOebXt670GS4ELGsqz3KZyHpzubD9eMXIv1cqVGNitK5pC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJi+OBnW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754479743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lYbYIyAZ4oaVOmnPS9kKuJWUEwG+7pddjOFtFzW7yY0=;
	b=dJi+OBnW0j/auy+DT97+Mq0t77EjAJcFp8F1isieEr4igmUW6b7VaDuLXHH39YSYBGiCaM
	6Qg2TsCKnEJc1z06bimxsBlGM/fhZ/Dg1U9EMOR07IDum7TX4A8koDC1SeoFMVQHAQqhec
	umekEOh8OQhUVt5ZBJ++8BwH4UnRydk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-Faqg3IfGPwqaQMIUMTE5wQ-1; Wed, 06 Aug 2025 07:29:01 -0400
X-MC-Unique: Faqg3IfGPwqaQMIUMTE5wQ-1
X-Mimecast-MFC-AGG-ID: Faqg3IfGPwqaQMIUMTE5wQ_1754479740
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459e0f54c88so4944385e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 04:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754479740; x=1755084540;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lYbYIyAZ4oaVOmnPS9kKuJWUEwG+7pddjOFtFzW7yY0=;
        b=s1ofZ9Eo5M8SRiUdba/F1A7+oOU0CckhzFwNmMTdCdzp2GmDpMhimvyf5ogcBXxYVM
         KGwvqqGUEXoJNYjCyqC0MtTmQ7NPUy2G+B/4/8S0Gv5znpXr6JaKeBhcy8YOkH0P6xEB
         gNmKgYG5/vnsb0LWoq1mX5MQACkrkv7HnJHOsaxVSxOSqjTMlUDSx/bM7Opcz9dAFPrZ
         X6eD36hrVLq0Av8ArAfeLnAW3g/qeAeT6puHue4YBx/beaL0kya0+cMh6QlXMEu3OAfs
         +UUrS0TxN8Vb6fUeMrdRmGdGiz4JL1g4gFyP6SD9xRgWkUSG2A5iZ/Fy+LKQc5Zc0X8H
         kpxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvrmk6eXa6WNvAAnDjGu4iYbZBimJ0TsHn5g5xniuTxUNsjI2/yYNWsnweGmsoZbwM7aWwruswy+FawjKH@vger.kernel.org
X-Gm-Message-State: AOJu0YyWo6MBhwH7oUSyhLVzGMYbsAQJMWT9qbykAXT9xjNhbrGETOXl
	jjjvmEMa2ZdFUCZqa2kbtH8WwMqJyg82wSUQkzs9Z5qiTZLcbUQlAmjyD9gEm8OMrAGs9pC/SHX
	SzCePBQqt8YqAW239O5G8iDj3dXpSnH+xIla2trA5BmkyQlSxT6gEF7cdbYSW7SMqqXo=
X-Gm-Gg: ASbGnctkeBNmJtuqCo/cfRu+ckGf2Z/Voz3lGAZwVoaLwyebmQpbnj8QmjjFIJqqU7R
	C2n6A7kVp4UcksayxNKBrOYSf25YRC63MdLZvac7OTZURRzEdroekp/eSuu/yq+89WR6fQWe3ad
	QVhsXQstsptrLpWVLIn0xmf73aCmSEFM+e740n+UC/S1W/gUDf+M7XpCP1I/XPyXFvalYVJQpr4
	K6g+9+0FWWGNMfU+vpntB2jbRH8hWmli4bGOJlCYqWTv3XxpdPEGTF/sJioiw3a1HQAQ2/WsWc2
	q2q9HnxMj2850mjfaKlqX0O7smrlBNLea1AxSgD/8orhSbS8fUEhT9Az/c6yR/M6+V75ZGPTJAX
	cpOWPwlYAQyrUK+KMACBQYwrdmE/3AIKHrZvxa5HBX1HCG0D6/N9VPPVPlcplmsvOzcY=
X-Received: by 2002:a05:600c:19cf:b0:456:189e:223a with SMTP id 5b1f17b1804b1-459e70cdc76mr23327165e9.10.1754479739622;
        Wed, 06 Aug 2025 04:28:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy2UbQNnTJj8kSlOYhDTdXWzLJg+Fm8eoPyd02PfblipaRgBhM/zfUmFaLs0jdNDHqGe+LMg==
X-Received: by 2002:a05:600c:19cf:b0:456:189e:223a with SMTP id 5b1f17b1804b1-459e70cdc76mr23326685e9.10.1754479739099;
        Wed, 06 Aug 2025 04:28:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f35:8a00:42f7:2657:34cc:a51f? (p200300d82f358a0042f7265734cca51f.dip0.t-ipconnect.de. [2003:d8:2f35:8a00:42f7:2657:34cc:a51f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47b10asm22303636f8f.60.2025.08.06.04.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 04:28:58 -0700 (PDT)
Message-ID: <8a39bcff-d0cf-4c1e-a076-f676a9ace4ba@redhat.com>
Date: Wed, 6 Aug 2025 13:28:56 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] add static huge zero folio support
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Dave Hansen <dave.hansen@intel.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, x86@kernel.org,
 linux-block@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
 linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <c3b0adc9-e8e9-45ce-b839-cb09dcce3b50@intel.com>
 <sqpsvjefzukhqbumjmnhsotixw2vpdy76d3batdtlbztzk4q5w@osrjvx22pvah>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <sqpsvjefzukhqbumjmnhsotixw2vpdy76d3batdtlbztzk4q5w@osrjvx22pvah>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.25 10:31, Pankaj Raghav (Samsung) wrote:
> On Tue, Aug 05, 2025 at 09:00:40AM -0700, Dave Hansen wrote:
>> On 8/4/25 05:13, Pankaj Raghav (Samsung) wrote:
>>> Add a config option STATIC_HUGE_ZERO_FOLIO that will always allocate
>>> the huge_zero_folio, and it will never drop the reference.
>>
>> "static" is a really odd naming choice for a dynamically allocated
>> structure. It's one that's never freed, sure, but it's still dynamically
>> allocated in the first place.
> 
> That is a fair point.
> 
> I like the rename you did to PERSISTENT_HUGE_ZERO_FOLIO instead of
> STATIC_HUGE_ZERO_FOLIO as we still allocate it dynamically.
> 
> @David, @Lorenzo and @Zi: Does the rename sound good to you?

Yes, sounds good.

-- 
Cheers,

David / dhildenb


