Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FA739469A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 19:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhE1RoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 13:44:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43240 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhE1RoG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 13:44:06 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DF24D1FD2E;
        Fri, 28 May 2021 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622223749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zq80NlXSvdx5/aOv0vEANOPqKQZGQ+8KXE80Dg+Lb1w=;
        b=jfX2Sw2HQrMoeIpcNyvriHpwcBGWuQWDfh1JnVyBilNTFtmKqFqkKYoGCOheQqMd1gqfuI
        R5RCIgP70zmGwzUuZCMTXt7ti0i+NokMNGXoPU8FhNsaQy0lEdoyq3JLmBAuX7UAjK8xXx
        +hgdxgkxTBh24hoKhmJ04gapPv4EVlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622223749;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zq80NlXSvdx5/aOv0vEANOPqKQZGQ+8KXE80Dg+Lb1w=;
        b=7GVp6oY7SMnRWOlOJybfPl7psUPH0V/IEjSq6nBDsZ/eoncGtSDm9aMWWmZgpP5FHYdgQ0
        zdyd0Tom76nh3kBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 6A174118DD;
        Fri, 28 May 2021 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622223749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zq80NlXSvdx5/aOv0vEANOPqKQZGQ+8KXE80Dg+Lb1w=;
        b=jfX2Sw2HQrMoeIpcNyvriHpwcBGWuQWDfh1JnVyBilNTFtmKqFqkKYoGCOheQqMd1gqfuI
        R5RCIgP70zmGwzUuZCMTXt7ti0i+NokMNGXoPU8FhNsaQy0lEdoyq3JLmBAuX7UAjK8xXx
        +hgdxgkxTBh24hoKhmJ04gapPv4EVlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622223749;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zq80NlXSvdx5/aOv0vEANOPqKQZGQ+8KXE80Dg+Lb1w=;
        b=7GVp6oY7SMnRWOlOJybfPl7psUPH0V/IEjSq6nBDsZ/eoncGtSDm9aMWWmZgpP5FHYdgQ0
        zdyd0Tom76nh3kBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 7XfGGIUrsWDQUQAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Fri, 28 May 2021 17:42:29 +0000
Subject: Re: [PATCH v4] mm/compaction: let proactive compaction order
 configurable
To:     chukaiping <chukaiping@baidu.com>, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, nigupta@nvidia.com, bhe@redhat.com,
        khalid.aziz@oracle.com, iamjoonsoo.kim@lge.com,
        mateusznosek0@gmail.com, sh_def@163.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <1619576901-9531-1-git-send-email-chukaiping@baidu.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <aa99cdab-cc0d-6cc2-464d-be42da5efa97@suse.cz>
