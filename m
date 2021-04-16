Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53423362A59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 23:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344418AbhDPVb6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 17:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344410AbhDPVb5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:31:57 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F6AC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 14:31:30 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u7so12854305plr.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=hM1UR+Vw0ywEGDkul6oI2E64jJ5D9eQ8MbJoitghleQ=;
        b=WcD3qHCNcHRS7V5HM/CHnNz8IDEXBPrD/ywe/hZjlGAXenB8tD7MCapy8Vh2G0+hTh
         W6m/7vjZVYFAFX65Lj0x4RFDKE5vO1hpOeUD97DkwwReCv+gYr5OshGZm0hoYOdW1/Qp
         3+d565l0EkmFQYQyk6D44fo5fbjJYHMILnHx0BvJ72PfoI8DyzX00LUgvVjpfWDah1dd
         avx+IOemk2fdRqyMPlhS/ecZs36FA/A+7seWHBmrruuXDyhpqaSu/GXJ45nKrW9O91oS
         4ICzYyl1A/lbNdRDy9INu/b8F+HzP0oFsLhGF3N6w4xW0mwULz9vrZK8aytGzHrFX9ZQ
         594A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=hM1UR+Vw0ywEGDkul6oI2E64jJ5D9eQ8MbJoitghleQ=;
        b=pOuTxplCZJUK2YbcpbIOeOE4U8O/1Z91ixILumiHB6uSKmbXaKrk4Z3oIjooIGkEhz
         cACsqHtD/+0BFuSTxcYo3jqW6vqaXVC63E2NzmvNd/m/Vj+U06LHV5lFCNPL5if4vp3z
         1SZzTbVRuY/TIWdKp7wqMJhXVB4C1Kmrj9CxJRYwwI0KH/67Q729yB8Q1XTqZYvOLCJH
         TeYOM3zp2KHMPN/wMYxcG9Etgzj4fBkHFspbYjbFj/eOQaMIb+tUBl/AHhpHE05OZL5e
         f9Y8xBzht1fD+1O1RcqBoarfRG4YqM5Kmcnj7ngIPi5mQDTAGdKaD+55jqUNByVzsG7m
         kaqg==
X-Gm-Message-State: AOAM531N3SJb20eAYuL6Y9O5q72bu2VpKXjrH9xQawuBPx9NHveM2ChS
        tl2zHlYrMeBWUN+Cj8oP7AvrOg==
X-Google-Smtp-Source: ABdhPJxO8/F3ez1KDXkuVV4SgjTCxbjSmVz2zc4Lm7qt0toOer9TRTe6i01oIiwQk1mSdoFB0fSg5w==
X-Received: by 2002:a17:902:b602:b029:e6:cabb:10b9 with SMTP id b2-20020a170902b602b02900e6cabb10b9mr11360077pls.47.1618608689649;
        Fri, 16 Apr 2021 14:31:29 -0700 (PDT)
Received: from [2620:15c:17:3:f88f:bc36:c44b:9965] ([2620:15c:17:3:f88f:bc36:c44b:9965])
        by smtp.gmail.com with ESMTPSA id q3sm6598565pja.37.2021.04.16.14.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:31:28 -0700 (PDT)
Date:   Fri, 16 Apr 2021 14:31:28 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     chukaiping <chukaiping@baidu.com>
cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/compaction:let proactive compaction order
 configurable
In-Reply-To: <1618593751-32148-1-git-send-email-chukaiping@baidu.com>
Message-ID: <7efa316c-d39b-59a5-bc52-62325127a917@google.com>
References: <1618593751-32148-1-git-send-email-chukaiping@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 17 Apr 2021, chukaiping wrote:

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

Still not entirely clear on the use case beyond hugepages.  In your 
response from v1, you indicated you were not concerned with allocation 
latency of hugepages but rather had a thundering herd problem where once 
fragmentation got bad, many threads started compacting all at once.

I'm not sure that tuning the proactive compaction order is the right 
solution.  I think the proactive compaction order is more about starting 
compaction when a known order of interest (like a hugepage) is fully 
depleted and we want a page of that order so the idea is to start 
recovering from that situation.

Is this not a userspace policy decision?  I'm wondering if it would simply 
be better to manually invoke compaction periodically or when the 
fragmentation ratio has reached a certain level.  You can manually invoke 
compaction yourself through sysfs for each node on the system.

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
> +	sysctl_compaction_order = COMPACTION_HPAGE_ORDER;
> +
>  	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>  					"mm/compaction:online",
>  					kcompactd_cpu_online, NULL);
> -- 
> 1.7.1
> 
> 
> 
