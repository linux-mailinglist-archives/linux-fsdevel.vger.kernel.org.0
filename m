Return-Path: <linux-fsdevel+bounces-53462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9153AEF475
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535E248207E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713BB2741B3;
	Tue,  1 Jul 2025 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnuwPodT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C8F26FDB6
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364168; cv=none; b=aGSIVsNlmGQFUYoiwlIpv8uTiAZgUHvOTTpYPaeoMIbCFL5sOsGf/9QP5C61qdbE1Y1rj+J5XPOUfWGYwDDKGyjyNCFaVL9iz58ge/vT2jWMHanDbxtlkVeW1NecY63e4wfB+u6B69fdyUWzrdBKypadryTG6DSA6wlSHUe5tF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364168; c=relaxed/simple;
	bh=DR9hb5KeCO0FkdqEG08+Y242Qqjr2Sy8Cd+ROJQeEQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INbYKKPzldathf3YiWSrkLa787ZGqQcl/JP3GNRKWi6xepaRBG9HMo3qXJPADw4wv61hc4VgXWb/mgbXo/DW5Csc1DFlziqRiwByuG72P9Gs8Lg+y2PFbsdbugVgqVcxPT7kUMLdVVwjAi6WhNiSw2houA503sDc54S62N0CKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NnuwPodT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751364166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f3SHUBXDE7b2cL32PsfHmk/IPfjLCqgNx6V4kjxRwyc=;
	b=NnuwPodTCcOfB5pgl2nvhpA1zoObDVFh/i0paQxv4Oxvm4Sb4jY0j3qw0/uBYIrbOrOFcR
	La8X4ddYQCJsg3uNuhOPzbY7EuheuuycO2izp7BNPeSkpVwwYcMekxFLjVnQbEq6FiVzF2
	bubhQFiWLD6auamc9zhQdbl7123A+zg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-3s6lIZGnMvud9XoAw2jzIw-1; Tue, 01 Jul 2025 06:02:45 -0400
X-MC-Unique: 3s6lIZGnMvud9XoAw2jzIw-1
X-Mimecast-MFC-AGG-ID: 3s6lIZGnMvud9XoAw2jzIw_1751364164
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45311704d22so21923575e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 03:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751364164; x=1751968964;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f3SHUBXDE7b2cL32PsfHmk/IPfjLCqgNx6V4kjxRwyc=;
        b=fNkPo9sYIT2vFcQ+u845sqe6Iqc7xEzzjlpMTvYERST/Uhk2Xu4MirudJ9BY/rT/px
         ByiKpTZOkwmMoBTeig85reQqM4lLdiMd66bEw8gmRO+iiKUGKZouSHlMQVT2EGhauZTu
         r4alqoTOaUGoh2fk856dWOOUqhEiD91RUNhok2sJGPa7XT0s3uJlsU99z5iPgcz8e/Ea
         uDA+xY6TW06ti7t+mxSNwVB54ZXi/fKX4T4FiGKOkZJsBREwXa3xf0hHoj/vZH6OyFYS
         gNtAVdAETtPDFyVhTBVvBCFaLQzc7xYA1fFdIR/Dn7XGvjWmbjYuhVCrMcqNx3RynA60
         xqRg==
X-Forwarded-Encrypted: i=1; AJvYcCX2pjuDt3RSmr3B7x3+XLv7rSZm4d9luOdV6pAhaeAHgWR2TqaGJYbuEoTbh1Q2TCx9SRujC4A2IPXytwYS@vger.kernel.org
X-Gm-Message-State: AOJu0YyLho3yI/8o8s76tMO3jT38+uKbi9X+Dw+vx+n32RwFh2a1IIXH
	GcpCcKIdPgHoKBvDdPJvV7DVDFvQU+rvkDnSw6kgBG2VZJWQ99auU7r+GbMnzR/Grevd5+Cz/V3
	4kBvoSEymqJNzNceN2DbWPHxVWps0PnE82vSVpGMbl7xnBKlHub1nOuwZzFhS5jo5UoA=
