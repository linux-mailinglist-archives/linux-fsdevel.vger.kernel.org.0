Return-Path: <linux-fsdevel+bounces-53630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8CFAF148E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635111BC4D51
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 11:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F75F2673BF;
	Wed,  2 Jul 2025 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCY9ggQS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F401E221F37
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751457121; cv=none; b=bUy4C2RX/mE7B4I1S27QJ+7AvpuzWzyVnSAEQTZdcR4kla7IEr8JXdThCZp4Z4kjmf3Fgcl3ImSdDclUFyTd2qvSZE/MvlaVngX5czStOYXtvcKzHnkR62ywqA89z5XZEV+8jUi1vmuCS4y/xLNleMoPLhV3nXD6eOp7Nkd76Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751457121; c=relaxed/simple;
	bh=4Va2jVGgDp6vlWAEdmdkPLeKFU1i7MbWo0WqztU3mgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuIGa17FvpM1FZqsRAAgqKw7I5ExMhDTOwNn1QW421ulVru9GZDaVr9QZt6sDZq2RbIQ3wVE4qpReTioA54bek8xwXnMtzE3ELdfTYrT8TgC4+7Lf2/8VyIQ1NnM6YvKRxIvhLdYhKn6B9bgjZ439d44gVzDCHdmTuYoGreu5i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCY9ggQS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751457118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3SHK2nux4iNGPT20ZdOmVtc3HhHpFaXJCXwhMmqqOYs=;
	b=cCY9ggQSfVB/+wcy/s/eaRPdgaOBVMAq8/4QABBIvSsfwtguy28PbHB02wOvBAT0XAz0SL
	YUKhxWLBsb1dUsQ2pXPiVh+olhtPyw789oHranpo+IGBc43QMWzMZbPONOHfbd0l/PcKLX
	dDk508c4GPU/G5JummolhErGohapLK4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-o2A_D8LxMSyhtO31cDF8oQ-1; Wed, 02 Jul 2025 07:51:58 -0400
X-MC-Unique: o2A_D8LxMSyhtO31cDF8oQ-1
X-Mimecast-MFC-AGG-ID: o2A_D8LxMSyhtO31cDF8oQ_1751457117
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso25191255e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 04:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751457117; x=1752061917;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3SHK2nux4iNGPT20ZdOmVtc3HhHpFaXJCXwhMmqqOYs=;
        b=QbnqgSU6f7P7Q0BEABLXX93Y/3McfbmeBC4L8MaXW9EjAH4Y3ECuvvF42IHUHB0guT
         LHXs+u4PUaVVxItjY4JsZaAr63NR93ZXwEOGOHh3og5bTHbbBYoHEwnhjfgQVv7uivW+
         D3zJ+ZKbIeAE3V5I+y9XZ+lJJ7o4ltYtiPt4FS0ev+9YLnJ17rMrHQnnaKn1kSYYedME
         GKuqLwVU5iy8pN5WDacpfpcRIVPQsvlr63818PXqeWj7DhWnAV8iVih/AF1x6ivAiLwJ
         U9dpbSpYDHcxg+bczhFiPcUhQbednl0qRKwckQnt0dLbj+DHioi+iRcdlf37vhhTTotu
         RXMw==
X-Forwarded-Encrypted: i=1; AJvYcCUaLlfpO5IhOlKCCJM5g/bOdFZBmbYMYc74CQLSKXkn8ZUJV2hcoMruOundT1Xp3LICuGHI+ciS/FVsHsnQ@vger.kernel.org
X-Gm-Message-State: AOJu0YywMWLYLDBgVg1hIaa1a2kVmuwCZ2Fefrejc+BlgwYAY6st3mO5
	RfsJ1wrD52wgjxwl5LSVdm0ewABAPlypQDpLNLghqFe63t9pDLsG8z1Zjcjp3fj4TQMLea0XxWf
	UzMseAq3xtTFxiqmoTiOZl2BaOZTyi8q7wY0IYg5rUF+gGLAH4Sx7uSyoEQrq/c2jDYA=
X-Gm-Gg: ASbGncv3YtRUnHy7mJMrDI5ytNix6jUbIztzQ4Iza1Lsxg/cnW2X5IN7xqUy+n0NFvo
	KVlBwebp1CG/HHQ7FZ1gdQPHnH5IBJIc5cdESWCaj99Fzdk19y8GiOaExHxXVVUZZgrYC7w9YC2
	E5G6fLlBbSwcyZkEO3N4XpOrZ7ItdNwK9zCgXUp9L8DPpCJVfriQySlYzoMVDGPr52b626LkVVw
	dpt+/bHYPAHO+j84TmYJq8+vpKVSkHaPHt7NiI59IDJUggsue/qq1qTQ55Sgo1sTDkFLJSUypOC
	kJ2Jv4ebpHOPE8j2igWgRHHpN5+oVGdYEGsk1YsDNhpigw46Crgedwk=
