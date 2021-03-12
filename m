Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7A4338820
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 10:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhCLJBN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 04:01:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53362 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232408AbhCLJAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615539638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rr0dGN2pSc+mcCIwGu4puQfGjJsJ+IRGl94rNXhK8Hs=;
        b=WmCKwVV/NeSEOiBf/hrwC/ciSzXs/LWVDFjZlBdCY9jbT1fvKxHpDuE5KO+vqlF2JP5Teu
        qAM+yvdmnFOGZMYtdHnm+9oq6Szg6o6g9zu8rJZzS2RkQMbfblRf51NsoJEO8i3V+KseNB
        LiBp6F1o5iS+1Wsku5/NtvKikRSfqXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-1tF8crEXMYmkDXuW16Db4g-1; Fri, 12 Mar 2021 04:00:34 -0500
X-MC-Unique: 1tF8crEXMYmkDXuW16Db4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5051D760D2;
        Fri, 12 Mar 2021 09:00:32 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FC5F18A78;
        Fri, 12 Mar 2021 09:00:29 +0000 (UTC)
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, vbabka@suse.cz,
        linux-fsdevel@vger.kernel.org
References: <20210310161429.399432-1-minchan@kernel.org>
 <20210310161429.399432-2-minchan@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v3 2/3] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <5ada6223-ce21-1ae4-8580-5cd25ed491b5@redhat.com>
Date:   Fri, 12 Mar 2021 10:00:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210310161429.399432-2-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10.03.21 17:14, Minchan Kim wrote:
> LRU pagevec holds refcount of pages until the pagevec are drained.
> It could prevent migration since the refcount of the page is greater
> than the expection in migration logic. To mitigate the issue,
> callers of migrate_pages drains LRU pagevec via migrate_prep or
> lru_add_drain_all before migrate_pages call.
> 
> However, it's not enough because pages coming into pagevec after the
> draining call still could stay at the pagevec so it could keep
> preventing page migration. Since some callers of migrate_pages have
> retrial logic with LRU draining, the page would migrate at next trail
> but it is still fragile in that it doesn't close the fundamental race
> between upcoming LRU pages into pagvec and migration so the migration
> failure could cause contiguous memory allocation failure in the end.
> 
> To close the race, this patch disables lru caches(i.e, pagevec)
> during ongoing migration until migrate is done.
> 
> Since it's really hard to reproduce, I measured how many times
> migrate_pages retried with force mode(it is about a fallback to a
> sync migration) with below debug code.
> 
> int migrate_pages(struct list_head *from, new_page_t get_new_page,
> 			..
> 			..
> 
> if (rc && reason == MR_CONTIG_RANGE && pass > 2) {
>         printk(KERN_ERR, "pfn 0x%lx reason %d\n", page_to_pfn(page), rc);
>         dump_page(page, "fail to migrate");
> }
> 
> The test was repeating android apps launching with cma allocation
> in background every five seconds. Total cma allocation count was
> about 500 during the testing. With this patch, the dump_page count
> was reduced from 400 to 30.
> 
> The new interface is also useful for memory hotplug which currently
> drains lru pcp caches after each migration failure. This is rather
> suboptimal as it has to disrupt others running during the operation.
> With the new interface the operation happens only once. This is also in
> line with pcp allocator cache which are disabled for the offlining as
> well.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>   include/linux/swap.h |  3 ++
>   mm/memory_hotplug.c  |  3 +-
>   mm/mempolicy.c       |  4 ++-
>   mm/migrate.c         |  3 +-
>   mm/swap.c            | 79 ++++++++++++++++++++++++++++++++++++--------
>   5 files changed, 75 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 32f665b1ee85..a3e258335a7f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -339,6 +339,9 @@ extern void lru_note_cost(struct lruvec *lruvec, bool file,
>   extern void lru_note_cost_page(struct page *);
>   extern void lru_cache_add(struct page *);
>   extern void mark_page_accessed(struct page *);
> +extern void lru_cache_disable(void);
> +extern void lru_cache_enable(void);
> +extern bool lru_cache_disabled(void);
>   extern void lru_add_drain(void);
>   extern void lru_add_drain_cpu(int cpu);
>   extern void lru_add_drain_cpu_zone(struct zone *zone);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 5ba51a8bdaeb..959f659ef085 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1611,6 +1611,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>   	 * in a way that pages from isolated pageblock are left on pcplists.
>   	 */
>   	zone_pcp_disable(zone);
> +	lru_cache_disable();

Did you also experiment which effects zone_pcp_disable() might have on 
alloc_contig_range() ?

Feels like both calls could be abstracted somehow and used in both 
(memory offlining/alloc_contig_range) cases. It's essentially disabling 
some kind of caching.


Looks sane to me, but I am not that experienced with migration code to 
give this a real RB.

-- 
Thanks,

David / dhildenb

