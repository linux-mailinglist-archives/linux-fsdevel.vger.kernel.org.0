Return-Path: <linux-fsdevel+bounces-53494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A23BAEF8B9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8538116A435
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5255F273819;
	Tue,  1 Jul 2025 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOsvUrpJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2AD26F477
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373386; cv=none; b=PobrnyuEByACLc6IOiZv5gDM7qp/0iLyI2H2IvEBbRDmV2rF7HYdEFWMgEIBD4LOvsFihgja9wa2VzFy6mmsaMVHJFRfrE5qOEaWhDb2UyKA3mEVJhTvUJfLCF1cCABbKgrIdaNoRbCWxX0Ct16LvIdhUuFK0kVHR7igf1mAm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373386; c=relaxed/simple;
	bh=RSqTIjrct88sR7CZzH6GZUrUHcWswrjRQM40/qiNezA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjsXmsJ0yawGsH8GzSh++MRzK9D5HvHiPus0nRfsMx4K8Is/kV8KaMLAx8vBAtguU5Gir+RMDM3Zd4gi7J1fcWOQ/o/Xs3pmRMeppdujvJ/63R8VX8gK4zHAA2MarmQDXRXREgF+VcRJqxnisLC4BC7XAaO6qmz9CP5+zL/mou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOsvUrpJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751373384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BWUS58/xuFehV84IBP/7jugiRMD3VIiL2+WOvgSmr/U=;
	b=eOsvUrpJ0LOALtwLN0WKD0VCHfgjZuKZDMRrr3VNyIeZz9lNb9PT1kY6KBkExBHb9PlTsS
	kxfvU9XEbT87u5GwdNoCuosF7MSLTuLeDFTfhfG6qDKBOKqghg5QasveGGUHEne5Ry6Tvo
	cE5NwaBY1GJ5AMXNXYv5L5qsufDvEcU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-LF-5xnccNHeVtmQINMP87g-1; Tue, 01 Jul 2025 08:36:23 -0400
X-MC-Unique: LF-5xnccNHeVtmQINMP87g-1
X-Mimecast-MFC-AGG-ID: LF-5xnccNHeVtmQINMP87g_1751373382
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so2255736f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 05:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751373382; x=1751978182;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BWUS58/xuFehV84IBP/7jugiRMD3VIiL2+WOvgSmr/U=;
        b=vabi6JBv70aeBjDRViQnoKoFAul/MTXrvTk+k8/6V8Fjwj1dVbJjg+EmL7AOYXee1E
         Fxo+sD2GA8kp0iaGA5slk+Fwhnbf6qfhLnzsE93gByqGYsJQqudo6k+69Gan81daQ4jx
         Tq3aUJW4BIueBl2Y68bMq85ut45kxY9OWAFB3Uw0VLUvD0BZ1kDYuqTTiUpMM+LnGHUJ
         /xARtsijJ++iLWf3z1t7embhbzO173isxmRTQ8+dH7nV+ePVkc6NSVamuyqN6+Qx/zOr
         2zF3G6Izx4G6wND3nbqdTq4o+bXg3aZF0ovA13CCNuSgqIA5E/fZA9C6BdAfWH7XqQNC
         L3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCV3Vb+icsXOA7v1D+q5bH12x0nkyh0zdO7VbUSV6001Ft0+f/tapyzUZM4zg17gpyT5+ZEGDxX+BWb0Tqo3@vger.kernel.org
X-Gm-Message-State: AOJu0YyGeqbg1DdMIiG0goMVABKA1C7LEtP7KpEbeJ/dHiJNDhx8/FrB
	vyeDX9aXsgUKxKS6QZPhQ1xbAa6Od7+4uxUztktGkZMbQxdVfGtHZefVOz3eRGhwvq40yXSL27M
	sNrkageLMPlFHJ9MlwYvaflp78XOcMkf27/f0WDfcrZwCqFjqXmfizekLoc0qsnqeOsc=
