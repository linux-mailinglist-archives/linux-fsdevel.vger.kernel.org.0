Return-Path: <linux-fsdevel+bounces-53427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18541AEF045
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 09:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F03C17FEEB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 07:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494B3264A65;
	Tue,  1 Jul 2025 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tvp18pRn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C679625FA06
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356698; cv=none; b=UzzCHOdnlY9NxpK83Vgmq7gd2VndOMQE4dDUYy2GLEEqKlYVteuJz6EwXYGM6WGgeq9Suy2VuuqOOxkZ3fFL/qfZMQyl8vzqy5aC+ruhIznpqqOGsCO0qALUJTBbrupOjTzGMmJ44AhSeewqDxdurQWCqrlssunzVHbZXjDuno0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356698; c=relaxed/simple;
	bh=EkxLnWK+KNQPvO+XPa/qISs0wqev8VlQsQoVXc69XRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxoDvvyEVHvgJMUI0qe9Fj33/K9KM68hPH5bmT0ZjDbrHOADg4dm8SPkx3AuG/i78lTaljL8GoYCtxm0BpSRdU0qwMpnL7wjzuyrJjGU/m0ZeK9MMwLTrOiUXaAYnj2MJitsuLOJ6qpklqeIqXahptqMeXJS6goeri+B3/2oM2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tvp18pRn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751356695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/Feq4JYZa9imSCNgZMBn1vPhrRu0fqByvVFyCsbFbfo=;
	b=Tvp18pRnrfrSiRzNfZY2JgzOhWD4f4I9MS20zJ0FzVOOPWoXG1aDk7mkWfgg2qiDJ5KZkv
	yaSHQQCvo5Nx7z7z9t8Cc28R++wH974c7XRTXd8/g3NyOwp8GrkSScA2nTKD7h/YhIGnER
	12kccKaHYw1oFGhJYghMXwfltuRymAw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-lHgKx3pcMSqoG3Cu1yqHCg-1; Tue, 01 Jul 2025 03:58:14 -0400
X-MC-Unique: lHgKx3pcMSqoG3Cu1yqHCg-1
X-Mimecast-MFC-AGG-ID: lHgKx3pcMSqoG3Cu1yqHCg_1751356693
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so2235820f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 00:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751356693; x=1751961493;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Feq4JYZa9imSCNgZMBn1vPhrRu0fqByvVFyCsbFbfo=;
        b=LR7yJnbvz4MqzaWnejhDq7g7vmuxYC8YQyx1ioz4Ig6GcR7IVScKUfo4m5WsfPVao5
         cgp8bjFYfr3cb3+o66uk+8XtJYtGQa4KGZGkD2bc45O5Ly7BwqNBSLLiOBd1mhucq4Fj
         ZwMetQbOJBbh1FZYMdohUJ7TW14PA6F0cVSmp8vYFn0618/VbKnLZp+mHhB7dTtnmYUb
         hVCbrzPE/77iZzk0RNwNjFaImQq2zsCTBXOGYybLSrRbHTo79/1RftUQj2uWuaBx3/mi
         qQl4CVr/kAsMDrTurBdpASD1LAn1j4Z3XAhQhjQswwRIP1evxijQuc82pzQPEd4UuRAE
         WxJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqt4axevV0Q4FJ7WFJwpNh+F1momEcy8R1iLFdjzjeH3+5IyPlTzZ++leyMQY7rfPYZ+KFLeRSoxKKd2Gz@vger.kernel.org
X-Gm-Message-State: AOJu0YzmYgddCcWevhJfLdEYzL7dRfvwOd/hYa0uiDgP6wBtKAOW0mBr
	JjAzH+V2SU/41VHNfqd0bjgSGjtWZSVemX/MMYDrbX8JK4G+M8q8DaNYE3+AflKb5blsLeU3EIg
	fkEUXoj6kESMBUgFyxkSfw8M/XSHtAgaya9U1TXkIBb289ZhA6+XET/hddDD7GZK1rRk=
