Return-Path: <linux-fsdevel+bounces-52620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B397AE48A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7574917FFD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B519628DEF0;
	Mon, 23 Jun 2025 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bv5FC/Uc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2FB28850F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692540; cv=none; b=e2xvaIJ7Ydr8NSdqHizdsd7ANsE8CcoaB2Lisj5bu7R5yFWoISgsDmEI7/VZVe3MFnrJdYbaQvHv3YU/hnp7R99ZvhgkVqJaA0jMkNzf5rrseDCBZBBsMzyaGdkD4HIv50QQmdVWQMoWfJ7zE5c2uDvSp8K+dz4ItzYwenKQnl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692540; c=relaxed/simple;
	bh=0J9O5voey/ARvd7gZJ+eqO3vZig6wxwRfdaP0l0lKm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeazxxlMiJCXsFwCo/fzkzgrq8L9WVgpDIfL7H1FanxVV5uz0G37JtwVDh5zcmbwbiZd9CI7D7mIiQMUATJy5+BNnlg/SZoOy0tXcjMmxl8bH1O0RA7ARBivs604KEzghDJHfLl35W8bDuBlzXctQqsdSrQUW91ZAWcTvbcHJxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bv5FC/Uc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750692537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Pxej4Be5/c9j1n89M+jkXuuoHAyPKQExUDiEWr44btc=;
	b=bv5FC/UcAvNu50N55GtFT/EhhkPoiii19PbxJfZXaBwKeJug3DjAtEyn+nOr+1k6tw3bON
	HjNt7TtuBO3h/ggqefeQtqetLLfUWbS2kJQ1uY36fJOl0ASvC1n2sPHoZ93NPaqousrfN/
	BjLUGB5nOhXBSISX6KkM0IPeiid/wqU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-f_5Lk_KyP46K2DxqfEQ_bA-1; Mon, 23 Jun 2025 11:27:55 -0400
X-MC-Unique: f_5Lk_KyP46K2DxqfEQ_bA-1
X-Mimecast-MFC-AGG-ID: f_5Lk_KyP46K2DxqfEQ_bA_1750692474
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450d6768d4dso29437935e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 08:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750692474; x=1751297274;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pxej4Be5/c9j1n89M+jkXuuoHAyPKQExUDiEWr44btc=;
        b=q0iOEE3JBMPxvruBXPM1okCDlQW7VH04bUjs8EuhbD9qsB1Y5HZbSIENldn4HCeGBp
         eSgFRMeOLdvW9roZE/1EI5Gqd1W1EYStccQI9GJsUQRv5LvqWXLVzLFpx9JhyHih6xiv
         98+s0FDUoOWOnGTaiMrZ1pkk80phQuHNfopvjZXyuzCJu3FaSnd6bXG6J59xydicnIZZ
         vDyLf43UTj44j2fYa2Jgc+YUCwXqTRXy8p6bZIxe6gTb5hc1TGO/i79mcwtFjHqZNtCK
         tWMhARUfTijfZbdms4htA9DxuVWNa31rqMa3G6d8XTG/sFKSSAjxz1ZU4Sr1L923fQfE
         ppIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE8CkJ5uuE0PARA1Acz0+MIUIKnLnL4Ubs4cka952fzb8eLAsje85IMAHXRFc4U2QPZIff5ayckNeuI5OB@vger.kernel.org
X-Gm-Message-State: AOJu0YxpCntDnXU21kJcnK6Lxd6u3DzfFg815vZwJkAutZDkhhbtlGk8
	ib1uP4iiA8W8QLU+RW9ISIijbOzFq72JJXAUYsSpxIov/nktru2smy/AKYQV8rn6L6EL2N4wBdZ
	Ber85+V6o4WCx1UOgVspZNgAvoZUkcSQ1QzjvC+IgZNhYZQtjPjgMCdDl9FgtQiAM4EE=
X-Gm-Gg: ASbGncuhggKIbNQyPhAmJzUpgTmqMkp5fQw/Fq7Mbabt0uScuWOW37hbXm3ehHzOudx
	0WlvujW9GTjr51iWqOGtRXP/TL9yPLJl1W3jbiKKKuPOGFB2GkwkIDMBdHOt9Cq6zmx+Q+IKrNA
	Hz6DUTg/GCObALqxb7Tc8snpwZxqS+YFdCoLbOCQhEu0v8tmHnocvFM5CLDa60oUreo1W+05VYl
	F2kqHZz8j2Q9vTXxHCf9Cxw4wV2PUeGalZ4B5IyWYYinCvhdFTQ2eQILxDALBw6e+VpbIK93UKB
	iwPtTYel9XlrKNkwpyAIiRAtgQl2sBl7B9v6W9D14JuwswAgEulVvNiDtHUkApF+mF5xspmNqbV
	G+88WtQc2ped+cd9AjikXeajQitqTYAXmmccfEYujS+wXX3WTKw==
X-Received: by 2002:a05:6000:480f:b0:3a4:da87:3a73 with SMTP id ffacd0b85a97d-3a6d12dee06mr8313615f8f.42.1750692472629;
        Mon, 23 Jun 2025 08:27:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdT39TbThk3Qh/5ilj30MJfKQ2I2zikQzZNduY5teMOhv+k+uk/nLRmFEoy8dlARo9Q3L/mw==
X-Received: by 2002:a05:6000:480f:b0:3a4:da87:3a73 with SMTP id ffacd0b85a97d-3a6d12dee06mr8313543f8f.42.1750692470720;
        Mon, 23 Jun 2025 08:27:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb5ecsm117373425e9.8.2025.06.23.08.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:27:49 -0700 (PDT)
Message-ID: <becc0ae9-ad15-479d-89d3-71a19089392f@redhat.com>
Date: Mon, 23 Jun 2025 17:27:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 04/29] mm/page_alloc: allow for making page types
 sticky until freed
To: Zi Yan <ziy@nvidia.com>
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
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-5-david@redhat.com>
 <6E57AE2C-7754-4269-B16A-A39D168C5285@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6E57AE2C-7754-4269-B16A-A39D168C5285@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.06.25 20:43, Zi Yan wrote:
> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
> 
>> Let's allow for not clearing a page type before freeing a page to the
>> buddy.
>>
>> We'll focus on having a type set on the first page of a larger
>> allocation only.
>>
>> With this change, we can reliably identify typed folios even though
>> they might be in the process of getting freed, which will come in handy
>> in migration code (at least in the transition phase).
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/page_alloc.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 858bc17653af9..44e56d31cfeb1 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1380,6 +1380,9 @@ __always_inline bool free_pages_prepare(struct page *page,
>>   			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>>   		page->mapping = NULL;
>>   	}
>> +	if (unlikely(page_has_type(page)))
>> +		page->page_type = UINT_MAX;
>> +
>>   	if (is_check_pages_enabled()) {
>>   		if (free_page_is_bad(page))
>>   			bad++;
> 
> Should we be pedantic to only do this for PageOffline and PageZsmalloc
> and warn for the rest page types?

I think we should just allow any page types. Limiting it to specific 
types sounds like some use-after-free check that probably shouldn't be 
handled that way.

-- 
Cheers,

David / dhildenb


