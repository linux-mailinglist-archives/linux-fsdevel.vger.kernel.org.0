Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3237368813
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 22:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbhDVUep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 16:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27710 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236949AbhDVUep (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619123649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bPsR9zAvMT1rXu00S7RjYydgHJfjQUx3EMwYfq9HIMg=;
        b=TcMfLho5m38TIHVTYBOXxyy+xXPCqiyBVDELfsR0fxA+f1X80I8RuUettw3e6JJGcK9rbk
        TQTPYSCwSFbN4j1bCUniSnA83FEIWcUb/tarQtOXuZhW6EqGYUOnyEfapzDa7VEkwhDnJF
        pyKDObpLHToGxOMCXQ9SjJ/zsBhjqWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-x7oK4LyIMbOEnxlHSgLzJA-1; Thu, 22 Apr 2021 16:34:05 -0400
X-MC-Unique: x7oK4LyIMbOEnxlHSgLzJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBAD4343A2;
        Thu, 22 Apr 2021 20:34:02 +0000 (UTC)
Received: from optiplex-fbsd (unknown [10.3.128.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5CFD60C17;
        Thu, 22 Apr 2021 20:33:58 +0000 (UTC)
Date:   Thu, 22 Apr 2021 16:33:56 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     chukaiping <chukaiping@baidu.com>
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, vbabka@suse.cz, nigupta@nvidia.com,
        bhe@redhat.com, khalid.aziz@oracle.com, iamjoonsoo.kim@lge.com,
        mateusznosek0@gmail.com, sh_def@163.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/compaction:let proactive compaction order
 configurable
Message-ID: <YIHdtI7gMmIxewGG@optiplex-fbsd>
References: <1618989713-20962-1-git-send-email-chukaiping@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618989713-20962-1-git-send-email-chukaiping@baidu.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:21:53PM +0800, chukaiping wrote:
> Currently the proactive compaction order is fixed to
> COMPACTION_HPAGE_ORDER(9), it's OK in most machines with lots of
> normal 4KB memory, but it's too high for the machines with small
> normal memory, for example the machines with most memory configured
> as 1GB hugetlbfs huge pages. In these machines the max order of
> free pages is often below 9, and it's always below 9 even with hard
> compaction. This will lead to proactive compaction be triggered very
> frequently. In these machines we only care about order of 3 or 4.
> This patch export the oder to proc and let it configurable
> by user, and the default value is still COMPACTION_HPAGE_ORDER.
> 
> Signed-off-by: chukaiping <chukaiping@baidu.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> 
> Changes in v2:
>     - fix the compile error in ia64 and powerpc
>     - change the hard coded max order number from 10 to MAX_ORDER - 1
> 
>  include/linux/compaction.h |    1 +
>  kernel/sysctl.c            |   11 +++++++++++
>  mm/compaction.c            |   14 +++++++++++---
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index ed4070e..151ccd1 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -83,6 +83,7 @@ static inline unsigned long compact_gap(unsigned int order)
>  #ifdef CONFIG_COMPACTION
>  extern int sysctl_compact_memory;
>  extern unsigned int sysctl_compaction_proactiveness;
> +extern unsigned int sysctl_compaction_order;
>  extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>  			void *buffer, size_t *length, loff_t *ppos);
>  extern int sysctl_extfrag_threshold;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 62fbd09..a607d4d 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -195,6 +195,8 @@ enum sysctl_writes_mode {
>  #endif /* CONFIG_SMP */
>  #endif /* CONFIG_SCHED_DEBUG */
>  
> +static int max_buddy_zone = MAX_ORDER - 1;
> +

This should go into the #ifdef CONFIG_COMPACTION section
below

>  #ifdef CONFIG_COMPACTION
>  static int min_extfrag_threshold;
>  static int max_extfrag_threshold = 1000;
> @@ -2871,6 +2873,15 @@ int proc_do_static_key(struct ctl_table *table, int write,
>  		.extra2		= &one_hundred,
>  	},
>  	{
> +		.procname       = "compaction_order",
> +		.data           = &sysctl_compaction_order,
> +		.maxlen         = sizeof(sysctl_compaction_order),
> +		.mode           = 0644,
> +		.proc_handler   = proc_dointvec_minmax,
> +		.extra1         = SYSCTL_ZERO,
> +		.extra2         = &max_buddy_zone,
> +	},
> +	{
>  		.procname	= "extfrag_threshold",
>  		.data		= &sysctl_extfrag_threshold,
>  		.maxlen		= sizeof(int),
> diff --git a/mm/compaction.c b/mm/compaction.c
> index e04f447..bfd1d5e 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1925,16 +1925,16 @@ static bool kswapd_is_running(pg_data_t *pgdat)
>  
>  /*
>   * A zone's fragmentation score is the external fragmentation wrt to the
> - * COMPACTION_HPAGE_ORDER. It returns a value in the range [0, 100].
> + * sysctl_compaction_order. It returns a value in the range [0, 100].
>   */
>  static unsigned int fragmentation_score_zone(struct zone *zone)
>  {
> -	return extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
> +	return extfrag_for_order(zone, sysctl_compaction_order);
>  }
>  
>  /*
>   * A weighted zone's fragmentation score is the external fragmentation
> - * wrt to the COMPACTION_HPAGE_ORDER scaled by the zone's size. It
> + * wrt to the sysctl_compaction_order scaled by the zone's size. It
>   * returns a value in the range [0, 100].
>   *
>   * The scaling factor ensures that proactive compaction focuses on larger
> @@ -2666,6 +2666,7 @@ static void compact_nodes(void)
>   * background. It takes values in the range [0, 100].
>   */
>  unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
> +unsigned int __read_mostly sysctl_compaction_order;
>  
>  /*
>   * This is the entry point for compacting all nodes via
> @@ -2958,6 +2959,13 @@ static int __init kcompactd_init(void)
>  	int nid;
>  	int ret;
>  
> +	/*
> +	 * move the initialization of sysctl_compaction_order to here to
> +	 * eliminate compile error in ia64 and powerpc architecture because
> +	 * COMPACTION_HPAGE_ORDER is a variable in this architecture
> +	 */

This comment block belongs to your commit log, instead.


Cheers,
-- Rafael

> +	sysctl_compaction_order = COMPACTION_HPAGE_ORDER;
> +
>  	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>  					"mm/compaction:online",
>  					kcompactd_cpu_online, NULL);
> -- 
> 1.7.1
> 
> 