X-Gm-Gg: ASbGncv6DEYwamkLeuMVasbJFr00ZQqEAs7/21A15GabcmLUG10gpO36pjUsx7dnE0x
	6AzW7FLMrzD81hZ0l2YK8GTXu+zRT2KEYDivoUA53WE9ML7JcSFh9AKFsMK87q5XvHL+Bp11vdz
	lgeC9LwZBsa99qyGbz8ZK0++8MHJioNqaWqX1Zzn1c8ArP538YXZ9oplmwqbSM9i3aIkMpfbZS4
	99XQkvtutDB8jKXcuNIggOEOvtDT4YU2KKhYNPKyH7r0e9dCdqXXx23VR0iaxIFLjomN32G0Ih9
	q5ePHn3nRBn6RrlOUcXXqbQ7602CGyH2Upd+9RuPrXMSbdFUayxlJ55ei2bI597p8/wvZkaESqI
	nohPmI/DpvRuntOYNF4Atn5qztA60/FNz0w7FW7630FMsDAfUEA==
X-Received: by 2002:a05:6000:64b:b0:3a6:d5fd:4687 with SMTP id ffacd0b85a97d-3a8f482bd31mr13154697f8f.18.1751356693281;
        Tue, 01 Jul 2025 00:58:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjMbemhkIZeoSup+OwONMSvz50yZg2K0dN6tNDQHYUqndeAp7nP+ltTQxgNLFcEg/amFhAAA==
X-Received: by 2002:a05:6000:64b:b0:3a6:d5fd:4687 with SMTP id ffacd0b85a97d-3a8f482bd31mr13154650f8f.18.1751356692689;
        Tue, 01 Jul 2025 00:58:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e72c1sm12366971f8f.1.2025.07.01.00.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 00:58:11 -0700 (PDT)
Message-ID: <277e094d-b159-411f-940d-13b62493f6c5@redhat.com>
Date: Tue, 1 Jul 2025 09:58:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/29] mm/balloon_compaction: convert
 balloon_page_delete() to balloon_page_finalize()
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
 <20250630130011.330477-3-david@redhat.com>
 <f9cb1865-aa9d-409f-bce5-7051480c1a71@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f9cb1865-aa9d-409f-bce5-7051480c1a71@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 17:15, Lorenzo Stoakes wrote:
> On Mon, Jun 30, 2025 at 02:59:43PM +0200, David Hildenbrand wrote:
>> Let's move the removal of the page from the balloon list into the single
>> caller, to remove the dependency on the PG_isolated flag and clarify
>> locking requirements.
>>
>> We'll shuffle the operations a bit such that they logically make more sense
>> (e.g., remove from the list before clearing flags).
>>
>> In balloon migration functions we can now move the balloon_page_finalize()
>> out of the balloon lock and perform the finalization just before dropping
>> the balloon reference.
>>
>> Document that the page lock is currently required when modifying the
>> movability aspects of a page; hopefully we can soon decouple this from the
>> page lock.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   arch/powerpc/platforms/pseries/cmm.c |  2 +-
>>   drivers/misc/vmw_balloon.c           |  3 +-
>>   drivers/virtio/virtio_balloon.c      |  4 +--
>>   include/linux/balloon_compaction.h   | 43 +++++++++++-----------------
>>   mm/balloon_compaction.c              |  3 +-
>>   5 files changed, 21 insertions(+), 34 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
>> index 5f4037c1d7fe8..5e0a718d1be7b 100644
>> --- a/arch/powerpc/platforms/pseries/cmm.c
>> +++ b/arch/powerpc/platforms/pseries/cmm.c
>> @@ -532,7 +532,6 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
>>
>>   	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
>>   	balloon_page_insert(b_dev_info, newpage);
>> -	balloon_page_delete(page);
> 

Hi Lorenzo,

as always, thanks for the detailed review!

> We seem to just be removing this and not replacing with finalize, is this right?

See below.

> 
>>   	b_dev_info->isolated_pages--;
>>   	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
>>
>> @@ -542,6 +541,7 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
>>   	 */
>>   	plpar_page_set_active(page);
>>
>> +	balloon_page_finalize(page);

^ here it is, next to the put_page() just like for the other cases.

