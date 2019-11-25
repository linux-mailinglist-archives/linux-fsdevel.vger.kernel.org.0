Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAA5108AEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 10:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfKYJcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 04:32:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41245 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYJcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:32:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id b18so17026183wrj.8;
        Mon, 25 Nov 2019 01:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9g1dsHSkZyIuogn9FJsE8Uhy7HUmJyPQt4umj/Cy1qM=;
        b=ebZrraCX980kznxsj6PVadip6OfG7OxiQeybCaI5jAz4hgrM5H3JhZTgCx4wo8yphS
         TBGAXJhH+2aBOfSKm2z+STT4xUISLzsKbb8N8krp0yAwwKPiYxK/41ThPpz4cXsaVH+K
         ovcWS49YswZOZp5ajy3kvAt3MTqTfEEJrDmRPntsdGuzYxiBMf0aiqDSSPi2mB4Bl6v2
         pMPJNqW0pX7nl/UHV/3acbVMAYQwbkBMpGjcAfQ+GAHL4BKHFjJ9QlWPskYgDlsKjFiM
         clzJp/IVuwoXQE/XyNW0XlwDC7BTjD6RKhya2661HKMvCpxZfoCiK/KFKu/zo02stEQl
         4ICA==
X-Gm-Message-State: APjAAAUWTMkMbD3uMIQi8Y+HFnW0ZDeTjij9C9QYmIsdZeDz+4MFcRFn
        GjNU9dFKcOMY7dtBg6LsFXk=
X-Google-Smtp-Source: APXvYqxVLtRMAmG3OtLqwN04F1cLQln/PkStBpS9dqyei6x12GwZXrBMjfGzYE/Q4E+36GpGh+1hVw==
X-Received: by 2002:adf:f5c6:: with SMTP id k6mr29557791wrp.245.1574674337631;
        Mon, 25 Nov 2019 01:32:17 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id q15sm8447341wrv.61.2019.11.25.01.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 01:32:16 -0800 (PST)
Date:   Mon, 25 Nov 2019 10:32:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     x86@kernel.org, Chen Yu <yu.chen.surf@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH][v5] x86/resctrl: Add task resctrl information display
Message-ID: <20191125093216.GF31714@dhcp22.suse.cz>
References: <20191125040001.28943-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125040001.28943-1-yu.c.chen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc linux-api]

