Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF653387F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 09:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhCLIyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 03:54:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232474AbhCLIxz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615539234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=on1Sxh6r3JqCY0LKPqjzYnWAizl5J1ZeYGQoA8ZcjwA=;
        b=eQvUJdYOVtwNJgeDSHCP6jSoRWP5bZIF9zjcXUAjpb7+/Zk1dQtZIRg60PWWiaymbCQMEe
        YJi8amz5bs3q120yWQEL+zFVZWvK/Hh8eczU47DxmfcZPxIgnLyeiCzh/xdvojlFxwi5q5
        tfgfwiPHVrUige6QtQ9aVFYTe2s0xQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-hFDHyMEnOBmbbT7osTOAvw-1; Fri, 12 Mar 2021 03:53:50 -0500
X-MC-Unique: hFDHyMEnOBmbbT7osTOAvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38D2F8189CB;
        Fri, 12 Mar 2021 08:53:49 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 833805D6D7;
        Fri, 12 Mar 2021 08:53:46 +0000 (UTC)
Subject: Re: [PATCH v3 1/3] mm: replace migrate_prep with lru_add_drain_all
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, vbabka@suse.cz,
        linux-fsdevel@vger.kernel.org
References: <20210310161429.399432-1-minchan@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <bf9c13bf-4715-e598-3fa6-0b60f6615b90@redhat.com>
Date:   Fri, 12 Mar 2021 09:53:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210310161429.399432-1-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10.03.21 17:14, Minchan Kim wrote:
> Currently, migrate_prep is merely a wrapper of lru_cache_add_all.
> There is not much to gain from having additional abstraction.
> 
> Use lru_add_drain_all instead of migrate_prep, which would be more
> descriptive.
> 
> note: migrate_prep_local in compaction.c changed into lru_add_drain
> to avoid CPU schedule cost with involving many other CPUs to keep
> keep old behavior.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>   include/linux/migrate.h |  5 -----
>   mm/compaction.c         |  3 ++-
>   mm/mempolicy.c          |  4 ++--
>   mm/migrate.c            | 24 +-----------------------
>   mm/page_alloc.c         |  2 +-
>   mm/swap.c               |  5 +++++
>   6 files changed, 11 insertions(+), 32 deletions(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 3a389633b68f..6155d97ec76c 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -45,8 +45,6 @@ extern struct page *alloc_migration_target(struct page *page, unsigned long priv
>   extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
>   extern void putback_movable_page(struct page *page);
>   
> -extern void migrate_prep(void);
> -extern void migrate_prep_local(void);
>   extern void migrate_page_states(struct page *newpage, struct page *page);
>   extern void migrate_page_copy(struct page *newpage, struct page *page);
>   extern int migrate_huge_page_move_mapping(struct address_space *mapping,
> @@ -66,9 +64,6 @@ static inline struct page *alloc_migration_target(struct page *page,
>   static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
>   	{ return -EBUSY; }
>   
> -static inline int migrate_prep(void) { return -ENOSYS; }
> -static inline int migrate_prep_local(void) { return -ENOSYS; }
> -
>   static inline void migrate_page_states(struct page *newpage, struct page *page)
>   {
>   }
> diff --git a/mm/compaction.c b/mm/compaction.c
> index e04f4476e68e..3be017ececc0 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2319,7 +2319,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>   	trace_mm_compaction_begin(start_pfn, cc->migrate_pfn,
>   				cc->free_pfn, end_pfn, sync);
>   
> -	migrate_prep_local();
> +	/* lru_add_drain_all could be expensive with involving other CPUs */
> +	lru_add_drain();
>   
>   	while ((ret = compact_finished(cc)) == COMPACT_CONTINUE) {
>   		int err;
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index ab51132547b8..fc024e97be37 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1124,7 +1124,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
>   	int err = 0;
>   	nodemask_t tmp;
>   
> -	migrate_prep();
> +	lru_add_drain_all();
>   
>   	mmap_read_lock(mm);
>   
> @@ -1323,7 +1323,7 @@ static long do_mbind(unsigned long start, unsigned long len,
>   
>   	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
>   
> -		migrate_prep();
> +		lru_add_drain_all();
>   	}
>   	{
>   		NODEMASK_SCRATCH(scratch);
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 62b81d5257aa..45f925e10f5a 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -57,28 +57,6 @@
>   
>   #include "internal.h"
>   
> -/*
> - * migrate_prep() needs to be called before we start compiling a list of pages
> - * to be migrated using isolate_lru_page(). If scheduling work on other CPUs is
> - * undesirable, use migrate_prep_local()
> - */
> -void migrate_prep(void)
> -{
> -	/*
> -	 * Clear the LRU lists so pages can be isolated.
> -	 * Note that pages may be moved off the LRU after we have
> -	 * drained them. Those pages will fail to migrate like other
> -	 * pages that may be busy.
> -	 */
> -	lru_add_drain_all();
> -}
> -
> -/* Do the necessary work of migrate_prep but not if it involves other CPUs */
> -void migrate_prep_local(void)
> -{
> -	lru_add_drain();
> -}
> -
>   int isolate_movable_page(struct page *page, isolate_mode_t mode)
>   {
>   	struct address_space *mapping;
> @@ -1769,7 +1747,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>   	int start, i;
>   	int err = 0, err1;
>   
> -	migrate_prep();
> +	lru_add_drain_all();
>   
>   	for (i = start = 0; i < nr_pages; i++) {
>   		const void __user *p;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2e8348936df8..f05a8db741ca 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8467,7 +8467,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>   		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
>   	};
>   
> -	migrate_prep();
> +	lru_add_drain_all();
>   
>   	while (pfn < end || !list_empty(&cc->migratepages)) {
>   		if (fatal_signal_pending(current)) {
> diff --git a/mm/swap.c b/mm/swap.c
> index 31b844d4ed94..441d1ae1f285 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -729,6 +729,11 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
>   }
>   
>   /*
> + * lru_add_drain_all() usually needs to be called before we start compiling
> + * a list of pages to be migrated using isolate_lru_page(). Note that pages
> + * may be moved off the LRU after we have drained them. Those pages will
> + * fail to migrate like other pages that may be busy.
> + *
>    * Doesn't need any cpu hotplug locking because we do rely on per-cpu
>    * kworkers being shut down before our page_alloc_cpu_dead callback is
>    * executed on the offlined cpu.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

