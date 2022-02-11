Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54A34B24C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 12:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345558AbiBKLv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 06:51:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238409AbiBKLv0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:51:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68DFF4F;
        Fri, 11 Feb 2022 03:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BHPbXDxWBtuDI9YYnGdugRaUKtQ7K4m6+zQLsPmD+c4=; b=dR8Q5ZU2i/N7HitiOzfANLpiaz
        5qF/SGYCLXmE3e/dkF3v4vQlXl0pelPeb6ZkNEXzLADKV9kE23rp79jq4mfm03lr+heVNBw6SiiaY
        6Z1pKGNxXXmfGBcyaBr6PSJcpbz8Sdshm9m2BBMjbHme/kSazx7WqGhKRwogi4Xwnv6NNTZsBkMSl
        FG16DeaXr1JW6GU+rgKjMw3/dKdJvXb6j/XE3kxeGiExzW4cOIhaKmi9tqzv+Uf1tvOu9gdhNB4qx
        +LB1CCgDn3ykbmNyqqv+jJyTAUNskEwK3OFdtohRrAqlCJ7QbjcAlAePlTps3tau2u4nzTWSfA3hd
        HZgeVPvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIUSJ-00AN1Y-C0; Fri, 11 Feb 2022 11:51:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C45D9853C7; Fri, 11 Feb 2022 12:51:14 +0100 (CET)
Date:   Fri, 11 Feb 2022 12:51:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhen Ni <nizhen@uniontech.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched: move rr_timeslice sysctls to rt.c
Message-ID: <20220211115114.GU23216@worktop.programming.kicks-ass.net>
References: <20220210060831.26689-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210060831.26689-1-nizhen@uniontech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 10, 2022 at 02:08:31PM +0800, Zhen Ni wrote:
> move rr_timeslice sysctls to rt.c and use the new
> register_sysctl_init() to register the sysctl interface.
> 
> Signed-off-by: Zhen Ni <nizhen@uniontech.com>

OK, I've had it with this nonsense. Can you *please* redo all of sched
such that:

 - In the Subject:, the first letter after the subsystem prefix (sched:)
   is capitalized.
 - the lot actually applies to tip/sched/core (so far not a single one
   of these patches applied without needing -- mostly trivial --
   fixups).
 - Do obvious cleanups.. see below.
 - Don't have more than a single *sysctl_init() per .c file.
 - It's a full series that does all instead of random little patches
   that conflict with one another when applied out of turn.

> ---
>  include/linux/sched/sysctl.h |  3 ---
>  kernel/sched/rt.c            | 28 ++++++++++++++++++++++++++--
>  kernel/sysctl.c              |  7 -------
>  3 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index d416d8f45186..f6466040883c 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -45,11 +45,8 @@ extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
>  extern unsigned int sysctl_sched_autogroup_enabled;
>  #endif
>  
> -extern int sysctl_sched_rr_timeslice;
>  extern int sched_rr_timeslice;

Why leave sched_rr_timeslice here? It doesn't belong here.


> +#ifdef CONFIG_SYSCTL
> +static struct ctl_table sched_rr_sysctls[] = {
> +	{
> +		.procname       = "sched_rr_timeslice_ms",
> +		.data           = &sysctl_sched_rr_timeslice,
> +		.maxlen         = sizeof(int),
> +		.mode           = 0644,
> +		.proc_handler   = sched_rr_handler,
> +	},
> +	{}
> +};
> +
> +static void __init sched_rr_sysctl_init(void)
> +{
> +	register_sysctl_init("kernel", sched_rr_sysctls);
> +}
> +#else
> +#define sched_rr_sysctl_init() do { } while (0)
> +#endif
> +
>  static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
>  
>  struct rt_bandwidth def_rt_bandwidth;
> @@ -2471,6 +2494,7 @@ void __init init_sched_rt_class(void)
>  		zalloc_cpumask_var_node(&per_cpu(local_cpu_mask, i),
>  					GFP_KERNEL, cpu_to_node(i));
>  	}
> +	sched_rr_sysctl_init();
>  }

When I combine this with: patches/zhen_ni-sched-move_rt_period_runtime_sysctls_to_rt_c.patch

That ends up as:

@@ -2471,6 +2535,8 @@ void __init init_sched_rt_class(void)
                zalloc_cpumask_var_node(&per_cpu(local_cpu_mask, i),
                                        GFP_KERNEL, cpu_to_node(i));
        }
+       sched_rt_sysctl_init();
+       sched_rr_sysctl_init();
 }
 #endif /* CONFIG_SMP */

Like srsly?


So I've dropped the whole lot I had:

patches/zhen_ni-sched-move_energy_aware_sysctls_to_topology_c.patch
patches/zhen_ni-sched-move_cfs_bandwidth_slice_sysctls_to_fair_c.patch
patches/zhen_ni-sched-move_uclamp_util_sysctls_to_core_c.patch
patches/zhen_ni-sched-move_schedstats_sysctls_to_core_c.patch
patches/zhen_ni-sched-move_deadline_period_sysctls_to_deadline_c.patch
patches/zhen_ni-sched-move_rt_period_runtime_sysctls_to_rt_c.patch
patches/zhen_ni-sched-move_rr_timeslice_sysctls_to_rt_c.patch

And I expect a single coherent series or I'll forgo all this.
