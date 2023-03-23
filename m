Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AAA6C6D1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 17:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCWQPc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 12:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjCWQPM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:15:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E16E34C38;
        Thu, 23 Mar 2023 09:15:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 253341FE0C;
        Thu, 23 Mar 2023 16:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679588109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nao5YJy5U8MamFKPwtjtE3/coDYBxSRiD+wySqWUFFg=;
        b=ZzmDOH7PKtRDNFQCKzB3/DwbckrO6pbYa4doXEGSz2y3e2l0Wzal7+txERSkuW6NZT7H8/
        9Hwp1U1KBYFVP/3zozE/xwh9grNSt5PB45WVCUzsw3iVWXcQ2al7yimnJ1powbWagKkepP
        XBGdDWyN716cd0hJhGVQlwdUlRgKwLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679588109;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nao5YJy5U8MamFKPwtjtE3/coDYBxSRiD+wySqWUFFg=;
        b=/OGtHFA8Cw9F9Twg6BicDum99ioSBoKzFJ3KSm0S9aCrgaOfE8uNHqrXaSkbWUkphXNO/3
        07sWoT6Ouf/mbyDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F14B513596;
        Thu, 23 Mar 2023 16:15:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KGI+Ogx7HGRzQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 23 Mar 2023 16:15:08 +0000
Message-ID: <704cae66-5128-8628-b7ea-e5e0fe9e0f03@suse.cz>
Date:   Thu, 23 Mar 2023 17:15:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V6 1/2] mm: compaction: move compaction sysctl to its own
 file
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, mcgrof@kernel.org
Cc:     keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linmiaohe@huawei.com,
        chi.minghao@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <202303221108054628708@zte.com.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202303221108054628708@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/22/23 04:08, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> This moves all compaction sysctls to its own file.