X-Gm-Gg: ASbGnct3kHX04A91u7sD5H8LRyjZPHSwMoP7Vrn0tAFF4pv/DsgqTvmZVtAVsEza7Bv
	ckbQqKV/8mmpx9/k7MlPBkLe157Q5ko9pK/liUod0lgEX0eCr88shV/SOnB9q/QgAok2Lcqj5fR
	E5nfhD/eGl4bYsWzl33drT2sr1XfzbV+VKHHkW4uDVpK724WrZFteYUpLNRRsDt+bDMnBweBsMR
	4IQNN/MVsZuFmHmowCrLWLpojp/NTvejNJxwVY52mZUrESECps5gF2TtpY7GhvkrXw5+nmVHHtO
	3Em4P3j7TpD1IWsWZ3GWs5zCEgFnJU6sBOsv2yZXpUXYXZXgCd1HFyAy4dQi7ByLJFIDMRaSK3s
	HL3xjXGIZCWAjf7XKo0VasKtJ0CcZLy9erGppD2RJVe3dABjjoQ==
X-Received: by 2002:a05:600c:c09b:b0:450:d3b9:4ba4 with SMTP id 5b1f17b1804b1-4538ee3344amr145818545e9.2.1751364163144;
        Tue, 01 Jul 2025 03:02:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFgAwnBW5J05+aCYFKVRcwfsiMjpcnNtgBSBoK6tfZW90o8f6wyDtCBqB3s9LfsUKyHTpToQ==
X-Received: by 2002:a05:600c:c09b:b0:450:d3b9:4ba4 with SMTP id 5b1f17b1804b1-4538ee3344amr145817895e9.2.1751364162437;
        Tue, 01 Jul 2025 03:02:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45388888533sm172377615e9.21.2025.07.01.03.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 03:02:41 -0700 (PDT)
Message-ID: <38c64eec-0350-4e94-a115-76a569f4b934@redhat.com>
Date: Tue, 1 Jul 2025 12:02:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/29] mm/page_alloc: let page freeing clear any set
 page type
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
 <20250630130011.330477-5-david@redhat.com>
 <8c5392d6-372c-4d5d-8446-6af48fba4548@lucifer.local>
 <d4d8b891-008d-4cbc-950f-2e44c4445904@redhat.com>
 <06e260cf-9b63-4d7c-809c-a9f2cda58939@lucifer.local>
 <84e1eeeb-c78f-4735-a6d2-4bb15ea1fbce@redhat.com>
 <b0069788-2940-4634-ada1-224b927154dd@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b0069788-2940-4634-ada1-224b927154dd@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.25 10:37, Lorenzo Stoakes wrote:
> On Tue, Jul 01, 2025 at 10:34:33AM +0200, David Hildenbrand wrote:
>>>>>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>>>>>> Acked-by: Harry Yoo <harry.yoo@oracle.com>
>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Based on discussion below, I'm good with this now with the comment change, so
> feel free to add:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
>>>>>> ---
>>>>>>     mm/page_alloc.c | 3 +++
>>>>>>     1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>> index 858bc17653af9..44e56d31cfeb1 100644
>>>>>> --- a/mm/page_alloc.c
>>>>>> +++ b/mm/page_alloc.c
>>>>>> @@ -1380,6 +1380,9 @@ __always_inline bool free_pages_prepare(struct page *page,
>>>>>>     			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>>>>>>     		page->mapping = NULL;
>>>>>>     	}
>>>>>> +	if (unlikely(page_has_type(page)))
>>>>>> +		page->page_type = UINT_MAX;
>>>>>
>>>>> Feels like this could do with a comment!
>>>>
>>>> /* Reset the page_type -> _mapcount to -1 */
>>>
>>> Hm this feels like saying 'the reason we set it to -1 is to set it to -1' :P
>>
>> Bingo! Guess why I didn't add a comment in the first place :P
>>
>>>
>>> I'd be fine with something simple like
>>>
>>> /* Set page_type to reset value */
>>
>> "Reset the page_type (which overlays _mapcount)"
>>
>> ?
> 
> Sounds good thanks, have an R-b above on the basis of this change.
> 
>>
>>>> But... Can't we just put a #define somewhere here to make life easy?
>> Like:
>>
>> Given that Willy will change all that soon, I'm not in favor of doing that
>> in this series.
> 
> Ah is he? I mean of course he is :))) this does seem like a prime target for the
> ongoing memdesc/foliofication efforts.

Right. According to the plans I know, the type will be stored as part of 
the memdesc pointer.

Clearing the type (where to clear, what to clear, when to clear) is 
probably the interesting bit in the future: probably it will be cleared 
as part of freeing any memdesc (thereby, invalidating the pointer).

-- 
Cheers,

David / dhildenb