On Mon 25-11-19 12:00:01, Chen Yu wrote:
> Monitoring tools that want to find out which resctrl control
> and monitor groups a task belongs to must currently read
> the "tasks" file in every group until they locate the process
> ID.
> 
> Add an additional file /proc/{pid}/resctrl to provide this
> information.
> 
> The output is as followed according to Thomas's suggestion,
> for example:
> 
>  1)   ""
>       Resctrl is not available.
> 
>  2)   "/"
>       Task is part of the root group, task is not associated to
>       any monitoring group.
> 
>  3)   "/mon_groups/mon0"
>       Task is part of the root group and monitoring group mon0.
> 
>  4)   "/group0"
>       Task is part of control group group0, task is not associated
>       to any monitoring group.
> 
>  5)   "/group0/mon_groups/mon1"
>       Task is part of control group group0 and monitoring group mon1.
> 
> Tested-by: Jinshi Chen <jinshi.chen@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2: Reduce indentation level in proc_resctrl_show()
>     according to Boris's suggestion.
>     Create the include/linux/resctrl.h header and
>     declare proc_resctrl_show() in this file, so
>     that other architectures would probably use it
>     in the future. Different architectures should
>     implement architectural specific proc_resctrl_show()
>     accordingly.
> 
> v3: Return empty string if the resctrl filesystem has
>     not been mounted per Boris's suggestion.
>     Rename the config from CPU_RESCTRL to PROC_CPU_RESCTRL
>     to better represent its usage. Move PROC_CPU_RESCTRL
>     from arch/Kconfig to fs/proc/Kconfig.
>     And let PROC_CPU_RESCTRL to be depended on PROC_FS.
> 
> v4: According to Thomas's suggestion, changed the output
>     from multiple lines to one single line.
> 
> v5: According to Alexey's feedback, removed the header file
>     proc_fs.h in resctrl.h, and changed seq_puts() to
>     seq_putc() for simplicity.
> ---
>  arch/x86/Kconfig                       |  1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 78 ++++++++++++++++++++++++++
>  fs/proc/Kconfig                        |  4 ++
>  fs/proc/base.c                         |  7 +++
>  include/linux/resctrl.h                | 14 +++++
>  5 files changed, 104 insertions(+)
>  create mode 100644 include/linux/resctrl.h
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 8ef85139553f..252364d18887 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -455,6 +455,7 @@ config X86_CPU_RESCTRL
>  	bool "x86 CPU resource control support"
>  	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
>  	select KERNFS
> +	select PROC_CPU_RESCTRL		if PROC_FS
>  	help
>  	  Enable x86 CPU resource control support.
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 2e3b06d6bbc6..f786e7626a65 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -725,6 +725,84 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_PROC_CPU_RESCTRL
> +
> +/*
> + * A task can only be part of one control
> + * group and of one monitoring group which
> + * is associated to that control group.
> + * So one line is simple and clear enough:
> + *
> + * 1)   ""
> + *    Resctrl is not available.
> + *
> + * 2)   "/"
> + *    Task is part of the root group, and it is
> + *    not associated to any monitoring group.
> + *
> + * 3)   "/mon_groups/mon0"
> + *    Task is part of the root group and monitoring
> + *    group mon0.
> + *
> + * 4)   "/group0"
> + *    Task is part of control group group0, and it is
> + *    not associated to any monitoring group.
> + *
> + * 5)   "/group0/mon_groups/mon1"
> + *    Task is part of control group group0 and monitoring
> + *    group mon1.
> + */
> +int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
> +		      struct pid *pid, struct task_struct *tsk)
> +{
> +	struct rdtgroup *rdtg;
> +	int ret = 0;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	/* Return empty if resctrl has not been mounted. */
> +	if (!static_branch_unlikely(&rdt_enable_key))
> +		goto unlock;
> +
> +	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
> +		struct rdtgroup *crg;
> +
> +		/*
> +		 * Task information is only relevant for shareable
> +		 * and exclusive groups.
> +		 */
> +		if (rdtg->mode != RDT_MODE_SHAREABLE &&
> +		    rdtg->mode != RDT_MODE_EXCLUSIVE)
> +			continue;
> +
> +		if (rdtg->closid != tsk->closid)
> +			continue;
> +
> +		seq_printf(s, "/%s", rdtg->kn->name);
> +		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
> +				    mon.crdtgrp_list) {
> +			if (tsk->rmid != crg->mon.rmid)
> +				continue;
> +			seq_printf(s, "%smon_groups/%s",
> +				   rdtg == &rdtgroup_default ? "" : "/",
> +				   crg->kn->name);
> +			break;
> +		}
> +		seq_putc(s, '\n');
> +		goto unlock;
> +	}
> +	/*
> +	 * The above search should succeed. Otherwise return
> +	 * with an error.
> +	 */
> +	ret = -ENOENT;
> +unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return ret;
> +}
> +#endif
> +
>  static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
>  				    struct seq_file *seq, void *v)
>  {
> diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> index cb5629bd5fff..ae96a339d24d 100644
> --- a/fs/proc/Kconfig
> +++ b/fs/proc/Kconfig
> @@ -103,3 +103,7 @@ config PROC_CHILDREN
>  config PROC_PID_ARCH_STATUS
>  	def_bool n
>  	depends on PROC_FS
> +
> +config PROC_CPU_RESCTRL
> +	def_bool n
> +	depends on PROC_FS
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ebea9501afb8..0e4b8bf2b986 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -94,6 +94,7 @@
>  #include <linux/sched/debug.h>
>  #include <linux/sched/stat.h>
>  #include <linux/posix-timers.h>
> +#include <linux/resctrl.h>
>  #include <trace/events/oom.h>
>  #include "internal.h"
>  #include "fd.h"
> @@ -3060,6 +3061,9 @@ static const struct pid_entry tgid_base_stuff[] = {
>  #endif
>  #ifdef CONFIG_CGROUPS
>  	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
> +#endif
> +#ifdef CONFIG_PROC_CPU_RESCTRL
> +	ONE("resctrl", S_IRUGO, proc_resctrl_show),
>  #endif
>  	ONE("oom_score",  S_IRUGO, proc_oom_score),
>  	REG("oom_adj",    S_IRUGO|S_IWUSR, proc_oom_adj_operations),
> @@ -3460,6 +3464,9 @@ static const struct pid_entry tid_base_stuff[] = {
>  #endif
>  #ifdef CONFIG_CGROUPS
>  	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
> +#endif
> +#ifdef CONFIG_PROC_CPU_RESCTRL
> +	ONE("resctrl", S_IRUGO, proc_resctrl_show),
>  #endif
>  	ONE("oom_score", S_IRUGO, proc_oom_score),
>  	REG("oom_adj",   S_IRUGO|S_IWUSR, proc_oom_adj_operations),
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> new file mode 100644
> index 000000000000..daf5cf64c6a6
> --- /dev/null
> +++ b/include/linux/resctrl.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _RESCTRL_H
> +#define _RESCTRL_H
> +
> +#ifdef CONFIG_PROC_CPU_RESCTRL
> +
> +int proc_resctrl_show(struct seq_file *m,
> +		      struct pid_namespace *ns,
> +		      struct pid *pid,
> +		      struct task_struct *tsk);
> +
> +#endif
> +
> +#endif /* _RESCTRL_H */
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
