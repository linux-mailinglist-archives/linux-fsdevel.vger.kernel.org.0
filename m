Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6E44B1767
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 22:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344511AbiBJVFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 16:05:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbiBJVFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 16:05:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0139C2655;
        Thu, 10 Feb 2022 13:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Z9d73V1Hk3TZ+5A0nBSljOJ2hSUrKCy4MxgW8Jd6pE=; b=mWmITOP9ohmcC/iELjKVP0aY/U
        0JXuv3fvinanZVg4Ju0L2+K5L1UQEAkY6Zv+zDpGUds6eL17GzEtWb0f2y2T8Q9nJmkuKxCl1dQoE
        SuXHE+q8GVXMOLXlDVnybMCb8U1gY9YLmjlg6yvXXRxfQojfsqgJ/qtIrQaU/0AL5rgnsZf8HY9PZ
        hlCRoBOvQnYhVbcQ5o2dVhbctpbANN6nv99wTnJ6Zid86d9wVF2/4/7BHluvsKaiyJpBSFMjJl6uM
        aLajiUxbihdXfOaqLt2W97FU/gAMfLsLulO3DUYEWO74t7fEAGWesiYDvJSritf+N7S9Mtpo27F8q
        LP5lWLNg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIGd8-004w6Y-Hm; Thu, 10 Feb 2022 21:05:30 +0000
Date:   Thu, 10 Feb 2022 13:05:30 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zhen Ni <nizhen@uniontech.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] sched: move cfs_bandwidth_slice sysctls to fair.c
Message-ID: <YgV+GqGXYUl1ZTj9@bombadil.infradead.org>
References: <20220210054028.3062-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210054028.3062-1-nizhen@uniontech.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 10, 2022 at 01:40:28PM +0800, Zhen Ni wrote:
> move cfs_bandwidth_slice sysctls to fair.c and use the
> new register_sysctl_init() to register the sysctl interface.
> 
> Signed-off-by: Zhen Ni <nizhen@uniontech.com>
> ---

Your description of what has changed in your v2 should go here.
If a v3, then your v2 notes and v3 notes should be here as well.

>  include/linux/sched/sysctl.h |  4 ----
>  kernel/sched/fair.c          | 25 +++++++++++++++++++++++--
>  kernel/sysctl.c              | 10 ----------
>  3 files changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index c19dd5a2c05c..d416d8f45186 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -41,10 +41,6 @@ extern unsigned int sysctl_sched_uclamp_util_max;
>  extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
>  #endif
>  
> -#ifdef CONFIG_CFS_BANDWIDTH
> -extern unsigned int sysctl_sched_cfs_bandwidth_slice;
> -#endif
> -
>  #ifdef CONFIG_SCHED_AUTOGROUP
>  extern unsigned int sysctl_sched_autogroup_enabled;
>  #endif
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5146163bfabb..354ebf938567 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -141,8 +141,26 @@ int __weak arch_asym_cpu_priority(int cpu)
>   *
>   * (default: 5 msec, units: microseconds)
>   */
> -unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
> -#endif
> +static unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
> +#ifdef CONFIG_SYSCTL
> +static struct ctl_table sched_cfs_bandwidth_sysctls[] = {
> +	{
> +		.procname       = "sched_cfs_bandwidth_slice_us",
> +		.data           = &sysctl_sched_cfs_bandwidth_slice,
> +		.maxlen         = sizeof(unsigned int),
> +		.mode           = 0644,
> +		.proc_handler   = proc_dointvec_minmax,
> +		.extra1         = SYSCTL_ONE,
> +	},
> +	{}
> +};
> +
> +static void __init sched_cfs_bandwidth_sysctl_init(void)
> +{
> +	register_sysctl_init("kernel", sched_cfs_bandwidth_sysctls);
> +}
> +#endif /* CONFIG_SYSCTL */

Maybe an #else which then adds a no-op sched_cfs_bandwidth_sysctl_init

> +#endif /* CONFIG_CFS_BANDWIDTH */

Likewise, if disabled, then have a no-op sched_cfs_bandwidth_sysctl_init()

>  static inline void update_load_add(struct load_weight *lw, unsigned long inc)
>  {
> @@ -207,6 +225,9 @@ static void update_sysctl(void)
>  void __init sched_init_granularity(void)
>  {
>  	update_sysctl();
> +#if defined(CONFIG_CFS_BANDWIDTH) && defined(CONFIG_SYSCTL)
> +	sched_cfs_bandwidth_sysctl_init();
> +#endif

Then you can get remove the #ifdef mess from this code.

But this is a style issue nothing major.

  Luis
