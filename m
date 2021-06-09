Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70BE3A1161
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 12:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbhFIKq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 06:46:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235052AbhFIKq4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623235499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wn61wvGsrZPr3Bs7lAZrFJOV9d4oeYutZi5DKf0Dx9U=;
        b=hv8zuJBkI/ytjrOJv4cahjeYxXTx1brQSDDLmqJ78WX/8j9VFt1KSm+Qh+en1rWrNcq0DQ
        7uTfh2p8yGNPduDPO0Xz6x0pr8LM7SUQhiBOL6DLpzmKOfjRHwoGG2/LssHJBwb+PFT/wt
        Kc5PAWoJhaQs18xqHKBa+QzeveIBStU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-wrAeb1_5PNih-8ryIJiX7A-1; Wed, 09 Jun 2021 06:44:57 -0400
X-MC-Unique: wrAeb1_5PNih-8ryIJiX7A-1
Received: by mail-wr1-f69.google.com with SMTP id k25-20020a5d52590000b0290114dee5b660so10608294wrc.16
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jun 2021 03:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Wn61wvGsrZPr3Bs7lAZrFJOV9d4oeYutZi5DKf0Dx9U=;
        b=rndloLCheoQacc5auK9BBh/au7Lfbagw9fQ4gkPPtJ2uAws7T8olN4fbiUnS0JkLHB
         3hUffN/IxRRGSXK14bd9ravWfJC+DtfXN5F54rtEPFfEljKLleMyaaLxpTGQyaR+1vZs
         2up02Dt91AITFxSq/nNAdyos93tg7zgeazUCD9l7BEFDvFiUDfLJjRhGcNMo9uNgBZT0
         g3HaJObQHwrZ6wemp/vwPeMDJlwZ+1uFyz2XRb0iZbImk69NKYuQqYabt8OJBdTI1GhO
         vW0kpuzUy3vA8Pv4/V+Ar9oNro/XwtURsR5aC0SCnvJtAC5sEApNaPMLkMtm4JDT8Mek
         yO7Q==
X-Gm-Message-State: AOAM532GMNYkqGHTmtotthraRDi6uY2AF9SvtmuxO06jhdd3nRmqHndY
        wxHJ3HLAvKUKshBqt5Ivmuxig50a/XarUwTJBsipCx9KCSaAbXycTxm4t9peYhRsnA0CsNapEqd
        xrLA/2B1eW1Yt17m9+jR+lxuthg==
X-Received: by 2002:a1c:770b:: with SMTP id t11mr9099942wmi.79.1623235496561;
        Wed, 09 Jun 2021 03:44:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7B8PRy8M6hppCE72ZIXVc5gaAVIQuKoTl7DV/+tdt0wcwyIUod9OORSca87u9VRDHyYd1Jg==
X-Received: by 2002:a1c:770b:: with SMTP id t11mr9099928wmi.79.1623235496361;
        Wed, 09 Jun 2021 03:44:56 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c611d.dip0.t-ipconnect.de. [91.12.97.29])
        by smtp.gmail.com with ESMTPSA id o17sm22066824wrp.47.2021.06.09.03.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 03:44:55 -0700 (PDT)
Subject: Re: [PATCH v4] mm/compaction: let proactive compaction order
 configurable
To:     chukaiping <chukaiping@baidu.com>, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, vbabka@suse.cz, nigupta@nvidia.com,
        bhe@redhat.com, khalid.aziz@oracle.com, iamjoonsoo.kim@lge.com,
        mateusznosek0@gmail.com, sh_def@163.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <1619576901-9531-1-git-send-email-chukaiping@baidu.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <a3f6628a-8165-429f-0383-c522b4c49197@redhat.com>