X-Gm-Gg: ASbGncsJ5JHeBPuMyRUXOQ2DsEDGN30l5IuykHsib7hxn2RxhTKXJnmjm9LsX4S88/V
	FsXkS5wj3hosbMzNCyq2+gumcfYyYYv48NOlN49ZE6LFULqvmtqSI8E0IWaC6BaROWoKT3OwGqW
	stiE+Tt7q/CFIvIzVaSQLrutOMREAk7R05ff30yJiuiIU5heQtoDWTI7kac+nv0tIJmfFKJmpxI
	P7MHeOK49iHjBnlB5NrOrJEA7Yt6wFwIpSQs/UTwqpwhRo73NKNt199Yii8MLE4JMLPqN05klbH
	afOsBOYxbFrE3Qa6a+bFJKuvTq4QrcXB6vBw26I5J1gdjN5xhuEzDzIH7VcGvXaxNtOpnpcUGyU
	7HtrFDqyVKiFMZ+UC9IHKiHhIqH27+buFFHMWg765TzK0X30UJA==
X-Received: by 2002:adf:a21a:0:b0:3a5:88cf:479e with SMTP id ffacd0b85a97d-3a8fe79c8e3mr10444954f8f.48.1751373381329;
        Tue, 01 Jul 2025 05:36:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqIR1BDJyK8ZRp8F0lL2pM8FI7W8fcFCGvncPeyeTD2kfxRgbkByPh+KE/B8iSSRVeA4M/aQ==
X-Received: by 2002:adf:a21a:0:b0:3a5:88cf:479e with SMTP id ffacd0b85a97d-3a8fe79c8e3mr10444867f8f.48.1751373380689;
        Tue, 01 Jul 2025 05:36:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a87e947431sm13174236f8f.0.2025.07.01.05.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:36:20 -0700 (PDT)
Message-ID: <9af55241-8348-46a1-8f72-5ad7e61bcd84@redhat.com>
Date: Tue, 1 Jul 2025 14:36:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 18/29] mm: remove __folio_test_movable()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin
 <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-19-david@redhat.com>
 <6e067746-9d18-4d04-a60a-536d5fee6b87@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6e067746-9d18-4d04-a60a-536d5fee6b87@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> ---
>>   include/linux/page-flags.h |  6 ------
>>   mm/migrate.c               | 43 ++++++++++++--------------------------
>>   mm/vmscan.c                |  6 ++++--
>>   3 files changed, 17 insertions(+), 38 deletions(-)
>>
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index c67163b73c5ec..4c27ebb689e3c 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -744,12 +744,6 @@ static __always_inline bool PageAnon(const struct page *page)
>>   	return folio_test_anon(page_folio(page));
>>   }
>>
>> -static __always_inline bool __folio_test_movable(const struct folio *folio)
>> -{
>> -	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) ==
>> -			PAGE_MAPPING_MOVABLE;
>> -}
>> -
> 
> Woah, wait, does this mean we can remove PAGE_MAPPING_MOVABLE??

Jup :)

> 
> Nice!
> 
>>   static __always_inline bool page_has_movable_ops(const struct page *page)
>>   {
>>   	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 587af35b7390d..15d3c1031530c 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -219,12 +219,7 @@ void putback_movable_pages(struct list_head *l)
>>   			continue;
>>   		}
>>   		list_del(&folio->lru);
>> -		/*
>> -		 * We isolated non-lru movable folio so here we can use
>> -		 * __folio_test_movable because LRU folio's mapping cannot
>> -		 * have PAGE_MAPPING_MOVABLE.
>> -		 */
> 
> So hate these references to 'LRU' as in meaning 'pages that could be on the
> LRU'.

Yeah, it's a historical thing.

But for anything we isolated, it had to be an LRU folio (PageLRU) 
because that's how we were even able to isolate it ... from the LRU.

[...]

>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 098bcc821fc74..103dfc729a823 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1658,9 +1658,11 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>>   	unsigned int noreclaim_flag;
>>
>>   	list_for_each_entry_safe(folio, next, folio_list, lru) {
>> +		/* TODO: these pages should not even appear in this list. */
>> +		if (page_has_movable_ops(&folio->page))
> 
> VM_WARN_ON_ONCE()?

Well, no, it can currently still happen. But really, movable_ops pages 
are not folios that could ever be reclaimed that way.

So the TODO highlights that movable_ops pages should never even be put 
in a list (page->lru will go away).

-- 
Cheers,

David / dhildenb


