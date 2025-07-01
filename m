Return-Path: <linux-fsdevel+bounces-53437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A12AEF115
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DACF4A01BE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F7626B2AA;
	Tue,  1 Jul 2025 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRgi+AO+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A27126A1C4
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358604; cv=none; b=ohfbOh6Ff+Rk2jKFKTCYRtjcS3+fYs/f10Cvx5+RtRjoOuAm6VIE/Lt/nj3lX/K0SxH8cW1KxG2Fek4SyxSeOe820n0776QdEmV7835CIFAV1xQfoT9CquKz1LVSkUmYJ8O6DBh7KWddKYfJbqoBpjp5CBu2x8ha6CKLUJLi2Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358604; c=relaxed/simple;
	bh=fBnxDlxBfs5ee3e1zyZlfO2WcPezlbBGR3D5/rM+XzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAN9eY7E8GnW7cC5F3JQW+49qcQiEyxxr8h6c4aT0OOkguk7H92mEjYveg7CA6/M16Winpq0FSlOlRKW2eStsNtS2Xbare8pnV9DvysG1SRD3dRRqNdGO46VAzv5dWjoaM7VUUeC4ISZlSDUHYpZNvHGVhRjvkOf4J4IGLVZfNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LRgi+AO+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751358601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Dly7kLJXAODD4HRHbtgbrL2VqDcoupb5huNWDKMA8X0=;
	b=LRgi+AO+UD+pqUiGYKRwH23G6m9rYMLZs8Wgkq/8X7JTomACY61p2AsPWJ0QBGRbgdys+X
	9KPwUkEWC8e3X3EBbshRSDWKm0sO5kbAWaIR2GAFF1BYIGvEFiaxqjoV1zEzpCUvs5oW3S
	LK2AFIeCyyAP6vvjBjsj9J2Jw4PGV7o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-kh39ONdLP9OjLhqdKgjekg-1; Tue, 01 Jul 2025 04:30:00 -0400
X-MC-Unique: kh39ONdLP9OjLhqdKgjekg-1
X-Mimecast-MFC-AGG-ID: kh39ONdLP9OjLhqdKgjekg_1751358599
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450db029f2aso23904475e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 01:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751358599; x=1751963399;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dly7kLJXAODD4HRHbtgbrL2VqDcoupb5huNWDKMA8X0=;
        b=Slz7aXyMAPbT0oOYuNr+NoJ/CRIdxTxiXhc8XT9sf2Lt8PGh3Iz4L2SdAoS86iYvQ3
         eRjCH7m995fPXzdvT4v/PgYXhZuHi4Joe9PhMOklGnAeJx3WgMZ1mSchvP81WQZT0x8j
         sVdT+h7/cuzfzxrrNNE+2a8OYcsqjksG2zVV486iY6bJlry5TXkB8ePzC+xRx3dd3/P2
         9yKCD9EqUt7P6Ow1OzJsZ/9Td+g+kzrLGW4Ri00XYuJbTHzc+cr8To5lJPEm33hTPnQI
         wO7SGP3JZeTBcB/epIGxIqCHYfMzt+FULUmZCG6/PWYFfGOJHmaxvVPtFB2oEnW1J3ZS
         uvYg==
X-Forwarded-Encrypted: i=1; AJvYcCV6zu04X7zm06SKsoDsWilfB0MLrczzddVgE4FEnzfwAjz+ltSaOmOzzxcrud1Ic/eBXP9oXEW+XhpWE8N9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf8UP76CHJSsIuX99fdCQbLxvTTlzwhbisuK6x3M5DZlO9J6sa
	0EqsXDVxFYq3q97Bh5CXRDcBD8v/grfpgijVICbO+39qC4mNCiJRfYzmgeM+JGhn9WBBTRdnANP
	yaY3I30PIm5Gn+cZP91dg8CGI5rg0cbTr47pdXUQCk5X7Vt6LcQUa0dKGkQEt8oLqpyk=
X-Gm-Gg: ASbGncshvt0aLQuIMPQw2b9BX88Lk/QCMKcB2gpqvwbl+eUurv0sWL6aMC2NTXfU4s2
	GBUCfKfO3qj647xzs0WWTQevHmaf40bPfwW7dQQavQuuL2CJtd5G/wqaErojHlcb8gXO9D747i3
	uZwl6mHbBhxjxK1fzqGSIAV4sHZRMqBrkt9QhzCOPDr78U1oNJwGB3+C7elmzUkYbv1XECWwMsB
	toeg1OZM2tAlRpI1zFw12n/Twj9t+n1mEHYhxM0tTOUX3fyVK4jilG44KPL26hHyI3VekAJw/rh
	BDwezltVh1OaaDmG82XSWG21E/879SBNrLTxSRejfFzCeM0Fmq5BmeK1GvRGHF2VFFyVApeHgD+
	05NdPuOnzgV6d9FWbhrXmN/Mf/YmcR9YkGE9jf9mi0igaGG6B5A==
X-Received: by 2002:a05:600c:458b:b0:450:b9c0:c7d2 with SMTP id 5b1f17b1804b1-45391b6b96dmr133227195e9.11.1751358599063;
        Tue, 01 Jul 2025 01:29:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWpMztTlH2ZF2ZQcI5K0kw/h7norGjoB/XuG0q+YJAXvrKR/hZBsXnJltourxu7zIahXchVg==
