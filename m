Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32802008EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 14:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgFSMm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 08:42:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34568 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725806AbgFSMm7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592570577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gv76+7wPlxv1JgTAX5XGbER7AaxLFtv8PFB7E49p9nI=;
        b=C8A9GH3BmB/8CGTRIs7bi6t/aP+Rs/IUJBwkkfcItBiacLevTifmsTuurOuWeR7XU4QY5b
        v4q4ZBfWxrKowibEhjQ9KldEUC50IGlRzaPLN7uuHIuvrZN4+bnQ1605gRZ7K881POrtrB
        2o+9s9J4f6NxgJFRqDjeqiIP0Z8sk/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-7Wo61-9uPoqvi1tbAT48UA-1; Fri, 19 Jun 2020 08:42:56 -0400
X-MC-Unique: 7Wo61-9uPoqvi1tbAT48UA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6060E1005512;
        Fri, 19 Jun 2020 12:42:53 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8212B71671;
        Fri, 19 Jun 2020 12:42:51 +0000 (UTC)
Date:   Fri, 19 Jun 2020 20:42:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Nitin Gupta <nigupta@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@nitingupta.dev>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC SYSCTL" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: Use unsigned types for fragmentation score
Message-ID: <20200619124248.GF3346@MiWiFi-R3L-srv>
References: <20200618010319.13159-1-nigupta@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618010319.13159-1-nigupta@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/17/20 at 06:03pm, Nitin Gupta wrote:
> Proactive compaction uses per-node/zone "fragmentation score" which
> is always in range [0, 100], so use unsigned type of these scores
> as well as for related constants.
> 
> Signed-off-by: Nitin Gupta <nigupta@nvidia.com>

Reviewed-by: Baoquan He <bhe@redhat.com>

> ---
>  include/linux/compaction.h |  4 ++--
>  kernel/sysctl.c            |  2 +-
>  mm/compaction.c            | 18 +++++++++---------
>  mm/vmstat.c                |  2 +-
>  4 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index 7a242d46454e..25a521d299c1 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -85,13 +85,13 @@ static inline unsigned long compact_gap(unsigned int order)
>  
>  #ifdef CONFIG_COMPACTION
>  extern int sysctl_compact_memory;
> -extern int sysctl_compaction_proactiveness;
> +extern unsigned int sysctl_compaction_proactiveness;
>  extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>  			void *buffer, size_t *length, loff_t *ppos);
>  extern int sysctl_extfrag_threshold;
>  extern int sysctl_compact_unevictable_allowed;
>  
> -extern int extfrag_for_order(struct zone *zone, unsigned int order);
> +extern unsigned int extfrag_for_order(struct zone *zone, unsigned int order);
>  extern int fragmentation_index(struct zone *zone, unsigned int order);
>  extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
>  		unsigned int order, unsigned int alloc_flags,
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 58b0a59c9769..40180cdde486 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2833,7 +2833,7 @@ static struct ctl_table vm_table[] = {
>  	{
>  		.procname	= "compaction_proactiveness",
>  		.data		= &sysctl_compaction_proactiveness,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(sysctl_compaction_proactiveness),
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
> diff --git a/mm/compaction.c b/mm/compaction.c
> index ac2030814edb..45fd24a0ea0b 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -53,7 +53,7 @@ static inline void count_compact_events(enum vm_event_item item, long delta)
>  /*
>   * Fragmentation score check interval for proactive compaction purposes.
>   */
> -static const int HPAGE_FRAG_CHECK_INTERVAL_MSEC = 500;
> +static const unsigned int HPAGE_FRAG_CHECK_INTERVAL_MSEC = 500;
>  
>  /*
>   * Page order with-respect-to which proactive compaction
> @@ -1890,7 +1890,7 @@ static bool kswapd_is_running(pg_data_t *pgdat)
>   * ZONE_DMA32. For smaller zones, the score value remains close to zero,
>   * and thus never exceeds the high threshold for proactive compaction.
>   */
> -static int fragmentation_score_zone(struct zone *zone)
> +static unsigned int fragmentation_score_zone(struct zone *zone)
>  {
>  	unsigned long score;
>  
> @@ -1906,9 +1906,9 @@ static int fragmentation_score_zone(struct zone *zone)
>   * the node's score falls below the low threshold, or one of the back-off
>   * conditions is met.
>   */
> -static int fragmentation_score_node(pg_data_t *pgdat)
> +static unsigned int fragmentation_score_node(pg_data_t *pgdat)
>  {
> -	unsigned long score = 0;
> +	unsigned int score = 0;
>  	int zoneid;
>  
>  	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
> @@ -1921,17 +1921,17 @@ static int fragmentation_score_node(pg_data_t *pgdat)
>  	return score;
>  }
>  
> -static int fragmentation_score_wmark(pg_data_t *pgdat, bool low)
> +static unsigned int fragmentation_score_wmark(pg_data_t *pgdat, bool low)
>  {
> -	int wmark_low;
> +	unsigned int wmark_low;
>  
>  	/*
>  	 * Cap the low watermak to avoid excessive compaction
>  	 * activity in case a user sets the proactivess tunable
>  	 * close to 100 (maximum).
>  	 */
> -	wmark_low = max(100 - sysctl_compaction_proactiveness, 5);
> -	return low ? wmark_low : min(wmark_low + 10, 100);
> +	wmark_low = max(100U - sysctl_compaction_proactiveness, 5U);
> +	return low ? wmark_low : min(wmark_low + 10, 100U);
>  }
>  
>  static bool should_proactive_compact_node(pg_data_t *pgdat)
> @@ -2604,7 +2604,7 @@ int sysctl_compact_memory;
>   * aggressively the kernel should compact memory in the
>   * background. It takes values in the range [0, 100].
>   */
> -int __read_mostly sysctl_compaction_proactiveness = 20;
> +unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
>  
>  /*
>   * This is the entry point for compacting all nodes via
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 3e7ba8bce2ba..b1de695b826d 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1079,7 +1079,7 @@ static int __fragmentation_index(unsigned int order, struct contig_page_info *in
>   * It is defined as the percentage of pages found in blocks of size
>   * less than 1 << order. It returns values in range [0, 100].
>   */
> -int extfrag_for_order(struct zone *zone, unsigned int order)
> +unsigned int extfrag_for_order(struct zone *zone, unsigned int order)
>  {
>  	struct contig_page_info info;
>  
> -- 
> 2.27.0
> 
> 