Or did you mean something else?

>>   	/* balloon page list reference */
>>   	put_page(page);
>>
>> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
>> index c817d8c216413..6653fc53c951c 100644
>> --- a/drivers/misc/vmw_balloon.c
>> +++ b/drivers/misc/vmw_balloon.c
>> @@ -1778,8 +1778,7 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
>>   	 * @pages_lock . We keep holding @comm_lock since we will need it in a
>>   	 * second.
>>   	 */
>> -	balloon_page_delete(page);
>> -
>> +	balloon_page_finalize(page);
>>   	put_page(page);
>>


[...]

>> -/*
>> - * balloon_page_delete - delete a page from balloon's page list and clear
>> - *			 the page->private assignement accordingly.
>> - * @page    : page to be released from balloon's page list
>> - *
>> - * Caller must ensure the page is locked and the spin_lock protecting balloon
>> - * pages list is held before deleting a page from the balloon device.
>> - */
>> -static inline void balloon_page_delete(struct page *page)
>> -{
>> -	__ClearPageOffline(page);
>> -	__ClearPageMovable(page);
>> -	set_page_private(page, 0);
>> -	/*
>> -	 * No touch page.lru field once @page has been isolated
>> -	 * because VM is using the field.
>> -	 */
>> -	if (!PageIsolated(page))
>> -		list_del(&page->lru);
> 
> I don't see this check elsewhere, is it because, as per the 1/xx of this series,
> because by the time we do the finalize

balloon_page_delete() was used on two paths

1) Removing a page from the balloon for deflation through 
balloon_page_list_dequeue()

2) Removing an isolated page from the balloon for migration in the 
per-driver migration handlers. Isolated pages were already removed from 
the balloon list during ... isolation.

With this change, 1) does the list_del(&page->lru) manually and 2) only 
calls balloon_page_finalize().

During 1) the same reasoning as in 1/xx applies: isolated pages cannot 
be in the balloon list.

> 
>> -}
>> -
>>   /*
>>    * balloon_page_device - get the b_dev_info descriptor for the balloon device
>>    *			 that enqueues the given page.
>> @@ -141,12 +120,6 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
>>   	list_add(&page->lru, &balloon->pages);
>>   }
>>
>> -static inline void balloon_page_delete(struct page *page)
>> -{
>> -	__ClearPageOffline(page);
>> -	list_del(&page->lru);
>> -}
>> -
>>   static inline gfp_t balloon_mapping_gfp_mask(void)
>>   {
>>   	return GFP_HIGHUSER;
>> @@ -154,6 +127,22 @@ static inline gfp_t balloon_mapping_gfp_mask(void)
>>
>>   #endif /* CONFIG_BALLOON_COMPACTION */
>>
>> +/*
>> + * balloon_page_finalize - prepare a balloon page that was removed from the
>> + *			   balloon list for release to the page allocator
>> + * @page: page to be released to the page allocator
>> + *
>> + * Caller must ensure that the page is locked.
> 
> Can we assert this?

We could, but I'm planning on removing the page lock next (see patch 
description), so not too keen to create more code around that.

Maybe mention that the balloon lock should not be held?

Not a limitation. It could be called with it, just not a requirement today.

I suspect that once we remove the page lock, that we might use the 
balloon lock and rework balloon_page_migrate() to take the lock. TBD.

 > >> + */
>> +static inline void balloon_page_finalize(struct page *page)
>> +{
>> +	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
>> +		__ClearPageMovable(page);
>> +		set_page_private(page, 0);
>> +	}
> 
> Why do we check this? Is this function called from anywhere where that config won't be set?

Sure. balloon_page_list_dequeue() is called from balloon_page_dequeue(), 
which resides outside the CONFIG_BALLOON_COMPACTION ifdef in 
mm/balloon_compaction.c.

At some point (not in this series) we should probably rename

balloon_compaction.c -> balloon.c

To match CONFIG_MEMORY_BALLOON.

Because the compaction part is just one extra bit in there. (an 
important one, but still, you can use the balloon infrastructure without 
compaction/page migration)

-- 
Cheers,

David / dhildenb


