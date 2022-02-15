Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808924B645B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 08:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbiBOH37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 02:29:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiBOH36 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:29:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBDF107D9E;
        Mon, 14 Feb 2022 23:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hPZS7SLIWQKSR8Z0amtkFe/ZriOWoRw/aJauuRJm7e0=; b=PYz3ofSxIVKbqnRd1QlWXAk+yt
        uXuD9Z8BT36vtYAJE8Fhpmun7Z/2LK+bUueiiOQT31UrcEmYzlit5XkzKPL9dLVbplIuq06fkJB5r
        KdsfZmaP59RRPBLwQpw3mpf40niaT/cFbAof5bLUFf32rL6EWYT033obYvG6AzDPnkN3pBerpbdX2
        moyt94Lvn66qI0xtXMqFmoRHRmfJEdd41bIJ42PhPF2SsWM2sBTtr/412X7Fd1WPOH+kG8lmiIg8m
        NcdlR5sQpSMd9lJHZGjn5nlw3ba/mKyCNQGwV+qwbxNlS75+AD5nLPhKi3YfUeFpfz89WWFkKVNwF
        nxxecQ/Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJsHP-001DZ0-Nl; Tue, 15 Feb 2022 07:29:43 +0000
Date:   Mon, 14 Feb 2022 23:29:43 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     sujiaxun <sujiaxun@uniontech.com>
Cc:     keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: move oom_kill sysctls to their own file
Message-ID: <YgtWZ0B7OzluiOkr@bombadil.infradead.org>
References: <20220215030257.11150-1-sujiaxun@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215030257.11150-1-sujiaxun@uniontech.com>
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

On Tue, Feb 15, 2022 at 11:02:57AM +0800, sujiaxun wrote:
> kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
> dishes, this makes it very difficult to maintain.
> 
> To help with this maintenance let's start by moving sysctls to places
> where they actually belong.  The proc sysctl maintainers do not want to
> know what sysctl knobs you wish to add for your own piece of code, we just
> care about the core logic.
> 
> So move the oom_kill sysctls to its own file.
> 
> Signed-off-by: sujiaxun <sujiaxun@uniontech.com>
> ---
>  include/linux/oom.h |  4 ----
>  kernel/sysctl.c     | 23 -----------------------
>  mm/oom_kill.c       | 37 ++++++++++++++++++++++++++++++++++---
>  3 files changed, 34 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 2db9a1432511..02d1e7bbd8cd 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -123,8 +123,4 @@ extern void oom_killer_enable(void);
> 
>  extern struct task_struct *find_lock_task_mm(struct task_struct *p);
> 
> -/* sysctls */
> -extern int sysctl_oom_dump_tasks;
> -extern int sysctl_oom_kill_allocating_task;
> -extern int sysctl_panic_on_oom;
>  #endif /* _INCLUDE_LINUX_OOM_H */
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 788b9a34d5ab..40d822fbb6d5 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2352,29 +2352,6 @@ static struct ctl_table vm_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_TWO,
>  	},
> -	{
> -		.procname	= "panic_on_oom",
> -		.data		= &sysctl_panic_on_oom,
> -		.maxlen		= sizeof(sysctl_panic_on_oom),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_TWO,
> -	},
> -	{
> -		.procname	= "oom_kill_allocating_task",
> -		.data		= &sysctl_oom_kill_allocating_task,
> -		.maxlen		= sizeof(sysctl_oom_kill_allocating_task),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> -	},
> -	{
> -		.procname	= "oom_dump_tasks",
> -		.data		= &sysctl_oom_dump_tasks,
> -		.maxlen		= sizeof(sysctl_oom_dump_tasks),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> -	},
>  	{
>  		.procname	= "overcommit_ratio",
>  		.data		= &sysctl_overcommit_ratio,
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 6b875acabd1e..c720c0710911 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -52,9 +52,35 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/oom.h>
> 
> -int sysctl_panic_on_oom;
> -int sysctl_oom_kill_allocating_task;
> -int sysctl_oom_dump_tasks = 1;
> +static int sysctl_panic_on_oom;
> +static int sysctl_oom_kill_allocating_task;
> +static int sysctl_oom_dump_tasks = 1;
> +
> +static struct ctl_table vm_oom_kill_table[] = {
> +	{
> +		.procname	= "panic_on_oom",
> +		.data		= &sysctl_panic_on_oom,
> +		.maxlen		= sizeof(sysctl_panic_on_oom),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_TWO,
> +	},
> +	{
> +		.procname	= "oom_kill_allocating_task",
> +		.data		= &sysctl_oom_kill_allocating_task,
> +		.maxlen		= sizeof(sysctl_oom_kill_allocating_task),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	},
> +	{
> +		.procname	= "oom_dump_tasks",
> +		.data		= &sysctl_oom_dump_tasks,
> +		.maxlen		= sizeof(sysctl_oom_dump_tasks),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	}
> +};
> 
>  /*
>   * Serializes oom killer invocations (out_of_memory()) from all contexts to
> @@ -680,6 +706,11 @@ static void wake_oom_reaper(struct task_struct *tsk)
>  static int __init oom_init(void)
>  {
>  	oom_reaper_th = kthread_run(oom_reaper, NULL, "oom_reaper");
> +
> +	#ifdef CONFIG_SYSCTL
> +		register_sysctl_init("vm", vm_oom_kill_table);
> +	#endif

PLease avoid the ifdefs and the tab spacing seems very off here.

Also are you running ./scripts/get_maintainer* ?

  Luis