X-Received: by 2002:adf:e18b:0:b0:3a4:eae1:a79f with SMTP id ffacd0b85a97d-3b20095cf7amr1838672f8f.33.1751457116517;
        Wed, 02 Jul 2025 04:51:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgEWAxspDk6Q7crly73Lfvk8omExZapeXCZ1dGuKFEhCOxnWKoHtykjsVu0MJ5bKGF2TLWQg==
X-Received: by 2002:adf:e18b:0:b0:3a4:eae1:a79f with SMTP id ffacd0b85a97d-3b20095cf7amr1838610f8f.33.1751457116041;
        Wed, 02 Jul 2025 04:51:56 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234bc1fsm224606175e9.14.2025.07.02.04.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 04:51:55 -0700 (PDT)
Message-ID: <edb588a4-41c1-4108-9d86-fa69e1db5237@redhat.com>
Date: Wed, 2 Jul 2025 13:51:52 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 19/29] mm: stop storing migration_ops in page->mapping
To: Harry Yoo <harry.yoo@oracle.com>
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
 Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-20-david@redhat.com> <aGULHOwAfVItRNr6@hyeyoo>
 <819b61fb-ebb0-4ded-a104-01ab133b6a41@redhat.com> <aGUbIB34G7pLWKbX@hyeyoo>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aGUbIB34G7pLWKbX@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.25 13:43, Harry Yoo wrote:
> On Wed, Jul 02, 2025 at 01:04:05PM +0200, David Hildenbrand wrote:
>> On 02.07.25 12:34, Harry Yoo wrote:
>>> On Mon, Jun 30, 2025 at 03:00:00PM +0200, David Hildenbrand wrote:
>>>> ... instead, look them up statically based on the page type. Maybe in the
>>>> future we want a registration interface? At least for now, it can be
>>>> easily handled using the two page types that actually support page
>>>> migration.
>>>>
>>>> The remaining usage of page->mapping is to flag such pages as actually
>>>> being movable (having movable_ops), which we will change next.
>>>>
>>>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>
>>>> +static const struct movable_operations *page_movable_ops(struct page *page)
>>>> +{
>>>> +	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
>>>> +
>>>> +	/*
>>>> +	 * If we enable page migration for a page of a certain type by marking
>>>> +	 * it as movable, the page type must be sticky until the page gets freed
>>>> +	 * back to the buddy.
>>>> +	 */
>>>> +#ifdef CONFIG_BALLOON_COMPACTION
>>>> +	if (PageOffline(page))
>>>> +		/* Only balloon compaction sets PageOffline pages movable. */
>>>> +		return &balloon_mops;
>>>> +#endif /* CONFIG_BALLOON_COMPACTION */
>>>> +#if defined(CONFIG_ZSMALLOC) && defined(CONFIG_COMPACTION)
>>>> +	if (PageZsmalloc(page))
>>>> +		return &zsmalloc_mops;
>>>> +#endif /* defined(CONFIG_ZSMALLOC) && defined(CONFIG_COMPACTION) */
>>>
>>> What happens if:
>>>     CONFIG_ZSMALLOC=y
>>>     CONFIG_TRANSPARENT_HUGEPAGE=n
>>>     CONFIG_COMPACTION=n
>>>     CONFIG_MIGRATION=y
>>
>> Pages are never allocated from ZONE_MOVABLE/CMA and
> 
> I don't understand how that's true, neither zram nor zsmalloc clears
> __GFP_MOVABLE when CONFIG_COMPACTION=n?
> 
> ...Or perhaps I'm still missing some pieces ;)

You might have found a bug in zsmalloc then :) Without support for compaction, we
must clear __GFP_MOVABLE in alloc_zpdesc() I assume.

Do you have the capacity to look into that and send a fix if really broken?

In balloon compaction code we properly handle that.

>   
>> are not marked as having movable_ops, so we never end up in this function.
> 
> Right.
> 
>> See how zsmalloc.c deals with CONFIG_COMPACTION, especially how
>> SetZsPageMovable() is a NOP without it.
> 
> Right.
> 
> Now I see what I was missing in the previous reply.
> Thanks!
> 
> Please feel free to add:
> 
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Thanks!

-- 
Cheers,

David / dhildenb


