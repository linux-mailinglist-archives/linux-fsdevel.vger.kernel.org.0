Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86A9BF7158
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 11:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfKKKGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 05:06:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:59974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbfKKKGt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:06:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8FC55B126;
        Mon, 11 Nov 2019 10:06:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 188F51E4AD6; Mon, 11 Nov 2019 11:06:46 +0100 (CET)
Date:   Mon, 11 Nov 2019 11:06:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH v2] fs/quota: handle overflows of sysctl fs.quota.* and
 report as unsigned long
Message-ID: <20191111100646.GA13307@quack2.suse.cz>
References: <157337934693.2078.9842146413181153727.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157337934693.2078.9842146413181153727.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 10-11-19 12:49:06, Konstantin Khlebnikov wrote:
> Quota statistics counted as 64-bit per-cpu counter. Reading sums per-cpu
> fractions as signed 64-bit int, filters negative values and then reports
> lower half as signed 32-bit int.
> 
> Result may looks like:
> 
> fs.quota.allocated_dquots = 22327
> fs.quota.cache_hits = -489852115
> fs.quota.drops = -487288718
> fs.quota.free_dquots = 22083
> fs.quota.lookups = -486883485
> fs.quota.reads = 22327
> fs.quota.syncs = 335064
> fs.quota.writes = 3088689
> 
> Values bigger than 2^31-1 reported as negative.
> 
> All counters except "allocated_dquots" and "free_dquots" are monotonic,
> thus they should be reported as is without filtering negative values.
> 
> Kernel doesn't have generic helper for 64-bit sysctl yet,
> let's use at least unsigned long.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  fs/quota/dquot.c      |   29 +++++++++++++++++------------
>  include/linux/quota.h |    2 +-
>  2 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 6e826b454082..fa6ec4f96791 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2860,68 +2860,73 @@ EXPORT_SYMBOL(dquot_quotactl_sysfile_ops);
>  static int do_proc_dqstats(struct ctl_table *table, int write,
>  		     void __user *buffer, size_t *lenp, loff_t *ppos)
>  {
> -	unsigned int type = (int *)table->data - dqstats.stat;
> +	unsigned int type = (unsigned long *)table->data - dqstats.stat;
> +	s64 value = percpu_counter_sum(&dqstats.counter[type]);
> +
> +	/* Filter negative values for non-monotonic counters */
> +	if (value < 0 && (type == DQST_ALLOC_DQUOTS ||
> +			  type == DQST_FREE_DQUOTS))
> +		value = 0;
>  
>  	/* Update global table */
> -	dqstats.stat[type] =
> -			percpu_counter_sum_positive(&dqstats.counter[type]);
> -	return proc_dointvec(table, write, buffer, lenp, ppos);
> +	dqstats.stat[type] = value;
> +	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
>  }
>  
>  static struct ctl_table fs_dqstats_table[] = {
>  	{
>  		.procname	= "lookups",
>  		.data		= &dqstats.stat[DQST_LOOKUPS],
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(unsigned long),
>  		.mode		= 0444,
>  		.proc_handler	= do_proc_dqstats,
>  	},
>  	{
>  		.procname	= "drops",
>  		.data		= &dqstats.stat[DQST_DROPS],
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(unsigned long),
>  		.mode		= 0444,
>  		.proc_handler	= do_proc_dqstats,
>  	},
>  	{
>  		.procname	= "reads",
>  		.data		= &dqstats.stat[DQST_READS],
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(unsigned long),
>  		.mode		= 0444,
>  		.proc_handler	= do_proc_dqstats,
>  	},
>  	{
>  		.procname	= "writes",
>  		.data		= &dqstats.stat[DQST_WRITES],
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(unsigned long),
>  		.mode		= 0444,
>  		.proc_handler	= do_proc_dqstats,
>  	},
>  	{
>  		.procname	= "cache_hits",
>  		.data		= &dqstats.stat[DQST_CACHE_HITS],
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(unsigned long),
>  		.mode		= 0444,
>  		.proc_handler	= do_proc_dqstats,
>  	},
>  	{
>  		.procname	= "allocated_dquots",
>  		.data		= &dqstats.stat[DQST_ALLOC_DQUOTS],
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(unsigned long),
>  		.mode		= 0444,
>  		.proc_handler	= do_proc_dqstats,
>  	},
>  	{
>  		.procname	= "free_dquots",
>  		.data		= &dqstats.stat[DQST_FREE_DQUOTS],
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(unsigned long),
>  		.mode		= 0444,
>  		.proc_handler	= do_proc_dqstats,
>  	},
>  	{
>  		.procname	= "syncs",
>  		.data		= &dqstats.stat[DQST_SYNCS],
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(unsigned long),
>  		.mode		= 0444,
>  		.proc_handler	= do_proc_dqstats,
>  	},
> diff --git a/include/linux/quota.h b/include/linux/quota.h
> index f32dd270b8e3..27aab84fcbaa 100644
> --- a/include/linux/quota.h
> +++ b/include/linux/quota.h
> @@ -263,7 +263,7 @@ enum {
>  };
>  
>  struct dqstats {
> -	int stat[_DQST_DQSTAT_LAST];
> +	unsigned long stat[_DQST_DQSTAT_LAST];
>  	struct percpu_counter counter[_DQST_DQSTAT_LAST];
>  };
>  
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
