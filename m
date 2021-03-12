Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001FF3388C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 10:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhCLJeA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 04:34:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232720AbhCLJd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615541637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rj53vgUL+fBc1sW2QW6DZG1JFSB+puhdylPCj8GuUxQ=;
        b=JQAoSx6Z0S+f/I3XBFZHUqNNFofNkUBiWJn7NtJqIs9KzE4emX9zEX1AH1QeNswwKAEx04
        yewuW2cwuxeylcASxWdINLerNkB3Kk5J7K8fDVOyceYweOQlzYA04I9Z/9Gvyn1FhN8pJY
        MsWWmjUljEbmQyJLcauXuV2PZbxMIuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-LQlaec_hOfOaql8j20nvfQ-1; Fri, 12 Mar 2021 04:33:53 -0500
X-MC-Unique: LQlaec_hOfOaql8j20nvfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9087C760C1;
        Fri, 12 Mar 2021 09:33:51 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 595F9196E3;
        Fri, 12 Mar 2021 09:33:49 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, vbabka@suse.cz,
        linux-fsdevel@vger.kernel.org
References: <20210310161429.399432-1-minchan@kernel.org>
 <20210310161429.399432-3-minchan@kernel.org>
 <1bdc93e5-e5d4-f166-c467-5b94ac347857@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v3 3/3] mm: fs: Invalidate BH LRU during page migration
Message-ID: <1527f16f-4376-a10d-4e72-041926cf38da@redhat.com>
Date:   Fri, 12 Mar 2021 10:33:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1bdc93e5-e5d4-f166-c467-5b94ac347857@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12.03.21 10:03, David Hildenbrand wrote:
> On 10.03.21 17:14, Minchan Kim wrote:
>> ffer_head LRU caches will be pinned and thus cannot be migrated.
>> This can prevent CMA allocations from succeeding, which are often used
>> on platforms with co-processors (such as a DSP) that can only use
>> physically contiguous memory. It can also prevent memory
>> hot-unplugging from succeeding, which involves migrating at least
>> MIN_MEMORY_BLOCK_SIZE bytes of memory, which ranges from 8 MiB to 1
>> GiB based on the architecture in use.
> 
> Actually, it's memory_block_size_bytes(), which can be even bigger
> (IIRC, 128MiB..2 GiB on x86-64) that fails to get offlined. But that
> will prevent bigger granularity (e.g., a whole DIMM) from getting unplugged.
> 
>>
>> Correspondingly, invalidate the BH LRU caches before a migration
>> starts and stop any buffer_head from being cached in the LRU caches,
>> until migration has finished.
> 
> Sounds sane to me.
> 

Diving a bit into the code, I am wondering:


a) Are these buffer head pages marked as movable?

IOW, are they either PageLRU() or __PageMovable()?


b) How do these pages end up on ZONE_MOVABLE or MIGRATE_CMA?

I assume these pages come via
alloc_page_buffers()->alloc_buffer_head()->kmem_cache_zalloc(GFP_NOFS | 
__GFP_ACCOUNT)



-- 
Thanks,

David / dhildenb