Date:   Wed, 9 Jun 2021 12:44:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1619576901-9531-1-git-send-email-chukaiping@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28.04.21 04:28, chukaiping wrote:
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
> Changes in v4:
>      - change the sysctl file name to proactive_compation_order
> 
> Changes in v3:
>      - change the min value of compaction_order to 1 because the fragmentation
>        index of order 0 is always 0
>      - move the definition of max_buddy_zone into #ifdef CONFIG_COMPACTION
> 
> Changes in v2:
>      - fix the compile error in ia64 and powerpc, move the initialization
>        of sysctl_compaction_order to kcompactd_init because
>        COMPACTION_HPAGE_ORDER is a variable in these architectures
>      - change the hard coded max order number from 10 to MAX_ORDER - 1
> 
>   include/linux/compaction.h |    1 +
>   kernel/sysctl.c            |   10 ++++++++++
>   mm/compaction.c            |   12 ++++++++----
>   3 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index ed4070e..a0226b1 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -83,6 +83,7 @@ static inline unsigned long compact_gap(unsigned int order)
>   #ifdef CONFIG_COMPACTION
>   extern int sysctl_compact_memory;
>   extern unsigned int sysctl_compaction_proactiveness;
> +extern unsigned int sysctl_proactive_compaction_order;
>   extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>   			void *buffer, size_t *length, loff_t *ppos);
>   extern int sysctl_extfrag_threshold;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 62fbd09..ed9012e 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -196,6 +196,7 @@ enum sysctl_writes_mode {
>   #endif /* CONFIG_SCHED_DEBUG */
>   
>   #ifdef CONFIG_COMPACTION
> +static int max_buddy_zone = MAX_ORDER - 1;
>   static int min_extfrag_threshold;
>   static int max_extfrag_threshold = 1000;
>   #endif
> @@ -2871,6 +2872,15 @@ int proc_do_static_key(struct ctl_table *table, int write,
>   		.extra2		= &one_hundred,
>   	},
>   	{
> +		.procname       = "proactive_compation_order",
> +		.data           = &sysctl_proactive_compaction_order,
> +		.maxlen         = sizeof(sysctl_proactive_compaction_order),
> +		.mode           = 0644,
> +		.proc_handler   = proc_dointvec_minmax,
> +		.extra1         = SYSCTL_ONE,
> +		.extra2         = &max_buddy_zone,
> +	},
> +	{
>   		.procname	= "extfrag_threshold",
>   		.data		= &sysctl_extfrag_threshold,
>   		.maxlen		= sizeof(int),
> diff --git a/mm/compaction.c b/mm/compaction.c
> index e04f447..171436e 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1925,17 +1925,18 @@ static bool kswapd_is_running(pg_data_t *pgdat)
>   
>   /*
>    * A zone's fragmentation score is the external fragmentation wrt to the
> - * COMPACTION_HPAGE_ORDER. It returns a value in the range [0, 100].
> + * sysctl_proactive_compaction_order. It returns a value in the range
> + * [0, 100].
>    */
>   static unsigned int fragmentation_score_zone(struct zone *zone)
>   {
> -	return extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
> +	return extfrag_for_order(zone, sysctl_proactive_compaction_order);
>   }
>   
>   /*
>    * A weighted zone's fragmentation score is the external fragmentation
> - * wrt to the COMPACTION_HPAGE_ORDER scaled by the zone's size. It
> - * returns a value in the range [0, 100].
> + * wrt to the sysctl_proactive_compaction_order scaled by the zone's size.
> + * It returns a value in the range [0, 100].
>    *
>    * The scaling factor ensures that proactive compaction focuses on larger
>    * zones like ZONE_NORMAL, rather than smaller, specialized zones like
> @@ -2666,6 +2667,7 @@ static void compact_nodes(void)
>    * background. It takes values in the range [0, 100].
>    */
>   unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
> +unsigned int __read_mostly sysctl_proactive_compaction_order;
>   
>   /*
>    * This is the entry point for compacting all nodes via
> @@ -2958,6 +2960,8 @@ static int __init kcompactd_init(void)
>   	int nid;
>   	int ret;
>   
> +	sysctl_proactive_compaction_order = COMPACTION_HPAGE_ORDER;
> +
>   	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>   					"mm/compaction:online",
>   					kcompactd_cpu_online, NULL);
> 

Hm, do we actually want to put an upper limit to the order a user can 
supply?

-- 
Thanks,

David / dhildenb