X-Received: by 2002:a05:600c:458b:b0:450:b9c0:c7d2 with SMTP id 5b1f17b1804b1-45391b6b96dmr133226535e9.11.1751358598437;
        Tue, 01 Jul 2025 01:29:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a5fd2sm157378465e9.15.2025.07.01.01.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 01:29:57 -0700 (PDT)
Message-ID: <872810e0-3570-47ff-8f91-3cc97a8870a1@redhat.com>
Date: Tue, 1 Jul 2025 10:29:54 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/29] mm/migrate: rename isolate_movable_page() to
 isolate_movable_ops_page()
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
 <20250630130011.330477-8-david@redhat.com>
 <a014bf06-f544-4d24-8850-052f7ead738b@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a014bf06-f544-4d24-8850-052f7ead738b@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 18:24, Lorenzo Stoakes wrote:
> On Mon, Jun 30, 2025 at 02:59:48PM +0200, David Hildenbrand wrote:
>> ... and start moving back to per-page things that will absolutely not be
>> folio things in the future. Add documentation and a comment that the
>> remaining folio stuff (lock, refcount) will have to be reworked as well.
>>
>> While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and handle
>> it gracefully (relevant with further changes), and convert a
>> WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().
>>
>> Note that we will leave anything that needs a rework (lock, refcount,
>> ->lru) to be using folios for now: that perfectly highlights the
>> problematic bits.
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Seesm reasonable to me so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
>> ---
>>   include/linux/migrate.h |  4 ++--
>>   mm/compaction.c         |  2 +-
>>   mm/migrate.c            | 39 +++++++++++++++++++++++++++++----------
>>   3 files changed, 32 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>> index aaa2114498d6d..c0ec7422837bd 100644
>> --- a/include/linux/migrate.h
>> +++ b/include/linux/migrate.h
>> @@ -69,7 +69,7 @@ int migrate_pages(struct list_head *l, new_folio_t new, free_folio_t free,
>>   		  unsigned long private, enum migrate_mode mode, int reason,
>>   		  unsigned int *ret_succeeded);
>>   struct folio *alloc_migration_target(struct folio *src, unsigned long private);
>> -bool isolate_movable_page(struct page *page, isolate_mode_t mode);
>> +bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode);
>>   bool isolate_folio_to_list(struct folio *folio, struct list_head *list);
>>
>>   int migrate_huge_page_move_mapping(struct address_space *mapping,
>> @@ -90,7 +90,7 @@ static inline int migrate_pages(struct list_head *l, new_folio_t new,
>>   static inline struct folio *alloc_migration_target(struct folio *src,
>>   		unsigned long private)
>>   	{ return NULL; }
>> -static inline bool isolate_movable_page(struct page *page, isolate_mode_t mode)
>> +static inline bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
>>   	{ return false; }
>>   static inline bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
>>   	{ return false; }
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 3925cb61dbb8f..17455c5a4be05 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1093,7 +1093,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>   					locked = NULL;
>>   				}
>>
>> -				if (isolate_movable_page(page, mode)) {
>> +				if (isolate_movable_ops_page(page, mode)) {
>>   					folio = page_folio(page);
>>   					goto isolate_success;
>>   				}
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 767f503f08758..d4b4a7eefb6bd 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -51,8 +51,26 @@
>>   #include "internal.h"
>>   #include "swap.h"
>>
>> -bool isolate_movable_page(struct page *page, isolate_mode_t mode)
>> +/**
>> + * isolate_movable_ops_page - isolate a movable_ops page for migration
>> + * @page: The page.
>> + * @mode: The isolation mode.
>> + *
>> + * Try to isolate a movable_ops page for migration. Will fail if the page is
>> + * not a movable_ops page, if the page is already isolated for migration
>> + * or if the page was just was released by its owner.
>> + *
>> + * Once isolated, the page cannot get freed until it is either putback
>> + * or migrated.
>> + *
>> + * Returns true if isolation succeeded, otherwise false.
>> + */
>> +bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
>>   {
>> +	/*
>> +	 * TODO: these pages will not be folios in the future. All
>> +	 * folio dependencies will have to be removed.
>> +	 */
>>   	struct folio *folio = folio_get_nontail_page(page);
>>   	const struct movable_operations *mops;
>>
>> @@ -73,7 +91,7 @@ bool isolate_movable_page(struct page *page, isolate_mode_t mode)
>>   	 * we use non-atomic bitops on newly allocated page flags so
>>   	 * unconditionally grabbing the lock ruins page's owner side.
>>   	 */
>> -	if (unlikely(!__folio_test_movable(folio)))
>> +	if (unlikely(!__PageMovable(page)))
>>   		goto out_putfolio;
>>
>>   	/*
>> @@ -90,18 +108,19 @@ bool isolate_movable_page(struct page *page, isolate_mode_t mode)
>>   	if (unlikely(!folio_trylock(folio)))
>>   		goto out_putfolio;
>>
>> -	if (!folio_test_movable(folio) || folio_test_isolated(folio))
>> +	if (!PageMovable(page) || PageIsolated(page))
> 
> I wonder, in the wonderful future where PageXXX() always refers to a page, can
> we use something less horrible than these macros?

Good question. It all interacts with how we believe compound pages will 
work / look like in the future.

Doing a change from PageXXX() to page_test_XXX() might be reasonable 
change in the future. But, I mean, there are more important things to 
clean up that that :)

-- 
Cheers,

David / dhildenb