> 
> Link: https://lore.kernel.org/lkml/9952bbf8-cf59-7bea-ce50-0200d4f4165e@suse.cz/
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  include/linux/compaction.h |  7 ----
>  kernel/sysctl.c            | 59 ------------------------------
>  mm/compaction.c            | 73 ++++++++++++++++++++++++++++++++++----
>  3 files changed, 67 insertions(+), 72 deletions(-)
> 
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index 52a9ff65faee..a6e512cfb670 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -81,13 +81,6 @@ static inline unsigned long compact_gap(unsigned int order)
>  }
> 
>  #ifdef CONFIG_COMPACTION
> -extern unsigned int sysctl_compaction_proactiveness;
> -extern int sysctl_compaction_handler(struct ctl_table *table, int write,
> -			void *buffer, size_t *length, loff_t *ppos);
> -extern int compaction_proactiveness_sysctl_handler(struct ctl_table *table,
> -		int write, void *buffer, size_t *length, loff_t *ppos);
> -extern int sysctl_extfrag_threshold;
> -extern int sysctl_compact_unevictable_allowed;
> 
>  extern unsigned int extfrag_for_order(struct zone *zone, unsigned int order);
>  extern int fragmentation_index(struct zone *zone, unsigned int order);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index ce0297acf97c..e23061f33237 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -42,7 +42,6 @@
>  #include <linux/highuid.h>
>  #include <linux/writeback.h>
>  #include <linux/ratelimit.h>
> -#include <linux/compaction.h>
>  #include <linux/hugetlb.h>
>  #include <linux/initrd.h>
>  #include <linux/key.h>
> @@ -746,27 +745,6 @@ int proc_dointvec(struct ctl_table *table, int write, void *buffer,
>  	return do_proc_dointvec(table, write, buffer, lenp, ppos, NULL, NULL);
>  }
> 
> -#ifdef CONFIG_COMPACTION
> -static int proc_dointvec_minmax_warn_RT_change(struct ctl_table *table,
> -		int write, void *buffer, size_t *lenp, loff_t *ppos)
> -{
> -	int ret, old;
> -
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || !write)
> -		return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> -
> -	old = *(int *)table->data;
> -	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> -	if (ret)
> -		return ret;
> -	if (old != *(int *)table->data)
> -		pr_warn_once("sysctl attribute %s changed by %s[%d]\n",
> -			     table->procname, current->comm,
> -			     task_pid_nr(current));
> -	return ret;
> -}
> -#endif
> -
>  /**
>   * proc_douintvec - read a vector of unsigned integers
>   * @table: the sysctl table
> @@ -2157,43 +2135,6 @@ static struct ctl_table vm_table[] = {
>  		.extra1		= SYSCTL_ONE,
>  		.extra2		= SYSCTL_FOUR,
>  	},
> -#ifdef CONFIG_COMPACTION
> -	{
> -		.procname	= "compact_memory",
> -		.data		= NULL,
> -		.maxlen		= sizeof(int),
> -		.mode		= 0200,
> -		.proc_handler	= sysctl_compaction_handler,
> -	},
> -	{
> -		.procname	= "compaction_proactiveness",
> -		.data		= &sysctl_compaction_proactiveness,
> -		.maxlen		= sizeof(sysctl_compaction_proactiveness),
> -		.mode		= 0644,
> -		.proc_handler	= compaction_proactiveness_sysctl_handler,
> -		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_ONE_HUNDRED,
> -	},
> -	{
> -		.procname	= "extfrag_threshold",
> -		.data		= &sysctl_extfrag_threshold,
> -		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_ONE_THOUSAND,
> -	},
> -	{
> -		.procname	= "compact_unevictable_allowed",
> -		.data		= &sysctl_compact_unevictable_allowed,
> -		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax_warn_RT_change,
> -		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_ONE,
> -	},
> -
> -#endif /* CONFIG_COMPACTION */
>  	{
>  		.procname	= "min_free_kbytes",
>  		.data		= &min_free_kbytes,
> diff --git a/mm/compaction.c b/mm/compaction.c
> index e689d66cedf4..ec2989f2c5d3 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1728,7 +1728,9 @@ typedef enum {
>   * Allow userspace to control policy on scanning the unevictable LRU for
>   * compactable pages.
>   */
> -int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;
> +static int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;
> +unsigned int sysctl_compaction_proactiveness;

Couldn't you move the "__read_mostly" and "= 20" part here as well? And the
explanatory comment? And make it static too?

> +static int sysctl_extfrag_threshold = 500;
> 
>  static inline void
>  update_fast_start_pfn(struct compact_control *cc, unsigned long pfn)
> @@ -2584,8 +2586,6 @@ static enum compact_result compact_zone_order(struct zone *zone, int order,
>  	return ret;
>  }
> 
> -int sysctl_extfrag_threshold = 500;
> -
>  /**
>   * try_to_compact_pages - Direct compact to satisfy a high-order allocation
>   * @gfp_mask: The GFP mask of the current allocation
> @@ -2748,8 +2748,7 @@ static void compact_nodes(void)
>   * background. It takes values in the range [0, 100].
>   */
>  unsigned int __read_mostly sysctl_compaction_proactiveness = 20;

And remove this.

> -
> -int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
> +static int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
>  		void *buffer, size_t *length, loff_t *ppos)
>  {
>  	int rc, nid;
> @@ -2779,7 +2778,7 @@ int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
>   * This is the entry point for compacting all nodes via
>   * /proc/sys/vm/compact_memory
>   */
> -int sysctl_compaction_handler(struct ctl_table *table, int write,
> +static int sysctl_compaction_handler(struct ctl_table *table, int write,
>  			void *buffer, size_t *length, loff_t *ppos)
>  {
>  	if (write)
> @@ -3075,6 +3074,65 @@ static int kcompactd_cpu_online(unsigned int cpu)
>  	return 0;
>  }
> 
> +static int proc_dointvec_minmax_warn_RT_change(struct ctl_table *table,
> +		int write, void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int ret, old;
> +
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || !write)
> +		return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +
> +	old = *(int *)table->data;
> +	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +	if (ret)
> +		return ret;
> +	if (old != *(int *)table->data)
> +		pr_warn_once("sysctl attribute %s changed by %s[%d]\n",
> +			     table->procname, current->comm,
> +			     task_pid_nr(current));
> +	return ret;
> +}
> +
> +#ifdef CONFIG_SYSCTL
> +static struct ctl_table vm_compaction[] = {
> +	{
> +		.procname	= "compact_memory",
> +		.data		= NULL,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0200,
> +		.proc_handler	= sysctl_compaction_handler,
> +	},
> +	{
> +		.procname	= "compaction_proactiveness",
> +		.data		= &sysctl_compaction_proactiveness,
> +		.maxlen		= sizeof(sysctl_compaction_proactiveness),
> +		.mode		= 0644,
> +		.proc_handler	= compaction_proactiveness_sysctl_handler,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE_HUNDRED,
> +	},
> +	{
> +		.procname	= "extfrag_threshold",
> +		.data		= &sysctl_extfrag_threshold,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE_THOUSAND,
> +	},
> +	{
> +		.procname	= "compact_unevictable_allowed",
> +		.data		= &sysctl_compact_unevictable_allowed,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax_warn_RT_change,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +	{ }
> +};
> +#endif
> +
>  static int __init kcompactd_init(void)
>  {
>  	int nid;
> @@ -3090,6 +3148,9 @@ static int __init kcompactd_init(void)
> 
>  	for_each_node_state(nid, N_MEMORY)
>  		kcompactd_run(nid);
> +#ifdef CONFIG_SYSCTL
> +	register_sysctl_init("vm", vm_compaction);
> +#endif
>  	return 0;
>  }
>  subsys_initcall(kcompactd_init)

