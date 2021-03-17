Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7413133EF5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 12:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhCQLSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 07:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230048AbhCQLSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615979897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ICFrnCYA6WU/nyO91rMalKC6CyiSa92VZImMiLqiv4=;
        b=V4qDeizPYEuTC68DzhrzTUz6U7Y7MkE4ldnPqa1uaxeBG3yshW92wtE8jEV1HWcxwZn75N
        ywXAeSAraQztUQ4NA0TKwfk+1F54887ZXbj/j699Zb6KhOLPPieGT14EsYqM7Q+eT1lN57
        vt5rpVI35AvWiHt3TbG7JaeRMQ7crGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-amxZMycaOZKvHSdvPBTREg-1; Wed, 17 Mar 2021 07:18:13 -0400
X-MC-Unique: amxZMycaOZKvHSdvPBTREg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87B43101371C;
        Wed, 17 Mar 2021 11:18:11 +0000 (UTC)
Received: from [10.36.112.124] (ovpn-112-124.ams2.redhat.com [10.36.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FC03629DA;
        Wed, 17 Mar 2021 11:18:08 +0000 (UTC)
Subject: Re: [PATCH v3 3/3] mm: fs: Invalidate BH LRU during page migration
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, vbabka@suse.cz,
        linux-fsdevel@vger.kernel.org
References: <20210310161429.399432-1-minchan@kernel.org>
 <20210310161429.399432-3-minchan@kernel.org>
 <1bdc93e5-e5d4-f166-c467-5b94ac347857@redhat.com>
 <1527f16f-4376-a10d-4e72-041926cf38da@redhat.com>
 <YEuiI44IRjBOQ8Wy@google.com> <YFD4cz6+0U2jgTzH@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <239b45ff-dad0-6cd0-4f6e-18159185cd6d@redhat.com>
Date:   Wed, 17 Mar 2021 12:18:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFD4cz6+0U2jgTzH@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16.03.21 19:26, Minchan Kim wrote:
> On Fri, Mar 12, 2021 at 09:17:23AM -0800, Minchan Kim wrote:
>> On Fri, Mar 12, 2021 at 10:33:48AM +0100, David Hildenbrand wrote:
>>> On 12.03.21 10:03, David Hildenbrand wrote:
>>>> On 10.03.21 17:14, Minchan Kim wrote:
>>>>> ffer_head LRU caches will be pinned and thus cannot be migrated.
>>>>> This can prevent CMA allocations from succeeding, which are often used
>>>>> on platforms with co-processors (such as a DSP) that can only use
>>>>> physically contiguous memory. It can also prevent memory
>>>>> hot-unplugging from succeeding, which involves migrating at least
>>>>> MIN_MEMORY_BLOCK_SIZE bytes of memory, which ranges from 8 MiB to 1
>>>>> GiB based on the architecture in use.
>>>>
>>>> Actually, it's memory_block_size_bytes(), which can be even bigger
>>>> (IIRC, 128MiB..2 GiB on x86-64) that fails to get offlined. But that
>>>> will prevent bigger granularity (e.g., a whole DIMM) from getting unplugged.
>>>>
>>>>>
>>>>> Correspondingly, invalidate the BH LRU caches before a migration
>>>>> starts and stop any buffer_head from being cached in the LRU caches,
>>>>> until migration has finished.
>>>>
>>>> Sounds sane to me.
>>>>
>>>
>>> Diving a bit into the code, I am wondering:
>>>
>>>
>>> a) Are these buffer head pages marked as movable?
>>>
>>> IOW, are they either PageLRU() or __PageMovable()?
>>>
>>>
>>> b) How do these pages end up on ZONE_MOVABLE or MIGRATE_CMA?
>>>
>>> I assume these pages come via
>>> alloc_page_buffers()->alloc_buffer_head()->kmem_cache_zalloc(GFP_NOFS |
>>> __GFP_ACCOUNT)
>>>
>>
>> It's indirect it was not clear
>>
>> try_to_release_page
>>      try_to_free_buffers
>>          buffer_busy
>>              failed
>>
>> Yeah, comment is misleading. This one would be better.
>>
>>          /*
>>           * the refcount of buffer_head in bh_lru prevents dropping the
>>           * attached page(i.e., try_to_free_buffers) so it could cause
>>           * failing page migrationn.
>>           * Skip putting upcoming bh into bh_lru until migration is done.
>>           */
> 

Thanks, that makes more sense to me now :)

> Hi Andrew,
> 
> Could you fold this comment fix patch? If you prefer formal patch,
> let me know. I will resend it.
> 
> Thank you.
> 
>  From 0774f21e2dc8220fc2be80c25f711cb061363519 Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Fri, 12 Mar 2021 09:17:34 -0800
> Subject: [PATCH] comment fix
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>   fs/buffer.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index ca9dd736bcb8..8602dcbe0327 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1265,8 +1265,9 @@ static void bh_lru_install(struct buffer_head *bh)
>   
>   	check_irqs_on();
>   	/*
> -	 * buffer_head in bh_lru could increase refcount of the page
> -	 * until it will be invalidated. It causes page migraion failure.
> +	 * the refcount of buffer_head in bh_lru prevents dropping the
> +	 * attached page(i.e., try_to_free_buffers) so it could cause
> +	 * failing page migratoin.

s/migratoin/migration/

>   	 * Skip putting upcoming bh into bh_lru until migration is done.
>   	 */
>   	if (lru_cache_disabled())
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

