Return-Path: <linux-fsdevel+bounces-50386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A9EACBC4C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 22:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56AA3A45F3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 20:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05A5224AF3;
	Mon,  2 Jun 2025 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jn3Uvl6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854281BEF8C
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748896142; cv=none; b=keeZJ3W8soNlnWNSY1Sl4apm2ydsWkHyPvlB0qG9Trcb6pSpO7pG0KBRrcODHvYMBAxrLZWlNjd8iAK31Ro0wBKQ9HWcEBQJdhzKDvhFo/K7RaQQxN6EHtGBGdsLPW8le1IwDNA7jClTbmLsIFvdvmG2IzES0YhnR5qFjPphEFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748896142; c=relaxed/simple;
	bh=NaSlojcZ0ifXJIZoD0hyUTGOTRKGEAzb/GTIaXrEKDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgmAr55G9dy5Cgf9VK1ahTZO9W1dAI5oz6L+KnBhDOLIrtH3soSvm8YZashDW72FI8WEmOa5469VMqEtGDQ7Xf74XrvzDDKJD3tkq2Qt4kOus/TDM1nhGRlx5eebb/4LkT9EvWLe2KC1otLMl3aesvAduff2RCa0v+dfh2wzb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jn3Uvl6i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748896138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i+jLNp1+bBkMPcUNLnkWqh9V3VeeeCz8sfTBLH1Dubg=;
	b=Jn3Uvl6iJ1w8vvyXHol2S9Sx+n1qazLfc5psTy6GRzs/2QUwAvnqbyckLYz55nKfnRDLlH
	z/ENmbps+hmFLJ3t+kcTcnVFdqapk1QK4ZEhneST/PjxMStoXcAEm+GGgg7cd0EcTtKOFu
	jV2tZWQNAggMsNwK8tgdrl5g9PRVrF0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-FupivfOzOMipilQTfhAKmg-1; Mon, 02 Jun 2025 16:28:57 -0400
X-MC-Unique: FupivfOzOMipilQTfhAKmg-1
X-Mimecast-MFC-AGG-ID: FupivfOzOMipilQTfhAKmg_1748896136
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4e9252ba0so2972084f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Jun 2025 13:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748896136; x=1749500936;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i+jLNp1+bBkMPcUNLnkWqh9V3VeeeCz8sfTBLH1Dubg=;
        b=NcrrNdNKQwnCd+WGZp5ba6babNzZ03LQZ99el/BTLkMbd8PzIdQXTMSTWw1AflukXG
         16B3oXnCvBxcAGwV4O6vrSuTBolCX1DmWOZLBSw33F40r0L8vZHGUtAC0dxBtZ3SssaJ
         7FkvPXggP7V6DmDYWW2jIlIa6bkUFlIqrxJcpt2AAw+d7/Wu/En6YXX5bcLGcAIkZnWR
         IGx46Xdq3sK+A5dkGdMtil0oSUlWRsSZ1ey60dFLgvj2Ic8g/MSm14QTMctqpnP8ao8w
         kYgNLd4YPlUvLDhAGQd5tNvwz0v14wakpC7RlFhTE1RiVJVnIiprW0irs2sFl8HJ1Q+/
         HkBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVw2/ck5+om7R1JdXbSG/dPX8OJceMDfihM+rcs16Gtd4j8u4h3mcVxXnPCKBihwHBX9kxSsTeX4/QOm1N@vger.kernel.org
X-Gm-Message-State: AOJu0YxdYrs0j+l0J1M5IZb7dhCkZVdNIhXR93yfkCv9xQJ6J1yyMaNK
	ab7BzU3fohi0BdXt0H1VPXOx2YuIbdH2H8ChP+X2QFGWGPuwMXSnarkAKjhFhT4MXshyECwXDFD
	EhjfKoxI5syV2KId+K1sWDpYSbe4C9kLOZEXDxkqUNLYjQBIklsMVmPEAxs/MqR2m/0A=
X-Gm-Gg: ASbGnctpwmzXWMwtsuEvnZ2xilcg5ZeDhmbM4x+HLovhZqeq/oHYNBkioHhW2MX6Olu
	csxbgRGKwB+fWH09GHihMfNGcIcq4ulfHWEZdkqn2IH8TOiQA4mu1KDVglDHhSSw4LmvW/+6NK4
	QSqzFFDxAZSjZVnNdErbja0+7qULuLDgeKhfmRxCfJW8g+Z3LoxC5Hk+xrckxt6L4XIn1RC6J7b
	lH2GbXwzfTzneee7ilGulXBrPsoPd/peV0CCtOmGTphUR7YxWQSEsFVaRS9BFmY4d0YhkcL6qwZ
	sSxxuc/k3TrAFCN11yTeU7WAUA+ICbiExVhtyfXZ2Rh79SCBZWQbtztTA53gtMQi260E2VOXEhV
	Sp4CRpx+biYBhRmjBGccaFT9YpGzTEC6ZN1j4vLE=
X-Received: by 2002:a05:6000:1aca:b0:3a0:9dfc:da4 with SMTP id ffacd0b85a97d-3a4f89da7a9mr10341270f8f.42.1748896136163;
        Mon, 02 Jun 2025 13:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/a10XT6j0KvqzZRmd5BI/F1rVt+h8hUFaigZcjYLo+RekVq1Wlju6PqEsxl9YDXkz6lgFsA==
X-Received: by 2002:a05:6000:1aca:b0:3a0:9dfc:da4 with SMTP id ffacd0b85a97d-3a4f89da7a9mr10341247f8f.42.1748896135802;
        Mon, 02 Jun 2025 13:28:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f34:a300:1c2c:f35e:e8e5:488e? (p200300d82f34a3001c2cf35ee8e5488e.dip0.t-ipconnect.de. [2003:d8:2f34:a300:1c2c:f35e:e8e5:488e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00972c1sm16239336f8f.68.2025.06.02.13.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 13:28:55 -0700 (PDT)
Message-ID: <04a27029-df1e-43a7-8642-15f351121438@redhat.com>
Date: Mon, 2 Jun 2025 22:28:53 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/3] mm: add STATIC_PMD_ZERO_PAGE config option
To: Pankaj Raghav <kernel@pankajraghav.com>, Christoph Hellwig <hch@lst.de>,
 Pankaj Raghav <p.raghav@samsung.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@suse.cz>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, willy@infradead.org,
 x86@kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com
References: <20250527050452.817674-1-p.raghav@samsung.com>
 <20250527050452.817674-3-p.raghav@samsung.com>
 <20250602050307.GC21716@lst.de>
 <aa6fcbdd-5b1f-412c-a5db-f503f8a7af72@pankajraghav.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aa6fcbdd-5b1f-412c-a5db-f503f8a7af72@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.06.25 16:49, Pankaj Raghav wrote:
> On 6/2/25 07:03, Christoph Hellwig wrote:
>> Should this say FOLIO instead of PAGE in the config option to match
>> the symbol protected by it?
>>
> I am still discussing how the final implementation should be with David. But I will
> change the _PAGE to _FOLIO as that is what we would like to expose at the end.

It's a huge page, represented internally as a folio. No strong opinion, 
as ...

MMF_HUGE_ZERO_PAGE vs. mm_get_huge_zero_folio vs. get_huge_zero_page vs 
... :)

-- 
Cheers,

David / dhildenb