Date:   Fri, 28 May 2021 19:42:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1619576901-9531-1-git-send-email-chukaiping@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: imap.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.00
X-Spamd-Result: default: False [0.00 / 100.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         RCPT_COUNT_TWELVE(0.00)[14];
         FREEMAIL_TO(0.00)[baidu.com,kernel.org,chromium.org,google.com,linux-foundation.org,nvidia.com,redhat.com,oracle.com,lge.com,gmail.com,163.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/28/21 4:28 AM, chukaiping wrote:
> Currently the proactive compaction order is fixed to
> COMPACTION_HPAGE_ORDER(9), it's OK in most machines with lots of
> normal 4KB memory, but it's too high for the machines with small
> normal memory, for example the machines with most memory configured
> as 1GB hugetlbfs huge pages. In these machines the max order of
> free pages is often below 9, and it's always below 9 even with hard
> compaction. This will lead to proactive compaction be triggered very
> frequently.

Could you be more concrete about "very frequently"? There's a proactive_defer
mechanism that should help here. Normally the proactive compaction attempt
happens each 500ms, but if it fails to improve the fragmentation score, it
defers for 32 seconds. So is 32 seconds still too frequent? Or the score does
improve thus defer doesn't happen, but the cost of that improvement is too high
compared to the amount of the improvement?

> In these machines we only care about order of 3 or 4.
> This patch export the oder to proc and let it configurable
> by user, and the default value is still COMPACTION_HPAGE_ORDER.
> 
> Signed-off-by: chukaiping <chukaiping@baidu.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> 
> Changes in v4:
>     - change the sysctl file name to proactive_compation_order
> 
> Changes in v3:
>     - change the min value of compaction_order to 1 because the fragmentation
>       index of order 0 is always 0
>     - move the definition of max_buddy_zone into #ifdef CONFIG_COMPACTION
> 
> Changes in v2:
>     - fix the compile error in ia64 and powerpc, move the initialization
>       of sysctl_compaction_order to kcompactd_init because
>       COMPACTION_HPAGE_ORDER is a variable in these architectures
>     - change the hard coded max order number from 10 to MAX_ORDER - 1
> 
>  include/linux/compaction.h |    1 +
>  kernel/sysctl.c            |   10 ++++++++++
>  mm/compaction.c            |   12 ++++++++----
>  3 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index ed4070e..a0226b1 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -83,6 +83,7 @@ static inline unsigned long compact_gap(unsigned int order)
>  #ifdef CONFIG_COMPACTION
>  extern int sysctl_compact_memory;
>  extern unsigned int sysctl_compaction_proactiveness;
> +extern unsigned int sysctl_proactive_compaction_order;
>  extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>  			void *buffer, size_t *length, loff_t *ppos);
>  extern int sysctl_extfrag_threshold;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 62fbd09..ed9012e 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -196,6 +196,7 @@ enum sysctl_writes_mode {
>  #endif /* CONFIG_SCHED_DEBUG */
>  
>  #ifdef CONFIG_COMPACTION
> +static int max_buddy_zone = MAX_ORDER - 1;
>  static int min_extfrag_threshold;
>  static int max_extfrag_threshold = 1000;
>  #endif
> @@ -2871,6 +2872,15 @@ int proc_do_static_key(struct ctl_table *table, int write,
>  		.extra2		= &one_hundred,
>  	},
>  	{
> +		.procname       = "proactive_compation_order",
> +		.data           = &sysctl_proactive_compaction_order,
> +		.maxlen         = sizeof(sysctl_proactive_compaction_order),
> +		.mode           = 0644,
> +		.proc_handler   = proc_dointvec_minmax,
> +		.extra1         = SYSCTL_ONE,
> +		.extra2         = &max_buddy_zone,
> +	},
> +	{
>  		.procname	= "extfrag_threshold",
>  		.data		= &sysctl_extfrag_threshold,
>  		.maxlen		= sizeof(int),
> diff --git a/mm/compaction.c b/mm/compaction.c
> index e04f447..171436e 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1925,17 +1925,18 @@ static bool kswapd_is_running(pg_data_t *pgdat)
>  
>  /*
>   * A zone's fragmentation score is the external fragmentation wrt to the
> - * COMPACTION_HPAGE_ORDER. It returns a value in the range [0, 100].
> + * sysctl_proactive_compaction_order. It returns a value in the range
> + * [0, 100].
>   */
>  static unsigned int fragmentation_score_zone(struct zone *zone)
>  {
> -	return extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
> +	return extfrag_for_order(zone, sysctl_proactive_compaction_order);
>  }
>  
>  /*
>   * A weighted zone's fragmentation score is the external fragmentation
> - * wrt to the COMPACTION_HPAGE_ORDER scaled by the zone's size. It
> - * returns a value in the range [0, 100].
> + * wrt to the sysctl_proactive_compaction_order scaled by the zone's size.
> + * It returns a value in the range [0, 100].
>   *
>   * The scaling factor ensures that proactive compaction focuses on larger
>   * zones like ZONE_NORMAL, rather than smaller, specialized zones like
> @@ -2666,6 +2667,7 @@ static void compact_nodes(void)
>   * background. It takes values in the range [0, 100].
>   */
>  unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
> +unsigned int __read_mostly sysctl_proactive_compaction_order;
>  
>  /*
>   * This is the entry point for compacting all nodes via
> @@ -2958,6 +2960,8 @@ static int __init kcompactd_init(void)
>  	int nid;
>  	int ret;
>  
> +	sysctl_proactive_compaction_order = COMPACTION_HPAGE_ORDER;
> +
>  	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>  					"mm/compaction:online",
>  					kcompactd_cpu_online, NULL);
> 

